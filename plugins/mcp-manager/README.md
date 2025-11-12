# MCP Manager Plugin

Control which MCP servers are loaded in Claude Code without manually editing configuration files.

## Quick Start

1. **Setup the plugin** (included in main setup scripts)
2. **Configure servers** by editing `config/enabled-mcps.json`
3. **Restart Claude Code** to apply changes

## Configuration Files

### `config/enabled-mcps.json`

Toggle servers on/off:

```json
{
  "puppeteer": true,    // Enable Puppeteer for web automation
  "postgres": false,    // Disable PostgreSQL
  "filesystem": false   // Disable filesystem access
}
```

### `config/mcp-servers.json`

Define server configurations:

```json
{
  "puppeteer": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-puppeteer"]
  },
  "postgres": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-postgres"],
    "env": {
      "POSTGRES_CONNECTION_STRING": "postgresql://localhost/mydb"
    }
  }
}
```

## Usage Examples

### Enable Puppeteer for Web Research

```bash
# Edit the config
vim plugins/mcp-manager/config/enabled-mcps.json

# Set puppeteer to true
{
  "puppeteer": true,
  "postgres": false
}

# Restart Claude Code
```

### Add a New MCP Server

1. Add server definition to `config/mcp-servers.json`:

```json
{
  "myserver": {
    "command": "node",
    "args": ["/path/to/server.js"]
  }
}
```

2. Add toggle to `config/enabled-mcps.json`:

```json
{
  "myserver": false
}
```

3. Set to `true` when ready to use

### Disable All MCP Servers

Set all values to `false` in `enabled-mcps.json`:

```json
{
  "puppeteer": false,
  "postgres": false,
  "filesystem": false
}
```

## Benefits

- **No manual config editing**: Never touch `claude_desktop_config.json` directly
- **Version controlled**: Track MCP preferences in git
- **Team sharing**: Share MCP setup across team via repository
- **Context budget control**: Easily disable servers to free up context
- **Quick toggling**: Change one JSON value instead of editing complex configs

## Troubleshooting

### Changes Not Taking Effect

1. Make sure you restarted Claude Code after editing
2. Check console for `[MCP Manager]` log messages
3. Verify JSON syntax is valid

### Server Not Starting

1. Check that the server is defined in `mcp-servers.json`
2. Verify the command and args are correct
3. Check that you have the server installed (e.g., `npm install -g @modelcontextprotocol/server-puppeteer`)

### Conflicts with Manual Config

If you manually edit `claude_desktop_config.json`, the plugin will overwrite your changes on next startup. Use `enabled-mcps.json` instead.
