#include <StaticConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiMenu.au3>
Global $k = 0, $TrMenu = 0

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

$hGui = GUICreate($LngTitle, 500, 300)

; $iBtn1 = GUICtrlCreateLabel(ChrW(0x25BC), 11, 11, 23, 23, $SS_CENTER + $SS_CENTERIMAGE)
$iBtn1 = GUICtrlCreateButton(ChrW(0x25BC), 5, 5, 25, 25)
$hBtn1 = GUICtrlGetHandle($iBtn1)
GUICtrlSetFont($iBtn1, -1, -1, -1, 'Arial')

$ContMenu = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
$hMenu = GUICtrlGetHandle($ContMenu)
$iOpEpl = GUICtrlCreateMenuItem($LngOpEpl & @Tab & 'Enter', $ContMenu)
$iCMdel = GUICtrlCreateMenuItem($LngDel & @Tab & 'Ctrl+Del', $ContMenu)
$iCMDef = GUICtrlCreateMenuItem($LngDef & @Tab & 'Ctrl+Enter', $ContMenu)
$iCMreg = GUICtrlCreateMenuItem($LngOpn & ' RegEdit' & @Tab & 'Ctrl+NumPad0', $ContMenu)

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUIRegisterMsg($WM_MENUSELECT, "WM_MENUSELECT")


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

Func WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
    ; $k += 1
    ; WinSetTitle($hGui, '', 'Вызов ' & $k &', ID = '& $wParam)
	
	Local Const $BCN_HOTITEMCHANGE = -1249
	Local $tNMBHOTITEM = DllStructCreate("hwnd hWndFrom;int IDFrom;int Code;dword dwFlags", $lParam)
	Local $nNotifyCode = DllStructGetData($tNMBHOTITEM, "Code"), _
		$hCtrl = DllStructGetData($tNMBHOTITEM, "hWndFrom"), _
		$nID = DllStructGetData($tNMBHOTITEM, "IDFrom"), _
		$nNotifyCode = DllStructGetData($tNMBHOTITEM, "Code"), _
		$dwFlags = DllStructGetData($tNMBHOTITEM, "dwFlags")

    Switch $hCtrl
        Case $hBtn1
            Switch $nNotifyCode
                Case $BCN_HOTITEMCHANGE ; Win XP и выше
                    If BitAND($dwFlags, 0x10) = 0x10 Then
                        ; $sText = "наведена"
						$aPos = ControlGetPos($hGui, "", $iBtn1)
						Local $tpoint = DllStructCreate("int X;int Y")
						DllStructSetData($tpoint, "X", $aPos[0])
						DllStructSetData($tpoint, "Y", $aPos[1] + $aPos[3])
						_WinAPI_ClientToScreen($hGui, $tpoint)
						_GUICtrlMenu_TrackPopupMenu ($hMenu, $hGui, DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y"), 1)
                    ElseIf BitAND($dwFlags, 0x20) = 0x20 Then
                        ; $sText = "оставлена"
						; If Not $TrMenu Then Send('^{ESC}')
                    EndIf
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

Func WM_MENUSELECT($hWnd, $Msg, $wParam, $lParam)
    Local $ID = BitAND($wParam, 0xFFFF) ; _WinAPI_LoWord
    Local $Flags = BitShift($wParam, 16) ; _WinAPI_HiWord
	$TrMenu = $ID
    $k += 1
    WinSetTitle($hGui, '', 'Вызов ' & $k)
    Local $info = ''
    If BitAND($Flags, $MF_CHECKED) Then $info &= 'MF_CHECKED' & @CRLF
    If BitAND($Flags, $MF_DISABLED) Then $info &= 'MF_DISABLED' & @CRLF
    If BitAND($Flags, $MF_GRAYED) Then $info &= 'MF_GRAYED' & @CRLF
    If BitAND($Flags, $MF_HILITE) Then $info &= 'MF_HILITE' & @CRLF
    If BitAND($Flags, $MF_MOUSESELECT) Then $info &= 'MF_MOUSESELECT' & @CRLF
    If BitAND($Flags, $MF_OWNERDRAW) Then $info &= 'MF_OWNERDRAW' & @CRLF
    If BitAND($Flags, $MF_POPUP) Then $info &= 'MF_POPUP' & @CRLF
    If BitAND($Flags, $MF_SYSMENU) Then $info &= 'MF_SYSMENU' & @CRLF

	If $ID Then
	ToolTip('Дескриптор = ' & $lParam & @CRLF & _
            'ID = ' & $ID & @CRLF & _
            'Flags:' & $Flags & @CRLF & $info)
    ; GUICtrlSetData($statist, _
            ; 'Дескриптор = ' & $lParam & @CRLF & _
            ; 'ID = ' & $ID & @CRLF & _
            ; 'Flags:' & $Flags & @CRLF & $info)
	Else
		ToolTip('')
	EndIf
EndFunc