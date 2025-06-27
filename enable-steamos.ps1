# Wait for Internet connectivity
$maxTries = 20
$tries = 0
$online = $false

while (-not $online -and $tries -lt $maxTries) {
    try {
        $ping = Test-Connection -ComputerName store.steampowered.com -Count 1 -Quiet
        if ($ping) {
            $online = $true
            break
        }
    } catch {}
    Start-Sleep -Seconds 2
    $tries++
}

if (-not $online) {
    Write-Host "Network not detected. Proceeding anyway..."
}

# Fetch Steam path from steam_path.txt
$CUSTOM_STEAM_PATH = Get-Content -Path "$PSScriptRoot\\steam_path.txt" -Raw
$CUSTOM_STEAM_PATH = $CUSTOM_STEAM_PATH.Trim()

# Launch Steam and track the process ID
$steamProc = Start-Process "$CUSTOM_STEAM_PATH\\steam.exe" -ArgumentList '-noverifyfiles', '-steamos', '-gamepadui', '-fulldesktopres' -PassThru
$steamPid = $steamProc.Id

# Wait until the specific process ends
try {
    Wait-Process -Id $steamPid
    # Only reach here if that exact Steam process exited (not restarted)
    Start-Process explorer.exe
} catch {
    Write-Host "Steam process wait failed or was terminated unexpectedly."
}
