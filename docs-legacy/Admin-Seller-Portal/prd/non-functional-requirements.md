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
