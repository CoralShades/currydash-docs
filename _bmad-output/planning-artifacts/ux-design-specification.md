---
stepsCompleted:
  - 1
  - 2
  - 3
  - 4
  - 5
  - 6
  - 7
  - 8
  - 9
  - 10
  - 11
  - 12
  - 13
  - 14
workflowComplete: true
completedAt: 2026-01-21
inputDocuments:
  - path: '_bmad-output/planning-artifacts/prd.md'
    type: prd
    description: 'Product Requirements Document with 54 FRs, 25 NFRs, 5 user journeys'
  - path: '_bmad-output/planning-artifacts/prd-validation-report.md'
    type: validation
    description: 'PRD validation report - all checks passed, 5/5 holistic quality'
---

# UX Design Specification - currydash-docs

**Author:** Demi
**Date:** 2026-01-21

---

## Executive Summary

### Project Vision

CurryDash Docs is an enterprise-grade documentation platform serving the CurryDash food delivery ecosystem. The platform provides unified, always-current documentation for five distinct audiences: restaurant vendors, backend developers, mobile developers, platform administrators, and customers.

**Core Differentiator:** Cross-repository automation where documentation automatically updates when code changes in the backend (`currydash-admin-vendor-portal`) or mobile (`currydash-mobile`) repositories—eliminating the "docs are outdated" problem that plagues most platforms.

**Current State (Brownfield):**
- Sidebar and TOC are broken on desktop (critical UI blocker)
- 61 legacy docs scattered and need migration
- Current navigation doesn't serve 5 distinct user types
- Cross-repo automation triggers not yet implemented

**Target State:** Match the visual and functional quality of Stripe, Vercel, and SvelteFlow documentation. Users find answers in under 30 seconds.

### Target Users

| User Persona | Description | Primary Goal | Tech Level |
|--------------|-------------|--------------|------------|
| **Restaurant Vendors** (Priya) | Small business owners, tech-comfortable but time-poor | Self-serve onboarding without support calls | Intermediate |
| **Backend Developers** (Marcus) | Senior PHP/Laravel devs, new to codebase | Understand architecture quickly to ship code | Expert |
| **Mobile Developers** (Aisha) | Flutter devs integrating with backend | Find API specs and copy-paste code examples | Expert |
| **Platform Admins** (David) | Operations managers troubleshooting issues | Resolve vendor tickets without engineering | Intermediate |
| **Customers** (Sarah) | End users with order issues | Get answers without calling support | Novice |

### Key Design Challenges

1. **Multi-Audience Navigation:** 5 distinct user types with vastly different needs (vendor onboarding vs. API specs vs. customer FAQ)—must feel tailored without overwhelming

2. **Broken Core UI:** Sidebar/TOC visibility issues on desktop are blocking all usability—must fix before any UX polish matters

3. **Content Hierarchy:** 61 legacy docs + multi-repo sources need clear organization so users find answers in <30 seconds

4. **Visual Credibility:** Competing with Stripe/Vercel quality expectations from developers

### Design Opportunities

1. **Audience-First Homepage:** Card-based selection ("I'm a restaurant vendor" / "I'm a developer") creates immediate relevance and reduces cognitive load

2. **Copy-Paste Developer Experience:** Multi-language code examples with instant clipboard functionality could delight developers (Stripe-like)

3. **Visual Vendor Guides:** Step-by-step screenshots for non-technical vendors differentiates from developer-focused competitors

---

## Core User Experience

### Defining Experience

The core experience of currydash-docs is **finding specific information in under 30 seconds**. Users arrive with a question (vendor: "How do I set up Curry Packs?", developer: "What's the order status API endpoint?", customer: "Why is my order delayed?") and should reach their answer through intuitive navigation or instant search.

The defining interaction is **audience identification on first visit**—if users immediately recognize "this section is for me", they self-serve successfully. If they land in developer docs when they're a vendor, they'll abandon to support.

### Platform Strategy

| Platform | Priority | Interaction Mode |
|----------|----------|-----------------|
| **Desktop Web** | Primary | Mouse/keyboard |
| **Mobile Web** | Secondary | Touch |
| **Offline** | Not required | N/A |

**Key Capabilities:**
- Clipboard API for one-click code copying
- Responsive images for screenshot guides
- Dark/light mode toggle with persistence
- Fast static pages (Nextra/Next.js SSG)

### Effortless Interactions

| Interaction | Design Goal |
|-------------|-------------|
| **Audience identification** | One-click role selection, immediate navigation to relevant content |
| **Code copying** | Single click with visual confirmation, complete ready-to-use snippets |
| **Navigation** | Always-visible sidebar (desktop), collapsible drawer (mobile), working TOC |
| **Search** | <100ms results, highlighted match context, relevant ranking |
| **Theme toggle** | Single click, persists across sessions |

### Critical Success Moments

1. **First Visit Success:** User identifies relevant content within 5 seconds via audience-based homepage cards
2. **Search Success:** First search result is relevant; answer visible in result preview
3. **Guide Completion:** Vendor completes onboarding by following visual step-by-step guide without calling support
4. **API Integration:** Developer copies code example, pastes into project, it works immediately

### Experience Principles

1. **Audience-First Navigation:** Every user knows within 5 seconds that content exists specifically for their role
2. **Answer in 30 Seconds:** From landing to answer should feel instant—search, navigation, and structure optimize for speed
3. **Copy-Paste Ready:** Code examples are complete and work immediately, with auth headers, error handling, and imports
4. **Show, Don't Tell:** Visual guides with screenshots for non-technical users; every step is "do this, see this"
5. **Trust Through Quality:** Visual polish signals credibility—if docs look like Stripe, users trust the platform

---

## Desired Emotional Response

### Primary Emotional Goals

| User Type | Primary Emotion | Design Intent |
|-----------|-----------------|---------------|
| **Vendors** | Confident and Capable | "I can do this myself without calling support" |
| **Developers** | Efficient and Respected | "They value my time with complete, working examples" |
| **Admins** | Empowered and Competent | "I have the tools to solve this issue" |
| **Customers** | Reassured and Informed | "I know what's happening with my order" |

**Differentiating Emotion:** Users should feel surprised by quality—"documentation that's actually good"

### Emotional Journey Mapping

| Stage | Emotion | Design Support |
|-------|---------|----------------|
| **Discovery** | Welcomed, Not Overwhelmed | Clean homepage with clear audience paths |
| **Navigation** | Oriented, In Control | Visible breadcrumbs, sidebar, and TOC |
| **Reading** | Focused, Confident | Clean typography, comfortable reading width |
| **Searching** | Hopeful → Satisfied | Instant results with highlighted context |
| **Task Completion** | Accomplished, Relieved | Clear success states and progress indicators |
| **Error/Confusion** | Supported, Not Blamed | Helpful messages with clear next steps |
| **Return Visit** | Familiar, Efficient | Remembered preferences, faster navigation |

### Micro-Emotions

| Target State | How We Achieve It |
|--------------|-------------------|
| **Confidence** | Clear headings, logical structure, persistent navigation |
| **Trust** | Professional polish, accurate content, current screenshots |
| **Accomplishment** | Step-by-step progress indicators, completion feedback |
| **Efficiency** | Fast search, one-click actions, no unnecessary clicks |
| **Subtle Delight** | Smooth animations, copy confirmations, responsive feedback |

### Design Implications

**Interactions That Build Positive Emotions:**
- Code copy shows "Copied!" with checkmark animation
- Smooth dark/light theme transition
- Search results appear instantly with highlighted matches
- Sidebar expands smoothly to reveal current location

**Emotions to Actively Prevent:**
- Overwhelmed: Never show all audiences' content simultaneously
- Lost: Always show navigation and location cues
- Frustrated: Eliminate dead ends, broken examples, outdated content
- Ignored: Acknowledge every user action with feedback

### Emotional Design Principles

1. **Respect Time Above All:** Every interaction signals "we value your time"—fast loads, instant search, direct paths
2. **Confidence Through Clarity:** Users never wonder "am I in the right place?" or "what do I do next?"
3. **Celebrate Progress:** Multi-step guides show progress and acknowledge completion
4. **Fail Gracefully:** When things go wrong, provide helpful alternatives over dead ends
5. **Polish = Trust:** Visual quality signals CurryDash is a serious platform worth doing business with

---

## UX Pattern Analysis & Inspiration

### Inspiring Products Analysis

#### Stripe Documentation
- **Key Strength:** Multi-language code examples that are complete and copy-paste ready
- **Pattern Highlight:** "Copied!" feedback animation; language selector tabs
- **Why It Works:** Respects developer time; examples include imports, auth, error handling

#### Vercel Documentation
- **Key Strength:** Audience-based entry points with professional visual polish
- **Pattern Highlight:** Command palette (Cmd+K); breadcrumb navigation; card-based homepage
- **Why It Works:** Feels premium from first interaction; never feel lost

#### SvelteFlow Documentation
- **Key Strength:** Clean, focused design with fast static pages
- **Pattern Highlight:** Component-based navigation; minimal visual distraction
- **Why It Works:** Content-first approach; excellent performance

### Transferable UX Patterns

**Navigation:**
- Persistent sidebar with collapsible audience sections
- Breadcrumb trail showing Audience > Section > Page
- Sticky "On This Page" TOC on desktop

**Interaction:**
- Language/package manager tabs for code blocks (npm/yarn/pnpm/bun)
- Copy button with "Copied!" checkmark animation
- Search results with highlighted match context

**Visual:**
- Clean typography with comfortable reading width
- Card-based homepage for audience selection
- Professional polish matching platform credibility goals

### Anti-Patterns to Avoid

| Avoid | Because | Instead |
|-------|---------|---------|
| Wall of text homepage | Overwhelming first impression | Card-based audience selection |
| Hidden navigation | Users feel lost | Always-visible sidebar on desktop |
| Incomplete code examples | Wastes developer time | Complete, working examples |
| Mixed audiences in nav | Vendors confused by API docs | Clear audience separation |
| Search without preview | Forces unnecessary clicks | Results with context highlights |

### Design Inspiration Strategy

**Adopt Directly:**
- Stripe's language tabs and copy feedback
- Vercel's breadcrumbs and card homepage
- All three's clean typography approach

**Adapt for CurryDash:**
- Simplify command palette to focused search
- Audience + feature navigation hybrid structure
- Package manager tabs (npm/yarn/pnpm/bun)

**Avoid:**
- Complex onboarding (vendors need instant access)
- Hamburger menu on desktop (sidebar must be visible)
- Mixed technical/non-technical navigation

---

## Design System Foundation

### Design System Choice

**Primary System:** Nextra 4 Default Theme + Tailwind CSS v4 Customization + shadcn/ui for Custom Components

**Component Layers:**
1. **Nextra Theme Components:** Sidebar, TOC, Search, Code blocks, Breadcrumbs, Navigation
2. **Tailwind CSS v4:** Typography, spacing, colors, responsive utilities, dark mode
3. **shadcn/ui (as needed):** Custom cards, tabs, modals, and interactive elements

### Rationale for Selection

| Factor | Why This Choice |
|--------|-----------------|
| **Framework Alignment** | Nextra + Tailwind is the PRD-specified stack; no fighting between systems |
| **Documentation Focus** | Nextra provides purpose-built docs components (sidebar, TOC, search) |
| **Customization** | Tailwind CSS variables allow brand-aligned theming |
| **Speed** | Nextra defaults work immediately; customize incrementally |
| **Accessibility** | Nextra and shadcn/ui include WCAG AA compliance |
| **Dark Mode** | Native support in both Nextra and Tailwind |

### Implementation Approach

**Phase 1: Fix Broken Fundamentals**
- Resolve sidebar/TOC CSS conflicts with Nextra theme
- Validate Tailwind v4 compatibility with existing styles
- Ensure dark mode toggle functions correctly

**Phase 2: Brand Customization**
- Define CurryDash color palette as Tailwind CSS variables
- Customize typography scale for optimal readability
- Adjust spacing and layout for professional polish

**Phase 3: Custom Components (As Needed)**
- Audience selection cards (shadcn/ui Card pattern)
- Package manager tabs for code blocks (shadcn/ui Tabs)
- Copy-to-clipboard with feedback (custom Tailwind)

### Customization Strategy

**Tailwind CSS Variables for Brand:**
- Primary brand color for key actions and highlights
- Secondary color for supporting elements
- Accent colors for interactive states
- Semantic colors for success/warning/error states

**Nextra Theme Overrides:**
- Custom sidebar styles for multi-audience navigation
- Enhanced code block styling with language tabs
- Branded search results appearance

**Component Library Strategy:**
- Use Nextra defaults first
- Add shadcn/ui components only when needed
- Custom components follow Tailwind patterns for consistency

---

## Detailed User Experience Design

### Defining Experience

**Core Interaction:** "Ask a question, get an answer in under 30 seconds"

This is the defining experience for currydash-docs. Whether via search or navigation, users should feel the platform respects their time and knows what they need.

**How Users Describe It:** "I typed what I was looking for, and it showed me exactly what I needed."

### User Mental Model

**Developer Mental Model:**
- Expects search to work like VS Code/Stripe docs (instant, relevant)
- Expects copy-paste code examples that actually work
- Expects to find architecture context, not just API endpoints

**Vendor Mental Model:**
- Expects step-by-step guides with screenshots
- Expects to complete tasks without calling support
- Expects content organized by their workflow, not system architecture

**Customer Mental Model:**
- Expects FAQ-style answers in plain language
- Expects to understand order status without technical jargon
- Expects support contact as last resort, not first option

### Success Criteria

| Criterion | Target | Evidence of Success |
|-----------|--------|---------------------|
| **Speed** | <30 seconds | User finds answer before abandoning |
| **Relevance** | First result correct | No need to click multiple results |
| **Clarity** | Answer visible immediately | No scrolling through paragraphs |
| **Completeness** | Full context included | Code examples work as-is |
| **Trust** | Content is current | Screenshots match actual UI |

### Novel UX Patterns

**Pattern Approach:** Established patterns with exceptional execution

**Not Innovating On:** Search, navigation, code blocks, documentation structure

**Differentiating Through:**
- Audience-first navigation (uncommon in docs)
- Cross-repo automation for content freshness (unique)
- Visual quality matching Stripe/Vercel (rare)

### Experience Mechanics

**Initiation:** User arrives via direct URL, homepage, or search
**Interaction:** Search (<100ms results) or navigate (audience → section → page)
**Feedback:** Match highlighting, breadcrumbs, TOC position, "Copied!" confirmation
**Completion:** Answer found, code works, guide matches experience, no support needed

---

## Visual Design Foundation

### Color System

**Brand Palette (from CurryDash Brand Guidelines v2.0):**

| Color | Hex | Usage in Documentation |
|-------|-----|----------------------|
| **Turmeric Gold** | #E6B04B | Navigation, active states, links, highlights |
| **Chili Red** | #C5351F | Error states, urgent callouts, code errors |
| **Curry Leaf Green** | #4A7C59 | Success states, trust badges, verified content |
| **Cinnamon Brown** | #5D4037 | Primary text (8.59:1 on white - AAA) |
| **Warm Gray** | #8D6E63 | Secondary text (4.76:1 on white - AA) |
| **Deep Charcoal** | #1A1A1A | Dark mode background |
| **Warm White** | #F5F5F5 | Dark mode text (16.82:1 - AAA) |

**Documentation-Specific Adaptations:**
- **Reading Surfaces:** Use white (#FFFFFF) instead of Coconut Cream for long-form reading comfort
- **Code Blocks:** Neutral gray backgrounds (#F6F8FA light / #161B22 dark) for code—matches developer expectations
- **Links:** Turmeric Gold with underline for accessibility (4.48:1 alone requires large text)

**Semantic Color Mapping:**

| Semantic | Light Mode | Dark Mode | Usage |
|----------|------------|-----------|-------|
| **Primary** | Turmeric Gold #E6B04B | #F4C462 | Navigation, CTAs, focus states |
| **Success** | Curry Leaf Green #4A7C59 | #66BB6A | Confirmations, verified badges |
| **Warning** | Warning Amber #FF9800 | #FF9800 | Caution callouts |
| **Error** | Error Red #E53935 | #E53935 | Error states, critical alerts |
| **Info** | Info Blue #2196F3 | #2196F3 | Tips, notes, information |

### Typography System

**Font Stack:**
- **Headings:** Poppins (400, 500, 600, 700)
- **Body:** Roboto (400, 500)
- **Code:** Roboto Mono (400)

**Type Scale:**

| Element | Font | Size | Weight | Line Height |
|---------|------|------|--------|-------------|
| H1 | Poppins | 32px | 700 | 40px |
| H2 | Poppins | 24px | 600 | 32px |
| H3 | Poppins | 20px | 500 | 28px |
| H4 | Roboto | 18px | 500 | 24px |
| Body | Roboto | 16px | 400 | 24px |
| Caption | Roboto | 14px | 400 | 20px |
| Code | Roboto Mono | 14px | 400 | 22px |

### Spacing & Layout Foundation

**Base Unit:** 8px (matching brand guidelines)

**Spacing Scale:**
- xs: 4px | sm: 8px | md: 16px | lg: 24px | xl: 32px | xxl: 48px

**Layout Specifications:**
- **Content max-width:** 720px (optimal reading)
- **Page padding:** 32px (desktop), 24px (tablet), 16px (mobile)
- **Section gap:** 48px
- **Border radius:** 8px (cards, code blocks)

**Responsive Breakpoints:**
- Mobile: < 768px (sidebar collapsed)
- Tablet: 768-1024px (sidebar visible, narrower content)
- Desktop: > 1024px (full layout with TOC)

### Accessibility Considerations

**WCAG 2.1 AA Compliance (from Brand Guidelines):**
- All text contrast ratios verified
- Turmeric Gold requires 18px+ text or additional visual indicators
- Color never used alone to convey meaning
- Focus indicators: 3px solid Turmeric Gold outline

**Documentation-Specific Accessibility:**
- Code blocks include copy button (keyboard accessible)
- Heading hierarchy strictly maintained for screen readers
- Skip-to-content link for keyboard navigation
- Dark mode respects `prefers-color-scheme`

---

## Design Direction Decision

### Design Directions Explored

Three primary directions were evaluated for currydash-docs:

1. **Vercel-Style Clean:** Maximum white space, minimal chrome, content-first
2. **Stripe-Style Polished:** Visual polish, branded feel, multi-audience navigation
3. **SvelteFlow-Style Focused:** Ultra-minimal, content dominates, performance-first

### Chosen Direction

**Stripe-Style Polished** with elements from Vercel-Style Clean.

This hybrid approach provides:
- Visual polish matching enterprise credibility goals
- Multi-audience navigation visibility
- Sticky TOC for improved long-page navigation
- Brand color integration via navigation and active states

### Design Rationale

| Decision | Rationale |
|----------|-----------|
| **Polished visual style** | Enterprise credibility; matches Stripe/Vercel benchmark |
| **Prominent navigation** | 5 audiences require clear wayfinding |
| **Branded accents** | Turmeric Gold creates distinctive identity |
| **Sticky TOC** | Long documentation pages need section navigation |
| **720px content width** | Optimal reading comfort for all audiences |

### Implementation Approach

**Layout Structure:**
```
┌──────────────────────────────────────────────────┐
│  Logo  │  [Audience Tabs]  │  Search  │ Theme │
├────────┼───────────────────┼──────────┴────────┤
│        │                   │                   │
│ Side   │    Main Content   │   TOC             │
│ bar    │    (720px max)    │   (sticky)        │
│ 240px  │                   │   200px           │
│        │                   │                   │
├────────┴───────────────────┴───────────────────┤
│  Footer: Quick links, version, feedback        │
└────────────────────────────────────────────────┘
```

**Responsive Behavior:**
- Desktop (>1024px): Full layout with sidebar and TOC
- Tablet (768-1024px): Sidebar visible, TOC hidden
- Mobile (<768px): Collapsed sidebar (hamburger), no TOC

---

## User Journey Flows

### Journey 1: Vendor Self-Service Onboarding

**Goal:** New vendor completes restaurant setup following documentation

**Entry Points:**
- Homepage → "I'm a Restaurant Vendor" card
- Direct URL from onboarding email
- Search for "vendor setup" or "restaurant onboarding"

**Flow:**
1. Land on vendor docs landing page
2. See prominent "Getting Started" section
3. View onboarding checklist (5 steps with progress)
4. Follow step-by-step guides with matching screenshots
5. Complete each section: Profile → Menu → Curry Packs → Payment → Go Live
6. Success: Restaurant live without support calls

**Key Interactions:**
- Progress checklist shows completed steps
- Each guide shows estimated time (~10 minutes)
- Screenshots always match current portal UI
- "Stuck?" callouts link to related topics

### Journey 2: Developer Finding API Documentation

**Goal:** Developer finds endpoint docs, copies working code example

**Entry Points:**
- Homepage → "I'm a Developer" card
- Direct URL to API reference
- Search for endpoint name or feature

**Flow:**
1. Navigate to API Reference section
2. Browse or search for specific endpoint
3. View endpoint documentation (GET /v1/orders/{id}/status)
4. See request/response schemas
5. Select language tab (Dart/JavaScript/PHP)
6. Copy complete code example
7. Paste in IDE → works immediately

**Key Interactions:**
- Language preference persists across pages
- Code examples include auth headers and error handling
- Copy button with "Copied!" confirmation
- Related endpoints shown in context

### Journey 3: Search → Answer (Core Experience)

**Goal:** Any user finds answer in under 30 seconds

**Flow:**
1. Focus search (Cmd+K or click)
2. Type query
3. See instant results (<100ms) with context
4. Each result shows: Title, Section (Vendor/Developer/Admin), Match highlight
5. Click most relevant result
6. Page loads with match section visible
7. Read answer → question resolved

**Key Interactions:**
- Results show audience section for filtering
- Keyboard navigation (up/down arrows)
- Recent searches remembered
- "No results" suggests alternatives

### Journey Patterns

**Navigation:**
- Audience-first entry on all journeys
- Breadcrumb context (Audience > Section > Page)
- Progressive disclosure (overview → details)
- Related content links on every page

**Feedback:**
- Instant search results
- Copy confirmation animations
- Progress indicators for multi-step guides
- Active page highlighted in sidebar

**Error Recovery:**
- Search refinement suggestions
- No dead-end pages
- Support contact on troubleshooting pages
- Version indicators for API docs

### Flow Optimization Principles

1. **Minimize steps to value:** Users reach answers in under 30 seconds
2. **Reduce cognitive load:** One clear action per decision point
3. **Provide constant feedback:** Users always know where they are and what's happening
4. **Handle errors gracefully:** Every failure path leads to recovery
5. **Remember preferences:** Language selection, recent searches persist

---

## Component Strategy

### Design System Components

**From Nextra 4 Theme (Use as-is with styling):**
- Sidebar navigation (needs CSS fix)
- Table of Contents (needs CSS fix)
- Search (Pagefind) - working
- Code blocks with syntax highlighting - working
- Callout components (info/warning/error) - working
- Dark mode toggle - needs verification
- Breadcrumbs - working

**From shadcn/ui (Add as needed):**
- Tabs component (for language selection)
- Card component (base for audience cards)
- Tooltip component (for copy feedback)

### Custom Components

#### Audience Selector Card

**Purpose:** Homepage navigation for audience self-identification

**Specifications:**
- White card with icon, title, description, CTA link
- Hover: Turmeric Gold border + shadow lift
- Focus: 3px Turmeric Gold outline
- 5 variants: Vendors, Backend Devs, Mobile Devs, Admins, Customers

#### Code Block Language Tabs

**Purpose:** Multi-language code examples with easy switching

**Specifications:**
- Tab bar: npm/yarn/pnpm/bun or Dart/JS/PHP
- Active tab: Turmeric Gold underline
- Persists selection across pages (localStorage)

#### Copy Button with Feedback

**Purpose:** One-click code copying with visual confirmation

**Specifications:**
- Default: Copy icon
- Hover: "Copy" label appears
- Success: Checkmark + "Copied!" (2 seconds, Curry Leaf Green)
- Accessible: aria-label, announces on success

### Component Implementation Strategy

1. **Fix First:** Resolve Nextra sidebar/TOC CSS issues before building custom
2. **Extend, Don't Replace:** Use Nextra/shadcn components as base
3. **Brand Consistently:** All components use Tailwind CSS variables for brand colors
4. **Accessible by Default:** ARIA patterns, keyboard navigation, screen reader support

### Implementation Roadmap

| Phase | Components | Priority |
|-------|------------|----------|
| **P1 Fixes** | Sidebar CSS, TOC CSS, Dark mode | Critical |
| **P1 Custom** | Audience Cards, Copy Button | Critical |
| **P2 Enhance** | Language Tabs, Search styling | High |
| **Post-MVP** | Version selector, API playground, Feedback widget | Future |

---

## UX Consistency Patterns

### Navigation Patterns

**Sidebar:**
- Always visible on desktop, collapsible on mobile
- Current page: Turmeric Gold left border + background tint
- Audience sections at top level, expandable subsections
- Width: 240px

**Breadcrumbs:**
- Format: Home > Audience > Section > Page
- All segments clickable except current page
- Truncates gracefully on mobile

**Table of Contents:**
- Sticky on desktop, hidden on mobile
- Highlights current section on scroll
- Click for smooth-scroll navigation

### Search Patterns

**Search Box:**
- Trigger: Click or Cmd+K
- Results: Instant (<100ms)
- Show: 5-8 results with title, section badge, highlighted match

**No Results:**
- Clear message with query shown
- Suggestions for alternative searches
- Links to popular sections

### Feedback Patterns

**Callout Types:**

| Type | Purpose | Color |
|------|---------|-------|
| Info | General information | Blue #2196F3 |
| Tip | Best practices | Green #4A7C59 |
| Warning | Potential issues | Amber #FF9800 |
| Danger | Critical/breaking | Red #C5351F |

**Copy Confirmation:**
- Shows checkmark + "Copied!" for 2 seconds
- Announces to screen readers
- Reverts to copy icon automatically

### Content Patterns

**Code Blocks:**
- Syntax highlighting by language
- Copy button always visible (top-right)
- Language/package tabs when applicable
- Wrap long lines, no horizontal scroll

**API Reference:**
- Endpoint with HTTP method badge
- Authentication requirements
- Parameter table with types
- Response example in highlighted JSON

**Step-by-Step Guides:**
- Time estimate at start
- Numbered steps with screenshots
- "You did it!" success confirmation
- Related guides at end

---

## Responsive Design & Accessibility

### Responsive Strategy

**Desktop (>1024px):**
- Three-column layout: Sidebar (240px) + Content (720px) + TOC (200px)
- Full navigation visible, keyboard shortcuts enabled
- Mouse/keyboard optimized interactions

**Tablet (768-1024px):**
- Two-column layout: Sidebar (200px) + Content (flexible)
- TOC hidden, expands on demand
- Touch-friendly with 48px tap targets

**Mobile (<768px):**
- Single column, content full-width
- Sidebar collapsed to hamburger menu
- Search prominent, touch-optimized

### Breakpoint Strategy

| Breakpoint | Width | Changes |
|------------|-------|---------|
| **mobile** | <768px | Single column, collapsed nav, no TOC |
| **md** | ≥768px | Add sidebar (200px) |
| **lg** | ≥1024px | Full layout with TOC (200px), sidebar (240px) |

**Approach:** Mobile-first CSS (Tailwind default)

### Accessibility Strategy

**Compliance:** WCAG 2.1 Level AA

**Color Contrast:**
- Primary text: 8.59:1 (AAA)
- Secondary text: 4.76:1 (AA)
- All interactive elements: 4.5:1+ minimum

**Keyboard Navigation:**
- Logical tab order: Header → Sidebar → Content → TOC
- Skip link: "Skip to content" at page top
- Focus indicators: 3px solid Turmeric Gold
- Shortcuts: Cmd+K (search), Escape (close)

**Screen Reader Support:**
- Semantic HTML with proper heading hierarchy
- ARIA landmarks and labels
- Live regions for dynamic content ("Copied!")
- Descriptive alt text on all images

**Touch Accessibility:**
- Minimum touch target: 48x48px
- Minimum spacing: 8px between targets
- No hover-only interactions

### Testing Strategy

**Responsive Testing:**
- Chrome DevTools responsive mode
- Real devices: iPhone 14, Samsung S23, iPad Air
- BrowserStack for cross-browser coverage

**Accessibility Testing:**
- Automated: axe DevTools, Lighthouse (target 90+)
- Manual: Keyboard-only navigation test
- Screen readers: VoiceOver (Mac), NVDA (Windows)
- Color: WebAIM Contrast Checker, Coblis color blindness sim

### Implementation Guidelines

**Responsive Development:**
- Use Tailwind responsive prefixes (sm:, md:, lg:)
- Relative units (rem, %) over fixed pixels
- Test touch targets on actual devices
- Optimize images with responsive srcset

**Accessibility Development:**
- Semantic HTML structure (nav, main, aside, article)
- ARIA labels on all interactive elements
- Focus management for modals/overlays
- Skip link as first focusable element

---
