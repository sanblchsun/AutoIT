@echo off
color 3b
title Obfuscator
:: ��������� ������ - ����� ������������ ���� ����� ������� �� ������, �� � ��������� ���������. ��� ��������� ����� ��������� ����������� ��� � ��������� ����� �������
set contmenu=Obfuscator
set awg=%~dp0
set awg=%awg:~0,-1%
Reg.exe add "HKCR\AutoIt3Script\Shell\Obfuscator\Command" /v "" /t REG_SZ /d "\"%awg%\Obfuscator.exe\" \"%%1\"" /f
Reg.exe add "HKCR\AutoIt3Script\Shell\Obfuscator" /v "" /t REG_SZ /d "%contmenu%" /f