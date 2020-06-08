#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

; Извлекает строки, которые содержатся в обоих файлах. Результат содержит строки в одном экземпляре.

; #FUNCTION# ;=================================================================================
; Function Name ...: _Alike_Lines
; Description ........: Duplicate strings in 2-x files
; Syntax................: _Alike_Lines ( $sText1, $sText2 [, $sep = @CRLF [, $sep2 = ''[, $all = 1]]] )
; Parameters:
;		$sText1 - Multistring text
;		$sText2 - Multistring text
;		$sep - Delimiter of elements at a search
;		$sep2 - Delimiter of elements is in results
;		$all - Changes how the string split (See StringSplit)
;                  |0 - each character in $sep it is a delimiter
;                  |1 - entire delimiter string in $sep it is a delimiter
;		$casesense - case sensitive
;                  |0 - binary mode, case sensitive
;                  |1 - text mode is not case sensitive
; Return values ....: Success - Returns string
;					Failure - '', @error:
;                  |0 - no error
;                  |2 - Not found
; Author(s) ..........: AZJIO
; Remarks ..........: Case sensitive, String <> StRiNg <> STRING using $casesense=0
; ============================================================================================
; Имя функции ...: _Alike_Lines
; Описание ........: Возвращает одинаковые строки в 2-х файлах
; Синтаксис.......: _Alike_Lines ( $sText1, $sText2 [, $sep = @CRLF [, $sep2 = ''[, $all = 1]]] )
; Параметры:
;		$sText1 - Многостроковый текст
;		$sText2 - Многостроковый текст
;		$sep - Разделитель элементов при поиске
;		$sep2 - Разделитель элементов в возвращаемых данных
;		$all - Определяет как воспринимать разделитель
;                  |0 - каждый символ параметра $sep является разделителем
;                  |1 - вся строка параметра $sep является разделителем
;		$casesense - чуствительность к регистру
;                  |0 - бинарный режим, учитывает регистр букв
;                  |1 - текстовый режим не учитывает регистр букв
; Возвращаемое значение: Успешно - Возвращает строку
;					Неудачно -'', @error:
;                  |0 - нет ошибок
;                  |2 - Не найдено
; Автор ..........: AZJIO
; Примечания ..: Учитывает регистр String <> StRiNg <> STRING при использовании $casesense=0
; ============================================================================================
Func _Alike_Lines($sText1, $sText2, $sep = @CRLF, $sep2 = '', $all = 1, $casesense = 1)
	Local $i, $k, $aText

	If $all And $sep2 == '' Then $sep2 = $sep

	$aText = StringSplit($sText1, $sep, $all + 2) ; Создаём переменные первого файла
	Local $oSD = ObjCreate("Scripting.Dictionary")
	$oSD.CompareMode = $casesense
	For $i In $aText
		$oSD.Item($i) = -2
	Next
	$oSD.Item('') = 2

	$aText = StringSplit($sText2, $sep, $all + 2)

	$k = 0
	$sText1 = ''
	For $i In $aText
		$oSD.Item($i) = $oSD.Item($i) + 1
		If $oSD.Item($i) = -1 Then
			$sText1 &= $i & $sep2
			$k += 1
		EndIf
	Next
	If $k = 0 Then Return SetError(2, 0, '')
	Return SetError(0, $k, StringTrimRight($sText1, StringLen($sep2)))
EndFunc   ;==>_Alike_Lines

; #FUNCTION# ;=================================================================================
; Function Name ...: _Unique_Lines_Text2
; Description ........: Returns unique 2-file strings which are not present in the first
; Syntax................: _Unique_Lines_Text2 ( $sText1, $sText2 [, $sep = @CRLF [, $sep2 = ''[, $all = 1]]] )
; Parameters:
;		$sText1 - Multistring text
;		$sText2 - Multistring text
;		$sep - Delimiter of elements at a search
;		$sep2 - Delimiter of elements is in results
;		$all - Changes how the string split (See StringSplit)
;                  |0 - each character in $sep it is a delimiter
;                  |1 - entire delimiter string in $sep it is a delimiter
;		$casesense - case sensitive
;                  |0 - binary mode, case sensitive
;                  |1 - text mode is not case sensitive
; Return values ....: Success - Returns string
;					Failure - '', @error:
;                  |0 - no error
;                  |2 - Not found
; Author(s) ..........: AZJIO
; Remarks ..........: Case sensitive, String <> StRiNg <> STRING using $casesense=0
; ============================================================================================
; Имя функции ...: _Unique_Lines_Text2
; Описание ........: Возвращает уникальные строки 2-го файла, которых нет в первом
; Синтаксис.......: _Unique_Lines_Text2 ( $sText1, $sText2 [, $sep = @CRLF [, $sep2 = ''[, $all = 1]]] )
; Параметры:
;		$sText1 - Многостроковый текст
;		$sText2 - Многостроковый текст
;		$sep - Разделитель элементов при поиске
;		$sep2 - Разделитель элементов в возвращаемых данных
;		$all - Определяет как воспринимать разделитель
;                  |0 - каждый символ параметра $sep является разделителем
;                  |1 - вся строка параметра $sep является разделителем
;		$casesense - чуствительность к регистру
;                  |0 - бинарный режим, учитывает регистр букв
;                  |1 - текстовый режим не учитывает регистр букв
; Возвращаемое значение: Успешно - Возвращает строку
;					Неудачно -'', @error:
;                  |0 - нет ошибок
;                  |2 - Не найдено
; Автор ..........: AZJIO
; Примечания ..: Учитывает регистр String <> StRiNg <> STRING при использовании $casesense=0
; ============================================================================================
Func _Unique_Lines_Text2($sText1, $sText2, $sep = @CRLF, $sep2 = '', $all = 1, $casesense = 1)
	Local $i, $k, $aText

	If $all And $sep2 == '' Then $sep2 = $sep

	$aText = StringSplit($sText1, $sep, $all + 2) ; Создаём переменные первого файла
	Local $oSD = ObjCreate("Scripting.Dictionary")
	$oSD.CompareMode = $casesense
	For $i In $aText
		$oSD.Item($i) = 2
	Next
	$oSD.Item('') = 2

	$aText = StringSplit($sText2, $sep, $all + 2)

	$k = 0
	$sText1 = ''
	For $i In $aText
		$oSD.Item($i) = $oSD.Item($i) + 1
		If $oSD.Item($i) = 1 Then
			$sText1 &= $i & $sep2
			$k += 1
		EndIf
	Next
	If $k = 0 Then Return SetError(2, 0, '')
	Return SetError(0, $k, StringTrimRight($sText1, StringLen($sep2)))
EndFunc   ;==>_Unique_Lines_Text2

; #FUNCTION# ;=================================================================================
; Function Name ...: _StringUnique
; Description ........: Returns unique strings of the one file, removes duplicates
; Syntax................: _StringUnique ( $sText [, $sep = @CRLF [, $sep2 = ''[, $all = 1]]] )
; Parameters:
;		$sText - Multistring text
;		$sep - Delimiter of elements at a search
;		$sep2 - Delimiter of elements is in results
;		$all - Changes how the string split (See StringSplit)
;                  |0 - each character in $sep it is a delimiter
;                  |1 - entire delimiter string in $sep it is a delimiter
;		$casesense - case sensitive
;                  |0 - binary mode, case sensitive
;                  |1 - text mode is not case sensitive
; Return values ....: Success - Returns string
;					Failure - '', @error:
;                  |0 - no error
;                  |2 - Not found
; Author(s) ..........: AZJIO
; Remarks ..........: Case sensitive, String <> StRiNg <> STRING using $casesense=0
; ============================================================================================
; Имя функции ...: _StringUnique
; Описание ........: Возвращает уникальные строки одного файла, удаляет повторы
; Синтаксис.......: _StringUnique ( $sText [, $sep = @CRLF [, $sep2 = ''[, $all = 1]]] )
; Параметры:
;		$sText - Многостроковый текст
;		$sep - Разделитель элементов при поиске
;		$sep2 - Разделитель элементов в возвращаемых данных
;		$all - Определяет как воспринимать разделитель
;                  |0 - каждый символ параметра $sep является разделителем
;                  |1 - вся строка параметра $sep является разделителем
;		$casesense - чуствительность к регистру
;                  |0 - бинарный режим, учитывает регистр букв
;                  |1 - текстовый режим не учитывает регистр букв
; Возвращаемое значение: Успешно - Возвращает строку
;					Неудачно -'', @error:
;                  |0 - нет ошибок
;                  |2 - Не найдено
; Автор ..........: AZJIO
; Примечания ..: Учитывает регистр String <> StRiNg <> STRING при использовании $casesense=0
; ============================================================================================
Func _StringUnique($sText, $sep = @CRLF, $sep2 = '', $all = 1, $casesense = 1)
	Local $i, $k, $aText
	If $all And $sep2 == '' Then $sep2 = $sep
	Local $oSD = ObjCreate("Scripting.Dictionary")
	$oSD.CompareMode = $casesense

	$aText = StringSplit($sText, $sep, $all + 2)
	$k = 0
	$sText = ''
	For $i In $aText
		If Not $oSD.Exists($i) And $i Then
			$oSD.Add($i, '')
			$sText &= $i & $sep2
			$k += 1
		EndIf
	Next
	If Not $k Then Return SetError(2, 0, '')
	Return SetError(0, $k, StringTrimRight($sText, StringLen($sep2)))
EndFunc   ;==>_StringUnique

; #FUNCTION# ;=================================================================================
; Function Name ...: _CountingStringUnique
; Description ........: Returns unique strings of the one file, counting up the amount of reiterations of these strings
; Syntax................: _CountingStringUnique ( $sText [, $sep = @CRLF [, $sep2 = ''[, $all = 1]]] )
; Parameters:
;		$sText - Multistring text
;		$sep - Delimiter of elements at a search
;		$sep2 - Delimiter of elements is in results
;		$all - Changes how the string split (See StringSplit)
;                  |0 - each character in $sep it is a delimiter
;                  |1 - entire delimiter string in $sep it is a delimiter
;		$casesense - case sensitive
;                  |0 - binary mode, case sensitive
;                  |1 - text mode is not case sensitive
; Return values ....: Success - Returns string
;					Failure - '', @error:
;                  |0 - no error
;                  |2 - Not found
; Author(s) ..........: AZJIO
; Remarks ..........: Case sensitive, String <> StRiNg <> STRING using $casesense=0
; ============================================================================================
; Имя функции ...: _CountingStringUnique
; Описание ........: Возвращает уникальные строки одного файла, подсчитывая количество повторений этих строк
; Синтаксис.......: _CountingStringUnique ( $sText [, $sep = @CRLF [, $sep2 = ''[, $all = 1]]] )
; Параметры:
;		$sText - Многостроковый текст
;		$sep - Разделитель элементов при поиске
;		$sep2 - Разделитель элементов в возвращаемых данных
;		$all - Определяет как воспринимать разделитель
;                  |0 - каждый символ параметра $sep является разделителем
;                  |1 - вся строка параметра $sep является разделителем
;		$casesense - чуствительность к регистру
;                  |0 - бинарный режим, учитывает регистр букв
;                  |1 - текстовый режим не учитывает регистр букв
; Возвращаемое значение: Успешно - Возвращает строку
;					Неудачно -'', @error:
;                  |0 - нет ошибок
;                  |2 - Не найдено
; Автор ..........: AZJIO
; Примечания ..: Учитывает регистр String <> StRiNg <> STRING при использовании $casesense=0
; ============================================================================================
Func _CountingStringUnique($sText, $sep = @CRLF, $sep2 = '', $all = 1, $casesense = 1)
	Local $i, $k, $aText
	If $all And $sep2 == '' Then $sep2 = $sep

	$aText = StringSplit($sText, $sep, $all + 2)
	Local $oSD = ObjCreate("Scripting.Dictionary")
	$oSD.CompareMode = $casesense
	For $i In $aText
		$oSD.Item($i) = $oSD.Item($i) + 1
	Next
	$aText = $oSD.Keys()
	$k = 0
	$sText = ''
	For $i In $aText
		If Not $i Then ContinueLoop
		$sText &= $oSD.Item($i) & @TAB & $i & $sep2
		$k += 1
	Next
	If $k = 0 Then Return SetError(2, 0, '')
	Return SetError(0, $k, StringTrimRight($sText, StringLen($sep2)))
EndFunc   ;==>_CountingStringUnique

; функция создаёт диалог с чекбоксом и возможностью отложить вопрос до следующего старта программы или до следующего события в текущей сессии работы с программой. Естественно, чтобы отложить вопрос до следующего старта, потребуется сохранить состояние @extended в ini-файл.
; Функция позволяет установить тексты всех элементов окна, размеры окна, чтобы вместить текст вопроса и умолчальное состояние чекбокса.
; Параметры:
;				$sTitle - Заголовок окна
;				$sText - Текст окна
;				$iSizeX - Ширина окна, по умолчанию 270
;				$iSizeY - Высота окна, по умолчанию 170
;				$iCheckbox - Состояние чекбокса, по умолчанию 0 - нет галочки
;				$LngCheck - текст чекбокса, по умолчанию 'Больше не спрашивать'
;				$LngYes - текст кнопки "Да", по умолчанию "Да"
;				$LngNo - текст кнопки, "Нет", по умолчанию "Нет"
;				$hWnd - дескриптор родительского окна
; Возвращает:
;				0 - Нет, Отмена или закрытие окна
;				1 - Да, ОК
; в случае, если потребуется отличать закрытие окна от кнопки "Нет" используйте проверку @error
Func _MsgAsk($sTitle, $sText, $iSizeX = 270, $iSizeY = 170, $iCheckbox = 0, $LngCheck = 'Not to ask any more', $LngYes = 'Yes', $LngNo = 'No', $hWnd = 0)
	Local $hGUIChild, $iYes, $iNo, $iCheck, $iMode, $iAnswer = 0, $iError = 0, $iTrWnd = 0
	If $iSizeX < 170 Then $iSizeX = 170
	$iMode = Opt('GUIOnEventMode', 0)
	If IsHWnd($hWnd) Then
		GUISetState(@SW_DISABLE, $hWnd)
		$iTrWnd = 1
	Else
		$hWnd = 0
	EndIf
	
	$hGUIChild = GUICreate($sTitle, $iSizeX, $iSizeY, -1, -1, BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $hWnd)
	GUICtrlCreateLabel($sText, 10, 10, $iSizeX - 20, $iSizeY - 75)
	
	$iCheck = GUICtrlCreateCheckbox($LngCheck, 10, $iSizeY - 65, $iSizeX - 20, 17)
	If $iCheckbox Then GUICtrlSetState(-1, 1)
	
	$iYes = GUICtrlCreateButton($LngYes, ($iSizeX - 150) / 2, $iSizeY - 40, 70, 28)
	$iNo = GUICtrlCreateButton($LngNo, ($iSizeX - 150) / 2 + 80, $iSizeY - 40, 70, 28)
	GUISetState(@SW_SHOW, $hGUIChild)
	While 1
		Switch GUIGetMsg()
			Case $iYes
				$iAnswer = 1
				ExitLoop
			Case $iNo
				ExitLoop
			Case $GUI_EVENT_CLOSE
				$iError = 1
				ExitLoop
		EndSwitch
	WEnd
	If GUICtrlRead($iCheck) = 1 Then
		$iCheckbox = 1
	Else
		$iCheckbox = 0
	EndIf
	If $iTrWnd Then GUISetState(@SW_ENABLE, $hWnd)
	GUIDelete($hGUIChild)
	Opt('GUIOnEventMode', $iMode)
	Return SetError($iError, $iCheckbox, $iAnswer)
EndFunc   ;==>_MsgAsk

Func _TypeGetPath($type)
	Local $aPath = ''
	Local $typefile = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $type, 'Progid')
	If @error Or $typefile = '' Then
		$typefile = RegRead('HKCR\.' & $type, '')
		If @error Then
			$aPath = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $type & '\OpenWithList', 'a')
			If @error Or $aPath = '' Then Return SetError(1)
		EndIf
	EndIf
	If $aPath = '' Then
		Local $Open = RegRead('HKCR\' & $typefile & '\shell', '')
		If @error Or $Open = '' Then $Open = 'open'
		$typefile = RegRead('HKCR\' & $typefile & '\shell\' & $Open & '\command', '')
		If @error Then
			$aPath = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $type & '\OpenWithList', 'a')
			If @error Or $aPath = '' Then
				Return SetError(1)
			Else
				$typefile = $aPath
			EndIf
		EndIf
	Else
		$typefile = $aPath
	EndIf
	Local $aPath = StringRegExp($typefile, '(?i)(^.*)(\.exe.*)$', 3)
	If @error Then Return SetError(1)
	$aPath = StringReplace($aPath[0], '"', '') & '.exe'
	Opt('ExpandEnvStrings', 1)
	If FileExists($aPath) Then
		$aPath = $aPath
		Opt('ExpandEnvStrings', 0)
		Return $aPath
	EndIf
	Opt('ExpandEnvStrings', 0)
	If FileExists(@SystemDir & '\' & $aPath) Then
		Return @SystemDir & '\' & $aPath
	ElseIf FileExists(@WindowsDir & '\' & $aPath) Then
		Return @WindowsDir & '\' & $aPath
	EndIf
	Return SetError(1)
EndFunc   ;==>_TypeGetPath

Func _ChildCoor($Gui, $w, $h, $c = 0, $d = 0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
			$GP = WinGetPos($Gui), _
			$wgcs = WinGetClientSize($Gui)
	Local $dLeft = ($GP[2] - $wgcs[0]) / 2, _
			$dTor = $GP[3] - $wgcs[1] - $dLeft
	If $c = 0 Then
		$GP[0] = $GP[0] + ($GP[2] - $w) / 2 - $dLeft
		$GP[1] = $GP[1] + ($GP[3] - $h - $dLeft - $dTor) / 2
	EndIf
	If $d > ($aWA[2] - $aWA[0] - $w - $dLeft * 2) / 2 Or $d > ($aWA[3] - $aWA[1] - $h - $dLeft + $dTor) / 2 Then $d = 0
	If $GP[0] + $w + $dLeft * 2 + $d > $aWA[2] Then $GP[0] = $aWA[2] - $w - $d - $dLeft * 2
	If $GP[1] + $h + $dLeft + $dTor + $d > $aWA[3] Then $GP[1] = $aWA[3] - $h - $dLeft - $dTor - $d
	If $GP[0] <= $aWA[0] + $d Then $GP[0] = $aWA[0] + $d
	If $GP[1] <= $aWA[1] + $d Then $GP[1] = $aWA[1] + $d
	$GP[2] = $w
	$GP[3] = $h
	Return $GP
EndFunc   ;==>_ChildCoor

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

Func _Restart()
	Local $sAutoIt_File = @TempDir & "\~Au3_ScriptRestart_TempFile.au3"
	Local $sRunLine, $sScript_Content, $hFile

	$sRunLine = @ScriptFullPath
	If Not @Compiled Then $sRunLine = @AutoItExe & ' /AutoIt3ExecuteScript ""' & $sRunLine & '""'
	If $CmdLine[0] > 0 Then $sRunLine &= ' ' & $CmdLineRaw

	$sScript_Content &= '#NoTrayIcon' & @CRLF & _
			'While ProcessExists(' & @AutoItPID & ')' & @CRLF & _
			'   Sleep(10)' & @CRLF & _
			'WEnd' & @CRLF & _
			'Run("' & $sRunLine & '")' & @CRLF & _
			'FileDelete(@ScriptFullPath)' & @CRLF

	$hFile = FileOpen($sAutoIt_File, 2)
	FileWrite($hFile, $sScript_Content)
	FileClose($hFile)

	Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sAutoIt_File & '"', @ScriptDir, @SW_HIDE)
	Sleep(1000)
	Exit
EndFunc   ;==>_Restart