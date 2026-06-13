---
name: GSD探索尖峰
description: "通过体验式探索验证想法，或建议下一步验证内容（前沿模式）"
argument-hint: "[idea to validate] [--quick] [--text] [--wrap-up] or [frontier]"
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - AskUserQuestion
  - WebSearch
  - WebFetch
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
---

<objective>
Spike an idea through experiential exploration 鈥?build focused experiments to feel the pieces
of a future app, validate feasibility, and produce verified knowledge for the real build.
Spikes live in `.planning/spikes/` and integrate with GSD commit patterns, state tracking,
and handoff workflows.

Two modes:
- **Idea mode** (default) 鈥?describe an idea to spike
- **Frontier mode** (no argument or "frontier") 鈥?analyzes existing spike landscape and proposes integration and frontier spikes

Does not require prior new-project setup 鈥?auto-creates `.planning/spikes/` if needed.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/spike.md
@$HOME/.claude/get-shit-done/workflows/spike-wrap-up.md
@$HOME/.claude/get-shit-done/references/ui-brand.md
</execution_context>

<runtime_note>
**Copilot (VS Code):** Use `vscode_askquestions` wherever this workflow calls `AskUserQuestion`.
</runtime_note>

<context>
Idea: $ARGUMENTS

**Available flags:**
- `--quick` 鈥?Skip decomposition/alignment, jump straight to building. Use when you already know what to spike.
- `--text` 鈥?Use plain-text numbered lists instead of AskUserQuestion (for non-Claude runtimes).
- `--wrap-up` 鈥?Package spike findings into a persistent project skill for future build conversations. Runs the spike-wrap-up workflow.
</context>

<process>
Parse the first token of $ARGUMENTS:
- If it is `--wrap-up`: strip the flag, execute the spike-wrap-up workflow
- Otherwise: pass all of $ARGUMENTS as the idea to the spike workflow end-to-end.

Preserve all workflow gates (prior spike check, decomposition, research, risk ordering, observability assessment, verification, MANIFEST updates, commit patterns).
</process>
