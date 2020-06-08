#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_outfile=LweMon.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <EditConstants.au3>
#Include <Misc.au3>
#Include <File.au3>
#NoTrayIcon 

Opt ("SendKeyDownDelay", 110)
Opt ("SendKeyDelay", 60)

Global $radio_hotkeys = true
Global $setup = false
Global $PAUSE_KEY = "14" ;Caps Lock Key
Global $progname = "Gamer's Hotkeys"
Global $input_back, $input_forward
Global $send_back = "{CTRL}"
Global $send_forward = "<SWITCH>"

$dll2 = DllOpen("user32.dll")
$dll3 = DllOpen(".\hook.dll")

$tray_size = WinGetPos("[CLASS:Shell_TrayWnd]")
$form1 = GUICreate($progname, 300, 50, @DesktopWidth-300, @DesktopHeight-50-$tray_size[3], $WS_POPUP, $WS_EX_TOPMOST)
GUISetIcon("shell32.dll", -121)
GUISetBkColor("0x99ccff")
GUICtrlCreateGraphic(0, 0, 300, 50, $SS_BLACKFRAME)
GUICtrlCreateGraphic(150, 2, 148, 46, $SS_BLACKFRAME)
GUICtrlCreateGraphic(2, 2, 146, 46, $SS_BLACKFRAME)
$setup_button = GUICtrlCreateButton("Setup", 152, 27, 100, 20)
$exit_button = GUICtrlCreateButton("Exit", 252, 27, 44, 20)
$skill_radio = GUICtrlCreateRadio("Skills", 165, 6, 40, 17)
$skill_text = ""

for $i = 0 to 9
    $skill_text &= $i & @CRLF
Next

$hotkey_radio = GUICtrlCreateRadio("Hotkeys", 230, 6, 55, 17)
if NOT FileExists(".\hotkeys.dat") then
    FileWrite(".\hotkeys.dat", "SPACE" & @CRLF & "CTRL" & @CRLF & "ALT" & @CRLF & "ENTER" & @CRLF & _
    "Q" & @CRLF & "W" & @CRLF & "E" & @CRLF & "I" & @CRLF & "S" & @CRLF & "C" & @CRLF & "M" & @CRLF & _
    "P" & @CRLF & "F2" & @CRLF & "F3" & @CRLF & "F4" & @CRLF & "F5" & @CRLF & "F6" & @CRLF & "PRINTSCREEN")
EndIf
$hotkey_text = FileRead(".\Hotkeys.dat")
GUICtrlSetState(-1, $GUI_CHECKED)

    $form45 = GUICreate("",144, 44, 0, -26,BitOR($WS_POPUP,$WS_CHILD),$WS_EX_MDICHILD,$form1)
    GUISetBkColor(0xDFF3FE, $form45)
    $credits_label_hotkey = GUICtrlCreateLabel($hotkey_text, 0, -11, 144, Number(_FileCountLines(".\Hotkeys.dat"))*30, $ES_CENTER)
    GUICtrlSetColor(-1, "0x003366")
    GUICtrlSetFont(-1, 14, 400, 0, "Tahoma")
    $credits_label_skill = GUICtrlCreateLabel($skill_text, 0, -11, 144, 500, $ES_CENTER)
    GUICtrlSetColor(-1, "0x003366")
    GUICtrlSetFont(-1, 14, 400, 0, "Tahoma")
    if GUICtrlRead($hotkey_radio) = $GUI_CHECKED Then
        GUICtrlSetState($credits_label_skill, $GUI_HIDE)
    Else
        GUICtrlSetState($credits_label_hotkey, $GUI_HIDE)
    EndIf
    GUISetState()
   
    $sTransHeight = 1
    For $x = 0 to 15
        Local $stemp1 = GUICreate("",144, $sTransHeight, 0, ($sTransHeight * $x)-26 ,BitOR($WS_POPUP,$WS_CHILD),$WS_EX_MDICHILD,$form1)
        GUISetBkColor(0xDFF3FE, $stemp1)
        GUISetState()
        WinSetTrans($stemp1,"",(255/15)*(-1*($x-15)))
    Next

    For $x = 0 to 15
        Local $stemp2 = GUICreate("",144, $sTransHeight, 0, 17-($sTransHeight * $x) ,BitOR($WS_POPUP,$WS_CHILD),$WS_EX_MDICHILD,$form1)
        GUISetBkColor(0xDFF3FE, $stemp2)
        GUISetState()
        WinSetTrans($stemp2,"",(255/15)*(-1*($x-15)))
    Next
   
Const $WH_MOUSE = 7
Global $DLLinst = DLLCall("kernel32.dll","hwnd","LoadLibrary","str",".\hook.dll")
Global $mouseHOOKproc = DLLCall("kernel32.dll","hwnd","GetProcAddress","hwnd",$DLLInst[0],"str","MouseProc")

Global $hhMouse = DLLCall("user32.dll","hwnd","SetWindowsHookEx","int",$WH_MOUSE, _
        "hwnd",$mouseHOOKproc[0],"hwnd",$DLLinst[0],"int",0)
       
DLLCall($dll3,"int","SetValuesMouse","hwnd",$form1,"hwnd",$hhMouse[0])

GUIRegisterMsg(0x1400 + 0x0D30,"FuncScrollUp") ;mouse wheel up
GUIRegisterMsg(0x1400 + 0x0D31,"FuncScrollDown") ;mouse wheel down
GUIRegisterMsg(0x1400 + 0x0A32,"FuncScrollPressDown") ;mouse PRESS middle down
GUIRegisterMsg(0x1400 + 0x0B32,"FuncScrollPressUp") ;mouse PRESS middle Up
GUIRegisterMsg(0x1400 + 0x0A33,"FuncHotLeftDown") ;mouse PRESS down back
GUIRegisterMsg(0x1400 + 0x0B33,"FuncHotLeftUp") ;mouse PRESS up back
GUIRegisterMsg(0x1400 + 0x0A34,"FuncHotRightDown") ;mouse PRESS down forward
GUIRegisterMsg(0x1400 + 0x0B34,"FuncHotRightUp") ;mouse PRESS up forward

GUISetState(@SW_SHOW, $form1)

func _get_current()
    Local $current_label
    if GUICtrlRead($hotkey_radio) = $GUI_CHECKED Then
        $current_label = $hotkey_text
    Else
        $current_label = $skill_text
    EndIf
    Local $array = StringSplit($current_label, @CRLF, 1)
    Local $credits_location
        Local $credits_hwdn
        if GUICtrlGetState($credits_label_hotkey) = 96 Then
            $credits_hwdn = GUICtrlGetHandle($credits_label_skill)
        Else
            $credits_hwdn = GUICtrlGetHandle($credits_label_hotkey)
        EndIf
    $credits_location = ControlGetPos($form45, "", $credits_hwdn)
    if $credits_location[1] = 11 Then
        Return $array[1]
    Else
        Local $number = (((($credits_location[1]*(-1))/11)+1)/2)+1
        Return $array[$number]
    EndIf
EndFunc

func _setup_window($name)
    Local $Form2 = GUICreate("Setup", 250, 130, -1, -1, $WS_POPUP)
    GUISetBkColor("0x99ccff")
    GUICtrlCreateGraphic(0, 0, 250, 130, 0x07)
    GUICtrlCreateGraphic(3, 3, 250-6, 130-6, 0x07)
    GUICtrlCreateLabel($name, 10, 5, 230, -1, $ES_CENTER)
    GUICtrlSetFont(-1, 12, 800)
    GUICtrlCreateLabel("Press back or forward on your mouse to test", 10, 35, 230, 17, $ES_CENTER)
    GUICtrlCreateLabel("Back key sends:                   Left key sends:", 10, 55, 230, 17, $ES_CENTER)
    $input_back = GUICtrlCreateInput($send_back, 20, 72, 80, 20, $ES_CENTER+$ES_AUTOHSCROLL)
    GUICtrlSetFont(-1, 10, 800)
    $input_forward = GUICtrlCreateInput($send_forward, 150, 72, 80, 20, $ES_CENTER+$ES_AUTOHSCROLL)
    GUICtrlSetFont(-1, 10, 800)
    Local $close_button = GUICtrlCreateButton("Cancel", 180, 100, 60, 20)
    Local $accept_button = GUICtrlCreateButton("Accept", 115, 100, 60, 20)
    GUISetState(@SW_SHOW)
    $setup = true

    While 1
        Local $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $close_button
                GUIDelete($Form2)
                $setup = False
                ExitLoop
            case $accept_button
                $send_back = GUICtrlRead($input_back)
                $send_forward = GUICtrlRead($input_forward)
                GUIDelete($Form2)
                $setup = False
                ExitLoop
            case $GUI_EVENT_PRIMARYDOWN
                dllcall($dll2,"int","SendMessage","hWnd", $Form2,"int",0xA1,"int", 2,"int", 0)
        EndSwitch
    WEnd
EndFunc

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        case $exit_button
            Exit
        case $setup_button
            _setup_window($progname & " Setup")
        case $skill_radio
            GUICtrlSetState($credits_label_skill, $GUI_SHOW)
            GUICtrlSetState($credits_label_hotkey, $GUI_HIDE)
        case $hotkey_radio
            GUICtrlSetState($credits_label_skill, $GUI_HIDE)
            GUICtrlSetState($credits_label_hotkey, $GUI_SHOW)
        case $GUI_EVENT_PRIMARYDOWN
            WinSetTrans($form45,"",254)
            do
                dllcall("user32.dll","int","SendMessage","hWnd", $form1,"int",0xA1,"int", 2,"int", 0)
                Local $msgg2 = GUIGetMsg()
            Until $msgg2 <> -7
            WinSetTrans($form45,"",255)
    EndSwitch
WEnd

Func FuncScrollUp()
    if NOT _IsPressed($PAUSE_KEY, $dll2) Then
        Local $credits_location
        Local $credits_hwdn
        Local $max_size
        if GUICtrlGetState($credits_label_hotkey) = 96 Then
            $credits_hwdn = GUICtrlGetHandle($credits_label_skill)
            $max_size = -16*11
        Else
            $credits_hwdn = GUICtrlGetHandle($credits_label_hotkey)
            $max_size = -((_FileCountLines(".\hotkeys.dat")*2)-5)*11
        EndIf
        $credits_location = ControlGetPos($form45, "", $credits_hwdn)
        if $credits_location[1] >= $max_size then
            for $i = 1 to 3
                $credits_location = ControlGetPos($form45, "", $credits_hwdn)
                ControlMove($form45,"",$credits_hwdn,0,$credits_location[1]-4)
                Sleep(1)
            Next
            for $i = 1 to 2
                $credits_location = ControlGetPos($form45, "", $credits_hwdn)
                ControlMove($form45,"",$credits_hwdn,0,$credits_location[1]-3)
                Sleep(1)
            Next
            $credits_location = ControlGetPos($form45, "", $credits_hwdn)
            ControlMove($form45,"",$credits_hwdn,0,$credits_location[1]-2)
            for $i = 1 to 2
                $credits_location = ControlGetPos($form45, "", $credits_hwdn)
                ControlMove($form45,"",$credits_hwdn,0,$credits_location[1]-1)
                Sleep(1)
            Next
            if GUICtrlRead($skill_radio) = $GUI_CHECKED Then
                Local $new_skill = _get_current()
                Send("{" & $new_skill & "}")
            EndIf
        EndIf
    EndIf
EndFunc

Func FuncScrollDown()
    if NOT _IsPressed($PAUSE_KEY, $dll2) Then
        Local $credits_location
        Local $credits_hwdn
        Local $max_size
        if GUICtrlGetState($credits_label_hotkey) = 96 Then
            $credits_hwdn = GUICtrlGetHandle($credits_label_skill)
            $max_size = 10
        Else
            $credits_hwdn = GUICtrlGetHandle($credits_label_hotkey)
            $max_size = 10
        EndIf
        $credits_location = ControlGetPos($form45, "", $credits_hwdn)
        if $credits_location[1] <= $max_size then
            for $i = 1 to 3
                $credits_location = ControlGetPos($form45, "", $credits_hwdn)
                ControlMove($form45,"",$credits_hwdn,0,$credits_location[1]+4)
                Sleep(1)
            Next
            for $i = 1 to 2
                $credits_location = ControlGetPos($form45, "", $credits_hwdn)
                ControlMove($form45,"",$credits_hwdn,0,$credits_location[1]+3)
                Sleep(1)
            Next
            $credits_location = ControlGetPos($form45, "", $credits_hwdn)
            ControlMove($form45,"",$credits_hwdn,0,$credits_location[1]+2)
            for $i = 1 to 2
                $credits_location = ControlGetPos($form45, "", $credits_hwdn)
                ControlMove($form45,"",$credits_hwdn,0,$credits_location[1]+1)
                Sleep(1)
            Next
            if GUICtrlRead($skill_radio) = $GUI_CHECKED Then
                Local $new_skill = _get_current()
                Send("{" & $new_skill & "}")
            EndIf
        EndIf
    EndIf
EndFunc
   
func FuncScrollPressDown()
    if NOT _IsPressed($PAUSE_KEY, $dll2) Then
        Local $get_current = _get_current()
        if $get_current = "CTRL" Then
            Send("{CTRLDOWN}")
        ElseIf $get_current = "SHIFT" Then
            Send("{SHIFTDOWN}")
        ElseIf $get_current = "ALT" Then
            Send("{ALTDOWN}")
        Else
            Send("{" & $get_current & " down}")
        EndIf
    EndIf
EndFunc

func FuncScrollPressUp()
        Local $get_current = _get_current()
        if $get_current = "CTRL" Then
            Send("{CTRLUP}")
        ElseIf $get_current = "SHIFT" Then
            Send("{SHIFTUP}")
        ElseIf $get_current = "ALT" Then
            Send("{ALTUP}")
        Else
            Send("{" & $get_current & " up}")
        EndIf
EndFunc

func FuncHotRightDown()
    if $setup = false Then
        if NOT _IsPressed($PAUSE_KEY, $dll2) Then
            Local $get_current = $send_forward
            if $get_current = "{CTRL}" Then
                Send("{CTRLDOWN}")
            ElseIf $get_current = "{SHIFT}" Then
                Send("{SHIFTDOWN}")
            ElseIf $get_current = "{ALT}" Then
                Send("{ALTDOWN}")
            ElseIf $get_current = "<SWITCH>" Then
                if GUICtrlRead($hotkey_radio) = $GUI_CHECKED Then
                    GUICtrlSetState($skill_radio, $GUI_CHECKED)
                    GUICtrlSetState($credits_label_skill, $GUI_SHOW)
                    GUICtrlSetState($credits_label_hotkey, $GUI_HIDE)
                Else
                    GUICtrlSetState($hotkey_radio, $GUI_CHECKED)
                    GUICtrlSetState($credits_label_skill, $GUI_HIDE)
                    GUICtrlSetState($credits_label_hotkey, $GUI_SHOW)
                EndIf
            Else
                Send($get_current)
            EndIf
        EndIf
    Else
        GUICtrlSetBkColor($input_forward, 0x00FF00)
    EndIf
EndFunc

func FuncHotRightUp()
    if $setup = false Then
        if NOT _IsPressed($PAUSE_KEY, $dll2) Then
            Local $get_current = $send_forward
            if $get_current = "{CTRL}" Then
                Send("{CTRLUP}")
            ElseIf $get_current = "{SHIFT}" Then
                Send("{SHIFTUP}")
            ElseIf $get_current = "{ALT}" Then
                Send("{ALTUP}")
            EndIf
        EndIf
    Else
        GUICtrlSetBkColor($input_forward, 0xFFFFFF)
    EndIf
EndFunc

func FuncHotLeftDown()
    if $setup = false Then
        if NOT _IsPressed($PAUSE_KEY, $dll2) Then
            Local $get_current = $send_back
            if $get_current = "{CTRL}" Then
                Send("{CTRLDOWN}")
            ElseIf $get_current = "{SHIFT}" Then
                Send("{SHIFTDOWN}")
            ElseIf $get_current = "{ALT}" Then
                Send("{ALTDOWN}")
            ElseIf $get_current = "<SWITCH>" Then
                if GUICtrlRead($hotkey_radio) = $GUI_CHECKED Then
                    GUICtrlSetState($skill_radio, $GUI_CHECKED)
                    GUICtrlSetState($credits_label_skill, $GUI_HIDE)
                    GUICtrlSetState($credits_label_hotkey, $GUI_SHOW)
                Else
                    GUICtrlSetState($hotkey_radio, $GUI_CHECKED)
                    GUICtrlSetState($credits_label_skill, $GUI_SHOW)
                    GUICtrlSetState($credits_label_hotkey, $GUI_HIDE)
                EndIf
            Else
                Send($get_current)
            EndIf
        EndIf
    Else
        GUICtrlSetBkColor($input_back, 0x00FF00)
    EndIf
EndFunc

func FuncHotLeftUp()
    if $setup = false Then
        if NOT _IsPressed($PAUSE_KEY, $dll2) Then
            Local $get_current = $send_back
            if $get_current = "{CTRL}" Then
                Send("{CTRLUP}")
            ElseIf $get_current = "{SHIFT}" Then
                Send("{SHIFTUP}")
            ElseIf $get_current = "{ALT}" Then
                Send("{ALTUP}")
            EndIf
        EndIf
    Else
        GUICtrlSetBkColor($input_back, 0xFFFFFF)
    EndIf
EndFunc

Func OnAutoItExit()
    DLLCall("user32.dll","int","UnhookWindowsHookEx","hwnd",$hhMouse[0])
    DLLCall("kernel32.dll","int","FreeLibrary","hwnd",$DLLinst[0])
    DllClose($dll2)
    DllClose($dll3)
EndFunc