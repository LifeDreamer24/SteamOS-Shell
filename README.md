# SteamOS Shell for Windows

A custom Windows shell replacement that launches Steam Big Picture / Gamemode automatically when you log in — just like SteamOS.  
When Steam closes, Explorer is restored and the user is logged out, giving you a console-like experience on Windows.

---

## ✨ Features
- Replaces **Explorer.exe** with a custom shell that starts Steam in Big Picture Mode.
- When Steam exits, waits 10 seconds, restores Explorer shell, then logs out cleanly.
- **Optional Start Menu shortcuts** (configurable during installation).
- Proper uninstall entry in **Windows Settings → Apps & Features**.
- Includes desktop shortcut `Go to Gamemode`.
- Installer built with **Inno Setup**.

---

## 📥 Installation
1. Download the latest release from the [Releases](../../releases) page.
2. Run the installer (`SteamOS-Shell-Setup.exe`).
3. During setup you can:
   - Choose whether to create Start Menu shortcuts.
   - Install/uninstall at any time via Windows Settings.

After installation, logging into Windows will start Steam instead of Explorer.

---

## 🔄 Uninstall
You can remove SteamOS Shell in two ways:
- Open **Windows Settings → Apps → Installed Apps → SteamOS Shell → Uninstall**.
- Or run `unins000.exe` from the installation folder.

---

## ⚠️ Safety & Recovery
Changing the Windows shell is an advanced tweak.  
If Steam fails to start, you might see a blank or gray screen after login.

To recover:
1. Press `Ctrl+Shift+Esc` to open **Task Manager**.
2. Go to **File → Run new task**.
3. Type:
   ```
   reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d explorer.exe /f
   ```
4. Log off and back on. Explorer should return as the default shell.

---

## 🛠 Development
This installer is written in [Inno Setup](https://jrsoftware.org/isinfo.php).  
Key customizations:
- `gamemode.ps1` handles Steam launch, Explorer restore, and logout.
- `gamemode-launcher.vbs` runs PowerShell scripts hidden.
- Inno `[Tasks]` used for optional Start Menu entries.

---

## 🤝 Contributing
Pull requests welcome! Ideas, bug fixes, and improvements are appreciated.  
If you encounter issues, open an [issue](../../issues).

---

## 📜 License
MIT License — feel free to use, modify, and share.
