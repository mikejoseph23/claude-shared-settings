#!/bin/bash
# setup.sh - Claude Shared Settings Setup for Mac/Linux

set -e

echo "================================================"
echo "Claude Shared Settings Setup"
echo "================================================"
echo ""

# Get repository path
REPO_PATH="$HOME/git/claude-shared-settings"

# Check if in repo
if [ -f "$REPO_PATH/README.md" ]; then
    cd "$REPO_PATH"
    echo "✅ Repository found at: $REPO_PATH"
else
    echo "❌ Repository not found at: $REPO_PATH"
    echo "Please clone the repository first:"
    echo "git clone <repo-url> ~/git/claude-shared-settings"
    exit 1
fi

echo ""

# Create directories
echo "Creating directories..."
mkdir -p ~/.claude/commands
mkdir -p ~/.claude
echo "✅ Directories created"
echo ""

# Create commands symlink
echo "Creating commands symlink..."
if [ -L ~/.claude/commands/iadev ]; then
    rm ~/.claude/commands/iadev
fi
ln -sf "$REPO_PATH/commands" ~/.claude/commands/iadev
echo "✅ Commands symlink created"
echo "   ~/.claude/commands/iadev"
echo "   → $REPO_PATH/commands"
echo ""

# Create skills symlink
echo "Creating skills symlink..."
if [ -L ~/.claude/skills ]; then
    rm ~/.claude/skills
fi
ln -sf "$REPO_PATH/skills" ~/.claude/skills
echo "✅ Skills symlink created"
echo "   ~/.claude/skills"
echo "   → $REPO_PATH/skills"
echo ""

# Create plugins symlink
echo "Creating plugins symlink..."
if [ -L ~/.claude/plugins/mcp-manager ]; then
    rm ~/.claude/plugins/mcp-manager
fi
mkdir -p ~/.claude/plugins
ln -sf "$REPO_PATH/plugins/mcp-manager" ~/.claude/plugins/mcp-manager
echo "✅ Plugin symlink created"
echo "   ~/.claude/plugins/mcp-manager"
echo "   → $REPO_PATH/plugins/mcp-manager"
echo ""

# Verify
echo "Verifying installation..."
echo ""

echo "Commands:"
if [ -d ~/.claude/commands/iadev ]; then
    ls -1 ~/.claude/commands/iadev/ | while read file; do
        echo "  ✅ $file"
    done
else
    echo "  ❌ Commands not found"
fi

echo ""

echo "Skills:"
if [ -d ~/.claude/skills ]; then
    ls -1 ~/.claude/skills/ | while read dir; do
        if [ -d ~/.claude/skills/$dir ]; then
            echo "  ✅ $dir"
        fi
    done
else
    echo "  ❌ Skills not found"
fi

echo ""

echo "Plugins:"
if [ -d ~/.claude/plugins/mcp-manager ]; then
    echo "  ✅ mcp-manager"
else
    echo "  ❌ MCP Manager plugin not found"
fi

echo ""
echo "========================================"
echo "✅ Setup complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. Restart Claude Code"
echo "2. Test commands: Type /iadev: in Claude Code"
echo "3. Test skills: Ask Claude to 'help gather requirements'"
echo "4. Configure MCP servers: Edit plugins/mcp-manager/config/enabled-mcps.json"
echo ""
echo "To update later: cd $REPO_PATH && git pull"
echo ""
