---
name: doc-analyze
title: Analyze Story for Documentation
description: Analyzes completed stories and generates doc change specifications
type: triggered
trigger: on_story_done
agent: paige
module: bmad-docops-nextra
---

# Doc Analyze Workflow

## Purpose

When a story is marked complete, analyze it for documentation needs and create change specifications.

## Trigger

Automatically triggered when a story status changes to `done`.

## Process

### 1. Read Completed Story

Parse story from `implementation_artifacts/stories/{story_id}.md`:
- Feature description
- Acceptance criteria
- API changes
- UI changes
- Breaking changes

### 2. Determine Documentation Needs

Apply decision matrix:

| Story Contains | Doc Action |
|----------------|------------|
| New API endpoint | Create API reference |
| Modified endpoint | Update API reference |
| New feature | Create/update guide |
| UI change | Update screenshots |
| Breaking change | Create migration guide |
| Config change | Update configuration |

### 3. Check Existing Docs

Review `.doc-manifest.yaml`:
- Find related existing documentation
- Identify sections to update
- Check for conflicts

### 4. Generate Change Spec

Create `.doc-changes/{story_id}.yaml`:

```yaml
metadata:
  story_id: "STORY-123"
  analyzed_at: "2025-01-17T12:00:00Z"
  
changes:
  - id: "change-1"
    type: create
    priority: high
    target:
      path: "content/guides/new-feature.mdx"
    content:
      template: feature-guide
      title: "New Feature Guide"
      
  - id: "change-2"
    type: update
    target:
      path: "content/api/endpoints.mdx"
      section: "## POST /api/users"
    content:
      append: true
      
changelog_entry:
  type: feature
  scope: api
  description: "Add user creation endpoint"
```

### 5. Update Manifest

Add to `.doc-manifest.yaml`:

```yaml
story_docs:
  STORY-123:
    status: pending
    changes:
      - content/guides/new-feature.mdx
      - content/api/endpoints.mdx
    changelog_type: feature
```

## Output

- Change specification in `.doc-changes/`
- Updated manifest with pending changes
- Summary of required documentation updates
