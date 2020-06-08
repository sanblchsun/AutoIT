; Смотрите _GUICtrlMenu_SetMenuInfo

; funkey
; http://www.autoitscript.com/forum/topic/149279-color-menu/
Opt('GUIOnEventMode', 1)

Global $hGui = GUICreate("Mein eigenes Menu", 270, 140, -1, -1);, 0x80000000)
GUISetOnEvent(-3, '_Exit')
GUISetBkColor(0x00ffff)
GUICtrlCreateLabel('Das Menu befindet sich unterhalb ;)', 50, 15)

GUICtrlCreateLabel('', 0, 48, 270, 2, 0x1000)

$MenueDatei = GUICtrlCreateLabel('&Datei', 95, 50, 40, 19, 0x201)
GUICtrlSetOnEvent(-1, '_MenuPressed')

$DateiContext = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
SetMenuColor(-1, 0xffff00)
$OptionsOpen = GUICtrlCreateMenuItem("O&ffnen", $DateiContext)
$OptionsClose = GUICtrlCreateMenuItem("S&chlie?en", $DateiContext)
GUICtrlCreateMenuItem("", $DateiContext)
$OptionsExit = GUICtrlCreateMenuItem("B&eenden", $DateiContext)
GUICtrlSetOnEvent(-1, '_Exit')

$MenueHelp = GUICtrlCreateLabel("&Hilfe", 135, 50, 30, 19, 0x201)
GUICtrlSetOnEvent(-1, '_MenuPressed')
$HelpContext = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
SetMenuColor(-1, 0xffff00)
$HelpWWW = GUICtrlCreateMenuItem("&Website", $HelpContext)
GUICtrlSetOnEvent(-1, '_Website')
GUICtrlCreateMenuItem("", $HelpContext)
$HelpAbout = GUICtrlCreateMenuItem("U&ber...", $HelpContext)
GUICtrlSetOnEvent(-1, '_About')

GUICtrlCreateLabel('', 0, 70, 270, 2, 0x1000)

GUISetState()

;~ ToolTip($DateiContext & @CR & $HelpContext)

Global $AccelKeys[2][2]=[["!d", $MenueDatei], ["!h", $MenueHelp]]
GUISetAccelerators($AccelKeys)

While 1
    Sleep(10000)
WEnd

Func _Exit()
    Exit
EndFunc

Func _MenuPressed()
    Switch @GUI_CtrlId
        Case $MenueDatei
            ShowMenu($hGui, $MenueDatei, $DateiContext)
        Case $MenueHelp
            ShowMenu($hGui, $MenueHelp, $HelpContext)
    EndSwitch
EndFunc

Func _About()
    MsgBox(64, "About...", "Beispiel fur ein eigenes Menu")
EndFunc

Func _Website()
    MsgBox(64, "Website...", "www.autoit.de")
EndFunc

; Show a menu in a given GUI window which belongs to a given GUI ctrl
Func ShowMenu($hWnd, $CtrlID, $nContextID)
    Local $arPos, $x, $y
    Local $hMenu = GUICtrlGetHandle($nContextID)

    $arPos = ControlGetPos($hWnd, "", $CtrlID)

    $x = $arPos[0]
    $y = $arPos[1] + $arPos[3]

    ClientToScreen($hWnd, $x, $y)
    TrackPopupMenu($hWnd, $hMenu, $x, $y)
EndFunc   ;==>ShowMenu

; Convert the client (GUI) coordinates to screen (desktop) coordinates
Func ClientToScreen($hWnd, ByRef $x, ByRef $y)
    Local $stPoint = DllStructCreate("int;int")

    DllStructSetData($stPoint, 1, $x)
    DllStructSetData($stPoint, 2, $y)

    DllCall("user32.dll", "int", "ClientToScreen", "hwnd", $hWnd, "ptr", DllStructGetPtr($stPoint))

    $x = DllStructGetData($stPoint, 1)
    $y = DllStructGetData($stPoint, 2)
    ; release Struct not really needed as it is a local
    $stPoint = 0
EndFunc   ;==>ClientToScreen

; Show at the given coordinates (x, y) the popup menu (hMenu) which belongs to a given GUI window (hWnd)
Func TrackPopupMenu($hWnd, $hMenu, $x, $y)
    DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hWnd, "ptr", 0)
EndFunc   ;==>TrackPopupMenu

Func SetMenuColor($nMenuID, $nColor)
    Local $hMenu, $hBrush, $stMenuInfo
    Local Const $MIM_APPLYTOSUBMENUS = 0x80000000
    Local Const $MIM_BACKGROUND = 0x00000002

    $hMenu = GUICtrlGetHandle($nMenuID)

    $hBrush = DllCall("gdi32.dll", "hwnd", "CreateSolidBrush", "int", $nColor)
    $hBrush = $hBrush[0]

    $stMenuInfo = DllStructCreate("dword;dword;dword;uint;dword;dword;ptr")
    DllStructSetData($stMenuInfo, 1, DllStructGetSize($stMenuInfo))
    DllStructSetData($stMenuInfo, 2, BitOR($MIM_APPLYTOSUBMENUS, $MIM_BACKGROUND))
    DllStructSetData($stMenuInfo, 5, $hBrush)

    DllCall("user32.dll", "int", "SetMenuInfo", "hwnd", $hMenu, "ptr", DllStructGetPtr($stMenuInfo))

    ; release Struct not really needed as it is a local
    $stMenuInfo = 0
EndFunc   ;==>SetMenuColor