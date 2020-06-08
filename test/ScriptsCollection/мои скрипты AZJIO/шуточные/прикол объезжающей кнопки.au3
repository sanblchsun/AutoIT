
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'

$Gui = GUICreate("Опрос для статистики", 450, 260)
$Button=GUICtrlCreateButton('Да', 66, 110, 88, 30)
$ButtonN=GUICtrlCreateButton('Нет', 266, 110, 88, 30)
GUICtrlCreateLabel("Нужна ли тебе зарплата?", 0, 0,450, 44, 0x01+0x0200)
GUICtrlSetFont(-1,15)

GUISetState ()
GUIRegisterMsg(0x004E, "WM_NOTIFY")
Global $BtnXY = ControlGetPos($Gui, "", $Button)

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = $Button
           MsgBox(0, 'Сообщение', 'Однако!')
       Case $msg = $ButtonN
           MsgBox(0, 'Сообщение', 'Это очень странно.')
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
	
    #forceref $hWnd, $Msg, $wParam
    Local Const $BCN_HOTITEMCHANGE = -1249
    Local $tNMBHOTITEM = DllStructCreate("hwnd hWndFrom;int IDFrom;int Code;dword dwFlags", $lParam)
    Local $nNotifyCode = DllStructGetData($tNMBHOTITEM, "Code")
    Local $dwFlags = DllStructGetData($tNMBHOTITEM, "dwFlags")
    Local $nID = DllStructGetData($tNMBHOTITEM, "IDFrom")
    
	If $nNotifyCode=$BCN_HOTITEMCHANGE Then
		If BitAND($dwFlags, 0x10) = 0x10 And $nID = $Button Then
			; $BtnXY = ControlGetPos($Gui, "", $Button)
			$CP = MouseGetPos()
			$aCur_Info = GUIGetCursorInfo($Gui)
			If $aCur_Info[1]<$BtnXY[1]+$BtnXY[3]+2 And $aCur_Info[1]>$BtnXY[1]+$BtnXY[3]-17 And $aCur_Info[0]>$BtnXY[0]+$BtnXY[2]/2 Then
				BlockInput(1)
				MouseMove($CP[0]+$BtnXY[0]+$BtnXY[2]-$aCur_Info[0], $CP[1])
				MouseMove($CP[0]+$BtnXY[0]+$BtnXY[2]-$aCur_Info[0], $CP[1]-$BtnXY[3])
				MouseMove($CP[0], $CP[1]-$BtnXY[3])
				BlockInput(0)
			EndIf
			If $aCur_Info[1]<$BtnXY[1]+$BtnXY[3]+2 And $aCur_Info[1]>$BtnXY[1]+$BtnXY[3]-17 And $aCur_Info[0]<=$BtnXY[0]+$BtnXY[2]/2 Then
				BlockInput(1)
				MouseMove($CP[0]+$BtnXY[0]-$aCur_Info[0], $CP[1])
				MouseMove($CP[0]+$BtnXY[0]-$aCur_Info[0], $CP[1]-$BtnXY[3])
				MouseMove($CP[0], $CP[1]-$BtnXY[3])
				BlockInput(0)
			EndIf

			If $aCur_Info[1]<$BtnXY[1]+17 And $aCur_Info[1]>$BtnXY[1]-2 And $aCur_Info[0]>$BtnXY[0]+$BtnXY[2]/2 Then
				BlockInput(1)
				MouseMove($CP[0]+$BtnXY[0]+$BtnXY[2]-$aCur_Info[0], $CP[1])
				MouseMove($CP[0]+$BtnXY[0]+$BtnXY[2]-$aCur_Info[0], $CP[1]+$BtnXY[3])
				MouseMove($CP[0], $CP[1]+$BtnXY[3])
				BlockInput(0)
			EndIf

			If $aCur_Info[1]<$BtnXY[1]+17 And $aCur_Info[1]>$BtnXY[1]-2 And $aCur_Info[0]<=$BtnXY[0]+$BtnXY[2]/2 Then
				BlockInput(1)
				MouseMove($CP[0]+$BtnXY[0]-$aCur_Info[0], $CP[1])
				MouseMove($CP[0]+$BtnXY[0]-$aCur_Info[0], $CP[1]+$BtnXY[3])
				MouseMove($CP[0], $CP[1]+$BtnXY[3])
				BlockInput(0)
			EndIf
		EndIf
	 EndIf
    Return $GUI_RUNDEFMSG
EndFunc