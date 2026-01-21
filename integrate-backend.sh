#!/bin/bash
# CurryDash Backend Repository Integration
# Run this script in the CurryDash-Admin-Seller-Portal repository
# to enable automatic documentation updates

set -e

echo "CurryDash Backend Documentation Integration"
echo "==========================================="
echo ""

# Configuration
ORG_NAME="CoralShades"
DOCS_REPO="currydash-docs"
SOURCE_REPO="CurryDash-Admin-Seller-Portal"

# Create GitHub workflows directory
echo "Creating GitHub Actions workflow..."
mkdir -p .github/workflows

# Create notify-docs workflow
cat > .github/workflows/notify-docs.yml << 'EOF'
name: Notify Documentation Repository

on:
  push:
    branches: [main, master]
  pull_request:
    types: [closed]
    branches: [main, master]

jobs:
  notify-docs:
    runs-on: ubuntu-latest
    if: |
      github.event_name == 'push' ||
      (github.event_name == 'pull_request' && github.event.pull_request.merged == true)
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 2

      - name: Extract story ID from commit
        id: extract
        run: |
          # Get the commit message
          COMMIT_MSG=$(git log -1 --pretty=%B)
          echo "Commit message: $COMMIT_MSG"

          # Extract story ID (format: Stories: STORY-123 or STORY-123)
          STORY_ID=$(echo "$COMMIT_MSG" | grep -oE '(Stories?:?\s*)?[A-Z]+-[0-9]+' | head -1 | grep -oE '[A-Z]+-[0-9]+' || echo "")

          if [ -z "$STORY_ID" ]; then
            echo "No story ID found in commit message"
            STORY_ID="AUTO-$(date +%Y%m%d%H%M%S)"
          fi

          echo "story_id=$STORY_ID" >> $GITHUB_OUTPUT
          echo "commit_sha=${{ github.sha }}" >> $GITHUB_OUTPUT
          echo "commit_message<<EOFMSG" >> $GITHUB_OUTPUT
          echo "$COMMIT_MSG" >> $GITHUB_OUTPUT
          echo "EOFMSG" >> $GITHUB_OUTPUT

      - name: Determine affected documentation sections
        id: sections
        run: |
          # Get changed files
          CHANGED_FILES=$(git diff --name-only HEAD~1 HEAD 2>/dev/null || git diff --name-only HEAD)

          SECTIONS=""

          # Check for API changes
          if echo "$CHANGED_FILES" | grep -qE "(routes|Controllers|api)"; then
            SECTIONS="$SECTIONS api/backend"
          fi

          # Check for database changes
          if echo "$CHANGED_FILES" | grep -qE "(migrations|Models|database)"; then
            SECTIONS="$SECTIONS developers/backend/database"
          fi

          # Check for authentication changes
          if echo "$CHANGED_FILES" | grep -qE "(auth|Auth|login|Login)"; then
            SECTIONS="$SECTIONS developers/backend/api admins/user-management"
          fi

          # Check for vendor/seller changes
          if echo "$CHANGED_FILES" | grep -qE "(vendor|Vendor|seller|Seller|restaurant|Restaurant)"; then
            SECTIONS="$SECTIONS vendors admins/vendor-management"
          fi

          # Check for order changes
          if echo "$CHANGED_FILES" | grep -qE "(order|Order)"; then
            SECTIONS="$SECTIONS vendors/orders"
          fi

          # Check for payment changes
          if echo "$CHANGED_FILES" | grep -qE "(payment|Payment|payout|Payout)"; then
            SECTIONS="$SECTIONS vendors/payments"
          fi

          # Default to general backend if no specific section matched
          if [ -z "$SECTIONS" ]; then
            SECTIONS="developers/backend"
          fi

          echo "sections=$SECTIONS" >> $GITHUB_OUTPUT
          echo "Affected sections: $SECTIONS"

      - name: Trigger documentation update
        uses: peter-evans/repository-dispatch@v2
        with:
          token: ${{ secrets.DOCS_REPO_TOKEN }}
          repository: CoralShades/currydash-docs
          event-type: docs-update
          client-payload: |
            {
              "source_repo": "CurryDash-Admin-Seller-Portal",
              "story_id": "${{ steps.extract.outputs.story_id }}",
              "sections": "${{ steps.sections.outputs.sections }}",
              "commit_sha": "${{ steps.extract.outputs.commit_sha }}",
              "commit_message": "${{ steps.extract.outputs.commit_message }}"
            }

      - name: Log notification
        run: |
          echo "Documentation update notification sent!"
          echo "Story ID: ${{ steps.extract.outputs.story_id }}"
          echo "Sections: ${{ steps.sections.outputs.sections }}"
EOF

# Create manual trigger script
mkdir -p scripts
cat > scripts/trigger-docs-update.sh << 'EOF'
#!/bin/bash
# Manual trigger for documentation updates
# Usage: ./scripts/trigger-docs-update.sh STORY-123

STORY_ID=${1:-"MANUAL-$(date +%Y%m%d%H%M%S)"}
SECTIONS=${2:-"developers/backend"}

echo "Triggering documentation update..."
echo "Story ID: $STORY_ID"
echo "Sections: $SECTIONS"

# This requires GitHub CLI (gh) to be installed and authenticated
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  /repos/CoralShades/currydash-docs/dispatches \
  -f event_type='docs-update' \
  -f 'client_payload[source_repo]=CurryDash-Admin-Seller-Portal' \
  -f "client_payload[story_id]=$STORY_ID" \
  -f "client_payload[sections]=$SECTIONS" \
  -f "client_payload[commit_sha]=$(git rev-parse HEAD)" \
  -f "client_payload[commit_message]=$(git log -1 --pretty=%B)"

echo "Done! Check https://github.com/CoralShades/currydash-docs/actions"
EOF

chmod +x scripts/trigger-docs-update.sh

# Update README with docs link
if [ -f "README.md" ]; then
    echo ""
    echo "Adding documentation link to README..."

    # Check if docs link already exists
    if ! grep -q "currydash-docs" README.md; then
        cat >> README.md << 'EOF'

## Documentation

Full platform documentation is available at: **https://docs.currydash.com**

- [Backend Development Guide](https://docs.currydash.com/developers/backend)
- [API Reference](https://docs.currydash.com/api/backend)
- [Admin Guide](https://docs.currydash.com/admins)
- [Vendor Guide](https://docs.currydash.com/vendors)

### Documentation Updates

This repository automatically triggers documentation updates on commits to `main`.

To manually trigger a documentation update:
```bash
./scripts/trigger-docs-update.sh STORY-123 "developers/backend api"
```
EOF
    fi
fi

# Create CONTRIBUTING.md
cat > CONTRIBUTING.md << 'EOF'
# Contributing to CurryDash Admin/Seller Portal

## Commit Message Format

Use conventional commits with story IDs for automatic documentation updates:

```
feat(auth): implement JWT authentication

Added JWT token generation and validation.
Includes refresh token mechanism.

Stories: STORY-123
```

### Commit Types

- `feat` - New feature (minor version bump)
- `fix` - Bug fix (patch version bump)
- `docs` - Documentation changes
- `style` - Code style changes (formatting, etc.)
- `refactor` - Code refactoring
- `test` - Adding or updating tests
- `chore` - Maintenance tasks

### Story ID Format

Include the story ID in your commit message to trigger documentation updates:

```
Stories: STORY-123
```

or simply include the ID anywhere in the message:

```
feat: add user registration STORY-456
```

## Documentation Updates

When your commit is merged to `main`:

1. GitHub Actions extracts the story ID
2. Determines affected documentation sections
3. Triggers the documentation repository
4. Creates a change spec for review
5. Documentation team applies changes

## Pull Requests

1. Create a feature branch from `main`
2. Make your changes with appropriate commit messages
3. Submit a pull request with a clear description
4. Wait for code review and CI checks
5. Merge when approved

## Questions?

- Documentation: https://docs.currydash.com
- Issues: Create a GitHub issue
EOF

echo ""
echo "Integration complete!"
echo ""
echo "Next steps:"
echo ""
echo "   1. Add DOCS_REPO_TOKEN secret to this repository:"
echo "      - Go to: GitHub repo Settings > Secrets and variables > Actions"
echo "      - Create new secret: DOCS_REPO_TOKEN"
echo "      - Value: Your GitHub Personal Access Token with 'repo' and 'workflow' scopes"
echo ""
echo "   2. Commit and push these changes:"
echo "      git add ."
echo "      git commit -m 'feat: integrate documentation automation'"
echo "      git push origin main"
echo ""
echo "   3. Test the integration:"
echo "      Make a commit with a story ID and check GitHub Actions"
echo ""
