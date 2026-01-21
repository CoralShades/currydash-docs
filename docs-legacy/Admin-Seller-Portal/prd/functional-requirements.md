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
