@echo off
title OCR Tool Launcher
echo =======================================
echo    Starting OCR Tool Server...
echo =======================================
echo.

:: Open the browser after a short delay
start "" "http://127.0.0.1:5000"

:: Run the Flask application
python app.py

if %ERRORLEVEL% neq 0 (
    echo.
    echo [!] Error: Python not found or app failed to start.
    echo Please make sure Python is installed and added to PATH.
    pause
)
