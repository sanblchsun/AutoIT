; sample volume meter display
;
; author nobbe 2009

#include <GUIConstantsEx.au3>
#include <GUIConstants.au3>

Global $vol_left[51], $vol_right[51];

;Create GUI and controls
$GUI = GUICreate("Sample", 180, 190, 193, 115);
$btn_start = GUICtrlCreateButton("Start", 76, 160, 75, 25, 0)

;Show GUI
GUISetState(@SW_SHOW)

_setup_volume()

;; loop

While 1

    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $btn_start
        ; up
        for $i = 1 to 100
			If GUIGetMsg()=-3 Then Exit
            _show_volume($i, $i); left , right
            sleep(50)
        next

        ; down
        for $i = 100 to 1 step -1
			If GUIGetMsg()=-3 Then Exit
            _show_volume($i, $i); left , right
            sleep(50)
        next

        ; random
        for $i = 1 to 100
			If GUIGetMsg()=-3 Then Exit
            $l = int(Random(1,100))
            $r = int(Random(1,100))
            _show_volume($l, $r); left , right
            sleep(100)
        next

        Case -3
			Exit
    EndSwitch
    Sleep(20)
WEnd

;
; setup a bunch of controls as array to display the volume
;
Func _setup_volume()
    Local $color_red = 0xff0000
    Local $color_grey = 0xcccccc

    $left = 10
    $top = 180
    $height = 3
    $width = 10

    For $m = 0 To 25
        $vol_left[$m] = GUICtrlCreateLabel("", $left, $top, $width, $height)
        GUICtrlSetBkColor($vol_left[$m], $color_grey)
        $top = $top - $height - 1 ;
    Next

    $left = $left + $width + 3
    $top = 180

    ;right slider
    For $m = 0 To 25
        $vol_right[$m] = GUICtrlCreateLabel("", $left, $top, $width, $height)
        GUICtrlSetBkColor($vol_right[$m], $color_grey)
        $top = $top - $height - 1 ;
    Next
EndFunc   ;==>_setup_volume

;
; set the volume "display" to ....
;
Func _show_volume($l, $r)
    Local $color_red = 0xff0000
    Local $color_grey = 0xcccccc

        For $m = 0 To 50
            If ($l / 4) >= $m Then

                GUICtrlSetBkColor($vol_left[$m], $color_red)
            Else
                GUICtrlSetBkColor($vol_left[$m], $color_grey)
            EndIf

            If ($r / 4) >= $m Then

                GUICtrlSetBkColor($vol_right[$m], $color_red)
            Else
                GUICtrlSetBkColor($vol_right[$m], $color_grey)
            EndIf
        Next
EndFunc   ;==>_show_volume