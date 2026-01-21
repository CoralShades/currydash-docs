# CurryDash Documentation Platform - Comprehensive Analysis

**Generated:** 2026-01-21
**Analysis Type:** UI/UX Review, Gap Analysis, Architecture Design
**Platform:** Nextra 4 + Next.js 15 + Tailwind CSS v4

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Current State Analysis](#2-current-state-analysis)
3. [Gap Analysis](#3-gap-analysis)
4. [Multi-Audience Documentation Architecture](#4-multi-audience-documentation-architecture)
5. [Document Migration Strategy](#5-document-migration-strategy)
6. [_meta Patterns & MDX Routing](#6-_meta-patterns--mdx-routing)
7. [UI/UX Recommendations](#7-uiux-recommendations)
8. [Enterprise Feature Roadmap](#8-enterprise-feature-roadmap)
9. [Implementation Priorities](#9-implementation-priorities)

---

## 1. Executive Summary

### Overview

CurryDash-docs is a multi-repository documentation platform for a food delivery service. It uses Nextra 4 with Next.js 15 and integrates with two source repositories:
- `currydash-admin-vendor-portal` (Laravel backend)
- `currydash-mobile` (Flutter mobile/web apps)

### Key Findings

| Area | Current State | Gap Level | Priority |
|------|---------------|-----------|----------|
| **Navigation** | Generic template structure | High | Critical |
| **Search** | Pagefind configured | Medium | High |
| **Multi-Audience** | Not implemented | High | Critical |
| **Content Migration** | 75 legacy docs unmigrated | High | Critical |
| **UI/UX** | Sidebar/TOC issues | High | Critical |
| **Developer Experience** | Basic components only | Medium | High |
| **Help Center** | Missing | High | Medium |

### Recommended Action

1. **Immediate:** Fix sidebar/TOC visibility issues (CSS/layout)
2. **Short-term:** Implement multi-audience navigation architecture
3. **Medium-term:** Migrate 75 legacy documents with proper _meta patterns
4. **Long-term:** Add AI-powered search and help center

---

## 2. Current State Analysis

### 2.1 Existing Documentation Assets

**Legacy Documentation (75 files):**

```
docs-legacy/
├── Admin-Seller-Portal/              (35 files)
│   ├── prd/                          (10 files - PRD with 98 FRs)
│   ├── architecture/                 (24 files - Technical docs)
│   └── architecture-solution.md      (Workflow artifact)
├── brand-strategy/                   (2 files)
│   ├── brand-guidelines.md           (509 lines)
│   └── color-system-technical.md     (200+ lines)
└── UserApp-Mobile_Web-Flutter/       (38 files)
    ├── prd/                          (10 files)
    └── gcp-deployment-framework/     (28 files)
```

### 2.2 Current Nextra Site Structure

```
bmad-docops/templates/content/
├── _meta.js                          (Root navigation)
├── index.mdx                         (Homepage)
├── changelog.mdx
├── getting-started/
│   ├── _meta.js
│   ├── index.mdx
│   ├── installation.mdx
│   ├── quick-start.mdx
│   └── configuration.mdx
├── guides/
│   └── _meta.js (empty)
├── api/
│   ├── _meta.js
│   └── index.mdx (placeholder)
└── concepts/
    └── _meta.js (empty)
```

### 2.3 Current Custom Components

The platform has 4 custom components in `mdx-components.tsx`:
- `APIEndpoint` - HTTP method badges with path/description
- `VersionBadge` - Version status indicators
- `StoryRef` - JIRA story ID references
- `ChangelogEntry` - Semantic versioning entries

### 2.4 Known Issues (from workflow status)

- **Sidebar not visible** (CSS/layout issue)
- **TOC "On This Page" missing**
- 380+ lines enterprise CSS applied but not working correctly
- Tailwind v4 upgrade complete but styles need adjustment

---

## 3. Gap Analysis

### 3.1 Navigation Gaps

| Gap | Description | Impact | Solution |
|-----|-------------|--------|----------|
| **Generic structure** | Current nav doesn't reflect CurryDash domains | High | Restructure to audience-based |
| **No persona paths** | All users see same content | High | Add audience switcher |
| **Missing breadcrumbs** | Hard to orient in deep content | Medium | Enable Nextra breadcrumbs |
| **No sidebar icons** | Visual hierarchy missing | Low | Add icons to _meta entries |

### 3.2 Content Gaps

| Gap | Description | Impact | Solution |
|-----|-------------|--------|----------|
| **75 unmigrated docs** | Legacy content not accessible | Critical | Migration with _meta mapping |
| **No API reference** | Only placeholder exists | High | Build from Laravel routes |
| **No help center** | End-user support missing | High | Create knowledge base section |
| **No deployment docs** | GCP framework not migrated | Medium | Include in developer docs |

### 3.3 Feature Gaps

| Gap | Description | Impact | Solution |
|-----|-------------|--------|----------|
| **No AI search** | Modern docs have "Ask AI" | Medium | Add Inkeep or Algolia |
| **No version selector** | API versioning unclear | Medium | Add v1/v2 switcher |
| **No llms.txt** | AI crawlers can't prioritize | Low | Create llms.txt file |
| **No code tabs** | Single language examples only | Medium | Multi-language snippets |

### 3.4 UI/UX Gaps vs Enterprise Standards

Based on analysis of Stripe, Vercel, Supabase, and Linear:

| Feature | Enterprise Standard | CurryDash Current | Gap |
|---------|---------------------|-------------------|-----|
| Task-oriented onboarding | Yes | No | High |
| Language tabs in code | Yes | No | Medium |
| Dark mode polish | Yes | Basic | Medium |
| Copy button on code | Yes | Yes | None |
| Keyboard navigation | Yes | Unknown | Low |
| Search suggestions | Yes | No | Medium |

---

## 4. Multi-Audience Documentation Architecture

### 4.1 Audience Identification

From PRD analysis, CurryDash serves 5 distinct audiences:

| Audience | Primary Content Needs | Access Pattern |
|----------|----------------------|----------------|
| **Customers** | App usage, troubleshooting | Help center |
| **Vendors** | Portal usage, menu mgmt, orders | Task guides |
| **Admins** | Platform mgmt, analytics | Reference docs |
| **Backend Developers** | API, architecture, Laravel | Technical docs |
| **Mobile Developers** | Flutter, SDK, integration | Technical docs |

### 4.2 Recommended Information Architecture

```
/ (Homepage - Audience Selector)
│
├── /developers/                       [DEVELOPERS PORTAL]
│   ├── /backend/
│   │   ├── getting-started/
│   │   ├── architecture/              (24 migrated files)
│   │   ├── api-reference/
│   │   │   ├── authentication/
│   │   │   ├── orders/
│   │   │   ├── restaurants/
│   │   │   ├── payments/
│   │   │   └── webhooks/
│   │   └── requirements/              (10 migrated PRD files)
│   ├── /mobile/
│   │   ├── getting-started/
│   │   ├── flutter-architecture/
│   │   ├── state-management/
│   │   ├── api-integration/
│   │   └── requirements/              (10 migrated PRD files)
│   ├── /deployment/
│   │   ├── gcp-cloud-run/             (28 migrated files)
│   │   ├── ci-cd/
│   │   └── security/
│   └── /brand/
│       ├── guidelines/                (Brand guidelines)
│       └── color-system/              (Technical specs)
│
├── /vendors/                          [VENDOR PORTAL]
│   ├── getting-started/
│   │   ├── onboarding/
│   │   ├── account-setup/
│   │   └── first-order/
│   ├── menu-management/
│   │   ├── adding-items/
│   │   ├── curry-packs/
│   │   └── pricing/
│   ├── orders/
│   │   ├── accepting-orders/
│   │   ├── order-status/
│   │   └── refunds/
│   ├── payments/
│   │   ├── payouts/
│   │   └── reports/
│   └── analytics/
│
├── /admins/                           [ADMIN DASHBOARD]
│   ├── getting-started/
│   ├── vendor-management/
│   ├── user-management/
│   ├── analytics/
│   └── support-tools/
│
├── /help/                             [HELP CENTER - Customers]
│   ├── ordering/
│   │   ├── how-to-order/
│   │   ├── tracking/
│   │   └── cancellation/
│   ├── payments/
│   │   ├── methods/
│   │   ├── refunds/
│   │   └── promo-codes/
│   ├── account/
│   │   ├── sign-up/
│   │   ├── password-reset/
│   │   └── settings/
│   └── troubleshooting/
│       ├── app-issues/
│       ├── payment-failed/
│       └── order-not-arriving/
│
├── /api/                              [API REFERENCE]
│   ├── overview/
│   ├── authentication/
│   ├── v2/                            (Current version)
│   │   ├── orders/
│   │   ├── restaurants/
│   │   └── ...
│   └── v1/                            (Legacy - deprecated banner)
│
└── /changelog/
```

### 4.3 Navigation UX Patterns

**Homepage Audience Cards:**
```
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│  I'm building   │ │  I'm a vendor   │ │  I need help    │
│  with CurryDash │ │  on CurryDash   │ │  with my order  │
│                 │ │                 │ │                 │
│  [Developers →] │ │  [Vendors →]    │ │  [Help →]       │
└─────────────────┘ └─────────────────┘ └─────────────────┘
```

**Header Navigation:**
```
[Logo] [Developers ▼] [Vendors] [Admins] [Help]    [Search] [Dark Mode]
```

**Developer Docs Sidebar:**
```
▼ Getting Started
    Quick Start
    Installation
    Configuration
▼ Backend Development
  ▶ Architecture
  ▶ API Reference
  ▶ Requirements (PRD)
▼ Mobile Development
  ▶ Flutter Guide
  ▶ State Management
  ▶ API Integration
▼ Deployment
  ▶ GCP Cloud Run
  ▶ CI/CD Pipelines
───────────────────
▼ Brand Guidelines
    Color System
```

---

## 5. Document Migration Strategy

### 5.1 Migration Mapping

#### Admin-Seller-Portal PRD (10 files)

| Legacy File | Target Path | Notes |
|-------------|-------------|-------|
| `executive-summary.md` | `/developers/backend/requirements/` | Overview page |
| `project-classification.md` | `/developers/backend/requirements/` | Combine with scope |
| `success-criteria.md` | `/developers/backend/requirements/` | Keep as reference |
| `product-scope.md` | `/developers/backend/requirements/` | Roadmap section |
| `user-journeys.md` | `/developers/backend/requirements/` | 7 personas |
| `web-app-api-backend-specific-requirements.md` | `/developers/backend/requirements/` | Technical reqs |
| `project-scoping-phased-development.md` | `/developers/backend/requirements/` | Phases |
| `functional-requirements.md` | `/developers/backend/requirements/` | 98 FRs |
| `non-functional-requirements.md` | `/developers/backend/requirements/` | 53 NFRs |
| `index.md` | `/developers/backend/requirements/` | Section landing |

#### Admin-Seller-Portal Architecture (24 files)

| Legacy File | Target Path | Notes |
|-------------|-------------|-------|
| `overview.md` | `/developers/backend/architecture/` | Landing page |
| `laravel-project-structure.md` | `/developers/backend/architecture/` | Core |
| `design-patterns.md` | `/developers/backend/architecture/` | MVC, Repository |
| `modular-architecture.md` | `/developers/backend/architecture/` | nWidart modules |
| `centrallogics-orchestration-layer-cur.md` | `/developers/backend/architecture/` | CUR layer |
| `package-system-architecture-cpfp.md` | `/developers/backend/architecture/` | CPFP system |
| `subscription-system-architecture.md` | `/developers/backend/architecture/` | Subscriptions |
| `order-system-architecture.md` | `/developers/backend/architecture/` | Orders |
| `restaurant-system-architecture.md` | `/developers/backend/architecture/` | Restaurants |
| `service-layer-business-logic.md` | `/developers/backend/architecture/` | Services |
| `payment-gateway-integration.md` | `/developers/backend/architecture/` | 12+ gateways |
| `notification-system.md` | `/developers/backend/architecture/` | Multi-channel |
| `file-storage-cdn.md` | `/developers/backend/architecture/` | Storage |
| `caching-strategy.md` | `/developers/backend/architecture/` | Redis |
| `authentication-authorization.md` | `/developers/backend/architecture/` | JWT, RBAC |
| `code-organization-principles.md` | `/developers/backend/architecture/` | Patterns |
| `data-flow.md` | `/developers/backend/architecture/` | Request flow |
| `cross-project-integration.md` | `/developers/backend/architecture/` | Mobile ↔ Backend |
| `api-specification.md` | `/api/v2/` | Move to API section |
| `architecture-gaps-future-improvements.md` | `/developers/backend/architecture/` | Gap analysis |
| `next-steps.md` | `/developers/backend/architecture/` | Guidance |
| `table-of-contents.md` | N/A | Replaced by _meta |
| `version-history.md` | `/changelog/` | Merge with changelog |

#### Brand Strategy (2 files)

| Legacy File | Target Path | Notes |
|-------------|-------------|-------|
| `brand-guidelines.md` | `/developers/brand/guidelines/` | Full brand identity |
| `color-system-technical.md` | `/developers/brand/color-system/` | Technical specs |

#### UserApp-Mobile_Web-Flutter PRD (10 files)

| Legacy File | Target Path | Notes |
|-------------|-------------|-------|
| All PRD files | `/developers/mobile/requirements/` | Mirror backend structure |

#### GCP Deployment Framework (28 files)

| Legacy Path | Target Path | Notes |
|-------------|-------------|-------|
| `README.md`, `CLAUDE-GCP-GUIDE.md` | `/developers/deployment/overview/` | Landing |
| `guides/cost-analysis.md` | `/developers/deployment/cost-analysis/` | FinOps |
| `guides/deployment-decision.md` | `/developers/deployment/decision-framework/` | Choices |
| `guides/security-checklist.md` | `/developers/deployment/security/` | Security |
| `workflows/initial-setup.md` | `/developers/deployment/gcp-setup/` | Setup |
| `workflows/ci-cd-setup.md` | `/developers/deployment/ci-cd/` | Pipelines |
| `workflows/deploy-cloud-run.md` | `/developers/deployment/cloud-run/` | Deployment |
| `templates/flutter-web/` | `/developers/deployment/templates/flutter/` | Templates |
| `templates/nextjs/` | `/developers/deployment/templates/nextjs/` | Templates |
| `templates/nodejs/` | `/developers/deployment/templates/nodejs/` | Templates |
| `templates/laravel/` | `/developers/deployment/templates/laravel/` | Templates |
| `templates/react/` | `/developers/deployment/templates/react/` | Templates |

### 5.2 Migration Process

**Phase 1: File Preparation**
1. Copy legacy files to new structure
2. Rename to Nextra conventions (`*.md` → `page.mdx` or `*.mdx`)
3. Add/update frontmatter (title, description)
4. Convert relative links to absolute paths
5. Replace custom TOC with _meta.js

**Phase 2: MDX Conversion**
1. Add Nextra component imports where needed
2. Convert code blocks to tabbed examples
3. Add Callouts for warnings/notes
4. Use Steps for tutorials
5. Add Cards for navigation

**Phase 3: Navigation Setup**
1. Create _meta.js for each directory
2. Configure sidebar ordering
3. Add separators and folder types
4. Test navigation flow

---

## 6. _meta Patterns & MDX Routing

### 6.1 Root Navigation (_meta.js)

```javascript
// content/_meta.js
export default {
  index: {
    title: 'Home',
    type: 'page',
    display: 'hidden',
  },

  // Primary audience sections
  developers: {
    title: 'Developers',
    type: 'menu',
    items: {
      backend: {
        title: 'Backend (Laravel)',
        href: '/developers/backend',
      },
      mobile: {
        title: 'Mobile (Flutter)',
        href: '/developers/mobile',
      },
      deployment: {
        title: 'Deployment',
        href: '/developers/deployment',
      },
      brand: {
        title: 'Brand Guidelines',
        href: '/developers/brand',
      },
    },
  },

  vendors: {
    title: 'Vendors',
    type: 'page',
  },

  admins: {
    title: 'Admins',
    type: 'page',
  },

  help: {
    title: 'Help Center',
    type: 'page',
  },

  api: {
    title: 'API Reference',
    type: 'page',
  },

  '---': {
    type: 'separator',
  },

  changelog: {
    title: 'Changelog',
    type: 'page',
  },

  // External links
  github: {
    title: 'GitHub',
    href: 'https://github.com/CoralShades/currydash-docs',
    newWindow: true,
  },
}
```

### 6.2 Backend Developer Section (_meta.js)

```javascript
// content/developers/backend/_meta.js
export default {
  index: 'Overview',

  '---getting-started': {
    type: 'separator',
    title: 'Getting Started',
  },
  'quick-start': 'Quick Start',
  installation: 'Installation',
  configuration: 'Configuration',

  '---architecture': {
    type: 'separator',
    title: 'Architecture',
  },
  architecture: {
    title: 'System Architecture',
    type: 'folder',
    defaultOpen: false,
  },

  '---requirements': {
    type: 'separator',
    title: 'Requirements',
  },
  requirements: {
    title: 'PRD Reference',
    type: 'folder',
    defaultOpen: false,
  },
}
```

### 6.3 Architecture Folder (_meta.js)

```javascript
// content/developers/backend/architecture/_meta.js
export default {
  index: 'Overview',

  // Core Structure
  'laravel-project-structure': 'Project Structure',
  'design-patterns': 'Design Patterns',
  'modular-architecture': 'Modular Architecture',

  '---systems': {
    type: 'separator',
    title: 'Domain Systems',
  },
  'order-system': 'Order System',
  'restaurant-system': 'Restaurant System',
  'package-system': 'Package System (CPFP)',
  'subscription-system': 'Subscription System',

  '---infrastructure': {
    type: 'separator',
    title: 'Infrastructure',
  },
  authentication: 'Authentication & RBAC',
  'payment-gateway': 'Payment Gateway',
  notifications: 'Notification System',
  'file-storage': 'File Storage & CDN',
  caching: 'Caching Strategy',

  '---integration': {
    type: 'separator',
    title: 'Integration',
  },
  'cross-project': 'Cross-Project Integration',
  'data-flow': 'Data Flow',

  '---appendix': {
    type: 'separator',
    title: 'Appendix',
  },
  'architecture-gaps': 'Gaps & Improvements',
  'code-organization': 'Code Organization',
}
```

### 6.4 API Reference (_meta.js)

```javascript
// content/api/_meta.js
export default {
  index: 'API Overview',
  authentication: 'Authentication',
  'rate-limits': 'Rate Limits',
  errors: 'Error Handling',
  webhooks: 'Webhooks',

  '---endpoints': {
    type: 'separator',
    title: 'Endpoints',
  },

  orders: {
    title: 'Orders',
    type: 'folder',
  },
  restaurants: {
    title: 'Restaurants',
    type: 'folder',
  },
  users: {
    title: 'Users',
    type: 'folder',
  },
  payments: {
    title: 'Payments',
    type: 'folder',
  },
  subscriptions: {
    title: 'Subscriptions',
    type: 'folder',
  },

  '---versioning': {
    type: 'separator',
    title: 'Versioning',
  },

  'v1-deprecated': {
    title: 'v1 (Deprecated)',
    type: 'folder',
    theme: {
      collapsed: true,
    },
  },
}
```

### 6.5 Help Center (_meta.js)

```javascript
// content/help/_meta.js
export default {
  index: 'Help Center',

  ordering: {
    title: 'Ordering',
    type: 'folder',
  },
  payments: {
    title: 'Payments',
    type: 'folder',
  },
  account: {
    title: 'Account',
    type: 'folder',
  },
  troubleshooting: {
    title: 'Troubleshooting',
    type: 'folder',
  },

  '---': {
    type: 'separator',
  },

  'contact-support': {
    title: 'Contact Support',
    href: 'mailto:support@currydash.com',
  },
}
```

### 6.6 MDX Page Template

```mdx
---
title: Order System Architecture
description: Technical documentation for CurryDash order processing system
---

import { Callout, Steps, Tabs, Cards, Card } from 'nextra/components'
import { APIEndpoint, StoryRef } from '../../../mdx-components'

# Order System Architecture

<Callout type="info">
  This document covers the core order processing flow in the CurryDash backend.
</Callout>

## Overview

The order system is built on Laravel's Eloquent ORM with the following key components:

<Cards num={3}>
  <Card title="Order Models" href="#order-models">
    Core data structures for orders
  </Card>
  <Card title="Placement Flow" href="#order-placement-flow">
    End-to-end order creation
  </Card>
  <Card title="Status Machine" href="#order-status-state-machine">
    Order lifecycle management
  </Card>
</Cards>

## Order Models

[Content from legacy order-system-architecture.md...]

## API Endpoints

<APIEndpoint method="POST" path="/v1/orders" description="Create a new order">

### Request Body

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `restaurant_id` | string | Yes | Restaurant identifier |
| `items` | array | Yes | Order items array |

<Tabs items={['cURL', 'JavaScript', 'PHP']}>
  <Tabs.Tab>
```bash copy
curl -X POST https://api.currydash.com/v1/orders \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"restaurant_id": "...", "items": [...]}'
```
  </Tabs.Tab>
  <Tabs.Tab>
```javascript copy
const order = await client.orders.create({
  restaurant_id: 'rest_123',
  items: [{ menu_item_id: 'item_456', quantity: 2 }]
});
```
  </Tabs.Tab>
  <Tabs.Tab>
```php copy
$order = $client->orders->create([
    'restaurant_id' => 'rest_123',
    'items' => [['menu_item_id' => 'item_456', 'quantity' => 2]]
]);
```
  </Tabs.Tab>
</Tabs>

</APIEndpoint>

## Related Documentation

- [Payment Gateway Integration](/developers/backend/architecture/payment-gateway)
- [Restaurant System](/developers/backend/architecture/restaurant-system)
- <StoryRef id="STORY-123" title="Order placement flow implementation" />
```

---

## 7. UI/UX Recommendations

### 7.1 Critical Fixes (Immediate)

#### Fix Sidebar Visibility
```css
/* globals.css - Ensure sidebar is visible */
.nextra-sidebar-container {
  display: flex !important;
  visibility: visible !important;
}

aside.nextra-sidebar {
  width: var(--nextra-sidebar-width, 16rem);
  min-width: var(--nextra-sidebar-width, 16rem);
}
```

#### Fix TOC "On This Page"
```tsx
// app/layout.tsx - Ensure TOC is enabled
<Layout
  toc={{
    float: true,
    title: 'On This Page',
    backToTop: true,
  }}
  // ...other props
>
```

### 7.2 Navigation Enhancements

#### Add Breadcrumbs
```tsx
<Layout
  navigation={{ prev: true, next: true }}
  breadcrumb={{ separator: '/' }}
  // ...
>
```

#### Add Sidebar Icons (with lucide-react)
```javascript
// _meta.js with icons
import { Code, Users, ShoppingCart, HelpCircle } from 'lucide-react'

export default {
  developers: {
    title: 'Developers',
    icon: <Code size={16} />,
  },
  vendors: {
    title: 'Vendors',
    icon: <Users size={16} />,
  },
  // ...
}
```

### 7.3 Search Enhancements

#### Add llms.txt
```text
# public/llms.txt
# CurryDash Documentation - AI Discovery File
# Last updated: 2026-01-21

# Priority content for LLMs
/api/
/developers/backend/architecture/
/developers/mobile/

# Quick references
/developers/backend/quick-start
/vendors/getting-started/
/help/troubleshooting/

# Exclude administrative content
!/admins/internal/
```

#### Enhanced Pagefind Config
```javascript
// next.config.mjs
const withNextra = nextra({
  search: {
    codeblocks: true,
    indexing: {
      weighting: {
        title: 10,
        headings: 5,
        body: 1,
      }
    }
  },
})
```

### 7.4 Code Block Styling

#### Multi-language Tabs Pattern
```mdx
<Tabs items={['npm', 'yarn', 'pnpm', 'bun']} storageKey="pkg-manager">
  <Tabs.Tab>
```bash copy
npm install @currydash/sdk
```
  </Tabs.Tab>
  <Tabs.Tab>
```bash copy
yarn add @currydash/sdk
```
  </Tabs.Tab>
  <Tabs.Tab>
```bash copy
pnpm add @currydash/sdk
```
  </Tabs.Tab>
  <Tabs.Tab>
```bash copy
bun add @currydash/sdk
```
  </Tabs.Tab>
</Tabs>
```

### 7.5 Dark Mode Polish

```css
/* globals.css - Enhanced dark mode */
:root {
  --nextra-primary-hue: 32deg;       /* Turmeric Gold */
  --nextra-primary-saturation: 78%;
  --nextra-primary-lightness: 60%;
}

.dark {
  --nextra-bg: 13 13 13;             /* Not pure black */
  --nextra-primary-lightness: 55%;

  /* Code block backgrounds */
  pre {
    background: rgb(24 24 27) !important;
  }
}

/* API method badges - dark mode */
.dark .api-method-get {
  @apply bg-emerald-900/30 text-emerald-400;
}
.dark .api-method-post {
  @apply bg-sky-900/30 text-sky-400;
}
.dark .api-method-put {
  @apply bg-amber-900/30 text-amber-400;
}
.dark .api-method-delete {
  @apply bg-rose-900/30 text-rose-400;
}
```

### 7.6 New Components to Add

#### VersionSelector Component
```tsx
// components/VersionSelector.tsx
'use client'

import { useRouter, usePathname } from 'next/navigation'

const versions = [
  { value: 'v2', label: 'v2.0 (current)', default: true },
  { value: 'v1', label: 'v1.x (deprecated)' },
]

export function VersionSelector() {
  const router = useRouter()
  const pathname = usePathname()

  return (
    <select
      className="version-selector px-2 py-1 rounded border"
      onChange={(e) => {
        const newPath = pathname.replace(/\/v\d+\//, `/${e.target.value}/`)
        router.push(newPath)
      }}
    >
      {versions.map(v => (
        <option key={v.value} value={v.value}>{v.label}</option>
      ))}
    </select>
  )
}
```

#### AudienceSwitcher Component
```tsx
// components/AudienceSwitcher.tsx
'use client'

import { Cards, Card } from 'nextra/components'
import { Code, Store, Shield, HelpCircle } from 'lucide-react'

export function AudienceSwitcher() {
  return (
    <div className="audience-switcher py-8">
      <h2 className="text-2xl font-bold mb-6 text-center">
        What brings you here today?
      </h2>
      <Cards num={4}>
        <Card
          icon={<Code className="h-8 w-8" />}
          title="I'm building with CurryDash"
          href="/developers"
          arrow
        />
        <Card
          icon={<Store className="h-8 w-8" />}
          title="I'm a restaurant vendor"
          href="/vendors"
          arrow
        />
        <Card
          icon={<Shield className="h-8 w-8" />}
          title="I'm a platform admin"
          href="/admins"
          arrow
        />
        <Card
          icon={<HelpCircle className="h-8 w-8" />}
          title="I need help with my order"
          href="/help"
          arrow
        />
      </Cards>
    </div>
  )
}
```

---

## 8. Enterprise Feature Roadmap

### Phase 1: Foundation (Week 1-2)

| Task | Priority | Effort | Owner |
|------|----------|--------|-------|
| Fix sidebar/TOC visibility | Critical | Low | Frontend |
| Create multi-audience navigation | Critical | Medium | Frontend |
| Migrate 10 backend PRD files | High | Medium | Content |
| Migrate 24 architecture files | High | High | Content |
| Add audience switcher to homepage | High | Low | Frontend |

### Phase 2: Content Migration (Week 3-4)

| Task | Priority | Effort | Owner |
|------|----------|--------|-------|
| Migrate 10 mobile PRD files | High | Medium | Content |
| Migrate 28 deployment files | High | High | Content |
| Migrate 2 brand strategy files | Medium | Low | Content |
| Create API reference structure | High | High | Backend |
| Build vendor getting-started section | High | Medium | Content |

### Phase 3: UX Enhancement (Week 5-6)

| Task | Priority | Effort | Owner |
|------|----------|--------|-------|
| Add code language tabs | High | Medium | Frontend |
| Implement dark mode polish | Medium | Low | Frontend |
| Add version selector for API | Medium | Medium | Frontend |
| Create llms.txt file | Low | Low | Content |
| Add sidebar icons | Low | Low | Frontend |

### Phase 4: Help Center (Week 7-8)

| Task | Priority | Effort | Owner |
|------|----------|--------|-------|
| Create help center landing | High | Medium | Content |
| Write top 10 troubleshooting articles | High | High | Content |
| Add step-by-step screenshots | Medium | High | Content |
| Implement search suggestions | Medium | Medium | Frontend |

### Phase 5: Advanced Features (Week 9+)

| Task | Priority | Effort | Owner |
|------|----------|--------|-------|
| Evaluate AI search (Inkeep/Algolia) | Medium | High | Platform |
| Add MCP server for AI integration | Low | High | Platform |
| Implement feedback widgets | Low | Medium | Frontend |
| Add analytics tracking | Low | Medium | Platform |

---

## 9. Implementation Priorities

### Immediate (This Week)

1. **Fix sidebar visibility** - Debug CSS, ensure Nextra layout works
2. **Fix TOC "On This Page"** - Enable in layout configuration
3. **Create audience-based navigation** - Update root _meta.js

### Short-term (Next 2 Weeks)

1. **Migrate backend architecture docs** (24 files)
2. **Migrate backend PRD docs** (10 files)
3. **Create API reference skeleton**
4. **Build vendor onboarding section**

### Medium-term (Month 1)

1. **Complete all 75 file migrations**
2. **Implement code language tabs**
3. **Add version selector for API**
4. **Create help center with 10+ articles**

### Long-term (Month 2+)

1. **AI-powered search integration**
2. **MCP server for AI assistants**
3. **Analytics and feedback systems**
4. **Automated doc generation from Laravel routes**

---

## Appendix A: File Count Summary

| Category | Files | Status |
|----------|-------|--------|
| Backend PRD | 10 | Pending migration |
| Backend Architecture | 24 | Pending migration |
| Mobile PRD | 10 | Pending migration |
| GCP Deployment | 28 | Pending migration |
| Brand Strategy | 2 | Pending migration |
| Workflow Artifact | 1 | Reference only |
| **Total Legacy** | **75** | |
| Current Nextra | 10 | Active |
| **Total Target** | **85+** | |

---

## Appendix B: Technology Stack Reference

| Component | Current | Recommended |
|-----------|---------|-------------|
| Framework | Next.js 15 | Keep |
| Docs Engine | Nextra 4 | Keep |
| CSS | Tailwind v4 | Keep |
| Search | Pagefind | Enhance |
| AI Search | None | Inkeep or Algolia |
| Icons | None | lucide-react |
| Analytics | None | Plausible or Posthog |

---

*Generated by CurryDash Documentation Analysis Workflow*
*BMAD Method - Phase 1: Analysis*
