#NoTrayIcon
#include <GUIConstants.au3>
#include <WindowsConstants.au3>
;

Opt("GUIOnEventMode", 1)

Dim $s_TempFile
$bmp = _TempFile()

FileInstall("gui.bmp", $bmp)

; Caption
$caption = "Program name..."
; Caption

$gui = GUICreate("Main GUI", 230, 110, -1, -1, $WS_POPUP + $WS_SYSMENU + $WS_MINIMIZEBOX, $WS_EX_LAYERED)
GUISetOnEvent($GUI_EVENT_CLOSE, "Close")

$caption = GUICtrlCreateLabel($caption, 12, 4, 180, 14)
GUICtrlSetStyle($caption, -1, $WS_EX_TRANSPARENT) ; To show $caption text
GUICtrlSetStyle($caption, $DS_SETFOREGROUND)
GUICtrlSetFont($caption, 9, 400, -1, "Arial Bold")
GUICtrlSetColor($caption, 0xF5F5F5)
GUICtrlSetBkColor($caption, 0xFF00FF) ; To select $caption
GUICtrlSetOnEvent($caption, "_Drag")

$min = GUICtrlCreateLabel("", 198, 4, 11, 11)
GUICtrlSetOnEvent($min, "Minimize")
GUICtrlSetTip($min, "Minimize")

;GUICtrlSetStyle($min, -1, $WS_EX_TRANSPARENT) ; To select $min
;GUICtrlSetBkColor($min,0xFF00FF) ; To select $min

$close = GUICtrlCreateLabel("", 210, 4, 11, 11)
GUICtrlSetOnEvent($close, "Close")
GUICtrlSetTip($close, "Close")

;GUICtrlSetStyle($close, -1, $WS_EX_TRANSPARENT) ; To select $close
;GUICtrlSetBkColor($close,0xFF00FF) ; To select $close

$btn = GUICtrlCreateButton("Button", 90, 80, 50, 20)
GUICtrlSetStyle($btn, -1, $WS_EX_TRANSPARENT)
GUICtrlSetOnEvent($btn, "Btn")

$pic = GUICtrlCreatePic($bmp, 0, 0, 230, 110)
GUICtrlSetOnEvent($pic, "_Drag")

$contextmenu = GUICtrlCreateContextMenu($pic)

$min_item = GUICtrlCreateMenuItem("Min", $contextmenu)
GUICtrlSetOnEvent($min_item, "Minimize")

$close_item = GUICtrlCreateMenuItem("Close", $contextmenu)
GUICtrlSetOnEvent($close_item, "Close")

GUICtrlCreateMenuItem("", $contextmenu) ; separator

$about_item = GUICtrlCreateMenuItem("About", $contextmenu)
GUICtrlSetOnEvent($about_item, "About")

GUISetState(@SW_SHOW)

While 1
	Sleep(1000)
WEnd

Func Btn()
	GUISetState(@SW_HIDE)
	SplashTextOn("btn", "Button clicked", 130, 19, -1, -1, 1, "", 12)
	Sleep(100)
	SplashOff()
	GUISetState(@SW_SHOW)
EndFunc

Func About()
	GUISetState(@SW_HIDE)
	SplashTextOn("btn", "Button clicked", 130, 19, -1, -1, 1, "", 12)
	Sleep(100)
	SplashOff()
	GUISetState(@SW_SHOW)
EndFunc

Func Close()
	GUISetState(@SW_HIDE)
	FileDelete($bmp)
	Exit
EndFunc

Func Minimize()
	GUISetState(@SW_MINIMIZE)
EndFunc

Func _TempFile()
	Local $s_TempName
	
	Do
		$s_TempName = "~"
		While StringLen($s_TempName) < 7
			$s_TempName = $s_TempName & Chr(Round(Random(65, 90), 0))
		WEnd
		$s_TempName = @TempDir & "\" & $s_TempName & ".tmp"
	Until Not FileExists($s_TempName)
	Return ($s_TempName)
EndFunc

Func _Drag()
	DllCall("user32.dll", "int", "ReleaseCapture")
	DllCall("user32.dll", "int", "SendMessage", "hWnd", $gui, "int", 0xA1, "int", 2, "int", 0)
EndFunc