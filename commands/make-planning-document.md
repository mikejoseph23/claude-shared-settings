---
description: Create a comprehensive planning document with structure and tracking
argument-hint: [optional: file-path] [optional: additional instructions]
---

Create a planning document for the current working file in our IDE (or the file specified in arguments if provided). Transform the document into a structured planning document by completing the following tasks:

**Target File:** $ARGUMENTS (if no file specified, use the current working directory context or prompt for clarification)

**Document Structure Requirements:**

a) ** Summary**: Create a concise summary at the top of the document that captures:

- The purpose/goal of the project or plan, key objectives, and critical success factors
- Include beneath the summary to track percent complete status so that when we open the document, we have an immediate sense of how much work there is left to do.

b) **Table of Contents**: Generate a linked table of contents that includes all major sections with anchor links for easy navigation

c) **Section Organization**: Create or reorganize content into milestones with:

- Clear section headers (use existing headers from the document if present, or create logical sections based on content)
- Brief placeholder/descriptive text for each section if content is minimal
- A "Return to Top" link at the end of each major section
- **Model Recommendation**: For each milestone, include a recommended model to use:
  - **Sonnet**: For straightforward implementation tasks, routine coding, documentation, and well-defined work
  - **Opus**: For complex architectural decisions, nuanced problem-solving, tasks requiring deeper reasoning, or work that benefits from extended thinking

d) **Actionable Item Tracking**: Add checkboxes `- [ ]` next to every actionable item throughout the document to enable progress tracking. Ensure items are specific and measurable.

e) **Work Organization** (optional enhancement): Analyze whether the work should be organized by:

- Functional category (e.g., Backend, Frontend, DevOps, Design)

- Technical task type (e.g., Setup, Implementation, Testing, Documentation)

- Timeline phases (e.g., Phase 1, Phase 2, Phase 3)

- Milestones (e.g., MVP, Beta, Production)
  
  Choose the organization method that makes the most sense for the content and break apart complex items into smaller, trackable tasks within the chosen structure.

f) **Progress Log / Notes**: Add a dedicated section at the end of the document titled "Progress Log / Notes" that includes:

- A reverse-chronological log (newest entries first) for tracking execution timeline and progress
- Each entry should include:
  - Date/timestamp
  - Description of work completed, decisions made, or issues encountered
  - Any blockers, pivots, or changes to the original plan
  - Links to related checkboxes or sections of the document that were affected
- This section captures the nuance and reality of execution that doesn't fit into simple checkbox tracking
- Use a consistent format like: `**YYYY-MM-DD HH:MM** - [Entry description]` or similar
- Include a "Return to Top" link at the end of this section

**Additional Instructions:** If any additional instructions or preferences are provided in the arguments, incorporate them into the planning document structure.

**Output Format:** Maintain markdown formatting throughout and ensure the document is clean, professional, and easy to navigate.
