exit

:: Внимание!!! батник только для только что установленного дистрибутива, иначе вы рискуете потерять свои сохранённые файлы в удаляемых каталогах.
:: Батник подготовит дистриб для замены поверх другой версии дистриба AutoIt3. Другими словами этот батник удалит все файлы AutoIt3, кроме моих. Оставшиеся файлы копируем в новую установленную версию AutoIt3 и готов новый портабельный дистрибутив AutoIt3.
:: В папке куда будет установлени дистриб требуется только удалить каталог SciTE, хотя он наверно корректно перезапишется поверх.

@echo off
color 3b
title Clear

set "RootAutoIt3=%~dp0"
set "RootAutoIt3=%RootAutoIt3:~0,-1%"

rd /s /q "%RootAutoIt3%\Aut2Exe"
rd /s /q "%RootAutoIt3%\AutoItX"
rd /s /q "%RootAutoIt3%\Examples"
rd /s /q "%RootAutoIt3%\Extras"
rd /s /q "%RootAutoIt3%\Icons"
:: Include тоже удаляем, дополнения могут быть несовместимы с другими версиями. Тестировать можно из каталога скриптов, где есть дополнительные копии UDF
rd /s /q "%RootAutoIt3%\Include"

del /s /f /q "%RootAutoIt3%\Au3Check.dat"
del /s /f /q "%RootAutoIt3%\Au3Check.exe"
del /s /f /q "%RootAutoIt3%\Au3Info.exe"
del /s /f /q "%RootAutoIt3%\Au3Info_x64.exe"
del /s /f /q "%RootAutoIt3%\AutoIt v3 Website.url"
del /s /f /q "%RootAutoIt3%\AutoIt.chm"
del /s /f /q "%RootAutoIt3%\AutoIt3.chm"
del /s /f /q "%RootAutoIt3%\AutoIt3.exe"
del /s /f /q "%RootAutoIt3%\AutoIt3Help.exe"
del /s /f /q "%RootAutoIt3%\AutoIt3_x64.exe"
del /s /f /q "%RootAutoIt3%\UDFs3.chm"


:: для экономии места папку скриптов и дополнительные утилиты можно хранить в одном экземпляре.
::rd /s /q "%RootAutoIt3%\!script"
::rd /s /q "%RootAutoIt3%\Tools"