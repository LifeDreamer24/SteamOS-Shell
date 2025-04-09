@echo off
:: Launch PowerShell script from same directory
powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0enable-steamos.ps1"
