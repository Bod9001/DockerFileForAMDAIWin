@echo off
REM Check if the source folder exists
IF NOT EXIST "C:\Program Files\WSL\lib" (
    echo Source folder does not exist: C:\Program Files\WSL\lib
    pause
    exit /b
)

REM Create the "lib" folder in the local directory if it doesn't exist
IF NOT EXIST "%~dp0lib" (
    mkdir "%~dp0lib"
)

REM Copy the files
xcopy "C:\Program Files\WSL\lib\*" "%~dp0lib" /E /I /H /Y

echo Files copied to %~dp0lib
pause


