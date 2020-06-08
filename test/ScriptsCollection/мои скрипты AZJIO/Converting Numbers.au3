#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=ConvNum.exe
#AutoIt3Wrapper_Icon=ConvNum.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=ConvNum.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.2
#AutoIt3Wrapper_Res_Field=Build|2013.01.07
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2013.01.07 AutoIt3-v3.3.6.1
#NoTrayIcon
#include <GuiComboBox.au3>
#include <EditConstants.au3>
#include <GuiStatusBar.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ConvertingNumbers.au3>

; En
$LngSlt='Custom character set'
$LngEr1='Error. There is no data in the input field, or selection'
$LngEr2='Error. Types (character set) are the same'
$LngEr3='Error. The set contains less than 2 characters'
$LngEr4='Error. The symbol is not found in the character set'
$LngEr5='Error. Number outside the specified range'
$LngEr6='Error. This number does not exist'
$LngScs='Successfully:'
$LngCpB='Copy in clipboard'
$iRusLng = 0

; Ru
; ���� ������� �����������, �� ������� ����
If @OSLang = 0419 Then
	$LngSlt='�������� ����� ��������'
	$LngEr1='������. ����������� ������ � ���� ����� ��� ����� ����'
	$LngEr2='������. ���� (����� ��������) ���������'
	$LngEr3='������. ����� �������� ����� 2 ��������'
	$LngEr4='������. ������ ����� �� ������ � ������ ��������'
	$LngEr5='������. ����� ��� �������������� ���������'
	$LngEr6='������. ����� ����� �� ����������'
	$LngScs='�������:'
	$LngCpB='���������� � ����� ������'
	$iRusLng = 1
EndIf

Global $s_Symbol_In, $s_Symbol_Out, $sOut, $Ini = @ScriptDir & '\Setting.ini'

If Not FileExists($Ini) Then
	$hFile = FileOpen($Ini, 2)
	FileWrite($hFile, _
			'[Set]' & @CRLF & _
			'Combo_In=Dec' & @CRLF & _
			'Combo_Out=Hex' & @CRLF & _
			'000=1')
	FileClose($hFile)
EndIf

$s_Symbol_In = IniRead($Ini, 'Set', 'Combo_In', 'Dec') ; ������������� ��������
$s_Symbol_Out = IniRead($Ini, 'Set', 'Combo_Out', 'Hex')
$ini_000 = IniRead($Ini, 'Set', '000', '1')

$hGui = GUICreate('Converting numbers', 550, 100)
If Not @Compiled Then GUISetIcon(@ScriptDir & '\ConvNum.ico')

$i_Combo_In = GUICtrlCreateCombo('', 5,10, 260) ; ������
GUICtrlSetData(-1,'Bin|Dec|Hex|Roman|' & $LngSlt) ; ������������� ������� �����
$h_Combo_In = GUICtrlGetHandle(-1) ; ���������� ��������������� ������
_GUICtrlComboBox_SetEditText($h_Combo_In, $s_Symbol_In)

$i_Combo_Out = GUICtrlCreateCombo('', 5,40, 260) ; ������
GUICtrlSetData(-1,'Bin|Dec|Hex|Roman|Text|' & $LngSlt) ; ������������� ������� �����
$h_Combo_Out = GUICtrlGetHandle(-1) ; ���������� ��������������� ������
_GUICtrlComboBox_SetEditText($h_Combo_Out, $s_Symbol_Out)

$iIn = GUICtrlCreateInput('', 275, 10, 260, 23) ; ������� ���� �����
$hIn = GUICtrlGetHandle(-1) ; ���������� ���� �����
$iOut = GUICtrlCreateInput('', 275, 40, 240, 23) ; �������� ���� �����
$iClipboard = GUICtrlCreateButton('^', 515, 40, 20, 23)
GUICtrlSetTip(-1, $LngCpB)

; $invert = GUICtrlCreateButton('o', 266, 10, 8, 53)

$hStatus = _GUICtrlStatusBar_Create ($hGUI)
GUISetState()
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND") ; ������������ ������� ��� �������������� ����������
OnAutoItExitRegister('_Exit')
Func _Exit()
	IniWrite($Ini, 'Set', 'Combo_In', GUICtrlRead($i_Combo_In))
	IniWrite($Ini, 'Set', 'Combo_Out', GUICtrlRead($i_Combo_Out))
EndFunc

While 1
	Switch GUIGetMsg()
		Case $i_Combo_In, $i_Combo_Out
			_Conv()
		Case $iClipboard
			ClipPut(GUICtrlRead($iOut)) ; �������� � �����
		Case -3
			Exit
	EndSwitch
WEnd

Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg
	Local $iIDFrom, $iCode
	$iIDFrom = BitAND($iwParam, 0xFFFF) ; Low Word
	$iCode = BitShift($iwParam, 16) ; Hi Word
	Switch $ilParam
		Case $h_Combo_In, $h_Combo_Out
			Switch $iCode
				Case $CBN_EDITCHANGE
					_Conv()
			EndSwitch
		Case $hIn
			Switch $iCode
				Case $EN_CHANGE
					_Conv()
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

Func _Conv()
	Local $sDec
	$s_Symbol_In = GUICtrlRead($i_Combo_In)
	If $s_Symbol_In = $LngSlt Then
		_GUICtrlComboBox_SetEditText($h_Combo_In, '')
		_GUICtrlStatusBar_SetText($hStatus, '')
		GUICtrlSetData($iOut, '')
		Return
	EndIf
	$s_Symbol_Out = GUICtrlRead($i_Combo_Out)
	If $s_Symbol_Out = $LngSlt Then
		_GUICtrlComboBox_SetEditText($h_Combo_Out, '')
		_GUICtrlStatusBar_SetText($hStatus, '')
		GUICtrlSetData($iOut, '')
		Return
	EndIf
	$sIn = GUICtrlRead($iIn)
	If Not($sIn And $s_Symbol_In And $s_Symbol_Out) Then
		_GUICtrlStatusBar_SetText($hStatus, $LngEr1)
		GUICtrlSetData($iOut, '')
		Return
	EndIf
	If $s_Symbol_In = $s_Symbol_Out Then
		_GUICtrlStatusBar_SetText($hStatus, $LngEr2)
		GUICtrlSetData($iOut, '')
		Return
	EndIf

	Switch $s_Symbol_In
		Case 'Bin'
			$s_Symbol_In = '01'
		Case 'Dec'
			$s_Symbol_In = '0123456789'
		Case 'Hex'
			$s_Symbol_In = '0123456789ABCDEF'
	EndSwitch

	Switch $s_Symbol_Out
		Case 'Bin'
			$s_Symbol_Out = '01'
		Case 'Dec'
			$s_Symbol_Out = '0123456789'
		Case 'Hex'
			$s_Symbol_Out = '0123456789ABCDEF'
	EndSwitch
	
	If $s_Symbol_In = '0123456789' Then ; ���� ������� ����� ����������, ��
		$sDec = $sIn
		If Not StringIsDigit($sDec) Then Return _Error(2) ; �������� ��������� ������ ���������� ����
	ElseIf $s_Symbol_In = 'Roman' Then
		$sDec =_RomanToDec($sIn)
		If @error Then Return _Error(4)
	Else ; ����� ��������������� ������� � ����������
		$sDec =_NumToDec($sIn, $s_Symbol_In)
		If @error Then Return _Error(@error)
	EndIf
	
	If $s_Symbol_Out = '0123456789' Then ; ���� �������� ����� ����������, ��
		$sOut = $sDec
	ElseIf $s_Symbol_Out = 'Roman' Then
		$sOut =_DecToRoman($sDec)
		If @error Then Return _Error(3)
	ElseIf $s_Symbol_Out = 'Text' Then
		$sOut =_NumberNumToName($sDec, $iRusLng)
	Else ; ����� ��������������� ���������� � ���������
		$sOut =_DecToNum($sDec, $s_Symbol_Out)
		If @error Then Return _Error(@error)
	EndIf
	
	If $ini_000<>'0' And $s_Symbol_Out <> 'Text' And $s_Symbol_Out <> 'Roman' Then
		$0_In = StringLeft($s_Symbol_In, 1)
		$0_Out = StringLeft($s_Symbol_Out, 1)
		$00=StringRegExp($sIn, '^('&$0_In&'+)(.*)$', 3)
		If Not @error Then
			$00[0]=StringLen($00[0])
			If $00[1] = '' Then $sOut = ''
			For $i = 1 To $00[0]
				$sOut = $0_Out & $sOut
			Next
		EndIf
	EndIf
	
	GUICtrlSetData($iOut, $sOut)
	_GUICtrlStatusBar_SetText($hStatus, $LngScs & ' ' & $sIn & ' -> ' & $sOut)
EndFunc

Func _Error($Error)
	$sOut = ''
	GUICtrlSetData($iOut, '')
	Switch $Error
		Case 1
			_GUICtrlStatusBar_SetText($hStatus, $LngEr3)
		Case 2
			If $s_Symbol_In = 'Roman' Then $s_Symbol_In = 'IVXLCDM'
			_GUICtrlStatusBar_SetText($hStatus, $LngEr4 & ' (' & $s_Symbol_In & ')')
		Case 3
			_GUICtrlStatusBar_SetText($hStatus, $LngEr5)
		Case 4
			_GUICtrlStatusBar_SetText($hStatus, $LngEr6)
	EndSwitch
EndFunc