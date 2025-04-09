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

# Launch Steam Gamepad UI
Start-Process "C:\Program Files (x86)\Steam\Steam.exe" -ArgumentList "-steamos -gamepadui -dev"

# Wait for Steam to close, then restore Explorer shell
Get-Process Steam -ErrorAction SilentlyContinue | Wait-Process

Start-Process explorer.exe
