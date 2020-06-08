;  @AZJIO
GUICreate("Удаление пустых строк", 300, 100, -1, -1, -1, 0x00000010)
$CatchDrop = GUICtrlCreateLabel("  кинь сюда файл", 0, 25, 300, 75)
GUICtrlSetState(-1, 8)
GUICtrlCreateLabel("Количество переходов на новую строку :", 31, 5, 205, 15, 0xC)
$Mode=GUICtrlCreateCombo ("", 240,3,50,18)
GUICtrlSetData(-1,'0|1|2|', '2')
$k=0
$kol2=''
GUISetState()

While 1
	Sleep(10)
	$msg = GUIGetMsg()
	Select
		Case $msg = -13
			$file = FileOpen(@GUI_DragFile, 0)
			$text = FileRead($file)
			FileClose($file)
			$aPath=StringRegExp(@GUI_DragFile,'(^.*)\\(.*)\.(.*)$',3)
			$text = StringRegExpReplace($text, '(\n\r){40}', '') ;удаление по 40 пустых строк
			$kol1 = @extended
			$Mode0=GUICtrlRead ($Mode)
			Switch $Mode0
				Case 0
					$text = StringRegExpReplace($text, '(\r\n)', '')
					$kol2 = @extended
				Case 1
					$text = StringRegExpReplace($text, '(\r\n){2,}', @CRLF)
					$kol2 = @extended
				Case 2
					$text = StringRegExpReplace($text, '(\r\n){3,}', @CRLF&@CRLF)
					$kol2 = @extended
				Case Else
					$text = StringRegExpReplace($text, '(\r\n){3,}', @CRLF&@CRLF)
					$kol2 = @extended
			EndSwitch
			$file = FileOpen($aPath[0]&'\'&$aPath[1]&'_New.'&$aPath[2],2)
			FileWrite($file, $text)
			FileClose($file)
			$k+=1
			GUICtrlSetData($CatchDrop, "  "&$k&'. Файл '&$aPath[1]&'_New.'&$aPath[2]&' готов'&@CRLF&' количество замен '&$kol1&'*40+'&$kol2&'='&$kol1*40+$kol2)
		Case $msg = -3
			Exit
	EndSelect
WEnd