# Quickstart: Idea to Done with Custom Commands

A fast-track companion to [The Secret Sauce](secret-sauce.md). This guide walks you through the same process using custom command shortcuts and tells you what to expect at each step.

Read the full guide first if you want to understand the *why* behind each phase. This doc is for when you already get the process and just want to move.

---

## Before You Start

**Have your idea ready.** A few paragraphs in an `Idea.txt` — the problem, the goal, any initial thoughts. Casual is fine.

**Know your escape key.** Press `Esc` at any point to interrupt Claude mid-response. This is one of the most powerful habits you can build:

- **Course-correct early** — if you see the agent heading in the wrong direction, don't wait for it to finish. Interrupt, redirect, and save yourself a tangent.
- **Add an afterthought** — remembered something important mid-response? Hit `Esc`, add your thought, and let it continue with the new context.
- **Don't be precious about it** — interrupting isn't rude and it doesn't break anything. A 2-second course correction beats a 2-minute redo. The earlier you catch a drift, the less work gets thrown away.

This applies throughout the entire workflow — during interviews, while reviewing planning docs, during orchestration. Stay engaged and steer actively.

---

## The Flow

### 1. Seed

Drop your `Idea.txt` into the project directory and reference it in conversation.

### 2. Requirements Interview

```
/planning-interview
```

**What to expect:** Claude asks you questions one at a time — scope, constraints, users, edge cases. Answer naturally. After 5-10 questions, it automatically shifts into a rapid-fire gap-filling mode, probing for edge cases and assumptions you haven't considered.

**When it's done:** Questions start feeling unlikely or trivial. That's your signal — the gaps are closed.

**Your job:** Answer honestly. "I don't know" and "whatever makes sense" are valid. Don't overthink — you can course-correct later.

### 3. Planning Document

```
/make-planning-document
```

**What to expect:** Claude transforms the interview into a structured planning doc with a milestone tracker table, checkboxed tasks, dependency analysis, parallel wave groupings, and model recommendations (Haiku/Sonnet/Opus) per milestone. You'll be asked if you want to use Haiku for simpler milestones — say yes if you're watching usage limits.

**When it's done:** You have a `ProjectName-Planning.md` with everything the orchestrator needs.

**Your job:** Review the milestones and dependencies. Make sure the parallel groupings make sense and nothing critical is missing.

### 4. Foundation

Execute the first milestone(s) sequentially in your main Claude Code window. These are the setup, structure, and shared patterns that everything else builds on.

**Tip:** Create a `CLAUDE.md` at the project root during this phase. Every parallel agent will inherit these conventions automatically.

### 5. Parallel Waves

```
/orchestrator
```

**What to expect:** The orchestrator reads your planning doc, shows a dashboard of milestone status, and generates self-contained prompts for each wave. It tells you which prompts to paste into which Claude Code windows, and which model to use for each.

**When a wave completes:** Workers write summaries to `.orchestrator/`. Tell the orchestrator to "check for updates" — it processes summaries, updates the planning doc, and suggests the next wave.

**Your job:** Open 3-4 Claude Code terminal windows. Paste prompts, wait for completion, tell the orchestrator to process results. Repeat until all milestones are done.

**Pro tip — reuse windows with `/clear`:** After a worker finishes, run `/clear` in that window instead of opening a new one. This resets the context but keeps all permission grants, saving you from re-approving file writes and bash access every wave.

### 6. Verify & Archive

Once all waves are done:

1. **Verify** — run builds, tests, or review deliverables against the milestone checklists
2. **Summarize** — ask Claude to generate a summary of everything accomplished
3. **Archive** — run the command below to clean up and move the planning doc to `docs/`

```
/archive-planning-document
```

---

## Tips That Compound

- **`Esc` early, `Esc` often** — course-correcting in the first 10 seconds saves minutes of wasted work. Don't let a wrong direction play out.
- **`/clear` between waves** — permission grants persist, context resets. Faster than new windows.
- **Model matching matters** — Haiku for boilerplate, Sonnet for features, Opus for architecture. The planning doc recommends one per milestone.
- **`CLAUDE.md` is the bridge** — conventions you write once propagate to every parallel agent automatically.
- **Scope changes aren't restarts** — pause, update the planning doc, resume. Completed work stays valid.

---

## Command Reference

| Command | Phase | What It Does |
|---------|-------|-------------|
| `/planning-interview` | 2 | Interactive requirements gathering with automatic gap-filling |
| `/make-planning-document` | 3 | Structured planning doc with milestones, dependencies, and parallel groups |
| `/orchestrator` | 5 | Coordinates parallel agents — prompts, dashboards, summary processing |
| `/archive-planning-document` | 6 | Cleans, renames, moves plan to `docs/`, updates index, commits |

For the full process with detailed manual instructions for every phase, see [The Secret Sauce](secret-sauce.md).

For setup instructions (installing commands, shared settings), see [setup.md](setup.md).
