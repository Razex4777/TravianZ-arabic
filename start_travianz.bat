@echo off
title TravianZ - One Click Starter
color 0A

echo.
echo  ========================================
echo     TravianZ - One Click Starter
echo  ========================================
echo.
echo  Choose how to run the server:
echo.
echo    [1] Docker  (recommended)
echo    [2] XAMPP   (no Docker needed)
echo    [3] Exit
echo.
set /p choice="  Your choice (1/2/3): "

if "%choice%"=="1" goto :DOCKER
if "%choice%"=="2" goto :XAMPP
if "%choice%"=="3" exit /b
echo  Invalid choice. Try again.
pause
exit /b

REM =============================================
REM            FIX INSTALL FOLDER
REM =============================================
:FIX_INSTALL
set "TARGET=%~1"
if not exist "%TARGET%install" (
    for /d %%D in ("%TARGET%installed_*") do (
        echo  [FIX] Renaming %%~nxD back to install...
        ren "%%D" install
        goto :fix_flag
    )
)
:fix_flag
if exist "%TARGET%var\installed" (
    echo  [FIX] Removing old installed flag...
    del /F /Q "%TARGET%var\installed" >nul 2>&1
)
exit /b

REM =============================================
REM              DOCKER MODE
REM =============================================
:DOCKER
echo.
echo  --- Docker Mode ---
echo.

docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo  [ERROR] Docker not installed!
    echo  Download: https://www.docker.com/products/docker-desktop/
    start https://www.docker.com/products/docker-desktop/
    pause
    exit /b
)
echo  [OK] Docker installed.

docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo  [START] Launching Docker Desktop...
    start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe" 2>nul
    set /a counter=0
    :dwait
    set /a counter+=1
    if %counter% gtr 24 (
        echo  [ERROR] Docker Desktop didn't start. Open it manually.
        pause
        exit /b
    )
    timeout /t 5 /nobreak >nul
    docker info >nul 2>&1
    if %errorlevel% neq 0 (
        echo           Waiting... (%counter%/24)
        goto dwait
    )
)
echo  [OK] Docker Desktop running!

REM Fix install folder in source
call :FIX_INSTALL "%~dp0"

REM Create .env if missing
if not exist "%~dp0.env" (
    if exist "%~dp0.env.example" (
        copy "%~dp0.env.example" "%~dp0.env" >nul
        echo  [OK] Created .env
    )
)

echo  [BUILD] Starting containers...
echo.
docker compose up -d --build
if %errorlevel% neq 0 (
    echo  [ERROR] Failed. Is Docker Desktop running?
    pause
    exit /b
)

echo.
echo  ========================================
echo       SERVER IS RUNNING! (Docker)
echo  ========================================
echo.
timeout /t 10 /nobreak >nul
start http://localhost:8080/install

echo  -------------------------------------------
echo   DATABASE SETTINGS:
echo.
echo   SQL Hostname:  db
echo   Port:          3306
echo   Username:      travianz
echo   Password:      travianzpass
echo   DB name:       travian
echo   Prefix:        s1_
echo   Type:          MYSQLi
echo.
echo   !! Use "db" NOT "localhost" !!
echo  -------------------------------------------
echo.
echo  Game:        http://localhost:8080
echo  phpMyAdmin:  http://localhost:8081
echo.
echo  Press any key to STOP.
pause
docker compose down
echo  Stopped. Bye!
timeout /t 2 /nobreak >nul
exit /b

REM =============================================
REM              XAMPP MODE
REM =============================================
:XAMPP
echo.
echo  --- XAMPP Mode ---
echo.

REM Find XAMPP - check multiple locations and detection methods
set "XAMPP_PATH="
for %%P in (C:\xampp D:\xampp E:\xampp) do (
    if exist "%%P\htdocs" (
        set "XAMPP_PATH=%%P"
        goto :xampp_found
    )
)
echo  [ERROR] XAMPP not found!
echo  Download: https://www.apachefriends.org
start https://www.apachefriends.org/download.html
pause
exit /b

:xampp_found
echo  [OK] Found XAMPP at: %XAMPP_PATH%

REM Check if XAMPP is fully installed or just htdocs
set "XAMPP_FULL=0"
if exist "%XAMPP_PATH%\xampp-control.exe" set "XAMPP_FULL=1"
if exist "%XAMPP_PATH%\apache_start.bat" set "XAMPP_FULL=1"

if "%XAMPP_FULL%"=="0" (
    echo.
    echo  [WARNING] XAMPP folder exists but is not fully installed.
    echo  Only htdocs folder was found. You need to install XAMPP
    echo  properly to get Apache and MySQL.
    echo.
    echo  Opening download page...
    start https://www.apachefriends.org/download.html
    echo.
    echo  IMPORTANT: When installing, choose the SAME folder: %XAMPP_PATH%
    echo  The installer will add Apache, MySQL, PHP etc alongside htdocs.
    echo  Then run this bat file again.
    echo.
    pause
    exit /b
)

REM Fix install folder in source
call :FIX_INSTALL "%~dp0"

REM Copy project to htdocs
set "DEST=%XAMPP_PATH%\htdocs\travian"
if not exist "%DEST%\index.php" (
    echo  [COPY] Copying to htdocs\travian...
    xcopy "%~dp0*" "%DEST%\" /E /I /Y /Q >nul 2>&1
    echo  [OK] Done!
) else (
    echo  [OK] Project already in htdocs\travian.
    call :FIX_INSTALL "%DEST%\"
    xcopy "%~dp0*" "%DEST%\" /E /I /Y /Q /D >nul 2>&1
)

REM Check if port 80 is free
set "XAMPP_PORT=80"
set "XAMPP_URL_PORT="

REM Always restore httpd.conf to port 80 first (undo any previous patches)
if exist "%XAMPP_PATH%\apache\conf\httpd.conf" (
    powershell -Command "(Get-Content '%XAMPP_PATH%\apache\conf\httpd.conf') -replace 'Listen \d+$','Listen 80' -replace 'ServerName localhost:\d+','ServerName localhost:80' | Set-Content '%XAMPP_PATH%\apache\conf\httpd.conf'"
)

powershell -Command "if((netstat -ano | Select-String 'LISTENING' | Select-String ':80\s').Count -gt 0){exit 1}else{exit 0}" >nul 2>&1
if %errorlevel% equ 1 (
    echo  [WARNING] Port 80 is blocked by another program.
    echo  [FIX] Switching Apache to port 8080...
    set "XAMPP_PORT=8080"
    set "XAMPP_URL_PORT=:8080"
    if exist "%XAMPP_PATH%\apache\conf\httpd.conf" (
        powershell -Command "(Get-Content '%XAMPP_PATH%\apache\conf\httpd.conf') -replace 'Listen 80$','Listen 8080' -replace 'ServerName localhost:80$','ServerName localhost:8080' | Set-Content '%XAMPP_PATH%\apache\conf\httpd.conf'"
        echo  [OK] Apache config set to port 8080.
    )
)

REM Start Apache
echo  [START] Apache...
tasklist /FI "IMAGENAME eq httpd.exe" 2>NUL | find /I "httpd.exe" >NUL
if %errorlevel% equ 0 goto :apache_ok

echo Start-Process -FilePath '%XAMPP_PATH%\apache\bin\httpd.exe' -WindowStyle Hidden > "%TEMP%\start_apache.ps1"
powershell -ExecutionPolicy Bypass -File "%TEMP%\start_apache.ps1"
del "%TEMP%\start_apache.ps1" >nul 2>&1
timeout /t 3 /nobreak >nul

tasklist /FI "IMAGENAME eq httpd.exe" 2>NUL | find /I "httpd.exe" >NUL
if %errorlevel% equ 0 goto :apache_ok
echo  [ERROR] Apache failed to start!
echo  Try: Run this bat file as Administrator.
pause
exit /b

:apache_ok
echo  [OK] Apache running on port %XAMPP_PORT%!

REM Start MySQL
echo  [START] MySQL...
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I "mysqld.exe" >NUL
if %errorlevel% equ 0 goto :mysql_ok

echo Start-Process -FilePath '%XAMPP_PATH%\mysql\bin\mysqld.exe' -ArgumentList '--defaults-file=%XAMPP_PATH%\mysql\bin\my.ini' -WindowStyle Hidden > "%TEMP%\start_mysql.ps1"
powershell -ExecutionPolicy Bypass -File "%TEMP%\start_mysql.ps1"
del "%TEMP%\start_mysql.ps1" >nul 2>&1
timeout /t 4 /nobreak >nul

tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I "mysqld.exe" >NUL
if %errorlevel% equ 0 goto :mysql_ok
echo  [ERROR] MySQL failed to start!
echo  Try: Run this bat file as Administrator.
pause
exit /b

:mysql_ok
echo  [OK] MySQL running!

echo.
echo  ========================================
echo       SERVER IS RUNNING! (XAMPP)
echo  ========================================
echo.
timeout /t 3 /nobreak >nul
start http://localhost%XAMPP_URL_PORT%/travian/install

echo  -------------------------------------------
echo   DATABASE SETTINGS:
echo.
echo   SQL Hostname:  localhost
echo   Port:          3306
echo   Username:      root
echo   Password:      (leave empty)
echo   DB name:       travian
echo   Prefix:        s1_
echo   Type:          MYSQLi
echo  -------------------------------------------
echo.
echo  Game:        http://localhost%XAMPP_URL_PORT%/travian
echo  phpMyAdmin:  http://localhost%XAMPP_URL_PORT%/phpmyadmin
echo.
echo  Press any key to STOP.
pause
taskkill /F /IM httpd.exe >nul 2>&1
taskkill /F /IM mysqld.exe >nul 2>&1
REM Restore httpd.conf if we patched it
if "%XAMPP_PORT%"=="8080" (
    if exist "%XAMPP_PATH%\apache\conf\httpd.conf" (
        powershell -Command "(Get-Content '%XAMPP_PATH%\apache\conf\httpd.conf') -replace 'Listen 8080','Listen 80' -replace 'ServerName localhost:8080','ServerName localhost:80' | Set-Content '%XAMPP_PATH%\apache\conf\httpd.conf'"
    )
)
echo  Stopped. Bye!
timeout /t 2 /nobreak >nul
exit /b
