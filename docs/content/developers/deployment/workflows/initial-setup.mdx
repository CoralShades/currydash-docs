# Initial GCP Setup Workflow

Follow this workflow when setting up GCP for a new project.

## Prerequisites

- Google Cloud account (demi@coralshades.ai)
- gcloud CLI installed
- Billing account linked

## Step 1: Authentication

```bash
# Login to GCP
gcloud auth login

# Verify authentication
gcloud auth list
```

## Step 2: Project Setup

### Option A: Use Existing Project
```bash
# List existing projects
gcloud projects list

# Set active project
gcloud config set project PROJECT_ID
```

### Option B: Create New Project
```bash
# Create project
gcloud projects create PROJECT_ID --name="Project Name"

# Set as active
gcloud config set project PROJECT_ID

# Link billing (required for most services)
gcloud billing projects link PROJECT_ID \
  --billing-account=BILLING_ACCOUNT_ID
```

## Step 3: Enable Required APIs

```bash
# Core APIs (always needed)
gcloud services enable \
  run.googleapis.com \
  cloudbuild.googleapis.com \
  artifactregistry.googleapis.com \
  secretmanager.googleapis.com

# Database (if needed)
gcloud services enable sqladmin.googleapis.com

# Networking (if using Cloud SQL with Cloud Run)
gcloud services enable \
  vpcaccess.googleapis.com \
  servicenetworking.googleapis.com
```

## Step 4: Set Default Region

```bash
# Set default region
gcloud config set run/region australia-southeast1
gcloud config set compute/region australia-southeast1
gcloud config set compute/zone australia-southeast1-a
```

## Step 5: Create Artifact Registry

```bash
# Create Docker repository
gcloud artifacts repositories create docker-repo \
  --repository-format=docker \
  --location=australia-southeast1 \
  --description="Docker images"

# Configure Docker authentication
gcloud auth configure-docker australia-southeast1-docker.pkg.dev
```

## Step 6: Set Up VPC Connector (Optional)

Required for Cloud Run → Cloud SQL connectivity:

```bash
# Create VPC connector
gcloud compute networks vpc-access connectors create app-connector \
  --region=australia-southeast1 \
  --network=default \
  --range=10.8.0.0/28 \
  --min-instances=2 \
  --max-instances=3
```

## Step 7: Cloud SQL Setup (Optional)

```bash
# Create MySQL instance
gcloud sql instances create app-db \
  --database-version=MYSQL_8_0 \
  --tier=db-f1-micro \
  --region=australia-southeast1 \
  --storage-size=10GB \
  --storage-type=SSD \
  --backup \
  --backup-start-time=03:00

# Create database
gcloud sql databases create app_database --instance=app-db

# Create user
gcloud sql users create app_user \
  --instance=app-db \
  --password=SECURE_PASSWORD
```

## Step 8: Secret Manager Setup

```bash
# Create secrets
echo -n "your-secret-value" | \
  gcloud secrets create SECRET_NAME \
  --data-file=-

# Grant Cloud Run access
gcloud secrets add-iam-policy-binding SECRET_NAME \
  --member="serviceAccount:PROJECT_NUMBER-compute@developer.gserviceaccount.com" \
  --role="roles/secretmanager.secretAccessor"
```

## Step 9: Set Up Budget Alerts

```bash
# Create budget (recommended)
gcloud billing budgets create \
  --billing-account=BILLING_ACCOUNT_ID \
  --display-name="Monthly Budget" \
  --budget-amount=50USD \
  --threshold-rule=percent=50 \
  --threshold-rule=percent=80 \
  --threshold-rule=percent=100
```

## Verification Checklist

- [ ] Authenticated to GCP
- [ ] Project selected/created
- [ ] Required APIs enabled
- [ ] Artifact Registry created
- [ ] Docker authentication configured
- [ ] (Optional) VPC Connector created
- [ ] (Optional) Cloud SQL instance created
- [ ] (Optional) Secrets created
- [ ] Budget alerts configured

## Cost Estimate for Setup

| Resource | Monthly Cost |
|----------|--------------|
| Artifact Registry | ~$0.10/GB |
| VPC Connector | ~$11 (if used) |
| Cloud SQL (db-f1-micro) | ~$12 |
| **Total (minimal)** | **$0-12** |
| **Total (with DB)** | **~$23** |

## Next Steps

After initial setup, proceed to:
- `deploy-cloud-run.md` - Deploy your application
- `ci-cd-setup.md` - Set up automated deployments
