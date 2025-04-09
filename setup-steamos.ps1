# Copy to LOCALAPPDATA for portability
$Target = "$env:LOCALAPPDATA\SteamOSShell"
New-Item -Path $Target -ItemType Directory -Force | Out-Null
Copy-Item -Path "$PSScriptRoot\*" -Destination $Target -Recurse -Force

# Set custom shell
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "Shell" -Value "$Target\launch-steamos.bat"

# Reboot to apply
shutdown /r /t 5
