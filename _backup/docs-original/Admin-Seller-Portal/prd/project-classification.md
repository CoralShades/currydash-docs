# Project Classification

**Technical Type:** web_app + api_backend (Laravel 9.x serving Flutter apps + Blade dashboards)
**Domain:** General (Food delivery marketplace)
**Complexity:** Medium (multi-vendor, subscriptions, Stripe payments)
**Project Context:** Brownfield - extending existing StackFood-based system

## Scope Categories

1. **Vendor Portal (CAR)** - Menu management, order fulfillment, analytics, subscription handling
2. **Admin Dashboard (CAD)** - Platform operations, vendor management, quality control, reporting
3. **Backend APIs (CUR)** - Endpoints supporting frontend PRD requirements (70 FRs)
4. **Package System (CPFP)** - Admin/vendor interfaces for curry pack configuration

## Key Integration Points

- Frontend PRD (User-Web-Mobile) - 70 functional requirements to support
- Existing architecture patterns in `app/Http/Controllers/`
- CentralLogics orchestration layer
- JIRA ticket enhancements (priority gaps to close)
- Research documents (UI/UX patterns, vendor onboarding best practices)
