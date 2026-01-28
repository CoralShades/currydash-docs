# Browser E2E Testing Workflow Instructions

## Prerequisites
- agent-browser installed globally (`npm install -g agent-browser`)
- Chromium downloaded (`agent-browser install`)
- Documentation site running at {base_url}

## Execution Steps

### Step 1: Setup
1. Verify agent-browser: `agent-browser --version`
2. Create output directory: `{test_output_dir}`
3. Determine test scope from {test_scope} variable

### Step 2: Navigation E2E Tests
Test all major navigation paths work correctly.

1. `agent-browser open {base_url}`
2. `agent-browser snapshot`
3. **Test: Homepage loads**
   - Assert: page title is not empty
   - Assert: sidebar navigation exists
   - Assert: main content area has children
4. **Test: Each section navigable**
   - For each sidebar section (admins, api, developers, vendors):
     - Click section link
     - Assert: URL changed to expected path
     - Assert: page content loaded (snapshot has content)
     - Assert: breadcrumb updated
5. **Test: Deep link navigation**
   - Open a deep page directly: `agent-browser open {base_url}/api/backend/authentication`
   - Assert: page renders correctly
   - Assert: sidebar highlights correct section
6. **Test: 404 handling**
   - `agent-browser open {base_url}/nonexistent-page`
   - Assert: 404 page or redirect shown

### Step 3: API Endpoint E2E Tests
Test headless API endpoints via browser.

1. **Test: GET /api/docs**
   - `agent-browser open {api_base}/docs`
   - `agent-browser get text body` or `agent-browser snapshot`
   - Assert: response is valid JSON with page map
2. **Test: GET /api/docs/[slug]**
   - `agent-browser open {api_base}/docs/api/backend/authentication`
   - Assert: response contains MDX content
3. **Test: CORS headers**
   - `agent-browser open {base_url}`
   - `agent-browser eval "fetch('/api/docs').then(r => JSON.stringify(Object.fromEntries(r.headers))).then(h => document.title = h)"`
   - `agent-browser get title` - Check for CORS headers

### Step 4: Search E2E Tests
1. `agent-browser open {base_url}`
2. `agent-browser snapshot` - Find search element
3. **Test: Search returns results**
   - `agent-browser fill @eN "orders"` (known term)
   - Wait for results
   - Assert: at least one result displayed
4. **Test: Search result navigation**
   - Click first result
   - Assert: navigated to correct page
5. **Test: Empty search**
   - Clear search, submit empty
   - Assert: no error, appropriate empty state
6. **Test: No results**
   - Search for "xyznonexistent123"
   - Assert: "no results" message shown

### Step 5: Responsive E2E Tests
1. **Desktop (1920x1080)**
   - `agent-browser set viewport 1920 1080`
   - `agent-browser open {base_url}`
   - Assert: sidebar visible, full layout
   - `agent-browser screenshot {test_output_dir}/desktop.png --full`
2. **Tablet (768x1024)**
   - `agent-browser set viewport 768 1024`
   - `agent-browser reload`
   - Assert: layout adapts (sidebar may collapse)
   - `agent-browser screenshot {test_output_dir}/tablet.png --full`
3. **Mobile (375x667)**
   - `agent-browser set viewport 375 667`
   - `agent-browser reload`
   - Assert: mobile layout, hamburger menu
   - `agent-browser screenshot {test_output_dir}/mobile.png --full`

### Step 6: Multi-Session Parallel Tests (if {parallel_sessions})
1. Launch {session_count} sessions:
   - `agent-browser --session s1 open {base_url}`
   - `agent-browser --session s2 open {base_url}/api/backend/authentication`
2. Snapshot each: `agent-browser --session sN snapshot`
3. Compare: both sessions independent, no cross-contamination
4. Close all: `agent-browser --session sN close`

### Step 7: Performance Baseline
1. `agent-browser open {base_url}`
2. `agent-browser trace start {test_output_dir}/trace.zip`
3. Navigate through 5 pages
4. `agent-browser trace stop`
5. Report: trace file location for analysis

### Step 8: Generate Test Report
Compile all test results:

```markdown
# E2E Test Report
Date: {date}
Base URL: {base_url}
Scope: {test_scope}

## Test Results Summary
| Test Suite | Tests | Passed | Failed |
|------------|-------|--------|--------|
| Navigation | N | N | N |
| API | N | N | N |
| Search | N | N | N |
| Responsive | N | N | N |

## Detailed Results
### Navigation Tests
- [PASS/FAIL] Homepage loads: ...
- [PASS/FAIL] Section navigation: ...
...

## Artifacts
- Screenshots: {test_output_dir}/*.png
- Trace: {test_output_dir}/trace.zip
```

### Step 9: Cleanup
1. `agent-browser close`
2. Present report to user
