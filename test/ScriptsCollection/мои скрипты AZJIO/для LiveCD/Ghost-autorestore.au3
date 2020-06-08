;  @AZJIO
#NoTrayIcon

FileChangeDir(@ScriptDir)

Global $Ini = @ScriptDir & '\ghost_auto.ini', $sWinTitleRE = '[CLASS:GhostScreen]'

If FileExists('B:\ghost_auto.ini') Then $Ini = 'B:\ghost_auto.ini'

If Not FileExists($Ini) And MsgBox(4, "Сообщение", "Хотите создать необходимый ghost_auto.ini для возможности изменять параметры?") = 6 Then IniWriteSection($Ini, "Ghost", 'dsk="1:1"' & @LF & 'gho="1:2"' & @LF & 'Path2="\SYS\ImageHDD\myhdd.gho"')

$dsk = IniRead($Ini, "Ghost", "dsk", "1:1")
$gho = IniRead($Ini, "Ghost", "gho", "1:2")
$Path5 = IniRead($Ini, "Ghost", "Path2", "\SYS\ImageHDD\myhdd.gho")

GUICreate("!!! - ОПАСНО - !!!", 600, 400)

GUISetFont(12, 300)
$Attention = GUICtrlCreateLabel("Внимание!", 260, 8, 320, 22)
GUICtrlSetColor(-1, 0xff0000)
GUICtrlSetFont(-1, 15)
$read = GUICtrlCreateLabel("     Если вас не предупредили о функции восстановления для текущего компьютера или вы случайно запустили этот скрипт, то закройте это окно. При нажатии кнопки восстановления и при условии существования образа для восстановления произойдёт копирование содержимого образа на диск C: с полным уничтожением данных на диске C:." & @CRLF & "     Если вы желаете восстановить операционную систему из образа, то перед восстановлением нужно проверить личные файлы на диске С: и перенести их на диск D:, только после этого нажать кнопку восстановления." & @CRLF & "     При нажатии восстановления появится полоса прогресса копирования данных, по окончании появится диалоговое окно с кнопками Reset (перезагрузить) и Continue (продолжить), выбираем Reset и загружаемся в восстановленную операционную систему." & @CRLF & "     При копировании данных нельзя выполнять отмену перезагрузкой. Альтернативный способ восстановления - открыть образ и выполнить извлечение, переименовав предварительно системные каталоги на диске C:.", 10, 35, 580, 282)
$iContMenu = GUICtrlCreateContextMenu($read)
$iGhost_Auto_ini = GUICtrlCreateMenuItem("Посмотреть ghost_auto.ini", $iContMenu)
$iReadme = GUICtrlCreateMenuItem("Подробней о восстановлении", $iContMenu)
$iStartGhost = GUICtrlCreateMenuItem("Старт Ghost32", $iContMenu)

$iRestore = GUICtrlCreateButton("Восстановление Windows XP из образа", 135, 325, 330, 45)
GUICtrlSetTip(-1, "!!! ОПАСНО !!! Автовосстановление" & @LF & "из образа в спец-каталоге диска D" & @LF & "настройки в ghost_auto.ini")
GUICtrlSetFont(-1, 13)

GUISetState()
While 1
	Switch GUIGetMsg()
		Case $iRestore
			ShellExecute(@ScriptDir & '\ghost32.exe', '-clone,mode=pload,src=' & $gho & $Path5 & ':1,dst=' & $dsk & ' -sure', '', '', @SW_HIDE)
		Case $iGhost_Auto_ini
			ShellExecute($Ini, "", @ScriptDir, "")
		Case $iReadme
			ShellExecute(@ScriptDir & '\autoreadme.txt', "", @ScriptDir, "")
		Case $iStartGhost
			If WinExists($sWinTitleRE) Then ; если окно существует, то
				WinActivate($sWinTitleRE) ; активируем окно
			Else ; иначе
				Run(@ScriptDir & '\ghost32.exe -SPLIT=2048', '', @SW_HIDE) ; запускаем Ghost32
				$hWnd = WinWait($sWinTitleRE, '', 5) ; ожидаем окно (запуск программы)
				If Not $hWnd Then
					MsgBox(4096, 'Сообщение', 'Не удалось запустить Ghost32, завершаем работу скрипта')
					Exit
				EndIf
				If WinWaitActive($hWnd) Then ; если дождались, что окно активное, то
					Send("{Enter}") ; Эмуляция нажатий клавиш
					Send("{RIGHT}")
					Send("{DOWN}")
					Send("{RIGHT}")
					Send("{DOWN}")
				EndIf
			EndIf
		Case -3
			Exit
	EndSwitch
WEnd