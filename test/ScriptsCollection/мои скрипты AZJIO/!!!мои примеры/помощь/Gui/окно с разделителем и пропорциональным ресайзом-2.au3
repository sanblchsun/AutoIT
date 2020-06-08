
;
; http://autoit-script.ru/index.php?topic=4531.msg32800#msg32800

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIRichEdit.au3>
#include <IE.au3>
OnAutoItExitRegister("Error")
Global $iWidth = 500, $iHeight = 130

$hForm = GUICreate('Test', $iWidth, $iHeight + 20, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_THICKFRAME, $WS_OVERLAPPEDWINDOW, $WS_TILEDWINDOW, $WS_TABSTOP), $WS_EX_COMPOSITED)
$hR_Edit1 = _GUICtrlRichEdit_Create($hForm, 'Edit1', 10, 10, 290, 130)
; $hR_Edit2 = _GUICtrlRichEdit_Create($hForm, 'Edit2', 310, 10, 180, 130)

$oIE1 = _IECreateEmbedded()
$hR_Edit2 = GUICtrlCreateObj($oIE1, 304, 10, 180, 130)
;GUICtrlSetResizing(-1, 4)
_IENavigate($oIE1, "C:\WINDOWS\Web\Wallpaper\Wallpaper.jpg")

$Label = GUICtrlCreateLabel('', 300, 10, 4, 130)
; GUICtrlSetBkColor(-1, 0xffd7d7)
GUICtrlSetCursor(-1, 13)
$dd = 300 / $iWidth

GUISetState()
GUIRegisterMsg($WM_SIZE, "WM_SIZE")

While 1
	$nMsg = GUIGetMsg()

	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			GUIDelete()
			Exit
		Case -7
			$aCur_Info = GUIGetCursorInfo($hForm)
			If $aCur_Info[4] = $Label Then
				$aID_Pos = ControlGetPos($hForm, '', $Label)
				; высчитываем разницу координат
				$dX = $aID_Pos[0] - $aCur_Info[0]
				$tmp = 0
				While 1
					Sleep(10)
					$aCur_Info = GUIGetCursorInfo($hForm) ; получаем новую инфу
					$aCur_Info[0] += $dX

					If Not ($aCur_Info[0] - 10 < 40 Or $iWidth - $aCur_Info[0] - 20 < 40 Or $tmp = $aCur_Info[0]) Then
						GUICtrlSetPos($Label, $aCur_Info[0], 10) ; устанавливаем новые координаты
						_WinAPI_MoveWindow($hR_Edit1, 10, 10, $aCur_Info[0] - 10, $iHeight)
						; _WinAPI_MoveWindow($hR_Edit2, $aCur_Info[0]+10, 10, $iWidth-$aCur_Info[0]-20, $iHeight)
						GUICtrlSetPos($hR_Edit2, $aCur_Info[0] + 4, 10, $iWidth - $aCur_Info[0] - 20, $iHeight)
						$tmp = $aCur_Info[0]
					EndIf
					If Not $aCur_Info[2] Then ExitLoop ; выход если курсор отпущен
				WEnd
				$dd = $aCur_Info[0] / $iWidth
			EndIf
	EndSwitch
WEnd

Func WM_SIZE($hWnd, $Msg, $wParam, $lParam)
	$iWidth = _WinAPI_LoWord($lParam)
	$iHeight = _WinAPI_HiWord($lParam) - 20
	Local $w = Int($iWidth * $dd)
	_WinAPI_MoveWindow($hR_Edit1, 10, 10, $w - 10, $iHeight)
	; _WinAPI_MoveWindow($hR_Edit2, $w+10, 10, $iWidth-$w-20, $iHeight)
	GUICtrlSetPos($hR_Edit2, $w + 4, 10, $iWidth - $w - 20, $iHeight)
	GUICtrlSetPos($Label, $w + 2, 10, 10, $iHeight - 20)
	Return 0
EndFunc

Func Error()
	GUIDelete()
EndFunc