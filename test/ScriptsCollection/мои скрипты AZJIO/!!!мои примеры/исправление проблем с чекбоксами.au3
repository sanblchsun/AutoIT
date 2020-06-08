; переделал пример Yashied в более мне понятном виде, в 3-х пунктах.
; если UDF -  WinAPIEx.au3 добавлен с директивой #Include, то функции добавлять не нужно, но компилирование с WinAPIEx.au3 заметно увеличивает файл EXE.

Global $Msg, $Tab, $hTab, $Button, $Slider, $Color, $Part

GUICreate('MyGUI', 200, 180)
$Tab = GUICtrlCreateTab(7, 7, 188, 164)
$hTab = GUICtrlGetHandle($Tab) ; (1) строка определения хэндэла элемента (таба), у меня без неё работает, но переменная указана в функции
GUICtrlCreateTabItem('About')
$Slider = GUICtrlCreateSlider(20, 45, 160, 26)
$Group = GUICtrlCreateGroup ("Группа элементов", 20, 90, 150, 65)
$Radio = GUICtrlCreateRadio("Выбрать", 30, 110, 130, 20)
$Check = GUICtrlCreateCheckbox("Использовать", 30, 130, 130, 20)
GUICtrlCreateTabItem('')

;===========================================================
; (2) устранение проблем интерфейса, проверка OS, для установки нужного индекса
Switch @OSVersion
    Case 'WIN_2000', 'WIN_XP', 'WIN_2003'
        $Part = 10
    Case Else
        $Part = 11
EndSwitch
$Color = _WinAPI_GetThemeColor($hTab, 'TAB', $Part, 1, 0x0EED)
If Not @error Then
	; перечисление элементов, для которых нужно исправить проблему цвета
	; здесь чекбоксы, радиокнопки, слайдеры, группы...
	; для эксперимента попробуйте удалить ниже четыре строки и проверте скрипт. При движении окна поверх окна скрипта чекбоксы закрашиваются в чёрный цвет.
    GUICtrlSetBkColor($Slider, $Color)
    GUICtrlSetBkColor($Group, $Color)
    GUICtrlSetBkColor($Radio, $Color)
    GUICtrlSetBkColor($Check, $Color)
EndIf
;===========================================================

GUISetState()

While 1
    $Msg = GUIGetMsg()
    Switch $Msg
        Case -3
            ExitLoop
    EndSwitch
WEnd

;===========================================================
; (3) устранение проблем интерфейса, обязательные три (сократил до одной) функции, скопированные из WinAPIEx.au3 ("Global $__RGB = True" - уже не нужен)
Func _WinAPI_GetThemeColor($hWnd, $sClass, $iPart, $iState, $iProp)
	Local $hTheme = DllCall('uxtheme.dll', 'ptr', 'OpenThemeData', 'hwnd', $hWnd, 'wstr', $sClass)
	Local $Ret = DllCall('uxtheme.dll', 'lresult', 'GetThemeColor', 'ptr', $hTheme[0], 'int', $iPart, 'int', $iState, 'int', $iProp, 'dword*', 0)

	If (@error) Or ($Ret[0] < 0) Then
		$Ret = -1
	EndIf
	DllCall('uxtheme.dll', 'lresult', 'CloseThemeData', 'ptr', $hTheme[0])
	If $Ret = -1 Then
		Return SetError(1, 0, -1)
	EndIf
	Return SetError(0, 0, BitOR(BitAND($Ret[5], 0x00FF00), BitShift(BitAND($Ret[5], 0x0000FF), -16), BitShift(BitAND($Ret[5], 0xFF0000), 16)))
EndFunc   ;==>_WinAPI_GetThemeColor
;===========================================================