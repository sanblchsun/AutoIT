exit

:: ��������!!! ������ ������ ��� ������ ��� �������������� ������������, ����� �� �������� �������� ���� ���������� ����� � ��������� ���������.
:: ������ ���������� ������� ��� ������ ������ ������ ������ �������� AutoIt3. ������� ������� ���� ������ ������ ��� ����� AutoIt3, ����� ����. ���������� ����� �������� � ����� ������������� ������ AutoIt3 � ����� ����� ������������ ����������� AutoIt3.
:: � ����� ���� ����� ����������� ������� ��������� ������ ������� ������� SciTE, ���� �� ������� ��������� ������������� ������.

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
:: Include ���� �������, ���������� ����� ���� ������������ � ������� ��������. ����������� ����� �� �������� ��������, ��� ���� �������������� ����� UDF
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


:: ��� �������� ����� ����� �������� � �������������� ������� ����� ������� � ����� ����������.
::rd /s /q "%RootAutoIt3%\!script"
::rd /s /q "%RootAutoIt3%\Tools"