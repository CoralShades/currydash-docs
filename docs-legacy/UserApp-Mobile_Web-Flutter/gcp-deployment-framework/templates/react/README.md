# React Deployment Template

This template provides everything needed to deploy a React application (Create React App, Vite, etc.) to GCP.

## Deployment Options

### Option A: Firebase Hosting (Recommended for Static)
- **Cost**: Free tier usually sufficient
- **Best for**: Static React builds (CRA, Vite)
- **Pros**: Global CDN, automatic SSL, simple deployment

### Option B: Cloud Run
- **Cost**: $0-10/month
- **Best for**: React with backend or SSR
- **Pros**: Containerized, more control

### Option C: Cloud Storage + CDN
- **Cost**: ~$0-5/month
- **Best for**: High traffic static sites
- **Pros**: Full control over caching, cheapest for high traffic

## Quick Start (Firebase Hosting)

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login and initialize
firebase login
firebase init hosting

# Build React app
npm run build

# Deploy
firebase deploy --only hosting
```

## Quick Start (Cloud Run)

```bash
# Build and deploy
docker build -t gcr.io/PROJECT_ID/react-app .
gcloud run deploy react-app \
  --image gcr.io/PROJECT_ID/react-app \
  --platform managed \
  --region australia-southeast1 \
  --allow-unauthenticated
```

## Files in This Template

- `Dockerfile` - Nginx container for Cloud Run
- `nginx.conf` - SPA routing configuration
- `cloudbuild.yaml` - CI/CD pipeline
- `firebase.json` - Firebase Hosting config

## Build Commands

### Create React App
```bash
npm run build  # Output: build/
```

### Vite
```bash
npm run build  # Output: dist/
# Update Dockerfile and firebase.json to use dist/ instead of build/
```

## Environment Variables

For build-time env vars (REACT_APP_* or VITE_*):
- Set in `.env.production`
- Or pass during Docker build with `--build-arg`
