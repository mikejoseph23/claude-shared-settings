---
description: Create a comprehensive planning document with structure and tracking
argument-hint: [optional: file-path] [optional: additional instructions]
---

Create a planning document for the current working file in our IDE (or the file specified in arguments if provided). Transform the document into a structured planning document by completing the following tasks:

**Target File:** $ARGUMENTS (if no file specified, use the current working directory context or prompt for clarification)

**Before Creating the Document:** Ask the user if they want to use Haiku for simpler milestones. This saves significantly on usage limits for team members on cheaper plans. Max plan subscribers may decline, but others benefit from assigning Haiku to mechanical/boilerplate tasks.

**Document Structure Requirements:**

a) **Summary**: Create a concise summary at the top of the document that captures:

- The purpose/goal of the project or plan, key objectives, and critical success factors
- Include beneath the summary a **Milestone Progress Tracker** table to show completion status at a glance:

  | Milestone          | Model             | Status                                        | Duration (min) | Notes       |
  |--------------------|-------------------|-----------------------------------------------|----------------|-------------|
  | Milestone 1 name   | Haiku/Sonnet/Opus | ⬜ Not Started / 🔄 In Progress / ✅ Complete | —              | Brief notes |

  - **Model Assignment Guidelines**:
    - **Haiku**: Mechanical/boilerplate work, simple CRUD, straightforward UI components, basic tests (ask user if they want to use Haiku - beneficial for those with usage limits)
    - **Sonnet**: Most feature work, moderate complexity, standard implementations, well-defined tasks
    - **Opus**: Complex architecture, nuanced decisions, ambiguous requirements, extended reasoning

  - **Duration Tracking**: When a milestone is completed, record the actual time (in minutes) it took to process. This helps with future estimation and identifying milestones that may need to be broken down further.

b) **Table of Contents**: Generate a linked table of contents that includes all major sections with anchor links for easy navigation

c) **Section Organization**: Create or reorganize content into milestones with:

- Clear section headers (use existing headers from the document if present, or create logical sections based on content)
- Brief placeholder/descriptive text for each section if content is minimal
- A "Return to Top" link at the end of each major section
- **Model Recommendation**: For each milestone, include a recommended model to use:
  - **Haiku**: For mechanical/boilerplate work, simple CRUD operations, straightforward UI components, and basic tests
  - **Sonnet**: For most feature work, moderate complexity, standard implementations, and well-defined tasks
  - **Opus**: For complex architectural decisions, nuanced problem-solving, tasks requiring deeper reasoning, ambiguous requirements, or work that benefits from extended thinking

d) **Actionable Item Tracking**: Add checkboxes `- [ ]` next to every actionable item throughout the document to enable progress tracking. Ensure items are specific and measurable.

   **Worker Completion Requirement**: Include a note in each milestone that workers must complete ALL items in their assigned task list. Workers should NOT skip items because they seem lower priority or slightly out of scope—if an item is listed in the milestone, it must be completed. If a worker believes an item should be removed or deferred, they must note this in their summary for the orchestrator to decide, but they should still attempt the work unless it's truly blocked.

e) **Work Organization** (optional enhancement): Analyze whether the work should be organized by:

- Functional category (e.g., Backend, Frontend, DevOps, Design)

- Technical task type (e.g., Setup, Implementation, Testing, Documentation)

- Timeline phases (e.g., Phase 1, Phase 2, Phase 3)

- Milestones (e.g., MVP, Beta, Production)
  
  Choose the organization method that makes the most sense for the content and break apart complex items into smaller, trackable tasks within the chosen structure.

f) **Progress Log / Notes**: Add a dedicated section at the end of the document titled "Progress Log / Notes" that includes:

- A reverse-chronological log (newest entries first) for tracking execution timeline and progress
- Each entry should include:
  - **Full timestamp with time** (not just date)
  - Description of work completed, decisions made, or issues encountered
  - Any blockers, pivots, or changes to the original plan
  - Links to related checkboxes or sections of the document that were affected
- This section captures the nuance and reality of execution that doesn't fit into simple checkbox tracking
- Use the format: `**YYYY-MM-DD HH:MM** - [Entry description]` (24-hour time, include both date AND time)
- Include a "Return to Top" link at the end of this section

g) **Parallel Development Recommendations** (optional): At the end of the document, include a section that analyzes which milestones can be worked on in parallel:

- Identify milestones that have no dependencies on each other and could be developed simultaneously by multiple agents
- Group these into **Parallel Groups** (e.g., Group A, Group B)
- Note any milestones that are **sequential blockers** and must complete before others can begin
- This section helps coordinate work when multiple agents or team members are available

h) **Gap-Filling Prompt Requirements**: When milestones have incomplete work (items skipped or partially done), the orchestrator may need to generate follow-up prompts. Include guidance that these gap-filling prompts must:

- Follow the same structure as original milestone prompts (header, mission statement, planning doc reference, etc.)
- Include awareness of what work was already completed in the original milestone attempt
- Reference the original milestone's context and any files that were modified
- List other active workers and their directories to avoid conflicts (same as regular prompts)
- Include the standard completion instructions:
  1. **Commit code changes** before writing the summary
  2. **Write summary** to `.orchestrator/worker-summary-[milestone-slug]-gap.md`
  3. **Prompt user to close/clear the context** after completion
- Be clearly labeled as gap-filling work (e.g., "Worker Context: [Milestone Name] - Gap Fill")

i) **Orchestrator Context Management**: When coordinating many parallel workers, the orchestrator context may approach its limit. Include a note in the Parallel Development Recommendations section:

- If dispatching multiple prompts causes the orchestrator context to fill up, the user should be prompted to run the `/compact` command while waiting for workers to complete
- The orchestrator should monitor its own context usage and proactively suggest compacting when approaching limits
- After compacting, the orchestrator can resume coordination by reading the `.orchestrator/state.json` file

**Additional Instructions:** If any additional instructions or preferences are provided in the arguments, incorporate them into the planning document structure.

**Output Format:** Maintain markdown formatting throughout and ensure the document is clean, professional, and easy to navigate.
