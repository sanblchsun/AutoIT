; 1. � �������� ��������� ������� �������� ������������� ������, � ���� ������� � ������ �����, �� ������� ����� ����� ���������� �� ������� � ������ ��� ������� �� ������� �������.
; 2. ����� ��������� ���������� ����� ������������� ���������� WM-��������� (WM_SYSCOMMAND) ������������� ��� ����� �� ���������, �.�. �� ����� ������� ����������� ���� � ��� ������������.
; 3. ��� ������ ��������� ���������� ����������
;			�) ��� �������� �� ������ � ������� �� ���������� � ������� ����������� ������ ��������. ������� �� ������ ��������� �� �������.
;			�) ���� ������������ "�������" � �����������, �.�. �������� �� �����. ��������� �� ������ ���� ����� -1 (�������� �� ����� -1), ������ �� ����� ������������� � 0 (�������), ���������� ����������� �������� ������� "��������" � ������� (��������� ������� ����������� |).

; �������� ����� ����, ��������� �� ���������������. ����� ����� ��������� ������� ����. ��� ������������� WM_SYSCOMMAND �� ����������� ��������� ������ ���������� � ������ ��� ini, ����� ������ ��������� ����������, ������� ��� ������ ����� ���������.

#include <GUIConstantsEx.au3>
#include <WinAPI.au3>

Global $WHXY[4], $Ini = @ScriptDir & '\Setting.ini'
$WHXY[0] = 400
$WHXY[1] = 300
$WHXY[2] = IniRead($Ini, 'Setting', 'X', '')
$WHXY[3] = IniRead($Ini, 'Setting', 'Y', '')
_SetCoor($WHXY)

$hGui = GUICreate("���������� ������� ����", $WHXY[0], $WHXY[1], $WHXY[2], $WHXY[3])

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			_SavePos()
			Exit
	EndSwitch
WEnd

Func _SavePos()
	$tRect = DllStructCreate($tagRECT)
	$tRect = _WinAPI_GetWindowRect($hGui)
	$x = DllStructGetData($tRect, "Left")
	$y = DllStructGetData($tRect, "Top")
	If $x > -2 And $x < @DesktopWidth Then IniWrite($Ini, 'Setting', 'X', $x)
	If $y > -2 And $y < @DesktopHeight Then IniWrite($Ini, 'Setting', 'Y', $y)
EndFunc   ;==>_Pos

; ���������� ��������� ��������� ��� �������
Func _SetCoor(ByRef $WHXY, $d = 0)
	; _ArrayDisplay($WHXY, '������')
	Local $Xtmp, $Ytmp, $aWA
	$Frm = _WinAPI_GetSystemMetrics(32) * 2
	$CpT = _WinAPI_GetSystemMetrics(4) + _WinAPI_GetSystemMetrics(33) * 2
	$WHXY[0] = $WHXY[0] + $Frm
	$WHXY[1] = $WHXY[1] + $CpT - $d
	$aWA = _WinAPI_GetWorkingArea()
	ReDim $aWA[6]
	$aWA[4] = $aWA[2] - $aWA[0] ; ������
	$aWA[5] = $aWA[3] - $aWA[1] ; ������
	; $sLeftArea, $sTopArea, $sRightArea, $sBottomArea
	$Xtmp = Number($WHXY[2])
	$Ytmp = Number($WHXY[3])
	If $Xtmp < 0 And $Xtmp <> -1 Then $Xtmp = 0
	If $WHXY[0] >= $aWA[4] Then
		$WHXY[0] = $aWA[4]
		$Xtmp = 0
	EndIf
	If $Xtmp > $aWA[4] - $WHXY[0] Then $Xtmp = $aWA[4] - $WHXY[0]
	If $WHXY[2] = '' Then $Xtmp = -1
	
	If $Ytmp < 0 And $Ytmp <> -1 Then $Ytmp = 0
	If $WHXY[1] >= $aWA[5] Then
		$WHXY[1] = $aWA[5]
		$Ytmp = 0
	EndIf
	If $Ytmp > $aWA[5] - $WHXY[1] Then $Ytmp = $aWA[5] - $WHXY[1] ; �������� �������� �� ���������
	If $WHXY[3] = '' Then $Ytmp = -1
	$WHXY[0] = $WHXY[0] - $Frm
	$WHXY[1] = $WHXY[1] - $CpT + $d
	$WHXY[2] = $Xtmp + $aWA[0]
	$WHXY[3] = $Ytmp + $aWA[1]
	; _ArrayDisplay($WHXY, '������')
EndFunc   ;==>_SetCoor

Func _WinAPI_GetWorkingArea()
	Local Const $SPI_GETWORKAREA = 48
	Local $stRECT = DllStructCreate("long; long; long; long")

	Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
	If @error Then Return 0
	If $SPIRet[0] = 0 Then Return 0

	Local $sLeftArea = DllStructGetData($stRECT, 1)
	Local $sTopArea = DllStructGetData($stRECT, 2)
	Local $sRightArea = DllStructGetData($stRECT, 3)
	Local $sBottomArea = DllStructGetData($stRECT, 4)

	Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
	Return $aRet
EndFunc   ;==>_WinAPI_GetWorkingArea