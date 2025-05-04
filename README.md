![Windows 10+](https://img.shields.io/badge/platform-Windows%2010%2B-blue)  
![Steam Shell](https://img.shields.io/badge/Steam-GamepadUI-lightgrey)  
![Installer](https://img.shields.io/badge/setup-EXE--based-yellow)

# 🕹️ SteamOS Shell for Windows — Executable Installer Edition

**SteamOS Shell** is a Windows shell replacement that launches **Steam in Big Picture Mode (Gamepad UI)** on startup, turning your PC into a console-like, couch-friendly gaming experience.  
This branch uses a **compiled executable installer** created with *Advanced BAT to EXE Converter PRO* for fully automated setup.

---

## 🚀 Features

- Replaces the Windows shell with **Steam Big Picture Mode**
- Waits for internet connection to avoid Steam update errors
- Restores **Windows Explorer** when Steam is closed
- Uses `%LOCALAPPDATA%\SteamOSShell` for all files (fully portable)
- Desktop shortcut included for easy logout and return to Game Mode
- Fully automated **EXE installer** — no manual script running required

---

## 🖥️ What the Installer Does

- Extracts all necessary files into `%LOCALAPPDATA%\SteamOSShell`
- Saves your custom Steam install path in `steam_path.txt`
- Copies a custom icon to the same folder
- Creates a shortcut on the desktop: **"Go to Gamemode"**
- Sets `launch-steamos.bat` as the system shell on login

---

## 🛠️ Included (Behind the Scenes)

- `setup-steamos.ps1` – Main setup logic (shell registration + file handling)
- `enable-steamos.ps1` – Launches Steam in Gamepad UI after checking network
- `disable-steamos.ps1` – Restores default Explorer shell
- `launch-steamos.bat` – Shell entry point script
- `uninstall-steamos.bat` – Removes the shell and restores original config
- `steamdeck-gaming-return.ico` – Icon used for the desktop shortcut

---

## ❓ How to Restore Desktop Manually

If Steam closes and you are left with a black screen:

1. Press `Ctrl + Shift + Esc` to open **Task Manager**
2. Go to **File > Run new task**
3. Type `explorer` and press Enter

You can also press `Ctrl + Alt + Del` and select Task Manager if stuck.

---

## 🔙 Uninstallation

- Run `uninstall-steamos.bat` from `%LOCALAPPDATA%\SteamOSShell`
- Your system will reboot into the standard Windows desktop environment

---

## 🧠 Requirements

- Windows 10 or 11 (64-bit)
- Steam installed
- Administrator rights for setup

---

## 🙌 Credits

Big thanks to **ChatGPT by OpenAI** for help with scripting, logic, and automation.  
Created with passion by **LifeDreamer24**

If you like this project, please consider giving it a ⭐ on GitHub!

---

Game on. 🎮