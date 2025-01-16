
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
echo:             [6] Scarica Microsoft Office
echo:             [0] Esci
echo:       ______________________________________________________________
echo:
set /p choice="      Scegli un'opzione dal menu [1-5,0]: "

if "%choice%"=="1" goto :RunDebloater
if "%choice%"=="2" goto :InstallBaseSoftwareCustomEdition
if "%choice%"=="3" goto :InstallBase
if "%choice%"=="4" goto :RunOfficeToolPlus
if "%choice%"=="5" goto :ActivateWindows
if "%choice%"=="6" goto :DownOffice
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


:DownOffice
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA VERSIONE DI OFFICE DA SCARICARE
echo:
echo:             [1] Office 365
echo:             [2] Office 2024
echo:             [3] Office 2021
echo:             [4] Office 2019
echo:             [5] Office 2016
echo:             [6] Office 2013
echo:             [0] Torna al menu principale
echo:       ______________________________________________________________
echo:
set /p officeChoice="      Scegli una versione di Office [1-6,0]: "

if "%officeChoice%"=="1" goto :Office365
if "%officeChoice%"=="2" goto :Office2024
if "%officeChoice%"=="3" goto :Office2021
if "%officeChoice%"=="4" goto :Office2019
if "%officeChoice%"=="5" goto :Office2016
if "%officeChoice%"=="6" goto :Office2013
if "%officeChoice%"=="0" goto :MainMenu
goto :DownOffice

:Office365
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI OFFICE 365
echo:
echo:             [1] Pro Plus
echo:             [2] Business
echo:             [3] Education
echo:             [4] Home
echo:             [5] Small Business
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Office 365 [1-5,0]: "

if "%editionChoice%"=="1" start microsoft-edge:https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=it-it&version=O16GA
if "%editionChoice%"=="2" start microsoft-edge:https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365BusinessRetail&platform=x64&language=it-it&version=O16GA
if "%editionChoice%"=="3" start microsoft-edge:https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365EduCloudRetail&platform=x64&language=it-it&version=O16GA
if "%editionChoice%"=="4" start microsoft-edge:https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365HomePremRetail&platform=x64&language=it-it&version=O16GA
if "%editionChoice%"=="5" start microsoft-edge:https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365SmallBusPremRetail&platform=x64&language=it-it&version=O16GA
if "%editionChoice%"=="0" goto :DownOffice
goto :Office365

:Office2024
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI OFFICE 2024
echo:
echo:             [1] Standard
echo:             [2] Professional
echo:             [3] Home and Student
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Office 2024 [1-3,0]: "

if "%editionChoice%"=="1" start microsoft-edge:https://example.com/office2024-standard
if "%editionChoice%"=="2" start microsoft-edge:https://example.com/office2024-professional
if "%editionChoice%"=="3" start microsoft-edge:https://example.com/office2024-home-student
if "%editionChoice%"=="0" goto :DownOffice
goto :Office2024

:Office2021
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI OFFICE 2021
echo:
echo:             [1] Standard
echo:             [2] Professional
echo:             [3] Home and Student
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Office 2021 [1-3,0]: "

if "%editionChoice%"=="1" start microsoft-edge:https://example.com/office2021-standard
if "%editionChoice%"=="2" start microsoft-edge:https://example.com/office2021-professional
if "%editionChoice%"=="3" start microsoft-edge:https://example.com/office2021-home-student
if "%editionChoice%"=="0" goto :DownOffice
goto :Office2021

:Office2019
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI OFFICE 2019
echo:
echo:             [1] Standard
echo:             [2] Professional
echo:             [3] Home and Student
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Office 2019 [1-3,0]: "

if "%editionChoice%"=="1" start microsoft-edge:https://example.com/office2019-standard
if "%editionChoice%"=="2" start microsoft-edge:https://example.com/office2019-professional
if "%editionChoice%"=="3" start microsoft-edge:https://example.com/office2019-home-student
if "%editionChoice%"=="0" goto :DownOffice
goto :Office2019

:Office2016
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI OFFICE 2016
echo:
echo:             [1] Standard
echo:             [2] Professional
echo:             [3] Home and Student
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Office 2016 [1-3,0]: "

if "%editionChoice%"=="1" start microsoft-edge:https://example.com/office2016-standard
if "%editionChoice%"=="2" start microsoft-edge:https://example.com/office2016-professional
if "%editionChoice%"=="3" start microsoft-edge:https://example.com/office2016-home-student
if "%editionChoice%"=="0" goto :DownOffice
goto :Office2016

:Office2013
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI OFFICE 2013
echo:
echo:             [1] Standard
echo:             [2] Professional
echo:             [3] Home and Student
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Office 2013 [1-3,0]: "

if "%editionChoice%"=="1" start microsoft-edge:https://example.com/office2013-standard
if "%editionChoice%"=="2" start microsoft-edge:https://example.com/office2013-professional
if "%editionChoice%"=="3" start microsoft-edge:https://example.com/office2013-home-student
if "%editionChoice%"=="0" goto :DownOffice
goto:Office2016

:Exit
echo Uscita dal programma...
pause
exit
