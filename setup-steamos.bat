@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=C:\Users\LifeDreamer24\Desktop\SteamOS Gamemode For Windows 11 Installer.exe
REM BFCPEICON=C:\Users\LifeDreamer24\Pictures\steamdeck-gaming-return.ico
REM BFCPEICONINDEX=-1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=0
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Product Name
REM BFCPEVERDESC=Product Description
REM BFCPEVERCOMPANY=Your Company
REM BFCPEVERCOPYRIGHT=Copyright Info
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=30
REM BFCPEWINDOWWIDTH=120
REM BFCPEWTITLE=SteamOS Gamemode For Windows 11 Installer
REM BFCPEEMBED=C:\Users\LifeDreamer24\Documents\SteamOS_Installer_Pack\disable-steamos.ps1
REM BFCPEEMBED=C:\Users\LifeDreamer24\Documents\SteamOS_Installer_Pack\enable-steamos.ps1
REM BFCPEEMBED=C:\Users\LifeDreamer24\Documents\SteamOS_Installer_Pack\launch-steamos.bat
REM BFCPEEMBED=C:\Users\LifeDreamer24\Documents\SteamOS_Installer_Pack\setup-steamos.ps1
REM BFCPEEMBED=C:\Users\LifeDreamer24\Documents\SteamOS_Installer_Pack\steamdeck-gaming-return.ico
REM BFCPEEMBED=C:\Users\LifeDreamer24\Documents\SteamOS_Installer_Pack\uninstall-steamos.bat
REM BFCPEOPTIONEND

:: --- Custom SteamOS Installer Logic ---

@ECHO OFF

:: Set custom shell
powershell -Command "&{ Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -WindowStyle Hidden -File \"%MYFILES%\setup-steamos.ps1\"' -Verb RunAs}"

:: Ask user for Steam install location
SET /P CUSTOM_STEAM_PATH=Enter your Steam install path [default: C:\Program Files (x86)\Steam]: 
IF "%CUSTOM_STEAM_PATH%"=="" SET CUSTOM_STEAM_PATH=C:\Program Files (x86)\Steam
ECHO %CUSTOM_STEAM_PATH% > "%LOCALAPPDATA%\SteamOSShell\steam_path.txt"

:: Create logout script
ECHO shutdown -l > "%LOCALAPPDATA%\SteamOSShell\logout.bat"

:: Copy the embedded icon file
COPY "%MYFILES%\steamdeck-gaming-return.ico" "%LOCALAPPDATA%\SteamOSShell\steamdeck-gaming-return.ico"

:: Create desktop shortcut to logout script with custom icon
SET DESKTOP=%USERPROFILE%\Desktop
powershell -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%DESKTOP%\Go to Gamemode.lnk');$s.TargetPath='%LOCALAPPDATA%\SteamOSShell\logout.bat';$s.IconLocation='%LOCALAPPDATA%\SteamOSShell\steamdeck-gaming-return.ico';$s.Save()"

:: Final message
ECHO Installation complete.
PAUSE
