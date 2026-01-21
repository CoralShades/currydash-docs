# Claude Code GCP Deployment Guide

**IMPORTANT: Read this entire file before executing any GCP deployment commands.**

## Core Principles

1. **NEVER deploy without user approval and cost breakdown**
2. **ALWAYS suggest free/cheapest options first**
3. **USE MCP servers for up-to-date GCP documentation**
4. **ASK which deployment method the user prefers**

## GCP Account Configuration

```yaml
account: demi@coralshades.ai
default_region: australia-southeast1
default_zone: australia-southeast1-a
billing_account: (user's billing account)
```

## Deployment Decision Workflow

When asked to deploy a project to GCP, follow this workflow:

### Step 1: Identify Project Type

Detect the project type from files:
- `pubspec.yaml` → Flutter
- `package.json` + `next.config.js` → Next.js
- `package.json` + `react` dependency → React
- `composer.json` → Laravel/PHP
- `package.json` (no framework) → Node.js
- `requirements.txt` / `pyproject.toml` → Python

### Step 2: Analyze Requirements

Ask the user:
1. Expected traffic volume (requests/day)?
2. Database requirements (MySQL, PostgreSQL, none)?
3. File storage needs (uploads, assets)?
4. Background jobs/queues?
5. Budget constraints?

### Step 3: Present Options with Costs

ALWAYS present at least 2 options:

```
## Deployment Options for [Project Name]

### Option A: Cloud Run (Recommended - Pay-per-use)
- **Monthly Cost Estimate**: $X - $Y
- **Pros**: Auto-scaling, no idle costs, managed SSL
- **Cons**: Cold starts, max 60min requests
- **Best for**: APIs, web apps with variable traffic

### Option B: Compute Engine (VM)
- **Monthly Cost Estimate**: $X/month fixed
- **Pros**: Full control, persistent connections, no cold starts
- **Cons**: Always-on cost, manual scaling
- **Best for**: WebSockets, long-running processes

### Option C: Firebase Hosting (if static)
- **Monthly Cost Estimate**: Free tier / $X
- **Pros**: Free SSL, global CDN, automatic deploys
- **Cons**: Static only, limited backend
- **Best for**: Static sites, SPAs

Which option would you like? (A/B/C)
```

### Step 4: Get Explicit Approval

Before ANY billable action, confirm:

```
## Cost Confirmation

I'm about to create the following GCP resources:
- Cloud Run service: ~$X/month
- Cloud SQL (if needed): ~$Y/month
- Artifact Registry: ~$Z/month
- Total estimated: ~$TOTAL/month

Do you want me to proceed? (yes/no)
```

## MCP Server Usage

### Cloudflare Documentation
Use for DNS, CDN, and WAF configuration:
```
mcp__cloudflare-docs__search_cloudflare_documentation
```

### Perplexity Research
Use for GCP best practices and troubleshooting:
```
mcp__perplexity__perplexity_ask
mcp__perplexity__perplexity_research
```

### Example: Research Current GCP Pricing
```javascript
// Use Perplexity to get current pricing
mcp__perplexity__perplexity_ask({
  messages: [{
    role: "user",
    content: "What is the current GCP Cloud Run pricing for australia-southeast1 region in 2024?"
  }]
})
```

## GCP CLI Commands Reference

### Authentication
```bash
# Login to GCP
gcloud auth login

# Set project
gcloud config set project PROJECT_ID

# Set region
gcloud config set run/region australia-southeast1
```

### Cloud Run Deployment
```bash
# Build and deploy
gcloud builds submit --tag gcr.io/PROJECT_ID/SERVICE_NAME
gcloud run deploy SERVICE_NAME \
  --image gcr.io/PROJECT_ID/SERVICE_NAME \
  --platform managed \
  --region australia-southeast1 \
  --allow-unauthenticated
```

### Artifact Registry Setup
```bash
# Create repository
gcloud artifacts repositories create REPO_NAME \
  --repository-format=docker \
  --location=australia-southeast1

# Configure Docker auth
gcloud auth configure-docker australia-southeast1-docker.pkg.dev
```

### Cloud SQL Setup
```bash
# Create instance (ask user first - this costs money!)
gcloud sql instances create INSTANCE_NAME \
  --database-version=MYSQL_8_0 \
  --tier=db-f1-micro \
  --region=australia-southeast1

# Create database
gcloud sql databases create DB_NAME --instance=INSTANCE_NAME
```

## Project-Specific Templates

Based on detected project type, use the appropriate template:

| Project Type | Template Path |
|--------------|---------------|
| Flutter Web | `templates/flutter-web/` |
| React | `templates/react/` |
| Next.js | `templates/nextjs/` |
| Laravel | `templates/laravel/` |
| Node.js | `templates/nodejs/` |

## Security Checklist

Before deployment, ensure:

- [ ] No secrets in code (use Secret Manager)
- [ ] Environment variables configured
- [ ] IAM permissions minimized
- [ ] VPC configured for database access
- [ ] HTTPS enforced
- [ ] CORS configured correctly

## Free Tier Maximization

GCP Free Tier includes:
- **Cloud Run**: 2M requests/month, 360k GB-seconds
- **Cloud Build**: 120 build-minutes/day
- **Artifact Registry**: 500MB storage
- **Cloud Storage**: 5GB (regional)
- **Compute Engine**: 1 e2-micro (us regions only)

Always check: https://cloud.google.com/free

## Error Handling

### Common Issues

1. **Permission Denied**
   - Check: `gcloud auth list`
   - Fix: `gcloud auth login` or check IAM roles

2. **Quota Exceeded**
   - Check: Cloud Console → IAM & Admin → Quotas
   - Fix: Request quota increase or optimize usage

3. **Build Failed**
   - Check: Cloud Build logs
   - Common: Missing dependencies, Dockerfile errors

4. **Connection Refused (Cloud SQL)**
   - Check: VPC connector, Cloud SQL proxy
   - Fix: Configure serverless VPC access

## Deployment Workflows

### New Project Setup
1. Read `workflows/initial-setup.md`
2. Create GCP project (if needed)
3. Enable required APIs
4. Set up Artifact Registry
5. Configure secrets

### Cloud Run Deployment
1. Read `workflows/deploy-cloud-run.md`
2. Build Docker image
3. Push to Artifact Registry
4. Deploy to Cloud Run
5. Configure custom domain (optional)

### CI/CD Setup
1. Read `workflows/ci-cd-setup.md`
2. Create cloudbuild.yaml
3. Configure triggers
4. Set up environments (dev/staging/prod)

## Post-Deployment

After successful deployment:

1. Verify service is running
2. Test all endpoints
3. Set up monitoring (Cloud Monitoring)
4. Configure alerts
5. Document the deployment in project README

## Cost Monitoring

Recommend setting up:
- Budget alerts at 50%, 80%, 100%
- Daily cost reports
- Resource usage dashboards

```bash
# Check current billing
gcloud billing accounts list
gcloud billing projects describe PROJECT_ID
```

---

**Remember: Always ask before creating billable resources. The user trusts you to be cost-conscious.**
