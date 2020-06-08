; funkey
; http://www.autoitscript.com/forum/topic/132709-guictrlsetfont-rotating-control-texts/
#region _GuiCtrlSetFont.au3
;Copyrights to funkey !!

#include <WinAPI.au3>

OnAutoItExitRegister("_FontCleanUp")
Global $ahFontEx[1] = [0]

Func _GuiCtrlSetFont($controlID, $size, $weight = 400, $attribute = 0, $rotation = 0, $fontname = "", $quality = 2)
	Local $fdwItalic = BitAND($attribute, 1)
	Local $fdwUnderline = BitAND($attribute, 2)
	Local $fdwStrikeOut = BitAND($attribute, 4)

	ReDim $ahFontEx[UBound($ahFontEx) + 1]
	$ahFontEx[0] += 1

	$ahFontEx[$ahFontEx[0]] = _WinAPI_CreateFont($size, 0, $rotation * 10, $rotation, $weight, _
			$fdwItalic, $fdwUnderline, $fdwStrikeOut, -1, 0, 0, $quality, 0, $fontname)

	GUICtrlSendMsg($controlID, 48, $ahFontEx[$ahFontEx[0]], 1)
EndFunc   ;==>_GuiCtrlSetFont

Func _FontCleanUp()
	For $i = 1 To $ahFontEx[0]
		_WinAPI_DeleteObject($ahFontEx[$i])
	Next
EndFunc   ;==>_FontCleanUp
#endregion _GuiCtrlSetFont.au3

Global $hGui1 = GUICreate("_GuiCtrlSetFont example", 300, 340, 100, 100, -1, 0);

For $i = 0 To 350 Step 30
	GUICtrlCreateLabel("This is rotating", 50, 0, 300, 220, 0x201)
	GUICtrlSetColor(-1, Random(0, 0xffffff, 1))
	_GuiCtrlSetFont(-1, 15, 1000, 1, $i)
	GUICtrlSetBkColor(-1, -2)
Next

GUICtrlCreateLabel("This is a vertical label", 10, 30, 200, 200, 0x001)
GUICtrlSetColor(-1, Random(0, 0xffffff, 1))
_GuiCtrlSetFont(-1, 15, 400, 1, -90)
GUICtrlSetBkColor(-1, -2)
GUICtrlCreateLabel("This too!!", 130, 50, 200, 200, 0x202)
GUICtrlSetColor(-1, Random(0, 0xffffff, 1))
_GuiCtrlSetFont(-1, 15, 400, 1, 90)
GUICtrlSetBkColor(-1, -2)

GUICtrlCreateButton("This is a cool button text", 10, 220, 275, 60, 0x0800);
_GuiCtrlSetFont(-1, 20, 1000, 1, 8)

GUICtrlCreateCombo("Hello", 10, 290, 275, 80, 0x3, -1);
GUICtrlSetColor(-1, Random(0, 0xffffff, 1))
_GuiCtrlSetFont(-1, 15, 1000, 1, -3)
GUICtrlSetData(-1, "Item2|Item3")

GUISetState(@SW_SHOW, $hGui1);

Do
Until GUIGetMsg() = -3