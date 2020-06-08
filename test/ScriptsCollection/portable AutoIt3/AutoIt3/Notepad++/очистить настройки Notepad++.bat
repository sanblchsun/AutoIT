IF NOT EXIST "%~dp0backup" xcopy "%UserProfile%\Application Data\Notepad++" "%~dp0backup\Application Data\Notepad++" /Q /H /Y /K /C /E /I
DEL "%UserProfile%\Application Data\Notepad++\*.*" /S /F /Q