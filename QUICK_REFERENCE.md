# CurryDash Multi-Repo Quick Reference

## 🚀 Setup Commands

```bash
# Extract package
unzip currydash-multi-repo.zip
cd currydash-multi-repo

# Run automated setup
bash scripts/setup-all-repos.sh

# OR manual setup
bash docs-repo/setup-docs-repository.sh                    # Create docs repo
bash backend-repo-integration/integrate-backend.sh         # Integrate backend
bash mobile-repo-integration/integrate-mobile.sh           # Integrate mobile
```

## 📦 Repository URLs

| Repository | URL | Purpose |
|------------|-----|---------|
| Docs | `https://github.com/your-org/currydash-docs` | Platform documentation |
| Backend | `https://github.com/your-org/currydash-admin-vendor-portal` | Laravel API + Admin |
| Mobile | `https://github.com/your-org/currydash-mobile` | Flutter apps |

## 🔐 Required Secrets

Add to **backend** and **mobile** repositories:

| Secret Name | Value | Scopes |
|-------------|-------|--------|
| `DOCS_REPO_TOKEN` | GitHub PAT | `repo`, `workflow` |

## 🤖 BMAD Workflow Commands

| Command | When | What It Does |
|---------|------|--------------|
| `*paige di` | After Phase 3 complete | Initialize docs from planning artifacts |
| `*paige da STORY-123` | Story marked done | Analyze story for documentation needs |
| `*paige ds` | Sprint end or manual | Apply all pending changes to docs |

## 📝 Commit Message Format

```bash
# Feature (minor version bump)
git commit -m "feat(auth): add JWT authentication

Stories: STORY-123"

# Fix (patch version bump)
git commit -m "fix(api): resolve token issue

Stories: STORY-124"

# Breaking change (major version bump)
git commit -m "feat(api)!: redesign endpoints

BREAKING CHANGE: All endpoints now use /v2/.

Stories: STORY-125"
```

## 🔄 Workflow Trigger Flow

```
1. Developer commits to backend/mobile with story ID
   ↓
2. GitHub Actions → notify-docs.yml runs
   ↓
3. Triggers currydash-docs via repository_dispatch
   ↓
4. currydash-docs → sync-from-repos.yml runs
   ↓
5. Creates .doc-changes/STORY-123.yaml
   ↓
6. Creates GitHub issue for tracking
   ↓
7. Developer runs: *paige ds
   ↓
8. Documentation updated and committed
   ↓
9. Semantic-release creates new version
   ↓
10. Documentation deployed
```

## 🧪 Testing Integration

### Backend Test
```bash
cd currydash-admin-vendor-portal
git commit -m "feat(test): test docs (Stories: TEST-1)"
git push origin main

# Check:
# - GitHub Actions runs
# - currydash-docs gets issue
# - .doc-changes/TEST-1.yaml created
```

### Mobile Test
```bash
cd currydash-mobile
git commit -m "feat(test): test docs (Stories: TEST-2)"
git push origin main

# Same checks as backend
```

### Docs Update Test
```bash
cd currydash-docs
*paige ds
git push origin main

# Check:
# - Semantic-release runs
# - New version created
# - Docs deployed
```

## 🚀 Deployment Commands

### Local Development
```bash
cd currydash-docs/docs
npm install
npm run dev  # http://localhost:3000
```

### Vercel Deployment
```bash
cd currydash-docs/docs
npm i -g vercel
vercel --prod
```

### GitHub Pages
```bash
# Already configured!
# Just enable in: Repo Settings → Pages → Source: GitHub Actions
```

### GCP Cloud Run
```bash
cd currydash-docs/docs
gcloud run deploy currydash-docs \
  --source . \
  --region australia-southeast1 \
  --allow-unauthenticated
```

## 🎨 Customization Paths

| What to Customize | File | Path |
|-------------------|------|------|
| Logo & branding | `layout.tsx` | `currydash-docs/docs/app/layout.tsx` |
| Colors | `globals.css` | `currydash-docs/docs/app/globals.css` |
| Tailwind theme | `tailwind.config.js` | `currydash-docs/docs/tailwind.config.js` |
| Homepage | `index.mdx` | `currydash-docs/docs/content/index.mdx` |
| Navigation | `_meta.js` | `currydash-docs/docs/content/_meta.js` |

## 📊 Key Files

### Documentation Repository
```
currydash-docs/
├── docs/content/               # MDX documentation files
├── docs/app/                   # Next.js app
├── planning_artifacts/         # BMAD workflows
├── .github/workflows/          # CI/CD
├── .doc-changes/               # Pending changes
├── .doc-manifest.yaml          # Change tracking
└── planning_artifacts/platform-manifest.yaml  # Repo mapping
```

### Backend Repository
```
currydash-admin-vendor-portal/
├── .github/workflows/
│   └── notify-docs.yml         # Triggers docs updates
├── README.md                   # Updated with docs links
├── CONTRIBUTING.md             # Contribution guidelines
└── scripts/
    └── trigger-docs-update.sh  # Manual trigger helper
```

### Mobile Repository
```
currydash-mobile/
├── .github/workflows/
│   └── notify-docs.yml         # Triggers docs updates
├── README.md                   # Updated with docs links
├── CONTRIBUTING.md             # Contribution guidelines
└── scripts/
    └── trigger-docs-update.sh  # Manual trigger helper
```

## 🔍 Troubleshooting

### Workflow Not Triggering
```bash
# Check secret exists
gh secret list --repo your-org/currydash-admin-vendor-portal

# Verify token scopes
# Token must have: repo, workflow

# Check workflow file
cat .github/workflows/notify-docs.yml

# View workflow runs
gh run list
gh run view <run-id> --log
```

### Docs Not Updating
```bash
# Check pending changes
cd currydash-docs
cat .doc-manifest.yaml
ls -la .doc-changes/

# Check GitHub issues
gh issue list --label documentation

# Run sync manually
*paige ds
```

### Semantic Release Not Running
```bash
# Check commit format
git log --oneline -10

# Test locally
cd currydash-docs/docs
npm run semantic-release --dry-run

# Check workflow permissions
# .github/workflows/docs.yml must have:
# permissions:
#   contents: write
```

## 📞 Quick Links

- **Nextra Docs:** https://nextra.site
- **Semantic Release:** https://semantic-release.gitbook.io/
- **GitHub Actions:** https://docs.github.com/en/actions
- **Conventional Commits:** https://www.conventionalcommits.org/

## ✅ Post-Setup Checklist

- [ ] Docs repository created and deployed
- [ ] Backend integration complete
- [ ] Mobile integration complete
- [ ] Personal Access Token created
- [ ] Secrets added to both code repos
- [ ] Test commits made with story IDs
- [ ] Workflows verified in GitHub Actions
- [ ] Documentation site accessible
- [ ] Custom domain configured (optional)
- [ ] Team trained on commit format
- [ ] BMAD workflows accessible

---

**Need detailed instructions?** See `SETUP_GUIDE.md`

**Ready to start?** Run `bash scripts/setup-all-repos.sh`
