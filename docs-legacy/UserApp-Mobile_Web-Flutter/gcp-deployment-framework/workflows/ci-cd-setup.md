# CI/CD Pipeline Setup Workflow

Set up automated deployments with Cloud Build.

## Prerequisites

- Application deployed to Cloud Run (see `deploy-cloud-run.md`)
- GitHub repository for your code

## Architecture

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   GitHub    │────▶│  Cloud Build │────▶│  Cloud Run  │
│  (push)     │     │  (trigger)   │     │  (deploy)   │
└─────────────┘     └──────────────┘     └─────────────┘
```

## Step 1: Connect GitHub Repository

```bash
# Install Cloud Build GitHub App
# Visit: https://github.com/apps/google-cloud-build

# Or use gcloud
gcloud beta builds connections create github CONNECTION_NAME \
  --region=${REGION}
```

## Step 2: Create Cloud Build Trigger

### Option A: Console (Recommended for first time)

1. Go to Cloud Console → Cloud Build → Triggers
2. Click "Create Trigger"
3. Select GitHub repository
4. Configure trigger settings

### Option B: gcloud CLI

```bash
# Create trigger for main branch
gcloud builds triggers create github \
  --name="${SERVICE_NAME}-deploy" \
  --repo-name="your-repo-name" \
  --repo-owner="your-github-username" \
  --branch-pattern="^main$" \
  --build-config="cloudbuild.yaml"
```

## Step 3: Create cloudbuild.yaml

Copy the appropriate template from `templates/[project-type]/cloudbuild.yaml` to your repository root.

### Generic Template

```yaml
substitutions:
  _SERVICE_NAME: your-service-name
  _REGION: australia-southeast1
  _ARTIFACT_REPO: docker-repo

steps:
  # Build
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', '${_REGION}-docker.pkg.dev/${PROJECT_ID}/${_ARTIFACT_REPO}/${_SERVICE_NAME}:${SHORT_SHA}', '.']

  # Push
  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', '${_REGION}-docker.pkg.dev/${PROJECT_ID}/${_ARTIFACT_REPO}/${_SERVICE_NAME}:${SHORT_SHA}']

  # Deploy
  - name: 'gcr.io/google.com/cloudsdktool/cloud-sdk'
    entrypoint: gcloud
    args:
      - 'run'
      - 'deploy'
      - '${_SERVICE_NAME}'
      - '--image=${_REGION}-docker.pkg.dev/${PROJECT_ID}/${_ARTIFACT_REPO}/${_SERVICE_NAME}:${SHORT_SHA}'
      - '--region=${_REGION}'
      - '--platform=managed'

images:
  - '${_REGION}-docker.pkg.dev/${PROJECT_ID}/${_ARTIFACT_REPO}/${_SERVICE_NAME}:${SHORT_SHA}'

options:
  logging: CLOUD_LOGGING_ONLY

timeout: '1200s'
```

## Step 4: Configure IAM Permissions

```bash
PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} --format='value(projectNumber)')

# Grant Cloud Build permission to deploy to Cloud Run
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member="serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com" \
  --role="roles/run.admin"

# Grant Cloud Build permission to act as runtime service account
gcloud iam service-accounts add-iam-policy-binding \
  ${PROJECT_NUMBER}-compute@developer.gserviceaccount.com \
  --member="serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser"

# Grant access to Secret Manager (if using secrets)
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member="serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com" \
  --role="roles/secretmanager.secretAccessor"
```

## Step 5: Test the Pipeline

```bash
# Trigger manually
gcloud builds triggers run ${SERVICE_NAME}-deploy --branch=main

# Or push to GitHub
git push origin main

# Watch build progress
gcloud builds list --ongoing
gcloud builds log BUILD_ID --stream
```

## Multiple Environments

### Development Trigger

```yaml
# cloudbuild-dev.yaml
substitutions:
  _SERVICE_NAME: your-service-dev
  _REGION: australia-southeast1

# Deploy with --no-traffic for preview
steps:
  - name: 'gcr.io/google.com/cloudsdktool/cloud-sdk'
    args:
      - 'run'
      - 'deploy'
      - '${_SERVICE_NAME}'
      - '--image=...'
      - '--no-traffic'  # Don't route traffic yet
      - '--tag=preview-${SHORT_SHA}'
```

### Production with Approval

```yaml
# For production, use Cloud Deploy for approval gates
steps:
  # Build and push image
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', '...', '.']

  # Create release (requires approval)
  - name: 'gcr.io/google.com/cloudsdktool/cloud-sdk'
    entrypoint: gcloud
    args:
      - 'deploy'
      - 'releases'
      - 'create'
      - 'release-${SHORT_SHA}'
      - '--delivery-pipeline=my-pipeline'
      - '--region=${_REGION}'
```

## Build Notifications

### Slack Notifications

```yaml
# Add to cloudbuild.yaml
steps:
  # ... build steps ...

  # Notify on success
  - name: 'gcr.io/cloud-builders/curl'
    args:
      - '-X'
      - 'POST'
      - '-H'
      - 'Content-type: application/json'
      - '--data'
      - '{"text":"Build ${BUILD_ID} succeeded for ${_SERVICE_NAME}"}'
      - '${_SLACK_WEBHOOK_URL}'
```

### Email via Pub/Sub

```bash
# Create notification channel
gcloud beta builds triggers update ${TRIGGER_NAME} \
  --include-build-logs=INCLUDE_BUILD_LOGS_WITH_STATUS
```

## Branch Protection

Recommended GitHub branch rules:
- Require pull request reviews
- Require status checks (Cloud Build)
- Require branches to be up to date

## Rollback Strategy

### Automatic Rollback

```yaml
# Add health check step
steps:
  # Deploy
  - name: 'gcr.io/google.com/cloudsdktool/cloud-sdk'
    id: deploy
    args: ['run', 'deploy', '...']

  # Health check
  - name: 'gcr.io/cloud-builders/curl'
    id: health-check
    args: ['-f', 'https://${_SERVICE_URL}/health']
    waitFor: ['deploy']

  # Rollback on failure
  - name: 'gcr.io/google.com/cloudsdktool/cloud-sdk'
    id: rollback
    entrypoint: bash
    args:
      - '-c'
      - |
        if [ "$$BUILD_STATUS" = "FAILURE" ]; then
          gcloud run services update-traffic ${_SERVICE_NAME} --to-latest --region=${_REGION}
        fi
```

### Manual Rollback

```bash
# List recent revisions
gcloud run revisions list --service ${SERVICE_NAME} --region ${REGION}

# Roll back to specific revision
gcloud run services update-traffic ${SERVICE_NAME} \
  --to-revisions REVISION_NAME=100 \
  --region ${REGION}
```

## Cost Considerations

| Resource | Free Tier | Cost After |
|----------|-----------|------------|
| Cloud Build | 120 min/day | $0.003/min |
| Artifact Registry | 500 MB | $0.10/GB |

**Typical CI/CD cost**: $0-5/month for small projects

## Troubleshooting

### Build fails to start
- Check Cloud Build API is enabled
- Verify trigger configuration

### Permission denied
- Check IAM roles for Cloud Build service account
- Verify Secret Manager access

### Deployment fails
- Check Cloud Run service account permissions
- Review build logs for errors

## Checklist

- [ ] GitHub repository connected
- [ ] Cloud Build trigger created
- [ ] cloudbuild.yaml in repository
- [ ] IAM permissions configured
- [ ] Test build successful
- [ ] Notifications configured (optional)
- [ ] Branch protection enabled (optional)
