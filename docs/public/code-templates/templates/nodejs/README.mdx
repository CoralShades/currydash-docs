# Node.js Deployment Template

This template provides everything needed to deploy a Node.js application (Express, Fastify, NestJS, etc.) to GCP.

## Deployment Options

### Option A: Cloud Run (Recommended)
- **Cost**: $0-30/month
- **Best for**: REST APIs, GraphQL, microservices
- **Pros**: Auto-scaling, managed SSL, pay-per-use

### Option B: Compute Engine
- **Cost**: $16+/month (e2-small)
- **Best for**: WebSocket servers, long-running processes
- **Pros**: Full control, persistent connections, no cold starts

### Option C: Cloud Functions
- **Cost**: $0-10/month
- **Best for**: Event-driven, simple APIs
- **Pros**: Simplest deployment, scale-to-zero

## Quick Start (Cloud Run)

```bash
# Build and deploy
gcloud builds submit --config cloudbuild.yaml

# Or manual deployment
docker build -t gcr.io/PROJECT_ID/nodejs-api .
gcloud run deploy nodejs-api \
  --image gcr.io/PROJECT_ID/nodejs-api \
  --platform managed \
  --region australia-southeast1 \
  --allow-unauthenticated
```

## Files in This Template

- `Dockerfile` - Multi-stage Node.js build
- `cloudbuild.yaml` - CI/CD pipeline
- `.dockerignore` - Optimize build context

## Application Requirements

Your Node.js app should:

1. **Listen on PORT env variable**:
```javascript
const port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
```

2. **Have a health check endpoint**:
```javascript
app.get('/health', (req, res) => {
  res.status(200).send('OK');
});
```

3. **Handle graceful shutdown**:
```javascript
process.on('SIGTERM', () => {
  server.close(() => {
    process.exit(0);
  });
});
```

## Environment Variables

Set in Cloud Run or Secret Manager:
- `NODE_ENV=production`
- `DATABASE_URL` - Database connection string
- `API_KEY` - External API keys
- Custom app configuration
