; http://www.autoitscript.com/forum/index.php?showtopic=47023&view=findpost&p=352055
#include <GuiConstants.au3>
#include <WindowsConstants.au3>

Global $gui[100000]
$x = 1

$Mother_GUI = GUICreate("Thinking box",-1,-1,-1,-1,BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS))
$Button_1 = GUICtrlCreateButton("New Box", 5, 5, 70, 20)
GUICtrlSetResizing(-1,$GUI_DOCKALL)
$Button_2 = GUICtrlCreateButton("Delete Box",5,30,70,20)
GUICtrlSetResizing(-1,$GUI_DOCKALL)
$Input_1 = GUICtrlCreateInput("1",5,60,70,20)
GUICtrlSetResizing(-1,$GUI_DOCKALL)
GUISetState(@SW_SHOW, $Mother_GUI)

$Main_GUI = GUICreate("",220,300,80,5,$WS_POPUPWINDOW)
GUISetBkColor(0xCCCCCC)
GUISetState(@SW_SHOW,$Main_GUI)
DllCall("user32.dll", "int", "SetParent", "hwnd", WinGetHandle($Main_GUI), "hwnd", WinGetHandle($Mother_GUI))
Makebox()
While 1
    setsize()
    $msg = GUIGetMsg()
    if $msg = $GUI_EVENT_CLOSE then Exit
    if $msg = $Button_1 then Makebox()
    if $msg = $Button_2 then GUIDelete($Gui[GUICtrlRead($Input_1)])
    sleep(10)
WEnd

Func Makebox()
    if $x < 100000 then
        $gui[$x] = GUICreate("",200,90,100+$x*5,100+$x*5, $WS_POPUPWINDOW,$WS_EX_TOOLWINDOW)
        $label = GUICtrlCreateLabel("  Box number: " & $x,0,0,200,20,-1,$GUI_WS_EX_PARENTDRAG)
        GUICtrlSetFont(-1,12,14,0,"Comic Sans MS")
        settopbarcolor()
        GUICtrlCreateEdit("",0,20,200,70,$WS_VSCROLL)
        GUISetState(@SW_SHOW,$gui[$x])
        DllCall("user32.dll", "int", "SetParent", "hwnd", WinGetHandle($Gui[$x]), "hwnd", WinGetHandle($Main_GUI))
        $x = $x +1
    EndIf
EndFunc

Func settopbarcolor($s_control=-1)
    $Random = Random(1,6,1)
    if $Random = 1 Then
        GUICtrlSetBkColor($s_control,0x0000FF)
    elseif $Random = 2 Then
        GUICtrlSetBkColor($s_control,0x00FF00)
    elseif $Random = 3 then
        GUICtrlSetBkColor($s_control,0xFF0000)
    elseif $Random = 4 then
        GUICtrlSetBkColor($s_control,0x00FFFF)
    elseif $Random = 5 then
        GUICtrlSetBkColor($s_control,0xFF00FF)
    elseif $Random = 6 Then
        GUICtrlSetBkColor($s_control,0xFFFF00)
    EndIf
EndFunc

Func setsize()
    $Motherpos = WinGetPos($Mother_GUI)
    $Mainpos = WinGetPos($Main_GUI)
    if $Mainpos[2] <> $Motherpos[2]-98 or $Mainpos[3] <> $Motherpos[3]-40 then WinMove($Main_GUI,"",85,5,$Motherpos[2]-98,$Motherpos[3]-45)
EndFunc

Func SpecialEvents()
    Select
        Case @GUI_CTRLID = $GUI_EVENT_CLOSE
            Exit
    EndSelect
EndFunc