# Browser Verification Workflow Instructions

## Prerequisites
- agent-browser installed globally (`npm install -g agent-browser`)
- Chromium downloaded (`agent-browser install`)
- Documentation site running at {base_url} (default: http://localhost:3000)

## Execution Steps

### Step 1: Setup & Environment Check
1. Verify agent-browser is available: `agent-browser --version`
2. Create output directory: `{screenshot_dir}`
3. If {use_profile} is true, use `--profile {profile_path}` for all commands

### Step 2: Homepage Verification
1. `agent-browser open {base_url}`
2. `agent-browser snapshot` - Capture accessibility tree
3. Verify: Page title contains expected text
4. Verify: Navigation sidebar is present and populated
5. Verify: Main content area renders correctly
6. `agent-browser screenshot {screenshot_dir}/homepage.png --full`

### Step 3: Navigation Verification ({check_navigation})
1. From snapshot, identify all navigation links in sidebar
2. For each top-level section:
   - `agent-browser click @eN` (the nav link ref)
   - `agent-browser snapshot` - Verify page loaded
   - `agent-browser get title` - Verify title changed
   - `agent-browser get url` - Verify URL changed
3. Test browser back/forward: `agent-browser back` then `agent-browser forward`
4. Document any broken navigation paths

### Step 4: Link Verification ({check_links})
1. Navigate to each main section page
2. `agent-browser snapshot` for each page
3. Extract all `<a>` elements from accessibility tree
4. For each internal link:
   - `agent-browser click @eN`
   - Verify page loads (no 404)
   - `agent-browser back`
5. For external links, verify `href` attribute is valid
6. Report: total links checked, broken links found

### Step 5: Search Functionality ({check_search})
1. `agent-browser open {base_url}`
2. `agent-browser snapshot` - Find search input
3. `agent-browser fill @eN "authentication"` (search for known content)
4. `agent-browser wait --text "result"` or wait for search results
5. `agent-browser snapshot` - Verify results appear
6. Click a search result, verify navigation works
7. Test edge cases: empty search, special characters, no results query

### Step 6: Code Block Verification ({check_code_blocks})
1. Navigate to pages with code examples (e.g., API documentation)
2. `agent-browser snapshot` - Identify code blocks
3. Verify: Syntax highlighting is applied (check for language-specific classes)
4. Verify: Copy-to-clipboard button is present on code blocks
5. `agent-browser click @eN` (copy button) - Verify interaction works
6. `agent-browser screenshot {screenshot_dir}/code-blocks.png --full`

### Step 7: Rendering Verification ({check_rendering})
1. Check multiple viewport sizes:
   - Desktop: `agent-browser set viewport 1920 1080`
   - Tablet: `agent-browser set viewport 768 1024`
   - Mobile: `agent-browser set viewport 375 667`
2. For each viewport:
   - `agent-browser snapshot`
   - `agent-browser screenshot {screenshot_dir}/viewport-{size}.png --full`
   - Verify: No layout breaks, content is readable
3. Test dark mode if applicable: `agent-browser set media dark`

### Step 8: Accessibility Audit ({check_accessibility})
1. `agent-browser open {base_url}`
2. `agent-browser snapshot` - Full accessibility tree analysis
3. Check for:
   - Missing alt text on images
   - Missing ARIA labels on interactive elements
   - Heading hierarchy (h1 -> h2 -> h3, no skips)
   - Focus order (Tab through interactive elements)
   - Color contrast (via screenshot analysis)
4. Use `agent-browser press Tab` repeatedly to test keyboard navigation
5. Document accessibility findings

### Step 9: Generate Report
1. Compile all findings into `{report_file}`
2. Report format:
   ```markdown
   # Documentation Site Verification Report
   Date: {date}
   Base URL: {base_url}

   ## Summary
   - Pages Checked: N
   - Links Verified: N (N broken)
   - Screenshots Captured: N
   - Accessibility Issues: N

   ## Navigation [PASS/FAIL]
   ...

   ## Links [PASS/FAIL]
   ...

   ## Search [PASS/FAIL]
   ...

   ## Code Blocks [PASS/FAIL]
   ...

   ## Rendering [PASS/FAIL]
   ...

   ## Accessibility [PASS/FAIL]
   ...

   ## Screenshots
   - [filename]: description
   ```

### Step 10: Cleanup
1. `agent-browser close`
2. Report location of all artifacts to user
