# Claude Code Workflow Guide

A structured process for planning, developing, and testing features with Claude Code.

## Quick Reference

```
1. Enter planning mode     → Type: "Enter planning mode" or press Shift+Tab and select Plan
2. State objective         → Describe what you want to build
3. /iadev:planning-interview    → Answer questions to gather requirements
4. /iadev:make-planning-document → Convert interview into structured plan
5. /iadev:orchestrator          → Coordinate parallel development
6. Unit tests              → Written during development milestones
7. Manual testing          → Validate complete user experience
8. E2E tests (optional)    → Playwright tests for regression protection
9. /iadev:archive-planning-document → Move completed plan to docs/
```

## The Workflow

### Step 1: Enter Planning Mode

Tell Claude Code to enter planning mode before starting a new feature. This can be done by:
- Typing "Enter planning mode" or "Let's plan this feature"
- Pressing `Shift+Tab` and selecting "Plan"

**Why?** Planning mode focuses on exploration and design without making code changes. Claude will investigate the codebase and design an approach before implementation.

### Step 2: State Your Objective

Describe what you want to build. This workflow handles entire applications or major features:

- **Full application:** "Build an e-commerce platform for ordering grass and turf products. Customers browse a catalog, add items to cart, and checkout. Admins manage orders and inventory."
- **Major feature:** "Add a complete order management system with order creation, status tracking, email notifications, admin dashboard, and reporting."
- **Feature set:** "Implement the customer portal: account registration, order history, saved addresses, and profile management."

The planning interview will dig into requirements, edge cases, and technical decisions - so a high-level description is enough to start.

### Step 3: Run Planning Interview

```
/iadev:planning-interview
```

This asks questions one at a time about requirements, edge cases, and technical decisions. Continue until:
- Edge cases are reaching exhaustion
- Requirements feel complete
- You're not finding new scenarios

Thorough planning here saves time later.

### Step 4: Create Structured Planning Document

```
/iadev:make-planning-document
```

Converts the interview output into a structured document with milestones and tasks that the orchestrator can execute.

### Step 5: Coordinate Parallel Development

```
/iadev:orchestrator
```

The orchestrator reads the planning document, identifies dependencies, and coordinates parallel Claude Code instances. It handles parallelization automatically - you don't need to manage it.

### Step 6: Development with Unit Tests

As the orchestrator works through milestones:
- Unit tests are developed alongside code
- Development follows patterns in `CLAUDE.md`
- Each instance works independently on assigned tasks

Let the orchestrator complete all milestones before moving on.

### Step 7: Manual Testing

Once development completes:
- Test implemented features manually
- Validate complete workflows end-to-end
- Fix issues within the testing context if bugs are found

### Step 8: End-to-End Tests (Optional)

After manual testing passes, optionally create E2E tests:
- Use Playwright for browser-based testing
- Run tests in headed mode (`--headed`)
- Follow patterns established in the codebase

### Step 9: Cleanup and Documentation

When everything works:

```
/iadev:archive-planning-document
```

This moves the planning document to `docs/` for future reference.

## Handling Scope Changes

If requirements change mid-development:

1. **Pause** - Stop current work
2. **Update** - Revise the planning document
3. **Resume** - Continue with the updated plan

Don't restart from scratch.

## Context Efficiency and Model Selection

### Why This Workflow is Efficient

Worker contexts spawned by the orchestrator rarely hit context window limits. Well-scoped milestones mean each worker completes its unit of work with context to spare. This makes the workflow both fast and cost-effective.

### Model Selection

The `make-planning-document` command determines which model to use for each milestone. Using less capable models for simpler work saves on usage limits - valuable for team members on cheaper plans.

| Model | Use For |
|-------|---------|
| **Haiku** | Mechanical/boilerplate work, simple CRUD, straightforward UI components, basic tests |
| **Sonnet** | Most feature work, moderate complexity, standard implementations |
| **Opus** | Complex architecture, tricky integrations, nuanced requirements |

When creating the planning document, you'll be asked if you want to use Haiku for simpler milestones. Max plan subscribers may skip this, but team members with usage limits benefit significantly.

## Key Principle: CLAUDE.md

Throughout the workflow, `CLAUDE.md` guides all decisions: code patterns, database naming, error handling, DateTime usage, and more. The orchestrator and all Claude instances follow these rules automatically.

## Command Reference

| Command | Purpose |
|---------|---------|
| `/iadev:planning-interview` | Interactive requirements gathering |
| `/iadev:make-planning-document` | Create structured planning document |
| `/iadev:orchestrator` | Coordinate parallel development |
| `/iadev:archive-planning-document` | Archive completed plan to docs/ |
