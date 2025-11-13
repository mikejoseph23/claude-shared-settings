# Claude Shared Settings - Complete Setup Guide

This comprehensive guide covers setting up **commands, skills, and plugins** for Claude Code on Mac and Windows.

## Table of Contents

- [Quick Setup (Recommended)](#quick-setup-recommended)
  - [Mac/Linux Quick Setup](#maclinux-quick-setup)
  - [Windows Quick Setup](#windows-quick-setup)
- [What Gets Installed](#what-gets-installed)
- [Manual Setup](#manual-setup)
- [Verification](#verification)
- [Updating](#updating)
- [Troubleshooting](#troubleshooting)

---

## Quick Setup (Recommended)

### Mac/Linux Quick Setup

**One-command setup** (copy and paste this entire block):

```bash
cd ~/git/claude-shared-settings && \
mkdir -p ~/.claude/commands ~/.claude/plugins && \
ln -sf ~/git/claude-shared-settings/commands ~/.claude/commands/iadev && \
ln -sf ~/git/claude-shared-settings/skills ~/.claude/skills && \
ln -sf ~/git/claude-shared-settings/plugins/mcp-manager ~/.claude/plugins/mcp-manager && \
echo "✅ Setup complete! Commands available with /iadev: prefix" && \
echo "✅ Skills are now active across all projects" && \
echo "✅ MCP Manager plugin installed" && \
ls -la ~/.claude/
```

**What this does:**
1. Navigates to the repository
2. Creates necessary directories
3. Creates symlink for commands (`~/.claude/commands/iadev`)
4. Creates symlink for skills (`~/.claude/skills`)
5. Creates symlink for MCP Manager plugin (`~/.claude/plugins/mcp-manager`)
6. Confirms setup and shows your Claude directory

**Restart Claude Code** after running this command.

[⬆ Back to Top](#claude-shared-settings---complete-setup-guide)

---

### Windows Quick Setup

**One-command setup** - Open PowerShell **as Administrator**, then copy and paste this entire block:

```powershell
cd C:\git\claude-shared-settings; `
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\commands" | Out-Null; `
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\plugins" | Out-Null; `
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\commands\iadev" -Target "C:\git\claude-shared-settings\commands" -Force; `
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\skills" -Target "C:\git\claude-shared-settings\skills" -Force; `
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\plugins\mcp-manager" -Target "C:\git\claude-shared-settings\plugins\mcp-manager" -Force; `
Write-Host "`n✅ Setup complete! Commands available with /iadev: prefix" -ForegroundColor Green; `
Write-Host "✅ Skills are now active across all projects" -ForegroundColor Green; `
Write-Host "✅ MCP Manager plugin installed" -ForegroundColor Green; `
Get-ChildItem "$env:USERPROFILE\.claude\"
```

**What this does:**
1. Navigates to the repository at `C:\git\claude-shared-settings`
2. Creates necessary directories in `%USERPROFILE%\.claude\`
3. Creates symlink for commands (`%USERPROFILE%\.claude\commands\iadev`)
4. Creates symlink for skills (`%USERPROFILE%\.claude\skills`)
5. Creates symlink for MCP Manager plugin (`%USERPROFILE%\.claude\plugins\mcp-manager`)
6. Confirms setup and shows your Claude directory

**Note:** If your repository is in a different location, replace `C:\git\claude-shared-settings` with your actual path in the command above.

**Restart Claude Code** after running this command.

[⬆ Back to Top](#claude-shared-settings---complete-setup-guide)

---

## What Gets Installed

### Commands (Manual Invocation)

Slash commands you explicitly invoke with the `/iadev:` prefix:

| Command | Description |
|---------|-------------|
| `/iadev:make-planning-document` | Transform documents into structured planning docs with TOC, checkboxes, and progress tracking |
| `/iadev:planning-interview` | Conduct structured interviews for planning document sections |
| `/iadev:update-scratchpad` | Update scratchpad with completed work and next steps |

### Skills (Automatic Activation)

Skills that Claude automatically uses when relevant:

| Skill | Trigger Words | Purpose |
|-------|---------------|---------|
| **Requirements Interviewer** | "requirements", "interview", "gather specifications", "what should this feature do" | Expert requirements gathering with strategic questioning, validation, and stakeholder management |

### Plugins (Startup Hooks)

Plugins that run automatically when Claude Code starts:

| Plugin | Purpose | Configuration |
|--------|---------|---------------|
| **MCP Manager** | Control which MCP servers load without editing config files | Edit `plugins/mcp-manager/config/enabled-mcps.json` to toggle servers on/off |

**MCP Manager Benefits:**
- Toggle MCP servers (Puppeteer, Postgres, etc.) without config file surgery
- Control context budget by disabling unused servers
- Version control MCP preferences via git
- Share team MCP setup automatically

---

## Manual Setup

If you prefer to set up manually or understand what's happening:

### Mac/Linux Manual Setup

```bash
# 1. Clone the repository (if not already done)
git clone <repo-url> ~/git/claude-shared-settings

# 2. Create directories
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/plugins
mkdir -p ~/.claude

# 3. Create symlinks
ln -s ~/git/claude-shared-settings/commands ~/.claude/commands/iadev
ln -s ~/git/claude-shared-settings/skills ~/.claude/skills
ln -s ~/git/claude-shared-settings/plugins/mcp-manager ~/.claude/plugins/mcp-manager

# 4. Verify
ls -la ~/.claude/commands/iadev/
ls -la ~/.claude/skills/
ls -la ~/.claude/plugins/mcp-manager/

# 5. Restart Claude Code
```

### Windows Manual Setup (Admin)

```powershell
# 1. Clone the repository
git clone <repo-url> $env:USERPROFILE\git\claude-shared-settings

# 2. Open PowerShell as Administrator

# 3. Create directories
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\commands"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\plugins"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude"

# 4. Create symlinks
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\commands\iadev" -Target "$env:USERPROFILE\git\claude-shared-settings\commands"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\skills" -Target "$env:USERPROFILE\git\claude-shared-settings\skills"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\plugins\mcp-manager" -Target "$env:USERPROFILE\git\claude-shared-settings\plugins\mcp-manager"

# 5. Verify
Get-ChildItem "$env:USERPROFILE\.claude\commands\iadev\"
Get-ChildItem "$env:USERPROFILE\.claude\skills\"
Get-ChildItem "$env:USERPROFILE\.claude\plugins\mcp-manager\"

# 6. Restart Claude Code
```

[⬆ Back to Top](#claude-shared-settings---complete-setup-guide)

---

## Verification

### Check Commands

**Mac/Linux:**
```bash
ls -la ~/.claude/commands/iadev/
# Should show: make-planning-document.md, planning-interview.md, etc.
```

**Windows:**
```powershell
Get-ChildItem "$env:USERPROFILE\.claude\commands\iadev\"
```

**In Claude Code:**
Type `/iadev:` and you should see autocomplete suggestions for all commands.

### Check Skills

**Mac/Linux:**
```bash
ls -la ~/.claude/skills/
# Should show: requirements-interviewer/
cat ~/.claude/skills/requirements-interviewer/SKILL.md
```

**Windows:**
```powershell
Get-ChildItem "$env:USERPROFILE\.claude\skills\"
Get-Content "$env:USERPROFILE\.claude\skills\requirements-interviewer\SKILL.md"
```

**In Claude Code:**
Start a new conversation and say: "I need to gather requirements for a new feature"

Claude should engage with requirements interviewing expertise automatically.

### Check Plugins

**Mac/Linux:**
```bash
ls -la ~/.claude/plugins/mcp-manager/
# Should show: PLUGIN.md, README.md, on-client-start.js, config/
cat ~/.claude/plugins/mcp-manager/config/enabled-mcps.json
```

**Windows:**
```powershell
Get-ChildItem "$env:USERPROFILE\.claude\plugins\mcp-manager\"
Get-Content "$env:USERPROFILE\.claude\plugins\mcp-manager\config\enabled-mcps.json"
```

**Test MCP Manager:**
1. Edit `plugins/mcp-manager/config/enabled-mcps.json`
2. Set a server to `true` (e.g., `"puppeteer": true`)
3. Restart Claude Code
4. Check that the MCP server loads (look for startup messages)

### Verify Symlinks (Mac/Linux)

```bash
readlink ~/.claude/commands/iadev
# Should show: /Users/yourname/git/claude-shared-settings/commands

readlink ~/.claude/skills
# Should show: /Users/yourname/git/claude-shared-settings/skills

readlink ~/.claude/plugins/mcp-manager
# Should show: /Users/yourname/git/claude-shared-settings/plugins/mcp-manager
```

### Verify Symlinks (Windows)

```powershell
Get-Item "$env:USERPROFILE\.claude\commands\iadev" | Select-Object LinkType, Target
Get-Item "$env:USERPROFILE\.claude\skills" | Select-Object LinkType, Target
Get-Item "$env:USERPROFILE\.claude\plugins\mcp-manager" | Select-Object LinkType, Target
```

[⬆ Back to Top](#claude-shared-settings---complete-setup-guide)

---

## Updating

### With Symlinks (Mac/Linux/Windows Option 1)

Updates are automatic! Just pull the latest changes:

```bash
# Mac/Linux
cd ~/git/claude-shared-settings
git pull
# Changes immediately available via symlinks
```

```powershell
# Windows
cd $env:USERPROFILE\git\claude-shared-settings
git pull
# Changes immediately available via symlinks
```

**Restart Claude Code** to ensure changes are loaded.

### Without Symlinks (Windows Option 2)

After pulling updates, re-run the setup script:

```powershell
cd $env:USERPROFILE\git\claude-shared-settings
git pull
.\setup\update.ps1
# Or re-run setup\setup-no-admin.ps1
```

[⬆ Back to Top](#claude-shared-settings---complete-setup-guide)

---

## Troubleshooting

### Commands Not Showing Up

1. **Check symlink/directory exists:**
   ```bash
   # Mac/Linux
   ls -la ~/.claude/commands/iadev/

   # Windows
   Get-ChildItem "$env:USERPROFILE\.claude\commands\iadev\"
   ```

2. **Restart Claude Code** - This is required after creating symlinks

3. **Check symlink target:**
   ```bash
   # Mac/Linux
   readlink ~/.claude/commands/iadev

   # Windows
   Get-Item "$env:USERPROFILE\.claude\commands\iadev" | Select-Object Target
   ```

### Skills Not Activating

1. **Verify skill files exist:**
   ```bash
   # Mac/Linux
   cat ~/.claude/skills/requirements-interviewer/SKILL.md

   # Windows
   Get-Content "$env:USERPROFILE\.claude\skills\requirements-interviewer\SKILL.md"
   ```

2. **Use trigger words** - Skills activate based on context. Try: "I need to gather requirements"

3. **Be explicit** - Say: "Use requirements interviewing techniques to help me..."

4. **Restart Claude Code**

### MCP Manager Not Working

1. **Check plugin is installed:**
   ```bash
   # Mac/Linux
   ls -la ~/.claude/plugins/mcp-manager/

   # Windows
   Get-ChildItem "$env:USERPROFILE\.claude\plugins\mcp-manager\"
   ```

2. **Verify hook script is executable (Mac/Linux only):**
   ```bash
   chmod +x ~/.claude/plugins/mcp-manager/on-client-start.js
   ```

3. **Check config files exist:**
   ```bash
   # Mac/Linux
   cat ~/.claude/plugins/mcp-manager/config/enabled-mcps.json

   # Windows
   Get-Content "$env:USERPROFILE\.claude\plugins\mcp-manager\config\enabled-mcps.json"
   ```

4. **Verify JSON syntax:**
   - Ensure valid JSON in both config files
   - Check for trailing commas, missing quotes, etc.

5. **Check Claude Code startup logs:**
   - Look for `[MCP Manager]` messages during startup
   - Errors will show which step failed

6. **Manual test the script:**
   ```bash
   # Mac/Linux
   node ~/.claude/plugins/mcp-manager/on-client-start.js

   # Windows
   node "$env:USERPROFILE\.claude\plugins\mcp-manager\on-client-start.js"
   ```

### Windows: "Insufficient Privilege" Error

**Solutions:**

1. **Run as Administrator** - Right-click PowerShell → "Run as Administrator"

2. **Enable Developer Mode:**
   - Settings → Update & Security → For Developers
   - Enable "Developer Mode"
   - Restart terminal and try again

3. **Use copy method** - Run `setup-no-admin.ps1` instead

### Symlink Broken After Moving Repository

If you move the repository, recreate symlinks:

**Mac/Linux:**
```bash
rm ~/.claude/commands/iadev
rm ~/.claude/skills
rm ~/.claude/plugins/mcp-manager
ln -s ~/git/claude-shared-settings/commands ~/.claude/commands/iadev
ln -s ~/git/claude-shared-settings/skills ~/.claude/skills
ln -s ~/git/claude-shared-settings/plugins/mcp-manager ~/.claude/plugins/mcp-manager
```

**Windows (as Admin):**
```powershell
Remove-Item "$env:USERPROFILE\.claude\commands\iadev"
Remove-Item "$env:USERPROFILE\.claude\skills"
Remove-Item "$env:USERPROFILE\.claude\plugins\mcp-manager"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\commands\iadev" -Target "$env:USERPROFILE\git\claude-shared-settings\commands"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\skills" -Target "$env:USERPROFILE\git\claude-shared-settings\skills"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\plugins\mcp-manager" -Target "$env:USERPROFILE\git\claude-shared-settings\plugins\mcp-manager"
```

### Updates Not Appearing

**With symlinks:**
- Run `git pull`
- Restart Claude Code
- Verify symlink still points to correct location

**Without symlinks (copied files):**
- Run your update script after `git pull`
- Files are copied, not linked - manual sync required

### Different Behavior on Different Machines

1. **Ensure all machines pulled latest:** `git pull`
2. **Check git branch:** `git branch` (should be on same branch)
3. **If using copy method:** Re-run update script
4. **Verify file contents match:** Compare a command file on both machines

[⬆ Back to Top](#claude-shared-settings---complete-setup-guide)

---

## Quick Reference

### File Locations

| Item | Mac/Linux | Windows |
|------|-----------|---------|
| **Repository** | `~/git/claude-shared-settings/` | `%USERPROFILE%\git\claude-shared-settings\` |
| **Commands Symlink** | `~/.claude/commands/iadev` → repo | `%USERPROFILE%\.claude\commands\iadev` → repo |
| **Skills Symlink** | `~/.claude/skills` → repo | `%USERPROFILE%\.claude\skills` → repo |
| **Plugins Symlink** | `~/.claude/plugins/mcp-manager` → repo | `%USERPROFILE%\.claude\plugins\mcp-manager` → repo |

### Command Summary

**Setup:**
- Mac/Linux: One-command block from Quick Setup section
- Windows Admin: `.\setup\setup.ps1`
- Windows No Admin: `.\setup\setup-no-admin.ps1`

**Update:**
- With symlinks: `git pull` then restart Claude Code
- Without symlinks: `git pull` then `.\setup\update.ps1`

**Verify:**
- Commands: Type `/iadev:` in Claude Code
- Skills: Say "I need to gather requirements"
- Plugins: Check MCP Manager with `ls ~/.claude/plugins/mcp-manager/`

**Configure MCP Servers:**
- Edit `plugins/mcp-manager/config/enabled-mcps.json`
- Set servers to `true` to enable, `false` to disable
- Restart Claude Code to apply changes

---

## Next Steps

After setup:

1. ✅ **Test Commands** - Try `/iadev:make-planning-document` on a document
2. ✅ **Test Skills** - Ask Claude to help gather requirements
3. ✅ **Configure MCP Servers** - Edit `plugins/mcp-manager/config/enabled-mcps.json` as needed
4. ✅ **Bookmark This Guide** - For future reference and troubleshooting
5. ✅ **Share with Team** - Send them the repository URL and this guide
6. ✅ **Check Backlog** - See `backlog.md` for upcoming skills and features

[⬆ Back to Top](#claude-shared-settings---complete-setup-guide)
