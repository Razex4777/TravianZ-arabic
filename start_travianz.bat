@echo off
chcp 65001 >nul 2>&1
title TravianZ - One Click Installer
color 0A

echo.
echo  ╔══════════════════════════════════════════════════╗
echo  ║       TravianZ - One Click Installer             ║
echo  ║       Just sit back and relax!                   ║
echo  ╚══════════════════════════════════════════════════╝
echo.

REM ===================================================
REM STEP 1: Check if Docker is installed
REM ===================================================
echo [Step 1/4] Checking if Docker is installed...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo  ╔══════════════════════════════════════════════════╗
    echo  ║  Docker is NOT installed on your computer!       ║
    echo  ║                                                  ║
    echo  ║  Opening the download page for you now...        ║
    echo  ║                                                  ║
    echo  ║  INSTRUCTIONS:                                   ║
    echo  ║  1. Click "Download Docker Desktop"              ║
    echo  ║  2. Run the installer and follow the steps       ║
    echo  ║  3. RESTART your computer after installing       ║
    echo  ║  4. Open Docker Desktop and wait until it says   ║
    echo  ║     "Docker Desktop is running"                  ║
    echo  ║  5. Then double-click this .bat file again       ║
    echo  ╚══════════════════════════════════════════════════╝
    echo.
    start https://www.docker.com/products/docker-desktop/
    pause
    exit /b
)
echo           Docker is installed!

REM ===================================================
REM STEP 2: Check if Docker Desktop is running
REM ===================================================
echo [Step 2/4] Checking if Docker Desktop is running...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo  Docker Desktop is not running. Trying to start it...
    start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe" 2>nul
    if %errorlevel% neq 0 (
        start "" "%ProgramFiles%\Docker\Docker\Docker Desktop.exe" 2>nul
    )
    echo.
    echo  Waiting for Docker Desktop to start up...
    echo  (This can take 30-60 seconds on first launch)
    echo.

    REM Wait up to 120 seconds for Docker to become ready
    set /a counter=0
    :waitloop
    set /a counter+=1
    if %counter% gtr 24 (
        echo.
        echo  [ERROR] Docker Desktop did not start in time.
        echo  Please open Docker Desktop manually, wait until
        echo  it says "running", then run this .bat file again.
        echo.
        pause
        exit /b
    )
    timeout /t 5 /nobreak >nul
    docker info >nul 2>&1
    if %errorlevel% neq 0 (
        echo           Still waiting... (%counter%/24)
        goto waitloop
    )
)
echo           Docker Desktop is running!

REM ===================================================
REM STEP 3: Create .env file if missing
REM ===================================================
echo [Step 3/4] Preparing configuration...
IF NOT EXIST ".env" (
    IF EXIST ".env.example" (
        copy .env.example .env >nul
        echo           Created .env config file.
    ) else (
        echo           No .env.example found, skipping.
    )
) else (
    echo           Config file already exists.
)

REM ===================================================
REM STEP 4: Build and start containers
REM ===================================================
echo [Step 4/4] Building and starting the server...
echo           (This may take 2-5 minutes on first run)
echo.

docker compose up -d --build 2>nul
if %errorlevel% neq 0 (
    docker-compose up -d --build 2>nul
    if %errorlevel% neq 0 (
        echo.
        echo  [ERROR] Failed to start. Please make sure Docker
        echo  Desktop is fully running and try again.
        echo.
        pause
        exit /b
    )
)

echo.
echo  ╔══════════════════════════════════════════════════╗
echo  ║            SERVER IS NOW RUNNING!                ║
echo  ╚══════════════════════════════════════════════════╝
echo.
echo  Opening the installation page in your browser...
echo.

REM Give the database a moment to initialize
timeout /t 8 /nobreak >nul
start http://localhost:8080/install

echo.
echo  ┌──────────────────────────────────────────────────┐
echo  │  DATABASE SETTINGS (use these in the wizard):    │
echo  │                                                  │
echo  │  SQL Hostname:  db                               │
echo  │  Port:          3306                             │
echo  │  Username:      travianz                         │
echo  │  Password:      travianzpass                     │
echo  │  DB name:       travian                          │
echo  │  Prefix:        s1_                              │
echo  │  Type:          MYSQLi                           │
echo  │                                                  │
echo  │  !! DO NOT use "localhost" as hostname !!         │
echo  │  !! Type exactly: db                   !!        │
echo  └──────────────────────────────────────────────────┘
echo.
echo  OTHER URLS:
echo    Game:        http://localhost:8080
echo    phpMyAdmin:  http://localhost:8081
echo.
echo  To STOP the server later, double-click: stop_travianz.bat
echo.
pause
