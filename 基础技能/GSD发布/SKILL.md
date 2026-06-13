---
name: GSD发布
description: "创建PR、运行审查并在验证通过后准备合并"
argument-hint: "[phase number or milestone, e.g., '4' or 'v1.0']"
allowed-tools:
  - Read
  - Bash
  - Grep
  - Glob
  - Write
  - AskUserQuestion
---

<objective>
Bridge local completion 鈫?merged PR. After /gsd:verify-work passes, ship the work: push branch, create PR with auto-generated body, optionally trigger review, and track the merge.

Closes the plan 鈫?execute 鈫?verify 鈫?ship loop.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/ship.md
</execution_context>

Execute the ship workflow from @$HOME/.claude/get-shit-done/workflows/ship.md end-to-end.
