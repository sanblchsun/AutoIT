#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <EditConstants.au3>
#include <ButtonConstants.au3>

Global $iLimit_Box = 5000
Global $ahBox_GUI[1][1]

Global $sBoxTitle = "Box Number: %i"
Global $iFocusBox = False

Global $iLeft_Counter = 0
Global $iTopPlus = 20

$hHost_GUI = GUICreate("Thinking box", -1, -1, -1, -1, BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS))

GUIRegisterMsg($WM_SIZING, "WM_SIZING")
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")

$NewBox_Button = GUICtrlCreateButton("New Box", 5, 5, 70, 20, BitOr($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON))
GUICtrlSetResizing(-1, $GUI_DOCKALL)

$DeleteBox_Button = GUICtrlCreateButton("Delete Box", 5, 40, 70, 20)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

$DeleteBox_Input = GUICtrlCreateInput(-1, 5, 65, 70, 20)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

$GoToBox_Button = GUICtrlCreateButton("Go To Box", 5, 100, 70, 20)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

$GoToBox_Input = GUICtrlCreateInput(-1, 5, 125, 70, 20)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

GUISetState(@SW_SHOW, $hHost_GUI)

$hMain_GUI = GUICreate("", 220, 300, 80, 5, $WS_POPUPWINDOW)
GUISetBkColor(0xCCCCCC)

DllCall("user32.dll", "int", "SetParent", "hwnd", WinGetHandle($hMain_GUI), "hwnd", WinGetHandle($hHost_GUI))

MakeBox_Proc()
WM_SIZING($hHost_GUI, 0, 0, 0)

GUISetState(@SW_SHOW, $hMain_GUI)

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $GUI_EVENT_MAXIMIZE, $GUI_EVENT_RESTORE
            WM_SIZING($hHost_GUI, 0, 0, 0)
        Case $NewBox_Button
            MakeBox_Proc()
        Case $DeleteBox_Button
            DeleteBox_Proc()
        Case $GoToBox_Button
            GoToBox_Proc()
    EndSwitch
WEnd

Func MakeBox_Proc()
    If $ahBox_GUI[0][0] >= $iLimit_Box Then
        MsgBox(48, "Error", StringFormat("Number of allowed Boxes is limited to [%i]", $iLimit_Box))
        Return
    EndIf
    
    Local $aHostGUI_Pos = WinGetPos($hHost_GUI)
    
    $iLeft_Counter += 1
    
    If 250 + $iLeft_Counter * 6 > $aHostGUI_Pos[2] Then
        $iLeft_Counter = 1
        $iTopPlus -= 20
        If $iTopPlus < 0 Then $iTopPlus = 60
    EndIf
    
    Local $iLeft = 40 + $iLeft_Counter * 6
    Local $iTop = $iTopPlus + $iLeft_Counter * 6
    
    $ahBox_GUI[0][0] += 1
    ReDim $ahBox_GUI[$ahBox_GUI[0][0]+1][2]
    
    $ahBox_GUI[$ahBox_GUI[0][0]][0] = GUICreate("", 200, 90, $iLeft, $iTop, BitOR($WS_POPUPWINDOW, $WS_SIZEBOX), $WS_EX_TOOLWINDOW)
    $ahBox_GUI[$ahBox_GUI[0][0]][1] = StringFormat($sBoxTitle, $ahBox_GUI[0][0])
    
    GUICtrlCreateLabel($ahBox_GUI[$ahBox_GUI[0][0]][1], 0, 0, 200, 20, $SS_CENTER, $GUI_WS_EX_PARENTDRAG)
    GUICtrlSetFont(-1, 12, 14, 0, "Comic Sans MS")
    GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKSIZE)
    
    Local $aColors[6] = [0x0000FF, 0x00FF00, 0xFF0000, 0x00FFFF, 0xFF00FF, 0xFFFF00]
    GUICtrlSetBkColor(-1, $aColors[Random(0, 5, 1)])
    
    GUICtrlCreateEdit("", 0, 20, 200, 70, BitOr($GUI_SS_DEFAULT_EDIT, $WS_VSCROLL))
    GUICtrlSetResizing(-1, $GUI_DOCKBORDERS)
    
    DllCall("user32.dll", "int", "SetParent", "hwnd", _
        WinGetHandle($ahBox_GUI[$ahBox_GUI[0][0]][0]), "hwnd", WinGetHandle($hMain_GUI))
    
    GUISetState(@SW_SHOW, $ahBox_GUI[$ahBox_GUI[0][0]][0])
    
    GUICtrlSetData($DeleteBox_Input, $ahBox_GUI[0][0])
    If Not $iFocusBox Then ControlFocus($hHost_GUI, "", $NewBox_Button)
EndFunc

Func DeleteBox_Proc()
    Local $iDelete_Box_Num = Number(GUICtrlRead($DeleteBox_Input))
    
    If $ahBox_GUI[0][0] = 0 Or $iDelete_Box_Num = 0 Then Return SetError(1, 0, 0)
    
    $iLeft_Counter -= 1
    
    Switch $iDelete_Box_Num
        Case -1
            $ahBox_GUI[0][0] -= 1
            ReDim $ahBox_GUI[$ahBox_GUI[0][0]+2][2]
            GUIDelete($ahBox_GUI[$ahBox_GUI[0][0]+1][0])
        Case Else
            Local $aTmpArr[1][1]
            Local $sBoxTitleFormat = StringFormat($sBoxTitle, $iDelete_Box_Num)
            
            For $i = 1 To $ahBox_GUI[0][0]
                If $ahBox_GUI[$i][1] = $sBoxTitleFormat Then
                    GUIDelete($ahBox_GUI[$i][0])
                Else
                    $aTmpArr[0][0] += 1
                    ReDim $aTmpArr[$aTmpArr[0][0]+1][2]
                    $aTmpArr[$aTmpArr[0][0]][0] = $ahBox_GUI[$i][0]
                    $aTmpArr[$aTmpArr[0][0]][1] = $ahBox_GUI[$i][1]
                EndIf
            Next
            
            $ahBox_GUI = $aTmpArr
    EndSwitch
    
    GUICtrlSetData($DeleteBox_Input, -1)
EndFunc

Func GoToBox_Proc()
    Local $iGoTo_Box_Num = Number(GUICtrlRead($GoToBox_Input))
    
    If $ahBox_GUI[0][0] = 0 Or $iGoTo_Box_Num = 0 Then Return SetError(1, 0, 0)
    
    Switch $iGoTo_Box_Num
        Case -1
            ControlFocus($ahBox_GUI[$ahBox_GUI[0][0]][0], "", "")
        Case Else
            Local $sBoxTitleFormat = StringFormat($sBoxTitle, $iGoTo_Box_Num)
            Local $iGoToFound = 0
            
            For $i = 1 To $ahBox_GUI[0][0]
                If $ahBox_GUI[$i][1] = $sBoxTitleFormat Then
                    $iGoToFound = 1
                    ControlFocus($ahBox_GUI[$i][0], "", "")
                    ExitLoop
                EndIf
            Next
            
            If Not $iGoToFound Then
                ControlFocus($ahBox_GUI[$ahBox_GUI[0][0]][0], "", "")
                $iGoTo_Box_Num = -1
            EndIf
            
            GUICtrlSetData($GoToBox_Input, $iGoTo_Box_Num)
    EndSwitch
    
    GUICtrlSetData($DeleteBox_Input, $iGoTo_Box_Num)
EndFunc

Func WM_SIZING($hWndGUI, $MsgID, $WParam, $LParam)
    If $hWndGUI <> $hHost_GUI Then Return
    
    Local $aHostGUI_Pos = WinGetPos($hHost_GUI)
    If @error Then Return
    
    Local $aMainGUI_Pos = WinGetPos($hMain_GUI)
    If @error Then Return
    
    If $aMainGUI_Pos[2] <> $aHostGUI_Pos[2] - 98 Or $aMainGUI_Pos[3] <> $aMainGUI_Pos[3] - 40 Then _
        WinMove($hMain_GUI, "", 85, 5, $aHostGUI_Pos[2] - 98, $aHostGUI_Pos[3] - 45)
EndFunc

Func WM_GETMINMAXINFO($hWnd, $Msg, $wParam, $lParam)
    Local $MINGuiX = 100
    Local $MINGuiY = 80
    ;Local $MAXGuiX = 600
    ;Local $MAXGuiY = 600
    
    Local $MinMaxInfo = DllStructCreate("int;int;int;int;int;int;int;int;int;int", $lParam)
    
    DllStructSetData($MinMaxInfo, 7, $MINGuiX) ; min X
    DllStructSetData($MinMaxInfo, 8, $MINGuiY) ; min Y
    ;DllStructSetData($MinMaxInfo, 9, $MAXGuiX) ; max X
    ;DllStructSetData($MinMaxInfo, 10, $MAXGuiY) ; max Y
    
    Return $GUI_RUNDEFMSG
EndFunc