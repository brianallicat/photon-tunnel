@echo off
title Photon Tunnel Installer
color 0A
echo.
echo  ==========================================
echo   PHOTON TUNNEL - One Click Installer
echo  ==========================================
echo.
set IDIR=%USERPROFILE%\Downloads\PhotonTunnel
if not exist "%IDIR%" mkdir "%IDIR%"
echo [1/4] Folder: %IDIR%
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [2/4] Installing Node.js...
    curl -L -o "%TEMP%\node.msi" "https://nodejs.org/dist/v22.12.0/node-v22.12.0-x64.msi"
    msiexec /i "%TEMP%\node.msi" /qn /norestart
) else (
    echo [2/4] Node.js OK
)
echo [3/4] Downloading Photon Tunnel...
curl -L -o "%IDIR%\photon_app.js" "https://raw.githubusercontent.com/brianallicat/photon-tunnel/main/photon_app.js"
curl -L -o "%IDIR%\photon_tunnel.ico" "https://raw.githubusercontent.com/brianallicat/photon-tunnel/main/photon_tunnel.ico"
echo [4/4] Creating desktop shortcut...
set STARTUP=%IDIR%\start.bat
(echo @echo off&echo taskkill /f /im node.exe ^>nul 2^>^&1&echo timeout /t 2 ^>nul&echo start "Photon" cmd /k "cd /d %IDIR% ^&^& node photon_app.js"&echo timeout /t 3 ^>nul&echo start chrome http://localhost:7432) > "%STARTUP%"
set DESK=%USERPROFILE%\OneDrive\Desktop
if not exist "%DESK%" set DESK=%USERPROFILE%\Desktop
powershell -command "$ws=New-Object -ComObject WScript.Shell;$s=$ws.CreateShortcut('%DESK%\Photon Tunnel.lnk');$s.TargetPath='%STARTUP%';$s.IconLocation='%IDIR%\photon_tunnel.ico,0';$s.WorkingDirectory='%IDIR%';$s.Save()"
echo.
echo  DONE! Photon Tunnel icon is on your desktop!
echo  Double-click it to start!
echo.
timeout /t 3 >nul
start "" "%STARTUP%"
