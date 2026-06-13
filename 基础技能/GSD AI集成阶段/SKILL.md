---
name: GSD AI集成阶段
description: "为涉及构建AI系统的阶段生成AI-SPEC.md设计契约"
argument-hint: "[phase number]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Agent
  - WebFetch
  - WebSearch
  - AskUserQuestion
  - mcp__context7__*
---

<objective>
Create an AI design contract (AI-SPEC.md) for a phase involving AI system development.
Orchestrates gsd-framework-selector 鈫?gsd-ai-researcher 鈫?gsd-domain-researcher 鈫?gsd-eval-planner.
Flow: Select Framework 鈫?Research Docs 鈫?Research Domain 鈫?Design Eval Strategy 鈫?Done
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/ai-integration-phase.md
@$HOME/.claude/get-shit-done/references/ai-frameworks.md
@$HOME/.claude/get-shit-done/references/ai-evals.md
</execution_context>

<context>
Phase number: $ARGUMENTS 鈥?optional, auto-detects next unplanned phase if omitted.
</context>

<process>
Execute end-to-end.
Preserve all workflow gates.
</process>
