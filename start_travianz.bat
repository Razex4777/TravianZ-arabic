@echo off
title TravianZ Docker Runner
echo ==================================================
echo         TravianZ Docker One-Click Runner
echo ==================================================
echo.

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not running or not installed.
    echo Please start Docker Desktop and try again.
    pause
    exit /b
)

REM Create .env if it doesn't exist
IF NOT EXIST ".env" (
    echo [INFO] Creating .env file from .env.example...
    copy .env.example .env >nul
)

echo [INFO] Building and starting Docker containers...
docker compose up -d --build
if %errorlevel% neq 0 (
    echo [WARNING] 'docker compose' failed, trying older 'docker-compose' syntax...
    docker-compose up -d --build
)

echo.
echo ==================================================
echo              Server is now running!
echo ==================================================
echo.
echo You can access the installation wizard at:
echo http://localhost:8080/install
echo.
echo --------------------------------------------------
echo IMPORTANT: During the database configuration step,
echo use these EXACT settings (do NOT use localhost):
echo.
echo SQL Hostname:  db
echo Port:          3306
echo Username:      travianz
echo Password:      travianzpass
echo DB name:       travian
echo --------------------------------------------------
echo.
echo Note: If it says "Connection refused", just wait 
echo a few more seconds for the database to fully start
echo and refresh the page.
echo.
echo To stop the server later, open CMD here and run:
echo docker compose down
echo.
pause
