#include <Encoding.au3>

; ������� _CyrillicTo1251 ���������� ����� ��������� ������ ������� ����������. ��������� ������ ��������� 5 ���������: KOI8-R, IBM-866, ISO-8859-5, HEX, UTF8

ConsoleWrite(@CRLF & "=========== _Encoding_CyrillicTo1251 ")

_Output("_Encoding_CyrillicTo1251", _ ; latin
	_Encoding_CyrillicTo1251("The only fun remained to me - put fingers in the mouth and whistle merrily"))
_Output("_Encoding_CyrillicTo1251", _ ; win
	_Encoding_CyrillicTo1251("��� �������� ���� ������: ������ � ��� - � ������� �����."))
_Output("_Encoding_CyrillicTo1251", _ ; dos
	_Encoding_CyrillicTo1251("�ப�⨫��� ��ୠ� ᫠��, �� ��堡��� � � ᪠�������."))
_Output("_Encoding_CyrillicTo1251", _ ; koi
	_Encoding_CyrillicTo1251("��! ����� ������� ������! ����� � ����� ������� ������."))
_Output("_Encoding_CyrillicTo1251", _ ; iso
	_Encoding_CyrillicTo1251("������ ���, ��� � � ���� �� �����. ������ ���, ��� �� ���� ������."))
_Output("_Encoding_CyrillicTo1251", _ ; utf8
	_Encoding_CyrillicTo1251("﻿Золотые далёкие дали! Всё сжигает житейская мреть."))
_Output("_Encoding_CyrillicTo1251", _ ; hex
	_Encoding_CyrillicTo1251("=E9 =D0=CF=C8=C1=C2=CE=C9=DE=C1=CC =D1 =C9 =D3=CB=C1=CE=C4=C1=CC=C9=CC =C4=CC=D1 =D4=CF=C7=CF=2C =DE=D4=CF=C2=D9 =D1=D2=DE=C5 =C7=CF=D2=C5=D4=D8=2E"))
	
ConsoleWrite(@CRLF & "=========== _Encoding_XToY ")

; ������������� ������� ���������� ����� ��������� ��������
_Output("_Encoding_866To1251", _ ; dos
	_Encoding_866To1251("��� ���� - ��᪠�� � �����, ப���� �� ��� �����."))
_Output("_Encoding_KOI8To1251", _ ; koi
	_Encoding_KOI8To1251("���� ����� � ������ ����� � ����� �� ����� ���������."))
_Output("_Encoding_ISO8859To1251", _ ; iso
	_Encoding_ISO8859To1251("����� �� ���������, ����� �� ������� ��� ������� ������� ����."))
_Output("_Encoding_HexSymbolsToANSI", _ ; hex
	_Encoding_HexSymbolsToANSI("=CD=EE =EA=EE=EB=FC =F7=E5=F0=F2=E8 =E2 =E4=F3=F8=E5 =E3=ED=E5=E7=E4=E8=EB=E8=F1=FC =2D =C7=ED=E0=F7=E8=F2=2C =E0=ED=E3=E5=EB=FB =E6=E8=EB=E8 =E2 =ED=E5=E9=2E"))

ConsoleWrite(@CRLF & "=========== _Encoding_GetCyrillicANSIEncoding ")

; ������� _Encoding_GetCyrillicANSIEncoding ���������� ANSI ���������: KOI8-R, WINDOWS-1251, IBM-866, ISO-8859-5. ������� �� ����� 3-4 ���������� ������� ���� ��� ���������� �����������
_Output("_Encoding_GetCyrillicANSIEncoding", _ ; koi
	_Encoding_GetCyrillicANSIEncoding("�� ���� ����� � ���� ���������� - ������, ������ ���� � ���."))
_Output("_Encoding_GetCyrillicANSIEncoding", _ ; win
	_Encoding_GetCyrillicANSIEncoding("��� �� ��� ������� ����, ����������� � ��� � ���� ����,"))
_Output("_Encoding_GetCyrillicANSIEncoding", _ ; iso
	_Encoding_GetCyrillicANSIEncoding("� ���� ��� ��������� ������ ��������� ���, ��� ����� �� ����, -"))
_Output("_Encoding_GetCyrillicANSIEncoding", _ ; dos
	_Encoding_GetCyrillicANSIEncoding("�⮡ �� �� �� ��� ��� �寧��, �� ����ਥ � ���������"))

Func _Output($sFunction, $sData)
	ConsoleWrite("===========" & @CRLF & $sFunction & ": " & $sData & @CRLF)
EndFunc
