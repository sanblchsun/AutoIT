#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <TreeViewConstants.au3>
#Include <GuiTreeView.au3>


$timer = ""
$hcurrItem = ""
$hGUIHover = ""
$isOverParentItem = 0
;*** Main-GUI ***
$hMainGUI       = GUICreate("My Tree Menu", 300, 200)

$nBtnMenu       = GUICtrlCreateButton("Show Menu", 10, 10, 100, 30)

;*** Tree-Menu-GUI ***
;Dim $hMenuGUI  = GUICreate("MenuGUI", 160, 160, -1, -1, BitOr($WS_POPUP, $WS_BORDER, $WS_CHILD), $WS_EX_TOOLWINDOW, $hMainGUI) ; Flat Menu
Dim $hMenuGUI   = GUICreate("MenuGUI", 160, 160, -1, -1, BitOr($WS_POPUP, $WS_DLGFRAME, $WS_CHILD), $WS_EX_TOOLWINDOW, $hMainGUI)

Dim $nMenuTV    = GUICtrlCreateTreeView(0, 0, 160, 160, _
BitOr($TVS_NOHSCROLL, $TVS_NONEVENHEIGHT, $TVS_FULLROWSELECT, $TVS_INFOTIP, $TVS_HASBUTTONS)) ;, $TVS_TRACKSELECT))
GUICtrlSetBkColor(-1, 0xD4D0C8)
GUICtrlSetFont(-1, 10, -1, -1, "Arial")

;*** Main-Menu ***
$nItemProgs     = GUICtrlCreateTreeViewItem("Office                       >", $nMenuTV)
GUICtrlSetImage(-1, "shell32.dll", -20)
$nItemPrefs     = GUICtrlCreateTreeViewItem("Preferences              >", $nMenuTV)
GUICtrlSetImage(-1, "shell32.dll", -22)
$nItemAbout     = GUICtrlCreateTreeViewItem("About", $nMenuTV)
GUICtrlSetImage(-1, "shell32.dll", -23)
$nItemExit      = GUICtrlCreateTreeViewItem("Exit", $nMenuTV)
GUICtrlSetImage(-1, "shell32.dll", -24)

Dim $isParentItem[10] = [1,1,0,0,0]


$hSubMenuGUI    = GUICreate("MenuGUI", 160, 160, -1, -1, BitOr($WS_POPUP, $WS_DLGFRAME, $WS_CHILD), $WS_EX_TOOLWINDOW, $hMainGUI)

$nSubMenuTV = GUICtrlCreateTreeView(0, 0, 160, 160, _
BitOr($TVS_NOHSCROLL, $TVS_NONEVENHEIGHT, $TVS_FULLROWSELECT, $TVS_INFOTIP, $TVS_HASBUTTONS)) ;, $TVS_TRACKSELECT))
GUICtrlSetBkColor(-1, 0xD4D0C8)
GUICtrlSetFont(-1, 10, -1, -1, "Arial")

$nItemCalc      = GUICtrlCreateTreeViewItem("Calculator", $nSubMenuTV)
GUICtrlSetImage(-1, "calc.exe", 0)
$nItemPaint     = GUICtrlCreateTreeViewItem("Paint", $nSubMenuTV)
GUICtrlSetImage(-1, "mspaint.exe", 0)
$nItemNote      = GUICtrlCreateTreeViewItem("Notepad", $nSubMenuTV)
GUICtrlSetImage(-1, "notepad.exe", 0)
$nItemWord      = GUICtrlCreateTreeViewItem("Wordpad", $nSubMenuTV)
GUICtrlSetImage(-1, "write.exe", 0)



GUISetState(@SW_SHOW, $hMainGUI)
GUIRegisterMsg($WM_NOTIFY, "MY_WM_NOTIFY")

GUIRegisterMsg($WM_SETCURSOR, "MY_WM_NOTIFY")



While 1
    Sleep(20)
    If $timer <> "" Then
        If TimerDiff($timer) > 500 Then
            If $hGUIHover <> $hSubMenuGUI And Not $isOverParentItem Then ; if timer and
                ConsoleWrite("hmm hide?" & @CRLF)
                _GUICtrlTreeView_EndUpdate($nMenuTV)
                GUISetState(@SW_HIDE, $hSubMenuGUI)
                GUICtrlSetState($nMenuTV,$GUI_FOCUS)
                DllCall("user32.dll", "int", "SendMessage", "hwnd", $hMainGUI, "int", $WM_NCACTIVATE, "int", 1, "int", 0)
                $timer = ""
            ElseIf $hGUIHover = $hMenuGUI And $isOverParentItem then
                $arPos = WinGetPos($hMenuGUI)
                If IsArray($arPos) Then
                    $itemidx = _GUICtrlTreeView_Index($nMenuTV, $hcurrItem)
                    ConsoleWrite("verschiebe Submenu" & @CRLF)
                    WinMove($hSubMenuGUI, "", $arPos[0]+$arPos[2], $arPos[1]+$itemidx*21) ; +$parentidx*21
                EndIf
                _GUICtrlTreeView_BeginUpdate($nMenuTV)
                GUISetState(@SW_SHOW, $hSubMenuGUI)
                GUICtrlSetState($nSubMenuTV,$GUI_FOCUS)
                $timer = ""
            Else
                
            EndIf
        EndIf
    EndIf

    $Msg = GUIGetMsg()
    Switch $Msg
        Case $GUI_EVENT_CLOSE
            ExitLoop
            
        Case $nBtnMenu
            $arPos = ControlGetPos($hMainGUI, "", $nBtnMenu)
            If IsArray($arPos) Then
                $stPT = DllStructCreate("int;int")
                DllStructSetData($stPT, 1, $arPos[0])
                DllStructSetData($stPT, 2, $arPos[1])
                
                ClientToScreen($hMainGUI, DllStructGetPtr($stPT))
                
                WinMove($hMenuGUI, "", DllStructGetData($stPT, 1) + 100, DllStructGetData($stPT, 2))
                GUISetState(@SW_SHOW, $hMenuGUI)
                
                DllCall("user32.dll", "int", "SendMessage", "hwnd", $hMainGUI, "int", $WM_NCACTIVATE, "int", 1, "int", 0)
            EndIf
    EndSwitch
WEnd


Exit


Func MY_WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
    Switch $Msg
        Case $WM_SETCURSOR
            Switch $hWnd
                Case $hGUIHover
                Case Else
                    ConsoleWrite("Changed focus to: ")
                    Switch $hWnd
                        Case $hMainGUI
                            $hGUIHover = $hMainGUI
                            ConsoleWrite("MainGUI, Timer init" & @CRLF)
                            $timer = TimerInit()
                            $isOverParentItem = 0
                            Return $Gui_RUNDEFMSG
                        Case $hMenuGUI
                            $hGUIHover = $hMenuGUI
                            ConsoleWrite("MenuGUI, timer init" & @CRLF)
                            $timer = TimerInit()
                        Case $hSubMenuGUI
                            $hGUIHover = $hSubMenuGUI
                            ConsoleWrite("SubMenuGUI" & @CRLF)
                    EndSwitch
            EndSwitch

        Case $WM_NOTIFY
            Local $stNMHDR = DllStructCreate("hwnd;uint;int", $lParam)
            Local $hWndFrom = DllStructGetData($stNMHDR, 1)
            Local $nIdFrom = DllStructGetData($stNMHDR, 2)
            Local $nCode = DllStructGetData($stNMHDR, 3)
            If $hGUIHover = $hMenuGUI And $nIdFrom <> $nMenuTV Then Return $Gui_RUNDEFMSG
            If $hGUIHover = $hSubMenuGUI And $nIdFrom <> $nSubMenuTV Then Return $Gui_RUNDEFMSG
            Switch $nIdFrom
                Case $nMenuTV,$nSubMenuTV

                    Local $stPT = DllStructCreate("int;int")
                    GetCursorPos(DllStructGetPtr($stPT))
                    ScreenToClient($hWnd, DllStructGetPtr($stPT))
                    
                    Local $stTVHI = DllStructCreate("int[2];uint;hwnd")
                    DllStructSetData($stTVHI, 1, DllStructGetData($stPT, 1), 1)
                    DllStructSetData($stTVHI, 1, DllStructGetData($stPT, 2), 2)
                        
                    GUICtrlSendMsg($nIdFrom, $TVM_HITTEST, 0, DllStructGetPtr($stTVHI))
                    Local $hItem = DllStructGetData($stTVHI, 3)
            EndSwitch
            
            Switch $nCode
                Case $NM_SETCURSOR
;~                  ConsoleWrite(_WhichGUI($hWnd)&" <> "&_WhichGUI($hGUIHover) & @CRLF)
                    If $nIdFrom = $nMenuTV Then
                        If $hItem <> 0 Then
                            If $hcurrItem = $hItem Then Return $Gui_RUNDEFMSG
                            $hcurrItem = $hItem
                            $_idx = _GUICtrlTreeView_Index($nMenuTV, $hcurrItem)
                            $isOverParentItem = 0
                            If $_idx >= 0 And $isParentItem[$_idx] Then
                                $isOverParentItem = 1
                                If $timer = "" Then
                                    ConsoleWrite("timer start" & @CRLF)
                                    _GUICtrlTreeView_EndUpdate($nMenuTV)
                                    GUICtrlSetState($nMenuTV,$GUI_FOCUS)
                                    $timer = TimerInit()
                                EndIf
                            EndIf
                            $timer = TimerInit()
                            _GUICtrlTreeView_EndUpdate($nMenuTV)
                            GUICtrlSetState($nMenuTV,$GUI_FOCUS)
    ;~                      DllCall("user32.dll", "int", "SendMessage", "hwnd", $hMenuGUI, "int", $WM_NCACTIVATE, "int", 1, "int", 0)
                            GUICtrlSendMsg($nIdFrom, $TVM_SELECTITEM, $TVGN_CARET, $hItem)
    ;~                      ConsoleWrite("selecting item: "&$_idx & @CRLF)
                        Else
    ;~                      ConsoleWrite("selecting item 0"& @CRLF)
    ;~                      DllCall("user32.dll", "int", "SendMessage", "hwnd", $hMenuGUI, "int", $WM_NCACTIVATE, "int", 1, "int", 0)
                            GUICtrlSendMsg($nIdFrom, $TVM_SELECTITEM, $TVGN_CARET, 0)
                        EndIf
                    ElseIf $nIdFrom = $nSubMenuTV Then
                        If $hItem <> 0 Then
                            $hcurrItem = $hItem
                            If $timer = "" Then
                                ConsoleWrite("new:"&$hcurrItem & @CRLF)
                                $timer = TimerInit()
                            EndIf
                            GUICtrlSendMsg($nIdFrom, $TVM_SELECTITEM, $TVGN_CARET, $hItem)
                        Else
                            GUICtrlSendMsg($nIdFrom, $TVM_SELECTITEM, $TVGN_CARET, 0)
                        EndIf

                    EndIf
                Case $NM_CLICK
                    If $hItem <> 0 Then
                        GUICtrlSendMsg($nIdFrom, $TVM_EXPAND, $TVE_TOGGLE, $hItem)
                        
                        ;*** Now our treeview menu items ***
                        Switch $hItem
                            Case GUICtrlGetHandle($nItemCalc)
                                Run("calc.exe")
                                
                            Case GUICtrlGetHandle($nItemPaint)
                                Run("mspaint.exe")
                                
                            Case GUICtrlGetHandle($nItemNote)
                                Run("notepad.exe")
                                
                            Case GUICtrlGetHandle($nItemWord)
                                Run("write.exe")
                                
                            Case GUICtrlGetHandle($nItemAbout)
                                MsgBox(64, "About", "TreeView-Menu Demo by Holger Kotsch")
                                
                            Case GUICtrlGetHandle($nItemExit)
                                Exit
                        EndSwitch
                        
                        Return 1
                    EndIf
            EndSwitch
            
    EndSwitch
    Return $Gui_RUNDEFMSG
EndFunc


Func GetCursorPos($pPOINT)
    Local $nResult = DllCall("user32.dll", "int", "GetCursorPos", _
                                                    "ptr", $pPOINT)
    Return $nResult[0]
EndFunc


Func ScreenToClient($hWnd, $pPOINT)
    Local $nResult = DllCall("user32.dll", "int", "ScreenToClient", _
                                                    "hwnd", $hWnd, _
                                                    "ptr", $pPOINT)
    Return $nResult[0]
EndFunc


Func ClientToScreen($hWnd, $pPOINT)
    Local $nResult = DllCall("user32.dll", "int", "ClientToScreen", _
                                                    "hwnd", $hWnd, _
                                                    "ptr", $pPOINT)
    Return $nResult[0]
EndFunc

Func _WhichGUI($hWnd)
    Switch $hWnd
        Case $hMainGUI
            Return "MainGUI"
        Case $hMenuGUI
            Return "MenuGUI"
        Case $hSubMenuGUI
            Return "SubMenuGUI"
    EndSwitch
EndFunc
