# Restore default shell
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "Shell" -Value "explorer.exe"

# Optional: Clean up folder
$Target = "$env:LOCALAPPDATA\SteamOSShell"
Remove-Item -Path $Target -Recurse -Force -ErrorAction SilentlyContinue

# Reboot
shutdown /r /t 5
