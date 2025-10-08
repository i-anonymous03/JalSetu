@echo off
ECHO =======================================================
ECHO              JalSetu: END WORK SCRIPT
ECHO =======================================================
ECHO.

REM --- 1. Get User Input for Commit Message ---
set /p DESCRIPTION="Enter a short description of the work you completed: "
ECHO.

REM --- 2. Generate Commit Message with Date/Time ---
for /f "tokens=1-4 delims=/ " %%i in ('date /t') do set DATE_STR=%%k-%%j-%%i
for /f "tokens=1-2 delims=:" %%i in ('time /t') do set TIME_STR=%%i%%j
set COMMIT_MSG=JalSetu Commit [%DATE_STR% %TIME_STR%]: %DESCRIPTION%

ECHO Git commit message will be: %COMMIT_MSG%
ECHO.

REM --- 3. Stage Files ---
ECHO Staging all changes (git add .)...
git add .
IF %ERRORLEVEL% NEQ 0 (
ECHO !!! ERROR: Failed to stage files. Aborting push. !!!
goto :FAIL
)

REM --- 4. Commit Changes ---
ECHO Committing changes...
git commit -m "%COMMIT_MSG%"
IF %ERRORLEVEL% NEQ 0 (
ECHO !!! WARNING: Nothing to commit (maybe you committed already?). Pushing anyway. !!!
)

REM --- 5. Push to GitHub ---
ECHO Pushing changes to GitHub (git push -u origin main)...
git push -u origin main
IF %ERRORLEVEL% NEQ 0 (
ECHO.
ECHO !!! ERROR: Failed to push changes to GitHub. !!!
ECHO Please check your network connection and credentials.
goto :FAIL
)

ECHO.
ECHO √ SUCCESS: Your work has been saved and uploaded to GitHub!
goto :END

:FAIL
ECHO.
ECHO Operation failed. Please check the terminal output for details.

:END
ECHO.
pause