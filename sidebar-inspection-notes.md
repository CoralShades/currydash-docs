# Nextra 4 Sidebar CSS Inspection Notes

**Date:** 2026-01-22
**Task:** Subtask-1-1 - Inspect Nextra 4 rendered HTML to identify actual CSS class names
**Nextra Version:** 4.0.0
**Theme:** nextra-theme-docs 4.0.0

## Summary

Nextra 4 has **migrated from the `_` prefix to the `x:` prefix** for utility classes. This is a breaking change from earlier versions and requires updating custom CSS overrides.

## Key Findings

### 1. CSS Class Prefix Change
- **Old (Nextra 3.x):** `_sidebar`, `_container`, etc.
- **New (Nextra 4.x):** `x:` prefix for utility classes (e.g., `x:flex`, `x:px-4`, `x:rounded`)
- **CSS Variables:** Use `--x-` prefix (e.g., `--x-color-gray-100`, `--x-spacing`)

### 2. Main Sidebar Container Structure

The sidebar is rendered as an `<aside>` element with the following structure:

```html
<aside class="nextra-sidebar x:print:hidden x:transition-all x:ease-in-out x:max-md:hidden x:flex x:flex-col x:h-[calc(100dvh-var(--nextra-navbar-height))] x:top-(--nextra-navbar-height) x:shrink-0 x:w-64 x:sticky">
  <!-- Search area (if enabled) -->
  <div class="x:px-4 x:pt-4">
    <!-- Search component -->
  </div>

  <!-- Sidebar menu wrapper -->
  <div class="x:p-4 x:overflow-y-auto nextra-scrollbar nextra-mask x:grow">
    <ul class="x:grid x:gap-1">
      <!-- Menu items -->
    </ul>
  </div>

  <!-- Sidebar footer -->
  <div class="nextra-sidebar-footer x:border-t nextra-border x:flex x:items-center x:gap-2 x:py-4 x:mx-4 x:mt-auto">
    <!-- Theme switch, locale switch -->
  </div>
</aside>
```

### 3. CSS Classes Used by Nextra 4

#### Sidebar Container Classes
- **Main wrapper:** `nextra-sidebar`
- **Utility classes:**
  - `x:print:hidden` - Hide on print
  - `x:transition-all x:ease-in-out` - Smooth transitions
  - `x:max-md:hidden` - Hidden on mobile (< 768px)
  - `x:flex x:flex-col` - Flexbox column layout
  - `x:h-[calc(100dvh-var(--nextra-navbar-height))]` - Full viewport height minus navbar
  - `x:top-(--nextra-navbar-height)` - Positioned below navbar
  - `x:shrink-0` - Don't shrink in flex layouts
  - `x:w-64` - Width 256px (16rem) when expanded
  - `x:w-20` - Width 80px (5rem) when collapsed (with toggle)
  - `x:sticky` - Sticky positioning (visible state)
  - `x:hidden` - Hidden state

#### Menu Wrapper Classes
- **Class definition:** `classes.wrapper`
- **Actual classes:** `x:p-4 x:overflow-y-auto nextra-scrollbar nextra-mask x:grow`
- **Purpose:**
  - `x:p-4` - Padding on all sides
  - `x:overflow-y-auto` - Vertical scroll when needed
  - `nextra-scrollbar` - Styled scrollbar (thin, stable gutter)
  - `nextra-mask` - Gradient mask at top/bottom for fade effect
  - `x:grow` - Grow to fill available space

#### Link/Item Classes
- **Base link:** `x:flex x:rounded x:px-2 x:py-1.5 x:text-sm x:transition-colors x:[word-break:break-word] x:cursor-pointer x:contrast-more:border`
- **Inactive state:** `x:text-gray-600 x:hover:bg-gray-100 x:hover:text-gray-900 x:dark:text-neutral-400 x:dark:hover:bg-primary-100/5 x:dark:hover:text-gray-50`
- **Active state:** `x:bg-primary-100 x:font-semibold x:text-primary-800 x:dark:bg-primary-400/10 x:dark:text-primary-600`

#### List Classes
- **Class definition:** `classes.list`
- **Actual classes:** `x:grid x:gap-1`

#### Border/Nested Menu Classes
- **Class definition:** `classes.border`
- **Actual classes:** `x:relative x:before:absolute x:before:inset-y-1 x:before:w-px x:before:bg-gray-200 x:before:content-[""] x:dark:before:bg-neutral-800 x:ps-3 x:before:start-0 x:pt-1 x:ms-3`

#### Footer Classes
- **Class definition:** `classes.footer`
- **Actual classes:** `nextra-sidebar-footer x:border-t nextra-border x:flex x:items-center x:gap-2 x:py-4 x:mx-4`

### 4. Special Nextra Utility Classes

These are defined in `nextra-theme-docs/dist/style.css`:

#### `.nextra-scrollbar`
```css
.nextra-scrollbar {
  scrollbar-width: thin;
  scrollbar-gutter: stable;
}
```

#### `.nextra-border`
```css
.nextra-border {
  border-color: var(--x-color-gray-200);
  @media (prefers-contrast: more) {
    border-color: var(--x-color-neutral-400) !important;
  }
  &:where(.dark *) {
    border-color: var(--x-color-neutral-800);
  }
}
```

#### `.nextra-mask`
```css
.nextra-mask {
  mask-image: linear-gradient(to bottom, transparent, #000 20px, transparent 100%),
              linear-gradient(to top, transparent, #000 20px, transparent 100%);
  @media (prefers-contrast: more) {
    mask-image: none;
  }
}
```

### 5. Responsive Behavior

Based on the sidebar component code:

- **Mobile (< 768px):** Hidden via `x:max-md:hidden`, shown via mobile menu toggle
- **Tablet/Desktop (≥ 768px):** Visible with `x:sticky` positioning
- **Expandable mode:** Can toggle between `x:w-64` (expanded) and `x:w-20` (collapsed)

### 6. Current Custom CSS Issues

Looking at `docs/app/globals.css` (lines 77-98):

```css
/* Make sidebar visible and properly styled */
.nextra-sidebar-container {  /* ❌ Wrong class - doesn't exist in Nextra 4 */
  @apply block;
  @apply w-64 min-h-screen overflow-y-auto;
  @apply border-r border-gray-200 dark:border-gray-800;
  @apply bg-white dark:bg-gray-950;
}

.nextra-sidebar a {  /* ⚠️ Too generic, may work but not specific */
  @apply rounded-lg px-3 py-2 text-sm;
  @apply transition-all duration-200;
}
```

**Problems:**
1. `.nextra-sidebar-container` doesn't exist in Nextra 4
2. Should target `aside.nextra-sidebar` instead
3. Custom styles may have specificity issues with `x:` utility classes

### 7. Recommended CSS Selectors for Custom Overrides

Based on the actual HTML structure:

```css
/* Target main sidebar */
aside.nextra-sidebar { }

/* Target sidebar menu wrapper */
aside.nextra-sidebar > div:nth-child(2) { }
/* OR more specific */
aside.nextra-sidebar .nextra-scrollbar { }

/* Target sidebar links */
aside.nextra-sidebar a { }

/* Target sidebar footer */
aside.nextra-sidebar .nextra-sidebar-footer { }

/* Target active links */
aside.nextra-sidebar li.active a { }

/* Target specific utility class combinations */
aside.nextra-sidebar .x\:flex.x\:rounded { }
```

### 8. Color System

Nextra 4 uses CSS custom properties for theming:

```css
:root {
  --x-color-gray-50: oklch(98.5% 0.002 247.839);
  --x-color-gray-100: oklch(96.7% 0.003 264.542);
  --x-color-gray-200: oklch(92.8% 0.006 264.531);
  /* ... etc */

  /* Primary colors derived from Nextra config */
  --nextra-primary-hue: 43deg;        /* From our globals.css */
  --nextra-primary-saturation: 76%;
  --nextra-primary-lightness: 55%;

  --x-color-primary-100: hsl(var(--nextra-primary-hue) var(--nextra-primary-saturation) ...);
}
```

### 9. Next Steps (for Subtask-1-2)

To fix the sidebar visibility:

1. **Replace `.nextra-sidebar-container`** with `aside.nextra-sidebar`
2. **Ensure sufficient specificity** to override Nextra's default styles
3. **Consider using `!important`** for critical visibility rules (display, width, position)
4. **Test responsive breakpoints:**
   - Mobile: < 768px (should use mobile menu)
   - Tablet: 768px-1023px (sidebar visible)
   - Desktop: 1024px+ (sidebar visible)
5. **Verify dark mode** works with custom overrides

## References

- Nextra 4 source: `docs/node_modules/nextra-theme-docs/dist/`
- Sidebar component: `components/sidebar.js`
- Theme styles: `style.css`
- Layout config: `docs/app/layout.tsx`
