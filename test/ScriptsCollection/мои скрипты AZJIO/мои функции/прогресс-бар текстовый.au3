#NoTrayIcon
Opt("GUIResizeMode", 802)
Opt("GUIDataSeparatorChar", ChrW('0x00A4')) 
Global $Color=0x00ccff, $BkColor=0xf7f7f7

; En
$Lng1='Used symbol :'
$LngSt='Start'
$LngSz='Size :'
$LngDl='Delay :'
$LngSty='Style :'
$LngSel='Choose'
$LngAdd='Add'


; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$Lng1='Используемый символ :'
	$LngSt='Старт'
	$LngSz='Размер бара (кол. симв.) :'
	$LngDl='Задержка :'
	$LngSty='Стиль :'
	$LngSel='Выбрать'
	$LngAdd='Добавить'
EndIf

$hForm = GUICreate("Text Progress Bar", 380, 160+30, -1, -1, 0x00040000)
$hButton1 = GUICtrlCreateButton($LngSt, 260,115, 80, 30)
GUICtrlCreateLabel($Lng1, 10, 43, 130, 17)
$symbol = GUICtrlCreateCombo('', 140,40, 60)
GUICtrlSetData(-1,' '&ChrW('0x2588')&'¤|¤/¤\¤*¤(¤)¤'&ChrW('0x25CF')&'¤'&ChrW('0x25AA')&'¤'&ChrW('0x2022')&'¤'&ChrW('0x2039')&'¤'&ChrW('0x203A')&'¤'&ChrW('0x2206')&'¤'&ChrW('0x20AC')&'¤!¤.', ' '&ChrW('0x2588'))
GUICtrlCreateLabel($LngSz, 10, 73, 130, 17)
$kol_sim = GUICtrlCreateCombo('', 140,70, 60)
GUICtrlSetData(-1,'20¤30¤50¤100¤120¤200', '20')
GUICtrlCreateLabel($LngDl, 10, 103, 130, 17)
$Delay = GUICtrlCreateCombo('', 140,100, 60)
GUICtrlSetData(-1,'10¤20¤50¤100¤200', '20')
GUICtrlCreateLabel($LngSty, 10, 133, 130, 17)
$Style= GUICtrlCreateCombo('', 140,130, 60)
GUICtrlSetData(-1,'1¤2¤3¤4¤5', '1')

GUICtrlCreateGroup('', 205, 28, 160, 72)
$hSelect = GUICtrlCreateButton($LngSel, 210, 40, 60, 25)
$hAdd = GUICtrlCreateButton($LngAdd, 210, 70, 60, 25)
$Un = GUICtrlCreateCombo('', 280,40, 60)
GUICtrlSetData(-1,'2588¤25A0¤F031¤25B2¤25BA¤25BC¤2590¤2666¤25D8¤263B¤2665', '2588')

GUISetState()

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case -3
            Exit

        Case $hButton1
			$symbol0 = GUICtrlRead($symbol)
			$Delay0 = GUICtrlRead($Delay)
			$kol_sim0 = GUICtrlRead($kol_sim)
			$aStartTPB=_TPB_ProgressOn(10, 5, $kol_sim0, 21, $symbol0)
            For $i = 0 To 100
                Sleep($Delay0)
                _TPB_ProgressSet($aStartTPB, $i)
                ; GUICtrlSetData($hButton1, $i & " %")
            Next
			; GUICtrlDelete($aStartTPB[0])
			; _TPB_ProgressOff($aStartTPB)

        Case $hSelect
			Run('charmap.exe')

        Case $hAdd, $Un
			$Un0 = ChrW('0x'&GUICtrlRead($Un))
            GUICtrlSetData($symbol, $Un0, $Un0)

        Case $Style
			Switch GUICtrlRead($Style)
				Case 1
				   $Color=0x00CCFF
				   $BkColor=0xF7F7F7
				Case 2
				   $Color=0xFF8700
				   $BkColor=0xFFFF8D
				Case 3
				   $Color=0xFF0361
				   $BkColor=0xFFDEDA
				Case 4
				   $Color=0x00A272
				   $BkColor=0xE8EED8
				Case 5
				   $Color=0x515151
				   $BkColor=0xF1F1F1
				Case Else
				   $Color=0x00CCFF
				   $BkColor=0xF7F7F7
			EndSwitch

    EndSwitch
WEnd

Func _TPB_ProgressOn($left, $top, $amount, $height, $symbol)
	If IsDeclared('aStartTPB') And IsArray($aStartTPB) Then GUICtrlDelete($aStartTPB[0]) ; Строка для теста, чтобы удалить элемент и проверить с другим символом
	Local $aStartTPB[3], $String='  '
	For $i = 1 to $amount
		$String&=$symbol
	Next
	GUISetFont (12, 700)
	$aStartTPB[0] = GUICtrlCreateLabel($String, $left, $top, -1, $height)
	GUICtrlSetData(-1, '')
	GUICtrlSetColor(-1, $Color)
	GUICtrlSetBkColor(-1, $BkColor)
	; GUICtrlSetColor(-1, 0xff8700)
	; GUICtrlSetBkColor(-1, 0xffff8d)
	$aStartTPB[1] = $amount
	$aStartTPB[2] = $symbol
	Return $aStartTPB
EndFunc

Func _TPB_ProgressSet($aStartTPB, $Prosent = 0)
    If $Prosent < 0 Or $Prosent > 100 Then Return SetError(1, 0, 0)
	Local $kol=Int($Prosent*($aStartTPB[1]/100)), $String='  '
	; If StringLen(GUICtrlRead($aStartTPB[0]))-2=$kol Then Return ; этот вариант вызывает ошибку при использовании двух символов. Взамен строчка после цикла.
	For $i = 1 to $kol
		$String&=$aStartTPB[2]
	Next
	If GUICtrlRead($aStartTPB[0])=$String Then Return
	GUICtrlSetData($aStartTPB[0], $String)
EndFunc

; Func _TPB_ProgressOff($aStartTPB)
    ; GUICtrlDelete($aStartTPB[0])
; EndFunc