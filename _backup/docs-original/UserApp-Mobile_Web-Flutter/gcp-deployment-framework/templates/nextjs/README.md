# Next.js Deployment Template

This template provides everything needed to deploy a Next.js application to GCP Cloud Run.

## Deployment Options

### Option A: Cloud Run (Recommended)
- **Cost**: $0-30/month
- **Best for**: SSR, ISR, API routes
- **Pros**: Auto-scaling, managed SSL, supports all Next.js features

### Option B: Firebase Hosting + Cloud Functions
- **Cost**: $0-20/month
- **Best for**: Static export + API routes
- **Pros**: Global CDN, simpler for static sites

### Option C: Compute Engine
- **Cost**: $20+/month
- **Best for**: High traffic, persistent connections
- **Pros**: Full control, no cold starts

## Quick Start (Cloud Run)

```bash
# Build and deploy
gcloud builds submit --config cloudbuild.yaml

# Or manual deployment
docker build -t gcr.io/PROJECT_ID/nextjs-app .
docker push gcr.io/PROJECT_ID/nextjs-app
gcloud run deploy nextjs-app \
  --image gcr.io/PROJECT_ID/nextjs-app \
  --platform managed \
  --region australia-southeast1 \
  --allow-unauthenticated
```

## Files in This Template

- `Dockerfile` - Multi-stage build for Next.js
- `cloudbuild.yaml` - CI/CD pipeline
- `.dockerignore` - Optimize build context

## Next.js Configuration

For Cloud Run deployment, ensure your `next.config.js` includes:

```javascript
module.exports = {
  output: 'standalone',  // Required for Docker
}
```

## Environment Variables

Set these in Cloud Run or Secret Manager:
- `NODE_ENV=production`
- `NEXT_PUBLIC_*` - Client-side env vars (build time)
- Database URLs, API keys (runtime)
