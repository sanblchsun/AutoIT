@echo off
color 3b
title AutoIt3
SET ait=%~dp0
SET ait=%ait:~0,-1%

regedit /s DEL1_AutoIt3_v3.3.6.1.reg
regedit /s save1_AutoIt3_v3.3.6.1.reg

Reg.exe add "HKCR\AutoIt3Script\DefaultIcon" /v "" /t REG_SZ /d "%ait%\Icons\au3script_v10.ico" /f
Reg.exe add "HKCR\AutoIt3Script\Shell\AutoIt3Wrapper\Command" /v "" /t REG_SZ /d "\"%ait%\SciTE\AutoIt3Wrapper\AutoIt3Wrapper.exe\" /in \"%%l\"" /f
Reg.exe add "HKCR\AutoIt3Script\Shell\AutoIt3Wrapper_Gui\Command" /v "" /t REG_SZ /d "\"%ait%\SciTE\AutoIt3Wrapper\AutoIt3Wrapper.exe\" /ShowGui /in \"%%l\"" /f
::Reg.exe add "HKCR\AutoIt3Script\Shell\Compile\Command" /v "" /t REG_SZ /d "\"%ait%\Aut2Exe\Aut2Exe.exe\" /in \"%%l\"" /f
Reg.exe add "HKCR\AutoIt3Script\Shell\Edit\Command" /v "" /t REG_SZ /d "\"%ait%\Notepad++\notepad++.exe\" \"%%1\"" /f
Reg.exe add "HKCR\AutoIt3Script\Shell\Open\Command" /v "" /t REG_SZ /d "\"%ait%\AutoIt3.exe\" \"%%1\" %%*" /f
Reg.exe add "HKCR\AutoIt3Script\Shell\Run\Command" /v "" /t REG_SZ /d "\"%ait%\SciTE\SciTE.exe\" \"%%1\"" /f
Reg.exe add "HKCR\AutoIt3Script\Shell\rx_re\Command" /v "" /t REG_SZ /d "\"%ait%\AutoIt3.exe\" \"%ait%\re_au3.au3\" %%*" /f
Reg.exe add "HKCR\AutoIt3Script\Shell\Tidy\Command" /v "" /t REG_SZ /d "\"%ait%\SciTE\Tidy\Tidy.exe\" \"%%1\"" /f
Reg.exe add "HKCR\AutoIt3XScript\DefaultIcon" /v "" /t REG_SZ /d "%ait%\Icons\au3script_v10.ico" /f
Reg.exe add "HKCR\AutoIt3XScript\Shell\Run\Command" /v "" /t REG_SZ /d "\"%ait%\AutoIt3.exe\" \"%%1\" %%*" /f
Reg.exe add "HKCR\CLSID\{1A671297-FA74-4422-80FA-6C5D8CE4DE04}\InprocServer32" /v "" /t REG_SZ /d "%ait%\AutoItX\AutoItX3.dll" /f
Reg.exe add "HKCR\CLSID\{3D54C6B8-D283-40E0-8FAB-C97F05947EE8}\InProcServer32" /v "" /t REG_SZ /d "%ait%\AutoItX\AutoItX3.dll" /f
Reg.exe add "HKCR\TypeLib\{F8937E53-D444-4E71-9275-35B64210CC3B}\1.0\0\win32" /v "" /t REG_SZ /d "%ait%\AutoItX\AutoItX3.dll" /f
Reg.exe add "HKCR\TypeLib\{F8937E53-D444-4E71-9275-35B64210CC3B}\1.0\HELPDIR" /v "" /t REG_SZ /d "%ait%\AutoItX" /f
Reg.exe add "HKCU\Software\AutoIt v3\Aut2Exe" /v "LastIconDir" /t REG_SZ /d "\"%ait%\Aut2Exe\Icons\"" /f
Reg.exe add "HKLM\SOFTWARE\AutoIt v3\AutoIt" /v "InstallDir" /t REG_SZ /d "%ait%" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Au3Info.exe" /v "" /t REG_SZ /d "%ait%\Au3Info.exe" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Aut2Exe.exe" /v "" /t REG_SZ /d "%ait%\Aut2Exe\Aut2Exe.exe" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AutoIt3.exe" /v "" /t REG_SZ /d "%ait%\AutoIt3.exe" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AutoItv3" /v "UninstallString" /t REG_SZ /d "%ait%\Uninstall.exe" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AutoItv3" /v "DisplayIcon" /t REG_SZ /d "%ait%\AutoIt3.exe,0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\SciTE.exe" /v "" /t REG_SZ /d "%ait%\SciTE\SciTE.exe" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\SciTE.exe" /v "Path" /t REG_SZ /d "%ait%\SciTE" /f

start "%~dp0\AutoIt3.exe" "%~dp0inst_AutoIt.au3" /1