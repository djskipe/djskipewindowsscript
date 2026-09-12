
@echo off
setlocal enabledelayedexpansion

:: Version information
set "CURRENT_VERSION=2.3.0"
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

:CheckForUpdates
echo Checking for updates...

:: Create a temporary file to store the API response
set "temp_file=%temp%\github_response.txt"

:: Use PowerShell to fetch and parse the latest release information
powershell -NoProfile -Command "try { $response = Invoke-RestMethod -Uri '%GITHUB_API_URL%' -UseBasicParsing; Write-Host $response.tag_name; Write-Host $response.assets[0].browser_download_url } catch { Write-Host 'ERROR'; Write-Host 'ERROR' }" > "%temp_file%"

:: Read the response
set "line_count=0"
for /f "tokens=*" %%a in (%temp_file%) do (
    set /a line_count+=1
    if !line_count!==1 set "LATEST_VERSION=%%a"
    if !line_count!==2 set "DOWNLOAD_URL=%%a"
)

:: Remove the temporary file
del "%temp_file%"

:: Check if we got valid data
if "%LATEST_VERSION%"=="ERROR" (
    echo Unable to check for updates. Continuing...
    goto :eof
)

if "%LATEST_VERSION%"=="" (
    echo Unable to check for updates. Continuing...
    goto :eof
)

:: Normalize LATEST_VERSION: strip any leading non-numeric prefix
:: (GitHub tags can be "v2.2.0", "V.2.2.0", etc.)
for /f %%a in ('powershell -NoProfile -Command "('%LATEST_VERSION%' -replace '^[^0-9]+','')"') do set "LATEST_VERSION=%%a"

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
            :: Create an updater script in a temporary location
            echo @echo off > "%temp%\update_script.bat"
            echo timeout /t 2 /nobreak ^> nul >> "%temp%\update_script.bat"
            echo move /y "%~dp0update.bat" "%~nx0" >> "%temp%\update_script.bat"
            echo start "" "%~nx0" >> "%temp%\update_script.bat"
            echo del "%temp%\update_script.bat" >> "%temp%\update_script.bat"
            
            :: Run the updater script
            start cmd /c "%temp%\update_script.bat"
            exit
        ) else (
            echo Error: Update file not found.
            pause
        )
    ) else (
        echo Skipping update...
    )
) else (
    echo You are using the latest version.
)

goto :eof

:: -----------------------------------------------------------------------
:: Checks browser presence (Chrome, Firefox, Edge, Brave, Opera).
:: Sets BROWSER_FOUND=1 if at least one is found, 0 otherwise.
:: -----------------------------------------------------------------------
:CheckBrowserInstalled
set "BROWSER_FOUND=0"
:: --- Chrome ---
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe"              set "BROWSER_FOUND=1"
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"        set "BROWSER_FOUND=1"
if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe"              set "BROWSER_FOUND=1"
:: --- Firefox ---
if exist "%ProgramFiles%\Mozilla Firefox\firefox.exe"                         set "BROWSER_FOUND=1"
if exist "%ProgramFiles(x86)%\Mozilla Firefox\firefox.exe"                   set "BROWSER_FOUND=1"
:: --- Microsoft Edge ---
if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"             set "BROWSER_FOUND=1"
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"       set "BROWSER_FOUND=1"
:: --- Brave ---
if exist "%LocalAppData%\BraveSoftware\Brave-Browser\Application\brave.exe" set "BROWSER_FOUND=1"
if exist "%ProgramFiles%\BraveSoftware\Brave-Browser\Application\brave.exe" set "BROWSER_FOUND=1"
:: --- Opera / Opera GX ---
if exist "%ProgramFiles%\Opera\launcher.exe"                                  set "BROWSER_FOUND=1"
if exist "%LocalAppData%\Programs\Opera\launcher.exe"                        set "BROWSER_FOUND=1"
if exist "%LocalAppData%\Programs\Opera GX\launcher.exe"                    set "BROWSER_FOUND=1"
if exist "%ProgramFiles%\Opera GX\launcher.exe"                              set "BROWSER_FOUND=1"
:: --- Vivaldi ---
if exist "%LocalAppData%\Vivaldi\Application\vivaldi.exe"                    set "BROWSER_FOUND=1"
if exist "%ProgramFiles%\Vivaldi\Application\vivaldi.exe"                    set "BROWSER_FOUND=1"
:: --- Chromium ---
if exist "%LocalAppData%\Chromium\Application\chrome.exe"                    set "BROWSER_FOUND=1"
if exist "%ProgramFiles%\Chromium\Application\chrome.exe"                    set "BROWSER_FOUND=1"
:: --- LibreWolf ---
if exist "%ProgramFiles%\LibreWolf\librewolf.exe"                             set "BROWSER_FOUND=1"
if exist "%LocalAppData%\LibreWolf\librewolf.exe"                             set "BROWSER_FOUND=1"
:: --- Waterfox ---
if exist "%ProgramFiles%\Waterfox\waterfox.exe"                               set "BROWSER_FOUND=1"
if exist "%ProgramFiles(x86)%\Waterfox\waterfox.exe"                         set "BROWSER_FOUND=1"
:: --- Pale Moon ---
if exist "%ProgramFiles%\Pale Moon\palemoon.exe"                              set "BROWSER_FOUND=1"
if exist "%ProgramFiles(x86)%\Pale Moon\palemoon.exe"                        set "BROWSER_FOUND=1"
:: --- Maxthon ---
if exist "%LocalAppData%\Maxthon\Application\maxthon.exe"                    set "BROWSER_FOUND=1"
if exist "%ProgramFiles%\Maxthon\Bin\Maxthon.exe"                            set "BROWSER_FOUND=1"
:: --- UC Browser ---
if exist "%LocalAppData%\UCBrowser\Application\UCBrowser.exe"                set "BROWSER_FOUND=1"
:: --- Slimjet ---
if exist "%ProgramFiles%\Slimjet\slimjet.exe"                                 set "BROWSER_FOUND=1"
if exist "%ProgramFiles(x86)%\Slimjet\slimjet.exe"                           set "BROWSER_FOUND=1"
:: --- Comodo Dragon / IceDragon ---
if exist "%ProgramFiles%\Comodo\Dragon\dragon.exe"                           set "BROWSER_FOUND=1"
if exist "%ProgramFiles(x86)%\Comodo\Dragon\dragon.exe"                     set "BROWSER_FOUND=1"
if exist "%ProgramFiles%\Comodo\IceDragon\icedragon.exe"                    set "BROWSER_FOUND=1"
:: --- Torch ---
if exist "%LocalAppData%\Torch\Application\torch.exe"                        set "BROWSER_FOUND=1"
:: --- Fallback: Windows Registry (catches any browser not listed above) ---
if "%BROWSER_FOUND%"=="0" (
    powershell -NoProfile -Command ^
        "$paths=@('HKLM:\SOFTWARE\Clients\StartMenuInternet','HKCU:\SOFTWARE\Clients\StartMenuInternet');" ^
        "foreach($p in $paths){if(Test-Path $p){$k=Get-ChildItem $p -EA SilentlyContinue;if($k.Count -gt 0){[IO.File]::WriteAllText('%TEMP%\browser_reg.tmp','1');break}}}"
    if exist "%TEMP%\browser_reg.tmp" (
        set "BROWSER_FOUND=1"
        del "%TEMP%\browser_reg.tmp"
    )
)
goto :eof

:: -----------------------------------------------------------------------
:: If no browser is found, installs Brave (preferred) via winget first,
:: then via direct curl download. Falls back to curl for all URL-opens.
:: -----------------------------------------------------------------------
:EnsureBrowserAvailable
if "%BROWSER_FOUND%"=="1" goto :eof
if "%LANG%"=="EN" (
    echo No browser detected. Attempting to install Brave automatically...
) else (
    echo Nessun browser rilevato. Installazione automatica di Brave in corso...
)
set "BRAVE_OK=0"
if "%WINGET_FOUND%"=="1" (
    powershell -NoProfile -Command "winget install -e --id Brave.Brave --accept-package-agreements --accept-source-agreements -h"
    if !errorlevel! equ 0 set "BRAVE_OK=1"
)
if "%BRAVE_OK%"=="0" (
    if "%LANG%"=="EN" (
        echo winget failed or unavailable. Downloading Brave installer directly...
    ) else (
        echo winget non disponibile o fallito. Download diretto di Brave in corso...
    )
    curl -L --progress-bar -o "%TEMP%\BraveSetup.exe" "https://laptop-updates.brave.com/latest/winx64"
    if exist "%TEMP%\BraveSetup.exe" (
        "%TEMP%\BraveSetup.exe" /silent /install
        del "%TEMP%\BraveSetup.exe"
        set "BRAVE_OK=1"
    )
)
if "%BRAVE_OK%"=="1" (
    if "%LANG%"=="EN" (
        echo Brave installed. Re-checking browser availability...
    ) else (
        echo Brave installato. Nuovo controllo della disponibilita' del browser...
    )
    call :CheckBrowserInstalled
) else (
    if "%LANG%"=="EN" (
        echo Could not install Brave. Browser-based downloads will use curl/winget instead.
    ) else (
        echo Impossibile installare Brave. I download che richiedono browser useranno curl/winget.
    )
)
goto :eof

:: -----------------------------------------------------------------------
:: Checks whether the Microsoft Store app is registered on this machine.
:: winget and Store-based installers depend on it, so if it's missing
:: (common after aggressive debloating) it tries to re-register/restore it.
:: Sets MSSTORE_FOUND=1 if present or successfully restored, 0 otherwise.
:: -----------------------------------------------------------------------
:CheckMicrosoftStore
set "MSSTORE_FOUND=0"
powershell -NoProfile -Command "if (Get-AppxPackage -Name Microsoft.WindowsStore) { exit 0 } else { exit 1 }" >nul 2>&1
if %errorlevel%==0 set "MSSTORE_FOUND=1"

if "%MSSTORE_FOUND%"=="0" (
    if "%LANG%"=="EN" (
        echo Microsoft Store not found. Attempting to restore it...
    ) else (
        echo Microsoft Store non trovato. Tentativo di ripristino in corso...
    )
    powershell -NoProfile -Command "Get-AppxPackage -AllUsers Microsoft.WindowsStore | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\AppXManifest.xml\" }" >nul 2>&1
    powershell -NoProfile -Command "if (Get-AppxPackage -Name Microsoft.WindowsStore) { exit 0 } else { exit 1 }" >nul 2>&1
    if !errorlevel!==0 (
        set "MSSTORE_FOUND=1"
        if "%LANG%"=="EN" (
            echo Microsoft Store has been restored.
        ) else (
            echo Microsoft Store e' stato ripristinato.
        )
    ) else (
        if "%LANG%"=="EN" (
            echo Could not restore Microsoft Store automatically. Store-dependent installs may fail.
        ) else (
            echo Impossibile ripristinare automaticamente il Microsoft Store. Le installazioni che ne dipendono potrebbero fallire.
        )
    )
)
goto :eof

:: -----------------------------------------------------------------------
:: Checks whether winget (App Installer) is available and installs it
:: if missing, since several installs below rely on it.
:: Sets WINGET_FOUND=1 if available (or successfully installed), 0 otherwise.
:: -----------------------------------------------------------------------
:CheckWinget
set "WINGET_FOUND=0"
where winget >nul 2>&1
if %errorlevel%==0 (
    set "WINGET_FOUND=1"
) else (
    if "%LANG%"=="EN" (
        echo winget was not found. Attempting to install the App Installer...
    ) else (
        echo winget non e' stato trovato. Tentativo di installazione dell'App Installer in corso...
    )
    powershell -NoProfile -Command "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile \"$env:TEMP\AppInstaller.msixbundle\"; Add-AppxPackage -Path \"$env:TEMP\AppInstaller.msixbundle\"" >nul 2>&1
    where winget >nul 2>&1
    if !errorlevel!==0 (
        set "WINGET_FOUND=1"
        if "%LANG%"=="EN" (
            echo winget has been installed successfully.
        ) else (
            echo winget e' stato installato con successo.
        )
    ) else (
        if "%LANG%"=="EN" (
            echo Could not install winget automatically. Affected software will be downloaded manually instead.
        ) else (
            echo Impossibile installare winget automaticamente. I software interessati verranno scaricati manualmente.
        )
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
    echo:                 DJ SKIPE WINDOWS SCRIPT v2.3.0
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
    echo:                 DJ SKIPE WINDOWS SCRIPT v2.3.0
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
    echo Downloading Windows 11 debloater...
) else (
    echo Download del debloater di Windows 11...
)

set "TEMP_DIR=%TEMP%\win11debloat"
set "ZIP_FILE=%TEMP_DIR%\main.zip"

if exist "%TEMP_DIR%" rmdir /s /q "%TEMP_DIR%"
mkdir "%TEMP_DIR%"

REM Download ZIP
echo Downloading...
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://github.com/raphire/win11debloat/archive/refs/heads/master.zip', '%ZIP_FILE%')"

if not exist "%ZIP_FILE%" (
    if "%LANG%"=="EN" (
        echo Download failed
    ) else (
        echo Download fallito
    )
    pause
    goto :MainMenu
)

REM Extract
echo Extracting...
powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%TEMP_DIR%'"

REM Find and run first .bat file
echo Launching...
for /r "%TEMP_DIR%\win11debloat-master" %%F in (*.bat) do (
    powershell -Command "Start-Process '%%F' -Verb RunAs"
    goto :Success
)

if "%LANG%"=="EN" (
    echo No batch file found
) else (
    echo Nessun file batch trovato
)
pause
goto :MainMenu

:Success
pause
goto :MainMenu


:InstallBaseSoftwareCustomEdition

if "%LANG%"=="EN" (
    echo Running pre-install checks...
) else (
    echo Controlli preliminari in corso...
)
call :CheckBrowserInstalled
call :CheckMicrosoftStore
call :CheckWinget
call :EnsureBrowserAvailable

if "%LANG%"=="EN" (
    echo Downloading latest PowerShell...
) else (
    echo Download dell'ultima versione di PowerShell...
)

curl -L -o "%TEMP%\PowerShell-latest-win-x64.msi" "https://github.com/PowerShell/PowerShell/releases/latest/download/PowerShell-win-x64.msi"

if exist "%TEMP%\PowerShell-latest-win-x64.msi" (

    if "%LANG%"=="EN" (
        echo Installing PowerShell...
    ) else (
        echo Installazione di PowerShell in corso...
    )

    msiexec /i "%TEMP%\PowerShell-latest-win-x64.msi" /qn /norestart

    if %errorlevel% neq 0 (
        if "%LANG%"=="EN" (
            echo Error installing PowerShell.
        ) else (
            echo Errore durante l'installazione di PowerShell.
        )
    ) else (
        if "%LANG%"=="EN" (
            echo PowerShell has been successfully installed.
        ) else (
            echo PowerShell è stato installato con successo.
        )
    )

    :: Elimina il file MSI
    del /f /q "%TEMP%\PowerShell-latest-win-x64.msi"

) else (

    if "%LANG%"=="EN" (
        echo Failed to download PowerShell.
    ) else (
        echo Download di PowerShell non riuscito.
    )

)

if "%LANG%"=="EN" (
    echo.
    echo Installing base software...
    echo Downloading Telegram, WhatsApp and WeChat, using the browser or winget depending on what's available...
    echo Installing System Informer...
    echo Downloads completed.
    echo.
    echo Base software installed.
    echo Installing Custom Edition Software by dj skipe.
    echo Done.
) else (
    echo.
    echo Installazione del software base in corso...
    echo Scarico Telegram, WhatsApp e WeChat, usando il browser o winget a seconda di cosa e' disponibile...
    echo Installazione di System Informer in corso...
    echo Download completati.
    echo.
    echo Software base installato.
    echo Installazione del Software Custom Edition by dj skipe.
    echo Fine.
)

:: Ninite
start "" "https://ninite.com/7zip-brave-discord-epic-handbrake-notepadplusplus-operaChromium-putty-python3-steam-teamviewer15-vlc/"

:: EA App
curl -L -o "%USERPROFILE%\Downloads\EAappInstaller.exe" "https://origin-a.akamaihd.net/EA-Desktop-Client-Download/installer-releases/EAappInstaller.exe"
if exist "%USERPROFILE%\Downloads\EAappInstaller.exe" (
    start "" "%USERPROFILE%\Downloads\EAappInstaller.exe"
)

:: GOG Galaxy
curl -L -o "%USERPROFILE%\Downloads\GOG_Galaxy_2.0.exe" "https://webinstallers.gog-statics.com/download/GOG_Galaxy_2.0.exe"
if exist "%USERPROFILE%\Downloads\GOG_Galaxy_2.0.exe" (
    start "" "%USERPROFILE%\Downloads\GOG_Galaxy_2.0.exe"
)

:: Ubisoft Connect
curl -L -o "%USERPROFILE%\Downloads\Ubisoft_Connect.exe" "https://ubi.li/4vxt9"
if exist "%USERPROFILE%\Downloads\Ubisoft_Connect.exe" (
    start "" "%USERPROFILE%\Downloads\Ubisoft_Connect.exe"
)

:: Rockstar Games Launcher
curl -L -o "%USERPROFILE%\Downloads\Rockstar-Games-Launcher.exe" "https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe"
if exist "%USERPROFILE%\Downloads\Rockstar-Games-Launcher.exe" (
    start "" "%USERPROFILE%\Downloads\Rockstar-Games-Launcher.exe"
)

:: Amazon Games
curl -L -o "%USERPROFILE%\Downloads\AmazonGamesSetup.exe" "https://download.amazongames.com/AmazonGamesSetup.exe"
if exist "%USERPROFILE%\Downloads\AmazonGamesSetup.exe" (
    start "" "%USERPROFILE%\Downloads\AmazonGamesSetup.exe"
)

:: Steam
if "%LANG%"=="EN" (
    echo Installing Steam...
) else (
    echo Installazione di Steam in corso...
)
if "%BROWSER_FOUND%"=="1" (
    start "" "https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe"
) else (
    if "%WINGET_FOUND%"=="1" (
        powershell -NoProfile -Command "winget install -e --id Valve.Steam --accept-package-agreements --accept-source-agreements -h"
    ) else (
        curl -L --progress-bar -o "%USERPROFILE%\Downloads\SteamSetup.exe" "https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe"
        if exist "%USERPROFILE%\Downloads\SteamSetup.exe" start "" "%USERPROFILE%\Downloads\SteamSetup.exe"
    )
)

:: Epic Games Launcher
if "%LANG%"=="EN" (
    echo Installing Epic Games Launcher...
) else (
    echo Installazione di Epic Games Launcher in corso...
)
if "%BROWSER_FOUND%"=="1" (
    start "" "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.exe"
) else (
    if "%WINGET_FOUND%"=="1" (
        powershell -NoProfile -Command "winget install -e --id EpicGames.EpicGamesLauncher --accept-package-agreements --accept-source-agreements -h"
    ) else (
        curl -L --progress-bar -o "%USERPROFILE%\Downloads\EpicGamesLauncherInstaller.exe" "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.exe"
        if exist "%USERPROFILE%\Downloads\EpicGamesLauncherInstaller.exe" start "" "%USERPROFILE%\Downloads\EpicGamesLauncherInstaller.exe"
    )
)

:: Telegram
if "%BROWSER_FOUND%"=="1" (
    if "%LANG%"=="EN" (
        echo Browser detected: opening Telegram download page...
    ) else (
        echo Browser rilevato: apertura pagina di download di Telegram...
    )
    start "" "https://telegram.org/dl/desktop/win64"
) else (
    if "%WINGET_FOUND%"=="1" (
        if "%LANG%"=="EN" (
            echo No browser detected: installing Telegram via winget...
        ) else (
            echo Nessun browser rilevato: installazione di Telegram tramite winget in corso...
        )
        powershell -NoProfile -Command "winget install -e --id Telegram.TelegramDesktop --accept-package-agreements --accept-source-agreements -h"
    ) else (
        if "%LANG%"=="EN" (
            echo No browser and no winget detected: downloading Telegram directly...
        ) else (
            echo Nessun browser e nessun winget rilevati: download diretto di Telegram in corso...
        )
        curl -L -o "%USERPROFILE%\Downloads\TelegramSetup.exe" "https://telegram.org/dl/desktop/win64"
        if exist "%USERPROFILE%\Downloads\TelegramSetup.exe" start "" "%USERPROFILE%\Downloads\TelegramSetup.exe"
    )
)

:: WhatsApp
if "%BROWSER_FOUND%"=="1" (
    if "%LANG%"=="EN" (
        echo Browser detected: opening WhatsApp download page...
    ) else (
        echo Browser rilevato: apertura pagina di download di WhatsApp...
    )
    start "" "https://get.microsoft.com/installer/download/9NKSQGP7F2NH?cid=website_cta_psi"
) else (
    if "%LANG%"=="EN" (
        echo No browser detected: downloading WhatsApp via command line...
    ) else (
        echo Nessun browser rilevato: download di WhatsApp da linea di comando in corso...
    )
    curl -L -o "%USERPROFILE%\Downloads\WhatsApp Installer.exe" "https://get.microsoft.com/installer/download/9NKSQGP7F2NH?cid=website_cta_psi/"
    if exist "%USERPROFILE%\Downloads\WhatsApp Installer.exe" (
        start "" "%USERPROFILE%\Downloads\WhatsApp Installer.exe"
    )
)

:: WeChat
:: WeChat is the one most likely to silently fail: winget without the
:: agreement flags can hang waiting for a confirmation the script can't
:: give it. We pass the flags, check the actual exit code, and fall back
:: to a direct download if winget is unavailable or still fails.
if "%LANG%"=="EN" (
    echo Installing WeChat...
) else (
    echo Installazione di WeChat in corso...
)
set "WECHAT_OK=0"
if "%WINGET_FOUND%"=="1" (
    powershell -NoProfile -Command "winget install -e --id Tencent.WeChat --accept-package-agreements --accept-source-agreements -h"
    if !errorlevel! equ 0 set "WECHAT_OK=1"
)
if "%WECHAT_OK%"=="0" (
    if "%LANG%"=="EN" (
        echo winget install for WeChat failed or is unavailable, falling back to a direct download...
    ) else (
        echo Installazione di WeChat tramite winget non riuscita o non disponibile, download diretto in corso come alternativa...
    )
    curl -L -o "%USERPROFILE%\Downloads\WeChatSetup.exe" "https://dldir1.qq.com/weixin/Windows/WeChatSetup.exe"
    if exist "%USERPROFILE%\Downloads\WeChatSetup.exe" (
        start "" "%USERPROFILE%\Downloads\WeChatSetup.exe"
    ) else (
        if "%LANG%"=="EN" (
            echo Failed to download WeChat automatically. Please install it manually.
        ) else (
            echo Download automatico di WeChat non riuscito. Installalo manualmente.
        )
    )
)

:: System Informer
if "%WINGET_FOUND%"=="1" (
    powershell -NoProfile -Command "winget install -e --id WinsiderSS.SystemInformer --accept-package-agreements --accept-source-agreements -h"
) else (
    if "%LANG%"=="EN" (
        echo winget is not available: skipping System Informer installation.
    ) else (
        echo winget non disponibile: installazione di System Informer saltata.
    )
)

pause
goto :MainMenu


:InstallBaseSoftware
if "%LANG%"=="EN" (
    echo Running pre-install checks...
) else (
    echo Controlli preliminari in corso...
)
call :CheckBrowserInstalled
call :CheckMicrosoftStore
call :CheckWinget
call :EnsureBrowserAvailable

if "%LANG%"=="EN" (
    echo.
    echo Installing base software...
    echo.
) else (
    echo.
    echo Installazione del software base in corso...
    echo.
)

if "%BROWSER_FOUND%"=="1" (
    :: Browser available: Ninite handles everything in one shot
    if "%LANG%"=="EN" (
        echo Browser detected: opening Ninite bundle...
    ) else (
        echo Browser rilevato: apertura bundle Ninite...
    )
    start "" "https://ninite.com/7zip-brave-foxit-openoffice-vlc/"
) else (
    :: No browser: install each app via winget
    if "%WINGET_FOUND%"=="1" (
        if "%LANG%"=="EN" (
            echo No browser: installing apps via winget...
        ) else (
            echo Nessun browser: installazione tramite winget...
        )
        powershell -NoProfile -Command "winget install -e --id 7zip.7zip              --accept-package-agreements --accept-source-agreements -h"
        powershell -NoProfile -Command "winget install -e --id VideoLAN.VLC           --accept-package-agreements --accept-source-agreements -h"
        powershell -NoProfile -Command "winget install -e --id Notepad++.Notepad++    --accept-package-agreements --accept-source-agreements -h"
        powershell -NoProfile -Command "winget install -e --id Foxit.FoxitReader      --accept-package-agreements --accept-source-agreements -h"
        powershell -NoProfile -Command "winget install -e --id Apache.OpenOffice      --accept-package-agreements --accept-source-agreements -h"
        powershell -NoProfile -Command "winget install -e --id Brave.Brave            --accept-package-agreements --accept-source-agreements -h"
    ) else (
        if "%LANG%"=="EN" (
            echo Neither browser nor winget is available. Please install software manually.
        ) else (
            echo Ne browser ne winget sono disponibili. Installa il software manualmente.
        )
    )
)

if "%LANG%"=="EN" (
    echo.
    echo Base software installation complete.
) else (
    echo.
    echo Installazione del software base completata.
)
pause
goto :MainMenu

:RunOfficeToolPlus
set "downloadPath=%UserProfile%\Downloads\OfficeToolPlus.zip"
set "extractPath=%UserProfile%\Downloads\OTP"
set "urlFile=%TEMP%\otp_url.txt"

:: ---- Step 1: resolve latest release URL via GitHub API ----
if "%LANG%"=="EN" (
    echo [1/4] Contacting GitHub API to find the latest release...
) else (
    echo [1/4] Contatto le API GitHub per trovare l'ultima release...
)

if exist "%urlFile%" del "%urlFile%"

powershell -NoProfile -Command ^
  "$r = Invoke-RestMethod -Uri 'https://api.github.com/repos/YerongAI/Office-Tool/releases/latest' -UseBasicParsing;" ^
  "$a = $r.assets | Where-Object { $_.name -like 'Office_Tool_with_runtime*x64.zip' } | Select-Object -First 1;" ^
  "if ($a) { $a.browser_download_url | Out-File -Encoding ascii '%urlFile%' }" ^
  "else { Write-Host 'ASSET_NOT_FOUND' }"

if not exist "%urlFile%" (
    if "%LANG%"=="EN" (
        echo ERROR: Could not reach GitHub API or no matching asset found.
        echo Check your internet connection and try again.
    ) else (
        echo ERRORE: Impossibile raggiungere le API GitHub o nessun asset trovato.
        echo Controlla la connessione internet e riprova.
    )
    pause
    goto :MainMenu
)

:: Read the URL from the temp file into OTP_URL
set /p OTP_URL=<"%urlFile%"
del "%urlFile%"

if "%LANG%"=="EN" (
    echo     Found: %OTP_URL%
) else (
    echo     Trovato: %OTP_URL%
)

:: ---- Step 2: download with curl (shows native progress bar) ----
if "%LANG%"=="EN" (
    echo [2/4] Downloading...
) else (
    echo [2/4] Download in corso...
)

if exist "%downloadPath%" del "%downloadPath%"

curl -L --progress-bar -o "%downloadPath%" "%OTP_URL%"

if not exist "%downloadPath%" (
    if "%LANG%"=="EN" (
        echo ERROR: Download failed. Check your connection and try again.
    ) else (
        echo ERRORE: Download fallito. Controlla la connessione e riprova.
    )
    pause
    goto :MainMenu
)

if "%LANG%"=="EN" (
    echo     Download complete.
) else (
    echo     Download completato.
)

:: ---- Step 3: extract ----
if "%LANG%"=="EN" (
    echo [3/4] Extracting files...
) else (
    echo [3/4] Estrazione dei file in corso...
)

if not exist "%extractPath%" mkdir "%extractPath%"

powershell -NoProfile -Command "Expand-Archive -Path '%downloadPath%' -DestinationPath '%extractPath%' -Force"
del "%downloadPath%"

if "%LANG%"=="EN" (
    echo     Extraction complete.
) else (
    echo     Estrazione completata.
)

:: ---- Step 4: launch ----
if "%LANG%"=="EN" (
    echo [4/4] Launching Office Tool Plus...
) else (
    echo [4/4] Avvio di Office Tool Plus...
)

:: Use PowerShell to find and start the exe — handles spaces in path reliably
powershell -NoProfile -Command "$exe = Get-ChildItem -Path '%extractPath%' -Recurse -Filter 'Office Tool Plus.exe' -ErrorAction SilentlyContinue | Select-Object -First 1; if ($exe) { Write-Host ('    Found: ' + $exe.FullName); Start-Process $exe.FullName } else { Write-Host 'ERRORE: Office Tool Plus.exe non trovato dopo l estrazione.' }"

:OTPDone
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
    start "" "https://buzzheavier.com/b9gv4d2lt8x5"
    goto :DownWindows
)

if "%winChoice%"=="2" (
    cls
    echo: Downloading Windows 10...
    start "" "https://buzzheavier.com/1yn7wu9kb5sg"
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
    start "" "https://buzzheavier.com/nha1fymh8qa3"
    goto WinServer
)
if "%editionChoice%"=="2" (
    start "" "https://buzzheavier.com/ib7su6egmcs6"
    goto WinServer
)
if "%editionChoice%"=="3" (
    start "" "https://buzzheavier.com/p2fll4bgh2yf"
    goto WinServer
)
if "%editionChoice%"=="4" (
    start "" "https://archive.org/download/WinSrv2016ITA/it_windows_server_2016_x64_dvd_9720043.iso"
    goto WinServer
)
if "%editionChoice%"=="5" (
    start "" "https://archive.org/download/WinServer2012x64ITA/it_windows_server_2012_x64_dvd_915486.iso"
    goto WinServer
)
if "%editionChoice%"=="6" (
    start "" "https://archive.org/download/WinServer2008R2SP1x64ITA/it_windows_server_2008_r2_with_sp1_x64_dvd_617391.iso"
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
echo:             [3] Powershell 7                                          [23] WinPE Sergei Strelect
echo:             [4] Adobe Acrobat Pro 2026                                [24] MAGIX Vegas Pro 2026
echo:             [5] Adobe Photoshop 2026                                  [25] WinPE Macrium Reflect X
echo:             [6] Adobe Premiere Pro 2026                               [26] ABBYY FineReader Corporate
echo:             [7] Adobe Illustrator 2026                                [27] WeMod Patcher
echo:             [8] Adobe After Effects 2026
echo:             [9] MiniTool Partition Wizard
echo:             [10] Revo Uninstaller Pro
echo:             [11] Poweroff
echo:             [12] Glasswire
echo:             [13] Windows XP Activator       
echo:             [14] WinRar
echo:             [15] Topaz Video AI 
echo:             [16] StartAllBack 
echo:             [17] Hard Disk Sentinel Pro 
echo:             [18] Advanced IP Scanner
echo:             [19] Aida64 
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
    start "" "https://github.com/TheMythologist/GenP/releases/download/v4.2.1-hotfix/GenP-v4.2.1.exe"
    goto Extra
)

if "%extraChoice%"=="2" (
    start "" "https://www.mediafire.com/file/fjdzbjnkqto0cby/Wise+Care+365+Pro+8.0.5.733.zip/file"
    goto Extra
)
if "%extraChoice%"=="3" (
    start "" "https://github.com/PowerShell/PowerShell/releases/download/v7.6.6/PowerShell-7.6.6-win-x64.msi"
    goto Extra
)
if "%extraChoice%"=="4" (
    start "" "https://vikingfile.com/f/iKrdgQkC8t#AdobeAcrobatProDC2026.002.21901x64Repack.exe
    goto Extra
)
if "%extraChoice%"=="5" (
    start "" "https://vik1ngfile.site/f/cHTpRDGAgA#AdobePhotoshop2026v27.10.0.26x64Repack.exe"
    goto Extra
)
if "%extraChoice%"=="6" (
    start "" "https://fuckingfast.net/p8rsonalgmwi"
    goto Extra
)
if "%extraChoice%"=="7" (
    start "" "https://vik1ngfile.site/f/PFcPLrUGHn#AdobeIllustrator2026v30.8.1.1x64Repack.exe"
    goto Extra
)
if "%extraChoice%"=="8" (
    start "" "https://fuckingfast.net/00lyc1htt0sd"
    goto Extra
)
if "%extraChoice%"=="9" (
    start "" "https://www.mediafire.com/file/eqe4lhdvh406hz2/MiniTool+Partition+Wizard+Technician+13.9.zip/file"
    goto Extra
)
if "%extraChoice%"=="10" (
    start "" "https://www.mediafire.com/file/4hh7on9sb309h13/Revo+Uninstaller+Pro+5.5.2.7z/file"
    goto Extra
)
if "%extraChoice%"=="11" (
    start "" "https://download1509.mediafire.com/fsep1extw7ogjAaBtolj-EW4KJ98qspT2vIrbCg3UmGqbJNa_GHy5Dsr9bt0xsZRtK_o9FzAMxzeHB5tPUqhGe-AUEEhr1QZZ4qEhRvXUJYqswTsGDpKwQ_R8RtTqbGesqsYpfP_56eT-WS47HodFUv86_chCDMfj2dK8xBD7FfFy7M/oa2j0ymtjjgzr1s/poweroff-3.0.1.3.zip"
    goto Extra
)
if "%extraChoice%"=="12" (
    start "" "https://www.mediafire.com/file/hvj5tcpk83eifne/GlassWire+Elite+3.8.1061.7z/file"
    goto Extra
)
if "%extraChoice%"=="13" (
    start "" "https://archive.org/download/xp_activate32_202305/xp_activate32.zip"
    goto Extra
)
if "%extraChoice%"=="14" (
    start "" "https://www.mediafire.com/file/rs2fkd9cl6kgoy6/WinRAR+7.30.zip/file"
    goto Extra
)
if "%extraChoice%"=="15" (
    start "" "https://www.mediafire.com/file/9evqtaki0586tqj/TopazVideoAI7.1.6x64TeamV.R.7z/file"
    goto Extra
)
if "%extraChoice%"=="16" (
    start "" "https://www.mediafire.com/file/qe7vnx16wg6hwlh/StartAllBack+3.9.25.5386.zip/file"
    goto Extra
)
if "%extraChoice%"=="17" (
    start "" "https://www.mediafire.com/file/su817g6k97xyv1w/Hard+Disk+Sentinel+Pro+6.40.4.zip/file"
    goto Extra
)
if "%extraChoice%"=="18" (
    start "" "https://www.advanced-ip-scanner.com/it/download/"
    goto Extra
)
if "%extraChoice%"=="19" (
    start "" "https://www.mediafire.com/file/w9wjlj6vpzzbekl/AIDA64+v8.35.8400+(All+Editions).zip/file"
    goto Extra
)
if "%extraChoice%"=="20" (
    start "" "https://www.mediafire.com/file/bgjgtwh2r5vka9b/Any_Excel_Password_Recovery_11.8.0.7z/file"
    goto Extra
)
if "%extraChoice%"=="21" (
    start "" "https://www.mediafire.com/file/diw7b8ajm8ld4as/Revo+Uninstaller+Pro+Portable+5.5.2.zip/file"
    goto Extra
)
if "%extraChoice%"=="22" (
    start "" "https://www.mediafire.com/file/lq1j5csak1ebwlu/Acronis+True+Image+Build+42902+Bootable+ISO.iso/file"
    goto Extra
)
if "%extraChoice%"=="23" (
    start "" "https://www.mediafire.com/file/5gmyyc2pp60mo1s/WinPE11_10_Sergei_Strelec_x64_2026.09.08_English.zip/file"
    goto Extra
)
if "%extraChoice%"=="24" (
    start "" "https://www.mediafire.com/file/kyh57a5mhj1x1l2/BorisFXVEGASPro2026.0.3.189x64.7z/file"
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
    start "" "https://www.mediafire.com/file/v9pc5hc9wfy82wn/WandEnhancer+2.2.0.zip/file"
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
    start "" "https://www.mediafire.com/file/zlk15pdhfkmgd8q/MacriumRescueWinPE_Win10.iso/file"
    goto Extra
)

if "%macriumChoice%"=="2" (
    start "" "https://www.mediafire.com/file/vpbwk3p1wzrwa5n/MacriumRescueWinPE_Win11.iso/file"
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
    echo:             [4] VLC Media Player                                   [24] Opera
    echo:             [6] Notepad++                                          [25] Brave
    echo:             [7] Visual Studio Code                                 [26] Handbrake
    echo:             [8] OBS Studio                                         [27] KeePass Password Manager    
    echo:             [9] Python                                             [28] OpenOffice
    echo:             [10] CPU-Z                                             [29] Libreoffice
    echo:             [11] GPU-Z                                             [30] qBittorent
    echo:             [12] Discord                                           [31] Adobe Reader                                                           
    echo:             [13] TeamViewer                                        [32] DDU - Display Driver Uninstaller
    echo:             [14] Spotify                                           [33] Driver Store Explorer                                  
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
    echo:             [4] VLC Media Player                                   [24] Opera
    echo:             [6] Notepad++                                          [25] Brave 
    echo:             [7] Visual Studio Code                                 [26] Handbrake
    echo:             [8] OBS Studio                                         [27] KeePass Password Manager  
    echo:             [9] Python                                             [28] OpenOffice
    echo:             [10] CPU-Z                                             [29] Libreoffice
    echo:             [11] GPU-Z                                             [30] qBittorent
    echo:             [12] Discord                                           [31] Adobe Reader                                                         
    echo:             [13] TeamViewer                                        [32] DDU - Display Driver Uninstaller
    echo:             [14] Spotify                                           [33] Driver Store Explorer
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
    set /p softwareChoice="      Choose Useful Software [1-23,0]: "
) else (
    set /p softwareChoice="      Scegli Software Utili [1-23,0]: "
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
    start "" "https://get.videolan.org/vlc/3.0.23/win32/vlc-3.0.23-win32.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="5" (
    start "" "https://winrar.it/prelievo_ok.php?url=prelievo/WinRAR-x64-720b2it.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="6" (
    start "" "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.9.2/npp.8.9.2.Installer.x64.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="7" (
    start "" "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
    goto SoftwareUtili
)
if "%softwareChoice%"=="8" (
    start "" "https://cdn-fastly.obsproject.com/downloads/OBS-Studio-32.0.4-Windows-x64-Installer.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="9" (
    start "" "https://www.python.org/ftp/python/3.14.3/python-3.14.3-amd64.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="10" (
    start "" "https://download.cpuid.com/cpu-z/cpu-z_2.18-en.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="11" (
    start "" "https://www.guru3d.com/getdownload/2c1b2414f56a6594ffef91236a87c0e976d52e0518b4303846bab016c2f20c7c4d6ce7dfe19a0bc843da8d448bbb670058b0c9ee9a26f5cf49bc39c97da070e6eb314629af3da2d24ab0413917f73b946419b5af447da45cefb517a0840ad3003abff4f9d5fe7828bbbb910ee270b40528035fb17c6b4c80012cb4bd3140fa764f68932d48b5bb53887b044417f16e18cb59c8aca2a366e80787b52d8a915d2bf3ecdac9dae6c8bf601ba1d54d0d644f20e6189ac57e"
    goto SoftwareUtili
)
if "%softwareChoice%"=="12" (
    start "" "https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x64
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
    start "" "https://www.hwinfo.com/files/hwi64_834.exe"
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
    start "" "https://sourceforge.net/projects/crystaldiskinfo/files/latest/download"
    goto SoftwareUtili
)
if "%softwareChoice%"=="24" (
    start "" "https://www.opera.com/it/computer/thanks?ni=stable&os=windows"
    goto SoftwareUtili
)
if "%softwareChoice%"=="25" (
    start "" "https://laptop-updates.brave.com/download/BRV010?bitness=64"
    goto SoftwareUtili
)
if "%softwareChoice%"=="26" (
    start "" "https://handbrake.fr/rotation.php?file=HandBrake-1.10.2-x86_64-Win_GUI.exe"
    goto SoftwareUtili
)
if "%softwareChoice%"=="27" (
    start "" "https://sourceforge.net/projects/keepass/files/KeePass%202.x/2.61/KeePass-2.61-Setup.exe/download"
    goto SoftwareUtili
)
if "%softwareChoice%"=="28" (
    start "" "https://sourceforge.net/projects/openofficeorg.mirror/files/4.1.16/binaries/it/Apache_OpenOffice_4.1.16_Win_x86_install_it.exe/download"
    goto SoftwareUtili
)
if "%softwareChoice%"=="29" (
    start "" "https://it.libreoffice.org/donazioni/dl/win-x86_64/26.2.1/it/LibreOffice_26.2.1_Win_x86-64.msi"
    goto SoftwareUtili
)
if "%softwareChoice%"=="30" (
    start "" "https://sourceforge.net/projects/qbittorrent/files/qbittorrent-win32/"
    goto SoftwareUtili
)
if "%softwareChoice%"=="31" (
    start "" "https://get.adobe.com/it/reader/download?os=Windows+10&name=Reader+2025.001.20997+Italian+for+Windows+%28Recommended%29&lang=it&nativeOs=Windows+10&accepted=cr&declined=mss%2Chrm&preInstalled=&site=landing"
    goto SoftwareUtili
)
if "%softwareChoice%"=="32" (
    start "" "https://www.guru3d.com/getdownload/2c1b2414f56a6594ffef91236a87c0e976d52e0519bd313846bab016c2f20c7c4d6ce7dfe19a0bc843da8d448bbb670058b0c9ee9a26f5cf49bc39c97da070e6eb314629af3da2d24ab0413917f73b946419b5af447da45cefb517a0840ad3003abff4f9d5fe7828bbbb910ee270b704333a0283584211b2623dc4ca585fe82d4774d04b4af4b257b930215e13b2364fde129ef8d1f274e01f97997bd9cd142bafb4819bb6a291e23d01ac99"
    goto SoftwareUtili
)
if "%softwareChoice%"=="33" (
    start "" "https://github.com/lostindark/DriverStoreExplorer/releases/download/v0.12.145/DriverStoreExplorer.v0.12.145.zip"
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

