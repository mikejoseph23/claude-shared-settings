---
name: mcp-manager
description: Manage MCP server activation without editing config files directly
version: 1.0.0
---

# MCP Manager Plugin

This plugin allows you to enable/disable MCP servers by editing a simple JSON file instead of manually managing `claude_desktop_config.json`.

## How It Works

1. Edit `config/enabled-mcps.json` to toggle MCP servers on/off
2. Plugin reads this file on Claude Code startup
3. Automatically updates your Claude config with enabled servers
4. Restart Claude Code to apply changes

## Configuration

Edit `plugins/mcp-manager/config/enabled-mcps.json`:

```json
{
  "puppeteer": false,
  "postgres": false,
  "filesystem": true
}
```

Set any server to `true` to enable it, `false` to disable it.

## Benefits

- ✅ No manual config file editing
- ✅ Version control your MCP preferences
- ✅ Share MCP setup with team via git
- ✅ Toggle multiple servers at once
- ✅ Avoid config file conflicts

## Usage

```bash
# Enable/disable servers
vim plugins/mcp-manager/config/enabled-mcps.json

# Restart Claude Code to apply changes
```

## Adding New MCP Servers

1. Add server configuration to `config/mcp-servers.json`
2. Add toggle to `config/enabled-mcps.json`
3. Restart Claude Code
