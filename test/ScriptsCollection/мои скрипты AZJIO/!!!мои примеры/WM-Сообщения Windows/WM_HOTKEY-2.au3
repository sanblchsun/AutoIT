Global $k=0

Global Const $HOTKEYF_SHIFT = 0x01
Global Const $HOTKEYF_CONTROL = 0x02
Global Const $HOTKEYF_ALT = 0x04
Global Const $MOD_ALT = 0x1
Global Const $MOD_SHIFT = 0x4

$hGUI = GUICreate("������ ������ Ctrl+Alt+(A-Z)", 390, 150)
GUICtrlCreateLabel('������� WM_HOTKEY ����������� ��� ������ ������������������ ������� ������. ������ ������� ������� ����������� ID �� 1001 � �����. � ������� ����������� ������� �������� ID. ���������� $sModKey �������� ����� ������������� (Shift=1, Ctrl=2, Alt=4), � ���������� $sVirtKey - ����� ������� ����������. ���� ������ ���� ��� ������� GuiHotKey.au3 � GuiHotKey_Example.au3 �� rasim.'&@CRLF&' ������� ������� ��������� ���� ����� ���� ���������, �� ��� �������, ��� ������� �� ���� ������ ������ ����������� �������������.', 5, 5, 360, 140)
GUISetState()

GUIRegisterMsg(0x312, "WM_HOTKEY")

For $i = 1 to 26
	_GuiCtrlHotKey_RegisterHotkey($hGUI, 1000+$i, 64+$i, $HOTKEYF_ALT+$HOTKEYF_CONTROL)
Next


Do
Until GUIGetMsg() = -3

Func WM_HOTKEY($hWnd, $Msg, $wParam, $lParam)
	Local $iKeyID = BitAND($wParam, 0xFFFF)
	; If $iKeyID = 1001 Then Run("calc.exe")
	$k+=1
	WinSetTitle($hGUI, '', '����� ' &$k& ' ���, ID=' & $iKeyID-1000&'  '&Chr($iKeyID-1000+64))
EndFunc   ;==>WM_HOTKEY

;rasim
Func _GuiCtrlHotKey_RegisterHotkey($hWnd, $sID, $sVirtKey, $sModKey)
	Local $iModKey = 0
	
	If BitAND($sModKey, $HOTKEYF_SHIFT) Then $iModKey = BitOR($iModKey, $MOD_SHIFT)
	If BitAND($sModKey, $HOTKEYF_CONTROL) Then $iModKey = BitOR($iModKey, $HOTKEYF_CONTROL)
	If BitAND($sModKey, $HOTKEYF_ALT) Then $iModKey = BitOR($iModKey, $MOD_ALT)
	
	$aRet = DllCall("user32.dll", "int", "RegisterHotKey", _
											"hwnd", $hWnd, _
											"int", $sID, _
											"int", $iModKey, _
											"int", "0x" & Hex($sVirtKey, 2))
	
	If $aRet[0] <> 0 Then Return 1
EndFunc   ;==>_GuiCtrlHotKey_RegisterHotkey
