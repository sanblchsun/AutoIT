@echo off
color 3b
title delete_Tidy

set contmenu=Tidy (читабельность)
Reg.exe delete "HKCR\AutoIt3Script\Shell\%contmenu%" /f