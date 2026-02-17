# Shared Claude Code Configuration

This repository contains custom slash commands and skills for Claude Code that can be shared across multiple computers and user profiles.

**Location:** Part of the Interapp Development corporate repository at `~/git/claude-shared-settings`

## Table of Contents

- [Repository Structure](#repository-structure)
- [Commands Available](#commands-available)
  - [/iadev:make-planning-document](#iadevmake-planning-document)
  - [/iadev:planning-interview](#iadevplanning-interview)
  - [/iadev:market-research](#iadevmarket-research)
  - [/iadev:timer-summary](#iadevtimer-summary)
  - [/iadev:update-scratchpad](#iadevupdate-scratchpad)
- [Skills Available](#skills-available)
  - [Requirements Interviewer](#requirements-interviewer)
- [Plugins Available](#plugins-available)
  - [MCP Manager](#mcp-manager)
- [Setup Instructions](#setup-instructions)
- [Git Integration](#git-integration)
- [Workflow for Updates](#workflow-for-updates)
- [Adding New Commands](#adding-new-commands)
- [Benefits of This Approach](#benefits-of-this-approach)

---

## Repository Structure

```
claude-shared-settings/
├── README.md                    # This file - overview and quick start
├── SETUP.md                     # Comprehensive setup guide (RECOMMENDED)
├── agent-ideas.md               # Agent implementation ideas (AI-generated)
├── backlog.md                   # Future enhancements and ideas
├── scratchpad.md                # Current work in progress
├── commands/                    # Slash commands (manual invocation)
│   ├── make-planning-document.md
│   ├── planning-interview.md
│   ├── market-research.md
│   ├── timer-summary.md
│   └── update-scratchpad.md
├── skills/                      # Skills (automatic activation)
│   └── requirements-interviewer/
│       └── SKILL.md
├── plugins/                     # Plugins (startup hooks and utilities)
│   └── mcp-manager/
│       ├── PLUGIN.md            # Plugin metadata
│       ├── README.md            # Usage documentation
│       ├── on-client-start.js   # Startup hook script
│       └── config/
│           ├── enabled-mcps.json    # Toggle servers on/off
│           └── mcp-servers.json     # Server definitions
└── setup/                       # Setup scripts and documentation
    ├── setup.sh                 # Mac/Linux setup script
    ├── setup.ps1                # Windows setup script (admin)
    ├── setup-no-admin.ps1       # Windows setup script (no admin)
    └── update.ps1               # Windows update script (for copy mode)
```

[⬆ Back to Top](#shared-claude-code-custom-commands)

---

## Commands Available

All commands are prefixed with `iadev:` when used via symlinks in your projects.

### `/iadev:make-planning-document`

Creates a comprehensive planning document with:

- Executive summary with progress indication
- Table of contents with anchor links
- Organized sections with "Return to Top" links
- Checkboxes for all actionable items
- Optional organization into milestones/phases/categories

**Usage:**

To use the current document selected in the IDE:

```bash
/iadev:make-planning-document
```

To make the planning document in a specific file path:

```bash
/iadev:make-planning-document docs/project-plan.md
```

To make the planning document in the root folder with additional instructions:

```bash
/iadev:make-planning-document roadmap.md organize by timeline phases
```

---

### `/iadev:planning-interview`

Conducts an interactive interview with the user to gather detailed information for a planning document section.

**Features:**

- Asks one question at a time
- Waits for answers before proceeding
- Asks thoughtful, relevant questions based on the section topic and previous answers
- Summarizes gathered information
- Updates the specified planning document section with the interview results

**Usage:**

```bash
/iadev:planning-interview
```

The command will first ask which planning document and section you want to work on, then guide you through an interactive interview process.

---

### `/iadev:market-research`

Conducts comprehensive competitive analysis and market research with structured, well-documented findings.

**Features:**

- Creates organized research workspace with flat folder structure
- Produces executive summary with links to supporting documents
- Handles multiple input formats (descriptions, files, URLs, prior research)
- Flags discrepancies and gaps in research
- Delivers actionable insights with proper citations

**Usage:**

```bash
/iadev:market-research
```

The command will guide you through defining research objectives, conducting analysis, and producing a findings document with supporting materials organized in a working folder.

**Output Structure:**
- Centralized findings document with executive summary
- Supporting research documents in working folder
- Issues/discrepancies flagged appropriately
- Clean hierarchical linking (main findings → supporting docs → nested details)

---

### `/iadev:timer-summary`

Generates a short, non-technical summary of work accomplished for time tracker entries.

**Features:**

- Defaults to summarizing the current conversation context
- Optionally accepts a date range to summarize git commits instead
- Output is 2-4 sentences written for a non-technical manager audience

**Usage:**

```bash
# Summarize current session
/iadev:timer-summary

# Summarize today's git commits
/iadev:timer-summary today

# Summarize a date range
/iadev:timer-summary 2026-02-10 to 2026-02-17
```

---

### `/iadev:update-scratchpad`

Reviews the scratchpad document and updates it to reflect current progress.

**Features:**

- Identifies and moves completed work to a "Completed Work" section at the bottom
- Marks or removes completed todo items from active sections
- Updates status indicators (✅, ⏳, 📋, ❌)
- Updates "Next Steps" to show remaining work clearly

**Usage:**

```bash
/iadev:update-scratchpad
```

**Goal:** Keep the scratchpad focused on remaining work. Completed work is archived at the bottom, and the scratchpad eventually becomes empty when a phase is complete.

[⬆ Back to Top](#shared-claude-code-custom-commands)

---

## Skills Available

Skills are **automatically discovered capabilities** that extend Claude's expertise. Unlike commands which you explicitly invoke, Claude uses skills automatically when relevant to your conversation.

### Requirements Interviewer

Expert at conducting requirements interviews and gathering detailed specifications.

**When Claude Uses It:** Automatically activated when you need to gather requirements, conduct stakeholder interviews, clarify feature specifications, or extract technical details from business needs.

**Trigger Words:** "requirements", "interview", "gather specifications", "what should this feature do", "help me understand what they need"

**What It Provides:**
- Strategic questioning techniques (Five Whys, scenario-based, edge cases)
- Active listening and synthesis capabilities
- Requirement quality validation (specific, measurable, achievable, relevant, traceable)
- Structured interview process with context setting, deep dive, and validation phases
- Best practices for different stakeholder types (technical, business, end users, executives)

**Example Usage:**

```
You: "I need to gather requirements for a new invoicing feature"

Claude: [Automatically engages requirements-interviewer skill]
"Let me help you gather requirements for the invoicing feature.
To start, can you walk me through how invoicing is currently
handled in your system?"
```

**Location:** `skills/requirements-interviewer/SKILL.md`

📖 **For detailed skills setup instructions, see [SKILLS-SETUP.md](SKILLS-SETUP.md)**

[⬆ Back to Top](#shared-claude-code-custom-commands)

---

## Plugins Available

Plugins extend Claude Code with startup hooks and utilities that run automatically.

### MCP Manager

Control which MCP (Model Context Protocol) servers are loaded without manually editing configuration files.

**What It Does:**
- Manages MCP server activation via simple JSON configuration
- Automatically updates Claude config on startup
- Prevents context budget issues by letting you easily disable unused servers
- Version control your MCP server preferences via git

**Configuration Files:**

1. **`plugins/mcp-manager/config/enabled-mcps.json`** - Toggle servers on/off:
   ```json
   {
     "puppeteer": false,
     "postgres": false,
     "filesystem": false
   }
   ```

2. **`plugins/mcp-manager/config/mcp-servers.json`** - Define server configurations:
   ```json
   {
     "puppeteer": {
       "command": "npx",
       "args": ["-y", "@modelcontextprotocol/server-puppeteer"]
     }
   }
   ```

**Usage:**

```bash
# Enable Puppeteer for web research
vim plugins/mcp-manager/config/enabled-mcps.json
# Set "puppeteer": true

# Restart Claude Code to load the server
```

**Benefits:**
- ✅ No manual config file editing
- ✅ Quick toggle without surgery on `claude_desktop_config.json`
- ✅ Control context budget by disabling unused servers
- ✅ Share team MCP setup via git

**Location:** `plugins/mcp-manager/`

📖 **For detailed plugin documentation, see [plugins/mcp-manager/README.md](plugins/mcp-manager/README.md)**

[⬆ Back to Top](#shared-claude-code-custom-commands)

---

## Setup Instructions

### Quick Setup

**Mac/Linux - One Command:**

```bash
cd ~/git/claude-shared-settings && \
mkdir -p ~/.claude/commands ~/.claude/plugins && \
ln -sf ~/git/claude-shared-settings/commands ~/.claude/commands/iadev && \
ln -sf ~/git/claude-shared-settings/skills ~/.claude/skills && \
ln -sf ~/git/claude-shared-settings/plugins/mcp-manager ~/.claude/plugins/mcp-manager && \
echo "✅ Setup complete! Restart Claude Code."
```

**Or run the setup script:**

```bash
cd ~/git/claude-shared-settings
./setup/setup.sh
```

**Windows - Run Setup Script:**

```powershell
# As Administrator (recommended - creates symlinks)
cd $env:USERPROFILE\git\claude-shared-settings
.\setup\setup.ps1

# OR without admin (copies files, requires manual sync)
.\setup\setup-no-admin.ps1
```

### Comprehensive Setup Guide

📖 **See [SETUP.md](SETUP.md) for complete instructions including:**

- Detailed setup for Mac/Linux and Windows
- Multiple Windows options (symlink vs copy)
- What gets installed (commands, skills, and plugins)
- Verification steps
- Update procedures
- Troubleshooting guide
- Setup scripts reference

[⬆ Back to Top](#shared-claude-code-custom-commands)

---

## Git Integration

This folder is part of the Interapp corporate git repository. Changes should be committed and pushed as part of the Interapp repo workflow.

**Note:** Since this is a subfolder of `~/git/claude-shared-settings/`, it's already under version control. No separate git remote is needed - it syncs with your repository.

[⬆ Back to Top](#shared-claude-code-custom-commands)

---

## Workflow for Updates

### Making Changes

```bash
cd ~/git/claude-shared-settings

# Edit command files as needed
vim commands/make-planning-document.md

# Commit changes
git add commands/
git commit -m "Update Claude commands: make-planning-document"
git push
```

### Syncing Changes on Other Computers

**Mac/Linux with symlinks:**

```bash
cd ~/git/claude-shared-settings
git pull
# Changes are immediately available in Claude Code via symlink
```

**Windows with symlink (Option 1):**

```powershell
cd $env:USERPROFILE\git\claude-shared-settings
git pull
# Changes are immediately available in Claude Code via symlink
```

**Windows with copied files (Option 2):**

```powershell
cd $env:USERPROFILE\git\claude-shared-settings
git pull
.\setup\update.ps1
```

[⬆ Back to Top](#shared-claude-code-custom-commands)

---

## Adding New Commands

### Create a New Command in iadev Namespace

```bash
cd ~/git/claude-shared-settings/commands

# Create new command file
cat > new-command.md << 'EOF'
---
description: Brief description of what this command does
argument-hint: [optional arguments]
---

Your command prompt here with $ARGUMENTS
EOF

# Commit and push
git add new-command.md
git commit -m "Add new iadev command: new-command"
git push
```

The command will be available as `/iadev:new-command` after syncing.

### Create a New Command Namespace

```bash
cd ~/git/claude-shared-settings

# Create new namespace directory
mkdir new-namespace

# Add command
cat > new-namespace/my-command.md << 'EOF'
---
description: My custom command
---

Command prompt here
EOF

# Create symlink in each profile (Mac/Linux)
ln -s ~/git/claude-shared-settings/new-namespace ~/.claude/commands/new-namespace

# Commit and push
git add new-namespace/
git commit -m "Add new-namespace commands"
git push
```

**Windows (with admin):**

```powershell
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\commands\new-namespace" -Target "$env:USERPROFILE\git\claude-shared-settings\new-namespace"
```

The command will be available as `/new-namespace:my-command`.

[⬆ Back to Top](#shared-claude-code-custom-commands)

---

## Benefits of This Approach

✅ **Version Control**: Track changes to your commands over time
✅ **Sync Across Devices**: One git pull updates all computers
✅ **Share Between Profiles**: Multiple users can share the same commands
✅ **Team Collaboration**: Share with team members via corporate repo
✅ **Backup**: Commands backed up with your repository
✅ **No Duplication**: Symlinks mean commands are only stored once
✅ **Corporate Integration**: Commands live alongside work projects
✅ **Cross-Platform**: Works on Mac, Linux, and Windows (with appropriate setup)
✅ **Namespaced**: Commands use `iadev:` prefix to avoid conflicts with other commands

[⬆ Back to Top](#shared-claude-code-custom-commands)