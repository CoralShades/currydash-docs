# BMAD DocOps - Quick Reference

## Commands

| Command | Description |
|---------|-------------|
| `*paige di` | Initialize docs from planning artifacts |
| `*paige da` | Analyze story for documentation needs |
| `*paige ds` | Sync pending documentation changes |

## File Locations

| Path | Purpose |
|------|---------|
| `docs/content/` | MDX documentation files |
| `docs/content/_meta.js` | Navigation configuration |
| `docs/app/layout.tsx` | Theme and branding |
| `docs/app/api/docs/` | Headless API endpoints |
| `docs/.doc-manifest.yaml` | Documentation tracking |
| `.doc-changes/` | Pending change specifications |

## Nextra Components

```mdx
import { Callout, Cards, Card, Steps, Tabs, Tab, FileTree } from 'nextra/components'

<Callout type="info|warning|error">Content</Callout>

<Cards>
  <Card title="Title" href="/path">Description</Card>
</Cards>

<Steps>
### Step 1
Content
### Step 2
Content
</Steps>

<Tabs items={['Tab1', 'Tab2']}>
  <Tab>Content 1</Tab>
  <Tab>Content 2</Tab>
</Tabs>
```

## BMAD Components

```mdx
import { APIEndpoint, VersionBadge, StoryRef, ChangelogEntry } from '../mdx-components'

<APIEndpoint method="POST" path="/api/endpoint" description="Description">
  Content
</APIEndpoint>

<VersionBadge version="1.0.0" status="stable|beta|deprecated" />

<StoryRef id="STORY-123" title="Optional title" />

<ChangelogEntry version="1.0.0" date="2025-01-17" type="major|minor|patch">
  Content
</ChangelogEntry>
```

## _meta.js Configuration

```javascript
// content/section/_meta.js
export default {
  index: 'Overview',           // Page title
  'page-name': 'Custom Title', // Custom title
  '---': { type: 'separator' }, // Separator
  external: {                  // External link
    title: 'External',
    href: 'https://example.com',
    newWindow: true
  },
  hidden: {                    // Hidden page
    display: 'hidden'
  }
}
```

## API Endpoints

```bash
# Get navigation structure
GET /api/docs

# Get page content
GET /api/docs/getting-started/quick-start

# Search
GET /api/docs/search?q=query
POST /api/docs/search
  { "query": "search term", "limit": 10 }
```

## Scripts

```bash
npm run dev          # Development server with Turbopack
npm run build        # Production build
npm run postbuild    # Generate Pagefind search index
npm run docs:build   # Build + search index
npm run start        # Start production server
```

## Conventional Commits

```
feat(scope): description     → Minor release
fix(scope): description      → Patch release
docs(scope): description     → Patch release
BREAKING CHANGE: description → Major release
```
