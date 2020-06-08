@echo off
C:\AutoIt3\AutoIt3.exe "%~dp0Console.au3" -h
echo.
echo ERRORLEVEL=%ERRORLEVEL%
echo.
REM pause
C:\AutoIt3\AutoIt3.exe "%~dp0Console.au3" -z
echo.
echo ERRORLEVEL=%ERRORLEVEL%
echo.
REM pause
C:\AutoIt3\AutoIt3.exe "%~dp0Console.au3"
echo.
echo ERRORLEVEL=%ERRORLEVEL%
pause