
; http://www.autoitscript.com/forum/index.php?showtopic=24154&view=findpost&p=168674
#include <GUIConstants.au3>
#include <WindowsConstants.au3>
HotKeySet("{ESC}", "_Quit")

$MagWidth = InputBox ("Magnify Area", "What should the WIDTH of the magnified area be?")
$MagHeight = InputBox ("Magnify Area", "What should the HEIGHT of the magnified area be?")
$MagZoom = InputBox ("Magnify Area", "What should the ZOOM of the magnified area be?", 2)

; Global $SRCCOPY = 0x00CC0020
Global $dll[3], $DeskHDC, $GUIHDC

$dll[1] = DllOpen ( "user32.dll")
$dll[2] = DllOpen ( "gdi32.dll")

Global $GUI = GUICreate ("Zoom x2 Au3", $MagWidth * $MagZoom, $MagHeight * $MagZoom, _ 
    MouseGetPos (0), MouseGetPos (1), $WS_POPUP+$WS_BORDER, $WS_EX_TOPMOST)

GUISetState(@SW_SHOW)

Global $LastPos[2] = [0,0]

While 1
    MAG()
    $MousePos = MouseGetPos()
    If ($LastPos[0] <> $MousePos[0] Or $LastPos[1] <> $MousePos[1]) Then
        WinMove("Zoom x2 Au3", "", $MousePos[0] + $MagWidth/2 + 5, $MousePos[1])
        $LastPos[0] = $MousePos[0]
        $LastPos[1] = $MousePos[1]
    EndIf
    
    Sleep(10)
WEnd

Func MAG()
    $DeskHDC = DLLCall("user32.dll","int","GetDC","hwnd",0)
    $GUIHDC = DLLCall("user32.dll","int","GetDC","hwnd",$GUI)
    If Not @error Then
        DLLCall("gdi32.dll", "int", "StretchBlt", "int", $GUIHDC[0], "int", _
            0, "int", 0, "int", $MagWidth * $MagZoom, "int", $MagHeight * $MagZoom, "int", $DeskHDC[0], "int", _
            MouseGetPos (0) - $MagWidth/2, "int", MouseGetPos (1) - $MagHeight/2, "int", $MagWidth ,"int", $MagHeight, _
            "long", $SRCCOPY)
        DLLCall("user32.dll","int","ReleaseDC","int",$DeskHDC[0],"hwnd",0)
        DLLCall("user32.dll","int","ReleaseDC","int",$GUIHDC[0],"hwnd",$GUI)
    EndIf
EndFunc

Func _Quit()
    DllClose ( $dll[1] )
    DllClose ( $dll[2] )
	Exit
EndFunc