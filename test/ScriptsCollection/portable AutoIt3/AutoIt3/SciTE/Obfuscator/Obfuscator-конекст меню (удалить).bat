@echo off
color 3b
title delete_Obfuscator

set contmenu=Obfuscator
Reg.exe delete "HKCR\AutoIt3Script\Shell\%contmenu%" /f