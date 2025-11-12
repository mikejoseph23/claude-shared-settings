# setup-no-admin.ps1 - Claude Shared Settings Setup for Windows (No Admin Required)
# Uses file copying instead of symlinks

Write-Host "Setting up Claude Shared Settings (copy mode)..." -ForegroundColor Cyan
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

# Copy commands
Write-Host "Copying commands..." -ForegroundColor Cyan
try {
    $commandsSource = ".\commands"
    $commandsDest = "$env:USERPROFILE\.claude\commands\iadev"
    
    # Remove existing if present
    if (Test-Path $commandsDest) {
        Remove-Item $commandsDest -Recurse -Force
    }
    
    Copy-Item -Path $commandsSource -Destination $commandsDest -Recurse -Force
    Write-Host "✅ Commands copied" -ForegroundColor Green
    Write-Host "   → $commandsDest" -ForegroundColor Gray
} catch {
    Write-Host "❌ Commands copy failed: $_" -ForegroundColor Red
}

Write-Host ""

# Copy skills
Write-Host "Copying skills..." -ForegroundColor Cyan
try {
    $skillsSource = ".\skills"
    $skillsDest = "$env:USERPROFILE\.claude\skills"

    # Remove existing if present
    if (Test-Path $skillsDest) {
        Remove-Item $skillsDest -Recurse -Force
    }

    Copy-Item -Path $skillsSource -Destination $skillsDest -Recurse -Force
    Write-Host "✅ Skills copied" -ForegroundColor Green
    Write-Host "   → $skillsDest" -ForegroundColor Gray
} catch {
    Write-Host "❌ Skills copy failed: $_" -ForegroundColor Red
}

Write-Host ""

# Copy plugins
Write-Host "Copying plugins..." -ForegroundColor Cyan
try {
    $pluginsSource = ".\plugins\mcp-manager"
    $pluginsDest = "$env:USERPROFILE\.claude\plugins\mcp-manager"

    # Create plugins directory
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\plugins" | Out-Null

    # Remove existing if present
    if (Test-Path $pluginsDest) {
        Remove-Item $pluginsDest -Recurse -Force
    }

    Copy-Item -Path $pluginsSource -Destination $pluginsDest -Recurse -Force
    Write-Host "✅ Plugin copied" -ForegroundColor Green
    Write-Host "   → $pluginsDest" -ForegroundColor Gray
} catch {
    Write-Host "❌ Plugin copy failed: $_" -ForegroundColor Red
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
Write-Host "⚠️  IMPORTANT:" -ForegroundColor Yellow
Write-Host "Files were copied (not symlinked)." -ForegroundColor White
Write-Host "You must re-run this script or use update.ps1 after 'git pull'" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "1. Restart Claude Code" -ForegroundColor Yellow
Write-Host "2. Test commands: Type /iadev: in Claude Code" -ForegroundColor Yellow
Write-Host "3. Test skills: Ask Claude to 'help gather requirements'" -ForegroundColor Yellow
Write-Host "4. Configure MCP servers: Edit .claude\plugins\mcp-manager\config\enabled-mcps.json" -ForegroundColor Yellow
Write-Host ""
Write-Host "To update later:" -ForegroundColor Gray
Write-Host "  cd $repoPath" -ForegroundColor Gray
Write-Host "  git pull" -ForegroundColor Gray
Write-Host "  .\setup\update.ps1" -ForegroundColor Gray
Write-Host ""
