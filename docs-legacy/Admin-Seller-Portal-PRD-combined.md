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
# Success Criteria

## Vendor Success (CAR Portal)

**Onboarding Experience**
- New vendors complete self-service onboarding within 48 hours (vs industry 2-4 weeks manual)
- Onboarding completion rate >85% (vendors who start complete the process)
- First order received within 7 days of activation
- Vendor training completion correlates with 3x faster first sale (HungryPanda benchmark)

**Operational Efficiency**
- Order acceptance time <30 seconds with auto-accept option
- Menu updates reflect in customer app within 5 minutes
- Package configuration (curry pack setup) completed in <10 minutes
- Daily order summary accessible in single dashboard view
- Subscription order forecasting visible 7 days in advance

**Business Performance Visibility**
- Vendors can view sales, orders, and earnings in real-time
- Performance comparison against platform averages available
- Customer feedback and ratings accessible within 24 hours
- Revenue reports exportable for accounting purposes

**Vendor Satisfaction**
- Vendor NPS >50 (industry benchmark for "excellent")
- <5% vendor churn rate in first 6 months
- Vendor support ticket resolution <24 hours
- Commission structure transparent with no hidden fees

## Admin Success (CAD Dashboard)

**Platform Operations**
- Dashboard loads in <2 seconds with real-time data
- Platform availability >99.5% during business hours
- Admin can view all pending vendor applications in single queue
- Vendor approval/rejection workflow completes in <5 clicks

**Quality Control**
- Customer complaints visible and actionable within 4 hours
- Vendor performance alerts trigger automatically for declining metrics
- Quality audit workflow tracks issues to resolution
- Cultural authenticity verification checklist for new vendors

**Operational Efficiency**
- Bulk actions available for common admin tasks (approve, suspend, message)
- Search and filter across vendors, orders, customers functional
- Report generation <30 seconds for standard reports
- Export capabilities for all data views

**Business Intelligence**
- Platform-wide metrics visible at-a-glance (orders, revenue, active vendors)
- Trend analysis for key metrics (daily, weekly, monthly)
- Geographic heat maps for order density by suburb
- Subscription vs on-demand order ratio tracking

## Technical Success

**API Performance**
- API response time <200ms for 95th percentile requests
- API availability >99.9%
- Support all 70 frontend PRD functional requirements
- Zero breaking changes to existing mobile/web integrations

**Data Integrity**
- Order data durability 100% (no lost orders)
- Payment transactions atomic (all-or-nothing)
- Subscription schedules accurate across time zones
- Audit trail for all admin actions

**Security & Compliance**
- PCI-DSS compliance for payment handling
- Australian Privacy Principles compliance
- Role-based access control (admin, vendor, support roles)
- Session management with appropriate timeouts

**Scalability**
- Support 10x user growth without re-architecture
- Handle 3x peak load during promotional events
- Database queries <100ms for standard operations

## Business Success

**3-Month Targets (Pre-Launch)**
- Admin Dashboard production-ready (all critical workflows functional)
- Vendor Portal production-ready (onboarding, menu, orders, analytics)
- 100% of JIRA enhancement tickets addressed
- Competitive parity with DoorDash/UberEats merchant tools achieved

**6-Month Targets (Post-Launch)**
- 50+ active vendors onboarded
- Vendor satisfaction NPS >40
- Admin operational efficiency: <2 hours daily for platform management
- <2% critical bug rate in production

**12-Month Targets (Growth)**
- 150+ active vendors across Victoria
- Vendor retention rate >80%
- Platform supports multi-language content (English, Sinhalese, Tamil)
- Subscription orders represent >30% of total volume
- Geographic coverage: Casey, Monash, Greater Dandenong suburbs

## Measurable Outcomes

| Metric | Target | Measurement Method |
|--------|--------|-------------------|
| Vendor Onboarding Time | <48 hours | Time from registration to first order capability |
| Order Acceptance Rate | >95% | Orders accepted vs orders received |
| Order Accuracy | >90% | Orders without customer complaints |
| Vendor Portal Load Time | <2 seconds | Performance monitoring |
| Admin Task Completion | <5 clicks | UX testing for common workflows |
| Vendor NPS | >50 | Quarterly vendor surveys |
| Platform Uptime | >99.5% | Monitoring during business hours |
| API Response Time | <200ms (p95) | APM tooling |
| Customer Complaint Resolution | <24 hours | Support ticket tracking |
| Vendor Churn Rate | <5% | 6-month rolling retention |
# Product Scope

## MVP - Minimum Viable Product

**Vendor Portal (CAR) - Must Have:**
- Self-service vendor registration and onboarding
- Restaurant profile management (hours, location, delivery zones)
- Menu and package management (CRUD for items, curry pack configurations)
- Order dashboard with real-time incoming orders
- Order status workflow (accept, preparing, ready)
- Basic analytics (orders, revenue, ratings)
- Notification system for new orders

**Admin Dashboard (CAD) - Must Have:**
- Vendor application review and approval workflow
- Vendor management (view, edit, suspend, activate)
- Order monitoring and search
- Customer complaint queue
- Basic platform analytics
- User/role management

**Backend APIs (CUR) - Must Have:**
- All endpoints required by frontend PRD (70 FRs)
- Subscription management APIs
- Package configuration APIs
- Payment processing integration (Stripe)
- Push notification triggers

## Growth Features (Post-MVP)

**Vendor Portal Enhancements:**
- Advanced analytics with trend analysis and benchmarking
- Subscription forecasting and demand planning
- Bulk menu operations (import/export, batch updates)
- Multi-location support for vendor chains
- Promotional campaign creation tools
- Customer communication features (respond to reviews)

**Admin Dashboard Enhancements:**
- Advanced reporting with custom report builder
- Geographic analytics and heat maps
- Vendor performance scoring and automated alerts
- Quality audit workflows and checklists
- Bulk operations for common admin tasks
- Financial reconciliation and payout management

**Platform Capabilities:**
- Multi-language content management (Sinhalese, Tamil, English)
- A/B testing infrastructure
- Advanced search with filters and facets
- Integration with external analytics (Google Analytics, Mixpanel)

## Vision (Future)

**Cultural Platform Excellence:**
- AI-powered authenticity verification for vendor cuisine claims
- Community-driven vendor ratings incorporating cultural authenticity
- Heritage storytelling features for vendor profiles
- Cultural event integration (festival menus, seasonal specials)

**Operational Excellence:**
- Fully automated vendor onboarding with document verification
- Predictive demand forecasting for subscription optimization
- Real-time driver tracking integration
- Automated quality control with image recognition

**Scale & Expansion:**
- Multi-region support (other Australian cities)
- White-label vendor portal for enterprise vendors
- API marketplace for third-party integrations
- Self-service analytics with natural language queries
# User Journeys

## Journey 1: Dilan Jayawardena - Scaling Amma's Kitchen for the Digital Age

Dilan runs "Amma's Kitchen," a family restaurant in Dandenong that has been serving traditional Jaffna Tamil cuisine for fifteen years. His mother started the restaurant when they migrated from Sri Lanka in 2005, and now Dilan manages it while she still oversees the kitchen. The restaurant has loyal local customers, but Dilan knows that to secure the family legacy, he needs to reach the broader Sri Lankan diaspora across Victoria.

When CurryDash approaches him about joining the platform, Dilan is skeptical. He's tried UberEats before and found the commission fees devastating and the generic menu presentation insulting to his mother's recipes. But CurryDash is different - they understand that his grandmother's Christmas mutton curry recipe isn't just another "lamb curry" to be buried in a category.

Opening the vendor portal for the first time, Dilan is surprised by how intuitive it feels. He creates his first curry pack - "Amma's Family Feast" - with the configuration builder that lets him offer choices exactly as he would in the restaurant: choose your protein, select your spice level from "Melbourne mild" to "Jaffna fire," pick three sides from his mother's famous array of sambols and mallums. The system even lets him add seasonal availability for his Christmas mutton, which he can only source in December.

The breakthrough moment comes during the first Deepavali after joining CurryDash. The subscription forecasting dashboard shows him that 47 families have pre-ordered his festival pack for the following week. For the first time, he can tell his mother exactly how much to prepare, reducing the usual festival food waste by half. When he checks his monthly analytics, Dilan sees that his average order value has increased by 35% compared to his previous delivery platform, and the "Jaffna fire" spice level has a surprising cult following among non-Sri Lankan customers in Carlton.

Six months later, Dilan is training his nephew on the vendor portal. Amma's Kitchen now has a 4.8 rating with reviews specifically praising the authenticity - something that never happened on UberEats. His mother finally admits that maybe this "computer food ordering" isn't so bad after all.

**Journey Requirements:**
- Package configuration builder with options, spice levels, sides
- Seasonal availability settings
- Subscription forecasting dashboard
- Performance analytics with order value, ratings, trends
- Multi-user access for family business/training
- Cultural authenticity in menu presentation

---

## Journey 2: Amara Wickramasinghe - From Home Kitchen to Cloud Kitchen

Amara is a 34-year-old accountant who arrived in Melbourne from Colombo three years ago. During the pandemic, she started cooking Sri Lankan comfort food for homesick friends and colleagues, and her hoppers and curry became legendary in her apartment building. Everyone keeps telling her she should start a business, but the idea of opening a restaurant feels overwhelming - the rent, the staff, the regulations.

One evening, scrolling through a Sri Lankan community Facebook group, she sees a post about CurryDash's new vendor program specifically designed for home-based and cloud kitchen operators. The post mentions self-service onboarding and no upfront fees. Amara decides to take the leap.

Starting the registration at 9 PM after putting her kids to bed, Amara is guided through a simple step-by-step process. She enters her business details, uploads photos of her kitchen for the food safety check, and provides her ABN and insurance documents. The system immediately tells her what's missing - she needs a specific council permit - and even provides a link to apply. By 10:30 PM, her application is submitted.

Two days later, Amara receives a notification that her application is being reviewed. She can see the status in her vendor dashboard - "Document Verification" with a green checkmark, "Kitchen Assessment" showing "Scheduled for Thursday." An admin named Sarah has left a comment welcoming her and asking if she needs help with anything.

The kitchen assessment happens over video call - much easier than she expected. Sarah explains the platform's quality standards and walks her through the menu setup. Amara creates her first listing: "Amma's Hopper Kit" - a DIY pack with batter, accompaniments, and her grandmother's recipe card. The system suggests pricing based on similar items and delivery zone costs.

Her first order comes on a Friday evening - a subscription for weekly hopper kits from a young family in Box Hill. The mother's message says, "My kids refuse to eat the store-bought ones. Thank you for bringing real hoppers to Melbourne." Amara cries while packing the order. Three months later, she's processing 40 orders per week from her home kitchen and is looking at commercial spaces to expand.

**Journey Requirements:**
- Self-service registration with clear step-by-step guidance
- Document upload and verification tracking
- Application status visibility with admin communication
- Video assessment scheduling integration
- Menu setup wizard with pricing suggestions
- First order celebration/guidance experience
- Status notifications (email, push, SMS)

---

## Journey 3: Kasun Perera - The Dinner Rush Manager

Kasun is 22 years old and works as the evening shift manager at Amma's Kitchen. He's Dilan's nephew, studying business at Monash during the day and running the restaurant floor from 4 PM to close. He doesn't care about analytics or long-term strategy - he just needs to get through the dinner rush without any orders going wrong.

It's Friday evening, 6:47 PM, and the restaurant is filling up with dine-in customers when Kasun's tablet starts pinging. Three CurryDash orders arrive simultaneously - a subscription fulfillment for the Perera family (they order every Friday), a new customer's first order with a note "EXTRA SPICY please, I'm Sri Lankan!", and a complicated custom curry pack with multiple dietary modifications.

Kasun glances at the order dashboard - everything is color-coded. The subscription order is highlighted in blue (regular customer, knows what to expect), the new customer order has an orange "First Order" badge (extra attention needed), and the modified order has yellow tags showing the specific changes from standard. He taps "Accept All" and the orders automatically queue to the kitchen display with preparation priority.

While the kitchen works on the orders, another notification: the delivery driver for the first order will arrive in 12 minutes. Kasun taps the order to mark it as "Preparing" - the system automatically notifies the customer and the driver. When his aunt finishes the subscription order, he marks it "Ready" and sees the driver's location approaching on the mini-map.

Then something goes wrong. The customer with the "EXTRA SPICY" request calls - he received the wrong spice level. Kasun's heart sinks, but the dashboard shows exactly what happened: the kitchen had queued it correctly, but the packaging was swapped. He can see the order details and immediately initiates a replacement, with the system generating a partial refund automatically. The customer receives a push notification explaining what happened and that a new order is being prepared.

By 9:30 PM, the rush is over. Kasun does his shift handover by reviewing the night's stats on the dashboard - 23 orders processed, 22 on time, 1 issue resolved with customer satisfied. He screenshots the summary for Dilan, who's at home for once, and hands off to the closing team.

**Journey Requirements:**
- Real-time order dashboard with color-coding and badges
- Batch accept functionality for multiple orders
- Order status workflow (accept, preparing, ready)
- Driver ETA and location visibility
- Kitchen display system integration
- Issue resolution workflow with automatic refund
- Shift handover summary and reporting
- Mobile-responsive for tablet use

---

## Journey 4: Sarah Mitchell - Guardian of Platform Quality

Sarah has been the Operations Lead at CurryDash for eight months. Before this, she managed restaurant partnerships for a hotel chain, but she was drawn to CurryDash's mission of connecting the Sri Lankan diaspora with authentic cuisine. Her job is to ensure that every vendor on the platform meets quality standards and that customers have consistently excellent experiences.

Monday morning, Sarah opens her admin dashboard with a coffee. The overnight summary shows: 3 new vendor applications pending, 2 vendors with declining ratings flagged for review, and 1 customer escalation about a hygiene concern. She sorts by priority - the hygiene complaint first.

The complaint includes a photo of packaging that looks damaged. Sarah pulls up the vendor's profile - "Spice Route Kitchen" in Footscray - and sees this is their first complaint in three months of operation. She checks the order details, delivery driver notes (nothing unusual), and weather that day (heavy rain, could explain damaged packaging). She drafts a message to the vendor asking for their packaging process and schedules a quality check video call. The system tracks everything in a case file.

Next, the vendor applications. Sarah reviews Amara's application - documents are complete, insurance verified, ABN checks out. The kitchen photos look clean and organized. She schedules the video assessment for Thursday and adds a welcome note. The second application is missing food safety certification - she sends an automated request with clear instructions. The third application concerns her: the menu descriptions are copied from another platform and the "authentic Sri Lankan" claim is paired with photos that look distinctly North Indian. She flags this for cultural authenticity review and adds notes for the community advisor to check.

The afternoon brings a different challenge: "Curry House Victoria" has received five 2-star ratings in the past week, dropping from 4.3 to 3.8. Sarah pulls up the feedback themes - "portion sizes shrinking," "less flavor than before," "not the same as our first order." She recognizes the pattern: cost-cutting that sacrifices quality. She schedules a vendor success call, preparing talking points about long-term customer retention versus short-term savings.

By end of day, Sarah has processed 3 applications, resolved 2 quality issues, and saved one declining vendor from a spiral that would have ended in suspension. Her dashboard shows the week's platform health metrics - 94% positive ratings, 0 critical incidents, 12 new vendors in the pipeline.

**Journey Requirements:**
- Priority-sorted admin dashboard with overnight summary
- Customer complaint workflow with case management
- Vendor profile with complete history and metrics
- Document verification and status tracking
- Video assessment scheduling
- Automated request templates for missing information
- Cultural authenticity flagging and review workflow
- Vendor performance trending and alerts
- Vendor success intervention workflow
- Platform health metrics dashboard

---

## Journey 5: Raj Naidoo - The Problem Solver

Raj works from home in Cranbourne as a part-time customer support agent for CurryDash. He handles the afternoon shift, which covers the pre-dinner surge when customers are placing orders and vendors are ramping up operations. His background as a former restaurant manager means he understands both sides of every complaint.

At 3:15 PM, his first ticket arrives: a customer claiming they never received their order but were charged. Raj opens the case and immediately sees the full picture - order timeline, vendor confirmation, driver GPS tracking, and delivery photo. The photo shows the food at a door, but the customer's address notes say "Unit 4" and the photo clearly shows "Unit 1" on the door. Mystery solved: wrong unit. He contacts the delivery partner for confirmation, processes a full refund for the customer, and sends a polite note with delivery instructions for next time.

The next ticket is trickier. A vendor, "Lakshmi's Kitchen," is furious because a customer left a 1-star review claiming the food was "inauthentic" and "not real Sri Lankan food." Lakshmi, who has been cooking Sri Lankan food for 40 years, is devastated. Raj reads the customer's review carefully - they're comparing it to a different regional style. He responds to the public review explaining regional variations in Sri Lankan cuisine (the platform allows vendor response), flags the review for the community team to add educational context, and calls Lakshmi personally to reassure her. He also adds a note to her vendor profile suggesting she specify "Sinhalese-style" in her menu descriptions.

At 5:30 PM, a subscription billing issue comes in. A customer has been charged twice for their weekly curry pack. Raj investigates - it's a system glitch where the subscription renewed while the customer was also placing a one-time order. He processes the refund immediately, credits the customer's account with a 10% discount code as an apology, and escalates the bug to the tech team with detailed reproduction steps.

By 7 PM, Raj has closed 14 tickets with a 96% satisfaction rating. He flags two systemic issues for the product team and adds three entries to the knowledge base for common questions. His shift notes mention the subscription billing bug as high priority.

**Journey Requirements:**
- Ticket queue with full context (order, vendor, customer, delivery)
- GPS tracking and delivery photo access
- Refund and credit processing tools
- Public review response capability
- Vendor communication tools (call, message)
- Bug/issue escalation workflow
- Knowledge base contribution
- Performance metrics (tickets, satisfaction, resolution time)
- Shift notes and handover

---

## Journey 6: David Chen - The Platform Architect

David is CurryDash's technical co-founder. While he spends most of his time writing code, he's also the super admin who handles system configuration, user management, and the occasional data export for investor reports. He built the original platform on StackFood and is now overseeing the transformation into CurryDash's distinct identity.

It's the first Monday of the month - investor report day. David opens the super admin console and generates the platform metrics export: total GMV, active vendors, customer retention cohorts, and subscription growth. The system packages everything into a formatted spreadsheet that matches their investor template. One click, five minutes saved.

His next task is onboarding the new marketing lead, Priya. He creates her admin account, assigns the "Marketing" role (read access to customer analytics, write access to promotions, no access to vendor financials), and triggers the welcome email with login instructions. The role system means he doesn't have to manually configure each permission.

Then a Slack message from Sarah: "Need to add a new vendor category for 'Cloud Kitchen' separate from 'Restaurant' - changes some onboarding requirements." David opens the system configuration panel and creates the new vendor type with its associated document requirements (no shopfront photos needed, but additional kitchen safety certificate required). He sets it to "Draft" so Sarah can review before it goes live.

At 3 PM, a support escalation reaches him directly: a vendor claims their payout is wrong. David opens the vendor's financial ledger - a complete audit trail of every transaction, commission deduction, and payout. He finds the issue: a manual adjustment was applied incorrectly last month. He corrects it, triggers a catch-up payment, and documents the fix with before/after screenshots for audit purposes.

His final task is the quarterly security review. He exports the user access log showing every admin action for the past 90 days, reviews for anomalies (none found), and updates the audit documentation. The platform is ready for the next phase of growth.

**Journey Requirements:**
- Platform metrics dashboard with export to common formats
- User management with role-based access control
- Role template system with permission bundles
- System configuration panel for business rules
- Vendor type management with conditional requirements
- Financial audit trail with complete transaction history
- Manual adjustment and correction tools
- Comprehensive audit logging
- Security review and access log exports

---

## Journey 7: Nisha Patel - The Vendor Accountant

Nisha runs a small accounting practice in Springvale that specializes in hospitality clients. Five of her clients are now CurryDash vendors, and she spends every month-end reconciling their platform earnings with their business accounts. She's not a daily user, but she needs reliable access to financial data.

It's the 3rd of the month, and Nisha is preparing GST returns for her clients. She logs into the first vendor account - Dilan's Amma's Kitchen - using the accountant access he granted her. The dashboard shows her only what she needs: financial reports, payout history, and tax documentation. No menu management, no order details (privacy), no settings.

She downloads the monthly statement: every order with date, value, commission deducted, and net amount. The GST is broken out clearly - on both the order value and the commission (which she can claim back). The format matches her accounting software's import template perfectly, saving her 30 minutes of data manipulation.

For one vendor, the numbers don't match their bank statement. Nisha opens the payout history and sees the issue immediately: one payout was delayed due to a bank detail error and shows as "Pending" rather than "Completed." She advises her client to update their bank details and moves on.

Her final task is preparing the tax summary for the financial year. She downloads the annual statement for each client, which includes the platform's ABN (for GST credit claims), total earnings, total commissions, and a breakdown by month. Everything she needs for the tax return in one document.

At the end of her CurryDash work, Nisha sends feedback through the accountant portal: "Please add a batch download option so I can get all five client statements at once." Three weeks later, she receives an email that the feature has been implemented.

**Journey Requirements:**
- Accountant/delegated access role with limited permissions
- Financial reports with GST breakdowns
- Payout history with status and bank detail issues
- Accounting software-compatible export formats (CSV, XLSX)
- Annual tax summary document generation
- Multi-vendor batch operations for accountants
- Feedback/feature request submission
- Payout status visibility (completed, pending, failed)

---

## Journey Requirements Summary

| Journey | Key Capabilities Required |
|---------|--------------------------|
| Dilan (Established Vendor) | Package configuration, seasonal availability, subscription forecasting, analytics, multi-user access |
| Amara (New Vendor) | Self-service onboarding, document verification, application tracking, menu wizard, first order guidance |
| Kasun (Vendor Staff) | Real-time order dashboard, batch operations, status workflow, driver tracking, issue resolution, shift handover |
| Sarah (Admin Operations) | Admin dashboard, complaint workflow, vendor review, quality audits, performance alerts, cultural authenticity |
| Raj (Support Agent) | Ticket queue with context, refund tools, review response, escalation, knowledge base, metrics |
| David (Super Admin) | Metrics export, user/role management, system configuration, financial audit, security logs |
| Nisha (Accountant) | Delegated access, financial reports, GST breakdowns, tax summaries, batch exports |

**Critical Path Features (Must exist for core journeys):**
- Vendor onboarding (registration, verification, menu setup)
- Order management (accept, prepare, ready, driver tracking)
- Admin vendor management (review, approve, monitor, intervene)
- Financial/payout system (accurate, auditable, exportable)
- Support tooling (tickets, context, resolution, escalation)
- Role-based access control (owner, staff, admin, support, accountant)
# Web App + API Backend Specific Requirements

## Project-Type Overview

CurryDash Admin-Vendor Portal operates as a dual-interface system:

1. **Blade-Based Web Dashboards (MPA)**: Traditional multi-page application architecture serving authenticated admin and vendor users through server-rendered views
2. **REST API Backend**: JSON-based API layer serving Flutter mobile/web applications for customer-facing features

This hybrid approach leverages Laravel's strengths: Blade templating for complex admin interfaces where SEO is irrelevant, and API controllers for mobile-optimized endpoints.

## API Architecture

**Endpoints Overview:**
- 100+ documented endpoints across Admin, Vendor, and Customer contexts
- Organized by domain: packages, orders, subscriptions, restaurants, authentication
- Follows RESTful conventions with consistent response formatting

**Authentication Model:**
- **Admin/Vendor Dashboards**: Session-based authentication with CSRF protection
- **Customer API**: Laravel Passport (OAuth2) with JWT tokens
- **Guards**: `admin`, `vendor`, `api` (Passport)
- **Role-Based Access Control**: AdminRole model with JSON-based module permissions

**API Versioning:**
- Current: `/api/v1/` (active, 457+ route lines)
- Future: `/api/v2/` (stub exists, migration path available)
- Strategy: URI versioning with backward compatibility window

**Data Formats:**
- Request/Response: JSON (application/json)
- Date format: ISO 8601 (UTC)
- Currency: AUD with 2 decimal precision
- Images: URL references with cloud storage abstraction

**Rate Limiting:**

| Endpoint Category | Limit | Window |
|-------------------|-------|--------|
| Authentication | 5 requests | 1 minute |
| Order Placement | 10 requests | 1 minute |
| General API | 60 requests | 1 minute |
| Admin Dashboard | 120 requests | 1 minute |

**Error Response Format:**
```json
{
  "status": false,
  "message": "Human-readable error description",
  "errors": [
    { "field": "validation_field", "message": "Specific error" }
  ]
}
```

## Web Dashboard Architecture

**Technology Stack:**
- Laravel 9.x (PHP 8.1+)
- Blade templating engine
- jQuery + Bootstrap for admin UI
- AJAX for dynamic operations (sort ordering, status toggles)

**Browser Support:**

| Browser | Minimum Version | Notes |
|---------|----------------|-------|
| Chrome | 90+ | Primary development target |
| Firefox | 88+ | Full support |
| Safari | 14+ | macOS/iOS support |
| Edge | 90+ | Chromium-based |

**Responsive Design:**
- Admin dashboards optimized for desktop (1280px+)
- Vendor dashboards responsive to tablet (768px+) for counter-side order management
- Mobile-first not required (authenticated admin interfaces)

**Performance Targets:**

| Metric | Target | Context |
|--------|--------|---------|
| Dashboard Load (TTI) | <2 seconds | Initial page render |
| AJAX Operations | <500ms | Status updates, filters |
| API Response (p95) | <200ms | Mobile/web app endpoints |
| Database Queries | <100ms | Standard operations |

**Accessibility (WCAG 2.1 Level A):**
- Keyboard navigation for critical workflows
- Proper form labels and error announcements
- Sufficient color contrast (4.5:1 text, 3:1 UI components)
- Focus indicators on interactive elements

## Authentication & Authorization Matrix

**User Roles:**

| Role | Access Scope | Primary Interface |
|------|-------------|-------------------|
| Super Admin | Full platform access | Admin Dashboard |
| Zone Admin | Zone-scoped access | Admin Dashboard |
| Vendor Owner | Own restaurants | Vendor Dashboard |
| Vendor Staff | Delegated permissions | Vendor Dashboard |
| Accountant | Financial reports only | Vendor Dashboard (limited) |
| Support Agent | Ticket queue + read access | Admin Dashboard |
| Customer | Own orders/profile | Mobile/Web App (API) |

**Permission Modules (AdminRole):**
- `order` - Order management and tracking
- `package` - Package configuration CRUD
- `restaurant` - Vendor/restaurant management
- `food` - Menu item management
- `reports` - Analytics and reporting
- `subscription` - Subscription plan management
- `customer` - Customer account management
- `delivery_man` - Delivery personnel management
- `zone` - Geographic zone configuration
- `settings` - System configuration

## Data Integration Points

**External Services:**

| Service | Purpose | Integration Method |
|---------|---------|-------------------|
| Stripe | Payment processing | Stripe PHP SDK |
| Firebase | Push notifications (FCM) | HTTP API |
| SMS Gateway | OTP/notifications | Configurable (Twilio/Nexmo) |
| Cloud Storage | Media files | S3-compatible (AWS/DO Spaces) |
| Email | Transactional emails | Laravel Mail (SMTP) |

**Internal Service Layer:**
- CentralLogics: Orchestration utilities (refactoring to service classes recommended)
- TaxModule: Modular tax calculation service
- Notification system: Multi-channel (push, email, SMS, in-app)

## Implementation Considerations

**Existing Architecture Patterns:**
- Eloquent ORM with global scopes (ZoneScope, RestaurantScope)
- Model accessors for computed properties and image URLs
- Polymorphic relationships for flexible associations
- Transaction-wrapped operations for data integrity

**Technical Debt to Address:**
1. Extract service classes from monolithic CentralLogics
2. Implement comprehensive test coverage (currently 0%)
3. Add queue jobs for async operations (notifications, reports)
4. Standardize API responses with Laravel Resources
5. Implement systematic caching strategy

**Package System Integration:**
The custom Package → Configuration → Option model is fully implemented:
- Admin CRUD with wizard interface
- Vendor CRUD with drag-drop sorting
- API endpoints for mobile consumption
- Cart and order integration complete
# Project Scoping & Phased Development

## MVP Strategy & Philosophy

**MVP Approach:** Platform MVP with Operational Excellence Focus

CurryDash's MVP prioritizes operational capability over feature breadth. The strategy is to enable vendors to serve customers reliably while admins maintain platform quality - a "functioning marketplace" rather than a "feature-complete platform."

**Philosophy Rationale:**
- **Brownfield Advantage**: Existing StackFood codebase provides 80% of infrastructure
- **Vendor-First Launch**: 50+ active vendors needed before customer marketing
- **Quality Over Quantity**: Cultural authenticity positioning requires careful vendor onboarding
- **Subscription Foundation**: Package system (CPFP) is the differentiator - must work flawlessly

**MVP Success Definition:**
"A vendor can register, create curry pack menus, receive orders, and get paid. An admin can approve vendors, monitor quality, and resolve issues. A customer can discover, order, subscribe, and receive food."

## MVP Feature Boundaries

**Essential User Journeys Supported (MVP):**

| Journey | MVP Coverage | Deferred Features |
|---------|--------------|-------------------|
| Dilan (Established Vendor) | Menu mgmt, orders, basic analytics | Advanced forecasting, multi-location |
| Amara (New Vendor) | Registration, onboarding, first order | Video assessment automation |
| Kasun (Vendor Staff) | Order dashboard, status workflow | Kitchen display integration |
| Sarah (Admin Operations) | Vendor review, quality monitoring | Automated alerts, predictive scoring |
| Raj (Support Agent) | Basic ticket queue, refunds | Full case management, knowledge base |
| David (Super Admin) | User/role mgmt, basic exports | Custom report builder, advanced audit |
| Nisha (Accountant) | Financial reports, GST exports | Batch downloads, multi-vendor view |

**Must-Have Capabilities (Phase 1):**

**Vendor Portal (CAR):**
- Self-service registration with document upload
- Restaurant profile management (hours, zones, details)
- Package configuration builder (curry pack setup)
- Menu management (food items, categories, add-ons)
- Real-time order dashboard with accept/prepare/ready workflow
- Basic analytics (orders, revenue, ratings summary)
- Notification system (new orders, status updates)

**Admin Dashboard (CAD):**
- Vendor application queue with approval/rejection
- Vendor profile view and status management
- Order monitoring with search and filters
- Customer complaint queue (basic resolution)
- Platform analytics dashboard (daily/weekly KPIs)
- User and role management (RBAC)

**Backend APIs (CUR):**
- All 70 frontend PRD functional requirements
- Authentication (JWT for mobile, session for dashboards)
- Package and subscription endpoints
- Payment processing (Stripe integration)
- Push notification triggers

## Phased Development Roadmap

**Phase 1: MVP (Production Readiness)**

| Category | Features | Priority |
|----------|----------|----------|
| Vendor Onboarding | Registration, documents, approval workflow | P0 |
| Menu Management | Food CRUD, package configuration, availability | P0 |
| Order Management | Dashboard, status workflow, notifications | P0 |
| Admin Operations | Vendor management, order monitoring, complaints | P0 |
| API Layer | All frontend FR support, authentication, payments | P0 |
| Analytics | Basic metrics (orders, revenue, ratings) | P1 |

**Phase 2: Growth (Post-Launch Enhancement)**

| Category | Features | Priority |
|----------|----------|----------|
| Advanced Analytics | Trend analysis, benchmarking, forecasting | P1 |
| Vendor Tools | Bulk operations, promotional campaigns, customer messaging | P1 |
| Admin Efficiency | Bulk actions, automated alerts, quality audit workflows | P1 |
| Support Tooling | Full case management, knowledge base, escalation paths | P2 |
| Financial Features | Reconciliation, payout management, batch exports | P2 |

**Phase 3: Expansion (Market Leadership)**

| Category | Features | Priority |
|----------|----------|----------|
| Multi-Language | Sinhalese, Tamil content management | P2 |
| Geographic Expansion | Multi-region support, additional suburbs | P2 |
| Cultural Features | Heritage storytelling, authenticity verification | P3 |
| Enterprise | Multi-location vendor support, white-label options | P3 |
| AI/Automation | Demand forecasting, auto quality control, smart routing | P3 |

## Resource Requirements

**MVP Team Composition:**

| Role | Count | Responsibilities |
|------|-------|-----------------|
| Tech Lead / Senior Laravel Dev | 1 | Architecture decisions, code review, complex features |
| Backend Developer | 1-2 | Feature implementation, API development, testing |
| Frontend Developer | 0.5 | Blade template updates, admin UI improvements |
| QA Engineer | 0.5 | Manual testing, regression, UAT coordination |
| Product Manager | 0.5 | Requirements clarification, stakeholder alignment |
| DevOps | 0.25 | Deployment, monitoring, infrastructure |

**Skills Required:**
- Laravel 9.x expertise (Eloquent, Passport, Blade)
- PHP 8.1+ proficiency
- MySQL optimization and query tuning
- REST API design and documentation
- Payment gateway integration (Stripe)
- Git workflow and code review practices

## Risk Mitigation Strategy

**Technical Risks:**

| Risk | Impact | Mitigation |
|------|--------|------------|
| No test coverage (0%) | High | Implement critical path tests first; cover order and payment flows |
| Monolithic CentralLogics | Medium | Incremental service extraction; don't refactor during MVP |
| No queue system | Medium | Accept synchronous operations for MVP; add queues for Phase 2 |
| Performance at scale | Medium | Add caching for hot paths (restaurant lists, menu data) |

**Market Risks:**

| Risk | Impact | Mitigation |
|------|--------|------------|
| Vendor adoption slow | High | Focus on 10-15 pilot vendors for soft launch; white-glove onboarding |
| Competition from majors | Medium | Emphasize cultural niche; avoid head-to-head feature competition |
| Subscription model confusion | Medium | Clear UI differentiation between one-time and subscription orders |

**Resource Risks:**

| Risk | Impact | Mitigation |
|------|--------|------------|
| Key developer unavailable | High | Document architecture decisions; maintain comprehensive docs |
| Scope creep | High | Strict MVP boundary enforcement; defer "nice-to-haves" aggressively |
| Timeline pressure | Medium | Prioritize vendor-facing features; admin polish can follow |

**Contingency Plan (Reduced Resources):**
If resources are limited, prioritize:
1. Vendor order management (must transact)
2. Admin vendor approval (must onboard)
3. Basic analytics (must measure)
4. Advanced features (defer entirely)
# Functional Requirements

## Vendor Account & Onboarding

- **FR1**: Vendor can register for an account with business details and contact information
- **FR2**: Vendor can upload required documents (ABN, food safety certification, insurance)
- **FR3**: Vendor can view the status of their application through the onboarding process
- **FR4**: Vendor can complete restaurant profile with name, description, cuisine type, and branding
- **FR5**: Vendor can set restaurant operating hours and off-days
- **FR6**: Vendor can define delivery zones and radius for their restaurant
- **FR7**: Vendor can add and manage multiple restaurant locations under one account
- **FR8**: Vendor staff can be granted delegated access with specific permissions

## Menu & Package Management

- **FR9**: Vendor can create, edit, and delete food items with descriptions, images, and pricing
- **FR10**: Vendor can organize food items into categories
- **FR11**: Vendor can add variations (size, spice level) to food items with price differences
- **FR12**: Vendor can create add-on groups and individual add-on items
- **FR13**: Vendor can create curry pack packages with configurable options
- **FR14**: Vendor can define configuration groups within packages with min/max choice constraints
- **FR15**: Vendor can assign food items as selectable options within configuration groups
- **FR16**: Vendor can set additional charges for specific package options
- **FR17**: Vendor can reorder configuration groups and options via drag-drop
- **FR18**: Vendor can toggle availability status for food items and packages
- **FR19**: Vendor can set seasonal availability for menu items
- **FR20**: Vendor can upload multiple images per package

## Order Management

- **FR21**: Vendor can view incoming orders in real-time on a dashboard
- **FR22**: Vendor can accept or reject incoming orders
- **FR23**: Vendor can update order status through workflow (accept → preparing → ready)
- **FR24**: Vendor can view order details including items, customizations, and special instructions
- **FR25**: Vendor can identify subscription orders vs one-time orders
- **FR26**: Vendor can view driver location and ETA for pickup
- **FR27**: Vendor can initiate partial or full refunds for orders
- **FR28**: Vendor can view order history with search and filters
- **FR29**: Vendor can generate shift handover summary of orders processed

## Subscription Management

- **FR30**: Admin can create subscription plan templates with features and pricing
- **FR31**: Admin can manage trial periods for subscription plans
- **FR32**: Vendor can view their current subscription status and features
- **FR33**: Vendor can renew or cancel their platform subscription
- **FR34**: Customer subscriptions can be scheduled for recurring delivery (daily/weekly/monthly)
- **FR35**: Customers can pause subscriptions for specified date ranges
- **FR36**: Vendor can view subscription order forecasts for upcoming deliveries
- **FR37**: System can generate subscription orders automatically on scheduled dates

## Analytics & Reporting

- **FR38**: Vendor can view dashboard with key metrics (orders, revenue, ratings)
- **FR39**: Vendor can view sales trends over time (daily, weekly, monthly)
- **FR40**: Vendor can compare performance against platform averages
- **FR41**: Vendor can view customer ratings and feedback
- **FR42**: Vendor can export sales and order reports
- **FR43**: Admin can view platform-wide metrics dashboard
- **FR44**: Admin can view geographic distribution of orders by suburb
- **FR45**: Admin can view subscription vs on-demand order ratios
- **FR46**: Admin can generate and export financial reports

## Admin Operations

- **FR47**: Admin can view queue of pending vendor applications
- **FR48**: Admin can approve or reject vendor applications with notes
- **FR49**: Admin can view and edit vendor profiles
- **FR50**: Admin can suspend or reactivate vendor accounts
- **FR51**: Admin can search and filter vendors by status, zone, and cuisine
- **FR52**: Admin can view vendor performance metrics and ratings history
- **FR53**: Admin can flag vendors for quality review
- **FR54**: Admin can schedule quality check assessments
- **FR55**: Admin can monitor all platform orders with search and filters
- **FR56**: Admin can intervene in order issues (cancel, refund, reassign)

## Customer Support & Complaints

- **FR57**: Support agent can view customer complaint queue
- **FR58**: Support agent can view complete order context (timeline, vendor, driver, photos)
- **FR59**: Support agent can process refunds and credits for customers
- **FR60**: Support agent can respond to public reviews on behalf of vendors
- **FR61**: Support agent can escalate issues to appropriate teams
- **FR62**: Support agent can document resolution in case notes
- **FR63**: Support agent can view and update knowledge base articles

## User & Role Management

- **FR64**: Super admin can create and manage admin accounts
- **FR65**: Super admin can define roles with specific module permissions
- **FR66**: Super admin can assign roles to admin users
- **FR67**: Admin can be scoped to specific zones for filtered access
- **FR68**: Vendor owner can grant staff access with limited permissions
- **FR69**: Accountant role can access financial reports without operational access
- **FR70**: System logs all admin actions for audit trail

## Financial Management

- **FR71**: Vendor can view earnings and commission breakdowns
- **FR72**: Vendor can view payout history with status
- **FR73**: Vendor can request withdrawals from wallet balance
- **FR74**: Vendor can download monthly statements with GST details
- **FR75**: Vendor can generate annual tax summary documents
- **FR76**: Admin can view and manage vendor payout requests
- **FR77**: Admin can process manual adjustments to vendor accounts
- **FR78**: System calculates and deducts platform commission from orders

## Notifications

- **FR79**: Vendor receives notification for new orders
- **FR80**: Vendor receives notification for order status changes
- **FR81**: Customer receives push notifications for order updates
- **FR82**: Admin receives alerts for vendor performance issues
- **FR83**: System sends email notifications for registration and verification
- **FR84**: System sends SMS for critical order updates (configurable)

## System Configuration

- **FR85**: Admin can configure platform-wide business settings
- **FR86**: Admin can manage delivery zones with geographic boundaries
- **FR87**: Admin can create and manage promotional banners
- **FR88**: Admin can configure commission rates and fee structures
- **FR89**: Admin can define vendor categories and cuisine types
- **FR90**: Admin can toggle feature flags for platform capabilities

## API & Integration

- **FR91**: API supports all customer mobile/web app requirements (70 frontend FRs)
- **FR92**: API authenticates customers via JWT tokens
- **FR93**: API supports package listing and customization endpoints
- **FR94**: API supports cart operations with package selections
- **FR95**: API supports order placement with payment processing
- **FR96**: API supports subscription management operations
- **FR97**: System integrates with Stripe for payment processing
- **FR98**: System integrates with Firebase for push notifications
# Non-Functional Requirements

## Performance

- **NFR1**: API responses complete within 200ms for 95th percentile requests
- **NFR2**: Admin/vendor dashboard pages load within 2 seconds (time to interactive)
- **NFR3**: AJAX operations (status updates, filters) complete within 500ms
- **NFR4**: Database queries execute within 100ms for standard operations
- **NFR5**: Real-time order notifications delivered within 3 seconds of order placement
- **NFR6**: Image uploads complete within 5 seconds for files up to 5MB
- **NFR7**: Report generation completes within 30 seconds for standard reports
- **NFR8**: Search results return within 1 second for vendor/order queries

## Security

- **NFR9**: All API communication encrypted via TLS 1.2+ (HTTPS only)
- **NFR10**: Customer passwords hashed using bcrypt with cost factor ≥12
- **NFR11**: JWT tokens expire after 24 hours with refresh token rotation
- **NFR12**: Admin session timeout after 30 minutes of inactivity
- **NFR13**: Payment data handled via Stripe SDK only (no card data stored locally)
- **NFR14**: PCI-DSS compliance maintained through Stripe integration
- **NFR15**: Australian Privacy Principles compliance for personal data handling
- **NFR16**: Role-based access control enforced at API and view layers
- **NFR17**: All admin actions logged with user, timestamp, and action details
- **NFR18**: SQL injection and XSS vulnerabilities prevented through framework protections
- **NFR19**: Rate limiting enforced per endpoint category (auth: 5/min, API: 60/min)
- **NFR20**: File uploads restricted to allowed MIME types and size limits

## Scalability

- **NFR21**: System supports 10x user growth without architecture changes
- **NFR22**: Database handles 100,000+ orders without query degradation
- **NFR23**: Application supports 3x peak load during promotional events
- **NFR24**: Horizontal scaling possible through load balancer and multiple app servers
- **NFR25**: Static assets served through CDN for reduced server load
- **NFR26**: Database connection pooling supports 100+ concurrent connections

## Reliability

- **NFR27**: Platform availability ≥99.5% during business hours (6am-11pm AEST)
- **NFR28**: Order data durability 100% - no orders lost under any failure condition
- **NFR29**: Payment transactions atomic - partial payment states not possible
- **NFR30**: Database backups completed daily with 7-day retention minimum
- **NFR31**: Point-in-time recovery available for database within 24 hours
- **NFR32**: Graceful degradation when external services (Stripe, Firebase) unavailable
- **NFR33**: Automated health checks detect and alert on service degradation
- **NFR34**: Maximum unplanned downtime incident duration: 4 hours

## Accessibility

- **NFR35**: WCAG 2.1 Level A compliance for admin and vendor dashboards
- **NFR36**: All form inputs have associated labels accessible to screen readers
- **NFR37**: Color contrast ratio ≥4.5:1 for text, ≥3:1 for UI components
- **NFR38**: Keyboard navigation functional for all critical workflows
- **NFR39**: Focus indicators visible on all interactive elements
- **NFR40**: Error messages announced to assistive technologies

## Integration

- **NFR41**: Stripe API integration with automatic retry on transient failures
- **NFR42**: Firebase Cloud Messaging integration for push notifications
- **NFR43**: SMS gateway failover between primary and backup providers
- **NFR44**: Cloud storage (S3/DO Spaces) integration with URL signing for secure access
- **NFR45**: Email delivery via SMTP with queuing for burst capacity
- **NFR46**: API versioning supports backward compatibility for one major version
- **NFR47**: Webhook delivery retries 3 times with exponential backoff

## Maintainability

- **NFR48**: Code follows PSR-12 PHP coding standards
- **NFR49**: Critical business logic has automated test coverage
- **NFR50**: Database migrations are reversible and non-destructive
- **NFR51**: Environment configuration externalized via .env files
- **NFR52**: Logging provides sufficient detail for production debugging
- **NFR53**: Dependency versions locked and security updates applied monthly
