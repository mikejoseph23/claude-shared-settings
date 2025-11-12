# update.ps1 - Pull latest changes and sync (for copy mode)

Write-Host "Updating Claude Shared Settings..." -ForegroundColor Cyan
Write-Host ""

# Navigate to repo
$repoPath = "$env:USERPROFILE\git\claude-shared-settings"
if (Test-Path $repoPath) {
    Set-Location $repoPath
} else {
    Write-Host "❌ Repository not found at: $repoPath" -ForegroundColor Red
    exit 1
}

# Pull latest changes
Write-Host "Pulling latest changes from git..." -ForegroundColor Cyan
git pull

Write-Host ""
Write-Host "Syncing commands and skills..." -ForegroundColor Cyan

# Copy commands
try {
    Copy-Item -Path ".\commands" -Destination "$env:USERPROFILE\.claude\commands\iadev" -Recurse -Force
    Write-Host "✅ Commands synced" -ForegroundColor Green
} catch {
    Write-Host "❌ Commands sync failed: $_" -ForegroundColor Red
}

# Copy skills
try {
    Copy-Item -Path ".\skills" -Destination "$env:USERPROFILE\.claude\skills" -Recurse -Force
    Write-Host "✅ Skills synced" -ForegroundColor Green
} catch {
    Write-Host "❌ Skills sync failed: $_" -ForegroundColor Red
}

# Copy plugins
try {
    Copy-Item -Path ".\plugins\mcp-manager" -Destination "$env:USERPROFILE\.claude\plugins\mcp-manager" -Recurse -Force
    Write-Host "✅ Plugin synced" -ForegroundColor Green
} catch {
    Write-Host "❌ Plugin sync failed: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "✅ Updates synced successfully!" -ForegroundColor Green
Write-Host "Restart Claude Code to load changes." -ForegroundColor Yellow
Write-Host ""
