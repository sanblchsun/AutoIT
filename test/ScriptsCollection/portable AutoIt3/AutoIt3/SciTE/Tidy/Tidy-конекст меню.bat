@echo off
color 3b
title Tidy
:: ��������� ������ - ����� ������������ ���� ����� ������� �� ������, �� � ��������� ���������. ��� ��������� ����� ��������� ����������� ��� � ��������� ����� �������
set contmenu=Tidy (�⠡��쭮���)
set awg=%~dp0
set awg=%awg:~0,-1%
Reg.exe add "HKCR\AutoIt3Script\Shell\Tidy\Command" /v "" /t REG_SZ /d "\"%awg%\Tidy.exe\" \"%%1\"" /f
Reg.exe add "HKCR\AutoIt3Script\Shell\Tidy" /v "" /t REG_SZ /d "%contmenu%" /f