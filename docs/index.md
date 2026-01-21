# CurryDash Documentation - Project Knowledge Index

## Project Overview

- **Type:** Monolith (Web Documentation Platform)
- **Primary Language:** TypeScript
- **Architecture:** Component-based with Next.js App Router

## Quick Reference

- **Tech Stack:** Next.js 16.1.4 + Nextra 4.0.0 + Tailwind CSS 4.0.0
- **Entry Point:** `docs/app/layout.tsx`
- **Architecture Pattern:** Component-based documentation platform with Headless API

## Generated Documentation

- [Project Overview](./project-overview.md) - High-level project summary
- [Architecture](./architecture.md) - Technical architecture details
- [Source Tree Analysis](./source-tree-analysis.md) - Annotated directory structure
- [Development Guide](./development-guide.md) - Setup and development instructions

## Existing Documentation

### Root Level

- [README.md](../README.md) - Project overview and quick start
- [CLAUDE.md](../CLAUDE.md) - AI assistant instructions
- [QUICK_REFERENCE.md](../QUICK_REFERENCE.md) - Command reference
- [SETUP_GUIDE.md](../SETUP_GUIDE.md) - Multi-repo integration setup
- [content-mapping.md](../content-mapping.md) - Content organization guide

### BMAD DocOps

- [bmad-docops/README.md](../bmad-docops/README.md) - DocOps module overview
- [bmad-docops/QUICK-REFERENCE.md](../bmad-docops/QUICK-REFERENCE.md) - DocOps quick reference

### CI/CD Configuration

- [.github/workflows/docs.yml](../.github/workflows/docs.yml) - Build, validate, release, deploy
- [.github/workflows/sync-from-repos.yml](../.github/workflows/sync-from-repos.yml) - Cross-repo documentation sync

### Legacy Documentation

- [docs-legacy/Admin-Seller-Portal/](../docs-legacy/Admin-Seller-Portal/) - Backend architecture and PRD (Laravel)
- [docs-legacy/UserApp-Mobile_Web-Flutter/](../docs-legacy/UserApp-Mobile_Web-Flutter/) - Frontend PRD and GCP deployment (Flutter)
- [docs-legacy/brand-strategy/](../docs-legacy/brand-strategy/) - Brand guidelines

## Content Structure

The active documentation site (`docs/content/`) is organized by audience:

### Developers

| Section | Content |
|---------|---------|
| `/developers/backend/` | Laravel backend architecture, requirements, API docs |
| `/developers/frontend/` | Flutter frontend requirements, state management |
| `/developers/deployment/` | CI/CD, Docker, GCP deployment guides |
| `/developers/brand/` | Brand guidelines and color system |

### Vendors

| Section | Content |
|---------|---------|
| `/vendors/getting-started/` | Onboarding guides |
| `/vendors/menu-management/` | Menu editing |
| `/vendors/orders/` | Order management |
| `/vendors/payments/` | Payment processing |
| `/vendors/analytics/` | Sales analytics |

### Admins

| Section | Content |
|---------|---------|
| `/admins/getting-started/` | Admin onboarding |
| `/admins/user-management/` | User administration |
| `/admins/vendor-management/` | Vendor oversight |
| `/admins/analytics/` | Platform analytics |
| `/admins/settings/` | Configuration |

### API Reference

| Section | Content |
|---------|---------|
| `/api/backend/` | Backend API documentation |
| `/api/frontend/` | Frontend API documentation |

## Integration Points

### Source Repositories

| Repository | Type | Mapped Sections |
|------------|------|-----------------|
| CurryDash-Admin-Seller-Portal | Laravel | `/developers/backend`, `/api/backend`, `/admins`, `/vendors` |
| CurryDash-UserApp-Mobile_Web-Flutter | Flutter | `/developers/frontend`, `/api/frontend` |

### BMAD Workflows

| Command | Purpose |
|---------|---------|
| `*paige di` | Initialize docs from planning artifacts |
| `*paige da STORY-123` | Analyze story for documentation needs |
| `*paige ds` | Apply pending documentation changes |

## Getting Started

### For Developers

1. Review [Architecture](./architecture.md) for technical overview
2. Follow [Development Guide](./development-guide.md) for setup
3. Check [Source Tree Analysis](./source-tree-analysis.md) for project structure

### For Documentation Contributors

1. Create MDX files in `docs/content/`
2. Follow the audience-based folder structure
3. Use conventional commits for changes
4. Run `npm run dev` to preview locally

### For AI-Assisted Development

When creating brownfield PRDs or features, reference:
- This index as the primary entry point
- Architecture docs for technical context
- Source tree analysis for code locations

---

## Scan Metadata

| Attribute | Value |
|-----------|-------|
| Generated | 2026-01-21 |
| Workflow | document-project v1.2.0 |
| Scan Level | Quick Scan |
| Mode | Initial Scan |
| Files Generated | 5 |

---

*This is your primary entry point for AI-assisted development with CurryDash Documentation.*
