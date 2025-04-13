@echo off

:: Run PowerShell script from same folder as admin
powershell -Command "&{ Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0disable-steamos.ps1"' -Verb RunAs}"