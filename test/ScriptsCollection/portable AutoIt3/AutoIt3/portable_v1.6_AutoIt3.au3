;  @AZJIO 19.03.2010
#NoTrayIcon
Global $AutInp0, $RedInp01, $RedInp02, $OpenCom0, $EditCom0, $CompCom0, $RunCom0, $aPathAut0, $err1, $run_m0, $OpenCom, $EditCom, $CompCom, $RunCom, $filesave1, $aRegList
$as='HKCR\AutoIt3Script'

$Gui = GUICreate("Portable AutoIt3",  528, 401, -1, -1, -1, 0x00000010)
$StatusBar = GUICtrlCreateLabel('Строка состояния', 5,383,560,18)
GUICtrlCreateLabel ("используйте drag-and-drop", 250,3,200,18)

$tab=GUICtrlCreateTab (0,2, 528,401-20) ; размер вкладки
$hTab = GUICtrlGetHandle($tab)
$tab1=GUICtrlCreateTabitem ("AutoIt3") ; имя вкладки

$assreg = GUICtrlCreateButton("Ассоциировать", 380, 40, 122, 25)
GUICtrlSetTip(-1, "Зарегистрировать расширение"&@CRLF&"и контекстное меню с AutoIt3")
$zareg = GUICtrlCreateButton("Зарегистрировать", 380, 71, 122, 25)
GUICtrlSetTip(-1, "Аналогично установке AutoIt3")
$delreg = GUICtrlCreateButton("Удалить регистрацию", 380, 102, 122, 25)
GUICtrlSetTip(-1, "Удалить все упоминания"&@CRLF&"об AutoIt3 в реестре")
$reau3 = GUICtrlCreateButton("1 Создать re_au3", 380, 133, 107, 25)
GUICtrlSetTip(-1, "Для переназначения из контекстного меню"&@CRLF&"Выполнять или Открывать скрипт кликом мыши.")
$reau4 = GUICtrlCreateButton("2 Создать re_au3", 380, 164, 107, 25)
GUICtrlSetTip(-1, "Нестандартный вариант, но даёт возможность"&@CRLF&"в справке выполнять скрипты вместо открытия в редакторе.")
$reaust3 = GUICtrlCreateButton("s", 487, 133, 15, 25)
GUICtrlSetTip(-1, "Выполнить re_au3.au3")
$reaust4 = GUICtrlCreateButton("s", 487, 164, 15, 25)
GUICtrlSetTip(-1, "Выполнить re_au3.au3")

$lang=GUICtrlCreateGroup ("Язык контекстного меню", 345, 195, 150, 55)
GUIStartGroup()
$russet = GUICtrlCreateRadio("Russian", 350, 211, 67, 20)
GUICtrlSetTip(-1, "Обновить раскрывающиеся списки")
$enset = GUICtrlCreateRadio("English", 350, 228, 67, 20)
GUICtrlSetTip(-1, "Обновить раскрывающиеся списки")

$act=GUICtrlCreateGroup ("Действие кликом мыши", 345, 255, 150, 55)
GUIStartGroup()
$run_m = GUICtrlCreateRadio("Выполнить скрипт", 350, 271, 137, 20)
GUICtrlSetTip(-1, "Сохраняется при выборе")
$open_m = GUICtrlCreateRadio("Открыть скрипт", 350, 288, 137, 20)
GUICtrlSetTip(-1, "Сохраняется при выборе")
If RegRead($as&"\Shell", "") = "Run" Then
	GUICtrlSetState ($run_m,1)
Else
	GUICtrlSetState ($open_m,1)
EndIf

$AutLab = GUICtrlCreateLabel("Путь к AutoIt3.exe", 24, 40, 130, 17)
$AutInp = GUICtrlCreateInput("", 24, 57, 305, 21)
GUICtrlSetState(-1,8)
$folder1 = GUICtrlCreateButton("...", 337, 56, 27, 23)
GUICtrlSetFont (-1,13)

$RedLab1 = GUICtrlCreateLabel("Путь к основному редактору", 24, 90, 186, 17)
$RedInp1 = GUICtrlCreateInput("", 24, 107, 305, 21)
GUICtrlSetState(-1,8)
$folder2 = GUICtrlCreateButton("...", 337, 106, 27, 23)
GUICtrlSetFont (-1,13)

$RedLab2 = GUICtrlCreateLabel("Путь к дополнительному редактору", 24, 140, 186, 17)
$RedInp2 = GUICtrlCreateInput("", 24, 157, 305, 21)
GUICtrlSetState(-1,8)
$folder3 = GUICtrlCreateButton("...", 337, 156, 27, 23)
GUICtrlSetFont (-1,13)

$OpenLab=GUICtrlCreateLabel ('Пункт "Открыть"', 20,200,130,20)
$OpenCom=GUICtrlCreateCombo ("", 150,197,180,18)

$EditLab=GUICtrlCreateLabel ('Пункт "Изменить"', 20,230,130,20)
$EditCom=GUICtrlCreateCombo ("", 150,227,180,18)

$CompLab=GUICtrlCreateLabel ('Пункт "Компилировать"', 20,260,130,20)
$CompCom=GUICtrlCreateCombo ("", 150,257,180,18)

$RunLab=GUICtrlCreateLabel ('Пункт "Выполнить"', 20,290,130,20)
$RunCom=GUICtrlCreateCombo ("", 150,287,180,18)

If RegRead($as&"\Shell\Open", "") = "Open" Then
	GUICtrlSetState ($enset,1)
	_langen()
Else
	GUICtrlSetState ($russet,1)
	_langrus()
EndIf

$auopen = GUICtrlCreateButton("открыть", 152, 37, 55, 20)
GUICtrlSetTip(-1, "Открыть каталог")
$aureg = GUICtrlCreateButton("v реестр", 213, 37, 55, 20)
GUICtrlSetTip(-1, "Прочитать путь из реестра")
$cl = GUICtrlCreateButton("Очистить", 274, 37, 55, 20)
GUICtrlSetTip(-1, "Очистить все (3) поля ввода")

$edreg1 = GUICtrlCreateButton("v реестр", 213, 87, 55, 20)
GUICtrlSetTip(-1, "Прочитать путь из реестра")
$root1 = GUICtrlCreateButton("v корень", 274, 87, 55, 20)
GUICtrlSetTip(-1, "Копировать путь от корня AutoIt3.exe")

$edreg2 = GUICtrlCreateButton("v реестр", 213, 137, 55, 20)
GUICtrlSetTip(-1, "Прочитать путь из реестра")
$root2 = GUICtrlCreateButton("v корень", 274, 137, 55, 20)
GUICtrlSetTip(-1, "Копировать путь от корня AutoIt3.exe")

$Save = GUICtrlCreateButton("Save", 344, 320, 57, 23)
GUICtrlSetTip(-1, "Сохранить путь к AutoIt3"&@CRLF&"создание списка версий.")

$SaveCom=GUICtrlCreateCombo ("", 24,405,305,22)
GUICtrlSetTip(-1, "Список версий")

If FileExists(@ScriptDir&"\vAutoIt3.txt") Then
	GUICtrlSetPos($SaveCom, 24,320)
	$filesave = FileOpen(@ScriptDir&"\vAutoIt3.txt", 0)
	$filesave1 = FileRead($filesave)
	GUICtrlSetData($SaveCom,$filesave1, '')
	FileClose($filesave)
EndIf

$folder4 = GUICtrlCreateButton("Добавить", 344, 350, 57, 23)
GUICtrlSetTip(-1, "Добавить пункт"&@CRLF&"в контекстное меню")
$delitem = GUICtrlCreateButton("Удалить", 411, 350, 57, 23)
GUICtrlSetTip(-1, "Удалить пункт"&@CRLF&"из контекстного меню"&@CRLF&"указанный в списке")
$savereg = GUICtrlCreateButton("SAVE REG", 411, 320, 57, 23)
GUICtrlSetTip(-1, "Сохранить настройки"&@CRLF&"из реестра в reg-файл")
$genlist=GUICtrlCreateCombo ("", 24,350,305,22)
GUICtrlSetTip(-1, "Список контекстного меню"&@CRLF&"в реестре")
_genlist()

$tab2=GUICtrlCreateTabitem ("    ?") ; имя вкладки
GUICtrlCreateLabel ('    Данная утилитка поможет портабельно использовать AutoIt3, а также переключаться между версиями; удалить из реестра всю информацию об использовании AutoIt3; назначить любой редактор в качестве основного или дополнительного; переключать действие клика мыши на скрипте в контекстном меню.'&@CRLF&'     Если редактор не указан или автоматически не найден, то ассоциации не прописываются. Наличие каталога Include не проверяется.'&@CRLF&'     Кнопка Save позволяет сохранять несколько путей с указанием версии в файл и при последующем старте выбрать необходимую версию из списка. Не добавляются пути уже существующие в списке. Младшие версии AutoIt3 создают более компактные exe-файлы.'&@CRLF&'     Кнопка "1 Создать re_au3" позволяет не открывая эту программу из контекстного меню скрипта переназначить клик мыши на скрипте между вариантами "Открыть" и "Выполнить".'&@CRLF&'Кнопка "2 Создать re_au3" создаёт нестандартный переназначатель, но с преимуществом: в справке вместо открытия скрипта он будет выполнятся, побочный эффект: в переключателе на радиокнопках "Действие кликом мыши" будет противоположно. Рекомендуется: радиокнопка всегда "Открыть скрипт", и нажатие последовательно кнопок "Ассоциировать" и "s", при условии, что выполнено "2 Создать re_au3"'&@CRLF&'     Кнопками "Добавить / Удалить" можно управлять контекстным меню, пункты которого отображаются в раскрывающемся списке ', 20,40,488,300)
GUICtrlCreateLabel ('@AZJIO  19.03.2010, v1.6', 380,350,130,20)
GUICtrlCreateTabitem ("")   ; конец вкладок

; устранение проблем интерфейса
Switch @OSVersion
    Case 'WIN_2000', 'WIN_XP', 'WIN_2003'
        $Part = 10
    Case Else
        $Part = 11
EndSwitch
$Color = _WinAPI_GetThemeColor($hTab, 'TAB', $Part, 1, 0x0EED)
If Not @error Then
    GUICtrlSetBkColor($russet, $Color)
    GUICtrlSetBkColor($enset, $Color)
    GUICtrlSetBkColor($run_m, $Color)
    GUICtrlSetBkColor($open_m, $Color)
    GUICtrlSetBkColor($lang, $Color)
    GUICtrlSetBkColor($act, $Color)
EndIf

;вызов функций автозаполнения input из реестра
_aureg()
_edreg1()
_edreg2()

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = -13
				If @GUI_DropID=$AutInp Then
					GUICtrlSetData($AutInp, @GUI_DRAGFILE)
					GUICtrlSetData ($StatusBar, "Выбран AutoIt3.exe, версия - "&FileGetVersion(@GUI_DRAGFILE))
				;заполнение полей редакторов реестровыми путями 
				_edreg1()
				_edreg2()
				EndIf
				If @GUI_DropID=$RedInp1 Then
					If StringRight(@GUI_DRAGFILE, 4) = ".lnk" Or StringRight(@GUI_DRAGFILE, 4) = ".exe"  Then
						If StringRight( @GUI_DRAGFILE, 4 )  = ".lnk" Then ; принятие если lnk (ярлык) и объект (exe) в переменную
							$aLNK = FileGetShortcut(@GUI_DRAGFILE)
							$EXE=$aLNK[0]
						EndIf
						If StringRight( @GUI_DRAGFILE, 4 )  = ".exe" Then $EXE=@GUI_DRAGFILE ; принятие exe-файла
						GUICtrlSetData($RedInp1, $EXE)
					Else
						MsgBox(0, "Ошибка", "Файл не является программой (*.exe).")
						GUICtrlSetData($RedInp1, '')
					Endif
				Endif
				If @GUI_DropID=$RedInp2 Then
					If StringRight(@GUI_DRAGFILE, 4) = ".lnk" Or StringRight(@GUI_DRAGFILE, 4) = ".exe"  Then
						If StringRight( @GUI_DRAGFILE, 4 )  = ".lnk" Then ; принятие если lnk (ярлык) и объект (exe) в переменную
							$aLNK = FileGetShortcut(@GUI_DRAGFILE)
							$EXE=$aLNK[0]
						EndIf
						If StringRight( @GUI_DRAGFILE, 4 )  = ".exe" Then $EXE=@GUI_DRAGFILE ; принятие exe-файла
						GUICtrlSetData($RedInp2, $EXE)
					Else
						MsgBox(0, "Ошибка", "Файл не является программой (*.exe).")
						GUICtrlSetData($RedInp2, '')
					Endif
				Endif
			Case $msg = $delreg
				_split()
				For $i=1 To $aRegList[0]
					RegDelete($aRegList[$i])
				Next
				GUICtrlSetData ($StatusBar, "Удаление регистрации в реестре выполнено.")
			Case $msg = $zareg
				_read()
				If $err1<>0 Then ContinueLoop
				RegWrite("HKCR\.au3","","REG_SZ",'AutoIt3Script')
				RegWrite($as,"","REG_SZ",'AutoIt v3 Script')
				RegWrite($as&"\Shell\Open","","REG_SZ",$OpenCom0)
				RegWrite($as&"\Shell\Open\Command","","REG_SZ",'"'&$RedInp01&'" "%1"')
				RegWrite($as&"\Shell\Run","","REG_SZ",$RunCom0)
				RegWrite($as&"\Shell\Run\Command","","REG_SZ",'"'&$AutInp0&'" "%1" %*')
				RegWrite($as&"\Shell\Compile","","REG_SZ",$CompCom0)
				RegWrite($as&"\Shell\Compile\Command","","REG_SZ",'"'&$aPathAut0[0]&'\Aut2Exe\Aut2Exe.exe" /in "%l"')
				RegWrite($as&"\Shell\Edit","","REG_SZ",$EditCom0)
				RegWrite($as&"\Shell\Edit\Command","","REG_SZ",'"'&$RedInp02&'" "%1"')
				
				RegWrite($as&"\Shell","","REG_SZ",$run_m0)
				RegWrite("HKCR\.au3\ShellNew","FileName","REG_SZ",'Template.au3')
				RegWrite("HKCR\.au3","PerceivedType","REG_SZ",'text')
				RegWrite("HKCR\.au3\PersistentHandler","","REG_SZ",'{5e941d80-bf96-11cd-b579-08002b30bfeb}')

				RegWrite("HKCR\AutoIt3XScript","","REG_SZ",'AutoIt v3 Encoded Script')
				RegWrite("HKCR\AutoIt3XScript\Shell","","REG_SZ",'Run')
				RegWrite("HKCR\AutoIt3XScript\Shell\Run","","REG_SZ",'Run Script')
				RegWrite("HKCR\AutoIt3XScript\Shell\Run\Command","","REG_SZ",'"'&$AutInp0&'" "%1" %*')

				RegWrite("HKCU\Software\AutoIt v3\Aut2Exe","LastExeDir","REG_SZ",'My Documents')
				RegWrite("HKCU\Software\AutoIt v3\Aut2Exe","LastScriptDir","REG_SZ",'My Documents')
				RegWrite("HKCU\Software\AutoIt v3\Aut2Exe","LastIconDir","REG_SZ",'"'&$aPathAut0[0]&'\Aut2Exe\Icons"')
				RegWrite("HKCU\Software\AutoIt v3\Aut2Exe","LastIcon","REG_SZ",'')
				RegWrite("HKCU\Software\AutoIt v3\Aut2Exe","LastCompression","REG_DWORD",'2')
				RegWrite("HKCU\Software\AutoIt v3\Aut2Exe","AllowDecompile","REG_DWORD",'1')

				RegWrite("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir","REG_SZ",$aPathAut0[0])
				RegWrite("HKLM\SOFTWARE\AutoIt v3\AutoIt","Version","REG_SZ",'v'&FileGetVersion($AutInp0))
				RegWrite("HKCR\.a3x","","REG_SZ",'AutoIt3XScript')

				RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Au3Info.exe","","REG_SZ",$aPathAut0[0]&'\Au3Info.exe')
				RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Aut2Exe.exe","","REG_SZ",$aPathAut0[0]&'\Aut2Exe\Aut2Exe.exe')
				RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AutoIt3.exe","","REG_SZ",$aPathAut0[0]&'\AutoIt3.exe')
				
				$un='HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AutoItv3'
				RegWrite($un,"DisplayName","REG_SZ",'AutoIt v'&FileGetVersion($AutInp0))
				RegWrite($un,"UninstallString","REG_SZ",$aPathAut0[0]&'\Uninstall.exe')
				RegWrite($un,"DisplayIcon","REG_SZ",$aPathAut0[0]&'\AutoIt3.exe,0')
				RegWrite($un,"URLInfoAbout","REG_SZ",'http://www.autoitscript.com/autoit3')
				RegWrite($un,"Publisher","REG_SZ",'AutoIt Team')
				RegWrite($un,"NoModify","REG_DWORD",'1')
				RegWrite($un,"NoRepair","REG_DWORD",'1')

				If FileExists ($aPathAut0[0]&'\AutoItX\AutoItX3.dll') Then ShellExecute(@SystemDir&'\regsvr32.exe','/s "'&$aPathAut0[0]&'\AutoItX\AutoItX3.dll"','','', @SW_HIDE )
				If FileExists ($aPathAut0[0]&'\Icons\au3script_v10.ico') Then 
					RegWrite($as&"\DefaultIcon","","REG_SZ",$aPathAut0[0]&'\Icons\au3script_v10.ico')
					RegWrite("HKCR\AutoIt3XScript\DefaultIcon","","REG_SZ",$aPathAut0[0]&'\Icons\au3script_v10.ico')
					DllCall("shell32.dll", "none", "SHChangeNotify", "long", '0x8000000', "uint", '0x1000', "ptr", '0', "ptr", '0')
				Endif
				GUICtrlSetData ($StatusBar, "Регистрация выполнена. Версия AutoIt3 - "&FileGetVersion($AutInp0))

			Case $msg = $assreg
				_read()
				If $err1<>0 Then ContinueLoop
					RegWrite("HKCR\.au3","","REG_SZ",'AutoIt3Script')
					RegWrite($as&"\Shell","","REG_SZ",$run_m0)
					RegWrite($as,"","REG_SZ",'AutoIt v3 Script')
					RegWrite($as&"\Shell\Open","","REG_SZ",$OpenCom0)
					RegWrite($as&"\Shell\Open\Command","","REG_SZ",'"'&$RedInp01&'" "%1"')
					RegWrite($as&"\Shell\Run","","REG_SZ",$RunCom0)
					RegWrite($as&"\Shell\Run\Command","","REG_SZ",'"'&$AutInp0&'" "%1" %*')
					RegWrite($as&"\Shell\Compile","","REG_SZ",$CompCom0)
					RegWrite($as&"\Shell\Compile\Command","","REG_SZ",'"'&$aPathAut0[0]&'\Aut2Exe\Aut2Exe.exe" /in "%l"')
					RegWrite($as&"\Shell\Edit","","REG_SZ",$EditCom0)
					RegWrite($as&"\Shell\Edit\Command","","REG_SZ",'"'&$RedInp02&'" "%1"')
				If FileExists ($aPathAut0[0]&'\Icons\au3script_v10.ico') Then 
						RegWrite($as&"\DefaultIcon","","REG_SZ",'"'&$aPathAut0[0]&'\Icons\au3script_v10.ico"')
						RegWrite("HKCR\AutoIt3XScript\DefaultIcon","","REG_SZ",'"'&$aPathAut0[0]&'\Icons\au3script_v10.ico"')
						DllCall("shell32.dll", "none", "SHChangeNotify", "long", '0x8000000', "uint", '0x1000', "ptr", '0', "ptr", '0')
				Endif
					RegWrite("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir","REG_SZ",$aPathAut0[0])
					;RegWrite($as&"\DefaultIcon","","REG_SZ",'assot.dll,20')
				GUICtrlSetData ($StatusBar, "Ассоциации выполнены. Версия AutoIt3 - "&FileGetVersion($AutInp0))
			Case $msg = $reau3
				_read()
				If $err1<>0 Then ContinueLoop
				RegWrite($as&"\Shell\rx_re","","REG_SZ",'Переназначить au3')
				RegWrite($as&"\Shell\rx_re\Command","","REG_SZ",'"'&$AutInp0&'" "'&$aPathAut0[0]&'\re_au3.au3" %*')
				$file = FileOpen($aPathAut0[0]&'\re_au3.au3', 2)
				$sText = '$au3 = RegRead("HKCR\AutoIt3Script\Shell", "")' & @CRLF & 'If RegRead("HKCR\AutoIt3Script\Shell\rx_re", "") = "" Then' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\rx_re","","REG_SZ","Переназначить au3")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\rx_re\Command","","REG_SZ","""'&$AutInp0&'"" ""'&$aPathAut0[0]&'\re_au3.au3"" %*")' & @CRLF &'EndIf'& @CRLF &'If $au3 = "Open" Then RegWrite("HKCR\AutoIt3Script\Shell","","REG_SZ","Run")'& @CRLF &'If $au3 = "Run" Then RegWrite("HKCR\AutoIt3Script\Shell","","REG_SZ","Open")'& @CRLF
				FileWrite($file, $sText)
				FileClose($file)
				GUICtrlSetData ($StatusBar, "Файл re_au3.au3 создан.")
				_genlist()
				
			Case $msg = $reau4
				_read()
				If $err1<>0 Then ContinueLoop
				RegWrite($as&"\Shell\rx_re","","REG_SZ",'Переназначить au3')
				RegWrite($as&"\Shell\rx_re\Command","","REG_SZ",'"'&$AutInp0&'" "'&$aPathAut0[0]&'\re_au3.au3" %*')
				$file = FileOpen($aPathAut0[0]&'\re_au3.au3', 2)
				$sText = '$au3 = RegRead("HKCR\AutoIt3Script\Shell\Open", "")' & @CRLF & 'If $au3 = "'&$OpenCom0&'" Then' & @CRLF &'; Старт' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Open","","REG_SZ","'&$RunCom0&'")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Open\Command","","REG_SZ","""'&$AutInp0&'"" ""%1"" %*")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Run","","REG_SZ","'&$OpenCom0&'")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Run\Command","","REG_SZ","""'&$RedInp01&'"" ""%1""")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\rx_re","","REG_SZ","Переназначить au3")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\rx_re\Command","","REG_SZ","""'&$AutInp0&'"" ""'&$aPathAut0[0]&'\re_au3.au3"" %*")' & @CRLF &'EndIf' & @CRLF & @CRLF &'If $au3 = "'&$RunCom0&'" Then' & @CRLF &'; Открыть' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Run","","REG_SZ","'&$RunCom0&'")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Run\Command","","REG_SZ","""'&$AutInp0&'"" ""%1"" %*")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Open","","REG_SZ","'&$OpenCom0&'")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Open\Command","","REG_SZ","""'&$RedInp01&'"" ""%1""")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\rx_re","","REG_SZ","Переназначить au3")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\rx_re\Command","","REG_SZ","""'&$AutInp0&'"" ""'&$aPathAut0[0]&'\re_au3.au3"" %*")' & @CRLF &'EndIf' & @CRLF
				FileWrite($file, $sText)
				FileClose($file)
				GUICtrlSetData ($StatusBar, "Файл re_au3.au3 создан.")
				_genlist()
					
					; кнопки выбора языка
			Case $msg = $russet
				_clear()
				_langrus()
			Case $msg = $enset
				_clear()
				_langen()
				
			Case $msg = $run_m
				RegWrite($as&"\Shell","","REG_SZ",'Run')
			Case $msg = $open_m
				RegWrite($as&"\Shell","","REG_SZ",'Open')
				
				;  мелкие кнопки
			Case $msg = $auopen
				$AutInp0=GUICtrlRead ($AutInp)
				If FileExists($AutInp0) Then
					$aPathAut0 = StringRegExp($AutInp0, "(^.*)\\(.*)$", 3)
				Else
					ContinueLoop
				EndIf
				If FileExists($aPathAut0[0]) Then Run('Explorer.exe '&$aPathAut0[0])
			Case $msg = $aureg
				_aureg()
			Case $msg = $edreg1
				_edreg1()
			Case $msg = $root1
				_read()
				If $err1<>0 Then ContinueLoop
				GUICtrlSetData($RedInp1, $aPathAut0[0]&'\SciTE\SciTE.exe')
			Case $msg = $edreg2
				_edreg2()
			Case $msg = $root2
				_read()
				If $err1<>0 Then ContinueLoop
				GUICtrlSetData($RedInp2, $aPathAut0[0]&'\SciTE\SciTE.exe')
			Case $msg = $cl
				GUICtrlSetData($AutInp, '')
				GUICtrlSetData($RedInp1, '')
				GUICtrlSetData($RedInp2, '')
				
			Case $msg = $Save
				$filesave = FileOpen(@ScriptDir&"\vAutoIt3.txt", 1)
				_read()
				;If StringInStr($filesave1, '\Q'&$AutInp0&'\E')=0 Then
				If StringRegExp($filesave1, '\Q'&$AutInp0&'\E',0)<>0 Then
					MsgBox(0, "Ошибка", "Этот путь к AutoIt3.exe уже существует в списке")
					FileClose($filesave)
					ContinueLoop
				EndIf
				If FileExists($AutInp0) Then
					FileWrite($filesave, '|'&$AutInp0&' '&FileGetVersion($AutInp0))
					FileClose($filesave)
					; обновление списка
					$filesave = FileOpen(@ScriptDir&"\vAutoIt3.txt", 0)
					$filesave1 = FileRead($filesave)
					FileClose($filesave)
					GUICtrlSendMsg($SaveCom, 0x14B, 0, 0)
					GUICtrlSetData($SaveCom,$filesave1, '')
					GUICtrlSetPos($SaveCom, 24,320)
				EndIf
			Case $msg = $SaveCom
				$SaveCom0 = GUICtrlRead ($SaveCom)
				If StringInStr($SaveCom0,'.exe')<>0 Then
					$aSC0=StringRegExp($SaveCom0, "(^.*)exe(.*)$", 3)
					If FileExists($aSC0[0]&'exe') Then
						GUICtrlSetData ($StatusBar, "Выбран AutoIt3.exe, версия - "&FileGetVersion($aSC0[0]&'exe'))
					Else
						GUICtrlSetData ($StatusBar, "Путь неверный")
					EndIf
					GUICtrlSetData($AutInp,$aSC0[0]&'exe')
				EndIf
				;заполнение полей редакторов реестровыми путями при выборе из списка SAVE.
				_edreg1()
				_edreg2()
				; выполнить re_au3.au3
			Case $msg = $reaust3 or $msg = $reaust4
				_aureg()
				_read()
				Run('"'&$AutInp0&'" "'&$aPathAut0[0]&'\re_au3.au3"', '', @SW_HIDE)
				
				; кнопки обзор
			Case $msg = $folder1
				$folder01 = FileOpenDialog("Указать AutoIt3.exe", @WorkingDir & "", "AutoIt3 (*.exe)", 1 + 4 )
				If @error Then ContinueLoop
				GUICtrlSetData($AutInp, $folder01)
				GUICtrlSetData ($StatusBar, "Выбран AutoIt3.exe, версия - "&FileGetVersion($folder01))
			Case $msg = $folder2
				$folder01 = FileOpenDialog("Указать основной редкатор", @WorkingDir & "", "Редкатор1 (*.exe)", 1 + 4 )
				If @error Then ContinueLoop
				GUICtrlSetData($RedInp1, $folder01)
				GUICtrlSetData ($StatusBar, "Редактор 1 выбран.")
			Case $msg = $folder3
				$folder01 = FileOpenDialog("Указать дополнительный редкатор", @WorkingDir & "", "Редкатор2 (*.exe)", 1 + 4 )
				If @error Then ContinueLoop
				GUICtrlSetData($RedInp2, $folder01)
				GUICtrlSetData ($StatusBar, "Редактор 2 выбран.")
			Case $msg = $folder4
				$folder01 = FileOpenDialog("Указать *.exe", @WorkingDir & "", " (*.exe)", 1 + 4 )
				If @error Then ContinueLoop
				$aFolder = StringRegExp($folder01, "(^.*)\\(.*)\.(.*)$", 3)
				If $aFolder[2]='exe' Then
				If $aFolder[1]='AutoIt3Wrapper' or $aFolder[1]='AutoIt3Wrapper_Gui' or $aFolder[1]='Aut2exe' or $aFolder[1]='Aut2exe_x64' Then
					RegWrite($as&"\Shell\"&$aFolder[1]&"\command","","REG_SZ",'"'&$folder01&'" /in "%1"')
				Else
					RegWrite($as&"\Shell\"&$aFolder[1]&"\command","","REG_SZ",'"'&$folder01&'" "%1"')
				EndIf
				EndIf
				_genlist()
				GUICtrlSetData ($StatusBar, 'Пункт "'&$aFolder[1]&'" добавлен в контекстное меню')
			Case $msg = $delitem
				$genlist0=GUICtrlRead ($genlist)
				RegDelete("HKEY_CLASSES_ROOT\AutoIt3Script\Shell\"&$genlist0)
				_genlist()
			Case $msg = $savereg
				_aureg()
				_read()
				$Aut_v=FileGetVersion($AutInp0)
				$tempfile=@TempDir&'\temp8491.reg'
				; генерируем имя нового файла с номером копии на случай если файл существует
				$i = 1
				While FileExists(@ScriptDir&'\save'&$i&'_AutoIt3_v'&$Aut_v&'.reg')
 				   $i +=1
				WEnd
				$regfile=@ScriptDir&'\save'&$i&'_AutoIt3_v'&$Aut_v&'.reg'
				$regfileF = FileOpen($regfile, 1) ; открываем бэкап-файл
				FileWrite($regfileF,"Windows Registry Editor Version 5.00"&@CRLF&@CRLF)
				; массив данных для экспорта
				_split()
				$Data=''
				For $i=1 To $aRegList [0]
					RunWait ( @Comspec&' /C reg export "'&$aRegList[$i]&'" "'&$tempfile&'"', '', @SW_HIDE )
					$vr = FileOpen($tempfile, 0)
					$vr1 = FileRead($vr)
					$vr1 = StringReplace($vr1, "Windows Registry Editor Version 5.00"&@CRLF, '')
					$Data &=$vr1
					FileClose($vr)
				Next
				FileWrite($regfileF, $Data&@CRLF)
				FileClose($regfileF)
			Case $msg = -3
				ExitLoop
		EndSelect
	WEnd

; создание массива веток реестра
Func _split()
$aRegList = StringSplit( 'HKCR\.a3x|HKCR\.au3|HKCR\AutoIt3Script|HKCR\AutoIt3XScript|HKCR\AutoItX3.Control|HKCR\AutoItX3.Control.1|HKCR\AppID\AutoItX3.DLL|HKCR\AppID\{6E8109C4-F369-415D-AF9A-2AEEFF313234}|HKCR\CLSID\{1A671297-FA74-4422-80FA-6C5D8CE4DE04}|HKCR\CLSID\{3D54C6B8-D283-40E0-8FAB-C97F05947EE8}|HKCR\Interface\{3D54C6B8-D283-40E0-8FAB-C97F05947EE8}|HKCR\TypeLib\{F8937E53-D444-4E71-9275-35B64210CC3B}|HKCU\Software\AutoIt v3|HKLM\SOFTWARE\AutoIt v3\AutoIt|HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Au3Info.exe|HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Aut2Exe.exe|HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AutoIt3.exe|HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AutoItv3', "|")
EndFunc

; чтение пути к AutoIt3 из реестра
Func _aureg()
$type = RegRead("HKEY_CLASSES_ROOT\AutoIt3Script\Shell\Run\Command", "")
If StringInStr($type,'AutoIt3.exe')=0 Then $type = RegRead("HKEY_CLASSES_ROOT\AutoIt3Script\Shell\Open\Command", "")
If @error=1 Then return
$aPathexe=StringRegExp($type, "(^.*)exe(.*)$", 3)
If @error=1 Then return
$Pathexe1 = StringReplace($aPathexe[0], '"', '')
If FileExists($Pathexe1&'exe') Then
	GUICtrlSetData($AutInp, $Pathexe1&'exe')
	GUICtrlSetData ($StatusBar, "Версия AutoIt3 из реестра - "&FileGetVersion($Pathexe1&'exe'))
EndIf
EndFunc

; чтение пути редактора из реестра
Func _edreg1()
$type = RegRead("HKEY_CLASSES_ROOT\AutoIt3Script\Shell\Open\Command", "")
If StringInStr($type,'AutoIt3.exe')<>0 Then $type = RegRead("HKEY_CLASSES_ROOT\AutoIt3Script\Shell\Run\Command", "")
If @error=1 Then return
$aPathexe=StringRegExp($type, "(^.*)exe(.*)$", 3)
If @error=1 Then return
$Pathexe1 = StringReplace($aPathexe[0], '"', '')
If FileExists($Pathexe1&'exe') Then GUICtrlSetData($RedInp1, $Pathexe1&'exe')
EndFunc

; чтение пути редактора из реестра
Func _edreg2()
$type = RegRead("HKEY_CLASSES_ROOT\AutoIt3Script\Shell\Edit\Command", "")
If @error=1 Then return
$aPathexe=StringRegExp($type, "(^.*)exe(.*)$", 3)
If @error=1 Then return
$Pathexe1 = StringReplace($aPathexe[0], '"', '')
If FileExists($Pathexe1&'exe') Then GUICtrlSetData($RedInp2, $Pathexe1&'exe')
EndFunc


; заполнение комбобокса списком пунктов реестра
Func _genlist()
GUICtrlSendMsg($genlist, 0x14B, 0, 0)
$regst=''
For $i = 1 to 20
$regShell = RegEnumKey("HKEY_CLASSES_ROOT\AutoIt3Script\Shell", $i)
if @error <> 0 Then ExitLoop
$regst&='|'&$regShell
next
GUICtrlSetData($genlist,$regst, '')
EndFunc


; очистка комбобоксов
Func _clear()
GUICtrlSendMsg($OpenCom, 0x14B, 0, 0)
GUICtrlSendMsg($EditCom, 0x14B, 0, 0)
GUICtrlSendMsg($CompCom, 0x14B, 0, 0)
GUICtrlSendMsg($RunCom, 0x14B, 0, 0)
EndFunc

; установка английского языка
Func _langen()
GUICtrlSetData($OpenCom,'Открыть в редакторе|Open', 'Open')
GUICtrlSetData($EditCom,'Изменить|Edit Script', 'Edit Script')
GUICtrlSetData($CompCom,'Компилировать в EXE|Compile Script', 'Compile Script')
GUICtrlSetData($RunCom,'Выполнить скрипт|Run Script', 'Run Script')
EndFunc

; установка русского языка
Func _langrus()
GUICtrlSetData($OpenCom,'Открыть в редакторе|Open', 'Открыть в редакторе')
GUICtrlSetData($EditCom,'Изменить|Edit Script', 'Изменить')
GUICtrlSetData($CompCom,'Компилировать в EXE|Compile Script', 'Компилировать в EXE')
GUICtrlSetData($RunCom,'Выполнить скрипт|Run Script', 'Выполнить скрипт')
EndFunc

; чтение переменных, проверка валидности параметров
Func _read()
$err1=1
If GUICtrlRead ($run_m)=1 Then
	$run_m0='Run'
Else
	$run_m0='Open'
EndIf
$AutInp0=GUICtrlRead ($AutInp)
$RedInp01=GUICtrlRead ($RedInp1)
$RedInp02=GUICtrlRead ($RedInp2)
$OpenCom0=GUICtrlRead ($OpenCom)
$EditCom0=GUICtrlRead ($EditCom)
$CompCom0=GUICtrlRead ($CompCom)
$RunCom0=GUICtrlRead ($RunCom)
If $OpenCom0='' Then $OpenCom0='Open'
If $EditCom0='' Then $EditCom0='Edit Script'
If $CompCom0='' Then $CompCom0='Compile Script'
If $RunCom0='' Then $RunCom0='Run Script'

If $AutInp0='' or Not FileExists($AutInp0) Then
MsgBox(0, "Ошибка", "Укажите правильно путь к AutoIt3.exe")
return
EndIf

$aPathAut0 = StringRegExp($AutInp0, "(^.*)\\(.*)$", 3)

; пробуем определить редактор1
If Not FileExists($RedInp01) Then
	If FileExists($aPathAut0[0]&'\SciTE\SciTE.exe') Then
		$RedInp01=$aPathAut0[0]&'\SciTE\SciTE.exe'
	Else
		$type = RegRead("HKEY_CLASSES_ROOT\AutoIt3Script\Shell\Open\Command", "")
		If StringInStr($type,'AutoIt3.exe')<>0 Then $type = RegRead("HKEY_CLASSES_ROOT\AutoIt3Script\Shell\Run\Command", "")
		If @error=1 Then return
		$aPathexe=StringRegExp($type, "(^.*)exe(.*)$", 3)
		If @error=1 Then return
		$Pathexe1 = StringReplace($aPathexe[0], '"', '')
		If FileExists($Pathexe1&'exe') Then $RedInp01=$Pathexe1&'exe'
	EndIf
EndIf
If Not FileExists($RedInp01) Then MsgBox(0, "Ошибка", "Не найден путь к основному редактору")

; пробуем определить редактор2
If Not FileExists($RedInp02) Then
	If FileExists($aPathAut0[0]&'\SciTE\SciTE.exe') Then
		$RedInp02=$aPathAut0[0]&'\SciTE\SciTE.exe'
	Else
		$type = RegRead("HKEY_CLASSES_ROOT\AutoIt3Script\Shell\Edit\Command", "")
		If @error=1 Then return
		$aPathexe=StringRegExp($type, "(^.*)exe(.*)$", 3)
		If @error=1 Then return
		$Pathexe1 = StringReplace($aPathexe[0], '"', '')
		If FileExists($Pathexe1&'exe') Then $RedInp02=$Pathexe1&'exe'
	EndIf
EndIf
If Not FileExists($RedInp02) Then MsgBox(0, "Ошибка", "Не найден путь к дополнительному редактору")
If FileExists($RedInp02) and $RedInp02<>'' and FileExists($RedInp01) and $RedInp01<>'' and FileExists($AutInp0) and $AutInp0<>'' Then
$err1=0
GUICtrlSetData($RedInp2, $RedInp02)
GUICtrlSetData($RedInp1, $RedInp01)
EndIf
EndFunc

; устранение проблем интерфейса
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