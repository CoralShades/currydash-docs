# Executive Summary

CurryDash Admin-Vendor Portal is the Laravel backend powering a Sri Lankan food delivery marketplace that combines HelloFresh-style meal subscriptions with UberEats marketplace dynamics. This PRD defines the requirements for achieving production readiness across the Admin Dashboard (CAD) and Vendor Portal (CAR), ensuring competitive parity with established food delivery platforms while supporting the unique curry pack subscription model.

The backend serves six interconnected Jira projects (CUR, CAD, CAR, CPFP, PACK, CCW) and must deliver APIs and web interfaces that enable:
- **Vendors** to manage restaurants, curry pack configurations, orders, and subscriptions efficiently
- **Admins** to oversee platform operations, vendor quality, and customer support
- **Frontend apps** (Flutter mobile/web) to deliver seamless customer experiences

This initiative bridges the gap between "functional StackFood codebase" and "launch-ready platform" by implementing research-backed UI/UX patterns, closing feature gaps identified in JIRA, and matching the operational tooling standards of competitors like DoorDash Merchant Portal and UberEats Restaurant Dashboard.

## What Makes This Special

**Subscription-Marketplace Hybrid Backend**: Unlike pure marketplace or pure subscription platforms, CurryDash orchestrates both models simultaneously. The backend must handle subscription scheduling, recurring billing, pause/skip logic, AND on-demand marketplace orders - creating unique orchestration challenges that this PRD addresses.

**Cultural Platform Infrastructure**: The backend supports diaspora-first design with multi-language content management (English, Sinhala, Tamil), vendor heritage storytelling, and cultural authenticity verification workflows that generic food delivery backends don't provide.

**Curry Pack Configuration Engine**: The custom Package → Configuration → Option data model (CPFP) enables HelloFresh-style meal customization with vendor-controlled flexibility. This PRD ensures the admin/vendor interfaces fully leverage this differentiating capability.

**Production Readiness Focus**: This PRD incorporates 60+ research citations on vendor onboarding best practices and admin UI/UX patterns, translating industry standards into CurryDash-specific requirements.
