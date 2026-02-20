# The Secret Sauce: Idea to Full-Stack App in One Context Window

## What This Is

A repeatable process for turning a casual idea into a complete, multi-platform application using Claude Code with parallel agent teams — all within a single conversation context.

## The Secret Ingredient: Custom Commands

The process is accelerated by **custom slash commands** — reusable prompt templates stored in a shared settings repo that encode your workflow as repeatable skills. Each phase of the recipe maps to a command.

Claude Code supports custom commands at three levels:
- **Project commands**: `.claude/commands/` in your repo (shared with your team)
- **User commands**: `~/.claude/commands/` (personal, available in all projects)
- **Shared settings**: A git repo synced across machines via `claude-shared-settings` (available everywhere, version-controlled)

### Commands Used in This Recipe

| Command | Phase | What It Does |
|---------|-------|-------------|
| `/planning-interview` | Phase 2 | Interviews you one question at a time about a planning document section. Asks focused questions, builds on your answers, knows when it has enough. |
| `/make-planning-document` | Phase 3 | Transforms interview output into a structured planning document with milestone tracker, checkboxes, dependency analysis, model recommendations, parallel execution groups, and progress log. |
| `/orchestrator` | Phase 5 | Coordinates parallel processing of milestones from a planning document using agent teams. |
| `/archive-planning-document` | Phase 6 | Archives a completed planning document to the docs folder. |

**Optional, stack-specific commands:**

| Command | When Useful | What It Does |
|---------|------------|-------------|
| `/setup-project-simpleauth` | Web app / API projects | Scaffolds a .NET project with auth, SSO, admin panel, and database — a full foundation in one command. |

Phase 4 (Foundation) benefits the most from a scaffolding command, but it's stack-specific. Build your own for whatever tech you use most — Rails, Next.js, Django, Spring Boot, etc. The recipe works without one; it just means Phase 4 takes a bit longer.

### Why Custom Commands Matter

Without custom commands, you'd spend the first 15 minutes of every project re-explaining your preferred planning format, interview style, project scaffolding approach, and team coordination strategy. Custom commands encode that institutional knowledge once and replay it perfectly every time.

**The compounding effect**: Each command is tuned through real usage. The planning document command knows to include parallel execution groups because you learned that matters. The interview command knows to ask one question at a time because flooding the user with questions produces shallow answers. These refinements accumulate — every project benefits from lessons learned in previous ones.

### Creating Your Own

Store commands as markdown files with a system prompt. The filename becomes the slash command name:

```
~/.claude/commands/
├── planning-interview.md      → /planning-interview
├── make-planning-document.md  → /make-planning-document
└── orchestrator.md            → /orchestrator
```

Each file contains the full prompt that gets injected when the command is invoked. Think of them as saved expertise — the best version of instructions you've iterated on, ready to deploy instantly.

For team sharing, use a shared settings repo:
```
~/git/claude-shared-settings/commands/
```

Configure it in `~/.claude/settings.json`:
```json
{
  "sharedSettingsDir": "~/git/claude-shared-settings"
}
```

Now every machine and every team member gets the same commands, and improvements propagate via git.

---

## The Process

### Phase 1: Seed

Start with a raw idea file. It doesn't need to be formal. A few paragraphs describing the problem, the vision, and any features you've been thinking about. The messier and more authentic, the better — it captures intent that formal specs often lose.

**Input**: `Idea.txt` (or whatever you have — notes, voice transcript, napkin photo)

**Example** — the "Hello World" of this process:

```text
# Idea.txt

I want to build a to-do list app. Not just another checkbox list though.

I want it to feel like a real productivity tool. You should be able to
organize tasks into projects, set due dates and priorities, and maybe
have some kind of recurring task support for stuff like "take out the
trash every Thursday."

I'd love a clean minimal UI — something I'd actually want to look at
every day. Dark mode obviously. Maybe a calendar view so I can see
what's coming up this week.

Eventually I'd want it on my phone too, not just the browser. And it
would be cool if I could share a project with someone else, like a
shared grocery list with my partner that syncs in real time.

I don't want to use someone else's API — I want to own my data. So
a backend I control, probably with a database I can back up.

Notifications would be nice. Remind me 30 minutes before something
is due, or nag me if I keep snoozing a task.
```

That's it. Casual, conversational, full of "I want" and "it would be cool if." The planning interview will turn this into structured requirements, and the planning document will break it into parallelizable milestones.

### Phase 2: Requirements Interview

**Command**: `/planning-interview`

Use a structured interview command to extract detailed requirements from the idea. One question at a time, building on previous answers. This surfaces decisions you haven't thought about yet:

- User roles and permissions
- Edge cases and error states
- Platform targets and constraints
- Data model implications
- Real-time vs batch requirements
- Auth and access patterns

**Tip**: Answer honestly when you don't know. "Whatever makes sense" is a valid answer — the AI will make reasonable defaults and you can course-correct later.

The command has a built-in **exhaust-the-gaps phase** that automatically kicks in after the main interview. It transitions into rapid-fire, short-form Q&A probing edge cases and assumptions until they become improbable. Every gap closed here is a decision an agent won't have to guess at later.

**Output**: Detailed requirements captured in conversation context

### Phase 3: Planning Document

**Command**: `/make-planning-document`

Generate a structured planning document with:

- **Summary** with key objectives and success criteria
- **Milestone progress tracker** table (model assignment, status, duration)
- **Milestones** broken into specific, checkboxed task items
- **Dependency analysis** identifying which milestones can run in parallel
- **Model recommendations** per milestone (Haiku for boilerplate, Sonnet for standard work, Opus for architecture)

The critical insight: **milestones should be sized for parallelization**. Group work by independence, not by category. Two milestones that touch different files can run simultaneously. Two that modify the same service cannot.

**Output**: `ProjectName-Planning.md` with 10-20 milestones

### Phase 4: Foundation (Sequential)

**Command**: Your own scaffolding command, if you have one

This is where a project scaffolding command shines — if your project includes a web app or API, a command like `/setup-project-simpleauth` can drop in a complete auth system, admin panel, and database config in one invocation. But this is stack-specific and optional. The point of Phase 4 isn't *how* you scaffold — it's that you establish the foundation before parallelizing. Whether that's a custom command, a `create-react-app`, `dotnet new`, `cargo init`, or manual setup doesn't matter.

Build the foundation milestones sequentially. These are the ones everything else depends on:

1. Project scaffolding, auth, configuration
2. Data model, database schema, core abstractions
3. Service layer, repository pattern, base controllers

**Why sequential**: Every subsequent milestone imports from these files. Getting the patterns right here means parallel agents can follow established conventions without conflicts.

**Tip**: Establish conventions early — DI patterns, naming conventions, folder structure, error handling approach. Document them in a `CLAUDE.md` at the project root so all agents inherit them.

### Phase 5: Parallel Waves

**Command**: `/orchestrator` (or manual team coordination)

This is where the magic happens. Group remaining milestones into waves based on their dependency chains:

```
Wave 1: [Sequential foundation — M1, M2]
Wave 2: [M3, M4, M5]        ← 3 agents, independent API work
Wave 3: [M6, M7, M14, M15]  ← 4 agents, independent features
Wave 4: [M8, M10, M12, M16] ← 4 agents, different platforms
Wave 5: [M9, M11, M13]      ← 3 agents, depends on wave 4
```

#### Dispatching: Two Approaches

**Approach A: Built-in agent teams** (used in the OpenMicApp build)

Uses Claude Code's `TeamCreate` / `Task` tool to spawn in-process subagents. The orchestrator manages everything within a single context window. Pros: fully automated, no manual steps. Cons: subagents can't be individually configured for permissions or model, and the orchestrator context holds all coordination overhead.

**Approach B: Multi-window orchestration** (recommended for larger projects)

The orchestrator runs in one Claude Code window and prompts the *user* to dispatch work to separate Claude Code terminal windows. This is the preferred approach because:

1. **Permission persistence**: Tool permissions (file write, bash, etc.) are granted per-window and survive `/clear`. Opening a new window means re-approving everything. Reusing a window with `/clear` means zero permission friction.
2. **Model selection**: Each window can run a different model. The orchestrator can specify "use Haiku for M6" and "use Opus for M9" — the user sets the model per window.
3. **Visibility**: Each agent's work is visible in its own terminal. You can watch progress, intervene, or redirect in real time.
4. **Resource control**: You decide how many windows to run based on your machine and your plan tier. 3-4 simultaneous windows is the sweet spot.

**How the orchestrator should prompt the user**:

For each wave, the orchestrator generates ready-to-paste prompts and tells the user:

```
=== Wave 3 Ready ===

You have 3 idle Claude Code windows from the previous wave.

Window 1 (Sonnet): Run /clear, then paste:
  → [M6 prompt: TV Display implementation...]

Window 2 (Sonnet): Run /clear, then paste:
  → [M7 prompt: Mobile Web implementation...]

Window 3 (Sonnet): Run /clear, then paste:
  → [M14 prompt: Anti-Abuse & Moderation...]

Need a 4th window? Open a new terminal and run: claude --model sonnet
  → [M15 prompt: Venue Branding...]

When all windows report completion, come back here and tell me.
```

The orchestrator then waits, and when the user returns, it verifies the build, runs tests, updates the planning doc, and generates the next wave's prompts.

**Reusing windows with `/clear`**: This is the key optimization. After an agent finishes a milestone, the user runs `/clear` in that window to reset the context but keep all permission grants. The next milestone prompt starts fresh with full context budget but no permission friction. Over a 5-wave build with 4 windows, this avoids re-granting permissions ~16 times.

#### For each wave:

1. **Orchestrator analyzes** the planning doc for the next set of independent milestones
2. **Orchestrator generates prompts** — detailed, self-contained, with file paths, API routes, and conventions baked in
3. **Orchestrator tells the user** which windows to `/clear` and which prompts to paste, specifying the model for each
4. **User dispatches** to their terminal windows
5. **Agents work independently** — each reads the codebase, builds their milestone, reports completion in their window
6. **User returns to orchestrator** and reports results
7. **Orchestrator verifies** — build, tests, planning doc updates
8. **Repeat** for next wave

**Key principles for parallel agents**:

- **Detailed, self-contained prompts**: Each prompt must include everything the agent needs — file paths to read, patterns to follow, API routes, DTO shapes. The agent has no access to the orchestrator's context, so the prompt IS the context.
- **File ownership**: Each agent should own distinct files/directories. Two agents editing the same file causes conflicts. Structure your milestones to avoid overlap.
- **Shared read, exclusive write**: All agents can read the foundation code. Only one agent should write to any given file.
- **Verify between waves**: Run `build` and `test` between waves. Catch integration issues before the next wave builds on top.
- **Include `CLAUDE.md` reference**: Every prompt should tell the agent to read the project's `CLAUDE.md` first. This is how conventions propagate without the orchestrator repeating them in every prompt.

### Phase 6: Verification & Summary

**Command**: `/archive-planning-document` (to archive the completed plan)

After all waves complete:

1. Full build verification (0 errors, 0 warnings)
2. Run complete test suite
3. Update planning document (all milestones checked off)
4. Generate build summary with stats and architecture overview

---

## The Numbers That Matter

In practice, this process achieves:

| Metric | Typical Range |
|--------|--------------|
| Milestones per wave | 3-4 |
| Agents per wave | 3-4 |
| Total waves | 4-6 |
| Context usage | 40-60% |
| Files generated | 100-200+ |
| Lines of code | 15,000-25,000+ |

The context efficiency comes from delegation. The orchestrator (main conversation) doesn't hold the implementation details — it delegates to agents who do the work in their own context, report back with summaries, and get shut down. The orchestrator only holds the plan, the coordination messages, and the verification results.

---

## Why It Works

### 1. Progressive Refinement
Each phase transforms vague ideas into increasingly specific instructions. By the time an agent gets a task, it has exact file paths, API routes, and DTO shapes to work with.

### 2. Parallel Execution
Independent work runs simultaneously. A wave of 4 agents does 4x the work in roughly the same wall-clock time as one agent doing a single milestone.

### 3. Convention Inheritance
The `CLAUDE.md` file and established patterns from the foundation phase mean every agent produces code that looks like it was written by the same developer. Consistent DI patterns, naming, error handling, and folder structure.

### 4. Context Isolation
Each agent gets its own context window. The orchestrator stays lean — it coordinates but doesn't hold implementation details. This is why you can build an entire application without running out of context.

### 5. Dependency-Aware Scheduling
Milestones are grouped by independence, not category. This maximizes parallelism while preventing conflicts. Sequential where necessary, parallel where possible.

---

## Template: Agent Task Prompt

When spawning a parallel agent, include:

```
You are a teammate on the {team-name} team. Your name is "{agent-name}".

Your task is to implement {Milestone N}: {Title}.
Read the full task details using TaskGet for task #{id},
then mark it in_progress with TaskUpdate.

{2-3 sentences describing the work}

Key points:
- Read these files first: {list of files to understand}
- Create new files at: {target directories}
- Follow patterns established in: {reference files}
- API routes to implement/call: {list of endpoints}

Project root: {path}

When done, mark task #{id} as completed.
```

---

## Template: Wave Execution (Multi-Window)

```
1. Orchestrator reads planning doc, identifies next independent milestones
2. Orchestrator generates self-contained prompts (one per milestone)
3. Orchestrator tells user:
   - Which windows to /clear (reuse from previous wave)
   - Which model to use per window
   - Which prompt to paste in each
   - Whether a new window is needed (and what model)
4. User dispatches prompts to Claude Code windows
5. Agents work independently, report completion in their window
6. User returns to orchestrator: "all done" or "window 2 had an issue"
7. Orchestrator verifies: build + tests
8. Orchestrator updates planning document checkboxes
9. Repeat for next wave
```

**Why `/clear` over new windows**: Permissions granted in a Claude Code session persist
across `/clear` but not across new windows. A window that already has bash, file write,
and edit permissions approved keeps them after clearing. This eliminates the permission
approval friction that would otherwise multiply across every wave and every agent.

---

## Anti-Patterns to Avoid

- **Too many agents on shared files**: If two agents need to edit `Program.cs`, put them in the same wave but make one depend on the other, or consolidate into one agent's scope.
- **Vague task descriptions**: "Build the iOS app" is too broad. "Add venue CRUD methods to APIClient.swift, then create VenueListView and VenueEditorView following the pattern in EventView.swift" is actionable.
- **Skipping the foundation**: Rushing to parallelize before patterns are established leads to inconsistent code that needs rework.
- **Not verifying between waves**: An integration bug in wave 3 that goes unnoticed will compound through waves 4 and 5.
- **Over-parallelizing**: 4 agents is a practical sweet spot. More than that increases coordination overhead and conflict risk without proportional speedup.

---

## Scaling Up

This process scales to larger projects by adding more waves, not more agents per wave. A 30-milestone project might need 8 waves instead of 5, but each wave still runs 3-4 agents.

For very large projects, you can also nest the process: use one conversation to plan and build the backend, another for the frontend, and a third for mobile apps — each following the same wave pattern internally.

---

## One-Line Summary

**Idea file + structured planning + parallel agent waves + convention inheritance = full-stack app in one sitting.**
