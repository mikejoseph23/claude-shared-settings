# Timer Summary

Generate a short, non-technical summary of work accomplished — suitable for a time tracker entry that managers will read.

## Default Behavior

If no arguments are provided, summarize the work done in the current conversation context. Look at what was discussed, what changes were made, and what was accomplished.

## With Arguments

If the user provides a date/time range, use git log to find commits in that range and summarize them instead.

Examples:
- `/iadev:timer-summary` — summarize current session
- `/iadev:timer-summary today` — summarize today's git commits
- `/iadev:timer-summary 2026-02-10 to 2026-02-17` — summarize commits in that range
- `/iadev:timer-summary last week` — summarize last week's commits

When using git log, run it from the current working directory's git root. Use `--all` to catch work across branches.

## Output Guidelines

- Write 2-4 sentences max
- Use plain language a non-technical manager would understand
- Focus on *what was accomplished* and *why it matters*, not how it was done
- Avoid technical jargon (no "stored procs", "migrations", "refactored" — say "updated reports", "restructured data", "fixed calculations")
- Group related commits into a single coherent description rather than listing each commit

$ARGUMENTS
