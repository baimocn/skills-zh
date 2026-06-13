---
name: content-activator
description: "Proactive content creation router — detects documentation, presentation, PRD, and content writing intent. Researches audience and purpose, discusses structure and tone, and co-creates content strategy before generating deliverables. Triggers on .pptx, .md docs, README, PRD requests, slide deck needs, blog posts, and any content creation work."
license: MIT
---

# Content Activator Skill

Collaborative router for all content creation, documentation, and presentation work.
Before generating any deliverable, this skill researches context, discusses strategy with
the user, and co-creates a structural plan.

---

## 核心哲学 / Core Philosophy

### Audience First

Always determine WHO before WHAT. The same feature needs a completely different document
depending on whether the reader is a new user, a senior engineer, an executive, or a
compliance officer.

**Default questions before any content work:**
1. Who is the primary audience? (role, expertise level, context)
2. What should the reader DO after consuming this content? (action-oriented goal)
3. Where will they encounter it? (search result, shared link, printed handout, terminal)
4. What do they already know that I can skip? (baseline assumptions)

### Research Before Proposing

Never propose a structure from a blank slate. Always:
- Scan existing project documentation for conventions, tone, and patterns
- Check if there is a style guide, templates, or prior examples
- Look at the target directory structure for naming and organization norms
- Review recent git history if the content relates to completed work

### Structure Preview

Present a structural outline (headings, approximate sections, word/slide count targets)
before generating full content. Get alignment on the skeleton before writing flesh.

### Progressive Disclosure

Content should be layered: summary up top, details below, reference at the end.
Readers should be able to stop early and still get the most important information.

---

## Signal Detection / 信号检测

### Group A: File Signals

Triggers when the user works with or references these file types or paths:

| Signal | Likely Content Type |
|---|---|
| `*.pptx`, `*.ppt`, `*.key` | Presentation / slide deck |
| `docs/**/*.md`, `docs/**/*.mdx` | Project documentation |
| `README.md` | Project readme |
| `CHANGELOG.md` | Release changelog |
| `CONTRIBUTING.md` | Contributor guide |
| `*.mdx` in `blog/`, `posts/` | Blog post / article |
| `PRD.md`, `prd.md`, `requirements.md` | Product requirements document |
| `*.tex`, `*.bib` | Scientific / academic content |
| `summary.md`, `milestone*.md` | Milestone summary |

### Group B: User Intent Keywords

Direct language indicating content creation:

- "document this", "write docs", "create documentation"
- "make slides", "slide deck", "presentation", "pptx"
- "PRD", "product requirements", "requirements doc"
- "write a blog", "blog post", "article"
- "README", "changelog", "release notes"
- "guide", "tutorial", "how-to", "walkthrough"
- "explain this", "write an explanation", "document the API"
- "executive summary", "one-pager", "brief"

### Group C: Context Signals

Infer content need from project state:

| Context | Suggested Content |
|---|---|
| New feature branch merged with no docs | Documentation update / guide |
| New service or API created with no README | README + API reference |
| Sprint or milestone completed | Milestone summary report |
| Research experiment finished | Scientific slides or paper |
| New product area or initiative starting | PRD |
| Marketing launch approaching | Presentation / launch deck |
| Complex architecture decisions made | Architecture decision record (ADR) |

### Group D: Audience Signals

Infer audience from clues:

| Audience Clue | Target Reader | Content Style |
|---|---|---|
| "for the team", "internal" | Engineering team | Technical, direct, no fluff |
| "for stakeholders", "leadership" | Executives / managers | High-level, metrics-driven, concise |
| "for users", "customer-facing" | End users | Friendly, step-by-step, visual |
| "for new contributors" | Open-source contributors | Welcoming, example-heavy |
| "for compliance", "audit" | Regulators / auditors | Formal, thorough, traceable |
| "for the conference" | Conference attendees | Engaging, narrative, visual |

---

## 协作讨论协议 / Collaborative Discussion Protocol

When content work is detected, follow this protocol before generating deliverables.

### Step 1: Content Strategy Brief

Open with a brief discussion covering these four dimensions:

```
## Content Strategy Brief

**Audience:** Who reads this? What is their expertise level?
**Goal:** Inform | Persuade | Instruct | Reference | Entertain
**Format:** Long-form doc | Slide deck | Structured reference | Short post
**Tone:** Technical | Conversational | Formal | Marketing | Academic
```

If the user has not specified these, ask. Offer informed defaults based on context signals
and let the user confirm or adjust.

### Step 2: Discovery Questions

Ask 3-5 targeted questions. Choose the most relevant from these categories:

**Audience depth:**
- What is the audience's familiarity with this system/topic?
- Are there multiple audience segments? If so, who is primary?
- Should I assume they have read prior docs or start from zero?

**Message clarity:**
- What is the single most important takeaway?
- Are there specific points that must be covered?
- Is there anything the audience should NOT see (internal details, premature info)?

**Constraints:**
- Approximate length? (500 words, 5 slides, 20-page doc)
- Deadline or urgency level?
- Does it need to fit into an existing doc structure or template?

**Visual and format needs:**
- Diagrams, screenshots, or code examples needed?
- Specific branding, color scheme, or slide template?
- Will this be printed, projected, or read on screen?

### Step 3: Structural Approaches

Present 2-3 structural approaches with trade-offs. For example:

```
### Approach A: Tutorial-first (for learners)
Structure: Concept explanation → Setup → Walkthrough → Troubleshooting
Pro:  Accessible to newcomers, self-contained
Con:  Experienced users must skip ahead

### Approach B: Reference-first (for practitioners)
Structure: Quick summary → API/Config tables → Examples → Deep dives
Pro:  Fast lookup, respects reader expertise
Con:  Unfriendly to first-time readers

### Approach C: Hybrid (progressive)
Structure: Quick Start (5 min) → Full Guide → Reference appendix
Pro:  Serves both audiences
Con:  Longer total document, more maintenance
```

Let the user choose or request a modification.

### Step 4: Outline Preview

Generate a detailed outline with:
- Section headings (H2/H3 level)
- 1-2 sentence description of each section's content
- Estimated length per section
- Placeholder notes for visuals, code blocks, or tables

Present this outline for approval before writing full content.

---

## 内容架构模式 / Content Architecture Patterns

### PRD (Product Requirements Document)

```
# [Feature Name] PRD

## Problem Statement
- What user problem are we solving?
- Current pain points and workarounds
- Evidence: user research, support tickets, analytics

## Proposed Solution
- High-level approach (2-3 paragraphs)
- Key design decisions and rationale
- Alternatives considered and why rejected

## Requirements
### Functional Requirements
- FR-1: [Requirement with acceptance criteria]
- FR-2: ...

### Non-Functional Requirements
- Performance targets
- Security considerations
- Accessibility requirements

## User Stories
- As a [role], I want [action], so that [benefit]

## Success Criteria & Metrics
- Primary metric: [measurable outcome]
- Secondary metrics: [supporting indicators]
- Baseline → Target values

## Timeline & Phases
- Phase 1: [scope] by [date]
- Phase 2: [scope] by [date]

## Open Questions
- Unresolved decisions needing input
```

### Technical Documentation

```
# [System/Feature] Documentation

## Overview
- What it is (2-3 sentences)
- Why it exists
- Architecture diagram (if applicable)

## Getting Started
- Prerequisites
- Installation / Setup steps (numbered)
- Verification step ("you should see...")

## Usage Guide
- Common use cases with examples
- Configuration options table
- Code samples with expected output

## API Reference
- Endpoint / function signatures
- Parameters table (name, type, required, description)
- Response format
- Error codes

## Troubleshooting
- Common errors and solutions
- Debugging tips
- Where to get help

## FAQ
- Anticipated questions with concise answers
```

### Slide Deck / Presentation

```
# [Title] Presentation

## Slide 1: Hook
- Compelling opening stat, question, or story
- Sets the emotional/contextual frame

## Slide 2: Problem
- Clear articulation of the problem
- Impact quantification (cost, time, users affected)

## Slides 3-5: Solution
- What we built / propose
- Key features or arguments (one per slide)
- Supporting visuals: screenshots, diagrams, data

## Slide 6: Evidence
- Metrics, testimonials, benchmarks
- Before/after comparison

## Slide 7: Call to Action
- What we need from this audience
- Specific next steps
- Timeline

## Backup Slides (appendix)
- Technical details, data tables, extended references
```

### README

```
# [Project Name]

> One-line description of what this does and why it matters.

## Why
- Problem it solves (2-3 sentences)
- Key differentiators

## Quick Start
```bash
# minimal steps to run
```

## Usage
- Common commands / API calls
- Configuration reference table

## Contributing
- How to set up dev environment
- PR process, code style, testing requirements

## License
```

### Blog Post / Article

```
# [Title — benefit-oriented or curiosity-driven]

## Hook (1-2 paragraphs)
- Surprising fact, relatable problem, or bold claim
- Promise of what the reader will learn

## Context (1-2 paragraphs)
- Why this matters now
- Brief background for those who need it

## Main Body (3-5 sections)
- Each section: claim → evidence → example → takeaway
- Use subheadings every 200-300 words
- Include code blocks, images, or diagrams where helpful

## Conclusion (1 paragraph)
- Recap the key insight
- Reinforce the main takeaway

## CTA
- What should the reader do next?
- Link to related resources, repo, or signup
```

### Milestone Summary

```
# Milestone [N]: [Name] Summary

## Goals (回顾)
- Original objectives from planning
- Success criteria defined at start

## Achieved (成果)
- Completed items with links to PRs / commits
- Notable wins and breakthroughs

## Metrics (指标)
- Performance improvements (before → after)
- Coverage, velocity, or quality numbers

## Learnings (经验)
- What went well
- What was harder than expected
- Process improvements to adopt

## Next Steps (下一步)
- Carryover items
- Dependencies for next milestone
- Risks to monitor
```

---

## 主动行为 / Proactive Behaviors

### Missing Documentation Detection

When reviewing a codebase or project, watch for:
- New API endpoints with no corresponding documentation
- Complex features with no user guide or tutorial
- Configuration files with no explanation of options
- Public functions or classes with no docstrings
- `docs/` folder that is significantly behind the codebase

When detected, surface it:
> "I noticed [feature/API] was added recently but has no documentation.
> Would you like me to draft a [README section / guide / API reference]?"

### PRD Recommendation

Before new feature development begins:
> "This looks like a new feature initiative. Shall I help draft a PRD
> to align the team on requirements before we start building?"

### Changelog from Git History

When a release is being prepared:
> "I can generate a changelog entry from the git log since the last tag.
> Want me to categorize the changes (features, fixes, breaking changes)
> and draft the CHANGELOG update?"

### Slide Structure for Presentations

When a presentation need is detected:
> "For this audience and goal, I'd suggest a [7-slide / 10-slide]
> structure. Want me to outline the slides before we fill in content?"

### Documentation Health Check

Periodically or on request:
> "I reviewed the docs directory. 3 guides reference deprecated APIs,
> and 2 new features have no documentation. Want me to generate a
> docs backlog?"

---

## 子技能路由 / Sub-Skill Routing

Based on the content type determined during discussion, route to specialized skills:

| Content Type | Route To | When |
|---|---|---|
| PowerPoint / slides | `pptx` | User needs a `.pptx` file |
| Scientific presentation | `scientific-slides` | Research data, academic audience |
| Project documentation | `gsd-docs-update` | Updating project docs after work |
| Milestone report | `gsd-milestone-summary` | Sprint/milestone wrap-up |
| Long-form writing | `khazix-writer` | Blog posts, articles, essays |
| PRD creation | `prd` | New feature requirements doc |
| PRD to JSON | `ralph` | Converting PRD for agent consumption |
| Technical docs (Mintlify) | `design-mintlify` | API docs, developer portal content |
| Notion-style docs | `design-notion` | Internal wiki, team documentation |
| Bilingual content | `baimo` | Chinese-English content work |

**Cross-activator coordination:**
- Route visual design questions to `design-activator` (slide themes, doc styling)
- Route PRD workflow questions to `gsd-activator` (product development process)
- Route implementation questions back to the main coding context

---

## 质量检查清单 / Quality Checklist

Before delivering any content, verify:

- [ ] Audience is explicitly stated and consistently addressed
- [ ] Structure matches the chosen architecture pattern
- [ ] Opening hooks attention within the first 2-3 sentences
- [ ] Key takeaway is clear and repeatable
- [ ] Code examples are tested and accurate (if applicable)
- [ ] Links and references are valid
- [ ] Length is appropriate for the format and audience
- [ ] Tone is consistent throughout
- [ ] Visual elements are described or included where needed
- [ ] Call to action is specific and actionable

---

## Example Interaction Flow

```
User: "We just finished the auth refactor, need to update the docs."

Activator detection:
  - Context signal: completed work → docs update
  - File signal: documentation files
  - Route candidate: gsd-docs-update

Activator response:
  "Congrats on the auth refactor! Before I draft the docs update,
  a few quick questions:

  1. Audience: Are these docs for the internal team, external
     developers integrating with the auth API, or both?
  2. Scope: Should I update the existing auth guide, create a
     migration guide for the changes, or both?
  3. Tone: Keep it consistent with the existing docs style, or
     take this as an opportunity to improve clarity?

  I scanned the current docs/auth.md — it references the old
  session-based flow. I'd suggest:
    Approach A: Update in-place (faster, less disruption)
    Approach B: New versioned guide + migration doc (cleaner
    for users on the old system)

  Which direction works for you?"
```
