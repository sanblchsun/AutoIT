;  @AZJIO 24.04.2010
; сохраняем несколько сесий, при старте программы все сессии в текущем каталоге будут найдены и можно переключаться между ними. Особенно удобно при переключениями между виндами или LiveCD, когда нужно открыть сессию каталогов, создав рабочую обстановку.
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=SaveFolders.exe
#AutoIt3Wrapper_icon=SaveFolders.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=SaveFolders.exe
#AutoIt3Wrapper_Res_Fileversion=0.8.0.0
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

Opt("TrayOnEventMode", 1)
Opt("TrayMenuMode", 1)

Global $sTmp, $d, $file, $file_open0
Global $avTrayItems[1] ;создаём с чередующимся через три элемента массив, с элементами идентификации ID, имя пункта, имя меню. К массиву будем добавлять по три элемента группой.

TraySetIcon('shell32.dll', -111)

; Окно "Редактирование сессии"
$nMain = GUICreate("Редактировать сессию", 602, 285, -1, -1, -1, 0x00000010) ;drag-and-drop
GUISetIcon("shell32.dll",-111)
GUISetBkColor (0xF9F9F9)
$Label5 = GUICtrlCreateLabel('Имя файла', 10,3,260,16)
GUICtrlCreateLabel ("используйте drag-and-drop", 400,3,200,16)

$Folderlist = GUICtrlCreateList ("", 10, 24, 580, 230)
GUICtrlSetState(-1, 8)

$nOpen = GUICtrlCreateButton ("Добавить", 160, 255, 80, 24)
$nDel = GUICtrlCreateButton ("Удалить пункт", 250, 255, 90, 24)
$nRestart = GUICtrlCreateButton ("Перезапуск", 350, 255, 80, 24)
GUICtrlSetTip(-1, "Для обновления в трее"&@CRLF&"требуется перезапуск")


$search = FileFindFirstFile(@ScriptDir & "\*.inc")
If $search <> -1 Then
For $d = 1 To 20
    $file_open = FileFindNextFile($search) 
    If @error Then ExitLoop
	_add(25)
Next
EndIf
FileClose($search)

$nEmptily = TrayCreateItem("") 

$curent = TrayCreateMenu("текущие при старте")

$allfoldercur= TrayCreateItem('Открыть эти каталоги', $curent)
TrayItemSetOnEvent(-1, "_allfolder")
_ArrayAdd( $avTrayItems,Eval('allfoldercur'))
_ArrayAdd( $avTrayItems,'O')
_ArrayAdd( $avTrayItems, 'grup0')
$nEmptily = TrayCreateItem("", $curent)

$y=0
$AllWindows = WinList()
For $i = 1 To $AllWindows[0][0]
	If _IsVisible($AllWindows[$i][1]) and $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 12)='explorer.exe' Then
		$y+=1
		Assign('grup0' & $y, TrayCreateItem(ControlGetText ( $AllWindows[$i][0], '', "[CLASS:Edit; INSTANCE:1]"), $curent))
        TrayItemSetOnEvent(-1, "_TrayItemHit")
			_ArrayAdd( $avTrayItems,Eval('grup0' & $y))
			_ArrayAdd( $avTrayItems,ControlGetText ( $AllWindows[$i][0], '', "[CLASS:Edit; INSTANCE:1]"))
			_ArrayAdd( $avTrayItems, 'grup0_' & $y)
	EndIf
Next

$nEmptily = TrayCreateItem("") 

$action = TrayCreateMenu("Действия")

$nUpd= TrayCreateItem("Перезапуск для обновление списка текущих", $action)
TrayItemSetOnEvent(-1, "_restart")

$nSave= TrayCreateItem("Сохранить открытые каталоги и перезапуск", $action)
TrayItemSetOnEvent(-1, "_save")

$nClose= TrayCreateItem("Закрыть открытые каталоги", $action)
TrayItemSetOnEvent(-1, "_close")

$nAdd= TrayCreateItem("Добавить сессию", $action)
TrayItemSetOnEvent(-1, "_addses")

$nSFolder= TrayCreateItem("Папка программы", $action)
TrayItemSetOnEvent(-1, "_sfolder")

$nAbout= TrayCreateItem("О программе", $action)
TrayItemSetOnEvent(-1, "_about")

;_ArrayDisplay( $avTrayItems, "Смотрим текущий массив" )
HotKeySet('!{ESC}', "_Quit") ;по желанию выход по ALT+ESC
HotKeySet("{F2}", "_Rename") ; переименование файлов не затрагивая расширение
HotKeySet("{F1}", "_Rename2") ; переименование файлов
HotKeySet("{F9}", "_CreateFT") ; создаём папку
$CrTx="{F10}"
HotKeySet($CrTx, "_CreateFT") ; создаём файл текстовый
$langdef = RegRead("HKCU\Keyboard Layout\Preload", "1") ; читаем язык по умолчанию
$nExit = TrayCreateItem("Выход") 
TrayItemSetOnEvent(-1, "_Quit")

TraySetState()

While 1
    Sleep(20)
WEnd

Func _GUI() ; вызов окна "Редактирование сессии"
	;Opt("TrayIconHide", 1) ; скрываем иконку в трее
;деактивация пунктов
For $i = 1 To UBound($avTrayItems) - 1 Step 3
$n = _ArraySearch($avTrayItems, $avTrayItems[$i], 1)
TrayItemSetState($avTrayItems[$n],128)
    If @error Then ExitLoop
Next
TrayItemSetState($nAdd,128)
TrayItemSetState($nUpd,128)
TrayItemSetState($nSave,128)
TrayItemSetState($nClose,128)
	
	$msg = $nMain
	GUISetState()
	_edit()
	$file_open = StringRegExpReplace($file_open0, "(^.*)\\(.*)$", '\2')
	GUICtrlSetData($Label5, $file_open)
	$file = FileOpen($file_open0, 0)
	If $file = -1 Then
 	   MsgBox(0, "Ошибка", "Невозможно открыть файл.")
 	   return
	EndIf
	$sTmp = FileRead($file)
	FileClose($file)
	$aPath = StringSplit($sTmp, "|")
	GUICtrlDelete($Folderlist)
	$Folderlist = GUICtrlCreateList ("", 10, 24, 580, 230)
	GUICtrlSetState(-1, 8)
	GUICtrlSetData($Folderlist, $sTmp)
While 1
    Sleep(10)
    $msg = GUIGetMsg()
    Select
		; drag-and-drop
        Case $msg = -13
			If StringInStr(FileGetAttrib(@GUI_DRAGFILE), "D") = 0 Then ContinueLoop
			If StringInStr($sTmp&'|', @GUI_DRAGFILE&'|')>0 Then
				MsgBox(0, "Предупреждение", "Добавляемый путь существует в сессии"&@CRLF&"и не будет добавлен.")
				ContinueLoop
			EndIf
			$sTmp &= "|"&@GUI_DRAGFILE
			_updedit()

		 ; кнопка "удалить"
        Case $msg = $nDel
			$myFolder = GUICtrlRead($Folderlist)
			$myFolder=StringRegExpReplace($myFolder,"[][{}()+.\\^$=#]", "\\$0")
			$sTmp = StringRegExpReplace($sTmp&'|', $myFolder&'\|', '')
			;$sTmp = StringRegExpReplace($sTmp, '\|\|', '|')
			;If StringLeft( $sTmp, 1 )='|' Then $sTmp = StringTrimLeft( $sTmp ,1 )
			If StringRight( $sTmp, 1 )='|' Then $sTmp = StringTrimRight( $sTmp ,1 )
			_updedit()

		;кнопка "Добавить"
        Case $msg = $nOpen
			$addfold = FileSelectFolder ( "Выбрать добавляемую папку",'')
			If @error Then ContinueLoop
			If StringInStr($sTmp, $addfold)>0 Then
				MsgBox(0, "Предупреждение", "Добавляемый путь существует в сессии"&@CRLF&"и не будет добавлен.")
				ContinueLoop
			EndIf
			$sTmp &= "|"&$addfold
			_updedit()
	
        Case $msg = $nRestart
            _restart()
        Case $msg = -3
			;Opt("TrayIconHide", 0)
			;активация пунктов
For $i = 1 To UBound($avTrayItems) - 1 Step 3
$n = _ArraySearch($avTrayItems, $avTrayItems[$i], 1)
TrayItemSetState($avTrayItems[$n],64)
    If @error Then ExitLoop
Next
TrayItemSetState($nAdd,64)
TrayItemSetState($nUpd,64)
TrayItemSetState($nSave,64)
TrayItemSetState($nClose,64)
            GUISetState(@SW_HIDE, $nMain)
            ExitLoop
    EndSelect
WEnd
EndFunc

; обновление файла при редактировании сессии
Func _updedit()
			$file = FileOpen($file_open0, 2)
			If $file = -1 Then
				MsgBox(0, "Ошибка", "Невозможно открыть файл.")
				return
			EndIf
			FileWrite($file, $sTmp)
			FileClose($file)
			GUICtrlDelete($Folderlist)
			$Folderlist = GUICtrlCreateList ("", 10, 24, 580, 230)
			GUICtrlSetState(-1, 8)
			GUICtrlSetData($Folderlist, $sTmp)
EndFunc  ;==>_addses

; добавить сессию
Func _addses()
	TrayItemSetState(@TRAY_ID,4)
	$y=0
	$d+=1
	$file_open = FileOpenDialog("Открываем сессию", @ScriptDir & "", "Session (*.inc)", 1 + 4 , "Session.inc")
	If @error Then return
	_add(0)
EndFunc  ;==>_addses

; добавить пункты в меню трея для файлов сессий
Func _add($sor)
	$file = FileOpen($file_open, 0)
	If $file = -1 Then
 	   MsgBox(0, "Ошибка", "Невозможно открыть файл.")
 	   return
	EndIf
	$sTmp = FileRead($file)
	FileClose($file)
	$aPath = StringSplit($sTmp, "|")
	$file_open0=$file_open
	If StringInStr($file_open, "\")>0 Then $file_open = StringRegExpReplace($file_open, "(^.*)\\(.*)$", '\2')
	$file_open = StringTrimRight( $file_open, 4 ) 
	Assign('Session' & $d, TrayCreateMenu ($file_open,-1,$sor))
	
	Assign('edit' & $d, TrayCreateItem('Редактировать сессию', Eval('Session' & $d)))
	TrayItemSetOnEvent(-1, "_GUI")
	_ArrayAdd( $avTrayItems,Eval('edit' & $d))
	_ArrayAdd( $avTrayItems,'E')
	If StringInStr($file_open0, "\")=0 Then $file_open0 = @ScriptDir & "\" & $file_open0
	_ArrayAdd( $avTrayItems,$file_open0)
	
	Assign('allfolder' & $d, TrayCreateItem('Открыть эти каталоги', Eval('Session' & $d)))
	TrayItemSetOnEvent(-1, "_allfolder")
	_ArrayAdd( $avTrayItems,Eval('allfolder' & $d))
	_ArrayAdd( $avTrayItems,'O')
	_ArrayAdd( $avTrayItems,'grup' & $d)
	
	Assign('sesfolclose' & $d, TrayCreateItem('Закрыть эти каталоги', Eval('Session' & $d)))
	TrayItemSetOnEvent(-1, "_sesfolclose")
	_ArrayAdd( $avTrayItems,Eval('sesfolclose' & $d))
	_ArrayAdd( $avTrayItems,'C')
	_ArrayAdd( $avTrayItems,'grup' & $d)
	
	$nEmptily = TrayCreateItem("", Eval('Session' & $d))
	$y=0
	For $i = 1 To $aPath[0]
		If FileExists($aPath[$i]) Then
			$y+=1
			Assign('grup' & $d & '_' & $y, TrayCreateItem($aPath[$i], Eval('Session' & $d)))
			TrayItemSetOnEvent(-1, "_TrayItemHit")
			_ArrayAdd( $avTrayItems,Eval('grup' & $d & '_' & $y))
			_ArrayAdd( $avTrayItems,$aPath[$i])
			_ArrayAdd( $avTrayItems,'grup' & $d & '_' & $y)
		EndIf
	Next
EndFunc  ;==>_add

Func _save()
	TrayItemSetState(@TRAY_ID,4)
	$file_save = FileSaveDialog( "Сохраняем сессию", @ScriptDir & "", "Session (*.inc)", 24, "Session.inc")
	If @error Then return
	If StringRight($file_save, 4 )<>'.inc' Then $file_save&='.inc'
	$file = FileOpen($file_save, 2)
	If $file = -1 Then
 	   MsgBox(0, "Ошибка", "Невозможно открыть файл.")
 	   return
	EndIf
	$AllWindows = WinList()
	$sTmp = ""
	For $i = 1 To $AllWindows[0][0]
		If _IsVisible($AllWindows[$i][1]) And $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 12)='explorer.exe' Then
			If $sTmp = "" Then
				$sTmp &= ControlGetText ( $AllWindows[$i][0], '', "[CLASS:Edit; INSTANCE:1]") ; создаём список путей
			Else
				$sTmp &= "|"&ControlGetText ( $AllWindows[$i][0], '', "[CLASS:Edit; INSTANCE:1]")
			EndIf
		EndIf
	Next
	FileWrite($file, $sTmp)
	FileClose($file)
	_restart()
EndFunc  ;==>_save

; редактировать сессию, поиск ID элемента, считывание пути, отправление для редактирования
Func _edit()
	TrayItemSetState(@TRAY_ID,128+4)
    Local $n = _ArraySearch($avTrayItems, @TRAY_ID, 1)
    If @error Then
		MsgBox(0, "Ошибка", 'Не найден ID')
		Exit
    EndIf
		$n+=2
	$file_open0=$avTrayItems[$n]
EndFunc  ;==>_edit

; открыть все папки, поиск ID элемента, считывание имя группы, открытие папок группы
Func _allfolder()
	TrayItemSetState(@TRAY_ID,4)
    Local $n = _ArraySearch($avTrayItems, @TRAY_ID, 1)
    If @error Then
		MsgBox(0, "Ошибка", 'Не найден ID')
		Exit
    EndIf
		$n+=2
For $i = 1 To 35
	$z = _ArraySearch($avTrayItems, $avTrayItems[$n]&'_'&$i, 1)
    If @error Then ExitLoop
	$z-=1
    If Not FileExists($avTrayItems[$z]) Then ExitLoop
    Run('Explorer.exe "'&$avTrayItems[$z]&'"')
Next
EndFunc  ;==>_allfolder

; открыть все папки, поиск ID элемента, считывание имя группы, открытие папок группы
Func _sesfolclose()
	TrayItemSetState(@TRAY_ID,4)
    Local $n = _ArraySearch($avTrayItems, @TRAY_ID, 1)
    If @error Then
		MsgBox(0, "Ошибка", 'Не найден ID')
		Exit
    EndIf
		$n+=2
For $i = 1 To 35
	$z = _ArraySearch($avTrayItems, $avTrayItems[$n]&'_'&$i, 1)
    If @error Then ExitLoop
	$z-=1
	; в обоих случаях, когда имя окна может быть путь и имя папки
	$file_open = StringRegExpReplace($avTrayItems[$z], "(^.*)\\(.*)$", '\2')
	If WinExists($avTrayItems[$z]) And _IsVisible($avTrayItems[$z]) And StringRight(_ProcessGetPath(WinGetProcess($avTrayItems[$z])), 12)='explorer.exe' Then WinClose($avTrayItems[$z])
	If WinExists($file_open) And _IsVisible($file_open) And StringRight(_ProcessGetPath(WinGetProcess($file_open)), 12)='explorer.exe' Then WinClose($file_open)
Next
EndFunc  ;==>_sesfolclose

; считывание ID пункта меню, поиск в массиве, сдвиг на 1 и открыть путь
Func _TrayItemHit()
	TrayItemSetState(@TRAY_ID,4)
    Local $i = _ArraySearch($avTrayItems, @TRAY_ID, 1)
    If @error Then
		MsgBox(16, "Error", 'ошибка блин')
		Exit
    EndIf
		$i+=1
    If Not FileExists($avTrayItems[$i]) Then
        MsgBox(16, "Error", "нет папки")
        Return
    EndIf
    Run('Explorer.exe "'&$avTrayItems[$i]&'"')
EndFunc  ;==>_TrayItemHit

; проверка открытых окнон
Func _IsVisible($handle)
	If BitAND(WinGetState($handle), 4) and BitAND(WinGetState($handle), 2) Then
			Return 1
		Else
			Return 0
	EndIf
EndFunc  ;==>_IsVisible

;извлечь путь процесса зная PID
Func _ProcessGetPath($PID)
    If IsString($PID) Then $PID = ProcessExists($PID)
    $Path = DllStructCreate('char[1000]')
    $dll = DllOpen('Kernel32.dll')
    $handle1 = DllCall($dll, 'int', 'OpenProcess', 'dword', 0x0400 + 0x0010, 'int', 0, 'dword', $PID)
    $ret = DllCall('Psapi.dll', 'long', 'GetModuleFileNameEx', 'long', $handle1[0], 'int', 0, 'ptr', DllStructGetPtr($Path), 'long', DllStructGetSize($Path))
    $ret = DllCall($dll, 'int', 'CloseHandle', 'hwnd', $handle1[0])
    DllClose($dll)
    Return DllStructGetData($Path, 1)
EndFunc  ;==>_ProcessGetPath

; закрытие открытых окон
Func _close()
	TrayItemSetState(@TRAY_ID,4)
	$AllWindows = WinList()
	$sTmp = ""
	For $i = 1 To $AllWindows[0][0]
		If _IsVisible($AllWindows[$i][1]) And $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 12)='explorer.exe' Then
				WinClose($AllWindows[$i][0])
		EndIf
	Next
EndFunc  ;==>_close

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
EndFunc  ;==>_restart

Func _Quit()
    Exit
EndFunc

; собственно #include <Array.au3>
Func _ArrayAdd(ByRef $avArray, $vValue)
If Not IsArray($avArray) Then Return SetError(1, 0, -1)
If UBound($avArray, 0) <> 1 Then Return SetError(2, 0, -1)
Local $iUBound = UBound($avArray)
ReDim $avArray[$iUBound + 1]
$avArray[$iUBound] = $vValue
Return $iUBound
EndFunc
Func _ArraySearch(Const ByRef $avArray, $vValue, $iStart = 0, $iEnd = 0, $iCase = 0, $iPartial = 0, $iForward = 1, $iSubItem = -1)
If Not IsArray($avArray) Then Return SetError(1, 0, -1)
If UBound($avArray, 0) > 2 Or UBound($avArray, 0) < 1 Then Return SetError(2, 0, -1)
Local $iUBound = UBound($avArray) - 1
If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(4, 0, -1)
Local $iStep = 1
If Not $iForward Then
Local $iTmp = $iStart
$iStart = $iEnd
$iEnd = $iTmp
$iStep = -1
EndIf
Switch UBound($avArray, 0)
Case 1
If Not $iPartial Then
If Not $iCase Then
For $i = $iStart To $iEnd Step $iStep
If $avArray[$i] = $vValue Then Return $i
Next
Else
For $i = $iStart To $iEnd Step $iStep
If $avArray[$i] == $vValue Then Return $i
Next
EndIf
Else
For $i = $iStart To $iEnd Step $iStep
If StringInStr($avArray[$i], $vValue, $iCase) > 0 Then Return $i
Next
EndIf
Case 2
Local $iUBoundSub = UBound($avArray, 2) - 1
If $iSubItem > $iUBoundSub Then $iSubItem = $iUBoundSub
If $iSubItem < 0 Then
$iSubItem = 0
Else
$iUBoundSub = $iSubItem
EndIf
For $j = $iSubItem To $iUBoundSub
If Not $iPartial Then
If Not $iCase Then
For $i = $iStart To $iEnd Step $iStep
If $avArray[$i][$j] = $vValue Then Return $i
Next
Else
For $i = $iStart To $iEnd Step $iStep
If $avArray[$i][$j] == $vValue Then Return $i
Next
EndIf
Else
For $i = $iStart To $iEnd Step $iStep
If StringInStr($avArray[$i][$j], $vValue, $iCase) > 0 Then Return $i
Next
EndIf
Next
Case Else
Return SetError(7, 0, -1)
EndSwitch
Return SetError(6, 0, -1)
EndFunc

Func _Rename2()
	$window=WinGetTitle('')
    If (_WinGetClass($window) = "CabinetWClass") Or (_WinGetClass($window) = "Progman") Then
    HotKeySet("{F1}")
    HotKeySet("{F2}")
    Send("{F2}")
    HotKeySet("{F2}", "_Rename")
    HotKeySet("{F1}", "_Rename2")
	Else
    HotKeySet("{F1}")
    Send("{F1}")
    HotKeySet("{F1}", "_Rename2")
    EndIf
EndFunc

; функцию _Rename заимствовал у Monamo, немного изменив.
;http://www.autoitscript.com/forum/index.php?showtopic=88903
Func _Rename()
    HotKeySet("{F2}"); откл. горячей клавиши
    Send("{F2}")
	$window=WinGetTitle('')
		$adrPath= ControlGetText ( $window, '', "[CLASS:Edit; INSTANCE:1]")
    If (_WinGetClass($window) = "CabinetWClass") Or (_WinGetClass($window) = "Progman") Then
        $oldClipboard = ClipGet()
        Sleep(100)
        Send("^{insert}")
        $sFilename = ClipGet()
		If StringInStr(FileGetAttrib($adrPath & "\" & $sFilename), "D") = 0 Then ; проверка что объёкт является файлом
        $iExtPosition = StringInStr($sFilename, ".", 0, -1)
        If $iExtPosition <> 0 Then
            $iPosition = StringLen($sFilename) - $iExtPosition+1
            $i = 0
            Do
                Send("+{LEFT}")
                $i += 1
            Until $i = $iPosition
            Send("{SHIFTDOWN}{SHIFTUP}")
        EndIf
        EndIf
        ClipPut($oldClipboard)
    EndIf
    HotKeySet("{F2}", "_Rename"); возвращаем hotkey
EndFunc

Func _WinGetClass($hWnd)
; credit = SmOke_N from post http://www.autoitscript.com/forum/index.php?showtopic=41622&view=findpost&p=309799
    If IsHWnd($hWnd) = 0 And WinExists($hWnd) Then $hWnd = WinGetHandle($hWnd)
    Local $aGCNDLL = DllCall('User32.dll', 'int', 'GetClassName', 'hwnd', $hWnd, 'str', '', 'int', 4095)
    If @error = 0 Then Return $aGCNDLL[2]
    Return SetError(1, 0, '')
EndFunc

Func _CreateFT()
	$window=WinGetTitle('')
	If $window <> "" And $window <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($window)), 13)='\explorer.exe' Then
		$win_handle = WinGetHandle ($window)
		_SetKeyboardLayout("00000419", $win_handle)
		Send("!{ф}")
		Sleep(100)
		Send("{а}")
		If @HotKeyPressed=$CrTx Then
			Send("{т}") ; текстовый документ
			_Rename()
		Else
			Send("{п}") ; папка
		EndIf
		_SetKeyboardLayout($langdef, $win_handle) ; возвращаем язык по умолчанию
	EndIf
EndFunc
 
; переключение раскладки клавиатуры
Func _SetKeyboardLayout($sLayoutID, $hWnd)
    Local $ret = DllCall("user32.dll", "long", "LoadKeyboardLayout", "str", $sLayoutID, "int", 0)
    DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", 0x50, "int", 1, "int", $ret[0])
EndFunc

Func _sfolder()
    Run('Explorer.exe "'&@ScriptDir&'"')
EndFunc

Func _about()
MsgBox(0, "О программе SaveFolders v0.8", "Горячие клавиши"&@CRLF& _
"F1 - переименование c расширением"&@CRLF& _
"F2 - переименование без расширения"&@CRLF& _
"F9 - создание папки"&@CRLF& _
"F10 - создание текстового файла"&@CRLF& _
"ALT+ESC - выход"&@CRLF&@CRLF&"		@AZJIO 24.04.2010")
EndFunc