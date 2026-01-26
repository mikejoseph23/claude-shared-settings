---
description: Archive a completed planning document to the docs folder
argument-hint: [optional: filename]
---

Archive a completed planning document by cleaning it up, moving it to the docs folder, and updating the documentation index.

**Target File:** $ARGUMENTS (if no file specified, use the most recent planning document from this conversation context)

**Process:**

## 1. Identify the Document

- Use the filename provided in arguments, OR
- Use the most recent planning document referenced in this conversation
- If neither is available, list planning documents in the root folder and ask which one to archive

## 2. Preview Changes

Before making any changes, show a summary and ask for confirmation:

- **Source file:** [current location]
- **Destination:** `docs/[renamed-file].md` (drop "plan/planning" from filename)
- **Code blocks to remove:** [count of code blocks found]
- **README entry:** [proposed link text and location]

Ask: "Does this look correct? Proceed with archiving?"

## 3. Clean the Document

Remove implementation-specific technical details while preserving the functional specification:

**Remove:**
- All code blocks (fenced with triple backticks)
- Inline code that contains actual implementation snippets

**Preserve:**
- Functional descriptions and requirements
- Development progress logs and timestamps
- Progress trackers and checkbox status
- Reference mentions of class names, function names, database schemas, API endpoints
- All section structure and navigation links

## 4. Rename and Move

- Remove "plan", "planning", or similar suffixes from the filename
- Example: `my-feature-plan.md` → `my-feature.md`
- Move the cleaned document to the `docs/` folder

**If `docs/` folder doesn't exist:**
- Alert the user: "The docs/ folder doesn't exist."
- Ask: "Would you like me to create it?"
- Proceed only if confirmed

## 5. Update Documentation Index

Add a link to the archived document in `docs/README.md`:

- Read the existing `docs/README.md` structure
- Match the existing format and organization style
- Add the new document link in an appropriate location

**If `docs/README.md` doesn't exist:**
- Alert the user: "docs/README.md doesn't exist."
- Ask: "Would you like me to create a basic documentation index?"
- If confirmed, create a simple README with the new document as the first entry

## 6. Commit Changes

After all changes are complete:

- Generate a descriptive commit message summarizing the archive action
- Show the proposed commit message
- Ask: "Would you like me to commit these changes?"
- If confirmed, stage the relevant files and create the commit

**Commit message format:**
```
Archive [document-name] planning document to docs

- Moved from root to docs/[filename].md
- Removed implementation code blocks
- Added to documentation index
```

---

**Important:** Always confirm with the user before making changes. This command modifies and moves files, so transparency is key.
