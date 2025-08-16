; SteamOS Shell - Portable Big Picture Shell (Inno Setup)
; Hidden shell window + restart-aware restore + uninstall shortcut
; Made with love <3

[Setup]
AppId={{A1F4B730-1D0F-4F4E-9593-6E5E8AE2B2B8}}
UninstallDisplayIcon={app}\steamdeck-gaming-return.ico
AppName=SteamOS Shell
AppVersion=1.0.0
AppPublisher=SteamOS Shell Project
AppPublisherURL=https://github.com/LifeDreamer24/SteamOS-Shell
DefaultDirName={userappdata}\SteamOSShell
PrivilegesRequired=lowest
UsedUserAreasWarning=no
DisableProgramGroupPage=no
Compression=lzma
SolidCompression=yes
WizardStyle=modern
SetupIconFile=steamdeck-gaming-return.ico
OutputDir=build
OutputBaseFilename=SteamOS-Shell-Setup
DefaultGroupName=SteamOS Shell

; [Tasks] section REMOVED — we always create Start Menu entries in {group}

[Files]
; Only the icon ships; scripts are created at install time
Source: "steamdeck-gaming-return.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Desktop shortcut that elevates then enables Game Mode
Name: "{userdesktop}\Go to Gamemode"; \
    Filename: "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"; \
    Parameters: "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""{app}\go-gamemode-user.ps1"""; \
    WorkingDir: "{app}"; \
    IconFilename: "{app}\steamdeck-gaming-return.ico"

; Start Menu shortcut (placed automatically in the folder the user selects)
Name: "{group}\Go to Gamemode"; \
    Filename: "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"; \
    Parameters: "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""{app}\go-gamemode-user.ps1"""; \
    WorkingDir: "{app}"; \
    IconFilename: "{app}\steamdeck-gaming-return.ico"

; Start Menu uninstall entry
Name: "{group}\Uninstall SteamOS Shell"; Filename: "{uninstallexe}"

[UninstallRun]
; Ensure Explorer is restored on uninstall (run once)
Filename: "{sys}\reg.exe"; \
    Parameters: "add ""HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"" /v Shell /t REG_SZ /d explorer.exe /f"; \
    Flags: runhidden; \
    RunOnceId: restore_desktop_shell

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Code]
var
  SteamDirPage: TInputDirWizardPage;

function DetectDefaultSteamDir(): string;
begin
  if DirExists(ExpandConstant('{commonpf32}\Steam')) then
    Result := ExpandConstant('{commonpf32}\Steam')
  else if DirExists(ExpandConstant('{commonpf}\Steam')) then
    Result := ExpandConstant('{commonpf}\Steam')
  else
    Result := ExpandConstant('{userappdata}\Steam');
end;

procedure InitializeWizard;
begin
  SteamDirPage := CreateInputDirPage(
    wpSelectDir,
    'Steam Installation Folder',
    'Choose where Steam is installed',
    'Select the folder that contains "steam.exe".'#13#10 +
    'We''ll use it to start Big Picture when Game Mode is enabled.',
    False,
    ''
  );
  SteamDirPage.Add('Steam folder:');
  SteamDirPage.Values[0] := DetectDefaultSteamDir();
end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
  SteamExe: string;
begin
  Result := True;

  if CurPageID = SteamDirPage.ID then
  begin
    SteamExe := AddBackslash(SteamDirPage.Values[0]) + 'steam.exe';
    if not FileExists(SteamExe) then
    begin
      MsgBox(
        'steam.exe not found in:' + #13#10 +
        SteamDirPage.Values[0] + #13#10#13#10 +
        'Please pick the folder that contains steam.exe.',
        mbError, MB_OK
      );
      Result := False;
    end;
  end;
end;

procedure WriteFile(const Path, Contents: string);
begin
  if not SaveStringToFile(Path, Contents, False) then
    MsgBox('Failed to write file: ' + Path, mbError, MB_OK);
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  AppDir, SteamExe, S: string;
begin
  if CurStep = ssPostInstall then
  begin
    AppDir := ExpandConstant('{app}');
    SteamExe := AddBackslash(SteamDirPage.Values[0]) + 'steam.exe';
    WriteFile(AppDir + '\steam_path.txt', SteamExe);

    { gamemode.ps1 - launch Steam Big Picture, wait; handle updater restarts; restore Explorer; then log off }
    S :=
      '$ErrorActionPreference = ''SilentlyContinue'''#13#10 +
      '$Log = Join-Path $PSScriptRoot ''gamemode.log'''#13#10 +
      'function Log($m){ Add-Content -Path $Log -Value (''['' + (Get-Date -Format s) + ''] '' + $m) }'#13#10 +
      ''#13#10 +
      'function Get-SteamExe {'#13#10 +
      ' try { $r = Get-ItemProperty -Path ''HKCU:\Software\Valve\Steam'' -Name SteamPath -ErrorAction SilentlyContinue; if ($r -and $r.SteamPath) { $p = Join-Path $r.SteamPath ''steam.exe''; if (Test-Path $p) { return $p } } } catch {}'#13#10 +
      ' $c = @(''$env:ProgramFiles(x86)\Steam\steam.exe'', ''$env:ProgramFiles\Steam\steam.exe''); foreach($x in $c){ if(Test-Path $x){ return $x } }'#13#10 +
      ' $t = Join-Path $PSScriptRoot ''steam_path.txt''; if(Test-Path $t){ $v = (Get-Content $t -Raw).Trim(); if(Test-Path $v){ return $v } }'#13#10 +
      ' return $null }'#13#10 +
      ''#13#10 +
      'try {'#13#10 +
      ' Remove-Item $Log -ErrorAction SilentlyContinue'#13#10 +
      ' Log ''Shell started (PS hidden)'''#13#10 +
      ' $steamPath = Get-SteamExe'#13#10 +
      ' if (-not $steamPath) { Log ''Steam not found; starting Explorer''; Start-Process explorer.exe; exit 1 }'#13#10 +
      ' $steamDir = Split-Path $steamPath -Parent'#13#10 +
      ' $args = ''-gamepadui'''#13#10 +
      ' Log (''Launching: '' + $steamPath + '' '' + $args)'#13#10 +
      ' $p = Start-Process -FilePath $steamPath -WorkingDirectory $steamDir -ArgumentList $args -PassThru'#13#10 +
      ' try { Wait-Process -Id $p.Id } catch { Log (''Wait-Process error: '' + $_.Exception.Message) }'#13#10 +
      ''#13#10 +
      ' # Quiet window to handle updater restarts'#13#10 +
      ' $quietSeconds = 10'#13#10 +
      ' do {'#13#10 +
      ' $restarted = $false'#13#10 +
      ' for ($i = 0; $i -lt $quietSeconds; $i++) {'#13#10 +
      ' Start-Sleep -Seconds 1'#13#10 +
      ' if (Get-Process -Name ''steam'',''steamwebhelper'' -ErrorAction SilentlyContinue) {'#13#10 +
      ' Log ''Steam restarted during quiet window; waiting to exit again'''#13#10 +
      ' while (Get-Process -Name ''steam'' -ErrorAction SilentlyContinue) { Start-Sleep 2 }'#13#10 +
      ' $restarted = $true; break'#13#10 +
      ' }'#13#10 +
      ' }'#13#10 +
      ' } while ($restarted)'#13#10 +
      ''#13#10 +
      ' Log ''Quiet window (10s) complete; restoring Explorer shell and logging off'''#13#10 +
      ' Set-ItemProperty -Path ''HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon'' -Name Shell -Value ''explorer.exe'' -Force'#13#10 +
      ' Start-Sleep -Seconds 2'#13#10 +
      ' Start-Process explorer.exe'#13#10 +
      ' Start-Sleep -Seconds 3'#13#10 +
      ' & "$env:WINDIR\System32\shutdown.exe" /l'#13#10 +
      ' & "$env:WINDIR\System32\shutdown.exe" /l'#13#10 +
      '} catch { Log (''FATAL: '' + $_.Exception.Message); Start-Process explorer.exe }'#13#10;
    WriteFile(AppDir + '\gamemode.ps1', S);

    { gamemode-launcher.vbs - run PowerShell hidden to execute gamemode.ps1 }
    S :=
      'Set oShell = CreateObject("WScript.Shell")'#13#10 +
      'cmd = "%SystemRoot%\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File """" &'#13#10 +
      ' Replace(WScript.ScriptFullName, "gamemode-launcher.vbs", "gamemode.ps1") & """""'#13#10 +
      'oShell.Run cmd, 0, False'#13#10;
    WriteFile(AppDir + '\gamemode-launcher.vbs', S);

    { go-gamemode-user.ps1 - set HKCU shell to PowerShell launching gamemode.ps1, then log off }
    S :=
      '$shell = "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""$env:APPDATA\\SteamOSShell\\gamemode.ps1"""'#13#10 +
      'Set-ItemProperty -Path ''HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon'' -Name Shell -Value $shell -Force'#13#10 +
      'Start-Sleep -Milliseconds 800'#13#10 +
      '& "$env:WINDIR\System32\shutdown.exe" /l'#13#10;
    WriteFile(AppDir + '\go-gamemode-user.ps1', S);

    { go-gamemode-admin.ps1 - elevation wrapper that the desktop shortcut launches }
    S :=
      '$sid = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value'#13#10 +
      'Start-Process -FilePath (Join-Path $PSScriptRoot ''go-gamemode.cmd'') -Verb RunAs -ArgumentList $sid'#13#10;
    WriteFile(AppDir + '\go-gamemode-admin.ps1', S);
  end;
end;


procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpReady then
  begin
    try
      // Append the chosen Steam folder to the Ready To Install memo
      if WizardForm.ReadyMemo <> nil then
      begin
        // Avoid duplicating if user navigates back and forth
        if Pos('Steam folder:', WizardForm.ReadyMemo.Lines.Text) = 0 then
        begin
          WizardForm.ReadyMemo.Lines.Add('');
          WizardForm.ReadyMemo.Lines.Add('Steam folder:');
          WizardForm.ReadyMemo.Lines.Add(SteamDirPage.Values[0]);
        end;
      end;
    except
    end;
  end;
end;

