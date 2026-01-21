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
