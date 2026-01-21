# CurryDash Documentation

Official documentation for the CurryDash platform.

## View Documentation

**Live Site:** https://docs.currydash.com

## Local Development

```bash
cd docs
npm install
npm run dev
```

Visit http://localhost:3000

## Platform Repositories

This documentation repository integrates with:

- **Backend:** [CurryDash-Admin-Seller-Portal](https://github.com/CoralShades/CurryDash-Admin-Seller-Portal)
- **Frontend:** [CurryDash-UserApp-Mobile_Web-Flutter](https://github.com/CoralShades/CurryDash-UserApp-Mobile_Web-Flutter)

## Cross-Repository Integration

Documentation automatically updates when code is pushed to either repository:

1. Developer commits with story ID: `feat: add feature (STORY-123)`
2. Source repo workflow triggers this repo via `repository_dispatch`
3. Change spec created in `.doc-changes/STORY-123.yaml`
4. GitHub issue created for tracking
5. Developer runs `*paige ds` to apply changes
6. Documentation updated and versioned via semantic-release

## BMAD Integration

### Workflows

- `*paige di` - Initialize documentation structure
- `*paige da STORY-123` - Analyze story for documentation needs
- `*paige ds` - Sync pending documentation changes

### Files

- `planning_artifacts/workflows/` - BMAD workflow definitions
- `.doc-changes/` - Pending documentation changes
- `.doc-manifest.yaml` - Documentation tracking

## Deployment

Automatic deployment via GitHub Actions on push to `main`.

## License

MIT
