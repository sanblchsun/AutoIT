;  @AZJIO 15.05.2010
; панелька для сохранения и ввода готовых конструкций кода AutoIt3 в редакторы Notepad++ и SciTE
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <MenuConstants.au3>
#include <WinAPI.au3>
#include <Misc.au3> ; _SendEx

HotKeySet("^{F11}", "_copybyfer")

;#NoTrayIcon
Global $defaultstatus = "Ready", $status
Global $initext, $kol, $aSet, $createF=0
Global $Ini = @ScriptDir & '\pf_set.ini' ; путь к pf_set.ini
;Проверка существования pf_set.ini
If Not FileExists($Ini) Then
	If MsgBox(4, "Выгодное предложение", "Хотите создать необходимый pf_set.ini?" & @CRLF & "Иначе выход.") = "6" Then
		$iniopen = FileOpen($Ini, 2)
		FileWrite($iniopen, '302,46,2,30|Notepad++|AU3.ini|1')
		FileClose($iniopen)
	Else
		Exit
	EndIf
EndIf

$iniopen = FileOpen($ini, 0) ; читаем настройки pf_set.ini
$setinitext = FileRead($iniopen)
FileClose($iniopen)
$aSet = StringSplit($setinitext, '|')

If Not FileExists(@ScriptDir & '\' & $aSet[3]) Then ; проверяем наличие профильного ini-файла кнопок
	If MsgBox(4, "Выгодное предложение", "Хотите создать необходимый файл примера AU3.ini и BAT.ini?" & @CRLF & "Иначе выход.") = "6" Then
		If FileExists(@ScriptDir & '\AU3.ini') Or FileExists(@ScriptDir & '\BAT.ini') Then
			If MsgBox(4, "Предостережение", "Один из файлов AU3.ini и BAT.ini существуют, перезаписать их?" & @CRLF & "Сделайте их копию перед продолжением. Иначе выход.") = "6" Then
				_createfile()
			Else
				Exit
			EndIf
		Else
			_createfile()
		EndIf
	Else
		Exit
	EndIf
EndIf

; создание оболочки
$aPos = StringSplit($aSet[1], ',')
$Gui = GUICreate("панель", $aPos[1], $aPos[2], $aPos[3], $aPos[4], BitOR($WS_POPUP, $WS_THICKFRAME, $WS_SIZEBOX, $WS_SYSMENU))
GUISetBkColor(0x3f3f3f)
$filemenu = GUICtrlCreateMenu("Файл")
$Quit2 = GUICtrlCreateMenuItem("Перезапуск панели", $filemenu)
$recreate = GUICtrlCreateMenuItem("Добавить образец из буфера", $filemenu)
$Saveini = GUICtrlCreateMenuItem("Сохранить текущие настройки", $filemenu)
$Savepatt = GUICtrlCreateMenuItem("Сохранить панель как...", $filemenu)
$onerow = GUICtrlCreateMenuItem("Кнопки всегда в один ряд", $filemenu)
$Editini = GUICtrlCreateMenuItem("Редактировать ini", $filemenu)
$Openini = GUICtrlCreateMenuItem("Открыть ini", $filemenu)
GUICtrlCreateMenuItem("", $filemenu)
$Npad = GUICtrlCreateMenuItem("Использовать Notepad++", $filemenu)
$SciTE = GUICtrlCreateMenuItem("Использовать SciTE", $filemenu)
GUICtrlCreateMenuItem("", $filemenu)
$Quit1 = GUICtrlCreateMenuItem("Выход", $filemenu)

If $aSet[2] = "Notepad++" Then
	GUICtrlSetState($Npad,$GUI_CHECKED)
Else
	GUICtrlSetState($SciTE,$GUI_CHECKED)
EndIf

If $aSet[4] = 1 Then
	GUICtrlSetState($onerow,$GUI_CHECKED)
Else
	GUICtrlSetState($onerow,$GUI_UNCHECKED)
EndIf

$delmenu = GUICtrlCreateMenu("Удаление")

$inimenu = GUICtrlCreateMenu("ini")

$search = FileFindFirstFile(@ScriptDir & "\*.ini") ; поиск профильных ini с добавлением в меню ini
If $search <> -1 Then
$vk=0
$tmpfinif=''
For $v = 1 To 20
    $file_open = FileFindNextFile($search)
    If $file_open = 'pf_set.ini' Then ContinueLoop
    If @error Then ExitLoop
	Assign('inipath' & $v, $file_open)
	Assign('finif' & $v, GUICtrlCreateMenuItem($file_open, $inimenu))
	If $file_open=$aSet[3] Then
		GUICtrlSetState(Eval('finif' & $v),$GUI_CHECKED)
		$tmpfinif=Eval('finif' & $v)
	EndIf
	If $vk=0 Then $FirstFile=$file_open
	$vk+=1
Next
EndIf
FileClose($search)

If FileExists(@ScriptDir & '\' &$aSet[3]) Then $FirstFile=$aSet[3]
$iniopen = FileOpen(@ScriptDir&'\'&$FirstFile, 0) ; чтение первого найденного профиля или указанного в ini
$initext = FileRead($iniopen)
FileClose($iniopen)

$helpmenu = GUICtrlCreateMenu("?")
$helpitem = GUICtrlCreateMenuItem("О программе", $helpmenu)


$aPattern = StringRegExp($initext, '(?s)z\]\r\n(.*?)(?=\r\n\[z)', 3)
$kol = UBound($aPattern) - 1

$Width = $aPos[1] - Mod($aPos[1], 30) ; вычисление позиции кнопок при старте скрипта (12 строк)
$y = 0
$x = 0
$posy = 1
For $i = 0 To $kol
	$x += 1
	If $x * 30 > $Width And $aSet[4]=0 Then
		$x = 1
		$y += 1
		$posy = $y * 25 + 1
	EndIf
	$posx = $x * 30 - 29
	
	$tmp = StringSplit($aPattern[$i], '|')
	Assign('Button' & $i, GUICtrlCreateButton($tmp[1], $posx, $posy, 30, 25))
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetTip(-1, $tmp[2])
	Assign('execute' & $i, $tmp[2])
	Assign('name_b' & $i, $tmp[1])
	Assign('del' & $i, GUICtrlCreateMenuItem("Удалить - "&$tmp[1], $delmenu))
Next

$r = 0
GUISetState()


While 1
	$msg = GUIGetMsg()
	_SendMessage($Gui, $WM_SYSCOMMAND, BitOR($SC_MOVE, $HTCAPTION), 0) ; для перемещения окна за само окно
	For $i = 0 To $kol
		If $msg = Eval('Button' & $i) Then _insert(Eval('execute' & $i)) ; проверка кликов по кнопке
		If $msg = Eval('del' & $i) Then _delitem($i) ; проверка кликов по итемам удаления
	Next
	
	For $i = 1 To $vk ; выбор ini с обновлением кнопок
		If $msg = Eval('finif' & $i) Then
			GUICtrlSetState($tmpfinif,$GUI_UNCHECKED) ; три строки установки галочек
			$tmpfinif = Eval('finif' & $i)
			GUICtrlSetState(Eval('finif' & $i),$GUI_CHECKED)
			$FirstFile=Eval('inipath' & $i) ; понадобится для сохранения
			$file = FileOpen(@ScriptDir &'\'&$FirstFile,0)
			$initext=FileRead($file)
			FileClose($file)
			$r = 0
			
			
; удаление патерна-кнопки и повторное разделение переменной на патерны
For $i = 0 To $kol
	GUICtrlDelete(Eval('Button' & $i))
	GUICtrlDelete(Eval('execute' & $i))
	GUICtrlDelete(Eval('name_b' & $i))
	GUICtrlDelete(Eval('del' & $i))
Next

$aPattern = StringRegExp($initext, '(?s)z\]\r\n(.*?)(?=\r\n\[z)', 3)
$kol = UBound($aPattern) - 1

$Width = $aPos[1] - Mod($aPos[1], 30); вычисление позиции кнопок при старте скрипта (12 строк)
;If $aSet[4]=1 Then $aPos[1] = $kol*30+38
$y = 0
$x = 0
$posy = 1
For $i = 0 To $kol
	$x += 1
	If $x * 30 > $Width And $aSet[4]=0 Then
		$x = 1
		$y += 1
		$posy = $y * 25 + 1
	EndIf
	$posx = $x * 30 - 29
	
	$tmp = StringSplit($aPattern[$i], '|')
	Assign('Button' & $i, GUICtrlCreateButton($tmp[1], $posx, $posy, 30, 25))
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetTip(-1, $tmp[2])
	Assign('execute' & $i, $tmp[2])
	Assign('name_b' & $i, $tmp[1])
	Assign('del' & $i, GUICtrlCreateMenuItem("Удалить - "&$tmp[1], $delmenu))
Next
			
		EndIf
	Next
	 ; конец выбор ini с обновлением кнопок

	 ; распределение кнопок и установка размеров окна
	$r += 1
	If $r = 200 Then ; каждые 0,2 секунд проверка распределения кнопок
		$r = 0
		$GuiPos = WinGetPos($Gui)
		$Width = $GuiPos[2] - Mod($GuiPos[2], 30) ; ширине окна по кнопкам
		$y = 0
		$x = 0
		$posy = 1
		For $i = 0 To $kol
			$x += 1
			If $x * 30 > $GuiPos[2] And $aSet[4]=0 Then
				$x = 1
				$y += 1
				$posy = $y * 25 + 1
			EndIf
			$posx = $x * 30 - 29
			GUICtrlSetPos(Eval('Button' & $i), $posx, $posy)
		Next
			$GuiPos[2]=$GuiPos[2]-Mod( $GuiPos[2], 30 )+3; подгоняем размер под кнопки окна при ресайзе (пять строк), можно закомментировать их.
			If $kol * 30 < $GuiPos[2] Then $GuiPos[2]=$kol * 30+38
			If $y > 0 Then $GuiPos[2]=$Width+8
			If $aSet[4]=1 Then $GuiPos[2] = $kol*30+38
			If $GuiPos[2] < 212 Then $GuiPos[2]=212
			WinMove($Gui, "", $GuiPos[0], $GuiPos[1], $GuiPos[2], $posy+51) 
	EndIf
	 ; конец распределение кнопок и установка размеров окна

	Select
		Case $msg = $onerow
			If $aSet[4]=1 Then
				$aSet[4]=0
				GUICtrlSetState($onerow,$GUI_UNCHECKED)
			Else
				$aSet[4]=1
				GUICtrlSetState($onerow,$GUI_CHECKED)
			EndIf
		Case $msg = $Savepatt
			$savefile = FileSaveDialog( "Сохраняем в файл.", @WorkingDir & "", "файл патернов (*.ini)", 2, "имя только на англ. яз.")
			If @error Then ContinueLoop
			If StringRight($savefile, 4 )<>'.ini' Then $savefile&='.ini'
			$file = FileOpen($savefile, 2)
			If $file = -1 Then
				MsgBox(0, "Ошибка", "Невозможно открыть файл.")
			    ContinueLoop
			EndIf
			FileWrite($file, $initext)
			FileClose($file)
			   
		Case $msg = $Openini
			$folder01 = FileOpenDialog("Указать файл", @WorkingDir & "", "Файл конструкций (*.ini)", 1 + 4 )
			If @error Then ContinueLoop
				$file = FileOpen($folder01,0)
				$initext=FileRead($file)
				FileClose($file)
				$r = 0
; удаление патерна-кнопки и повторное разделение переменной на патерны
For $i = 0 To $kol
	GUICtrlDelete(Eval('Button' & $i))
	GUICtrlDelete(Eval('execute' & $i))
	GUICtrlDelete(Eval('name_b' & $i))
	GUICtrlDelete(Eval('del' & $i))
Next

$aPattern = StringRegExp($initext, '(?s)z\]\r\n(.*?)(?=\r\n\[z)', 3)
$kol = UBound($aPattern) - 1

$Width = $aPos[1] - Mod($aPos[1], 30); вычисление позиции кнопок при старте скрипта (12 строк)
;If $aSet[4]=1 Then $aPos[1] = $kol*30+38
$y = 0
$x = 0
$posy = 1
For $i = 0 To $kol
	$x += 1
	If $x * 30 > $Width And $aSet[4]=0 Then
		$x = 1
		$y += 1
		$posy = $y * 25 + 1
	EndIf
	$posx = $x * 30 - 29
	
	$tmp = StringSplit($aPattern[$i], '|')
	Assign('Button' & $i, GUICtrlCreateButton($tmp[1], $posx, $posy, 30, 25))
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetTip(-1, $tmp[2])
	Assign('execute' & $i, $tmp[2])
	Assign('name_b' & $i, $tmp[1])
	Assign('del' & $i, GUICtrlCreateMenuItem("Удалить - "&$tmp[1], $delmenu))
Next
		Case $msg = $Saveini
			$GuiPos = WinGetPos($Gui)
			$GuiPos[2]=$GuiPos[2]-Mod( $GuiPos[2], 30 )+2 ; подгоняем размер под кнопки окна при сохранении (четыре строки), можно закомментировать их.
			If $kol * 30 < $GuiPos[2] Then $GuiPos[2]=$kol * 30+32
			If $kol * 30 < 178 Then $GuiPos[2]=212
			$GuiPos[3]=$posy+45
			$setinitext = $GuiPos[2] & ',' & $GuiPos[3] & ',' & $GuiPos[0] & ',' & $GuiPos[1] & '|' & $aSet[2] & '|' & $FirstFile & '|' & $aSet[4]
			$iniopen = FileOpen($Ini, 2)
			FileWrite($iniopen, $setinitext)
			FileClose($iniopen)
			$iniopen = FileOpen(@ScriptDir&'\'&$FirstFile, 2)
			FileWrite($iniopen, $initext)
			FileClose($iniopen)

		Case $msg = $recreate Or $createF = 1
			If $createF = 1 Then
				$createF = 0
				_SendEx("^{ins}")
			EndIf
			$newButtom = ClipGet()
			$nameButt = StringRegExpReplace($newButtom, "(?sx).*?(\w{3}).*", '\1')
			If StringLen($nameButt)> 3 Then $nameButt= StringMid($nameButt, 1, 3)
			$varnew = InputBox("Сообщение", 'Введите имя кнопки' & @CRLF & 'желательно три символа', $nameButt, "", 170, 150, $GuiPos[0], $GuiPos[3] + $GuiPos[1])
			If $varnew = '' Then
				ContinueLoop
			Else
				$initext &= @CRLF & $varnew & '|' & $newButtom & @CRLF & '[z--z]'
			EndIf
			If $y=0 Then
			$GuiPos = WinGetPos($Gui)
			$GuiPos[2]+=30
			WinMove($Gui, "", $GuiPos[0], $GuiPos[1], $GuiPos[2],$GuiPos[3])
			EndIf
			$kol += 1
			Assign('Button' & $kol, GUICtrlCreateButton($varnew, 1, 1, 30, 25))
			GUICtrlSetTip(-1, $newButtom)
			GUICtrlSetResizing(-1, $GUI_DOCKALL)
			Assign('execute' & $kol, $newButtom)
			Assign('name_b' & $kol, $varnew)
			Assign('del' & $kol, GUICtrlCreateMenuItem("Удалить - "&$varnew, $delmenu))
			$r = 0

		Case $msg = $Npad
			$aSet[2] = 'Notepad++'
			GUICtrlSetState($Npad,$GUI_CHECKED)
			GUICtrlSetState($SciTE,$GUI_UNCHECKED)

		Case $msg = $SciTE
			$aSet[2] = 'SciTEWindow'
			GUICtrlSetState($SciTE,$GUI_CHECKED)
			GUICtrlSetState($Npad,$GUI_UNCHECKED)

		Case $msg = $helpitem
			MsgBox(0, 'О программе', 'Панелька для вставки готовых конструкций'&@CRLF&'кода в окно редактора Notepad++ или SciTE.'&@CRLF&'Ctrl+F11 - добавить выделенный текст как'&@CRLF&'кнопку-образец на панель.'&@CRLF&@CRLF&'		@AZJIO 15.05.2010')
		Case $msg = $Editini
			ShellExecute(@ScriptDir & '\' & $FirstFile, "", @ScriptDir, "")
		Case $msg = -3 Or $msg = $Quit1
			Exit
		Case $msg = $Quit2
			_restart()
	EndSelect
WEnd

Func _copybyfer()
	$createF=1
EndFunc

Func _delitem($d)
; удаление патерна-кнопки и повторное разделение переменной на патерны
$initext = StringRegExpReplace($initext, '(?s)\[z--z\]\r\n('&Eval('name_b' & $d)&'\|.*?)(?=\[z)', '')
$aPattern = StringRegExp($initext, '(?s)z\]\r\n(.*?)(?=\r\n\[z)', 3)
For $i = 0 To $kol
	GUICtrlDelete(Eval('Button' & $i))
	GUICtrlDelete(Eval('execute' & $i))
	GUICtrlDelete(Eval('name_b' & $i))
	GUICtrlDelete(Eval('del' & $i))
Next

$kol = UBound($aPattern) - 1

; вычисление позиции кнопок при старте скрипта (12 строк)
If $aSet[4]=1 Then $aPos[1] = $kol*30+38
$y = 0
$x = 0
$posy = 1
For $i = 0 To $kol
	$x += 1
	If $x * 30 > $aPos[1] Then
		$x = 1
		$y += 1
		$posy = $y * 25 + 1
	EndIf
	$posx = $x * 30 - 29
	
	$tmp = StringSplit($aPattern[$i], '|')
	Assign('Button' & $i, GUICtrlCreateButton($tmp[1], $posx, $posy, 30, 25))
	GUICtrlSetResizing(-1, $GUI_DOCKALL)
	GUICtrlSetTip(-1, $tmp[2])
	Assign('execute' & $i, $tmp[2])
	Assign('name_b' & $i, $tmp[1])
	Assign('del' & $i, GUICtrlCreateMenuItem("Удалить - "&$tmp[1], $delmenu))
			
;MsgBox(0, 'Сообщение', Eval('Button' & $i)&@CRLF&Eval('execute' & $i)&@CRLF&Eval('name_b' & $i)&@CRLF&Eval('del' & $i))
Next
EndFunc

Func _insert($pattern)
	$NP = '[CLASS:' & $aSet[2] & ']' ; здесь можно указать другой редактор, или в ini
	If WinExists($NP) Then
		WinActivate($NP)
		WinWaitActive($NP)
		$byfertmp=ClipGet()
		ClipPut($pattern)
		Send("+{ins}")
		ClipPut($byfertmp)
		$byfertmp=''
	EndIf
EndFunc

Func _restart()
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
EndFunc

Func _SendEx($sSend_Data)
    Local $hUser32DllOpen = DllOpen("User32.dll")
    While _IsPressed("10", $hUser32DllOpen) Or _IsPressed("11", $hUser32DllOpen) Or _IsPressed("12", $hUser32DllOpen)
        Sleep(10)
    WEnd
    Send($sSend_Data)
    DllClose($hUser32DllOpen)
EndFunc

Func _createfile()
		$iniopen = FileOpen(@ScriptDir & '\AU3.ini', 2)
		FileWrite($iniopen, _
'[z--z]' & @CRLF & _
'Msg|' & @CRLF & _
'MsgBox(0, ''Сообщение'', $text)' & @CRLF & _
'Exit' & @CRLF & _
'[z--z]' & @CRLF & _
'FW|' & @CRLF & _
'$file = FileOpen(@ScriptDir&''\file.txt'',2)' & @CRLF & _
'FileWrite($file, $text)' & @CRLF & _
'FileClose($file)' & @CRLF & _
'Exit' & @CRLF & _
'[z--z]' & @CRLF & _
'FR|' & @CRLF & _
'$file = FileOpen(@ScriptDir&''\file.txt'', 0)' & @CRLF & _
'$text = FileRead($file)' & @CRLF & _
'FileClose($file)' & @CRLF & _
'[z--z]' & @CRLF & _
'If|' & @CRLF & _
'If $var = 0 Then' & @CRLF & _
'	' & @CRLF & _
'Else' & @CRLF & _
'	' & @CRLF & _
'EndIf' & @CRLF & _
'[z--z]' & @CRLF & _
'Sw|' & @CRLF & _
'Switch @HOUR' & @CRLF & _
'	Case 6 To 11' & @CRLF & _
' 	   $msg = "Доброе утро"' & @CRLF & _
'	Case 12 To 17' & @CRLF & _
'	    $msg = "Доброго дня"' & @CRLF & _
'	Case 18 To 21' & @CRLF & _
'	    $msg = "Добрый вечер"' & @CRLF & _
'	Case Else' & @CRLF & _
' 	   $msg = "Доброй ночи"' & @CRLF & _
'EndSwitch' & @CRLF & _
'[z--z]' & @CRLF & _
'Wh|' & @CRLF & _
'While 1 ; если условие верно, то выполнить цикл' & @CRLF & _
'    MsgBox(0, "Сообщение", ''Вот опять сообщение'')' & @CRLF & _
'WEnd' & @CRLF & _
'[z--z]' & @CRLF & _
'Se|' & @CRLF & _
'Select' & @CRLF & _
'    Case $var = 1' & @CRLF & _
'        MsgBox(0, "", "Если 1 тогда")' & @CRLF & _
'    Case $var2 = "test"' & @CRLF & _
'        MsgBox(0, "", "Если test тогда")' & @CRLF & _
'    Case Else' & @CRLF & _
'        MsgBox(0, "", "Иначе")' & @CRLF & _
'EndSelect' & @CRLF & _
'[z--z]' & @CRLF & _
'DU|' & @CRLF & _
'Do' & @CRLF & _
'    MsgBox(0, "Сообщение", ''Вот опять сообщение'')' & @CRLF & _
'Until 0 ; если условие верно, то не повторять цикл' & @CRLF & _
'[z--z]' & @CRLF & _
'cse|' & @CRLF & _
'#cs' & @CRLF & _
'Блок комментариев' & @CRLF & _
'#ce' & @CRLF & _
'[z--z]' & @CRLF & _
'FU|' & @CRLF & _
'Func _funcname()' & @CRLF & _
'    return (@MON & "/" & @MDAY & "/" & @YEAR)' & @CRLF & _
'EndFunc' & @CRLF & _
'[z--z]')
		FileClose($iniopen)

		$iniopen = FileOpen(@ScriptDir & '\BAT.ini', 2)
		FileWrite($iniopen, _
'[z--z]' & @CRLF & _
'ech|@echo off' & @CRLF & _
'color 3b' & @CRLF & _
'title' & @CRLF & _
'[z--z]' & @CRLF & _
'xFi|' & @CRLF & _
'xcopy "путь\имя_файла" "%windir%\SYSTEM32\" /Q /H /Y /K /C' & @CRLF & _
'[z--z]' & @CRLF & _
'xFo|' & @CRLF & _
'xcopy "путь\папка" "новый_путь\новая_папка" /Q /H /Y /K /C /E /I' & @CRLF & _
'[z--z]' & @CRLF & _
'n-v|' & @CRLF & _
'%var:~n%' & @CRLF & _
'[z--z]' & @CRLF & _
'IF|' & @CRLF & _
'IF NOT EXIST ELSE' & @CRLF & _
'[z--z]' & @CRLF & _
'-1v|' & @CRLF & _
'SET var=%~dp0' & @CRLF & _
'SET var=%var:~0,-1%' & @CRLF & _
'[z--z]' & @CRLF & _
'CLS|' & @CRLF & _
'CLS' & @CRLF & _
'echo.' & @CRLF & _
'echo.' & @CRLF & _
'echo ================================================' & @CRLF & _
'echo этот текст должен быть в дос-кодировке 866' & @CRLF & _
'echo ================================================' & @CRLF & _
'echo.' & @CRLF & _
'pause' & @CRLF & _
'[z--z]' & @CRLF & _
'MNU|@echo off' & @CRLF & _
'color 3b' & @CRLF & _
'title MENU' & @CRLF & _
@CRLF & _
':: русский текст должен быть в дос-кодировке 866' & @CRLF & _
':MENU' & @CRLF & _
'CLS' & @CRLF & _
'ECHO Нажмите номер вашего выбора на клавиатуре (1,2,3)' & @CRLF & _
'echo.' & @CRLF & _
'ECHO 1 - действие первое старт Paint' & @CRLF & _
'ECHO 2 - действие второе старт Блокнот' & @CRLF & _
'ECHO 3 - действие третье старт Калькулятора' & @CRLF & _
'echo.' & @CRLF & _
'ECHO __________________________________________' & @CRLF & _
'SET /P Choice=Введите число и жмите Enter:' & @CRLF & _
'IF /I ''%Choice%''==''1'' GOTO 1' & @CRLF & _
'IF /I ''%Choice%''==''2'' GOTO 2' & @CRLF & _
'IF /I ''%Choice%''==''3'' GOTO 3' & @CRLF & _
'GOTO MENU' & @CRLF & _
@CRLF & _
':1' & @CRLF & _
'start mspaint.exe' & @CRLF & _
'GOTO end' & @CRLF & _
@CRLF & _
':2' & @CRLF & _
'start notepad.exe' & @CRLF & _
'GOTO end' & @CRLF & _
@CRLF & _
':3' & @CRLF & _
'start calc.exe' & @CRLF & _
'GOTO end' & @CRLF & _
@CRLF & _
':end' & @CRLF & _
'exit' & @CRLF & _
'[z--z]' & @CRLF & _
'%Pr|%ProgramFiles%' & @CRLF & _
'[z--z]' & @CRLF & _
'%SR|%SystemRoot%' & @CRLF & _
'[z--z]' & @CRLF & _
'%wd|%windir%' & @CRLF & _
'[z--z]' & @CRLF & _
'%TM|%TEMP%' & @CRLF & _
'[z--z]' & @CRLF & _
'%SD|%SystemDrive%' & @CRLF & _
'[z--z]' & @CRLF & _
'%CP|%COMMONPROGRAMFILES%' & @CRLF & _
'[z--z]' & @CRLF & _
'%AU|%AllUsersProfile%' & @CRLF & _
'[z--z]' & @CRLF & _
'%UP|%UserProfile%' & @CRLF & _
'[z--z]' & @CRLF & _
'%SS|%SystemRoot%\SYSTEM32' & @CRLF & _
'[z--z]')
		FileClose($iniopen)
EndFunc
