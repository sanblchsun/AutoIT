#include-once
#include <WinAPI.au3>

; UserGUI.au3

; =======================================
; Title .........: UserGUI
; AutoIt Version : 3.3.8.1
; Language ......: English + Русский
; Description ...: Operations with GUI
; =======================================

; #CURRENT# =============================
; _GetChildCoor
; _WinAPI_LoadKeyboardLayoutEx
; _SetCoor
; _WinAPI_GetWorkingArea
; =======================================

; Внутренние функции
; #INTERNAL_USE_ONLY#====================
; __Coor1
; __Coor2
; =======================================

; ============================================================================================
; Имя функции ...: _WinAPI_LoadKeyboardLayoutEx
; Описание ........: Устанавливает раскладку клавиатуры для указанного окна
; Синтаксис.......: _WinAPI_LoadKeyboardLayoutEx([$sLayoutID = 0x0409[, $hWnd = 0]])
; Параметры:
;		$sLayoutID - Код раскладки, по умолчанию 0x0409 (En)
;		$hWnd - Дескриптор окна, по умолчанию 0, что означает для окна AutoIt3
; Возвращаемое значение: Успешно - 1
;					Неудачно - 0, @error = 1
; Автор ..........: CreatoR
; Примечания ..:
; ============================================================================================
Func _WinAPI_LoadKeyboardLayoutEx($sLayoutID = 0x0409, $hWnd = 0)
	Local Const $WM_INPUTLANGCHANGEREQUEST = 0x50
	Local $aRet = DllCall("user32.dll", "long", "LoadKeyboardLayoutW", "wstr", Hex($sLayoutID, 8), "int", 0)

	If Not @error And $aRet[0] Then
		If $hWnd = 0 Then
			$hWnd = WinGetHandle(AutoItWinGetTitle())
		EndIf

		DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hWnd, "int", $WM_INPUTLANGCHANGEREQUEST, "int", 1, "int", $aRet[0])
		Return 1
	EndIf

	Return SetError(1)
EndFunc   ;==>_WinAPI_LoadKeyboardLayoutEx

; #FUNCTION# ;=================================================================================
; Function Name ...: _SetCoor
; Description ........: Corrects the coordinates to display the window in the working area of the screen
; Syntax................: _SetCoor(ByRef $aWHXY[, $iMinWidth = 0[, $iMinHeight = 0[, $iStyle = 2[, $iFixed = 0[, $iMargin = 0]]]]])
; Parameters:
;		$aWHXY - The array in the following format:
;                  [0] - Window width
;                  [1] - Window height
;                  [2] - X-coordinate of the window
;                  [3] - Y-coordinate of the window
;		$iMinWidth - Minimum width
;		$iMinHeight - Minimum height
;		$iStyle - Style window that determines the width of the border
;                  0 - No window borders, border width 0 pixel
;                  1 - The window with the style $WS_BORDER, usually the width of the border 1 pixel
;                  2 - The window is not resizable, usually the width of the border 3 pixels
;                  3 - With the ability to resize window ($WS_OVERLAPPEDWINDOW), usually the width of the border 4 pixels
;		$iFixed - Fix window coordinates when you place it right or bottom in the absence of style $WS_DLGFRAME or $WS_CAPTION
;		$iMargin - Offset from the edges
; Return values ....: The correct array
; Author(s) ..........: AZJIO
; Remarks ..........:
; ============================================================================================
; Имя функции ...: _SetCoor
; Описание ........: Корректирует координаты для отображения окна в рабочей области экрана
; Синтаксис.......: _SetCoor(ByRef $aWHXY[, $iMinWidth = 0[, $iMinHeight = 0[, $iStyle = 2[, $iFixed = 0[, $iMargin = 0]]]]])
; Параметры:
;		$aWHXY - Массив следующего формата:
;                  [0] - Ширина окна
;                  [1] - Высота окна
;                  [2] - X-координата окна
;                  [3] - Y-координата окна
;		$iMinWidth - Минимальная ширина
;		$iMinHeight - Минимальная высота
;		$iStyle - Стиль окна, который определяет ширину границ
;                  0 - Окно без границ, ширина границы 0 пиксел
;                  1 - Окно со стилем $WS_BORDER, обычно ширина этой границы 1 пиксел
;                  2 - Окно не изменяемое в размерах, обычно ширина этой границы 3 пиксел
;                  3 - Окно изменяемое в размерах ($WS_OVERLAPPEDWINDOW), обычно ширина этой границы 4 пиксел
;		$iFixed - Исправляет координаты окна при помещении его справа или снизу при отсутствии стиля $WS_CAPTION или $WS_DLGFRAME
;		$iMargin - Отступ от краёв
; Возвращаемое значение: Корректный массив
; Автор ..........: AZJIO
; Примечания ..: Функция предназначена для коррекции координат прочитанных из ini-файла.
; ============================================================================================
Func _SetCoor(ByRef $aWHXY, $iMinWidth = 0, $iMinHeight = 0, $iStyle = 2, $iFixed = 0, $iMargin = 0)
	Local $Xtmp, $Ytmp, $aWA, $iBorderX = 0, $iBorderY = 0, $iFixedH = 0
	If $iFixed Then $iFixedH += _WinAPI_GetSystemMetrics(4) ; + SMCYCAPTION
	$aWHXY[1] -= $iFixedH ; Вычисление одновременно приводит к числовому формату, необходимое для следующего условия
	If $iMinWidth And Number($aWHXY[0]) < $iMinWidth Then $aWHXY[0] = $iMinWidth ; ограничение ширины
	If $iMinHeight And Number($aWHXY[1]) < $iMinHeight Then $aWHXY[1] = $iMinHeight ; ограничение высоты

	__Coor1($aWA, $aWHXY[0], $aWHXY[1], $iBorderX, $iBorderY, $iStyle, $iMargin)

	$Xtmp = Number($aWHXY[2])
	$Ytmp = Number($aWHXY[3])

	__Coor2($Xtmp, $aWHXY[0], $aWA[4])
	__Coor2($Ytmp, $aWHXY[1], $aWA[5])

	If $aWHXY[2] == '' Then $Xtmp = -1
	If $aWHXY[3] == '' Then $Ytmp = -1
	$aWHXY[0] = $aWHXY[0] - $iBorderX - $iMargin
	$aWHXY[1] = $aWHXY[1] - $iBorderY - $iMargin + $iFixedH
	$aWHXY[2] = $Xtmp + $aWA[0] + $iMargin / 2
	$aWHXY[3] = $Ytmp + $aWA[1] + $iMargin / 2
EndFunc   ;==>_SetCoor

Func __Coor1(ByRef $aWA, ByRef $iWidth, ByRef $iHeight, ByRef $iBorderX, ByRef $iBorderY, ByRef $iStyle, ByRef $iMargin)
	Local $iX = 7, $iY = 8
	If $iStyle Then
		Switch $iStyle
			Case 1
				$iX = 5 ; SMCXBORDER
				$iY = 6 ; SMCYBORDER
			Case 2
				$iX = 7 ; SMCXDLGFRAME
				$iY = 8 ; SMCYDLGFRAME
			Case 3
				$iX = 32 ; SMCXFRAME
				$iY = 33 ; SMCYFRAME
		EndSwitch
		$iBorderX = _WinAPI_GetSystemMetrics($iX) * 2
		$iBorderY = _WinAPI_GetSystemMetrics($iY) * 2 + _WinAPI_GetSystemMetrics(4) ; + SMCYCAPTION
	Else
		$iBorderY = _WinAPI_GetSystemMetrics(4) ; + SMCYCAPTION
	EndIf
	$iWidth += $iBorderX
	$iHeight += $iBorderY
	$aWA = _WinAPI_GetWorkingArea()
	ReDim $aWA[6]
	$aWA[4] = $aWA[2] - $aWA[0] ; ширина Рабочей области
	$aWA[5] = $aWA[3] - $aWA[1] ; высота Рабочей области
	$iMargin *= 2 ; Вычисление наибольшего отступа

	If $iMargin > ($aWA[4] - $iWidth) Then $iMargin = $aWA[4] - $iWidth
	If $iMargin > ($aWA[5] - $iHeight) Then $iMargin = $aWA[5] - $iHeight
	If $iMargin < 0 Then $iMargin = 0

	$iWidth += $iMargin
	$iHeight += $iMargin
EndFunc   ;==>__Coor1

Func __Coor2(ByRef $Len1, ByRef $Len2, ByRef $Len3)
	If $Len1 < 0 Then $Len1 = 0
	If $Len2 >= $Len3 Then
		$Len2 = $Len3
		$Len1 = 0
	EndIf
	If $Len1 > $Len3 - $Len2 Then $Len1 = $Len3 - $Len2
EndFunc   ;==>__Coor2

; #FUNCTION# ;=================================================================================
; Function Name ...: _GetChildCoor
; Description ........: Returns the coordinates of the child window close to the parent, but in visible working area of the screen
; Syntax................: _GetChildCoor($hGui, $iWidth, $iHeight[, $iCenter = 1[, $iStyle = 2[, $iFixed = 0[, $iMargin = 0]]]])
; Parameters:
;		$hGui - The parent window handle
;		$iWidth - The width of the child window
;		$iHeight - The height of the child window
;		$iCenter - Alignment of the child window
;                  |0 - The top-left corner of the
;                  |1 - (by default) On the center
;		$iStyle - Style window that determines the width of the border
;                  0 - No window borders, border width 0 pixel
;                  1 - The window with the style $WS_BORDER, usually the width of the border 1 pixel
;                  2 - The window is not resizable, usually the width of the border 3 pixels
;                  3 - With the ability to resize window ($WS_OVERLAPPEDWINDOW), usually the width of the border 4 pixels
;		$iFixed - Fix window coordinates when you place it right or bottom in the absence of style $WS_DLGFRAME or $WS_CAPTION
;		$iMargin - Offset from the edges
; Return values ....: The array in the following format:
;                  [0] - Window width
;                  [1] - Window height
;                  [2] - X-coordinate of the window
;                  [3] - Y-coordinate of the window
; Author(s) ..........: AZJIO
; Remarks ..........:
; ============================================================================================
; Имя функции ...: _GetChildCoor
; Описание ........: Возвращает координаты дочернего окна приближенные к родительскому, но в видимой рабочей области экрана
; Синтаксис.......: _GetChildCoor($hGui, $iWidth, $iHeight[, $iCenter = 1[, $iStyle = 2[, $iFixed = 0[, $iMargin = 0]]]])
; Параметры:
;		$hGui - Дескриптор родительского окна
;		$iWidth - Ширина дочернего окна
;		$iHeight - Высота дочернего окна
;		$iCenter - Выравнивание дочернего окна
;                  |0 - По левому верхнему углу
;                  |1 - (по умолчанию) По центру
;		$iStyle - Стиль окна, который определяет ширину границ
;                  0 - Окно без границ, ширина границы 0 пиксел
;                  1 - Окно со стилем $WS_BORDER, обычно ширина этой границы 1 пиксел
;                  2 - Окно не изменяемое в размерах, обычно ширина этой границы 3 пиксел
;                  3 - Окно изменяемое в размерах ($WS_OVERLAPPEDWINDOW), обычно ширина этой границы 4 пиксел
;		$iFixed - Исправляет координаты окна при помещении его справа или снизу при отсутствии стиля $WS_CAPTION или $WS_DLGFRAME
;		$iMargin - Отступ от краёв
; Возвращаемое значение: Массив следующего формата:
;                  [0] - Ширина окна
;                  [1] - Высота окна
;                  [2] - X-координата окна
;                  [3] - Y-координата окна
; Автор ..........: AZJIO
; Примечания ..:
; ============================================================================================
Func _GetChildCoor($hGui, $iWidth, $iHeight, $iCenter = 1, $iStyle = 2, $iFixed = 0, $iMargin = 0)
	Local $aRect, $aWA, $iBorderX, $iBorderY, $iFixedH = 0
	If $iFixed Then $iFixedH += _WinAPI_GetSystemMetrics(4) ; + SMCYCAPTION
	$iHeight -= $iFixedH ; Вычисление одновременно приводит к числовому формату, необходимое для следующего условия
	$aRect = WinGetPos($hGui)

	__Coor1($aWA, $iWidth, $iHeight, $iBorderX, $iBorderY, $iStyle, $iMargin)

	$aRect[0] -= $aWA[0]
	$aRect[1] -= $aWA[1]

	If $iCenter Then
		$aRect[0] = $aRect[0] + ($aRect[2] - $iWidth) / 2
		$aRect[1] = $aRect[1] + ($aRect[3] - $iHeight) / 2
	EndIf

	__Coor2($aRect[0], $iWidth, $aWA[4])
	__Coor2($aRect[1], $iHeight, $aWA[5])

	$aRect[2] = $aRect[0] + $aWA[0] + $iMargin / 2
	$aRect[3] = $aRect[1] + $aWA[1] + $iMargin / 2
	$aRect[0] = $iWidth - $iBorderX - $iMargin
	$aRect[1] = $iHeight - $iBorderY - $iMargin + $iFixedH
	Return $aRect
EndFunc   ;==>_GetChildCoor

; #FUNCTION# ;=================================================================================
; Function Name ...: _WinAPI_GetWorkingArea
; Description ........: Returns the coordinates of the working area of the screen
; Syntax................: _WinAPI_GetWorkingArea()
; Return values ....: The array in the following format:
;                  [0] - X-coordinate of the upper left corner of the rectangle
;                  [1] - Y-coordinate of the upper left corner of the rectangle
;                  [2] - X-coordinate of the lower right corner of the rectangle
;                  [3] - Y-coordinate of the lower right corner of the rectangle
;					Failure - Array with coordinate of whole screen, @error = 1
; Author(s) ..........: CreatoR, AZJIO
; Remarks ..........:
; ============================================================================================
; Имя функции ...: _WinAPI_GetWorkingArea
; Описание ........: Возвращает прямоугольник рабочей области экрана
; Синтаксис.......: _WinAPI_GetWorkingArea()
; Возвращаемое значение: Массив следующего формата:
;                  [0] - X-координата левой стороны прямоугольника
;                  [1] - Y-координата верхней стороны прямоугольника
;                  [2] - X-координата правой стороны прямоугольника
;                  [3] - Y-координата нижней стороны прямоугольника
;					Неудачно - Массив с прямоугольником экрана, @error = 1
; Автор ..........: CreatoR, AZJIO
; Примечания ..:
; ============================================================================================
Func _WinAPI_GetWorkingArea()
	; Local Const $SPI_GETWORKAREA = 48
	Local $stRECT = DllStructCreate("long; long; long; long")
	Local $aRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", 48, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
	If @error Or Not $aRet[0] Then
		Local $aRet[4] = [0, 0, @DesktopWidth, @DesktopHeight]
		Return SetError(1, 0, $aRet[4])
	EndIf

	Local $aRet[4] = [DllStructGetData($stRECT, 1), DllStructGetData($stRECT, 2), DllStructGetData($stRECT, 3), DllStructGetData($stRECT, 4)]
	Return $aRet
EndFunc   ;==>_WinAPI_GetWorkingArea