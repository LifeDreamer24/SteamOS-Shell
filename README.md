![Windows 10+](https://img.shields.io/badge/platform-Windows%2010%2B-blue)  
![Steam Shell](https://img.shields.io/badge/Steam-GamepadUI-lightgrey)  
![Installer](https://img.shields.io/badge/setup-EXE--based-yellow)

# SteamOS Shell for Windows

A tiny installer that flips your Windows shell to **Steam Big Picture** for a console‑like experience — and flips you back to the desktop when you choose. Built with Inno Setup.

> Perfect for living‑room PCs or a dedicated “Steam console” feel on Windows.

---

## ✨ Features

- **Steam as the Windows shell** — boots straight into Steam Big Picture.
- **Clean session exit** — when Steam closes, the user session **logs out** automatically (≈10 seconds) instead of restoring Explorer.
- **Start Menu integration** — a Start Menu folder is created automatically (no checkbox).  
- **Ready page shows your Steam folder** — the installer’s _Ready to Install_ page displays the Steam path you chose.
- **Uninstallable from Settings** — appears in **Settings → Apps → Installed apps** and in the Start Menu folder.

---

## 🧰 Requirements

- Windows 10/11 (64‑bit tested)
- Steam installed
- Administrator rights during install (required to set the shell and write program files)

---

## 🚀 Install

1. Run the installer.
2. Choose your **Steam folder** (the path is shown on the “Ready to Install” page).
3. Click **Install**.
4. Sign out/in if prompted, or reboot to start directly in Steam Big Picture.

> The Start Menu folder is created automatically. You don’t need to tick any option.

---

## 🧭 How it works

- The installer sets the Windows **shell** to launch Steam Big Picture instead of `explorer.exe`.
- Helper scripts are installed to `AppData\Roaming\SteamOSShell` (e.g., `gamemode-launcher.vbs`, `go-gamemode.cmd`, `go-desktop.cmd`).
- When Steam exits, a small supervisor logs out the user after ~**10 seconds**. This keeps the “console mode” clean and avoids returning to Explorer.

---

## ↩️ Going back to Desktop (temporarily)

If you need a normal desktop session:

- Use the provided **“Go to Desktop”** helper (if exposed in your Start Menu folder), **or**
- Press **Ctrl+Alt+Del → Sign out**, then sign back in to a desktop account where Explorer is still the default shell, **or**
- Manually run `explorer.exe` from **Task Manager → Run new task** (temporary; next login will still boot to Steam unless you uninstall or reset the shell).

---

## 🗑️ Uninstall

- **Settings → Apps → Installed apps → SteamOS Shell → Uninstall**  
  (Also available from the **Start Menu → SteamOS Shell** folder.)

Uninstall restores the default **Explorer** shell on next sign‑in.

---

## 🛠️ Build from source

1. Install **[Inno Setup 6.x](https://jrsoftware.org/isinfo.php)**.
2. Open `SteamOS-Shell.iss` and compile.
3. The script includes:
   - A `CurPageChanged(wpReady)` handler that appends the chosen **Steam folder** to the Ready page memo.
   - Automatic Start Menu folder creation (no user checkbox).
   - Logout‑on‑exit flow (fixed delay ~10s).

> If you customize the delay or behavior, search for the logout/supervisor section and adjust the constant value accordingly.

---

## 🧩 Troubleshooting

**Installer says it “failed to write” files under AppData**  
Make sure you’re installing as the intended user and have permission for `%AppData%\SteamOSShell`. Close Steam before installing.

**Steam closes and I’m stuck / no desktop appears**  
This is by design: the session logs out after ~10s. If you need to keep the desktop, restore Explorer as the shell (uninstall) or adjust the delay in the script.

**Ready page doesn’t show my Steam folder**  
Use the latest script — it adds the Steam folder line during `wpReady`. If you forked, ensure the `CurPageChanged` handler isn’t duplicated.

**PrivilegesRequired warning during compile**  
The script uses per‑user locations but requires admin for shell changes; this is expected. Keep admin install mode enabled.

---

## 📦 Project layout (installed)

```
%AppData%\SteamOSShell\
 ├─ gamemode-launcher.vbs
 ├─ go-gamemode.cmd
 └─ go-desktop.cmd
```

---

## 🤝 Contributing

Issues and PRs welcome! Please describe your Windows version, Steam build, and attach logs/screens when reporting bugs.

---

## 📜 License

MIT License — feel free to use, modify, and share.
