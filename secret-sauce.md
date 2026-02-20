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

**Pro tip — stakeholder interviews**: If you have access to a stakeholder or subject matter expert, have a conversation with them and record it. Transcribe the recording and use it as your seed (or alongside your `Idea.txt`). A raw transcript captures domain knowledge, priorities, and constraints that you'd otherwise have to remember and retype. When the planning interview runs with a transcript as context, it asks sharper, more relevant questions because it already has the stakeholder's language and priorities to build on.

---

### Phase 2: Requirements Interview

Have Claude interview you about your idea, one question at a time. Reference your `Idea.txt` and ask:

> *"Interview me about this idea. Ask one question at a time, wait for my answer, then ask the next. Cover scope, constraints, users, edge cases, and success criteria."*

Answer honestly when you don't know. "Whatever makes sense" is a valid answer — Claude will make reasonable defaults and you can course-correct later.

#### How to run the interview

**Start the main interview (5-10 questions):**

Claude should ask clear, focused questions that build on your previous answers. Good questions cover:

- **Scope**: What's in, what's out, what's the MVP vs. future
- **Constraints**: Timeline, budget, technical limitations, team size
- **Users**: Who uses it, how many, what are their skill levels
- **Edge cases**: What happens when things go wrong
- **Success criteria**: How do you know when it's done

The key rule: **one question per message, wait for the answer, then ask the next**. This forces depth over breadth — each answer shapes the next question.

**Trigger the exhaust-the-gaps phase:**

After the initial questions, push for completeness:

> *"Are there any other questions that could help fill gaps in your understanding or surface edge cases? Keep interviewing me in short conversational form until the gaps become narrow and improbable."*

This triggers a rapid-fire second pass — short questions, short answers — that digs into assumptions you didn't know you were making. Focus areas for this phase:

- **Edge cases and error states** — What breaks? What happens when it does?
- **Assumptions that haven't been validated** — Are you sure about that default?
- **Boundary conditions and failure modes** — Limits, caps, timeouts
- **Integration points between features** — Where do things connect?
- **Permission and access edge cases** — Who can see/do what, when?
- **Offline/disconnected scenarios** — What works without a connection?
- **Data consistency concerns** — What if two things happen at once?

Questions will naturally progress from high-impact to increasingly niche. **When they start feeling unlikely or trivial, you've reached diminishing returns** and it's time to move on.

#### Why this matters

Every gap closed here is a decision an agent won't have to guess at later. Ambiguity in requirements becomes inconsistency in outputs — especially when multiple agents are working in parallel without shared context.

> **Shortcut**: The `/planning-interview` custom command does all of this automatically — structured one-at-a-time questions, adaptive follow-ups, and the exhaust-the-gaps phase built in as a mandatory step. Worth adopting because it ensures the gap-filling phase always happens (easy to skip when doing it manually) and encodes the focus areas so you don't have to remember them. See [Accelerating with Custom Commands](#accelerating-with-custom-commands).

**Output**: Detailed requirements captured in conversation context

---

### Phase 3: Planning Document

Ask Claude to turn the interview results into a structured planning document:

> *"Create a planning document from our interview. Include: a summary with objectives, a milestone progress tracker table, milestones broken into checkboxed tasks, dependency analysis showing which milestones can run in parallel, and a model recommendation (Haiku/Sonnet/Opus) for each milestone."*

#### What the document should contain

**a) Summary**: A concise overview at the top with the purpose, key objectives, and success criteria. Below it, include a **Milestone Progress Tracker** table:

| Milestone | Model | Status | Duration (min) | Notes |
|-----------|-------|--------|----------------|-------|
| M1: Setup | Sonnet | ⬜ Not Started | — | Foundation work |
| M2: Data Model | Sonnet | ⬜ Not Started | — | Depends on M1 |

Track duration when milestones complete — this builds estimation intuition over time.

**b) Table of contents**: Linked anchors to every major section. Makes the document navigable as it grows.

**c) Milestones with section organization**: Each milestone gets its own section with a clear header, descriptive text, and a model recommendation. Include a "Return to Top" link at the end of each section. Model guidelines:

- **Haiku**: Mechanical/boilerplate work, simple CRUD, straightforward UI, basic tests
- **Sonnet**: Most feature work, moderate complexity, well-defined tasks
- **Opus**: Complex architecture, nuanced decisions, ambiguous requirements

**d) Checkboxed task items**: Every actionable item gets a `- [ ]` checkbox. Items should be specific and measurable — "Implement user login endpoint with JWT" not "Handle auth." Include a note in each milestone that **workers must complete ALL listed items**. If a worker thinks an item should be deferred, they note it in their summary but still attempt the work.

**e) Work organization**: Choose the structure that fits the content — by functional category (Backend, Frontend, DevOps), by phase (MVP, Beta, Production), or by timeline. Break complex items into smaller trackable tasks.

**f) Progress log**: A dedicated section at the end for reverse-chronological entries tracking execution:

```
**2025-06-15 14:32** - Completed M3 (Venues API). 9 endpoints, all tests passing.
Deviation: Added branding endpoint not in original spec per user request.

**2025-06-15 10:15** - Started Wave 2 with 3 parallel agents (M3, M4, M5).
```

Use full timestamps (date AND time) — this captures the real timeline of execution.

**g) Parallel development recommendations**: Analyze which milestones can run simultaneously:

- Group independent milestones into **parallel waves** (e.g., Wave 1: M1-M2 sequential, Wave 2: M3+M4+M5 parallel)
- Identify **sequential blockers** that must complete before others start
- Note any milestones that are **sequential blockers** — everything downstream waits for these

**h) Gap-filling guidance**: When a milestone has incomplete work, follow-up prompts should include what was already done, which files were modified, and only the remaining unchecked items. Label these clearly (e.g., "Milestone 3 — Gap Fill").

**i) Context management note**: For large projects, the orchestrator context may fill up. Note that the user can run `/compact` while waiting for workers, and resume by re-reading the planning doc and any saved state.

#### The critical insight

**Milestones should be sized for parallelization.** Group work by independence, not by category. Two milestones that touch different outputs can run simultaneously. Two that depend on each other's results cannot.

> **Shortcut**: The `/make-planning-document` custom command generates all nine structural elements (a–i) with consistent formatting every time. Worth adopting because the format has many interlocking parts — the tracker table, checkbox format, progress log timestamps, parallel groupings, gap-filling guidance — and getting them consistent manually across projects takes effort. The command encodes all of this so you can focus on content, not structure. See [Accelerating with Custom Commands](#accelerating-with-custom-commands).

**Output**: `ProjectName-Planning.md` with milestones

---

### Phase 4: Foundation (Sequential)

Execute the foundation milestones sequentially. These are the ones everything else depends on — the setup, core structure, and shared resources that all subsequent work builds on.

**Why sequential**: Every subsequent milestone references this foundation. Getting the structure right here means parallel agents can follow established patterns without conflicts.

**Tip**: Establish conventions early and document them in a `CLAUDE.md` at the project root so all agents inherit them. This file is the bridge between you and every parallel agent — it's how conventions propagate without you repeating them.

---

### Phase 5: Parallel Waves

This is where the magic happens. Group remaining milestones into waves based on their dependency chains. Independent milestones run simultaneously, dependent ones wait for their prerequisites.

#### Setting up orchestration

Before dispatching the first wave, set up a lightweight coordination structure:

1. **Create an `.orchestrator/` folder** in the project root (add it to `.gitignore`)
2. **Save session state** in `.orchestrator/state.json` — track which planning doc you're using, which workers are active, and which summaries you've processed
3. **Choose a prompt delivery mode**: Either display prompts inline (copy/paste from the orchestrator window) or save them to `.orchestrator/prompts/` as markdown files workers can read directly

This state file is your recovery point. If your orchestrator context fills up, you can `/compact` or start a new window and resume by reading the state.

#### How to write worker prompts

Each worker prompt must be completely self-contained — the agent has no access to your main window's context. Every prompt should include these six components:

1. **Header**: "Worker Context: [Milestone Name]" — makes it clear what this agent is responsible for

2. **Mission statement**: Explain they are a worker handling a specific milestone. They should complete the work, write a summary, and close the context. One milestone per worker — no scope creep.

3. **Planning document reference**: Path to the planning doc for READ-ONLY context. Include this warning:
   > **IMPORTANT: Do NOT edit the planning document.** The orchestrator is the only context that updates the planning doc. You may READ it for reference, but never modify it.

4. **Milestone details**: Copy the relevant milestone section from the planning doc including all checkboxed tasks, relevant file paths, and the model recommendation. Emphasize that **ALL listed tasks must be completed** — workers should not skip items they consider low priority.

5. **Parallel work awareness**: List other active workers and what directories they're working in. Instruct this worker to avoid those areas and flag any conflicts.

6. **Completion instructions** (in this exact order):
   - **FIRST**: Commit all code changes for this milestone
   - **SECOND**: Write a summary to `.orchestrator/worker-summary-[milestone-slug].md` including: status (Completed/Blocked/Partial), work completed, files modified, test status, issues or blockers, start and end time
   - **DO NOT** edit the planning document
   - **LAST**: Tell the user the milestone is complete and prompt them to close/clear the context

#### How to dispatch

Open multiple Claude Code terminal windows (3-4 is the sweet spot). For each wave:

1. **Identify** the next set of independent milestones from your planning doc
2. **Write a self-contained prompt** for each milestone using the six-component structure above
3. **Paste each prompt** into a separate Claude Code window
4. **Update your planning doc** — mark dispatched milestones as "In Progress"
5. **Wait** for all windows to report completion
6. **Process summaries** — read each `.orchestrator/worker-summary-*.md`, check for issues, and update the planning doc (mark complete, record duration, check off task items, add a progress log entry with full timestamp)
7. **Verify** results — check outputs, run tests if applicable, confirm consistency across workers
8. **Handle gaps** — if a worker's summary shows incomplete work, generate a gap-filling prompt that references what was already done and lists only the remaining unchecked items
9. **Repeat** for the next wave

#### Maintaining the dashboard

Keep a mental (or written) dashboard of orchestration state:

- Which workers are active and what they're working on
- Which milestones are complete, in progress, or blocked
- Any pending summaries that need processing
- Any alerts from workers who hit blockers

After processing each summary, update the planning doc's progress tracker table with the completion status and duration.

**Reusing windows with `/clear`**: After an agent finishes a milestone, run `/clear` in that window to reset the context. This keeps all permission grants (file write, bash, etc.) while freeing the full context budget for the next milestone. Over a multi-wave project, this avoids re-granting permissions dozens of times. Always prefer `/clear` over opening new windows.

**Model selection**: Each window can run a different model. Use Haiku for straightforward milestones and Opus for complex ones — set the model per window to match the planning doc's recommendations.

**Context management**: If your orchestrator window is getting full from processing many waves, save the current state to `.orchestrator/state.json`, run `/compact`, and resume by re-reading the state file and planning doc.

> **Shortcut**: The `/orchestrator` custom command automates the entire coordination loop — state management, dashboard display, prompt generation with all six components, summary processing, gap-filling, and context management. Worth adopting because manual orchestration requires holding a lot of moving pieces (active workers, pending summaries, dependency chains, prompt formatting) and the command handles all of it consistently. It also enforces rules that are easy to forget manually, like the "workers must not edit the planning doc" constraint and the commit-before-summary ordering. See [Accelerating with Custom Commands](#accelerating-with-custom-commands).

#### Key principles:

- **Self-contained prompts**: Each prompt must include everything the agent needs. Don't assume shared context.
- **Output ownership**: Each agent owns distinct outputs. Two agents writing to the same resource causes conflicts.
- **Shared read, exclusive write**: All agents can read the foundation. Only one should write to any given output.
- **Verify between waves**: Check results between waves. Catch issues early before the next wave builds on top.
- **Include `CLAUDE.md` reference**: Every prompt should tell the agent to read the project's `CLAUDE.md` first.
- **Only the orchestrator edits the planning doc**: Workers read it for context but never modify it. This prevents merge conflicts and keeps one source of truth.

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

> **Shortcut**: The `/archive-planning-document` command does all of this automatically — identifying the doc, previewing changes before acting, cleaning code blocks, renaming, moving, updating the index, and committing. Worth adopting because the cleaning step (deciding what to remove vs. preserve) is tedious to do manually and easy to get inconsistent. The command also confirms every step before executing, so you maintain control without doing the mechanical work. See [Accelerating with Custom Commands](#accelerating-with-custom-commands).

---

## Why It Works

1. **Progressive Refinement** — Each phase transforms vague ideas into increasingly specific instructions. By the time an agent gets a task, it has everything it needs to execute independently.

2. **Parallel Execution** — Independent work runs simultaneously. A wave of 4 agents does 4x the work in roughly the same wall-clock time.

3. **Convention Inheritance** — Established patterns from the foundation phase mean every agent produces consistent, compatible output.

4. **Context Isolation** — Each agent gets its own context window. The orchestrator stays lean — it coordinates but doesn't hold implementation details.

5. **Dependency-Aware Scheduling** — Milestones are grouped by independence, not category. Sequential where necessary, parallel where possible.

---

## Handling Scope Changes

If requirements change mid-execution:

1. **Pause** — stop dispatching new waves
2. **Update the planning document** — revise affected milestones, add new ones, adjust dependencies
3. **Resume** — continue from where you left off with the updated plan

Don't restart from scratch. The foundation and completed waves are still valid. Adjust the remaining work to reflect the new direction.

---

## The Most Underused Shortcut: Escape

Press `Esc` at any point to interrupt Claude mid-response. This single habit changes the entire dynamic:

- **Course-correct early** — if you see the agent heading in the wrong direction, don't wait for it to finish. Interrupt, redirect, save yourself a tangent. A 2-second correction beats a 2-minute redo.
- **Add an afterthought** — remembered a constraint mid-response? Hit `Esc`, add it, let Claude continue with the new context.
- **Stay in the loop** — the process works best when you're actively steering, not passively watching. The earlier you catch a drift, the less work gets thrown away.

This applies everywhere — during interviews, while reviewing planning docs, during orchestration, while agents are working. Don't be precious about interrupting. It's not rude and it doesn't break anything.

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
| `/autopilot` | All | End-to-end autonomous build — seed to finished project, no human in the loop |

### The Nuclear Option: `/autopilot`

The `/autopilot` command chains the entire process into a single autonomous run. Give it your `Idea.txt`, run it in YOLO mode on a sandboxed machine, and walk away. It self-conducts the requirements analysis (documenting every decision it makes on your behalf), generates the planning doc, builds the foundation, dispatches parallel waves, verifies between each wave, and archives everything when done.

**When to use it**: When your seed file is thorough enough that you trust reasonable defaults for the gaps. Works best when the idea is well-defined or when you've already done a stakeholder interview and have a transcript as input.

**When not to use it**: When the project has critical ambiguities that genuinely need human judgment — business logic decisions, third-party service selection, security architecture. The command will stub these and leave TODOs, but if the whole project hinges on them, run the interactive process instead.

**Safety**: Run it on a machine you're comfortable giving full autonomy to. YOLO mode auto-approves all file writes, bash commands, and agent spawning. A sandboxed/firewalled environment means the worst case is a project you delete, not a machine you regret.

Custom commands are markdown files stored in `~/.claude/commands/`. The filename becomes the slash command. The commands used in this recipe are available at [github.com/mikejoseph23/claude-shared-settings](https://github.com/mikejoseph23/claude-shared-settings/). For setup instructions, see [setup.md](setup.md).

The compounding effect: each command is tuned through real usage. Refinements accumulate — every project benefits from lessons learned in previous ones.

---

## One-Line Summary

**Idea + structured planning + parallel agent waves + convention inheritance = done in one sitting.**
