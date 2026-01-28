# Task Plan: Fix Sidebar CSS Visibility + Enterprise-Grade UI/UX Audit

## Goal
Fix the sidebar navigation visibility on desktop, verify all auto-claude specs (002-010) are actually applied and working, and ensure the UI/UX meets the enterprise-grade standards defined in the PRD and UX Design Specification.

## Current Phase
Phase 1

## Phases

### Phase 1: Discovery & Current State Audit
- [ ] Explore Nextra site structure (app/, content/, styles)
- [ ] Read all auto-claude spec summaries (002-010)
- [ ] Identify CSS files affecting sidebar/TOC visibility
- [ ] Start dev server and take baseline screenshots via agent-browser
- [ ] Document current state vs PRD/UX spec expectations
- **Status:** in_progress

### Phase 2: Gap Analysis & Root Cause Identification
- [ ] Cross-check current UI against PRD acceptance criteria
- [ ] Cross-check against UX design specification requirements
- [ ] Identify which auto-claude specs are NOT actually applied
- [ ] Root-cause the sidebar invisibility issue
- [ ] Document all gaps in findings.md
- **Status:** pending

### Phase 3: Implementation - Critical Fixes
- [ ] Fix sidebar CSS visibility on desktop (P0)
- [ ] Fix TOC "On This Page" visibility (P0)
- [ ] Fix Tailwind v4 CSS compatibility issues (P0)
- [ ] Verify dark mode toggle functional (P1)
- **Status:** pending

### Phase 4: Implementation - Enterprise Polish
- [ ] Ensure responsive breakpoints match UX spec (mobile/tablet/desktop)
- [ ] Verify code block syntax highlighting and copy-to-clipboard
- [ ] Validate navigation structure and links
- **Status:** pending

### Phase 5: Testing & Verification
- [ ] Take screenshots at desktop (1024px+), tablet (768-1023px), mobile (<768px)
- [ ] Verify sidebar visible on desktop
- [ ] Verify TOC visible on desktop
- [ ] Verify dark mode toggle works
- [ ] Verify all navigation links clickable
- [ ] Cross-check screenshots against UX spec layout diagram
- **Status:** pending

### Phase 6: Final Report & Delivery
- [ ] Update progress.md with all test results
- [ ] Summarize all changes made
- [ ] Deliver final verification screenshots
- **Status:** pending

## Key Questions
1. Which CSS files control sidebar visibility in Nextra 4?
2. Are the auto-claude specs actually merged into the current main branch code?
3. Is Tailwind v4 CSS conflicting with Nextra theme styles?
4. What is the exact layout structure expected (sidebar 240px + content 720px + TOC 200px)?

## Decisions Made
| Decision | Rationale |
|----------|-----------|
| Start with agent-browser screenshots | Need visual baseline before code analysis |
| Fix sidebar first | P0 blocker per PRD - blocks all usability |

## Errors Encountered
| Error | Attempt | Resolution |
|-------|---------|------------|
|       | 1       |            |

## Notes
- All specs merged to main EXCEPT 007-legacy-documentation-migration
- PRD specifies: Sidebar/TOC 100% visible on desktop as Technical Success metric
- UX spec layout: Sidebar 240px + Content 720px + TOC 200px (desktop >1024px)
- Tech stack: Next.js 15 + Nextra 4 + Tailwind CSS v4
