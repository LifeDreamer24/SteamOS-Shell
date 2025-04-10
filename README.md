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

## 🔙 Uninstall

1. Run `uninstall-steamos.bat`.
2. Your system will reboot into the normal Windows desktop shell.

---

## 💡 Notes

- The script waits for internet availability before launching Steam to prevent “Steam needs to be online to update” errors.
- You can extend it to support other launchers like Playnite, EmulationStation, etc.

---

## 🧠 Requirements

- Windows 10 or 11
- Steam installed
- Admin rights to change the shell

---

## 🙌 Credits

Huge thanks to **[Simon](https://github.com/LifeDreamer24)** for creating and refining this shell setup with care and precision!

Built with guidance, scripting, and troubleshooting help from **ChatGPT by OpenAI** 🤖  
If you found this project useful, feel free to give it a ⭐!

---

Thank you for using!
Game on. 🎮
