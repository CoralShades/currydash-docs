# CurryDash Documentation - Architecture Overview

## Executive Summary

CurryDash Documentation is a multi-repository documentation platform built with Next.js 16 and Nextra 4. It serves as the central documentation hub for the CurryDash food delivery platform, aggregating documentation from the backend (Laravel) and frontend (Flutter) repositories.

**Key Characteristics:**
- **Type:** Documentation Platform (Web)
- **Framework:** Next.js 16.1.4 + Nextra 4.0.0
- **Architecture:** Component-based with App Router
- **Deployment:** GitHub Pages (static export)
- **Automation:** Semantic Release + Cross-repo sync

## Technology Stack

| Category | Technology | Version | Purpose |
|----------|------------|---------|---------|
| Framework | Next.js | 16.1.4 | React framework with App Router |
| Documentation | Nextra | 4.0.0 | Documentation theme for Next.js |
| UI Library | React | 18.2.0 | Component-based UI |
| Language | TypeScript | 5.3.0 | Type-safe JavaScript |
| Styling | Tailwind CSS | 4.0.0 | Utility-first CSS framework |
| Search | Pagefind | 1.0.0 | Rust-powered static search |
| Release | Semantic Release | 22.0.0 | Automated versioning |
| Commits | Commitlint | 18.4.0 | Conventional commit enforcement |

## Architecture Pattern

### Component-Based Documentation Platform

```
┌─────────────────────────────────────────────────────────────────┐
│                        Next.js App Router                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────┐   ┌─────────────┐   ┌─────────────────────┐   │
│  │   Layout    │   │   Page.tsx  │   │   API Routes        │   │
│  │   (Root)    │   │  (MDX Path) │   │  /api/docs/...      │   │
│  └─────────────┘   └─────────────┘   └─────────────────────┘   │
│         │                 │                    │                │
│         ▼                 ▼                    ▼                │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                    Nextra Theme                          │   │
│  │  - Sidebar navigation                                    │   │
│  │  - Table of contents                                     │   │
│  │  - Search integration                                    │   │
│  │  - MDX rendering                                         │   │
│  └─────────────────────────────────────────────────────────┘   │
│                             │                                   │
│                             ▼                                   │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                    Content Layer                         │   │
│  │  /content/                                               │   │
│  │  ├── developers/    (Technical documentation)            │   │
│  │  ├── vendors/       (Seller portal guides)               │   │
│  │  ├── admins/        (Admin documentation)                │   │
│  │  └── api/           (API reference)                      │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Data Flow

```
┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐
│   Source Repos   │    │   Sync Workflow  │    │   Documentation  │
│                  │    │                  │    │                  │
│ Backend (Laravel)│───▶│ repository_      │───▶│ .doc-changes/    │
│ Mobile (Flutter) │    │ dispatch event   │    │ STORY-XXX.yaml   │
└──────────────────┘    └──────────────────┘    └──────────────────┘
                                                         │
                                                         ▼
┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐
│   Built Site     │◀───│   CI/CD          │◀───│   BMAD Workflow  │
│                  │    │                  │    │                  │
│ GitHub Pages     │    │ Build, Validate  │    │ *paige ds        │
│ (Static Export)  │    │ Release, Deploy  │    │ (Apply changes)  │
└──────────────────┘    └──────────────────┘    └──────────────────┘
```

## Component Overview

### App Components

| Component | Path | Purpose |
|-----------|------|---------|
| Root Layout | `app/layout.tsx` | Global layout wrapper |
| MDX Page | `app/[[...mdxPath]]/page.tsx` | Dynamic MDX routing |
| Loading | `app/loading.tsx` | Loading state UI |
| Not Found | `app/not-found.tsx` | 404 error handling |

### API Endpoints

| Endpoint | Path | Purpose |
|----------|------|---------|
| Navigation | `GET /api/docs` | Page map and navigation structure |
| Content | `GET /api/docs/[...slug]` | Compiled MDX content delivery |

### Content Structure

```
content/
├── index.mdx                 # Homepage
├── changelog.mdx             # Version changelog
├── getting-started/          # Onboarding guides
├── concepts/                 # Platform concepts
├── guides/                   # How-to guides
├── developers/               # Developer documentation
│   ├── backend/              # Laravel backend
│   │   ├── architecture/     # 20 architecture docs
│   │   ├── requirements/     # PRD documents
│   │   ├── api/              # API docs
│   │   └── database/         # Schema docs
│   ├── frontend/             # Flutter frontend
│   │   ├── requirements/     # Frontend PRD
│   │   └── state-management/ # State patterns
│   └── deployment/           # DevOps guides
├── admins/                   # Admin documentation
├── vendors/                  # Vendor documentation
└── api/                      # API reference
```

## Deployment Architecture

### CI/CD Pipeline

```yaml
Workflow: docs.yml
├── build:
│   ├── Checkout
│   ├── Setup Node.js 20
│   ├── npm ci
│   └── npm run docs:build
├── validate:
│   └── Lychee link checking
├── release:
│   └── semantic-release
└── deploy:
    └── GitHub Pages (static export)
```

### Deployment Targets

| Environment | Trigger | URL |
|-------------|---------|-----|
| Production | Push to `main` | https://docs.currydash.com |
| Preview | Pull Request | PR-specific URL |

## Security Considerations

1. **API CORS** - Headless API endpoints configured with permissive CORS for cross-origin access
2. **No Secrets in Repo** - Environment variables handled via GitHub Secrets
3. **Link Validation** - Automated broken link detection in CI
4. **Dependency Scanning** - npm audit in CI pipeline

## Performance Characteristics

| Metric | Value | Notes |
|--------|-------|-------|
| Build Time | ~30-60s | Depends on content volume |
| Bundle Size | Minimal | Static MDX compilation |
| Search | Client-side | Pagefind (Rust-powered) |
| CDN | GitHub Pages | Global edge distribution |

## Integration Points

### Source Repositories

| Repository | Type | Sections |
|------------|------|----------|
| CurryDash-Admin-Seller-Portal | Laravel Backend | `/developers/backend`, `/api/backend`, `/admins`, `/vendors` |
| CurryDash-UserApp-Mobile_Web-Flutter | Flutter Frontend | `/developers/frontend`, `/api/frontend` |

### BMAD Method Integration

The documentation platform integrates with BMAD Method v6.0.0 for:
- Documentation initialization from planning artifacts
- Story-based documentation analysis
- Automated documentation synchronization

## Development Considerations

### Adding New Documentation

1. Create MDX files in appropriate `/content/` subdirectory
2. Follow existing frontmatter conventions
3. Use custom MDX components where needed
4. Test locally with `npm run dev`

### Extending the Platform

1. **Custom Components** - Edit `mdx-components.tsx`
2. **Theme Customization** - Modify Nextra theme config
3. **API Extensions** - Add routes in `app/api/`
4. **Build Plugins** - Extend `next.config.mjs`

---

*Generated by BMAD Document Project Workflow v1.2.0*
