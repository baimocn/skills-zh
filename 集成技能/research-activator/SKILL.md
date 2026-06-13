---
name: research-activator
description: "Proactive research and analysis router — detects investigation, exploration, competitive analysis, and technical research intent. Scopes research methodology, discusses depth and focus, and co-creates structured research plans before diving in. Triggers on analysis requests, comparison needs, investigation tasks, codebase exploration, idea validation, and any research-oriented work."
license: MIT
---

# Research Activator Skill

## Core Philosophy

Research without scoping wastes time. Before diving into any investigation, establish clarity on the question, the methodology, and what "done" looks like.

**Principles:**
- Always scope the research question before diving in — vague questions produce vague answers
- Present methodology options (quick scan vs deep dive vs adversarial analysis) and let the user choose
- Ask about decision context — what decision will this research inform? Research without a decision hook is just trivia
- Show the research plan before executing — get buy-in on approach before burning tokens
- Synthesize findings into actionable recommendations — raw data is not research; conclusions are

---

## Signal Detection

### Group A: File and Code Signals

Trigger this skill when you detect:
- Files with `TODO: research`, `TODO: investigate`, or `NEEDS: analysis` markers
- Comparison matrices, evaluation spreadsheets, or benchmark scripts in the repo
- Multiple `README` or `ARCHITECTURE` files suggesting a complex codebase worth mapping
- Issue trackers or bug reports referencing "unknown root cause" or "needs investigation"
- Decision records (ADRs) that are incomplete or pending
- Configuration files comparing multiple tools/services side by side

### Group B: User Intent Signals

Phrases and patterns that indicate research intent:
- "research", "compare", "analyze", "investigate", "explore"
- "what's the best", "pros and cons", "evaluate", "benchmark"
- "study", "learn about", "understand", "dig into"
- "look into", "figure out", "find out"
- "I'm not sure which", "I need to understand", "help me decide"

### Group C: Decision Context Signals

Different decisions activate different research modes:

| Decision Context | Research Mode | Activated Skill |
|---|---|---|
| Choosing a tech stack or library | Comparative research | `gsd-explore` + `web-access` |
| Debugging a mysterious failure | Forensic investigation | `gsd-forensics` |
| Exploring a new idea or concept | Exploration spike | `gsd-spike` |
| Learning from completed work | Extract learnings | `gsd-extract-learnings` |
| Understanding an unfamiliar codebase | Codebase mapping | `gsd-map-codebase` |
| Evaluating competitor products | Competitive analysis | `web-access` + `hv-analysis` |
| Checking AI industry trends | News and trend research | `aihot` + `web-access` |
| Challenging a proposed approach | Adversarial analysis | `devils-advocate` |
| Ingesting project documentation | Documentation analysis | `gsd-ingest-docs` |

### Group D: Scope Signals

Calibrate research depth from user phrasing:

- "quick look", "rough idea", "high-level" → **Fast Scan** (5-10 min, surface-level)
- "compare", "evaluate", "trade-offs" → **Structured Comparison** (medium depth, side-by-side)
- "deep dive", "thorough", "comprehensive" → **Deep Research** (full investigation)
- "what happened", "root cause", "why did" → **Forensic Analysis** (timeline + causation)
- "prove it works", "stress test", "validate" → **Adversarial Testing** (devil's advocate mode)

---

## 研究协作讨论协议 (Collaborative Discussion Protocol)

Before executing any research, walk through this brief with the user:

### Research Scope Brief

```
RESEARCH SCOPE BRIEF
====================

1. 核心问题 (Core Question):
   What specific question are we answering?

2. 决策背景 (Decision Context):
   What decision will this research inform?

3. 研究深度 (Research Depth):
   [ ] Fast Scan — quick overview, top 3 options
   [ ] Structured Comparison — side-by-side analysis
   [ ] Deep Dive — comprehensive investigation
   [ ] Adversarial Analysis — challenge assumptions

4. 时间约束 (Timeline):
   How urgently is this needed?

5. 已知信息 (Existing Knowledge):
   What do we already know? What sources exist?

6. 成功标准 (Success Criteria):
   How will we know the research is complete?

7. 输出格式 (Preferred Output):
   [ ] Summary report
   [ ] Comparison matrix
   [ ] Decision recommendation
   [ ] Action items
   [ ] Technical write-up
```

### Trade-off Discussion

When the user is unsure about scope, present these trade-offs explicitly:

- **Speed vs Depth**: A fast scan gets you 80% of the answer in 20% of the time. A deep dive finds edge cases but takes longer.
- **Breadth vs Focus**: Covering 10 tools superficially vs. comparing 3 tools in detail. Which serves the decision better?
- **Current Info vs Historical**: Do we need the latest news (`aihot`, `web-access`) or historical analysis of what went wrong (`gsd-forensics`, `gsd-extract-learnings`)?
- **External Research vs Internal Investigation**: Are we looking at the outside world (`web-access`, `aihot`) or our own codebase (`gsd-map-codebase`)?

---

## Research Methodology Patterns

### Pattern 1: Tech Stack Comparison

**When to use:** Choosing between libraries, frameworks, databases, or tools.

**Steps:**
1. **Define criteria** — What matters? Performance, ecosystem, learning curve, maintenance burden?
2. **Feature matrix** — Build a comparison table with the candidates across all criteria
3. **Benchmarking** — Run or reference benchmarks for performance-critical criteria
4. **Ecosystem analysis** — Community size, update frequency, dependency health
5. **Recommendation** — Clear pick with rationale, plus "if X changes, reconsider" conditions

**Skills activated:** `gsd-explore` (criteria definition), `web-access` (research), `devils-advocate` (challenge the pick)

**Example output structure:**
```
## Tech Stack Comparison: [X] vs [Y] vs [Z]

### Criteria (weighted)
| Criterion | Weight | X | Y | Z |
|-----------|--------|---|---|---|
| Performance | 30% | 8/10 | 6/10 | 9/10 |
| Ecosystem | 25% | 9/10 | 7/10 | 5/10 |
| Learning Curve | 20% | 7/10 | 9/10 | 4/10 |
| ... | ... | ... | ... | ... |

### Recommendation
X is the best choice because [...]
Risks: [...]
Conditions to reconsider: [...]
```

### Pattern 2: Competitive Analysis

**When to use:** Understanding the competitive landscape, positioning a product, finding differentiation.

**Steps:**
1. **Landscape scan** — Who are the players? Map the market
2. **Feature comparison** — Detailed feature-by-feature analysis
3. **UX analysis** — User experience walkthrough of each competitor
4. **Pricing model** — How do they monetize? What's the value proposition?
5. **Positioning map** — Where does each player sit on key dimensions?
6. **Gap analysis** — What's missing? Where are the opportunities?

**Skills activated:** `web-access` (market research), `hv-analysis` (structured analysis), `devils-advocate` (challenge assumptions about positioning)

### Pattern 3: Codebase Investigation

**When to use:** Onboarding to a new project, understanding unfamiliar code, finding the source of issues.

**Steps:**
1. **Architecture map** — High-level structure, main components, data flow
2. **Dependency analysis** — What depends on what? External vs internal dependencies
3. **Hotspot detection** — Where is complexity concentrated? What changes most often?
4. **Convention discovery** — What patterns does the team follow? What are the unwritten rules?
5. **Recommendation** — What to read first, what to be careful with, what needs refactoring

**Skills activated:** `gsd-map-codebase` (primary), `gsd-ingest-docs` (existing documentation), `gsd-extract-learnings` (if there's git history to mine)

### Pattern 4: Idea Validation

**When to use:** Evaluating whether an idea is worth pursuing before committing resources.

**Steps:**
1. **Market research** — Does this problem exist? Who has it? How do they solve it today?
2. **Technical feasibility** — Can we build this? What's the effort? What are the unknowns?
3. **Prototype exploration** — Quick spike to test the riskiest assumptions
4. **Feedback synthesis** — What did we learn? Does the idea hold up?

**Skills activated:** `gsd-explore` (ideation), `gsd-spike` (prototype), `web-access` (market research), `devils-advocate` (challenge viability)

### Pattern 5: Post-Mortem Investigation

**When to use:** Something went wrong and you need to understand why, prevent recurrence.

**Steps:**
1. **Timeline reconstruction** — What happened, in order? Gather all signals
2. **Root cause analysis** — Why did it happen? 5 Whys, fishbone diagram, or fault tree
3. **Impact assessment** — What was affected? Users, data, revenue, trust?
4. **Prevention plan** — What changes prevent this from happening again?
5. **Action items** — Concrete tasks with owners and deadlines

**Skills activated:** `gsd-forensics` (primary investigation), `gsd-extract-learnings` (capture lessons)

### Pattern 6: Trend and News Research

**When to use:** Understanding industry trends, AI developments, technology shifts.

**Steps:**
1. **Source gathering** — Collect recent articles, announcements, papers
2. **Signal analysis** — What's real vs hype? What's the evidence?
3. **Pattern recognition** — What trends are converging? What's the trajectory?
4. **Implication mapping** — How does this affect our work? What should we do differently?

**Skills activated:** `aihot` (AI news aggregation, Chinese sources), `web-access` (broad web research), `hv-analysis` (pattern analysis)

---

## 主动行为 (Proactive Behaviors)

### Stuck Deciding Detection

When the user presents options without committing ("I'm not sure if we should use React or Vue", "Should we go with PostgreSQL or MongoDB"), trigger a structured comparison:

1. Acknowledge the decision tension
2. Ask what criteria matter most
3. Propose a fast scan or structured comparison
4. Present a recommendation with clear rationale

### New Project Onboarding

When the user starts working in an unfamiliar repository:
1. Suggest `gsd-map-codebase` to understand the architecture
2. Use `gsd-ingest-docs` to absorb existing documentation
3. Present a "recommended reading order" for the codebase

### Major Architecture Decision Guard

Before the user commits to a significant architectural choice:
1. Recommend `devils-advocate` analysis to stress-test the approach
2. Propose exploring 1-2 alternatives with `gsd-explore`
3. Suggest a `gsd-spike` if the approach involves untested technology

### Unvalidated Approach Warning

When the user is about to implement something they haven't tested:
1. Suggest a `gsd-spike` to validate the approach
2. Offer to research known pitfalls via `web-access`
3. Recommend a small prototype before full implementation

### Post-Completion Extraction

When a significant feature or project phase completes:
1. Suggest `gsd-extract-learnings` to capture what was learned
2. Offer to document decisions and their outcomes
3. Propose creating reusable patterns from successful approaches

---

## 跨激活器协调 (Cross-Activator Coordination)

Research often intersects with other domains. Coordinate with:

- **data-activator** — When research involves database comparisons, data pipeline evaluation, or analytics tool assessment
- **devops-activator** — When research involves infrastructure choices, CI/CD tools, or deployment strategies
- **design-activator** — When research involves UI/UX patterns, design system evaluation, or user experience analysis

**Handoff pattern:** When research reveals a domain-specific question, flag it and suggest the relevant activator takes over for that portion.

---

## Research Output Templates

### Quick Scan Output
```
## Quick Scan: [Topic]

**Question:** [What we're answering]
**Methodology:** Fast scan of top options
**Confidence:** Medium — sufficient for directional decisions

### Top 3 Options
1. **[Option A]** — [One-line summary + key strength]
2. **[Option B]** — [One-line summary + key strength]
3. **[Option C]** — [One-line summary + key strength]

### Quick Recommendation
[Pick with 2-3 sentence rationale]

### Next Steps (if deeper research needed)
- [ ] [Specific follow-up investigation]
```

### Deep Research Output
```
## Research Report: [Topic]

### Executive Summary
[3-5 sentences with the key finding and recommendation]

### Research Question
[Exact question this research answers]

### Methodology
[How the research was conducted, what sources were used]

### Findings
[Detailed findings organized by theme or criterion]

### Analysis
[What the findings mean, patterns, implications]

### Recommendation
[Clear actionable recommendation with rationale]

### Risks and Caveats
[What could invalidate this recommendation]

### Sources and References
[Links, documents, data points consulted]
```

### Forensic Analysis Output
```
## Post-Mortem: [Incident/Issue]

### Summary
[What happened, impact, resolution]

### Timeline
[Chronological sequence of events]

### Root Cause
[Why it happened — be specific]

### Contributing Factors
[What made it worse or enabled it]

### What Went Well
[Things that helped during the incident]

### Action Items
| Action | Owner | Priority | Deadline |
|--------|-------|----------|----------|
| [ ] | [ ] | [ ] | [ ] |

### Lessons Learned
[What we should remember for next time]
```

---

## 工具参考 (Tool Reference)

| Skill | Purpose | When to Use |
|---|---|---|
| `aihot` | AI news aggregation (Chinese sources) | AI industry trends, Chinese tech ecosystem |
| `hv-analysis` | Structured analysis framework | Breaking down complex topics systematically |
| `devils-advocate` | Adversarial critical thinking | Challenging assumptions before major decisions |
| `gsd-explore` | Socratic ideation and routing | Exploring new ideas, defining problems |
| `gsd-spike` | Experiential exploration | Testing unproven approaches with minimal investment |
| `gsd-map-codebase` | Codebase analysis and mapping | Understanding unfamiliar repositories |
| `gsd-forensics` | Post-mortem investigation | Root cause analysis after incidents |
| `gsd-extract-learnings` | Lesson extraction | Capturing knowledge from completed work |
| `gsd-ingest-docs` | Documentation ingestion | Absorbing and analyzing existing docs |
| `web-access` | Web research | External research, market analysis, current information |

---

## Activation Examples

**User says:** "I need to figure out which state management library to use for our React app"
**Activator does:** Detects tech stack comparison signal. Presents Research Scope Brief. Asks about criteria, project constraints, team experience. Proposes structured comparison of top 3-4 options.

**User says:** "Something is causing memory leaks in production and I don't know what"
**Activator does:** Detects forensic investigation signal. Asks about timeline, recent changes, monitoring data available. Proposes `gsd-forensics` investigation with timeline reconstruction approach.

**User says:** "I have an idea for a new feature but I'm not sure it's feasible"
**Activator does:** Detects idea validation signal. Asks about the core hypothesis and riskiest assumption. Proposes `gsd-spike` to prototype the riskiest part, plus `web-access` for market validation.

**User says:** "What's happening in the AI agent space lately?"
**Activator does:** Detects trend research signal. Asks about specific areas of interest and depth needed. Activates `aihot` for Chinese AI news and `web-access` for broader coverage, with `hv-analysis` to synthesize patterns.

**User says:** "I just joined this project and have no idea how anything works"
**Activator does:** Detects codebase onboarding signal. Proposes `gsd-map-codebase` for architecture overview plus `gsd-ingest-docs` to absorb existing documentation. Offers a structured onboarding plan.

**User says:** "We're about to migrate from REST to GraphQL, any concerns?"
**Activator does:** Detects pre-decision validation signal. Activates `devils-advocate` to challenge the migration rationale, `web-access` for migration case studies, and `gsd-explore` to surface hidden risks.
