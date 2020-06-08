#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <GDIPlus.au3>
#Include <Misc.au3>
#Include <GuiEdit.au3>

_GDIPlus_Startup()

Opt("OnExitFunc", "endscript") ;func @ exiting script

dim $icons[10] ;number of icons used
dim $icon_info[10][6] ;number of icons used and their information
global $shell32 = @SystemDir & "\shell32.dll" ;shell32.dll location, the file for icon extraction
Global $cur_first = 0, $cur_last = 9, $moving = False, $timer_10, $hGraphic, $timer_end_txt, $inside = False ;some global variables

$timer_10 = TimerInit() ;this timer is limiting sliding to max speed of 10ms/px
$timer_end_txt = TimerInit() ;this timer is used for toolbar label to vanish (check While 1 section)

_set_icon_info() ;setting icons info, check the function for detail info

$Form1 = GUICreate("pr0 toolbar #1", 253, 300) ;gui creation
GUISetBkColor(0) ;gui black background color
GUICtrlCreateGroup("", 12, 76, 229, 212) ;group around edit
$Edit1 = GUICtrlCreateEdit("Click any icon in the toolbar...", 15, 85, 223, 200, $WS_VSCROLL+0x0040+0x0004+0x1000) ;edit control to display icons clicking
GUICtrlSetBkColor(-1, 0x333333) ;gray background of edit ctrl
GUICtrlSetColor(-1, 0xFFFFFF) ;white letters inside of edit ctrl
GUICtrlSetFont(-1, 8, 400, -1, "Arial") ;arial font for edit ctrl
GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group
$toolbar_display_txt = GUICtrlCreateLabel("", 10, 49+7, 233, 17, 0x01) ;label to display curent selected toolbar icon with "CENTER" style = 0x01
GUICtrlSetColor(-1, 0xFFFFFF) ;above label color is white
GUICtrlSetFont(-1, 12, 800, 2, "Arial") ;above label's font = arial, 800=bold
WinSetTrans($form1, "", 255) ;setting transp to 255 (max) will make GDI always visible (without disappearing when moved on the edge of the desktop, or when overlaped by another window
                                ;note - must be before declaring graphic GDI in order for this to work
$hGraphic = _GDIPlus_GraphicsCreateFromHWND($Form1) ;creating graphic for drawing toolbar icons
_extract_icons() ;extracting icons from shell32.dll, check func for detail info

GUISetState(@SW_SHOW, $form1) ;display main GUI

$stemp = GUICreate("", 30, 14, 185, 293, BitOR($WS_POPUP, $WS_CHILD), $WS_EX_MDICHILD, $Form1) ;just another trick-window to make CLEAR label inside of main window's EDIT, pretty neat ;)
WinSetTrans($stemp, "", 255) ;setting trans to 255 to clear bugs when moving main window
GUISetBkColor(0x333333) ;background color is the same as EDIT in main window
$clear_label = GUICtrlCreateLabel("clear", 0, 0, 30, 14, 0x01) ;clear label with "CENTER" style = 0x01
GUICtrlSetCursor(-1, 0) ;"finger" cursor on this label above
GUICtrlSetColor(-1, 0xFF0000) ;red color label
GUICtrlSetFont(-1, 8, 400, -1, "Arial") ;arial font for edit ctrl
GUISetState(@SW_SHOW, $stemp) ;display clear label inside of edit control

for $i = 0 to 4
    _GDIPlus_GraphicsDrawImageRect($hGraphic, $icons[$i], $icon_info[$i][3], 15, 32, 32) ;drawing first 4 icons into GDI (window)
Next

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        case $clear_label ;edit label in the "trick" child-window inside of EDIT control
            GUICtrlSetData($Edit1, "")
    EndSwitch
    
    Local $c = GUIGetCursorInfo($Form1) ;get mouse location inside of GUI
        Local $x_coord = $c[0] ;mouse x coordinate inside of GUI
        Local $y_coord = $c[1] ;mouse y coordinate isnide of GUI
        if $y_coord < 52 AND $y_coord > 0 AND WinActive($Form1) Then ;top and bottom coordinate of toolbar
            if TimerDiff($timer_10) >= 10 then ;sliding is chaotic if there is no speed limitation, 10ms in this case is just enough
                $timer_10 = TimerInit()
                Switch $x_coord
                    case -100 to 41 ;left corner - moving icons to the right
                        $inside = true ;is mouse inside of sliding area? yes!
                        _shrink_all() ;if there is any icon that is enlarged, it'll be decreased
                        $moving = true ;is slider mooving? yes!
                        Local $speed
                        Local $x_coord1 = $x_coord
                        if $x_coord1 < 0 then
                            $x_coord1 = 0 ;if this isn't limited to 0 then the speed would continue to increase if the mouse is outside (but near) window
                        EndIf
                        $speed = int(((41-$x_coord1)/15)^2) ;acceleration and speed of sliding icons is increased parabolical, and not linear, that's why ^2
                        if $speed < 1 then $speed = 1 ;min speed should be 1px
                        for $i = 0 to 9
                            $icon_info[$i][3] += $speed ;changing x starting coordinate for each icon
                            $icon_info[$i][4] += $speed ;changing x starting coordinate for each icon
                            
                            if Int($icon_info[$cur_first][3]) >= 25 Then ;this is where last icon become first
                                Local $previous = $cur_first
                                $cur_first -= 1
                                if $cur_first < 0 then $cur_first = 9
                                $icon_info[$cur_first][3] = int($icon_info[$previous][3]) - 57
                                $icon_info[$cur_first][4] = int($icon_info[$previous][4]) - 57
                            EndIf
                            
                            if $icon_info[$i][3] < 253+25 then ;icons that aren't visible shouldn't move at all (and thus save pc resources)
                                Local $width_x = 10
                                _GDIPlus_GraphicsFillRect($hGraphic, $icon_info[$i][4], 15, $width_x, 32);Right side filling black line
                                _GDIPlus_GraphicsDrawImageRect($hGraphic, $icons[$i], $icon_info[$i][3], 15, 32, 32);icon image
                                _GDIPlus_GraphicsFillRect($hGraphic, $icon_info[$i][3]-$width_x, 15, $width_x, 32);Left side filling black line
                            EndIf
                        Next
                    case 212 to 253+100 ;right corner - moving to the left
                        $inside = true
                        _shrink_all()
                        $moving = true
                        Local $speed
                        Local $x_coord1 = $x_coord
                        if $x_coord1 > 253 then
                            $x_coord1 = 253
                        EndIf
                        $speed = Int((($x_coord1-212)/15)^2)
                        if $speed < 1 then $speed = 1
                        for $i = 0 to 9
                            $icon_info[$i][3] -= $speed
                            $icon_info[$i][4] -= $speed
                            
                            if int($icon_info[$cur_last][3]) <= 228 Then ;this is where first icon become last
                                Local $previous = $cur_last
                                $cur_last += 1
                                if $cur_last > 9 then $cur_last = 0
                                $icon_info[$cur_last][3] = int($icon_info[$previous][3]) + 57
                                $icon_info[$cur_last][4] = int($icon_info[$previous][4]) + 57

                            EndIf
                            
                            if $icon_info[$i][4]+25 > 0 then
                                Local $width_x = 10
                                _GDIPlus_GraphicsFillRect($hGraphic, $icon_info[$i][3]-$width_x, 15, $width_x, 32);Left side filling black line
                                _GDIPlus_GraphicsDrawImageRect($hGraphic, $icons[$i], $icon_info[$i][3], 15, 32, 32)
                                _GDIPlus_GraphicsFillRect($hGraphic, $icon_info[$i][4], 15, $width_x, 32);Right side filling black line
                            EndIf
                        Next
                    case Else
                        $moving = False
                        if $inside = True Then
                            $inside = False
                            Local $founded = 10
                            for $i = 0 to 9
                                if $icon_info[$i][2] = True Then
                                    $founded = $i
                                    ExitLoop
                                EndIf
                            Next
                            if $founded <> 10 then
                                if $icon_info[$founded][5] = false Then
                                    _easy_rise($icons[$founded], $icon_info[$founded][3]-2, 12, 37, 37)
                                    $icon_info[$founded][5] = true
                                EndIf
                            EndIf
                        EndIf
                EndSwitch
            EndIf
                switch $x_coord
                    case $icon_info[0][3]-5 to $icon_info[0][4]+5 ;1st icon, mouse is hovering above 1st icon
                        if $x_coord >= 0 AND $x_coord <= 253 then _for_icon(0)
                    case $icon_info[1][3]-5 to $icon_info[1][4]+5 ;2nd icon
                        if $x_coord >= 0 AND $x_coord <= 253 then _for_icon(1)
                    case $icon_info[2][3]-5 to $icon_info[2][4]+5 ;3rd icon
                        if $x_coord >= 0 AND $x_coord <= 253 then _for_icon(2)
                    case $icon_info[3][3]-5 to $icon_info[3][4]+5 ;4th icon
                        if $x_coord >= 0 AND $x_coord <= 253 then _for_icon(3)
                    case $icon_info[4][3]-5 to $icon_info[4][4]+5 ;5th icon
                        if $x_coord >= 0 AND $x_coord <= 253 then _for_icon(4)
                    case $icon_info[5][3]-5 to $icon_info[5][4]+5 ;6th icon
                        if $x_coord >= 0 AND $x_coord <= 253 then _for_icon(5)
                    case $icon_info[6][3]-5 to $icon_info[6][4]+5 ;7th icon
                        if $x_coord >= 0 AND $x_coord <= 253 then _for_icon(6)
                    case $icon_info[7][3]-5 to $icon_info[7][4]+5 ;8th icon
                        if $x_coord >= 0 AND $x_coord <= 253 then _for_icon(7)
                    case $icon_info[8][3]-5 to $icon_info[8][4]+5 ;9th icon
                        if $x_coord >= 0 AND $x_coord <= 253 then _for_icon(8)
                    case $icon_info[9][3]-5 to $icon_info[9][4]+5 ;10th icon
                        if $x_coord >= 0 AND $x_coord <= 253 then _for_icon(9)
                    case Else
                        _shrink_all()
                EndSwitch
        Else
            _shrink_all()
        EndIf
    if Round(TimerDiff($timer_end_txt)) >= 500 then GUICtrlSetData($toolbar_display_txt, "") ;if mouse wasn't hovering above any icon for 0.5sec, display txt should vanish
    if WinActive($stemp) then WinActivate($form1) ;if the child window with label "clear" inside of EDIT ctrl is active, then main window should activate and set as current
WEnd
    
func _for_icon($number)
    $timer_end_txt = TimerInit() ;timer for vanishing txt label that display txt of curent icon
    if $icon_info[$number][2] = False then ;prevent constant shrinking and enlarging
        GUICtrlSetData($toolbar_display_txt, $icon_info[$number][1]) ;set label txt to curent icon info
        if $moving = False then ;if the slider isn't moving then it's OK to resize icons
            _shrink_all() 
            _easy_rise($icons[$number], $icon_info[$number][3]-2, 12, 37, 37) ;should enlarge selected icon
            $icon_info[$number][5] = true ;setting the curent icon as enlarged
        EndIf
        $icon_info[$number][2] = True ;setting the curent icon as selected
    EndIf
    If _IsPressed(01) then ;if mouse click is down on the selected icon
        if $icon_info[$number][5] = false Then
            _easy_rise($icons[$number], $icon_info[$number][3]-2, 12, 37, 37)
            $icon_info[$number][5] = true
        EndIf
        Do
        Until NOT _IsPressed(01) ;waiting for mouse key to release (like on regular buttons)
        Local $c = GUIGetCursorInfo($Form1)
        Local $x_coord = $c[0]
        Local $y_coord = $c[1]
        if $x_coord > $icon_info[$number][3]-5 AND $x_coord < $icon_info[$number][4]+5 AND $y_coord < 42 AND $y_coord > 0 AND WinActive($Form1) Then ;if the mouse click is released while cursor was still on that icon and while GUI is active...
        Switch $number
            case 0
                ;func for icon 1
                _GUICtrlEdit_AppendText($Edit1, @CRLF & "1st Icon Clicked - " & $icon_info[0][1]) ;edit this, and set any function you want to be called when you hit 1st icon
            case 1
                ;func for icon 2
                _GUICtrlEdit_AppendText($Edit1, @CRLF & "2nd Icon Clicked - " & $icon_info[1][1])
            case 2
                ;func for icon 3
                _GUICtrlEdit_AppendText($Edit1, @CRLF & "3rd Icon Clicked - " & $icon_info[2][1])
            case 3
                ;func for icon 4
                _GUICtrlEdit_AppendText($Edit1, @CRLF & "4th Icon Clicked - " & $icon_info[3][1])
            case 4
                ;func for icon 5
                _GUICtrlEdit_AppendText($Edit1, @CRLF & "5th Icon Clicked - " & $icon_info[4][1])
            case 5
                ;func for icon 6
                _GUICtrlEdit_AppendText($Edit1, @CRLF & "6th Icon Clicked - " & $icon_info[5][1])
            case 6
                ;func for icon 7
                _GUICtrlEdit_AppendText($Edit1, @CRLF & "7th Icon Clicked - " & $icon_info[6][1])
            case 7
                ;func for icon 8
                _GUICtrlEdit_AppendText($Edit1, @CRLF & "8th Icon Clicked - " & $icon_info[7][1])
            case 8
                ;func for icon 9
                _GUICtrlEdit_AppendText($Edit1, @CRLF & "9th Icon Clicked - " & $icon_info[8][1])
            case 9
                ;func for icon 10
                _GUICtrlEdit_AppendText($Edit1, @CRLF & "10th Icon Clicked - " & $icon_info[9][1])
        EndSwitch
        EndIf
    EndIf
EndFunc

func _shrink_all()
    for $i = 0 to 9
        if $icon_info[$i][2] = True Then ;if icon is selected
            if $icon_info[$i][5] = True then ;if icon is enlarged
                _easy_shrink($icons[$i], $icon_info[$i][3], 15, 32, 32)
                $icon_info[$i][5] = False
            EndIf
            $icon_info[$i][2] = false
        EndIf
    Next
EndFunc

func _easy_rise($immmmage, $iX, $iY, $iW, $iH, $maxxx=6, $step = 1) ;image to be resized, x-coord of the image, y-coord of the image, width of the image, height of the image, max enlargement, speed of enlargement
    for $i = 1 to $maxxx Step $step
        _GDIPlus_GraphicsDrawImageRect($hGraphic, $immmmage, $iX-$i, $iY-$i, $iW+2*$i, $iH+2*$i) ;enlarging icon
        Sleep(1) ;making it smooth
    Next    
EndFunc

func _easy_shrink($immmmage, $iX, $iY, $iW, $iH, $maxxx=6, $step = 1)
    Local $cntr = 0
    for $i = $maxxx to 1 Step -$step
        _GDIPlus_GraphicsDrawImageRect($hGraphic, $immmmage, $iX-$i, $iY-$i, $iW+2*$i, $iH+2*$i) ;shrinking icon
        _GDIPlus_GraphicsFillRect($hGraphic, $iX-$i-$step-3, $iY-$i-$step, $step+3, $iH+2*$i+2*$step);black goes Left
        _GDIPlus_GraphicsFillRect($hGraphic, $iX-$i+$iW+2*$i-$step+1, $iY-$i-$step, $step+3, $iH+2*$i+2*$step);black goes Right
        _GDIPlus_GraphicsFillRect($hGraphic, $iX-$i-$step-3, $iY-$i-$step-3, $iW+2*$i+($step+3)*2, $step+3);black goes Above
        _GDIPlus_GraphicsFillRect($hGraphic, $iX-$i-$step-3, $iY-$i+$iH+2*$i, $iW+2*$i+($step+3)*2, $step+3);black goes Bellow
        $cntr = $i
        Sleep(1)
    Next
    if $iW+2*$cntr <> $iW OR $iH+2*$cntr <> $iH then ;if shrinking didn't went to the exact size it was supposed to, this will make it regular size again
        _GDIPlus_GraphicsDrawImageRect($hGraphic, $immmmage, $iX, $iY, $iW, $iH) ;drawing icon @ it's original size
        _GDIPlus_GraphicsFillRect($hGraphic, $iX-$step-3, $iY, $step+3, $iH);Left
        _GDIPlus_GraphicsFillRect($hGraphic, $iX+$iW, $iY, $step+3, $iH);Right
        _GDIPlus_GraphicsFillRect($hGraphic, $iX-$step-3, $iY-$step-3, $iW+2*($step+3), $step+3);Above
        _GDIPlus_GraphicsFillRect($hGraphic, $iX-$step-3, $iY+$iH, $iW+2*($step+3), $step+3);Bellow
    EndIf
EndFunc

func _extract_icons()
    for $i = 0 to 9
        Local $Ret = DllCall("shell32","long","ExtractAssociatedIcon","int",0,"str",$shell32,"int*",(-1*$icon_info[$i][0])-1) ;extract icon from file
        Local $hIcon = $Ret[0] ;icon's handle
        Local $pBitmap = DllCall($ghGDIPDll,"int","GdipCreateBitmapFromHICON", "ptr",$hIcon, "int*",0) ;create bitmap from icon's handle
        _GDIPlus_ImageSaveToFile($pBitmap[2],@ScriptDir & "\test_image" & $i & ".bmp") ;why am I saving it instead of using it's handle? Using it's handle will make parts around icon transparent,
        _GDIPlus_ImageDispose($pBitmap[2]) ;                                             thus ruining resize/select mode, but saving it as image will fill up the transparent parts with black color
        $icons[$i] = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\test_image" & $i & ".bmp") ;and now loading this file
        _WinAPI_DestroyIcon($Ret[0]) ;and clearing resources by destroying icon's handle we don't need anymore...
    Next
EndFunc

func _set_icon_info()
    ;icon value:
    $icon_info[0][0] = "-13"; = memory
    $icon_info[1][0] = "-204"; = Camera
    $icon_info[2][0] = "-197"; = Phone
    $icon_info[3][0] = "-131"; = MS Live
    $icon_info[4][0] = "-166"; = Gear
    $icon_info[5][0] = "-172"; = Search
    $icon_info[6][0] = "-169"; = Sound
    $icon_info[7][0] = "-171";= MSN
    $icon_info[8][0] = "-200"; = HDD
    $icon_info[9][0] = "-201"; = PDA
    
    ;icon name:
    $icon_info[0][1] = "Memory"; = memory
    $icon_info[1][1] = "Camera"; = Camera
    $icon_info[2][1] = "Phone"; = Phone
    $icon_info[3][1] = "MS Live"; = MS Live
    $icon_info[4][1] = "Gear"; = Gear
    $icon_info[5][1] = "Search"; = Search
    $icon_info[6][1] = "Sound"; = Sound
    $icon_info[7][1] = "MSN";= MSN
    $icon_info[8][1] = "HDD"; = HDD
    $icon_info[9][1] = "PDA"; = PDA
    
    ;icon hover:
    $icon_info[0][2] = False; = memory
    $icon_info[1][2] = False; = Camera
    $icon_info[2][2] = False; = Phone
    $icon_info[3][2] = False; = MS Live
    $icon_info[4][2] = False; = Gear
    $icon_info[5][2] = False; = Search
    $icon_info[6][2] = False; = Sound
    $icon_info[7][2] = False;= MSN
    $icon_info[8][2] = False; = HDD
    $icon_info[9][2] = False; = PDA
    
    ;icon enlarged:
    $icon_info[0][5] = False; = memory
    $icon_info[1][5] = False; = Camera
    $icon_info[2][5] = False; = Phone
    $icon_info[3][5] = False; = MS Live
    $icon_info[4][5] = False; = Gear
    $icon_info[5][5] = False; = Search
    $icon_info[6][5] = False; = Sound
    $icon_info[7][5] = False;= MSN
    $icon_info[8][5] = False; = HDD
    $icon_info[9][5] = False; = PDA
    
    ;icon start/end coordinate x:
    Local $x_x = 0
    for $i = 0 to 9
        $x_x += 25
        $icon_info[$i][3] = $x_x ; = start X coordinate
        $x_x += 32
        $icon_info[$i][4] = $x_x ; = end X coordinate
    Next
EndFunc

func endscript() ;clearing resources @ the and of the script
    _GDIPlus_GraphicsDispose($hGraphic)
    for $i = 0 to 9
        _GDIPlus_ImageDispose($icons[$i])
        FileDelete(@ScriptDir & "\test_image" & $i & ".bmp")
    Next
    _GDIPlus_Shutdown()
EndFunc
