#include <WindowsConstants.au3>
#include <EditConstants.au3>
Global $k = 0
Global Const $HOTKEYF_SHIFT = 0x01
Global Const $HOTKEYF_CONTROL = 0x02
Global Const $HOTKEYF_ALT = 0x04
Global Const $MOD_ALT = 0x1
Global Const $MOD_SHIFT = 0x4

$hGUI = GUICreate("������ ������ Ctrl+A", 540, 350)
$myedit = GUICtrlCreateEdit('������� WM_HOTKEY ����������� ��� ������ ������������������ ������� ������. ������ ������� ������� ����������� ID �� 1001 � �����. � ������� ����������� ������� ��������. ���������� $iModKey �������� ����� ������������� (Shift=1, Ctrl=2, Alt=4), � ���������� $sVirtKey - ����� ������� ����������. ���� ������ ���� ��� ������� GuiHotKey.au3 � GuiHotKey_Example.au3 �� rasim.' & @CRLF & '������� ������� ��������� ���� ����� ���� ���������, �� ��� �������, ��� ������� �� ���� ������ ������ ����������� �������������.', 10, 10, 520, 330, $ES_AUTOVSCROLL + $WS_VSCROLL + $ES_NOHIDESEL + $ES_WANTRETURN)
GUISetState()
Send("{END}")

GUIRegisterMsg(0x312, "WM_HOTKEY")

$sID = 1001
$sVirtKey = 65 ; 65 - ��� ������� A, 67 ��� ������� C
; $sVirtKey='0x43' ; ��� ������� C (��� Hex � �������, ��� "0x" & Hex($sVirtKey1, 2))
$sVirtKey1 = 68 ; ��� ������� D
$sModKey = 'Ctrl+�'
$iModKey = 0
If StringInStr($sModKey, 'Shift') Then $iModKey = BitOR($iModKey, $MOD_SHIFT)
If StringInStr($sModKey, 'Ctrl') Then $iModKey = BitOR($iModKey, $HOTKEYF_CONTROL)
If StringInStr($sModKey, 'Alt') Then $iModKey = BitOR($iModKey, $MOD_ALT)
$aRet = DllCall("user32.dll", "int", "RegisterHotKey", "hwnd", $hGUI, "int", $sID, "int", $iModKey, "int", "0x" & Hex($sVirtKey, 2))
$aRet = DllCall("user32.dll", "int", "RegisterHotKey", "hwnd", $hGUI, "int", $sID + 1, "int", $iModKey, "int", "0x" & Hex($sVirtKey1, 2))

Do
Until GUIGetMsg() = -3

Func WM_HOTKEY($hWnd, $Msg, $wParam, $lParam)
	$iModKey = BitAND($lParam, 0xFFFF) ; _WinAPI_LoWord
	$sVirtKey = BitShift($lParam, 16) ; _WinAPI_HiWord
	$iID = Number($wParam)
	$Res = ''
	If BitAND($iModKey, $HOTKEYF_CONTROL) Then $Res &= 'Ctrl+'
	If BitAND($iModKey, $MOD_SHIFT) Then $Res &= 'Shift+'
	If BitAND($iModKey, $MOD_ALT) Then $Res &= 'Alt+'

	If BitAND($iModKey, $HOTKEYF_CONTROL) And $sVirtKey = 65 Then
		GUICtrlSendMsg($myedit, $EM_SETSEL, 0, -1)
	ElseIf BitAND($iModKey, $HOTKEYF_CONTROL) And $sVirtKey = 68 Then
		MsgBox(0, '���������', 'Ctrl+D')
	EndIf

	$k += 1
	WinSetTitle($hGUI, '', '����� ' & $k & ' ���, �����������=' & $Res & ', �������=' & $sVirtKey&', ID='&$iID)
EndFunc