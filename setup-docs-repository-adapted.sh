#!/bin/bash
# CurryDash Documentation Repository Setup - Adapted
# Uses extracted bmad-docops folder and actual repo names
# Organization: CoralShades

set -e

echo "CurryDash Documentation Repository Setup"
echo "========================================="
echo ""

# Configuration
ORG_NAME="CoralShades"
DOCS_REPO="currydash-docs"
BACKEND_REPO="CurryDash-Admin-Seller-Portal"
MOBILE_REPO="CurryDash-UserApp-Mobile_Web-Flutter"
DOMAIN="docs.currydash.com"

# Check if bmad-docops folder exists
if [ ! -d "bmad-docops" ]; then
    echo "Error: bmad-docops folder not found in current directory"
    echo "   Please ensure the bmad-docops folder is extracted"
    exit 1
fi

# Create docs structure from templates
echo "Creating documentation structure..."
mkdir -p docs
cp -r bmad-docops/templates/* docs/

# Create planning artifacts directory
echo "Creating planning artifacts structure..."
mkdir -p planning_artifacts/{workflows,modules/docops-nextra}
cp bmad-docops/workflows/*.md planning_artifacts/workflows/
cp bmad-docops/module/module.yaml planning_artifacts/modules/docops-nextra/

# Setup multi-audience structure
echo "Setting up multi-audience documentation..."
cd docs/content

# Create directories
mkdir -p developers/{getting-started,backend/{laravel,database,api,requirements,architecture,epics},frontend/{flutter,state-management,api-integration,requirements,epics},deployment,brand}
mkdir -p vendors/{getting-started,seller-portal,menu-management,orders,payments,analytics}
mkdir -p admins/{getting-started,user-management,vendor-management,analytics,settings,platform}
mkdir -p api/{backend,frontend}

# Root navigation
cat > _meta.js << 'EOF'
export default {
  index: {
    title: 'CurryDash',
    type: 'page',
    display: 'hidden',
  },
  developers: {
    title: 'Developer Docs',
    type: 'page',
  },
  vendors: {
    title: 'Vendor Guide',
    type: 'page',
  },
  admins: {
    title: 'Admin Guide',
    type: 'page',
  },
  '---': {
    type: 'separator',
  },
  api: {
    title: 'API Reference',
    type: 'page',
  },
  changelog: {
    title: 'Changelog',
    type: 'page',
  },
}
EOF

# Developers meta
cat > developers/_meta.js << 'EOF'
export default {
  index: 'Overview',
  'getting-started': 'Getting Started',
  backend: {
    title: 'Backend (Laravel)',
    type: 'page',
  },
  frontend: {
    title: 'Frontend (Flutter)',
    type: 'page',
  },
  deployment: 'Deployment & DevOps',
  brand: 'Brand Guidelines',
}
EOF

cat > developers/backend/_meta.js << 'EOF'
export default {
  index: 'Overview',
  laravel: 'Laravel Development',
  database: 'Database & Migrations',
  api: 'API Development',
  requirements: 'Requirements (PRD)',
  architecture: 'Architecture',
  epics: 'Epics & Stories',
}
EOF

cat > developers/frontend/_meta.js << 'EOF'
export default {
  index: 'Overview',
  flutter: 'Flutter Setup',
  'state-management': 'State Management',
  'api-integration': 'API Integration',
  requirements: 'Requirements (PRD)',
  epics: 'Epics & Stories',
}
EOF

# Vendors meta
cat > vendors/_meta.js << 'EOF'
export default {
  index: 'Overview',
  'getting-started': 'Getting Started',
  'seller-portal': 'Seller Portal',
  'menu-management': 'Menu Management',
  orders: 'Order Management',
  payments: 'Payments & Payouts',
  analytics: 'Sales Analytics',
}
EOF

# Admins meta
cat > admins/_meta.js << 'EOF'
export default {
  index: 'Overview',
  'getting-started': 'Getting Started',
  'user-management': 'User Management',
  'vendor-management': 'Vendor Management',
  analytics: 'Analytics & Reports',
  settings: 'Platform Settings',
  platform: 'Platform Administration',
}
EOF

# API meta
cat > api/_meta.js << 'EOF'
export default {
  index: 'Overview',
  backend: 'Backend API',
  frontend: 'Mobile/Web API',
}
EOF

# Enhanced homepage with repo links
cat > index.mdx << EOF
---
title: CurryDash Platform Documentation
description: Complete documentation for the Sri Lankan food delivery platform
---

import { Cards, Card, Callout } from 'nextra/components'

# CurryDash Platform Documentation

Welcome to the complete documentation for **CurryDash** - the premium Sri Lankan food delivery platform serving Victoria, Australia.

<Callout type="info" emoji="info">
  **Multi-repository platform:** CurryDash consists of separate backend and mobile repositories. This documentation hub covers the entire platform.
</Callout>

## Documentation by Audience

<Cards>
  <Card title="Developer Docs" href="/developers">
    Laravel backend, Flutter apps, API integration, deployment
  </Card>

  <Card title="Vendor Guide" href="/vendors">
    Seller Portal, menu management, orders, payments
  </Card>

  <Card title="Admin Guide" href="/admins">
    Platform administration, user management, analytics
  </Card>

  <Card title="API Reference" href="/api">
    Complete REST API documentation
  </Card>
</Cards>

## Platform Repositories

CurryDash is organized across multiple repositories:

| Repository | Purpose | Technologies |
|------------|---------|--------------|
| [$BACKEND_REPO](https://github.com/$ORG_NAME/$BACKEND_REPO) | Backend API & Admin Portal | Laravel 9.x, MySQL, Redis |
| [$MOBILE_REPO](https://github.com/$ORG_NAME/$MOBILE_REPO) | Customer Mobile & Web Apps | Flutter, Dart |
| [$DOCS_REPO](https://github.com/$ORG_NAME/$DOCS_REPO) | Platform Documentation | Nextra 4, Next.js |

## Quick Start by Role

### For Backend Developers

\`\`\`bash
git clone https://github.com/$ORG_NAME/$BACKEND_REPO.git
cd $BACKEND_REPO/backend
composer install && php artisan migrate
\`\`\`

[Backend Setup Guide](/developers/backend/getting-started)

### For Frontend Developers

\`\`\`bash
git clone https://github.com/$ORG_NAME/$MOBILE_REPO.git
cd $MOBILE_REPO
flutter pub get && flutter run
\`\`\`

[Flutter Setup Guide](/developers/frontend/flutter)

### For Vendors

Access the Seller Portal at **https://seller.currydash.com**

[Vendor Onboarding Guide](/vendors/getting-started)

### For Admins

Access the Admin Portal at **https://admin.currydash.com**

[Admin Guide](/admins/getting-started)

## Platform Architecture

\`\`\`
+----------------------------------------------------------+
|  Flutter Mobile/Web Apps                                  |
|  Repository: $MOBILE_REPO                                 |
+-----------------------------+----------------------------+
                              | REST API
+-----------------------------v----------------------------+
|  Laravel Backend API + Admin Portal                      |
|  Repository: $BACKEND_REPO                               |
+----------------------------------------------------------+
|  Cloud SQL (MySQL) | Memorystore (Redis)                 |
|  Google Cloud Platform                                   |
+----------------------------------------------------------+
\`\`\`

## Brand Colors

- **Turmeric Gold** \`#E6B04B\` - Primary
- **Chili Red** \`#C5351F\` - Accent
- **Curry Leaf Green** \`#4A7C59\` - Success

## Documentation Updates

This documentation is automatically synchronized with both code repositories:
- Commits to \`$BACKEND_REPO\` update Backend/Admin/Vendor docs
- Commits to \`$MOBILE_REPO\` update Frontend docs

Using BMAD Method with semantic-release for versioning.
EOF

# Replace variables in index.mdx
sed -i "s/\$ORG_NAME/$ORG_NAME/g" index.mdx
sed -i "s/\$BACKEND_REPO/$BACKEND_REPO/g" index.mdx
sed -i "s/\$MOBILE_REPO/$MOBILE_REPO/g" index.mdx
sed -i "s/\$DOCS_REPO/$DOCS_REPO/g" index.mdx

# Create developers overview
cat > developers/index.mdx << EOF
---
title: Developer Documentation
description: Technical documentation for CurryDash platform developers
---

import { Cards, Card, Callout } from 'nextra/components'

# Developer Documentation

Technical documentation for building and deploying the CurryDash platform.

<Callout type="info">
  **Multi-repository setup:** Clone both repositories for full platform development.
</Callout>

## Repositories

### Backend: $BACKEND_REPO

\`\`\`bash
git clone https://github.com/$ORG_NAME/$BACKEND_REPO.git
cd $BACKEND_REPO/backend
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
\`\`\`

[Backend Documentation](/developers/backend)

### Frontend: $MOBILE_REPO

\`\`\`bash
git clone https://github.com/$ORG_NAME/$MOBILE_REPO.git
cd $MOBILE_REPO
flutter pub get
flutter run
\`\`\`

[Frontend Documentation](/developers/frontend)

## Development Guides

<Cards>
  <Card title="Backend (Laravel)" href="/developers/backend">
    API development, database, authentication
  </Card>

  <Card title="Frontend (Flutter)" href="/developers/frontend">
    Mobile & web apps, state management
  </Card>

  <Card title="Deployment" href="/developers/deployment">
    GCP Cloud Run, Docker, CI/CD
  </Card>
</Cards>
EOF

sed -i "s/\$ORG_NAME/$ORG_NAME/g" developers/index.mdx
sed -i "s/\$BACKEND_REPO/$BACKEND_REPO/g" developers/index.mdx
sed -i "s/\$MOBILE_REPO/$MOBILE_REPO/g" developers/index.mdx

# Create vendors overview
cat > vendors/index.mdx << 'EOF'
---
title: Vendor Guide
description: Complete guide for restaurant vendors on CurryDash
---

import { Cards, Card, Callout } from 'nextra/components'

# Vendor Guide

Welcome! This guide will help you manage your restaurant on the CurryDash platform.

<Callout type="success" emoji="check">
  Ready to start serving authentic Sri Lankan cuisine to Victoria, Australia?
</Callout>

## Getting Started

<Cards>
  <Card title="Seller Portal" href="/vendors/seller-portal">
    Access dashboard, view orders, manage settings
  </Card>

  <Card title="Menu Management" href="/vendors/menu-management">
    Add dishes, set prices, manage availability
  </Card>

  <Card title="Orders" href="/vendors/orders">
    Accept orders, update status, handle delivery
  </Card>

  <Card title="Payments" href="/vendors/payments">
    View earnings, payout schedule, transactions
  </Card>
</Cards>

## Seller Portal Access

Access the Seller Portal at: **https://seller.currydash.com**

Need an account? Contact: vendors@currydash.com
EOF

# Create admins overview
cat > admins/index.mdx << 'EOF'
---
title: Admin Guide
description: Platform administration guide for CurryDash
---

import { Cards, Card, Callout } from 'nextra/components'

# Admin Guide

Platform administration documentation for CurryDash operators.

<Callout type="warning">
  **Admin Access Required:** These features require platform administrator privileges.
</Callout>

## Admin Portal

<Cards>
  <Card title="User Management" href="/admins/user-management">
    Manage customers, vendors, and admin accounts
  </Card>

  <Card title="Vendor Management" href="/admins/vendor-management">
    Approve vendors, manage restaurants
  </Card>

  <Card title="Analytics" href="/admins/analytics">
    Platform metrics, sales reports, insights
  </Card>

  <Card title="Settings" href="/admins/settings">
    Platform configuration and settings
  </Card>
</Cards>

## Admin Portal Access

Access the Admin Portal at: **https://admin.currydash.com**
EOF

# Create API overview
cat > api/index.mdx << 'EOF'
---
title: API Reference
description: CurryDash REST API documentation
---

import { Cards, Card, Callout } from 'nextra/components'

# API Reference

Complete REST API documentation for CurryDash platform integration.

<Callout type="info">
  API documentation is auto-generated from Laravel routes using L5-Swagger.
</Callout>

## API Sections

<Cards>
  <Card title="Backend API" href="/api/backend">
    Laravel REST API endpoints for admin, vendor, and customer operations
  </Card>

  <Card title="Mobile/Web API" href="/api/frontend">
    API integration guides for Flutter applications
  </Card>
</Cards>

## Authentication

All API endpoints require authentication using Bearer tokens:

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  https://api.currydash.com/v1/endpoint
```

## Base URLs

| Environment | URL |
|-------------|-----|
| Production | `https://api.currydash.com/v1` |
| Staging | `https://api-staging.currydash.com/v1` |
| Development | `http://localhost:8000/api/v1` |
EOF

cd ../..

# Create cross-repo sync workflow
mkdir -p .github/workflows
cat > .github/workflows/sync-from-repos.yml << EOF
name: Sync Documentation from Code Repositories

on:
  repository_dispatch:
    types: [docs-update]
  workflow_dispatch:

jobs:
  sync-docs:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout docs repository
        uses: actions/checkout@v4
        with:
          token: \${{ secrets.GITHUB_TOKEN }}

      - name: Log event payload
        run: |
          echo "Event from: \${{ github.event.client_payload.source_repo }}"
          echo "Story ID: \${{ github.event.client_payload.story_id }}"
          echo "Sections: \${{ github.event.client_payload.sections }}"
          echo "Commit: \${{ github.event.client_payload.commit_sha }}"
          echo "Message: \${{ github.event.client_payload.commit_message }}"

      - name: Create documentation change spec
        run: |
          STORY_ID="\${{ github.event.client_payload.story_id }}"
          SOURCE_REPO="\${{ github.event.client_payload.source_repo }}"
          SECTIONS="\${{ github.event.client_payload.sections }}"

          mkdir -p .doc-changes

          cat > .doc-changes/\${STORY_ID}.yaml << EOL
          metadata:
            story_id: "\${STORY_ID}"
            source_repo: "\${SOURCE_REPO}"
            analyzed_at: "\$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
            commit_sha: "\${{ github.event.client_payload.commit_sha }}"
            commit_message: "\${{ github.event.client_payload.commit_message }}"

          changes:
            - id: "change-1"
              type: update
              priority: medium
              sections: "\${SECTIONS}"
              auto_generated: true

          changelog_entry:
            type: feature
            scope: "\${SOURCE_REPO}"
            description: "Documentation updates from \${STORY_ID}"
          EOL

          echo "Created change spec for \${STORY_ID}"
          cat .doc-changes/\${STORY_ID}.yaml

      - name: Update manifest
        run: |
          STORY_ID="\${{ github.event.client_payload.story_id }}"

          if [ ! -f ".doc-manifest.yaml" ]; then
            echo "story_docs:" > .doc-manifest.yaml
          fi

          cat >> .doc-manifest.yaml << EOL
            \${STORY_ID}:
              status: pending
              source_repo: "\${{ github.event.client_payload.source_repo }}"
              created_at: "\$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
          EOL

          echo "Updated manifest"

      - name: Commit changes
        run: |
          git config user.name "CurryDash Bot"
          git config user.email "bot@currydash.com"

          git add .doc-changes/ .doc-manifest.yaml

          if git diff --staged --quiet; then
            echo "No changes to commit"
          else
            git commit -m "docs: add pending changes for \${{ github.event.client_payload.story_id }}

            Source: \${{ github.event.client_payload.source_repo }}
            Sections: \${{ github.event.client_payload.sections }}

            [skip ci]"

            git push

            echo "Changes committed and pushed"
          fi

      - name: Create tracking issue
        if: github.event.client_payload.story_id != ''
        uses: actions/github-script@v7
        with:
          script: |
            const storyId = '\${{ github.event.client_payload.story_id }}';
            const sourceRepo = '\${{ github.event.client_payload.source_repo }}';
            const sections = '\${{ github.event.client_payload.sections }}';

            github.rest.issues.create({
              owner: context.repo.owner,
              repo: context.repo.repo,
              title: \`Documentation update needed: \${storyId}\`,
              body: \`
              ## Documentation Update Required

              **Story:** \${storyId}
              **Source Repository:** \${sourceRepo}
              **Affected Sections:** \${sections}
              **Commit:** \${{ github.event.client_payload.commit_sha }}

              ### Next Steps

              Run \\\`*paige ds\\\` to apply pending documentation changes.

              ### Commit Message

              \\\`\\\`\\\`
              \${{ github.event.client_payload.commit_message }}
              \\\`\\\`\\\`
              \`,
              labels: ['documentation', 'auto-generated']
            });
EOF

# Update package.json
cd docs
npm pkg set name="$DOCS_REPO"
npm pkg set description="CurryDash platform documentation"
npm pkg set "repository.url"="https://github.com/$ORG_NAME/$DOCS_REPO"
npm pkg set homepage="https://$DOMAIN"

# Create platform manifest
cd ..
cat > planning_artifacts/platform-manifest.yaml << EOF
# CurryDash Platform Manifest
# Links documentation to source code repositories

platform:
  name: CurryDash
  version: "1.0.0"
  description: "Sri Lankan food delivery platform for Victoria, Australia"

repositories:
  backend:
    name: $BACKEND_REPO
    url: https://github.com/$ORG_NAME/$BACKEND_REPO
    type: backend
    language: PHP
    framework: Laravel 9.x
    documentation_sections:
      - developers/backend
      - api
      - admins
      - vendors/seller-portal

  frontend:
    name: $MOBILE_REPO
    url: https://github.com/$ORG_NAME/$MOBILE_REPO
    type: frontend
    language: Dart
    framework: Flutter 3.x
    documentation_sections:
      - developers/frontend
      - api/integration-examples

cross_repo_integration:
  enabled: true
  trigger_method: repository_dispatch
  sync_workflow: .github/workflows/sync-from-repos.yml

documentation_workflow:
  on_story_complete:
    - Source repo triggers docs repo
    - Create change spec in .doc-changes/
    - Update .doc-manifest.yaml
    - Create GitHub issue for tracking
    - Developer runs *paige ds to apply changes

  versioning:
    strategy: semantic-release
    changelog: content/changelog.mdx
    trigger: conventional commits
EOF

# Create README
cat > README.md << EOF
# CurryDash Documentation

Official documentation for the CurryDash platform.

## View Documentation

**Live Site:** https://$DOMAIN

## Local Development

\`\`\`bash
cd docs
npm install
npm run dev
\`\`\`

Visit http://localhost:3000

## Platform Repositories

This documentation repository integrates with:

- **Backend:** [$BACKEND_REPO](https://github.com/$ORG_NAME/$BACKEND_REPO)
- **Frontend:** [$MOBILE_REPO](https://github.com/$ORG_NAME/$MOBILE_REPO)

## Cross-Repository Integration

Documentation automatically updates when code is pushed to either repository:

1. Developer commits with story ID: \`feat: add feature (STORY-123)\`
2. Source repo workflow triggers this repo via \`repository_dispatch\`
3. Change spec created in \`.doc-changes/STORY-123.yaml\`
4. GitHub issue created for tracking
5. Developer runs \`*paige ds\` to apply changes
6. Documentation updated and versioned via semantic-release

## BMAD Integration

### Workflows

- \`*paige di\` - Initialize documentation structure
- \`*paige da STORY-123\` - Analyze story for documentation needs
- \`*paige ds\` - Sync pending documentation changes

### Files

- \`planning_artifacts/workflows/\` - BMAD workflow definitions
- \`.doc-changes/\` - Pending documentation changes
- \`.doc-manifest.yaml\` - Documentation tracking

## Deployment

Automatic deployment via GitHub Actions on push to \`main\`.

## License

MIT
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
docs/node_modules/

# Next.js
docs/.next/
docs/out/

# Environment
.env
.env.local

# Misc
.DS_Store
*.log

# IDE
.idea/
.vscode/

# BMAD
.doc-changes/*.yaml
!.doc-changes/.gitkeep
EOF

mkdir -p .doc-changes
touch .doc-changes/.gitkeep

echo ""
echo "Documentation repository setup complete!"
echo ""
echo "Structure created:"
echo "   docs/                          (Nextra documentation site)"
echo "   planning_artifacts/            (BMAD workflows & configs)"
echo "   .github/workflows/             (Cross-repo sync)"
echo "   README.md"
echo "   .gitignore"
echo ""
echo "Next steps:"
echo ""
echo "   1. Install dependencies:"
echo "      cd docs"
echo "      npm install"
echo ""
echo "   2. Test locally:"
echo "      npm run dev"
echo ""
echo "   3. Initialize git (if needed):"
echo "      git add ."
echo "      git commit -m 'feat: initialize CurryDash documentation'"
echo ""
echo "   4. Push to GitHub:"
echo "      git remote add origin https://github.com/$ORG_NAME/$DOCS_REPO.git"
echo "      git push -u origin main"
echo ""
echo "   5. Deploy to Vercel:"
echo "      cd docs"
echo "      npm i -g vercel"
echo "      vercel --prod"
echo ""
