---
name: GSD新项目
description: "通过深度上下文收集和PROJECT.md初始化新项目"
argument-hint: "[--auto]"
allowed-tools:
  - Read
  - Bash
  - Write
  - Agent
  - AskUserQuestion
---

<runtime_note>
**Copilot (VS Code):** Use `vscode_askquestions` wherever this workflow calls `AskUserQuestion`. They are equivalent 鈥?`vscode_askquestions` is the VS Code Copilot implementation of the same interactive question API.
</runtime_note>

<context>
**Flags:**
- `--auto` 鈥?Automatic mode. After config questions, runs research 鈫?requirements 鈫?roadmap without further interaction. Expects idea document via @ reference.
</context>

<objective>
Initialize a new project through unified flow: questioning 鈫?research (optional) 鈫?requirements 鈫?roadmap.

**Creates:**
- `.planning/PROJECT.md` 鈥?project context
- `.planning/config.json` 鈥?workflow preferences
- `.planning/research/` 鈥?domain research (optional)
- `.planning/REQUIREMENTS.md` 鈥?scoped requirements
- `.planning/ROADMAP.md` 鈥?phase structure
- `.planning/STATE.md` 鈥?project memory

**After this command:** Run `/gsd:plan-phase 1` to start execution.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/new-project.md
@$HOME/.claude/get-shit-done/references/questioning.md
@$HOME/.claude/get-shit-done/references/ui-brand.md
@$HOME/.claude/get-shit-done/templates/project.md
@$HOME/.claude/get-shit-done/templates/requirements.md
</execution_context>

<process>
Execute end-to-end.
Preserve all workflow gates (validation, approvals, commits, routing).
</process>
