#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const os = require('os');

// Paths
const pluginDir = __dirname;
const enabledMcpsPath = path.join(pluginDir, 'config', 'enabled-mcps.json');
const mcpServersPath = path.join(pluginDir, 'config', 'mcp-servers.json');
const configPath = path.join(os.homedir(), '.claude', 'claude_desktop_config.json');

// Load configuration files
function loadJson(filePath) {
  try {
    return JSON.parse(fs.readFileSync(filePath, 'utf8'));
  } catch (error) {
    console.error(`[MCP Manager] Error loading ${filePath}:`, error.message);
    return null;
  }
}

// Save configuration file
function saveJson(filePath, data) {
  try {
    fs.writeFileSync(filePath, JSON.stringify(data, null, 2) + '\n', 'utf8');
    return true;
  } catch (error) {
    console.error(`[MCP Manager] Error saving ${filePath}:`, error.message);
    return false;
  }
}

// Main logic
function manageMcpServers() {
  // Load enabled MCPs configuration
  const enabledMcps = loadJson(enabledMcpsPath);
  if (!enabledMcps) {
    console.error('[MCP Manager] Could not load enabled-mcps.json');
    return;
  }

  // Load MCP server definitions
  const mcpServers = loadJson(mcpServersPath);
  if (!mcpServers) {
    console.error('[MCP Manager] Could not load mcp-servers.json');
    return;
  }

  // Load or create Claude config
  let config = {};
  if (fs.existsSync(configPath)) {
    config = loadJson(configPath);
    if (!config) {
      console.error('[MCP Manager] Could not load claude_desktop_config.json');
      return;
    }
  }

  // Initialize mcpServers section if it doesn't exist
  if (!config.mcpServers) {
    config.mcpServers = {};
  }

  // Update MCP servers based on enabled configuration
  let changes = 0;

  Object.keys(enabledMcps).forEach(serverName => {
    const isEnabled = enabledMcps[serverName];
    const serverConfig = mcpServers[serverName];

    if (!serverConfig) {
      console.warn(`[MCP Manager] No configuration found for server: ${serverName}`);
      return;
    }

    if (isEnabled) {
      // Add or update server
      if (!config.mcpServers[serverName]) {
        config.mcpServers[serverName] = serverConfig;
        console.log(`[MCP Manager] ✅ Enabled: ${serverName}`);
        changes++;
      }
    } else {
      // Remove server if it exists
      if (config.mcpServers[serverName]) {
        delete config.mcpServers[serverName];
        console.log(`[MCP Manager] ❌ Disabled: ${serverName}`);
        changes++;
      }
    }
  });

  // Save updated configuration
  if (changes > 0) {
    if (saveJson(configPath, config)) {
      console.log(`[MCP Manager] Updated ${changes} server(s) in claude_desktop_config.json`);
    } else {
      console.error('[MCP Manager] Failed to save configuration');
    }
  } else {
    console.log('[MCP Manager] No changes needed');
  }
}

// Run the manager
manageMcpServers();
