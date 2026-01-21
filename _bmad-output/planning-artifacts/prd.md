---
stepsCompleted:
  - step-01-init
  - step-02-discovery
  - step-03-success
  - step-04-journeys
  - step-05-domain-skipped
  - step-06-innovation-skipped
  - step-07-project-type
  - step-08-scoping
  - step-09-functional
  - step-10-nonfunctional
  - step-11-polish
classification:
  projectType: web_app
  projectSubtype: documentation_platform
  domain: general
  domainSubtype: developer_documentation
  complexity: high
  projectContext: brownfield
  qualityTarget: enterprise-grade
  primaryGoal: full_platform_launch
  audienceStrategy: multi_audience_equal
inputDocuments:
  - path: '_bmad-output/analysis/currydash-docs-comprehensive-analysis-2026-01-21.md'
    type: analysis
    lines: 1086
    description: 'Comprehensive UI/UX Review, Gap Analysis, Architecture Design'
  - path: 'logs/context.md'
    type: project-log
    description: 'AI Agent Context - Tech stack, project structure, current issues'
  - path: 'logs/progress.md'
    type: project-log
    description: 'Progress log - Tailwind v4 upgrade, styling, navigation fixes'
  - path: 'logs/errors.md'
    type: project-log
    description: 'Errors log - Resolved and current issues'
  - path: 'logs/next-plan.md'
    type: project-log
    description: 'Next steps plan - Priorities for sidebar, TOC, styling'
  - path: 'QUICK_REFERENCE.md'
    type: reference
    description: 'Multi-repo setup commands, BMAD workflows, commit format'
  - path: 'migrate-existing-docs.sh'
    type: script
    description: 'Migration script for legacy docs to Nextra structure'
  - path: 'integrate-backend.sh'
    type: script
    description: 'GitHub Actions integration for backend repo'
  - path: 'integrate-mobile.sh'
    type: script
    description: 'GitHub Actions integration for mobile repo'
  - path: 'setup-docs-repository-adapted.sh'
    type: script
    description: 'Full docs repo setup with multi-audience structure'
documentCounts:
  analysis: 1
  projectLogs: 4
  referenceScripts: 4
  legacyDocs: 61
workflowType: 'prd'
projectType: 'brownfield'
---

# Product Requirements Document - currydash-docs

**Author:** Demi
**Date:** 2026-01-21
**Status:** Draft
**Version:** 1.0

---

## Executive Summary

### Product Vision

CurryDash Docs is an enterprise-grade documentation platform serving the CurryDash food delivery ecosystem. It provides unified, always-current documentation for five distinct audiences: restaurant vendors, backend developers, mobile developers, platform administrators, and customers.

### Core Differentiator

**Cross-Repository Automation:** Documentation automatically updates when code changes in the backend (`currydash-admin-vendor-portal`) or mobile (`currydash-mobile`) repositories. Developers commit code with story IDs, and the docs platform generates change specs and applies updates—eliminating the "docs are outdated" problem that plagues most platforms.

### Current State (Brownfield Context)

The documentation platform exists but has critical blockers:
- **UI Broken:** Sidebar and TOC not visible on desktop (CSS/layout issue)
- **Content Scattered:** 61 legacy docs need migration to proper structure
- **No Automation:** Cross-repo triggers not yet implemented
- **Single Audience:** Current navigation doesn't serve 5 distinct user types

### Target State

A polished, enterprise-quality documentation site matching the visual and functional standards of Stripe, Vercel, and SvelteFlow documentation. Users find answers in under 30 seconds, vendors onboard without support calls, and documentation stays current automatically.

### Tech Stack

| Component | Technology |
|-----------|------------|
| Framework | Next.js 16 + Nextra 4 (App Router) |
| Styling | Tailwind CSS v4 |
| Search | Pagefind (Rust-powered) |
| Versioning | Semantic Release |
| Automation | GitHub Actions (repository_dispatch) |

---

## Success Criteria

### User Success

**Primary Success Moment:** Users find answers in under 30 seconds and are impressed by both the quality AND functionality.

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Time to Answer** | <30 seconds | Search → relevant result → answer found |
| **Self-Service Rate** | 90%+ | Users resolve issues without support contact |
| **Cross-Repo Accuracy** | 100% sync | Backend/mobile docs reflect latest code |
| **Visual Quality Score** | Matches Stripe/Vercel | Subjective benchmark against reference sites |

**User Delight Indicators:**
- Developers say "this is actually good documentation"
- Vendors complete onboarding without calling support
- Users share docs links as answers (not workarounds)

### Business Success

| Metric | Target | Rationale |
|--------|--------|-----------|
| **Developer Onboarding** | Days, not weeks | New devs productive with backend/mobile repos faster |
| **Vendor Self-Sufficiency** | 80%+ self-serve | Restaurant owners manage menus/orders independently |
| **Support Ticket Reduction** | 50% fewer "how to" tickets | Docs answer common questions |
| **Platform Credibility** | Enterprise perception | Docs quality signals CurryDash is serious |

### Technical Success

| Metric | Target | Rationale |
|--------|--------|-----------|
| **Sidebar/TOC** | 100% visible on desktop | Critical UI fix |
| **Build Time** | <60 seconds | Fast iteration |
| **Lighthouse Score** | 90+ all categories | Performance, accessibility, SEO |
| **Search Latency** | <100ms | Pagefind optimization |
| **Cross-Repo Sync** | Automated via GitHub Actions | No manual doc updates |

### Measurable Outcomes

1. **Week 1:** Sidebar and TOC visible, enterprise CSS working
2. **Week 2:** Multi-audience navigation live, core content migrated
3. **Week 3:** All 61 docs migrated, cross-repo integration active
4. **Week 4:** Polish complete, Lighthouse 90+, launch-ready

---

## Product Scope

This section provides a high-level scope overview. For detailed week-by-week breakdown, priorities, and risk mitigation, see **Project Scoping & Phased Development**.

### MVP Summary (4-Week Delivery)

| Category | Key Deliverables |
|----------|-----------------|
| **UI/UX Foundation** | Fix sidebar/TOC visibility, enterprise styling, dark mode |
| **Multi-Audience** | 5 audience sections with tailored navigation |
| **Content Migration** | 61 legacy docs migrated with proper _meta.js patterns |
| **Cross-Repo Automation** | GitHub Actions triggers, .doc-changes/ specs, semantic versioning |
| **Search & Discovery** | Pagefind optimization, llms.txt, breadcrumbs |

### Post-MVP Vision

- AI-powered search (Inkeep/Algolia)
- Version selector for API docs
- Interactive API playground
- MCP server for AI assistants

---

## User Journeys

### Journey 1: Vendor Self-Service (Priority)

**Persona: Priya - Owner of "Spice Garden" Restaurant**

**Situation:** Priya runs a small Sri Lankan restaurant in Melbourne. She's tech-comfortable but busy - she can't spend hours learning a new system. She just signed up for CurryDash and needs to get her restaurant live.

**Opening Scene:**
Priya receives her CurryDash vendor credentials via email. She clicks to the Seller Portal but feels overwhelmed - where does she start? She's worried she'll miss something important and look unprofessional when customers see her listing.

**Rising Action:**
1. Priya lands on **docs.currydash.com** and immediately sees "I'm a restaurant vendor" card
2. Clicks through to `/vendors/getting-started/onboarding`
3. Finds a **step-by-step checklist**: Profile setup → Menu creation → Curry Pack configuration → Payment setup → Go live
4. Each step has clear screenshots showing exactly what to click
5. She completes profile in 10 minutes, following the visual guide

**Climax:**
Priya discovers the **Curry Pack Builder** documentation - CurryDash's unique family meal bundles. She understands how to create compelling packages that differentiate her from competitors. She builds her first Curry Pack in under 5 minutes.

**Resolution:**
Priya's restaurant is live within 2 hours of starting. She didn't call support once. When she gets her first order, she knows exactly how to accept it because she already read the order management guide. She texts her husband: "This was actually easy!"

**Journey Reveals:**
- Onboarding checklist documentation
- Visual step-by-step guides with screenshots
- Curry Pack concept explanation
- Quick-reference cards for common tasks

---

### Journey 2: New Backend Developer Onboarding

**Persona: Marcus - Senior PHP Developer, New Hire**

**Situation:** Marcus joined CurryDash as a backend developer. He's experienced with Laravel but unfamiliar with this specific codebase. His first task: add a new field to the restaurant API.

**Opening Scene:**
Marcus clones the `currydash-admin-vendor-portal` repo. The README points him to docs.currydash.com. He needs to understand the architecture before making changes.

**Rising Action:**
1. Marcus navigates to `/developers/backend` and finds the architecture overview
2. He discovers the **modular architecture** docs explaining nWidart modules
3. Reads about the **CentralLogics orchestration layer** (CUR pattern)
4. Finds the API specification showing existing endpoints
5. Uses search to find "restaurant" - instantly gets relevant results

**Climax:**
Marcus finds the **Restaurant System Architecture** doc that explains exactly where restaurant data flows. He understands the repository pattern and where to add his new field without breaking existing functionality.

**Resolution:**
Marcus submits his PR the same day. His commit message includes `Stories: STORY-456`, and he notices the docs repo automatically creates a change spec. He's impressed by how well-documented the codebase is.

**Journey Reveals:**
- Architecture overview and diagrams
- Module structure documentation
- Code patterns and conventions
- Search that works instantly
- Cross-repo integration documentation

---

### Journey 3: Mobile Developer API Integration

**Persona: Aisha - Flutter Developer**

**Situation:** Aisha is building the order tracking feature in the CurryDash mobile app. She needs to integrate with the backend API for real-time order status updates.

**Opening Scene:**
Aisha is in VS Code with the Flutter project open. She needs to know the exact API endpoint format, authentication headers, and response structure for order tracking.

**Rising Action:**
1. Aisha opens `/api/backend` and finds the Orders section
2. She sees code examples in **multiple languages** including Dart
3. Clicks through to `GET /v1/orders/{id}/status` endpoint
4. Finds complete request/response schemas with example payloads
5. Copies the Dart code example directly into her project

**Climax:**
Aisha discovers the **WebSocket subscription** docs for real-time updates. The Flutter-specific integration guide shows exactly how to handle the connection lifecycle.

**Resolution:**
Aisha implements order tracking in half the time she expected. The code examples were copy-paste ready. She bookmarks the API docs for future reference.

**Journey Reveals:**
- Multi-language code examples (Dart, JavaScript, PHP)
- Complete API schemas
- Real-time/WebSocket documentation
- Copy-paste code snippets

---

### Journey 4: Platform Admin Managing Vendors

**Persona: David - CurryDash Operations Manager**

**Situation:** David oversees vendor onboarding and needs to approve new restaurants, investigate payment issues, and monitor platform health.

**Opening Scene:**
David receives a support ticket: a vendor claims they weren't paid. He needs to investigate using the admin portal and understand the payout process.

**Rising Action:**
1. David goes to `/admins/vendor-management` to understand vendor statuses
2. Navigates to `/admins/payments` for payout documentation
3. Finds the **troubleshooting guide** for payment issues
4. Follows the step-by-step investigation checklist
5. Discovers the issue was a bank account verification failure

**Climax:**
David uses the admin documentation to guide the vendor through re-verification. The docs have the exact error codes and their solutions.

**Resolution:**
David resolves the ticket without escalating to engineering. He adds a bookmark to the payment troubleshooting page for his team.

**Journey Reveals:**
- Admin portal navigation guides
- Payment/payout system documentation
- Error code reference tables
- Troubleshooting checklists

---

### Journey 5: Customer Troubleshooting Order Issue

**Persona: Sarah - Hungry Customer**

**Situation:** Sarah ordered through CurryDash but her order shows "Preparing" for 45 minutes. She wants to know what's happening before calling support.

**Opening Scene:**
Sarah is frustrated. She googles "CurryDash order stuck preparing" and lands on the help center.

**Rising Action:**
1. Sarah finds `/help/troubleshooting/order-not-arriving`
2. Clear FAQ format: "Why is my order taking so long?"
3. Explains that "Preparing" means the restaurant is cooking
4. Provides expected timelines for different order types
5. Shows how to contact support if it exceeds normal time

**Climax:**
Sarah realizes her large Curry Pack order legitimately takes longer. The docs explain this clearly.

**Resolution:**
Sarah waits patiently, food arrives 10 minutes later. She didn't need to call support. She might even leave a good review.

**Journey Reveals:**
- Customer-facing help center
- FAQ-style troubleshooting
- Clear, jargon-free explanations
- Support contact as last resort

---

### Journey Requirements Summary

| Journey | Key Capabilities Needed |
|---------|------------------------|
| **Vendor Self-Service** | Onboarding checklists, visual guides, Curry Pack docs, screenshots |
| **Backend Dev Onboarding** | Architecture docs, module structure, code patterns, fast search |
| **Mobile Dev Integration** | Multi-language examples, API schemas, real-time docs, copy-paste code |
| **Admin Management** | Admin guides, troubleshooting checklists, error code reference |
| **Customer Troubleshooting** | Help center FAQ, plain language, timeline expectations |

---

## Web App Specific Requirements

### Project-Type Overview

CurryDash Docs is a **static-first documentation SPA** built on Nextra 4 + Next.js 16. It prioritizes:
- Fast page loads with static generation
- SEO-optimized content for discoverability
- Modern browser support without legacy overhead

### Browser Compatibility Matrix

| Browser | Version | Support Level |
|---------|---------|---------------|
| Chrome | Latest 2 | Full |
| Firefox | Latest 2 | Full |
| Safari | Latest 2 | Full |
| Edge | Latest 2 | Full |
| Mobile Chrome | Latest | Full |
| Mobile Safari | Latest | Full |
| IE11 | N/A | Not supported |

**Rationale:** Modern-only support allows use of CSS Grid, CSS Variables, ES2020+ JavaScript without polyfills.

### Responsive Design Requirements

| Breakpoint | Target | Key Considerations |
|------------|--------|-------------------|
| Mobile | < 768px | Collapsed sidebar, hamburger menu, stacked cards |
| Tablet | 768-1024px | Sidebar visible, narrower content area |
| Desktop | > 1024px | Full sidebar + TOC, optimal reading width |

**Critical:** Sidebar must collapse properly on mobile. TOC should hide on mobile and show on desktop.

### Performance, SEO & Accessibility

Detailed targets for performance, SEO, and accessibility are defined in the **Non-Functional Requirements** section (NFR-P1 through NFR-S6). Key targets:

- **Lighthouse scores:** 90+ across Performance, Accessibility, and SEO
- **Core Web Vitals:** LCP < 2.5s, FID < 100ms, CLS < 0.1
- **WCAG Level:** AA (2.1) compliance
- **Build time:** < 60 seconds for full static build

**SEO Goals:**
- Rank for "CurryDash API documentation"
- Rank for "CurryDash vendor portal guide"
- Rank for "CurryDash developer docs"

### Implementation Considerations

**Technology Stack Constraints:**
- Nextra 4 + Next.js 16 (App Router)
- Tailwind CSS v4 (CSS-based config)
- Static export capability for CDN deployment
- Pagefind for client-side search

**Deployment Options:**
- Vercel (recommended for Next.js)
- GitHub Pages (static export)
- GCP Cloud Run (containerized)

---

## Project Scoping & Phased Development

### MVP Strategy & Philosophy

**MVP Approach:** Full Platform MVP (Enterprise Complete)

The documentation platform will launch with complete enterprise-grade features because:
1. Nextra 4 provides most features out-of-box (low additional effort)
2. Documentation platforms have low iteration cost (content, not code)
3. First impressions matter for platform credibility
4. Cross-repo automation is the core differentiator (highest value, implement last)

**Risk Mitigation Order:**
1. **UI/UX Broken** → Fix sidebar/TOC visibility (blocking issue)
2. **Content Outdated** → Migrate 61 legacy docs with proper structure
3. **Poor Discoverability** → Multi-audience navigation + enhanced search
4. **No Automation** → Cross-repo GitHub Actions (most valued feature)

### MVP Feature Set (Phase 1)

**Week 1: Foundation (Unblock Everything)**

| Feature | Priority | Status |
|---------|----------|--------|
| Fix sidebar visibility | P0 | Critical blocker |
| Fix TOC "On This Page" | P0 | Critical blocker |
| Validate Tailwind v4 CSS | P0 | 380+ lines may need fixes |
| Dark mode functional | P1 | Brand polish |

**Week 2: Content Migration**

| Feature | Priority | Count |
|---------|----------|-------|
| Backend PRD docs | P0 | 10 files |
| Backend Architecture docs | P0 | 24 files |
| Mobile PRD docs | P1 | 10 files |
| Deployment docs | P1 | 15 files |
| Brand guidelines | P2 | 2 files |

**Week 3: Multi-Audience Navigation**

| Feature | Priority | Description |
|---------|----------|-------------|
| Root _meta.js restructure | P0 | 5 audience sections |
| Audience switcher homepage | P0 | Card-based selection |
| Developer docs navigation | P0 | Backend + Mobile subsections |
| Vendor docs navigation | P1 | Onboarding → Operations flow |
| Admin docs navigation | P1 | Management guides |
| Help center structure | P2 | Customer FAQ |

**Week 4: Polish & Automation**

| Feature | Priority | Description |
|---------|----------|-------------|
| Cross-repo GitHub Actions | P0 | notify-docs.yml triggers |
| sync-from-repos.yml | P0 | Receive triggers, create specs |
| Semantic-release setup | P1 | Versioned changelog |
| Lighthouse 90+ audit | P1 | Performance optimization |
| Code tabs component | P2 | npm/yarn/pnpm/bun |
| llms.txt file | P2 | AI crawler hints |

### Post-MVP Features (Phase 2: Growth)

| Feature | Rationale |
|---------|-----------|
| AI-powered search (Inkeep/Algolia) | Enhanced discoverability |
| Version selector for API docs | Multi-version support |
| Interactive API playground | Developer experience |
| Feedback widgets | User input collection |
| Analytics integration | Usage insights |

### Future Vision (Phase 3: Expansion)

| Feature | Rationale |
|---------|-----------|
| MCP server for AI assistants | AI integration point |
| Auto-generated API docs from Laravel routes | Zero-effort sync |
| Video tutorials embedded | Rich media content |
| Multi-language support | International expansion |
| Community contribution workflow | Open source docs |

### Risk Mitigation Strategy

**Technical Risks:**

| Risk | Mitigation |
|------|------------|
| Sidebar/TOC CSS conflict | Isolate Nextra theme CSS, test in dev before production |
| Tailwind v4 compatibility | Revert to v3 if blocking issues persist |
| Build time degradation | Monitor build times, optimize images, limit search indexing |

**Content Risks:**

| Risk | Mitigation |
|------|------------|
| Legacy docs outdated | Prioritize architecture docs (stable), PRD for reference only |
| Content drift post-launch | Cross-repo automation keeps docs current |
| Missing content gaps | Help center can launch with top 10 FAQs only |

**Resource Risks:**

| Risk | Mitigation |
|------|------------|
| Solo developer bandwidth | Focus on blocker fixes first, polish is parallelizable |
| Content migration volume | Use scripts (migrate-existing-docs.sh) for bulk operations |
| Cross-repo complexity | Test with single repo (backend) before adding mobile |

---

## Functional Requirements

### Content Discovery & Search

- **FR1:** Users can search documentation content using full-text search
- **FR2:** Users can filter search results by documentation section
- **FR3:** Users can view search results with highlighted match context
- **FR4:** Users can navigate to search results directly from search interface
- **FR5:** AI crawlers can access structured content hints via llms.txt

### Multi-Audience Navigation

- **FR6:** Users can identify their audience type from the homepage
- **FR7:** Vendors can access vendor-specific documentation section
- **FR8:** Backend developers can access backend architecture documentation
- **FR9:** Mobile developers can access mobile development documentation
- **FR10:** Administrators can access platform admin guides
- **FR11:** Customers can access help center and FAQ content
- **FR12:** Users can navigate documentation via persistent sidebar
- **FR13:** Users can see current page location via breadcrumbs
- **FR14:** Users can see page structure via table of contents

### Documentation Content Display

- **FR15:** Users can view formatted MDX documentation pages
- **FR16:** Users can view code examples with syntax highlighting
- **FR17:** Users can switch between package manager tabs (npm/yarn/pnpm/bun)
- **FR18:** Users can copy code blocks to clipboard
- **FR19:** Users can view API endpoint specifications with request/response schemas
- **FR20:** Users can view multi-language code examples (Dart, JavaScript, PHP)
- **FR21:** Users can view embedded diagrams and visual aids
- **FR22:** Users can view step-by-step guides with screenshots

### Vendor Self-Service Capabilities

- **FR23:** Vendors can access onboarding checklist documentation
- **FR24:** Vendors can view Curry Pack configuration guides
- **FR25:** Vendors can access menu management instructions
- **FR26:** Vendors can view order management documentation
- **FR27:** Vendors can access payment and payout information

### Developer Onboarding Capabilities

- **FR28:** Developers can view architecture overview diagrams
- **FR29:** Developers can access module structure documentation
- **FR30:** Developers can view code patterns and conventions
- **FR31:** Developers can access API specification reference
- **FR32:** Developers can view WebSocket/real-time integration guides
- **FR33:** Developers can access authentication implementation guides

### Admin Management Capabilities

- **FR34:** Administrators can access vendor management documentation
- **FR35:** Administrators can view payment troubleshooting guides
- **FR36:** Administrators can access error code reference tables
- **FR37:** Administrators can view investigation checklists

### Customer Help Capabilities

- **FR38:** Customers can access FAQ-style troubleshooting content
- **FR39:** Customers can view order status explanations
- **FR40:** Customers can find support contact information

### Cross-Repository Integration

- **FR41:** System can receive documentation trigger events from backend repository
- **FR42:** System can receive documentation trigger events from mobile repository
- **FR43:** System can generate change specifications from commit messages
- **FR44:** System can apply pending documentation changes
- **FR45:** System can version documentation releases via semantic versioning

### Visual Experience & Accessibility

- **FR46:** Users can toggle between light and dark display modes
- **FR47:** Users can view documentation on mobile devices with adapted layout
- **FR48:** Users can navigate documentation using keyboard only
- **FR49:** Users can access documentation via screen reader
- **FR50:** Users can identify interactive elements via visible focus indicators

### Content Management

- **FR51:** Authors can add new documentation pages as MDX files
- **FR52:** Authors can organize navigation structure via _meta.js files
- **FR53:** System can generate XML sitemap for search engines
- **FR54:** System can generate search index at build time

---

## Non-Functional Requirements

### Performance

| Requirement | Target | Measurement |
|-------------|--------|-------------|
| **NFR-P1:** Page load (LCP) | < 2.5 seconds | Core Web Vital on 3G connection |
| **NFR-P2:** Interactivity (FID) | < 100ms | First Input Delay measurement |
| **NFR-P3:** Visual stability (CLS) | < 0.1 | Cumulative Layout Shift score |
| **NFR-P4:** Search latency | < 100ms | Time from query to results displayed |
| **NFR-P5:** Lighthouse Performance | 90+ | All documentation pages |
| **NFR-P6:** Time to Interactive | < 3 seconds | On 3G connection |
| **NFR-P7:** Static build time | < 60 seconds | Full production build with search indexing |

### Accessibility

| Requirement | Target | Measurement |
|-------------|--------|-------------|
| **NFR-A1:** WCAG compliance | Level AA (2.1) | Automated + manual audit |
| **NFR-A2:** Keyboard navigation | 100% coverage | All interactive elements reachable |
| **NFR-A3:** Screen reader compatibility | NVDA, VoiceOver | Tested with major screen readers |
| **NFR-A4:** Color contrast | 4.5:1 minimum | Text against background |
| **NFR-A5:** Focus indicators | Visible on all elements | Keyboard focus state styling |
| **NFR-A6:** Skip links | Available | Skip to main content link |
| **NFR-A7:** Lighthouse Accessibility | 90+ | All documentation pages |

### Integration

| Requirement | Target | Measurement |
|-------------|--------|-------------|
| **NFR-I1:** Webhook reliability | 99.9% delivery | GitHub Actions repository_dispatch events |
| **NFR-I2:** Cross-repo latency | < 5 minutes | Commit to change spec generation |
| **NFR-I3:** API availability | 99.9% uptime | Headless API endpoints (/api/docs/*) |
| **NFR-I4:** Semantic versioning | Automated | Conventional commits to CHANGELOG |
| **NFR-I5:** Build trigger reliability | 100% | No missed documentation updates |

### Reliability

| Requirement | Target | Measurement |
|-------------|--------|-------------|
| **NFR-R1:** Site availability | 99.9% uptime | CDN-hosted static assets |
| **NFR-R2:** Build pipeline success | 95%+ | CI/CD build success rate |
| **NFR-R3:** Search index integrity | 100% | All pages indexed at build time |
| **NFR-R4:** Content freshness | Real-time on deploy | No stale cache issues |

### SEO & Discoverability

| Requirement | Target | Measurement |
|-------------|--------|-------------|
| **NFR-S1:** Lighthouse SEO score | 90+ | All documentation pages |
| **NFR-S2:** Sitemap generation | Automated | sitemap.xml updated on build |
| **NFR-S3:** Meta tags | 100% coverage | Title, description, OG tags on all pages |
| **NFR-S4:** Structured data | Article schema | JSON-LD on documentation pages |
| **NFR-S5:** Canonical URLs | 100% | Prevent duplicate content issues |
| **NFR-S6:** Crawlability | Unrestricted | robots.txt allows all public content |

