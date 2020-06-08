
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=timeout_gfx.exe
#AutoIt3Wrapper_icon=timeout_gfx.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=timeout_gfx.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO   (AutoIt3_v3.2.12.1...v3.3.6.1) 
; 16.8.2009 > 26.11.2010 - обновлено, оптимизирован код

#NoTrayIcon
GUICreate("Рассчёт таймера gfxboot",308,165)
GUICtrlCreateGroup("Направление убывания", 21, 10, 140, 106)
$Radio1 = GUICtrlCreateRadio("Справа налево", 30, 30, 110, 20)
GUICtrlSetState($Radio1, 1)
$Radio2 = GUICtrlCreateRadio("Слева направо", 30, 50, 110, 20)
$Radio3 = GUICtrlCreateRadio("Сверху вниз", 30, 70, 110, 20)
$Radio4 = GUICtrlCreateRadio("Снизу вверх", 30, 90, 110, 20)


GUICtrlCreateGroup("Полоска прогресса", 166, 10, 120, 106)
GUICtrlCreateLabel ("Высота:", 175,28,60,20)
$inputHeight=GUICtrlCreateInput ("6", 235,27,35,19) ; высота рисунка head.jpg, head_a.jpg

GUICtrlCreateLabel ("Ширина:", 175,50,60,20)
$inputWidth=GUICtrlCreateInput ("800", 235,50,35,19)   ; ширина рисунка head.jpg, head_a.jpg

GUICtrlCreateLabel ("Кол. шагов", 175,73,60,20)
$amount=GUICtrlCreateInput ("100", 235,73,35,19)

$FileNew=GUICtrlCreateCheckbox('Всегда в новый файл', 30,120,137,22)

GUICtrlCreateLabel ("AZJIO 26.11.2010", 30,145,137,22)
$start=GUICtrlCreateButton ("Выполнить", 195,125,87,28)
GUICtrlSetTip(-1, "Рассчитать и показать информацию.")
$FileName=''

GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $Radio1 Or $msg = $Radio2
			GUICtrlSetData($inputHeight,'6')
			GUICtrlSetData($inputWidth,'800')
		Case $msg = $Radio3 Or $msg = $Radio4
			GUICtrlSetData($inputHeight,'600')
			GUICtrlSetData($inputWidth,'6')
		Case $msg = $start
			If GUICtrlRead($FileNew)=1 Then 
				$FileName=@ScriptDir&'\GfxTimeOut'
				$i = 0
				While FileExists($FileName&'_'&$i&'.txt')
					$i+=1
				WEnd
				$FileName=$FileName&'_'&$i&'.txt'
			Else
				$FileName=@ScriptDir&'\GfxTimeOut_0.txt'
			EndIf
			$amount0=GUICtrlRead ($amount)
			$inputHeight0=GUICtrlRead ($inputHeight)
			$inputWidth0=GUICtrlRead ($inputWidth)
			If GUICtrlRead ($Radio1)=1 Then
				$Radio0=1
			ElseIf GUICtrlRead ($Radio2)=1 Then
				$Radio0=2
			ElseIf GUICtrlRead ($Radio3)=1 Then
				$Radio0=3
			ElseIf GUICtrlRead ($Radio4)=1 Then
				$Radio0=4
			EndIf
		
			Switch $Radio0
				Case 1, 2
				   $blok=$inputWidth0/$amount0
				Case 3, 4
				   $blok=$inputHeight0/$amount0
			EndSwitch
			
			If ($Radio0=1 Or $Radio0=2) And mod($inputWidth0, $amount0)<>0 Then 
			  MsgBox(0, "Мелкая ошибка", 'Введите кратные числа Ширина и Количество шагов'&@CRLF&'Число параметра Ширина должно быть больше,'&@CRLF&'чем число Количество шагов')
			  ContinueLoop
			EndIf
			
			If ($Radio0=3 Or $Radio0=4) And mod($inputHeight0, $amount0)<>0 Then 
			  MsgBox(0, "Мелкая ошибка", 'Введите кратные числа Высота и Количество шагов'&@CRLF&'Число параметра Высота должно быть больше,'&@CRLF&'чем число Количество шагов')
			  ContinueLoop
			EndIf
			   
			$xy1=0
			$FileText='Создание таймера GFX-темы' & @CRLF & _
			'Координаты рисунка head.jpg, head_a.jpg' & @CRLF & _
			'В файле common.inc строка 1197' & @CRLF & _
			 '/head.x 100 def - отступ слева' & @CRLF & _
			'/head.y 15 def - отступ сверху' & @CRLF & _
			'-------------------------' & @CRLF & _
			'Размеры рисунка head.jpg, head_a.jpg' & @CRLF & _
			'Они же указываются в окне утилиты' & @CRLF & _
			$inputHeight0&' - Высота' & @CRLF & _
			$inputWidth0&' - Ширина' & @CRLF & _
			'-------------------------' & @CRLF & _
			'Размеры закрашивающего блока' & @CRLF & _
			'В файле timeout.inc строка 105' & @CRLF & _
			'Заменить "8 8 savescreen" на' & @CRLF
			
		
			Switch $Radio0
				Case 1, 2
				   $FileText&=$blok&' '&$inputHeight0&' savescreen' & @CRLF
				Case 3, 4
				   $FileText&=$inputWidth0&' '&$blok&' savescreen' & @CRLF
			EndSwitch
			
			$FileText&='-------------------------' & @CRLF & _
			'Таблица перемещения закрашивающего блока' & @CRLF & _
			'В файле timeout.inc строка 123' & @CRLF & _
			'     y  x' & @CRLF & _
			'-------------------------' & @CRLF
			$amount0-=1
			
			Switch $Radio0
				Case 1
					For $i=0 To $amount0
					   $xy2=$inputWidth0-$i*$blok-$blok
					   $FileText&='  [  '&$xy2&'  '&$xy1&'  .undef ]' & @CRLF
					Next
				Case 2
					For $i=0 To $amount0
						$xy2=$i*$blok
						$FileText&='  [  '&$xy2&'  '&$xy1&'  .undef ]' & @CRLF
					Next
				Case 3
					For $i=0 To $amount0
						$xy2=$inputHeight0-$i*$blok-$blok
						$FileText&='  [  '&$xy1&'  '&$xy2&'  .undef ]' & @CRLF
					Next
				Case 4
					For $i=0 To $amount0
						$xy2=$i*$blok
						$FileText&='  [  '&$xy1&'  '&$xy2&'  .undef ]' & @CRLF
					Next
			EndSwitch
			
			$file = FileOpen($FileName, 2)
			If $file = -1 Then
				MsgBox(0, "Ошибка", "Не возможно открыть файл.")
				Exit
			EndIf
			FileWrite($file, $FileText)
			FileClose($file)
			ShellExecute($FileName)
		Case $msg = -3
			ExitLoop
	EndSelect
WEnd