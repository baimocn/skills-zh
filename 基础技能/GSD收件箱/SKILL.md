---
name: GSD收件箱
description: "根据项目模板和贡献指南分类审查开放的GitHub issues和PRs"
argument-hint: "[--issues] [--prs] [--label] [--close-incomplete] [--repo owner/repo]"
allowed-tools:
  - Read
  - Bash
  - Write
  - Grep
  - Glob
  - AskUserQuestion
---

<objective>
One-command triage of the project's GitHub inbox. Fetches all open issues and PRs,
reviews each against the corresponding template requirements (feature, enhancement,
bug, chore, fix PR, enhancement PR, feature PR), reports completeness and compliance,
and optionally applies labels or closes non-compliant submissions.

**Flow:** Detect repo 鈫?Fetch open issues + PRs 鈫?Classify each by type 鈫?Review against template 鈫?Report findings 鈫?Optionally act (label, comment, close)
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/inbox.md
</execution_context>

<context>
**Flags:**
- `--issues` 鈥?Review only issues (skip PRs)
- `--prs` 鈥?Review only PRs (skip issues)
- `--label` 鈥?Auto-apply recommended labels after review
- `--close-incomplete` 鈥?Close issues/PRs that fail template compliance (with comment explaining why)
- `--repo owner/repo` 鈥?Override auto-detected repository (defaults to current git remote)
</context>

<process>
Execute end-to-end.
Parse flags from arguments and pass to workflow.
</process>
