#cs
    Name ........: Colour Under Mouse
    Author ......: James Brooks aka Secure_ICT
    Description .: Shows colours under the mouse
    Link ........: www.autoitscript.com/forum/index.php?showtopic=47733&hl=color+under+mouse
    Modified ....: Jaberwocky6669
#ce

#AutoIt3Wrapper_Au3Check_Parameters=-w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7 -d

#include <Misc.au3>
_Singleton(@ScriptName)

HotKeySet("{F2}", "hex_to_clip")
HotKeySet("{F3}", "rgb_to_clip")
HotKeySet("{F4}", "paused")
HotKeySet("{ESC}", "terminate")

Global $paused = False

Global Const $DW = (@DesktopWidth / 2) * 1.7
Global Const $DH = (@DesktopHeight / 4) * 3.5

Global Const $GUI = GUICreate('', 180, 50, $DW, $DH, 0x80000000, 0x0080)
WinSetOnTop($GUI, '', 1)

Global Const $color_label = GUICtrlCreateLabel('', 117, 5, 50, 40)

GUICtrlCreateLabel("Hex (F2): #", 5, 5, 56, 15)
Global Const $hex_label = GUICtrlCreateLabel('', 62, 5, 55, 15)

GUICtrlCreateLabel("RGB (F3): ", 5, 30, 56, 15)
Global Const $rgb_label = GUICtrlCreateLabel('', 54, 30, 63, 15)

GUISetState(@SW_SHOWNORMAL)

Global $color = ''
Global $last_color = ''
Global $hex_color

While True
    If Not $paused Then
        $color = PixelGetColor(MouseGetPos(0), MouseGetPos(1))

        If $color <> $last_color Then
            $last_color = $color
            GUICtrlSetBkColor($color_label, $color)
            $hex_color = Hex($color, 6)
            GUICtrlSetData($hex_label, $hex_color)
            GUICtrlSetData($rgb_label, hex_to_dec())
        EndIf
    EndIf

    Sleep(8)
WEnd

; --------------------------------------------------------------------------------------------------

Func paused()
    $paused = Not $paused
EndFunc

; --------------------------------------------------------------------------------------------------

Func hex_to_clip()
    ClipPut(Hex($color, 6))
EndFunc

; --------------------------------------------------------------------------------------------------

Func hex_to_dec()
    Local Const $red = Dec(StringLeft($hex_color, 2))
    Local Const $green = Dec(StringMid($hex_color, 3, 2))
    Local Const $blue = Dec(StringRight($hex_color, 2))
    Return $red & ' ' & $green & ' ' & $blue
EndFunc

; --------------------------------------------------------------------------------------------------

Func rgb_to_clip()
    ClipPut(hex_to_dec())
EndFunc

; --------------------------------------------------------------------------------------------------

Func terminate()
    GUICtrlDelete($color_label)
    GUICtrlDelete($hex_label)
    GUICtrlDelete($rgb_label)
    GUIDelete($GUI)
    Exit
EndFunc

; --------------------------------------------------------------------------------------------------