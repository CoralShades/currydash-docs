---
name: doc-sync
title: Synchronize Documentation
description: Applies pending documentation changes and prepares for release
type: triggered
trigger: on_sprint_complete
agent: paige
module: bmad-docops-nextra
---

# Doc Sync Workflow

## Purpose

Process all pending documentation changes, update content, and prepare conventional commits.

## Trigger

- Manually via `*paige ds`
- Automatically on sprint complete

## Process

### 1. Scan Pending Changes

Load from `.doc-manifest.yaml`:
- Find all `status: pending` entries
- Sort by priority
- Group by target file

### 2. Process Creates

For new documentation files:

```mdx
---
title: {title}
description: {description}
---

import { Callout, Steps } from 'nextra/components'
import { StoryRef } from '../../mdx-components'

# {title}

<StoryRef id="STORY-123" title="Feature implementation" />

{generated content based on template}
```

### 3. Process Updates

For existing files:
- Locate target section
- Apply changes (append/replace)
- Preserve existing content
- Add story reference markers

### 4. Update _meta.js

If new pages added:

```javascript
// content/guides/_meta.js
export default {
  index: 'Overview',
  'existing-guide': 'Existing Guide',
  'new-feature': 'New Feature Guide', // Added
}
```

### 5. Generate Changelog Entry

Create/update `content/changelog.mdx`:

```mdx
import { ChangelogEntry } from '../mdx-components'

<ChangelogEntry version="1.2.0" date="2025-01-17" type="minor">

## ✨ Features

- Add user creation endpoint ([STORY-123])
- New feature guide documentation

## 🐛 Bug Fixes

- Fix authentication flow ([STORY-124])

## 📚 Documentation

- Updated API reference
- New getting started guide

</ChangelogEntry>
```

### 6. Update Manifest

Mark changes as synced:

```yaml
story_docs:
  STORY-123:
    status: synced
    synced_at: "2025-01-17T14:00:00Z"
```

### 7. Prepare Commit

Generate conventional commit message:

```
docs(guides): add new feature documentation

- Add new-feature.mdx guide
- Update API reference
- Add changelog entry

Stories: STORY-123, STORY-124
```

## Output

- Updated MDX files in `content/`
- Updated `_meta.js` navigation
- Changelog entry
- Conventional commit message ready
