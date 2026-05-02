@echo off
title TravianZ - One Click Starter
color 0A

echo.
echo  ========================================
echo     TravianZ - One Click Starter (XAMPP)
echo  ========================================
echo.

REM Try to find XAMPP
set "XAMPP_PATH=C:\xampp"
if not exist "%XAMPP_PATH%\xampp-control.exe" set "XAMPP_PATH=D:\xampp"
if not exist "%XAMPP_PATH%\xampp-control.exe" set "XAMPP_PATH=E:\xampp"
if not exist "%XAMPP_PATH%\xampp-control.exe" (
    echo  [ERROR] XAMPP not found!
    echo  Please install XAMPP from: https://www.apachefriends.org
    echo.
    start https://www.apachefriends.org/download.html
    pause
    exit /b
)
echo  Found XAMPP at: %XAMPP_PATH%

REM Copy project files to htdocs/travian if not already there
set "DEST=%XAMPP_PATH%\htdocs\travian"
set "SRC=%~dp0"

if not exist "%DEST%\index.php" (
    echo  Copying project files to htdocs\travian...
    xcopy "%SRC%*" "%DEST%\" /E /I /Y /Q >nul 2>&1
    echo  Done!
) else (
    echo  Project already in htdocs\travian.
)

REM Start Apache using XAMPP's own scripts
echo  Starting Apache...
tasklist /FI "IMAGENAME eq httpd.exe" 2>NUL | find /I "httpd.exe" >NUL
if %errorlevel% neq 0 (
    call "%XAMPP_PATH%\apache_start.bat" >nul 2>&1
    timeout /t 2 /nobreak >nul
    echo  Apache started!
) else (
    echo  Apache already running.
)

REM Start MySQL using XAMPP's own scripts
echo  Starting MySQL...
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I "mysqld.exe" >NUL
if %errorlevel% neq 0 (
    call "%XAMPP_PATH%\mysql_start.bat" >nul 2>&1
    timeout /t 3 /nobreak >nul
    echo  MySQL started!
) else (
    echo  MySQL already running.
)

echo.
echo  ========================================
echo     SERVER IS RUNNING!
echo  ========================================
echo.

timeout /t 3 /nobreak >nul
start http://localhost/travian/install

echo.
echo  -------------------------------------------
echo   DATABASE SETTINGS (use in the wizard):
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
echo  Game URL:       http://localhost/travian
echo  phpMyAdmin:     http://localhost/phpmyadmin
echo.
echo  DO NOT close this window while playing!
echo  Press any key to STOP the server.
echo.
pause

REM Stop services
echo  Stopping Apache and MySQL...
call "%XAMPP_PATH%\apache_stop.bat" >nul 2>&1
call "%XAMPP_PATH%\mysql_stop.bat" >nul 2>&1
echo  Server stopped. Bye!
timeout /t 2 /nobreak >nul
