# Nextra 4 TOC Data Flow Analysis

**Date:** 2026-01-22
**Subtask:** subtask-2-2
**Analyst:** Claude

---

## Executive Summary

**Root Cause Identified:** ✅ **Option (A) - Missing wrapper component in mdx-components.tsx**

The TOC 'On This Page' component is not rendering because the `wrapper` component is missing from `mdx-components.tsx`. This causes TOC data to be discarded by a Fragment fallback instead of being passed to the Nextra Layout component.

---

## TOC Data Flow Architecture

### Expected Data Flow (Nextra 4)

```
┌─────────────────────────────────────────────────────────────┐
│ 1. MDX Content (content/*.mdx)                              │
│    - Contains h2/h3 headings                                │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. importPage() from nextra/pages                           │
│    Returns: { default, toc, metadata, sourceCode }          │
│    - toc: Heading[] (extracted from headings)               │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. page.tsx (app/[[...mdxPath]]/page.tsx)                   │
│    - Gets Wrapper from getMDXComponents().wrapper           │
│    - Renders: <Wrapper toc={toc} metadata={metadata}>       │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│ 4. MDXWrapper Component (should be in mdx-components.tsx)   │
│    - Receives: toc, metadata, sourceCode, children          │
│    - Provides TOC data to Nextra's context                  │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│ 5. Layout Component (app/layout.tsx)                        │
│    - Has toc config: { backToTop, float, title }            │
│    - Reads TOC data from context                            │
│    - Renders TOC in right sidebar                           │
└─────────────────────────────────────────────────────────────┘
```

### Actual Data Flow (Current - BROKEN)

```
┌─────────────────────────────────────────────────────────────┐
│ 1. MDX Content                                              │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. importPage()                                             │
│    Returns: { default, toc, metadata, sourceCode }          │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. page.tsx                                                 │
│    - components.wrapper is UNDEFINED                        │
│    - Falls back to Fragment: <>{children}</>                │
│    - Passes toc={toc} to Fragment ❌                        │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│ 4. Fragment Component ❌ DATA LOSS                          │
│    - Fragment ignores toc/metadata props                    │
│    - Only renders children                                  │
│    - TOC data DISCARDED                                     │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│ 5. Layout Component                                         │
│    - Has toc config but receives NO DATA ❌                 │
│    - Cannot render TOC (no headings data)                   │
└─────────────────────────────────────────────────────────────┘
```

---

## Code Analysis

### 1. Layout Configuration (app/layout.tsx)

**Status:** ✅ Correctly configured

```typescript
// Line 61
toc={{ backToTop: true, float: true, title: 'On This Page' }}
```

**Analysis:**
- TOC is properly configured with all required options
- Layout is ready to receive and display TOC data
- No issues found in layout

### 2. Page Component (app/[[...mdxPath]]/page.tsx)

**Status:** ⚠️ Correctly implemented BUT depends on missing wrapper

```typescript
// Line 16: Gets MDX components
const components = getMDXComponents()

// Line 17: Tries to get wrapper, falls back to Fragment
const Wrapper = components.wrapper || (({ children }: { children: ReactNode }) => <>{children}</>)

// Lines 21-24: Uses wrapper with TOC data
const { default: MDXContent, toc, metadata } = await importPage(resolvedParams.mdxPath)
return (
  <Wrapper toc={toc} metadata={metadata}>
    <MDXContent {...props} params={resolvedParams} />
  </Wrapper>
)
```

**Analysis:**
- Implementation follows Nextra 4 best practices (see official docs example)
- Correctly extracts `toc` from `importPage()`
- Correctly passes `toc` and `metadata` to Wrapper
- **Problem:** `components.wrapper` is `undefined`, so Fragment fallback is used
- Fragment discards all props except children, causing TOC data loss

### 3. MDX Components (mdx-components.tsx)

**Status:** ❌ Missing wrapper component

```typescript
export function useMDXComponents(components?: MDXComponents): MDXComponents {
  return {
    ...getNextraMDXComponents({ ...components }),
    Callout,
    Cards,
    FileTree,
    Steps,
    Tabs,
    ...BMADComponents,
    ...components,
  }
}
```

**Analysis:**
- No `wrapper` property defined in returned components
- Custom BMAD components are present (APIEndpoint, VersionBadge)
- Nextra components imported (Callout, Cards, etc.)
- **Missing:** The critical `wrapper` component

---

## Type Definitions (from Nextra 4.6.1)

### MDXWrapper Type

```typescript
type MDXWrapper = FC<{
    children: ReactNode;
    bottomContent?: ReactNode;
} & Omit<EvaluateResult, 'default'>>;
```

### EvaluateResult Type

```typescript
type EvaluateResult = {
    /** The MDX component to render. */
    default: FC<any>;
    /** Table of contents list. */
    toc: Heading[];
    /** Page's front matter or `metadata` object including `title`, `description`, etc. */
    metadata: $NextraMetadata;
    /** Raw MDX source code */
    sourceCode: string;
};
```

**Conclusion:** MDXWrapper receives `toc`, `metadata`, `sourceCode`, and `children` as props.

---

## Root Cause Determination

### Option Analysis

| Option | Description | Verdict |
|--------|-------------|---------|
| **(A) Missing wrapper component** | mdx-components.tsx lacks wrapper | ✅ **ROOT CAUSE** |
| (B) Layout not receiving TOC data | Layout config issue | ❌ Layout is correct |
| (C) CSS hiding TOC | Styling problem | ❌ TOC data never reaches Layout |
| (D) Nextra version incompatibility | Version mismatch | ❌ Using correct Nextra 4.6.1 |

### Evidence Supporting Option (A)

1. **Type Definitions:** Nextra 4 expects `wrapper` in MDXComponents (line 45 in mdx-components.d.ts)
2. **Official Documentation:** Nextra docs show wrapper component example (pages.d.ts lines 61-72)
3. **Code Pattern:** page.tsx follows correct pattern but wrapper is undefined
4. **Data Flow Break:** Fragment fallback breaks the TOC data pipeline

---

## Critical Discovery: Nextra Theme Docs Already Provides Wrapper!

### Finding

**Nextra Theme Docs** (`nextra-theme-docs` package) **already exports a complete `useMDXComponents` function that includes a wrapper component!**

**File:** `node_modules/nextra-theme-docs/dist/mdx-components/index.d.mts`

```typescript
declare const DEFAULT_COMPONENTS: {
    // ... other components ...
    wrapper({ toc, children, metadata, bottomContent, sourceCode, ...props }: {
        children: react.ReactNode;
        bottomContent?: react.ReactNode;
    } & Omit<nextra.EvaluateResult, "default">): react_jsx_runtime.JSX.Element;
};

declare const useMDXComponents: UseMDXComponents<typeof DEFAULT_COMPONENTS>;

export { useMDXComponents };
```

### Current Problem in Our Code

**File:** `mdx-components.tsx` (line 5)

```typescript
import { useMDXComponents as getNextraMDXComponents } from 'nextra/mdx-components'
```

❌ **Wrong import!** This imports from `nextra/mdx-components` which does NOT include the wrapper.

✅ **Should be:** Import from `nextra-theme-docs` which DOES include the wrapper.

### Comparison

| Package | Has Wrapper? | Purpose |
|---------|--------------|---------|
| `nextra/mdx-components` | ❌ No | Base MDX components (img, a, etc.) |
| `nextra-theme-docs` | ✅ Yes | Full theme components including wrapper |

---

## Solution Requirements

To fix the TOC rendering, we must:

1. **Change import in mdx-components.tsx:**
   - FROM: `import { useMDXComponents as getNextraMDXComponents } from 'nextra/mdx-components'`
   - TO: `import { useMDXComponents as getNextraMDXComponents } from 'nextra-theme-docs'`

2. **The wrapper component is already implemented** in nextra-theme-docs and will automatically:
   - Receive `toc`, `metadata`, `sourceCode`, and `children` props
   - Provide TOC data to the Layout component via internal context
   - Handle all TOC rendering logic

---

## References

- **Nextra 4 Migration Guide:** https://the-guild.dev/blog/nextra-4
- **MDX Components File Documentation:** https://nextra.site/docs/file-conventions/mdx-components-file
- **Nextra Type Definitions:** node_modules/nextra/dist/types.d.ts
- **Official Page Example:** node_modules/nextra/dist/client/pages.d.ts (lines 54-73)

---

---

## SUMMARY

### Root Cause
**Missing wrapper component** - mdx-components.tsx imports from the wrong package.

### Current State
```typescript
// mdx-components.tsx - CURRENT (WRONG)
import { useMDXComponents as getNextraMDXComponents } from 'nextra/mdx-components'
// ❌ This doesn't include wrapper component
```

### Required Fix
```typescript
// mdx-components.tsx - REQUIRED FIX
import { useMDXComponents as getNextraMDXComponents } from 'nextra-theme-docs'
// ✅ This includes wrapper component with TOC support
```

### Impact
- **Complexity:** Low (one-line change)
- **Risk:** Very low (using official package implementation)
- **Testing:** Browser verification required

---

## Next Steps (Subtask 3-1)

1. ✅ ~~Research proper wrapper component implementation for Nextra 4~~ (COMPLETED - use nextra-theme-docs)
2. Change import in mdx-components.tsx from `nextra/mdx-components` to `nextra-theme-docs`
3. Ensure custom BMAD components are still merged correctly
4. Test TOC rendering in browser
5. Verify TOC functionality (clicking, highlighting, back-to-top)
