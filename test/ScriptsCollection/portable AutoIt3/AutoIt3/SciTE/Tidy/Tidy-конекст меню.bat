@echo off
color 3b
title Tidy
:: следующая строка - пункт контекстного меню можно указать по русски, но в досовской кодировке. При изменении нужно поправить аналогичное имя в удаляющем пункт батнике
set contmenu=Tidy (зЁв ЎҐ«м­®бвм)
set awg=%~dp0
set awg=%awg:~0,-1%
Reg.exe add "HKCR\AutoIt3Script\Shell\Tidy\Command" /v "" /t REG_SZ /d "\"%awg%\Tidy.exe\" \"%%1\"" /f
Reg.exe add "HKCR\AutoIt3Script\Shell\Tidy" /v "" /t REG_SZ /d "%contmenu%" /f