# Task Plan: Agent-Browser + BMAD v6 Integration

## Goal
Add vercel-labs/agent-browser and its capabilities to the currydash-docs project with:
- Full integration (Docs QA, Browser Automation, E2E Testing)
- All install approaches (Global CLI, Claude Code Plugin, Project Dependency)
- New BMAD Agent + Enhanced TEA Agent + Skills/Commands
- Transition period: Keep Puppeteer MCP alongside agent-browser

## Status: PLANNING COMPLETE - AWAITING APPROVAL

## User Decisions
| Question | Answer |
|----------|--------|
| Use Case | All of the above (QA + Automation + E2E) |
| Install Mode | All approaches combined |
| BMAD Scope | New Agent + Enhanced TEA + Skills |
| MCP Strategy | Transition period (both coexist) |

---

## Phase 1: Research & Discovery [complete]
- [x] Explore agent-browser repo (GitHub)
- [x] Explore current project structure
- [x] Explore current BMAD setup (_bmad/ directory)
- [x] Explore current Claude Code config (.claude/)
- [x] Identify BMAD v6 components needed
- [x] Ask user clarifying questions

## Phase 2: Install & Configure Agent-Browser [pending]
### 2A: Global CLI Installation
- [ ] Install agent-browser globally: `npm install -g agent-browser`
- [ ] Run `agent-browser install` to download Chromium
- [ ] Verify installation works on Windows

### 2B: Project Dependency
- [ ] Add to docs/package.json as devDependency
- [ ] Add npm scripts for browser automation
- [ ] Update .gitignore for browser profiles/state

### 2C: Claude Code Plugin Configuration
- [ ] Add agent-browser to .claude/settings.local.json permissions
- [ ] Add agent-browser to .claude_settings.json permissions
- [ ] Configure as skill in Claude Code

## Phase 3: BMAD v6 Integration [pending]
### 3A: New Browser QA Agent
- [ ] Create _bmad/bmm/agents/browser-qa.md (new agent: "Atlas")
- [ ] Register in _bmad/_config/agent-manifest.csv
- [ ] Add agent config entry in _bmad/_config/agents/browser-qa.yaml

### 3B: Enhance TEA Agent
- [ ] Update _bmad/bmm/config.yaml: tea_use_mcp_enhancements: true
- [ ] Add agent-browser references to TEA agent
- [ ] Add browser testing menu items to TEA

### 3C: New BMAD Workflows
- [ ] Create browser-verify workflow (docs verification)
- [ ] Create browser-test workflow (E2E testing)
- [ ] Create browser-screenshot workflow (visual capture)
- [ ] Register workflows in workflow-manifest.csv

### 3D: Claude Code Commands/Skills
- [ ] Create .claude/commands/bmad/bmm/agents/browser-qa.md
- [ ] Create .claude/commands/bmad/bmm/workflows/browser-verify.md
- [ ] Create .claude/commands/bmad/bmm/workflows/browser-test.md
- [ ] Create .claude/commands/bmad/bmm/workflows/browser-screenshot.md

## Phase 4: Configuration Updates [pending]
- [ ] Update .auto-claude/.env with AGENT_BROWSER_ENABLED config
- [ ] Update .auto-claude-security.json with agent-browser commands
- [ ] Update CLAUDE.md with agent-browser documentation section

## Phase 5: Verification [pending]
- [ ] Verify agent-browser CLI works
- [ ] Verify Claude Code recognizes new skills/commands
- [ ] Verify BMAD agent loads correctly
- [ ] Verify workflows execute
- [ ] Test documentation site verification workflow

## Errors Encountered
| Error | Attempt | Resolution |
|-------|---------|------------|
| (none yet) | | |

## Decisions
| Decision | Rationale | Date |
|----------|-----------|------|
| All use cases | User chose full integration | 2026-01-28 |
| All install modes | User chose combined approach | 2026-01-28 |
| New Agent + Enhanced TEA | User chose comprehensive BMAD scope | 2026-01-28 |
| Transition period for Puppeteer | Keep both, migrate gradually | 2026-01-28 |
| Agent name: Atlas | "Browser navigator" theme, not taken | 2026-01-28 |
