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

# Fetch Steam path
$CUSTOM_STEAM_PATH = Get-Content -Path "$PSScriptRoot\\steam_path.txt" -Raw
$CUSTOM_STEAM_PATH = $CUSTOM_STEAM_PATH.Trim()

# Launch Steam
Start-Process "$CUSTOM_STEAM_PATH\\steam.exe" -ArgumentList '-noverifyfiles', '-gamepadui', '-fulldesktopres'

# Wait until ALL steam.exe processes are gone for at least 10 seconds
$stableCount = 0
while ($true) {
    $running = Get-Process steam -ErrorAction SilentlyContinue
    if ($running) {
        $stableCount = 0  # Reset if Steam is still running
    } else {
        $stableCount++
    }

    if ($stableCount -ge 10) {
        break  # Steam has been gone for 10 seconds
    }

    Start-Sleep -Seconds 1
}

# Now safe to restore explorer shell
Start-Process explorer.exe
