#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Check_md5.exe
#AutoIt3Wrapper_Icon=Check_md5.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Check_md5.exe
#AutoIt3Wrapper_Res_Fileversion=0.7.1.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.7.1
#AutoIt3Wrapper_Res_Field=Build|2012.10.12
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2012.10.12

#NoTrayIcon
#include <Crypt.au3>
#include <FileOperations.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <ListBoxConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include "Check_md5_Func.au3"

FileChangeDir(@ScriptDir)
Global $AutoPath = ''

If $CmdLine[0] Then _AutoCheck()


$LngTitle='Check_md5'
$LngAbout='О программе'
$LngVer='Версия'
$LngCopy='Копировать'
$LngSite='Сайт'

$iW = 500
$iH = 213

;создание оболочки
$hGui = GUICreate($LngTitle, $iW, $iH, -1, -1, -1, $WS_EX_ACCEPTFILES) ; размер окна
If Not @Compiled Then GUISetIcon(@ScriptDir & '\Check_md5.ico')
$StatusBar = GUICtrlCreateLabel('Строка состояния', 10, 197, 490, 20)
$restart = GUICtrlCreateButton("R", 481, 2, 18, 20)
GUICtrlSetTip(-1, "Перезапуск утилиты")

$About = GUICtrlCreateButton("@", $iW - 40, 2, 18, 20)
GUICtrlSetTip(-1, "О программе")

$opencurfol = GUICtrlCreateButton("Открыть", $iW - 100, 2, 57, 20)
GUICtrlSetTip(-1, "Открыть каталог программы")

$tab = GUICtrlCreateTab(0, 2, $iW, $iH - 18) ; размер вкладки

GUICtrlCreateLabel("используйте drag-and-drop", $iW - 250, 5, 150, 17)

$tab1 = GUICtrlCreateTabItem("  Файл") ; имя вкладки
$CatchDrop1 = GUICtrlCreateLabel("", 0, 30, $iW, 70)
GUICtrlSetState(-1, $GUI_DISABLE + $GUI_DROPACCEPTED)
$CatchDrop2 = GUICtrlCreateLabel("", 0, 100, $iW, 100)
GUICtrlSetState(-1, $GUI_DISABLE + $GUI_DROPACCEPTED)

GUICtrlCreateLabel("Файл 1:", 10, 34, 50, 17, $SS_LEFTNOWORDWRAP)
$filen_1 = GUICtrlCreateLabel("", 61, 33, $iW - 65, 20)
GUICtrlSetColor(-1, 0x000099)
GUICtrlSetFont(-1, 9, 700)
$file_1 = GUICtrlCreateInput("", 10, 50, $iW - 45, 22)
GUICtrlSetState(-1, 8)
$openfile_1 = GUICtrlCreateButton("...", $iW - 34, 49, 24, 24, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', -4, 0)
$md5_1 = GUICtrlCreateInput("", 10, 75, $iW - 45, 22)
GUICtrlSetState(-1, 8)
GUICtrlSetFont(-1, 9, 700)
$md5buf_1 = GUICtrlCreateButton("^", $iW - 34, 74, 24, 24, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\netshell.dll', -150, 0)
GUICtrlSetTip(-1, "MD5 в буфер")

GUICtrlCreateLabel("Файл 2:", 10, 104, 50, 17, $SS_LEFTNOWORDWRAP)
$filen_2 = GUICtrlCreateLabel("", 61, 103, $iW - 65, 20)
GUICtrlSetColor(-1, 0x000099)
GUICtrlSetFont(-1, 9, 700)
$file_2 = GUICtrlCreateInput("", 10, 120, $iW - 45, 22)
GUICtrlSetState(-1, 8)
$openfile_2 = GUICtrlCreateButton("...", $iW - 34, 119, 24, 24, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', -4, 0)
$md5_2 = GUICtrlCreateInput("", 10, 145, $iW - 45, 22)
GUICtrlSetState(-1, 8)
GUICtrlSetFont(-1, 9, 700)
$md5buf_2 = GUICtrlCreateButton("^", $iW - 34, 144, 24, 24, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\netshell.dll', -150, 0)
GUICtrlSetTip(-1, "MD5 в буфер")

$Compare_md5 = GUICtrlCreateButton("MD5", 88, 170, 52, 20)
GUICtrlSetTip(-1, "Сравить поля MD5")

$ClearInp = GUICtrlCreateCheckbox("Очищать ""Файл 2"" при вставке в ""Файл 1""", 190, 171, 230, 17)

$tab2 = GUICtrlCreateTabItem("Каталог") ; имя вкладки

GUICtrlCreateLabel("Указать каталог", 10, 35, 300, 17)
$folder111 = GUICtrlCreateInput("", 10, 50, $iW - 45, 22)
GUICtrlSetState(-1, 8)
$openfolder = GUICtrlCreateButton("...", $iW - 34, 49, 24, 24, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', -4, 0)
GUICtrlSetTip(-1, "Обзор...")
$Clean1 = GUICtrlCreateButton("v Очистить", $iW - 100, 33, 65, 17)

GUICtrlCreateLabel("Указать файл-базу контрольных сумм md5", 10, 85, 300, 17)
$basefile = GUICtrlCreateInput("", 10, 100, $iW - 45, 22)
GUICtrlSetState(-1, 8)
$openbase = GUICtrlCreateButton("...", $iW - 34, 99, 24, 24, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', -4, 0)
GUICtrlSetTip(-1, "Обзор...")
$Clean2 = GUICtrlCreateButton("v Очистить", $iW - 100, 83, 65, 17)

GUICtrlCreateLabel("тип файла:", 20, 139, 60, 20)
$iMask = GUICtrlCreateCombo("", 90, 136, 180, 22)
GUICtrlSetData(-1, 'exe|exe;dll|exe;dll;com;scr|exe;dll;com;scr;inf;bat;cmd;vbs', 'exe')

$Check = GUICtrlCreateButton("Проверить", 410, 135, 72, 26)
GUICtrlSetTip(-1, "Проверить каталог по списку")

$Create = GUICtrlCreateButton("Создать", 320, 135, 72, 26)
GUICtrlSetTip(-1, "Начать создание списка")

$tab3 = GUICtrlCreateTabItem("Автозагрузка") ; имя вкладки
$ListBox = GUICtrlCreateList("", 10, 33, 408, 131, BitOR($GUI_SS_DEFAULT_LIST, $LBS_STANDARD, $LBS_NOINTEGRALHEIGHT))
GUICtrlSetState(-1, 8)
GUICtrlSetBkColor(-1, 0xDDEEE8)

$Autostart = GUICtrlCreateCheckbox("Автозагрузка", 10, 167, 90, 24)
GUICtrlSetTip(-1, "Добавить тихую проверку в автозагрузку")
If RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", @ScriptName) Then GUICtrlSetState($Autostart, 1)

$Import = GUICtrlCreateButton("Импорт", 425, 33, 65, 22)
GUICtrlSetTip(-1, "Импорт файлов автозагрузки" & @CRLF & "текущего пользователя")
$Import2 = GUICtrlCreateButton("Импорт", 425, 58, 65, 22)
GUICtrlSetTip(-1, "Импорт системных файлов")
$AddOpen = GUICtrlCreateButton("Добавить", 425, 83, 65, 22)
GUICtrlSetTip(-1, "Добавить файл в список")
$DelPath = GUICtrlCreateButton("Удалить", 425, 108, 65, 22)
GUICtrlSetTip(-1, "Удалить файл из списка")
$ClearPath = GUICtrlCreateButton("Очистить", 425, 133, 65, 22)
GUICtrlSetTip(-1, "Очистка списка")
$Save = GUICtrlCreateButton("Сохранить", 425, 158, 65, 22)
GUICtrlSetTip(-1, "Сохранить список в файл AutoCheck.txt")
$CheckCur = GUICtrlCreateButton("Проверить", 100, 167, 65, 22)
GUICtrlSetTip(-1, "Проверка по списку AutoCheck.txt")
$OpenAC = GUICtrlCreateButton("Открыть", 170, 167, 65, 22)
GUICtrlSetTip(-1, "Открыть AutoCheck.txt в блокноте")

$tab4 = GUICtrlCreateTabItem("     ?") ; имя вкладки
GUICtrlCreateLabel("     Цель утилиты - проверка контрольных сумм файлов для контроля целостности оригинала." & @CRLF & "     ""Файл"" - вкладка для сравнения двух файлов. " & @CRLF & "     ""Каталог"" - сравнение с каталога с предварительно созданным файлом-базой. Результат сравнения -  три списка: совпадающих, несовпадающих и отсутствующих файлов." & @CRLF & "     Если оставить поле ""Тип файла"" пустым, то сканируются все файлы. Если не хотите перезаписать файл базы, оставляете поле ""файл-базы"" пустым. Если оставить поле каталога пустым, то путь проверки читается в файл-базе, а если указать каталог, то это даст возможность сравнить с другими каталогами, например с бэкапом. Выходные лог-файлы генерируются с новыми индексами в именах. Esc - выход." & @CRLF & "     ""Автозагрузка"" - проверка файлов при автозагрузке.", 10, 30, 480, 150)
GUICtrlCreateLabel("AZJIO 2012.04.11", 408, 177, 90, 17)
GUICtrlCreateTabItem("") ; конец вкладок

If FileExists(@ScriptDir & '\AutoCheck.txt') Then
	$AutoPath = FileRead(@ScriptDir & '\AutoCheck.txt')
	$AutoPathW = StringReplace(StringReplace($AutoPath, '|', '   ***  '), @CRLF, '|')
	If StringRight($AutoPathW, 1) = '|' Then $AutoPathW = StringTrimRight($AutoPathW, 1)
	GUICtrlSetData($ListBox, $AutoPathW)
EndIf

GUISetState()
_Crypt_Startup()

While 1
	Switch GUIGetMsg()
		Case $tab
			_ResetFont()
		Case $About
			_ResetFont()
			_About()
			; алгоритм для drag-and-drop на всех владках
		Case -13
			GUICtrlSetColor($md5_2, 0x0)
			GUICtrlSetColor($md5_1, 0x0)
			_ResetFont()
			$IsFolder = _IsFolder(@GUI_DragFile)
			GUICtrlSetData($StatusBar, StringRegExpReplace(@GUI_DragFile, '(^.*)\\(.*)$', '\2'))
			Switch @GUI_DropId
				Case $folder111
					If $IsFolder Then
						GUICtrlSetData($folder111, @GUI_DragFile)
					Else
						GUICtrlSetData($folder111, '')
						MsgBox(0, "Предупреждение", 'Перетаскивайте каталог, а не файл.')
					EndIf
				Case $basefile
					If $IsFolder Then
						GUICtrlSetData($basefile, '')
						MsgBox(0, "Предупреждение", 'Перетаскивайте файл, а не каталог.')
					Else
						GUICtrlSetData($basefile, @GUI_DragFile)
					EndIf
				Case $file_1, $md5_1, $CatchDrop1
					If Not $IsFolder Then _DropDrag($file_1, $md5_1, $filen_1, @GUI_DragFile)
				Case $file_2, $md5_2, $CatchDrop2
					If Not $IsFolder Then _DropDrag($file_2, $md5_2, $filen_2, @GUI_DragFile)
				Case $ListBox
					If Not $IsFolder Then
						If StringInStr($AutoPath, @GUI_DragFile & '|') Then
							MsgBox(0, "Предупреждение", "Добавляемый путь существует в списке" & @CRLF & "и не будет добавлен.")
							ContinueLoop
						Else
							$AutoPath &= @GUI_DragFile & '|' & StringTrimLeft(_Crypt_HashFile(@GUI_DragFile, $CALG_MD5), 2) & @CRLF
							_CreateList()
							GUICtrlSetData($StatusBar, 'Добавлен ' & StringRegExpReplace(@GUI_DragFile, '(^.*)\\(.*)$', '\2'))
						EndIf
					EndIf
			EndSwitch

			; начало Вкладка Автозагрузка
			; Автозагрузка
		Case $Autostart
			_ResetFont()
			If GUICtrlRead($Autostart) = 1 Then
				RegWrite("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", @ScriptName, "REG_SZ", '"'&@ScriptFullPath& '" /1')
				If RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", @ScriptName) Then
					GUICtrlSetData($StatusBar, 'Запись в реестр успешно добавлена')
				Else
					GUICtrlSetState($Autostart, 4)
					GUICtrlSetData($StatusBar, 'Ошибка записи в реестр. Запустите программу от имени администратора')
				EndIf
			Else
				RegDelete("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", @ScriptName)
				If RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", @ScriptName) Then
					GUICtrlSetState($Autostart, 1)
					GUICtrlSetData($StatusBar, 'Ошибка удаления записи в реестре. Запустите программу от имени администратора')
				Else
					GUICtrlSetData($StatusBar, 'Запись из реестра успешно удалена.')
				EndIf
			EndIf
			; Импорт
		Case $Import
			_ResetFont()
			_implnk(@StartupCommonDir)
			_implnk(@StartupDir)
			If FileExists(@StartupDir & ' (Delayed by AnVir)') Then _implnk(@StartupDir & ' (Delayed by AnVir)')
			_impreg("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run")
			_impreg("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run")
			_CreateList()
			GUICtrlSetData($StatusBar, 'Импорт файлов автозагрузки выполнен')
		Case $Import2
			_ResetFont()
			$system = StringSplit(@SystemDir & '\svchost.exe|' & @SystemDir & '\winlogon.exe|' & @SystemDir & '\lsass.exe|' & @SystemDir & '\smss.exe|' & @SystemDir & '\spoolsv.exe|' & @SystemDir & '\ctfmon.exe|' & @SystemDir & '\services.exe|', '|')
			For $i = 1 To $system[0]
				If FileExists($system[$i]) And Not StringInStr($AutoPath, $system[$i] & '|') Then $AutoPath &= $system[$i] & '|' & StringTrimLeft(_Crypt_HashFile($system[$i], $CALG_MD5), 2) & @CRLF
			Next
			_CreateList()
			GUICtrlSetData($StatusBar, 'Импорт системных файлов выполнен')
			; Добавить
		Case $AddOpen
			_ResetFont()
			$tmp5 = FileOpenDialog("Выбрать файл", @WorkingDir, "Все файлы (*.*)", 1 + 2, '', $hGui)
			If @error Then ContinueLoop
			If StringInStr($AutoPath, $tmp5 & '|') Then
				MsgBox(0, "Предупреждение", "Добавляемый путь существует в списке" & @CRLF & "и не будет добавлен.")
				ContinueLoop
			Else
				$AutoPath &= $tmp5 & '|' & StringTrimLeft(_Crypt_HashFile($tmp5, $CALG_MD5), 2) & @CRLF
				_CreateList()
				GUICtrlSetData($StatusBar, 'Добавлен ' & StringRegExpReplace($tmp5, '(^.*)\\(.*)$', '\2'))
			EndIf
			; Удалить
		Case $DelPath
			_ResetFont()
			$myPath = GUICtrlRead($ListBox)
			If Not $myPath Then
				MsgBox(0, 'Сообщение', 'Выберите пункт для удаления')
				ContinueLoop
			EndIf
			$myPath = StringReplace($myPath, '   ***  ', '|')
			GUICtrlSetData($StatusBar, 'Удалён ' & StringRegExpReplace($myPath, '^.*\\(.*?)\|.*$', '\1'))
			$myPath = StringRegExpReplace($myPath, "[][{}()|+.\\^$=#]", "\\$0")
			$AutoPath = StringRegExpReplace($AutoPath, $myPath & '\r\n', '')
			_CreateList()
			; Очистить
		Case $ClearPath
			_ResetFont()
			$AutoPath = ''
			GUICtrlSetData($ListBox, '')
			GUICtrlSetData($StatusBar, 'Очистка')
			; Сохранить
		Case $Save
			If FileExists(@ScriptDir & '\AutoCheck.txt') And MsgBox(4, 'Сообщение', 'Заменить существующий файл AutoCheck.txt') =7 Then ContinueLoop
			$file = FileOpen(@ScriptDir & '\AutoCheck.txt', 2)
			FileWrite($file, $AutoPath)
			FileClose($file)
			_ResetFont()
			GUICtrlSetData($StatusBar, 'Сохранено')
			; Проверка
		Case $CheckCur
			GUICtrlSetData($StatusBar, 'Проверка ...')
			GUICtrlSetColor($StatusBar, 0x007700)
			_AutoCheck(0)
			GUICtrlSetFont($StatusBar, 9, 700)
			GUICtrlSetData($StatusBar, 'Проверка выполнена')

		Case $OpenAC
			_ResetFont()
			If FileExists(@ScriptDir & '\AutoCheck.txt') Then ShellExecute(@ScriptDir & '\AutoCheck.txt')
			
			; конец Вкладка Автозагрузка
			; начало Вкладка каталог

			; Создание списка
		Case $Create
			_ResetFont()
			GUICtrlSetData($StatusBar, 'Выполняется ...')
			; Читаем инпуты, проверяем наличие каталогов
			$folder100 = GUICtrlRead($folder111)
			$basefile0 = GUICtrlRead($basefile)
			$sMask0 = GUICtrlRead($iMask)
			If $folder100 = '' Or Not FileExists($folder100) Or StringInStr(FileGetAttrib($folder100), "D") = 0 Then
				$folder100 = FileSelectFolder("Указать каталог", '', '3', @WorkingDir, $hGui)
				If @error Then
					MsgBox(0, "Мелкая ошибка", 'Не указан или не существует каталог.')
					GUICtrlSetData($StatusBar, 'Не указан или не существует каталог.')
					ContinueLoop
				EndIf
			EndIf
			If $basefile0 = '' Or Not FileExists($basefile0) Or StringInStr(FileGetAttrib($basefile0), "D") > 0 Then
				; генерируем имя сохранения для FileSaveDialog
				$namef = StringRegExpReplace($folder100, '(^.*)\\(.*)$', '\2')
				$namef = StringReplace($namef, ' ', '_')
				$i = 1
				While FileExists($namef & '_' & $i & '.txt')
					$i += 1
				WEnd
				$namef1 = $namef & '_' & $i & '.txt'
				If Not FileExists(@ScriptDir & '\' & $namef & '.txt') Then $namef1 = $namef & '.txt'
				$basefile0 = FileSaveDialog("Выбор файла сохранения", @ScriptDir & "", "Текстовый файл (*.txt)", 24, $namef1, $hGui)
				If @error Then
					GUICtrlSetData($StatusBar, 'Не указан файл.')
					ContinueLoop
				EndIf
				If StringRight($basefile0, 4) <> '.txt' Then $basefile0 = $basefile0 & '.txt'
			EndIf
			$timer = TimerInit() ; засекаем время
			; подсчитаем размер для статистики
			$FileList = _FO_FileSearch($folder100, _FO_CorrectMask(StringReplace($sMask0, ';', '|')), True, 125, 1, 1, 0)
			If @error Then
				GUICtrlSetData($StatusBar, 'Ничего не найдено.')
				ContinueLoop
			EndIf
			$Size = 0
			For $i = 1 To $FileList[0]
				$Size += FileGetSize($FileList[$i])
			Next

			; проверка с прогресс-баром
			$ProgressBar = GUICtrlCreateProgress(150, 170, 200, 16)
			GUICtrlSetColor(-1, 32250); цвет для классической темы

			; поиск файлов
			$filetxt1 = FileOpen($basefile0, 2)
			; проверка открытия файла для записи строки
			If $filetxt1 = -1 Then
				MsgBox(0, "Ошибка", "Не возможно открыть файл.")
				ContinueLoop
			EndIf
			$Tmp = StringLen($folder100) + 1
			$datatext = $folder100 & @CRLF
			$Size1 = 0
			For $i = 1 To $FileList[0]
				GUICtrlSetData($StatusBar, $FileList[0] & ' / ' & $i & ' / ' & StringTrimLeft($FileList[$i], $Tmp))
				$SizeTmp = FileGetSize($FileList[$i])
				If $SizeTmp = 0 Then ContinueLoop ; проверка размера, так как файл с нулевым размером приводит к вылету скрипта
				$MD5 = StringTrimLeft(_Crypt_HashFile($FileList[$i], $CALG_MD5), 2)
				$datatext &= StringTrimLeft($FileList[$i], $Tmp) & '|' & $MD5 & @CRLF
				$Size1 += $SizeTmp
				GUICtrlSetData($ProgressBar, Ceiling($Size1 / $Size * 100))
			Next

			GUICtrlDelete($ProgressBar)
			FileWrite($filetxt1, $datatext)
			FileClose($filetxt1)
			GUICtrlSetData($StatusBar, 'Выполнено !!!  Всего ' & $FileList[0] & ' файлов, за ' & Ceiling(TimerDiff($timer) / 1000) & ' сек')
			GUICtrlSetColor($StatusBar, 0xEE0000)
			GUICtrlSetFont($StatusBar, 8.5, 700)
			$FileList=''

			; Проверка по списку
		Case $Check
			_ResetFont()
			GUICtrlSetData($StatusBar, 'Выполняется ...')
			; Читаем инпуты, проверяем наличие каталогов
			$folder100 = GUICtrlRead($folder111)
			$basefile0 = GUICtrlRead($basefile)
			If $basefile0 = '' Or Not FileExists($basefile0) Or StringInStr(FileGetAttrib($basefile0), "D") > 0 Then
				$basefile0 = FileOpenDialog("Указать файл-базу", @WorkingDir, "Текстовый файл (*.txt)", 1 + 2, '', $hGui)
				If @error Then
					MsgBox(0, "Мелкая ошибка", 'Не указан или не существует базовый файл.')
					GUICtrlSetData($StatusBar, 'Не указан или не существует базовый файл.')
					ContinueLoop
				EndIf
			EndIf
			If $folder100 <> '' Or FileExists($folder100) Or StringInStr(FileGetAttrib($folder100), "D") > 0 Then
				MsgBox(0, "Предупреждение", 'Если указан каталог, то используем этот путь, а не из базового файла.')
				;Устанавливаем путь к базе
			EndIf

			$timer = TimerInit() ; засекаем время
			$file = FileOpen($basefile0, 0)
			$basetext = FileRead($file)
			FileClose($file)

			;==============================
			;кусок кода из UDF File.au3 для разделения образца построчно в массив
			If StringInStr($basetext, @LF) Then
				$aFiletext = StringSplit(StringStripCR($basetext), @LF)
			ElseIf StringInStr($basetext, @CR) Then
				$aFiletext = StringSplit($basetext, @CR)
			Else ;; unable to split the file
				If StringLen($basetext) Then
					Dim $aFiletext[2] = [1, $basetext]
				Else
					MsgBox(0, "Сообщение", "нет данных")
					ContinueLoop
				EndIf
			EndIf

			If $folder100 <> '' Or FileExists($folder100) Or StringInStr(FileGetAttrib($folder100), "D") > 0 Then $aFiletext[1] = $folder100

			; генерируем имя нового файла с номером копии на случай если файл существует
			$Output = @ScriptDir & '\Out_'
			$i = 1
			While FileExists($Output & $i & '_Check.log') Or FileExists($Output & $i & '_No_Check.log') Or FileExists($Output & $i & '_No_File.log')
				$i += 1
			WEnd
			$OutputCh = $Output & $i & '_Check.log'
			$OutputNC = $Output & $i & '_No_Check.log'
			$OutputNF = $Output & $i & '_No_File.log'
			$OutputChText = ''
			$OutputNCText = ''
			$OutputNFText = ''

			;блок статистики
			$Size = 0
			For $i = 2 To UBound($aFiletext) - 1
				If $aFiletext[$i] = '' Then ExitLoop
				$aFile = StringSplit($aFiletext[$i], "|")
				If FileExists($aFiletext[1] & '\' & $aFile[1]) Then $Size += FileGetSize($aFiletext[1] & '\' & $aFile[1])
			Next

			; проверка с прогресс-баром
			$ProgressBar = GUICtrlCreateProgress(150, 170, 200, 16)
			GUICtrlSetColor(-1, 32250); цвет для классической темы
			$Size1 = 0

			; счётчики учёта количества файлов
			$kol = 0
			$kolCh = 0
			$kolNC = 0
			$kolNF = 0
			; цикл сверки md5 по базе
			$nbf = UBound($aFiletext) - 3
			For $i = 2 To $nbf + 2
				If $aFiletext[$i] = '' Then ExitLoop
				$aFile = StringSplit($aFiletext[$i], "|")
				If FileExists($aFiletext[1] & '\' & $aFile[1]) Then
					$SizeTmp = FileGetSize($aFiletext[1] & '\' & $aFile[1])
					If $SizeTmp = 0 Then
						$OutputNCText &= $aFiletext[1] & '\' & $aFile[1] & @CRLF
						ContinueLoop
					EndIf
					$kol += 1
					GUICtrlSetData($StatusBar, $nbf & ' / ' & $i - 1 & ' / ' & $aFile[1])
					$MD5 = StringTrimLeft(_Crypt_HashFile($aFiletext[1] & '\' & $aFile[1], $CALG_MD5), 2)
					If $MD5 = $aFile[2] Then
						$kolCh += 1
						$OutputChText &= $aFiletext[1] & '\' & $aFile[1] & @CRLF
					Else
						$kolNC += 1
						$OutputNCText &= $aFiletext[1] & '\' & $aFile[1] & @CRLF
					EndIf
					$Size1 += $SizeTmp
				Else
					$kolNF += 1
					$OutputNFText &= $aFiletext[1] & '\' & $aFile[1] & @CRLF
				EndIf
				GUICtrlSetData($ProgressBar, Ceiling($Size1 / $Size * 100))
			Next
			GUICtrlDelete($ProgressBar)

			If $OutputChText <> '' Then
				$file = FileOpen($OutputCh, 2)
				FileWrite($file, '---Список файлов с совпавшими контрольными суммами, всего ' & $kolCh & '---' & @CRLF & $OutputChText)
				FileClose($file)
			EndIf

			If $OutputNCText <> '' Then
				$file = FileOpen($OutputNC, 2)
				FileWrite($file, '---Список файлов с НЕсовпавшими контрольными суммами, всего ' & $kolNC & '---' & @CRLF & $OutputNCText)
				FileClose($file)
			EndIf

			If $OutputNFText <> '' Then
				$file = FileOpen($OutputNF, 2)
				FileWrite($file, '---Список отсутствующих файлов, всего ' & $kolNF & '---' & @CRLF & $OutputNFText)
				FileClose($file)
			EndIf
			GUICtrlSetData($StatusBar, 'Выполнено !!!  Всего ' & $kol & ' из ' & $nbf & ' файлов базы, за ' & Ceiling(TimerDiff($timer) / 1000) & ' сек')
			GUICtrlSetColor($StatusBar, 0xEE0000)
			GUICtrlSetFont($StatusBar, 8.5, 700)
			
			If $OutputNCText <> '' Then _Tabl($OutputNCText)

			; кнопки "Очистка"
		Case $Clean1
			_ResetFont()
			GUICtrlSetData($folder111, '')
		Case $Clean2
			_ResetFont()
			GUICtrlSetData($basefile, '')
			
			; кнопки "Обзор" вкладка "Каталог"
		Case $openfolder
			$tmp1 = FileSelectFolder("Указать каталог", '', '3', @WorkingDir, $hGui)
			If @error Then ContinueLoop
			_ResetFont()
			GUICtrlSetData($folder111, $tmp1)
		Case $openbase
			$tmp2 = FileOpenDialog("Указать файл-базу", @WorkingDir, "Текстовый файл (*.txt)", 1 + 2, '', $hGui)
			If @error Then ContinueLoop
			_ResetFont()
			GUICtrlSetData($basefile, $tmp2)
			
			; кнопки "Обзор" вкладка "Файл"
		Case $openfile_1
			$tmp3 = FileOpenDialog("Выбрать файл", @WorkingDir, "Все файлы (*.*)", 1 + 2, '', $hGui)
			If @error Then ContinueLoop
			_ResetFont()
			_DropDrag($file_1, $md5_1, $filen_1, $tmp3)
		Case $openfile_2
			$tmp4 = FileOpenDialog("Выбрать файл", @WorkingDir, "Все файлы (*.*)", 1 + 2, '', $hGui)
			If @error Then ContinueLoop
			_ResetFont()
			_DropDrag($file_2, $md5_2, $filen_2, $tmp4)
			
		Case $Compare_md5
			_ResetFont()
			GUICtrlSetData($file_1, '')
			GUICtrlSetData($file_2, '')
			GUICtrlSetData($filen_1, '')
			GUICtrlSetData($filen_2, '')
			If GUICtrlRead($md5_2) <> '' And GUICtrlRead($md5_1) <> '' Then
				_Compare()
			Else
				GUICtrlSetData($StatusBar, 'Не указан md5')
				GUICtrlSetColor($StatusBar, 0x0)
				GUICtrlSetColor($md5_2, 0xAAAAAA)
				GUICtrlSetColor($md5_1, 0xAAAAAA)
			EndIf
			
		Case $md5buf_1
			_ResetFont()
			ClipPut(GUICtrlRead($md5_1))
		Case $md5buf_2
			_ResetFont()
			ClipPut(GUICtrlRead($md5_2))
			
		Case $opencurfol
			_ResetFont()
			Run('Explorer.exe "' & @ScriptDir & '"')
		Case $restart
			_restart()
		Case -3
			_Crypt_Shutdown()
			Exit
	EndSwitch
WEnd

Func _ResetFont()
	GUICtrlSetColor($StatusBar, 0x0)
	GUICtrlSetFont($StatusBar, 8.5, 400)
EndFunc

Func _DropDrag($file_3, $md5_3, $filen_3, $DragFile)
	GUICtrlSetData($file_3, $DragFile)
	GUICtrlSetData($filen_3, StringRegExpReplace($DragFile, '(^.*)\\(.*)$', '\2'))
	$MD5 = StringTrimLeft(_Crypt_HashFile($DragFile, $CALG_MD5), 2)
	GUICtrlSetData($md5_3, $MD5)
	If GUICtrlRead($file_1) = GUICtrlRead($file_2) Then MsgBox(0, 'Сообщение', 'Выбран один и тот же файл.')
	If GUICtrlRead($ClearInp) = 1 And $file_3 = $file_1 Then
		GUICtrlSetData($file_2, '')
		GUICtrlSetData($md5_2, '')
		GUICtrlSetData($filen_2, '')
	EndIf
	_Compare()
EndFunc

Func _Compare()
	$file_10 = GUICtrlRead($file_1)
	$file_20 = GUICtrlRead($file_2)
	$md5_10 = GUICtrlRead($md5_1)
	$md5_20 = GUICtrlRead($md5_2)
	$Size_st = ' '
	
	If FileExists($file_10) And FileExists($file_20) Then
		$Size_10 = FileGetSize($file_10)
		$Size_20 = FileGetSize($file_20)
		If $Size_10 > $Size_20 Then
			$Size_st = ',         отношение размеров файла ' & Round($Size_10 / $Size_20, 1) & ' : 1'
		Else
			$Size_st = ',         отношение размеров файла 1 : ' & Round($Size_20 / $Size_10, 1)
		EndIf
		If $Size_10 = $Size_20 Then $Size_st = ',         отношение размеров файла 1=1'
	EndIf
	
	If $md5_20 And $md5_10 Then
		If $md5_20 = $md5_10 Then
			GUICtrlSetData($StatusBar, 'Совпадение' & $Size_st)
			GUICtrlSetColor($StatusBar, 0x007700)
			GUICtrlSetFont($StatusBar, 9, 700)
			GUICtrlSetColor($md5_2, 0x007700)
			GUICtrlSetColor($md5_1, 0x007700)
		Else
			GUICtrlSetData($StatusBar, 'Отличие' & $Size_st)
			GUICtrlSetColor($StatusBar, 0xEE0000)
			GUICtrlSetFont($StatusBar, 9, 700)
			GUICtrlSetColor($md5_2, 0xEE0000)
			GUICtrlSetColor($md5_1, 0xEE0000)
		EndIf
	EndIf
EndFunc

Func _AutoCheck($ex = 1)
	$AC_text = FileRead(@ScriptDir & '\AutoCheck.txt')
	If Not $AC_text Then Return

	$aFiletext = _SplitStringToArray($AC_text)
	; If @error Then Return

	$krit = ''
	$NotFile = ''
	For $i = 1 To UBound($aFiletext) - 1
		$aFile = StringSplit($aFiletext[$i], "|")
		If @error Or $aFile[0]<>2 Then ContinueLoop
		If FileExists($aFile[1]) Then
			$MD5 = StringTrimLeft(_Crypt_HashFile($aFile[1], $CALG_MD5), 2)
			If $MD5 <> $aFile[2] Then
				;$krit&=$aFile[1]&'|'&$aFile[2]&'|'&$MD5&@CRLF
				$krit &= $aFile[1] & @CRLF
			EndIf
		Else
			If Not $ex Then $NotFile &= @CRLF& 'Файл не существует: ' & $aFile[1]
		EndIf
	Next
	$krit &= $NotFile
	If $krit Then ; если содержится текст, то
		_Tabl($krit) ; просмотр в окне
		$file = FileOpen(@ScriptDir & '\AutoCheck.log', 1)
		FileWrite($file, "Дата: " & @YEAR & "." & @MON & "." & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & @CRLF & $krit & @CRLF)
		FileClose($file)
		If Not $ex Then
			GUICtrlSetColor($StatusBar, 0xEE0000)
			GUICtrlSetFont($StatusBar, 9, 700)
		EndIf
	EndIf
	If $ex Then Exit
EndFunc

Func _Tabl($krit)
	$aTabl = _SplitStringToArray($krit)

	If $aTabl[0] < 20 Then
		$pos = $aTabl[0]
	Else
		$pos = 20
	EndIf

	$kolbyk = 52
	For $i = 1 To $aTabl[0]
		$tmp = StringLen($aTabl[$i])
		If $tmp > $kolbyk Then $kolbyk = $tmp
	Next
	$kolbyk*=6
	If $kolbyk>@DesktopWidth-30 Then $kolbyk=@DesktopWidth-30

	$hGui1 = GUICreate("Несоответствие md5", $kolbyk, $pos * 17 + 40, -1, -1, $WS_SYSMENU+$WS_SIZEBOX)
	GUICtrlCreateEdit($krit, 0, 0, $kolbyk, $pos * 17 + 40)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetBkColor(-1, 0xffd7d7)

	GUISetState()
	If WinWaitActive($hGui1, '', 3) Then Send("{DOWN}")

	Do
	Until GUIGetMsg() = -3
	GUIDelete($hGui1)
EndFunc


Func _CreateList()
	Local $tmp = StringReplace(StringReplace($AutoPath, '|', '   ***  '), @CRLF, '|')
	If StringRight($tmp, 1) = '|' Then $tmp = StringTrimRight($tmp, 1)
	GUICtrlSetData($ListBox, '')
	GUICtrlSetData($ListBox, $tmp)
EndFunc

Func _implnk($ImplnkPath) ; чтение автозагрузки ярлыков
	Local $aLNK, $FileList
	$FileList = _FO_FileSearch($ImplnkPath, '*.lnk')
	If @error Then Return
	For $i = 1 To $FileList[0]
		$aLNK = FileGetShortcut($FileList[$i])
		If FileExists($aLNK[0]) And StringInStr($AutoPath, $aLNK[0] & '|') = 0 Then $AutoPath &= $aLNK[0] & '|' & StringTrimLeft(_Crypt_HashFile($aLNK[0], $CALG_MD5), 2) & @CRLF
	Next
EndFunc

Func _impreg($vetka) ; чтение автозагрузки реестра
	For $i = 1 To 50
		$Val = RegEnumVal($vetka, $i)
		If @error Then Return
		$znach = RegRead($vetka, $Val)
		If @error Then ContinueLoop
		$aPathexe = StringRegExp($znach, "(?i)(^.*)exe(.*)$", 3)
		If @error Then ContinueLoop
		$Pathexe1 = StringReplace($aPathexe[0], '"', '')
		If StringInStr($Pathexe1, '\') = 0 Then
			If FileExists(@SystemDir & '\' & $Pathexe1 & 'exe') Then $Pathexe1 = @SystemDir & '\' & $Pathexe1
		EndIf
		If FileExists($Pathexe1 & 'exe') And StringInStr($AutoPath, $Pathexe1 & 'exe|') = 0 Then $AutoPath &= $Pathexe1 & 'exe|' & StringTrimLeft(_Crypt_HashFile($Pathexe1 & 'exe', $CALG_MD5), 2) & @CRLF
	Next
EndFunc