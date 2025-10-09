@echo off
ECHO =======================================================
ECHO              JalSetu: END WORK SCRIPT
ECHO =======================================================
ECHO.

REM --- 1. Get User Input for Commit Message ---
set /p DESCRIPTION="Enter a short description of the work you completed: "
ECHO.

REM --- 2. Generate Commit Message with Date/Time ---
REM Note: PowerShell and standard cmd date/time formats clash, so we use a robust method.
for /f "tokens=1-4 delims=/ " %%i in ('date /t') do set DATE_STR=%%k-%%j-%%i
for /f "tokens=1-2 delims=:" %%i in ('time /t') do set TIME_STR=%%i%%j
set COMMIT_MSG=JalSetu Commit 

: %DESCRIPTION%

ECHO Git commit message will be: %COMMIT_MSG%
ECHO.

REM --- 3. Stage Files ---
ECHO Staging all changes (git add .)...
git add .
IF ERRORLEVEL 1 (
ECHO !!! ERROR: Failed to stage files. Aborting push. !!!
GOTO FAIL
)

REM --- 4. Commit Changes ---
ECHO Committing changes...
git commit -m "%COMMIT_MSG%"
IF ERRORLEVEL 1 (
ECHO !!! WARNING: Nothing new to commit (already up-to-date locally). Pushing remote changes. !!!
)

REM --- 5. Push to GitHub ---
ECHO Pushing changes to GitHub (git push -u origin main)...
git push -u origin main
IF ERRORLEVEL 1 (
ECHO.
ECHO !!! ERROR: Failed to push changes to GitHub. !!!
ECHO Please check your network connection or Git credentials.
GOTO FAIL
)

ECHO.
ECHO √ SUCCESS: Your work has been saved and uploaded to GitHub!
GOTO END

:FAIL
ECHO.
ECHO Operation failed. Please check the terminal output for details.

:END
ECHO.
pause