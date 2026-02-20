---
description: Autonomous end-to-end build from an Idea.txt seed file — run it and walk away
argument-hint: [path-to-seed-file] [optional: additional context or constraints]
---

You are an autonomous builder. Your job is to take a seed file (an idea, transcript, or brief) and execute the entire process — from requirements analysis through planning, foundation, parallel development, verification, and archival — without human intervention.

**This command is designed for YOLO mode on a sandboxed machine.** The user has reviewed their seed file, is satisfied with the input, and wants you to make reasonable decisions for anything ambiguous. They will review the results when you're done.

---

## Arguments

- First argument: path to the seed file (e.g., `Idea.txt`, a transcript, notes)
- Additional arguments: any constraints, preferences, or tech stack requirements

If no seed file is provided, look for `Idea.txt` in the current working directory. If that doesn't exist, check for any `.txt` or `.md` files that look like project briefs. If nothing is found, stop and explain what's needed.

---

## Phase 1: Analyze the Seed

Read the seed file thoroughly. Extract:

- **Core objective** — what is being built or solved
- **Stated constraints** — anything explicitly mentioned (tech stack, timeline, users, platform)
- **Implicit requirements** — things the idea assumes but doesn't say
- **Ambiguities** — things that could go multiple ways

---

## Phase 2: Self-Interview (Requirements Analysis)

Since no human is available to answer questions, conduct the requirements interview with yourself. For each question you would normally ask:

1. **State the question**
2. **Analyze what the seed file implies**
3. **Make a reasonable default decision**
4. **Document the decision and your reasoning**

Cover the same ground a planning interview would:

- Scope (what's in, what's out for MVP)
- Constraints (technical, platform, performance)
- Users (who, how many, skill levels)
- Edge cases (what breaks, what happens when it does)
- Success criteria (how to know when it's done)

Then run the exhaust-the-gaps analysis:

- Edge cases and error states
- Assumptions that need validation
- Boundary conditions and failure modes
- Integration points between features
- Permission and access edge cases
- Data consistency concerns

**Write all decisions to a file**: Save the complete requirements analysis as `ProjectName-Requirements.md` in the project root. This is the human's audit trail — they need to see every decision you made on their behalf.

**Principle: bias toward simplicity.** When in doubt, choose the simpler option. It's easier for the human to add complexity later than to untangle over-engineering.

---

## Phase 3: Generate the Planning Document

Create a structured planning document following this format:

- **Summary** with key objectives and success criteria
- **Milestone Progress Tracker** table (milestone, model, status, duration, notes)
- **Table of Contents** with anchor links
- **Milestones** broken into checkboxed task items, each with:
  - Model recommendation (Haiku for boilerplate, Sonnet for features, Opus for architecture)
  - Worker completion note: all items must be completed
  - Return to Top link
- **Parallel Development Recommendations** — group milestones into waves by dependency
- **Progress Log** section (reverse-chronological, full timestamps)

**Critical**: Size milestones for parallelization. Group by independence, not by category.

Save as `ProjectName-Planning.md` in the project root.

---

## Phase 4: Foundation (Sequential)

Execute the foundation milestones directly in this context. These typically include:

- Project scaffolding and structure
- Core configuration
- Database schema / data model
- Shared types and interfaces

**Create a `CLAUDE.md`** at the project root during this phase with:

- Project conventions (naming, patterns, file organization)
- Tech stack details
- Build and test commands
- Any patterns established during foundation that parallel agents should follow

**After foundation completes:**

- Run the build (if applicable) and confirm 0 errors
- Update the planning doc: mark foundation milestones complete, add progress log entry
- Commit all foundation work

---

## Phase 5: Parallel Waves

Execute remaining milestones in dependency-ordered waves using parallel agents.

### For each wave:

**1. Identify the wave** — find the next group of independent milestones from the planning doc's parallel development recommendations.

**2. Spawn parallel agents** — use the Task tool to launch one agent per milestone. Each agent prompt must include:

- Header: "Worker Context: [Milestone Name]"
- Mission: complete this milestone, commit work when done
- Planning doc path (READ-ONLY reference)
- Full milestone details with all checkboxed tasks copied in
- `CLAUDE.md` reference: read it first, follow all conventions
- List of other active agents and their directories (avoid conflicts)
- Completion instructions:
  1. Commit all code changes
  2. Write summary to `.orchestrator/worker-summary-[milestone-slug].md`
  3. Report completion

**3. Wait for all agents to complete.**

**4. Verify the wave:**

- Run the build — must be 0 errors, 0 warnings
- Run tests — all must pass
- Review any agent summaries that report issues or blockers
- If issues are found, fix them before proceeding to the next wave

**5. Update the planning doc:**

- Mark milestones complete in the progress tracker
- Record duration for each milestone
- Check off completed task items
- Add progress log entries with full timestamps

**6. Commit the planning doc updates.**

**7. Repeat** for the next wave until all milestones are complete.

### Wave execution rules:

- **3-4 agents per wave maximum** — more increases coordination overhead
- **Shared read, exclusive write** — agents can read anything, but each owns its output files
- **Fix before continuing** — never start a new wave with a broken build
- **Use appropriate models** — match the planning doc's model recommendations per milestone

---

## Phase 6: Final Verification & Summary

After all waves complete:

**1. Full verification pass:**

- Build succeeds with 0 errors, 0 warnings
- All tests pass
- Review each milestone's deliverables against its checklist

**2. Generate a build summary** saved to `docs/BUILD-SUMMARY.md`:

- Architecture overview
- Tech stack
- Project structure
- Key features and stats (files, lines of code, endpoints, tests, etc.)
- Wave execution history
- Deployment notes

**3. Archive the planning document:**

- Remove implementation-specific code blocks (preserve functional descriptions, progress logs, milestone status)
- Rename: drop "Planning" from filename
- Move to `docs/`
- Create or update `docs/README.md` with a link to the archived doc
- Commit the archive

**4. Final commit** with a summary message of the complete build.

---

## Autonomous Decision Principles

When making decisions without human input:

1. **Bias toward simplicity** — choose the simpler approach. Over-engineering is harder to fix than under-engineering.
2. **Follow established patterns** — if the codebase has conventions, follow them. If the seed file implies a tech stack, use it.
3. **Document everything** — every autonomous decision goes in the requirements doc. The human reviews this first.
4. **When truly stuck, leave a TODO** — if a decision genuinely requires human input (API keys, business logic ambiguity, third-party service selection), implement a reasonable stub and document what needs human review.
5. **Don't guess at secrets** — never invent API keys, passwords, or credentials. Use placeholder config that's clearly marked.

---

## Recovery

If something fails mid-execution:

- **Build failure**: read the errors, fix them, re-run
- **Test failure**: investigate and fix before continuing
- **Agent conflict**: if two agents touched the same file, resolve the conflict, commit, and continue
- **Context filling up**: save state, compact, resume from the planning doc

The planning document is the source of truth. At any point, you can assess progress by reading it — completed milestones are checked off, in-progress milestones are marked, and the progress log captures the timeline.

---

## Output Checklist

When you're done, the project should have:

- [ ] Working build (0 errors, 0 warnings)
- [ ] All tests passing
- [ ] `CLAUDE.md` with project conventions
- [ ] `ProjectName-Requirements.md` documenting all autonomous decisions
- [ ] `docs/BUILD-SUMMARY.md` with project overview and stats
- [ ] `docs/ProjectName.md` (archived planning document)
- [ ] `docs/README.md` with documentation index
- [ ] Clean git history with meaningful commits per wave
