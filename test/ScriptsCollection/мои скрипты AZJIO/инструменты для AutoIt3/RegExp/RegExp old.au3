#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=RegExp.exe
#AutoIt3Wrapper_Icon=RegExp.ico
#AutoIt3Wrapper_Compression=n
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=RegExp.exe
#AutoIt3Wrapper_Res_Fileversion=0.8.1.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.8.1
#AutoIt3Wrapper_Res_Field=Build|2012.06.17
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Icon_Add=1.ico
#AutoIt3Wrapper_Res_Icon_Add=2.ico
#AutoIt3Wrapper_Res_Icon_Add=3.ico
#AutoIt3Wrapper_Res_Icon_Add=4.ico
#AutoIt3Wrapper_Res_Icon_Add=5.ico
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\upx\upx.exe -7 --compress-icons=0 "%out%"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2010.10.27-2012.06.17 AutoIt3-v3.3.6.1
#include <GuiEdit.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <GuiListView.au3>
#include <GuiComboBox.au3>
#include <ListBoxConstants.au3>
#include <ButtonConstants.au3>
#include <ForRegExp.au3>

#NoTrayIcon
Opt("GUIResizeMode", 802)
$sep = ChrW(0x0144)
Opt("GUIDataSeparatorChar", $sep)

; En
$LngTitle = 'RegExp'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngMsg1 = 'Message'
$LngIni1 = 'Replacing paths on the file name'
$LngIni2 = 'File extension'
$LngIni3 = 'Sections'
$LngIni4 = 'IP'
$LngIni5 = 'metacharacters'
$LngIni6 = 'Removing blank lines'
$LngIni7 = 'Domain'
$LngIni8 = 'URL'
$LngIni9 = 'mail'
$LngRe = 'Restart RegExp'
$LngREx = 'Regular expression for search'
$LngRRep = 'The replacement pattern'
$LngRTx = 'The text to be searched (drag-and-drop)'
$LngRRS = 'Results'
$LngRHs = 'Library'
$LngAH = 'Add pattern'
$LngDH = 'Delete pattern'
$LngOH = 'Open the file library'
$LngTstH = 'Test. Try \s or [\002-\010]'
$LngUpH = 'Save pattern'
$LngRaS = 'Search'
$LngRaR = 'Replace'
$LngRaG = 'Group'
$LngCp = 'Copy the design' & @CRLF & 'to the clipboard'
$LngErr = 'Error'
$LngExc = 'Calculate'
$LngHExc = 'Enter data in the form of code, framing quotation' & @CRLF & 'marks or apostrophes, for example "$0"&@CRLF'
$LngMsg3 = 'Not exist regular expression' & @CRLF & 'or uncheck "' & $LngExc & '"'
$LngMsg4 = 'Not exist search pattern'
$LngMsg5 = 'Invalid regular expression'
$LngMsg6 = 'Not selected cell to save.' & @CRLF & @CRLF & 'Auto insertion mode is disabled,' & @CRLF & 'select a cell and repeatedly press "Upd"'
$LngInB = 'Enter the name of the element'
$LngInBn = 'Sample'
$LngFOp = 'Open'
$LngFO2 = 'File with regular expressions'
$LngDt1 = 'Number of coincidence'
$LngDt2 = 'Nothing was found on request'
$LngDtG = 'Group'
; $LngMsg7 = 'Not found RegExpHelp.hta'
$LngWG = 'Show group labels'
$LngNPt = 'No Update'
$LngHNPt = 'Do not insert the test pattern'
$LngMsg8 = 'The search expression contains quotation marks and apostrophes, or @, so the framing manually'
$LngMsg9 = 'The substitution expression contains quotation marks and apostrophes, or @, so the framing manually'
$LngScrollAbt = 'The tool is designed to test the regular expressions (PCRE).' & @CRLF & @CRLF & _
		'In the library you can add up to 99 samples.' & @CRLF & @CRLF & _
		'For parsing the file enough to throw the file in ' & _
		'the window. It supports hot keys.' & @CRLF & @CRLF & _
		'The utility is written in AutoIt3' & @CRLF & _
		'autoitscript.com'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'RegExp'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngCopy = 'Копировать'
	$LngMsg1 = 'Сообщение'
	$LngIni1 = 'Замена путей на имя файла'
	$LngIni2 = 'Расширение файла'
	$LngIni3 = 'Содержимое секций'
	$LngIni4 = 'айпишники'
	$LngIni5 = 'Экранирование спец-символов'
	$LngIni6 = 'Удаление пустых строк'
	$LngIni7 = 'Домен'
	$LngIni8 = 'найти URL'
	$LngIni9 = 'Почта'
	$LngRe = 'Перезапуск утилиты'
	$LngREx = 'Регулярное выражение, шаблон поиска'
	$LngRRep = 'Шаблон замены'
	$LngRTx = 'Текст, в котором выполняется поиск (drag-and-drop)'
	$LngRRS = 'Результаты поиска'
	$LngRHs = 'Библиотека'
	$LngAH = 'Добавить шаблон'
	$LngDH = 'Удалить шаблон'
	$LngOH = 'Открыть файл библиотеки'
	$LngTstH = 'Тест. Попробуйте метасимвол \s' & @CRLF & 'или диапазон [\002-\010]'
	$LngUpH = 'Сохранить шаблон'
	$LngRaS = 'Поиск'
	$LngRaR = 'Замена'
	$LngRaG = 'Группы'
	$LngCp = 'Копировать конструкцию' & @CRLF & 'в буфер обмена'
	$LngErr = 'Ошибка'
	$LngExc = 'Вычислить'
	$LngHExc = 'Вводите данные в виде кода, обрамляя кавычками' & @CRLF & 'или апострофами, например "$0"&@CRLF'
	$LngMsg3 = 'Отсутствует регулярное выражение' & @CRLF & 'или уберите галочку "' & $LngExc & '"'
	$LngMsg4 = 'Отсутствует шаблон для поиска'
	$LngMsg5 = 'Неверное регулярное выражение'
	$LngMsg6 = 'Не выделена ячейка для обновления.' & @CRLF & @CRLF & 'Режим автовставки отключен, требуется' & @CRLF & 'выбрать ячейку и повторно выполнить сохранение'
	$LngInB = 'Введите имя элемента'
	$LngInBn = 'Образец'
	$LngFOp = 'Открыть'
	$LngFO2 = 'Файл с регекспами'
	$LngDt1 = 'Количество совпадений'
	$LngDt2 = 'Ничего не найдено по запросу'
	$LngDtG = 'Группа'
	; $LngMsg7 = 'Не найден RegExpHelp.hta'
	$LngWG = 'Показывать номера групп'
	$LngNPt = 'Не обновлять'
	$LngHNPt = 'Не вставлять тестовый' & @CRLF & 'шаблон из библиотеки'
	$LngMsg8 = 'Выражение поиска содержит кавычки и апострофы одновременно или @, поэтому обрамляйте вручную дублируя в регулярном выражении символы обрамления'
	$LngMsg9 = 'Выражение замены содержит кавычки и апострофы одновременно или @, поэтому обрамляйте вручную дублируя в регулярном выражении символы обрамления'
	$LngScrollAbt = 'Утилита предназначена' & @CRLF & _
			'для теста регулярных выражений на движке PCRE.' & @CRLF & @CRLF & _
			'В файл-библиотеку можно добавлять до ' & _
			'99 образцов. Для парсинга файла ' & _
			'достаточно перетянуть его в окно ' & _
			'программы. Поддерживаются горячие клавиши для кнопок. ' & @CRLF & @CRLF & _
			'Утилита написана на AutoIt3' & @CRLF & _
			'autoitscript.com'
EndIf

Global $aIniPtn, $auUpd = 0, $Ini = @ScriptDir & '\RegExpSet.ini', $SetIni = @ScriptDir & '\RegExp.ini', $SampleCopy = "$test=<FUNC>($test, '<SEARCH>', '<REPLACE>')", $Gsub = ChrW(0x25BA), $Gsmbl, $nTimer0, $GUI1, $ListView, $iniRExList, $KolStr = 30, $iniSep = '}—•—{', $RegExp0tmp = '', $WHXY[5]
For $i = 1 To 20
	$Gsmbl &= ChrW(0x25AC)
Next

If Not FileExists($SetIni) Then
	$iniopen = FileOpen($SetIni, 2)
	FileWrite($iniopen, _
			'[Set]' & @CRLF & _
			'FontSize=-1' & @CRLF & _
			'RedColor=' & @CRLF & _
			'TextColor=' & @CRLF & _
			'BkColor=' & @CRLF & _
			'GuiBkColor=' & @CRLF & _
			'SampleCopy=' & $SampleCopy & @CRLF & _
			'GroupL=1' & @CRLF & _
			'ComboREx=' & @CRLF & _
			'WinMax=' & @CRLF & _
			'W=' & @CRLF & _
			'H=' & @CRLF & _
			'X=' & @CRLF & _
			'Y=')
	FileClose($iniopen)
EndIf

$iniSampleCopy = IniRead($SetIni, 'Set', 'SampleCopy', $SampleCopy)
$iniGroupL = Number(IniRead($SetIni, 'Set', 'GroupL', 1))
$iniRExList = IniRead($SetIni, 'Set', 'ComboREx', '')
$iniRExList = StringReplace($iniRExList, $iniSep, $sep)

If Not FileExists($ini) Then
	$iniopen = FileOpen($Ini, 2)
	FileWrite($iniopen, _
			'[z--z]' & @CRLF & _
			$LngIni1 & @CRLF & _
			'(^.*)\\(.*)\.(.*)$' & @CRLF & _
			'\2' & @CRLF & _
			'2' & @CRLF & _
			'D:\Docum\File.au3' & @CRLF & _
			'[z--z]' & @CRLF & _
			$LngIni2 & @CRLF & _
			'^(?:.*\\[^\\]*?)(\.[^.]+)?$' & @CRLF & _
			'\1' & @CRLF & _
			'2' & @CRLF & _
			'D:\Docum\File.au3' & @CRLF & _
			'[z--z]' & @CRLF & _
			$LngIni3 & @CRLF & _
			'(?s)\[SetValue\]([^\[]*)' & @CRLF & _
			'' & @CRLF & _
			'33' & @CRLF & _
			'[SetValue]' & @CRLF & _
			'1=Yes' & @CRLF & _
			'2=No' & @CRLF & _
			'[Set1]' & @CRLF & _
			'[z--z]' & @CRLF & _
			$LngIni4 & @CRLF & _
			'\d{2,3}\.\d{2,3}\.\d{1,3}\.\d{1,3}' & @CRLF & _
			'' & @CRLF & _
			'33' & @CRLF & _
			'09:34:34 Connected to 192.168.30.195' & @CRLF & _
			'10:43:15 Connected to 192.168.30.98' & @CRLF & _
			'11:13:19 Connected to 10.80.30.152' & @CRLF & _
			'[z--z]' & @CRLF & _
			$LngIni5 & @CRLF & _
			'[][{}()*+?.\\^$|=<>#]' & @CRLF & _
			'\\$0' & @CRLF & _
			'2' & @CRLF & _
			'D:\Docum\File.au3' & @CRLF & _
			'HKCR\CLSID\{0DF44EAA-FF21-4412-828E-260A8728E7F1}' & @CRLF & _
			'<KeyWord name="#cs"></KeyWord>' & @CRLF & _
			'[z--z]' & @CRLF & _
			$LngIni6 & @CRLF & _
			'(\r\n|\r|\n){2,}' & @CRLF & _
			'\1' & @CRLF & _
			'2' & @CRLF & _
			'1' & @CRLF & _
			'' & @CRLF & _
			'' & @CRLF & _
			'' & @CRLF & _
			'2' & @CRLF & _
			'[z--z]' & @CRLF & _
			$LngIni7 & @CRLF & _
			'(?:https?\:\/\/)*(?:www\.)*(.*?[^\/]*)(?:.*)' & @CRLF & _
			'\1' & @CRLF & _
			'2' & @CRLF & _
			'http://www.autoitscript.com/forum/index.php?showtopic=118648' & @CRLF & _
			'[z--z]' & @CRLF & _
			$LngIni8 & @CRLF & _
			'(?si)(?:.*?)?(https?:\/\/[\w.:]+\/?(?:[\w\/?&=.~;\-+!*_#%])*)' & @CRLF & _
			'' & @CRLF & _
			'33' & @CRLF & _
			'<a href="http://www.autoitscript.com/forum/index.php?showtopic=118648">' & @CRLF & _
			'<a href="http://azjio.ucoz.ru/load"> http://forum.oszone.net/forum-103.html' & @CRLF & _
			'link http://forum.ru-board.com/topic.cgi?forum=5&topic=33902&glp#lt' & @CRLF & _
			'[z--z]' & @CRLF & _
			$LngIni9 & @CRLF & _
			'[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}' & @CRLF & _
			'' & @CRLF & _
			'33' & @CRLF & _
			'technic aaa@mail.ru e' & @CRLF & _
			'work aa1@mail.com yes' & @CRLF & _
			'[z--z]')
	FileClose($iniopen)
EndIf

$FontSize = Number(IniRead($SetIni, 'Set', 'FontSize', '-1'))
If $FontSize<7 Or $FontSize>18 Then $FontSize = -1

$RedColor = Dec(IniRead($SetIni, 'Set', 'RedColor', ''))
If $RedColor = '' Then $RedColor = 0xff0000
$TextColor = Dec(IniRead($SetIni, 'Set', 'TextColor', ''))
$BkColor = Dec(IniRead($SetIni, 'Set', 'BkColor', ''))
$GuiBkColor = Dec(IniRead($SetIni, 'Set', 'GuiBkColor', ''))

$WHXY[0] = Number(IniRead($SetIni, 'Set', 'W', '680'))
$WHXY[1] = Number(IniRead($SetIni, 'Set', 'H', '460'))
$WHXY[2] = IniRead($SetIni, 'Set', 'X', '')
$WHXY[3] = IniRead($SetIni, 'Set', 'Y', '')
$WHXY[4] = Number(IniRead($SetIni, 'Set', 'WinMax', ''))

If $WHXY[0] < 580 Then $WHXY[0] = 580 ; ограничение ширины
If $WHXY[1] < 330 Then $WHXY[1] = 330 ; ограничение высоты
_SetCoor($WHXY)

$Gui = GUICreate("RegExp", $WHXY[0], $WHXY[1], $WHXY[2], $WHXY[3], BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPCHILDREN), $WS_EX_ACCEPTFILES + $WS_EX_COMPOSITED)
If $GuiBkColor <> '' Then GUISetBkColor($GuiBkColor)
If @Compiled Then
	$AutoItExe = @AutoItExe
Else
	$AutoItExe = @ScriptDir & '\RegExp.dll'
	GUISetIcon($AutoItExe, 1)
EndIf
GUISetFont($FontSize) 

$restart = GUICtrlCreateButton("R", $WHXY[0] - 22, 2, 18, 20)
GUICtrlSetTip(-1, $LngRe)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

$About = GUICtrlCreateButton("@", $WHXY[0] - 41, 2, 18, 20)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetTip(-1, 'About')

$Helphtm = GUICtrlCreateButton("?", $WHXY[0] - 60, 2, 18, 20)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetTip(-1, 'RegExpHelp.hta')

$LReg = GUICtrlCreateLabel($LngREx, 10, 10, 266, 14)
$RegExp = GUICtrlCreateCombo('', 10, 24, $WHXY[0] - 200, 22)
GUICtrlSetResizing(-1, 7 + 32 + 512)
If $FontSize<10 Then $FontSize=10
GUICtrlSetFont(-1, $FontSize, -1, -1, 'Verdana')
If $iniRExList Then GUICtrlSetData($RegExp, $iniRExList, '')

$Exc = GUICtrlCreateCheckbox($LngExc, 290, 49, 93, 13)
GUICtrlSetTip(-1, $LngHExc)

$LRep = GUICtrlCreateLabel($LngRRep, 10, 50, 266, 14)
$PtnRep = GUICtrlCreateInput('', 10, 64, $WHXY[0] - 200, 22, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NOHIDESEL))
GUICtrlSetResizing(-1, 7 + 32 + 512)
GUICtrlSetFont(-1, $FontSize, -1, -1, 'Verdana')

$LPtn = GUICtrlCreateLabel($LngRTx, 10, 90, 266, 14)
$Pattern = GUICtrlCreateEdit('', 10, 104, $WHXY[0] - 200, 165, BitOR($ES_AUTOVSCROLL, $WS_VSCROLL, $ES_NOHIDESEL, $ES_WANTRETURN))
GUICtrlSetResizing(-1, 7 + 32 + 512)
GUICtrlSendMsg(-1, $EM_LIMITTEXT, -1, 0)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

$NPt = GUICtrlCreateCheckbox($LngNPt, 290, 90, 93, 13)
GUICtrlSetTip(-1, $LngHNPt)

$LRes = GUICtrlCreateLabel($LngRRS & '   -   Ctrl+Enter', 10, 270, 266, 14)
$Result = GUICtrlCreateEdit('', 10, 285, $WHXY[0] - 200, 165, BitOR($ES_AUTOVSCROLL, $WS_VSCROLL, $ES_NOHIDESEL, $ES_WANTRETURN))
GUICtrlSetResizing(-1, 7 + 32 + 512)
; GUICtrlSetFont(-1, -1, -1, -1, 'Arial')
GUICtrlSendMsg(-1, $EM_LIMITTEXT, -1, 0)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

_SetSizePos($WHXY[0], $WHXY[1])

$LHstr = GUICtrlCreateLabel($LngRHs, $WHXY[0] - 180, 10, 120, 14)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

$History = GUICtrlCreateList('', $WHXY[0] - 180, 24, 170, $WHXY[1] - 244, $LBS_NOINTEGRALHEIGHT + $GUI_SS_DEFAULT_LIST) ; $LBS_NOINTEGRALHEIGHT+$GUI_SS_DEFAULT_LIST
GUICtrlSetResizing(-1, 256 + 64 + 32 + 4)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

$Opn = GUICtrlCreateButton('Opn', $WHXY[0] - 180, $WHXY[1] - 219, 25, 25, $BS_ICON)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngOH & @CRLF & 'Ctrl+NumPad 0' & @CRLF & 'Ctrl+Right')
GUICtrlSetImage(-1, $AutoItExe, 201, 0)
$Upd = GUICtrlCreateButton('Upd', $WHXY[0] - 154, $WHXY[1] - 219, 25, 25, $BS_ICON)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngUpH)
GUICtrlSetImage(-1, $AutoItExe, 202, 0)
$Add = GUICtrlCreateButton('Add', $WHXY[0] - 128, $WHXY[1] - 219, 25, 25, $BS_ICON)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngAH & @CRLF & 'Ctrl+Left')
GUICtrlSetImage(-1, $AutoItExe, 203, 0)
$Del = GUICtrlCreateButton('Del', $WHXY[0] - 102, $WHXY[1] - 219, 25, 25, $BS_ICON)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngDH & @CRLF & 'Ctrl+Del' & @CRLF & 'Ctrl+Down')
; GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', -132, 0)
GUICtrlSetImage(-1, $AutoItExe, 204, 0)

$Tst = GUICtrlCreateButton('Tst', $WHXY[0] - 61, $WHXY[1] - 219, 25, 25, $BS_ICON)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngTstH)
GUICtrlSetImage(-1, $AutoItExe, 205, 0)

$charmap = GUICtrlCreateButton('Chp', $WHXY[0] - 35, $WHXY[1] - 219, 25, 25, $BS_ICON)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, 'charmap.exe')
GUICtrlSetImage(-1, 'charmap.exe', 0, 0)

$R1 = GUICtrlCreateRadio($LngRaS, $WHXY[0] - 160, $WHXY[1] - 180, 75, 17)
GUICtrlSetState(-1, 1)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$R2 = GUICtrlCreateRadio($LngRaR, $WHXY[0] - 160, $WHXY[1] - 160, 75, 17)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$R3 = GUICtrlCreateRadio($LngRaG, $WHXY[0] - 160, $WHXY[1] - 140, 75, 17)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$ChT = GUICtrlCreateCheckbox('', $WHXY[0] - 175, $WHXY[1] - 138, 13, 13)
If $iniGroupL = 1 Then GUICtrlSetState(-1, 1)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngWG)

$R3T = GUICtrlCreateCombo('', $WHXY[0] - 80, $WHXY[1] - 142, 40, 22, 0x0003)
GUICtrlSetData(-1, '0' & $sep & '1' & $sep & '2' & $sep & '3' & $sep & '4', '3')
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$Copy = GUICtrlCreateButton('Copy', $WHXY[0] - 50, $WHXY[1] - 94, 35, 22)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngCp & @CRLF & 'Ctrl+UP')

$Start = GUICtrlCreateButton('Start', $WHXY[0] - 140, $WHXY[1] - 100, 75, 35)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, 'Ctrl+Enter')

$iTimerMR = GUICtrlCreateLabel('', $WHXY[0] - 180, $WHXY[1] - 50, 175, 20, BitOR($SS_SUNKEN, $SS_LEFTNOWORDWRAP))
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$iTimer = GUICtrlCreateLabel('  time, ms', $WHXY[0] - 180, $WHXY[1] - 30, 175, 20, BitOR($SS_SUNKEN, $SS_LEFTNOWORDWRAP))
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$TextColor0 = 0x0
If $BkColor <> '' Then
	GUICtrlSetBkColor($Result, $BkColor)
	GUICtrlSetBkColor($Pattern, $BkColor)
	GUICtrlSetBkColor($History, $BkColor)
	GUICtrlSetBkColor($PtnRep, $BkColor)
	GUICtrlSetBkColor($RegExp, $BkColor)
EndIf
If $TextColor <> '' Then
	GUICtrlSetColor($Result, $TextColor)
	GUICtrlSetColor($Pattern, $TextColor)
	GUICtrlSetColor($History, $TextColor)
	GUICtrlSetColor($PtnRep, $TextColor)
	GUICtrlSetColor($RegExp, $TextColor)
	$TextColor0 = $TextColor
EndIf

$Ctrl_A = GUICtrlCreateDummy()

; $CatchDrop1 = GUICtrlCreateLabel("", 0, 0, 500, 460)
; GUICtrlSetState(-1, $GUI_DROPACCEPTED + $GUI_DISABLE)
; GUICtrlSetResizing(-1, 102 + 256)
; $CatchDrop2 = GUICtrlCreateLabel("", $WHXY[0] - 180, 0, 180, 460)
; GUICtrlSetState(-1, $GUI_DROPACCEPTED + $GUI_DISABLE)
; GUICtrlSetResizing(-1, 256 + 64 + 32 + 4)

_aIniPtn()

$tr1 = 0
$z = ''
$kol = ''
$ChT0 = ''

Dim $AccelKeys[9][2] = [["{F1}", $Helphtm],["^a", $Ctrl_A],["^{ENTER}", $Start],["^{UP}", $Copy],["^{DEL}", $Del],["^{NUMPAD0}", $Opn],["^{RIGHT}", $Opn],["^{LEFT}", $Add],["^{DOWN}", $Del]]

; если раскладка не совпадает с англ. яз. то временно переключаем в неё, чтобы зарегистрировать горячие клавиши
$tmp = 0
$KeyLayout = RegRead("HKCU\Keyboard Layout\Preload", 1)
If Not @error And $KeyLayout <> 00000409 Then
	_WinAPI_LoadKeyboardLayout(0x0409)
	$tmp = 1
EndIf

GUISetAccelerators($AccelKeys)
If $tmp = 1 Then _WinAPI_LoadKeyboardLayout(Dec($KeyLayout)) ; восстанавливаем раскладку по умолчанию
OnAutoItExitRegister('_Exit')
GUISetState()
If $WHXY[4] Then
	GUISetState(@SW_MAXIMIZE, $Gui)
	WM_EXITSIZEMOVE()
EndIf

GUIRegisterMsg(0x0232, "WM_EXITSIZEMOVE")
GUIRegisterMsg($WM_SIZE, "WM_SIZE")
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")

; Func _GUI_DropId($i_id)
	; Local $tmp = _GUICtrlEdit_GetSel($i_id)
	; $tmp = StringMid(GUICtrlRead($i_id), $tmp[0] + 1)
	; _GUICtrlEdit_Undo($i_id)
	; $tmp = StringRegExpReplace($tmp, '(?s)^(.+?)(?:\R.*)', '\1')
	; If FileExists($tmp) And Not StringInStr(FileGetAttrib($tmp), "D") Then GUICtrlSetData($i_id, FileRead($tmp))
; EndFunc

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case 0
			ContinueLoop
		Case $GUI_EVENT_MAXIMIZE
			$WHXY[4] = 1
		Case $GUI_EVENT_RESTORE
			$WHXY[4] = 0
			; Case $GUI_EVENT_RESIZED
			; _Resized()
		Case $GUI_EVENT_DROPPED
			Switch @GUI_DropId
				Case $Result, $Pattern
					; _GUICtrlEdit_BeginUpdate(GUICtrlGetHandle($Pattern))
					; _GUICtrlEdit_BeginUpdate(GUICtrlGetHandle($Result))
					$tmp = _GUICtrlEdit_GetSel(@GUI_DropId)
					$tmp = StringMid(GUICtrlRead(@GUI_DropId), $tmp[0] + 1)
					_GUICtrlEdit_ReplaceSel(@GUI_DropId, '')
					$tmp = StringRegExpReplace($tmp, '(?s)^(.+?)(?:\R.*)', '\1')
					If FileExists($tmp) And Not StringInStr(FileGetAttrib($tmp), "D") Then GUICtrlSetData($Pattern, FileRead($tmp))
					; _GUICtrlEdit_EndUpdate(GUICtrlGetHandle($Pattern))
					; _GUICtrlEdit_EndUpdate(GUICtrlGetHandle($Result))
				Case $History
					$Ini = @GUI_DragFile
					_aIniPtn()
			EndSwitch

		Case $Tst
			_TestRange()

		Case $charmap
			Run('charmap.exe')

		Case $Ctrl_A
			Switch ControlGetFocus($Gui)
				Case 'Edit3'
					$tmp = $Pattern
				Case 'Edit4'
					$tmp = $Result
				Case 'Edit1'
					$tmp = $RegExp
				Case 'Edit2'
					$tmp = $PtnRep
			EndSwitch
			GUICtrlSendMsg($tmp, $EM_SETSEL, 0, -1)

		Case $Add
			$RegExp0 = GUICtrlRead($RegExp)
			$R3T0 = GUICtrlRead($R3T)
			; защита
			If $RegExp0 = '' Then
				MsgBox(0, $LngErr, $LngMsg3)
				ContinueLoop
			EndIf
			$PtnRep0 = GUICtrlRead($PtnRep)
			$Pattern0 = GUICtrlRead($Pattern)
			$TrR = ''
			If GUICtrlRead($R1) = 1 Then $TrR = 1
			If GUICtrlRead($R2) = 1 Then $TrR = 2
			If GUICtrlRead($R3) = 1 Then $TrR = 3

			$GP = WinGetPos($Gui)
			$varnew = InputBox($LngMsg1, $LngInB & @CRLF, $LngInBn, "", 170, 150, $GP[0] + $GP[2] - 375, $GP[1] + $GP[3] - 305)
			If $varnew = '' Then
				ContinueLoop
			Else
				If Not FileExists($Ini) Then
					$file = FileOpen($Ini, 1)
					FileWrite($file, '[z--z]')
					FileClose($file)
				EndIf
				$file = FileOpen($Ini, 1)
				FileWrite($file, @CRLF & $varnew & @CRLF & $RegExp0 & @CRLF & $PtnRep0 & @CRLF & $TrR & @CRLF & $Pattern0 & @CRLF & '[z--z]')
				FileClose($file)
				ReDim $aIniPtn[UBound($aIniPtn) + 1]
				$aIniPtn[UBound($aIniPtn) - 1] = $varnew & @CRLF & $RegExp0 & @CRLF & $PtnRep0 & @CRLF & $TrR & $R3T0 & @CRLF & $Pattern0
				$z = UBound($aIniPtn)
				If $z < 10 Then $z = '0' & $z
				GUICtrlSetData($History, $z & '. ' & $varnew)
				GUICtrlSetData($History, $z & '. ' & $varnew)
			EndIf

		Case $Del
			If GUICtrlRead($History) = 0 Then ContinueLoop
			$aTmpH = '[z--z]'
			$aIniPtn[Number(StringLeft(GUICtrlRead($History), 2)) - 1] = ''
			For $i = 0 To UBound($aIniPtn) - 1
				If $aIniPtn[$i] Then $aTmpH &= @CRLF & $aIniPtn[$i] & @CRLF & '[z--z]'
			Next
			$file = FileOpen($Ini, 2)
			FileWrite($file, $aTmpH)
			FileClose($file)
			_aIniPtn()

		Case $Upd
			$RegExp0 = GUICtrlRead($RegExp)
			If $RegExp0 = '' Then
				MsgBox(0, $LngMsg1, $LngMsg3)
				ContinueLoop
			EndIf
			$History0 = GUICtrlRead($History)
			If $History0 = 0 Then
				GUICtrlSetBkColor($History, 0xffe7e7)
				MsgBox(0, $LngMsg1, $LngMsg6)
				$auUpd = 1
				ContinueLoop
			EndIf

			$PtnRep0 = GUICtrlRead($PtnRep)
			$Pattern0 = GUICtrlRead($Pattern)
			$R3T0 = GUICtrlRead($R3T)
			$TrR = ''
			If GUICtrlRead($R1) = 1 Then $TrR = 1
			If GUICtrlRead($R2) = 1 Then $TrR = 2
			If GUICtrlRead($R3) = 1 Then $TrR = 3

			$varnew = StringTrimLeft($History0, 4)
			$aTmpH = '[z--z]'
			$aIniPtn[Number(StringLeft($History0, 2)) - 1] = ''
			For $i = 0 To UBound($aIniPtn) - 1
				If $aIniPtn[$i] <> '' Then
					$aTmpH &= @CRLF & $aIniPtn[$i] & @CRLF & '[z--z]'
				Else
					$aTmpH &= @CRLF & $varnew & @CRLF & $RegExp0 & @CRLF & $PtnRep0 & @CRLF & $TrR & $R3T0 & @CRLF & $Pattern0 & @CRLF & '[z--z]'
				EndIf
			Next
			$file = FileOpen($Ini, 2)
			FileWrite($file, $aTmpH)
			FileClose($file)
			_aIniPtn()
			GUICtrlSetData($History, $History0)

		Case $Opn
			$tmp = FileOpenDialog($LngFOp, @ScriptDir, $LngFO2 & " (*.ini)", "", "", $Gui)
			If @error Then ContinueLoop
			$Ini = $tmp
			_aIniPtn()

		Case $History
			If $auUpd = 1 Then
				$auUpd = 0
				GUICtrlSetBkColor($History, 0xffffff)
				ContinueLoop
			EndIf
			If GUICtrlRead($History) = 0 Then ContinueLoop
			$tmp = $aIniPtn[Number(StringLeft(GUICtrlRead($History), 2)) - 1]
			$aTmpH = StringSplit($tmp, @CRLF, 1)
			If @error Or $aTmpH[0] < 4 Then
				MsgBox(0, $LngMsg1, "no data")
				ContinueLoop
			EndIf

			$tmp = ''
			For $i = 5 To UBound($aTmpH) - 1
				$tmp &= $aTmpH[$i] & @CRLF
			Next
			$tmp = StringTrimRight($tmp, 2)

			Switch StringLeft($aTmpH[4], 1)
				Case 1
					GUICtrlSetState($R1, 1)
				Case 2
					GUICtrlSetState($R2, 1)
				Case 3
					GUICtrlSetState($R3, 1)
					GUICtrlSetData($R3T, StringRight($aTmpH[4], 1))
			EndSwitch
			_GUICtrlComboBox_SetEditText($RegExp, $aTmpH[2])
			GUICtrlSetData($PtnRep, $aTmpH[3])
			If GUICtrlRead($NPt) = 4 Then GUICtrlSetData($Pattern, $tmp)
			; If $Tmp<>'' Then GUICtrlSetData($Pattern, $Tmp)
			$tmp = ''
			$aTmpH = ''

		Case $Exc
			$RegExp0 = GUICtrlRead($RegExp)
			$PtnRep0 = GUICtrlRead($PtnRep)
			If GUICtrlRead($Exc) = 1 Then
				If $RegExp0 Then
					; если в выражении апостроф и кавычка или @ то обрамление вручную (возможно смешанный вариант)
					If StringInStr($RegExp0, '"') And StringInStr($RegExp0, "'") Or StringInStr($RegExp0, '@') Then
						MsgBox(0, $LngMsg1, $LngMsg8)
					Else
						$Tmp1 = StringLeft($RegExp0, 1)
						$Tmp2 = StringRight($RegExp0, 1)
						; если нет ни апострофа ни кавычки
						If Not (StringInStr($RegExp0, "'") Or StringInStr($RegExp0, '"')) Then
							_GUICtrlComboBox_SetEditText($RegExp, "'" & $RegExp0 & "'") ; то обрамляем апострофом
							; если нет обрамляющих символов, но сэмпл содержит кавычки, то
						ElseIf StringInStr($RegExp0, '"') And Not (StringInStr('|""|''''|', '|' & $Tmp1 & $Tmp2 & '|')) Then
							_GUICtrlComboBox_SetEditText($RegExp, "'" & $RegExp0 & "'") ; то обрамляем апострофом
							; если нет обрамляющих символов, но сэмпл содержит апострофы, то
						ElseIf StringInStr($RegExp0, "'") And Not (StringInStr('|""|''''|', '|' & $Tmp1 & $Tmp2 & '|')) Then
							_GUICtrlComboBox_SetEditText($RegExp, '"' & $RegExp0 & '"') ; то обрамляем кавычками
						EndIf
					EndIf
				EndIf


				If $PtnRep0 Then
					If StringInStr($PtnRep0, '"') And StringInStr($PtnRep0, "'") Or StringInStr($PtnRep0, '@') Then
						MsgBox(0, $LngMsg1, $LngMsg9)
					Else
						$Tmp1 = StringLeft($PtnRep0, 1)
						$Tmp2 = StringRight($PtnRep0, 1)
						If Not (StringInStr($PtnRep0, "'") Or StringInStr($PtnRep0, '"')) Then
							GUICtrlSetData($PtnRep, "'" & $PtnRep0 & "'")
						ElseIf StringInStr($PtnRep0, '"') And Not (StringInStr('|""|''''|', '|' & $Tmp1 & $Tmp2 & '|')) Then
							GUICtrlSetData($PtnRep, "'" & $PtnRep0 & "'")
						ElseIf StringInStr($PtnRep0, "'") And Not (StringInStr('|""|''''|', '|' & $Tmp1 & $Tmp2 & '|')) Then
							GUICtrlSetData($PtnRep, '"' & $PtnRep0 & '"')
						EndIf
					EndIf
				EndIf
			Else
				If $RegExp0 Then
					$tmp = StringRight($RegExp0, 1)
					If StringLeft($RegExp0, 1) = $tmp And StringInStr('"''', $tmp) Then _GUICtrlComboBox_SetEditText($RegExp, StringRegExpReplace($RegExp0, '^.(.*).$', '\1'))
				EndIf
				If $PtnRep0 Then
					$tmp = StringRight($PtnRep0, 1)
					If StringLeft($PtnRep0, 1) = $tmp And StringInStr('"''', $tmp) Then GUICtrlSetData($PtnRep, StringRegExpReplace($PtnRep0, '^.(.*).$', '\1'))
				EndIf
			EndIf

		Case $Copy
			$RegExp0 = GUICtrlRead($RegExp)
			$PtnRep0 = GUICtrlRead($PtnRep)
			$R3T0 = Number(GUICtrlRead($R3T))
			$aSC = StringRegExp($iniSampleCopy, '^(.*?)<FUNC>(.*?)\h*<SEARCH>\h*(.*?)\h*<REPLACE>\h*(.*?)$', 3)
			If UBound($aSC) <> 4 Then
				$aSC = StringRegExp($SampleCopy, '^(.*?)<FUNC>(.*?)\h*<SEARCH>\h*(.*?)\h*<REPLACE>\h*(.*?)$', 3)
				IniWrite($SetIni, 'Set', 'SampleCopy', $SampleCopy)
			EndIf
			; защита
			If $RegExp0 = '' Then
				MsgBox(0, $LngMsg1, $LngMsg3)
				ContinueLoop
			EndIf
			If GUICtrlRead($Exc) = 1 Then
				; SampleCopy=$test=<FUNC>($test, '<SEARCH>', '<REPLACE>')
				$aSC[1] = StringTrimRight($aSC[1], 1)
				$aSC[2] = StringTrimRight(StringTrimLeft($aSC[2], 1), 1)
				$aSC[3] = StringTrimLeft($aSC[3], 1)
			Else
				If StringInStr($RegExp0, "'") Or StringInStr($RegExp0, '"') Then ; дублируем символы ' или " в выражении, если присутствуют
					If StringRight($aSC[2], 1) = "'" Then ; апостроф
						$RegExp0 = StringReplace($RegExp0, "'", "''")
					ElseIf StringRight($aSC[2], 1) = '"' Then ; кавычка
						$RegExp0 = StringReplace($RegExp0, '"', '""')
					EndIf
				EndIf
			EndIf
			Switch 1
				Case GUICtrlRead($R1)
					ClipPut($aSC[0] & 'StringRegExp' & $aSC[1] & $RegExp0 & $aSC[3])
				Case GUICtrlRead($R2)
					ClipPut($aSC[0] & 'StringRegExpReplace' & $aSC[1] & $RegExp0 & $aSC[2] & $PtnRep0 & $aSC[3])
				Case GUICtrlRead($R3)
					If $R3T0 Then
						If GUICtrlRead($Exc) = 4 Then $aSC[2] = StringTrimRight($aSC[2], 1)
						ClipPut($aSC[0] & 'StringRegExp' & $aSC[1] & $RegExp0 & $aSC[2] & $R3T0 & ')')
					Else
						ClipPut($aSC[0] & 'StringRegExp' & $aSC[1] & $RegExp0 & $aSC[3])
					EndIf
			EndSwitch

		Case $Start
			$RegExp0 = GUICtrlRead($RegExp)
			$RegExp00 = $RegExp0
			$PtnRep0 = GUICtrlRead($PtnRep)
			$Pattern0 = GUICtrlRead($Pattern)
			$R3T0 = Number(GUICtrlRead($R3T))
			If GUICtrlRead($Exc) = 1 Then
				$RegExp0 = Execute($RegExp0)
				$PtnRep0 = Execute($PtnRep0)
			EndIf
			; защита
			If $RegExp0 = '' Then
				MsgBox(0, $LngMsg1, $LngMsg3)
				ContinueLoop
			EndIf
			If $Pattern0 = '' Then
				MsgBox(0, $LngMsg1, $LngMsg4)
				ContinueLoop
			EndIf
			$tmp = ''
			GUICtrlSetData($Result, '')
			GUICtrlSetColor($Result, $TextColor0)
			; Выполнение
			If GUICtrlRead($R1) = 1 Then ; режим поиска
				$vTimer = TimerInit()
				$aPattern = StringRegExp($Pattern0, $RegExp0)
				$vTimer = Round(TimerDiff($vTimer), 4)
				GUICtrlSetData($iTimer, $vTimer)
				$tmp = StringRegExpReplace($Pattern0, $RegExp0, '\0')
				$kol = @extended

				If @error = 2 Then
					GUICtrlSetData($Result, $LngMsg5 & ' ' & $RegExp0 & @CRLF & '@Extended = ' & $kol & '      ' & StringMid($RegExp0, $kol, 1))
					GUICtrlSetColor($Result, $RedColor)
					GUICtrlSetColor($RegExp, $RedColor)
					GUICtrlSetData($LRes, $LngRRS & '   -   Ctrl+Enter')
					$tr1 = 1
					GUICtrlSetState($RegExp, $GUI_FOCUS)
					; GUICtrlSendMsg($RegExp, $EM_SETSEL, $kol - 1, $kol)
					_GUICtrlComboBox_SetEditSel($RegExp, $kol - 1, $kol)
					ContinueLoop
				EndIf

				If $tmp And $kol Then
					GUICtrlSetData($Result, $LngDt1 & ' : ' & $kol & @CRLF)
					GUICtrlSetData($LRes, $LngRRS & '    / ' & $kol & ' /  -   Ctrl+Enter')
					; GUICtrlSetTip($Copy, '$test=StringRegExp($test, '''&$RegExp0&''', 0)')
				Else
					GUICtrlSetData($Result, $LngDt2 & ' ' & $RegExp0)
					GUICtrlSetColor($Result, $RedColor)
					GUICtrlSetData($LRes, $LngRRS & '   -   Ctrl+Enter')
				EndIf
			EndIf
			If GUICtrlRead($R2) = 1 Then ; режим замены
				$vTimer = TimerInit()
				$tmp = StringRegExpReplace($Pattern0, $RegExp0, $PtnRep0)
				$kol = @extended
				$err = @error
				$vTimer = Round(TimerDiff($vTimer), 4)
				GUICtrlSetData($iTimer, $vTimer)
				If $err = 2 Then
					GUICtrlSetData($Result, $LngMsg5 & ' ' & $RegExp0 & @CRLF & '@Extended = ' & $kol & '      ' & StringMid($RegExp0, $kol, 1))
					GUICtrlSetColor($Result, $RedColor)
					GUICtrlSetColor($RegExp, $RedColor)
					GUICtrlSetData($LRes, $LngRRS & '   -   Ctrl+Enter')
					$tr1 = 1
					GUICtrlSetState($RegExp, $GUI_FOCUS)
					; GUICtrlSendMsg($RegExp, $EM_SETSEL, $kol - 1, $kol)
					_GUICtrlComboBox_SetEditSel($RegExp, $kol - 1, $kol)
					ContinueLoop
				EndIf
				If $kol Then
					GUICtrlSetData($Result, $tmp)
					GUICtrlSetData($LRes, $LngRRS & '    / ' & $kol & ' /  -   Ctrl+Enter')
					; GUICtrlSetTip($Copy, '$test=StringRegExpReplace($test, '''&$RegExp0&''', '''&$PtnRep0&''')')
				Else
					GUICtrlSetData($Result, $LngDt2 & ' ' & $RegExp0)
					GUICtrlSetColor($Result, $RedColor)
					GUICtrlSetData($LRes, $LngRRS & '   -   Ctrl+Enter')
				EndIf
			EndIf
			If GUICtrlRead($R3) = 1 Then ; режим групп
				$vTimer = TimerInit()
				$aPattern = StringRegExp($Pattern0, $RegExp0, $R3T0)
				$kol = @extended
				$err = @error
				$vTimer = Round(TimerDiff($vTimer), 4)
				GUICtrlSetData($iTimer, $vTimer)
				If $err = 2 Then
					GUICtrlSetData($Result, $LngMsg5 & ' ' & $RegExp0 & @CRLF & '@Extended = ' & $kol & '      ' & StringMid($RegExp0, $kol, 1))
					GUICtrlSetColor($Result, $RedColor)
					GUICtrlSetColor($RegExp, $RedColor)
					GUICtrlSetData($LRes, $LngRRS & '   -   Ctrl+Enter')
					$tr1 = 1
					GUICtrlSetState($RegExp, $GUI_FOCUS)
					; GUICtrlSendMsg($RegExp, $EM_SETSEL, $kol - 1, $kol)
					_GUICtrlComboBox_SetEditSel($RegExp, $kol - 1, $kol)
					ContinueLoop
				EndIf

				If $R3T0 Then

					$u = UBound($aPattern)
					If $u Then ; если есть результат
						$ChT0 = GUICtrlRead($ChT) ; чекбокс возле Группы

						If $R3T0 = 4 Then
							If $ChT0 = 1 Then
								For $i = 0 To $u - 1
									$aA = $aPattern[$i]
									$aPattern[$i] = ''
									For $j = 0 To UBound($aA) - 1
										$aPattern[$i] &= $j & ' ' & $Gsub & $aA[$j] & @CRLF & @TAB
									Next
									$aPattern[$i] = StringTrimRight($aPattern[$i], 3)
									$tmp &= $LngDtG & ' ' & $i + 1 & ' ' & $Gsmbl & @CRLF & @TAB & $aPattern[$i] & @CRLF
								Next
							Else
								For $i = 0 To $u - 1
									$aA = $aPattern[$i]
									$aPattern[$i] = ''
									For $j = 0 To UBound($aA) - 1
										$aPattern[$i] &= $aA[$j] & @CRLF & @TAB
									Next
									$aPattern[$i] = StringTrimRight($aPattern[$i], 3)
									$tmp &= $aPattern[$i] & @CRLF
								Next
							EndIf
						Else
							If $ChT0 = 1 Then
								For $i = 0 To $u - 1
									$tmp &= $LngDtG & ' ' & $i + 1 & ' ' & $Gsub & $aPattern[$i] & @CRLF
								Next
							Else
								For $i = 0 To $u - 1
									$tmp &= $aPattern[$i] & @CRLF
								Next
							EndIf
						EndIf
						$tmp = StringTrimRight($tmp, 2)
						GUICtrlSetData($Result, $tmp)
						GUICtrlSetData($LRes, $LngRRS & '    / ' & $u & ' /  -   Ctrl+Enter')
						; GUICtrlSetTip($Copy, '$test=StringRegExp($test, '''&$RegExp0&''', 3)')
					Else ; иначе ошибка, красный цвет
						GUICtrlSetData($Result, $LngDt2 & ' ' & $RegExp0)
						GUICtrlSetColor($Result, $RedColor)
						GUICtrlSetData($LRes, $LngRRS & '   -   Ctrl+Enter')
					EndIf
				Else
					If $aPattern Then
						GUICtrlSetData($Result, '<True>')
						GUICtrlSetData($LRes, $LngRRS & '    / True /  -   Ctrl+Enter')
					Else
						GUICtrlSetData($Result, $LngDt2 & ' ' & $RegExp0)
						GUICtrlSetColor($Result, $RedColor)
						GUICtrlSetData($LRes, $LngRRS & '    / False /  -   Ctrl+Enter')
					EndIf
				EndIf
			EndIf
			GUICtrlSetData($iTimerMR, $nTimer0)
			If $vTimer < $nTimer0 Then
				GUICtrlSetBkColor($iTimer, 0xD2FFCC)
			Else
				GUICtrlSetBkColor($iTimer, 0xffd7d7)
			EndIf
			If Not ($RegExp00 == $RegExp0tmp) Then
				_ComboBox_Insert($RegExp00, $iniRExList, $RegExp)
				$RegExp0tmp = $RegExp00
			EndIf
			$nTimer0 = $vTimer
			GUICtrlSetState($Result, $GUI_FOCUS)
		Case $Helphtm
			If FileExists(@ScriptDir & '\RegExpHelp.hta') Then
				ShellExecute(@ScriptDir & '\RegExpHelp.hta')
			Else
				; MsgBox(0, $LngErr, $LngMsg7, 1)
				$sPathAutoIt = RegRead('HKLM\Software\AutoIt v3\AutoIt', 'InstallDir')
				If Not @error Then Run('hh.exe "' & $sPathAutoIt & '\AutoIt3.chm::/html/functions/StringRegExp.htm"')
			EndIf
		Case $restart
			_restart()
		Case $About
			_About()
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
	If $tr1 And $msg = $GUI_EVENT_PRIMARYDOWN Then
		GUICtrlSetColor($RegExp, $TextColor0)
		$tr1 = 0
	EndIf
WEnd

Func _ComboBox_Insert($item, ByRef $iniList, $ctrlID)
	$iniList = StringReplace($sep & $iniList & $sep, $sep & $item & $sep, $sep)
	$iniList = $item & StringTrimRight($iniList, 1)
	Local $tmp = StringInStr($iniList, $sep, 0, $KolStr)
	If $tmp Then $iniList = StringLeft($iniList, $tmp - 1)
	GUICtrlSetData($ctrlID, $sep & $iniList, $item)
EndFunc

Func _TestRange()
	Local $GP, $Combo, $Update, $StatusBar, $s, $aWA = _WinAPI_GetWorkingArea()
	Local $sPat = GUICtrlRead($RegExp)
	If Not $sPat Then $sPat = '..'

	$GP = _ChildCoor($Gui, 320, $aWA[3] - $aWA[1] - 40)
	GUISetState(@SW_DISABLE, $Gui)

	$GUI1 = GUICreate($sPat, $GP[2], $GP[3], $GP[0], $GP[1], $WS_OVERLAPPEDWINDOW + $WS_POPUP, -1, $Gui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 1)
	$StatusBar = GUICtrlCreateLabel('Done', 5, $GP[3] - 20, 310, 17, $SS_LEFTNOWORDWRAP)

	$Combo = GUICtrlCreateCombo('', 5, 5, 280)
	GUICtrlSetData($Combo, $sPat & $sep & '\a' & $sep & '[\cA-\cZ]' & $sep & '\d' & $sep & '\D' & $sep & '\e' & $sep & '\f' & $sep & '\h' & $sep & '\H' & $sep & '\n' & $sep & '\N' & $sep & '\R' & $sep & '\s' & $sep & '\S' & $sep & '\t' & $sep & '\v' & $sep & '\V' & $sep & '\w' & $sep & '\W' & $sep & '[\x{01}-\x{0F}]' & $sep & '[\x01-\x0F]' & $sep & '[\001-\010]' & $sep & '[[:alnum:]]' & $sep & '[[:alpha:]]' & $sep & '[[:ascii:]]' & $sep & '[[:blank:]]' & $sep & '[[:cntrl:]]' & $sep & '[[:digit:]]' & $sep & '[[:graph:]]' & $sep & '[[:lower:]]' & $sep & '[[:print:]]' & $sep & '[[:punct:]]' & $sep & '[[:space:]]' & $sep & '[[:upper:]]' & $sep & '[[:word:]]' & $sep & '[[:xdigit:]]', $sPat)
	$Update = GUICtrlCreateButton('>', 320 - 30, 5, 22, 22)

	$ListView = GUICtrlCreateListView('Symbol' & $sep & 'Yes' & $sep & 'No' & $sep & 'Hex' & $sep & 'Oct', 5, 30, $GP[2] - 10, $GP[3] - 55, -1, $LVS_EX_GRIDLINES + $LVS_EX_FULLROWSELECT + $WS_EX_CLIENTEDGE)
	GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 70) ; установка ширины первого столбца (инд=0)

	GUICtrlSetData($StatusBar, _UpdateListView($sPat))

	GUISetState(@SW_SHOW, $GUI1)
	While 1
		Switch GUIGetMsg()
			Case $Combo, $Update
				$sPat = GUICtrlRead($Combo)
				GUICtrlSetData($StatusBar, _UpdateListView($sPat, 1))
			Case -3
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($GUI1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func _UpdateListView($sPat, $Tr = 0)
	Local $b, $Chr, $i, $kol
	Local $Chr[256][3] = [['NUL'],['SOH'],['STX'],['ETX'],['EOT'],['ENQ'],['ACK'],['BEL'],['BS'],['HT'],['LF'],['VT'],['FF'],['CR'],['SO'],['SI'], _
			['DLE'],['DC1'],['DC2'],['DC3'],['DC4'],['NAK'],['SYN'],['ETB'],['CAN'],['EM'],['SUB'],['ESC'],['FS'],['GS'],['RS'],['US'],['Space']]
	$Chr[127][0] = 'DEL'
	$Chr[160][0] = 'Space2'

	If $Tr Then GUICtrlSendMsg($ListView, $LVM_DELETEALLITEMS, 0, 0)

	$kol = 0
	For $i = 0 To 255
		$s = Chr($i)
		If Not $Chr[$i][0] Then $Chr[$i][0] = $s
		$b = StringRegExpReplace($s, $sPat, '\0')
		If @extended Then
			$Chr[$i][1] = String(Asc($b))
			$kol += 1
		Else
			$Chr[$i][2] = String(Asc($b))
		EndIf
	Next
	$hListView = GUICtrlGetHandle($ListView)
	_GUICtrlListView_BeginUpdate($hListView)
	For $i = 0 To 255
		GUICtrlCreateListViewItem($Chr[$i][0] & $sep & $Chr[$i][1] & $sep & $Chr[$i][2] & $sep & StringFormat("%02X", $i) & $sep & StringFormat("%03o", $i), $ListView)
		If $Chr[$i][1] Then GUICtrlSetBkColor(-1, 0xd7ffd7)
	Next
	_GUICtrlListView_EndUpdate($hListView)
	Return 'Yes=' & $kol & ', No=' & 256 - $kol
EndFunc

Func _aIniPtn()
	GUICtrlSendMsg($History, 0x0184, 0, 0)
	$initext = FileRead($Ini)
	$z = ''
	$aIniPtn = StringRegExp($initext, '(?s)z\]\r\n(.*?)(?=\r\n\[z)', 3)
	If Not @error Then
		For $i = 0 To UBound($aIniPtn) - 1
			If $i < 9 Then
				$z = '0' & $i + 1
			Else
				$z = $i + 1
			EndIf
			GUICtrlSetData($History, $z & '. ' & StringRegExpReplace($aIniPtn[$i], '(?s)(^.*?)(\r\n.*)$', '$1'))
		Next
	Else
		$aIniPtn = ''
		Dim $aIniPtn[1]
	EndIf
EndFunc

Func _Exit()
	IniWrite($SetIni, 'Set', 'GroupL', GUICtrlRead($ChT))
	IniWrite($SetIni, 'Set', 'ComboREx', StringReplace($iniRExList, $sep, $iniSep))

	; $iState = WinGetState($Gui)
	; Если окно не свёрнуто или не развёрнуто на весь экран, то получаем его координаты и размеры
	; If Not (BitAnd($iState, 16) Or BitAnd($iState, 32)) Then _Resized()
	IniWrite($SetIni, 'Set', 'WinMax', $WHXY[4])
	IniWrite($SetIni, 'Set', 'W', $WHXY[0])
	IniWrite($SetIni, 'Set', 'H', $WHXY[1])
	IniWrite($SetIni, 'Set', 'X', $WHXY[2])
	IniWrite($SetIni, 'Set', 'Y', $WHXY[3])
EndFunc

Func WM_EXITSIZEMOVE()
	$ClientSz = WinGetClientSize($Gui)
	$GuiPos = WinGetPos($Gui)
	$WHXY[0] = $ClientSz[0]
	$WHXY[1] = $ClientSz[1]
	$WHXY[2] = $GuiPos[0]
	$WHXY[3] = $GuiPos[1]
	_SetSizePos($ClientSz[0], $ClientSz[1])
EndFunc

Func WM_SIZE($hWnd, $msg, $wParam, $lParam)
	#forceref $Msg, $wParam
	Local $w, $h
	If $hWnd = $Gui Then
		$w = BitAND($lParam, 0xFFFF) ; _WinAPI_LoWord
		$h = BitShift($lParam, 16) ; _WinAPI_HiWord
		_SetSizePos($w, $h)
	EndIf

	Return $GUI_RUNDEFMSG
EndFunc

Func _SetSizePos($w, $h)
	$w = $w - 200
	$h = ($h - 130) / 2
	GUICtrlSetPos($Pattern, 10, 104, $w, $h)
	GUICtrlSetPos($Result, 10, $h + 120, $w, $h)
	GUICtrlSetPos($LRes, 10, $h + 105)
EndFunc

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	Switch $hWnd
		Case $Gui
			Local $tMINMAXINFO = DllStructCreate("int;int;" & _
					"int MaxSizeX; int MaxSizeY;" & _
					"int MaxPositionX;int MaxPositionY;" & _
					"int MinTrackSizeX; int MinTrackSizeY;" & _
					"int MaxTrackSizeX; int MaxTrackSizeY", _
					$lParam)
			DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 580) ; минимальные размеры окна
			DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 330)
		Case $GUI1
			Local $tMINMAXINFO = DllStructCreate("int;int;" & _
					"int MaxSizeX; int MaxSizeY;" & _
					"int MaxPositionX;int MaxPositionY;" & _
					"int MinTrackSizeX; int MinTrackSizeY;" & _
					"int MaxTrackSizeX; int MaxTrackSizeY", _
					$lParam)
			DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 180) ; минимальные размеры окна
			DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 130)
	EndSwitch
EndFunc

Func _About()
	Global $iScroll_Pos, $GUI1, $nLAbt, $hAbt, $wAbtBt
	$wAbt = 270
	$hAbt = 180
	$wAbtBt = 20
	$wA = $wAbt / 2 - 80
	$wB = $hAbt / 3 * 2
	$iScroll_Pos = -$hAbt
	$TrAbt1 = 0
	$TrAbt2 = 0
	$BkCol1 = 0xE1E3E7
	$BkCol2 = 0
	$GP = _ChildCoor($Gui, $wAbt, $hAbt)
	GUISetState(@SW_DISABLE, $Gui)
	$font = "Arial"
	$GUI1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	GUISetIcon($AutoItExe, 1)
	GUISetBkColor($BkCol1)
	GUISetFont(-1, -1, -1, $font)
	$vk1 = GUICtrlCreateButton(ChrW('0x25BC'), 0, $hAbt - 20, $wAbtBt, 20)

	GUICtrlCreateTab($wAbtBt, 0, $wAbt - $wAbtBt, $hAbt + 35, 0x0100 + 0x0004 + 0x0002)
	$tabAbt0 = GUICtrlCreateTabItem("0")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt - $wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128)
	GUICtrlSetBkColor(-1, $BkCol1)

	GUICtrlCreateLabel($LngTitle, 0, 0, $wAbt, $hAbt / 3, $SS_CENTER + $SS_CENTERIMAGE)
	GUICtrlSetFont(-1, 15, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, $hAbt / 3, $wAbt - 2, 1, 0x10)

	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.8.1   17.06.2012', $wA, $wB - 30, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', $wA, $wB - 15, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', $wA + 37, $wB - 15, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', $wA, $wB, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', $wA + 75, $wB, 125, 17)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010', $wA, $wB + 15, 210, 17)

	$tabAbt1 = GUICtrlCreateTabItem("1")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt - $wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128)
	GUICtrlSetBkColor(-1, 0x000000)

	$StopPlay = GUICtrlCreateButton(ChrW('0x25A0'), 0, $hAbt - 41, $wAbtBt, 20)
	GUICtrlSetState(-1, 32)

	$nLAbt = GUICtrlCreateLabel($LngScrollAbt, $wAbtBt, $hAbt, $wAbt - $wAbtBt, 360, $SS_CENTER) ; центр
	GUICtrlSetFont(-1, 9, 400, 2, $font)
	GUICtrlSetColor(-1, 0x99A1C0)
	GUICtrlSetBkColor(-1, -2) ; прозрачный
	GUICtrlCreateTabItem('')
	GUISetState(@SW_SHOW, $GUI1)

	While 1
		Switch GUIGetMsg()
			Case $vk1
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
			Case $StopPlay
				If $TrAbt2 = 0 Then
					AdlibUnRegister('_ScrollAbtText')
					GUICtrlSetData($StopPlay, ChrW('0x25BA'))
					$TrAbt2 = 1
				Else
					AdlibRegister('_ScrollAbtText', 40)
					GUICtrlSetData($StopPlay, ChrW('0x25A0'))
					$TrAbt2 = 0
				EndIf
			Case $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $WbMn
				ClipPut('R939163939152')
			Case -3
				AdlibUnRegister('_ScrollAbtText')
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($GUI1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func _ScrollAbtText()
	$iScroll_Pos += 1
	ControlMove($GUI1, "", $nLAbt, $wAbtBt, -$iScroll_Pos)
	If $iScroll_Pos > 360 Then $iScroll_Pos = -$hAbt
EndFunc