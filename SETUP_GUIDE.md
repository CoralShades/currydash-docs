# CurryDash Multi-Repository Documentation Setup

Complete guide for setting up documentation across CurryDash's three-repository architecture.

---

## 📦 Package Contents

This package contains integration scripts for all three CurryDash repositories:

```
currydash-multi-repo/
├── docs-repo/
│   └── setup-docs-repository.sh          # NEW docs repository
├── backend-repo-integration/
│   └── integrate-backend.sh              # EXISTING backend repo
├── mobile-repo-integration/
│   └── integrate-mobile.sh               # EXISTING mobile repo
├── scripts/
│   └── setup-all-repos.sh                # Master orchestration
└── SETUP_GUIDE.md                        # This file
```

---

## 🎯 Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    CurryDash Platform                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  📚 currydash-docs (NEW)                                   │
│     - Platform documentation                               │
│     - Multi-audience (Developers, Vendors, Admins)         │
│     - Receives updates from both code repos                │
│     - Nextra 4 + Semantic Release                          │
│     - Headless API                                         │
│                                                             │
│  🔧 currydash-admin-vendor-portal (EXISTING)               │
│     - Laravel Backend API                                  │
│     - Admin Portal                                         │
│     - Seller Portal                                        │
│     - Triggers docs updates on push                        │
│                                                             │
│  📱 currydash-mobile (EXISTING)                            │
│     - Flutter Mobile App                                   │
│     - Flutter Web App                                      │
│     - Triggers docs updates on push                        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🚀 Quick Start (3-Repository Setup)

### Prerequisites

1. ✅ GitHub account with `your-org` organization
2. ✅ `bmad-docops-nextra.zip` downloaded
3. ✅ Existing repos:
   - `currydash-admin-vendor-portal`
   - `currydash-mobile`
4. ✅ Tools installed:
   - Git
   - GitHub CLI (`gh`)
   - Node.js 20+
   - Bash

---

## 📋 Step-by-Step Setup

### Step 1: Create Documentation Repository

```bash
# Create a new directory for the docs repository
mkdir currydash-docs
cd currydash-docs

# Copy bmad-docops-nextra.zip here
cp /path/to/bmad-docops-nextra.zip .

# Extract and run setup script
unzip ../currydash-multi-repo.zip
bash docs-repo/setup-docs-repository.sh

# Initialize git
git init
git add .
git commit -m "feat: initialize CurryDash documentation

- Multi-audience structure (developers, vendors, admins)
- Cross-repository integration
- BMAD Method workflows
- Semantic-release versioning"

# Create GitHub repository
gh repo create your-org/currydash-docs --public

# Push to GitHub
git remote add origin https://github.com/your-org/currydash-docs.git
git branch -M main
git push -u origin main
```

### Step 2: Create Personal Access Token

**This token allows code repositories to trigger documentation updates.**

1. Go to GitHub → Settings → Developer settings → Personal access tokens
2. Click "Generate new token (classic)"
3. Name: `CurryDash Docs Integration`
4. Expiration: 90 days (or No expiration)
5. Scopes:
   - ✅ `repo` (all)
   - ✅ `workflow`
6. Click "Generate token"
7. **COPY THE TOKEN** (you won't see it again)

### Step 3: Integrate Backend Repository

```bash
# Navigate to your existing backend repository
cd /path/to/currydash-admin-vendor-portal

# Extract integration package
unzip /path/to/currydash-multi-repo.zip

# Run integration script
bash backend-repo-integration/integrate-backend.sh

# Add repository secret
# Go to: GitHub repo → Settings → Secrets and variables → Actions
# New repository secret:
#   Name: DOCS_REPO_TOKEN
#   Value: [paste your token from Step 2]

# Update workflow file
# Edit .github/workflows/notify-docs.yml
# Replace 'your-org' with your actual GitHub organization

# Test the integration
git add .
git commit -m "feat: integrate documentation automation

Adds automatic documentation updates to currydash-docs.

- GitHub Actions workflow for notifications
- Updated README with docs links
- Contributing guidelines

Stories: SETUP-1"

git push origin main

# Check GitHub Actions to verify workflow ran
```

### Step 4: Integrate Mobile Repository

```bash
# Navigate to your existing mobile repository
cd /path/to/currydash-mobile

# Extract integration package (if not already done)
unzip /path/to/currydash-multi-repo.zip

# Run integration script
bash mobile-repo-integration/integrate-mobile.sh

# Add repository secret
# Go to: GitHub repo → Settings → Secrets and variables → Actions
# New repository secret:
#   Name: DOCS_REPO_TOKEN
#   Value: [paste your token from Step 2]

# Update workflow file
# Edit .github/workflows/notify-docs.yml
# Replace 'your-org' with your actual GitHub organization

# Test the integration
git add .
git commit -m "feat: integrate documentation automation

Adds automatic documentation updates to currydash-docs.

- GitHub Actions workflow for notifications
- Updated README with docs links
- Contributing guidelines

Stories: SETUP-2"

git push origin main

# Check GitHub Actions to verify workflow ran
```

### Step 5: Deploy Documentation Site

Choose your deployment option:

#### Option A: Vercel (Recommended)

```bash
cd currydash-docs/docs
npm install
npm i -g vercel
vercel

# Follow prompts:
# - Link to existing project or create new
# - Set as production deployment
```

**Custom Domain Setup:**
1. Vercel dashboard → Settings → Domains
2. Add `docs.currydash.com`
3. Update DNS with provided records

#### Option B: GitHub Pages

```bash
# Already configured in .github/workflows/docs.yml

# Enable GitHub Pages:
# Repo Settings → Pages → Source: GitHub Actions

# Docs will deploy at: https://your-org.github.io/currydash-docs
```

#### Option C: GCP Cloud Run

```bash
cd currydash-docs/docs

# Build container
docker build -t gcr.io/your-project/currydash-docs .

# Push to GCR
docker push gcr.io/your-project/currydash-docs

# Deploy to Cloud Run
gcloud run deploy currydash-docs \
  --image gcr.io/your-project/currydash-docs \
  --region australia-southeast1 \
  --allow-unauthenticated \
  --platform managed
```

---

## 🔄 How It Works

### Automatic Documentation Updates

```
┌─────────────────────────────────────────────────────────┐
│  Developer commits to backend/mobile repo               │
│  Message: "feat: add authentication (Stories: STORY-1)" │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│  GitHub Actions Workflow (notify-docs.yml)              │
│  - Extracts story ID from commit                        │
│  - Determines documentation sections                    │
│  - Triggers currydash-docs via repository_dispatch      │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│  Docs Repository (sync-from-repos.yml)                  │
│  - Receives trigger with payload                        │
│  - Creates change spec in .doc-changes/STORY-1.yaml     │
│  - Updates .doc-manifest.yaml                           │
│  - Creates GitHub issue for tracking                    │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│  Developer runs BMAD workflow                           │
│  Command: *paige ds                                     │
│  - Applies pending changes                              │
│  - Updates MDX files                                    │
│  - Commits with conventional format                     │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│  Semantic Release                                       │
│  - Analyzes commits                                     │
│  - Determines version bump                              │
│  - Updates changelog                                    │
│  - Creates GitHub release                               │
│  - Deploys documentation                                │
└─────────────────────────────────────────────────────────┘
```

---

## 📝 Developer Workflow Examples

### Backend Developer Flow

```bash
# 1. Working on authentication feature
cd currydash-admin-vendor-portal
git checkout -b feature/STORY-123-user-auth

# 2. Develop feature
# ... make changes to Laravel code ...

# 3. Commit with story ID
git add .
git commit -m "feat(auth): implement JWT authentication

Added JWT token generation and validation.
Includes refresh token mechanism.

Stories: STORY-123"

# 4. Push to GitHub
git push origin feature/STORY-123-user-auth

# 5. Create and merge PR
gh pr create --title "User Authentication" --body "Implements STORY-123"

# 6. After merge to main:
# - GitHub Actions triggers
# - currydash-docs receives notification
# - Change spec created
# - GitHub issue opened in docs repo

# 7. Update documentation
cd ../currydash-docs
git pull

# Run BMAD workflow (in BMAD chat or CLI)
*paige ds

# 8. Review and commit documentation changes
git add .
git commit -m "docs(api): add authentication endpoints

Documents JWT authentication flow.

Stories: STORY-123"

git push origin main

# 9. Semantic release automatically:
# - Bumps version (feat → minor)
# - Updates changelog
# - Deploys docs
```

### Frontend Developer Flow

```bash
# 1. Working on biometric auth
cd currydash-mobile
git checkout -b feature/STORY-124-biometric-auth

# 2. Develop feature
# ... Flutter code ...

# 3. Commit with story ID
git commit -m "feat(auth): add biometric authentication

Implements fingerprint and face ID support for iOS and Android.

Stories: STORY-124"

# 4. Push and merge
git push origin feature/STORY-124-biometric-auth

# Same flow as backend - docs auto-update
```

---

## 🧪 Testing the Integration

### Test 1: Backend Repository Trigger

```bash
cd currydash-admin-vendor-portal

# Make a test commit
echo "# Test" >> TEST.md
git add TEST.md
git commit -m "feat(test): test documentation trigger

Stories: TEST-1"

git push origin main

# Verify:
# 1. GitHub Actions → "Notify Documentation Repository" workflow runs
# 2. currydash-docs → Actions → "Sync from Repositories" workflow runs
# 3. currydash-docs → Issues → New issue created for TEST-1
# 4. currydash-docs → .doc-changes/TEST-1.yaml created
```

### Test 2: Mobile Repository Trigger

```bash
cd currydash-mobile

# Make a test commit
echo "// Test" >> lib/test.dart
git add lib/test.dart
git commit -m "feat(test): test documentation trigger

Stories: TEST-2"

git push origin main

# Same verification steps as Test 1
```

### Test 3: Documentation Update

```bash
cd currydash-docs

# Check for pending changes
cat .doc-manifest.yaml

# Run BMAD sync (in BMAD environment)
*paige ds

# Or manually update docs and commit
git add docs/content/
git commit -m "docs: apply changes for TEST-1 and TEST-2

Stories: TEST-1, TEST-2"

git push origin main

# Verify semantic-release runs and creates new version
```

---

## 🎨 Customization

### Update Branding

```bash
cd currydash-docs/docs

# 1. Edit layout (logo, colors, links)
nano app/layout.tsx

# 2. Edit global styles (brand colors)
nano app/globals.css

# 3. Update tailwind config
nano tailwind.config.js

# 4. Replace favicon
cp /path/to/logo.png public/favicon.ico
```

### Update Repository URLs

```bash
# In all three repositories, update:
# - .github/workflows/*.yml (repository URLs)
# - README.md (repository links)
# - planning_artifacts/platform-manifest.yaml

# Find and replace
find . -type f -name "*.yml" -o -name "*.yaml" -o -name "*.md" | \
  xargs sed -i 's/your-org/actual-org/g'
```

---

## 📊 Repository Secrets Needed

Each code repository needs:

| Secret Name | Value | Purpose |
|-------------|-------|---------|
| `DOCS_REPO_TOKEN` | GitHub PAT | Trigger docs repo workflows |

Documentation repository needs:

| Secret Name | Value | Purpose |
|-------------|-------|---------|
| `GITHUB_TOKEN` | Auto-provided | Semantic release |

---

## 🔍 Troubleshooting

### Issue: Workflow not triggering

**Check:**
1. `DOCS_REPO_TOKEN` secret exists in source repo
2. Token has `repo` and `workflow` scopes
3. Repository URLs correct in workflow files
4. Commit message contains `Stories: STORY-ID`

**Debug:**
```bash
# View workflow runs
gh run list --repo your-org/currydash-admin-vendor-portal
gh run list --repo your-org/currydash-docs

# View specific run
gh run view <run-id> --log
```

### Issue: Documentation not updating

**Check:**
1. Change spec created in `.doc-changes/`
2. Manifest updated in `.doc-manifest.yaml`
3. GitHub issue created
4. Running `*paige ds` in correct repository

**Debug:**
```bash
cd currydash-docs

# Check pending changes
cat .doc-manifest.yaml

# View change specs
ls -la .doc-changes/

# Check workflow logs
gh run list
```

### Issue: Semantic release not running

**Check:**
1. Commit follows conventional format
2. Pushing to `main` branch
3. Workflow file has correct permissions

**Debug:**
```bash
# Test locally
cd currydash-docs/docs
npm run semantic-release --dry-run
```

---

## 📚 Documentation Structure

```
currydash-docs/
├── docs/content/
│   ├── index.mdx                          # Homepage
│   ├── developers/                        # Developer docs
│   │   ├── index.mdx                      # Overview
│   │   ├── getting-started/
│   │   ├── backend/                       # From backend repo
│   │   │   ├── laravel/
│   │   │   ├── database/
│   │   │   └── api/
│   │   ├── frontend/                      # From mobile repo
│   │   │   ├── flutter/
│   │   │   ├── state-management/
│   │   │   └── api-integration/
│   │   └── deployment/                    # Shared
│   ├── vendors/                           # Vendor guides
│   │   ├── seller-portal/                 # From backend repo
│   │   ├── menu-management/
│   │   └── orders/
│   ├── admins/                            # Admin guides
│   │   ├── user-management/               # From backend repo
│   │   └── analytics/
│   ├── api/                               # API reference
│   │   └── (auto-generated from backend)
│   └── changelog.mdx                      # Auto-generated
└── planning_artifacts/
    ├── workflows/                         # BMAD workflows
    ├── modules/                           # BMAD modules
    └── platform-manifest.yaml             # Repo mapping
```

---

## 🎯 BMAD Workflow Commands

| Command | When | What It Does |
|---------|------|--------------|
| `*paige di` | After Phase 3 | Initialize docs from planning artifacts |
| `*paige da STORY-123` | Story complete | Analyze story for doc needs |
| `*paige ds` | Sprint end | Apply all pending changes |

---

## 🚢 Deployment URLs

After setup, your documentation will be available at:

- **Vercel:** `https://currydash-docs.vercel.app`
- **Custom:** `https://docs.currydash.com` (after DNS setup)
- **GitHub Pages:** `https://your-org.github.io/currydash-docs`
- **GCP Cloud Run:** `https://currydash-docs-xxx.run.app`

Update all repository README files with the final URL.

---

## ✅ Final Checklist

**Documentation Repository (`currydash-docs`)**
- [ ] Created and pushed to GitHub
- [ ] Dependencies installed (`npm install`)
- [ ] Tested locally (`npm run dev`)
- [ ] Deployed to hosting platform
- [ ] Custom domain configured (optional)
- [ ] Workflow files updated with org name

**Backend Repository (`currydash-admin-vendor-portal`)**
- [ ] Integration script executed
- [ ] `DOCS_REPO_TOKEN` secret added
- [ ] Workflow file updated with org name
- [ ] Test commit pushed with story ID
- [ ] Workflow trigger verified in Actions

**Mobile Repository (`currydash-mobile`)**
- [ ] Integration script executed
- [ ] `DOCS_REPO_TOKEN` secret added
- [ ] Workflow file updated with org name
- [ ] Test commit pushed with story ID
- [ ] Workflow trigger verified in Actions

**Cross-Repository Integration**
- [ ] Workflow triggers working (both directions)
- [ ] Change specs created automatically
- [ ] GitHub issues created in docs repo
- [ ] BMAD workflows accessible
- [ ] Semantic release configured and tested

---

## 📞 Support & Next Steps

### Resources

- [Nextra Documentation](https://nextra.site)
- [Semantic Release](https://semantic-release.gitbook.io/)
- [GitHub Actions](https://docs.github.com/en/actions)
- [BMAD Method](https://github.com/your-org/bmad-method)

### Next Steps

1. **Populate Initial Documentation**
   - Run `*paige di` in docs repo
   - Review and enhance generated content
   - Add images, examples, code samples

2. **Team Onboarding**
   - Share documentation URLs
   - Train team on commit message format
   - Demonstrate BMAD workflows

3. **Continuous Improvement**
   - Monitor documentation issues
   - Review and merge doc PRs
   - Keep changelog updated
   - Gather user feedback

---

**Setup Complete!** 🎉

Your CurryDash platform now has fully integrated, multi-repository documentation that auto-updates from code changes and uses semantic versioning.
