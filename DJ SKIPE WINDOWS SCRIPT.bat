@echo off
setlocal enabledelayedexpansion

:: Version information
set "CURRENT_VERSION=1.8.0"
set "GITHUB_API_URL=https://api.github.com/repos/djskipe/djskipewindowsscript/releases/latest"

:: Check for updates before showing the menu
call :CheckForUpdates

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

echo Continuing without update...
goto :eof

:CheckForUpdates
:: Create a temporary file to store the API response
set "temp_file=%temp%\github_response.txt"

:: Use PowerShell to fetch the latest release information
powershell -Command "(Invoke-WebRequest -Uri '%GITHUB_API_URL%' -UseBasicParsing).Content" > "%temp_file%"

:: Extract the latest version and download URL using PowerShell
for /f "tokens=* usebackq" %%a in (`powershell -Command "Get-Content '%temp_file%' | ConvertFrom-Json | Select-Object -ExpandProperty tag_name"`) do set "LATEST_VERSION=%%a"
for /f "tokens=* usebackq" %%a in (`powershell -Command "Get-Content '%temp_file%' | ConvertFrom-Json | Select-Object -ExpandProperty assets | Select-Object -First 1 | Select-Object -ExpandProperty browser_download_url"`) do set "DOWNLOAD_URL=%%a"

:: Remove the temporary file
del "%temp_file%"

:: Compare versions
if not "%LATEST_VERSION%"=="%CURRENT_VERSION%" (
    cls
    echo:
    echo  New version available: %LATEST_VERSION% ^(Current: %CURRENT_VERSION%^)
    echo:
    set /p "UPDATE_CHOICE=Do you want to update now? (Y/N): "
    
    if /i "!UPDATE_CHOICE!"=="Y" (
        :: Download the new version
        echo Downloading update...
        powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%~dp0update.bat'"

        :: Check if the update.bat file exists
        if exist "%~dp0update.bat" (
            :: Create an updater script in a temporary location (to avoid conflict with the current script)
            echo @echo off > "%temp%\update_script.bat"
            echo timeout /t 2 /nobreak ^> nul >> "%temp%\update_script.bat"
            echo move /y "%~dp0update.bat" "%~nx0" >> "%temp%\update_script.bat"
            echo start "" "%~nx0" >> "%temp%\update_script.bat"
            echo del "%temp%\update_script.bat" >> "%temp%\update_script.bat"
            
            :: Run the updater script in a new command window to avoid conflict
            start cmd /c "%temp%\update_script.bat"
            exit
        ) else (
            echo Error: Update file not found.
            pause
            exit
        )
    ) else (
        echo Skipping update...
        goto LanguageSelect
    )
)
goto :eof

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
    echo:                 DJ SKIPE WINDOWS SCRIPT v1.8.0
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
    echo:             [9] Useful Software
    echo:             [10] Change Language
    echo:             [0] Exit
) else (
    echo:                 DJ SKIPE WINDOWS SCRIPT v1.8.0
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
    echo:             [9] Software Utili
    echo:             [10] Cambia Lingua
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
if "%choice%"=="9" goto :SoftwareUtili
if "%choice%"=="10" goto :LanguageSelect
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

start "" "https://ninite.com/7zip-brave-discord-handbrake-notepadplusplus-operaChromium-python3-steam-teamviewer15-vlc-vscode/"
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
start "" "https://ninite.com/7zip-brave-foxit-openoffice-vlc/"
pause
goto :MainMenu

:RunOfficeToolPlus
if "%LANG%"=="EN" (
    echo Downloading and launching application...
) else (
    echo Download e avvio dell'applicazione in corso...
)

:: Set download path
set "downloadPath=%UserProfile%\Downloads\OTP_Runtime.zip"
set "extractPath=%UserProfile%\Downloads\OTP"

:: Download the file using PowerShell with the new direct URL
powershell -NoProfile -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri 'https://otp.landian.vip/redirect/download.php?type=runtime&arch=x64&site=github' -OutFile '%downloadPath%'"

:: Check if download was successful
if exist "%downloadPath%" (
    if "%LANG%"=="EN" (
        echo Download completed successfully.
        echo Extracting files...
    ) else (
        echo Download completato con successo.
        echo Estrazione dei file in corso...
    )
    
    :: Create extraction directory if it doesn't exist
    if not exist "%extractPath%" mkdir "%extractPath%"
    
    :: Extract the ZIP file using PowerShell
    powershell -NoProfile -Command "Expand-Archive -Path '%downloadPath%' -DestinationPath '%extractPath%' -Force"
    
    :: Launch the application
    if exist "%extractPath%\Office Tool Plus.exe" (
        start "" "%extractPath%\Office Tool Plus.exe"
    ) else (
        :: Try alternative path in case it's in a subfolder
        for /r "%extractPath%" %%i in (*"Office Tool Plus.exe") do (
            start "" "%%i"
            goto :continue
        )
        
        if "%LANG%"=="EN" (
            echo Error: Could not find Office Tool Plus executable.
        ) else (
            echo Errore: Impossibile trovare l'eseguibile di Office Tool Plus.
        )
    )
    
    :continue
    :: Clean up downloaded zip file
    del "%downloadPath%"
)

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

:Office2021
cls
echo:
echo:       ______________________________________________________________
echo:
if "%LANG%"=="EN" (
    echo:                   SELECT OFFICE 2021 EDITION
    echo:
    echo:             [1] Professional Plus
    echo:             [2] Professional
    echo:             [3] Home
    echo:             [4] Home and Business
    echo:             [0] Back to previous menu
) else (
    echo:                   SELEZIONA EDIZIONE DI OFFICE 2021
    echo:
    echo:             [1] Professional Plus
    echo:             [2] Professional
    echo:             [3] Home and Student
    echo:             [4] Home and Business
    echo:             [0] Torna al menu precedente
)
echo:       ______________________________________________________________
echo:

if "%LANG%"=="EN" (
    set /p editionChoice="      Choose an Office 2021 edition [1-4,0]: "
) else (
    set /p editionChoice="      Scegli un'edizione di Office 2021 [1-4,0]: "
)

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
if "%LANG%"=="EN" (
    echo:                   SELECT OFFICE 2019 EDITION
    echo:
    echo:             [1] Professional Plus
    echo:             [2] Professional
    echo:             [3] Home
    echo:             [4] Home and Business
    echo:             [0] Back to previous menu
) else (
    echo:                   SELEZIONA EDIZIONE DI OFFICE 2019
    echo:
    echo:             [1] Professional Plus
    echo:             [2] Professional
    echo:             [3] Home and Student
    echo:             [4] Home and Business
    echo:             [0] Torna al menu precedente
)
echo:       ______________________________________________________________
echo:

if "%LANG%"=="EN" (
    set /p editionChoice="      Choose an Office 2019 edition [1-4,0]: "
) else (
    set /p editionChoice="      Scegli un'edizione di Office 2019 [1-4,0]: "
)

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

if "%LANG%"=="EN" (
    set /p editionChoice="      Choose Office software [1-5,0]: "
) else (
    set /p editionChoice="      Scegli un software di Office [1-5,0]: "
)

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
    start "" "https://archive.org/download/Win11v24H2ITAx64/Win11_24H2_Italian_x64.iso"
    goto :DownWindows
)

if "%winChoice%"=="2" (
    cls
    echo: Downloading Windows 10...
    start "" "https://archive.org/download/win-10-22-h-2-italian-x-64_202302/Win10_22H2_Italian_x64.iso"
    goto :DownWindows
)

if "%winChoice%"=="3" (
    cls
    echo: Downloading Windows 8.1...
    start "" "https://archive.org/download/Win8.1AIOITA/Microsoft.Windows.8.1.AiO.6in1.Core.Prof.ProWMC.X86.X64.RTM.9600.ITA%2BACT.iso"
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
echo             [0] Torna al menu precedente
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
    start "" "https://drive.massgrave.dev/it-it_windows_server_2025_updated_july_2025_x64_dvd_a1f0681d.iso"
    goto WinServer
)
if "%editionChoice%"=="2" (
    start "" "https://drive.massgrave.dev/it-it_windows_server_2022_updated_july_2025_x64_dvd_f3e39b78.iso"
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
echo:       ___________________________________________________________________________________________________________
echo:
echo:                            Extra
echo:
echo:             [1] Adobe Suite Crack                                     [21] Revo Uninstaller Pro Portable          
echo:             [2] Wise Care 365                                         [22] WinPE Acronis True Image 
echo:             [3] Powershell 7 Installer by dj skipe                    [23] WinPE Sergei Strelect
echo:             [4] Adobe Acrobat Pro DC 2025                             [24] MAGIX Vegas Pro
echo:             [5] Adobe Photoshop 2025                                  [25] WinPE Macrium Reflect X
echo:             [6] Adobe Premiere Pro 2025                               [26] ABBYY FineReader Corporate
echo:             [7] Adobe Illustrator 2025                                [27] Aida64 Business
echo:             [8] Adobe After Effects 2025
echo:             [9] MiniTool Partition Wizard Technician 12.8
echo:             [10] Revo Uninstaller Pro
echo:             [11] Poweroff
echo:             [12] Glasswire
echo:             [13] Windows XP Activator       
echo:             [14] WinRar 7.11
echo:             [15] Topaz Video AI 
echo:             [16] StartAllBack 
echo:             [17] Hard Disk Sentinel Pro 
echo:             [18] Advanced IP Scanner
echo:             [19] Em Client Pro 
echo:             [20] Any Excel Password Recovery
echo:
if "%LANG%"=="EN" (
echo              [0] Back to previous menu
echo:      ___________________________________________________________________________________________________________

echo:
	set /p extraChoice="      Choose Extra [1-21,0]: "
	
) else (
echo              [0] Torna al menu precedente
echo:      ___________________________________________________________________________________________________________
echo:
    set /p extraChoice="      Scegli Extra [1-21,0]: "
)

if "%extraChoice%"=="0" goto :MainMenu


if "%extraChoice%"=="1" (
    start "" "https://www.mediafire.com/file/rfkhtvca7v8x5ip/GenP.v3.6.8.7z/file"
    goto Extra
)

if "%extraChoice%"=="2" (
    start "" "https://www.mediafire.com/file/cis98c3afhdx23g/WiseCare365_7.2.5.703.exe/file"
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
            echo PowerShell 7 e' stato installato con successo.
        )
    )
    goto Extra
)
if "%extraChoice%"=="4" (
    start "" "https://www.mediafire.com/file/4b6xahp0t7cr1t6/AdobeAcrobatProDC2025.001.20577x64.exe/file"
    goto Extra
)
if "%extraChoice%"=="5" (
    start "" "https://www.mediafire.com/file/ed0g9tq2jdif5ev/AdobePhotoshop2025v26.9.0.15x64Repack.exe/file"
    goto Extra
)
if "%extraChoice%"=="6" (
    start "" "https://www.mediafire.com/file/pumkdvaul314y5u/AdobePremierePro2025v25.3.0.084x64Repack.exe/file"
    goto Extra
)
if "%extraChoice%"=="7" (
    start "" "https://www.mediafire.com/file/krke39ev1wjgezj/AdobeIllustrator2025v29.6.1.9x64Repack.exe/file"
    goto Extra
)
if "%extraChoice%"=="8" (
    start "" "https://www.mediafire.com/file/a4nwt112iqfztzj/AdobeAfterEffects2025v25.3.2.002x64.7z/file"
    goto Extra
)
if "%extraChoice%"=="9" (
    start "" "https://www.mediafire.com/file/xdb83hmd58cehmv/MiniTool_Partition_Wizard_v12.8.rar/file"
    goto Extra
)
if "%extraChoice%"=="10" (
    start "" "https://www.mediafire.com/file/mjamylbeewy1q9o/RevoUninstallerPro5.4.0.7z/file"
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
if "%extraChoice%"=="14" (
    start "" "https://www.mediafire.com/file/wz16eq1kmpe4bfu/WinRAR7.13x64.exe/file"
    goto Extra
)
if "%extraChoice%"=="15" (
    start "" "https://www.mediafire.com/file/ft3w9qrryg7ra89/TopazVideoAI7.1.0x64.7z/file"
    goto Extra
)
if "%extraChoice%"=="16" (
    start "" "https://www.mediafire.com/file/eur53u458z4vmir/StartAllBack_3.9.13.5293.7z/file"
    goto Extra
)
if "%extraChoice%"=="17" (
    start "" "https://www.mediafire.com/file/tvhfxlwu3z3ktp8/Hard_Disk_Sentinel_Pro_v6.30.rar/file"
    goto Extra
)
if "%extraChoice%"=="18" (
    start "" "https://www.advanced-ip-scanner.com/it/download/"
    goto Extra
)
if "%extraChoice%"=="19" (
    start "" "https://www.mediafire.com/file/slx24irw8uqlcyi/eM+Client+Pro+10.3.2619.7z/file"
    goto Extra
)
if "%extraChoice%"=="20" (
    start "" "https://www.mediafire.com/file/bgjgtwh2r5vka9b/Any_Excel_Password_Recovery_11.8.0.7z/file"
    goto Extra
)
if "%extraChoice%"=="21" (
    start "" "https://www.mediafire.com/file/9xttrpzmbntda0u/Revo+Uninstaller+Pro+5.4.0+Portable.7z/file"
    goto Extra
)
if "%extraChoice%"=="22" (
    start "" "https://www.mediafire.com/file/s3cx3antqfwahp1/Acronis+True+Image+Build+42072+Multilingual+Bootable+ISO.7z/file"
    goto Extra
)
if "%extraChoice%"=="23" (
    start "" "https://mega.nz/file/cvpyhDgS#6_QA3ZfAaBdWoDdIwioqqjxy3hVhD5daPcti0L3W1-E"
    goto Extra
)
if "%extraChoice%"=="24" (
    start "" "https://www.mediafire.com/file/c85rf7759hfdper/MAGIXVEGASPro22.0.0.250x64.exe.xz/file"
    goto Extra
)
if "%extraChoice%"=="25" (
    goto MacriumSubmenu
)
if "%extraChoice%"=="26" (
    start "" "https://www.mediafire.com/file/sq279uu7lcwqbdn/ABBYYFineReaderCorporate16.0.14.7295x64.exe/file"
    goto Extra
)
if "%extraChoice%"=="27" (
    start "" "https://www.mediafire.com/file/lrndezvvqa61d3b/AIDA64Business7.70.7500.7z/file"
    goto Extra
)


goto :Extra

:MacriumSubmenu
cls
echo:       ___________________________________________________________________________________________________________
echo:
echo:                            WinPE Macrium Reflect X - Scegli Versione
echo:
if "%LANG%"=="EN" (
    echo:             [1] Macrium Reflect X Windows 10 WinPE
    echo:             [2] Macrium Reflect X Windows 11 WinPE
    echo:             [0] Back to Extra menu
) else (
    echo:             [1] Versione Windows 10
    echo:             [2] Versione Windows 11
    echo:             [0] Torna al menu Extra
)
echo:      ___________________________________________________________________________________________________________
echo:

if "%LANG%"=="EN" (
    set /p macriumChoice="      Choose version [1-2,0]: "
) else (
    set /p macriumChoice="      Scegli versione [1-2,0]: "
)

if "%macriumChoice%"=="0" goto Extra

if "%macriumChoice%"=="1" (
    start "" "https://www.mediafire.com/file/t591taedfywoz90/Macrium+Reflect+X+Server+10.0.8576+(x64)+WinPE+10.7z/file"
    goto Extra
)

if "%macriumChoice%"=="2" (
    start "" "https://www.mediafire.com/file/2pek6ack7mivl5i/Macrium+Reflect+X+Server+10.0.8576+(x64)+WinPE+11.7z/file"
    goto Extra
)

if "%LANG%"=="EN" (
    echo Invalid choice. Please try again.
) else (
    echo Scelta non valida. Riprova.
)
pause
goto MacriumSubmenu

goto :Extra

:SoftwareUtili
cls
echo:
echo:       ___________________________________________________________________________________________________________
echo:
if "%LANG%"=="EN" (
    echo:                                          Useful Software
    echo:
    echo:             [1] 7-Zip                                              [21] Ubisoft Connect
    echo:             [2] Google Chrome                                      [22] Gog Launcher
    echo:             [3] Firefox                                            [23] CrystalDiskInfo
    echo:             [4] VLC Media Player                                   
    echo:             [6] Notepad++                                          
    echo:             [7] Visual Studio Code                                 
    echo:             [8] OBS Studio                                           
    echo:             [9] Python                                             
    echo:             [10] CPU-Z  
    echo:             [11] GPU-Z                                      
    echo:             [12] Discord                                                                                                     
    echo:             [13] TeamViewer                                        
    echo:             [14] Spotify                                           
    echo:             [15] Steam                                             
    echo:             [16] Epic Games Launcher                               
    echo:             [17] Telegram                                          
    echo:             [18] WhatsApp                                                                                     
    echo:             [19] EA App                                             
    echo:             [20] HWiNFO
    echo:
    echo              [0] Back to main menu
) else (
    echo:                                          Software Utili
    echo:
    echo:             [1] 7-Zip                                              [21] Ubisoft Connect
    echo:             [2] Google Chrome                                      [22] Gog Launcher
    echo:             [3] Firefox                                            [23] CrystalDiskInfo
    echo:             [4] VLC Media Player                                   
    echo:             [6] Notepad++                                          
    echo:             [7] Visual Studio Code                                 
    echo:             [8] OBS Studio                                           
    echo:             [9] Python                                             
    echo:             [10] CPU-Z  
    echo:             [11] GPU-Z                                      
    echo:             [12] Discord                                                                                                     
    echo:             [13] TeamViewer                                        
    echo:             [14] Spotify                                           
    echo:             [15] Steam                                             
    echo:             [16] Epic Games Launcher                               
    echo:             [17] Telegram                                          
    echo:             [18] WhatsApp                                                                                     
    echo:             [19] EA App                                             
    echo:             [20] HWiNFO
    echo:
    echo              [0] Torna al menu principale
)
echo:      ___________________________________________________________________________________________________________
echo:

if "%LANG%"=="EN" (
    set /p softwareChoice="      Choose Useful Software [1-40,0]: "
) else (
    set /p softwareChoice="      Scegli Software Utili [1-40,0]: "
)

if "%softwareChoice%"=="0" goto :MainMenu

if "%softwareChoice%"=="1" (
    start "" "https://www.7-zip.org/a/7z2501-x64.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="2" (
    start "" "https://www.mediafire.com/file/tbp43lxp6eezlx4/ChromeSetup.exe/file"
    goto SoftwareUtili
)
if "%softwareChoice%"=="3" (
    start "" "https://download.mozilla.org/?product=firefox-stub&os=win&lang=it"
    goto SoftwareUtili
)
if "%softwareChoice%"=="4" (
    start "" "https://get.videolan.org/vlc/3.0.21/win32/vlc-3.0.21-win32.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="5" (
    start "" "https://www.mediafire.com/file/wz16eq1kmpe4bfu/WinRAR7.13x64.exe/file"
    goto SoftwareUtili
)
if "%softwareChoice%"=="6" (
    start "" "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.7.7/npp.8.7.7.Installer.x64.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="7" (
    start "" "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
    goto SoftwareUtili
)
if "%softwareChoice%"=="8" (
    start "" "LIhttps://cdn-fastly.obsproject.com/downloads/OBS-Studio-31.1.2-Windows-x64-Installer.exeNK_GIT"
    goto SoftwareUtili
)
if "%softwareChoice%"=="9" (
    start "" "LINKhttps://www.python.org/ftp/python/3.13.5/python-3.13.5-amd64.exe_PYTHON"
    goto SoftwareUtili
)
if "%softwareChoice%"=="10" (
    start "" "https://download.cpuid.com/cpu-z/cpu-z_2.16-en.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="11" (
    start "" "https://www.guru3d.com/getdownload/2c1b2414f56a6594ffef91236a87c0e976d52e0518b4303846bab016c2f20c7c4d6ce7dfe19a0bc843da8d448bbb670058b0c9ee9a26f5cf49bc39c97da070e6eb314629af3da2d24ab0413917f73b946419b5af447da45cefb517a0840ad3003abff4f9d5fe7828bbbb910ee270b40528035fb17c6b4c80012cb4bd3140fa764f68932d48b5bb53887b044417f16e18cb59c8aca2a366e80787b52d8a915d2bf3ecdac9dae6c8bf601ba1d54d0f634b29e61c9fcb7e"
    goto SoftwareUtili
)
if "%softwareChoice%"=="12" (
    start "" "https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x64"
    goto SoftwareUtili
)
if "%softwareChoice%"=="13" (
    start "" "https://download.teamviewer.com/download/TeamViewer_Setup_x64.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="14" (
    start "" "https://download.scdn.co/SpotifySetup.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="15" (
    start "" "https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="16" (
    start "" "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi"
    goto SoftwareUtili
)
if "%softwareChoice%"=="17" (
    start "" "https://telegram.org/dl/desktop/win64"
    goto SoftwareUtili
)
if "%softwareChoice%"=="18" (
    start "" "https://get.microsoft.com/installer/download/9NKSQGP7F2NH?cid=website_cta_psi"
    goto SoftwareUtili
)
if "%softwareChoice%"=="19" (
    start "" "https://origin-a.akamaihd.net/EA-Desktop-Client-Download/installer-releases/EAappInstaller.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="20" (
    start "" "https://sourceforge.net/projects/hwinfo/files/Windows_Installer/hwi64_828.exe/download"
    goto SoftwareUtili
)
if "%softwareChoice%"=="21" (
    start "" "https://ubi.li/4vxt9"
    goto SoftwareUtili
)
if "%softwareChoice%"=="22" (
    start "" "https://webinstallers.gog-statics.com/download/GOG_Galaxy_2.0.exe?payload=z6TgP8u7TnR3kbZbBsJ6HZvcqb4Q7ocn9w7cXKr-uvjp8EAs6SmeyxnuWvlQ50_0DjTZkrbQW2ZrVaggEjttD7lg1YNKvv3rOE6IiIliDN5pkl6us7IIFo5V-LJ27ePfntcEokTpWCwZ6ncXaxrzh44eXAWgBJjHqh2WqwUqG9BJeBgZVd9D4Fb7iC4lXBktlxe0lamSxEiDaRerGQjaCHlLpN-p9-7cleZYW_D0dGc20Og2FABN3FBuGMAvdP_lGyC82QvNvQCIb5bkwrmBiS1c430gmHSV6Q4F5Yc-KYpJ2HTeCCtxuCcD7_XMRfbQt7wHYXELdXL-mK8-NNSqE6TLwQfRWYDfR_q6Nw6uVShfNA9xJOZaSNb3693FcCY21ksdTCdoJvrpTWHhq8jp3KMeU6WOf1xv3rCo7aZBeX-b1N1NeMuQCf2zSN7HKghfrG0iYupOr47BfbL3Yyr1_ufyTpyCB14XhWqJhnyQeRxESTllyvcnc2YQe-AXqOrsaYlK1jXTihiHgpRSlffq2228Vna_cxHcocTUsgNRuuYVYPGPq_9lYd_XZVQUaZ9JeK_rFKGQya5WG6JJDuAzQHXU3KFH-QzJ985bJCapf4rZZbr9rjcipQ_L3Mv-jGEa-DoiVvV0J4145PjocWwcK4Cm53fJFYfHS_0ZqfPwSNzKAAgAUtEriRD1BIT_g9vo7w.."
    goto SoftwareUtili
)
if "%softwareChoice%"=="23" (
    start "" "https://sourceforge.net/projects/crystaldiskmark/files/9.0.1/CrystalDiskMark9_0_1Ads.exe/download"
    goto SoftwareUtili
)
:Exit

if "%LANG%"=="EN" (
    echo Exiting the program...
) else (
    echo Uscita dal programma...
)
pause
exit

