#include <GUIConstantsEx.au3>
#include <DateTimeConstants.au3>
#include <Timers.au3>
#include <String.au3>
#include <GuiMenu.au3>

Opt('MustDeclareVars', 1)
Global $hGUI, $hMenu, $cMenu

MenuBarClock()

Func MenuBarClock()
    Local $msg, $filemenu, $openitem, $helpmenu, $iMenuCnt, $cMenuTimeItem

    $hGUI = GUICreate("Select 'File' menu item 'Open' or select clock item", 400, 200)
    
    $filemenu = GUICtrlCreateMenu("&File")
    $openitem = GUICtrlCreateMenuItem("Open", $filemenu)
    GUICtrlCreateMenu("Recent Files", $filemenu, 1)
    GUICtrlCreateMenuItem("Save", $filemenu)
    GUICtrlCreateMenuItem("Exit", $filemenu)
    
    $helpmenu = GUICtrlCreateMenu("?")
    GUICtrlCreateMenuItem("Info", $helpmenu)

    $cMenu = GUICtrlCreateMenu(StringFormat("%02d:%02d:%02d", @HOUR, @MIN, @SEC))
    $cMenuTimeItem = GUICtrlCreateMenuItem("Set Time", $cMenu)
    
    $hMenu = _GUICtrlMenu_GetMenu($hGUI)
    $iMenuCnt = _GUICtrlMenu_GetItemCount($hMenu)
    _GUICtrlMenu_SetItemType($hMenu, ($iMenuCnt - 1), $MFT_RIGHTJUSTIFY, True)
    
    _Timer_SetTimer($hGUI, 1000, "_UpdateMenuClock"); create timer
    GUISetState()

    Sleep(2000)
    Beep(1000, 5)
    GUICtrlCreateMenu("Add menu item test", -1, 2); if menu position not used, menu item would be added after clock

    While 1
        $msg = GUIGetMsg()
        Switch $msg
            Case $openitem, $cMenuTimeItem
                MsgBox(262144, "Messageloop block test", "See how the clock is still working?", 0, $hGUI)
            Case $GUI_EVENT_CLOSE
                GUIDelete()
                Exit
        EndSwitch
    WEnd

EndFunc ;==>MenuBarClock

; call back function
Func _UpdateMenuClock($hWnd, $msg, $iIDTimer, $dwTime)
    #forceref $hWnd, $Msg, $iIDTimer, $dwTime
    GUICtrlSetData($cMenu, StringFormat("%02d:%02d:%02d", @HOUR, @MIN, @SEC))
EndFunc ;==>_UpdateMenuClock