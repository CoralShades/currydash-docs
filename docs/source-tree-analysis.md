# CurryDash Documentation - Source Tree Analysis

## Project Structure Overview

This document provides an annotated directory tree for the CurryDash Documentation platform, highlighting critical folders, entry points, and integration points.

## Directory Tree

```
currydash-docs/                      # Project root
├── .agent/                          # AI agent configurations
│   └── workflows/bmad/              # BMAD workflow definitions
├── .claude/                         # Claude Code configuration
│   └── commands/bmad/               # BMAD slash commands
├── .cursor/                         # Cursor IDE configuration
│   └── commands/bmad/               # IDE command integration
├── .doc-changes/                    # Pending documentation changes from code repos
├── .gemini/                         # Gemini AI configuration
├── .github/                         # GitHub configuration
│   └── workflows/                   # CI/CD workflows
│       ├── docs.yml                 # Build, validate, release, deploy
│       └── sync-from-repos.yml      # Cross-repo documentation sync
│
├── _bmad/                           # BMAD Method installation (v6.0.0-alpha)
│   ├── _config/                     # User configuration
│   │   ├── agents/                  # Agent customizations
│   │   ├── custom/                  # Custom extensions
│   │   └── ides/                    # IDE-specific settings
│   ├── _memory/                     # Agent memory/state
│   ├── bmb/                         # BMAD Builder Module
│   │   ├── agents/                  # Builder agents
│   │   └── workflows/               # Builder workflows
│   ├── bmm/                         # BMAD Method Module
│   │   ├── agents/                  # Method agents (pm, dev, architect, etc.)
│   │   ├── data/                    # CSV data files
│   │   ├── teams/                   # Team configurations
│   │   ├── testarch/                # Test architecture workflows
│   │   └── workflows/               # Core method workflows
│   ├── cis/                         # Creative Intelligence Suite
│   │   ├── agents/                  # Creative agents
│   │   ├── teams/                   # Creative teams
│   │   └── workflows/               # Creative workflows
│   └── core/                        # BMAD Core
│       ├── agents/                  # Core agents
│       ├── resources/               # Shared resources
│       ├── tasks/                   # Task definitions
│       └── workflows/               # Core workflows (party-mode, etc.)
│
├── _bmad-output/                    # BMAD workflow outputs
│   ├── implementation-artifacts/    # Generated implementation files
│   └── planning-artifacts/          # PRDs, architecture docs, epics
│
├── bmad-docops/                     # Documentation operations module
│   ├── module/                      # Module definition
│   ├── scripts/                     # Helper scripts
│   ├── templates/                   # Reference Next.js templates
│   │   ├── .github/                 # Template CI/CD
│   │   ├── app/                     # Template App Router
│   │   └── content/                 # Template MDX structure
│   └── workflows/                   # DocOps workflows
│
├── docs/                            # ★ ACTIVE DOCUMENTATION SITE ★
│   ├── .doc-manifest.yaml           # Documentation tracking manifest
│   ├── .releaserc.json              # Semantic release configuration
│   ├── .next/                       # Next.js build output (generated)
│   ├── app/                         # ★ ENTRY POINT - Next.js App Router
│   │   ├── layout.tsx               # Root layout component
│   │   ├── loading.tsx              # Loading state component
│   │   ├── not-found.tsx            # 404 handling
│   │   ├── [[...mdxPath]]/          # Dynamic MDX page routing
│   │   │   └── page.tsx             # MDX content renderer
│   │   └── api/                     # Headless API endpoints
│   │       └── docs/                # Documentation API
│   │           ├── route.ts         # Navigation/page map API
│   │           └── [...slug]/       # Dynamic content API
│   │               └── route.ts     # Content delivery endpoint
│   ├── content/                     # ★ DOCUMENTATION CONTENT (MDX)
│   │   ├── index.mdx                # Homepage
│   │   ├── changelog.mdx            # Changelog
│   │   ├── getting-started/         # Quick start guides
│   │   ├── concepts/                # Platform concepts
│   │   ├── guides/                  # How-to guides
│   │   ├── developers/              # Developer documentation
│   │   │   ├── backend/             # Laravel/PHP backend docs
│   │   │   │   ├── architecture/    # Backend architecture (20 files)
│   │   │   │   ├── requirements/    # PRD/requirements (10 files)
│   │   │   │   ├── api/             # API documentation
│   │   │   │   ├── database/        # Database schemas
│   │   │   │   ├── epics/           # Implementation epics
│   │   │   │   └── laravel/         # Laravel-specific docs
│   │   │   ├── frontend/            # Flutter frontend docs
│   │   │   │   ├── requirements/    # Frontend PRD (10 files)
│   │   │   │   ├── api-integration/ # API integration guides
│   │   │   │   ├── epics/           # Frontend epics
│   │   │   │   ├── flutter/         # Flutter-specific docs
│   │   │   │   └── state-management/# State management patterns
│   │   │   ├── deployment/          # Deployment documentation
│   │   │   │   ├── ci-cd/           # CI/CD setup
│   │   │   │   ├── docker/          # Containerization
│   │   │   │   ├── gcp/             # Google Cloud Platform
│   │   │   │   ├── guides/          # Deployment guides
│   │   │   │   └── workflows/       # Deployment workflows
│   │   │   └── brand/               # Brand guidelines
│   │   ├── admins/                  # Admin documentation
│   │   │   ├── getting-started/     # Admin onboarding
│   │   │   ├── analytics/           # Analytics dashboard
│   │   │   ├── platform/            # Platform settings
│   │   │   ├── settings/            # Configuration
│   │   │   ├── user-management/     # User administration
│   │   │   └── vendor-management/   # Vendor oversight
│   │   ├── vendors/                 # Vendor documentation
│   │   │   ├── getting-started/     # Vendor onboarding
│   │   │   ├── analytics/           # Sales analytics
│   │   │   ├── menu-management/     # Menu editing
│   │   │   ├── orders/              # Order management
│   │   │   ├── payments/            # Payment processing
│   │   │   └── seller-portal/       # Seller portal guide
│   │   └── api/                     # API reference
│   │       ├── backend/             # Backend API docs
│   │       └── frontend/            # Frontend API docs
│   ├── public/                      # Static assets
│   │   └── code-templates/          # Downloadable templates
│   ├── mdx-components.tsx           # Custom MDX component overrides
│   ├── next.config.mjs              # Next.js + Nextra configuration
│   ├── postcss.config.mjs           # PostCSS (Tailwind v4)
│   ├── tsconfig.json                # TypeScript configuration
│   └── package.json                 # Dependencies and scripts
│
├── docs-legacy/                     # Legacy documentation (reference)
│   ├── Admin-Seller-Portal/         # Laravel backend docs
│   │   ├── architecture/            # Architecture documentation
│   │   └── prd/                     # Product requirements
│   ├── UserApp-Mobile_Web-Flutter/  # Flutter frontend docs
│   │   ├── gcp-deployment-framework/# GCP deployment templates
│   │   └── prd/                     # Product requirements
│   └── brand-strategy/              # Brand guidelines
│
├── logs/                            # Development logs
├── planning_artifacts/              # Planning documentation
│   ├── modules/                     # Module planning
│   └── workflows/                   # Workflow planning
│
├── CLAUDE.md                        # Claude Code instructions
├── README.md                        # Project overview
├── QUICK_REFERENCE.md               # Command reference
├── SETUP_GUIDE.md                   # Setup instructions
└── content-mapping.md               # Content organization guide
```

## Critical Folders

| Folder | Purpose | Entry Point |
|--------|---------|-------------|
| `docs/app/` | Next.js application code | `layout.tsx` |
| `docs/content/` | MDX documentation content | `index.mdx` |
| `docs/app/api/docs/` | Headless API endpoints | `route.ts` |
| `.github/workflows/` | CI/CD automation | `docs.yml` |
| `_bmad/` | BMAD Method installation | `bmm/config.yaml` |
| `_bmad-output/` | Generated artifacts | N/A |

## Content Audiences

The documentation is organized by target audience:

| Audience | Path | Description |
|----------|------|-------------|
| Developers | `/developers/` | Technical implementation guides |
| Vendors | `/vendors/` | Restaurant/seller portal usage |
| Admins | `/admins/` | Platform administration |
| API Users | `/api/` | API reference documentation |

## Integration Points

### Cross-Repository Integration

```
┌─────────────────────────────┐      repository_dispatch
│ CurryDash-Admin-Seller-Portal│ ─────────────────────────┐
│ (Laravel Backend)           │                          │
└─────────────────────────────┘                          ▼
                                              ┌────────────────────┐
┌─────────────────────────────┐              │  currydash-docs    │
│ CurryDash-UserApp-Mobile_Web│ ────────────▶│  (Documentation)   │
│ (Flutter Frontend)          │              │                    │
└─────────────────────────────┘              │ sync-from-repos.yml│
                                              └────────────────────┘
```

### BMAD Workflow Integration

- **`*paige di`** - Initialize documentation structure
- **`*paige da <STORY>`** - Analyze story for documentation needs
- **`*paige ds`** - Sync pending documentation changes

## Key Files

| File | Purpose |
|------|---------|
| `docs/next.config.mjs` | Nextra and Next.js configuration |
| `docs/.doc-manifest.yaml` | Documentation tracking state |
| `docs/.releaserc.json` | Semantic release configuration |
| `.github/workflows/docs.yml` | Main CI/CD pipeline |
| `.github/workflows/sync-from-repos.yml` | Cross-repo sync handler |
| `CLAUDE.md` | AI assistant instructions |

---

*Generated by BMAD Document Project Workflow v1.2.0*
