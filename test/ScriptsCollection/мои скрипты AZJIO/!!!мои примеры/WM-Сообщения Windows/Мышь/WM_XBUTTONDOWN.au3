Global $k=0

Global Const $MK_CONTROL = 0x8
Global Const $MK_LBUTTON = 0x1
Global Const $MK_MBUTTON = 0x10
Global Const $MK_RBUTTON = 0x2
Global Const $MK_SHIFT = 0x4
Global Const $MK_XBUTTON1 = 0x20
Global Const $MK_XBUTTON2 = 0x40

$Gui = GUICreate("Клик дополнительной кнопкой мыши", 400, 150)
GUICtrlCreateLabel('Функция WM_XBUTTONDOWN срабатывает в момент нажатия дополнителной кнопки мыши в клиенской области окна.', 5, 5, 380, 34)
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
    ToolTip("X кнопка нажата: " & @LF & "Клавиша: " & _KeysHeld($wParam) & @LF & "X: " & $X & @LF & "Y: " & $Y, Default, Default, "Мышь", 1, 1)
    Return 0
EndFunc

Func _KeysHeld($iKeys)
    Local $sKeyHeld
    If BitAND($iKeys, $MK_CONTROL) Then $sKeyHeld &= 'CTRL нажата' & @LF
    If BitAND($iKeys, $MK_LBUTTON) Then $sKeyHeld &= 'Левая кнопка мыши нажата' & @LF
    If BitAND($iKeys, $MK_MBUTTON) Then $sKeyHeld &= 'Средняя кнопка мыши нажата' & @LF
    If BitAND($iKeys, $MK_RBUTTON) Then $sKeyHeld &= 'Правая кнопка мыши нажата' & @LF
    If BitAND($iKeys, $MK_SHIFT) Then $sKeyHeld &= 'SHIFT нажата' & @LF
    If BitAND($iKeys, $MK_XBUTTON1) Then $sKeyHeld &= 'Windows 2000/XP: Первая X кнопка нажата' & @LF
    If BitAND($iKeys, $MK_XBUTTON2) Then $sKeyHeld &= 'Windows 2000/XP: Вторая X кнопка нажата' & @LF
    Return $sKeyHeld
EndFunc