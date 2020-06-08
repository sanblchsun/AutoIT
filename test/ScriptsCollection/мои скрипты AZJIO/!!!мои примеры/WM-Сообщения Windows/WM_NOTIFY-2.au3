; переделанный пример из UDF _GUICtrlButton_Create
#include <GuiButton.au3>
Global $k=0
Global $L=0
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
Global $btn1, $btn2, $iMemo

$GUI = GUICreate("Наведи на кнопки", 430, 150)
GUICtrlCreateLabel("Функция WM_NOTIFY срабатывает при взаимодействии с кнопкой", 90, 5, 330, 40)
$iMemo = GUICtrlCreateLabel("", 90, 45, 330, 100)
$btn1 = GUICtrlCreateButton("= Кнопка1 =", 5, 5, 70, 25)
$btn2 = GUICtrlCreateButton("Кнопка2", 5, 35, 70, 25)
GUIRegisterMsg(0x004E, "WM_NOTIFY")

GUISetState()

While 1
	Switch GUIGetMsg()
		Case -3
			Exit
	EndSwitch
WEnd

Func WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
	$L+=1
	$GP = MouseGetPos()
	WinSetTitle($Gui, '', 'Вызов ' &$k& ', Событие '&$L& ' раз, x='&$GP[0]&', y='&$GP[1])
	
    #forceref $hWnd, $Msg, $wParam
    Local Const $BCN_HOTITEMCHANGE = -1249
    Local $tNMBHOTITEM = DllStructCreate("hwnd hWndFrom;int IDFrom;int Code;dword dwFlags", $lParam)
    Local $nNotifyCode = DllStructGetData($tNMBHOTITEM, "Code")
    Local $nID = DllStructGetData($tNMBHOTITEM, "IDFrom")
    Local $hCtrl = DllStructGetData($tNMBHOTITEM, "hWndFrom")
    Local $dwFlags = DllStructGetData($tNMBHOTITEM, "dwFlags")
    Local $sText = ""
    
    Switch $nNotifyCode
        Case $BCN_HOTITEMCHANGE ; Win XP and Above
            If BitAND($dwFlags, 0x10) = 0x10 Then
                $sText = "Наведено на кнопку" & @CRLF
				$k+=1
				WinSetTitle($Gui, '', 'Вызов ' &$k& ', Событие '&$L& ' раз, x='&$GP[0]&', y='&$GP[1])
            ElseIf BitAND($dwFlags, 0x20) = 0x20 Then
                $sText = "Оставлена кнопка" & @CRLF
				$k+=1
				WinSetTitle($Gui, '', 'Вызов ' &$k& ', Событие '&$L& ' раз, x='&$GP[0]&', y='&$GP[1])
            EndIf
    GUICtrlSetData($iMemo, $sText &'Имя кнопки - '& _GUICtrlButton_GetText($hCtrl))
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc