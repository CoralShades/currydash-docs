# Executive Summary

CurryDash is transforming from a purchased StackFood codebase into a distinct, market-ready food delivery platform specializing in Sri Lankan "curry pack" meal subscriptions for Victoria, Australia. This PRD defines the requirements for establishing CurryDash's brand identity, operational maturity, and quality assurance infrastructure.

The platform combines HelloFresh-style meal subscriptions with UberEats marketplace dynamics, serving both individual customers seeking authentic Sri Lankan cuisine and vendors looking to reach the Victoria market. The existing Flutter codebase (mobile + web) provides core food delivery functionality; this initiative focuses on differentiation, polish, and operational readiness.

### What Makes This Special

**Market Positioning**: CurryDash addresses an underserved niche - Sri Lankan cuisine delivery with a subscription model - in a market dominated by generic food delivery apps. The curry pack customization system (protein choice, spice levels, dietary options) creates a unique value proposition unavailable in competitors.

**Startup Readiness**: This initiative bridges the gap between "purchased code" and "launch-ready product" by:
- Establishing distinct visual identity separate from StackFood
- Implementing proper project management workflows via Jira
- Building testing infrastructure for quality assurance
- Creating documentation for team scaling and knowledge transfer

**Technical Foundation**: The existing architecture (34 feature modules, 100+ API endpoints, custom package system) provides solid groundwork. This PRD focuses on the final mile - branding, UX polish, testing, and operational tooling.
# Project Classification

**Technical Type:** mobile_app + web_app (Flutter cross-platform)
**Domain:** General (Food delivery marketplace)
**Complexity:** Medium
**Project Context:** Brownfield - extending and branding existing StackFood system

### Scope Categories

1. **Branding & UI/UX**: Visual identity refresh, style guide, asset updates
2. **Project Management**: Jira integration, story templates, sprint planning
3. **Quality Assurance**: Test case creation, Playwright automation, emulator testing
4. **Documentation**: Technical docs, API reference, deployment guides

### Key Integration Points

- Jira MCP for work item management (PACK project)
- Existing docs/project_doc/ business planning documents
- Current architecture patterns in lib/features/
- API endpoints defined in app_constants.dart
# Success Criteria

### User Success

**Customer Success (Post-Launch)**
- Customers can discover and order curry packs within 3 minutes of opening the app
- Package customization (protein, spice, dietary) is intuitive with <5% cart abandonment at customization
- Subscription setup completes in under 2 minutes with clear pricing visibility
- Users recognize CurryDash as distinct from generic food delivery apps

**Developer Success (Immediate)**
- New team members can set up development environment within 1 hour using documentation
- All work items are visible and trackable in Jira with clear acceptance criteria
- Test suite provides >80% confidence in code changes before deployment
- Code changes can be validated locally via emulator/browser before PR

### Business Success

**3-Month Targets (Pre-Launch)**
- Complete brand identity separation from StackFood base code
- 100% of active stories tracked in Jira with story points and due dates
- Automated test coverage for critical user flows (auth, cart, checkout, orders)
- Documentation enables 1-day developer onboarding

**12-Month Targets (Post-Launch)**
- Active user base in Victoria market
- <2% critical bug rate in production
- Subscription retention rate >60%
- Multi-vendor onboarding operational

### Technical Success

**Branding & UI/UX**
- All StackFood references removed from user-facing surfaces
- Consistent CurryDash visual identity across mobile and web
- Style guide documented for future development consistency

**Quality Assurance**
- Playwright test suite covering critical paths
- Emulator testing workflow documented and operational
- Chrome DevTools testing process for web application
- Pre-commit/pre-merge test gates configured

**Project Management**
- All PACK project stories have: summary, description, story points, priority, due date
- Incomplete/missing stories identified and documented
- Sprint planning enabled with proper backlog grooming

**Documentation**
- Technical architecture documented (completed in docs/)
- API reference maintained (completed in docs/)
- Developer setup guide operational
- Test execution guide created

### Measurable Outcomes

| Metric | Target | Measurement |
|--------|--------|-------------|
| Brand Separation | 100% | No StackFood references in UI |
| Story Coverage | 100% | All work tracked in Jira |
| Test Coverage | >80% | Critical flows automated |
| Onboarding Time | <1 day | New dev productive |
| Build Success Rate | >95% | CI pipeline green |
# Product Scope

### MVP - Minimum Viable Product

**Branding (Must Have)**
- App name, icon, and splash screen updated to CurryDash
- Primary color scheme applied consistently
- Logo and brand assets integrated

**Project Management (Must Have)**
- All current PACK stories retrieved and audited
- Missing stories identified and created in Jira
- Story fields populated (points, priority, due dates)

**Testing (Must Have)**
- Critical path test cases defined
- Manual testing checklist operational
- Basic Playwright setup for web

**Documentation (Must Have)**
- Developer setup guide
- Testing guide
- API documentation (completed)

### Growth Features (Post-MVP)

**Branding**
- Full UI/UX refresh with custom components
- Marketing asset library
- App Store/Play Store listing optimization

**Testing**
- Full Playwright test suite
- Mobile emulator CI integration
- Performance benchmarking

**Project Management**
- Automated story creation from templates
- Sprint velocity tracking
- Release management workflow

### Vision (Future)

- Comprehensive design system with CurryDash component library
- Full CI/CD pipeline with automated testing gates
- Self-service vendor onboarding portal
- Customer analytics dashboard
- Multi-region expansion capability
# User Journeys

### Journey 1: Priya Perera - Discovering Authentic Sri Lankan Flavors

Priya is a second-generation Sri Lankan Australian living in Melbourne who misses the home-cooked curries her grandmother used to make. She's tried several food delivery apps but finds the Sri Lankan options limited to a few generic "curry" dishes that don't capture the authentic flavors she remembers. One evening, while scrolling through her phone after a long day at work, she sees a friend's Instagram post about "CurryDash" and decides to download the app.

Opening CurryDash for the first time, Priya is immediately struck by the warm, inviting design with familiar Sri Lankan elements - it feels different from the generic delivery apps. She browses the curry pack options and discovers she can customize her order exactly how she likes it: chicken curry with extra spice level 4, coconut sambol on the side, and string hoppers instead of rice. The subscription option catches her eye - weekly curry packs delivered every Thursday, just like the family dinners she grew up with.

The breakthrough moment comes when her first order arrives. The packaging has cooking instructions in both English and Sinhala, and a QR code links to a video showing traditional serving suggestions. When she tastes the dhal curry, it brings tears to her eyes - it's exactly like her grandmother's recipe. She immediately signs up for the weekly subscription and starts a family group chat to share the discovery with her relatives across Victoria.

**Journey Requirements:**
- Intuitive onboarding with clear value proposition
- Package customization (protein, spice level, sides)
- Subscription management workflow
- Cultural authenticity in brand presentation
- Order tracking and delivery coordination

---

### Journey 2: Priya's Edge Case - Subscription Modification and Issue Resolution

Three months into her subscription, Priya realizes her parents are visiting from Sydney next week and she needs to modify her regular Thursday delivery. She also had an issue last week where one curry container leaked during delivery.

Opening the app, Priya navigates to her subscription settings where she can easily pause next week's delivery with two taps. She appreciates that the app remembers her preference and asks if she wants to add extra portions for her parents instead of skipping entirely. She decides to upgrade to a family pack just for that week.

For the leaking container issue, she finds the "Help" section and can submit a photo of the damaged packaging. Within hours, she receives a credit for her next order and a message that they're investigating the packaging from that vendor. The transparent communication makes her feel valued as a customer.

**Journey Requirements:**
- Subscription pause/modify functionality
- Order history and reorder capability
- Customer support ticketing system
- Issue resolution with photo upload
- Proactive communication system

---

### Journey 3: Marcus Chen - The Developer Onboarding Experience

Marcus is a senior Flutter developer who just joined the CurryDash team. His first task is to implement a new feature for vendor ratings. On his first day, he clones the repository and immediately finds the CLAUDE.md file that explains the project structure and conventions.

Following the documentation in docs/, Marcus sets up his development environment within an hour. He runs `flutter pub get` and the project builds successfully on the first try. When he checks the Jira board (PACK project), he finds his assigned story with clear acceptance criteria, story points, and links to the relevant code sections.

Before starting the implementation, Marcus runs the existing test suite to understand the testing patterns. He writes his feature following the established controller/repository/service pattern, adds tests, and submits a PR. The pre-commit hooks catch a minor style issue before it even reaches code review. His PR is approved and merged the same day.

**Journey Requirements:**
- Comprehensive developer documentation
- Clear project structure and conventions
- Jira stories with complete acceptance criteria
- Automated testing infrastructure
- Pre-commit/pre-merge quality gates
- Code review workflow

---

### Journey 4: Dilan Jayawardena - Vendor Partner Managing Curry Packs

Dilan runs "Amma's Kitchen," a family restaurant in Dandenong that specializes in traditional Jaffna Tamil cuisine. He joined CurryDash to reach customers across Victoria without the overhead of his own delivery fleet. Today, he needs to add a new seasonal curry pack featuring his grandmother's Christmas mutton curry recipe.

Logging into the vendor portal, Dilan navigates to his menu management section. He creates a new package with multiple configuration options: choice of mutton, chicken, or vegetarian; spice levels from mild to "Jaffna fire"; and optional add-ons like love cake for dessert. The system guides him through setting availability (December only), pricing, and preparation time.

When orders start flowing in, Dilan can see the daily summary on his dashboard. He appreciates that orders are grouped by delivery time slots, allowing him to batch preparation efficiently. The platform sends customers updates automatically when he marks orders as "preparing" and "ready for pickup."

**Journey Requirements:**
- Vendor portal for menu/package management
- Package configuration builder (options, variants, pricing)
- Order dashboard with batch views
- Status update workflow
- Seasonal/limited availability settings

---

### Journey 5: Admin Team - Platform Operations and Quality Control

Sarah is a CurryDash operations team member responsible for maintaining platform quality. Each morning, she reviews the admin dashboard for overnight issues: failed payments, customer complaints, vendor performance metrics, and delivery delays.

Today, she notices that a new vendor has received three complaints about portion sizes. She pulls up the vendor's profile, reviews the complaints with attached photos, and drafts a message to the vendor with specific feedback. She can also see the vendor's response rate and average rating trending downward.

Using the admin tools, Sarah creates a task for the quality team to conduct a mystery shopper order from this vendor. She schedules a follow-up reminder and documents everything in the case notes. If the issue persists, she has the ability to temporarily pause the vendor's listings pending review.

**Journey Requirements:**
- Admin dashboard with key metrics
- Complaint/issue management system
- Vendor performance tracking
- Quality control workflow tools
- Case documentation and follow-up
- Vendor status management

---

### Journey Requirements Summary

| Journey | Key Capabilities Required |
|---------|--------------------------|
| Customer - Happy Path | Onboarding, customization, subscription, brand identity |
| Customer - Edge Case | Subscription management, support, issue resolution |
| Developer | Documentation, Jira integration, testing, CI/CD |
| Vendor | Menu management, order dashboard, status updates |
| Admin/Operations | Metrics dashboard, quality control, vendor management |

**Critical Path Features (Must exist for core journeys):**
- Package customization system (existing in codebase)
- Subscription management
- Order tracking
- Vendor portal
- Admin dashboard
- Developer documentation (this PRD initiative)
- Testing infrastructure (this PRD initiative)
- Jira story management (this PRD initiative)
# Innovation & Novel Patterns

### Detected Innovation Areas

**Business Model Innovation: Subscription-Marketplace Hybrid**
CurryDash pioneers a hybrid model combining subscription predictability with marketplace discovery. Customers benefit from HelloFresh-style meal planning convenience while accessing UberEats-style vendor variety. Vendors benefit from subscription-based predictable demand alongside incremental on-demand orders. This dual-revenue model creates stronger unit economics than either model alone.

**Cultural Platform Innovation: Diaspora-First Design**
Unlike generic food delivery apps that treat ethnic cuisines as categories, CurryDash is purpose-built as a cultural connection platform. The product incorporates:
- Authentic cuisine curation with cultural context
- Multi-language support (English, Sinhala, Tamil)
- Heritage storytelling in vendor profiles and packaging
- Community features connecting diaspora members

This transforms food delivery from a transaction into a cultural experience.

**Technical Innovation: Configurable Package System**
The custom package configuration system enables sophisticated meal customization beyond typical food delivery:
- Hierarchical options (protein → preparation → spice → accompaniments)
- Constraint-based choices (minimum/maximum selections per category)
- Dynamic pricing with option-level modifiers
- Vendor-controlled flexibility without code changes

### Market Context & Competitive Landscape

**Market Gap**: Major food delivery apps (UberEats, DoorDash, Menulog) treat Sri Lankan cuisine as a subcategory of "Indian" or "Asian" - losing cultural authenticity and discoverability. No dedicated platform exists for Sri Lankan food delivery with subscription options in Australia.

**Competitive Advantage**: First-mover in the niche with deep cultural authenticity that generic platforms cannot replicate without significant investment.

**Expansion Path**: Success pattern can be replicated for other underserved diaspora cuisines (Ethiopian, Filipino, Vietnamese) using the same platform architecture.

### Validation Approach

| Innovation Area | Validation Method | Success Metric |
|-----------------|-------------------|----------------|
| Hybrid Model | A/B test subscription vs on-demand conversion | >30% subscription uptake |
| Cultural Platform | NPS among Sri Lankan diaspora | >50 NPS score |
| Package System | Customization completion rate | >80% complete customization |
| Niche Strategy | Market penetration in Victoria | >5% of Sri Lankan food orders |

### Risk Mitigation

**Risk: Niche too small**
- Mitigation: Validate Victoria market size before expansion investment
- Fallback: Expand to broader "South Asian" cuisine if pure Sri Lankan insufficient

**Risk: Subscription fatigue**
- Mitigation: Flexible pause/skip functionality, variety rotation
- Fallback: Pivot to on-demand-first with optional subscriptions

**Risk: Cultural authenticity claims challenged**
- Mitigation: Vendor vetting process, community advisory board
- Fallback: Partner with cultural organizations for credibility
# Mobile & Web Application Requirements

### Project-Type Overview

CurryDash is a **Flutter cross-platform application** targeting iOS, Android, and Web from a single codebase. This approach maximizes code reuse while enabling platform-specific optimizations where needed.

**Architecture Pattern:** Feature-first clean architecture with GetX state management
**Codebase:** Single Flutter codebase (`lib/features/`) serving all platforms
**Base:** StackFood Multivendor (commercial solution) with CurryDash customizations

### Platform Requirements

#### Mobile Platforms

| Platform | Minimum Version | Target SDK | Status |
|----------|-----------------|------------|--------|
| iOS | 12.0+ | Latest | Supported |
| Android | API 21+ (Lollipop) | API 34 | Supported |

**Cross-Platform Framework:** Flutter 3.4.4+
**State Management:** GetX with reactive controllers
**Navigation:** GetX named routes (50+ routes defined)

#### Web Platform

| Browser | Minimum Version | Status |
|---------|-----------------|--------|
| Chrome | 88+ | Primary |
| Firefox | 85+ | Supported |
| Safari | 14+ | Supported |
| Edge | 88+ | Supported |

**Web Rendering:** HTML renderer for broad compatibility
**PWA Support:** Service worker enabled for offline capability
**Responsive:** Mobile-first with desktop breakpoints

### Device Permissions & Features

| Permission | Platform | Purpose | Required |
|------------|----------|---------|----------|
| Location | iOS/Android | Delivery address, restaurant discovery | Yes |
| Camera | iOS/Android | Issue reporting photos, profile pics | Optional |
| Push Notifications | iOS/Android | Order updates, promotions | Yes |
| Storage | iOS/Android | Offline data, image cache | Yes |
| Biometrics | iOS/Android | Secure login option | Optional |

**Web Equivalents:**
- Geolocation API for address detection
- File upload for photo submission
- Web Push API for notifications (where supported)
- LocalStorage/IndexedDB for offline data

### Offline Mode Strategy

**Offline Capabilities:**
- Browse cached restaurant/menu data
- View order history
- Access saved addresses and payment methods
- Queue orders for submission when online

**Sync Strategy:**
- Background sync when connectivity restored
- Conflict resolution: Server wins for order state
- Local-first for user preferences

**Implementation:** Drift database for local persistence, API queue for offline actions

### Push Notification Strategy

| Notification Type | Trigger | Priority |
|-------------------|---------|----------|
| Order Confirmed | Order placed | High |
| Order Preparing | Vendor starts prep | Normal |
| Order Ready | Ready for pickup | High |
| Driver Assigned | Delivery assigned | Normal |
| Driver Arriving | ETA < 5 min | High |
| Order Delivered | Delivery complete | Normal |
| Promotions | Marketing campaigns | Low |
| Subscription Reminder | 24h before delivery | Normal |

**Implementation:** Firebase Cloud Messaging (FCM)
**Channels:** Separate channels for orders vs marketing (Android)
**Permissions:** Request at first order, not app launch

### App Store Compliance

#### iOS App Store
- Apple Sign-In required (implemented)
- In-app purchase compliance for subscriptions
- Privacy nutrition labels configured
- App Tracking Transparency (ATT) for advertising

#### Google Play Store
- Google Sign-In supported
- Billing library for subscriptions
- Data safety section configured
- Target API level 34 compliance

#### Common Requirements
- Privacy policy URL
- Terms of service URL
- Age rating: 4+ (no objectionable content)
- Content guidelines compliance

### Responsive Design

**Breakpoints:**

| Breakpoint | Width | Layout |
|------------|-------|--------|
| Mobile | < 600px | Single column, bottom nav |
| Tablet | 600-1024px | Two column, side nav |
| Desktop | > 1024px | Multi-column, top nav |

**Implementation:** `ResponsiveHelper` class in `lib/helper/`
**Web-specific:** Hover states via `lib/common/widgets/hover_widgets/`

### Performance Targets

| Metric | Mobile Target | Web Target |
|--------|---------------|------------|
| Cold Start | < 3s | < 2s (FCP) |
| Screen Transition | < 300ms | < 300ms |
| Image Load | < 1s | < 1s |
| API Response | < 2s | < 2s |
| App Size | < 50MB | N/A |
| Bundle Size | N/A | < 2MB (gzipped) |

### SEO Strategy (Web)

**Focus Areas:**
- Restaurant discovery pages (indexable)
- Menu/package pages (rich snippets)
- Location-based landing pages (local SEO)

**Technical SEO:**
- Server-side rendering for key pages (future)
- Meta tags per route
- Structured data for restaurants/menus
- Sitemap generation

**Current:** Client-side rendering (CSR) - SEO limited
**Future:** Consider Flutter web SEO improvements or SSR gateway

### Accessibility Level

**Target:** WCAG 2.1 AA compliance

**Implementation:**
- Semantic labels on all interactive elements
- Sufficient color contrast (4.5:1 minimum)
- Touch targets minimum 48x48dp
- Screen reader support (TalkBack/VoiceOver)
- Keyboard navigation (web)

### Implementation Considerations

**Platform-Specific Code Patterns:**
```dart
if (ResponsiveHelper.isWeb()) {
  // Web-specific behavior
}
if (GetPlatform.isAndroid || GetPlatform.isIOS) {
  // Mobile-specific behavior
}
```

**Feature Flags:**
- Use conditional compilation for platform-specific features
- Firebase Remote Config for runtime feature toggles

**Testing Strategy:**
- Widget tests for UI components
- Integration tests per platform
- Playwright for web E2E
- Emulator testing for mobile
# Project Scoping & Phased Development

### MVP Strategy & Philosophy

**MVP Approach:** Platform MVP - Establish brand identity and operational foundation
**Context:** Brownfield project enhancing existing StackFood codebase
**Resource Requirements:** 1-2 developers, 1 designer (part-time), 1 PM/QA

### Scope Focus Areas

This initiative focuses on four key areas rather than new feature development:

| Focus Area | Priority | Effort |
|------------|----------|--------|
| Branding & UI/UX | High | Medium |
| Jira Story Management | High | Low |
| Testing Infrastructure | High | Medium |
| Documentation | Medium | Low |

### MVP Feature Set (Phase 1)

**Core Objectives:**
1. Complete brand separation from StackFood
2. All work items tracked in Jira with proper fields
3. Critical path test coverage established
4. Developer documentation operational

**Branding MVP:**
- [ ] App name, icon, splash screen → CurryDash
- [x] **Primary color scheme designed** (Turmeric Gold-led v2.0)
- [x] **Brand guidelines documentation complete** (docs/brand-strategy/)
- [x] **Centralized color constants created** (lib/util/colors.dart)
- [ ] Theme files updated to use new color system (In Progress)
- [ ] Logo assets integrated
- [ ] Remove all StackFood references from UI

**Project Management MVP:**
- [ ] Retrieve all PACK project stories from Jira
- [ ] Audit existing stories for completeness
- [ ] Create missing stories with proper fields
- [ ] Establish story template standards

**Testing MVP:**
- [ ] Define critical path test cases
- [ ] Set up Playwright for web testing
- [ ] Create emulator testing workflow
- [ ] Document manual testing checklist

**Documentation MVP:**
- [ ] Developer setup guide (CLAUDE.md exists)
- [ ] Architecture documentation (docs/architecture.md exists)
- [ ] API reference (docs/api-reference.md exists)
- [ ] Testing guide

### Post-MVP Features

**Phase 2: Brand Polish (Post-MVP)**
- Full UI/UX component refresh
- Custom illustration library
- Marketing asset creation
- App Store/Play Store listing optimization
- Style guide documentation

**Phase 2: Quality Enhancement**
- Expanded Playwright test suite (all user journeys)
- Mobile emulator CI integration
- Performance benchmarking setup
- Automated accessibility testing

**Phase 2: Project Maturity**
- Sprint velocity tracking
- Release management workflow
- Automated deployment pipeline
- Code review guidelines

### Phase 3: Expansion Features

**Advanced Branding:**
- Comprehensive design system
- CurryDash component library
- Dark mode theme
- Animation/motion guidelines

**Advanced Quality:**
- Full CI/CD pipeline with test gates
- Performance monitoring dashboard
- Error tracking integration (Sentry)
- A/B testing infrastructure

**Advanced Operations:**
- Self-service vendor onboarding
- Customer analytics dashboard
- Multi-region expansion capability
- Automated story creation from templates

### Risk Mitigation Strategy

**Technical Risks:**

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| StackFood code entanglement | Medium | High | Systematic audit before changes |
| Test coverage gaps | Medium | Medium | Prioritize critical paths first |
| Build pipeline issues | Low | Medium | Test builds early and often |

**Market Risks:**

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Brand confusion | Low | Medium | Complete visual separation |
| Launch delays | Medium | High | Focus on MVP scope only |

**Resource Risks:**

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Developer availability | Medium | High | Clear story prioritization |
| Design bottleneck | Medium | Medium | Use existing design patterns |

**Contingency Plan:**
If resources are constrained, prioritize in this order:
1. Branding (minimum visual changes for launch)
2. Jira stories (essential for team coordination)
3. Documentation (critical for onboarding)
4. Testing (can be manual initially)

### Success Criteria Alignment

| Scoping Decision | Success Metric Supported |
|------------------|--------------------------|
| Brand MVP | 100% StackFood references removed |
| Jira stories | 100% story coverage |
| Testing MVP | >80% critical path coverage |
| Documentation | <1 day developer onboarding |

### Dependencies & Sequencing

```
Phase 1 Sequence:
1. Jira Audit → Understand current state
2. Branding Assets → Design resources needed
3. Branding Implementation → Code changes
4. Testing Setup → Validate changes
5. Documentation → Capture learnings
```

**Critical Path:** Jira audit informs all other work - must complete first.
# Functional Requirements

### Brand Identity

- FR1: System displays CurryDash branding (name, logo, colors) across all screens
- FR2: System displays CurryDash app icon on device home screens and app stores
- FR3: System displays CurryDash splash screen during app initialization
- FR4: System removes all StackFood references from user-visible interfaces
- FR5: System applies consistent CurryDash color scheme throughout the application

**Status Update (2025-12-10):** Brand Strategy v2.0 completed
- ✅ Brand Guidelines document created ([docs/brand-strategy/brand-guidelines.md](./brand-strategy/brand-guidelines.md))
- ✅ Color System technical specification complete with WCAG 2.1 AA compliance
- ✅ Centralized color constants implemented (`lib/util/colors.dart`)
- ✅ Turmeric Gold-led Sri Lankan spice-inspired palette designed
- 🔄 Theme files and component migration in progress (see Epic 2, Story 2.2)

### Customer Account Management

- FR6: Customers can create an account using email, phone, or social login
- FR7: Customers can authenticate using saved credentials or biometrics
- FR8: Customers can manage their profile information (name, photo, preferences)
- FR9: Customers can save and manage multiple delivery addresses
- FR10: Customers can save and manage payment methods

### Restaurant & Menu Discovery

- FR11: Customers can browse available restaurants filtered by location
- FR12: Customers can search restaurants by name, cuisine type, or dish
- FR13: Customers can view restaurant details including ratings, hours, and delivery info
- FR14: Customers can browse menu items and packages for a selected restaurant
- FR15: Customers can view package details including options, pricing, and customizations

### Package Customization

- FR16: Customers can select configuration options for curry packages (protein, spice level, sides)
- FR17: System enforces minimum and maximum selection constraints per configuration
- FR18: System calculates and displays price adjustments based on selected options
- FR19: Customers can view complete customization summary before adding to cart
- FR20: Vendors can define package configurations without code changes

### Cart & Checkout

- FR21: Customers can add customized packages to cart
- FR22: Customers can modify cart contents (quantity, options, remove items)
- FR23: Customers can apply promotional codes or discounts
- FR24: Customers can select delivery address and time slot
- FR25: Customers can complete payment using saved or new payment methods
- FR26: System confirms order and provides order number

### Subscription Management

- FR27: Customers can subscribe to recurring curry pack deliveries
- FR28: Customers can select subscription frequency and delivery day
- FR29: Customers can pause or skip upcoming subscription deliveries
- FR30: Customers can modify subscription package selections
- FR31: Customers can cancel subscriptions with confirmation
- FR32: System sends subscription reminders before scheduled deliveries

### Order Tracking

- FR33: Customers can view order status in real-time
- FR34: Customers can view order history with details
- FR35: Customers can reorder from previous orders
- FR36: System sends push notifications for order status changes
- FR37: Customers can contact support regarding active orders

### Customer Support

- FR38: Customers can report issues with orders including photo upload
- FR39: Customers can view support ticket status and history
- FR40: System routes issues to appropriate support queues
- FR41: Support staff can view and respond to customer issues

### Vendor Management

- FR42: Vendors can manage restaurant profile and operating hours
- FR43: Vendors can create and edit menu items and packages
- FR44: Vendors can define package configurations and pricing
- FR45: Vendors can set item availability and seasonal offerings
- FR46: Vendors can view incoming orders grouped by time slot
- FR47: Vendors can update order status (preparing, ready)

### Admin Operations

- FR48: Admins can view platform dashboard with key metrics
- FR49: Admins can view and manage customer complaints
- FR50: Admins can view vendor performance metrics
- FR51: Admins can manage vendor status (active, paused, suspended)
- FR52: Admins can create and manage promotional campaigns

### Developer Workflow (This Initiative)

- FR53: Developers can access comprehensive setup documentation
- FR54: Developers can find assigned Jira stories with complete acceptance criteria
- FR55: Developers can run automated tests to validate code changes
- FR56: Developers can validate changes locally via emulator or browser
- FR57: System provides pre-commit quality gates for code submissions

### Project Management (This Initiative)

- FR58: Team can view all work items in Jira with proper categorization
- FR59: Stories contain required fields (points, priority, due date, acceptance criteria)
- FR60: Team can track story status through development lifecycle
- FR61: Team can access story templates for consistent story creation

### Testing Infrastructure (This Initiative)

- FR62: QA can execute Playwright tests for web application
- FR63: QA can execute tests on mobile emulators
- FR64: QA can follow documented manual testing checklists
- FR65: System runs automated tests as part of build process
- FR66: Test results are visible and actionable for development team

### Notifications

- FR67: System sends push notifications for order updates (confirmed, preparing, delivered)
- FR68: System sends notifications for subscription reminders
- FR69: System sends notifications for promotional offers
- FR70: Customers can manage notification preferences
# Non-Functional Requirements

### Performance

**Response Time Requirements:**
- NFR1: App cold start completes within 3 seconds on mobile, 2 seconds on web
- NFR2: Screen transitions complete within 300ms
- NFR3: API responses return within 2 seconds under normal load
- NFR4: Image assets load within 1 second
- NFR5: Search results display within 1 second of query submission
- NFR6: Cart operations (add, update, remove) complete within 500ms

**Capacity Requirements:**
- NFR7: System supports 1,000 concurrent users without performance degradation
- NFR8: System processes up to 100 orders per minute during peak times
- NFR9: Database queries complete within 100ms for standard operations

**App Size:**
- NFR10: Mobile app package size remains under 50MB
- NFR11: Web bundle size (gzipped) remains under 2MB

### Security

**Authentication & Authorization:**
- NFR12: All authentication uses industry-standard protocols (OAuth 2.0, JWT)
- NFR13: Sessions expire after 30 days of inactivity
- NFR14: Failed login attempts are rate-limited (5 attempts per 15 minutes)
- NFR15: Biometric authentication available on supported devices

**Data Protection:**
- NFR16: All data transmitted over HTTPS/TLS 1.2+
- NFR17: Payment card data never stored locally (PCI-DSS compliance)
- NFR18: Sensitive data encrypted at rest in database
- NFR19: Personal data handling complies with Australian Privacy Principles

**Access Control:**
- NFR20: Role-based access control for admin, vendor, and support roles
- NFR21: API endpoints require valid authentication tokens
- NFR22: Admin actions logged for audit trail

### Scalability

**User Growth:**
- NFR23: Architecture supports 10x user growth without re-architecture
- NFR24: Database design supports horizontal scaling
- NFR25: API design supports load balancing across multiple servers

**Peak Load Handling:**
- NFR26: System handles 3x normal traffic during promotional events
- NFR27: Graceful degradation when approaching capacity limits
- NFR28: Queue-based processing for non-critical operations

### Reliability

**Availability:**
- NFR29: System availability target of 99.5% during business hours
- NFR30: Planned maintenance windows outside peak ordering hours (11am-2pm, 5pm-9pm)
- NFR31: Order submission succeeds within 3 retry attempts

**Data Integrity:**
- NFR32: Order data is durable once submission confirmed
- NFR33: Payment transactions are atomic (all-or-nothing)
- NFR34: Subscription schedules maintained accurately across time zones

**Recovery:**
- NFR35: System recovers from failures within 15 minutes
- NFR36: No data loss for confirmed orders during system failures
- NFR37: Offline-queued actions sync when connectivity restored

### Accessibility

**WCAG 2.1 AA Compliance:**
- NFR38: All interactive elements have accessible labels
- NFR39: Color contrast ratio meets 4.5:1 minimum
- NFR40: Touch targets minimum 48x48dp on mobile
- NFR41: Screen reader compatibility (TalkBack, VoiceOver)
- NFR42: Keyboard navigation supported for web application

**Inclusive Design:**
- NFR43: Text resizing supported up to 200% without loss of function
- NFR44: No content relies solely on color to convey information
- NFR45: Form errors clearly identified with text, not just color

### Integration

**External Services:**
- NFR46: Payment gateway integration with 99.9% availability
- NFR47: Google Maps integration for address and location services
- NFR48: Firebase services (Auth, FCM, Analytics) properly configured
- NFR49: Push notification delivery within 30 seconds of trigger

**API Reliability:**
- NFR50: External API failures handled gracefully with user-friendly messages
- NFR51: Circuit breaker pattern for failing external services
- NFR52: Retry logic with exponential backoff for transient failures

### Maintainability (This Initiative)

**Code Quality:**
- NFR53: Code passes Flutter analyzer with zero errors
- NFR54: Test coverage exceeds 80% for critical paths
- NFR55: Build succeeds on first attempt 95% of the time

**Documentation:**
- NFR56: Developer setup documented with <1 hour to productive
- NFR57: API documentation covers all endpoints
- NFR58: Architecture decisions documented in docs/

**Monitoring:**
- NFR59: Application errors logged and accessible for debugging
- NFR60: Build and test results visible to development team
