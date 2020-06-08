#include <GUIConstantsEx.au3>
#Include <GuiMenu.au3>
Global $k=0
$hGUI = GUICreate("Кликни главное меню окна", 400, 200)

$mFilemenu = GUICtrlCreateMenu("File")
$mExititem = GUICtrlCreateMenuItem("Exit", $mFilemenu)
$mSpecialitem = GUICtrlCreateMenu("Special")
$mSpecitem1 = GUICtrlCreateMenuItem("Spe1", $mSpecialitem)
$mSpecitem2 = GUICtrlCreateMenuItem("Spe2", $mSpecialitem)
$mHelpmenu = GUICtrlCreateMenu("Help")
$mAboutitem = GUICtrlCreateMenuItem("About", $mHelpmenu)
GUICtrlCreateLabel('Функция WM_ENTERMENULOOP срабатывает в момент клика главного меню окна (но не пунктов в меню)', 5, 5, 360, 130)

GUISetState()

$hMenu = _GUICtrlMenu_GetMenu($hGUI)
$iCount = _GUICtrlMenu_GetItemCount($hMenu) - 1

GUIRegisterMsg(0x0211,"WM_ENTERMENULOOP") ; WM_ENTERMENULOOP

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE, $mExititem
            Exit
    EndSwitch
WEnd

Func WM_ENTERMENULOOP($hWnd, $iMsg, $wParam, $lParam)
	$k+=1
    For $i = 0 To $iCount
        Local $tRect = _GUICtrlMenu_GetItemRectEx($hGUI, $hMenu, $i)
        Local $aMousePos = MouseGetPos()
        Local $aRes = DllCall("User32.dll", "int", "PtInRect", "ptr", DllStructGetPtr($tRect), "int", $aMousePos[0], "int", $aMousePos[1])
        If Not @error And $aRes[0] Then
            WinSetTitle($hGUI, '', 'Вызов ' &$k& ' раз, - '&_GUICtrlMenu_GetItemText($hMenu, $i))
            ExitLoop
        EndIf
    Next
EndFunc
 