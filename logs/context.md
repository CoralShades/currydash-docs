# CurryDash Nextra Documentation - AI Agent Context

## Project Overview

CurryDash documentation site built with Nextra 4 + Next.js 16. Goal is enterprise-grade documentation matching showcase sites like svelteflow.dev.

## Current Tech Stack

- **Framework**: Next.js 16.1.4 with Turbopack
- **Documentation**: Nextra 4.0.0 + nextra-theme-docs 4.0.0
- **Styling**: Tailwind CSS 4.0.0 with @tailwindcss/postcss
- **Search**: Pagefind (Rust-powered)

## Project Structure

```
D:\ailocal\currydash-docs\docs\
├── app/
│   ├── layout.tsx          # Root layout with Nextra theme
│   ├── globals.css         # Tailwind v4 styles
│   └── [[...mdxPath]]/     # Catch-all MDX route
│       └── page.tsx
├── content/                # MDX documentation files
│   ├── _meta.json          # Root navigation
│   ├── index.mdx           # Homepage
│   ├── developers/         # Developer docs section
│   ├── vendors/            # Vendor guide section
│   ├── admins/             # Admin guide section
│   ├── api/                # API reference section
│   └── changelog/          # Changelog
├── mdx-components.tsx      # MDX component overrides
├── next.config.mjs         # Nextra + Next.js config
├── postcss.config.mjs      # Tailwind v4 PostCSS
└── package.json
```

## Key Configuration Files

### next.config.mjs
```javascript
import nextra from 'nextra'

const withNextra = nextra({
  search: { codeblocks: false },
})

const nextConfig = {
  reactStrictMode: true,
  transpilePackages: ['nextra', 'nextra-theme-docs'],
}

export default withNextra(nextConfig)
```

### postcss.config.mjs
```javascript
export default {
  plugins: {
    '@tailwindcss/postcss': {}
  }
}
```

### layout.tsx Key Props
```typescript
<Layout
  banner={banner}
  navbar={navbar}
  footer={footer}
  pageMap={await getPageMap()}
  sidebar={{ defaultMenuCollapseLevel: 1, toggleButton: true }}
  toc={{ backToTop: true, float: true, title: 'On This Page' }}
>
```

## Current Issues to Fix

### 1. Sidebar Not Visible
- HTML contains `nextra-sidebar` classes
- CSS may be hiding sidebar or layout broken
- Check: `_meta.json` files, content structure

### 2. TOC Not Visible
- Config has `toc: { float: true }`
- Check: Heading structure in MDX, toc export

### 3. Cards Need Styling
- Current: Plain text without visual hierarchy
- Target: Borders, shadows, hover effects like svelteflow.dev

## Brand Colors (CurryDash)

```css
--color-turmeric-gold: #E6B04B;
--color-chili-red: #C5351F;
--color-curry-leaf-green: #4A7C59;
--color-coconut-cream: #FFF8DC;
--color-cinnamon-brown: #5D4037;
```

## Dev Server

```bash
cd D:\ailocal\currydash-docs\docs
npm run dev
# Runs on http://localhost:3000
```

## Reference Sites

- Target UI: https://svelteflow.dev/learn
- Nextra docs: https://nextra.site/docs
- React Flow: https://reactflow.dev/learn

## Commands for AI Agents

```bash
# Read current errors
cat D:\ailocal\currydash-docs\logs\errors.md

# Read progress
cat D:\ailocal\currydash-docs\logs\progress.md

# Read next plan
cat D:\ailocal\currydash-docs\logs\next-plan.md

# Start dev server
cd D:\ailocal\currydash-docs\docs && npm run dev

# Check content structure
ls -la D:\ailocal\currydash-docs\docs\content
```
