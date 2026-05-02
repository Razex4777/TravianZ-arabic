@echo off
title TravianZ - Stop Server
color 0C

echo.
echo  Stopping TravianZ server...
echo.

docker compose down 2>nul
if %errorlevel% neq 0 (
    docker-compose down 2>nul
)

echo.
echo  Server stopped successfully.
echo  To start again, double-click: start_travianz.bat
echo.
pause
