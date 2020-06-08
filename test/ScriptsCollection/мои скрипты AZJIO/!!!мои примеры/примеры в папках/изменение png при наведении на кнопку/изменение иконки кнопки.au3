#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiButton.au3>

$Gui=GUICreate("Тест", 300, 220, -1, -1, BitOr($WS_BORDER, $WS_POPUP, $WS_SYSMENU))

$btn1 = GUICtrlCreateButton("", 300-23, 2, 21, 21, $BS_ICON)
GUICtrlSetImage($btn1, "shell32.dll", -28, 0)
$btn2 = GUICtrlCreateButton("", 115, 66, 40, 40, $BS_ICON)
GUICtrlSetImage($btn2, "shell32.dll", -162)

GUISetState()

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

While 1
	Switch GUIGetMsg()
		Case $btn2
			MsgBox(0, 'Сообщение', 'е')
		Case $GUI_EVENT_CLOSE, $btn1
			ExitLoop
	EndSwitch
WEnd

Func WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
	
    #forceref $hWnd, $Msg, $wParam
    Local Const $BCN_HOTITEMCHANGE = -1249
    Local $tNMBHOTITEM = DllStructCreate("hwnd hWndFrom;int IDFrom;int Code;dword dwFlags", $lParam)
    Local $nNotifyCode = DllStructGetData($tNMBHOTITEM, "Code")
    Local $nID = DllStructGetData($tNMBHOTITEM, "IDFrom")
    Local $hCtrl = DllStructGetData($tNMBHOTITEM, "hWndFrom")
    Local $dwFlags = DllStructGetData($tNMBHOTITEM, "dwFlags")
    
    Switch $nNotifyCode
        Case $BCN_HOTITEMCHANGE ; Win XP and Above
            If BitAND($dwFlags, 0x10) = 0x10 Then
				Switch $nID
					Case $btn1
						GUICtrlSetImage($btn1, "shell32.dll", -113, 0)
					Case $btn2
						GUICtrlSetImage($btn2, "shell32.dll", -195)
				EndSwitch
            ElseIf BitAND($dwFlags, 0x20) = 0x20 Then
				Switch $nID
					Case $btn1
						GUICtrlSetImage($btn1, "shell32.dll", -28, 0)
					Case $btn2
						GUICtrlSetImage($btn2, "shell32.dll", -162)
				EndSwitch
            EndIf
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc