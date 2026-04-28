@echo off
cd /d "%~dp0"
echo Starting local server on http://localhost:8000
echo Close this window to stop the server.

REM Try Python 3
python -m http.server 8000 2>nul
if %errorlevel% neq 0 (
    REM Try Python 2
    python -m SimpleHTTPServer 8000 2>nul
    if %errorlevel% neq 0 (
        echo.
        echo Error: Python is not installed or not in PATH.
        echo.
        echo Please install Python from https://www.python.org/downloads/
        echo Or install VS Code Live Server extension and right-click index.html
        pause
    )
)
