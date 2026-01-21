# BMAD DocOps - Nextra 4 Integration

Automated documentation generation for BMAD Method projects using Nextra 4.

## Features

- 📚 **Nextra 4** - Next.js App Router based documentation
- 🔍 **Pagefind Search** - Rust-powered full-text search
- 🔌 **Headless API** - REST endpoints for custom frontends
- 🚀 **Semantic Release** - Automated versioning and changelogs
- 🤖 **BMAD Integration** - Automatic doc generation from stories

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│  Nextra 4 Documentation Site (Source of Truth)                  │
│  ├── content/          ← MDX documentation files                │
│  ├── app/api/docs/     ← Headless API endpoints                 │
│  └── public/_pagefind/ ← Search index                           │
├─────────────────────────────────────────────────────────────────┤
│  Headless API Layer                                             │
│  GET  /api/docs           → Page map (navigation)               │
│  GET  /api/docs/[...slug] → Compiled MDX content                │
│  POST /api/docs/search    → Search results                      │
├─────────────────────────────────────────────────────────────────┤
│  Future: Custom Frontend                                        │
│  └── Fetches docs via API, custom branding & design             │
└─────────────────────────────────────────────────────────────────┘
```

## Quick Start

### 1. Copy templates to your BMAD project

```bash
# From bmad-docops directory
cp -r templates/* /path/to/your/bmad-project/docs/
```

### 2. Install dependencies

```bash
cd /path/to/your/bmad-project/docs
npm install
```

### 3. Start development server

```bash
npm run dev
```

Visit `http://localhost:3000` to see your docs.

## BMAD Workflow Commands

| Command | Description |
|---------|-------------|
| `*paige di` | Initialize docs from planning artifacts |
| `*paige da` | Analyze completed story for doc needs |
| `*paige ds` | Sync pending documentation changes |

## File Structure

```
your-bmad-project/
├── planning_artifacts/      # BMAD planning docs (input)
│   ├── product-brief.md
│   ├── prd.md
│   └── architecture.md
├── implementation_artifacts/ # BMAD stories
│   └── stories/
├── docs/                    # Nextra documentation site
│   ├── content/             # MDX content files
│   │   ├── _meta.js         # Navigation config
│   │   ├── index.mdx        # Homepage
│   │   ├── getting-started/
│   │   ├── guides/
│   │   ├── api/
│   │   └── concepts/
│   ├── app/                 # Next.js App Router
│   │   ├── layout.tsx       # Root layout with theme
│   │   ├── globals.css
│   │   ├── docs/[[...mdxPath]]/page.tsx
│   │   └── api/docs/        # Headless API
│   ├── next.config.mjs
│   ├── mdx-components.tsx
│   ├── package.json
│   └── .doc-manifest.yaml   # Doc tracking
└── .releaserc.json          # Semantic release config
```

## Headless API Usage

### Get Navigation Structure

```bash
curl http://localhost:3000/api/docs
```

Response:
```json
{
  "pageMap": [
    {
      "name": "getting-started",
      "route": "/getting-started",
      "title": "Getting Started",
      "type": "folder",
      "children": [...]
    }
  ],
  "timestamp": "2025-01-17T12:00:00Z"
}
```

### Get Page Content

```bash
curl http://localhost:3000/api/docs/getting-started/quick-start
```

Response:
```json
{
  "content": "compiled MDX string",
  "frontmatter": {
    "title": "Quick Start",
    "description": "Get started quickly"
  },
  "toc": [
    { "id": "installation", "text": "Installation", "level": 2 }
  ],
  "slug": "getting-started/quick-start"
}
```

## Custom Components

Available in all MDX files:

```mdx
import { Callout, Cards, Card, Steps, Tabs, Tab } from 'nextra/components'
import { APIEndpoint, VersionBadge, StoryRef } from '../mdx-components'

<Callout type="info">This is an info callout</Callout>

<APIEndpoint method="POST" path="/api/users" description="Create a user">
  Request body documentation...
</APIEndpoint>

<VersionBadge version="1.0.0" status="stable" />

<StoryRef id="STORY-123" title="User authentication" />
```

## Deployment

### Vercel (Recommended)

```bash
npm i -g vercel
vercel
```

### GitHub Pages

The included GitHub Actions workflow automatically:
1. Builds documentation on push to `main`
2. Validates links
3. Runs semantic-release
4. Deploys to GitHub Pages

### Static Export

```bash
npm run docs:build
# Output in `out/` directory
```

## Configuration

### Customize Branding

Edit `app/layout.tsx`:

```tsx
const navbar = (
  <Navbar
    logo={<span className="font-bold">Your Logo</span>}
    projectLink="https://github.com/your-org/your-repo"
  />
)
```

### Add AI Search (Inkeep)

1. Get API key from [Inkeep](https://inkeep.com)
2. Add to environment:
   ```bash
   NEXT_PUBLIC_INKEEP_API_KEY=your-key
   ```
3. Configure in layout

## License

MIT
