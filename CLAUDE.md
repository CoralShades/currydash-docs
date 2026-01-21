# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Critical : Always use AskUserQuestion Tool when you want to clarify, interview or ask questions from the user.

## Project Overview

CurryDash-docs is a multi-repository documentation platform for the CurryDash food delivery service. It uses:
- **Nextra 4** with Next.js 15 App Router for documentation
- **Pagefind** for full-text search
- **Semantic Release** for automated versioning
- **BMAD Method** workflows for documentation generation from code changes

This repository receives automatic documentation updates from two code repositories:
- `currydash-admin-vendor-portal` (Laravel backend)
- `currydash-mobile` (Flutter mobile/web apps)

## Development Commands

All commands should be run from the `bmad-docops/templates/` directory where the Next.js project lives:

```bash
cd bmad-docops/templates

npm install          # Install dependencies
npm run dev          # Start dev server with Turbopack (http://localhost:3000)
npm run build        # Production build
npm run lint         # Run Next.js linting
npm run docs:build   # Build docs + generate Pagefind search index
```

## Architecture

```
currydash-docs/
├── bmad-docops/templates/     # The actual Nextra documentation site
│   ├── content/               # MDX documentation files
│   ├── app/                   # Next.js App Router
│   │   └── api/docs/          # Headless API endpoints
│   ├── package.json           # npm scripts and dependencies
│   └── next.config.mjs        # Nextra/Next.js configuration
├── _bmad/                     # BMAD Method resources (agents, workflows, modules)
├── _bmad-output/              # Generated implementation artifacts
├── SETUP_GUIDE.md             # Multi-repo integration setup
└── QUICK_REFERENCE.md         # Command quick reference
```

## Cross-Repository Documentation Flow

1. Developer commits to backend/mobile repo with story ID in commit message (e.g., `Stories: STORY-123`)
2. GitHub Actions in source repo triggers `notify-docs.yml`
3. This repo's `sync-from-repos.yml` receives the trigger
4. Change spec created in `.doc-changes/STORY-123.yaml`
5. Documentation updates applied via BMAD workflow commands

## BMAD Workflow Commands

| Command | Purpose |
|---------|---------|
| `*paige di` | Initialize docs from planning artifacts (after Phase 3) |
| `*paige da STORY-123` | Analyze completed story for documentation needs |
| `*paige ds` | Apply all pending documentation changes |

## Headless API Endpoints

- `GET /api/docs` - Navigation structure/page map
- `GET /api/docs/[...slug]` - Compiled MDX content for a page
- `POST /api/docs/search` - Search results

## Commit Message Format

This repo uses conventional commits for semantic-release:

```bash
# Feature (minor version bump)
git commit -m "feat(api): add authentication endpoints

Stories: STORY-123"

# Fix (patch version bump)
git commit -m "fix(docs): correct API example

Stories: STORY-124"

# Breaking change (major version bump)
git commit -m "feat(api)!: redesign endpoint structure

BREAKING CHANGE: All endpoints now use /v2/.

Stories: STORY-125"
```
