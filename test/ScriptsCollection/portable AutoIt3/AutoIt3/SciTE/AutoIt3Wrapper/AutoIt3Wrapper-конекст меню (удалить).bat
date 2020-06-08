@echo off
color 3b
title delete_AutoIt3Wrapper

set contmenu=AutoIt3Wrapper
Reg.exe delete "HKCR\AutoIt3Script\Shell\%contmenu%" /f