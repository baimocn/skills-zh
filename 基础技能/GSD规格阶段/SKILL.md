---
name: GSD规格阶段
description: "使用歧义评分明确阶段交付内容；在讨论阶段前生成SPEC.md"
argument-hint: "<phase> [--auto] [--text]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - AskUserQuestion
---


<objective>
Clarify phase requirements through structured Socratic questioning with quantitative ambiguity scoring.

**Position in workflow:** `spec-phase 鈫?discuss-phase 鈫?plan-phase 鈫?execute-phase 鈫?verify`

**How it works:**
1. Load phase context (PROJECT.md, REQUIREMENTS.md, ROADMAP.md, STATE.md)
2. Scout the codebase 鈥?understand current state before asking questions
3. Run Socratic interview loop (up to 6 rounds, rotating perspectives)
4. Score ambiguity across 4 weighted dimensions after each round
5. Gate: ambiguity 鈮?0.20 AND all dimensions meet minimums 鈫?write SPEC.md
6. Commit SPEC.md 鈥?discuss-phase picks it up automatically on next run

**Output:** `{phase_dir}/{padded_phase}-SPEC.md` 鈥?falsifiable requirements that lock "what/why" before discuss-phase handles "how"
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/spec-phase.md
@$HOME/.claude/get-shit-done/templates/spec.md
</execution_context>

<runtime_note>
**Copilot (VS Code):** Use `vscode_askquestions` wherever this workflow calls `AskUserQuestion`. They are equivalent.
</runtime_note>

<context>
Phase number: $ARGUMENTS (required)

**Flags:**
- `--auto` 鈥?Skip interactive questions; Claude selects recommended defaults and writes SPEC.md
- `--text` 鈥?Use plain-text numbered lists instead of TUI menus (required for `/rc` remote sessions)

Context files are resolved in-workflow using `init phase-op`.
</context>

<process>
Execute end-to-end.

**MANDATORY:** Read the workflow file BEFORE taking any action. The workflow contains the complete step-by-step process including the Socratic interview loop, ambiguity scoring gate, and SPEC.md generation. Do not improvise from the objective summary above.
</process>

<success_criteria>
- Codebase scouted for current state before questioning begins
- All 4 ambiguity dimensions scored after each interview round
- Gate passed: ambiguity 鈮?0.20 AND all dimension minimums met
- SPEC.md written with falsifiable requirements, explicit boundaries, and acceptance criteria
- SPEC.md committed atomically
- User knows they can now run /gsd:discuss-phase which will load SPEC.md automatically
</success_criteria>
