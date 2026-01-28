# start-agent-browser.ps1
# Windows workaround for agent-browser daemon startup race condition
# See: https://github.com/vercel-labs/agent-browser/issues/37
# See: https://github.com/vercel-labs/agent-browser/issues/132
#
# Usage:
#   .\scripts\start-agent-browser.ps1                        # Start daemon
#   .\scripts\start-agent-browser.ps1 -Session "my-session"  # Named session
#   .\scripts\start-agent-browser.ps1 -Stop                  # Stop daemon
#
# After starting, use agent-browser CLI normally:
#   agent-browser open https://example.com
#   agent-browser snapshot
#   agent-browser close

param(
    [string]$Session = "default",
    [switch]$Stop,
    [switch]$Headed
)

$AgentBrowserDir = Join-Path $env:USERPROFILE ".agent-browser"
$PidFile = Join-Path $AgentBrowserDir "$Session.pid"
$PortFile = Join-Path $AgentBrowserDir "$Session.port"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$DaemonScript = Join-Path $ScriptDir "agent-browser-daemon.mjs"

# Ensure socket directory exists
if (-not (Test-Path $AgentBrowserDir)) {
    New-Item -ItemType Directory -Path $AgentBrowserDir -Force | Out-Null
}

function Stop-Daemon {
    if (Test-Path $PidFile) {
        $rawPid = (Get-Content $PidFile -Raw).Trim()
        try {
            Stop-Process -Id $rawPid -Force -ErrorAction Stop
            Write-Host "Stopped daemon (PID: $rawPid)" -ForegroundColor Yellow
        } catch {
            Write-Host "Daemon process not found (PID: $rawPid)" -ForegroundColor Gray
        }
        Remove-Item $PidFile -Force -ErrorAction SilentlyContinue
        Remove-Item $PortFile -Force -ErrorAction SilentlyContinue
    } else {
        Write-Host "No daemon running for session: $Session" -ForegroundColor Gray
    }
}

if ($Stop) {
    Stop-Daemon
    exit 0
}

# Check if daemon is already running
if (Test-Path $PidFile) {
    $existingPid = (Get-Content $PidFile -Raw).Trim()
    try {
        Get-Process -Id $existingPid -ErrorAction Stop | Out-Null
        Write-Host "Daemon already running (PID: $existingPid)" -ForegroundColor Green
        exit 0
    } catch {
        Write-Host "Cleaning up stale PID file..." -ForegroundColor Yellow
        Remove-Item $PidFile -Force -ErrorAction SilentlyContinue
        Remove-Item $PortFile -Force -ErrorAction SilentlyContinue
    }
}

# Check daemon script exists
if (-not (Test-Path $DaemonScript)) {
    Write-Host "Error: Daemon script not found at $DaemonScript" -ForegroundColor Red
    exit 1
}

# Set environment for headed mode
if ($Headed) {
    $env:AGENT_BROWSER_HEADED = "1"
}

# Start daemon in background using the .mjs wrapper
Write-Host "Starting agent-browser daemon for session '$Session'..." -ForegroundColor Cyan
$process = Start-Process -FilePath "node" `
    -ArgumentList $DaemonScript, $Session `
    -WindowStyle Hidden `
    -PassThru

# Wait for daemon to be ready (check for PID file)
$maxWait = 15
$waited = 0
while ($waited -lt $maxWait) {
    Start-Sleep -Milliseconds 500
    $waited++
    if ((Test-Path $PidFile) -and (Test-Path $PortFile)) {
        $port = (Get-Content $PortFile -Raw).Trim()
        Write-Host ""
        Write-Host "Daemon started successfully!" -ForegroundColor Green
        Write-Host "  Session: $Session" -ForegroundColor White
        Write-Host "  PID:     $($process.Id)" -ForegroundColor White
        Write-Host "  Port:    $port" -ForegroundColor White
        Write-Host ""
        Write-Host "Now use agent-browser normally:" -ForegroundColor Gray
        Write-Host "  agent-browser open https://example.com" -ForegroundColor White
        Write-Host "  agent-browser snapshot" -ForegroundColor White
        Write-Host "  agent-browser close" -ForegroundColor White
        Write-Host ""
        Write-Host "To stop:" -ForegroundColor Gray
        Write-Host "  .\scripts\start-agent-browser.ps1 -Stop" -ForegroundColor White
        exit 0
    }
}

# Check if process is still running
if ($process.HasExited) {
    Write-Host "Error: Daemon process exited with code $($process.ExitCode)" -ForegroundColor Red
    Write-Host "Try running manually to see errors:" -ForegroundColor Yellow
    Write-Host "  node $DaemonScript" -ForegroundColor White
} else {
    Write-Host "Warning: Daemon started (PID: $($process.Id)) but PID/port files not found" -ForegroundColor Yellow
    Write-Host "The daemon may still be initializing. Try:" -ForegroundColor Yellow
    Write-Host "  agent-browser open https://example.com" -ForegroundColor White
}
