#include <GUIConstants.au3>
#include <Constants.au3>
#include <WindowsConstants.au3>
#include <WINAPI.au3>

$gui = GUICreate("trans", 300, 230, -1, -1, -1, $WS_EX_LAYERED)
_WinAPI_SetLayeredWindowAttributes($gui, 0x010101)
$lg=GUICtrlCreateLabel("За этот текст можно тащить GUI", 0, 0, 200, 17, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetBkColor(-1, 0xACCDEF)
GUICtrlSetState(-1, 32) ;скрыть 32
$checkTrans = GUICtrlCreateCheckbox("Цвет прозрачности 0xABCDEF или 0x010101", 10, 30, 280, 17)
GUICtrlSetBkColor(-1, 0xACCDEF)
$checkBorder = GUICtrlCreateCheckbox("POPUP-стиль", 10, 50)
$x= GUICtrlCreateButton("x", 280, 2, 18, 20)
GUICtrlSetState(-1, 32)

$layButt = GUICtrlCreateButton("Сообщение", 110, 80, 80)
GUISetBkColor(0xABCDEF)

GUICtrlCreateLabel("Прозрачность GUI", 10, 150)
$slidTrans = GUICtrlCreateSlider(10, 170, 200, 30)
GUICtrlSetBkColor(-1, 0xABCDEF)
GUICtrlSetLimit($slidTrans, 255, 0)
GUICtrlSetData(-1, 255)

GUISetState()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = -3 Or $msg =  $x
			Exit

		Case $msg = $layButt
			Dim $transcolor, $alpha
			$info = _WinAPI_GetLayeredWindowAttributes($gui, $transcolor, $alpha)
			MsgBox(0, 'Многослойный GUI', "Информация об окне"& @CRLF & _
					"Цвет прозрачности: " & $transcolor & @CRLF & _
					"Глубина прозрачности: " & $alpha & @CRLF & _
					"LWA_COLORKEY: " & (BitAND($info, $LWA_COLORKEY) = $LWA_COLORKEY) & @CRLF & _
					"LWA_ALPHA: " & (BitAND($info, $LWA_ALPHA) = $LWA_ALPHA))

		Case $msg = $checkTrans Or $msg = $slidTrans
			If BitAND(GUICtrlRead($checkTrans), $GUI_CHECKED) = $GUI_CHECKED Then
				_WinAPI_SetLayeredWindowAttributes($gui, 0xABCDEF, GUICtrlRead($slidTrans))
			Else
				_WinAPI_SetLayeredWindowAttributes($gui, 0x010101, GUICtrlRead($slidTrans))
			EndIf

		Case $msg = $checkBorder
			If BitAND(GUICtrlRead($checkBorder), $GUI_CHECKED) = $GUI_CHECKED Then
				GUISetStyle($WS_POPUP, -1, $gui)
				GUICtrlSetState($x, 16)
				GUICtrlSetState($lg, 16)
			Else
				GUISetStyle($GUI_SS_DEFAULT_GUI, -1, $gui)
				GUICtrlSetState($x, 32)
				GUICtrlSetState($lg, 32)
			EndIf
	EndSelect
WEnd