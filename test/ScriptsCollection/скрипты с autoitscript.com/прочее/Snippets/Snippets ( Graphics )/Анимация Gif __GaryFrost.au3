; Animated Gif

Opt("MustDeclareVars", 1)
#include <IE.au3>

_Main()

Func _Main()
	Local $pheight = 50, $pwidth = 50, $oIE, $GUIActiveX, $gif
	$gif = FileOpenDialog("Select Animated Gif", @ScriptDir, "gif files (*.gif)", 3)
	If @error Then Exit
	_GetGifPixWidth_Height($gif, $pwidth, $pheight)
	$oIE = ObjCreate("Shell.Explorer.2")
	GUICreate("Embedded Web control Test", 640, 580)
	$GUIActiveX = GUICtrlCreateObj($oIE, 0, 0, $pwidth, $pheight)
	$oIE.navigate("about:blank")
	While _IEPropertyGet($oIE, "busy")
		Sleep(100)
	WEnd
	$oIE.document.body.background = $gif
	$oIE.document.body.scroll = "no"
	GUISetState()
	While GUIGetMsg() <> -3
	WEnd
EndFunc

Func _GetGifPixWidth_Height($s_gif, ByRef $pwidth, ByRef $pheight)
	If FileGetSize($s_gif) > 9 Then
		Local $sizes = FileRead($s_gif, 10)
		ConsoleWrite("Gif version: " & StringMid($sizes, 1, 6) & @LF)
		$pwidth = Asc(StringMid($sizes, 8, 1)) * 256 + Asc(StringMid($sizes, 7, 1))
		$pheight = Asc(StringMid($sizes, 10, 1)) * 256 + Asc(StringMid($sizes, 9, 1))
		ConsoleWrite($pwidth & " x " & $pheight & @LF)
	EndIf
EndFunc