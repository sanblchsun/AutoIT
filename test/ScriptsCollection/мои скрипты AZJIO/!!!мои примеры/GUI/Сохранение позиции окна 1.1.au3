; 1. в свёрнутом состоянии позиция является отрицательным числом, и если закрыть с панели задач, то утилита будет иметь координаты за экраном и второй раз утилиту не удастся увидеть.
; 2. Чтобы сохранить координаты перед сворачиванием используем WM-сообщение (WM_SYSCOMMAND) срабатывающее при клике на заголовке, т.е. во время попытки перемещения окна и при сворачивании.
; 3. При старте проверяем валидность параметров
;			а) при переносе на флешке и запуске на компьютере с меньшим разрешением экрана монитора. Утилита не должна оказаться за экраном.
;			б) Если пользователь "поиграл" с параметрами, т.е. ввручную их менял. Параметры не должны быть менее -1 (проверку на менее -1), замена на текст устанавливает в 0 (валидно), отсутствие разделителя заставит утилиту "вылететь" с ошибкой (проверяем наличие разделителя |).

; Основной смысл есть, остальное по обстоятельствам. Можно также сохранить размеры окна. При использовании WM_SYSCOMMAND не обязательно постоянно писать координаты в реестр или ini, можно просто обновлять переменные, которые при выходе будут сохранены.

#include <GUIConstantsEx.au3>
#include <WinAPI.au3>

Global $WHXY[4], $Ini = @ScriptDir & '\Setting.ini'
$WHXY[0] = 400
$WHXY[1] = 300
$WHXY[2] = IniRead($Ini, 'Setting', 'X', '')
$WHXY[3] = IniRead($Ini, 'Setting', 'Y', '')
_SetCoor($WHXY)

$hGui = GUICreate("Сохранение позиции окна", $WHXY[0], $WHXY[1], $WHXY[2], $WHXY[3])

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			_SavePos()
			Exit
	EndSwitch
WEnd

Func _SavePos()
	$tRect = DllStructCreate($tagRECT)
	$tRect = _WinAPI_GetWindowRect($hGui)
	$x = DllStructGetData($tRect, "Left")
	$y = DllStructGetData($tRect, "Top")
	If $x > -2 And $x < @DesktopWidth Then IniWrite($Ini, 'Setting', 'X', $x)
	If $y > -2 And $y < @DesktopHeight Then IniWrite($Ini, 'Setting', 'Y', $y)
EndFunc   ;==>_Pos

; валидность координат проверяем при запуске
Func _SetCoor(ByRef $WHXY, $d = 0)
	; _ArrayDisplay($WHXY, 'Размер')
	Local $Xtmp, $Ytmp, $aWA
	$Frm = _WinAPI_GetSystemMetrics(32) * 2
	$CpT = _WinAPI_GetSystemMetrics(4) + _WinAPI_GetSystemMetrics(33) * 2
	$WHXY[0] = $WHXY[0] + $Frm
	$WHXY[1] = $WHXY[1] + $CpT - $d
	$aWA = _WinAPI_GetWorkingArea()
	ReDim $aWA[6]
	$aWA[4] = $aWA[2] - $aWA[0] ; ширина
	$aWA[5] = $aWA[3] - $aWA[1] ; высота
	; $sLeftArea, $sTopArea, $sRightArea, $sBottomArea
	$Xtmp = Number($WHXY[2])
	$Ytmp = Number($WHXY[3])
	If $Xtmp < 0 And $Xtmp <> -1 Then $Xtmp = 0
	If $WHXY[0] >= $aWA[4] Then
		$WHXY[0] = $aWA[4]
		$Xtmp = 0
	EndIf
	If $Xtmp > $aWA[4] - $WHXY[0] Then $Xtmp = $aWA[4] - $WHXY[0]
	If $WHXY[2] = '' Then $Xtmp = -1
	
	If $Ytmp < 0 And $Ytmp <> -1 Then $Ytmp = 0
	If $WHXY[1] >= $aWA[5] Then
		$WHXY[1] = $aWA[5]
		$Ytmp = 0
	EndIf
	If $Ytmp > $aWA[5] - $WHXY[1] Then $Ytmp = $aWA[5] - $WHXY[1] ; проблема поправки на заголовок
	If $WHXY[3] = '' Then $Ytmp = -1
	$WHXY[0] = $WHXY[0] - $Frm
	$WHXY[1] = $WHXY[1] - $CpT + $d
	$WHXY[2] = $Xtmp + $aWA[0]
	$WHXY[3] = $Ytmp + $aWA[1]
	; _ArrayDisplay($WHXY, 'Размер')
EndFunc   ;==>_SetCoor

Func _WinAPI_GetWorkingArea()
	Local Const $SPI_GETWORKAREA = 48
	Local $stRECT = DllStructCreate("long; long; long; long")

	Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
	If @error Then Return 0
	If $SPIRet[0] = 0 Then Return 0

	Local $sLeftArea = DllStructGetData($stRECT, 1)
	Local $sTopArea = DllStructGetData($stRECT, 2)
	Local $sRightArea = DllStructGetData($stRECT, 3)
	Local $sBottomArea = DllStructGetData($stRECT, 4)

	Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
	Return $aRet
EndFunc   ;==>_WinAPI_GetWorkingArea