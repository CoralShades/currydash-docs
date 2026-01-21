# GCP Cost Analysis Guide

This document provides cost estimates for common deployment scenarios. Always verify current pricing at https://cloud.google.com/pricing.

## Free Tier Summary (Always-Free)

| Service | Free Amount | Notes |
|---------|-------------|-------|
| Cloud Run | 2M requests/month | + 360k GB-seconds compute |
| Cloud Build | 120 build-min/day | First 120 min free |
| Artifact Registry | 500 MB | Storage only |
| Cloud Storage | 5 GB (regional) | Standard storage |
| Cloud Functions | 2M invocations | + 400k GB-seconds |
| Pub/Sub | 10 GB/month | Message delivery |
| Secret Manager | 6 active versions | 10k access operations |
| Cloud Logging | 50 GB/month | First 50GB free |

**Note**: e2-micro free tier is US regions only (us-central1, us-east1, us-west1).

## Cloud Run Pricing (australia-southeast1)

### Compute Costs
| Resource | Price |
|----------|-------|
| vCPU | $0.00002400/vCPU-second |
| Memory | $0.00000250/GiB-second |
| Requests | $0.40/million requests |

### Monthly Estimates by Usage

| Scenario | Requests/month | Compute | Estimated Cost |
|----------|----------------|---------|----------------|
| Hobby | 10k | Minimal | **$0 (free tier)** |
| Small App | 100k | Light | **$0-5** |
| Medium App | 1M | Moderate | **$10-30** |
| High Traffic | 10M | Heavy | **$50-150** |

### Example: Flutter Web App (Static)
```
Assumptions:
- 50k pageviews/month
- 512MB memory, 1 vCPU
- Average 200ms response time
- Scale to zero when idle

Monthly Cost:
- Requests: 50k × $0.0000004 = $0.02
- Compute: Covered by free tier
- Total: ~$0-2/month
```

### Example: Node.js API
```
Assumptions:
- 500k API calls/month
- 512MB memory, 1 vCPU
- Average 100ms response time
- 2 min instances for latency

Monthly Cost:
- Requests: 500k × $0.0000004 = $0.20
- Compute (min instances): 2 × 24 × 30 × 3600 × ($0.00002400 + $0.00000250 × 0.5)
  = ~$65/month for always-on
- With scale-to-zero: ~$5-15/month
- Total: $5-65/month (depends on min instances)
```

## Cloud SQL Pricing (australia-southeast1)

### Instance Types

| Tier | vCPUs | RAM | Cost/month |
|------|-------|-----|------------|
| db-f1-micro | Shared | 0.6 GB | **~$10** |
| db-g1-small | Shared | 1.7 GB | **~$27** |
| db-n1-standard-1 | 1 | 3.75 GB | **~$50** |
| db-n1-standard-2 | 2 | 7.5 GB | **~$100** |

### Storage Costs
| Type | Price/GB/month |
|------|----------------|
| SSD | $0.187 |
| HDD | $0.117 |

### Example: Small App Database
```
db-f1-micro + 10GB SSD:
- Instance: $10/month
- Storage: 10 × $0.187 = $1.87/month
- Total: ~$12/month
```

## Compute Engine Pricing (australia-southeast1)

### Machine Types

| Type | vCPUs | RAM | Cost/month |
|------|-------|-----|------------|
| e2-micro | 0.25 | 1 GB | **~$8** |
| e2-small | 0.5 | 2 GB | **~$16** |
| e2-medium | 1 | 4 GB | **~$32** |
| e2-standard-2 | 2 | 8 GB | **~$65** |
| e2-standard-4 | 4 | 16 GB | **~$130** |

### Committed Use Discounts
- 1-year commitment: 37% discount
- 3-year commitment: 55% discount

### Example: Simple VM Deployment
```
e2-small + 20GB SSD:
- Compute: $16/month
- Storage: 20 × $0.187 = $3.74/month
- Total: ~$20/month
```

## Artifact Registry Pricing

| Resource | Price |
|----------|-------|
| Storage | $0.10/GB/month |
| Network Egress | Same as Cloud Storage |

Typical usage: 1-5 GB = **$0.10-$0.50/month**

## VPC Connector Pricing

| Resource | Price |
|----------|-------|
| Instance | $0.015/hour (~$11/month) |
| Data Processing | $0.01/GB |

**Tip**: Required for Cloud Run → Cloud SQL connection.

## Firebase Hosting (Alternative)

| Plan | Price | Includes |
|------|-------|----------|
| Spark (Free) | $0 | 10 GB storage, 360 MB/day transfer |
| Blaze (Pay-as-go) | Variable | Unlimited + free tier |

### Blaze Plan Costs
- Storage: $0.026/GB
- Transfer: $0.15/GB (after free tier)

**Best for**: Static sites, SPAs (React, Flutter Web, Vue)

## Cost Comparison by Project Type

### Flutter Web (Static)

| Option | Monthly Cost | Best For |
|--------|--------------|----------|
| Firebase Hosting | **$0** | Small projects |
| Cloud Run | **$0-5** | Need backend |
| Cloud Storage + CDN | **$0-2** | High traffic static |

### Next.js (SSR)

| Option | Monthly Cost | Best For |
|--------|--------------|----------|
| Cloud Run (scale-to-zero) | **$0-15** | Variable traffic |
| Cloud Run (min instances) | **$30-70** | Low latency needed |
| GCE e2-small | **$20** | Consistent traffic |

### Laravel + Database

| Option | Monthly Cost | Best For |
|--------|--------------|----------|
| Cloud Run + Cloud SQL | **$15-50** | Scalable apps |
| GCE + Local MySQL | **$20-40** | Simple apps |
| GCE + Cloud SQL | **$30-80** | Enterprise |

## Cost Optimization Tips

### 1. Scale to Zero
Set `min_instances: 0` for Cloud Run to avoid idle costs. Accept 1-2 second cold starts.

### 2. Right-size Resources
Start with:
- Cloud Run: 256MB-512MB memory, 1 vCPU
- Cloud SQL: db-f1-micro
- GCE: e2-micro or e2-small

Scale up only when needed.

### 3. Use Free Tier Regions
If latency isn't critical, use US regions for free e2-micro instances.

### 4. Committed Use Discounts
For predictable workloads, commit for 1-3 years for up to 55% savings.

### 5. Preemptible/Spot VMs
For batch jobs: 60-91% cheaper but can be terminated.

### 6. Budget Alerts
Always set budget alerts:
```bash
gcloud billing budgets create \
  --billing-account=ACCOUNT_ID \
  --display-name="Monthly Budget" \
  --budget-amount=50USD \
  --threshold-rule=percent=50 \
  --threshold-rule=percent=80 \
  --threshold-rule=percent=100
```

## Cost Calculator Template

Use this template when presenting options to users:

```markdown
## Deployment Cost Estimate: [Project Name]

### Option A: Cloud Run (Recommended)
| Resource | Specification | Monthly Cost |
|----------|---------------|--------------|
| Cloud Run | 512MB, 1 vCPU | $X |
| Artifact Registry | ~2GB | $0.20 |
| Cloud Build | < 120min/day | $0 |
| VPC Connector | (if DB) | $11 |
| Cloud SQL | (if needed) | $12 |
| **Total** | | **$X** |

### Option B: Compute Engine
| Resource | Specification | Monthly Cost |
|----------|---------------|--------------|
| VM Instance | e2-small | $16 |
| Boot Disk | 20GB SSD | $3.74 |
| Static IP | 1 IP | $0 (free while attached) |
| **Total** | | **$20** |

### Recommendation
[Your recommendation based on project requirements]
```

## Links

- GCP Pricing Calculator: https://cloud.google.com/products/calculator
- Cloud Run Pricing: https://cloud.google.com/run/pricing
- Cloud SQL Pricing: https://cloud.google.com/sql/pricing
- Compute Engine Pricing: https://cloud.google.com/compute/all-pricing
