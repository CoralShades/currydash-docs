# Cloud Run Deployment Workflow

Follow this workflow to deploy your application to Cloud Run.

## Prerequisites

- GCP project set up (see `initial-setup.md`)
- Docker installed locally
- Application with Dockerfile

## Step 1: Prepare Application

### Verify Dockerfile

Ensure your Dockerfile:
- Exposes port 8080 (or set PORT env var)
- Has a health check endpoint
- Follows multi-stage build pattern

### Verify Configuration

```yaml
# Check project-config.yaml
deployment:
  target: cloud-run

cloud_run:
  cpu: "1"
  memory: "512Mi"
  port: 8080
```

## Step 2: Build Docker Image

### Option A: Local Build + Push

```bash
# Set variables
PROJECT_ID="your-project-id"
SERVICE_NAME="your-service"
REGION="australia-southeast1"

# Build image
docker build -t ${REGION}-docker.pkg.dev/${PROJECT_ID}/docker-repo/${SERVICE_NAME}:latest .

# Push to Artifact Registry
docker push ${REGION}-docker.pkg.dev/${PROJECT_ID}/docker-repo/${SERVICE_NAME}:latest
```

### Option B: Cloud Build (Recommended)

```bash
# Build using Cloud Build
gcloud builds submit \
  --tag ${REGION}-docker.pkg.dev/${PROJECT_ID}/docker-repo/${SERVICE_NAME}:latest
```

## Step 3: Deploy to Cloud Run

### Basic Deployment

```bash
gcloud run deploy ${SERVICE_NAME} \
  --image ${REGION}-docker.pkg.dev/${PROJECT_ID}/docker-repo/${SERVICE_NAME}:latest \
  --platform managed \
  --region ${REGION} \
  --allow-unauthenticated
```

### Full Deployment with Options

```bash
gcloud run deploy ${SERVICE_NAME} \
  --image ${REGION}-docker.pkg.dev/${PROJECT_ID}/docker-repo/${SERVICE_NAME}:latest \
  --platform managed \
  --region ${REGION} \
  --allow-unauthenticated \
  --cpu=1 \
  --memory=512Mi \
  --min-instances=0 \
  --max-instances=10 \
  --port=8080 \
  --concurrency=80 \
  --timeout=300 \
  --set-env-vars="NODE_ENV=production"
```

### Deployment with Cloud SQL

```bash
gcloud run deploy ${SERVICE_NAME} \
  --image ${REGION}-docker.pkg.dev/${PROJECT_ID}/docker-repo/${SERVICE_NAME}:latest \
  --platform managed \
  --region ${REGION} \
  --allow-unauthenticated \
  --vpc-connector=app-connector \
  --set-secrets="DB_PASSWORD=db-password:latest" \
  --set-env-vars="DB_HOST=CLOUD_SQL_PRIVATE_IP,DB_DATABASE=app_database"
```

## Step 4: Verify Deployment

```bash
# Get service URL
gcloud run services describe ${SERVICE_NAME} \
  --region ${REGION} \
  --format='value(status.url)'

# Check service status
gcloud run services list --region ${REGION}

# View logs
gcloud run services logs read ${SERVICE_NAME} --region ${REGION}
```

## Step 5: Configure Custom Domain (Optional)

```bash
# Map domain to Cloud Run
gcloud run domain-mappings create \
  --service ${SERVICE_NAME} \
  --domain your-domain.com \
  --region ${REGION}

# Get DNS records to configure
gcloud run domain-mappings describe \
  --domain your-domain.com \
  --region ${REGION}
```

## Common Deployment Flags

| Flag | Description | Default |
|------|-------------|---------|
| `--cpu` | CPU allocation | 1 |
| `--memory` | Memory allocation | 256Mi |
| `--min-instances` | Minimum instances | 0 |
| `--max-instances` | Maximum instances | 100 |
| `--concurrency` | Max concurrent requests | 80 |
| `--timeout` | Request timeout (seconds) | 300 |
| `--port` | Container port | 8080 |
| `--no-traffic` | Deploy without traffic | false |

## Rollback

```bash
# List revisions
gcloud run revisions list --service ${SERVICE_NAME} --region ${REGION}

# Roll back to previous revision
gcloud run services update-traffic ${SERVICE_NAME} \
  --to-revisions REVISION_NAME=100 \
  --region ${REGION}
```

## Cost Optimization

### Scale to Zero
```bash
--min-instances=0
```

### Right-size Resources
```bash
--cpu=0.5 --memory=256Mi  # For light workloads
```

### Use CPU Throttling
```bash
--cpu-throttling  # CPU only allocated during request
```

## Troubleshooting

### Container fails to start
```bash
# Check logs
gcloud run services logs read ${SERVICE_NAME} --region ${REGION} --limit=50
```

### 502 Bad Gateway
- Check health endpoint returns 200
- Verify container listens on correct port
- Check startup time < timeout

### Connection refused to Cloud SQL
- Verify VPC connector is attached
- Check Cloud SQL private IP is correct
- Verify IAM permissions

## Deployment Checklist

- [ ] Dockerfile tested locally
- [ ] Environment variables set
- [ ] Secrets created in Secret Manager
- [ ] VPC connector attached (if using Cloud SQL)
- [ ] Health endpoint responding
- [ ] Custom domain configured (optional)
- [ ] Budget alerts set

## Next Steps

- Set up CI/CD: `ci-cd-setup.md`
- Configure monitoring: Cloud Console → Monitoring
- Set up alerts: Cloud Console → Alerting
