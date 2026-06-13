---
name: GSD健康检查
description: "诊断规划目录健康状况并可选择修复问题"
argument-hint: "[--repair] [--context]"
allowed-tools:
  - Read
  - Bash
  - Write
  - AskUserQuestion
---

<objective>
Validate `.planning/` directory integrity and report actionable issues. Checks for missing files, invalid configurations, inconsistent state, and orphaned plans.

`--context` runs an orthogonal check: the running session's context utilization. The workflow asks for the model's tokensUsed + contextWindow, calls `gsd-sdk query validate.context`, and renders one of three states:

| Utilization | State    | Action                                                |
|-------------|----------|-------------------------------------------------------|
| < 60%       | healthy  | no action 鈥?context is comfortable                    |
| 60% 鈥?70%   | warning  | recommend `/gsd:thread` to start fresh                |
| 鈮?70%       | critical | reasoning quality may degrade past the fracture point |
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/health.md
</execution_context>

<process>
Execute end-to-end.
Parse `--repair` and `--context` flags from arguments and pass to workflow.
</process>
