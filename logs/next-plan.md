# CurryDash Nextra Documentation - Next Steps Plan

## Priority 1: Fix Sidebar Navigation (Critical)

### Problem
The left sidebar navigation is not visible despite Nextra theme being loaded.

### Investigation Steps
1. Check content structure in `docs/content/` directory
2. Verify `_meta.json` files exist and have correct format
3. Check if pages are being treated as "page" type vs "docs" type
4. Review Nextra 4 sidebar configuration requirements

### Potential Fixes
- Ensure `_meta.json` files define navigation order
- Check if `pageMap` is being correctly generated
- Verify content directory is correctly configured in Nextra

## Priority 2: Fix TOC "On This Page" (Critical)

### Problem
The right-side table of contents is not appearing.

### Investigation Steps
1. Check if MDX pages have proper heading structure (h2, h3)
2. Verify `toc` export from MDX pages
3. Check Nextra theme-docs TOC component rendering

### Potential Fixes
- Ensure headings use proper markdown syntax
- Check if `toc` prop is being passed to Wrapper component

## Priority 3: Enterprise-Grade Card Styling

### Target: Match svelteflow.dev styling

### Features Needed
1. **Card Component**
   - Rounded borders (`rounded-xl`)
   - Subtle shadows (`shadow-sm hover:shadow-md`)
   - Border styling (`border border-gray-200 dark:border-gray-800`)
   - Smooth transitions (`transition-all duration-200`)
   - Hover state lift effect

2. **Link Cards**
   - Arrow icon on hover
   - Background color change on hover
   - Title + description layout

### Implementation
Create custom Card components or override Nextra's Cards component in mdx-components.tsx

## Priority 4: Code Block Enhancements

### Features Needed
1. **Package Manager Tabs**
   - npm / pnpm / yarn / bun tabs above code blocks
   - Active tab highlighting
   - Persistent tab selection

2. **Copy Button**
   - Floating copy button on code blocks
   - Click feedback animation
   - Success state

3. **Syntax Highlighting**
   - Proper color scheme for light/dark mode
   - Language indicator

### Implementation
Use Nextra's built-in Tabs component or create custom CodeTabs component

## Priority 5: Animations & Polish

### Features
1. **Page Transitions**
   - Smooth fade-in on navigation

2. **Hover Effects**
   - Sidebar item highlight
   - Card lift effect
   - Link underline animation

3. **Micro-interactions**
   - Button press feedback
   - Copy success animation
   - Accordion expand/collapse

### Implementation
Add CSS transitions in globals.css and use Tailwind's animation utilities

## Files to Create/Modify

| File | Action | Purpose |
|------|--------|---------|
| `docs/content/_meta.json` | Verify/Fix | Sidebar navigation order |
| `docs/mdx-components.tsx` | Update | Enhanced Card, CodeTabs components |
| `docs/app/globals.css` | Update | Animation utilities, hover effects |
| `docs/components/Card.tsx` | Create | Enterprise Card component |
| `docs/components/CodeTabs.tsx` | Create | Package manager tabs |

## Success Criteria

After implementing these fixes, the site should have:
- [ ] Visible left sidebar with collapsible sections
- [ ] "On This Page" TOC on the right
- [ ] Cards with borders, shadows, and hover effects
- [ ] Code blocks with tabs (npm/pnpm/yarn/bun)
- [ ] Copy button on code blocks
- [ ] Smooth animations throughout
- [ ] Professional appearance matching svelteflow.dev
