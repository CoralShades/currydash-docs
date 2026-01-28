# Browser Screenshot Workflow Instructions

## Prerequisites
- agent-browser installed globally (`npm install -g agent-browser`)
- Chromium downloaded (`agent-browser install`)
- Documentation site running at {base_url}

## Execution Steps

### Step 1: Setup
1. Verify agent-browser: `agent-browser --version`
2. Create output directory structure:
   ```
   {screenshot_dir}/
   ├── desktop/
   ├── tablet/
   ├── mobile/
   └── dark/
   ```
3. Determine capture mode from {capture_mode}

### Step 2: Section Screenshot Capture (mode: all or sections)
For each section in {sections}:

1. `agent-browser open {base_url}{section.path}`
2. `agent-browser wait --load networkidle`
3. `agent-browser snapshot` - Verify page loaded correctly

For each viewport in {viewports}:
4. `agent-browser set viewport {viewport.width} {viewport.height}`
5. If {capture_full_page}:
   - `agent-browser screenshot {screenshot_dir}/{viewport.name}/{section.name}.png --full`
6. Else:
   - `agent-browser screenshot {screenshot_dir}/{viewport.name}/{section.name}.png`

### Step 3: Dark Mode Captures (if {dark_mode})
1. `agent-browser set media dark`
2. Repeat Step 2 with output to `{screenshot_dir}/dark/` subdirectory
3. `agent-browser set media light` (reset)

### Step 4: Single Page Capture (mode: single)
If capture_mode is "single":
1. Ask user for specific URL
2. `agent-browser open [url]`
3. `agent-browser wait --load networkidle`
4. Capture at all viewports as in Step 2

### Step 5: Responsive Comparison (mode: responsive)
For each section:
1. Capture at all 3 viewports side by side
2. Create comparison manifest noting layout differences
3. Flag any viewport where content is cut off or overlapping

### Step 6: Generate Screenshot Manifest
Create `{screenshot_dir}/screenshot-manifest.md`:

```markdown
# Screenshot Manifest
Date: {date}
Base URL: {base_url}
Viewports: desktop (1920x1080), tablet (768x1024), mobile (375x667)

## Captures

### Homepage
| Viewport | File | Size |
|----------|------|------|
| Desktop | desktop/homepage.png | WxH |
| Tablet | tablet/homepage.png | WxH |
| Mobile | mobile/homepage.png | WxH |

### [Section Name]
...

## Notes
- Dark mode: {dark_mode ? "captured" : "not captured"}
- Full page: {capture_full_page ? "yes" : "viewport only"}
- Total screenshots: N
```

### Step 7: Cleanup
1. `agent-browser close`
2. Report total screenshots captured and output directory
3. Present manifest to user
