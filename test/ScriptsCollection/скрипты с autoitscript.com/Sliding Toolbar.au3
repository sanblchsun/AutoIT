; http://www.autoitscript.com/forum/topic/25790-sliding-toolbar/
#cs
 Sliding Toolbar
 
 Original idea: Simucal
 Adds from Valuater, FireFox and many others
 
 Adapted Dec 2008 - A GreenCan
        03 Jan 2009 : Button now allows url shortcut
 
 
 #ce

#include <GUIConstants.au3>
#include <GUIConstants.au3>
#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include "Misc.au3"
#include <Constants.au3>
;#include <Array.au3>

Opt("TrayIconHide", 1)  
TraySetState (2)

;HotKeySet("^s", "Settings")
;HotKeySet("^q", "Set_Exit")

TraySetToolTip ("Sliding Toolbar")

; prevent 2nd launch
if  _Singleton(@ScriptName,1) =  0 Then
    Opt("TrayIconHide", 1)
    Msgbox(0,"Warning",@ScriptName & " is already running",3)
    Exit
EndIf

#Region ini
; startup with a new toolbarAG.ini with some stuff in it
If Not FileExists(@ScriptDir & "\toolbarAG.ini") Then Create_ini()
    
$Label_name = IniReadSection(@ScriptDir & "\toolbarAG.ini", "Label")
$Launch_name = IniReadSection(@ScriptDir & "\toolbarAG.ini", "Launch")
$Transparency = IniRead(@ScriptDir & "\toolbarAG.ini", "Global","Transparency",250)
$Auto_appear = IniRead(@ScriptDir & "\toolbarAG.ini", "Global","Auto_appear",0)
#EndRegion ini

#Region Global
Global Const $SM_VIRTUALWIDTH = 78
$VirtualDesktopWidth = DLLCall("user32.dll", "int", "GetSystemMetrics", "int", $SM_VIRTUALWIDTH)
$VirtualDesktopWidth = $VirtualDesktopWidth[0]

Global $hide_state = 0, $btn_state = 0, $pass = 0, $active_window, $side = "left"
Global $Button_[15], $Label_[15], $config_[12]
Global $Row1 = 7
Global $Row2 = 7
Global $Button_height = 77
If $Auto_appear = 1 Then; auto_appear is True
    ; hide the window almost completely as the mouse over will slidein the window, no button needs to be shown
    Global $left_hwnd = -605
    Global $right_hwnd = ($VirtualDesktopWidth -6)
    Global $Auto_app ="On"
Else
    ; leave just the slide in buttons visual
    Global $left_hwnd = -588
    Global $right_hwnd = ($VirtualDesktopWidth -20) 
    Global $Auto_app ="Off"
EndIf
#EndRegion Global


#Region config window $hwnd2
$hwnd = GUICreate("     Sliding Toolbar", 603, 170, $left_hwnd, -1, -1,  BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW, $WS_EX_ACCEPTFILES))

#Region Perforated Image
; Perforated Image
# ==> Start
Local $_Left_pos, $_Top_pos, $_GUI_NAME
$_Left_pos = 442 ; Replace with correct position
$_Top_pos = 139 ; Replace with correct position
_GuiImageHole($hwnd, $_Left_pos, $_Top_pos, 136, 41)
# <== End
#EndRegion Perforated Image

; create the labels, inputs and buttons for config window
$config_[1] = GUICtrlCreateLabel("Label Name", 15, 32, 60, 20)
$config_[2] = GUICtrlCreateInput("", 75, 30, 80, 20)
$config_[3] = GUICtrlCreateLabel("Program to Launch", 175, 32, 100, 20)
$config_[4] = GUICtrlCreateInput("", 270, 30, 255, 20)
GUICtrlSetState( -1, $GUI_DROPACCEPTED ) ; accept drops
GUICtrlSetTip(-1, "Drag and drop your executable here" & @CR & "The path is also the path where the application will start from")
$config_[5] = GUICtrlCreateButton("Cancel", 530, 5, 50, 20)
$config_[6] = GUICtrlCreateButton("Browse", 530, 30, 50, 20)
$config_[7] = GUICtrlCreateButton("Accept", 530, 55, 50, 20)
$config_[8] = GUICtrlCreateButton("Delete", 530, 80, 50, 20)
$config_[9] = GUICtrlCreateButton("?", 500, 5, 20, 20 )
GUICtrlSetTip(-1, about())
$config_[10] = GuiCtrlCreateLabel("", $_Left_pos - 4, $_Top_pos - 30, 144, 51 , $SS_GRAYFRAME)
GUICtrlSetTip(-1, about())
$config_[11] = GUICtrlCreateButton("", 75, 60, 73, 41, $BS_ICON)
For $x = 1 To UBound($config_)-1
    GUICtrlSetState($config_[$x], $GUI_HIDE)
Next

$SHOW = GUICtrlCreateButton(">", 585, 8, 17, 77 + $Button_height, BitOR($BS_CENTER, $BS_FLAT))
GUICtrlSetTip(-1, "Show Toolbar")
GUISetState(@SW_HIDE, $hwnd)
#EndRegion config window $hwnd

#Region main window $hwnd2
$hwnd2 = GUICreate("     Sliding Toolbar", 603, 170, 1, -1, -1, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW ))
; set transparency
 WinSetTrans($hwnd2, "", $Transparency)

; row 1
For $Row_item = 1 to $Row1
    $Button_[$Row_item] = GUICtrlCreateButton("", ($Row_item * 81) -60, 35, 73, 41, $BS_ICON)
    GUICtrlSetTip(-1, $Label_name[$Row_item][1])
    If StringInStr($Launch_name[$Row_item][1], ".exe") > 0 Then
        GUICtrlSetImage(-1, $Launch_name[$Row_item][1],1)
    ElseIf StringInStr($Launch_name[$Row_item][1], ".url") Then 
        ; url 
        GUICtrlSetImage(-1, "url.dll", 1)         
    Else
        If StringLen($Launch_name[$Row_item][1]) = 0 Then
            GUICtrlSetImage($Button_[$Row_item], "shell32.dll", 50) 
            GUICtrlSetState ( $Button_[$Row_item], $GUI_DISABLE )
        Else
            GUICtrlSetImage(-1, "shell32.dll", 4)
        EndIf
    EndIf
    $Label_[$Row_item] = GUICtrlCreateLabel($Label_name[$Row_item][1], ($Row_item * 81) -60, 8, 73, 17, $SS_CENTER + $SS_SUNKEN)
Next
; row 2
For $Row_item = 1 to $Row2
    $Button_[$Row_item+7] = GUICtrlCreateButton("", ($Row_item * 81) -60, 120, 73, 41, $BS_ICON)
    GUICtrlSetTip(-1, $Label_name[$Row_item+7][1])
    If StringInStr($Launch_name[$Row_item+7][1], ".exe") > 0 Then
        GUICtrlSetImage(-1, $Launch_name[$Row_item+7][1],1)
    ElseIf StringInStr($Launch_name[$Row_item+7][1], ".url") Then 
        ; url 
        GUICtrlSetImage(-1, "url.dll", 1)      
    Else
        If StringLen($Launch_name[$Row_item+7][1]) = 0 Then
            GUICtrlSetImage($Button_[$Row_item+7], "shell32.dll", 50)         
            GUICtrlSetState ( $Button_[$Row_item+7], $GUI_DISABLE )
        Else
            GUICtrlSetImage(-1, "shell32.dll", 4)
        EndIf
    EndIf   
    $Label_[$Row_item+7] = GUICtrlCreateLabel($Label_name[$Row_item+7][1], ($Row_item * 81) -60, 93, 73, 17, $SS_CENTER + $SS_SUNKEN)
Next

$HIDE = GUICtrlCreateButton("<", 585, 8, 17, 77 + $Button_height, BitOR($BS_CENTER, $BS_FLAT, $BS_MULTILINE))
GUICtrlSetTip($HIDE, "Hide")
$EDIT = GUICtrlCreateButton("[]", 2, 8, 15, 77 + $Button_height, BitOR($BS_CENTER, $BS_FLAT, $BS_MULTILINE))
GUICtrlSetTip(-1, "Config Mode")
GUISetState()
#EndRegion main window $hwnd2

#Region Tray settings
Opt("TrayMenuMode", 1)
Opt("TrayOnEventMode", 1)

TraySetOnEvent($TRAY_EVENT_SECONDARYUP, "Maximize") ; secondary mouse button will maximize window
TraySetClick(2) ; Only Primary mouse button will show the tray menu.
$About_tray = TrayCreateItem("About")
TrayItemSetOnEvent(-1, "Tray_About")
TrayCreateItem("")
$Maximize_tray = TrayCreateItem("Maximize")
TrayItemSetOnEvent(-1, "Maximize")
$Mouseover_tray = TrayCreateItem("Mouseover appear " & $Auto_app)
TrayItemSetOnEvent(-1, "Mouseover")
$Transparency_tray = TrayCreateItem("Set Transparency")
TrayItemSetOnEvent(-1, "Transparency")
TrayCreateItem("")
$exit_tray = TrayCreateItem("Quit Sliding Toolbar")
TrayItemSetOnEvent(-1, "Set_Exit")
TraySetState(2)
#EndRegion Tray settings

_ReduceMemory() 

#Region While
While 1
    $msg1 = GUIGetMsg()
    Select
    Case $hide_state = 1 and $msg1 = -3 ; close window on hidden window
        ; hide it to the tray
        $active_window = $hwnd
        GUISetState(@SW_HIDE, $hwnd)
        TraySetState(1)  
        $msg1 = 0
        TrayTip("Sliding Toolbar","Click right mouse button to activate" & @CR & "Click left mouse button for more options",0,1+16)
        ; reduce the memory needed
        _ReduceMemory() 
    Case $msg1 = -3 Or $msg1 = -4  ; escape key (-3) pressed, close window (-3), Minimize (-4) 
        ; hide it to the tray
        $active_window = $hwnd2
        GUISetState(@SW_HIDE, $hwnd2)
        TraySetState(1)  
        $msg1 = 0
        TrayTip("Sliding Toolbar","Click right mouse button to activate" & @CR & "Click left mouse button for more options",0,1+16) 
        ; reduce the memory needed
        _ReduceMemory() 
    Case $msg1 = $HIDE ; "<" button clicked
        If $pass = 1 Then ; return from Edit mode to menu mode
            WinSetTitle($hwnd2, "", "     Sliding Toolbar")
            ; return to default tooltip 
            GUICtrlSetTip($HIDE, "Hide")            
            $pass = 0
            ; disable all unused buttons
            ; row 1
            For $Row_item = 1 to $Row1
                If StringLen($Launch_name[$Row_item][1]) = 0 Then
                    GUICtrlSetState ( $Button_[$Row_item], $GUI_DISABLE )
                EndIf
            Next            
            ; row 2
            For $Row_item = 1 to $Row2
                If StringLen($Launch_name[$Row_item+7][1]) = 0 Then
                    GUICtrlSetState ( $Button_[$Row_item+7], $GUI_DISABLE )
                EndIf
            Next
            GUISetState(@SW_SHOW, $hwnd2)
        Else ; hide menu
            Slide_out()
        EndIf
    Case $msg1 = $SHOW ; ">" button clicked on closed menu
         Slide_in() 
    Case $msg1 = $EDIT  ; "[]" button clicked
        If $pass = 1 Then ; return from Edit mode to menu mode
            WinSetTitle($hwnd2, "", "     Sliding Toolbar")
            ; return to default tooltip 
            GUICtrlSetTip($HIDE, "Hide")
            GUICtrlSetTip($EDIT, "Config Mode")
            $pass = 0
            ; disable all unused buttons
            ; row 1
            For $Row_item = 1 to $Row1
                If StringLen($Launch_name[$Row_item][1]) = 0 Then
                    GUICtrlSetState ( $Button_[$Row_item], $GUI_DISABLE )
                EndIf
            Next            
            ; row 2
            For $Row_item = 1 to $Row2
                If StringLen($Launch_name[$Row_item+7][1]) = 0 Then
                    GUICtrlSetState ( $Button_[$Row_item+7], $GUI_DISABLE )
                EndIf
            Next
    
            GUISetState(@SW_SHOW, $hwnd2)
        Else        
            $pass = 1         
            ; change the tooltip 
            GUICtrlSetTip($HIDE, "Exit Config Mode")
            GUICtrlSetTip($EDIT, "Exit Config Mode")
            ; enable all disabled buttons
            ; row 1
            For $Row_item = 1 to $Row1
                GUICtrlSetState ( $Button_[$Row_item], $GUI_ENABLE )
            Next        
            ; row 2
            For $Row_item = 1 to $Row2
                GUICtrlSetState ( $Button_[$Row_item+7], $GUI_ENABLE )
            Next
            GUISetState(@SW_SHOW, $hwnd2)
        EndIf

    EndSelect
    If $Auto_appear = 1 And $hide_state = 1 then ; mouse over will slide in hidden window
        If GetHoveredHwnd() = $hwnd Then Slide_in()
    EndIf

    $a_pos = WinGetPos($hwnd2)
    $a_pos2 = WinGetPos($hwnd)
    If $side = "left" Then
        If $a_pos[0] + 302 < ($VirtualDesktopWidth / 2) Then
            ; main window
            If $a_pos[0] <> 1 And $hide_state = 0 And $a_pos[0] Then
                WinMove($hwnd2, "", 1, $a_pos[1]) ; Left Slider
                WinMove($hwnd, "", $left_hwnd, $a_pos[1]) ; Left Button
            EndIf
            ; hidden config wndow
            If $a_pos2[0] <> $left_hwnd And $hide_state = 1 Then
                WinMove($hwnd, "", $left_hwnd, $a_pos2[1])
                WinMove($hwnd2, "", 1, $a_pos2[1])
            EndIf         
        Else
            SideSwitch()
        EndIf
    EndIf
    If $side = "right" Then
        If $a_pos[0] + 302 >= ($VirtualDesktopWidth / 2) Then
            ; main window         
            If $a_pos[0] <> $VirtualDesktopWidth - 609 And $hide_state = 0 Then
                WinMove($hwnd2, "", ($VirtualDesktopWidth - 609), $a_pos[1]) ; Right Slider
                WinMove($hwnd, "", $right_hwnd, $a_pos[1]) ; Right button
            EndIf
            ; hidden config wndow
            If $a_pos2[0] <> $right_hwnd And $hide_state = 1 Then
                WinMove($hwnd, "",$right_hwnd , $a_pos2[1])
                WinMove($hwnd2, "", ($VirtualDesktopWidth - 609), $a_pos2[1])
            EndIf         
        Else
            SideSwitch()
        EndIf
    EndIf   
    
    If $pass = 1 Then WinSetTitle($hwnd2, "", " Config Mode - Please Press the Button to Configure...  Press  ""<""  to Cancel")
        
    If $hide_state = 0 Then
        $a_mpos = GUIGetCursorInfo($hwnd2)
        If IsArray($a_mpos) = 1 Then
            For $b = 1 To 14
                If $a_mpos[4] = $Button_[$b] And $b>=1 And $b<=7 Then
                    If $b = 1 Then $left = 15
                    If $b > 1 Then $left = (($b - 1) * 81) + 15
                    GUICtrlSetPos($Button_[$b], $left, 30, 83, 46)
                    GUICtrlSetColor($Label_[$b], 0xff0000)
                    GUICtrlSetCursor($Button_[$b], 0)
                    While $a_mpos[4] = $Button_[$b]
                        $msg = GUIGetMsg()
                        If $msg = $Button_[$b] Then
                            If $pass = 0 Then
                                Function($b)
                                ExitLoop
                            Else
                                Set_ini($b)
                                ExitLoop
                            EndIf
                        EndIf
                        $a_mpos = GUIGetCursorInfo($hwnd2)
                        If IsArray($a_mpos) <> 1 Then ExitLoop
                    WEnd
                    $left = $left + 5
                    GUICtrlSetPos($Button_[$b], $left, 35, 73, 41)
                    GUICtrlSetColor($Label_[$b], 0x000000)
                EndIf
                If $a_mpos[4] = $Button_[$b] And $b>=8 and $b<=14 Then
                    If $b = 7 Then $left = 15
                    If $b > 7 Then $left = (($b - 8) * 81) + 15
                    GUICtrlSetPos($Button_[$b], $left, 120, 83, 46)
                    GUICtrlSetColor($Label_[$b], 0xff0000)
                    GUICtrlSetCursor($Button_[$b], 0)
                    While $a_mpos[4] = $Button_[$b]
                        $msg = GUIGetMsg()
                        If $msg = $Button_[$b] Then
                            If $pass = 0 Then
                                Function($b)
                                ExitLoop
                            Else
                                Set_ini($b)
                                ExitLoop
                            EndIf
                        EndIf
                        $a_mpos = GUIGetCursorInfo($hwnd2)
                        If IsArray($a_mpos) <> 1 Then ExitLoop
                    WEnd
                    $left = $left + 5
                    GUICtrlSetPos($Button_[$b], $left, 120, 73, 41)
                    GUICtrlSetColor($Label_[$b], 0x000000)
                EndIf
            Next
        EndIf
    EndIf
WEnd
#EndRegion While

#Region Functions
#FUNCTION# ==============================================================
Func GetHoveredHwnd()
    Local $iRet = DllCall("user32.dll", "int", "WindowFromPoint", "long", MouseGetPos(0), "long", MouseGetPos(1))
    If IsArray($iRet) Then Return HWnd($iRet[0])
    Return SetError(1, 0, 0)
EndFunc ;==>GetHoveredHwnd
#FUNCTION# ==============================================================
Func SideSwitch()
    If $side = "left" Then
        $side = "right"
        GUICtrlSetPos($HIDE, 1, 8)
        GUICtrlSetData($HIDE, ">")
        GUICtrlSetPos($SHOW, 2, 8)
        GUICtrlSetData($SHOW, "<")
        GUICtrlSetPos($EDIT, 585, 8)
        GUICtrlSetData($EDIT, "[]")
    Else
        $side = "left"
        GUICtrlSetPos($HIDE, 585, 8)
        GUICtrlSetData($HIDE, "<")
        GUICtrlSetPos($SHOW, 585, 8)
        GUICtrlSetData($SHOW, ">")
        GUICtrlSetPos($EDIT, 2, 8)
        GUICtrlSetData($EDIT, "[]")
    EndIf
EndFunc   ;==>SideSwitch
#FUNCTION# ==============================================================
Func Maximize()
    TraySetState(2)
    GUISetState(@SW_SHOW, $active_window)   ; main window
    If $hide_state = 1 And $active_window = $hwnd Then ; if window is hidden, then unhide
        Slide_in()
    EndIf
EndFunc   ;==>Maximize
#FUNCTION# ==============================================================
Func Slide_in()
    ; the window will appear from left to right
    $hide_state = 0
    GUISetState(@SW_HIDE, $hwnd)
    If $side = "left" Then 
        DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $hwnd2, "int", 100, "long", 0x00040001);slide in from left
    Else
        DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $hwnd2, "int", 100, "long", 0x00040002);slide in from right
    EndIf
    WinActivate($hwnd2)
    WinWaitActive($hwnd2)
    _ReduceMemory() 
EndFunc  ;==>Slide_in
#FUNCTION# ==============================================================
Func Slide_out()
    ; the window will disappear from right to left
    $hide_state = 1
    If $side = "left" Then 
        DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $hwnd2, "int", 100, "long", 0x00050002);slide out to left
    Else
        DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $hwnd2, "int", 100, "long", 0x00050001);slide out to right    
    EndIf
    GUISetState(@SW_SHOW, $hwnd)
    WinActivate($hwnd)
    WinWaitActive($hwnd)
    _ReduceMemory() 
EndFunc  ;==>Slide_out
#FUNCTION# ==============================================================
Func Create_ini()
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Global", "Transparency", 222)
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Global", "Auto_appear", 0)
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch", 1, @ProgramFilesDir & "\Internet Explorer\iexplore.exe")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch", 2, @SystemDir & "\osk.exe")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch", 3, @ProgramFilesDir & "\Windows Media Player\wmplayer.exe")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch", 4, @SystemDir & "\notepad.exe")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch", 5, @SystemDir & "\calc.exe")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch", 6, @SystemDir & "\mstsc.exe")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch", 7, @SystemDir & "\cleanmgr.exe")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch", 8, "")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch", 9, "")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch",10, "")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch",11, @SystemDir)
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch",12, "")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch",13, "")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch",14, "")
    
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label", 1, "IE Explorer")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label", 2, "Keyboard")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label", 3, "Media Player")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label", 4, "Notepad")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label", 5, "Calculator")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label", 6, "Net Service")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label", 7, "Clean Mngr")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label", 8, "")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label", 9, "")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label",10, "")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label",11, "System Dir")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label",12, "")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label",13, "")
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Label",14, "")
EndFunc  ;==>Create_ini
#FUNCTION# ==============================================================
Func Set_ini(ByRef $b)
    ; slide out the config window
    Slide_out()
    ; hide the slide out button as this is only used in slide in mode
    GUICtrlSetState($SHOW, $GUI_HIDE)
    ; show all the config fields
    For $x = 1 To UBound($config_)-1
        GUICtrlSetState($config_[$x], $GUI_SHOW)
    Next
    ; add the image on the button
    If StringInStr($Launch_name[$b][1], ".exe") Then 
        ; exe file
        GUICtrlSetImage($config_[11], $Launch_name[$b][1],1)
    ElseIf StringInStr($Launch_name[$b][1], ".url") Then 
        ; url 
        GUICtrlSetImage($config_[11], "url.dll", 1)  
    ElseIf StringLen($Label_name[$b][1] & $Launch_name[$b][1]) = 0 Then 
        ; empty button
        GUICtrlSetImage($config_[11], "shell32.dll", 50)
    Else
        ; folder
        GUICtrlSetImage($config_[11], "shell32.dll", 4)
    EndIf
    Sleep(50)
    If $side = "left" Then
        ; move the window back to postion 1
        WinMove($hwnd, "", 1, $a_pos[1])
    Else
        WinMove($hwnd, "", $VirtualDesktopWidth - 609, $a_pos[1])
    EndIf
    GUICtrlSetData($config_[2], $Label_name[$b][1])
    GUICtrlSetData($config_[4], $Launch_name[$b][1])
    GUICtrlSetState($config_[4], $GUI_DROPACCEPTED )
    While 3
        ; switch windows
        $a_pos = WinGetPos($hwnd)
        If $side = "left" Then
            If $a_pos[0] + 302 < ($VirtualDesktopWidth / 2) Then
                ; main window
                If $a_pos[0] <> 1 Then 
                    WinMove($hwnd, "", 1, $a_pos[1]) 
                    ; And synchronize the position of the main window too
                    WinMove($hwnd2, "", 1, $a_pos[1]) 
                EndIf
            Else
                SideSwitch()
            EndIf
        EndIf
        If $side = "right" Then
            If $a_pos[0] + 302 >= ($VirtualDesktopWidth / 2) Then
                ; main window         
                If $a_pos[0] <> $VirtualDesktopWidth - 609 Then

                    WinMove($hwnd, "", ($VirtualDesktopWidth - 609), $a_pos[1]) 
                    WinMove($hwnd2, "", ($VirtualDesktopWidth - 609), $a_pos[1]) 
                EndIf
            Else
                SideSwitch()
            EndIf
        EndIf
        
        $msg3 = GUIGetMsg()

        
       If $msg3 = -3 Or $msg3 = -4 Then ExitLoop; escape key (-3) pressed, close window (-3), Minimize (-4) - same as cancel
        If $msg3 = $config_[5] Then ExitLoop ; cancel
        If $msg3 = $config_[6] Then ; browse
            $Find = FileOpenDialog("Please Select a Program to Launch", @ProgramFilesDir, "exe (*.exe)", 1 + 2)
            If Not @error = 1 Then GUICtrlSetData($config_[4], $Find)
        EndIf
        If $msg3 = $config_[7] Then ; accept
            $temp_name = GUICtrlRead($config_[2])
            $temp_info = GUICtrlRead($config_[4])

            If FileExists($temp_info) Or StringLen($temp_info & $temp_name) = 0 Then
                If StringInStr($temp_info, ".lnk") Then
                    $details = FileGetShortcut($temp_info)
                    $temp_info = $details[0]
                EndIf
                IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch", $b, $temp_info)
                IniWrite(@ScriptDir & "\toolbarAG.ini", "Label", $b, (GUICtrlRead($config_[2])))
                $Label_name = IniReadSection(@ScriptDir & "\toolbarAG.ini", "Label")
                $Launch_name = IniReadSection(@ScriptDir & "\toolbarAG.ini", "Launch")
                ; refresh label
ConsoleWrite($Launch_name[$b][1])
                GUICtrlSetData($Label_[$b], $Label_name[$b][1])
                ; set the tooltip 
                GUICtrlSetTip($Button_[$b], $Label_name[$b][1])
                If StringInStr($Launch_name[$b][1], ".exe") Then 
                    ; exe file
                    GUICtrlSetImage($Button_[$b], $Launch_name[$b][1],1)
                ElseIf StringInStr($Launch_name[$b][1], ".url") Then 
                    ; url 
                    GUICtrlSetImage($Button_[$b], "url.dll", 1)     
                ElseIf StringLen($Label_name[$b][1] & $Launch_name[$b][1]) = 0 Then 
                    ; empty button
                    GUICtrlSetImage($Button_[$b], "shell32.dll", 50)
                Else
                    ; folder
                    GUICtrlSetImage($Button_[$b], "shell32.dll", 4)
                EndIf
                ExitLoop
            Else
                MsgBox(262208, "Error", "The file location is not correct   ", 4)
            EndIf
        EndIf
        If $msg3 = $config_[8] Then ; Delete Button
            IniWrite(@ScriptDir & "\toolbarAG.ini", "Launch", $b, "")
            IniWrite(@ScriptDir & "\toolbarAG.ini", "Label", $b, "")
            $Label_name = IniReadSection(@ScriptDir & "\toolbarAG.ini", "Label")
            $Launch_name = IniReadSection(@ScriptDir & "\toolbarAG.ini", "Launch")  
            GUICtrlSetData($Label_[$b], "")
            ; empty the tooltip 
            GUICtrlSetTip($Button_[$b], "")
            GUICtrlSetImage($Button_[$b], "shell32.dll", 50)
            ExitLoop
        EndIf
    WEnd
    For $x = 1 To UBound($config_)-1
        GUICtrlSetState($config_[$x], $GUI_HIDE)
    Next

    ; hide the config window now
    If $side = "left" Then
        ; move the window back to postion 1
        WinMove($hwnd, "", $left_hwnd, $a_pos[1])
    Else
        WinMove($hwnd, "", $right_hwnd, $a_pos[1])
    EndIf

    ; show the slide out button
    GUICtrlSetState($SHOW, $GUI_SHOW)
    Slide_in()
EndFunc  ;==>Set_ini
#FUNCTION# ==============================================================
Func Tray_About()
    TrayTip("Sliding Toolbar", "A GreenCan"  & @CR & "December 2008",0,1+16)
    Return 
EndFunc  ;==>Tray_About
#FUNCTION# ==============================================================
Func About()
    Return "Sliding Toolbar" & @CR & "A GreenCan"  & @CR & "December 2008"
EndFunc  ;==>About
#FUNCTION# ==============================================================
Func Function(ByRef $b)
    Slide_out()
    If FileExists($Launch_name[$b][1]) Then
        If StringInStr($Launch_name[$b][1], ".exe") > 0 Then
            $LFile = FileGetShortName($Launch_name[$b][1])
            $Dir = Stringleft($LFile, StringInStr( $LFile, "\" , 0, -1)-1)
            Run($LFile, $Dir)
        ElseIf StringInStr($Launch_name[$b][1], ".url") > 0 Then
            ConsoleWrite($Launch_name[$b][1])
            ShellExecute ($Launch_name[$b][1])
        Else
            ; Folder
            Run(@WindowsDir & "\explorer.exe /n,/root, " & $Launch_name[$b][1])
        EndIf
    Else
        MsgBox(262208, "Error", "Program or directory not found!   ", 4)
    EndIf
    _ReduceMemory()
EndFunc  ;==>Function
#FUNCTION# ==============================================================
Func Set_Exit()
    GUIDelete($hwnd2)   
    GUIDelete($hwnd)    
    Exit
EndFunc  ;==>Set_Exit
#FUNCTION# ==============================================================
Func Set_Config()
    $a_pos = WinGetPos($hwnd)
    If $a_pos[0] = 3 Then Return
    Slide_in()
    $pass = 1
EndFunc  ;==>Set_Config
#FUNCTION# ==============================================================
Func Transparency()
    Local $Msg4
    Maximize()
    $a_pos = WinGetPos($hwnd2) 
    $hGUI1 = GUICreate("Set Transparency", 230, 70, 185, $a_pos[1]+ 170/2 - 50, BitOR($WS_POPUP,$WS_BORDER), $WS_EX_TOPMOST)
    $iLabel1 = GUICtrlCreateLabel ("Adjust slider to change opacity level", 10, 10, 180, 20)
    $iSlider = GUICtrlCreateSlider(5, 32, 180, 40)
    GUICtrlSetLimit($iSlider, 254, 150)
    GUICtrlSetData ($iSlider, $Transparency)
    $button = GUICtrlCreateButton("OK", 190, 5, 25, 60) 
    GUISetState( )
    Do
        $msg4 = GUIGetMsg()
        $value = GUICtrlRead($iSlider)
        WinSetTrans($hwnd2, "", $value)
        If $msg4 = $button Or $msg4 = -3 Then
            $Transparency = $value
            IniWrite(@ScriptDir & "\toolbarAG.ini", "Global", "Transparency", $Transparency)
            GUIDelete ( $hGUI1 )
            _ReduceMemory() 
            Return 
        EndIf
    Until $msg4 = $GUI_EVENT_CLOSE  
    
EndFunc   ;==>Settings
#FUNCTION# ==============================================================
Func Mouseover()
    If $Auto_appear = 1 Then ; flip/flop
        $Auto_appear = 0
    Else
        $Auto_appear = 1 
    EndIf
    If $Auto_appear = 1 Then; auto_appear is True
        ; hide the window almost completely as the mouse over will slide in the window, no button needs to be shown
        $left_hwnd = -605
        $right_hwnd = ($VirtualDesktopWidth -6)
        $Auto_app = "On"
    Else
        ; leave just the slide in buttons visual
        $left_hwnd = -588
        $right_hwnd = ($VirtualDesktopWidth -20)    
        $Auto_app = "Off"
    EndIf
    TrayItemSetText ( $Mouseover_tray, "Mouseover appear " & $Auto_app )
    IniWrite(@ScriptDir & "\toolbarAG.ini", "Global", "Auto_appear", $Auto_appear)  
    Maximize()  
    Return
EndFunc   ;==>Mouseover
#FUNCTION# ==============================================================
Func _ReduceMemory()
    Local $dll_mem = DllOpen(@SystemDir & "\psapi.dll")
    Local $ai_Return = DllCall($dll_mem, 'int', 'EmptyWorkingSet', 'long', -1)
    If @error Then Return SetError(@error, @error, 1)
    Return $ai_Return[0]
EndFunc   ;==>_ReduceMemory
#FUNCTION# ==============================================================
#Region Perforated Image
#comments-start
    The lines below will generate the perforated image (bewteen start and end)
    Move these lines into your GUI code, usually just before GUISetState()
    Don't forget to fill in the correct coordinates for $Left_pos, $Top_pos
    and enter the GUI Window Handle in the last line

# ==> Start
Local $_Left_pos, $_Top_pos, $_GUI_NAME
$_Left_pos = 10 ; Replace with correct position
$_Top_pos = 10 ; Replace with correct position
$_GUI_NAME = 'The name of your GUI window'
_GuiImageHole($_GUI_NAME, $_Left_pos, $_Top_pos, 136, 45)
# <== End

#comments-end

#FUNCTION# ==============================================================
Func _GuiImageHole($window_handle, $pos_x, $pos_y,$Image_Width ,$Image_Height)
    Local $aClassList, $aM_Mask, $aMask
#Region picture array
Local $PictArray[248]
$PictArray[0] = '1,1,2,1'
$PictArray[1] = '5,1,24,1'
$PictArray[2] = '29,1,44,1'
$PictArray[3] = '48,1,91,1'
$PictArray[4] = '95,1,136,1'
$PictArray[5] = '1,2,3,2'
$PictArray[6] = '6,2,23,2'
$PictArray[7] = '30,2,44,2'
$PictArray[8] = '47,2,91,2'
$PictArray[9] = '96,2,136,2'
$PictArray[10] = '1,3,4,3'
$PictArray[11] = '7,3,8,3'
$PictArray[12] = '10,3,22,3'
$PictArray[13] = '30,3,37,3'
$PictArray[14] = '42,3,43,3'
$PictArray[15] = '46,3,92,3'
$PictArray[16] = '96,3,136,3'
$PictArray[17] = '1,4,5,4'
$PictArray[18] = '11,4,23,4'
$PictArray[19] = '29,4,36,4'
$PictArray[20] = '45,4,65,4'
$PictArray[21] = '68,4,92,4'
$PictArray[22] = '96,4,136,4'
$PictArray[23] = '1,5,5,5'
$PictArray[24] = '13,5,23,5'
$PictArray[25] = '30,5,35,5'
$PictArray[26] = '44,5,65,5'
$PictArray[27] = '69,5,86,5'
$PictArray[28] = '91,5,92,5'
$PictArray[29] = '97,5,136,5'
$PictArray[30] = '1,6,5,6'
$PictArray[31] = '13,6,22,6'
$PictArray[32] = '31,6,36,6'
$PictArray[33] = '43,6,64,6'
$PictArray[34] = '71,6,85,6'
$PictArray[35] = '92,6,92,6'
$PictArray[36] = '97,6,136,6'
$PictArray[37] = '1,7,5,7'
$PictArray[38] = '12,7,21,7'
$PictArray[39] = '32,7,34,7'
$PictArray[40] = '42,7,64,7'
$PictArray[41] = '71,7,85,7'
$PictArray[42] = '92,7,92,7'
$PictArray[43] = '97,7,136,7'
$PictArray[44] = '1,8,5,8'
$PictArray[45] = '15,8,21,8'
$PictArray[46] = '32,8,33,8'
$PictArray[47] = '43,8,49,8'
$PictArray[48] = '54,8,64,8'
$PictArray[49] = '70,8,85,8'
$PictArray[50] = '97,8,136,8'
$PictArray[51] = '1,9,4,9'
$PictArray[52] = '18,9,20,9'
$PictArray[53] = '32,9,32,9'
$PictArray[54] = '44,9,48,9'
$PictArray[55] = '55,9,64,9'
$PictArray[56] = '72,9,85,9'
$PictArray[57] = '96,9,136,9'
$PictArray[58] = '1,10,4,10'
$PictArray[59] = '15,10,15,10'
$PictArray[60] = '44,10,47,10'
$PictArray[61] = '55,10,63,10'
$PictArray[62] = '73,10,85,10'
$PictArray[63] = '96,10,136,10'
$PictArray[64] = '1,11,3,11'
$PictArray[65] = '15,11,19,11'
$PictArray[66] = '45,11,47,11'
$PictArray[67] = '54,11,63,11'
$PictArray[68] = '74,11,84,11'
$PictArray[69] = '96,11,136,11'
$PictArray[70] = '1,12,3,12'
$PictArray[71] = '17,12,18,12'
$PictArray[72] = '46,12,47,12'
$PictArray[73] = '55,12,62,12'
$PictArray[74] = '75,12,83,12'
$PictArray[75] = '96,12,136,12'
$PictArray[76] = '1,13,4,13'
$PictArray[77] = '17,13,17,13'
$PictArray[78] = '46,13,46,13'
$PictArray[79] = '56,13,62,13'
$PictArray[80] = '76,13,83,13'
$PictArray[81] = '97,13,136,13'
$PictArray[82] = '1,14,4,14'
$PictArray[83] = '17,14,17,14'
$PictArray[84] = '46,14,46,14'
$PictArray[85] = '56,14,62,14'
$PictArray[86] = '77,14,83,14'
$PictArray[87] = '97,14,136,14'
$PictArray[88] = '1,15,5,15'
$PictArray[89] = '16,15,17,15'
$PictArray[90] = '33,15,33,15'
$PictArray[91] = '57,15,62,15'
$PictArray[92] = '77,15,83,15'
$PictArray[93] = '98,15,136,15'
$PictArray[94] = '1,16,5,16'
$PictArray[95] = '16,16,16,16'
$PictArray[96] = '32,16,33,16'
$PictArray[97] = '58,16,62,16'
$PictArray[98] = '77,16,83,16'
$PictArray[99] = '98,16,136,16'
$PictArray[100] = '1,17,5,17'
$PictArray[101] = '16,17,16,17'
$PictArray[102] = '32,17,33,17'
$PictArray[103] = '58,17,62,17'
$PictArray[104] = '78,17,82,17'
$PictArray[105] = '98,17,136,17'
$PictArray[106] = '1,18,5,18'
$PictArray[107] = '32,18,33,18'
$PictArray[108] = '58,18,62,18'
$PictArray[109] = '78,18,82,18'
$PictArray[110] = '98,18,136,18'
$PictArray[111] = '1,19,5,19'
$PictArray[112] = '57,19,63,19'
$PictArray[113] = '78,19,81,19'
$PictArray[114] = '98,19,136,19'
$PictArray[115] = '1,20,5,20'
$PictArray[116] = '57,20,64,20'
$PictArray[117] = '78,20,81,20'
$PictArray[118] = '98,20,136,20'
$PictArray[119] = '1,21,5,21'
$PictArray[120] = '58,21,64,21'
$PictArray[121] = '77,21,81,21'
$PictArray[122] = '99,21,136,21'
$PictArray[123] = '1,22,5,22'
$PictArray[124] = '58,22,63,22'
$PictArray[125] = '76,22,82,22'
$PictArray[126] = '99,22,136,22'
$PictArray[127] = '1,23,6,23'
$PictArray[128] = '32,23,32,23'
$PictArray[129] = '46,23,46,23'
$PictArray[130] = '58,23,63,23'
$PictArray[131] = '77,23,82,23'
$PictArray[132] = '100,23,136,23'
$PictArray[133] = '1,24,6,24'
$PictArray[134] = '31,24,32,24'
$PictArray[135] = '46,24,46,24'
$PictArray[136] = '58,24,64,24'
$PictArray[137] = '77,24,82,24'
$PictArray[138] = '99,24,136,24'
$PictArray[139] = '2,25,6,25'
$PictArray[140] = '31,25,32,25'
$PictArray[141] = '59,25,64,25'
$PictArray[142] = '78,25,83,25'
$PictArray[143] = '98,25,136,25'
$PictArray[144] = '7,26,7,26'
$PictArray[145] = '16,26,17,26'
$PictArray[146] = '31,26,32,26'
$PictArray[147] = '46,26,46,26'
$PictArray[148] = '59,26,64,26'
$PictArray[149] = '79,26,83,26'
$PictArray[150] = '96,26,136,26'
$PictArray[151] = '8,27,9,27'
$PictArray[152] = '15,27,17,27'
$PictArray[153] = '25,27,25,27'
$PictArray[154] = '31,27,33,27'
$PictArray[155] = '45,27,46,27'
$PictArray[156] = '60,27,61,27'
$PictArray[157] = '79,27,84,27'
$PictArray[158] = '95,27,136,27'
$PictArray[159] = '3,28,5,28'
$PictArray[160] = '8,28,9,28'
$PictArray[161] = '15,28,20,28'
$PictArray[162] = '25,28,25,28'
$PictArray[163] = '33,28,33,28'
$PictArray[164] = '42,28,47,28'
$PictArray[165] = '60,28,61,28'
$PictArray[166] = '78,28,84,28'
$PictArray[167] = '95,28,136,28'
$PictArray[168] = '34,29,34,29'
$PictArray[169] = '39,29,39,29'
$PictArray[170] = '42,29,48,29'
$PictArray[171] = '60,29,61,29'
$PictArray[172] = '76,29,85,29'
$PictArray[173] = '95,29,119,29'
$PictArray[174] = '125,29,129,29'
$PictArray[175] = '135,29,136,29'
$PictArray[176] = '38,30,38,30'
$PictArray[177] = '44,30,50,30'
$PictArray[178] = '76,30,87,30'
$PictArray[179] = '95,30,121,30'
$PictArray[180] = '125,30,128,30'
$PictArray[181] = '131,30,133,30'
$PictArray[182] = '135,30,136,30'
$PictArray[183] = '47,31,50,31'
$PictArray[184] = '55,31,59,31'
$PictArray[185] = '64,31,64,31'
$PictArray[186] = '76,31,87,31'
$PictArray[187] = '95,31,120,31'
$PictArray[188] = '123,31,123,31'
$PictArray[189] = '126,31,127,31'
$PictArray[190] = '130,31,133,31'
$PictArray[191] = '135,31,136,31'
$PictArray[192] = '49,32,50,32'
$PictArray[193] = '56,32,61,32'
$PictArray[194] = '65,32,65,32'
$PictArray[195] = '69,32,69,32'
$PictArray[196] = '76,32,80,32'
$PictArray[197] = '83,32,87,32'
$PictArray[198] = '95,32,119,32'
$PictArray[199] = '122,32,123,32'
$PictArray[200] = '126,32,126,32'
$PictArray[201] = '129,32,136,32'
$PictArray[202] = '56,33,57,33'
$PictArray[203] = '66,33,69,33'
$PictArray[204] = '76,33,77,33'
$PictArray[205] = '84,33,87,33'
$PictArray[206] = '95,33,119,33'
$PictArray[207] = '122,33,123,33'
$PictArray[208] = '126,33,126,33'
$PictArray[209] = '129,33,130,33'
$PictArray[210] = '135,33,136,33'
$PictArray[211] = '67,34,70,34'
$PictArray[212] = '77,34,78,34'
$PictArray[213] = '84,34,88,34'
$PictArray[214] = '95,34,118,34'
$PictArray[215] = '126,34,126,34'
$PictArray[216] = '129,34,131,34'
$PictArray[217] = '134,34,136,34'
$PictArray[218] = '32,35,32,35'
$PictArray[219] = '85,35,88,35'
$PictArray[220] = '95,35,117,35'
$PictArray[221] = '120,35,123,35'
$PictArray[222] = '126,35,126,35'
$PictArray[223] = '129,35,131,35'
$PictArray[224] = '134,35,136,35'
$PictArray[225] = '18,36,23,36'
$PictArray[226] = '26,36,40,36'
$PictArray[227] = '86,36,88,36'
$PictArray[228] = '95,36,116,36'
$PictArray[229] = '121,36,122,36'
$PictArray[230] = '127,36,127,36'
$PictArray[231] = '134,36,136,36'
$PictArray[232] = '14,37,45,37'
$PictArray[233] = '85,37,88,37'
$PictArray[234] = '95,37,136,37'
$PictArray[235] = '9,38,51,38'
$PictArray[236] = '88,38,88,38'
$PictArray[237] = '97,38,136,38'
$PictArray[238] = '7,39,54,39'
$PictArray[239] = '57,39,58,39'
$PictArray[240] = '62,39,64,39'
$PictArray[241] = '67,39,68,39'
$PictArray[242] = '70,39,72,39'
$PictArray[243] = '100,39,136,39'
$PictArray[244] = '6,40,78,40'
$PictArray[245] = '100,40,136,40'
$PictArray[246] = '4,41,80,41'
$PictArray[247] = '100,41,136,41'

#EndRegion picture array

    ; get the size of the active window
    $size = WinGetClientSize($window_handle)
    $Window_width = $size[0]
    $Window_height = $size[1]+33 ; including the title bar
    ; First hide the window
    $aClassList = StringSplit(_WinGetClassListEx($window_handle), @LF)
    $aM_Mask = DllCall('gdi32.dll', 'long', 'CreateRectRgn', 'long', 0, 'long', 0, 'long', 0, 'long', 0)
    ; rectangle A - left side
    $aMask = DllCall('gdi32.dll', 'long', 'CreateRectRgn', 'long', 0, 'long', 0, 'long', $pos_x, 'long', $Window_height)
    DllCall('gdi32.dll', 'long', 'CombineRgn', 'long', $aM_Mask[0], 'long', $aMask[0], 'long', $aM_Mask[0], 'int', 2)
    ; rectangle B - Top
    $aMask = DllCall('gdi32.dll', 'long', 'CreateRectRgn', 'long', 0, 'long', 0, 'long', $Window_width, 'long', $pos_y)
    DllCall('gdi32.dll', 'long', 'CombineRgn', 'long', $aM_Mask[0], 'long', $aMask[0], 'long', $aM_Mask[0], 'int', 2)
    ; rectangle C - Right side
    $aMask = DllCall('gdi32.dll', 'long', 'CreateRectRgn', 'long', $pos_x  + $Image_Width , 'long', 0 , 'long', $Window_width + 30, 'long', $Window_height)
    DllCall('gdi32.dll', 'long', 'CombineRgn', 'long', $aM_Mask[0], 'long', $aMask[0], 'long', $aM_Mask[0], 'int', 2)
    ; rectangle D - Bottom
    $aMask = DllCall('gdi32.dll', 'long', 'CreateRectRgn', 'long', 0 , 'long', $pos_y + $Image_Height, 'long', $Window_width, 'long', $Window_height)
    DllCall('gdi32.dll', 'long', 'CombineRgn', 'long', $aM_Mask[0], 'long', $aMask[0], 'long', $aM_Mask[0], 'int', 2)
    ; now unhide all regions as defined  in array $PictArray
    For $i = 0 To (UBound($PictArray) - 1)
        $Block_value = StringSplit($PictArray[$i],',')
        $aMask = DllCall('gdi32.dll', 'long', 'CreateRectRgn', 'long', $pos_x + $Block_value[1] - 1 , 'long', $pos_y + $Block_value[2], 'long', $pos_x + $Block_value[3], 'long', $pos_y + $Block_value[4] -1)
        DllCall('gdi32.dll', 'long', 'CombineRgn', 'long', $aM_Mask[0], 'long', $aMask[0], 'long', $aM_Mask[0], 'int', 2)
    Next
    DllCall('user32.dll', 'long', 'SetWindowRgn', 'hwnd', $window_handle, 'long', $aM_Mask[0], 'int', 1)
    $PictArray='' ; empty array
EndFunc  ;==>_GuiImageHole
#FUNCTION# ==============================================================
Func _WinGetClassListEx($sTitle)
    Local $sClassList = WinGetClassList($sTitle)
    Local $aClassList = StringSplit($sClassList, @LF)
    Local $sRetClassList = '', $sHold_List = '|'
    Local $aiInHold, $iInHold
    For $i = 1 To UBound($aClassList) - 1
        If $aClassList[$i] = '' Then ContinueLoop
        If StringRegExp($sHold_List, '\|' & $aClassList[$i] & '~(\d+)\|') Then
            $aiInHold = StringRegExp($sHold_List, '.*\|' & $aClassList[$i] & '~(\d+)\|.*', 1)
            $iInHold = Number($aiInHold[UBound($aiInHold)-1])
            If $iInHold = 0 Then $iInHold += 1
            $aClassList[$i] &= '~' & $iInHold + 1
            $sHold_List &= $aClassList[$i] & '|'
            $sRetClassList &= $aClassList[$i] & @LF
        Else
            $aClassList[$i] &= '~1'
            $sHold_List &= $aClassList[$i] & '|'
            $sRetClassList &= $aClassList[$i] & @LF
        EndIf
    Next
    Return StringReplace(StringStripWS($sRetClassList, 3), '~', '')
EndFunc ;==>_WinGetClassListEx
#FUNCTION# ==============================================================
#EndRegion Perforated Image
#EndRegion Functions