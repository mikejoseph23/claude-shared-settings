# The Secret Sauce: Idea to Done in One Context Window

## What This Is

A repeatable process for turning a vague idea into a finished outcome using Claude Code with parallel agent waves. Works for any complex problem that benefits from structured decomposition and parallel execution.

## Prerequisites

Set up the custom commands used in this recipe. See [setup.md](setup.md) for installation instructions.

### Commands Used in This Recipe

| Command | Phase | What It Does |
|---------|-------|-------------|
| `/planning-interview` | Phase 2 | Interviews you one question at a time. Asks focused questions, builds on your answers, then automatically probes edge cases until gaps become improbable. |
| `/make-planning-document` | Phase 3 | Transforms interview output into a structured planning document with milestone tracker, checkboxes, dependency analysis, model recommendations, and parallel execution groups. |
| `/orchestrator` | Phase 5 | Coordinates parallel processing of milestones from a planning document. |
| `/archive-planning-document` | Phase 6 | Archives a completed planning document to the docs folder. |

### Why Custom Commands Matter

Without them, you'd spend the first 15 minutes of every project re-explaining your preferred planning format, interview style, and coordination strategy. Custom commands encode that institutional knowledge once and replay it perfectly every time. Each command is tuned through real usage — refinements accumulate, and every project benefits from lessons learned in previous ones.

---

## The Process

### Phase 1: Seed

Start with a raw description of what you want to accomplish. It doesn't need to be formal. A few paragraphs describing the problem, the goal, and any ideas you have about the approach. The messier and more authentic, the better — it captures intent that formal specs often lose.

**Input**: `Idea.txt` (or whatever you have — notes, voice transcript, napkin photo, a problem statement, a half-baked plan)

**Examples**:

```text
# Idea.txt

I want to build a to-do list app. Not just another checkbox list
though. Projects, due dates, priorities, recurring tasks. Clean
minimal UI with dark mode. Maybe a calendar view. Notifications
when something is due.
```

```text
# Idea.txt

I need to migrate our monolith to microservices. I don't know
where to start. We have about 15 domain areas, a shared Postgres
database, and three teams. Downtime needs to be minimal.
```

```text
# Idea.txt

Research the competitive landscape for AI-assisted development
tools. I want to understand pricing models, feature gaps, and
where the market is heading. Deliverable is a summary doc I can
share with my team.
```

The seed can be anything — a product idea, a migration plan, a research question, an infrastructure overhaul. Casual and conversational works best. The planning interview turns it into structured requirements, and the planning document breaks it into parallelizable milestones.

### Phase 2: Requirements Interview

**Command**: `/planning-interview`

Extracts detailed requirements from your idea. One question at a time, building on previous answers. This surfaces decisions you haven't thought about yet — scope boundaries, constraints, dependencies, success criteria, and edge cases.

**Tip**: Answer honestly when you don't know. "Whatever makes sense" is a valid answer — the AI will make reasonable defaults and you can course-correct later.

The command has a built-in **exhaust-the-gaps phase** that automatically kicks in after the main interview. It transitions into rapid-fire, short-form Q&A probing edge cases and assumptions until they become improbable. Every gap closed here is a decision an agent won't have to guess at later.

**Output**: Detailed requirements captured in conversation context

### Phase 3: Planning Document

**Command**: `/make-planning-document`

Generates a structured planning document with:

- **Summary** with key objectives and success criteria
- **Milestone progress tracker** table (model assignment, status, duration)
- **Milestones** broken into specific, checkboxed task items
- **Dependency analysis** identifying which milestones can run in parallel
- **Model recommendations** per milestone (Haiku for straightforward work, Sonnet for standard tasks, Opus for complex reasoning)

The critical insight: **milestones should be sized for parallelization**. Group work by independence, not by category. Two milestones that touch different outputs can run simultaneously. Two that depend on each other's results cannot.

**Output**: `ProjectName-Planning.md` with milestones

### Phase 4: Foundation (Sequential)

Build the foundation milestones sequentially. These are the ones everything else depends on — the setup, core structure, and shared resources that all subsequent work builds on.

**Why sequential**: Every subsequent milestone references this foundation. Getting the structure right here means parallel agents can follow established patterns without conflicts.

**Tip**: Establish conventions early and document them in a `CLAUDE.md` at the project root so all agents inherit them.

### Phase 5: Parallel Waves

**Command**: `/orchestrator` (or manual team coordination)

Group remaining milestones into waves based on their dependency chains. Independent milestones run simultaneously, dependent ones wait for their prerequisites.

#### Dispatching: Two Approaches

**Approach A: Built-in agent teams**

Uses Claude Code's `TeamCreate` / `Task` tool to spawn in-process subagents. The orchestrator manages everything within a single context window. Pros: fully automated, no manual steps. Cons: subagents can't be individually configured for permissions or model.

**Approach B: Multi-window orchestration** (recommended)

The orchestrator runs in one Claude Code window and prompts the *user* to dispatch work to separate Claude Code terminal windows:

1. **Permission persistence**: Tool permissions survive `/clear` but not new windows. Reusing a window with `/clear` means zero permission friction.
2. **Model selection**: Each window can run a different model. The orchestrator specifies "use Haiku for this milestone" and "use Opus for that one."
3. **Visibility**: Each agent's work is visible in its own terminal.

**How the orchestrator prompts the user**:

```
=== Wave 2 Ready ===

You have 3 idle Claude Code windows from the previous wave.

Window 1 (Sonnet): Run /clear, then paste:
  → [Milestone prompt...]

Window 2 (Sonnet): Run /clear, then paste:
  → [Milestone prompt...]

Window 3 (Haiku): Run /clear, then paste:
  → [Milestone prompt...]

When all windows report completion, come back here and tell me.
```

The orchestrator waits, then verifies results and generates the next wave.

**Reusing windows with `/clear`**: After an agent finishes a milestone, `/clear` resets the context but keeps all permission grants. Over a multi-wave project, this avoids re-granting permissions dozens of times.

#### For each wave:

1. **Orchestrator analyzes** the planning doc for the next independent milestones
2. **Orchestrator generates prompts** — detailed, self-contained, with all context needed
3. **Orchestrator tells the user** which windows to `/clear` and what to paste
4. **User dispatches** to their terminal windows
5. **Agents work independently** and report completion
6. **User returns to orchestrator** with results
7. **Orchestrator verifies** results and updates planning doc
8. **Repeat** for next wave

#### Key principles:

- **Self-contained prompts**: Each prompt must include everything the agent needs. The agent has no access to the orchestrator's context.
- **Output ownership**: Each agent owns distinct outputs. Two agents writing to the same file or resource causes conflicts.
- **Shared read, exclusive write**: All agents can read the foundation. Only one should write to any given output.
- **Verify between waves**: Check results between waves. Catch issues early before the next wave builds on top.
- **Include `CLAUDE.md` reference**: Every prompt should tell the agent to read the project's `CLAUDE.md` first.

### Phase 6: Verification & Summary

**Command**: `/archive-planning-document` (to archive the completed plan)

After all waves complete:

1. Verify all outputs
2. Update planning document (all milestones checked off)
3. Generate summary of what was accomplished

---

## Why It Works

1. **Progressive Refinement** — Each phase transforms vague ideas into increasingly specific instructions. By the time an agent gets a task, it has everything it needs to execute independently.

2. **Parallel Execution** — Independent work runs simultaneously. A wave of 4 agents does 4x the work in roughly the same wall-clock time.

3. **Convention Inheritance** — Established patterns from the foundation phase mean every agent produces consistent, compatible output.

4. **Context Isolation** — Each agent gets its own context window. The orchestrator stays lean — it coordinates but doesn't hold implementation details.

5. **Dependency-Aware Scheduling** — Milestones are grouped by independence, not category. Sequential where necessary, parallel where possible.

---

## Anti-Patterns to Avoid

- **Overlapping outputs**: If two agents need to modify the same resource, make one depend on the other or consolidate into one agent's scope.
- **Vague task descriptions**: "Handle section 3" is too broad. Specific deliverables with clear boundaries are actionable.
- **Skipping the foundation**: Rushing to parallelize before patterns are established leads to inconsistent results.
- **Not verifying between waves**: An issue in wave 3 compounds through waves 4 and 5.
- **Over-parallelizing**: 3-4 agents per wave is the sweet spot. More increases coordination overhead without proportional speedup.

---

## One-Line Summary

**Idea + structured planning + parallel agent waves + convention inheritance = done in one sitting.**
