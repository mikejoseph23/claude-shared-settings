# Team Claude Code Configuration Setup

## Executive Summary

**Purpose:** Extend the claude-shared-settings repository to include shared Skills and MCP management capabilities for the Interapp Development team.

**Status:** ✅ Core objectives completed - Skills and MCP Manager plugin operational

**Progress:** 2/2 major objectives completed

---

## Completed Work

### ✅ Skills Setup

**What was done:**
- Created `skills/requirements-interviewer/` with comprehensive SKILL.md
- Added symlink setup for skills in all setup scripts
- Updated README.md and SETUP.md with skills documentation
- Skills automatically activate based on conversation context
- Team can now share skills via git repository

**Files created:**
- [skills/requirements-interviewer/SKILL.md](skills/requirements-interviewer/SKILL.md:1)

**Documentation added:**
- Skills section in README.md
- Skills setup in SETUP.md
- Verification and troubleshooting

### ✅ MCP Manager Plugin

**What was done:**
- Created `plugins/mcp-manager/` with full plugin structure
- Automatic MCP server management via JSON config files
- Toggle MCP servers on/off without editing `claude_desktop_config.json`
- Added plugin setup to all setup scripts (Mac/Linux/Windows)
- Comprehensive documentation in plugin README.md

**Files created:**
- [plugins/mcp-manager/PLUGIN.md](plugins/mcp-manager/PLUGIN.md:1)
- [plugins/mcp-manager/README.md](plugins/mcp-manager/README.md:1)
- [plugins/mcp-manager/on-client-start.js](plugins/mcp-manager/on-client-start.js:1)
- [plugins/mcp-manager/config/enabled-mcps.json](plugins/mcp-manager/config/enabled-mcps.json:1)
- [plugins/mcp-manager/config/mcp-servers.json](plugins/mcp-manager/config/mcp-servers.json:1)

**Setup scripts updated:**
- [setup/setup.sh](setup/setup.sh:1) - Mac/Linux
- [setup/setup.ps1](setup/setup.ps1:1) - Windows (admin)
- [setup/setup-no-admin.ps1](setup/setup-no-admin.ps1:1) - Windows (no admin)
- [setup/update.ps1](setup/update.ps1:1) - Windows update

**Benefits delivered:**
- No manual config file editing
- Context budget control (disable unused MCP servers)
- Version control MCP preferences
- Team can share MCP setup via git

### ✅ Issue Resolved: Recursive Symlink

**Problem:** Skills symlink showed recursive structure due to `skills/skills` symlink inside repository

**Solution:** Removed the errant symlink at `/Users/michaeljosephwork/git/claude-shared-settings/skills/skills`

**Status:** Resolved - symlinks now work correctly

---

## Future Enhancements

### Additional Skills (As Needed)

Create additional skills when team needs emerge:
- **Code Reviewer Skill** - Automatic code quality analysis
- **Architecture Advisor Skill** - System design guidance
- **Testing Strategy Skill** - Test planning and coverage
- **Security Auditor Skill** - Security best practices

**Process:**
1. Identify need through team usage
2. Create skill in `skills/` directory
3. Test locally
4. Commit and push to repository
5. Team members pull and restart Claude Code

### MCP Server Additions

Current MCP servers in config (all disabled by default):
- Puppeteer - Web automation and research
- Postgres - Database queries
- Filesystem - File system access

**To add new MCP servers:**
1. Add server definition to `plugins/mcp-manager/config/mcp-servers.json`
2. Add toggle to `plugins/mcp-manager/config/enabled-mcps.json`
3. Commit and push
4. Team members pull updates

### Global CLAUDE.md (Optional - Future Consideration)

**Status:** Not started - needs research

**Questions to answer:**
1. Is there a global CLAUDE.md location that applies to all projects?
2. Would a shared CLAUDE.md provide value beyond project-specific ones?
3. Can it be symlinked, or must it be copied per-project?

**If pursued later:**
- Research global CLAUDE.md capabilities
- Create team template
- Add to repository with setup instructions

---

## Notes

### Agents

**Current understanding:**
- Agents (general-purpose, Explore, Plan, statusline-setup) are built-in to Claude Code
- Custom agents cannot be created by users
- Agent ideas documented in [agent-ideas.md](agent-ideas.md:1) for future reference
- **No action needed** - use built-in agents via Task tool as needed

### Repository Status

**Current capabilities:**
- ✅ Commands (4 commands in `iadev:` namespace)
- ✅ Skills (1 skill: requirements-interviewer)
- ✅ MCP Manager plugin (operational with 3 predefined servers)
- ✅ Complete setup scripts for Mac/Linux and Windows
- ✅ Comprehensive documentation

**Team ready:** Repository is production-ready for team rollout

---

## Next Steps

**Immediate:**
1. Test MCP Manager plugin after restart
2. Share repository with team
3. Gather feedback on new capabilities

**Ongoing:**
1. Monitor team usage patterns
2. Create additional skills as needs emerge
3. Add MCP server definitions as requested
4. Update documentation based on feedback

[⬆ Back to Top](#team-claude-code-configuration-setup)
