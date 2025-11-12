# setup.ps1 - Claude Shared Settings Setup for Windows
# Run as Administrator

Write-Host "Setting up Claude Shared Settings..." -ForegroundColor Cyan
Write-Host ""

# Navigate to repo
$repoPath = "$env:USERPROFILE\git\claude-shared-settings"
if (Test-Path $repoPath) {
    Set-Location $repoPath
    Write-Host "✅ Repository found at: $repoPath" -ForegroundColor Green
} else {
    Write-Host "❌ Repository not found at: $repoPath" -ForegroundColor Red
    Write-Host "Please clone the repository first:" -ForegroundColor Yellow
    Write-Host "git clone <repo-url> $repoPath" -ForegroundColor White
    exit 1
}

Write-Host ""

# Create directories
Write-Host "Creating directories..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\commands" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude" | Out-Null
Write-Host "✅ Directories created" -ForegroundColor Green
Write-Host ""

# Create commands symlink
Write-Host "Creating commands symlink..." -ForegroundColor Cyan
try {
    $commandsTarget = "$env:USERPROFILE\git\claude-shared-settings\commands"
    $commandsLink = "$env:USERPROFILE\.claude\commands\iadev"
    
    # Remove existing if present
    if (Test-Path $commandsLink) {
        Remove-Item $commandsLink -Force
    }
    
    New-Item -ItemType SymbolicLink -Path $commandsLink -Target $commandsTarget -Force | Out-Null
    Write-Host "✅ Commands symlink created" -ForegroundColor Green
    Write-Host "   $commandsLink" -ForegroundColor Gray
    Write-Host "   → $commandsTarget" -ForegroundColor Gray
} catch {
    Write-Host "❌ Commands symlink failed: $_" -ForegroundColor Red
    Write-Host "   Make sure you're running as Administrator" -ForegroundColor Yellow
}

Write-Host ""

# Create skills symlink
Write-Host "Creating skills symlink..." -ForegroundColor Cyan
try {
    $skillsTarget = "$env:USERPROFILE\git\claude-shared-settings\skills"
    $skillsLink = "$env:USERPROFILE\.claude\skills"

    # Remove existing if present
    if (Test-Path $skillsLink) {
        Remove-Item $skillsLink -Force -Recurse
    }

    New-Item -ItemType SymbolicLink -Path $skillsLink -Target $skillsTarget -Force | Out-Null
    Write-Host "✅ Skills symlink created" -ForegroundColor Green
    Write-Host "   $skillsLink" -ForegroundColor Gray
    Write-Host "   → $skillsTarget" -ForegroundColor Gray
} catch {
    Write-Host "❌ Skills symlink failed: $_" -ForegroundColor Red
    Write-Host "   Make sure you're running as Administrator" -ForegroundColor Yellow
}

Write-Host ""

# Create plugins symlink
Write-Host "Creating plugins symlink..." -ForegroundColor Cyan
try {
    $pluginsTarget = "$env:USERPROFILE\git\claude-shared-settings\plugins\mcp-manager"
    $pluginsLink = "$env:USERPROFILE\.claude\plugins\mcp-manager"

    # Create plugins directory
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\plugins" | Out-Null

    # Remove existing if present
    if (Test-Path $pluginsLink) {
        Remove-Item $pluginsLink -Force -Recurse
    }

    New-Item -ItemType SymbolicLink -Path $pluginsLink -Target $pluginsTarget -Force | Out-Null
    Write-Host "✅ Plugin symlink created" -ForegroundColor Green
    Write-Host "   $pluginsLink" -ForegroundColor Gray
    Write-Host "   → $pluginsTarget" -ForegroundColor Gray
} catch {
    Write-Host "❌ Plugin symlink failed: $_" -ForegroundColor Red
    Write-Host "   Make sure you're running as Administrator" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Verifying installation..." -ForegroundColor Cyan
Write-Host ""

# Verify commands
Write-Host "Commands:" -ForegroundColor White
if (Test-Path "$env:USERPROFILE\.claude\commands\iadev") {
    Get-ChildItem "$env:USERPROFILE\.claude\commands\iadev" | ForEach-Object { Write-Host "  ✅ $($_.Name)" -ForegroundColor Green }
} else {
    Write-Host "  ❌ Commands not found" -ForegroundColor Red
}

Write-Host ""

# Verify skills
Write-Host "Skills:" -ForegroundColor White
if (Test-Path "$env:USERPROFILE\.claude\skills") {
    Get-ChildItem "$env:USERPROFILE\.claude\skills" -Directory | ForEach-Object { Write-Host "  ✅ $($_.Name)" -ForegroundColor Green }
} else {
    Write-Host "  ❌ Skills not found" -ForegroundColor Red
}

Write-Host ""

# Verify plugins
Write-Host "Plugins:" -ForegroundColor White
if (Test-Path "$env:USERPROFILE\.claude\plugins\mcp-manager") {
    Write-Host "  ✅ mcp-manager" -ForegroundColor Green
} else {
    Write-Host "  ❌ MCP Manager plugin not found" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "1. Restart Claude Code" -ForegroundColor Yellow
Write-Host "2. Test commands: Type /iadev: in Claude Code" -ForegroundColor Yellow
Write-Host "3. Test skills: Ask Claude to 'help gather requirements'" -ForegroundColor Yellow
Write-Host "4. Configure MCP servers: Edit plugins\mcp-manager\config\enabled-mcps.json" -ForegroundColor Yellow
Write-Host ""
Write-Host "To update later: cd $repoPath && git pull" -ForegroundColor Gray
Write-Host ""
