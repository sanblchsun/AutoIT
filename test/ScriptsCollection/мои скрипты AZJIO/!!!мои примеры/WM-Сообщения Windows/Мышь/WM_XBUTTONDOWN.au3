Global $k=0

Global Const $MK_CONTROL = 0x8
Global Const $MK_LBUTTON = 0x1
Global Const $MK_MBUTTON = 0x10
Global Const $MK_RBUTTON = 0x2
Global Const $MK_SHIFT = 0x4
Global Const $MK_XBUTTON1 = 0x20
Global Const $MK_XBUTTON2 = 0x40

$Gui = GUICreate("���� �������������� ������� ����", 400, 150)
GUICtrlCreateLabel('������� WM_XBUTTONDOWN ����������� � ������ ������� ������������� ������ ���� � ��������� ������� ����.', 5, 5, 380, 34)
GUISetState()

GUIRegisterMsg(0x020B, "WM_XBUTTONDOWN")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_XBUTTONDOWN($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    ToolTip("X ������ ������: " & @LF & "�������: " & _KeysHeld($wParam) & @LF & "X: " & $X & @LF & "Y: " & $Y, Default, Default, "����", 1, 1)
    Return 0
EndFunc

Func _KeysHeld($iKeys)
    Local $sKeyHeld
    If BitAND($iKeys, $MK_CONTROL) Then $sKeyHeld &= 'CTRL ������' & @LF
    If BitAND($iKeys, $MK_LBUTTON) Then $sKeyHeld &= '����� ������ ���� ������' & @LF
    If BitAND($iKeys, $MK_MBUTTON) Then $sKeyHeld &= '������� ������ ���� ������' & @LF
    If BitAND($iKeys, $MK_RBUTTON) Then $sKeyHeld &= '������ ������ ���� ������' & @LF
    If BitAND($iKeys, $MK_SHIFT) Then $sKeyHeld &= 'SHIFT ������' & @LF
    If BitAND($iKeys, $MK_XBUTTON1) Then $sKeyHeld &= 'Windows 2000/XP: ������ X ������ ������' & @LF
    If BitAND($iKeys, $MK_XBUTTON2) Then $sKeyHeld &= 'Windows 2000/XP: ������ X ������ ������' & @LF
    Return $sKeyHeld
EndFunc