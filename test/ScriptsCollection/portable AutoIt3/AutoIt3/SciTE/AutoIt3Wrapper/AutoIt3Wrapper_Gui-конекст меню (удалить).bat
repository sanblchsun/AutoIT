@echo off
color 3b
title delete_AutoIt3Wrapper_Gui

set contmenu=AutoIt3Wrapper_Gui
Reg.exe delete "HKCR\AutoIt3Script\Shell\%contmenu%" /f