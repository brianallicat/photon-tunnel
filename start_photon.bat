@echo off
echo Restarting Photon Tunnel...
taskkill /f /im node.exe >nul 2>&1
taskkill /f /im ngrok.exe >nul 2>&1
timeout /t 2 >nul
start "Photon Server" cmd /k "cd /d C:\Users\allison\Downloads && node photon_app.js"
timeout /t 3 >nul
start "Photon ngrok" cmd /k "cd /d C:\Users\allison\Downloads && ngrok.exe http --url=photontunnel.ngrok.app 7432"
timeout /t 3 >nul
start chrome http://localhost:7432
