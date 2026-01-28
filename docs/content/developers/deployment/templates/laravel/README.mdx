# Laravel Deployment Template

This template provides everything needed to deploy a Laravel application to GCP Cloud Run with Cloud SQL.

## Deployment Options

### Option A: Cloud Run + Cloud SQL (Recommended)
- **Cost**: $25-60/month
- **Best for**: Standard Laravel apps
- **Pros**: Auto-scaling, managed database, serverless

### Option B: Compute Engine + Local MySQL
- **Cost**: $20-50/month
- **Best for**: Simple apps, development environments
- **Pros**: Lower cost, full control

### Option C: Cloud Run + Cloud SQL + Redis
- **Cost**: $40-80/month
- **Best for**: Apps with queues, sessions, caching
- **Pros**: Full Laravel feature support

## Quick Start

```bash
# 1. Set up Cloud SQL (one-time)
gcloud sql instances create laravel-db \
  --database-version=MYSQL_8_0 \
  --tier=db-f1-micro \
  --region=australia-southeast1

# 2. Build and deploy
gcloud builds submit --config cloudbuild.yaml
```

## Files in This Template

- `Dockerfile` - Multi-stage PHP 8.3 + Nginx build
- `docker-compose.yml` - Local development environment
- `cloudbuild.yaml` - CI/CD pipeline
- `nginx.conf` - Nginx configuration
- `supervisord.conf` - Process management

## Architecture

```
┌─────────────────┐     ┌──────────────────┐
│   Cloud Run     │────▶│   VPC Connector  │
│  (Laravel App)  │     │  (10.8.0.0/28)   │
└─────────────────┘     └────────┬─────────┘
                                 │
                        ┌────────▼─────────┐
                        │    Cloud SQL     │
                        │   (MySQL 8.0)    │
                        └──────────────────┘
```

## Required GCP Setup

1. **Cloud SQL Instance** (MySQL 8.0)
2. **VPC Connector** for private connectivity
3. **Artifact Registry** for Docker images
4. **Secret Manager** for credentials

## Environment Variables

Store these in Secret Manager:
- `APP_KEY` - Laravel encryption key
- `DB_HOST` - Cloud SQL private IP
- `DB_DATABASE` - Database name
- `DB_USERNAME` - Database user
- `DB_PASSWORD` - Database password

## Queue Workers

For Laravel queues, you have options:

1. **Cloud Run Jobs** - Scheduled via Cloud Scheduler
2. **Always-on worker** - Separate Cloud Run service
3. **Cloud Tasks** - Push-based queue driver
