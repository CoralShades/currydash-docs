---
name: doc-init
title: Initialize Nextra Documentation
description: Generates Nextra 4 documentation from planning artifacts
type: progressive
agent: paige
module: bmad-docops-nextra
---

# Doc Init Workflow

## Purpose

Analyzes planning artifacts and generates the initial Nextra 4 documentation structure.

## Inputs

| Artifact | Required | Description |
|----------|----------|-------------|
| `planning_artifacts/product-brief.md` | Yes | Product brief with vision |
| `planning_artifacts/prd.md` | Yes | Product Requirements |
| `planning_artifacts/architecture.md` | Yes | Technical architecture |
| `planning_artifacts/ux-design.md` | No | UX specifications |

## Steps

### 1. Analyze Artifacts

Extract from planning artifacts:
- Product name, description, tagline
- Feature list for documentation
- API endpoints for reference docs
- User flows for tutorials

### 2. Create Content Structure

Generate Nextra content directory:

```
content/
├── _meta.js           # Root navigation
├── index.mdx          # Homepage
├── getting-started/
│   ├── _meta.js
│   ├── index.mdx
│   ├── installation.mdx
│   └── quick-start.mdx
├── guides/
│   ├── _meta.js
│   └── index.mdx
├── api/
│   ├── _meta.js
│   └── index.mdx
├── concepts/
│   ├── _meta.js
│   └── index.mdx
└── changelog.mdx
```

### 3. Generate _meta.js Files

Create navigation configuration:

```javascript
// content/_meta.js
export default {
  index: { title: 'Home', display: 'hidden' },
  'getting-started': 'Getting Started',
  guides: 'Guides',
  api: 'API Reference',
  concepts: 'Concepts',
  '---': { type: 'separator' },
  changelog: 'Changelog',
}
```

### 4. Generate Homepage

Create `content/index.mdx` with:
- Product introduction
- Quick links (Cards component)
- Feature highlights
- Getting started callout

### 5. Setup Configuration

Copy and customize:
- `next.config.mjs` - Nextra configuration
- `mdx-components.tsx` - Custom MDX components
- `app/layout.tsx` - Theme configuration
- `tailwind.config.js` - Styles

### 6. Create Manifest

Generate `.doc-manifest.yaml`:

```yaml
version: "1.0"
framework: nextra
generated_at: "{timestamp}"
source_artifacts:
  product_brief: planning_artifacts/product-brief.md
  prd: planning_artifacts/prd.md
  architecture: planning_artifacts/architecture.md
content_structure:
  - getting-started/
  - guides/
  - api/
  - concepts/
feature_mapping: {}
story_docs: {}
```

## Output

- Complete Nextra content directory
- Navigation configuration
- Documentation manifest
- Ready to run with `npm run dev`
