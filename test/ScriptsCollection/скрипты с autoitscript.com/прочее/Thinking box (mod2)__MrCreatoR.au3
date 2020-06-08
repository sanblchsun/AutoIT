#include <GuiConstants.au3>
#include <WindowsConstants.au3>
#include <GUIEdit.au3>

Global Const $SS_CENTER = 0x01

Global $iLimit_Box = 5000
Global $ahBox_GUI[$iLimit_Box]

Global $iBox_Counter = 1
Global $iLeft_Counter = 0
Global $iTopPlus = 20

$hHost_GUI = GUICreate("Thinking box", -1, -1, -1, -1, BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS))

GUIRegisterMsg($WM_SIZING, "WM_SIZING")

$Button_1 = GUICtrlCreateButton("New Box", 5, 5, 70, 20)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

$Button_2 = GUICtrlCreateButton("Delete Box", 5, 30, 70, 20)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

$Input_1 = GUICtrlCreateInput(-1, 5, 60, 70, 20);, BitOR($ES_LEFT, $ES_AUTOHSCROLL, $ES_NUMBER))
GUICtrlSetResizing(-1, $GUI_DOCKALL)

GUISetState(@SW_SHOW, $hHost_GUI)

$hMain_GUI = GUICreate("", 220, 300, 80, 5, $WS_POPUPWINDOW)
GUISetBkColor(0xCCCCCC)

DllCall("user32.dll", "int", "SetParent", "hwnd", WinGetHandle($hMain_GUI), "hwnd", WinGetHandle($hHost_GUI))

MakeBox()
WM_SIZING($hHost_GUI, 0, 0, 0)

GUISetState(@SW_SHOW, $hMain_GUI)

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $GUI_EVENT_MAXIMIZE, $GUI_EVENT_RESTORE
            WM_SIZING($hHost_GUI, 0, 0, 0)
        Case $Button_1
            Makebox()
        Case $Button_2
            $iDelete_Box_Num = Number(GUICtrlRead($Input_1))
           
            If $iDelete_Box_Num = -1 And $iBox_Counter-1 > 0 Then
                GUIDelete($ahBox_GUI[$iBox_Counter-1])
                $iBox_Counter -= 1
                $iLeft_Counter -= 1
            ElseIf $iDelete_Box_Num <= $iBox_Counter And $iDelete_Box_Num > 0 Then
                GUIDelete($ahBox_GUI[$iDelete_Box_Num])
            EndIf
    EndSwitch
WEnd

Func MakeBox()
    If $iBox_Counter >= $iLimit_Box Then
        MsgBox(48, "Error", StringFormat("Number of allowed Boxes is limited to [%i]", $iLimit_Box))
        Return
    EndIf
   
    $aHostGUI_Pos = WinGetPos($hHost_GUI)
    $iLeft_Counter += 1
   
    If 250 + $iLeft_Counter * 6 > $aHostGUI_Pos[2] Then
        $iLeft_Counter = 1
        $iTopPlus -= 20
        If $iTopPlus < 0 Then $iTopPlus = 60
    EndIf
   
    Local $iLeft = 40 + $iLeft_Counter * 6
    Local $iTop = $iTopPlus + $iLeft_Counter * 6
   
    $ahBox_GUI[$iBox_Counter] = GUICreate("", 200, 90, $iLeft, $iTop, BitOR($WS_POPUPWINDOW, $WS_SIZEBOX), $WS_EX_TOOLWINDOW)
   
    GUICtrlCreateLabel("Box Number: " & $iBox_Counter, 0, 0, 200, 20, $SS_CENTER, $GUI_WS_EX_PARENTDRAG)
    GUICtrlSetFont(-1, 12, 14, 0, "Comic Sans MS")
    GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKSIZE)
   
    Local $aColors[6] = [0x0000FF, 0x00FF00, 0xFF0000, 0x00FFFF, 0xFF00FF, 0xFFFF00]
    GUICtrlSetBkColor(-1, $aColors[Random(0, 5, 1)])
   
    GUICtrlCreateEdit("", 0, 20, 200, 70, BitOr($GUI_SS_DEFAULT_EDIT, $WS_VSCROLL))
    GUICtrlSetResizing(-1, $GUI_DOCKBORDERS)
   
    DllCall("user32.dll", "int", "SetParent", "hwnd", _
        WinGetHandle($ahBox_GUI[$iBox_Counter]), "hwnd", WinGetHandle($hMain_GUI))
   
    GUISetState(@SW_SHOW, $ahBox_GUI[$iBox_Counter])
   
    $iBox_Counter += 1
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