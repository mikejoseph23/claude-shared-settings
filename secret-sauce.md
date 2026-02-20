# The Secret Sauce: Idea to Done in One Context Window

## What This Is

A repeatable process for turning a vague idea into a finished outcome using Claude Code with parallel agent waves. Works for any complex problem that benefits from structured decomposition and parallel execution.

No special setup required. Each phase describes exactly what to do with plain conversation. If you later want to go faster, optional custom commands can automate each phase.

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

The seed can be anything — a product idea, a migration plan, a research question, an infrastructure overhaul. Casual and conversational works best.

---

### Phase 2: Requirements Interview

Have Claude interview you about your idea, one question at a time. Reference your `Idea.txt` and ask:

> *"Interview me about this idea. Ask one question at a time, wait for my answer, then ask the next. Cover scope, constraints, users, edge cases, and success criteria."*

Answer honestly when you don't know. "Whatever makes sense" is a valid answer — Claude will make reasonable defaults and you can course-correct later.

After the initial questions (typically 5-10), push for completeness:

> *"Are there any other questions that could help fill gaps in your understanding or surface edge cases? Keep interviewing me in short conversational form until the gaps become narrow and improbable."*

This triggers a rapid-fire second pass — short questions, short answers — that digs into assumptions you didn't know you were making. When the questions start feeling unlikely or trivial, you've reached diminishing returns and it's time to move on.

Every gap closed here is a decision an agent won't have to guess at later.

> **Shortcut**: The `/planning-interview` custom command does all of this automatically, including the exhaust-the-gaps phase. See [Accelerating with Custom Commands](#accelerating-with-custom-commands).

**Output**: Detailed requirements captured in conversation context

---

### Phase 3: Planning Document

Ask Claude to turn the interview results into a structured planning document:

> *"Create a planning document from our interview. Include: a summary with objectives, a milestone progress tracker table, milestones broken into checkboxed tasks, dependency analysis showing which milestones can run in parallel, and a model recommendation (Haiku/Sonnet/Opus) for each milestone."*

The document should have:

- **Summary** with key objectives and success criteria
- **Milestone progress tracker** table (model assignment, status, duration)
- **Milestones** broken into specific, checkboxed task items
- **Dependency analysis** identifying which milestones can run in parallel
- **Model recommendations** per milestone (Haiku for straightforward work, Sonnet for standard tasks, Opus for complex reasoning)

The critical insight: **milestones should be sized for parallelization**. Group work by independence, not by category. Two milestones that touch different outputs can run simultaneously. Two that depend on each other's results cannot.

> **Shortcut**: The `/make-planning-document` custom command generates all of this with consistent formatting, parallel execution groups, and a progress log. See [Accelerating with Custom Commands](#accelerating-with-custom-commands).

**Output**: `ProjectName-Planning.md` with milestones

---

### Phase 4: Foundation (Sequential)

Execute the foundation milestones sequentially. These are the ones everything else depends on — the setup, core structure, and shared resources that all subsequent work builds on.

**Why sequential**: Every subsequent milestone references this foundation. Getting the structure right here means parallel agents can follow established patterns without conflicts.

**Tip**: Establish conventions early and document them in a `CLAUDE.md` at the project root so all agents inherit them. This file is the bridge between you and every parallel agent — it's how conventions propagate without you repeating them.

---

### Phase 5: Parallel Waves

This is where the magic happens. Group remaining milestones into waves based on their dependency chains. Independent milestones run simultaneously, dependent ones wait for their prerequisites.

#### How to dispatch

Open multiple Claude Code terminal windows (3-4 is the sweet spot). For each wave:

1. **Identify** the next set of independent milestones from your planning doc
2. **Write a self-contained prompt** for each milestone — include everything the agent needs (file paths, patterns to follow, references, deliverables). The agent has no access to your main window's context, so the prompt IS the context.
3. **Paste each prompt** into a separate Claude Code window
4. **Wait** for all windows to report completion
5. **Verify** results — check outputs, run tests if applicable, confirm consistency
6. **Update** your planning doc (check off completed milestones)
7. **Repeat** for the next wave

**Reusing windows with `/clear`**: After an agent finishes a milestone, run `/clear` in that window to reset the context. This keeps all permission grants (file write, bash, etc.) while freeing the full context budget for the next milestone. Over a multi-wave project, this avoids re-granting permissions dozens of times. Always prefer `/clear` over opening new windows.

**Model selection**: Each window can run a different model. Use Haiku for straightforward milestones and Opus for complex ones — set the model per window to match the planning doc's recommendations.

**Example orchestrator output** (what you'd prepare for yourself, or what the `/orchestrator` command generates):

```
=== Wave 2 Ready ===

You have 3 idle Claude Code windows from the previous wave.

Window 1 (Sonnet): Run /clear, then paste:
  → [Milestone prompt...]

Window 2 (Sonnet): Run /clear, then paste:
  → [Milestone prompt...]

Window 3 (Haiku): Run /clear, then paste:
  → [Milestone prompt...]

When all windows report completion, verify and move to Wave 3.
```

> **Shortcut**: The `/orchestrator` custom command automates wave analysis, prompt generation, and verification. See [Accelerating with Custom Commands](#accelerating-with-custom-commands).

#### Key principles:

- **Self-contained prompts**: Each prompt must include everything the agent needs. Don't assume shared context.
- **Output ownership**: Each agent owns distinct outputs. Two agents writing to the same resource causes conflicts.
- **Shared read, exclusive write**: All agents can read the foundation. Only one should write to any given output.
- **Verify between waves**: Check results between waves. Catch issues early before the next wave builds on top.
- **Include `CLAUDE.md` reference**: Every prompt should tell the agent to read the project's `CLAUDE.md` first.

---

### Phase 6: Verification & Summary

After all waves complete:

**1. Verify all outputs**

Confirm that every milestone delivered what was expected. For code projects, run the build and test suite. For research or documentation, review each deliverable against its milestone checklist.

**2. Update the planning document**

Go through every milestone in the planning doc and check off completed items. Update the progress tracker table — mark each milestone as complete and note any deviations or decisions made during execution.

**3. Generate a summary**

Ask Claude to generate a summary of everything that was accomplished — what was built/produced, key stats, architecture decisions, and anything notable from the process.

**4. Archive the planning document**

Once the plan is fully complete, archive it to keep the project root clean:

- **Clean the document**: Remove implementation-specific code blocks while preserving the functional spec, progress logs, and milestone status. The archived version should read as a record of *what* was done and *why*, not *how*.
- **Rename**: Drop "plan" or "planning" from the filename (e.g., `MyProject-Planning.md` → `MyProject.md`)
- **Move to `docs/`**: Create the folder if it doesn't exist
- **Update the docs index**: Add a link to the archived doc in `docs/README.md`. Create the README if it doesn't exist.
- **Commit**: Stage the move, the cleaned doc, and the index update as a single commit

> **Shortcut**: The `/archive-planning-document` command does all of this automatically — cleaning, renaming, moving, updating the index, and committing. See [Accelerating with Custom Commands](#accelerating-with-custom-commands).

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

## Accelerating with Custom Commands

Every phase above can be done with plain conversation. But if you find yourself repeating the same instructions across projects, custom commands encode that knowledge into reusable shortcuts.

| Command | Phase | What It Automates |
|---------|-------|-------------------|
| `/planning-interview` | Phase 2 | Structured interview with automatic exhaust-the-gaps phase |
| `/make-planning-document` | Phase 3 | Consistent planning doc format with milestone tracker, dependencies, and parallel groups |
| `/orchestrator` | Phase 5 | Wave analysis, prompt generation, dispatch instructions, verification |
| `/archive-planning-document` | Phase 6 | Archives completed plan to docs folder |

Custom commands are markdown files stored in `~/.claude/commands/`. The filename becomes the slash command. The commands used in this recipe are available at [github.com/mikejoseph23/claude-shared-settings](https://github.com/mikejoseph23/claude-shared-settings/). For setup instructions, see [setup.md](setup.md).

The compounding effect: each command is tuned through real usage. Refinements accumulate — every project benefits from lessons learned in previous ones.

---

## One-Line Summary

**Idea + structured planning + parallel agent waves + convention inheritance = done in one sitting.**
