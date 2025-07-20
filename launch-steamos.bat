@echo off
:: Launch PowerShell script from same directory
start "" conhost --headless powershell.exe -WindowStyle Hidden -NoProfile -NonInteractive -File "%~dp0enable-steamos.ps1"