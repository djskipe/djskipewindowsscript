
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
echo:             [7] Scarica Microsoft Windows
echo:             [0] Esci
echo:       ______________________________________________________________
echo:
set /p choice="      Scegli un'opzione dal menu [1-5,0]: "

if "%choice%"=="1" goto :RunDebloater
if "%choice%"=="2" goto :InstallBaseSoftwareCustomEdition
if "%choice%"=="3" goto :InstallBaseSoftware
if "%choice%"=="4" goto :RunOfficeToolPlus
if "%choice%"=="5" goto :ActivateWindows
if "%choice%"=="6" goto :DownOffice
if "%choice%"=="7" goto :DownWindows
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
echo:             [7] Software Singoli 
echo:             [0] Torna al menu principale
echo:       ______________________________________________________________
echo:
set /p officeChoice="      Scegli una versione di Office [1-7,0]: "

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
echo:                   SELEZIONA EDIZIONE DI OFFICE 365
echo:
echo:             [1] Professional Plus
echo:             [2] Business
echo:             [3] Education
echo:             [4] Home
echo:             [5] Small Business
echo:             [0] Torna al menu precedente 
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Office 365 [1-5,0]: "

if "%editionChoice%"=="1" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/O365ProPlusRetail.img"
    goto Office365
)
if "%editionChoice%"=="2" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/O365Business.img"
    goto Office365
)
if "%editionChoice%"=="3" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/O365Education.img"
    goto Office365
)
if "%editionChoice%"=="4" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/"
    goto Office365
)
if "%editionChoice%"=="5" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/"
    goto Office365
)
if "%editionChoice%"=="0" goto DownOffice

:Office2024
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI OFFICE 2024
echo:
echo:             [1] Professional Plus
echo:             [2] Professional
echo:             [3] Home
echo:             [4] Home and Business
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Office 2024 [1-3,0]: "

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

:Office2021
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI OFFICE 2021
echo:
echo:             [1] Professional Plus
echo:             [2] Professional
echo:             [3] Home and Student
echo:             [4] Home and Business
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Office 2021 [1-4,0]: "

if "%editionChoice%"=="1" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/ProPlus2021Retail.img"
    goto Office2021
)
if "%editionChoice%"=="2" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/Professional2021Retail.img"
    goto Office2021
)
if "%editionChoice%"=="3" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/HomeStudent2021Retail.img"
    goto Office2021
)
if "%editionChoice%"=="4" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/HomeBusiness2021Retail.img"
    goto Office2021
)
if "%editionChoice%"=="0" goto :DownOffice
goto :Office2021

:Office2019
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI OFFICE 2019
echo:
echo:             [1] Professional Plus
echo:             [2] Professional
echo:             [3] Home and Student
echo:             [4] Home and Business
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Office 2019 [1-4,0]: "

if "%editionChoice%"=="1" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/ProPlus2019Retail.img"
    goto Office2019
)
if "%editionChoice%"=="2" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/Professional2019Retail.img"
    goto Office2019
)
if "%editionChoice%"=="3" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/HomeStudent2019Retail.img"
    goto Office2019
)
if "%editionChoice%"=="4" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/HomeBusiness2019Retail.img"
    goto Office2019
)
if "%editionChoice%"=="0" goto :DownOffice
goto :Office2019

:Office2016
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI OFFICE 2016
echo:
echo:             [1] Professional Plus
echo:             [2] Professional
echo:             [3] Home and Student
echo:             [4] Home and Business
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Office 2016 [1-4,0]: "
if "%editionChoice%"=="1" (
    start "" "https://drive.massgrave.dev/SW_DVD5_Office_Professional_Plus_2016_64Bit_Italian_MLF_X20-42442.ISO"
    goto Office2016
)
if "%editionChoice%"=="2" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/ProfessionalRetail.img"
    goto Office2016
)
if "%editionChoice%"=="3" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/HomeStudentRetail.img"
    goto Office2016
)
if "%editionChoice%"=="4" (
    start "" "https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/it-IT/HomeBusinessRetail.img"
    goto Office2016
)
if "%editionChoice%"=="0" goto :DownOffice
goto :Office2016

:Office2013
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI OFFICE 2013
echo:
echo:             [1] Professional
echo:             [2] Home and Student
echo:             [3] Home and Business
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Office 2013 [1-3,0]: "

if "%editionChoice%"=="1" (
    start "" "https://officeredir.microsoft.com/r/rlidO15C2RMediaDownload?p1=db&p2=it-IT&p3=ProfessionalRetail"
    goto Office2013
)
if "%editionChoice%"=="2" (
    start "" "https://officeredir.microsoft.com/r/rlidO15C2RMediaDownload?p1=db&p2=it-IT&p3=HomeStudentRetail"
    goto Office2013
)
if "%editionChoice%"=="3" (
    start "" "https://officeredir.microsoft.com/r/rlidO15C2RMediaDownload?p1=db&p2=it-IT&p3=HomeBusinessRetail"
    goto Office2013
)
if "%editionChoice%"=="0" goto :DownOffice
goto:Office2013

:SoftwareSingoli
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                 SELEZIONA SOFTWARE DI OFFICE DA SCARICARE
echo:                             (solo 2024)
echo:
echo:             [1] Word
echo:             [2] Powerpoint
echo:             [3] Excel
echo:             [4] Outlook
echo:             [5] Access
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un software di Office [1-9,0]: "

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
goto:SoftwaereSingoli

:DownWindows
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA VERSIONE DI WINDOWS DA SCARICARE
echo:
echo:             [1] Windows 11
echo:             [2] Windows 10
echo:             [3] Windows 8.1
echo:             [4] Windows 7
echo:             [5] Windows XP
echo:             [6] Windows Server 
echo:             [0] Torna al menu principale
echo:       ______________________________________________________________
echo:
set /p winChoice="      Scegli una versione di Windows [1-7,0]: "

if "%winChoice%"=="1" goto :Win11
if "%winChoice%"=="2" goto :Win10
if "%winChoice%"=="3" goto :Win8.1
if "%winChoice%"=="4" goto :Win7
if "%winChoice%"=="5" goto :WinXP
if "%winChoice%"=="6" goto :WinServer
if "%winChoice%"=="0" goto :MainMenu
goto :DownWindows

if "%winChoice%"=="1" (
    start "" "https://software.download.prss.microsoft.com/dbazure/Win11_24H2_Italian_x64.iso?t=52b88a14-2732-4489-ac54-8233f950f32f&P1=1737205836&P2=601&P3=2&P4=3G48wwJiMPyfr45ItnbBLuIuYHCjimXpWUyGImBRWVNVjiKqSBj4vaKQDI6LKRRrZQHSNc91WLQWkQ0jT8ZXm30SsHmiOL%2fM2IlpfW7z7WmJLyj43sh8fYQ2z%2fAUIBu68Q02UD2MyC343agQjnC7VDlqhkLxo0oCmcI%2foRl7UHQFnX2XB1aSpg19skHkIjnhlSo6YLzgWYMrQD5wvAM%2bP36%2fWoC0XYaI3V1%2bgEgnhrGXxxFW3LYxNMTvcop%2b3efhftI7o6aiQnzqik74DXt%2bbaSSg1FQSFXeE0f%2bdvxJrIsB1g3fcTb87BiuNFSGO7q3oHiXJGVp33VTlKVQ199npg%3d%3d"
)
if "%winChoice%"=="2" (
    start "" "https://delivery.activated.win/47c62492-92f1-49ef-8740-62989154e590/it-it_windows_10_consumer_editions_version_22h2_updated_nov_2024_x86_dvd_3eeacab9.iso?t=ac967221-29d9-4d79-9d04-282aaab25502&P1=1737141282&P2=601&P3=2&P4=7tvlhF7XjJMA0%2B45bPZYN8SASWzXxo8cO3l%2FUMVMQKs%3D"
)
if "%winChoice%"=="3" (
    start "" "https://software.download.prss.microsoft.com/dbazure/Win8.1_Italian_x64.iso?t=411b2b32-613a-490d-b5b4-960f793af0ed&P1=1737206229&P2=601&P3=2&P4=Maq8BzXR%2bhX%2f3051IIFG5Xex6B9SOOSZPf7Bhohg3E3KDtEx3tQGYTbysn2D%2b9Hjw29L82ner2JVgGVjMdnQmfptORF4FgAIMANq%2f2nbviLbppbtRVyuaEiya7hM72pr6g1Ca8K%2fXckJGHm7uMuV9ijdjTjf%2fE%2faiTHz5aF8delbxesYS%2fhv6IgpwAm5%2b1PTPgKoCxiRetka1aiYRlSdKZFJ2xaFQvu4ILZuWwYNLhGc96TiVJ30nHrfVSOsL5c3H8HcSIhyNtvhgGoAa4%2flbctMKZBLyOwl%2bweilsFN9ILHmc7uOCZ3zppau6R75PNCwZx1Zt3COhdhyoNvNP2Aew%3d%3d"
)


:Win7
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI WINDOWS 7
echo:
echo:             [1] Professional
echo:             [2] Enterprise
echo:             [3] Ultimate
echo:             [4] Home Premium
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Windows 7 [1-4,0]: "

if "%editionChoice%"=="1" goto :Win7Pro
if "%editionChoice%"=="2" goto :Win7Enterprise
if "%editionChoice%"=="3" goto :Win7Ultimate
if "%editionChoice%"=="4" goto :Win7HomePremium
if "%editionChoice%"=="0" goto :DownWindows
goto :Win7

:Win7Pro
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA ARCHITETTURA WINDOWS 7 PROFESSIONAL
echo:
echo:             [1] Windows 7 Professional x64
echo:             [2] Windows 7 Professional x86
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p archChoice="      Scegli l'architettura [1-2,0]: "

if "%archChoice%"=="1" (
    start "" "https://software.download.prss.microsoft.com/dbazure/Win7_Pro_SP1_Italian_x64.iso"
    goto Win7Pro
)
if "%archChoice%"=="2" (
    start "" "https://software.download.prss.microsoft.com/dbazure/Win7_Pro_SP1_Italian_x86.iso"
    goto Win7Pro
)
if "%archChoice%"=="0" goto :Win7
goto :Win7Pro

:Win7Enterprise
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA ARCHITETTURA WINDOWS 7 ENTERPRISE
echo:
echo:             [1] Windows 7 Enterprise x64
echo:             [2] Windows 7 Enterprise x86
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p archChoice="      Scegli l'architettura [1-2,0]: "

if "%archChoice%"=="1" (
    start "" "https://software.download.prss.microsoft.com/dbazure/Win7_Ent_SP1_Italian_x64.iso"
    goto Win7Enterprise
)
if "%archChoice%"=="2" (
    start "" "https://software.download.prss.microsoft.com/dbazure/Win7_Ent_SP1_Italian_x86.iso"
    goto Win7Enterprise
)
if "%archChoice%"=="0" goto :Win7
goto :Win7Enterprise

:Win7Ultimate
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA ARCHITETTURA WINDOWS 7 ULTIMATE
echo:
echo:             [1] Windows 7 Ultimate x64
echo:             [2] Windows 7 Ultimate x86
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p archChoice="      Scegli l'architettura [1-2,0]: "

if "%archChoice%"=="1" (
    start "" "https://software.download.prss.microsoft.com/dbazure/Win7_Ult_SP1_Italian_x64.iso"
    goto Win7Ultimate
)
if "%archChoice%"=="2" (
    start "" "https://software.download.prss.microsoft.com/dbazure/Win7_Ult_SP1_Italian_x86.iso"
    goto Win7Ultimate
)
if "%archChoice%"=="0" goto :Win7
goto :Win7Ultimate

:Win7HomePremium
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA ARCHITETTURA WINDOWS 7 HOME PREMIUM
echo:
echo:             [1] Windows 7 Home Premium x64
echo:             [2] Windows 7 Home Premium x86
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p archChoice="      Scegli l'architettura [1-2,0]: "

if "%archChoice%"=="1" (
    start "" "https://software.download.prss.microsoft.com/dbazure/Win7_HomePrem_SP1_Italian_x64.iso"
    goto Win7HomePremium
)
if "%archChoice%"=="2" (
    start "" "https://software.download.prss.microsoft.com/dbazure/Win7_HomePrem_SP1_Italian_x86.iso"
    goto Win7HomePremium
)
if "%archChoice%"=="0" goto :Win7
goto :Win7HomePremium

:WinXP
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA EDIZIONE DI WINDOWS XP
echo:
echo:             [1] Professional SP3
echo:             [2] Home SP3
echo:             [3] Professional x64 Edition
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli un'edizione di Windows XP [1-3,0]: "

if "%editionChoice%"=="1" (
    start "" "https://software.download.prss.microsoft.com/dbazure/WinXP_Pro_SP3_Italian.iso"
    goto WinXP
)
if "%editionChoice%"=="2" (
    start "" "https://software.download.prss.microsoft.com/dbazure/WinXP_Home_SP3_Italian.iso"
    goto WinXP
)
if "%editionChoice%"=="3" (
    start "" "https://software.download.prss.microsoft.com/dbazure/WinXP_Pro_x64_Italian.iso"
    goto WinXP
)
if "%editionChoice%"=="0" goto :DownWindows
goto :WinXP

:WinServer
cls
echo:
echo:       ______________________________________________________________
echo:
echo:                   SELEZIONA VERSIONE DI WINDOWS SERVER
echo:
echo:             [1] Windows Server 2022
echo:             [2] Windows Server 2019
echo:             [3] Windows Server 2016
echo:             [4] Windows Server 2012 R2
echo:             [5] Windows Server 2008 R2
echo:             [0] Torna al menu precedente
echo:       ______________________________________________________________
echo:
set /p editionChoice="      Scegli una versione di Windows Server [1-5,0]: "

if "%editionChoice%"=="1" (
    start "" "https://software.download.prss.microsoft.com/dbazure/WinServer2022_x64_Italian.iso"
    goto WinServer
)
if "%editionChoice%"=="2" (
    start "" "https://software.download.prss.microsoft.com/dbazure/WinServer2019_x64_Italian.iso"
    goto WinServer
)
if "%editionChoice%"=="3" (
    start "" "https://software.download.prss.microsoft.com/dbazure/WinServer2016_x64_Italian.iso"
    goto WinServer
)
if "%editionChoice%"=="4" (
    start "" "https://software.download.prss.microsoft.com/dbazure/WinServer2012R2_x64_Italian.iso"
    goto WinServer
)
if "%editionChoice%"=="5" (
    start "" "https://software.download.prss.microsoft.com/dbazure/WinServer2008R2_x64_Italian.iso"
    goto WinServer
)
if "%editionChoice%"=="0" goto :DownWindows
goto :WinServer

:Exit
echo Uscita dal programma...
pause
exit
