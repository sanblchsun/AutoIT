AdlibRegister("TitleChanger", 200)
$title = "***My Long Long Title to be changed***"
$hGUI = GUICreate($title, 600, 200)
GUISetState()

Do
    $msg = GUIGetMsg()
Until $msg = -3

Func TitleChanger()
    $title = WinGetTitle($hGUI)
    $newtitle = StringMid($title, 2) & StringLeft($title, 1)
    WinSetTitle($title, "", $newtitle)
EndFunc
 