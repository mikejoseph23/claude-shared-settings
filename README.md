# Shared Claude Code Custom Commands

This repository contains custom slash commands for Claude Code that can be shared across multiple computers and user profiles.

**Location:** Part of the Interapp Development corporate repository at `~/git/claude-shared-settings`

## Repository Structure

```
claude-commands-shared/
├── README.md
└── iadev/
    └── make-planning-document.md
```

## Commands Available

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

## Setup Instructions

### Initial Setup (First Computer/Profile)

This has already been completed for the personal profile (michaeljoseph):

```bash
# 1. Repository created at ~/git/claude-commands-shared
# 2. Commands moved to repository
# 3. Symlink created from ~/.claude/commands/iadev to ~/git/claude-shared-settings/iadev
# 4. Git initialized and committed
```

### Setup on Additional Computers (Mac/Linux)

To use these commands on another Mac or Linux computer:

```bash
# 1. Clone the Interapp repo (if not already cloned)
git clone <interapp-repo-url> ~/git/claude-shared-settings

# 2. Create the commands directory if it doesn't exist
mkdir -p ~/.claude/commands

# 3. Create symlink
ln -s ~/git/claude-commands-shared/iadev ~/.claude/commands/iadev

# 4. Verify the command is available
# Open Claude Code and type /iadev:make-planning-document
```

### Setup on Another Profile (Same Mac)

For the work profile (michaeljosephinterapp) on this iMac:

```bash
# 1. Create commands directory if needed
mkdir -p /Users/michaeljosephinterapp/.claude/commands

# 2. Create symlink to the shared repository
ln -s /Users/michaeljoseph/git/claude-shared-settings/iadev /Users/michaeljosephinterapp/.claude/commands/iadev

# 3. Verify the command is available
# Open Claude Code and type /iadev:make-planning-document
```

### Setup on Windows Dev Environment

Windows handles symlinks differently. You have two options:

**Option A: Using mklink (Requires Administrator privileges)**

```cmd
REM Run Command Prompt or PowerShell as Administrator

REM 1. Clone the Interapp repo (if not already cloned)
git clone <interapp-repo-url> %USERPROFILE%\git\interapp

REM 2. Create the commands directory if it doesn't exist
mkdir %USERPROFILE%\.claude\commands

REM 3. Create symlink (requires admin)
mklink /D %USERPROFILE%\.claude\commands\iadev %USERPROFILE%\git\interapp\claude-commands-shared\iadev
```

**Option B: Copy files instead of symlink (No admin required, but requires manual sync)**

```cmd
REM 1. Clone the Interapp repo
git clone <interapp-repo-url> %USERPROFILE%\git\interapp

REM 2. Create the commands directory
mkdir %USERPROFILE%\.claude\commands

REM 3. Copy the commands (run this after each git pull to sync changes)
xcopy /E /I %USERPROFILE%\git\interapp\claude-commands-shared\iadev %USERPROFILE%\.claude\commands\iadev
```

**Recommendation for Windows:** Use Option A (mklink) if you have admin access. If not, use Option B but remember to re-copy files after pulling updates from git.

## Git Integration

This folder is part of the Interapp corporate git repository. Changes should be committed and pushed as part of the Interapp repo workflow.

**Note:** Since this is a subfolder of `~/git/interapp/`, it's already under version control. No separate git remote is needed - it syncs with your main Interapp repository.

## Workflow for Updates

### Making Changes

```bash
cd ~/git/claude-shared-settings

# Edit command files as needed
vim iadev/make-planning-document.md

# Commit changes (from Interapp repo root)
cd ~/git/interapp
git add claude-commands-shared/
git commit -m "Update Claude commands: make-planning-document"
git push
```

### Syncing Changes on Other Computers

**Mac/Linux with symlinks:**

```bash
cd ~/git/interapp
git pull
# Changes are immediately available in Claude Code via symlink
```

**Windows with mklink:**

```cmd
cd %USERPROFILE%\git\interapp
git pull
REM Changes are immediately available in Claude Code via symlink
```

**Windows with copied files (Option B):**

```cmd
cd %USERPROFILE%\git\interapp
git pull

REM Re-copy files to sync changes
xcopy /E /I /Y %USERPROFILE%\git\interapp\claude-commands-shared\iadev %USERPROFILE%\.claude\commands\iadev
```

## Adding New Commands

### Create a New Command

```bash
cd ~/git/claude-shared-settings/iadev

# Create new command file
cat > new-command.md << 'EOF'
---
description: Brief description of what this command does
argument-hint: [optional arguments]
---

Your command prompt here with $ARGUMENTS
EOF

# Commit and push
cd ~/git/interapp
git add claude-commands-shared/
git commit -m "Add new iadev command: new-command"
git push
```

### Create a New Command Namespace

```bash
cd ~/git/claude-shared-settings

# Create new namespace directory
mkdir my-namespace

# Add command
cat > my-namespace/my-command.md << 'EOF'
---
description: My custom command
---

Command prompt here
EOF

# Create symlink in each profile
ln -s ~/git/claude-shared-settings/my-namespace ~/.claude/commands/my-namespace

# Commit and push
cd ~/git/interapp
git add claude-commands-shared/
git commit -m "Add my-namespace commands"
git push
```

## Benefits of This Approach

✅ **Version Control**: Track changes to your commands over time
✅ **Sync Across Devices**: One git pull updates all computers
✅ **Share Between Profiles**: Multiple users can share the same commands
✅ **Team Collaboration**: Share with team members via corporate repo
✅ **Backup**: Commands backed up with Interapp repository
✅ **No Duplication**: Symlinks mean commands are only stored once
✅ **Corporate Integration**: Commands live alongside work projects
✅ **Cross-Platform**: Works on Mac, Linux, and Windows (with appropriate setup)

## Troubleshooting

### Command Not Showing Up

1. Verify symlink exists:

   ```bash
   ls -la ~/.claude/commands/
   ```

2. Check symlink target is correct:

   ```bash
   readlink ~/.claude/commands/iadev
   ```

3. Verify command file exists:

   ```bash
   cat ~/git/claude-shared-settings/iadev/make-planning-document.md
   ```

### Symlink Broken After Moving Repository

If you move the repository location, recreate symlinks:

**Mac/Linux:**

```bash
rm ~/.claude/commands/iadev
ln -s ~/git/claude-shared-settings/iadev ~/.claude/commands/iadev
```

**Windows (with admin):**

```cmd
rmdir %USERPROFILE%\.claude\commands\iadev
mklink /D %USERPROFILE%\.claude\commands\iadev %USERPROFILE%\git\interapp\claude-commands-shared\iadev
```

## Repository Locations

- **Desktop iMac (Personal Profile)**: `/Users/michaeljoseph/git/claude-shared-settings`
- **Desktop iMac (Work Profile)**: Symlink to `/Users/michaeljoseph/git/claude-shared-settings/iadev`
- **Laptop**: `~/git/claude-shared-settings` (after cloning Interapp repo)
- **Windows Dev Machine**: `%USERPROFILE%\git\interapp\claude-commands-shared` (after cloning Interapp repo)

## Next Steps

- [ ] Set up on work profile (michaeljosephinterapp) on this iMac
- [ ] Set up on laptop after format/fresh install
- [ ] Set up on Windows dev environment (if applicable)
- [ ] Create additional iadev commands as needed
- [ ] Consider adding team-wide command namespaces for Interapp Development
