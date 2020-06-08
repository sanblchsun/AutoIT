#include <GUIConstants.au3>
#include <Misc.au3>
Global $timer_toolbar
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 500, 200)
$Edit1 = GUICtrlCreateEdit("", 0, 40, 500, 160)
;~ GUICtrlSetData(-1, "Edit1")
$line1 = GUICtrlCreateGraphic(5, 30, 490, 1, 0x08)
$icon1 = _create_toolbar_item("Shell32.dll", -(Random(1, 239)), 5, 5, 16, 16)
$icon2 = _create_toolbar_item("Shell32.dll", -(Random(1, 239)), 30, 5, 16, 16)
$icon3 = _create_toolbar_item("Shell32.dll", -(Random(1, 239)), 55, 5, 16, 16)
$icon4 = _create_toolbar_item("Shell32.dll", -(Random(1, 239)), 80, 5, 16, 16)
$icon5 = _create_toolbar_item("Shell32.dll", -(Random(1, 239)), 105, 5, 16, 16)
$icon6 = _create_toolbar_item("Shell32.dll", -(Random(1, 239)), 130, 5, 16, 16)
$icon7 = _create_toolbar_item("Shell32.dll", -(Random(1, 239)), 155, 5, 16, 16)
$icon8 = _create_toolbar_item("Shell32.dll", -(Random(1, 239)), 180, 5, 16, 16)
$icon9 = _create_toolbar_item("Shell32.dll", -(Random(1, 239)), 205, 5, 16, 16)
$icon10 = _create_toolbar_item("Shell32.dll", -(Random(1, 239)), 230, 5, 16, 16)
$icon11 = _create_toolbar_item("Shell32.dll", -(Random(1, 239)), 255, 5, 16, 16)
$icon12 = _create_toolbar_item("Shell32.dll", -(Random(1, 239)), 280, 5, 16, 16)

GUISetState(@SW_SHOW, $Form1)
$form2 = guicreate("", 23, 23, 1+50, 1, 0x80000000, BitOR(0x00080000 , 0x00000040), $Form1)
GUICtrlCreatePic(@ScriptDir & "\square.gif", 0, 0, 0, 0)
GUISetState(@SW_HIDE, $Form2)
#EndRegion ### END Koda GUI section ###

While 1
    if TimerDiff($timer_toolbar) >= 500 Then
        GUISetState(@SW_HIDE, $Form2)
    EndIf
    Local $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
    Local $c = GUIGetCursorInfo($Form1)
    Switch $c[4]
        case $icon1[0]
            _dont_edit_this_function($icon1, "function_name")
        case $icon2[0]
            _dont_edit_this_function($icon2, "function_name")
        case $icon3[0]
            _dont_edit_this_function($icon3, "function_name")
        case $icon4[0]
            _dont_edit_this_function($icon4, "function_name")
        case $icon5[0]
            _dont_edit_this_function($icon5, "function_name")
        case $icon6[0]
            _dont_edit_this_function($icon6, "function_name")
        case $icon7[0]
            _dont_edit_this_function($icon7, "function_name")
        case $icon8[0]
            _dont_edit_this_function($icon8, "function_name")
        case $icon9[0]
            _dont_edit_this_function($icon9, "function_name")
        case $icon10[0]
            _dont_edit_this_function($icon10, "function_name")
        case $icon11[0]
            _dont_edit_this_function($icon11, "function_name")
        case $icon12[0]
            _dont_edit_this_function($icon12, "function_name")
    EndSwitch
WEnd

func function_name()
    MsgBox(0, "ok", "ok")
EndFunc

;----------- odavde pa na dole ne treba nista dirati -----------------------
func _dont_edit_this_function($Control_handle, $function_name)
    Local $get_control_position = ControlGetPos($Form1, "", $Control_handle[0])
    Local $get_window_position = WinGetPos($form1)
    Local $get_client_size = WinGetClientSize($Form1)
    Local $mali_border = ($get_window_position[2]-$get_client_size[0])/2
    Local $veliki_border = $get_window_position[3]-$get_client_size[1]-$mali_border
    Local $x_koordinata = $get_window_position[0]+$mali_border+$get_control_position[0]-4
    Local $y_koordinata = $get_window_position[1]+$veliki_border+1
    GUICtrlSetState( $Control_handle[1], $GUI_SHOW)
    GUICtrlSetState( $Control_handle[0], $GUI_HIDE)
;~  WinMove($form2, "", $x_koordinata, $y_koordinata)
    if WinGetState($form2) > 5 Then
        Local $box_position = WinGetPos($Form2)
        if $box_position[0] > $x_koordinata then
            for $i = $box_position[0] to $x_koordinata+20 Step -15
                WinMove($form2, "", $i, $y_koordinata)
                Sleep(1)
            Next
            for $i = $x_koordinata+20 to $x_koordinata+8 Step -5
                WinMove($form2, "", $i, $y_koordinata)
                Sleep(1)
            Next
            for $i = $x_koordinata+8 to $x_koordinata Step -1
                WinMove($form2, "", $i, $y_koordinata)
                Sleep(1)
            Next
            ;WinMove($form2, "", $x_koordinata, $y_koordinata)
        ElseIf $box_position[0] < $x_koordinata Then
            for $i = $box_position[0] to $x_koordinata-20 Step 15
                WinMove($form2, "", $i, $y_koordinata)
                Sleep(1)
            Next
            for $i = $x_koordinata-20 to $x_koordinata-8 Step 5
                WinMove($form2, "", $i, $y_koordinata)
                Sleep(1)
            Next
            for $i = $x_koordinata-8 to $x_koordinata Step 1
                WinMove($form2, "", $i, $y_koordinata)
                Sleep(1)
            Next
            ;WinMove($form2, "", $x_koordinata, $y_koordinata)
        EndIf
;~      WinMove($form2, "", $x_koordinata, $y_koordinata)
    Else
        WinMove($form2, "", $x_koordinata, $y_koordinata)
        GUISetState(@SW_SHOWNOACTIVATE, $Form2)
    EndIf
    Local $a = GUIGetCursorInfo($Form1)
        While $a[4] = $Control_handle[1]
            if GUIGetMsg() = $Control_handle[1] then
                if _IsPressed(01) Then
                Do
                Until NOT _IsPressed(01)
                Call($function_name)
                EndIf
            EndIf
            $a = GUIGetCursorInfo($Form1)
        WEnd
        $timer_toolbar = TimerInit()
    GUICtrlSetState( $Control_handle[1], $GUI_HIDE)
    GUICtrlSetState( $Control_handle[0], $GUI_SHOW)
;~  GUISetState(@SW_HIDE, $Form2)
EndFunc

func _create_toolbar_item($location, $icon_name, $x_coordinate, $y_coordinate, $toolbar_item_width, $toolbar_item_height)
    Local $toolbar_item_local[2]
    $toolbar_item_local[0] = GUICtrlCreateIcon($location, $icon_name, $x_coordinate, $y_coordinate, $toolbar_item_width, $toolbar_item_height)
        GUICtrlSetState(-1, $GUI_DISABLE)
    $toolbar_item_local[1] = GUICtrlCreateIcon($location, $icon_name, $x_coordinate, $y_coordinate, $toolbar_item_width, $toolbar_item_height)
        GUICtrlSetState(-1,$GUI_HIDE)
    Return $toolbar_item_local
EndFunc
