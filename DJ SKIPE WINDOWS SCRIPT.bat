@echo off
setlocal enabledelayedexpansion

:LanguageSelect
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                 SELECT LANGUAGE / SELEZIONA LINGUA
echo:
echo:             [1] English
echo:             [2] Italiano
echo:       ______________________________________________________________
echo:
set /p langChoice="Choose your language / Scegli la tua lingua [1-2]: "

if "%langChoice%"=="1" (
    set "LANG=EN"
    goto :MainMenu
)
if "%langChoice%"=="2" (
    set "LANG=IT"
    goto :MainMenu
)
goto :LanguageSelect

:MainMenu
cls
echo:
echo:       ______________________________________________________________
echo:
if "%LANG%"=="EN" (
    echo:                 DJ SKIPE WINDOWS SCRIPT v1.3.1
    echo:
    echo          This script allows you to easily run the Windows
    echo          debloater from this CMD. It also allows you to
    echo          activate both Windows and Office, and opens
    echo          download pages for basic software.
    echo:
    echo:
    echo:             [1] Run Windows 11 Debloater
    echo:             [2] Install Custom Edition Software by dj skipe
    echo:             [3] Install Base Software
    echo:             [4] Download and Run Office Tool Plus
    echo:             [5] Windows and Office Activation
    echo:             [6] Download Microsoft Office
    echo:             [7] Download Microsoft Windows
    echo:             [8] Extra
    echo:             [9] Change Language
    echo:             [0] Exit
) else (
    echo:                 DJ SKIPE WINDOWS SCRIPT v1.3
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
    echo:             [5] Attivazione Windows e Office
    echo:             [6] Scarica Microsoft Office
    echo:             [7] Scarica Microsoft Windows
    echo:             [8] Extra
    echo:             [9] Cambia Lingua
    echo:             [0] Esci
)
echo:       ______________________________________________________________
echo:

if "%LANG%"=="EN" (
    set /p choice="      Choose an option from the menu [1-9,0]: "
) else (
    set /p choice="      Scegli un'opzione dal menu [1-9,0]: "
)

if "%choice%"=="1" goto :RunDebloater
if "%choice%"=="2" goto :InstallBaseSoftwareCustomEdition
if "%choice%"=="3" goto :InstallBaseSoftware
if "%choice%"=="4" goto :RunOfficeToolPlus
if "%choice%"=="5" goto :ActivateWindows
if "%choice%"=="6" goto :DownOffice
if "%choice%"=="7" goto :DownWindows
if "%choice%"=="8" goto :Extra
if "%choice%"=="9" goto :LanguageSelect
if "%choice%"=="0" goto :Exit
goto :MainMenu

:RunDebloater
if "%LANG%"=="EN" (
    echo Running Windows 11 debloater...
) else (
    echo Avvio del debloater di Windows 11...
)
powershell -NoProfile -Command "& ([scriptblock]::Create((irm 'https://win11debloat.raphi.re/')))"
pause
goto :MainMenu

:InstallBaseSoftwareCustomEdition
if "%LANG%"=="EN" (
    echo Installing PowerShell...
) else (
    echo Installazione di PowerShell in corso...
)
winget install --id Microsoft.PowerShell --source winget --silent --accept-package-agreements --accept-source-agreements
if %errorlevel% neq 0 (
    if "%LANG%"=="EN" (
        echo Error installing PowerShell. Try temporarily disabling firewall or antivirus.
    ) else (
        echo Errore durante l'installazione di PowerShell. Prova a disabilitare temporaneamente il firewall o l'antivirus.
    )
) else (
    if "%LANG%"=="EN" (
        echo PowerShell has been successfully installed.
    ) else (
        echo PowerShell è stato installato con successo.
    )
)

if "%LANG%"=="EN" (
    echo Installing base software...
    echo Downloading and installing Tixati...
    echo Downloading Telegram, WhatsApp and WeChat from Microsoft Store...
    echo Installing System Informer...
    echo Downloads completed.
    echo.
    echo Base software installed.
    echo Installing Custom Edition Software by dj skipe.
    echo Done.
) else (
    echo Installazione del software base in corso...
    echo Download e installazione di Tixati in corso...
    echo Scarico Telegram, WhatsApp e WeChat dal Microsoft Store...
    echo Installazione di System Informer in corso...
    echo Download completati.
    echo.
    echo Software base installato.
    echo Installazione del Software Custom Edition by dj skipe.
    echo Fine.
)

start microsoft-edge:https://ninite.com/7zip-brave-discord-handbrake-notepadplusplus-operaChromium-python3-steam-teamviewer15-vlc-vscode/
curl -L -o "%USERPROFILE%\Downloads\tixati-3.32-1.win64-install.exe" "https://download.tixati.com/tixati-3.32-1.win64-install.exe" && "%USERPROFILE%\Downloads\tixati-3.32-1.win64-install.exe" /S
powershell -NoProfile -Command "winget install -e --id Telegram.TelegramDesktop"
curl -L -o "%USERPROFILE%\Downloads\WhatsApp Installer.exe" "https://get.microsoft.com/installer/download/9NKSQGP7F2NH?cid=website_cta_psi/"
if exist "%USERPROFILE%\Downloads\WhatsApp Installer.exe" (
    start "" "%USERPROFILE%\Downloads\WhatsApp Installer.exe"
)
powershell -NoProfile -Command "winget install -e --id Tencent.WeChat"
powershell -NoProfile -Command "winget install --id=WinsiderSS.SystemInformer -e"
pause
goto :MainMenu

:InstallBaseSoftware
if "%LANG%"=="EN" (
    echo Installing base software...
    echo.
    echo Base software installed.
) else (
    echo Installazione del software base in corso...
    echo.
    echo Software base installato.
)
start microsoft-edge:https://ninite.com/7zip-brave-foxit-libreoffice-vlc/
pause
goto :MainMenu

:RunOfficeToolPlus
if "%LANG%"=="EN" (
    echo Downloading and launching Office Tool Plus...
) else (
    echo Scarico e avvio Office Tool Plus...
)
powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://otp.landian.vip/redirect/download.php?type=runtime&arch=x64&site=github' -OutFile '%UserProfile%\Downloads\officetoolplus_x64.zip'"
powershell -NoProfile -Command "Expand-Archive -Path '%UserProfile%\Downloads\officetoolplus_x64.zip' -DestinationPath '%UserProfile%\Downloads\officetoolplus_x64.zip' -Force"
start "" "%UserProfile%\Downloads\officetoolplus_x64\office tool\office tool plus.exe"
pause
goto :MainMenu

:ActivateWindows
if "%LANG%"=="EN" (
    echo Activating Windows...
) else (
    echo Attivazione di Windows in corso...
)
powershell -Command "Start-Process powershell -ArgumentList '-NoProfile -Command irm https://get.activated.win | iex; echo 1 | Out-Host' -Verb RunAs"
pause
goto :MainMenu

:DownOffice
cls
echo:
echo:       ______________________________________________________________
echo:
if "%LANG%"=="EN" (
    echo:                   SELECT OFFICE VERSION TO DOWNLOAD
    echo:
    echo:             [1] Office 365
    echo:             [2] Office 2024
    echo:             [3] Office 2021
    echo:             [4] Office 2019
    echo:             [5] Office 2016
    echo:             [6] Office 2013
    echo:             [7] Single Software
    echo:             [0] Back to main menu
) else (
    echo:                   SELEZIONA VERSIONE DI OFFICE DA SCARICARE
    echo:
    echo:             [1] Office 365
    echo:             [2] Office 2024
    echo:             [3] Office 2021
    echo:             [4] Office 2019
    echo:             [5] Office 2016
    echo:             [6] Office 2013
    echo:             [7] Software Singoli
    echo:             [0] Torna al menu principale
)
echo:       ______________________________________________________________
echo:

if "%LANG%"=="EN" (
    set /p officeChoice="      Choose an Office version [1-7,0]: "
) else (
    set /p officeChoice="      Scegli una versione di Office [1-7,0]: "
)

if "%officeChoice%"=="1" goto :Office365
if "%officeChoice%"=="2" goto :Office2024
if "%officeChoice%"=="3" goto :Office2021
if "%officeChoice%"=="4" goto :Office2019
if "%officeChoice%"=="5" goto :Office2016
if "%officeChoice%"=="6" goto :Office2013
if "%officeChoice%"=="7" goto :SoftwareSingoli
if "%officeChoice%"=="0" goto :MainMenu
goto :DownOffice

:Office365
cls
echo:
echo:       ______________________________________________________________
echo:
if "%LANG%"=="EN" (
    echo:                   SELECT OFFICE 365 EDITION
    echo:
    echo:             [1] Professional Plus
    echo:             [2] Business
    echo:             [3] Education
    echo:             [4] Home
    echo:             [5] Small Business
    echo:             [0] Back to previous menu
) else (
    echo:                   SELEZIONA EDIZIONE DI OFFICE 365
    echo:
    echo:             [1] Professional Plus
    echo:             [2] Business
    echo:             [3] Education
    echo:             [4] Home
    echo:             [5] Small Business
    echo:             [0] Torna al menu precedente
)
echo:       ______________________________________________________________
echo:

if "%LANG%"=="EN" (
    set /p editionChoice="      Choose an Office 365 edition [1-5,0]: "
) else (
    set /p editionChoice="      Scegli un'edizione di Office 365 [1-5,0]: "
)

if "%editionChoice%"=="1" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/O365ProPlusRetail.img"
    goto Office365
)
if "%editionChoice%"=="2" (
    start "" "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365BusinessRetail&platform=x64&language=it-it&version=O16GA"
    goto Office365
)
if "%editionChoice%"=="3" (
    start "" "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365EduCloudRetail&platform=x64&language=it-it&version=O16GA"
    goto Office365
)
if "%editionChoice%"=="4" (
    start "" "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365HomePremRetail&platform=x64&language=it-it&version=O16GA"
    goto Office365
)
if "%editionChoice%"=="5" (
    start "" "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365SmallBusPremRetail&platform=x64&language=it-it&version=O16GA"
    goto Office365
)
if "%editionChoice%"=="0" goto :DownOffice

:Office2024
cls
echo:
echo:       ______________________________________________________________
echo:
if "%LANG%"=="EN" (
    echo:                   SELECT OFFICE 2024 EDITION
    echo:
    echo:             [1] Professional Plus
    echo:             [2] Professional
    echo:             [3] Home
    echo:             [4] Home and Business
    echo:             [0] Back to previous menu
) else (
    echo:                   SELEZIONA EDIZIONE DI OFFICE 2024
    echo:
    echo:             [1] Professional Plus
    echo:             [2] Professional
    echo:             [3] Home
    echo:             [4] Home and Business
    echo:             [0] Torna al menu precedente
)
echo:       ______________________________________________________________
echo:

if "%LANG%"=="EN" (
    set /p editionChoice="      Choose an Office 2024 edition [1-4,0]: "
) else (
    set /p editionChoice="      Scegli un'edizione di Office 2024 [1-4,0]: "
)

if "%editionChoice%"=="1" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/ProPlus2024Retail.img"
    goto Office2024
)
if "%editionChoice%"=="2" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/Professional2024Retail.img"
    goto Office2024
)
if "%editionChoice%"=="3" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/Home2024Retail.img"
    goto Office2024
)
if "%editionChoice%"=="4" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/HomeBusiness2024Retail.img"
    goto Office2024
)
if "%editionChoice%"=="0" goto :DownOffice
goto :Office2024 

:Office2016
cls
echo:
echo:       ______________________________________________________________
echo:
if "%LANG%"=="EN" (
    echo:                   SELECT OFFICE 2016 EDITION
    echo:
    echo:             [1] Professional Plus
    echo:             [2] Professional
    echo:             [3] Home
    echo:             [4] Home and Business
    echo:             [0] Back to previous menu
) else (
    echo:                   SELEZIONA EDIZIONE DI OFFICE 2016
    echo:
    echo:             [1] Professional Plus
    echo:             [2] Professional
    echo:             [3] Home
    echo:             [4] Home and Business
    echo:             [0] Torna al menu precedente
)
echo:       ______________________________________________________________
echo:

if "%LANG%"=="EN" (
    set /p editionChoice="      Choose an Office 2016 edition [1-4,0]: "
) else (
    set /p editionChoice="      Scegli un'edizione di Office 2016 [1-4,0]: "
)

if "%editionChoice%"=="1" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/ProPlus2016Retail.img"
    goto Office2016
)
if "%editionChoice%"=="2" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/Professional2016Retail.img"
    goto Office2016
)
if "%editionChoice%"=="3" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/Home2016Retail.img"
    goto Office2016
)
if "%editionChoice%"=="4" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/HomeBusiness2016Retail.img"
    goto Office2016
)
if "%editionChoice%"=="0" goto :DownOffice
goto :Office2016

:Office2013
cls
echo:
echo:       ______________________________________________________________
echo:
if "%LANG%"=="EN" (
    echo:                   SELECT OFFICE 2013 EDITION
    echo:
    echo:             [1] Professional
    echo:             [2] Home and Student
    echo:             [3] Home and Business
    echo:             [0] Back to previous menu
) else (
    echo:                   SELEZIONA EDIZIONE DI OFFICE 2013
    echo:
    echo:             [1] Professional
    echo:             [2] Home and Student
    echo:             [3] Home and Business
    echo:             [0] Torna al menu precedente
)
echo:       ______________________________________________________________
echo:

if "%LANG%"=="EN" (
    set /p editionChoice="      Choose an Office 2013 edition [1-3,0]: "
) else (
    set /p editionChoice="      Scegli un'edizione di Office 2013 [1-3,0]: "
)

if "%editionChoice%"=="1" (
    start "" "https://officeredir.microsoft.com/r/rlidO15C2RMediaDownload?p1=db&p2=en-US&p3=ProfessionalRetail"
    goto Office2013
)
if "%editionChoice%"=="2" (
    start "" "https://officeredir.microsoft.com/r/rlidO15C2RMediaDownload?p1=db&p2=en-US&p3=HomeStudentRetail"
    goto Office2013
)
if "%editionChoice%"=="3" (
    start "" "https://officeredir.microsoft.com/r/rlidO15C2RMediaDownload?p1=db&p2=en-US&p3=HomeBusinessRetail"
    goto Office2013
)
if "%editionChoice%"=="0" goto :DownOffice
goto :Office2013

:SoftwareSingoli
cls
echo:
echo:       ______________________________________________________________
echo:
if "%LANG%"=="EN" (
    echo:                 SELECT OFFICE SOFTWARE TO DOWNLOAD
    echo:                             (only 2024)
    echo:
    echo:             [1] Word
    echo:             [2] Powerpoint
    echo:             [3] Excel
    echo:             [4] Outlook
    echo:             [5] Access
    echo:             [0] Back to previous menu
) else (
    echo:                 SELEZIONA SOFTWARE DI OFFICE DA SCARICARE
    echo:                             (solo 2024)
    echo:
    echo:             [1] Word
    echo:             [2] Powerpoint
    echo:             [3] Excel
    echo:             [4] Outlook
    echo:             [5] Access
    echo:             [0] Torna al menu precedente
)
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un software di Office [1-5,0]: "

if "%editionChoice%"=="1" (
    start "" "http://officecdn.microsoft.com.edgesuite.net/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-it/Word2024Retail.img"
    goto SoftwareSingoli
)
if "%editionChoice%"=="2" (
    start "" "http://officecdn.microsoft.com.edgesuite.net/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-it/PowerPoint2024Retail.img"
    goto SoftwareSingoli
)
if "%editionChoice%"=="3" (
    start "" "http://officecdn.microsoft.com.edgesuite.net/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-it/Excel2024Retail.img"
    goto SoftwareSingoli
)
if "%editionChoice%"=="4" (
    start "" "http://officecdn.microsoft.com.edgesuite.net/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-it/Outlook2024Retail.img"
    goto SoftwareSingoli
)
if "%editionChoice%"=="5" (
    start "" "http://officecdn.microsoft.com.edgesuite.net/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-it/Access2024Retail.img"
    goto SoftwareSingoli
)
if "%editionChoice%"=="0" goto :DownOffice
goto :SoftwareSingoli

:DownWindows
cls
echo:
echo:       ______________________________________________________________
if "%LANG%"=="EN" (
    echo:                   SELECT WINDOWS VERSION TO DOWNLOAD
    echo:
    echo:             [1] Windows 11
    echo:             [2] Windows 10
    echo:             [3] Windows 8.1
    echo:             [4] Windows 7
    echo:             [5] Windows XP
    echo:             [6] Windows Server 
    echo:             [0] Back to main menu
) else (
    echo:                   SELEZIONA VERSIONE DI WINDOWS DA SCARICARE
    echo:
    echo:             [1] Windows 11
    echo:             [2] Windows 10
    echo:             [3] Windows 8.1
    echo:             [4] Windows 7
    echo:             [5] Windows XP
    echo:             [6] Windows Server 
    echo:             [0] Torna al menu principale
)
echo:       ______________________________________________________________
echo:

if "%LANG%"=="EN" (
    set /p winChoice="      Choose a Windows version [1-6,0]: "
) else (
    set /p winChoice="      Scegli una versione di Windows [1-6,0]: "
)

if "%winChoice%"=="1" (
    cls
    echo: Downloading Windows 11...
    start "" "https://software.download.prss.microsoft.com/dbazure/Win11_24H2_Italian_x64.iso?t=52b88a14-2732-4489-ac54-8233f950f32f&P1=1737205836&P2=601&P3=2&P4=3G48wwJiMPyfr45ItnbBLuIuYHCjimXpWUyGImBRWVNVjiKqSBj4vaKQDI6LKRRrZQHSNc91WLQWkQ0jT8ZXm30SsHmiOL%2fM2IlpfW7z7WmJLyj43sh8fYQ2z%2fAUIBu68Q02UD2MyC343agQjnC7VDlqhkLxo0oCmcI%2foRl7UHQFnX2XB1aSpg19skHkIjnhlSo6YLzgWYMrQD5wvAM%2bP36%2fWoC0XYaI3V1%2bgEgnhrGXxxFW3LYxNMTvcop%2b3efhftI7o6aiQnzqik74DXt%2bbaSSg1FQSFXeE0f%2bdvxJrIsB1g3fcTb87BiuNFSGO7q3oHiXJGVp33VTlKVQ199npg%3d%3d"
    goto :DownWindows
)

if "%winChoice%"=="2" (
    cls
    echo: Downloading Windows 10...
    start "" "https://delivery.activated.win/47c62492-92f1-49ef-8740-62989154e590/it-it_windows_10_consumer_editions_version_22h2_updated_nov_2024_x86_dvd_3eeacab9.iso?t=ac967221-29d9-4d79-9d04-282aaab25502&P1=1737141282&P2=601&P3=2&P4=7tvlhF7XjJMA0%2B45bPZYN8SASWzXxo8cO3l%2FUMVMQKs%3D"
    goto :DownWindows
)

if "%winChoice%"=="3" (
    cls
    echo: Downloading Windows 8.1...
    start "" "https://software.download.prss.microsoft.com/dbazure/Win8.1_Italian_x64.iso?t=411b2b32-613a-490d-b5b4-960f793af0ed&P1=1737206229&P2=601&P3=2&P4=Maq8BzXR%2bhX%2f3051IIFG5Xex6B9SOOSZPf7Bhohg3E3KDtEx3tQGYTbysn2D%2b9Hjw29L82ner2JVgGVjMdnQmfptORF4FgAIMANq%2f2nbviLbppbtRVyuaEiya7hM72pr6g1Ca8K%2fXckJGHm7uMuV9ijdjTjf%2fE%2faiTHz5aF8delbxesYS%2fhv6IgpwAm5%2b1PTPgKoCxiRetka1aiYRlSdKZFJ2xaFQvu4ILZuWwYNLhGc96TiVJ30nHrfVSOsL5c3H8HcSIhyNtvhgGoAa4%2flbctMKZBLyOwl%2bweilsFN9ILHmc7uOCZ3zppau6R75PNCwZx1Zt3COhdhyoNvNP2Aew%3d%3d"
    goto :DownWindows
)

if "%winChoice%"=="4" goto :Win7
if "%winChoice%"=="5" goto :WinXP
if "%winChoice%"=="6" goto :WinServer
if "%winChoice%"=="0" goto :MainMenu
goto :DownWindows

:Win7
cls
echo:
echo:       ______________________________________________________________
if "%LANG%"=="EN" (
    echo:                   SELECT WINDOWS 7 EDITION
) else (
    echo:                   SELEZIONA EDIZIONE DI WINDOWS 7
)
echo:
echo:             [1] Professional
echo:             [2] Enterprise
echo:             [3] Ultimate
echo:             [4] Home Premium
echo:             [5] All in One Version 32/64 bit
echo:             [0] Back to previous menu
echo:       ______________________________________________________________
echo:

if "%LANG%"=="EN" (
    set /p editionChoice="      Choose a Windows 7 edition [1-5,0]: "
) else (
    set /p editionChoice="      Scegli un'edizione di Windows 7 [1-5,0]: "
)

if "%editionChoice%"=="1" goto :Win7Pro
if "%editionChoice%"=="2" goto :Win7Enterprise
if "%editionChoice%"=="3" goto :Win7Ultimate
if "%editionChoice%"=="4" goto :Win7HomePremium
if "%editionChoice%"=="5" (
    start "" "https://archive.org/download/win-7-aio-32x-64x/Win7AIO32x64x.iso"
    goto Win7
)
if "%editionChoice%"=="0" goto :DownWindows
goto Win7

:Win7Pro
cls
echo:
echo:       ______________________________________________________________
if "%LANG%"=="EN" (
    echo:                   SELECT WINDOWS 7 PROFESSIONAL EDITION
) else (
    echo:                   SELEZIONA EDIZIONE WINDOWS 7 PROFESSIONAL
)
echo:
echo:             [1] Windows 7 Professional x64
echo:             [2] Windows 7 Professional x86
if "%LANG%"=="EN" (
    echo          [0] Back to previous menu
) else (
    echo          [0] Torna al menu precedente
)

echo:

if "%LANG%"=="EN" (
    set /p archChoice="      Choose architecture [1-2,0]: "
) else (
    set /p archChoice="      Scegli architettura [1-2,0]: "
)

if "%archChoice%"=="1" (
    start "" "https://archive.org/download/win-7-pro-sp1-italian/Win7_Pro_SP1_Italian_x64.iso"
    goto Win7Pro
)
if "%archChoice%"=="2" (
    start "" "https://archive.org/download/win-7-pro-sp1-italian/Win7_Pro_SP1_Italian_x86.iso"
    goto Win7Pro
)
if "%archChoice%"=="0" goto Win7
goto Win7Pro

:Win7Enterprise
cls
echo:
echo:       ______________________________________________________________
if "%LANG%"=="EN" (
    echo:                   SELECT WINDOWS 7 ENTERPRISE EDITION
) else (
    echo:                   SELEZIONA EDIZIONE WINDOWS 7 ENTERPRISE
)
echo:
echo:             [1] Windows 7 Enterprise x64
echo:             [2] Windows 7 Enterprise x86
if "%LANG%"=="EN" (
echo              [0] Back to previous menu
) else (
echo              [0] Torna al menu precedente
)

echo:

if "%LANG%"=="EN" (
    set /p archChoice="      Choose architecture [1-2,0]: "
) else (
    set /p archChoice="      Scegli architettura [1-2,0]: "
)

if "%archChoice%"=="1" (
    start "" "https://archive.org/download/Win7EnterpriseSP1x64ITA/it_windows_7_enterprise_with_sp1_x64_dvd_u_677660.iso"
    goto Win7Enterprise
)
if "%archChoice%"=="2" (
    start "" "https://archive.org/download/Win7EnterpriseSP1x86ITA/it_windows_7_enterprise_with_sp1_x86_dvd_u_677749.iso"
    goto Win7Enterprise
)
if "%archChoice%"=="0" goto Win7
goto Win7Enterprise

:Win7Ultimate
cls
echo:
echo:       ______________________________________________________________
if "%LANG%"=="EN" (
    echo:                   SELECT WINDOWS 7 ULTIMATE EDITION
) else (
    echo:                   SELEZIONA EDIZIONE WINDOWS 7 ULTIMATE
)
echo:
echo:             [1] Windows 7 Ultimate x64
echo:             [2] Windows 7 Ultimate x86
if "%LANG%"=="EN" (
echo              [0] Back to previous menu
) else (
echo              [0] Torna al menu precedente
)


echo:

if "%LANG%"=="EN" (
    set /p archChoice="      Choose architecture [1-2,0]: "
) else (
    set /p archChoice="      Scegli architettura [1-2,0]: "
)

if "%archChoice%"=="1" (
    start "" "https://archive.org/download/cover_20230817/it_windows_7_ultimate_with_sp1_x64_dvd_u_677356.iso"
    goto Win7Ultimate
)
if "%archChoice%"=="2" (
    start "" "https://archive.org/download/cover_20230817/it_windows_7_ultimate_with_sp1_x86_dvd_u_677443.iso"
    goto Win7Ultimate
)
if "%archChoice%"=="0" goto Win7
goto Win7Ultimate

:Win7HomePremium
cls
echo:
echo:       ______________________________________________________________
if "%LANG%"=="EN" (
    echo:                   SELECT WINDOWS 7 HOME PREMIUM EDITION
) else (
    echo:                   SELEZIONA EDIZIONE WINDOWS 7 HOME PREMIUM
)
echo:
echo:             [1] Windows 7 Home Premium x64
echo:             [2] Windows 7 Home Premium x86
if "%LANG%"=="EN" (
echo              [0] Back to previous menu
) else (
echo              [0] Torna al menu precedente
)

echo:

if "%LANG%"=="EN" (
    set /p archChoice="      Choose architecture [1-2,0]: "
) else (
    set /p archChoice="      Scegli architettura [1-2,0]: "
)

if "%archChoice%"=="1" (
    start "" "https://archive.org/download/win-7-italian-home-premium/Win7_HomePrem_SP1_Italian_x64.iso"
    goto Win7HomePremium
)
if "%archChoice%"=="2" (
    start "" "https://archive.org/download/win-7-italian-home-premium/Win7_HomePrem_SP1_Italian_x86.iso"
    goto Win7HomePremium
)
if "%archChoice%"=="0" goto Win7
goto Win7HomePremium

:WinXP
cls
echo:
echo:       ______________________________________________________________
if "%LANG%"=="EN" (
    echo:                   SELECT WINDOWS XP EDITION
) else (
    echo:                   SELEZIONA EDIZIONE DI WINDOWS XP
)
echo:
echo:             [1] Professional
echo:             [2] Home 
echo:             [3] Media Center
if "%LANG%"=="EN" (
echo              [0] Back to previous menu
) else (
echo              [0] Torna al menu precedente
)

echo:

if "%LANG%"=="EN" (
    set /p editionChoice="      Choose a Windows XP edition [1-3,0]: "
) else (
    set /p editionChoice="      Scegli un'edizione di Windows XP [1-3,0]: "
)

if "%editionChoice%"=="1" goto :WinXPProSP3
if "%editionChoice%"=="2" (
    start "" "https://archive.org/download/microsoft-windows-xp-italiano-raccolta-di-mrgass/%5BISO%5D%20CD%20di%20Installazione/Microsoft%20Windows%20XP%20Home/Microsoft%20Windows%20XP%20Home%20Edition%20Service%20Pack%203%20Retail%202600.5512.xpsp.080413-2111/it_windows_xp_home_with_service_pack_3_x86_cd_x14-92420.iso"
    goto WinXP
)
if "%editionChoice%"=="3" (
    start "" "https://archive.org/download/WinXPMCE2005SP3ITA/Windows_XP_Media_Center_Edition_2005_Sp3_ITA_by_Condor.07.iso"
    goto WinXP
)
if "%editionChoice%"=="0" goto :DownWindows
goto :WinXP

:WinXPProSP3
cls
echo:
echo:       ______________________________________________________________
if "%LANG%"=="EN" (
    echo:                   SELECT WINDOWS XP PROFESSIONAL SP3 ARCHITECTURE
) else (
    echo:                   SELEZIONA ARCHITETTURA WINDOWS XP PROFESSIONAL SP3
)
echo:
echo:             [1] Windows XP Professional SP3 32-bit
echo:             [2] Windows XP Professional SP2 64-bit (English only)
if "%LANG%"=="EN"
echo              [0] Back to previous menu
) else (
echo              [0] Torna al menu precedente
)

echo:

if "%LANG%"=="EN" (
    set /p archChoice="      Choose architecture [1-2,0]: "
) else (
    set /p archChoice="      Scegli architettura [1-2,0]: "
)

if "%archChoice%"=="1" (
    start "" "https://archive.org/download/xppro32retailita/it_windows_xp_professional_with_service_pack_3_x86_cd_x14-80460.iso"
    goto WinXPProSP3
)
if "%archChoice%"=="2" (
    start "" "https://archive.org/download/windows-xp-professional-64-bit_202105/Windows_XP_Professional_64-bit.iso"
    goto WinXPProSP3
)
if "%archChoice%"=="0" goto WinXP
goto WinXPProSP3

:WinServer
cls
echo:
echo:       ______________________________________________________________
if "%LANG%"=="EN" (
    echo:                   SELECT WINDOWS SERVER VERSION
) else (
    echo:                   SELEZIONA VERSIONE DI WINDOWS SERVER
)
echo:
echo:             [1] Windows Server 2025
echo:             [2] Windows Server 2022
echo:             [3] Windows Server 2019
echo:             [4] Windows Server 2016
echo:             [5] Windows Server 2012 
echo:             [6] Windows Server 2008 R2
if "%LANG%"=="EN" (
echo              [0] Back to previous menu
) else (
echo              [0] Torna al menu precedente
)

echo:

if "%LANG%"=="EN" (
    set /p editionChoice="      Choose a Windows Server version [1-6,0]: "
) else (
    set /p editionChoice="      Scegli una versione di Windows Server [1-6,0]: "
)

if "%editionChoice%"=="1" (
    start "" "https://oemsoc.download.prss.microsoft.com/dbazure/X23-81962_26100.1742.240906-0331.ge_release_svc_refresh_SERVER_OEMRET_x64FRE_it-it.iso_48cb6aac-6a5f-4b42-8eb8-58e82f98e0ea?t=b7f5fbb0-2607-4b2c-8c6c-a38461db2668&P1=102817441220&P2=601&P3=2&P4=qNno3hapIKl8cJiUZp%2fOrX14cqNaI6jq5aNvVXCqzS3aQEdzH3jb7je57F%2bTkkfiysXwxZ2lYY9XJs8gcVMFqHolQQGLX%2fb%2fQXxMX96QFek8b3v8%2b9FzpZcccVBclC0F0bTSUZuEY%2fop%2fpaolR2gketpgFkvlc5VJokh1266Ab3Gsm4WKowQCvJ5gEgEgjN2JdErZHtMz76mBGjyg0lHRBrs98dZE8bsCscZbh4YpfHELdIt7Z1stOg0SQqiUF8nYm%2b3PVE4zh9w9sopgbUVnAyUUQNpiTr1esfeuf8WOMyAVfmyc2%2faSgmErMuruE84LHj4UbxL3nyvkiArzOs9mg%3d%3d"
    goto WinServer
)
if "%editionChoice%"=="2" (
    start "" "https://drive.massgrave.dev/it-it_windows_server_2022_updated_nov_2024_x64_dvd_4e34897c.iso"
    goto WinServer
)
if "%editionChoice%"=="3" (
    start "" "https://drive.massgrave.dev/it-it_windows_server_2019_x64_dvd_454267de.iso"
    goto WinServer
)
if "%editionChoice%"=="4" (
    start "" "https://drive.massgrave.dev/it_windows_server_2016_vl_x64_dvd_11636710.iso"
    goto WinServer
)
if "%editionChoice%"=="5" (
    start "" "https://drive.massgrave.dev/it_windows_server_2012_r2_vl_with_update_x64_dvd_6052792.iso"
    goto WinServer
)
if "%editionChoice%"=="6" (
    start "" "https://drive.massgrave.dev/it_windows_server_2008_r2_with_sp1_vl_build_x64_dvd_619596.iso"
    goto WinServer
)
if "%editionChoice%"=="0" goto :DownWindows
goto WinServer

:Extra
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                            Extra
echo:
echo:             [1] Adobe Suite Crack
echo:             [2] Wise Care 365
echo:             [3] Powershell 7
echo:             [4] Adobe Acrobat Pro DC 2024
echo:             [5] Adobe Photoshop 2025
echo:             [6] Adobe Premiere Pro 2025
echo:             [7] Adobe Illustrator 2025 (zip password: 123)
echo:             [8] Adobe After Effects 2025
echo:             [9] MiniTool Partition Wizard Technician 12.9
echo:             [10] Revo Uninstaller Pro
echo:             [11] Poweroff
echo:             [12] Glasswire 
echo:             [13] Windows XP Activator             
if "%LANG%"=="EN" (
echo              [0] Back to previous menu
echo:       ______________________________________________________________
echo:
	set /p extraChoice="      Choose Extra [1-13,0]: "
	
) else (
echo              [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
    set /p extraChoice="      Scegli Extra [1-13,0]: "
)

if "%extraChoice%"=="0" goto :MainMenu


if "%extraChoice%"=="1" (
    start "" "https://github.com/wangzhenjjcn/AdobeGenp/releases/download/AdobeGenp-3.4.2-CGP/AdobeGenp-3.4.2-CGP.exe"
    goto Extra
)

if "%extraChoice%"=="2" (
    start "" "https://dl.tickcoupon.cloud/WiseCare365_v7.0.2_TickGiveaway.exe"
    goto Extra
)
if "%extraChoice%"=="3" (
    if "%LANG%"=="EN" (
        echo Installing PowerShell 7...
    ) else (
        echo Installazione di PowerShell 7 in corso...
    )
    winget install --id Microsoft.Powershell --source winget --silent --accept-package-agreements --accept-source-agreements
    
    if %errorlevel% neq 0 (
        if "%LANG%"=="EN" (
            echo Error occurred while installing PowerShell. Try disabling your firewall or antivirus temporarily.
        ) else (
            echo Errore durante l'installazione di PowerShell. Prova a disabilitare temporaneamente il firewall o l'antivirus.
        )
    ) else (
        if "%LANG%"=="EN" (
            echo PowerShell 7 has been successfully installed.
        ) else (
            echo PowerShell 7 è stato installato con successo.
        )
    )
    goto Extra
)
if "%extraChoice%"=="4" (
    start "" "https://download2276.mediafire.com/cxxum78y8zqgN_tJuU36Elb1r3l7lFBTmK5EAve1C5152EfPM7eiv6zaCdX_xj_KJkVSSZa07LiPseGsEerZp2e5S1J0MjSdGlAJ-D0V1bVIFD25nV_cZ7PKYETrCAUcqGrKdcYYnwlRZQfLOQeOWacCz-Cii4FxyrTyn2vtMoWYqNs/wis3cl6fgdhsh6t/AdobeAcrobatProDC2024.005.20320x86.exe"
    goto Extra
)
if "%extraChoice%"=="5" (
    start "" "https://download2341.mediafire.com/hspn5g1bm5ogUM9JD6ZhoXVE7ai8ZXTiWrI4bHj7sgTd51_Ntlf5gKaq5XuOwenJVTYtOYhsRLqX4qnDHkJ_wlMoxNkkyk41paAdShKpPnB-5TALC3dVopvYaInRJYbFOifAtsVgBUFBmwD2vB5LDzopgmHL-VctqZghnMxrbDIO3ME/ptv08z9d94pgwd4/AdobePhotoshop2025v26.2.0.140x64Repack.exe"
    goto Extra
)
if "%extraChoice%"=="6" (
    start "" "https://download2362.mediafire.com/2agtqmude9ugQQ0uWsn2yv99DAfkJMnL2nebOVOjCg83X9d2yy0WMBayXvPx81NUzboLSGhx0JxJzYC-2jVwQ1hlHIKc_KYX24z524rzi2xJvWetrLm6QPxaWChDnndu6-7qhGwD_vjluz36HlGbDBn-ebNS2QJNpvf_dKajJGk--2E/bs6j6oxa34husl2/AdobePremierePro2025v25.1.0.073x64Repack.exe"
    goto Extra
)
if "%extraChoice%"=="7" (
    start "" "https://s2-download.xyz/a208c36e6a1aeb2b?ref=3b42157738c4f54a769a03bb72768090"
    goto Extra
)
if "%extraChoice%"=="8" (
    start "" "https://pixeldrain.com/u/sr6Juu55"
    goto Extra
)
if "%extraChoice%"=="9" (
    start "" "https://download2303.mediafire.com/nzdul5186wegPipTxg3QiEJTcN5Txa1YwPEusyRyOFaYsGI8cL6Txet6oLwVMaqxe6O6Mxex9E7858bELiecPzgus72T0MqL4B3qdBHsoJ3_iKbS0kgCTv3tPoosMZ12sxjOntLEvdkUzw_mSsOSweExC5o1IgtzPXsVlEK2I_MkC_c/ydflmgh2hlhrrtc/MiniToolPartitionWizardTechnician12.9.tar.xz"
    goto Extra
)
if "%extraChoice%"=="10" (
    start "" "https://download2264.mediafire.com/yn7i8ultj3ygKC6IvuMxmGFypQmbqgG9nn_cXRk7HI0cuydUcovA8ky579k6fQHy0nIClkK2JuPZt8s_quqKLb_G8pj5KZOfx97CKkLRvVtrMdTMEgzkPfgxRlLQvMSIosJNseCnJ-ouHFQbRdCcVQsqUvfL42etzrO8mM5JJbeahb0/nukbc77mx4snbdz/RevoUninstallerPro5.3.5.exe.xz"
    goto Extra
)
if "%extraChoice%"=="11" (
    start "" "https://download1509.mediafire.com/fsep1extw7ogjAaBtolj-EW4KJ98qspT2vIrbCg3UmGqbJNa_GHy5Dsr9bt0xsZRtK_o9FzAMxzeHB5tPUqhGe-AUEEhr1QZZ4qEhRvXUJYqswTsGDpKwQ_R8RtTqbGesqsYpfP_56eT-WS47HodFUv86_chCDMfj2dK8xBD7FfFy7M/oa2j0ymtjjgzr1s/poweroff-3.0.1.3.zip"
    goto Extra
)
if "%extraChoice%"=="12" (
    start "" "https://download2388.mediafire.com/9k0l3cdx4mpgWXSpL4__11B-7xZFvlUyPWcJte1ADHgiTc7fcTkWa1TamhafLO-_Kx5KuhZcFYBsbI8dnxnbrmDIb7WwYKu3wb1vhJe4d563A-f_sX06cgYv4g70kVQqhtFPiIvvXrnoD_8D2v1GjXzdM5q4R5eGTzvyA4SmiA28eLU/9wsxxcvrn4bpz6g/Glasswire3.4.768.exe.xz"
    goto Extra
)
if "%extraChoice%"=="13" (
    start "" "https://archive.org/download/xp_activate32_202305/xp_activate32.zip"
    goto Extra
)

goto :Extra

:Exit
if "%LANG%"=="EN" (
    echo Exiting the program...
) else (
    echo Uscita dal programma...
)
pause
exit

