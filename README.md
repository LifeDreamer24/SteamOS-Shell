![Windows 10+](https://img.shields.io/badge/platform-Windows%2010%2B-blue)
![Steam Shell](https://img.shields.io/badge/Steam-GamepadUI-lightgrey)
![Portable](https://img.shields.io/badge/portable-yes-success)

# 🕹️ SteamOS Shell for Windows

A lightweight shell replacement for Windows that launches **Steam in Big Picture Mode (Gamepad UI)** using the `-steamos -gamepadui -dev` flags — perfect for turning your PC into a couch-friendly, gaming console-like experience.

---

## 🚀 Features

- Launches **Steam Big Picture Mode (Gamepad UI)** instead of Explorer on startup
- Waits for network availability to avoid Steam update errors
- Restores **Explorer** automatically when Steam is closed
- Fully **portable & path-independent**
- Includes one-click setup & uninstall scripts

---

## 📦 What's Included

- `launch-steamos.bat` – The shell entry point, launches the script
- `enable-steamos.ps1` – Main script that waits for network and launches Steam in Big Picture mode
- `setup-steamos.ps1` – Installs the custom shell into `%LOCALAPPDATA%` and sets it as your shell
- `setup-steamos.bat` – One-click admin launcher for the setup script
- `disable-steamos.ps1` – Restores the default Explorer shell and cleans up
- `uninstall-steamos.bat` – One-click admin launcher for the uninstall script
- `README.txt` – Basic offline instructions (optional)

---

## 🛠️ Installation

1. Download this repo and extract it anywhere.
2. Run `setup-steamos.bat`.
3. Your system will reboot into Steam Big Picture mode automatically!

> The setup script copies everything to `%LOCALAPPDATA%\SteamOSShell` so it's fully portable.

---

## 🖥️ Manually Opening the Windows Desktop

If you accidentally close the Steam window without fully exiting Steam, the desktop may not appear automatically. Here’s how to get it back manually:
1. Press Ctrl + Shift + Esc to open Task Manager.
2.	Click File > Run new task.
3.	Type `explorer` and hit Enter.
4.	The standard Windows interface (taskbar, desktop, etc.) will reappear.

> You can also press Ctrl + Alt + Del and choose Task Manager from the menu if you’re stuck.

---

## 🔙 Uninstallation

1. Run `uninstall-steamos.bat`.
2. Your system will reboot into the normal Windows desktop shell.

---

## 💡 Side Notes

- The script waits for internet availability before launching Steam to prevent “Steam needs to be online to update” errors.
- You can extend it to support other launchers like Playnite, EmulationStation, etc.

---

## 🧠 Requirements

- Windows 10 or 11
- Steam installed
- Admin rights to change the shell

---

## 🙌 Credits

Huge thanks to **ChatGPT by OpenAI** for the guidance, scripting, and troubleshooting help given.
If you found this project useful, feel free to give it a ⭐!

---

Thank you for using!
Game on. 🎮
