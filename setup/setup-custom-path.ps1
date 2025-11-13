# setup-custom-path.ps1 - Run as Administrator
# For repositories not in the standard %USERPROFILE%\git location

Write-Host "Setting up Claude Shared Settings..." -ForegroundColor Cyan

# Get the current directory (should be the repo root)
$repoPath = Get-Location

Write-Host "Using repository path: $repoPath" -ForegroundColor Yellow

# Create directories
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\commands" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\plugins" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude" | Out-Null

# Create symlinks using current directory
try {
    New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\commands\iadev" -Target "$repoPath\commands" -Force | Out-Null
    Write-Host "✅ Commands symlink created" -ForegroundColor Green
} catch {
    Write-Host "❌ Commands symlink failed: $_" -ForegroundColor Red
}

try {
    New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\skills" -Target "$repoPath\skills" -Force | Out-Null
    Write-Host "✅ Skills symlink created" -ForegroundColor Green
} catch {
    Write-Host "❌ Skills symlink failed: $_" -ForegroundColor Red
}

try {
    New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\plugins\mcp-manager" -Target "$repoPath\plugins\mcp-manager" -Force | Out-Null
    Write-Host "✅ MCP Manager plugin symlink created" -ForegroundColor Green
} catch {
    Write-Host "❌ MCP Manager symlink failed: $_" -ForegroundColor Red
}

# Verify
Write-Host "`nVerifying installation:" -ForegroundColor Cyan
Get-ChildItem "$env:USERPROFILE\.claude\commands\"
Get-ChildItem "$env:USERPROFILE\.claude\skills\"
Get-ChildItem "$env:USERPROFILE\.claude\plugins\"

Write-Host "`n✅ Setup complete! Restart Claude Code." -ForegroundColor Green
Write-Host "Commands available with /iadev: prefix" -ForegroundColor White
Write-Host "Skills are active across all projects" -ForegroundColor White
Write-Host "MCP Manager plugin installed" -ForegroundColor White
