REM @echo off
color 3b
title Замена системных иконок иконками Vista
echo.

"%~dp0ResHacker.exe" -script Folder_ico_modify_script.txt
pause
