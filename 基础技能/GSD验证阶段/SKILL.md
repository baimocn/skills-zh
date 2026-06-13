---
name: GSD验证阶段
description: "追溯审计并填补已完成阶段的Nyquist验证空白"
argument-hint: "[phase number]"
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - Grep
  - Agent
  - AskUserQuestion
---

<objective>
Audit Nyquist validation coverage for a completed phase. Three states:
- (A) VALIDATION.md exists 鈥?audit and fill gaps
- (B) No VALIDATION.md, SUMMARY.md exists 鈥?reconstruct from artifacts
- (C) Phase not executed 鈥?exit with guidance

Output: updated VALIDATION.md + generated test files.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/validate-phase.md
</execution_context>

<context>
Phase: $ARGUMENTS 鈥?optional, defaults to last completed phase.
</context>

<process>
Execute end-to-end.
Preserve all workflow gates.
</process>
