; в отличии от первого варианта здесь сохраняются координаты, даже когда окно было свёрнутым, так как координаты кэшируются при перемещении окна
; Упрощённый вариант размера окна - событие $GUI_EVENT_RESIZED + WinGetClientSize
#include <WindowsConstants.au3>
Global $XYPos[4], $Tr7=0, $ini=@ScriptDir&'\SaveXY.ini'
Global $k=0 ; удалить статистику

Switch @OSVersion
	Case 'WIN_VISTA', 'WIN_7'
		$Tr7=1
EndSwitch

$XYPos[0]=Number(IniRead($Ini, 'Set', 'W', '330'))
$XYPos[1]=Number(IniRead($Ini, 'Set', 'H', '220'))
$XYPos[2]=IniRead($Ini, 'Set', 'X', '')
$XYPos[3]=IniRead($Ini, 'Set', 'Y', '')

If $XYPos[0]<230 Then $XYPos[0]=230 ; ограничение ширины
If $XYPos[1]<300 Then $XYPos[1]=300 ; ограничение высоты
_SetCoor($XYPos)

; валидность координат проверяем при запуске
Func _SetCoor(ByRef $XYPos)
	$Xtmp=Number($XYPos[2])
	$Ytmp=Number($XYPos[3])
	If $Xtmp < 0 And $Xtmp <>-1 Then $Xtmp=0
	If $Xtmp > @DesktopWidth-$XYPos[0] Then $Xtmp=@DesktopWidth-$XYPos[0]
	If $XYPos[2]='' Then $Xtmp=-1
	If $Ytmp < 0 And $Ytmp <>-1 Then $Ytmp=0
	If $Ytmp > @DesktopHeight-$XYPos[1] Then $Ytmp=@DesktopHeight-$XYPos[1]
	If $XYPos[3]='' Then $Ytmp=-1
	$XYPos[2]=$Xtmp
	$XYPos[3]=$Ytmp
EndFunc


$Gui=GUICreate('My Program', $XYPos[0], $XYPos[1], $XYPos[2], $XYPos[3], $WS_OVERLAPPEDWINDOW)
$OpFile=GUICtrlCreateButton ('...', 150, 5, 86, 28)
$StatusBar=GUICtrlCreateLabel('Статистика', 5, 45, 240, 135)
GUISetState ()
OnAutoItExitRegister("_Exit_Save_Ini")
GUIRegisterMsg($WM_SIZE, "WM_SIZE")
GUIRegisterMsg($WM_WINDOWPOSCHANGING , "WM_WINDOWPOSCHANGING")
While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $OpFile
			$tmp = FileOpenDialog('open', @ScriptDir , 'Все (*.*)', '', '', $Gui)
			If Not @error Then MsgBox(0, 'Message', $tmp)
		Case -3
			 Exit
	EndSwitch
WEnd

Func _Exit_Save_Ini()
	IniWrite($Ini, 'Set', 'W', $XYPos[0])
	IniWrite($Ini, 'Set', 'H', $XYPos[1])
	IniWrite($Ini, 'Set', 'X', $XYPos[2])
	IniWrite($Ini, 'Set', 'Y', $XYPos[3])
EndFunc

Func WM_SIZE($hWnd, $Msg, $wParam, $lParam) ;можно переместить в WM_WINDOWPOSCHANGING но тогда не будет ресайза в текущем времени для элеметов "по особым правилам" и учесть что в этой функции клиентские размеры,в отличии от WM_WINDOWPOSCHANGING
	Switch $Tr7
		Case 1
			If Not BitAnd(WinGetState($Gui), 16) Then
				$XYPos[0] = BitAND($lParam, 0x0000FFFF)
				$XYPos[1] = BitShift($lParam, 16)
			EndIf
		Case Else ; Если окно не свёрнуто при выходе, то сохраняем координаты в переменную.
			If Not BitAnd(WinGetState($Gui), 16) Then
				$XYPos[0] = BitAND($lParam, 0x0000FFFF)
				$XYPos[1] = BitShift($lParam, 16)
			EndIf
	EndSwitch
    ; _WinAPI_MoveWindow($Dubl, 10, 100, $XYPos[0]-20, $XYPos[1]-100) ; изменение размера по особым правилам, например для _GUICtrlListView_Create
	Return 'GUI_RUNDEFMSG'
EndFunc

Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
	Local $sRect = DllStructCreate("Int[6]", $lparam)
	Switch $Tr7
		Case 1
			If DllStructGetData($sRect, 1, 5)<>0 And Not BitAnd(WinGetState($Gui), 16) Then
				$XYPos[2]=DllStructGetData($sRect, 1, 3)
				$XYPos[3]=DllStructGetData($sRect, 1, 4)
			EndIf
		Case Else ; Если окно отпущено после перемещения, не вызвано диалогового окна, не свёрнуто при выходе, то сохраняем координаты в переменную
			If DllStructGetData($sRect, 1, 2) And DllStructGetData($sRect, 1, 5)<>0 And Not BitAnd(WinGetState($Gui), 16) Then
				$XYPos[2]=DllStructGetData($sRect, 1, 3)
				$XYPos[3]=DllStructGetData($sRect, 1, 4)
			EndIf
	EndSwitch
	; удалить статистику, начало
	Local $ykazatel = DllStructGetData($sRect, 1, 1), _
	$otpysk = DllStructGetData($sRect, 1, 2), _
	$left = DllStructGetData($sRect, 1, 3), _
	$top = DllStructGetData($sRect, 1, 4), _
	$WinSizeX = DllStructGetData($sRect, 1, 5), _
	$WinSizeY = DllStructGetData($sRect, 1, 6)

	$k+=1
	GUICtrlSetData($StatusBar,'Вызов ' &$k& ' раз'&@CRLF&'число='&$ykazatel&@CRLF&'отпуск='&$otpysk&@CRLF& 'Left='&$left&@CRLF&'Top='&$top&@CRLF& 'WinSizeX='&$WinSizeX&@CRLF&'WinSizeY='&$WinSizeY)
	WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз, x='&$WinSizeX&', y='&$WinSizeY)
	; удалить статистику, конец
	Return 'GUI_RUNDEFMSG'
EndFunc