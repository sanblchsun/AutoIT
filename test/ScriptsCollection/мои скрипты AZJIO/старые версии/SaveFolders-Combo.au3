;  @AZJIO 25.03.2010
; сохраняем несколько сесий, при старте программы все сессии в текущем каталоге будут найдены и можно переключаться между ними. Особенно удобно при переключениями между виндами или LiveCD, когда нужно открыть сессию каталогов, создав рабочую обстановку.
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=SaveFolders.exe
#AutoIt3Wrapper_icon=SaveFolders.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=SaveFolders.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#NoTrayIcon
Global $sTmp

GUICreate("SaveFolders v0.3", 500, 180)

GUICtrlCreateLabel("Сессия", 15, 15, 41, 18)
$Session = GUICtrlCreateCombo("", 15, 32, 470, 25, 0x3) ; $CBS_DROPDOWNLIST=0x3 - стиль нередактируемого комбобокса.

GUICtrlCreateLabel("Список папок", 15, 71, 74, 18)
$Folderlist = GUICtrlCreateCombo("", 15, 88, 470, 25, 0x3)

$OpenF = GUICtrlCreateButton("Папка", 310, 12, 73, 20)
GUICtrlSetTip(-1, "Открыть папку файла сессии")

$Open = GUICtrlCreateButton("Открыть", 390, 12, 73, 20)
GUICtrlSetTip(-1, "Открыть сессию")

$Upd_list = GUICtrlCreateButton("Обновить", 310, 68, 73, 20)
GUICtrlSetTip(-1, "Обновить список")

$Save = GUICtrlCreateButton("Сохранить", 390, 68, 73, 20)
GUICtrlSetTip(-1, "Сохранить папки в сессию")

$close = GUICtrlCreateButton("Закрыть все папки", 80, 130, 130, 33)
GUICtrlSetTip(-1, "Из текущего списка")

$Openfolder = GUICtrlCreateButton("Открыть все папки", 290, 130, 130, 33)
GUICtrlSetTip(-1, "Из текущего списка")

;$auto = GUICtrlCreateCheckbox("авто открытие", 340, 134, 97, 18)
;GUICtrlSetState($auto, 1)

_GetWindows() ; чтение текущих каталогов
_search() ; создать список сессий

GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $OpenF
			$file=GUICtrlRead ($Session)
			If $file='текущая' Then
				Run('Explorer.exe "'&@ScriptDir&'"')
			Else
				$file = StringRegExpReplace($file, "(^.*)\\(.*)$", '\1')
				Run('Explorer.exe "'&$file&'"')
			EndIf
		Case $msg = $Upd_list
			_GetWindows()
			
		Case $msg = $Save
			$file_save = FileSaveDialog( "Сохраняем сессию", @ScriptDir & "", "Session (*.inc)", 24, "Session.inc")
			If @error Then ContinueLoop
			If StringRight($file_save, 4 )<>'.inc' Then $file_save&='.inc'
			$file = FileOpen($file_save, 2)
			If $file = -1 Then
 			   MsgBox(0, "Ошибка", "Невозможно открыть файл.")
 			   ContinueLoop
			EndIf
			FileWrite($file, $sTmp)
			FileClose($file)
			GUICtrlSendMsg($Session, 0x14B, 0, 0)
			_search()
			
		Case $msg = $Open
			$file_open = FileOpenDialog("Открываем сессию", @ScriptDir & "", "Session (*.inc)", 1 + 4 , "Session.inc")
			If @error Then ContinueLoop
			$file = FileOpen($file_open, 0)
			If $file = -1 Then
 			   MsgBox(0, "Ошибка", "Невозможно открыть файл.")
 			   ContinueLoop
			EndIf
			$sTmp = FileRead($file)
			GUICtrlSetData($Session, $file_open) 
			GUICtrlSetData($Folderlist, $sTmp) 
			FileClose($file)
			
		Case $msg = $Openfolder
			$aPath = StringSplit($sTmp, "|")
			For $i=1 To $aPath [0]
				If FileExists($aPath[$i]) Then Run('Explorer.exe "'&$aPath[$i]&'"')
			Next
			Sleep(300)
			_GetWindows()
			Sleep(300)
			WinActivate ( "SaveFolders") 
			
		Case $msg = $close
			_close()
			_GetWindows()
			
		Case $msg = $Session
			$file_open=GUICtrlRead ($Session)
			If $file_open ='текущая' Then
			_GetWindows()
			Else
			$file = FileOpen($file_open, 0)
			If $file = -1 Then
 			   MsgBox(0, "Ошибка", "Невозможно открыть файл.")
 			   ContinueLoop
			EndIf
			$sTmp = FileRead($file)
			FileClose($file)
			GUICtrlSetData($Session, $file_open) 
			If $sTmp <> '' Then
			GUICtrlSendMsg($Folderlist, 0x14B, 0, 0)
			GUICtrlSetData($Folderlist, $sTmp)
			EndIf
			EndIf
			
		Case $msg = $Folderlist
			;If GUICtrlRead ($auto)=1 Then
				$myFolder = GUICtrlRead($Folderlist)
				If FileExists($myFolder) Then
					Run('Explorer.exe "'&$myFolder&'"')
					;ShellExecute($myFolder, "", $myFolder) ; выполнение открытие каталога
				EndIf
			;EndIf
		Case $msg = -3
			Exit
	EndSelect
WEnd

; 1 функция чтения текущих каталогов и заполнение их в комбобокс
Func _GetWindows() ; функция самостоятельная, ничего не получает, только создаёт список процессов.
	GUICtrlSendMsg($Folderlist, 0x14B, 0, 0) ; очистка комбобокс
	$AllWindows = WinList() ; вернуть весь список окон, массив с заголовком и идентификатором
	$sTmp = ""
	For $i = 1 To $AllWindows[0][0]
		; находим окна созданные эксплорером и создаём список для комбобокса
		If _IsVisible($AllWindows[$i][1]) and $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 12)='explorer.exe' Then
			If $sTmp = "" Then
				$sTmp &= ControlGetText ( $AllWindows[$i][0], '', "[CLASS:Edit; INSTANCE:1]") ; создаём список путей
			Else
				$sTmp &= "|"&ControlGetText ( $AllWindows[$i][0], '', "[CLASS:Edit; INSTANCE:1]")
			EndIf
		EndIf
	Next
	If $sTmp <> "" Then
		GUICtrlSetData($Folderlist, $sTmp) ; устанавливаем список в комбобокс
	Else
		GUICtrlSetData($Folderlist, "<Нет процессов>")
	EndIf
EndFunc

; 2 функция закрытия окон, аналогичная _GetWindows(), но с WinClose
Func _close()
	$AllWindows = WinList()
	$sTmp = ""
	For $i = 1 To $AllWindows[0][0]
		If _IsVisible($AllWindows[$i][1]) And $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 12)='explorer.exe' Then
				WinClose($AllWindows[$i][0])
		EndIf
	Next
EndFunc

; 3 Функция существования процесса, вызываемая предыдущей функцией
Func _IsVisible($handle) ; проверка открытых окон и свёрнутых на панель задач
	If BitAND(WinGetState($handle), 4) and BitAND(WinGetState($handle), 2) Then ; Вернуть параметры состояния указанного окна. | Выполнить побитовое логическое умножение AND. Первое выражение равно 4, значит процесс существует, второе выражение равно либо 0, либо 2. Если 0, то else Return 0, если 2, то Return 1
			Return 1
		Else
			Return 0 ; это значит процесс игнорировать
	EndIf
EndFunc

; 4 поиск сессий
Func _search()
$sestmp='текущая'
$search = FileFindFirstFile(@ScriptDir & "\*.inc")
If $search <> -1 Then
While 1
    $file = FileFindNextFile($search) 
    If @error Then ExitLoop
	$sestmp&='|'&@ScriptDir & "\"&$file
WEnd
EndIf
FileClose($search)
GUICtrlSetData($Session, $sestmp, 'текущая')
EndFunc

; 5 зная PID получить путь к файлу создавшему процесс
Func _ProcessGetPath($PID)
    If IsString($PID) Then $PID = ProcessExists($PID)
    $Path = DllStructCreate('char[1000]')
    $dll = DllOpen('Kernel32.dll')
    $handle1 = DllCall($dll, 'int', 'OpenProcess', 'dword', 0x0400 + 0x0010, 'int', 0, 'dword', $PID)
    $ret = DllCall('Psapi.dll', 'long', 'GetModuleFileNameEx', 'long', $handle1[0], 'int', 0, 'ptr', DllStructGetPtr($Path), 'long', DllStructGetSize($Path))
    $ret = DllCall($dll, 'int', 'CloseHandle', 'hwnd', $handle1[0])
    DllClose($dll)
    Return DllStructGetData($Path, 1)
EndFunc