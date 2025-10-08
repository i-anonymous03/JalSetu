@echo off
ECHO =======================================================
ECHO             JalSetu: START WORK SCRIPT
ECHO =======================================================
ECHO.

ECHO Checking for updates from the main branch on GitHub...
git pull origin main

IF %ERRORLEVEL% NEQ 0 (
ECHO.
ECHO !!! ERROR: Failed to pull updates. !!!
ECHO Please check your internet connection or Git authentication.
) ELSE (
ECHO.
ECHO √ SUCCESS: Your project is now up-to-date!
)

ECHO.
pause