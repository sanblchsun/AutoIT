Global $k=0

Global Const $HOTKEYF_SHIFT = 0x01
Global Const $HOTKEYF_CONTROL = 0x02
Global Const $HOTKEYF_ALT = 0x04
Global Const $MOD_ALT = 0x1
Global Const $MOD_SHIFT = 0x4

$hGUI = GUICreate("������ ������ Ctrl+Alt+�", 390, 150)
GUICtrlCreateLabel('������� WM_HOTKEY ����������� ��� ������ ������������������ ������� ������. ������ ������� ������� ����������� ID �� 1001 � �����. � ������� ����������� ������� �������� ID. ���������� $sModKey �������� ����� ������������� (Shift=1, Ctrl=2, Alt=4), � ���������� $sVirtKey - ����� ������� ����������. ���� ������ ���� ��� ������� GuiHotKey.au3 � GuiHotKey_Example.au3 �� rasim.'&@CRLF&'������� ������� ��������� ���� ����� ���� ���������, �� ��� �������, ��� ������� �� ���� ������ ������ ����������� �������������.', 5, 5, 360, 140)
GUISetState()

GUIRegisterMsg(0x312, "WM_HOTKEY")

$sID=1001
$sVirtKey=67
$sModKey=6
$iModKey = 0
If BitAND($sModKey, $HOTKEYF_SHIFT) Then $iModKey = BitOR($iModKey, $MOD_SHIFT)
If BitAND($sModKey, $HOTKEYF_CONTROL) Then $iModKey = BitOR($iModKey, $HOTKEYF_CONTROL)
If BitAND($sModKey, $HOTKEYF_ALT) Then $iModKey = BitOR($iModKey, $MOD_ALT)
$aRet = DllCall("user32.dll", "int", "RegisterHotKey", "hwnd", $hGUI, "int", $sID, "int", $iModKey, "int", "0x" & Hex($sVirtKey, 2))


Do
Until GUIGetMsg() = -3

Func WM_HOTKEY($hWnd, $Msg, $wParam, $lParam)
	$k+=1
	WinSetTitle($hGUI, '', '����� ' &$k& ' ���')
	; Local $iKeyID = BitAND($wParam, 0xFFFF)
	; If $iKeyID = 1001 Then Run("calc.exe")
EndFunc   ;==>WM_HOTKEY
