# GCP Security Checklist

Use this checklist before deploying any application to GCP.

## Pre-Deployment Security

### Secrets Management
- [ ] No secrets in source code
- [ ] No secrets in Docker images
- [ ] No secrets in environment variables (use Secret Manager)
- [ ] `.env` files in `.gitignore`
- [ ] Secrets rotated before going live

### Secret Manager Setup
```bash
# Create secret
echo -n "secret-value" | gcloud secrets create SECRET_NAME --data-file=-

# Grant access to Cloud Run
gcloud secrets add-iam-policy-binding SECRET_NAME \
  --member="serviceAccount:PROJECT_NUMBER-compute@developer.gserviceaccount.com" \
  --role="roles/secretmanager.secretAccessor"
```

### IAM Best Practices
- [ ] Use least privilege principle
- [ ] Service accounts have minimal permissions
- [ ] No user accounts in production IAM
- [ ] Regular IAM audit

### Network Security
- [ ] VPC configured for database access
- [ ] No public Cloud SQL access
- [ ] Firewall rules restricted
- [ ] VPC connector for private connectivity

## Application Security

### Input Validation
- [ ] All user input validated
- [ ] SQL injection prevention
- [ ] XSS protection enabled
- [ ] CSRF tokens implemented

### Authentication
- [ ] Strong password requirements
- [ ] Rate limiting on auth endpoints
- [ ] Session timeout configured
- [ ] JWT expiration set appropriately

### HTTPS
- [ ] HTTPS enforced (Cloud Run default)
- [ ] HSTS header enabled
- [ ] No mixed content

### Headers
```nginx
# Security headers
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
add_header Content-Security-Policy "default-src 'self'" always;
```

## Cloud Run Security

### Container Security
- [ ] Use official base images
- [ ] Keep images updated
- [ ] Run as non-root user
- [ ] No sensitive data in image layers

### Dockerfile Best Practices
```dockerfile
# Use specific version
FROM node:20-alpine

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Don't run as root
```

### Service Configuration
- [ ] Min instances set appropriately
- [ ] Memory/CPU limits defined
- [ ] Concurrency limits set
- [ ] Timeout configured

## Cloud SQL Security

### Instance Security
- [ ] Private IP only (no public IP)
- [ ] SSL/TLS required for connections
- [ ] Authorized networks configured
- [ ] Backup enabled

### Database Security
- [ ] Separate database users per service
- [ ] Strong passwords
- [ ] Minimal privileges per user
- [ ] Regular password rotation

```sql
-- Create user with minimal privileges
CREATE USER 'app_user'@'%' IDENTIFIED BY 'strong_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON app_database.* TO 'app_user'@'%';
FLUSH PRIVILEGES;
```

## Monitoring & Logging

### Logging
- [ ] Application logs enabled
- [ ] No sensitive data in logs
- [ ] Log retention configured
- [ ] Error alerts configured

### Monitoring
- [ ] Uptime checks enabled
- [ ] Performance monitoring enabled
- [ ] Error rate alerts configured
- [ ] Cost alerts configured

## Compliance

### Data Protection
- [ ] Personal data identified
- [ ] Data encryption at rest (GCP default)
- [ ] Data encryption in transit (HTTPS)
- [ ] Data retention policy defined

### Access Control
- [ ] Admin access restricted
- [ ] Audit logging enabled
- [ ] Access reviews scheduled

## Security Scanning

### Automated Scans
```bash
# Scan Docker image
gcloud artifacts docker images scan \
  REGION-docker.pkg.dev/PROJECT/REPO/IMAGE:TAG

# Check vulnerabilities
gcloud artifacts docker images list-vulnerabilities \
  REGION-docker.pkg.dev/PROJECT/REPO/IMAGE@DIGEST
```

### Manual Review
- [ ] Code review for security
- [ ] Dependency audit
- [ ] Third-party library check

## Incident Response

### Preparation
- [ ] Contact list defined
- [ ] Incident playbook created
- [ ] Backup/restore tested
- [ ] Communication plan ready

### Recovery
- [ ] Rollback procedure documented
- [ ] Backup restoration tested
- [ ] Incident post-mortem process

## Post-Deployment

### Regular Tasks
- [ ] Weekly vulnerability scans
- [ ] Monthly access review
- [ ] Quarterly security audit
- [ ] Annual penetration test

### Update Schedule
- [ ] OS/runtime updates
- [ ] Dependency updates
- [ ] Container image updates
