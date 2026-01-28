# Flutter Web Deployment Template

This template provides everything needed to deploy a Flutter Web application to GCP.

## Deployment Options

### Option A: Firebase Hosting (Recommended for Static)
- **Cost**: Free tier usually sufficient
- **Best for**: Static Flutter web builds
- **Pros**: Simple, global CDN, automatic SSL

### Option B: Cloud Run (For Dynamic)
- **Cost**: $0-15/month
- **Best for**: Flutter web with backend API
- **Pros**: Can include backend, auto-scaling

### Option C: Cloud Storage + CDN
- **Cost**: ~$0-5/month
- **Best for**: High traffic static sites
- **Pros**: Full control over caching

## Quick Start

### Firebase Hosting
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login and init
firebase login
firebase init hosting

# Build Flutter
flutter build web --release

# Deploy
firebase deploy --only hosting
```

### Cloud Run
```bash
# Build Flutter
flutter build web --release

# Build Docker image
docker build -t gcr.io/PROJECT_ID/flutter-web -f Dockerfile .

# Deploy
gcloud run deploy flutter-web \
  --image gcr.io/PROJECT_ID/flutter-web \
  --platform managed \
  --region australia-southeast1 \
  --allow-unauthenticated
```

## Files in This Template

- `Dockerfile` - Container for Cloud Run
- `nginx.conf` - Nginx configuration for SPA routing
- `cloudbuild.yaml` - CI/CD pipeline
- `firebase.json` - Firebase Hosting config
- `.firebaserc` - Firebase project config

## Configuration

Edit these files based on your project:

1. Replace `PROJECT_ID` with your GCP project
2. Update `flutter build web` flags if needed
3. Configure custom domain in deployment
