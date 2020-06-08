#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=TextReplace.exe
#AutoIt3Wrapper_OutFile_X64=TextReplaceX64.exe
; #AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Icon=icons\TextReplace.ico
#AutoIt3Wrapper_Compression=n
#AutoIt3Wrapper_UseUpx=n
; #AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=TextReplace.exe
#AutoIt3Wrapper_Res_Fileversion=1.1.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Icon_Add=icons\1.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\2.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\3.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\4.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\5.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\6.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\7.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\8.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\9.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\10.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\11.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\12.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\13.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\14.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\15.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\16.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\17.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\18.ico
#AutoIt3Wrapper_Res_Field=Version|1.1.0.0
#AutoIt3Wrapper_Res_Field=Build|2013.04.13
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/SOI
; #Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
; #AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
; #AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\upx\upx.exe -7 --compress-icons=0 "%out%"
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2013.04.13 (AutoIt3_v3.3.6.1)

#NoAutoIt3Execute
#NoTrayIcon
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <Array.au3>
#include <ListBoxConstants.au3>
#include <StaticConstants.au3>
#include <GuiComboBox.au3>
#include <GuiRichEdit.au3>
#include "FileOperations.au3"
#include "ForTextReplace.au3"

Local $sLocale = 0
If $CmdLine[0] > 2 Then _RunCMD()
FileChangeDir(@ScriptDir)

Opt("GUIOnEventMode", 1)
Opt("GUICloseOnESC", 0)
Opt("GUIResizeMode", 0x0322) ; 802
Local $sep = Chr(1)
Opt("GUIDataSeparatorChar", $sep)
; Scenario
Local $ScrStart, $ScrPath, $aTextScr = '', $aScenario = ''
Local $aTypInp0[1], $iniAa = 0, $inisub = 0, $iniOutRes = 0, $sOutList = '', $SeaInp0, $RepInp0, $TypInp0, $PatInp0, $Out0, $WHXY[5], $RichPos[5], $lng, $iniSep = '}—•—{'
Local $TrEx = 0, $MinSizeH, $MaxSizeH ; , $TrScr = 0
; ini
Local $iniSea, $iniRep, $iniMask, $iniDef = '*' & $sep & '*.inf' & $sep & '*.bat|*.cmd' & $sep & '*.htm*' & $sep & '*.reg' & $sep & '*.txt' & $sep & '*.au3', $iniPath, $iniAa = 0, $inisub = 0, $iniBAK = 0, $iniREx = 0, $iniExc = 0, $ReData = 0, $ChData
Local $Ini = @ScriptDir & '\TextReplace.ini', $BackUpPath = ''
; Setting
Local $LangPath, $ComboLang, $iniLimitFile, $iniLimitSize, $InpLimitFile, $InpLimitSize, $InpErrSize, $iniErrSize = 180 * 1024 * 1024, $iniPathBackup, $InpPathBackup, $LbPathBackup, $LbLimitFile, $LbLimitSize, $InpHst, $LbHst, $KolStr, $atrR, $atrA, $atrH, $atrS, $ExcldAttrib = '', $IgnGr, $CharSet, $CharSetAuto, $ComboChar, $LbChS, $LbErrSize
Local $aSearch[1][2] = [[0]], $Tr_ViewT = -1, $Tr_View = True, $Tr_Sea = 0
Local $EditBoxSea, $EditBoxRep
; GUI...RichEdit
Local $Btn_Next, $Btn_Back, $Combo_Jump, $hRichEdit, $g_iTrPathDir = 1
; GUI, триггеры
Local $hGui, $Gui1, $TrStopLoop = 0
; About
Local $iScroll_Pos, $nLAbt, $hAbt, $wAbtBt, $TrAbt1, $TrAbt2, $tabAbt1, $StopPlay, $vk1, $BkCol2, $tabAbt0, $BkCol1

Switch RegRead("HKCU\Keyboard Layout\Preload", '1')
	Case 419
		$hf = 'а'
	Case 409
		$hf = 'f'
	Case Else
		$hf = ''
EndSwitch

If Not FileExists($Ini) Then
	$file = FileOpen($Ini, 2)
	FileWrite($file, _
			'[Set]' & @CRLF & _
			'Search=Text1' & $iniSep & 'Text2' & @CRLF & _
			'Replace=Text11' & $iniSep & 'Text22' & @CRLF & _
			'Mask=' & StringReplace($iniDef, $sep, $iniSep) & @CRLF & _
			'DefaultMask=' & StringReplace($iniDef, $sep, $iniSep) & @CRLF & _
			'Path=C:\WINDOWS\inf' & $iniSep & 'C:\Program Files\Notepad++' & @CRLF & _
			'Aa=0' & @CRLF & _
			'sub=1' & @CRLF & _
			'REx=0' & @CRLF & _
			'BAK=0' & @CRLF & _
			'OutRes=0' & @CRLF & _
			'ExceptMask=0' & @CRLF & _
			'LimitFile=20000' & @CRLF & _
			'LimitSize=100' & @CRLF & _
			'ErrSize=' & $iniErrSize & @CRLF & _
			'History=10' & @CRLF & _
			'PathBackup=' & @CRLF & _
			'CharSet=Auto' & @CRLF & _
			'PosL=30' & @CRLF & _
			'PosT=30' & @CRLF & _
			'PosW=361' & @CRLF & _
			'PosH=480' & @CRLF & _
			'PosMax=0' & @CRLF & _
			'RichW=790' & @CRLF & _
			'RichH=500' & @CRLF & _
			'RichL=' & @CRLF & _
			'RichT=' & @CRLF & _
			'RichMax=0' & @CRLF & _
			'ReData=0' & @CRLF & _
			'Lang=')
	FileClose($file)
EndIf

; En
$LngScrollAbt = 'The tool is designed' & @LF & _
		'to find and replace text in any files. The program supports scenarios replace, regular expressions, command line.' & @LF & @LF & _
		'All parameters of the script commands are unique and do not depend on the current program settings. ' & _
		'The button is designed to create backup copies of changed files in the specified directory or the default program directory. ' & @LF & @LF & _
		'The utility is written in AutoIt3' & @LF & _
		'autoitscript.com'

Global $aLng0[105][2] = [[ _
		104, 0],[ _
		'Title', 'TextReplace'],[ _
		'About', 'About'],[ _
		'Ver', 'Version'],[ _
		'Site', 'Site'],[ _
		'Copy', 'Copy'],[ _
		'Sb1', 'StatusBar		( drag-and-drop )'],[ _
		'AaH1', 'Current:' & @LF & 'not case sensitive'],[ _
		'AaH2', 'Current:' & @LF & 'case sensitive'],[ _
		'RExH1', 'Current:' & @LF & 'Do not use regular expression'],[ _
		'RExH2', 'Current:' & @LF & 'Use regular expression'],[ _
		'SubH1', 'Current:' & @LF & 'Search only in the root directory'],[ _
		'SubH2', 'Current:' & @LF & 'Search in subfolders'],[ _
		'BAKH1', 'Current:' & @LF & 'Do not backup'],[ _
		'BAKH2', 'Current:' & @LF & 'Do backup'],[ _
		'OutRH1', 'Current:' & @LF & 'Results not show'],[ _
		'OutRH2', 'Current:' & @LF & 'Results show of searching for'],[ _
		'RBrH', 'Viewing search results'],[ _
		'CRLF', 'Symbol CRLF'],[ _
		'CRLFH', 'Select symbol CRLF'],[ _
		'PSmb', 'Add'],[ _
		'Sea', 'Find'],[ _
		'Rep', 'Replace'],[ _
		'OScr', 'Open *.srt'],[ _
		'AScr', 'Add in *.srt'],[ _
		'Cr', 'Clear'],[ _
		'Msk', 'Mask'],[ _
		'Def', 'Default'],[ _
		'Pth', 'Path'],[ _
		'Ed', 'Editor'],[ _
		'EdH', 'Open in editor (txt)'],[ _
		'St', 'Execute'],[ _
		'StH', 'Start'],[ _
		'Sp', 'Esc - Stop'],[ _
		'Err', 'Error'],[ _
		'MB1', 'Path is not specified or does not exist'],[ _
		'MB2', 'Not a text of searching'],[ _
		'MB3', 'Lines of searching for and change alike or not a text of searching'],[ _
		'MB4', 'It Is Required open *.srt'],[ _
		'MB5', 'no data'],[ _
		'MB6', 'Such already there is in list'],[ _
		'Sb2', 'Searching / count of the files ...'],[ _
		'Sb3', 'Nothing be not found, for'],[ _
		'Sb4', '(total | checked | found | all), for'],[ _
		'SbS', 'sec'],[ _
		'Sb5', 'Searching / Replace ...'],[ _
		'SVD', 'Select/Create file'],[ _
		'SVD1', 'file'],[ _
		'OD', 'Select'],[ _
		'OD1', 'Any'],[ _
		'OF', 'Select'],[ _
		'G1T', 'List'],[ _
		'LV1', 'Find'],[ _
		'LV2', 'Replace'],[ _
		'US', 'Use'],[ _
		'USH', 'Use all'],[ _
		'Sl', 'Choose file'],[ _
		'Rest', 'Restart TextReplace'],[ _
		'EdF', 'Editor+F'],[ _
		'EdFH', 'Open in editor (txt) and find'],[ _
		'Epr', 'Explorer'],[ _
		'MLineSH', 'Searching for multiline text'],[ _
		'MLineRH', 'Searching and replace for multiline text'],[ _
		'bSet', 'Setting'],[ _
		'SzFl', 'Warn volume files over, MB'],[ _
		'MFile', 'Warn if number of files over'],[ _
		'SzEr', 'Maximum file size, KB' & @LF & 'with more than ~190 MB get the error memory'],[ _
		'BakPh', 'The path to the backup folder'],[ _
		'Hst', 'Number of items in the ComboBox'],[ _
		'MB7', 'The number of files ('],[ _
		'MB8', ') exceeds the limit specified in the settings ('],[ _
		'MB9', '). Continue processing?'],[ _
		'MB10', 'Volume occupied by the file ('],[ _
		'MB11', 'MB) exceeds the limit specified in the settings ('],[ _
		'MB12', 'MB). Continue processing?'],[ _
		'MB13', 'The specified volume occupied by the file is not a positive number '],[ _
		'MB14', 'Specified number of files is not a positive integer'],[ _
		'MB15', 'Specified number of points of history is not a number from 1 to 50'],[ _
		'MB16', 'The specified path is invalid for the backup and can not be created. Enter the correct path otherwise the backups will be created in the program folder.'],[ _
		'ExcH1', 'Current:' & @LF & 'The mask specifies the files'],[ _
		'ExcH2', 'Current:' & @LF & 'No files specified in the mask'],[ _
		'MB17', 'Disk backup is not available for copying or path is not valid. Want to continue without backup?'],[ _
		'MB18', 'Cancel operation. Specified in the script path does not exist'],[ _
		'MB19', 'Number of characters in a string search and replace must be an even'],[ _
		'MB20', 'Turn on the display of detailed results and next do a search.'],[ _
		'IgnGr', 'Ignore files with attributes'],[ _
		'AtrR', 'read-only'],[ _
		'AtrA', 'archival'],[ _
		'AtrH', 'hidden'],[ _
		'AtrS', 'System'],[ _
		'Data', 'Do not change the modification date of files'],[ _
		'ChS', 'CharSet'],[ _
		'Nxt', 'Next'],[ _
		'Bck', 'Back'],[ _
		'TTp', 'Close'],[ _
		'Lst', 'To clipboard'],[ _
		'ERg', 'Error in regular expression'],[ _
		'LbCb1', 'Name without extension'],[ _
		'LbCb2', 'Name + extension'],[ _
		'LbCb3', 'Relative path'],[ _
		'LbCb4', 'Full path'],[ _
		'LbCb5', 'Save to File'],[ _
		'MB21', 'This line already exists in the script.' & @LF & 'Still add?'],[ _
		'MB22', 'The number of rows exceeds the number of files. Continue?'],[ _
		'Cnl', 'Cancel']]

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$sLocale = 'А-яЁё'
	$LngScrollAbt = 'Утилита предназначена' & @LF & _
			'для поиска и замены текста в любых файлах. Поддержка сценариев замены, регулярных выражений, ком-строки.' & @LF & @LF & _
			'Символ переноса строк - простой способ выполнить поиск и замену многострочного текста. В качестве переноса строк выбирается подстановочный символ, которого нет в тексте поиска и замены, и используем этот символ в полях ввода поиска и замены. ' & _
			'Сценарий замены можно создать средствами TextReplace, или открыть в блокноте и вручную править и добавлять комментарии. ' & _
			'Все параметры команды сценария являются индивидуальными и не зависят от текущих настроек программы. ' & _
			'Кнопка резервирования включает операцию создания копий изменяемых файлов в указанном каталоге или по умолчанию в каталоге программы. ' & @LF & @LF & _
			'Утилита написана на AutoIt3' & @LF & _
			'autoitscript.com'
	
	Dim $aLng0[105][2] = [[ _
			104, 0],[ _
			'Title', 'TextReplace'],[ _
			'About', 'О программе'],[ _
			'Ver', 'Версия'],[ _
			'Site', 'Сайт'],[ _
			'Copy', 'Копировать'],[ _
			'Sb1', 'Строка состояния		( используйте drag-and-drop )'],[ _
			'AaH1', 'Текущее состояние:\nне учитывать регистр букв'],[ _
			'AaH2', 'Текущее состояние:\nучитывать регистр букв'],[ _
			'RExH1', 'Текущее состояние:\nНе использовать регулярное выражение\nРекомендуется'],[ _
			'RExH2', 'Текущее состояние:\nИспользовать регулярное выражение\nНе рекомендуется'],[ _
			'SubH1', 'Текущее состояние:\nпоиск только в корневой папке'],[ _
			'SubH2', 'Текущее состояние:\nпоиск во вложенных папках'],[ _
			'BAKH1', 'Текущее состояние:\nНе бэкапировать изменяемые файлы'],[ _
			'BAKH2', 'Текущее состояние:\nБэкапировать изменяемые файлы'],[ _
			'OutRH1', 'Текущее состояние:\nНе выводить результаты поиска'],[ _
			'OutRH2', 'Текущее состояние:\nВыводить результаты поиска'],[ _
			'RBrH', 'Просмотр результатов поиска'],[ _
			'CRLF', 'Символ переноса строк'],[ _
			'CRLFH', 'Выберите подстановочный знак для переноса строки\nи используйте его в полях ввода поиска и замены'],[ _
			'PSmb', 'Добавить'],[ _
			'Sea', 'Найти текст'],[ _
			'Rep', 'Заменить текст на ...'],[ _
			'OScr', 'Открыть сценарий замены'],[ _
			'AScr', 'Добавить образцы в сценарий'],[ _
			'Cr', 'Очистить поле ввода'],[ _
			'Msk', 'Маска'],[ _
			'Def', 'Сброс раскрывающегося списка\nмаски по умолчанию'],[ _
			'Pth', 'Путь, где искать'],[ _
			'Ed', 'Редактор'],[ _
			'EdH', 'Открыть в редакторе' & @LF & 'ассоциированным с txt'],[ _
			'St', 'Выполнить'],[ _
			'StH', 'Запуск в ассоциированной программе'],[ _
			'Sp', 'Esc - Отмена'],[ _
			'Err', 'Сообщение'],[ _
			'MB1', 'Путь не указан или не существует'],[ _
			'MB2', 'Не указан текст поиска'],[ _
			'MB3', 'Строки поиска и замены одинаковы или не указан текст поиска'],[ _
			'MB4', 'Требуется открыть сценарий'],[ _
			'MB5', 'нет данных'],[ _
			'MB6', 'Такой уже есть в списке'],[ _
			'Sb2', 'Поиск / подсчёт файлов и объёма ...'],[ _
			'Sb3', 'Ничего не найдено, за'],[ _
			'Sb4', '(всего | проверено | найдено | общее), за'],[ _
			'SbS', 'сек'],[ _
			'Sb5', 'Поиск и замена ...'],[ _
			'SVD', 'Указать/Создать файл'],[ _
			'SVD1', 'Сценарий'],[ _
			'OD', 'Указать файл'],[ _
			'OD1', 'Любой'],[ _
			'OF', 'Указать папку'],[ _
			'G1T', 'Список замен'],[ _
			'LV1', 'найти'],[ _
			'LV2', 'заменить'],[ _
			'US', 'Использовать сценарий'],[ _
			'USH', 'Для последовательной замены по текущему списку'],[ _
			'Sl', 'Выбрать файл'],[ _
			'Rest', 'Перезапуск утилиты'],[ _
			'EdF', 'Редактор+F'],[ _
			'EdFH', 'Открыть в редакторе ассоциированным' & @LF & 'с txt-файлами и выполнить поиск'],[ _
			'Epr', 'В проводнике'],[ _
			'MLineSH', 'Поиск многострочного текста'],[ _
			'MLineRH', 'Поиск и замена для многострочного текста'],[ _
			'bSet', 'Настройки'],[ _
			'SzFl', 'Предупреждать, если объём файлов более, МБ'],[ _
			'MFile', 'Предупреждать, если количество файлов более'],[ _
			'SzEr', 'Максимальный размер файлов, КБ' & @LF & 'при более ~190 МБ получим ошибку памяти'],[ _
			'BakPh', 'Путь к резервной папке'],[ _
			'Hst', 'Количество пунктов в раскрывающемся списке'],[ _
			'MB7', 'Количество файлов ('],[ _
			'MB8', ') превышает указанный в настройках лимит ('],[ _
			'MB9', '). Продолжить обработку?'],[ _
			'MB10', 'Объём файлов ('],[ _
			'MB11', 'МБ) превышает указанный в настройках лимит ('],[ _
			'MB12', 'МБ). Продолжить обработку?'],[ _
			'MB13', 'Указанный объём файлов не является положительным числом'],[ _
			'MB14', 'Указанное количество файлов не является положительным целым числом'],[ _
			'MB15', 'Указанное количество пунктов истории не является числом от 1 до 50'],[ _
			'MB16', 'Указанный путь для резервных копий невалидный и не может быть создан. Укажите правильно путь иначе резервные копии будут созданы в папке программы.'],[ _
			'ExcH1', 'Текущее состояние:' & @LF & 'Файлы определяемые маской'],[ _
			'ExcH2', 'Текущее состояние:' & @LF & 'Кроме файлов определяемых маской'],[ _
			'MB17', 'Диск резервирования не доступен для копирования' & @LF & 'или неверно указан путь. Хотите продолжить без  резервирования?'],[ _
			'MB18', 'Отмена операции. Указанные в сценарии пути не существуют'],[ _
			'MB19', 'Количество символов в строке поиска и замены должно быть чётное'],[ _
			'MB20', 'Включите режим вывода подробных результатов и далее сделайте поиск.'],[ _
			'IgnGr', 'Игнорировать файлы с атрибутами'],[ _
			'AtrR', 'Только чтение'],[ _
			'AtrA', 'Архивный'],[ _
			'AtrH', 'Скрытый'],[ _
			'AtrS', 'Системный'],[ _
			'Data', 'Дату изменения файлов отставлять прежней'],[ _
			'ChS', 'Кодировка'],[ _
			'Nxt', 'Далее'],[ _
			'Bck', 'Назад'],[ _
			'TTp', 'Закрыть'],[ _
			'Lst', 'В буфер обмена'],[ _
			'ERg', 'Ошибка в регулярном выражении'],[ _
			'LbCb1', 'Имя без расширение'],[ _
			'LbCb2', 'Имя + расширение'],[ _
			'LbCb3', 'Относительный путь'],[ _
			'LbCb4', 'Полный путь'],[ _
			'LbCb5', 'Сохранить в файл'],[ _
			'MB21', 'Данная строка уже существует в сценарии.' & @LF & 'Всё равно добавить?'],[ _
			'MB22', 'Количество строк в списке превышает количество строк содержащих пути. Продолжить?'],[ _
			'Cnl', 'Отмена']]
EndIf

For $i = 1 To $aLng0[0][0]
	If StringInStr($aLng0[$i][1], '\n') Then $aLng0[$i][1] = StringReplace($aLng0[$i][1], '\n', @LF)
	Assign('Lng' & $aLng0[$i][0], $aLng0[$i][1])
Next

$LangPath = IniRead($Ini, 'Set', 'Lang', 'none')
If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then
	$aLng = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng')
	If Not @error Then
		For $i = 1 To $aLng[0][0]
			If StringInStr($aLng[$i][1], '\n') Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\n', @LF)
			If IsDeclared('Lng' & $aLng[$i][0]) Then Assign('Lng' & $aLng[$i][0], $aLng[$i][1])
		Next
	EndIf
EndIf

$iniSea = StringReplace(IniRead($Ini, 'Set', 'Search', ''), $iniSep, $sep)
$iniRep = StringReplace(IniRead($Ini, 'Set', 'Replace', ''), $iniSep, $sep)
$iniDef = StringReplace(IniRead($Ini, 'Set', 'DefaultMask', $iniDef), $iniSep, $sep)
$iniMask = StringReplace(IniRead($Ini, 'Set', 'Mask', $iniDef), $iniSep, $sep)
$iniPath = StringReplace(IniRead($Ini, 'Set', 'Path', ''), $iniSep, $sep)
$iniAa = Number(IniRead($Ini, 'Set', 'Aa', '0'))
$inisub = Number(IniRead($Ini, 'Set', 'sub', '0'))
$iniREx = Number(IniRead($Ini, 'Set', 'REx', '0'))
$iniBAK = Number(IniRead($Ini, 'Set', 'BAK', '0'))
$iniOutRes = Number(IniRead($Ini, 'Set', 'OutRes', '0'))
$iniExc = Number(IniRead($Ini, 'Set', 'ExceptMask', '0'))
$ReData = Number(IniRead($Ini, 'Set', 'ReData', $ReData))
$WHXY[0] = Number(IniRead($Ini, 'Set', 'PosW', '361'))
$WHXY[1] = Number(IniRead($Ini, 'Set', 'PosH', '480'))
$WHXY[2] = IniRead($Ini, 'Set', 'PosL', '30')
$WHXY[3] = IniRead($Ini, 'Set', 'PosT', '30')
$WHXY[4] = Number(IniRead($Ini, 'Set', 'PosMax', ''))
$iniPathBackup = IniRead($Ini, 'Set', 'PathBackup', '')
$iniLimitFile = Int(IniRead($Ini, 'Set', 'LimitFile', '20000'))
If $iniLimitFile < 1 Then $iniLimitFile = 20000
$iniLimitSize = Number(IniRead($Ini, 'Set', 'LimitSize', '100'))
If $iniLimitSize <= 0 Then $iniLimitSize = 100
$iniErrSize = Number(IniRead($Ini, 'Set', 'ErrSize', 188000000))
If $iniErrSize <= 0 Then $iniErrSize = 180 * 1024 * 1024
$KolStr = Int(IniRead($Ini, 'Set', 'History', '10'))
If $KolStr < 1 Or $KolStr > 50 Then $KolStr = 10
$CharSet = _CharNameToNum(IniRead($Ini, 'Set', 'CharSet', 'Auto'))

If $WHXY[0] < 361 Then $WHXY[0] = 361 ; ограничение ширины
If $WHXY[1] < 360 Then $WHXY[1] = 360 ; ограничение высоты
_SetCoor($WHXY, 35)

$Editor = _FileAssociation('.txt') ; получаем путь к редактору
If @error Then $Editor = @SystemDir & '\notepad.exe'

$hGui = GUICreate($LngTitle, $WHXY[0], 250, $WHXY[2], $WHXY[3], BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPCHILDREN), $WS_EX_ACCEPTFILES)
Global $aPosH2 = WinGetPos($hGui)
$MinSizeH = $aPosH2[3]
$MaxSizeH = $aPosH2[3]
GUISetOnEvent($GUI_EVENT_CLOSE, "_Quit")
; GUISetOnEvent($GUI_EVENT_DROPPED, "_Dropped")
GUISetOnEvent($GUI_EVENT_RESIZED, "_Resized")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "_Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "_Restore")
If @Compiled Then
	$AutoItExe = @AutoItExe
Else
	$AutoItExe = @ScriptDir & '\TextReplace.dll'
	GUISetIcon($AutoItExe, 1)
	If Not FileExists($AutoItExe) Then GUISetIcon("shell32.dll", -23)
EndIf

$StatusBar = GUICtrlCreateLabel($LngSb1, 5, 233, $WHXY[0] - 10, 15, 0xC)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)

$About = GUICtrlCreateButton("@", $WHXY[0] - 235, 2, 18, 20)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetTip(-1, $LngAbout)
GUICtrlSetOnEvent(-1, "_About")

$restart = GUICtrlCreateButton("R", $WHXY[0] - 215, 2, 18, 20)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetTip(-1, $LngRest)
GUICtrlSetOnEvent(-1, "_restart")

$AaBut = GUICtrlCreateCheckbox("--", 5, 5, 24, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 206, 0)
GUICtrlSetOnEvent(-1, "_AaBut")
If $iniAa Then
	GUICtrlSetTip(-1, $LngAaH2)
	GUICtrlSetState(-1, 1)
Else
	GUICtrlSetTip(-1, $LngAaH1)
EndIf

$RExBut = GUICtrlCreateCheckbox("--", 35, 5, 24, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 207, 0)
GUICtrlSetOnEvent(-1, "_RExBut")
If $iniREx Then
	GUICtrlSetTip($RExBut, $LngRExH2)
	GUICtrlSetState(-1, 1)
	GUICtrlSetState($AaBut, $GUI_DISABLE)
Else
	GUICtrlSetTip($RExBut, $LngRExH1)
	GUICtrlSetState($AaBut, $GUI_ENABLE)
EndIf

$BAKBut = GUICtrlCreateCheckbox("--", 65, 5, 24, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 209, 0)
GUICtrlSetOnEvent(-1, "_BAKBut")
If $iniBAK Then
	GUICtrlSetTip($BAKBut, $LngBAKH2)
	GUICtrlSetState(-1, 1)
Else
	GUICtrlSetTip($BAKBut, $LngBAKH1)
EndIf

GUICtrlCreateButton('Set', 95, 5, 24, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 210, 0)
; GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetTip(-1, $LngbSet)
GUICtrlSetOnEvent(-1, "_Setting")

$SubBut = GUICtrlCreateCheckbox("--", 120, 180, 24, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 208, 0)
GUICtrlSetOnEvent(-1, "_SubBut")
If $inisub Then
	GUICtrlSetTip(-1, $LngSubH2)
	GUICtrlSetState(-1, 1)
Else
	GUICtrlSetTip(-1, $LngSubH1)
EndIf

#region ; ряд 3 кнопки маска
$TypClear = GUICtrlCreateButton("X", 120, 130, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngCr)
GUICtrlSetImage(-1, $AutoItExe, 203, 0)
GUICtrlSetOnEvent(-1, "_Clear")

$ExcBut = GUICtrlCreateCheckbox("--", 150, 130, 24, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 211, 0)
GUICtrlSetOnEvent(-1, "_ExcBut")
If $iniExc Then
	GUICtrlSetTip($ExcBut, $LngExcH2)
	GUICtrlSetState(-1, 1)
Else
	GUICtrlSetTip($ExcBut, $LngExcH1)
EndIf

$TypDef = GUICtrlCreateButton("Def", 180, 130, 26, 24)
GUICtrlSetTip(-1, $LngDef)
GUICtrlSetOnEvent(-1, "_DefaultMask")
#endregion ; ряд 3 кнопки маска

#region ; ряд 4 кнопок поиска
$SeaClear = GUICtrlCreateButton("X", 120, 30, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngCr)
GUICtrlSetImage(-1, $AutoItExe, 203, 0)
GUICtrlSetOnEvent(-1, "_Clear")

$MLineS = GUICtrlCreateButton("SM", 150, 30, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngMLineSH)
GUICtrlSetImage(-1, $AutoItExe, 217, 0)
GUICtrlSetOnEvent(-1, "_EditBox")

$OutRBut = GUICtrlCreateCheckbox("swr", 180, 30, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 212, 0)
GUICtrlSetOnEvent(-1, "_OutRBut")
If $iniOutRes Then
	GUICtrlSetTip(-1, $LngOutRH2)
	GUICtrlSetState(-1, 1)
Else
	GUICtrlSetTip(-1, $LngOutRH1)
EndIf

$RBrBut = GUICtrlCreateButton("--", 210, 30, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 213, 0)
GUICtrlSetOnEvent(-1, "_Res_Byfer")
GUICtrlSetTip(-1, $LngRBrH)
#endregion ; ряд 4 кнопок поиска

#region ; ряд 4 кнопок замены
$RepClear = GUICtrlCreateButton("X", 120, 80, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngCr)
GUICtrlSetImage(-1, $AutoItExe, 203, 0)
GUICtrlSetOnEvent(-1, "_Clear")

$MLineR = GUICtrlCreateButton("RM", 150, 80, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngMLineRH)
GUICtrlSetImage(-1, $AutoItExe, 217, 0)
GUICtrlSetOnEvent(-1, "_EditBoxM")

$ScrRep = GUICtrlCreateButton("Scr", 180, 80, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngOScr)
GUICtrlSetImage(-1, $AutoItExe, 205, 0)
GUICtrlSetOnEvent(-1, "_ScrRep")

$AddRep = GUICtrlCreateButton("Add", 210, 80, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngAScr)
GUICtrlSetImage(-1, $AutoItExe, 204, 0)
GUICtrlSetOnEvent(-1, "_AddRep")
#endregion ; ряд 4 кнопок замены

$specsymbol = $sep & ChrW(0x00A9) & $sep & ChrW(0x00AE) & $sep & ChrW(0x00AB) & $sep & ChrW(0x00BB) & $sep & ChrW(0x2030) & $sep & ChrW(0x00A7) & $sep & ChrW(0x00B5) & $sep & ChrW(0x20AC) & $sep & ChrW(0x2122)

$CRLF = GUICtrlCreateCombo("", $WHXY[0] - 65, 2, 54)
GUICtrlSetData(-1, $sep & $sep & '~' & $sep & '@' & $sep & '%' & $sep & '&' & $sep & '*' & $sep & '^' & $sep & '#' & $sep & '\' & $sep & '/' & $sep & '+' & $sep & '-' & $sep & '_' & $sep & '{' & $sep & '}' & $sep & '[' & $sep & ']' & $sep & '`' & $sep & '<' & $sep & '>' & $specsymbol, '')
GUICtrlSetTip(-1, $LngCRLFH)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
$CRLFLab = GUICtrlCreateLabel($LngCRLF, $WHXY[0] - 192, 5, 125, 15, $SS_RIGHT)
GUICtrlSetTip(-1, $LngCRLFH)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

; $spec = GUICtrlCreateCombo("", 294, 25, 44)
$spec = GUICtrlCreateCombo("", $WHXY[0] - 55, 28, 44, 23, $CBS_DROPDOWNLIST + $WS_VSCROLL)
GUICtrlSetData(-1, $sep & $sep & ChrW(0x9) & $specsymbol, '')
GUICtrlSetTip(-1, $LngPSmb)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_Spec")
$specLab = GUICtrlCreateLabel($LngPSmb, $WHXY[0] - 122, 32, 65, 15, $SS_RIGHT)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

$SeaBtn = GUICtrlCreateButton("S", $WHXY[0] - 34, 53, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngSea)
GUICtrlSetImage(-1, $AutoItExe, 99, 0)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_Search")
$SeaLab = GUICtrlCreateLabel($LngSea, 7, 40, 86, 15)
$SeaInp = GUICtrlCreateCombo("", 5, 55, $WHXY[0] - 45)
GUICtrlSetData(-1, $iniSea, StringRegExpReplace($iniSea, '(^.*?)(?:' & $sep & '.*)$', '\1'))
GUICtrlSetResizing(-1, 7 + 32 + 512)

$RepBtn = GUICtrlCreateButton("R", $WHXY[0] - 34, 103, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngRep)
GUICtrlSetImage(-1, $AutoItExe, 201, 0)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_ReplaceOnce")
$RepLab = GUICtrlCreateLabel($LngRep, 7, 90, 110, 15)
$RepInp = GUICtrlCreateCombo("", 5, 105, $WHXY[0] - 45)
GUICtrlSetData(-1, $iniRep, StringRegExpReplace($iniRep, '(^.*?)(?:' & $sep & '.*)$', '\1'))
GUICtrlSetResizing(-1, 7 + 32 + 512)

$TypLab = GUICtrlCreateLabel($LngMsk, 7, 140, 110, 15)
$TypInp = GUICtrlCreateCombo("", 5, 155, $WHXY[0] - 45)
GUICtrlSetData(-1, $iniMask, StringRegExpReplace($iniMask, '(^.*?)(?:' & $sep & '.*)$', '\1'))
GUICtrlSetResizing(-1, 7 + 32 + 512)
$Folder1 = GUICtrlCreateButton("...", $WHXY[0] - 34, 153, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 202, 0)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_Folder1")

$PatLab = GUICtrlCreateLabel($LngPth, 7, 190, 110, 15)
$PatInp = GUICtrlCreateCombo("", 5, 205, $WHXY[0] - 45)
GUICtrlSetData(-1, $iniPath, StringRegExpReplace($iniPath, '(^.*?)(?:' & $sep & '.*)$', '\1'))
GUICtrlSetResizing(-1, 7 + 32 + 512)
$Folder2 = GUICtrlCreateButton("...", $WHXY[0] - 34, 203, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 202, 0)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_Folder2")

$Out = GUICtrlCreateList("", 5, 250, $WHXY[0] - 10, 10, BitOR($WS_BORDER, $WS_VSCROLL, $LBS_USETABSTOPS, $LBS_NOINTEGRALHEIGHT))
GUICtrlSetOnEvent(-1, "_ListBox")
GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
GUICtrlSetState(-1, $GUI_HIDE)

$EditBut = GUICtrlCreateButton($LngEd, 10, 250 - 28, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngEdH)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 2)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetOnEvent(-1, "_EditorOpen")
GUICtrlSetImage(-1, $AutoItExe, 214, 0)
$EditFBut = GUICtrlCreateButton($LngEdF, 40, 250 - 28, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngEdFH)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 2)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetOnEvent(-1, "_EditorTextFound")
GUICtrlSetImage(-1, $AutoItExe, 215, 0)
$StrBut = GUICtrlCreateButton($LngSt, 70, 250 - 28, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngStH)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 2)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetOnEvent(-1, "_StartFile")
GUICtrlSetImage(-1, $AutoItExe, 216, 0)
$EprBut = GUICtrlCreateButton('-', 100, 250 - 28, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngEpr)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 2)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetOnEvent(-1, "_ExplorerOpen")
GUICtrlSetImage(-1, $AutoItExe, 202, 0)
$LstBut = GUICtrlCreateButton('-', 130, 250 - 28, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngLst)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 2)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetOnEvent(-1, "_ListBox_GetText")
GUICtrlSetImage(-1, $AutoItExe, 218, 0)

$StopBut = GUICtrlCreateLabel($LngSp, -20, -20, 1, 1, 0xC)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_StopLoop")
GUICtrlSetFont(-1, Default, 700)
GUICtrlSetColor(-1, 0xff0000)

$OutContext = GUICtrlCreateContextMenu($Out)
$Cont1 = GUICtrlCreateMenuItem($LngEd, $OutContext)
GUICtrlSetOnEvent(-1, "_EditorOpen")
$Cont3 = GUICtrlCreateMenuItem($LngEdF, $OutContext)
GUICtrlSetOnEvent(-1, "_EditorTextFound")
$Cont2 = GUICtrlCreateMenuItem($LngSt, $OutContext)
GUICtrlSetOnEvent(-1, "_StartFile")
$Cont4 = GUICtrlCreateMenuItem($LngEpr, $OutContext)
GUICtrlSetOnEvent(-1, "_ExplorerOpen")
; $Cont5= GUICtrlCreateMenuitem('View',$OutContext)
; GUICtrlSetOnEvent(-1, "_View")

$HelpCHM = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_HelpCHM")

$insCRLF = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_CRLFins")

$ClearTTip = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_ClearTTip")

; $CtrlA=GUICtrlCreateDummy()
; GUICtrlSetOnEvent(-1, "_CtrlA")

Dim $AccelKeys[5][2] = [["{F1}", $HelpCHM],["!e", $EprBut],["!s", $SeaBtn],["^{Enter}", $insCRLF],["{F4}", $ClearTTip]] ; , ["^a", $CtrlA]

; если раскладка не совпадает с англ. яз. то временно переключаем в неё, чтобы зарегистрировать горячие клавиши
$tmp = 0
$KeyLayout = RegRead("HKCU\Keyboard Layout\Preload", 1)
If Not @error And $KeyLayout <> 00000409 Then
	_WinAPI_LoadKeyboardLayout(0x0409)
	$tmp = 1
EndIf

GUISetAccelerators($AccelKeys)
If $tmp = 1 Then _WinAPI_LoadKeyboardLayout(Dec($KeyLayout)) ; восстанавливаем раскладку по умолчанию

GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")
GUIRegisterMsg(0x0216, "WM_MOVING")
GUIRegisterMsg(0x0233, "WM_DROPFILES")
OnAutoItExitRegister('_Exit')

GUISetState(@SW_SHOW, $hGui)
If $WHXY[4] Then GUISetState(@SW_MAXIMIZE, $hGui)

While 1
	Sleep(1000000)
WEnd

Func _ClearTTip()
	$Tr_View = False
	ToolTip('')
EndFunc   ;==>_ClearTTip

; Func _CtrlA()
; $handle = ControlGetFocus("[ACTIVE]")
; $handle = ControlGetHandle("[ACTIVE]", '', "[CLASSNN:"&$handle&"]")
; GUICtrlSendMsg($handle, $EM_SETSEL, 0, -1)
; EndFunc

Func _HelpCHM()
	If FileExists(@ScriptDir & '\TextReplace.chm') Then
		ShellExecute('"' & @ScriptDir & '\TextReplace.chm"')
		; Run('hh.exe "'&@ScriptDir&'\TextReplace.chm')
	Else
		Return _About()
	EndIf
EndFunc   ;==>_HelpCHM

; авто-вставка переноса строки по Ctrl+Enter
Func _CRLFins()
	$CRLF0 = GUICtrlRead($CRLF)
	$SeaInp0 = GUICtrlRead($SeaInp)
	If Not $CRLF0 Then
		$CRLF0 = _CRLF_Define($SeaInp0)
		If @error Then Return
		GUICtrlSetData($CRLF, $CRLF0)
	EndIf
	_GUICtrlComboBox_SetEditText($SeaInp, $SeaInp0 & $CRLF0)
EndFunc   ;==>_CRLFins

Func WM_DROPFILES($hwnd, $msg, $wParam, $lParam)
	Local $aRet = DllCall("shell32.dll", "int", "DragQueryFile", "int", $wParam, "int", -1, "ptr", 0, "int", 0)
	If @error Then Return SetError(1, 0, 0)
	Local $sDroppedFiles, $tBuffer = DllStructCreate("char[256]")
	DllCall("shell32.dll", "int", "DragQueryFile", "int", $wParam, "int", 0, "ptr", DllStructGetPtr($tBuffer), "int", DllStructGetSize($tBuffer))
	$sDroppedFiles = DllStructGetData($tBuffer, 1)
	DllCall("shell32.dll", "none", "DragFinish", "int", $wParam)
	$tBuffer = 0
	; WinActivate($гуи) ; активирует окно, в которое брошены файлы
	If _FO_IsDir($sDroppedFiles) Then
		; _GUICtrlComboBox_InsertString($PatInp, $sDroppedFiles, 0)
		; GUICtrlSetData($PatInp, $sDroppedFiles)
		_ComboBox_InsertPath($sDroppedFiles, $iniPath, $PatInp)
	Else
		If StringRight($sDroppedFiles, 4) = '.srt' Then
			$ScrPath = $sDroppedFiles
			_ScenarioView()
		Else
			Local $tInfo
			If _GUICtrlComboBox_GetComboBoxInfo($PatInp, $tInfo) Then
				Local $tPoint = DllStructCreate($tagPoint)
				Local $xy = MouseGetPos()
				DllStructSetData($tPoint, "x", $xy[0])
				DllStructSetData($tPoint, "y", $xy[1])
				Local $hWnd0 = _WinAPI_WindowFromPoint($tPoint)
				If $hWnd0 = DllStructGetData($tInfo, "hEdit") Or $hWnd0 = DllStructGetData($tInfo, "hCombo") Then
					_ComboBox_InsertPath($sDroppedFiles, $iniPath, $PatInp) ; добавление к путям
				Else
					_mask($sDroppedFiles) ; добавление к маске
				EndIf
			EndIf
		EndIf
	EndIf
	Return "GUI_RUNDEFMSG"
EndFunc   ;==>WM_DROPFILES

Func _AaBut()
	If GUICtrlRead($AaBut) = 4 Then
		$iniAa = 0
		GUICtrlSetTip($AaBut, $LngAaH1)
	Else
		$iniAa = 1
		GUICtrlSetTip($AaBut, $LngAaH2)
		; GUICtrlSetState(-1, 1)
	EndIf
EndFunc   ;==>_AaBut

Func _SubBut()
	If GUICtrlRead($SubBut) = 4 Then
		$inisub = 0
		GUICtrlSetTip($SubBut, $LngSubH1)
	Else
		$inisub = 1
		GUICtrlSetTip($SubBut, $LngSubH2)
		; GUICtrlSetState(-1, 1)
	EndIf
EndFunc   ;==>_SubBut

Func _OutRBut()
	If GUICtrlRead($OutRBut) = 4 Then
		$iniOutRes = 0
		GUICtrlSetTip($OutRBut, $LngOutRH1)
		ToolTip('')
	Else
		$iniOutRes = 1
		GUICtrlSetTip($OutRBut, $LngOutRH2)
		; GUICtrlSetState(-1, 1)
	EndIf
EndFunc   ;==>_OutRBut

Func _RExBut()
	If GUICtrlRead($RExBut) = 4 Then
		$iniREx = 0
		GUICtrlSetTip($RExBut, $LngRExH1)
		GUICtrlSetState($AaBut, $GUI_ENABLE)
	Else
		$iniREx = 1
		GUICtrlSetTip($RExBut, $LngRExH2)
		; GUICtrlSetState(-1, 1)
		GUICtrlSetState($AaBut, $GUI_DISABLE)
	EndIf
EndFunc   ;==>_RExBut

Func _BAKBut()
	If GUICtrlRead($BAKBut) = 4 Then
		$iniBAK = 0
		GUICtrlSetTip($BAKBut, $LngBAKH1)
	Else
		$iniBAK = 1
		GUICtrlSetTip($BAKBut, $LngBAKH2)
		; GUICtrlSetState(-1, 1)
	EndIf
EndFunc   ;==>_BAKBut

Func _ExcBut()
	If GUICtrlRead($ExcBut) = 4 Then
		$iniExc = 0
		GUICtrlSetTip($ExcBut, $LngExcH1)
	Else
		$iniExc = 1
		GUICtrlSetTip($ExcBut, $LngExcH2)
		; GUICtrlSetState(-1, 1)
	EndIf
EndFunc   ;==>_ExcBut

Func _Spec()
	Local $spec0 = GUICtrlRead($spec), $SeaInp0 = GUICtrlRead($SeaInp)
	_GUICtrlComboBox_SetEditText($SeaInp, $SeaInp0 & $spec0)
EndFunc   ;==>_Spec

Func _Clear()
	Switch @GUI_CtrlId
		Case $SeaClear
			GUICtrlSetData($SeaInp, '')
			GUICtrlSetData($SeaInp, $iniSea, '')
			GUICtrlSetState($SeaInp, $GUI_FOCUS)
		Case $RepClear
			GUICtrlSetData($RepInp, '')
			GUICtrlSetData($RepInp, $iniRep, '')
			GUICtrlSetState($RepInp, $GUI_FOCUS)
		Case $TypClear
			GUICtrlSetData($TypInp, '')
			GUICtrlSetData($TypInp, $iniMask, '')
			GUICtrlSetState($TypInp, $GUI_FOCUS)
	EndSwitch
EndFunc   ;==>_Clear

Func _DefaultMask()
	GUICtrlSetData($TypInp, '')
	$iniMask = $iniDef
	GUICtrlSetData($TypInp, $iniMask, '') ; исправить
EndFunc   ;==>_DefaultMask

Func _StopLoop()
	$TrStopLoop = 1
EndFunc   ;==>_StopLoop

Func _GetFileList($sPath)
	Local $j, $tmp, $vFileList, $iEncoding
	$iEncoding = FileGetEncoding($sPath) ; определяем кодировку
	$hFile = FileOpen($sPath, $iEncoding) ; Открываем в нужной кодировке для поддержки китайских товарищей
	$vFileList = FileRead($hFile)
	FileClose($hFile)
	$vFileList=StringRegExpReplace($vFileList, '(?:[\r\n]+\h*)+', @CRLF) ; удаление пустых строк перед обработкой
	$vFileList=StringRegExpReplace($vFileList, '^[\r\n]+|[\r\n]+\z', '') ; удаление пустых строк в начале и в конце строки
	$tmp = StringRegExp($vFileList, '(?mi)^(.+?)\r?$', 3)
	$tmp = UBound($tmp) ; количество строк с данными в файле
	$vFileList = StringRegExp($vFileList, '(?mi)^([a-z]:\\.+?)\r?$', 3)
	If @error Then
		Return SetError(1) ; список пуст
	Else
		Local $aFileList[UBound($vFileList) + 1]
		$j = 0
		For $i = 0 To UBound($vFileList) - 1
			If FileExists($vFileList[$i]) Then
				$j += 1
				$aFileList[$j] = $vFileList[$i]
			EndIf
		Next
		If $j = 0 Then Return SetError(2) ; нет существующих файлов
		$aFileList[0] = $j
		ReDim $aFileList[$j + 1]
		Return SetError(0, $tmp, $aFileList) ; Возвращаем список файлов
	EndIf
EndFunc   ;==>_GetFileList

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
Func _Search()
	Local $aExcAttrib, $file, $seatext, $tmp, $timer, $iTotalRep, $extended
	$sOutList = ''
	ToolTip('')
	GUICtrlSetState($SeaBtn, $GUI_DISABLE)
	GUICtrlSetState($RepBtn, $GUI_DISABLE)
	GUICtrlSetData($StatusBar, '')
	$SeaInp0 = GUICtrlRead($SeaInp)
	$TypInp0 = GUICtrlRead($TypInp)
	$PatInp0 = GUICtrlRead($PatInp)
	$CRLF0 = GUICtrlRead($CRLF)
	If $CharSet = -1 Then
		$CharSetAuto = 1
	Else
		$CharSetAuto = 0
	EndIf

	$tmp = _FO_IsDir($PatInp0)
	If Not (@error Or $tmp) Then ; проверка, что указан список файлов или папка
		$FileList = _GetFileList($PatInp0)
		If @error Then
			MsgBox(0, $LngErr, $LngMB1, 0, $hGui)
			_Enable()
			Return
		EndIf
		$extended = @extended
		If $FileList[0] < $extended And MsgBox(4, $LngErr, $extended &' string'&@LF&$FileList[0] & ' files'&@LF& $LngMB22)=7 Then
			_Enable()
			Return
		EndIf
		$g_iTrPathDir = 0 ; это файл
	ElseIf $tmp Then
		$g_iTrPathDir = 1 ; это папка
	Else
		MsgBox(0, $LngErr, $LngMB1, 0, $hGui) ; путь не верный
		_Enable()
		Return
	EndIf

	If $SeaInp0 = '' Then ; проверка существования строки поиска
		MsgBox(0, $LngErr, $LngMB2, 0, $hGui)
		_Enable()
		Return
	EndIf
	_saveini(0)
	_ComboBox_InsertPath($PatInp0, $iniPath, $PatInp) ; вставка строки поиска в комбо при удачной проверке
	; Обработка переносов строк в поисковом запросе
	If $CRLF0 Then
		If StringLen($CRLF0) = 2 Then
			$CRLF0 = StringSplit($CRLF0, '')
			If $CRLF0[1] = $CRLF0[2] Then
				$SeaInp0 = StringReplace($SeaInp0, $CRLF0[1], @CRLF)
			Else
				$SeaInp0 = StringReplace($SeaInp0, $CRLF0[1], @CR)
				$SeaInp0 = StringReplace($SeaInp0, $CRLF0[2], @LF)
			EndIf
		Else
			$SeaInp0 = StringReplace($SeaInp0, $CRLF0, @CRLF)
		EndIf
	EndIf

	If $iniREx Then ; проверка валидности рег.выр.
		StringRegExp('a', $SeaInp0)
		If @error = 2 Then
			MsgBox(0, $LngErr, $LngERg, 0, $hGui)
			_Enable()
			Return
		EndIf
	EndIf
	GUICtrlSetData($StatusBar, $LngSb2)
	
	$timer = TimerInit() ; засекаем время
	If $g_iTrPathDir Then
		$Depth = 0
		If $inisub = 1 Then $Depth = 125
		If $iniExc Then
			$Include = False
		Else
			$Include = True
		EndIf
		$FileList = _FO_FileSearch($PatInp0, _FO_CorrectMask($TypInp0), $Include, $Depth, 1, 1, 1, $sLocale) ; получаем список файлов
		If @error Then
			$timer = TimerDiff($timer)
			If $timer < 9500 Then
				$timer = Round($timer / 1000, 1)
			Else
				$timer = Ceiling($timer / 1000)
			EndIf
			GUICtrlSetData($StatusBar, $LngSb3 & ' ' & $timer & ' ' & $LngSbS)
			_stat(0)
			_Enable()
			Return
		EndIf
	EndIf
	If $FileList[0] > $iniLimitFile And MsgBox(4, $LngErr, $LngMB7 & $FileList[0] & $LngMB8 & $iniLimitFile & $LngMB9, 0, $hGui) = 7 Then
		GUICtrlSetData($StatusBar, $LngCnl)
		_stat(0)
		_Enable()
		Return
	EndIf
	
	; выполняем подсчёт объёма
	Local $FileSize[$FileList[0] + 1] = [$FileList[0]] ; массив размеров файлов
	$Size = 0
	For $i = 1 To $FileList[0]
		$FileSize[$i] = FileGetSize($FileList[$i])
		$Size += $FileSize[$i]
	Next
	If $Size > $iniLimitSize * 1048576 And MsgBox(4, $LngErr, $LngMB10 & Round($Size / 1048576, 2) & $LngMB11 & $iniLimitSize & $LngMB12, 0, $hGui) = 7 Then
		GUICtrlSetData($StatusBar, $LngCnl)
		_stat(0)
		_Enable()
		Return
	EndIf
	$SizeText = _ConvertFileSize($Size)
	
	$GuiPos = WinGetPos($hGui)
	; выполнение с прогресс-баром
	$ProgressBar = GUICtrlCreateProgress($GuiPos[2] - 110, 233, 100, 16)
	GUICtrlSetColor(-1, 32250); цвет для классической темы
	GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
	
	GUICtrlSetPos($StopBut, $GuiPos[2] - 90, 185, 80, 17)
	GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 120, 15)
	
	If StringRight($PatInp0, 1) <> '\' Then $PatInp0 &= '\'
	; выполняем поиск в цикле для всех типов файлов
	$LenPath = StringLen($PatInp0)
	$Size1 = 0
	$kol = 0
	$ExcldAttrib = StringRegExpReplace($ExcldAttrib, '(?i)[^RASHNOT]', '') ; удаление из набора атрибутов "левых" символов
	$aExcAttrib = StringSplit($ExcldAttrib, '')
	HotKeySet("{ESC}", "_StopLoop")
	Dim $aSearch[1][2] = [[$PatInp0]]
	If $iniOutRes Then
		$p = ' *'
	Else
		$p = ' *p'
	EndIf
	For $i = 1 To $FileList[0]
		If $TrStopLoop Then
			; GUICtrlSetData($StatusBar, $LngCnl)
			; GUICtrlDelete($ProgressBar)
			; GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 10, 15)
			; GUICtrlSetPos($StopBut, -20, -20, 1, 1)
			; _stat(0)
			$i+=1
			$TrStopLoop = 0
			; _Enable()
			; Return
			ExitLoop
		EndIf
		$Size1 += $FileSize[$i]
		If $FileSize[$i] > $iniErrSize Then ContinueLoop
		If $g_iTrPathDir Then
			$seafile = StringTrimLeft($FileList[$i], $LenPath)
		Else
			$seafile = $FileList[$i]
		EndIf
		
		GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' | ' & $i & ' | ' & $kol & ' | ' & $iTotalRep & ' | ' & $seafile)
		
		$FileAttrib = FileGetAttrib($FileList[$i])
		For $j = 1 To $aExcAttrib[0]
			If StringInStr($FileAttrib, $aExcAttrib[$j]) Then ContinueLoop 2 ; если хоть один из исключаемых атрибутов в наличии, то пропускаем файл
		Next
		If $CharSetAuto Then
			$CharSet = FileGetEncoding($FileList[$i])
		Else
			If $CharSet <> 16 And $CharSet <> FileGetEncoding($FileList[$i]) Then ContinueLoop
		EndIf

		$file = FileOpen($FileList[$i], $CharSet)
		If $file = -1 Then ContinueLoop
		$seatext = FileRead($file)
		FileClose($file)
		
		If $iniOutRes Then
			If $iniREx Then
				$s0 = _StringInStrMultiR($seatext, $SeaInp0, $seafile)
			Else
				$s0 = _StringInStrMulti($seatext, $SeaInp0, $iniAa, $seafile)
			EndIf
			$iTotalRep += $s0
		Else
			If $iniREx Then
				$s0 = StringRegExp($seatext, $SeaInp0)
			Else
				$s0 = StringInStr($seatext, $SeaInp0, $iniAa)
			EndIf
		EndIf
		
		If $s0 Then
			$kol += 1
			$sOutList &= $seafile & $p & $s0 & $sep
		EndIf
		GUICtrlSetData($ProgressBar, Ceiling($Size1 / $Size * 100))
	Next
	HotKeySet("{ESC}")
	
	GUICtrlDelete($ProgressBar)
	GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 10, 15)

	$timer = TimerDiff($timer)
	If $timer < 9500 Then
		$timer = Round($timer / 1000, 1)
	Else
		$timer = Ceiling($timer / 1000)
	EndIf

	$i-=1
	If $sOutList = '' Then
		GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' | ' & $i & ' | ' & $kol & ' | ' & $iTotalRep & '   ' & $LngSb3 & ' ' & $timer & ' ' & $LngSbS)
		GUICtrlSetData($Out, '')
		_stat(0)
	Else
		GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' | ' & $i & ' | ' & $kol & ' | ' & $iTotalRep & '   ' & $LngSb4 & ' ' & $timer & ' ' & $LngSbS)
		GUICtrlSetData($Out, '')
		GUICtrlSetData($Out, $sOutList)
		_stat(1)
		ControlFocus($hGui, '', $Out)
		
		; автоматически выделить
		$Tr_View = False
		ControlCommand($hGui, "", $Out, "SetCurrentSelection", 0)
		; If GUICtrlSendMsg($Out, $LB_GETCOUNT, 0, 0) = 1 Then GUICtrlSendMsg($Out, $LB_SETCURSEL, 0, 0) ; автоматически выделить если один пункт
	EndIf
	If $CharSetAuto Then $CharSet = -1
	$Tr_Sea = 1
	$Tr_ViewT = 1000 ; любое число не совпадающее с выбором индекса в лисбокс
	GUICtrlSetPos($StopBut, -20, -20, 1, 1)
	_Enable()
EndFunc   ;==>_Search

; Func _View()
; If $Tr_Sea  Then
; Local $i=GUICtrlSendMsg($Out, $LB_GETCURSEL, 0, 0)
; If $i <> -1 Then MsgBox(0, 'Найденное в ' &$aSearch[$i+1][0], $aSearch[$i+1][1])
; EndIf
; EndFunc

Func _StringInStrMulti($seatext, $SeaInp0, $iniAa, $file)
	Local $end, $end2, $FindBlok, $long, $pos, $re, $str, $str2
	Local $s0 = 0, $sep = Chr(0) & Chr(1) & Chr(0)
	$long = StringLen($SeaInp0)
	$pos = 1 - $long
	While 1
		$pos = StringInStr($seatext, $SeaInp0, $iniAa, 1, $pos + $long)
		If $pos = 0 Then ExitLoop
		$s0 += 1
		$str = StringInStr($seatext, @LF, 0, -1, $pos) ; поиск ближайших символов переноса строки
		$str2 = StringInStr($seatext, @CR, 0, -1, $pos)
		If $str < $str2 Then $str = $str2
		$end = StringInStr($seatext, @CR, 0, 1, $pos + $long)
		$end2 = StringInStr($seatext, @LF, 0, 1, $pos + $long)
		If $end = 0 Then $end = $end2 ; корректировки при отсутствии символов
		If $end2 = 0 Then $end2 = $end
		If $end > $end2 Then $end = $end2
		If $end < $pos Or $end - $pos - $long > 40 Then $end = $pos + $long + 40
		If $pos - $str > 40 Then $str = $pos - 40
		$FindBlok = StringMid($seatext, $str + 1, $end - $str - 1)
		; If $long > 30 Then $FindBlok=StringReplace($FindBlok, $SeaInp0, '|-pattern-|')
		; $line=UBound(StringRegExp(StringLeft($seatext, $str), '(\r\n|\r|\n)', 3))+1 ; дорого обходится номер строки
		; StringReplace(StringLeft($seatext, $str), @CRLF, '') ; дорого обходится номер строки, но в 3 раза быстрее регулярки
		; $re[$s0][0]=$pos
		$re &= $FindBlok & $sep
	WEnd
	If $s0 Then
		$i = UBound($aSearch)
		ReDim $aSearch[$i + 1][2]
		$aSearch[$i][0] = $file & ' - ' & $s0
		$aSearch[$i][1] = StringTrimRight($re, 3)
	EndIf
	Return $s0
EndFunc   ;==>_StringInStrMulti

Func _StringInStrMultiR($seatext, $SeaInp0, $file)
	Local $aR, $end, $end2, $FindBlok, $long, $pos, $str, $str2, $tmp
	Local $s0 = 0
	$aR = StringRegExp($seatext, $SeaInp0, 4)
	If @error Then Return 0
	$s0 = UBound($aR)
	Local $re[$s0][3]
	$pos = 0
	For $i = 0 To $s0 - 1
		$tmp = $aR[$i]
		$aR[$i] = $tmp[0]
		$pos = StringInStr($seatext, $aR[$i], 1, 1, $pos + 1)
		If $pos = 0 Then ContinueLoop
		$long = StringLen($aR[$i])
		$str = StringInStr($seatext, @LF, 0, -1, $pos)
		$str2 = StringInStr($seatext, @CR, 0, -1, $pos)
		If $str < $str2 Then $str = $str2
		$end = StringInStr($seatext, @CR, 0, 1, $pos + $long)
		$end2 = StringInStr($seatext, @LF, 0, 1, $pos + $long)
		If $end = 0 Then $end = $end2
		If $end2 = 0 Then $end2 = $end
		If $end > $end2 Then $end = $end2
		If $end < $pos Or $end - $pos - $long > 40 Then $end = $pos + $long + 40
		If $pos - $str > 40 Then $str = $pos - 40
		$FindBlok = StringMid($seatext, $str + 1, $end - $str - 1)
		If $long > 30 Then
			$re[$i][0] = $pos
			$re[$i][1] = $aR[$i]
		Else
			$re[$i][0] = $pos
			$re[$i][1] = $aR[$i]
			$re[$i][2] = $FindBlok
		EndIf
	Next
	If $s0 Then
		$i = UBound($aSearch)
		ReDim $aSearch[$i + 1][2]
		$aSearch[$i][0] = $file & ' - ' & $s0
		$aSearch[$i][1] = $re
	EndIf
	Return $s0
EndFunc   ;==>_StringInStrMultiR

Func _ListBox()
	Local $i, $j, $kol, $sep, $txtres, $re
	If $Tr_Sea And $iniOutRes And UBound($aSearch) > 1 Then
		$i = GUICtrlSendMsg($Out, $LB_GETCURSEL, 0, 0)
		If $Tr_ViewT = $i And $i <> -1 Then
			If $Tr_View = True Then
				$Tr_View = False
				ToolTip('')
			Else
				$Tr_View = True
			EndIf
		EndIf
		If $Tr_View = True And $i <> -1 Then
			
			$sep = Chr(0) & Chr(1) & Chr(0)
			$kol = 0
			If $iniREx Then
				$txtres &= $aSearch[$i + 1][0] & @CRLF & @CRLF
				$kol += 1
				$re = $aSearch[$i + 1][1]
				For $j = 0 To UBound($re) - 1
					If $re[$j][2] Then
						$txtres &= $j + 1 & ' ---| ' & $re[$j][1] & @CRLF & ' -->| ' & $re[$j][2] & @CRLF
					Else
						$txtres &= $j + 1 & ' -->| ' & $re[$j][1] & @CRLF
					EndIf
					$kol += 1
					If $kol > 70 Then ExitLoop
				Next
			Else
				$txtres &= $aSearch[$i + 1][0] & @CRLF & @CRLF
				$kol += 1
				$re = StringSplit($aSearch[$i + 1][1], $sep, 1)
				For $j = 1 To $re[0]
					$txtres &= $j & ' -->| ' & $re[$j] & @CRLF
					$kol += 1
					If $kol > 70 Then ExitLoop ; обрезка если строк более 70 (на экран более не поместится, а подсказка глючит)
				Next
			EndIf
			$kol = Number(StringTrimLeft($aSearch[$i + 1][0], StringInStr($aSearch[$i + 1][0], ' - ') + 2))
			; MsgBox(0, '1', $kol)
			If $kol > 70 Then $txtres = StringLeft($txtres, StringInStr($txtres, @CRLF, 0, 70) - 1) & @CRLF & '...'
			$kol = StringLen($txtres)
			If $kol > 10000 Then $txtres = StringLeft($txtres, 10000) ; обрезка если символов более 10000
			; Заменяет нечитаемые символы квадратами (без них вывод обрезается по первому нечитаемому символу)
			$txtres = StringRegExpReplace($txtres, '[\000-\007\010\016\017\020-\027\030-\037\177]', ChrW('0x25A1'))
			ToolTip($txtres, -1, -1, StringTrimLeft($aSearch[$i + 1][0], StringInStr($aSearch[$i + 1][0], '\', 0, -1)) & '   (F4 - ' & $LngTTp & ')')
		EndIf
		$Tr_ViewT = $i
	EndIf
EndFunc   ;==>_ListBox

; Обработка старого формата массива в буфер обмена (восстановить и переделать в случае проблем с RichEdit)
; Func _Res_Byfer_Old()
; If $Tr_Sea And UBound($aSearch)>1 Then
; Local $tmp=''
; For $i = 0 to UBound($aSearch)-1
; $tmp&=$aSearch[$i][0]&@CRLF&$aSearch[$i][1]&@CRLF&@CRLF
; Next
; ClipPut($tmp)
; EndIf
; EndFunc

Func _Res_Byfer()
	Local $aRicheditTags, $Combo_Jump0, $ComboData, $EditBut, $Find, $i, $j, $msg, $pos = 0, $re, $Rsep, $sRTFCode = '', $StrBut, $tmp, $pos
	If Not ($Tr_Sea And UBound($aSearch) > 1) Then
		MsgBox(0, $LngErr, $LngMB20)
		Return
	EndIf
	$Rsep = Chr(0) & Chr(1) & Chr(0)
	Opt("GUIOnEventMode", 0)
	
	GUISetState(@SW_DISABLE, $hGui)
	If Not $RichPos[0] Then
		$RichPos[4] = Number(IniRead($Ini, 'Set', 'RichMax', ''))
		$RichPos[0] = Number(IniRead($Ini, 'Set', 'RichW', '790'))
		$RichPos[1] = Number(IniRead($Ini, 'Set', 'RichH', '500'))
		$RichPos[2] = IniRead($Ini, 'Set', 'RichL', '')
		$RichPos[3] = IniRead($Ini, 'Set', 'RichT', '')
		If $RichPos[0] < 200 Then $RichPos[0] = 200
		If $RichPos[1] < 200 Then $RichPos[1] = 200
		_SetCoor($RichPos)
	EndIf
	
	$Gui1 = GUICreate($aSearch[0][0], $RichPos[0], $RichPos[1], $RichPos[2], $RichPos[3], BitOR($WS_OVERLAPPEDWINDOW, $WS_POPUP, $WS_CLIPCHILDREN), -1, $hGui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 1)
	$hRichEdit = _GUICtrlRichEdit_Create($Gui1, "", 5, 5, $RichPos[0] - 10, $RichPos[1] - 40, BitOR($ES_MULTILINE, $WS_VSCROLL, $WS_HSCROLL, $ES_AUTOVSCROLL))
	_GUICtrlRichEdit_PauseRedraw($hRichEdit) ; приостановить перерисовку

	; ================================
	; изменяет любые теги RichEdit, которые находятся в коде.
	$aRicheditTags = StringRegExp($sRTFCode, '\\+par|\\+tab|\\+cf\d+', 3)
	If Not @error Then
		$aRicheditTags = _ArrayRemoveDuplicates($aRicheditTags)
		For $i = 0 To UBound($aRicheditTags) - 1
			$sRTFCode = StringReplace($sRTFCode, $aRicheditTags[$i], StringReplace($aRicheditTags[$i], '\', '#', 0, 2), 0, 2)
		Next
	EndIf
	; =================================

	; Формирование кода RTF из результатов поиска находящихся в массиве
	If $Tr_Sea And UBound($aSearch) > 1 Then
		If $iniREx Then ; если регулярное выражение
			For $i = 1 To UBound($aSearch) - 1
				$ComboData &= $sep & $i & '. ' & $aSearch[$i][0] ; для комбо
				$sRTFCode &= @CRLF & Chr(1) & 'cf2 ' & $i & '. ' & $aSearch[$i][0] & Chr(1) & 'cf0 ' & @CRLF
				$re = $aSearch[$i][1]
				For $j = 0 To UBound($re) - 1
					If $re[$j][2] Then
						$sRTFCode &= Chr(1) & 'cf3 ' & $j + 1 & ' -->| ' & Chr(1) & 'cf0 ' & StringReplace($re[$j][2], $re[$j][1], Chr(1) & 'cf1 ' & $re[$j][1] & Chr(1) & 'cf0 ') & @CRLF
					Else
						$sRTFCode &= Chr(1) & 'cf3 ' & $j + 1 & ' -->| ' & Chr(1) & 'cf0 ' & Chr(1) & 'cf1 ' & $re[$j][1] & Chr(1) & 'cf0 ' & @CRLF
					EndIf
				Next
			Next
		Else ; иначе текст
			For $i = 1 To UBound($aSearch) - 1
				$ComboData &= $sep & $i & '. ' & $aSearch[$i][0]
				$sRTFCode &= @CRLF & Chr(1) & 'cf2 ' & $i & '. ' & $aSearch[$i][0] & Chr(1) & 'cf0 ' & @CRLF
				$re = StringReplace($aSearch[$i][1], $SeaInp0, Chr(1) & 'cf1 ' & $SeaInp0 & Chr(1) & 'cf0 ')
				$re = StringSplit($re, $Rsep, 1)
				For $j = 1 To $re[0]
					$sRTFCode &= Chr(1) & 'cf3 ' & $j & ' -->| ' & Chr(1) & 'cf0 ' & $re[$j] & @CRLF
				Next
			Next
		EndIf
	EndIf
	$sRTFCode = StringTrimRight($sRTFCode, 2)

	; escape-символы для  RTF кода. Экранируем все спецсимволы, делая их литеральными (как есть)
	$sRTFCode = StringReplace($sRTFCode, '\', '\\', 0, 2)
	$sRTFCode = StringReplace($sRTFCode, '{', '\{', 0, 2)
	$sRTFCode = StringReplace($sRTFCode, '}', '\}', 0, 2)
	$sRTFCode = StringReplace($sRTFCode, @CR, '\par ' & @CRLF, 0, 2)
	$sRTFCode = StringReplace($sRTFCode, @TAB, '\tab ', 0, 2)

	$sRTFCode = StringReplace($sRTFCode, Chr(1), '\', 0, 2)
	; замена нечитаемых символов вопросами, иначе текст не вставляется в RichEdit после первого попавшегося нечитаемого символа
	$sRTFCode = StringRegExpReplace($sRTFCode, '[\000-\007\010\016\017\020-\027\030-\037\177]', ChrW('0x25A1'))

	__RESH_HeaderFooter($sRTFCode) ; Создать/присоединить шапку RichEdit. Текст будет форматированный

	; ================================
	; $Tmp=''
	; For $i = 1 To StringLen($sRTFCode)
	; $Tmp &=' '
	; Next
	; _GUICtrlRichEdit_SetText($hRichEdit, $Tmp) ; Вставляет пустой текст, чтобы расширить вмещаемость RichEdit
	; ================================
	_GUICtrlRichEdit_SetLimitOnText($hRichEdit, StringLen($sRTFCode)) ; увеличивает лимит, чтобы вместить весь текст

	_GUICtrlRichEdit_SetText($hRichEdit, $sRTFCode) ; Вставляет форматированный текст
	; _GUICtrlRichEdit_GotoCharPos($hRichEdit, 0) ; Перейти к началу
	_GUICtrlRichEdit_ResumeRedraw($hRichEdit) ; Возобновить перерисовку
	
	$Find = _GUICtrlRichEdit_FindText($hRichEdit, @CR & '1 -->| ')
	If Not @error And $Find <> -1 Then _GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find + 3) ; перемещает курсор в найденную позицию
	
	$Btn_Back = GUICtrlCreateButton($LngBck, 10, $RichPos[1] - 29, 120, 24)
	$Btn_Next = GUICtrlCreateButton($LngNxt, 140, $RichPos[1] - 29, 120, 24)
	$Combo_Jump = GUICtrlCreateCombo('', 270, $RichPos[1] - 29, $RichPos[0] - 280, -1, $CBS_DROPDOWNLIST + $WS_VSCROLL) ; $CBS_OEMCONVERT
	GUICtrlSetData($Combo_Jump, $ComboData, '')

	GUISetState(@SW_SHOW, $Gui1)
	GUIRegisterMsg(0x05, "_WM_SIZE_RichEdit")
	If $RichPos[4] Then GUISetState(@SW_MAXIMIZE, $Gui1)
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_MAXIMIZE
				$RichPos[4] = 1
			Case $GUI_EVENT_RESTORE
				$RichPos[4] = 0
				; Case $GUI_EVENT_RESIZED
				; $ClientSz = WinGetClientSize($hGui)
				; $RichPos[0] = $ClientSz[0]
				; $RichPos[1] = $ClientSz[1]
			Case $Combo_Jump
				$Combo_Jump0 = GUICtrlRead($Combo_Jump)
				If $Combo_Jump0 Then
					_GUICtrlRichEdit_GotoCharPos($hRichEdit, -1)
					$Find = _GUICtrlRichEdit_FindText($hRichEdit, $Combo_Jump0, False)
					If Not @error And $Find <> -1 Then
						_GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find)
						$Find = _GUICtrlRichEdit_FindText($hRichEdit, @CR & '1 -->| ')
						If Not @error And $Find <> -1 Then
							_GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find + 3)
							_GUICtrlRichEdit_ScrollToCaret($hRichEdit)
						EndIf
					EndIf
				EndIf
			Case $Btn_Next
				$Find = _GUICtrlRichEdit_FindText($hRichEdit, @CR & '1 -->| ')
				If Not @error And $Find <> -1 Then
					_GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find + 3) ; перемещает курсор в найденную позицию
					_GUICtrlRichEdit_ScrollToCaret($hRichEdit) ; прокручивает к курсору
				ElseIf $Find = -1 Then
					_GUICtrlRichEdit_GotoCharPos($hRichEdit, 0) ; перемещает курсор в найденную позицию
					$Find = _GUICtrlRichEdit_FindText($hRichEdit, @CR & '1 -->| ')
					If Not @error And $Find <> -1 Then
						_GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find + 3)
						_GUICtrlRichEdit_ScrollToCaret($hRichEdit) ; прокручивает к курсору
					EndIf
				EndIf
			Case $Btn_Back
				$Find = _GUICtrlRichEdit_FindText($hRichEdit, @CR & '1 -->| ', False)
				If Not @error And $Find <> -1 Then
					_GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find + 3) ; перемещает курсор в найденную позицию
					_GUICtrlRichEdit_ScrollToCaret($hRichEdit) ; прокручивает к курсору
					_GUICtrlRichEdit_ScrollLines($hRichEdit, -3)
				ElseIf $Find = -1 Then
					_GUICtrlRichEdit_GotoCharPos($hRichEdit, -1) ; перемещает курсор в найденную позицию
					$Find = _GUICtrlRichEdit_FindText($hRichEdit, @CR & '1 -->| ', False)
					If Not @error And $Find <> -1 Then
						_GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find + 3)
						_GUICtrlRichEdit_ScrollToCaret($hRichEdit) ; прокручивает к курсору
					EndIf
				EndIf
				; Case $GUI_EVENT_MINIMIZE
				; GUISetState(@SW_MINIMIZE, $hGui)
				; ExitLoop
			Case -3
				ExitLoop
		EndSwitch
	WEnd
	_GUICtrlRichEdit_Destroy($hRichEdit)
	GUIRegisterMsg(0x05, '')
	If Not $RichPos[4] Then
		$ClientSz = WinGetClientSize($Gui1)
		If $ClientSz[0] > 180 And $ClientSz[1] > 150 Then
			$RichPos[0] = $ClientSz[0]
			$RichPos[1] = $ClientSz[1]
			$aGuiPos = WinGetPos($Gui1)
			$RichPos[2] = $aGuiPos[0]
			$RichPos[3] = $aGuiPos[1]
		EndIf
		; MsgBox(0, 'Сообщение', $RichPos[0] &@CRLF&$RichPos[1] &@CRLF&$RichPos[2] &@CRLF&$RichPos[3])
	EndIf
	GUISetState(@SW_ENABLE, $hGui)
	GUIDelete($Gui1)
	Opt("GUIOnEventMode", 1)
EndFunc   ;==>_Res_Byfer

Func _WM_SIZE_RichEdit($hwnd, $msg, $wParam, $lParam)
	$w = BitAND($lParam, 0xFFFF) ; _WinAPI_LoWord
	$h = BitShift($lParam, 16) ; _WinAPI_HiWord
	_WinAPI_MoveWindow($hRichEdit, 5, 5, $w - 10, $h - 40)
	GUICtrlSetPos($Btn_Back, 10, $h - 30)
	GUICtrlSetPos($Btn_Next, 140, $h - 30)
	GUICtrlSetPos($Combo_Jump, 270, $h - 28, $w - 280)
	Return 0
EndFunc   ;==>_WM_SIZE_RichEdit

; Присоединение шапки RTF к тексту-коду
Func __RESH_HeaderFooter(ByRef $sCode)
	Local $g_RESH_sColorTable = _
			'\red255\green0\blue0;' & _ ; красный
			'\red0\green0\blue255;' & _ ; синий
			'\red99\green99\blue99;' ; серый
	$sCode = "{\rtf\ansi\ansicpg1251\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}}" & _ ; шрифт Ариал
			"{\colortbl;" & $g_RESH_sColorTable & "}{\*\generator Msftedit 5.41.21.2510;}\viewkind4\uc1\pard\f0\fs18" & _ ; размер шрифта 18
			StringStripWS($sCode, 2) & '}'
EndFunc   ;==>__RESH_HeaderFooter

Func _ArrayRemoveDuplicates(Const ByRef $aArray)
	If Not IsArray($aArray) Then Return SetError(1, 0, 0)
	Local $oSD = ObjCreate("Scripting.Dictionary")
	For $i In $aArray
		$oSD.Item($i); shown by wraithdu
	Next
	Return $oSD.Keys()
EndFunc   ;==>_ArrayRemoveDuplicates
; ============================

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
; Однократное выполнение операции (не сценарий)
Func _ReplaceOnce()
	Local $tmpData, $TrR, $TrH, $TrS, $aExcAttrib, $file, $Size2, $iTotalRep, $extended
	$sOutList = ''
	ToolTip('')
	GUICtrlSetState($SeaBtn, $GUI_DISABLE)
	GUICtrlSetState($RepBtn, $GUI_DISABLE)
	GUICtrlSetData($StatusBar, '')
	$SeaInp0 = GUICtrlRead($SeaInp)
	$RepInp0 = GUICtrlRead($RepInp)
	$TypInp0 = GUICtrlRead($TypInp)
	$PatInp0 = GUICtrlRead($PatInp)
	$CRLF0 = GUICtrlRead($CRLF)
	If $CharSet = -1 Then
		$CharSetAuto = 1
	Else
		$CharSetAuto = 0
	EndIf

	; проверки-защиты
	If $SeaInp0 == $RepInp0 And (StringRight($RepInp0, 4) <> '.srt' Or Not FileExists($RepInp0)) Then ; ошибка входных данных
		MsgBox(0, $LngErr, $LngMB3, 0, $hGui)
		_Enable()
		Return
	EndIf
	If $SeaInp0 = $RepInp0 And StringRight($RepInp0, 4) = '.srt' And FileExists($RepInp0) Then ; если сценарий, то
		If IsArray($aTextScr) Then ; если сценарий не пустой
			Return _ReplaceLoop($RepInp0) ; вызов обработки сценария
		Else
			; $TrScr = 0
			MsgBox(0, $LngErr, $LngMB4, 0, $hGui)
			_Enable()
			Return
		EndIf
	EndIf

	$tmp = _FO_IsDir($PatInp0)
	If Not (@error Or $tmp) Then ; проверка, что указан список файлов или папка
		$FileList = _GetFileList($PatInp0)
		If @error Then
			MsgBox(0, $LngErr, $LngMB1, 0, $hGui)
			_Enable()
			Return
		EndIf
		$extended = @extended
		If $FileList[0] < $extended And MsgBox(4, $LngErr, $extended &' string'&@LF&$FileList[0] & ' files'&@LF& $LngMB22)=7 Then
			_Enable()
			Return
		EndIf
		$g_iTrPathDir = 0 ; это файл
	ElseIf $tmp Then
		$g_iTrPathDir = 1 ; это папка
	Else
		MsgBox(0, $LngErr, $LngMB1, 0, $hGui) ; путь не верный
		_Enable()
		Return
	EndIf

	If $SeaInp0 = '' Then
		MsgBox(0, $LngErr, $LngMB2, 0, $hGui)
		_Enable()
		Return
	EndIf
	If $CharSet = 16 And Not $iniREx Then
		$SeaInp0 = StringUpper($SeaInp0)
		If Mod(StringLen($SeaInp0), 2) <> Mod(StringLen($RepInp0), 2) Then
			MsgBox(0, $LngErr, $LngMB19, 0, $hGui)
			_Enable()
			Return
		EndIf
	EndIf

	GUICtrlSetData($StatusBar, $LngSb5)
	_saveini(0)
	_ComboBox_InsertPath($PatInp0, $iniPath, $PatInp)
	; Выполняем функции, которые не ресурсоёмкие и на раннем этапе могут возвратить ошибку без ожидания поиска файлов
	; Обработка переносов строк в поисковом запросе
	If $CRLF0 Then _CRLF($CRLF0, $SeaInp0, $RepInp0)

	If $iniREx Then ; проверка валидности рег.выр.
		StringRegExp('a', $SeaInp0)
		If @error = 2 Then
			MsgBox(0, $LngErr, $LngERg, 0, $hGui)
			_Enable()
			Return
		EndIf
	EndIf

	; делаем резервные копии
	; If $iniBAK Then
	; $BackUpPath=_BackUp($iniBAK)&StringRegExpReplace($Path, '^(.*\\)(.*?\\)$', '\2')
	; If @error Then Return
	; EndIf
	
	If StringRight($PatInp0, 1) <> '\' Then $PatInp0 &= '\'
	; делаем резервные копии... определяем путь и возможность резервирования
	If $iniBAK = 1 Then
		If $iniPathBackup = '' Then
			$tmp = @ScriptDir & '\Backup\'
		Else
			$tmp = $iniPathBackup
		EndIf
		If StringRegExp($tmp, '(?i)^[a-z]:[^/:*?"<>|]*$') And StringInStr('|Removable|Fixed|', '|' & DriveGetType(StringLeft($tmp, 1) & ':\') & '|') And Not StringInStr($tmp, '\\') Then
			If $iniPathBackup And StringRight($iniPathBackup, 1) <> '\' Then $iniPathBackup &= '\'
			$BackUpPath = $tmp
		Else
			If MsgBox(4, $LngErr, $LngMB17, 0, $hGui) = 7 Then
				_Enable()
				Return
			EndIf
		EndIf
		$BackUpPath &= @YEAR & "." & @MON & "." & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & "_" & StringRegExpReplace($PatInp0, '^(.*\\)(.*?\\)$', '\2')
	EndIf

	; засекаем время
	$timer = TimerInit()
	If $g_iTrPathDir Then
		$Depth = 0
		If $inisub = 1 Then $Depth = 125
		If $iniExc Then
			$Include = False
		Else
			$Include = True
		EndIf
		$FileList = _FO_FileSearch($PatInp0, _FO_CorrectMask($TypInp0), $Include, $Depth, 1, 1, 1, $sLocale) ; получаем список файлов
		If @error Then
			GUICtrlSetData($StatusBar, $LngSb3 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
			_stat(0)
			_Enable()
			Return
		EndIf
	EndIf
	If $FileList[0] > $iniLimitFile And MsgBox(4, $LngErr, $LngMB7 & $FileList[0] & $LngMB8 & $iniLimitFile & $LngMB9, 0, $hGui) = 7 Then
		GUICtrlSetData($StatusBar, $LngCnl)
		_stat(0)
		_Enable()
		Return
	EndIf
	
	; выполняем подсчёт объёма
	Local $FileSize[$FileList[0] + 1] = [$FileList[0]] ; массив размеров файлов
	$Size = 0
	For $i = 1 To $FileList[0]
		$FileSize[$i] = FileGetSize($FileList[$i])
		$Size += $FileSize[$i]
	Next
	If $Size > $iniLimitSize * 1048576 And MsgBox(4, $LngErr, $LngMB10 & Round($Size / 1048576, 2) & $LngMB11 & $iniLimitSize & $LngMB12, 0, $hGui) = 7 Then
		GUICtrlSetData($StatusBar, $LngCnl)
		_stat(0)
		_Enable()
		Return
	EndIf
	$SizeText = _ConvertFileSize($Size)
	
	$GuiPos = WinGetPos($hGui)
	; выполнение с прогресс-баром
	$ProgressBar = GUICtrlCreateProgress($GuiPos[2] - 110, 233, 100, 16)
	GUICtrlSetColor(-1, 32250); цвет для классической темы
	GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
	
	GUICtrlSetPos($StopBut, $GuiPos[2] - 90, 185, 80, 17)
	GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 120, 15)
	
	$LenPath = StringLen($PatInp0)
	
	; выполняем поиск в цикле для всех типов файлов
	$Size1 = 0
	$kol = 0
	$ExcldAttrib = StringRegExpReplace($ExcldAttrib, '(?i)[^RASHNOT]', '') ; удаление из набора атрибутов "левых" символов
	$aExcAttrib = StringSplit($ExcldAttrib, '')
	HotKeySet("{ESC}", "_StopLoop")
	For $i = 1 To $FileList[0]
		If $TrStopLoop Then
			; GUICtrlSetData($StatusBar, $LngCnl)
			; GUICtrlDelete($ProgressBar)
			; GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 10, 15)
			; GUICtrlSetPos($StopBut, -20, -20, 1, 1)
			; _stat(0)
			$i+=1
			$TrStopLoop = 0
			; _Enable()
			; Return
			ExitLoop
		EndIf
		$Size1 += $FileSize[$i]
		If $FileSize[$i] > $iniErrSize Then ContinueLoop
		If $g_iTrPathDir Then
			$seafile = StringTrimLeft($FileList[$i], $LenPath)
		Else
			$seafile = $FileList[$i]
		EndIf
		
		GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' | ' & $i & ' | ' & $kol & ' | ' & $iTotalRep & ' | ' & $seafile)
		
		$FileAttrib = FileGetAttrib($FileList[$i])
		For $j = 1 To $aExcAttrib[0]
			If StringInStr($FileAttrib, $aExcAttrib[$j]) Then ContinueLoop 2
		Next
		
		If $CharSetAuto Then
			$CharSet = FileGetEncoding($FileList[$i])
		Else
			If $CharSet <> 16 And $CharSet <> FileGetEncoding($FileList[$i]) Then ContinueLoop
		EndIf

		$file = FileOpen($FileList[$i], $CharSet)
		If $file = -1 Then ContinueLoop
		$seatext = FileRead($file)
		FileClose($file)
		
		; If $TrScr = 0 Then
		If $iniREx Then
			$seatext = StringRegExpReplace($seatext, $SeaInp0, $RepInp0)
			$s0 = @extended
		Else
			$seatext = StringReplace($seatext, $SeaInp0, $RepInp0, 0, $iniAa)
			$s0 = @extended
		EndIf
		; Else ; Бывший обработчик сценария
			; $s0 = 0
			; For $m = 1 To $aTextScr[0]
				; $aTmp = StringSplit($aTextScr[$m], $iniSep, 1)
				; If $aTmp[0] > 3 Then ContinueLoop
				; If $iniREx Then
					; $seatext = StringRegExpReplace($seatext, $aTmp[1], $aTmp[2])
					; $s0 += @extended
				; Else
					; $seatext = StringReplace($seatext, $aTmp[1], $aTmp[2], 0, $iniAa)
					; $s0 += @extended
				; EndIf
			; Next
		; EndIf

		If $s0 <> 0 Then
			$kol += 1
			If $iniBAK = 1 Then FileCopy($FileList[$i], $BackUpPath & StringReplace($seafile, ':', ''), 8) ; добавлена замена ":" в пути
			If $ReData Then $tmpData = FileGetTime($FileList[$i], 0, 1)
			$TrR = StringInStr($FileAttrib, 'R')
			$TrH = StringInStr($FileAttrib, 'H')
			$TrS = StringInStr($FileAttrib, 'S')
			If $TrR Then FileSetAttrib($FileList[$i], '-R')
			If $TrH Then FileSetAttrib($FileList[$i], '-H')
			If $TrS Then FileSetAttrib($FileList[$i], '-S')
			$file = FileOpen($FileList[$i], $CharSet + 2)
			If Not FileWrite($file, $seatext) Then $s0 = 0
			FileClose($file)
			If $ReData Then FileSetTime($FileList[$i], $tmpData)
			If $TrR Then FileSetAttrib($FileList[$i], '+R')
			If $TrH Then FileSetAttrib($FileList[$i], '+H')
			If $TrS Then FileSetAttrib($FileList[$i], '+S')
			$sOutList &= $seafile & ' *' & $s0 & $sep
			$iTotalRep += $s0
		EndIf
		GUICtrlSetData($ProgressBar, Ceiling($Size1 / $Size * 100))
	Next
	HotKeySet("{ESC}")
	GUICtrlDelete($ProgressBar)

	$timer = TimerDiff($timer)
	If $timer < 9500 Then
		$timer = Round($timer / 1000, 1)
	Else
		$timer = Ceiling($timer / 1000)
	EndIf

	$i-=1
	If $sOutList = '' Then
		GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' | ' & $i & ' | ' & $kol & ' | ' & $iTotalRep & '   ' & $LngSb3 & ' ' & $timer & ' ' & $LngSbS)
		GUICtrlSetData($Out, '')
		_stat(0)
	Else
		GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' | ' & $i & ' | ' & $kol & ' | ' & $iTotalRep & '   ' & $LngSb4 & ' ' & $timer & ' ' & $LngSbS)
		GUICtrlSetData($Out, '')
		GUICtrlSetData($Out, $sOutList)
		_stat(1)
		ControlFocus($hGui, '', $Out)
		
		; автоматически выделить
		$Tr_View = False
		ControlCommand($hGui, "", $Out, "SetCurrentSelection", 0)
	EndIf
	If $CharSetAuto Then $CharSet = -1
	$aTextScr = ''
	; $TrScr = 0
	$Tr_Sea = 0
	GUICtrlSetPos($StopBut, -20, -20, 1, 1)
	_Enable()
EndFunc   ;==>_ReplaceOnce

; $BackUp имеет 3 варианта:
; 0 - не резервировать
; 1 - резервировать в дефолтный каталог, в папку программы
; путь - резервировать в указанный путь, если он соответствует валидности и диск существует и доступен для записи.
Func _BackUp(ByRef $BackUp)
	Local $BackUpPath
	If StringRegExp($BackUp, '(?i)^[a-z]:[^/:*?"<>|]*$') And Not StringInStr($BackUp, '\\') Then
		If StringRight($BackUp, 1) <> '\' Then $BackUp &= '\'
		$BackUpPath = $BackUp
	Else
		$BackUpPath = @ScriptDir & '\Backup\'
	EndIf
	
	If Not StringInStr('|Removable|Fixed|', '|' & DriveGetType(StringLeft($BackUpPath, 1) & ':\') & '|') Then Return SetError(1, 0, '')
	$BackUp = 1
	$BackUpPath &= @YEAR & "." & @MON & "." & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & "_"
	Return $BackUpPath
EndFunc   ;==>_BackUp

; Это только для обработки сценария замены
Func _ReplaceLoop($RepInp0)
	Local $PathListErr, $s
	ToolTip('')
	_ReadScenario($RepInp0)
	$s = UBound($aScenario)
	; Проверка существования путей и валидность бинарного шаблона
	$PathListErr = ''
	For $i = 0 To $s - 1
		If Not FileExists($aScenario[$i][6]) Then $PathListErr &= $aScenario[$i][6] & @CRLF
		If $aScenario[$i][12] = 'Bin' And $aScenario[$i][3] = '0' Then
			$aScenario[$i][0] = StringUpper($aScenario[$i][0])
			If Mod(StringLen($aScenario[$i][0]), 2) <> Mod(StringLen($aScenario[$i][1]), 2) Then
				MsgBox(0, $LngErr, $LngMB19 & @CRLF & $aScenario[$i][0] & @CRLF & $aScenario[$i][1], 0, $hGui)
				_Enable()
				Return
			EndIf
		EndIf
	Next
	If $PathListErr <> '' Then
		MsgBox(0, $LngErr, $LngMB18 & @CRLF & $PathListErr)
		_stat(0)
		_Enable()
		Return
	EndIf
	Local $ch[$s]
	For $i = 0 To $s - 1
		$ch[$i] = $aScenario[$i][6] & $aScenario[$i][7] & $aScenario[$i][8] & $aScenario[$i][9] & $aScenario[$i][11] & $aScenario[$i][12]
	Next
	$aUni = _ArrayUnique($ch)
	If Not @error And $aUni[0] = 1 Then
		; Здесь вставить проверку одинаковости некоторых параметров, чтобы переключится на экономичную функцию, которая единожды откроет файл и сделает многократные замены, вместо многократного открытия файла для разовой замены.
		For $i = 0 To $s - 1
			If $aScenario[$i][5] Then
				$aScenario[0][5] = $aScenario[$i][5] ; бэкапирование в эконом-функции включается, если хотя бы одна команда сценария этого потребует
				ExitLoop
			EndIf
		Next
		_ReplaceEconom($aScenario)
	Else
		For $i = 0 To $s - 1
			_ReplaceFull($aScenario[$i][0], $aScenario[$i][1], $aScenario[$i][2], $aScenario[$i][3], $aScenario[$i][4], $aScenario[$i][5], $aScenario[$i][6], $aScenario[$i][7], $aScenario[$i][8], $aScenario[$i][9], $aScenario[$i][10], $aScenario[$i][11], _CharNameToNum($aScenario[$i][12]), '(' & $s & ' \ ' & $i & ')')
			If @error Then Return
		Next
	EndIf
EndFunc   ;==>_ReplaceLoop

; Func _ReplaceEconom($Search, $Replace, $Casesense, $RegExp, $CRLF)
Func _ReplaceEconom($aScenario)
	$sOutList = ''
	Local $BackUpPath, $file, $FileList, $LenPath, $seatext, $tmpData, $TrR, $TrH, $TrS, $aExcAttrib, $Size2, $iTotalRep
	Local $BackUp, $Path, $Mask, $Include, $Depth, $ReData, $ExcldAttrib, $CharSet
	$BackUp = $aScenario[0][5]
	$Path = $aScenario[0][6]
	$Mask = $aScenario[0][7]
	$Include = $aScenario[0][8]
	$Depth = $aScenario[0][9]
	$ReData = $aScenario[0][10]
	$ExcldAttrib = $aScenario[0][11]
	$CharSet = _CharNameToNum($aScenario[0][12])
	If $CharSet = -1 Then
		$CharSetAuto = 1
	Else
		$CharSetAuto = 0
	EndIf
	; Выполняем функции, которые не ресурсоёмкие и на раннем этапе могут возвратить ошибку без ожидания поиска файлов
	
	If StringRight($Path, 1) <> '\' Then $Path &= '\'
	; делаем резервные копии... получаем путь и возможность резервирования
	If $BackUp Then
		$BackUpPath = _BackUp($BackUp) & StringRegExpReplace($Path, '^(.*\\)(.*?\\)$', '\2')
		If @error Then Return SetError(1, 0, '')
	EndIf
	
	; засекаем время
	$timer = TimerInit()
	$Depth = 0
	If $inisub = 1 Then $Depth = 125
	If $Include Then
		$Include = True
	Else
		$Include = False
	EndIf
	$FileList = _FO_FileSearch($Path, _FO_CorrectMask($Mask), $Include, $Depth, 1, 1, 1, $sLocale) ; получаем список файлов
	If @error Then

		$timer = TimerDiff($timer)
		If $timer < 9500 Then
			$timer = Round($timer / 1000, 1)
		Else
			$timer = Ceiling($timer / 1000)
		EndIf

		GUICtrlSetData($StatusBar, $LngSb3 & ' ' & $timer & ' ' & $LngSbS)
		_stat(0)
		_Enable()
		Return SetError(1, 0, '')
	EndIf
	If $FileList[0] > $iniLimitFile And MsgBox(4, $LngErr, $LngMB7 & $FileList[0] & $LngMB8 & $iniLimitFile & $LngMB9, 0, $hGui) = 7 Then
		GUICtrlSetData($StatusBar, $LngCnl)
		_stat(0)
		_Enable()
		Return SetError(1, 0, '')
	EndIf
	
	; выполняем подсчёт объёма
	Local $FileSize[$FileList[0] + 1] = [$FileList[0]] ; массив размеров файлов
	$Size = 0
	For $i = 1 To $FileList[0]
		$FileSize[$i] = FileGetSize($FileList[$i])
		$Size += $FileSize[$i]
	Next
	If $Size > $iniLimitSize * 1048576 And MsgBox(4, $LngErr, $LngMB10 & Round($Size / 1048576, 2) & $LngMB11 & $iniLimitSize & $LngMB12, 0, $hGui) = 7 Then
		GUICtrlSetData($StatusBar, $LngCnl)
		_stat(0)
		_Enable()
		Return SetError(1, 0, '')
	EndIf
	$SizeText = _ConvertFileSize($Size)
	
	$GuiPos = WinGetPos($hGui)
	; выполнение с прогресс-баром
	$ProgressBar = GUICtrlCreateProgress($GuiPos[2] - 110, 233, 100, 16)
	GUICtrlSetColor(-1, 32250); цвет для классической темы
	GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
	
	GUICtrlSetPos($StopBut, $GuiPos[2] - 90, 185, 80, 17)
	GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 120, 15)
	
	$LenPath = StringLen($Path)
	
	; выполняем поиск в цикле для всех типов файлов
	$Size1 = 0
	$kol = 0
	$ExcldAttrib = StringRegExpReplace($ExcldAttrib, '(?i)[^RASHNOT]', '') ; удаление из набора атрибутов "левых" символов
	$aExcAttrib = StringSplit($ExcldAttrib, '')
	HotKeySet("{ESC}", "_StopLoop")
	For $i = 1 To $FileList[0]
		If $TrStopLoop Then
			; GUICtrlSetData($StatusBar, $LngCnl)
			; GUICtrlDelete($ProgressBar)
			; GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 10, 15)
			; GUICtrlSetPos($StopBut, -20, -20, 1, 1)
			; _stat(0)
			$i+=1
			$TrStopLoop = 0
			; _Enable()
			; Return
			ExitLoop
		EndIf
		$Size1 += $FileSize[$i]
		If $FileSize[$i] > $iniErrSize Then ContinueLoop
		$seafile = StringTrimLeft($FileList[$i], $LenPath)
		
		GUICtrlSetData($StatusBar, 'Econ (' & $SizeText & ') ' & $FileList[0] & ' | ' & $i & ' | ' & $kol & ' | ' & $iTotalRep & ' | ' & $seafile)
		
		$FileAttrib = FileGetAttrib($FileList[$i])
		For $j = 1 To $aExcAttrib[0]
			If StringInStr($FileAttrib, $aExcAttrib[$j]) Then ContinueLoop 2
		Next
		
		; $Search=$aScenario[$m][0]
		; $Replace=$aScenario[$m][1]
		; $Casesense=$aScenario[$m][2]
		; $RegExp=$aScenario[$m][3]
		; $CRLF=$aScenario[$m][4]
		If $CharSetAuto Then
			$CharSet = FileGetEncoding($FileList[$i])
		Else
			If $CharSet <> 16 And $CharSet <> FileGetEncoding($FileList[$i]) Then ContinueLoop
		EndIf

		$file = FileOpen($FileList[$i], $CharSet)
		If $file = -1 Then ContinueLoop
		$seatext = FileRead($file)
		FileClose($file)
		
		$s0 = 0
		For $m = 0 To UBound($aScenario) - 1
			If $aScenario[$m][4] Then _CRLF($aScenario[$m][4], $aScenario[$m][0], $aScenario[$m][1])
			If $aScenario[$m][3] Then
				$seatext = StringRegExpReplace($seatext, $aScenario[$m][0], $aScenario[$m][1])
				$s0 += @extended
			Else
				$seatext = StringReplace($seatext, $aScenario[$m][0], $aScenario[$m][1], 0, $aScenario[$m][2])
				$s0 += @extended
			EndIf
		Next

		If $s0 <> 0 Then
			$kol += 1
			If $BackUp = 1 Then FileCopy($FileList[$i], $BackUpPath & $seafile, 8)
			If $ReData = 1 Then $tmpData = FileGetTime($FileList[$i], 0, 1)
			$TrR = StringInStr($FileAttrib, 'R')
			$TrH = StringInStr($FileAttrib, 'H')
			$TrS = StringInStr($FileAttrib, 'S')
			If $TrR Then FileSetAttrib($FileList[$i], '-R')
			If $TrH Then FileSetAttrib($FileList[$i], '-H')
			If $TrS Then FileSetAttrib($FileList[$i], '-S')
			$file = FileOpen($FileList[$i], $CharSet + 2)
			If Not FileWrite($file, $seatext) Then $s0 = 0
			FileClose($file)
			If $ReData = 1 Then FileSetTime($FileList[$i], $tmpData)
			If $TrR Then FileSetAttrib($FileList[$i], '+R')
			If $TrH Then FileSetAttrib($FileList[$i], '+H')
			If $TrS Then FileSetAttrib($FileList[$i], '+S')
			$sOutList &= $seafile & ' *' & $s0 & $sep
			$iTotalRep += $s0
		EndIf
		GUICtrlSetData($ProgressBar, Ceiling($Size1 / $Size * 100))
	Next
	HotKeySet("{ESC}")
	GUICtrlDelete($ProgressBar)

	$timer = TimerDiff($timer)
	If $timer < 9500 Then
		$timer = Round($timer / 1000, 1)
	Else
		$timer = Ceiling($timer / 1000)
	EndIf

	$i-=1
	If $sOutList = '' Then
		GUICtrlSetData($StatusBar, 'Econ (' & $SizeText & ') ' & $FileList[0] & ' | ' & $i & ' | ' & $kol & ' | ' & $iTotalRep & '   ' & $LngSb3 & ' ' & $timer & ' ' & $LngSbS)
		GUICtrlSetData($Out, '')
		_stat(0)
	Else
		GUICtrlSetData($StatusBar, 'Econ (' & $SizeText & ') ' & $FileList[0] & ' | ' & $i & ' | ' & $kol & ' | ' & $iTotalRep & '   ' & $LngSb4 & ' ' & $timer & ' ' & $LngSbS)
		GUICtrlSetData($Out, '')
		GUICtrlSetData($Out, $sOutList)
		_stat(1)
		ControlFocus($hGui, '', $Out)
		
		; автоматически выделить
		$Tr_View = False
		ControlCommand($hGui, "", $Out, "SetCurrentSelection", 0)
	EndIf
	If $CharSetAuto Then $CharSet = -1
	$aTextScr = ''
	; $TrScr = 0
	$Tr_Sea = 0
	GUICtrlSetPos($StopBut, -20, -20, 1, 1)
	_Enable()
EndFunc   ;==>_ReplaceEconom

Func _ReplaceFull($Search, $Replace, $Casesense, $RegExp, $CRLF, $BackUp, $Path, $Mask, $Include, $Depth, $ReData, $ExcldAttrib, $CharSet, $stat)
	$sOutList = ''
	Local $BackUpPath, $file, $FileList, $LenPath, $seatext, $tmpData, $TrR, $TrH, $TrS, $aExcAttrib, $Size2, $iTotalRep
	If $CharSet = -1 Then
		$CharSetAuto = 1
	Else
		$CharSetAuto = 0
	EndIf
	; Выполняем функции, которые не ресурсоёмкие и на раннем этапе могут возвратить ошибку без ожидания поиска файлов
	; Обработка переносов строк в поисковом запросе
	If $CRLF Then _CRLF($CRLF, $Search, $Replace)
	
	If StringRight($Path, 1) <> '\' Then $Path &= '\'
	; делаем резервные копии... получаем путь и возможность резервирования
	If $BackUp Then
		$BackUpPath = _BackUp($BackUp) & StringRegExpReplace($Path, '^(.*\\)(.*?\\)$', '\2')
		If @error Then Return SetError(1, 0, '')
	EndIf
	
	; делаем резервные копии
	; If $BackUp = 1 Then
	; If StringRegExp($iniPathBackup, '(?i)^[a-z]:[^/:*?"<>|]*$') And StringInStr('|Removable|Fixed|', '|'&DriveGetType(StringLeft($iniPathBackup, 1)&':\' )&'|') And Not StringInStr($iniPathBackup, '\\') Then
	; If $iniPathBackup And StringRight($iniPathBackup, 1) <> '\' Then $iniPathBackup &= '\'
	; $BackUpPath=$iniPathBackup
	; Else
	; $BackUpPath=@ScriptDir&'\Backup\'
	; EndIf
	; $BackUpPath&=@YEAR&"."&@MON&"."&@MDAY&"_"&@HOUR&"."&@MIN&"."&@SEC&"_"&StringRegExpReplace($Path, '^(.*\\)(.*?\\)$', '\2')
	; EndIf
	
	; засекаем время
	$timer = TimerInit()
	$Depth = 0
	If $inisub = 1 Then $Depth = 125
	If $Include Then
		$Include = True
	Else
		$Include = False
	EndIf
	$FileList = _FO_FileSearch($Path, _FO_CorrectMask($Mask), $Include, $Depth, 1, 1, 1, $sLocale) ; получаем список файлов
	If @error Then

		$timer = TimerDiff($timer)
		If $timer < 9500 Then
			$timer = Round($timer / 1000, 1)
		Else
			$timer = Ceiling($timer / 1000)
		EndIf

		GUICtrlSetData($StatusBar, $LngSb3 & ' ' & $timer & ' ' & $LngSbS)
		_stat(0)
		_Enable()
		Return SetError(1, 0, '')
	EndIf
	If $FileList[0] > $iniLimitFile And MsgBox(4, $LngErr, $LngMB7 & $FileList[0] & $LngMB8 & $iniLimitFile & $LngMB9, 0, $hGui) = 7 Then
		GUICtrlSetData($StatusBar, $LngCnl)
		_stat(0)
		_Enable()
		Return SetError(1, 0, '')
	EndIf
	
	; выполняем подсчёт объёма
	Local $FileSize[$FileList[0] + 1] = [$FileList[0]] ; массив размеров файлов
	$Size = 0
	For $i = 1 To $FileList[0]
		$FileSize[$i] = FileGetSize($FileList[$i])
		$Size += $FileSize[$i]
	Next
	If $Size > $iniLimitSize * 1048576 And MsgBox(4, $LngErr, $LngMB10 & Round($Size / 1048576, 2) & $LngMB11 & $iniLimitSize & $LngMB12, 0, $hGui) = 7 Then
		GUICtrlSetData($StatusBar, $LngCnl)
		_stat(0)
		_Enable()
		Return SetError(1, 0, '')
	EndIf
	$SizeText = _ConvertFileSize($Size)
	
	$GuiPos = WinGetPos($hGui)
	; выполнение с прогресс-баром
	$ProgressBar = GUICtrlCreateProgress($GuiPos[2] - 110, 233, 100, 16)
	GUICtrlSetColor(-1, 32250); цвет для классической темы
	GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
	
	GUICtrlSetPos($StopBut, $GuiPos[2] - 90, 185, 80, 17)
	GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 120, 15)
	
	$LenPath = StringLen($Path)
	
	; выполняем поиск в цикле для всех типов файлов
	$Size1 = 0
	$kol = 0
	$ExcldAttrib = StringRegExpReplace($ExcldAttrib, '(?i)[^RASHNOT]', '') ; удаление из набора атрибутов "левых" символов
	$aExcAttrib = StringSplit($ExcldAttrib, '')
	HotKeySet("{ESC}", "_StopLoop")
	For $i = 1 To $FileList[0]
		If $TrStopLoop Then
			; GUICtrlSetData($StatusBar, $LngCnl)
			; GUICtrlDelete($ProgressBar)
			; GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 10, 15)
			; GUICtrlSetPos($StopBut, -20, -20, 1, 1)
			; _stat(0)
			$i+=1
			$TrStopLoop = 0
			; _Enable()
			; Return
			ExitLoop
		EndIf
		$Size1 += $FileSize[$i]
		If $FileSize[$i] > $iniErrSize Then ContinueLoop
		$seafile = StringTrimLeft($FileList[$i], $LenPath)
		
		GUICtrlSetData($StatusBar, $stat & ' (' & $SizeText & ') ' & $FileList[0] & ' | ' & $i & ' | ' & $kol & ' | ' & $iTotalRep & ' | ' & $seafile)
		
		$FileAttrib = FileGetAttrib($FileList[$i])
		For $j = 1 To $aExcAttrib[0]
			If StringInStr($FileAttrib, $aExcAttrib[$j]) Then ContinueLoop 2
		Next
		
		If $CharSetAuto Then
			$CharSet = FileGetEncoding($FileList[$i])
		Else
			If $CharSet <> 16 And $CharSet <> FileGetEncoding($FileList[$i]) Then ContinueLoop
		EndIf

		$file = FileOpen($FileList[$i], $CharSet)
		If $file = -1 Then ContinueLoop
		$seatext = FileRead($file)
		FileClose($file)
		
		If $RegExp Then
			$seatext = StringRegExpReplace($seatext, $Search, $Replace)
			$s0 = @extended
		Else
			$seatext = StringReplace($seatext, $Search, $Replace, 0, $Casesense)
			$s0 = @extended
		EndIf

		If $s0 <> 0 Then
			$kol += 1
			If $BackUp = 1 Then FileCopy($FileList[$i], $BackUpPath & $seafile, 8)
			If $ReData = 1 Then $tmpData = FileGetTime($FileList[$i], 0, 1)
			$TrR = StringInStr($FileAttrib, 'R')
			$TrH = StringInStr($FileAttrib, 'H')
			$TrS = StringInStr($FileAttrib, 'S')
			If $TrR Then FileSetAttrib($FileList[$i], '-R')
			If $TrH Then FileSetAttrib($FileList[$i], '-H')
			If $TrS Then FileSetAttrib($FileList[$i], '-S')
			$file = FileOpen($FileList[$i], $CharSet + 2)
			If Not FileWrite($file, $seatext) Then $s0 = 0
			FileClose($file)
			If $ReData = 1 Then FileSetTime($FileList[$i], $tmpData)
			If $TrR Then FileSetAttrib($FileList[$i], '+R')
			If $TrH Then FileSetAttrib($FileList[$i], '+H')
			If $TrS Then FileSetAttrib($FileList[$i], '+S')
			$sOutList &= $seafile & ' *' & $s0 & $sep
			$iTotalRep += $s0
		EndIf
		GUICtrlSetData($ProgressBar, Ceiling($Size1 / $Size * 100))
	Next
	HotKeySet("{ESC}")
	GUICtrlDelete($ProgressBar)

	$timer = TimerDiff($timer)
	If $timer < 9500 Then
		$timer = Round($timer / 1000, 1)
	Else
		$timer = Ceiling($timer / 1000)
	EndIf

	$i-=1
	If $sOutList = '' Then
		GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' | ' & $i & ' | ' & $kol & ' | ' & $iTotalRep & '   ' & $LngSb3 & ' ' & $timer & ' ' & $LngSbS)
		GUICtrlSetData($Out, '')
		_stat(0)
	Else
		GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' | ' & $i & ' | ' & $kol & ' | ' & $iTotalRep & '   ' & $LngSb4 & ' ' & $timer & ' ' & $LngSbS)
		GUICtrlSetData($Out, '')
		GUICtrlSetData($Out, $sOutList)
		_stat(1)
		ControlFocus($hGui, '', $Out)
		
		; автоматически выделить
		$Tr_View = False
		ControlCommand($hGui, "", $Out, "SetCurrentSelection", 0)
	EndIf
	If $CharSetAuto Then $CharSet = -1
	$aTextScr = ''
	; $TrScr = 0
	$Tr_Sea = 0
	GUICtrlSetPos($StopBut, -20, -20, 1, 1)
	_Enable()
EndFunc   ;==>_ReplaceFull

Func _AddRep()
	$tmpPath = FileSaveDialog($LngSVD, @WorkingDir, $LngSVD1 & " (*.srt)", 0, '', $hGui)
	If @error Then Return
	If StringRight($tmpPath, 4) <> '.srt' Then $tmpPath &= '.srt'
	$SeaInp0 = GUICtrlRead($SeaInp)
	$RepInp0 = GUICtrlRead($RepInp)
	; $ReData = 0
	; $ExcldAttrib = 0
	If $iniBAK Then
		If $iniPathBackup Then
			$tmpPathBackup = $iniPathBackup
		Else
			$tmpPathBackup = 1
		EndIf
	Else
		$tmpPathBackup = 0
	EndIf

	$PatInp0 = GUICtrlRead($PatInp)
	$tmp = _FO_IsDir($PatInp0)
	If Not (@error Or $tmp) Then ; проверка, что указан список файлов или папка
		Return MsgBox(0, $LngErr, $LngMB1 & @LF & 'List of files not supported', 0, $hGui)
	ElseIf Not $tmp Then
		Return MsgBox(0, $LngErr, $LngMB1, 0, $hGui) ; путь не верный
	EndIf

	If Not ($SeaInp0 == $RepInp0) And $SeaInp0 <> '' Then
		$sText = '-->|' & $SeaInp0 & $iniSep & $RepInp0 & $iniSep & $iniAa & $iniSep & $iniREx & $iniSep & GUICtrlRead($CRLF) & $iniSep & $tmpPathBackup & $iniSep & $PatInp0 & $iniSep & GUICtrlRead($TypInp) & $iniSep & $iniExc & $iniSep & $inisub & $iniSep & $ReData & $iniSep & $ExcldAttrib & $iniSep & _CharNumToName($CharSet) & '|<--'

		$tmp = StringInStr(FileRead($tmpPath), $sText, 1)
		If Not $tmp Or ($tmp And MsgBox(4+ 256, $LngErr, $LngMB21)=6) Then ; с проверкой существующих, с учётом регистра
			Local $hFile = FileOpen($tmpPath, 1 + 8)
			If FileGetSize($tmpPath) = 0 Then
				FileWrite($hFile, $sText)
			Else
				FileWrite($hFile, @CRLF & $sText)
			EndIf
			FileClose($hFile)
		EndIf
	Else
		MsgBox(0, $LngErr, $LngMB3, 0, $hGui)
		Return
	EndIf
EndFunc   ;==>_AddRep

Func _Enable()
	GUICtrlSetState($SeaBtn, $GUI_ENABLE)
	GUICtrlSetState($RepBtn, $GUI_ENABLE)
EndFunc   ;==>_Enable

Func _ScrRep()
	$tmpPath = FileOpenDialog($LngOD, @WorkingDir & "", $LngSVD1 & " (*.srt)", 1 + 4, '', $hGui)
	If @error Then Return
	$ScrPath = $tmpPath
	_ScenarioView()
EndFunc   ;==>_ScrRep

Func _EditorOpen()
	$Out0 = GUICtrlRead($Out)
	If Not $Out0 Then Return ; выделите файл
	$Out0 = StringLeft($Out0, StringInStr($Out0, '*') - 2)
	; $Out0=StringRegExpReplace($Out0, '(^.*)( \*\d+)$', '\1')
	If StringInStr($Out0, ':') Then $PatInp0 = ''
	Run($Editor & ' ' & $PatInp0 & $Out0)
EndFunc   ;==>_EditorOpen

Func _ExplorerOpen()
	$Out0 = GUICtrlRead($Out)
	If Not $Out0 Then Return ; выделите файл
	$Out0 = StringLeft($Out0, StringInStr($Out0, '*') - 2)
	; $Out0=StringRegExpReplace($Out0, '(^.*)( \*\d+)$', '\1')
	If StringInStr($Out0, ':') Then $PatInp0 = ''
	Run('Explorer.exe /select,"' & $PatInp0 & $Out0 & '"')
EndFunc   ;==>_ExplorerOpen

; Func _ListBox_GetText()
; Local $tmp = StringTrimRight(StringRegExpReplace($sOutList, '\s+\*[p\d]+' & $sep, @CRLF), 2)
; Switch MsgBox(3, 'List to clipboard', 'Select:' & @Tab & '|' & '  Format' &@LF& '-----------------------------------' &@LF& 'Yes' & @Tab & '|' & '  name' &@LF&  'No' & @Tab & '|' & '  name.ext' &@LF&  'Cancel' & @Tab & '|' & '  folder\name.ext' )
; Case 6 ; Yes
; $tmp = StringRegExpReplace($tmp, '(?m)^(?:.*\\)?([^\\]*?)(?:\.[^.]+)?$', '\1' & @CR)
; $tmp = StringTrimRight($tmp, 1)
; Case 7 ; No
; $tmp = StringRegExpReplace($tmp, '(?m)^(?:.*\\)?(.*)$', '\1')
; EndSwitch
; ClipPut($tmp)
; EndFunc

Func _ListBox_GetText() ; выбор экспорта списка в буфер
	Local $GP, $hFile, $idx, $iState, $iStateTmp, $OK, $tmp, $tmpPath
	Opt("GUIOnEventMode", 0)
	$GP = _ChildCoor($hGui, 240, 270)
	GUISetState(@SW_DISABLE, $hGui)
	; 'List to clipboard'
	$Gui1 = GUICreate($LngLst, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $hGui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 99)

	Local $radio[6]
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$radio[1] = GUICtrlCreateRadio($LngLbCb1, 20, 20, -1, 20)
	$radio[2] = GUICtrlCreateRadio($LngLbCb2, 20, 40, -1, 20)
	$radio[3] = GUICtrlCreateRadio($LngLbCb3, 20, 60, -1, 20)
	$radio[4] = GUICtrlCreateRadio($LngLbCb4, 20, 80, -1, 20)
	$radio[5] = GUICtrlCreateRadio($LngLbCb5, 20, 100, -1, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	If $g_iTrPathDir Then
		GUICtrlSetState($radio[3], $GUI_CHECKED)
	Else
		GUICtrlSetState($radio[4], $GUI_CHECKED)
		GUICtrlSetState($radio[3], $GUI_DISABLE)
	EndIf

	Local $iEncoding[6]
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$iEncoding[1] = GUICtrlCreateRadio('ANSI', 50, 120, -1, 20)
	GUICtrlSetState($iEncoding[1], $GUI_CHECKED)
	$iEncoding[2] = GUICtrlCreateRadio('UTF16 Little Endian', 50, 140, -1, 20)
	$iEncoding[3] = GUICtrlCreateRadio('UTF16 Big Endian', 50, 160, -1, 20)
	$iEncoding[4] = GUICtrlCreateRadio('UTF8 + BOM', 50, 180, -1, 20)
	$iEncoding[5] = GUICtrlCreateRadio('UTF8 - BOM', 50, 200, -1, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$iStateTmp = $GUI_DISABLE
	For $i = 1 To 5
		GUICtrlSetState($iEncoding[$i], $GUI_DISABLE)
	Next
	
	$OK = GUICtrlCreateButton("OK", 90, $GP[3] - 35, 60, 30)
	GUISetState(@SW_SHOW, $Gui1)
	$tmp = StringTrimRight(StringRegExpReplace($sOutList, '\s+\*[p\d]+' & $sep, @CRLF), 2)
	While 1
		Switch GUIGetMsg()
			Case $radio[1] to $radio[5]
				If BitAND(GUICtrlRead($radio[5]), $GUI_CHECKED) Then
					$iState = $GUI_ENABLE
				Else
					$iState = $GUI_DISABLE
				EndIf
				If $iState<>$iStateTmp Then
					For $i = 1 To 5
						GUICtrlSetState($iEncoding[$i], $iState)
					Next
					$iStateTmp = $iState
				EndIf
			Case $OK
				For $i = 1 To 5
					If BitAND(GUICtrlRead($radio[$i]), $GUI_CHECKED) Then
						$idx = $i
						ExitLoop
					EndIf
				Next
				Switch $idx
					Case 1
						$tmp = StringRegExpReplace($tmp, '(?m)^(?:.*\\)?([^\\]*?)(?:\.[^.]+)?$', '\1' & @CR)
						$tmp = StringTrimRight($tmp, 1)
					Case 2
						$tmp = StringRegExpReplace($tmp, '(?m)^(?:.*\\)?(.*)$', '\1')
					Case 4
						If Not StringInStr($sOutList, ':') Then $tmp = $PatInp0 & StringReplace($tmp, @CRLF, @CRLF & $PatInp0)
					Case 5
						If Not StringInStr($sOutList, ':') Then $tmp = $PatInp0 & StringReplace($tmp, @CRLF, @CRLF & $PatInp0)
						$tmpPath = FileSaveDialog('Save', @WorkingDir, "File (*.txt)", 0, '', $Gui1)
						If @error Then ContinueLoop
						If StringRight($tmpPath, 4) <> '.txt' Then $tmpPath &= '.txt'
						For $i = 1 To 5
							If BitAND(GUICtrlRead($iEncoding[$i]), $GUI_CHECKED) Then
								$iEncoding = $i
								ExitLoop
							EndIf
						Next
						Switch $iEncoding
							Case 1
								$iEncoding = 0
							Case 2
								$iEncoding = 32
							Case 3
								$iEncoding = 64
							Case 4
								$iEncoding = 128
							Case 5
								$iEncoding = 256
							Case Else
								$iEncoding = 0
						EndSwitch
						
						$hFile = FileOpen($tmpPath, 2 + $iEncoding)
						FileWrite($hFile, $tmp)
						FileClose($hFile)
				EndSwitch
				If $idx <> 5 Then ClipPut($tmp)
				ContinueCase
			Case -3
				GUISetState(@SW_ENABLE, $hGui)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
	Opt("GUIOnEventMode", 1)
EndFunc   ;==>_ListBox_GetText

; Func _ListBox_GetText_OK()

; _Exit1()
; EndFunc   ;==>_ListBox_GetText_OK

; Func _ListBox_GetALLItemsText()
; Local $sText, $iCount = GUICtrlSendMsg($Out, $LB_GETCOUNT, 0, 0)
; If $iCount > 0 Then
; For $i = 0 To $iCount
; $sText[$i] &= _GUICtrlListBox_GetText($hWnd, $i) & @CRLF
; Next
; EndIf
; Return $aText
; EndFunc

Func _StartFile()
	$Out0 = GUICtrlRead($Out)
	If Not $Out0 Then Return ; выделите файл
	$Out0 = StringLeft($Out0, StringInStr($Out0, '*') - 2)
	; $Out0=StringRegExpReplace($Out0, '(^.*)( \*\d+)$', '\1')
	If StringInStr($Out0, ':') Then $PatInp0 = ''
	ShellExecute($PatInp0 & $Out0)
EndFunc   ;==>_StartFile

Func _EditorTextFound()
	$Out0 = GUICtrlRead($Out)
	If Not $Out0 Then Return ; выделите файл
	$Out0 = StringLeft($Out0, StringInStr($Out0, '*') - 2)
	; $Out0=StringRegExpReplace($Out0, '(^.*)( \*\d+)$', '\1')
	If StringInStr($Out0, ':') Then $PatInp0 = ''
	Run($Editor & ' ' & $PatInp0 & $Out0)
	
	If $hf <> '' And Not $iniREx Then
		Sleep(100)
		$nameEditor = StringRegExpReplace($Editor, '(^.*)\\(.*)$', '\2')
		$AllWindows = WinList()
		For $i = 1 To $AllWindows[0][0]
			; если окно имеет текст заголовка, видимое и путь окна совпадает с путём редактора
			If $AllWindows[$i][0] And BitAND(WinGetState($AllWindows[$i][1]), 2) And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][1])), StringLen($nameEditor) + 1) = '\' & $nameEditor Then
				WinActivate($AllWindows[$i][1])
				If WinWaitActive($AllWindows[$i][1], '', 3) Then ; ожидаем 3 сек активность окна
					Sleep(30)
					Send('^{' & $hf & '}')
					Sleep(30)
					ClipPut($SeaInp0)
					Sleep(30)
					If WinWaitNotActive($AllWindows[$i][1], "", 1) And StringRight(_ProcessGetPath(WinGetProcess('[ACTIVE]')), StringLen($nameEditor) + 1) = '\' & $nameEditor Then ; если активен диалог поиска, а не окно редактора, то делаем вставку
						Send('+{INS}')
						Sleep(30)
						Send('{Enter}')
					EndIf
					ExitLoop
				EndIf
			EndIf
		Next
	EndIf
EndFunc   ;==>_EditorTextFound

Func _Folder1()
	$tmpPath = FileOpenDialog($LngOD, @WorkingDir, $LngOD1 & " (*.*)", 1 + 4, "", $hGui)
	If @error Then Return
	_mask($tmpPath)
EndFunc   ;==>_Folder1

Func _Folder2()
	$PatInp0 = GUICtrlRead($PatInp)
	$sTmp = FileGetAttrib($PatInp0)
	If Not (@error Or StringInStr($sTmp, 'D', 2)) Then $PatInp0 = StringRegExpReplace($PatInp0, '(^.*)\\.*$', '\1') ; если файл, то обрезаем последний элемент

	While Not FileExists($PatInp0)
		$PatInp0 = StringRegExpReplace($PatInp0, '(^.*)\\.*$', '\1')
		If Not @extended Then ExitLoop
	WEnd
	If Not FileExists($PatInp0) Then $PatInp0 = @WorkingDir
	$tmpPath = FileSelectFolder($LngOF, '', 2, $PatInp0, $hGui)
	If @error Then Return
	_ComboBox_InsertPath($tmpPath, $iniPath, $PatInp)
EndFunc   ;==>_Folder2
; конец функций обработки кнопок

Func _ComboBox_InsertPath($item, ByRef $iniList, $ctrlID)
	$iniList = StringReplace($sep & $iniList & $sep, $sep & $item & $sep, $sep)
	$iniList = StringReplace($iniList, $sep & $item & '\' & $sep, $sep)
	$iniList = $item & StringTrimRight($iniList, 1)
	$tmp = StringInStr($iniList, $sep, 0, $KolStr)
	If $tmp Then $iniList = StringLeft($iniList, $tmp - 1)
	GUICtrlSetData($ctrlID, $sep & $iniList, $item)
EndFunc   ;==>_ComboBox_InsertPath

Func _mask($tmp) ; добавление к маске расширение кинутого файла
	$tmp = _FO_PathSplit($tmp)
	$tmp = $tmp[2]
	If $tmp Then
		$tmp = '*' & $tmp
	Else
		Return
	EndIf
	$TypInp0 = GUICtrlRead($TypInp)
	If StringInStr('|' & $TypInp0 & '|', '|' & $tmp & '|') Then
		MsgBox(0, $LngErr, $LngMB6, 0, $hGui)
		Return
	EndIf
	If $TypInp0 = '' Or $TypInp0 = '*' Then
		GUICtrlSetData($TypInp, $tmp)
		GUICtrlSetData($TypInp, $tmp)
	Else
		GUICtrlSetData($TypInp, $TypInp0 & '|' & $tmp)
		GUICtrlSetData($TypInp, $TypInp0 & '|' & $tmp)
	EndIf
EndFunc   ;==>_mask

Func _EditBox() ; окно поиска многострочного текста
	$GP = _ChildCoor($hGui, 540, 330)
	GUISetState(@SW_DISABLE, $hGui)
	$Gui1 = GUICreate($LngMLineSH, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_OVERLAPPEDWINDOW, $WS_POPUP), -1, $hGui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 99)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")

	$EditBoxSea = GUICtrlCreateEdit('', 5, 5, 530, 285, $ES_AUTOVSCROLL + $WS_VSCROLL + $ES_NOHIDESEL + $ES_WANTRETURN)
	GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
	$CRLF0 = GUICtrlRead($CRLF)
	$SeaInp0 = GUICtrlRead($SeaInp)
	If $CRLF0 Then _CRLF($CRLF0, $SeaInp0, '')
	GUICtrlSetData($EditBoxSea, $SeaInp0)
	
	$OK = GUICtrlCreateButton("OK", 240, $GP[3] - 35, 60, 30)
	GUICtrlSetOnEvent(-1, "_EditBox_OK")
	GUICtrlSetResizing(-1, 256 + 512 + 64 + 128)

	GUISetState(@SW_SHOW, $Gui1)
EndFunc   ;==>_EditBox

Func _EditBox_OK()
	$EditBoxSea0 = GUICtrlRead($EditBoxSea)
	$CRLF0 = GUICtrlRead($CRLF)
	; если нет переносов, то вставляем и текст в инпут и выходим из функции
	If Not (StringInStr($EditBoxSea0, @CR) Or StringInStr($EditBoxSea0, @LF)) Then
		_GUICtrlComboBox_SetEditText($CRLF, '')
		_GUICtrlComboBox_SetEditText($SeaInp, $EditBoxSea0)
		Return _Exit1()
	EndIf

	$tmp = StringReplace($EditBoxSea0, @CRLF, '')
	If Not (StringInStr($tmp, @CR) Or StringInStr($tmp, @LF)) Then ; если в тексте только цельные @CRLF
		$CRLF0 = _CRLF_Define($EditBoxSea0) ; определяем символ подмены
		If @error Then Return _Exit1()
	Else
		$CRLF0 = _CRLF_Define($EditBoxSea0)
		If @error Then Return _Exit1()
		$CRLF0 &= _CRLF_Define($EditBoxSea0 & $CRLF0)
		If @error Then Return _Exit1()
	EndIf
	_GUICtrlComboBox_SetEditText($CRLF, $CRLF0)
	$tmp = StringLen($CRLF0)
	If $tmp = 1 Then
		_GUICtrlComboBox_SetEditText($SeaInp, StringReplace($EditBoxSea0, @CRLF, $CRLF0))
	ElseIf $tmp = 2 Then
		_GUICtrlComboBox_SetEditText($SeaInp, StringReplace(StringReplace($EditBoxSea0, @CR, StringLeft($CRLF0, 1)), @LF, StringRight($CRLF0, 1)))
	EndIf
	_Exit1()
EndFunc   ;==>_EditBox_OK

Func _EditBoxM() ; окно поиска и замены многострочного текста
	$GP = _ChildCoor($hGui, 540, 330)
	GUISetState(@SW_DISABLE, $hGui)
	$Gui1 = GUICreate($LngMLineRH, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_OVERLAPPEDWINDOW, $WS_POPUP), -1, $hGui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 99)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
	
	$CRLF0 = GUICtrlRead($CRLF)
	$SeaInp0 = GUICtrlRead($SeaInp)
	$RepInp0 = GUICtrlRead($RepInp)
	If $CRLF0 Then _CRLF($CRLF0, $SeaInp0, $RepInp0)

	$EditBoxSea = GUICtrlCreateEdit('', 5, 5, 530, 140, $ES_AUTOVSCROLL + $WS_VSCROLL + $ES_NOHIDESEL + $ES_WANTRETURN)
	GUICtrlSetData($EditBoxSea, $SeaInp0)
	; GUICtrlSetResizing(-1, 2 + 4 + 32 + 128 + 8)
	GUICtrlSetResizing(-1, 1)

	$EditBoxRep = GUICtrlCreateEdit('', 5, 150, 530, 140, $ES_AUTOVSCROLL + $WS_VSCROLL + $ES_NOHIDESEL + $ES_WANTRETURN)
	GUICtrlSetData($EditBoxRep, $RepInp0)
	; GUICtrlSetResizing(-1, 2 + 4 + 64 + 128 + 8)
	GUICtrlSetResizing(-1, 1)
	
	$OK = GUICtrlCreateButton("OK", 240, $GP[3] - 35, 60, 30)
	GUICtrlSetOnEvent(-1, "_EditBoxM_OK")
	; GUICtrlSetResizing(-1, 256 + 512 + 64 + 128)
	GUICtrlSetResizing(-1, 1)

	GUISetState(@SW_SHOW, $Gui1)
EndFunc   ;==>_EditBoxM

Func _EditBoxM_OK()
	$EditBoxSea0 = GUICtrlRead($EditBoxSea)
	$EditBoxRep0 = GUICtrlRead($EditBoxRep)
	$CRLF0 = GUICtrlRead($CRLF)
	; если нет переносов, то вставляем и текст в инпут и выходим из функции
	$total = $EditBoxSea0 & $EditBoxRep0
	If Not (StringInStr($total, @CR) Or StringInStr($total, @LF)) Then
		_GUICtrlComboBox_SetEditText($CRLF, '')
		_GUICtrlComboBox_SetEditText($SeaInp, $EditBoxSea0)
		_GUICtrlComboBox_SetEditText($RepInp, $EditBoxRep0)
		Return _Exit1()
	EndIf
	
	$tmp = StringReplace($total, @CRLF, '')
	If Not (StringInStr($tmp, @CR) Or StringInStr($tmp, @LF)) Then ; если в тексте только цельные @CRLF
		$CRLF0 = _CRLF_Define($total) ; определяем символ подмены
		If @error Then Return _Exit1()
	Else
		$CRLF0 = _CRLF_Define($total)
		If @error Then Return _Exit1()
		$CRLF0 &= _CRLF_Define($total & $CRLF0)
		If @error Then Return _Exit1()
	EndIf
	_GUICtrlComboBox_SetEditText($CRLF, $CRLF0)
	$tmp = StringLen($CRLF0)
	If $tmp = 1 Then
		_GUICtrlComboBox_SetEditText($SeaInp, StringReplace($EditBoxSea0, @CRLF, $CRLF0))
		_GUICtrlComboBox_SetEditText($RepInp, StringReplace($EditBoxRep0, @CRLF, $CRLF0))
	ElseIf $tmp = 2 Then
		_GUICtrlComboBox_SetEditText($SeaInp, StringReplace(StringReplace($EditBoxSea0, @CR, StringLeft($CRLF0, 1)), @LF, StringRight($CRLF0, 1)))
		_GUICtrlComboBox_SetEditText($RepInp, StringReplace(StringReplace($EditBoxRep0, @CR, StringLeft($CRLF0, 1)), @LF, StringRight($CRLF0, 1)))
	EndIf
	_Exit1()
EndFunc   ;==>_EditBoxM_OK

Func _CRLF_Define($text)
	Local $i, $a = ChrW(0x00A9) & ChrW(0x00AE) & ChrW(0x00AB) & ChrW(0x00BB) & ChrW(0x2030) & ChrW(0x00A7) & ChrW(0x00B5) & ChrW(0x20AC) & ChrW(0x2122)
	$a = StringSplit('~@%&*^#\/+-_{}[]`<>' & $a, '')
	For $i = 1 To $a[0]
		If Not StringInStr($text, $a[$i]) Then Return $a[$i]
	Next
	Return SetError(1, 0, '')
EndFunc   ;==>_CRLF_Define

Func _Setting()
	$GP = _ChildCoor($hGui, 340, 360)
	GUISetState(@SW_DISABLE, $hGui)
	$Gui1 = GUICreate($LngbSet, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $hGui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 99)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")

	$LbLimitSize = GUICtrlCreateLabel($LngSzFl, 10, 10, 245, 17)
	$InpLimitSize = GUICtrlCreateInput($iniLimitSize, 260, 6, 50, 22)

	$LbLimitFile = GUICtrlCreateLabel($LngMFile, 10, 32, 245, 17)
	$InpLimitFile = GUICtrlCreateInput($iniLimitFile, 260, 30, 50, 22)

	$LbPathBackup = GUICtrlCreateLabel($LngBakPh, 10, 53, 260, 17)
	$InpPathBackup = GUICtrlCreateInput($iniPathBackup, 10, 70, 320, 22)

	$Search = FileFindFirstFile(@ScriptDir & '\Lang\*.lng')
	If $Search <> -1 Then
		$LangList = 'none'
		While 1
			$file = FileFindNextFile($Search)
			If @error Then ExitLoop
			$LangList &= $sep & $file
		WEnd
		GUICtrlCreateLabel('Language', 10, 103, 65, 17)
		$ComboLang = GUICtrlCreateCombo('', 75, 100, 80, 22, $CBS_DROPDOWNLIST + $WS_VSCROLL)
		GUICtrlSetData(-1, $LangList, $LangPath)
		GUICtrlSetOnEvent(-1, "_SetLang")
	EndIf
	FileClose($Search)

	$LbHst = GUICtrlCreateLabel($LngHst, 10, 130, 250, 17)
	$InpHst = GUICtrlCreateInput($KolStr, 260, 127, 50, 22)
	
	$IgnGr = GUICtrlCreateGroup($LngIgnGr, 10, 155, 320, 56)
	$atrR = GUICtrlCreateCheckbox($LngAtrR & ' (R)', 20, 170, 130, 17)
	If StringInStr($ExcldAttrib, 'R') Then GUICtrlSetState(-1, 1)
	$atrA = GUICtrlCreateCheckbox($LngAtrA & ' (A)', 20, 190, 130, 17)
	If StringInStr($ExcldAttrib, 'A') Then GUICtrlSetState(-1, 1)
	$atrH = GUICtrlCreateCheckbox($LngAtrH & ' (H)', 150, 170, 130, 17)
	If StringInStr($ExcldAttrib, 'H') Then GUICtrlSetState(-1, 1)
	$atrS = GUICtrlCreateCheckbox($LngAtrS & ' (S)', 150, 190, 130, 17)
	If StringInStr($ExcldAttrib, 'S') Then GUICtrlSetState(-1, 1)
	
	$ChData = GUICtrlCreateCheckbox($LngData, 10, 220, 300, 17)
	If $ReData = 1 Then GUICtrlSetState(-1, 1)
	
	$LbChS = GUICtrlCreateLabel($LngChS, 10, 247, 65, 17)
	$ComboChar = GUICtrlCreateCombo('', 75, 245, 140, 22, $CBS_DROPDOWNLIST + $WS_VSCROLL)
	GUICtrlSetData($ComboChar, 'Auto' & $sep & 'ANSI' & $sep & 'Bin' & $sep & 'UTF16 Little Endian' & $sep & 'UTF16 Big Endian' & $sep & 'UTF8 (+ BOM)' & $sep & 'UTF8 (- BOM)', _CharNumToName($CharSet))

	$LbErrSize = GUICtrlCreateLabel($LngSzEr, 10, 273, 245, 34)
	$InpErrSize = GUICtrlCreateInput(Int($iniErrSize / 1024), 260, 276, 50, 22)

	$OK = GUICtrlCreateButton("OK", 140, $GP[3] - 48, 60, 30)
	GUICtrlSetOnEvent(-1, "_Setting_OK")

	GUISetState(@SW_SHOW, $Gui1)
EndFunc   ;==>_Setting

Func _Setting_OK()
	$CharSet = _CharNameToNum(GUICtrlRead($ComboChar))
	
	$tmp = StringReplace(GUICtrlRead($InpLimitSize), ',', '.')
	If StringRegExp($tmp, '^\d+(.\d+)?$') And $tmp <> '0' Then
		$iniLimitSize = Number($tmp)
	Else
		MsgBox(0, $LngErr, $LngMB13)
	EndIf
	
	$tmp = GUICtrlRead($InpErrSize)
	If Not StringIsDigit($tmp) Or $tmp = '0' Then
		MsgBox(0, $LngErr, $LngMB13)
	Else
		$iniErrSize = Number($tmp) * 1024
	EndIf
	
	$tmp = GUICtrlRead($InpLimitFile)
	If Not StringIsDigit($tmp) Or $tmp = '0' Then
		MsgBox(0, $LngErr, $LngMB14)
	Else
		$iniLimitFile = Number($tmp)
	EndIf
	
	$tmp = Int(GUICtrlRead($InpHst))
	If $tmp < 1 Or $tmp > 50 Then
		MsgBox(0, $LngErr, $LngMB15)
	Else
		$KolStr = $tmp
	EndIf
	
	$ExcldAttrib = ''
	If GUICtrlRead($atrR) = 1 Then $ExcldAttrib &= 'R'
	If GUICtrlRead($atrA) = 1 Then $ExcldAttrib &= 'A'
	If GUICtrlRead($atrH) = 1 Then $ExcldAttrib &= 'H'
	If GUICtrlRead($atrS) = 1 Then $ExcldAttrib &= 'S'
	
	If GUICtrlRead($ChData) = 1 Then
		$ReData = 1
	Else
		$ReData = 0
	EndIf
	
	$iniPathBackup = GUICtrlRead($InpPathBackup)

	If $iniPathBackup And Not (StringRegExp($iniPathBackup, '(?i)^[a-z]:[^/:*?"<>|]*$') And StringInStr('|Removable|Fixed|', '|' & DriveGetType(StringLeft($iniPathBackup, 1) & ':\') & '|') And Not StringInStr($iniPathBackup, '\\')) Then
		MsgBox(0, $LngErr, $LngMB16)
		$iniPathBackup = ''
	EndIf
	_Exit1()
EndFunc   ;==>_Setting_OK

Func _CharNumToName($i)
	If $CharSetAuto Then Return 'Auto'
	Switch $i
		Case 0
			$i = 'ANSI'
		Case 16
			$i = 'Bin'
		Case 32
			$i = 'UTF16 Little Endian'
		Case 64
			$i = 'UTF16 Big Endian'
		Case 128
			$i = 'UTF8 (+ BOM)'
		Case 256
			$i = 'UTF8 (- BOM)'
		Case Else
			$i = 'Auto'
	EndSwitch
	Return $i
EndFunc   ;==>_CharNumToName

Func _CharNameToNum($i)
	If $i = 'Auto' Then
		$CharSetAuto = 1
	Else
		$CharSetAuto = 0
	EndIf
	Switch $i
		Case 'Auto'
			$i = -1
		Case 'ANSI'
			$i = 0
		Case 'Bin'
			$i = 16
		Case 'UTF16 Little Endian'
			$i = 32
		Case 'UTF16 Big Endian'
			$i = 64
		Case 'UTF8 (+ BOM)'
			$i = 128
		Case 'UTF8 (- BOM)'
			$i = 256
		Case Else
			$i = -1
	EndSwitch
	Return $i
EndFunc   ;==>_CharNameToNum

Func _SetLang()
	Local $aLng
	$LangPath = GUICtrlRead($ComboLang)
	If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then
		$aLng = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng')
		If Not @error Then
			For $i = 1 To $aLng[0][0]
				If StringInStr($aLng[$i][1], '\n') Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\n', @LF)
				If IsDeclared('Lng' & $aLng[$i][0]) Then Assign('Lng' & $aLng[$i][0], $aLng[$i][1])
			Next
			_SetLang2()
			IniWrite($Ini, 'Set', 'Lang', $LangPath)
		EndIf
	Else
		For $i = 1 To $aLng0[0][0]
			If StringInStr($aLng0[$i][1], '\n') Then $aLng0[$i][1] = StringReplace($aLng0[$i][1], '\n', @LF)
			Assign('Lng' & $aLng0[$i][0], $aLng0[$i][1])
		Next
		_SetLang2()
		IniWrite($Ini, 'Set', 'Lang', 'none')
	EndIf
EndFunc   ;==>_SetLang

Func _SetLang2()
	WinSetTitle($Gui1, '', $LngbSet)
	GUICtrlSetTip($About, $LngAbout)
	GUICtrlSetTip($restart, $LngRest)
	
	If $iniBAK Then
		GUICtrlSetTip($BAKBut, $LngBAKH2)
	Else
		GUICtrlSetTip($BAKBut, $LngBAKH1)
	EndIf

	If $iniREx Then
		GUICtrlSetTip($RExBut, $LngRExH2)
	Else
		GUICtrlSetTip($RExBut, $LngRExH1)
	EndIf

	If $iniAa Then
		GUICtrlSetTip($AaBut, $LngAaH2)
	Else
		GUICtrlSetTip($AaBut, $LngAaH1)
	EndIf

	If $iniOutRes Then
		GUICtrlSetTip($OutRBut, $LngOutRH2)
	Else
		GUICtrlSetTip($OutRBut, $LngOutRH1)
	EndIf

	If $inisub Then
		GUICtrlSetTip($SubBut, $LngSubH2)
	Else
		GUICtrlSetTip($SubBut, $LngSubH1)
	EndIf

	If $iniExc Then
		GUICtrlSetTip($ExcBut, $LngExcH2)
	Else
		GUICtrlSetTip($ExcBut, $LngExcH1)
	EndIf

	GUICtrlSetTip($CRLF, $LngCRLFH)
	GUICtrlSetTip($CRLFLab, $LngCRLFH)
	GUICtrlSetTip($spec, $LngPSmb)
	GUICtrlSetTip($SeaBtn, $LngSea)
	GUICtrlSetTip($SeaClear, $LngCr)
	GUICtrlSetTip($RepBtn, $LngRep)
	GUICtrlSetTip($RepClear, $LngCr)
	GUICtrlSetTip($ScrRep, $LngOScr)
	GUICtrlSetTip($AddRep, $LngAScr)
	GUICtrlSetTip($TypClear, $LngCr)
	GUICtrlSetTip($TypDef, $LngDef)
	GUICtrlSetTip($EditBut, $LngEdH)
	GUICtrlSetTip($EditFBut, $LngEdFH)
	GUICtrlSetTip($StrBut, $LngStH)
	GUICtrlSetTip($RBrBut, $LngRBrH)
	GUICtrlSetTip($EprBut, $LngEpr)
	GUICtrlSetTip($LstBut, $LngLst)
	GUICtrlSetTip($MLineS, $LngMLineSH)
	GUICtrlSetTip($MLineR, $LngMLineRH)
	; GUICtrlSetTip($StopBut, $LngSpH)
	; GUICtrlSetTip($OpenLng, $LngType)
	; GUICtrlSetTip($WbMn, $LngCopy)

	GUICtrlSetData($CRLFLab, $LngCRLF)
	GUICtrlSetData($specLab, $LngPSmb)
	GUICtrlSetData($SeaLab, $LngSea)
	GUICtrlSetData($RepLab, $LngRep)
	GUICtrlSetData($TypLab, $LngMsk)
	GUICtrlSetData($PatLab, $LngPth)
	GUICtrlSetData($StatusBar, $LngSb1)
	GUICtrlSetData($EditBut, $LngEd)
	GUICtrlSetData($EditFBut, $LngEdF)
	GUICtrlSetData($StrBut, $LngSt)
	GUICtrlSetData($StopBut, $LngSp)
	GUICtrlSetData($Cont1, $LngEd)
	GUICtrlSetData($Cont3, $LngEdF)
	GUICtrlSetData($Cont2, $LngSt)
	GUICtrlSetData($Cont4, $LngEpr)
	GUICtrlSetData($LbLimitSize, $LngSzFl)
	GUICtrlSetData($LbLimitFile, $LngMFile)
	GUICtrlSetData($LbPathBackup, $LngBakPh)
	GUICtrlSetData($LbHst, $LngHst)
	GUICtrlSetData($IgnGr, $LngIgnGr)
	GUICtrlSetData($atrR, $LngAtrR)
	GUICtrlSetData($atrA, $LngAtrA)
	GUICtrlSetData($atrH, $LngAtrH)
	GUICtrlSetData($atrS, $LngAtrS)
	GUICtrlSetData($ChData, $LngData)
	GUICtrlSetData($LbChS, $LngChS)
	GUICtrlSetData($LbErrSize, $LngSzEr)
	; GUICtrlSetData($Btn_Back, $LngBck) ; не возможно выбрать просмотр и настройки
	; GUICtrlSetData($Btn_Next, $LngNxt)
EndFunc   ;==>_SetLang2

Func _ReadScenario($ScrPath)
	Local $m, $sTmp, $tmp, $i
	; Читаем файл в массив
	$tmp = StringReplace(FileRead($ScrPath), $iniSep, $sep)
	$tmp = StringRegExp($tmp, '(?m)^-->\|(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)\|<--', 3)
	If @error Then Return SetError(1)
	$sTmp = UBound($tmp)
	Dim $aScenario[$sTmp / 13][13]
	$m = 0
	For $i = 0 To $sTmp - 1 Step 13
		$aScenario[$m][0] = $tmp[$i]
		$aScenario[$m][1] = $tmp[$i + 1]
		$aScenario[$m][2] = $tmp[$i + 2]
		$aScenario[$m][3] = $tmp[$i + 3]
		$aScenario[$m][4] = $tmp[$i + 4]
		$aScenario[$m][5] = $tmp[$i + 5]
		$aScenario[$m][6] = $tmp[$i + 6]
		$aScenario[$m][7] = $tmp[$i + 7]
		$aScenario[$m][8] = $tmp[$i + 8]
		$aScenario[$m][9] = $tmp[$i + 9]
		$aScenario[$m][10] = $tmp[$i + 10]
		$aScenario[$m][11] = $tmp[$i + 11]
		$aScenario[$m][12] = $tmp[$i + 12]
		$m += 1
	Next
EndFunc   ;==>_ReadScenario

; Просмотр сценария перед использовнием
Func _ScenarioView()
	Local $GP, $i, $LVSR, $x
	_ReadScenario($ScrPath)
	If @error Then Return
	$x = @DesktopWidth - 20
	If $x > 1120 Then $x = 1100
	$GP = _ChildCoor($hGui, $x, 420)
	GUISetState(@SW_DISABLE, $hGui)
	
	$Gui1 = GUICreate($LngG1T, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_OVERLAPPEDWINDOW, $WS_POPUP), -1, $hGui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 205)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
	
	$LVSR = GUICtrlCreateListView($LngLV1 & $sep & $LngLV2 & $sep & 'Aa' & $sep & 'REx' & $sep & 'CRLF' & $sep & 'BAK' & $sep & 'Path' & $sep & 'Mask' & $sep & 'Exc' & $sep & 'Sub' & $sep & 'Data' & $sep & 'Attrib' & $sep & 'Char', 5, 5, $x - 10, 380, -1, 0x00000001)
	GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
	GUICtrlSendMsg(-1, 0x1000 + 30, 0, 203) ; установка ширина столбца
	GUICtrlSendMsg(-1, 0x1000 + 30, 1, 203)
	For $i = 0 To UBound($aScenario) - 1
		GUICtrlCreateListViewItem($aScenario[$i][0] & $sep & $aScenario[$i][1] & $sep & $aScenario[$i][2] & $sep & $aScenario[$i][3] & $sep & $aScenario[$i][4] & $sep & $aScenario[$i][5] & $sep & $aScenario[$i][6] & $sep & $aScenario[$i][7] & $sep & $aScenario[$i][8] & $sep & $aScenario[$i][9] & $sep & $aScenario[$i][10] & $sep & $aScenario[$i][11] & $sep & $aScenario[$i][12], $LVSR)
	Next
	$ScrStart = GUICtrlCreateButton($LngUS, $x / 2 - 70, 390, 140, 25)
	GUICtrlSetTip(-1, $LngUSH)
	GUICtrlSetResizing(-1, 8 + 64 + 256 + 512)
	GUICtrlSetOnEvent(-1, "_UseScenario")

	GUISetState(@SW_SHOW, $Gui1)
EndFunc   ;==>_ScenarioView

Func _UseScenario()
	; $TrScr = 1
	_Exit1()
	$aTextScr = $aScenario
	GUICtrlSetData($SeaInp, $ScrPath)
	GUICtrlSetData($SeaInp, $ScrPath)
	GUICtrlSetData($RepInp, $ScrPath)
	GUICtrlSetData($RepInp, $ScrPath)
EndFunc   ;==>_UseScenario

Func _Exit()
	_saveini(1)
	GUIDelete($hGui)
	GUIDelete($Gui1)
EndFunc   ;==>_Exit

Func _Quit()
	Exit
EndFunc   ;==>_Quit

Func _saveini($ty = 1)
	Local $iState
	$SeaInp0 = GUICtrlRead($SeaInp)
	$RepInp0 = GUICtrlRead($RepInp)
	$TypInp0 = GUICtrlRead($TypInp)

	If Not ($SeaInp0 = $RepInp0 And StringRight($RepInp0, 4) = '.srt' And FileExists($RepInp0)) Then
		$iniSea = StringReplace($sep & $iniSea & $sep, $sep & $SeaInp0 & $sep, $sep)
		$iniSea = $SeaInp0 & StringTrimRight($iniSea, 1)
		$tmp = StringInStr($iniSea, $sep, 0, $KolStr)
		If $tmp Then $iniSea = StringLeft($iniSea, $tmp - 1)
		GUICtrlSetData($SeaInp, $sep & $iniSea, $SeaInp0)
		
		$iniRep = StringReplace($sep & $iniRep & $sep, $sep & $RepInp0 & $sep, $sep)
		$iniRep = $RepInp0 & StringTrimRight($iniRep, 1)
		$tmp = StringInStr($iniRep, $sep, 0, $KolStr)
		If $tmp Then $iniRep = StringLeft($iniRep, $tmp - 1)
		GUICtrlSetData($RepInp, $sep & $iniRep, $RepInp0)
	EndIf
	
	If $TypInp0 Then
		$iniMask = StringReplace($sep & $iniMask & $sep, $sep & $TypInp0 & $sep, $sep)
		$iniMask = $TypInp0 & StringTrimRight($iniMask, 1)
		$tmp = StringInStr($iniMask, $sep, 0, $KolStr)
		If $tmp Then $iniMask = StringLeft($iniMask, $tmp - 1)
		GUICtrlSetData($TypInp, $sep & $iniMask, $TypInp0)
	EndIf
	
	If $ty = 1 Then
		IniWrite($Ini, 'Set', 'Search', StringReplace(StringReplace('"' & $iniSea & '"', $sep & $sep, $sep), $sep, $iniSep))
		IniWrite($Ini, 'Set', 'Replace', StringReplace(StringReplace('"' & $iniRep & '"', $sep & $sep, $sep), $sep, $iniSep))
		IniWrite($Ini, 'Set', 'Mask', StringReplace('"' & $iniMask & '"', $sep, $iniSep))
		IniWrite($Ini, 'Set', 'Path', StringReplace($iniPath, $sep, $iniSep))
		IniWrite($Ini, 'Set', 'Aa', $iniAa)
		IniWrite($Ini, 'Set', 'sub', $inisub)
		IniWrite($Ini, 'Set', 'REx', $iniREx)
		IniWrite($Ini, 'Set', 'BAK', $iniBAK)
		IniWrite($Ini, 'Set', 'OutRes', $iniOutRes)
		IniWrite($Ini, 'Set', 'ExceptMask', $iniExc)
		IniWrite($Ini, 'Set', 'Lang', $LangPath)
		IniWrite($Ini, 'Set', 'PathBackup', $iniPathBackup)
		IniWrite($Ini, 'Set', 'LimitSize', $iniLimitSize)
		IniWrite($Ini, 'Set', 'LimitFile', $iniLimitFile)
		IniWrite($Ini, 'Set', 'ErrSize', $iniErrSize)
		IniWrite($Ini, 'Set', 'History', $KolStr)
		IniWrite($Ini, 'Set', 'ReData', $ReData)
		Switch $CharSet
			Case 0
				$tmp = 'ANSI'
			Case 16
				$tmp = 'Bin'
			Case 32
				$tmp = 'UTF16 Little Endian'
			Case 64
				$tmp = 'UTF16 Big Endian'
			Case 128
				$tmp = 'UTF8 (+ BOM)'
			Case 256
				$tmp = 'UTF8 (- BOM)'
			Case Else
				$tmp = 'Auto'
		EndSwitch
		IniWrite($Ini, 'Set', 'CharSet', $tmp)
		IniWrite($Ini, 'Set', 'PosW', $WHXY[0])
		IniWrite($Ini, 'Set', 'PosL', $WHXY[2])
		IniWrite($Ini, 'Set', 'PosT', $WHXY[3])
		IniWrite($Ini, 'Set', 'PosH', $WHXY[1])
		IniWrite($Ini, 'Set', 'PosMax', $WHXY[4]) ; сохранение развёрнутость окна
		If $RichPos[0] Then ; если окно открывалось, то сохраняем новые координаты
			IniWrite($Ini, 'Set', 'RichW', $RichPos[0])
			IniWrite($Ini, 'Set', 'RichH', $RichPos[1])
			IniWrite($Ini, 'Set', 'RichL', $RichPos[2])
			IniWrite($Ini, 'Set', 'RichT', $RichPos[3])
			IniWrite($Ini, 'Set', 'RichMax', $RichPos[4])
		EndIf
	EndIf
EndFunc   ;==>_saveini

Func _stat($stat)
	Switch $TrEx & $stat
		Case 01
			$MinSizeH = 360
			$MaxSizeH = @DesktopHeight
			WinMove($hGui, "", Default, Default, Default, $WHXY[1])
			$ClientSz = WinGetClientSize($hGui) ; для ширины
			$TrEx = 1 ; триггер, если включился режим 1, то второй раз не повторяется
			GUICtrlSetPos($Out, 5, 250, $ClientSz[0] - 10, $ClientSz[1] - 283)
			GUICtrlSetState($Out, $GUI_SHOW)
			GUICtrlSetState($EditBut, $GUI_SHOW)
			GUICtrlSetState($EditFBut, $GUI_SHOW)
			GUICtrlSetState($StrBut, $GUI_SHOW)
			GUICtrlSetState($EprBut, $GUI_SHOW)
			GUICtrlSetState($LstBut, $GUI_SHOW)
		Case 10
			$MinSizeH = $aPosH2[3]
			$MaxSizeH = $aPosH2[3]
			WinMove($hGui, "", Default, Default, Default, 250)
			$TrEx = 0
			GUICtrlSetState($Out, $GUI_HIDE)
			GUICtrlSetState($EditBut, $GUI_HIDE)
			GUICtrlSetState($EditFBut, $GUI_HIDE)
			GUICtrlSetState($StrBut, $GUI_HIDE)
			GUICtrlSetState($EprBut, $GUI_HIDE)
			GUICtrlSetState($LstBut, $GUI_HIDE)
	EndSwitch
EndFunc   ;==>_stat

Func _Resized() ; срабатывает при изменении размера окна, но не при "Развернуть на весь экран", "Восстановить"
	$GuiPos = WinGetPos($hGui)
	$WHXY[2] = $GuiPos[0]
	$WHXY[3] = $GuiPos[1]
	$ClientSz = WinGetClientSize($hGui) ; сохраняется размер клиентской области
	$WHXY[0] = $ClientSz[0]
	If $TrEx And $ClientSz[1] > 270 Then $WHXY[1] = $GuiPos[3]
	; Сохраняем размеры и позицию окна только при закрытии программы !!!
EndFunc   ;==>_Resized

Func _Maximize() ; срабатывает при изменении размера окна, но не при "Развернуть на весь экран", "Восстановить"
	$WHXY[4] = 1
EndFunc   ;==>_Maximize

Func _Restore() ; срабатывает при изменении размера окна, но не при "Развернуть на весь экран", "Восстановить"
	$WHXY[4] = 0
EndFunc   ;==>_Restore

Func WM_MOVING($hwnd, $msg, $wParam, $lParam)
	Local $sRect = DllStructCreate("Int[4]", $lParam)
	Switch $hwnd ; проверка хендла позволяет не отключать функцию в диалоговых окнах
		Case $hGui
			; получаем координаты окна. Это нужно при закрытии свёрнутого скрипта
			$WHXY[2] = DllStructGetData($sRect, 1, 1)
			$WHXY[3] = DllStructGetData($sRect, 1, 2)
			; Case $Gui1
			; $RichPos[2] = DllStructGetData($sRect, 1, 1)
			; $RichPos[3] = DllStructGetData($sRect, 1, 2)
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_MOVING

Func WM_GETMINMAXINFO($hwnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	Switch $hwnd ; проверка хендла позволяет не отключать функцию в диалоговых окнах
		Case $hGui
			Local $tMINMAXINFO = DllStructCreate("int;int;" & _
					"int MaximSizeW; int MaximSizeH;" & _
					"int MaxPositionX;int MaxPositionY;" & _
					"int MinSizeW; int MinSizeH;" & _
					"int MaxSizeW; int MaxSizeH", _
					$lParam)
			DllStructSetData($tMINMAXINFO, "MinSizeW", 367) ; минимальные размеры окна по ширине
			DllStructSetData($tMINMAXINFO, "MinSizeH", $MinSizeH) ; минимальные размеры окна по высоте
			If Not $TrEx Then DllStructSetData($tMINMAXINFO, "MaxSizeH", $MaxSizeH) ; Если режим без вывода результатов, то запрет на увелич. окна по вертикали
		Case $Gui1
			Local $tMINMAXINFO = DllStructCreate("int;int;" & _
					"int MaximSizeW; int MaximSizeH;" & _
					"int MaxPositionX;int MaxPositionY;" & _
					"int MinSizeW; int MinSizeH;" & _
					"int MaxSizeW; int MaxSizeH", _
					$lParam)
			DllStructSetData($tMINMAXINFO, "MinSizeW", 200) ; минимальные размеры окна по ширине
			DllStructSetData($tMINMAXINFO, "MinSizeH", 200) ; минимальные размеры окна по высоте
	EndSwitch
EndFunc   ;==>WM_GETMINMAXINFO

Func _RunCMD()
	Local $aTmp, $BackUp, $Casesense, $CRLF, $Include, $Depth, $Mask, $ParamLine, $Path, $RegExp, $Replace, $Search, $spr, $ReData, $ExcldAttrib
	$spr = Chr(6) & Chr(1) & Chr(6) ; разделитель параметров

	$ParamLine = $spr & _ArrayToString($CmdLine, $spr, 1) & $spr
	; проверка ключей:
	
	; /s"Search" - строка поиска
	$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]s(.+?)' & $spr, 3)
	If Not @error And UBound($aTmp) = 1 Then
		$Search = $aTmp[0]
	Else
		Exit 1
	EndIf
	; MsgBox(0, '2', $ParamLine)
	
	; /r"Replace" - строка замены
	$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]r(.+?)' & $spr, 3)
	If Not @error And UBound($aTmp) = 1 Then
		$Replace = $aTmp[0]
	Else
		Exit 2
	EndIf
	
	If $Search == $Replace Then Exit 6
	
	; /a - независимо от регистра
	$Casesense = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]a' & $spr)
	
	; /e - регулярное выражение
	$RegExp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]e' & $spr)
	
	; /w"~|" - символы заменяющие перенос строки @CRLF.
	; Если один или два одинаковых символа, то аналогично @CRLF, а если два разных символа, то первый символ заменяет CR, второй LF
	$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]w(.{1,2}?)' & $spr, 3)
	If Not @error And UBound($aTmp) = 1 Then
		$CRLF = $aTmp[0]
	Else
		$CRLF = ''
	EndIf
	
	; /b - делать бэкап изменяемых файлов
	$BackUp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]b' & $spr)
	
	; /b"PathBackUp" - ключ или ключ с путём
	$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]b(.*?)' & $spr, 3)
	If Not @error And UBound($aTmp) > 0 Then
		$BackUp = $aTmp[0]
		If $BackUp = '' Then $BackUp = 1
	Else
		$BackUp = 0
	EndIf
	
	; /p"Path" - путь поиска
	$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]p(.+?)' & $spr, 3)
	If Not @error And UBound($aTmp) = 1 Then
		$Path = $aTmp[0]
	Else
		Exit 3
	EndIf
	
	; /m"Mask" - маска
	$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]m(.*?)' & $spr, 3)
	If Not @error And UBound($aTmp) = 1 Then
		$Mask = $aTmp[0]
		If $Mask = '' Then $Mask = '*'
	Else
		$Mask = '*'
	EndIf
	
	; /i - исключение
	If StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]i' & $spr) Then
		$Include = False
	Else
		$Include = True
	EndIf
	
	; /l"Depth" - уровень вложения
	$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]l(\d+?)' & $spr, 3)
	If Not @error And UBound($aTmp) = 1 Then
		$Depth = $aTmp[0]
	Else
		$Depth = 125
	EndIf
	
	; /d - восстанавливать прежнюю дату
	$ReData = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]d' & $spr)
	
	; /t"RAHS" - атрибуты, файла которые содержат хотя бы обин из них не участвуют в операции замены.
	$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]t(.+?)' & $spr, 3)
	If Not @error And UBound($aTmp) = 1 Then
		$ExcldAttrib = $aTmp[0]
	Else
		$ExcldAttrib = ''
	EndIf
	
	; /f"U8" - кодировка по умолчанию Auto, иначе указанная ANSI, U8, U8-B, U16L, U16B, Bin.
	$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]f(.{2,4}?)' & $spr, 3)
	If Not @error And UBound($aTmp) = 1 Then
		Select
			Case $aTmp[0] = 'ANSI'
				$CharSet = 0
			Case $aTmp[0] = 'Bin'
				$CharSet = 16
			Case $aTmp[0] = 'U16L'
				$CharSet = 32
			Case $aTmp[0] = 'U16B'
				$CharSet = 64
			Case $aTmp[0] = 'U8'
				$CharSet = 128
			Case $aTmp[0] = 'U8-B'
				$CharSet = 256
			Case Else
				$CharSet = -1 ; Auto
		EndSelect
	Else
		$CharSet = 0
	EndIf
	
	; /z"MaxFileSize" - максимальный размер файла
	$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]z(\d+?)' & $spr, 3)
	If Not @error And UBound($aTmp) = 1 Then
		$ErrSize = $aTmp[0]
	Else
		$ErrSize = 180 * 1024 * 1024
	EndIf
	
	; 5 параметров поиска: Текст поиска; Текст замены; Чуствительность к регистру; Регулярное выражение; Бэкап
	; 4 параметров файлового поиска:
	_ReplaceCMD($Search, $Replace, $Casesense, $RegExp, $CRLF, $BackUp, $Path, $Mask, $Include, $Depth, $ReData, $ExcldAttrib, $CharSet, $ErrSize)
	Exit
EndFunc   ;==>_RunCMD

Func _ReplaceCMD($Search, $Replace, $Casesense, $RegExp, $CRLF, $BackUp, $Path, $Mask, $Include, $Depth, $ReData, $ExcldAttrib, $CharSet, $ErrSize)
	Local $BackUpPath, $file, $FileList, $i, $j, $LenPath, $TextReplace, $tmpData, $TrR, $TrH, $TrS, $aExcAttrib, $CharSetAuto
	If StringRight($Path, 1) <> '\' Then $Path &= '\'
	
	If $CharSet = -1 Then
		$CharSetAuto = 1
	Else
		$CharSetAuto = 0
	EndIf
	
	; Выполняем функции, которые не ресурсоёмкие и на раннем этапе могут возвратить ошибку без ожидания поиска файлов
	; Обработка переносов строк в поисковом запросе
	If $CRLF Then _CRLF($CRLF, $Search, $Replace)
	
	; делаем резервные копии
	If $BackUp Then
		$BackUpPath = _BackUp($BackUp) & StringRegExpReplace($Path, '^(.*\\)(.*?\\)$', '\2')
		If @error Then Exit 4
	EndIf
	
	; Выполняем поиск файлов по параметрам поиска файлов с выводом полных путей массивом по принудительной маске
	$FileList = _FO_FileSearch($Path, _FO_CorrectMask($Mask), $Include, $Depth, 1, 1, 1, $sLocale)
	If @error Then Exit 5
	
	; Выполняем замены
	$LenPath = StringLen($Path)
	$ExcldAttrib = StringRegExpReplace($ExcldAttrib, '(?i)[^RASHNOT]', '') ; удаление из набора атрибутов "левых" символов
	$aExcAttrib = StringSplit($ExcldAttrib, '')
	For $i = 1 To $FileList[0]
		If FileGetSize($FileList[$i]) > $ErrSize Then ContinueLoop
		
		$FileAttrib = FileGetAttrib($FileList[$i])
		For $j = 1 To $aExcAttrib[0]
			If StringInStr($FileAttrib, $aExcAttrib[$j]) Then ContinueLoop 2
		Next
		If $CharSetAuto Then
			$CharSet = FileGetEncoding($FileList[$i])
		Else
			If $CharSet <> 16 And $CharSet <> FileGetEncoding($FileList[$i]) Then ContinueLoop
		EndIf

		$file = FileOpen($FileList[$i], $CharSet)
		If $file = -1 Then ContinueLoop
		$TextReplace = FileRead($file)
		FileClose($file)
		If $RegExp Then
			$TextReplace = StringRegExpReplace($TextReplace, $Search, $Replace)
		Else
			$TextReplace = StringReplace($TextReplace, $Search, $Replace, 0, $Casesense)
		EndIf
		If @extended Then ; если изменения произошли, то выполняем перезапись файла и бэкапирование
			If $BackUp Then FileCopy($FileList[$i], $BackUpPath & StringTrimLeft($FileList[$i], $LenPath), 8)
			If $ReData = 1 Then $tmpData = FileGetTime($FileList[$i], 0, 1)
			$TrR = StringInStr($FileAttrib, 'R')
			$TrH = StringInStr($FileAttrib, 'H')
			$TrS = StringInStr($FileAttrib, 'S')
			If $TrR Then FileSetAttrib($FileList[$i], '-R')
			If $TrH Then FileSetAttrib($FileList[$i], '-H')
			If $TrS Then FileSetAttrib($FileList[$i], '-S')
			$file = FileOpen($FileList[$i], $CharSet + 2)
			FileWrite($file, $TextReplace)
			FileClose($file)
			If $ReData = 1 Then FileSetTime($FileList[$i], $tmpData)
			If $TrR Then FileSetAttrib($FileList[$i], '+R')
			If $TrH Then FileSetAttrib($FileList[$i], '+H')
			If $TrS Then FileSetAttrib($FileList[$i], '+S')
		EndIf
	Next
EndFunc   ;==>_ReplaceCMD

Func _About()
	$wAbt = 270
	$hAbt = 180
	$GP = _ChildCoor($hGui, $wAbt, $hAbt)
	$wAbtBt = 20
	$wA = $wAbt / 2 - 80
	$wB = $hAbt / 3 * 2
	$iScroll_Pos = -$hAbt
	$TrAbt1 = 0
	$TrAbt2 = 0
	$BkCol1 = 0xE1E3E7
	$BkCol2 = 0
	$GuiPos = WinGetPos($hGui)
	GUISetState(@SW_DISABLE, $hGui)
	$font = "Arial"

	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $hGui)
	GUISetBkColor($BkCol1)
	If Not @Compiled Then GUISetIcon($AutoItExe, 1)
	GUISetFont(-1, -1, -1, $font)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
	
	$vk1 = GUICtrlCreateButton(ChrW('0x25BC'), 0, $hAbt - 20, $wAbtBt, 20)
	GUICtrlSetOnEvent(-1, "_About_vk1")

	GUICtrlCreateTab($wAbtBt, 0, $wAbt - $wAbtBt, $hAbt + 35, 0x0100 + 0x0004 + 0x0002)
	$tabAbt0 = GUICtrlCreateTabItem("0")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt - $wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128)
	GUICtrlSetBkColor(-1, $BkCol1)

	GUICtrlCreateLabel($LngTitle, 0, 0, $wAbt, $hAbt / 3, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 15, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 1, $hAbt / 3, $wAbt - 2, 1, 0x10)

	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 1.1  13.04.2013', $wA, $wB - 36, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', $wA, $wB - 17, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', $wA + 39, $wB - 17, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlSetOnEvent(-1, "_About_url")
	GUICtrlCreateLabel('WebMoney:', $wA, $wB + 2, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', $wA + 75, $wB + 2, 125, 17)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetOnEvent(-1, "_About_WbMn")
	GUICtrlCreateLabel('Copyright AZJIO © 2010-2013', $wA, $wB + 21, 210, 17)

	$tabAbt1 = GUICtrlCreateTabItem("1")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt - $wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128)
	GUICtrlSetBkColor(-1, 0x000000)

	$StopPlay = GUICtrlCreateButton(ChrW('0x25A0'), 0, $hAbt - 41, $wAbtBt, 20)
	GUICtrlSetState(-1, 32)
	GUICtrlSetOnEvent(-1, "_About_StopPlay")

	$nLAbt = GUICtrlCreateLabel($LngScrollAbt, $wAbtBt, $hAbt, $wAbt - $wAbtBt, 360, 0x1) ; центр
	GUICtrlSetFont(-1, 9, 400, 2, $font)
	GUICtrlSetColor(-1, 0x99A1C0)
	GUICtrlSetBkColor(-1, -2) ; прозрачный
	GUICtrlCreateTabItem('')
	GUISetState(@SW_SHOW, $Gui1)
EndFunc   ;==>_About

Func _Exit1()
	AdlibUnRegister('_ScrollAbtText')
	GUISetState(@SW_ENABLE, $hGui)
	GUIDelete($Gui1)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Quit")
EndFunc   ;==>_Exit1

Func _About_url()
	ShellExecute('http://azjio.ucoz.ru')
EndFunc   ;==>_About_url

Func _About_WbMn()
	ClipPut('R939163939152')
EndFunc   ;==>_About_WbMn

Func _About_StopPlay()
	If $TrAbt2 = 0 Then
		AdlibUnRegister('_ScrollAbtText')
		GUICtrlSetData($StopPlay, ChrW('0x25BA'))
		$TrAbt2 = 1
	Else
		AdlibRegister('_ScrollAbtText', 40)
		GUICtrlSetData($StopPlay, ChrW('0x25A0'))
		$TrAbt2 = 0
	EndIf
EndFunc   ;==>_About_StopPlay

Func _About_vk1()
	If $TrAbt1 = 0 Then
		GUICtrlSetState($tabAbt1, 16)
		GUICtrlSetState($nLAbt, 16)
		GUICtrlSetState($StopPlay, 16)
		GUICtrlSetData($vk1, ChrW('0x25B2'))
		GUISetBkColor($BkCol2)
		If $TrAbt2 = 0 Then AdlibRegister('_ScrollAbtText', 40)
		$TrAbt1 = 1
	Else
		GUICtrlSetState($tabAbt0, 16)
		GUICtrlSetState($nLAbt, 32)
		GUICtrlSetState($StopPlay, 32)
		GUICtrlSetData($vk1, ChrW('0x25BC'))
		GUISetBkColor($BkCol1)
		AdlibUnRegister('_ScrollAbtText')
		$TrAbt1 = 0
	EndIf
EndFunc   ;==>_About_vk1

Func _ScrollAbtText()
	$iScroll_Pos += 1
	ControlMove($Gui1, "", $nLAbt, $wAbtBt, -$iScroll_Pos)
	If $iScroll_Pos > 360 Then $iScroll_Pos = -$hAbt
EndFunc   ;==>_ScrollAbtText