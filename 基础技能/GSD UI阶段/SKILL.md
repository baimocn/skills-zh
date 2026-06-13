---
name: GSD UI阶段
description: "为前端阶段生成UI设计契约(UI-SPEC.md)"
argument-hint: "[phase]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Agent
  - WebFetch
  - AskUserQuestion
  - mcp__context7__*
---

<objective>
Create a UI design contract (UI-SPEC.md) for a frontend phase.
Orchestrates gsd-ui-researcher and gsd-ui-checker.
Flow: Validate 鈫?Research UI 鈫?Verify UI-SPEC 鈫?Done
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/ui-phase.md
@$HOME/.claude/get-shit-done/references/ui-brand.md
</execution_context>

<context>
Phase number: $ARGUMENTS 鈥?optional, auto-detects next unplanned phase if omitted.
</context>

<process>
Execute end-to-end.
Preserve all workflow gates.
</process>
