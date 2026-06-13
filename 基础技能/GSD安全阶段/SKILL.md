---
name: GSD安全阶段
description: "追溯验证已完成阶段的威胁缓解措施"
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
Verify threat mitigations for a completed phase. Three states:
- (A) SECURITY.md exists 鈥?audit and verify mitigations
- (B) No SECURITY.md, PLAN.md with threat model exists 鈥?run from artifacts
- (C) Phase not executed 鈥?exit with guidance

Output: updated SECURITY.md.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/secure-phase.md
</execution_context>

<context>
Phase: $ARGUMENTS 鈥?optional, defaults to last completed phase.
</context>

<process>
Execute end-to-end.
Preserve all workflow gates.
</process>
