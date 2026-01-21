# CurryDash Nextra Documentation - Errors Log

## Session Date: 2026-01-21 (Updated)

### Resolved Errors

1. **`@layer base` Conflict (Tailwind v3)**
   - Error: Tailwind v3 PostCSS plugin conflicted with Nextra's CSS `@layer base` directives
   - Solution: Upgraded to Tailwind CSS v4 which uses `@tailwindcss/postcss`

2. **Invalid next.config.mjs**
   - Error: `Unrecognized key(s) in object: 'turbopack' at "experimental"`
   - Solution: Removed `experimental.turbopack` config (not needed in Next.js 16)

3. **Navigation Type Conflict**
   - Error: `type: 'page'` in _meta.js disables sidebar for sections
   - Solution: Removed `type: 'page'` from doc sections in root _meta.js

### Current Issues (Under Investigation)

1. **Desktop Sidebar Not Visible**
   - **Status**: Sidebar HTML IS being generated (links exist)
   - **Finding**: Sidebar links found in HTML with proper classes
   - **Finding**: Links to /developers/getting-started, /developers/backend, etc. present
   - **Possible Cause**: CSS layout not rendering sidebar in desktop view
   - **Nextra Structure**: May need specific container or layout config

   **Evidence**:
   ```html
   <a href="/developers/getting-started" class="x:flex x:rounded x:px-2 ...">
   ```

   **Next Steps**:
   - Check if sidebar is inside mobile-only container
   - Verify nextra-theme-docs Layout props
   - May need to add sidebar wrapper or override CSS

2. **TOC "On This Page" Not Visible**
   - Connected to sidebar issue
   - Same layout container problem

### Debug Information

**Sidebar Links Found in HTML**:
- `/developers`
- `/developers/getting-started`
- `/developers/backend`
- `/developers/backend/architecture`
- `/developers/backend/architecture/api-specification`
- `/developers/backend/architecture/authentication-authorization`

**Hidden Element Count**: 51 (includes legitimate mobile-hidden elements)

### Asset Loading Errors (Non-blocking)

These errors appear when old Flowise-related assets are requested:
```
Error while loading { pathSegments: [ 'assets', 'index-9xw-RjBM.css' ] }
Error while loading { pathSegments: [ 'assets', 'flowise_white-DsHGi9nE.svg' ] }
```
- Cause: Legacy asset references in content
- Impact: Low - pages still render
- Solution: Clean up old asset references in MDX files

### CSS Compilation

- Tailwind v4 with @tailwindcss/postcss: Working
- Custom globals.css: 380+ lines applied
- No CSS compilation errors in server logs
- Longer compile times (500-600ms) indicate CSS changes being processed
