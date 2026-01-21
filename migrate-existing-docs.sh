#!/bin/bash
# CurryDash Documentation Migration Script
# Migrates existing documentation from code repositories to docs repo

set -e

echo "CurryDash Documentation Migration"
echo "=================================="
echo ""

# Source directories
BACKEND_DOCS="/d/ailocal/currydash/Admin-Seller_Portal/docs"
MOBILE_DOCS="/d/ailocal/currydash/User-Web-Mobile/docs"

# Destination directory
DOCS_CONTENT="docs/content"

# Check source directories exist
if [ ! -d "$BACKEND_DOCS" ]; then
    echo "Warning: Backend docs directory not found at $BACKEND_DOCS"
fi

if [ ! -d "$MOBILE_DOCS" ]; then
    echo "Warning: Mobile docs directory not found at $MOBILE_DOCS"
fi

# Create destination directories
echo "Creating destination directories..."
mkdir -p "$DOCS_CONTENT/developers/backend/requirements"
mkdir -p "$DOCS_CONTENT/developers/backend/architecture"
mkdir -p "$DOCS_CONTENT/developers/backend/epics"
mkdir -p "$DOCS_CONTENT/developers/frontend/requirements"
mkdir -p "$DOCS_CONTENT/developers/frontend/epics"
mkdir -p "$DOCS_CONTENT/developers/brand"
mkdir -p "$DOCS_CONTENT/developers/deployment"
mkdir -p "$DOCS_CONTENT/api/backend"

# ============================================================
# BACKEND DOCUMENTATION MIGRATION
# ============================================================

echo ""
echo "Migrating Backend Documentation..."

# Migrate PRD
if [ -d "$BACKEND_DOCS/prd" ]; then
    echo "  - Copying PRD files..."
    cp "$BACKEND_DOCS/prd/"*.md "$DOCS_CONTENT/developers/backend/requirements/" 2>/dev/null || true

    # Create navigation meta
    cat > "$DOCS_CONTENT/developers/backend/requirements/_meta.js" << 'EOF'
export default {
  index: 'Overview',
  'executive-summary': 'Executive Summary',
  'project-classification': 'Project Classification',
  'product-scope': 'Product Scope',
  'success-criteria': 'Success Criteria',
  'user-journeys': 'User Journeys',
  'functional-requirements': 'Functional Requirements',
  'non-functional-requirements': 'Non-Functional Requirements',
  'web-app-api-backend-specific-requirements': 'Backend-Specific Requirements',
  'project-scoping-phased-development': 'Phased Development',
}
EOF
fi

# Migrate Architecture
if [ -d "$BACKEND_DOCS/architecture" ]; then
    echo "  - Copying Architecture files..."
    cp "$BACKEND_DOCS/architecture/"*.md "$DOCS_CONTENT/developers/backend/architecture/" 2>/dev/null || true

    # Create navigation meta
    cat > "$DOCS_CONTENT/developers/backend/architecture/_meta.js" << 'EOF'
export default {
  index: 'Overview',
  'table-of-contents': 'Table of Contents',
  'overview': 'Architecture Overview',
  'laravel-project-structure': 'Laravel Project Structure',
  'modular-architecture': 'Modular Architecture',
  'design-patterns': 'Design Patterns',
  'centrallogics-orchestration-layer-cur': 'CentralLogics Layer',
  'package-system-architecture-cpfp': 'Package System (CPFP)',
  'order-system-architecture': 'Order System',
  'restaurant-system-architecture': 'Restaurant System',
  'subscription-system-architecture': 'Subscription System',
  'service-layer-business-logic': 'Service Layer',
  'notification-system': 'Notification System',
  'payment-gateway-integration': 'Payment Gateway',
  'authentication-authorization': 'Auth & Authorization',
  'data-flow': 'Data Flow',
  'caching-strategy': 'Caching Strategy',
  'file-storage-cdn': 'File Storage & CDN',
  'code-organization-principles': 'Code Organization',
  'cross-project-integration': 'Cross-Project Integration',
  'api-specification': 'API Specification',
  'architecture-gaps-future-improvements': 'Gaps & Future',
  'next-steps': 'Next Steps',
  'version-history': 'Version History',
}
EOF
fi

# Migrate Epics
if [ -d "$BACKEND_DOCS/epics" ]; then
    echo "  - Copying Epic files..."
    cp "$BACKEND_DOCS/epics/"*.md "$DOCS_CONTENT/developers/backend/epics/" 2>/dev/null || true

    # Create navigation meta
    cat > "$DOCS_CONTENT/developers/backend/epics/_meta.js" << 'EOF'
export default {
  index: 'Overview',
  'overview': 'Epics Overview',
  'epic-list': 'Epic List',
  'requirements-inventory': 'Requirements Inventory',
  'epic-1-vendor-onboarding-experience': 'Epic 1: Vendor Onboarding',
  'epic-2-menu-curry-pack-management': 'Epic 2: Menu & Curry Pack',
  'epic-3-real-time-order-operations': 'Epic 3: Order Operations',
  'epic-4-admin-vendor-management': 'Epic 4: Admin Vendor Mgmt',
  'epic-5-customer-support-tooling': 'Epic 5: Customer Support',
  'epic-6-platform-access-security': 'Epic 6: Access & Security',
  'epic-7-financial-payout-management': 'Epic 7: Financial Payouts',
  'epic-8-subscription-system': 'Epic 8: Subscriptions',
  'epic-9-analytics-business-intelligence': 'Epic 9: Analytics & BI',
  'epic-10-multi-channel-notifications': 'Epic 10: Notifications',
  'epic-11-platform-configuration-api-foundation': 'Epic 11: Platform Config',
}
EOF
fi

# Migrate Brand Strategy
if [ -d "$BACKEND_DOCS/brand-strategy" ]; then
    echo "  - Copying Brand Strategy files..."
    cp "$BACKEND_DOCS/brand-strategy/"*.md "$DOCS_CONTENT/developers/brand/" 2>/dev/null || true

    cat > "$DOCS_CONTENT/developers/brand/_meta.js" << 'EOF'
export default {
  index: 'Brand Overview',
  'brand-guidelines': 'Brand Guidelines',
  'color-system-technical': 'Color System (Technical)',
}
EOF

    # Create brand index
    cat > "$DOCS_CONTENT/developers/brand/index.mdx" << 'EOF'
---
title: CurryDash Brand Guidelines
description: Brand identity and design system for CurryDash platform
---

# CurryDash Brand Guidelines

Brand identity documentation for the CurryDash platform.

## Brand Colors

| Color | Hex | Usage |
|-------|-----|-------|
| Turmeric Gold | `#E6B04B` | Primary brand color, CTAs, highlights |
| Chili Red | `#C5351F` | Accent, alerts, important actions |
| Curry Leaf Green | `#4A7C59` | Success states, confirmations |

## Documentation

- [Brand Guidelines](/developers/brand/brand-guidelines) - Complete brand identity guide
- [Color System (Technical)](/developers/brand/color-system-technical) - Technical implementation of colors
EOF
fi

# Migrate API Specification
if [ -f "$BACKEND_DOCS/api-specification.md" ]; then
    echo "  - Copying API specification..."
    cp "$BACKEND_DOCS/api-specification.md" "$DOCS_CONTENT/api/backend/" 2>/dev/null || true
fi

if [ -f "$BACKEND_DOCS/architecture/api-specification.md" ]; then
    cp "$BACKEND_DOCS/architecture/api-specification.md" "$DOCS_CONTENT/api/backend/specification.md" 2>/dev/null || true
fi

# Migrate architecture-solution.md
if [ -f "$BACKEND_DOCS/architecture-solution.md" ]; then
    echo "  - Copying architecture solution..."
    cp "$BACKEND_DOCS/architecture-solution.md" "$DOCS_CONTENT/developers/backend/architecture/" 2>/dev/null || true
fi

# ============================================================
# MOBILE/FRONTEND DOCUMENTATION MIGRATION
# ============================================================

echo ""
echo "Migrating Mobile/Frontend Documentation..."

# Migrate PRD
if [ -d "$MOBILE_DOCS/prd" ]; then
    echo "  - Copying PRD files..."
    cp "$MOBILE_DOCS/prd/"*.md "$DOCS_CONTENT/developers/frontend/requirements/" 2>/dev/null || true

    # Create navigation meta
    cat > "$DOCS_CONTENT/developers/frontend/requirements/_meta.js" << 'EOF'
export default {
  index: 'Overview',
  'executive-summary': 'Executive Summary',
  'project-classification': 'Project Classification',
  'product-scope': 'Product Scope',
  'success-criteria': 'Success Criteria',
  'user-journeys': 'User Journeys',
  'functional-requirements': 'Functional Requirements',
  'non-functional-requirements': 'Non-Functional Requirements',
  'mobile-web-application-requirements': 'Mobile/Web Requirements',
  'innovation-novel-patterns': 'Innovation & Patterns',
  'project-scoping-phased-development': 'Phased Development',
}
EOF
fi

# Migrate Epics
if [ -d "$MOBILE_DOCS/epics" ]; then
    echo "  - Copying Epic files..."
    cp "$MOBILE_DOCS/epics/"*.md "$DOCS_CONTENT/developers/frontend/epics/" 2>/dev/null || true

    # Create navigation meta
    cat > "$DOCS_CONTENT/developers/frontend/epics/_meta.js" << 'EOF'
export default {
  index: 'Overview',
  'overview': 'Epics Overview',
  'epic-list': 'Epic List',
  'stories': 'Stories',
  'requirements-inventory': 'Requirements Inventory',
  'fr-coverage-map': 'FR Coverage Map',
  'jira-gap-analysis': 'Jira Gap Analysis',
  'jira-action-plan': 'Jira Action Plan',
  'epic-1-developer-foundation': 'Epic 1: Developer Foundation',
  'epic-2-brand-identity-visual-experience': 'Epic 2: Brand Identity',
  'epic-3-user-account-authentication': 'Epic 3: Authentication',
  'epic-4-location-restaurant-discovery': 'Epic 4: Discovery',
  'epic-5-package-configuration-currydash-differentiator': 'Epic 5: Package Config',
  'epic-6-cart-checkout': 'Epic 6: Cart & Checkout',
  'epic-7-subscription-management': 'Epic 7: Subscriptions',
  'epic-8-order-tracking-history': 'Epic 8: Order Tracking',
  'epic-9-customer-support': 'Epic 9: Support',
  'epic-10-push-notifications': 'Epic 10: Notifications',
  'epic-11-testing-infrastructure': 'Epic 11: Testing',
}
EOF
fi

# ============================================================
# CREATE INDEX FILES
# ============================================================

echo ""
echo "Creating index files..."

# Backend requirements index
cat > "$DOCS_CONTENT/developers/backend/requirements/index.mdx" << 'EOF'
---
title: Backend Requirements (PRD)
description: Product Requirements Documentation for CurryDash Admin/Seller Portal
---

import { Cards, Card } from 'nextra/components'

# Backend Requirements (PRD)

Product Requirements Documentation for the CurryDash Admin/Seller Portal (Laravel Backend).

## Quick Links

<Cards>
  <Card title="Executive Summary" href="/developers/backend/requirements/executive-summary">
    High-level overview of the platform
  </Card>
  <Card title="Functional Requirements" href="/developers/backend/requirements/functional-requirements">
    Detailed functional specifications
  </Card>
  <Card title="User Journeys" href="/developers/backend/requirements/user-journeys">
    User flow documentation
  </Card>
</Cards>

## Document Structure

| Document | Description |
|----------|-------------|
| Executive Summary | Project overview and objectives |
| Project Classification | Platform categorization |
| Product Scope | Features and boundaries |
| Success Criteria | KPIs and metrics |
| User Journeys | User flow documentation |
| Functional Requirements | Feature specifications |
| Non-Functional Requirements | Performance, security, etc. |
| Backend-Specific Requirements | Laravel/API specific needs |
| Phased Development | Implementation roadmap |
EOF

# Backend architecture index
cat > "$DOCS_CONTENT/developers/backend/architecture/index.mdx" << 'EOF'
---
title: Backend Architecture
description: Technical architecture documentation for CurryDash Laravel Backend
---

import { Cards, Card, Callout } from 'nextra/components'

# Backend Architecture

Technical architecture documentation for the CurryDash Laravel Backend.

<Callout type="info">
  This documentation covers the CurryDash-Admin-Seller-Portal repository architecture.
</Callout>

## Core Systems

<Cards>
  <Card title="Modular Architecture" href="/developers/backend/architecture/modular-architecture">
    Module-based Laravel structure
  </Card>
  <Card title="Order System" href="/developers/backend/architecture/order-system-architecture">
    Order processing and management
  </Card>
  <Card title="Package System (CPFP)" href="/developers/backend/architecture/package-system-architecture-cpfp">
    CurryDash Package/Family Pack system
  </Card>
  <Card title="Payment Gateway" href="/developers/backend/architecture/payment-gateway-integration">
    Stripe and payment processing
  </Card>
</Cards>

## Infrastructure

<Cards>
  <Card title="Authentication" href="/developers/backend/architecture/authentication-authorization">
    JWT auth and role-based access
  </Card>
  <Card title="Caching Strategy" href="/developers/backend/architecture/caching-strategy">
    Redis caching implementation
  </Card>
  <Card title="Notification System" href="/developers/backend/architecture/notification-system">
    Multi-channel notifications
  </Card>
</Cards>
EOF

# Backend epics index
cat > "$DOCS_CONTENT/developers/backend/epics/index.mdx" << 'EOF'
---
title: Backend Epics & Stories
description: Implementation epics for CurryDash Admin/Seller Portal
---

import { Cards, Card } from 'nextra/components'

# Backend Epics & Stories

Implementation epics for the CurryDash Admin/Seller Portal backend.

## Epic Overview

| Epic | Title | Status |
|------|-------|--------|
| 1 | Vendor Onboarding Experience | In Progress |
| 2 | Menu & Curry Pack Management | Planned |
| 3 | Real-time Order Operations | Planned |
| 4 | Admin Vendor Management | Planned |
| 5 | Customer Support Tooling | Planned |
| 6 | Platform Access & Security | Planned |
| 7 | Financial Payout Management | Planned |
| 8 | Subscription System | Planned |
| 9 | Analytics & Business Intelligence | Planned |
| 10 | Multi-Channel Notifications | Planned |
| 11 | Platform Configuration & API Foundation | Planned |

## Quick Links

<Cards>
  <Card title="Epic List" href="/developers/backend/epics/epic-list">
    Complete list of all epics
  </Card>
  <Card title="Requirements Inventory" href="/developers/backend/epics/requirements-inventory">
    Requirements mapping
  </Card>
</Cards>
EOF

# Frontend requirements index
cat > "$DOCS_CONTENT/developers/frontend/requirements/index.mdx" << 'EOF'
---
title: Frontend Requirements (PRD)
description: Product Requirements Documentation for CurryDash Mobile/Web Apps
---

import { Cards, Card } from 'nextra/components'

# Frontend Requirements (PRD)

Product Requirements Documentation for the CurryDash Flutter Mobile and Web applications.

## Quick Links

<Cards>
  <Card title="Executive Summary" href="/developers/frontend/requirements/executive-summary">
    High-level overview
  </Card>
  <Card title="Functional Requirements" href="/developers/frontend/requirements/functional-requirements">
    Feature specifications
  </Card>
  <Card title="User Journeys" href="/developers/frontend/requirements/user-journeys">
    Customer flow documentation
  </Card>
</Cards>

## Document Structure

| Document | Description |
|----------|-------------|
| Executive Summary | Project overview |
| Product Scope | Features and boundaries |
| User Journeys | Customer flows |
| Functional Requirements | Feature specs |
| Mobile/Web Requirements | Platform-specific needs |
| Innovation & Patterns | Novel implementations |
EOF

# Frontend epics index
cat > "$DOCS_CONTENT/developers/frontend/epics/index.mdx" << 'EOF'
---
title: Frontend Epics & Stories
description: Implementation epics for CurryDash Mobile/Web Apps
---

import { Cards, Card } from 'nextra/components'

# Frontend Epics & Stories

Implementation epics for the CurryDash Flutter Mobile and Web applications.

## Epic Overview

| Epic | Title | Status |
|------|-------|--------|
| 1 | Developer Foundation | In Progress |
| 2 | Brand Identity & Visual Experience | In Progress |
| 3 | User Account & Authentication | Planned |
| 4 | Location & Restaurant Discovery | Planned |
| 5 | Package Configuration (Differentiator) | Planned |
| 6 | Cart & Checkout | Planned |
| 7 | Subscription Management | Planned |
| 8 | Order Tracking & History | Planned |
| 9 | Customer Support | Planned |
| 10 | Push Notifications | Planned |
| 11 | Testing Infrastructure | Planned |

## Quick Links

<Cards>
  <Card title="Epic List" href="/developers/frontend/epics/epic-list">
    Complete list of all epics
  </Card>
  <Card title="Stories" href="/developers/frontend/epics/stories">
    Story breakdown
  </Card>
</Cards>
EOF

# API Backend index
cat > "$DOCS_CONTENT/api/backend/index.mdx" << 'EOF'
---
title: Backend API Reference
description: REST API documentation for CurryDash Laravel Backend
---

import { Callout } from 'nextra/components'

# Backend API Reference

REST API documentation for the CurryDash Laravel Backend.

<Callout type="info">
  API documentation will be auto-generated from Laravel routes using L5-Swagger.
</Callout>

## Base URLs

| Environment | URL |
|-------------|-----|
| Production | `https://api.currydash.com/v1` |
| Staging | `https://api-staging.currydash.com/v1` |
| Development | `http://localhost:8000/api/v1` |

## Authentication

All API endpoints require Bearer token authentication:

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  https://api.currydash.com/v1/endpoint
```

## API Sections

- Authentication & Users
- Restaurants & Vendors
- Menu & Products
- Orders
- Payments
- Subscriptions
- Admin Operations
EOF

cat > "$DOCS_CONTENT/api/backend/_meta.js" << 'EOF'
export default {
  index: 'Overview',
  'api-specification': 'API Specification',
  'specification': 'OpenAPI Spec',
}
EOF

echo ""
echo "Migration complete!"
echo ""
echo "Files migrated:"
echo "  - Backend PRD: $(ls -1 $DOCS_CONTENT/developers/backend/requirements/*.md 2>/dev/null | wc -l) files"
echo "  - Backend Architecture: $(ls -1 $DOCS_CONTENT/developers/backend/architecture/*.md 2>/dev/null | wc -l) files"
echo "  - Backend Epics: $(ls -1 $DOCS_CONTENT/developers/backend/epics/*.md 2>/dev/null | wc -l) files"
echo "  - Frontend PRD: $(ls -1 $DOCS_CONTENT/developers/frontend/requirements/*.md 2>/dev/null | wc -l) files"
echo "  - Frontend Epics: $(ls -1 $DOCS_CONTENT/developers/frontend/epics/*.md 2>/dev/null | wc -l) files"
echo "  - Brand Strategy: $(ls -1 $DOCS_CONTENT/developers/brand/*.md 2>/dev/null | wc -l) files"
echo ""
echo "Next steps:"
echo "  1. Review migrated files"
echo "  2. Run 'npm run dev' to test locally"
echo "  3. Fix any MDX syntax issues"
echo ""
