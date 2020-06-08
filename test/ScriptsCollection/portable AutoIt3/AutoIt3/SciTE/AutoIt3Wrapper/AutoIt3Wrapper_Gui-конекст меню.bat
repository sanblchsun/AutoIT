@echo off
color 3b
title AutoIt3Wrapper_Gui
:: следующая строка - пункт контекстного меню можно указать по русски, но в досовской кодировке. При изменении нужно поправить аналогичное имя в удаляющем пункт батнике
set contmenu=AutoIt3Wrapper_Gui
set awg=%~dp0
set awg=%awg:~0,-1%
Reg.exe add "HKCR\AutoIt3Script\Shell\AutoIt3Wrapper_Gui\Command" /v "" /t REG_SZ /d "\"%awg%\AutoIt3Wrapper_Gui.exe\" /in \"%%l\"" /f
Reg.exe add "HKCR\AutoIt3Script\Shell\AutoIt3Wrapper_Gui" /v "" /t REG_SZ /d "%contmenu%" /f