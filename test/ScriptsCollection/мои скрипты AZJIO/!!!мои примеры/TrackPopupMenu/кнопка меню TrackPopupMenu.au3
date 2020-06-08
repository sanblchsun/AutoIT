#include <StaticConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiMenu.au3>


; En

$LngTitle = 'Test'
$LngOpEpl='Open in Explorer'
$LngDel = 'Delete'
$LngDef = 'Default'
$LngOpn = 'Open'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
$LngTitle = 'Контекстное меню'
$LngOpEpl='Открыть в проводнике'
$LngDel = 'Удалить'
$LngDef = 'Основной'
$LngOpn = 'Открыть'
EndIf

$hGui = GUICreate($LngTitle, 500, 300, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_OVERLAPPEDWINDOW, $WS_CLIPCHILDREN), $WS_EX_ACCEPTFILES)

; $iBtn1 = GUICtrlCreateLabel(ChrW('0x25BC'), 11, 11, 23, 23, $SS_CENTER + $SS_CENTERIMAGE)
$iBtn1 = GUICtrlCreateButton(ChrW('0x25BC'), 5, 5, 25, 25)
$hBtn1 = _SetButton($iBtn1)
$iBtn2 = GUICtrlCreateButton(ChrW('0x25BC'), 500 - 30, 5, 25, 25)
$hBtn2 = _SetButton($iBtn2)
$iBtn3 = GUICtrlCreateButton(ChrW('0x25B2'), 500 - 30, 300 - 30, 25, 25)
$hBtn3 = _SetButton($iBtn3)
$iBtn4 = GUICtrlCreateButton(ChrW('0x25B2'), 5, 300 - 30, 25, 25)
$hBtn4 = _SetButton($iBtn4)


$iBtn5 = GUICtrlCreateButton(ChrW('0x25BA'), 120, 5, 25, 25)
$hBtn5 = _SetButton($iBtn5)
$iBtn6 = GUICtrlCreateButton(ChrW('0x25C4'), 500 - 140, 5, 25, 25)
$hBtn6 = _SetButton($iBtn6)
$iBtn7 = GUICtrlCreateButton(ChrW('0x25BA'), 120, 300 - 30, 25, 25)
$hBtn7 = _SetButton($iBtn7)
$iBtn8 = GUICtrlCreateButton(ChrW('0x25C4'), 500 - 140, 300 - 30, 25, 25)
$hBtn8 = _SetButton($iBtn8)
; GUICtrlSetState(-1, $GUI_NOFOCUS)

; $iDummy = GUICtrlCreateDummy()
$ContMenu = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
$hMenu = GUICtrlGetHandle($ContMenu)
$iOpEpl = GUICtrlCreateMenuItem($LngOpEpl & @Tab & 'Enter', $ContMenu)
$iCMdel = GUICtrlCreateMenuItem($LngDel & @Tab & 'Ctrl+Del', $ContMenu)
$iCMDef = GUICtrlCreateMenuItem($LngDef & @Tab & 'Ctrl+Enter', $ContMenu)
$iCMreg = GUICtrlCreateMenuItem($LngOpn & ' RegEdit' & @Tab & 'Ctrl+NumPad0', $ContMenu)

GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
; GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

GUISetState()
While 1
	Switch GUIGetMsg()
		Case $iOpEpl
			MsgBox(0, '?', $LngOpEpl)
		Case $iCMdel
			MsgBox(0, '?', $LngDel)
		Case $iCMDef
			MsgBox(0, '?', $LngDef)
		Case $iCMreg
			MsgBox(0, '?', $LngOpn)
		Case -3
			Exit
	EndSwitch
WEnd

Func WM_COMMAND($hWnd, $Msg, $wParam, $lParam)
    #forceref $hWnd, $Msg
    Local $nNotifyCode = BitShift($wParam, 16)
    Local $nID = BitAND($wParam, 0x0000FFFF)
    Local $hCtrl = $lParam
    
    Switch $hCtrl
        Case $hBtn1
            Switch $nNotifyCode
                Case $BN_CLICKED
					$aPos = ControlGetPos($hGui, "", $iBtn1)
					Local $tpoint = DllStructCreate("int X;int Y")
					DllStructSetData($tpoint, "X", $aPos[0])
					DllStructSetData($tpoint, "Y", $aPos[1] + $aPos[3])
					_WinAPI_ClientToScreen($hGui, $tpoint)
					_GUICtrlMenu_TrackPopupMenu ($hMenu, $hGui, DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y"), 1)
            EndSwitch
            Return 0 ; Only workout clicking on the button
        Case $hBtn2
            Switch $nNotifyCode
                Case $BN_CLICKED
					$aPos = ControlGetPos($hGui, "", $iBtn2)
					Local $tpoint = DllStructCreate("int X;int Y")
					DllStructSetData($tpoint, "X", $aPos[0] + $aPos[2])
					DllStructSetData($tpoint, "Y", $aPos[1] + $aPos[3])
					_WinAPI_ClientToScreen($hGui, $tpoint)
					_GUICtrlMenu_TrackPopupMenu ($hMenu, $hGui, DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y"), 2)
            EndSwitch
            Return 0 ; Only workout clicking on the button
        Case $hBtn3
            Switch $nNotifyCode
                Case $BN_CLICKED
					$aPos = ControlGetPos($hGui, "", $iBtn3)
					Local $tpoint = DllStructCreate("int X;int Y")
					DllStructSetData($tpoint, "X", $aPos[0] + $aPos[2])
					DllStructSetData($tpoint, "Y", $aPos[1])
					_WinAPI_ClientToScreen($hGui, $tpoint)
					_GUICtrlMenu_TrackPopupMenu ($hMenu, $hGui, DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y"), 2, 0)
            EndSwitch
            Return 0 ; Only workout clicking on the button
        Case $hBtn4
            Switch $nNotifyCode
                Case $BN_CLICKED
					$aPos = ControlGetPos($hGui, "", $iBtn4)
					Local $tpoint = DllStructCreate("int X;int Y")
					DllStructSetData($tpoint, "X", $aPos[0])
					DllStructSetData($tpoint, "Y", $aPos[1])
					_WinAPI_ClientToScreen($hGui, $tpoint)
					_GUICtrlMenu_TrackPopupMenu ($hMenu, $hGui, DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y"), 1, 0)
            EndSwitch
            Return 0 ; Only workout clicking on the button
        Case $hBtn5
            Switch $nNotifyCode
                Case $BN_CLICKED
					$aPos = ControlGetPos($hGui, "", $iBtn5)
					Local $tpoint = DllStructCreate("int X;int Y")
					DllStructSetData($tpoint, "X", $aPos[0] + $aPos[2])
					DllStructSetData($tpoint, "Y", $aPos[1])
					_WinAPI_ClientToScreen($hGui, $tpoint)
					_GUICtrlMenu_TrackPopupMenu ($hMenu, $hGui, DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y"), 1)
            EndSwitch
            Return 0 ; Only workout clicking on the button
        Case $hBtn6
            Switch $nNotifyCode
                Case $BN_CLICKED
					$aPos = ControlGetPos($hGui, "", $iBtn6)
					Local $tpoint = DllStructCreate("int X;int Y")
					DllStructSetData($tpoint, "X", $aPos[0])
					DllStructSetData($tpoint, "Y", $aPos[1])
					_WinAPI_ClientToScreen($hGui, $tpoint)
					_GUICtrlMenu_TrackPopupMenu ($hMenu, $hGui, DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y"), 2)
            EndSwitch
            Return 0 ; Only workout clicking on the button
        Case $hBtn7
            Switch $nNotifyCode
                Case $BN_CLICKED
					$aPos = ControlGetPos($hGui, "", $iBtn7)
					Local $tpoint = DllStructCreate("int X;int Y")
					DllStructSetData($tpoint, "X", $aPos[0] + $aPos[2])
					DllStructSetData($tpoint, "Y", $aPos[1] + $aPos[3])
					_WinAPI_ClientToScreen($hGui, $tpoint)
					_GUICtrlMenu_TrackPopupMenu ($hMenu, $hGui, DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y"), 1, 0)
            EndSwitch
            Return 0 ; Only workout clicking on the button
        Case $hBtn8
            Switch $nNotifyCode
                Case $BN_CLICKED
					$aPos = ControlGetPos($hGui, "", $iBtn8)
					Local $tpoint = DllStructCreate("int X;int Y")
					DllStructSetData($tpoint, "X", $aPos[0])
					DllStructSetData($tpoint, "Y", $aPos[1] + $aPos[3])
					_WinAPI_ClientToScreen($hGui, $tpoint)
					_GUICtrlMenu_TrackPopupMenu ($hMenu, $hGui, DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y"), 2, 0)
            EndSwitch
            Return 0 ; Only workout clicking on the button
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

Func _SetButton($iBtn)
	GUICtrlSetFont($iBtn, -1, -1, -1, 'Arial')
	GUICtrlSetBkColor($iBtn, 0xEEEEEE)
	; GUICtrlSetBkColor($iBtn, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetColor($iBtn, 0x0)
	Return GUICtrlGetHandle($iBtn)
EndFunc