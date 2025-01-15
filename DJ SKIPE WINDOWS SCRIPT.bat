
@echo off

:MainMenu
cls
echo:
echo:
echo:       ______________________________________________________________
echo:
echo:                 DJ SKIPE WINDOWS SCRIPT v1.0
echo:
echo          Questo script ti permette di eseguire il debloater 
echo          di Windows in facilita' direttamente da questo CMD.
echo          Inoltre ti permette di attivare sia Windows che Office.
echo          Apre inoltre le pagine di download per i software base.
echo:
echo:
echo:             [1] Esegui Debloater Windows 11
echo:             [2] Installa Software Custom Edition by dj skipe
echo:             [3] Installa Software Base 
echo:             [4] Scarica e Avvia Office Tool Plus
echo:             [5] Attiva Windows e Office
echo:             [0] Esci
echo:       ______________________________________________________________
echo:
set /p choice="      Scegli un'opzione dal menu [1-5,0]: "

if "%choice%"=="1" goto :RunDebloater
if "%choice%"=="2" goto :InstallBaseSoftwareCustomEdition
if "%choice%"=="3" goto :InstallBase
if "%choice%"=="4" goto :RunOfficeToolPlus
if "%choice%"=="5" goto :ActivateWindows
if "%choice%"=="0" goto :Exit
goto :MainMenu

:RunDebloater
echo Avvio del debloater di Windows 11...
powershell -NoProfile -Command "& ([scriptblock]::Create((irm 'https://win11debloat.raphi.re/')))"
pause
goto :MainMenu

:InstallBaseSoftwareCustomEdition
echo Installazione del software base in corso...
start microsoft-edge:https://ninite.com/7zip-brave-discord-handbrake-notepadplusplus-operaChromium-python3-steam-teamviewer15-vlc-vscode/
echo Download e installazione di Tixati in corso...
curl -L -o "%USERPROFILE%\Downloads\tixati-3.32-1.win64-install.exe" "https://download.tixati.com/tixati-3.32-1.win64-install.exe" && "%USERPROFILE%\Downloads\tixati-3.32-1.win64-install.exe" /S
echo Scarico Telegram, WhatsApp e WeChat dal Microsoft Store...
powershell -NoProfile -Command "winget install -e --id Telegram.TelegramDesktop"
echo Download e installazione di WhatsApp in corso...
curl -L -o "%USERPROFILE%\Downloads\WhatsApp Installer.exe" "https://get.microsoft.com/installer/download/9NKSQGP7F2NH?cid=website_cta_psi/"
if exist "%USERPROFILE%\Downloads\WhatsApp Installer.exe" (
    start "" "%USERPROFILE%\Downloads\WhatsApp Installer.exe"
) else (
    echo Installazione in corso.
)
powershell -NoProfile -Command "winget install -e --id Tencent.WeChat"
echo Installazione di System Informer in corso...
powershell -NoProfile -Command "winget install --id=WinsiderSS.SystemInformer -e"

echo Download completati.
echo.
echo Software base installato.
echo Installazione del Software Custom Edition by dj skipe.
echo Fine.
pause
goto :MainMenu

:InstallBaseSoftware
echo Installazione del software base in corso...
start  microsoft-edge:https://ninite.com/7zip-brave-foxit-libreoffice-vlc/
echo.
echo Software base installato.
pause
goto :MainMenu


:RunOfficeToolPlus
echo Scarico e avvio Office Tool Plus...
powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://otp.landian.vip/redirect/download.php?type=runtime&arch=x64&site=github' -OutFile '%UserProfile%\Downloads\officetoolplus_x64.zip'"
powershell -NoProfile -Command "Expand-Archive -Path '%UserProfile%\Downloads\officetoolplus_x64.zip' -DestinationPath '%UserProfile%\Downloads\officetoolplus_x64.zip' -Force"
start "" "%UserProfile%\Downloads\officetoolplus_x64\office tool\office tool plus.exe"
pause
goto :MainMenu


:ActivateWindows
echo Attivazione di Windows in corso...
powershell -Command "Start-Process powershell -ArgumentList '-NoProfile -Command irm https://get.activated.win | iex; echo 1 | Out-Host' -Verb RunAs"
pause
goto :MainMenu

:Exit
echo Uscita dal programma...
pause
exit
