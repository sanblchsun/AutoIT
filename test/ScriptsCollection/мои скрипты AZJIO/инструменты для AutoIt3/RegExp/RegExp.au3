#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=RegExp.exe
#AutoIt3Wrapper_OutFile_X64=RegExpX64.exe
; #AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Icon=RegExp.ico
#AutoIt3Wrapper_Compression=n
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=RegExp.exe
#AutoIt3Wrapper_Res_Fileversion=1.0.2
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|1.0.2
#AutoIt3Wrapper_Res_Field=Build|2013.06.23
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
; #AutoIt3Wrapper_Run_After=%autoitdir%\Aut2Exe\upx.exe -7 --compress-icons=0 "%out%"
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2010.10.23-2013.06.12 AutoIt3-v3.3.8.1
#include <GuiEdit.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <GuiListView.au3>
; #include <GuiComboBox.au3>
#include <ListBoxConstants.au3>
#include <ButtonConstants.au3>
#include <GuiRichEdit.au3>
#include <GuiMenu.au3>
#include <File.au3>
#include <ForRegExp.au3>

#NoTrayIcon
Opt("GUIResizeMode", 802)
$sep = ChrW(0x0144)
Opt("GUIDataSeparatorChar", $sep)

#region
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
$LngIni4 = 'IPv4'
$LngIni5 = 'metacharacters'
$LngIni6 = 'Removing blank lines'
$LngIni7 = 'Domain'
$LngIni8 = 'URL'
$LngIni9 = 'mail'
$LngRCopy = 'Copy'
$LngRTst = 'Test'
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
$LngCLP = 'Color'
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
	$LngIni4 = 'IPv4 айпишники'
	$LngIni5 = 'Экранирование спец-символов'
	$LngIni6 = 'Удаление пустых строк'
	$LngIni7 = 'Домен'
	$LngIni8 = 'найти URL'
	$LngIni9 = 'Почта'
	$LngRCopy = 'Копир'
	$LngRTst = 'Тест'
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
	$LngCLP = 'Цвет'
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
#endregion

Global $aIniPtn, $auUpd = 0, $iniLibraryName = 'Sample', $SetIni = @ScriptDir & '\RegExp.ini', $SampleCopy = "$test=<FUNC>($test, '<SEARCH>', '<REPLACE>')", $Gsub = ChrW(0x25BA), $Gsmbl, $nTimer0, $GUI1, $ListView, $iniRExList, $KolStr = 30, $iniSep = '}—•—{', $RegExp0tmp = '', $WHXY[5]
For $i = 1 To 20
	$Gsmbl &= ChrW(0x25AC)
Next

Global $hRichEdit_SPE, $ContMenu, $iMenuItem[1] = [0], $a_iniList[1] = [0], $hPatternM, $MenuPatternID[1] = [0], $MenuLibraryID[1] = [0]

Global Const $tagEN_MSGFILTER2 = $tagNMHDR & ";uint msg;wparam wParam;lparam lParam"
; Global $CodeRTF = '{\rtf1\ansi\ansicpg1251\deff0\deflang1049{\fonttbl{\f0\fnil\fcharset204 Consolas;}}'&@CRLF&'{\*\generator Msftedit 5.41.15.1515;}\viewkind4\uc1\pard\f0\fs22 '
; $CodeRTFend = '\par'&@CRLF&'}'&@CRLF

If Not FileExists($SetIni) Then
	$iniopen = FileOpen($SetIni, 2)
	FileWrite($iniopen, _
			'[Set]' & @CRLF & _
			'FontSize=-1' & @CRLF & _
			'ColorParcer=1' & @CRLF & _
			';RedColor=c53800' & @CRLF & _
			';TextColor=000000' & @CRLF & _
			';BkColor=d0c8ac' & @CRLF & _
			';GuiBkColor=aba48c' & @CRLF & _
			';ColorSPE00=FFFFFF' & @CRLF & _
			';ColorSPE10=B4B4F3' & @CRLF & _
			';ColorSPE11=9F9FD7' & @CRLF & _
			';ColorSPE20=E0DBB5' & @CRLF & _
			';ColorSPE21=D8C77A' & @CRLF & _
			';ColorSPE30=8FDFE3' & @CRLF & _
			';ColorSPE31=8DD4D4' & @CRLF & _
			';ColorSPE40=F2C0CD' & @CRLF & _
			';ColorSPE50=A7E1A9' & @CRLF & _
			';ColorSPE60=9AD0F0' & @CRLF & _
			';ColorSPE70=DEC1E5' & @CRLF & _
			'SampleCopy=' & $SampleCopy & @CRLF & _
			'GroupL=1' & @CRLF & _
			'ComboREx=' & @CRLF & _
			'LastLibrary=' & @CRLF & _
			'WinMax=' & @CRLF & _
			'W=' & @CRLF & _
			'H=' & @CRLF & _
			'X=' & @CRLF & _
			'Y=')
	FileClose($iniopen)
EndIf
; ';FontFamily=Consolas' & @CRLF & _

Global $iColorTheme[8][2]
; = [[ _
; Dec('ffffff'), Dec('ffffff')], [ _
; Dec('BDBDFF'), Dec('ACA6E6')], [ _ ; красный
; Dec('FFF7BD'), Dec('E3DF8F')], [ _ ; голубой
; Dec('A5FFFF'), Dec('8FDFE3')], [ _ ; жёлтый
; Dec('FFDDE6'), 0], [ _ ; фиолетовый
; Dec('BDFFBF'), 0], [ _ ; зелёный
; Dec('A5DFFF'), 0], [ _ ; оранжевый
; Dec('F7C1FF'), 0]] ; розовый (числа)
; _ArrayDisplay($iColorTheme, 'Array')

$iColorTheme[0][0] = Dec(IniRead($SetIni, 'Set', 'ColorSPE00', ''))
If Not $iColorTheme[0][0] Then $iColorTheme[0][0] = 16777215
$iColorTheme[1][0] = Dec(IniRead($SetIni, 'Set', 'ColorSPE10', ''))
If Not $iColorTheme[1][0] Then $iColorTheme[1][0] = 12434943
$iColorTheme[1][1] = Dec(IniRead($SetIni, 'Set', 'ColorSPE11', ''))
If Not $iColorTheme[1][1] Then $iColorTheme[1][1] = 11314918

$iColorTheme[2][0] = Dec(IniRead($SetIni, 'Set', 'ColorSPE20', ''))
If Not $iColorTheme[2][0] Then $iColorTheme[2][0] = 16775101
$iColorTheme[2][1] = Dec(IniRead($SetIni, 'Set', 'ColorSPE21', ''))
If Not $iColorTheme[2][1] Then $iColorTheme[2][1] = 14933903

$iColorTheme[3][0] = Dec(IniRead($SetIni, 'Set', 'ColorSPE30', ''))
If Not $iColorTheme[3][0] Then $iColorTheme[3][0] = 10878975
$iColorTheme[3][1] = Dec(IniRead($SetIni, 'Set', 'ColorSPE31', ''))
If Not $iColorTheme[3][1] Then $iColorTheme[3][1] = 9428963

$iColorTheme[4][0] = Dec(IniRead($SetIni, 'Set', 'ColorSPE40', ''))
If Not $iColorTheme[4][0] Then $iColorTheme[4][0] = 16768486
$iColorTheme[5][0] = Dec(IniRead($SetIni, 'Set', 'ColorSPE50', ''))
If Not $iColorTheme[5][0] Then $iColorTheme[5][0] = 12451775
$iColorTheme[6][0] = Dec(IniRead($SetIni, 'Set', 'ColorSPE60', ''))
If Not $iColorTheme[6][0] Then $iColorTheme[6][0] = 10870783
$iColorTheme[7][0] = Dec(IniRead($SetIni, 'Set', 'ColorSPE70', ''))
If Not $iColorTheme[7][0] Then $iColorTheme[7][0] = 16237055

; _ArrayDisplay($iColorTheme, 'Array')
; MsgBox(0, 'Сообщение', VarGetType($iColorTheme[2][0]))

$iniSampleCopy = IniRead($SetIni, 'Set', 'SampleCopy', $SampleCopy)
$iniGroupL = Number(IniRead($SetIni, 'Set', 'GroupL', 1))
$iniRExList = IniRead($SetIni, 'Set', 'ComboREx', '')
$iniRExList = StringReplace($iniRExList, $iniSep, $sep)
While StringRight($iniRExList, 1) = $sep
	$iniRExList = StringTrimRight($iniRExList, 1)
WEnd

$iniLibrary = @ScriptDir & '\Library\' & IniRead($SetIni, 'Set', 'LastLibrary', $iniLibraryName) & '.ini'
If Not FileExists($iniLibrary) Then
	$iniLibrary = @ScriptDir & '\Library\' & $iniLibraryName & '.ini'
	If Not FileExists($iniLibrary) Then _CreateSampleINI()
EndIf

$FontSize = Number(IniRead($SetIni, 'Set', 'FontSize', '-1'))
If $FontSize < 7 Or $FontSize > 18 Then $FontSize = -1

$RedColor = Dec(IniRead($SetIni, 'Set', 'RedColor', ''))
If $RedColor = '' Then $RedColor = 0xff0000
$TextColor = Dec(IniRead($SetIni, 'Set', 'TextColor', ''))
$BkColor = Dec(IniRead($SetIni, 'Set', 'BkColor', ''))
$GuiBkColor = Dec(IniRead($SetIni, 'Set', 'GuiBkColor', ''))


$ColorParcer = Number(IniRead($SetIni, 'Set', 'ColorParcer', '1'))

$WHXY[0] = Number(IniRead($SetIni, 'Set', 'W', '680'))
$WHXY[1] = Number(IniRead($SetIni, 'Set', 'H', '460'))
$WHXY[2] = IniRead($SetIni, 'Set', 'X', '')
$WHXY[3] = IniRead($SetIni, 'Set', 'Y', '')
$WHXY[4] = Number(IniRead($SetIni, 'Set', 'WinMax', ''))

_SetCoor($WHXY, 580, 330, 3)

$hGui = GUICreate("RegExp", $WHXY[0], $WHXY[1], $WHXY[2], $WHXY[3], BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPCHILDREN), $WS_EX_ACCEPTFILES + $WS_EX_COMPOSITED)
If $GuiBkColor <> '' Then GUISetBkColor($GuiBkColor)
If @Compiled Then
	$AutoItExe = @AutoItExe
Else
	$AutoItExe = @ScriptDir & '\RegExp.dll'
	GUISetIcon($AutoItExe, 1)
EndIf
GUISetFont($FontSize)

$restart = GUICtrlCreateButton("R", $WHXY[0] - 22, 2, 19, 22)
GUICtrlSetTip(-1, $LngRe)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

$About = GUICtrlCreateButton("@", $WHXY[0] - 41, 2, 19, 22)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetTip(-1, 'About')

$Helphtm = GUICtrlCreateButton("?", $WHXY[0] - 60, 2, 19, 22)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetTip(-1, 'RegExpHelp.hta' & @TAB & 'F1')

$LReg = GUICtrlCreateLabel($LngREx, 10, 10, 266, 14)
$hRichEdit_SPE = _GUICtrlRichEdit_Create($hGui, '', _
		10, 24, $WHXY[0] - 200, 22, $ES_AUTOHSCROLL, 0)
OnAutoItExitRegister('_OnExit') ; Освобождает ресурсы RichEdit даже при завершении скрипта с ошибкой. Регистрировать обязательно сразу после создания RichEdit, иначе при ошибке кода между созданием и регистрацией функция выхода ещё не зарегистрирована, а ошибка валит программу без освобождения ресурсов RichEdit и комп повисает намертво.
Func _OnExit()
	; Для версий ниже 3.3.8.0 обязательно удаление RichEdit или GUI для освобождения ресурсов RichEdit
	_GUICtrlRichEdit_Destroy($hRichEdit_SPE)
	GUIDelete()
EndFunc   ;==>_OnExit
If $FontSize < 11 Then $FontSize = 11
$sFontF = "Consolas" ; Verdana
_SetFont_RE()
; _GuiCtrlRichEdit_SetSel($hRichEdit_SPE,  0, -1)
; _GUICtrlRichEdit_SetFont($hRichEdit_SPE, $FontSize, $sFontF)
; _GUICtrlRichEdit_Deselect($hRichEdit_SPE)
; GUICtrlSetResizing(-1, 7 + 32 + 512)
; GUICtrlSetFont(-1, $FontSize, -1, -1, 'Verdana')

Func _SetFont_RE()
	_GUICtrlRichEdit_SetSel($hRichEdit_SPE, 0, -1)
	_GUICtrlRichEdit_SetFont($hRichEdit_SPE, $FontSize, $sFontF)
	_GUICtrlRichEdit_Deselect($hRichEdit_SPE)
EndFunc   ;==>_SetFont_RE

$iCombo = GUICtrlCreateButton('V', $WHXY[0] - 214, 24, 23, 22)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

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

$btnLibrary = GUICtrlCreateButton($LngRHs, $WHXY[0] - 180, 2, 120, 22)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
$hLibraryM = _GetMenuLibrary($btnLibrary)

$History = GUICtrlCreateList('', $WHXY[0] - 180, 24, 170, $WHXY[1] - 244, $LBS_NOINTEGRALHEIGHT + $GUI_SS_DEFAULT_LIST) ; $LBS_NOINTEGRALHEIGHT+$GUI_SS_DEFAULT_LIST
GUICtrlSetResizing(-1, 256 + 64 + 32 + 4)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

; $Opn = GUICtrlCreateButton('Opn', $WHXY[0] - 180, $WHXY[1] - 219, 25, 25, $BS_ICON)
; GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
; GUICtrlSetTip(-1, $LngOH & @CRLF & 'Ctrl+NumPad 0' & @CRLF & 'Ctrl+Right')
; GUICtrlSetImage(-1, $AutoItExe, 201, 0)
$Upd = GUICtrlCreateButton('Upd', $WHXY[0] - 180, $WHXY[1] - 219, 25, 25, $BS_ICON)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngUpH)
GUICtrlSetImage(-1, $AutoItExe, 202, 0)
$Add = GUICtrlCreateButton('Add', $WHXY[0] - 154, $WHXY[1] - 219, 25, 25, $BS_ICON)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngAH & @CRLF & 'Ctrl+Left')
GUICtrlSetImage(-1, $AutoItExe, 203, 0)
$Del = GUICtrlCreateButton('Del', $WHXY[0] - 128, $WHXY[1] - 219, 25, 25, $BS_ICON)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngDH & @CRLF & 'Ctrl+Del' & @CRLF & 'Ctrl+Down')
; GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', -132, 0)
GUICtrlSetImage(-1, $AutoItExe, 204, 0)
; 102

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

$Copy = GUICtrlCreateButton($LngRCopy, $WHXY[0] - 55, $WHXY[1] - 94, 45, 22)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngCp & @CRLF & 'Ctrl+UP')

$Start = GUICtrlCreateButton($LngRTst, $WHXY[0] - 140, $WHXY[1] - 100, 75, 35)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, 'Ctrl+Enter')

$iTimerMR = GUICtrlCreateLabel('', $WHXY[0] - 180, $WHXY[1] - 50, 175, 20, BitOR($SS_SUNKEN, $SS_LEFTNOWORDWRAP))
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$iTimer = GUICtrlCreateLabel('  time, ms', $WHXY[0] - 180, $WHXY[1] - 30, 175, 20, BitOR($SS_SUNKEN, $SS_LEFTNOWORDWRAP))
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$TextColor0 = 0x0
$TrBkC = 0
$TrClr = 0
$BkColorRE = 0xFFFFFF
$ColorRE = 0
If $BkColor <> '' Then
	GUICtrlSetBkColor($Result, $BkColor)
	GUICtrlSetBkColor($Pattern, $BkColor)
	GUICtrlSetBkColor($History, $BkColor)
	GUICtrlSetBkColor($PtnRep, $BkColor)
	; GUICtrlSetBkColor($RegExp, $BkColor)
	; MsgBox(0, $BkColor, _RGB_BGR($BkColor))
	$BkColorRE = _RGB_BGR(Hex(Int($BkColor), 6))
	; MsgBox(0, Hex(Int($BkColor),6), Hex(Int($BkColorRE),6))
	_GUICtrlRichEdit_SetBkColor($hRichEdit_SPE, $BkColorRE)
	$TrBkC = 1
EndIf
If $TextColor <> '' Then
	GUICtrlSetColor($Result, $TextColor)
	GUICtrlSetColor($Pattern, $TextColor)
	GUICtrlSetColor($History, $TextColor)
	GUICtrlSetColor($PtnRep, $TextColor)
	$ColorRE = _RGB_BGR(Hex(Int($TextColor), 6))
	; GUICtrlSetColor($RegExp, $TextColor)
	$TrClr = 1
	$TextColor0 = $TextColor
EndIf

Func _RGB_BGR($iColor)
	Local $aRGB[3], $aTmp, $pat = 'x*([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})$'
	$aRGB = StringRegExp($iColor, $pat, 3)
	If @error Then Return SetError(1, 0, 0)
	Return Dec($aRGB[2] & $aRGB[1] & $aRGB[0])
EndFunc   ;==>_RGB_BGR

$iPatternM = GUICtrlCreateButton('.*?', $WHXY[0] - 294, 2, 23, 20)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
$hPatternM = _GetMenuPattern($iPatternM)
If @error Then GUICtrlSetState($iPatternM, $GUI_HIDE) ; если ошибка меню, то скрываем кнопку

$idColorParcer = GUICtrlCreateCheckbox($LngCLP, $WHXY[0] - 264, 6, 73, 17)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
If $ColorParcer Then GUICtrlSetState(-1, $GUI_CHECKED)

$Ctrl_A = GUICtrlCreateDummy()

; $CatchDrop1 = GUICtrlCreateLabel("", 0, 0, 500, 460)
; GUICtrlSetState(-1, $GUI_DROPACCEPTED + $GUI_DISABLE)
; GUICtrlSetResizing(-1, 102 + 256)
; $CatchDrop2 = GUICtrlCreateLabel("", $WHXY[0] - 180, 0, 180, 460)
; GUICtrlSetState(-1, $GUI_DROPACCEPTED + $GUI_DISABLE)
; GUICtrlSetResizing(-1, 256 + 64 + 32 + 4)

_Fill_ListBox()

$tr1 = 0
$z = ''
$kol = ''
$ChT0 = ''

Dim $AccelKeys[7][2] = [["{F1}", $Helphtm],["^a", $Ctrl_A],["^{ENTER}", $Start],["^{UP}", $Copy],["^{DEL}", $Del],["^{LEFT}", $Add],["^{DOWN}", $Del]]

; если раскладка не совпадает с англ. яз. то временно переключаем в неё, чтобы зарегистрировать горячие клавиши
$tmp = 0
$KeyLayout = RegRead("HKCU\Keyboard Layout\Preload", 1)
If Not @error And $KeyLayout <> 00000409 Then
	_WinAPI_LoadKeyboardLayoutEx(0x0409)
	$tmp = 1
EndIf

GUISetAccelerators($AccelKeys)
If $tmp = 1 Then _WinAPI_LoadKeyboardLayoutEx(Dec($KeyLayout)) ; восстанавливаем раскладку по умолчанию
OnAutoItExitRegister('_Exit')
GUISetState()
If $WHXY[4] Then
	GUISetState(@SW_MAXIMIZE, $hGui)
	WM_EXITSIZEMOVE()
EndIf

GUIRegisterMsg(0x0232, "WM_EXITSIZEMOVE")
GUIRegisterMsg($WM_SIZE, "WM_SIZE")
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
_GUICtrlRichEdit_SetEventMask($hRichEdit_SPE, $ENM_KEYEVENTS)

; Func _GUI_DropId($i_id)
; Local $tmp = _GUICtrlEdit_GetSel($i_id)
; $tmp = StringMid(GUICtrlRead($i_id), $tmp[0] + 1)
; _GUICtrlEdit_Undo($i_id)
; $tmp = StringRegExpReplace($tmp, '(?s)^(.+?)(?:\R.*)', '\1')
; If FileExists($tmp) And Not StringInStr(FileGetAttrib($tmp), "D") Then GUICtrlSetData($i_id, FileRead($tmp))
; EndFunc

While 1
	$Msg = GUIGetMsg()
	Switch $Msg
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
					$iniLibrary = @GUI_DragFile
					_Fill_ListBox()
			EndSwitch

		Case $idColorParcer
			If GUICtrlRead($idColorParcer) = $GUI_CHECKED Then
				$ColorParcer = 1
				_Pars()
				IniWrite($SetIni, 'Set', 'ColorParcer', '1')
			Else
				$ColorParcer = 0
				$iStart = _GUICtrlRichEdit_GetSel($hRichEdit_SPE)
				_Clear()
				_GUICtrlRichEdit_GotoCharPos($hRichEdit_SPE, $iStart[0])
				IniWrite($SetIni, 'Set', 'ColorParcer', '0')
			EndIf

		Case $Tst
			_TestRange()

		Case $charmap
			Run('charmap.exe')

		Case $Ctrl_A
			$tmp = 0
			Switch ControlGetFocus($hGui)
				Case 'Edit2'
					$tmp = $Pattern
				Case 'Edit3'
					$tmp = $Result
					; Case 'Edit0'
					; $tmp = $RegExp
				Case 'Edit1'
					$tmp = $PtnRep
			EndSwitch
			If $tmp Then
				GUICtrlSendMsg($tmp, $EM_SETSEL, 0, -1)
			Else
				If ControlGetFocus($hGui) = 'RICHEDIT50W1' Then
					Sleep(300) ; для пропуска нативной реакции выделения
					_GUICtrlRichEdit_SetSel($hRichEdit_SPE, 0, -1)
				EndIf
			EndIf

		Case $Add
			$RegExp0 = _GUICtrlRichEdit_GetText($hRichEdit_SPE)
			$R3T0 = GUICtrlRead($R3T)
			; защита
			If $RegExp0 = '' Then
				MsgBox(0, $LngErr, $LngMsg3, 0, $hGui)
				ContinueLoop
			EndIf
			$PtnRep0 = GUICtrlRead($PtnRep)
			$Pattern0 = GUICtrlRead($Pattern)
			$TrR = ''
			If GUICtrlRead($R1) = 1 Then $TrR = 1
			If GUICtrlRead($R2) = 1 Then $TrR = 2
			If GUICtrlRead($R3) = 1 Then $TrR = 3

			$GP = WinGetPos($hGui)
			$varnew = InputBox($LngMsg1, $LngInB & @CRLF, $LngInBn, "", 170, 150, $GP[0] + $GP[2] - 375, $GP[1] + $GP[3] - 305)
			If $varnew = '' Then
				ContinueLoop
			Else
				If Not FileExists($iniLibrary) Then
					$hFile = FileOpen($iniLibrary, 1)
					FileWrite($hFile, '[z--z]')
					FileClose($hFile)
				EndIf
				$hFile = FileOpen($iniLibrary, 1)
				FileWrite($hFile, @CRLF & $varnew & @CRLF & $RegExp0 & @CRLF & $PtnRep0 & @CRLF & $TrR & @CRLF & $Pattern0 & @CRLF & '[z--z]')
				FileClose($hFile)
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
			$hFile = FileOpen($iniLibrary, 2)
			FileWrite($hFile, $aTmpH)
			FileClose($hFile)
			_Fill_ListBox()

		Case $Upd
			$RegExp0 = _GUICtrlRichEdit_GetText($hRichEdit_SPE)
			If $RegExp0 = '' Then
				MsgBox(0, $LngMsg1, $LngMsg3, 0, $hGui)
				ContinueLoop
			EndIf
			$History0 = GUICtrlRead($History)
			If $History0 = 0 Then
				GUICtrlSetBkColor($History, 0xffe7e7)
				MsgBox(0, $LngMsg1, $LngMsg6, 0, $hGui)
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
			$hFile = FileOpen($iniLibrary, 2)
			FileWrite($hFile, $aTmpH)
			FileClose($hFile)
			_Fill_ListBox()
			GUICtrlSetData($History, $History0)

			; Case $Opn
			; $tmp = FileOpenDialog($LngFOp, @ScriptDir, $LngFO2 & " (*.ini)", "", "", $hGui)
			; If @error Then ContinueLoop
			; $iniLibrary = $tmp
			; _Fill_ListBox()

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
				MsgBox(0, $LngMsg1, "no data", 0, $hGui)
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
			_GUICtrlRichEdit_SetText($hRichEdit_SPE, $aTmpH[2])
			_SetFont_RE()
			If $ColorParcer Then _Pars()
			GUICtrlSetData($PtnRep, $aTmpH[3])
			If GUICtrlRead($NPt) = 4 Then GUICtrlSetData($Pattern, $tmp)
			; If $Tmp<>'' Then GUICtrlSetData($Pattern, $Tmp)
			$tmp = ''
			$aTmpH = ''

		Case $Exc
			$RegExp0 = _GUICtrlRichEdit_GetText($hRichEdit_SPE)
			$PtnRep0 = GUICtrlRead($PtnRep)
			If GUICtrlRead($Exc) = 1 Then
				If $RegExp0 Then
					; если в выражении апостроф и кавычка или @ то обрамление вручную (возможно смешанный вариант)
					If StringInStr($RegExp0, '"') And StringInStr($RegExp0, "'") Or StringInStr($RegExp0, '@') Then
						MsgBox(0, $LngMsg1, $LngMsg8, 0, $hGui)
					Else
						$Tmp1 = StringLeft($RegExp0, 1)
						$Tmp2 = StringRight($RegExp0, 1)
						; если нет ни апострофа ни кавычки
						If Not (StringInStr($RegExp0, "'") Or StringInStr($RegExp0, '"')) Then
							_GUICtrlRichEdit_SetText($hRichEdit_SPE, "'" & $RegExp0 & "'") ; то обрамляем апострофом
							_SetFont_RE()
							; если нет обрамляющих символов, но сэмпл содержит кавычки, то
						ElseIf StringInStr($RegExp0, '"') And Not (StringInStr('|""|''''|', '|' & $Tmp1 & $Tmp2 & '|')) Then
							_GUICtrlRichEdit_SetText($hRichEdit_SPE, "'" & $RegExp0 & "'") ; то обрамляем апострофом
							_SetFont_RE()
							; если нет обрамляющих символов, но сэмпл содержит апострофы, то
						ElseIf StringInStr($RegExp0, "'") And Not (StringInStr('|""|''''|', '|' & $Tmp1 & $Tmp2 & '|')) Then
							_GUICtrlRichEdit_SetText($hRichEdit_SPE, '"' & $RegExp0 & '"') ; то обрамляем кавычками
							_SetFont_RE()
						EndIf
					EndIf
				EndIf

				If $PtnRep0 Then
					If StringInStr($PtnRep0, '"') And StringInStr($PtnRep0, "'") Or StringInStr($PtnRep0, '@') Then
						MsgBox(0, $LngMsg1, $LngMsg9, 0, $hGui)
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
					If StringLeft($RegExp0, 1) = $tmp And StringInStr('"''', $tmp) Then
						_GUICtrlRichEdit_SetText($hRichEdit_SPE, StringRegExpReplace($RegExp0, '^.(.*).$', '\1'))
						_SetFont_RE()
					EndIf
					If $ColorParcer Then _Pars()
				EndIf
				If $PtnRep0 Then
					$tmp = StringRight($PtnRep0, 1)
					If StringLeft($PtnRep0, 1) = $tmp And StringInStr('"''', $tmp) Then GUICtrlSetData($PtnRep, StringRegExpReplace($PtnRep0, '^.(.*).$', '\1'))
				EndIf
			EndIf

		Case $Copy
			$RegExp0 = _GUICtrlRichEdit_GetText($hRichEdit_SPE)
			$PtnRep0 = GUICtrlRead($PtnRep)
			$R3T0 = Number(GUICtrlRead($R3T))
			$aSC = StringRegExp($iniSampleCopy, '^(.*?)<FUNC>(.*?)\h*<SEARCH>\h*(.*?)\h*<REPLACE>\h*(.*?)$', 3)
			If UBound($aSC) <> 4 Then
				$aSC = StringRegExp($SampleCopy, '^(.*?)<FUNC>(.*?)\h*<SEARCH>\h*(.*?)\h*<REPLACE>\h*(.*?)$', 3)
				IniWrite($SetIni, 'Set', 'SampleCopy', $SampleCopy)
			EndIf
			; защита
			If $RegExp0 = '' Then
				MsgBox(0, $LngMsg1, $LngMsg3, 0, $hGui)
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
			$RegExp0 = _GUICtrlRichEdit_GetText($hRichEdit_SPE)
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
				MsgBox(0, $LngMsg1, $LngMsg3, 0, $hGui)
				ContinueLoop
			EndIf
			If $Pattern0 = '' Then
				MsgBox(0, $LngMsg1, $LngMsg4, 0, $hGui)
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
					_SetColor_SPE($RedColor)
					GUICtrlSetData($LRes, $LngRRS & '   -   Ctrl+Enter')
					$tr1 = 1
					_WinAPI_SetFocus($hRichEdit_SPE)
					_GUICtrlRichEdit_SetSel($hRichEdit_SPE, $kol - 1, $kol)
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
					_SetColor_SPE($RedColor)
					GUICtrlSetData($LRes, $LngRRS & '   -   Ctrl+Enter')
					$tr1 = 1
					_WinAPI_SetFocus($hRichEdit_SPE)
					_GUICtrlRichEdit_SetSel($hRichEdit_SPE, $kol - 1, $kol)
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
					_SetColor_SPE($RedColor)
					GUICtrlSetData($LRes, $LngRRS & '   -   Ctrl+Enter')
					$tr1 = 1
					_WinAPI_SetFocus($hRichEdit_SPE)
					_GUICtrlRichEdit_SetSel($hRichEdit_SPE, $kol - 1, $kol)
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
			If Not ($RegExp00 == $RegExp0tmp) Then ; если рег.выр. изменился, то обновляем список
				_Insert_To_List($RegExp00, $iniRExList)
				$RegExp0tmp = $RegExp00
			EndIf
			$nTimer0 = $vTimer
			GUICtrlSetState($Result, $GUI_FOCUS)

		Case $iCombo
			If $iniRExList Then
				$ContMenu = GUICtrlCreateContextMenu($iCombo)
				$a_iniList = StringSplit($iniRExList, $sep)
				; If Not @error Then
				ReDim $iMenuItem[$a_iniList[0] + 1]
				$iMenuItem[0] = $a_iniList[0]
				For $i = 1 To $a_iniList[0]
					If StringLen($a_iniList[$i]) > 99 Then
						$iMenuItem[$i] = GUICtrlCreateMenuItem(StringLeft($a_iniList[$i], 96) & '...', $ContMenu) ; проблема длинных регулярок
					Else
						$iMenuItem[$i] = GUICtrlCreateMenuItem($a_iniList[$i], $ContMenu) ; эта строка в цикле создаёт задержку 220 мсек
					EndIf
				Next

				$aPos = ControlGetPos($hGui, "", $iCombo)
				Local $tpoint = DllStructCreate("int X;int Y")
				DllStructSetData($tpoint, "X", $aPos[0] + $aPos[2])
				DllStructSetData($tpoint, "Y", $aPos[1] + $aPos[3])
				_WinAPI_ClientToScreen($hGui, $tpoint)
				_GUICtrlMenu_TrackPopupMenu(GUICtrlGetHandle($ContMenu), $hGui, DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y"), 2)
			EndIf
			GUICtrlDelete($ContMenu)

		Case $iPatternM
			$aPos = ControlGetPos($hGui, "", $iPatternM)
			Local $tpoint = DllStructCreate("int X;int Y")
			DllStructSetData($tpoint, "X", $aPos[0] + $aPos[2])
			DllStructSetData($tpoint, "Y", $aPos[1] + $aPos[3])
			_WinAPI_ClientToScreen($hGui, $tpoint)
			_GUICtrlMenu_TrackPopupMenu($hPatternM, $hGui, DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y"), 2)

		Case $btnLibrary
			$aPos = ControlGetPos($hGui, "", $btnLibrary)
			Local $tpoint = DllStructCreate("int X;int Y")
			DllStructSetData($tpoint, "X", $aPos[0] + $aPos[2])
			DllStructSetData($tpoint, "Y", $aPos[1] + $aPos[3])
			_WinAPI_ClientToScreen($hGui, $tpoint)
			_GUICtrlMenu_TrackPopupMenu($hLibraryM, $hGui, DllStructGetData($tpoint, "X"), DllStructGetData($tpoint, "Y"), 2)

		Case $Helphtm
			If FileExists(@ScriptDir & '\RegExpHelp.hta') Then
				ShellExecute(@ScriptDir & '\RegExpHelp.hta')
			Else
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
	If $tr1 And $Msg = $GUI_EVENT_PRIMARYDOWN Then
		If $ColorParcer Then _Pars()
		$tr1 = 0
	EndIf
WEnd

Func _GetMenuLibrary($hLibraryM)
	$MenuLibraryID = _FileListToArray(@ScriptDir & '\Library', '*.ini', 1)
	If @error Then
		ReDim $MenuLibraryID[1]
		$MenuLibraryID[0] = 0
		Return SetError(1, 0, 0)
	EndIf
	
	Local $ContMenu = GUICtrlCreateContextMenu($hLibraryM)

	For $i = 1 To $MenuLibraryID[0]
		$MenuLibraryID[$i] = GUICtrlCreateMenuItem(StringTrimRight($MenuLibraryID[$i], 4), $ContMenu)
	Next
	Return SetError(Not $MenuLibraryID[0], $MenuLibraryID[0], GUICtrlGetHandle($ContMenu))
EndFunc   ;==>_GetMenuLibrary

Func _GetMenuPattern($iPatternM)
	Local $IniMenuPath = @ScriptDir & '\Menu.ini'
	If Not FileExists($IniMenuPath) Then _CreateMenuINI($IniMenuPath)
	Local $IniMenuRoot = IniReadSectionNames($IniMenuPath)
	If @error Then Return SetError(1, 0, 0)
	Local $ContMenu = GUICtrlCreateContextMenu($iPatternM)
	Local $aRootID[$IniMenuRoot[0] + 1]
	For $i = 1 To $IniMenuRoot[0]
		; создаём корневое меню / директории. Заранее, чтобы ID пунктов были попорядку
		; секция Root в исключении. Если такие существуют то будут добавлены в корень
		If $IniMenuRoot[$i] <> 'Root' Then $aRootID[$i] = GUICtrlCreateMenu($IniMenuRoot[$i], $ContMenu)
	Next

	For $i = 1 To $IniMenuRoot[0]
		If $IniMenuRoot[$i] = 'Root' Then ; если секция Root, то добавляем пункты в корень меню
			$tmp = $ContMenu
		Else
			$tmp = $aRootID[$i]
		EndIf
		$aKeyVal = IniReadSection($IniMenuPath, $IniMenuRoot[$i])
		If Not @error And $aKeyVal[0][0] <> 0 Then
			ReDim $MenuPatternID[$MenuPatternID[0] + $aKeyVal[0][0] + 1] ; увеличение масива ID по количеству ключей в секции
			For $j = 1 To $aKeyVal[0][0]
				$MenuPatternID[$MenuPatternID[0] + $j] = GUICtrlCreateMenuItem($aKeyVal[$j][1], $tmp)
			Next
			$MenuPatternID[0] = UBound($MenuPatternID) - 1
		EndIf
	Next
	Return SetError(Not $MenuPatternID[0], $MenuPatternID[0], GUICtrlGetHandle($ContMenu))
EndFunc   ;==>_GetMenuPattern

Func _SetColor_SPE($iColor)
	_Clear()
	_GUICtrlRichEdit_PauseRedraw($hRichEdit_SPE)
	_GUICtrlRichEdit_SetSel($hRichEdit_SPE, 0, -1)
	; _GUICtrlRichEdit_SetCharColor($hRichEdit_SPE, $iColor)
	_GUICtrlRichEdit_SetCharColor($hRichEdit_SPE, _RGB_BGR($iColor))
	_GUICtrlRichEdit_Deselect($hRichEdit_SPE)
	_GUICtrlRichEdit_ResumeRedraw($hRichEdit_SPE)
EndFunc   ;==>_SetColor_SPE

Func _Insert_To_List($item, ByRef $iniList)
	$iniList = StringReplace($sep & $iniList & $sep, $sep & $item & $sep, $sep)
	If $iniList = $sep & $sep Then $iniList = $sep
	$iniList = $item & StringTrimRight($iniList, 1)
	Local $tmp = StringInStr($iniList, $sep, 0, $KolStr)
	If $tmp Then $iniList = StringLeft($iniList, $tmp - 1)
EndFunc   ;==>_Insert_To_List

; Func WM_MENUSELECT($hWnd, $Msg, $wParam, $lParam)
; Local $ID = BitAND($wParam, 0xFFFF) ; _WinAPI_LoWord
; Local $Flags = BitShift($wParam, 16) ; _WinAPI_HiWord

; GUICtrlSetData($statist, _
; 'Дескриптор = ' & $lParam & @CRLF & _
; 'ID = ' & $ID)
; EndFunc

Func WM_COMMAND($hWnd, $Msg, $wParam, $lParam)
	Local $iID = BitAND($wParam, 0x0000FFFF)
	If $iMenuItem[0] Then
		Switch $iID
			Case $iMenuItem[1] To $iMenuItem[$iMenuItem[0]]
				_GUICtrlRichEdit_SetText($hRichEdit_SPE, $a_iniList[$iID - $iMenuItem[1] + 1])
				_SetFont_RE()
				If $ColorParcer Then _Pars()
				Return $GUI_RUNDEFMSG
		EndSwitch
	EndIf
	If $MenuPatternID[0] Then
		Switch $iID
			Case $MenuPatternID[1] To $MenuPatternID[$MenuPatternID[0]]
				Local $sText = GUICtrlRead($iID, 1)
				Local $iStart = _GUICtrlRichEdit_GetSel($hRichEdit_SPE)
				$iStart = $iStart[0] + StringLen($sText)
				_GUICtrlRichEdit_InsertText($hRichEdit_SPE, $sText)
				_SetFont_RE()
				If $ColorParcer Then _Pars()
				_GUICtrlRichEdit_GotoCharPos($hRichEdit_SPE, $iStart)
				Return $GUI_RUNDEFMSG
		EndSwitch
	EndIf
	If $MenuLibraryID[0] Then
		Switch $iID
			Case $MenuLibraryID[1] To $MenuLibraryID[$MenuLibraryID[0]]
				Local $sName = GUICtrlRead($iID, 1)
				Local $sPath = @ScriptDir & '\Library\' & $sName & '.ini'
				If FileExists($sPath) Then
					$iniLibrary = $sPath
					_Fill_ListBox()
				EndIf
				Return $GUI_RUNDEFMSG
		EndSwitch
	EndIf
EndFunc   ;==>WM_COMMAND

Func _TestRange()
	Local $GP, $Combo, $Update, $StatusBar, $s, $aWA = _WinAPI_GetWorkingArea()
	Local $sPat = _GUICtrlRichEdit_GetText($hRichEdit_SPE)
	If Not $sPat Then $sPat = '..'

	$GP = _GetChildCoor($hGui, 320, $aWA[3] - $aWA[1] - 40)
	GUISetState(@SW_DISABLE, $hGui)

	$GUI1 = GUICreate($sPat, $GP[0], $GP[1], $GP[2], $GP[3], $WS_OVERLAPPEDWINDOW + $WS_POPUP, -1, $hGui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 1)
	$StatusBar = GUICtrlCreateLabel('Done', 5, $GP[1] - 20, 310, 17, $SS_LEFTNOWORDWRAP)

	$Combo = GUICtrlCreateCombo('', 5, 5, 280)
	GUICtrlSetData($Combo, $sPat & $sep & '\a' & $sep & '[\cA-\cZ]' & $sep & '\d' & $sep & '\D' & $sep & '\e' & $sep & '\f' & $sep & '\h' & $sep & '\H' & $sep & '\n' & $sep & '\N' & $sep & '\R' & $sep & '\s' & $sep & '\S' & $sep & '\t' & $sep & '\v' & $sep & '\V' & $sep & '\w' & $sep & '\W' & $sep & '[\x{01}-\x{0F}]' & $sep & '[\x01-\x0F]' & $sep & '[\001-\010]' & $sep & '[[:alnum:]]' & $sep & '[[:alpha:]]' & $sep & '[[:ascii:]]' & $sep & '[[:blank:]]' & $sep & '[[:cntrl:]]' & $sep & '[[:digit:]]' & $sep & '[[:graph:]]' & $sep & '[[:lower:]]' & $sep & '[[:print:]]' & $sep & '[[:punct:]]' & $sep & '[[:space:]]' & $sep & '[[:upper:]]' & $sep & '[[:word:]]' & $sep & '[[:xdigit:]]', $sPat)
	$Update = GUICtrlCreateButton('>', 320 - 30, 5, 22, 22)

	$ListView = GUICtrlCreateListView('Symbol' & $sep & 'Yes' & $sep & 'No' & $sep & 'Hex' & $sep & 'Oct', 5, 30, $GP[0] - 10, $GP[1] - 55, -1, $LVS_EX_GRIDLINES + $LVS_EX_FULLROWSELECT + $WS_EX_CLIENTEDGE)
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
				GUISetState(@SW_ENABLE, $hGui)
				GUIDelete($GUI1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_TestRange

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
EndFunc   ;==>_UpdateListView

Func _Fill_ListBox()
	GUICtrlSendMsg($History, $LB_RESETCONTENT, 0, 0)
	Local $sText = FileRead($iniLibrary)
	Local $z = ''
	$aIniPtn = StringRegExp($sText, '(?s)z\]\r\n(.*?)(?=\r\n\[z)', 3)
	If Not @error Then
		For $i = 0 To UBound($aIniPtn) - 1
			If $i < 9 Then
				$z = '0' & $i + 1
			Else
				$z = $i + 1
			EndIf
			GUICtrlSetData($History, $z & '. ' & StringRegExpReplace($aIniPtn[$i], '(?s)(^.*?)(\r\n.*)$', '$1'))
		Next
		GUICtrlSetData($btnLibrary, StringRegExpReplace($iniLibrary, '^(?:.*\\)([^\\]*?)(?:\.[^.]+)?$', '\1')) ; $LngRHs&':'&
	Else
		$aIniPtn = ''
		Dim $aIniPtn[1]
	EndIf
EndFunc   ;==>_Fill_ListBox

Func _Exit()
	IniWrite($SetIni, 'Set', 'GroupL', GUICtrlRead($ChT))
	IniWrite($SetIni, 'Set', 'ComboREx', StringReplace($iniRExList, $sep, $iniSep))
	IniWrite($SetIni, 'Set', 'LastLibrary', StringRegExpReplace($iniLibrary, '^(?:.*\\)([^\\]*?)(?:\.[^.]+)?$', '\1'))

	; $iState = WinGetState($hGui)
	; Если окно не свёрнуто или не развёрнуто на весь экран, то получаем его координаты и размеры
	; If Not (BitAnd($iState, 16) Or BitAnd($iState, 32)) Then _Resized()
	$aWA = _WinAPI_GetWorkingArea()
	IniWrite($SetIni, 'Set', 'WinMax', $WHXY[4])
	IniWrite($SetIni, 'Set', 'W', $WHXY[0])
	IniWrite($SetIni, 'Set', 'H', $WHXY[1])
	IniWrite($SetIni, 'Set', 'X', $WHXY[2] - $aWA[0])
	IniWrite($SetIni, 'Set', 'Y', $WHXY[3] - $aWA[1])
EndFunc   ;==>_Exit

Func WM_EXITSIZEMOVE()
	$ClientSz = WinGetClientSize($hGui)
	$GuiPos = WinGetPos($hGui)
	$WHXY[0] = $ClientSz[0]
	$WHXY[1] = $ClientSz[1]
	$WHXY[2] = $GuiPos[0]
	$WHXY[3] = $GuiPos[1]
	_SetSizePos($ClientSz[0], $ClientSz[1])
EndFunc   ;==>WM_EXITSIZEMOVE

Func WM_SIZE($hWnd, $Msg, $wParam, $lParam)
	#forceref $Msg, $wParam
	Local $w, $h
	If $hWnd = $hGui Then
		$w = BitAND($lParam, 0xFFFF) ; _WinAPI_LoWord
		$h = BitShift($lParam, 16) ; _WinAPI_HiWord
		_SetSizePos($w, $h)
	EndIf

	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE

Func _SetSizePos($w, $h)
	$w = $w - 200
	$h = ($h - 130) / 2
	GUICtrlSetPos($Pattern, 10, 104, $w, $h)
	GUICtrlSetPos($Result, 10, $h + 120, $w, $h)
	GUICtrlSetPos($LRes, 10, $h + 105)
	; GUICtrlSetPos($iCombo, $w - 11, 24)
	_WinAPI_MoveWindow($hRichEdit_SPE, 10, 24, $w - 25, 22)
EndFunc   ;==>_SetSizePos

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	Switch $hWnd
		Case $hGui
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
EndFunc   ;==>WM_GETMINMAXINFO

Func WM_NOTIFY($hWnd, $iMsg, $iWparam, $iLparam)
	Local $hWndFrom, $iCode, $tNMHDR, $tMsgFilter, $iMsg2
	$tNMHDR = DllStructCreate($tagNMHDR, $iLparam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	; $iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hRichEdit_SPE
			$tMsgFilter = DllStructCreate($tagEN_MSGFILTER2, $iLparam)
			$iMsg2 = DllStructGetData($tMsgFilter, "msg")
			Switch $iMsg2
				Case $WM_KEYUP
					; ConsoleWrite("msg=" & DllStructGetData($tMsgFilter, "msg") & ', Code' & $iMsg & @CRLF)
					If $ColorParcer Then _Pars()
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _Pars()
	$iStart = _GUICtrlRichEdit_GetSel($hRichEdit_SPE)
	$iStart = $iStart[0]
	$sTextRE = _GUICtrlRichEdit_GetText($hRichEdit_SPE) ; извлекаем текст для анализа
	$sTextRE = StringReplace($sTextRE, '\\', '  ')
	_Clear()
	_SearchGroups($sTextRE) ; (...)
	_SearchClass($sTextRE) ; [...]
	_Special_Character($sTextRE) ; \w
	_Search_Borders($sTextRE) ; \A, \z, \b - границы
	_Special_Character2($sTextRE) ; .*? - повтор любого символа
	_SearchRepeat($sTextRE) ; {2,3} - повторы
	_Search_CodeCharacter($sTextRE) ; \x{..} - код символа
	_SearchClass2($sTextRE) ; [:alnum:]
	_GUICtrlRichEdit_GotoCharPos($hRichEdit_SPE, $iStart)
EndFunc   ;==>_Pars

Func _SearchGroups(ByRef $sTextRE)
	Local $iSample, $iOffset = 1, $TrClr0 = 0, $TrClr = 0, $iPos1, $iPos2 = -5
	Do
		$iOffset = 1
		Do
			$iSample = StringRegExp($sTextRE, '(?<!\\)(\((?:\?[smixJU-]+:?|\?[:=!]|\?<[=!])?)([^()]*?(?<!\\|\()\))', 2, $iOffset)
			If @error Then
				ExitLoop
			Else
				$iOffset = @extended
				$iPos1 = $iOffset - StringLen($iSample[0]) - 1
				If $iPos2 = $iPos1 Then
					$TrClr = Number(Not $TrClr)
				Else
					$TrClr = $TrClr0
				EndIf
				$iPos2 = $iOffset - 1
				_SetColor2($iPos1, $iPos1 + StringLen($iSample[1]), $iColorTheme[1][$TrClr])
				_SetColor2($iOffset - 2, $iPos2, $iColorTheme[1][$TrClr])
				$sTextRE = StringReplace($sTextRE, $iPos1 + 1, ' ') ; удаление скобок, чтобы на втором поиске найти не вложенные группы
				$sTextRE = StringReplace($sTextRE, $iOffset - 1, ' ')
			EndIf
		Until 0
		$TrClr0 = Number(Not $TrClr0)
		; $TrClr = $TrClr0
	Until $iOffset = 1
EndFunc   ;==>_SearchGroups

; Func _SearchRepeat($sTextRE) ; отсутствует второй цвет, так как повтор не может примыкать к повтору
	; Local $iSample, $iOffset = 1
	; Do
		; $iSample = StringRegExp($sTextRE, '(?<!\\)(\{)([\d,]+\})', 2, $iOffset) ; |\\x
		; If @error Then
			; ExitLoop
		; Else
			; $iOffset = @extended
			; _SetColor2($iOffset - StringLen($iSample[0]) - 1, $iOffset - StringLen($iSample[0]) + StringLen($iSample[1]) - 1, $iColorTheme[5][0])
			; _SetColor2($iOffset - 2, $iOffset - 1, $iColorTheme[5][0])
		; EndIf
	; Until 0
; EndFunc   ;==>_SearchRepeat

Func _SearchRepeat($sTextRE) ; отсутствует второй цвет, так как повтор не может примыкать к повтору
	Local $iSample, $iOffset = 1
	Do
		$iSample = StringRegExp($sTextRE, '(?<!\\)(\{[\d,]+\})', 2, $iOffset) ; |\\x
		If @error Then
			ExitLoop
		Else
			$iOffset = @extended
			_SetColor2($iOffset - 1, $iOffset - StringLen($iSample[0]) - 1, $iColorTheme[5][0])
		EndIf
	Until 0
EndFunc   ;==>_SearchRepeat

Func _Special_Character2($sTextRE) ; отсутствует второй цвет, так как этот набор не может примыкать к такому же набору
	Local $iSample, $iOffset = 1
	Do
		$iSample = StringRegExp($sTextRE, '(?<!\\)(\.[*+]\??)', 1, $iOffset)
		If @error Then
			ExitLoop
		Else
			$iOffset = @extended
			_SetColor2($iOffset - StringLen($iSample[0]) - 1, $iOffset - 1, $iColorTheme[4][0])
		EndIf
	Until 0
EndFunc   ;==>_Special_Character2

Func _Special_Character($sTextRE)
	Local $iSample, $iOffset = 1, $TrClr = 0, $iPos1, $iPos2 = -5
	Do
		$iSample = StringRegExp($sTextRE, '(?<!\\)\\[fhrntvdswFHRNVDSW][*+]?\??', 1, $iOffset)
		If @error Then
			ExitLoop
		Else
			$iOffset = @extended
			$iPos1 = $iOffset - StringLen($iSample[0]) - 1
			If $iPos2 = $iPos1 Then
				$TrClr = Number(Not $TrClr)
			Else
				$TrClr = 0
			EndIf
			$iPos2 = $iOffset - 1
			_SetColor2($iPos1, $iPos2, $iColorTheme[3][$TrClr])
		EndIf
	Until 0
EndFunc   ;==>_Special_Character

Func _Search_Borders($sTextRE)
	Local $iSample, $iOffset = 1
	Do
		; $iSample=StringRegExp($sTextRE, '\\[ABbZzQE][*+]?\??', 1, $iOffset)
		$iSample = StringRegExp($sTextRE, '((?<!\\)\\[ABbZzQE]|(?<![\[\\^])[$^|])', 1, $iOffset)
		If @error Then
			ExitLoop
		Else
			$iOffset = @extended
			_SetColor2($iOffset - StringLen($iSample[0]) - 1, $iOffset - 1, $iColorTheme[6][0])
		EndIf
	Until 0
EndFunc   ;==>_Search_Borders

Func _Search_CodeCharacter($sTextRE)
	Local $iSample, $iOffset = 1
	Do
		$iSample = StringRegExp($sTextRE, '\\(x\d\d|x\{[0-9A-Fa-f]{2}(?:[0-9A-Fa-f]{2})?\}|\d{3})[*+]?\??', 1, $iOffset)
		If @error Then
			ExitLoop
		Else
			$iOffset = @extended
			_SetColor2($iOffset - StringLen($iSample[0]) - 2, $iOffset - 1, $iColorTheme[7][0])
		EndIf
	Until 0
EndFunc   ;==>_Search_CodeCharacter

Func _SearchClass2($sTextRE)
	Local $iSample, $iOffset = 1
	Do
		$iSample = StringRegExp($sTextRE, '(\[:\^?(alnum|alpha|ascii|blank|cntrl|digit|graph|lower|print|punct|space|upper|word|xdigit):\])', 1, $iOffset)
		If @error Then
			ExitLoop
		Else
			$iOffset = @extended
			_SetColor2($iOffset - StringLen($iSample[0]) - 1, $iOffset - 1, $iColorTheme[5][0])
		EndIf
	Until 0
EndFunc   ;==>_SearchClass2

Func _SearchClass($sTextRE)
	Local $iSample, $iOffset = 1, $TrClr = 0, $iPos1, $iPos2 = -5
	Do
		$iSample = StringRegExp($sTextRE, '(?<!\\)(\[\^|\[)(.*?[^\\:]\])', 2, $iOffset) ; добавил : чтобы  [:alnum:] не портил картину
		; $iSample=StringRegExp($sTextRE, '(?<!\\)(\((?:\?[smixJU-]+:?|\?[:=!]|\?<[=!])?)([^()]*?\))', 2, $iOffset)
		If @error Then
			ExitLoop
		Else
			$iOffset = @extended
			$iPos1 = $iOffset - StringLen($iSample[0]) - 1
			If $iPos2 = $iPos1 Then
				$TrClr = Number(Not $TrClr)
			Else
				$TrClr = 0
			EndIf
			$iPos2 = $iOffset - 1
			_SetColor2($iPos1, $iPos1 + StringLen($iSample[1]), $iColorTheme[2][$TrClr])
			_SetColor2($iOffset - 2, $iPos2, $iColorTheme[2][$TrClr])
		EndIf
	Until 0
EndFunc   ;==>_SearchClass

Func _SetColor2($iPos1, $iPos2, $iColor)
	_GUICtrlRichEdit_PauseRedraw($hRichEdit_SPE)
	; _GuiCtrlRichEdit_SetSel($hRichEdit_SPE, $iPos, $iPos+1, True)
	_GUICtrlRichEdit_SetSel($hRichEdit_SPE, $iPos1, $iPos2)
	; _GUICtrlRichEdit_SetCharColor($hRichEdit_SPE, $iColor)
	_GUICtrlRichEdit_SetCharBkColor($hRichEdit_SPE, $iColor)
	_GUICtrlRichEdit_Deselect($hRichEdit_SPE)
	_GUICtrlRichEdit_ResumeRedraw($hRichEdit_SPE)
EndFunc   ;==>_SetColor2

Func _Clear()
	_GUICtrlRichEdit_PauseRedraw($hRichEdit_SPE)
	_GUICtrlRichEdit_SetSel($hRichEdit_SPE, 0, -1)
	_GUICtrlRichEdit_SetCharBkColor($hRichEdit_SPE, $BkColorRE)
	_GUICtrlRichEdit_SetCharColor($hRichEdit_SPE, $ColorRE)
	_GUICtrlRichEdit_Deselect($hRichEdit_SPE)
	_GUICtrlRichEdit_ResumeRedraw($hRichEdit_SPE)
EndFunc   ;==>_Clear

Func _CreateMenuINI($IniMenuPath)
	$1 = ''
	$2 = 'Num'
	If @OSLang = 0419 Then
		$1 = '4=[А-яЁё]' & @CRLF
		$2 = 'Числа'
	EndIf
	Local $sText = _
			'[Root]' & @CRLF & _
			'1=.*?' & @CRLF & _
			'2=\r\n' & @CRLF & _
			'3=\r?$' & @CRLF & _
			$1 & _
			'5=[^]' & @CRLF & _
			@CRLF & _
			'[(?...)]' & @CRLF & _
			'1=(?:)' & @CRLF & _
			'2=(?smi)' & @CRLF & _
			'3=(?=)' & @CRLF & _
			'4=(?!)' & @CRLF & _
			'5=(?<=)' & @CRLF & _
			'6=(?<!)' & @CRLF & _
			@CRLF & _
			'[\meta]' & @CRLF & _
			'1=\h' & @CRLF & _
			'2=\w' & @CRLF & _
			'3=\s' & @CRLF & _
			'4=\z' & @CRLF & _
			'5=\A' & @CRLF & _
			'6=\b' & @CRLF & _
			'7=\Q\E' & @CRLF & _
			@CRLF & _
			'[' & $2 & ']' & @CRLF & _
			'1=\x{01}' & @CRLF & _
			'2=\x41' & @CRLF & _
			'3=\120' & @CRLF & _
			'4=[\dA-Fa-f]' & @CRLF & _
			@CRLF & _
			'[posix]' & @CRLF & _
			'01=[:alnum:]' & @CRLF & _
			'02=[:alpha:]' & @CRLF & _
			'03=[:ascii:]' & @CRLF & _
			'04=[:blank:]' & @CRLF & _
			'05=[:cntrl:]' & @CRLF & _
			'06=[:digit:]' & @CRLF & _
			'07=[:graph:]' & @CRLF & _
			'08=[:lower:]' & @CRLF & _
			'09=[:print:]' & @CRLF & _
			'10=[:punct:]' & @CRLF & _
			'11=[:space:]' & @CRLF & _
			'12=[:upper:]' & @CRLF & _
			'13=[:word:]' & @CRLF & _
			'14=[:xdigit:]'
	Local $hFile = FileOpen($IniMenuPath, 2)
	FileWrite($hFile, $sText)
	FileClose($hFile)
EndFunc   ;==>_CreateMenuINI

Func _CreateSampleINI()
	$hFile = FileOpen($iniLibrary, 2)
	FileWrite($hFile, _
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
			'(?:(?:2(?:[0-4][\d|5[0-5])|[0-1]?\d{1,2})\.){3}(?:(?:2(?:[0-4]\d|5[0-5])|[0-1]?\d{1,2}))' & @CRLF & _
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
			'(?:https?://)?(?:www\.)?([\w.]+)(?:.*)' & @CRLF & _
			'\1' & @CRLF & _
			'2' & @CRLF & _
			'http://www.autoitscript.com/forum/index.php?showtopic=118648' & @CRLF & _
			'[z--z]' & @CRLF & _
			$LngIni8 & @CRLF & _
			'(?si)(?:.*?)?(https?://[\w.:]+/?(?:[\w/?&=.~;\-+!*_#%])*)' & @CRLF & _
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
	FileClose($hFile)
EndFunc   ;==>_CreateSampleINI

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
	$GP = _GetChildCoor($hGui, $wAbt, $hAbt)
	GUISetState(@SW_DISABLE, $hGui)
	$font = "Arial"
	$GUI1 = GUICreate($LngAbout, $GP[0], $GP[1], $GP[2], $GP[3], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $hGui)
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
	GUICtrlCreateLabel($LngVer & ' 1.0.2   23.06.2013', $wA, $wB - 30, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', $wA, $wB - 15, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', $wA + 37, $wB - 15, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', $wA, $wB, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', $wA + 75, $wB, 125, 17)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010-2013', $wA, $wB + 15, 210, 17)

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
				GUISetState(@SW_ENABLE, $hGui)
				GUIDelete($GUI1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_About

Func _ScrollAbtText()
	$iScroll_Pos += 1
	ControlMove($GUI1, "", $nLAbt, $wAbtBt, -$iScroll_Pos)
	If $iScroll_Pos > 360 Then $iScroll_Pos = -$hAbt
EndFunc   ;==>_ScrollAbtText