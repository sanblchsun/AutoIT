#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Create_list_files.exe
#AutoIt3Wrapper_Icon=Create_list_files.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Create_list_files.exe
#AutoIt3Wrapper_Res_Fileversion=0.6.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.6
#AutoIt3Wrapper_Res_Field=Build|2012.09.30
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
; #Obfuscator_Parameters=/SOI
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#Obfuscator_Ignore_Variables=$LngTitle,$LngAbout,$LngVer,$LngSite,$LngCopy,$LngaDisk,$LngaFPth,$LngaRPth,$LngaNmFile,$LngaFileEx,$LngaSzFile,$LngaAtrF,$LngaChDt,$LngaCrDt,$LngaOpDt,$LngaAgFile,$LngaAgFileS, $LngaAgCrFile, $LngaAgCrFileS,$LngaAgOpFile,$LngaAgOpFileS,$LngaMD5,$LngaSHA1,$LngaLNm,$LngaLPt,$LngLvSub,$LngMs1,$LngMs2,$LngMs3,$LngiTxt,$LngSBr1,$LngSFd,$LngFLst,$LngFType,$LngLnSub,$LngInclH,$LngFSrt,$LngSrtD,$LngAvEL,$LngRsLine,$LngCln,$LngsRightH,$LngsLeftH,$LngsUpH,$LngsDwnH,$LngbSrt,$LngCEsc,$LngbSet,$LngMs4,$LngMs5,$LngMs6,$LngMs7,$LngMs8,$LngReSt,$LngAdLn,$LngAdLnH,$LngSep,$LngFmDt,$LngcTmpl,$LngbSv,$LngbSvH,$LngBx1,$LngBx2,$LngOpen,$LngOAll,$LngOLst,$LngSBr2,$LngSBr3,$LngSBr5,$LngSBr6,$LngSBr7,$LngSBr8,$LngSBr9,$LngSBr10,$LngSBr11,$LngSBr12,$LngSBr13,$LngSBr14,$LngSBr15,$Lngskb,$LngsMb,$LngsGb,$LngCntM,$LngMFile,$LngAuLEd,$LngAsTXT,$LngOthPr,$LngARnd,$LngReg,$LngVLF,$LngLst,$LngLF1,$LngLF2
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2012.09.30 AutoIt3_v3.3.6.1
#NoTrayIcon
#include <GuiConstantsEx.au3>
#include <GuiListView.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>
#include <Crypt.au3>
#include <File.au3>
#include <Date.au3>
#include <FileOperations.au3>
#include <StaticConstants.au3>
#include <GuiTreeView.au3>

Opt("GUIOnEventMode", 1)
Opt("GUIResizeMode", 802)

Global Const $GMKConst = (1024 / 1000 - 1) / 1024

Global $hListView, $hListView2, $Gui, $Gui1, $length, $XYPos[4], $Tr7 = 0, $TrSort = 0, $Xpos, $Ypos, $ComboDate0, $DT[6], $a, $stat = 0, $trHash = 0, $trStop = 0, $ini = @ScriptDir & '\Create_list_files.ini'
Global $iniLimit, $InpLimit, $ChReg, $StatusBar1, $TrAV, $TrGMK, $Editor, $EditorTmp, $RdTxt, $RdMy, $InpMy, $ChOpenList, $ChGbMbKb, $ComboLang, $L21, $LangPath, $TrInc
$iniFileEx = '*|avi;mpg;vob;wmv;mkv;mp4|mov;asf;asx;3gp;flv;bik|mp3;wav;wma;ogg;ac3|bak;gid;log;tmp|htm;html;css;js;php|bmp;gif;jpg;jpeg;png;tif;tiff|exe;msi;scr;dll;cpl;ax|com;sys;bat;cmd'
$iniSep = '-Tab-||'

Global $fDrag = False, $iOld, $sOld
Global $hImage

Switch @OSVersion
	Case 'WIN_VISTA', 'WIN_7'
		$Tr7 = 1
EndSwitch

If Not FileExists($ini) Then
	$file = FileOpen($ini, 2)
	FileWrite($file, '[Set]' & @CRLF & _
			'LastFolder=' & @CRLF & _
			'LastFileList=' & @CRLF & _
			'LevelFld=125' & @CRLF & _
			'LastType=*' & @CRLF & _
			'FileEx=' & $iniFileEx & @CRLF & _
			'Include=0' & @CRLF & _
			'Text="   ---   "' & @CRLF & _
			'Sep=' & $iniSep & @CRLF & _
			'ChSort=1' & @CRLF & _
			'CmSort=' & @CRLF & _
			'Limit=20000' & @CRLF & _
			'TrAV=1' & @CRLF & _
			'TrGMK=1' & @CRLF & _
			'Editor=' & @CRLF & _
			'Lang=' & @CRLF & _
			'W=490' & @CRLF & _
			'H=420' & @CRLF & _
			'X=' & @CRLF & _
			'Y=')
	FileClose($file)
EndIf

; En
Global $aLng0[94][2] = [[ _
		93, 93],[ _
		'Title', 'Create list of files'],[ _
		'About', 'About'],[ _
		'Ver', 'Version'],[ _
		'Site', 'Site'],[ _
		'Copy', 'Copy'],[ _
		'aDisk', 'Disk'],[ _
		'aFPth', 'Full path'],[ _
		'aRPth', 'Relative path'],[ _
		'aNmFile', 'Filename'],[ _
		'aFileEx', 'File extension'],[ _
		'aSzFile', 'File size'],[ _
		'aAtrF', 'Attribute'],[ _
		'aChDt', 'Date modified'],[ _
		'aCrDt', 'Date created'],[ _
		'aOpDt', 'Date of access'],[ _
		'aAgFile', 'Age modified'],[ _
		'aAgFileS', 'Age modified in sec'],[ _
		'aAgCrFile', 'Age of creating'],[ _
		'aAgCrFileS', 'Age creation in sec'],[ _
		'aAgOpFile', 'Age of access'],[ _
		'aAgOpFileS', 'Age of access in sec'],[ _
		'aMD5', 'MD5'],[ _
		'aSHA1', 'SHA1'],[ _
		'aLNm', 'Name length'],[ _
		'aLPt', 'Path length'],[ _
		'LvSub', 'Nesting level'],[ _
		'Ms1', 'Message'],[ _
		'Ms2', 'Folder does not exist or is not a directory'],[ _
		'Ms3', 'Supported by only one parameter, the path to the directory'],[ _
		'iTxt', 'Your text'],[ _
		'SBr1', 'Status bar'],[ _
		'SFd', 'Search folder:'],[ _
		'FLst', 'File list:'],[ _
		'FType', 'File types:'],[ _
		'LnSub', 'Nesting folders:'],[ _
		'InclH', 'Besides this type of file'],[ _
		'FSrt', 'Sorting:'],[ _
		'SrtD', 'Sort descending'],[ _
		'AvEL', 'Available items'],[ _
		'RsLine', 'Result is a string'],[ _
		'Cln', 'Clean'],[ _
		'sRightH', 'Copy right' & @CRLF & 'Double click or' & @CRLF & 'Ctrl+right Arrow'],[ _
		'sLeftH', 'Remove from the right box' & @CRLF & 'Double click or' & @CRLF & 'Ctrl+left Arrow' & @CRLF & 'Ctrl+Delete'],[ _
		'sUpH', 'Move up' & @CRLF & 'Ctrl+up Arrow'],[ _
		'sDwnH', 'Move down' & @CRLF & 'Ctrl+down Arrow'],[ _
		'bSrt', 'Start'],[ _
		'CEsc', 'Cancel Esc'],[ _
		'bSet', 'Setting'],[ _
		'Ms4', 'Moving within a selection list'],[ _
		'Ms5', 'Can not open file, or read-only or in the path illegal characters'],[ _
		'Ms6', 'List is empty'],[ _
		'Ms7', 'Do you want to continue processing'],[ _
		'Ms8', 'file'],[ _
		'ReSt', 'Restart utility'],[ _
		'AdLn', 'Add row'],[ _
		'AdLnH', 'Add a row to list'],[ _
		'Sep', 'Separator:'],[ _
		'FmDt', 'Date format:'],[ _
		'cTmpl', 'Template:'],[ _
		'bSv', 'Save'],[ _
		'bSvH', 'Save Template'],[ _
		'Bx1', 'Template'],[ _
		'Bx2', 'Enter the name of the template'],[ _
		'Open', 'Open'],[ _
		'OAll', 'All'],[ _
		'OLst', 'List'],[ _
		'SBr2', 'Running...'],[ _
		'SBr3', 'Operation is interrupted, the folder does not exist'],[ _
		'SBr5', 'Operation is interrupted, unable to open file'],[ _
		'SBr6', 'Operation is interrupted, the list is empty'],[ _
		'SBr7', 'Operation is interrupted, the folder is empty'],[ _
		'SBr8', 'Cancelled'],[ _
		'SBr9', 'List was created for'],[ _
		'SBr10', 'sec,'],[ _
		'SBr11', 'lines'],[ _
		'SBr12', 'Error importing'],[ _
		'SBr13', 'Successfully added to context menu'],[ _
		'SBr14', 'Successfully removed from the context menu'],[ _
		'SBr15', 'Failure to remove'],[ _
		'skb', 'kb'],[ _
		'sMb', 'Mb'],[ _
		'sGb', 'Gb'],[ _
		'CntM', 'Add to context menu'],[ _
		'MFile', 'Warn if number of files more than'],[ _
		'AuLEd', 'Automatically open a file list'],[ _
		'AsTXT', 'Program associated with the txt- files'],[ _
		'OthPr', 'In another program'],[ _
		'ARnd', 'Automatically rounded to the GB, MB, KB'],[ _
		'VLF', 'View a list'],[ _
		'Lst', 'List'],[ _
		'LF1', 'item'],[ _
		'LF2', 'sec'],[ _
		'Reg', 'Create a list of files']]

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	Dim $aLng0[94][2] = [[ _
			93, 93],[ _
			'Title', 'Создание списка файлов'],[ _
			'About', 'О программе'],[ _
			'Ver', 'Версия'],[ _
			'Site', 'Сайт'],[ _
			'Copy', 'Копировать'],[ _
			'aDisk', 'Диск'],[ _
			'aFPth', 'Полный путь'],[ _
			'aRPth', 'Относительный путь'],[ _
			'aNmFile', 'Имя файла'],[ _
			'aFileEx', 'Расширение файла'],[ _
			'aSzFile', 'Размер файла'],[ _
			'aAtrF', 'Атрибуты'],[ _
			'aChDt', 'Дата изменения'],[ _
			'aCrDt', 'Дата создания'],[ _
			'aOpDt', 'Дата открытия'],[ _
			'aAgFile', 'Возраст изменения'],[ _
			'aAgFileS', 'Возраст измен. в сек'],[ _
			'aAgCrFile', 'Возраст создания'],[ _
			'aAgCrFileS', 'Возраст созд. в сек'],[ _
			'aAgOpFile', 'Возраст открытия'],[ _
			'aAgOpFileS', 'Возраст откр. в сек'],[ _
			'aMD5', 'MD5'],[ _
			'aSHA1', 'SHA1'],[ _
			'aLNm', 'Длина имени'],[ _
			'aLPt', 'Длина пути'],[ _
			'LvSub', 'Уровень вложенности'],[ _
			'Ms1', 'Сообщение'],[ _
			'Ms2', 'Папка не существует или не является каталогом'],[ _
			'Ms3', 'Поддерживается только один параметр, путь к каталогу'],[ _
			'iTxt', 'Ваш текст'],[ _
			'SBr1', 'Строка состояния'],[ _
			'SFd', 'Папка поиска:'],[ _
			'FLst', 'Файл-список:'],[ _
			'FType', 'Типы файлов:'],[ _
			'LnSub', 'Глубина вложенности каталогов:'],[ _
			'InclH', 'Кроме указанного типа файлов'],[ _
			'FSrt', 'Сортировка:'],[ _
			'SrtD', 'Сортировка по убыванию'],[ _
			'AvEL', 'Доступные элементы'],[ _
			'RsLine', 'Результат получаемой строки'],[ _
			'Cln', 'Очистить'],[ _
			'sRightH', 'Копировать вправо' & @CRLF & 'Двойной клик или' & @CRLF & 'Ctrl+Стрелка вправо'],[ _
			'sLeftH', 'Удалить из правого списка' & @CRLF & 'Двойной клик или' & @CRLF & 'Ctrl+Стрелка влево' & @CRLF & 'Ctrl+Delete'],[ _
			'sUpH', 'Сдвинуть вверх' & @CRLF & 'Ctrl+Стрелка вверх'],[ _
			'sDwnH', 'Сдвинуть вниз' & @CRLF & 'Ctrl+Стрелка вниз'],[ _
			'bSrt', 'Старт'],[ _
			'CEsc', 'Отмена Esc'],[ _
			'bSet', 'Настройки'],[ _
			'Ms4', 'Перемещение одного выделенного в пределах списка'],[ _
			'Ms5', 'Невозможно открыть файл, либо неперезаписываемый носитель, либо в пути недопустимые символы'],[ _
			'Ms6', 'Список пустой'],[ _
			'Ms7', 'Вы хотите продолжить обработку'],[ _
			'Ms8', 'файлов'],[ _
			'ReSt', 'Перезапуск утилиты'],[ _
			'AdLn', 'Добавить строку'],[ _
			'AdLnH', 'Добавить строку в список'],[ _
			'Sep', 'Разделитель:'],[ _
			'FmDt', 'Формат даты:'],[ _
			'cTmpl', 'Шаблон:'],[ _
			'bSv', 'Сохранить'],[ _
			'bSvH', 'Сохранить шаблон'],[ _
			'Bx1', 'Шаблон'],[ _
			'Bx2', 'Введите имя шаблона'],[ _
			'Open', 'Открыть'],[ _
			'OAll', 'Все'],[ _
			'OLst', 'Список'],[ _
			'SBr2', 'Выполняется...'],[ _
			'SBr3', 'Операция прервана, папка не существует'],[ _
			'SBr5', 'Операция прервана, невозможно открыть файл'],[ _
			'SBr6', 'Операция прервана, список пустой'],[ _
			'SBr7', 'Операция прервана, папка пуста'],[ _
			'SBr8', 'Отменено'],[ _
			'SBr9', 'Список создан за'],[ _
			'SBr10', 'сек, всего'],[ _
			'SBr11', 'строк'],[ _
			'SBr12', 'Ошибка добавления'],[ _
			'SBr13', 'Добавлено в контекстного меню успешно'],[ _
			'SBr14', 'Удалено из контекстного меню успешно'],[ _
			'SBr15', 'Ошибка удаления'],[ _
			'skb', 'кб'],[ _
			'sMb', 'Мб'],[ _
			'sGb', 'Гб'],[ _
			'CntM', 'Добавить в контекстное меню'],[ _
			'MFile', 'Предупреждение, если файлов более'],[ _
			'AuLEd', 'Автоматически открывать файл-список'],[ _
			'AsTXT', 'В программе ассоциированной с txt-файлами'],[ _
			'OthPr', 'В другой программе'],[ _
			'ARnd', 'Автоматически округлить до Гб, Мб, кб'],[ _
			'VLF', 'Просмотрщик списка'],[ _
			'Lst', 'Список'],[ _
			'LF1', 'пунктов, за'],[ _
			'LF2', 'сек'],[ _
			'Reg', 'Создать список файлов']]
EndIf

For $i = 1 To $aLng0[0][0]
	If StringInStr($aLng0[$i][1], '\r\n') Then $aLng0[$i][1] = StringReplace($aLng0[$i][1], '\r\n', @CRLF)
	Assign('Lng' & $aLng0[$i][0], $aLng0[$i][1])
Next

$LangPath = IniRead($ini, 'Set', 'Lang', 'none')
If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then
	$aLng = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng')
	If Not @error Then
		For $i = 1 To $aLng[0][0]
			If StringInStr($aLng[$i][1], '\r\n') Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\r\n', @CRLF)
			If IsDeclared('Lng' & $aLng[$i][0]) Then Assign('Lng' & $aLng[$i][0], $aLng[$i][1])
		Next
	EndIf
EndIf

; пункты
Global $aType[21] = [ _
		'01 ' & $LngaDisk, _
		'02 ' & $LngaFPth, _
		'03 ' & $LngaRPth, _
		'04 ' & $LngaNmFile, _
		'05 ' & $LngaFileEx, _
		'06 ' & $LngaSzFile, _
		'07 ' & $LngaAtrF, _
		'08 ' & $LngaChDt, _
		'09 ' & $LngaCrDt, _
		'10 ' & $LngaOpDt, _
		'11 ' & $LngaAgFile, _
		'12 ' & $LngaAgFileS, _
		'13 ' & $LngaAgCrFile, _
		'14 ' & $LngaAgCrFileS, _
		'15 ' & $LngaAgOpFile, _
		'16 ' & $LngaAgOpFileS, _
		'17 ' & $LngaMD5, _
		'18 ' & $LngaSHA1, _
		'19 ' & $LngaLNm, _
		'20 ' & $LngaLPt, _
		'21 ' & $LngLvSub]

$XYPos[0] = Number(IniRead($ini, 'Set', 'W', '490'))
$XYPos[1] = Number(IniRead($ini, 'Set', 'H', '420'))
$XYPos[2] = IniRead($ini, 'Set', 'X', '')
$XYPos[3] = IniRead($ini, 'Set', 'Y', '')

If $XYPos[0] < 490 Then $XYPos[0] = 490
If $XYPos[1] < 420 Then $XYPos[1] = 420

_SetCoor($XYPos)

If $CmdLine[0] = 1 Then
	If FileExists($CmdLine[1]) And StringInStr(FileGetAttrib($CmdLine[1]), "D") Then
		$iniPathFldr = $CmdLine[1]
		$iniPathFileList = _TempFile('', '~', '.txt')
	Else
		MsgBox(0, $LngMs1, $LngMs2)
		Exit
	EndIf
ElseIf $CmdLine[0] > 1 Then
	MsgBox(0, $LngMs1, $LngMs3)
Else
	$iniPathFldr = IniRead($ini, 'Set', 'LastFolder', '')
	$iniPathFileList = IniRead($ini, 'Set', 'LastFileList', '')
EndIf

If Number(IniRead($ini, 'Set', 'Include', '0')) = 1 Then
	$TrInc = False
Else
	$TrInc = True
EndIf
$iniLimit = Number(IniRead($ini, 'Set', 'Limit', '20000'))
$TrAV = Number(IniRead($ini, 'Set', 'TrAV', '1'))
$TrGMK = Number(IniRead($ini, 'Set', 'TrGMK', '1'))
$iniLevelFld = Number(IniRead($ini, 'Set', 'LevelFld', '125'))
$iniInputTxt = IniRead($ini, 'Set', 'Text', $LngiTxt)
$iniSep = IniRead($ini, 'Set', 'Sep', $iniSep)
$iniChSort = Number(IniRead($ini, 'Set', 'ChSort', '1'))
$iniCmSort = IniRead($ini, 'Set', 'CmSort', '')
$LastType = IniRead($ini, 'Set', 'LastType', '')
$iniFileEx = IniRead($ini, 'Set', 'FileEx', $iniFileEx)
If $LastType Then
	$iniFileEx = $LastType & '|' & StringReplace('|' & $iniFileEx & '|', '|' & $LastType & '|', '|')
	$iniFileEx = StringTrimRight(StringReplace($iniFileEx, '||', '|'), 1)
EndIf
$Editor = IniRead($ini, 'Set', 'Editor', '')
If Not FileExists($Editor) Then
	$Editor = _TypeGetPath('txt')
	If @error Then $Editor = @SystemDir & '\notepad.exe'
EndIf

If Not StringInStr(';01;02;03;04;05;06;07;08;09;10;11;12;13;14;15;16;17;18;19;20;21;', ';' & $iniCmSort & ';') Then $iniCmSort = ''
For $i = 0 To UBound($aType) - 1
	$Ind = _ArraySearch($aType, $iniCmSort, 0, 0, 0, 1)
	If $Ind <> -1 Then $iniCmSort = $aType[$Ind]
Next

If Not StringInStr('|' & $iniSep & '|', '|-Tab-|') Then $iniSep &= '|-Tab-||'
If $iniSep = '-Tab-' Then $iniSep = '-Tab-||'

$exStyles = BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT)

$Gui = GUICreate($LngTitle, $XYPos[0], $XYPos[1], $XYPos[2], $XYPos[3], $WS_OVERLAPPEDWINDOW, $WS_EX_ACCEPTFILES)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
GUISetOnEvent($GUI_EVENT_DROPPED, "_Dropped")
If Not @Compiled Then GUISetIcon(@ScriptDir & '\Create_list_files.ico')

$StatusBar = GUICtrlCreateLabel($LngSBr1, 3, $XYPos[1] - 18, 230, 17)
GUICtrlSetResizing(-1, 2 + 64 + 256 + 512)

$L1 = GUICtrlCreateLabel($LngSFd, 5, 7, 75, 17, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
$PathFldr = GUICtrlCreateInput($iniPathFldr, 80, 5, $XYPos[0] - 109, 22)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
$OpenFldr = GUICtrlCreateButton("...", $XYPos[0] - 30, 5, 26, 23)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
GUICtrlSetFont(-1, 16)
GUICtrlSetOnEvent(-1, "_OpenFldr")

$L2 = GUICtrlCreateLabel($LngFLst, 5, 32, 75, 17, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
$PathFileList = GUICtrlCreateInput($iniPathFileList, 80, 30, $XYPos[0] - 109, 22)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
$OpenFilelist = GUICtrlCreateButton("...", $XYPos[0] - 30, 30, 26, 23)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
GUICtrlSetFont(-1, 16)
GUICtrlSetOnEvent(-1, "_OpenFilelist")

$L3 = GUICtrlCreateLabel($LngFType, 5, 57, 75, 17, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
$FileEx = GUICtrlCreateCombo('', 80, 55, 147)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
GUICtrlSetData(-1, $iniFileEx, StringRegExpReplace($iniFileEx, '^(.*?)\|.*', '\1'))

$L4 = GUICtrlCreateLabel($LngLnSub, 5, 82, 170, 17, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
$LevelFld = GUICtrlCreateInput($iniLevelFld, 176, 81, 30, 20)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)

$hChInc = GUICtrlCreateCheckbox('', 210, 79, 17, 17)
GUICtrlSetOnEvent(-1, "_Include")
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
GUICtrlSetTip(-1, $LngInclH)
If Not $TrInc Then GUICtrlSetState(-1, 1)

$L5 = GUICtrlCreateLabel($LngFSrt, 245, 58, 68, 17, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
$ComboSort = GUICtrlCreateCombo('', 315, 55, 150, 22, $CBS_DROPDOWNLIST)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
GUICtrlSetData(-1, '||'&_ArrayToString($aType), $iniCmSort)

$ChSort = GUICtrlCreateCheckbox($LngSrtD, 245, 79, 168, 17)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
If $iniChSort = 1 Then GUICtrlSetState(-1, 1)

$L6 = GUICtrlCreateLabel($LngAvEL, 5, 103, 170, 17, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing(-1, 32 + 256 + 512)
; нужен дескриптор, потому что UDF функции используют созданные пункты
$hListView0 = GUICtrlCreateListView("", 5, 120, $XYPos[0] / 2 - 25, $XYPos[1] - 244, BitOR($LVS_REPORT, $LVS_SHOWSELALWAYS, $LVS_NOCOLUMNHEADER), $WS_EX_CLIENTEDGE)
GUICtrlSetResizing(-1, 2 + 32)
$hListView = GUICtrlGetHandle($hListView0)
_GUICtrlListView_SetExtendedListViewStyle($hListView, $exStyles)
GUICtrlSetState($hListView0, $GUI_DROPACCEPTED)


$Label2 = GUICtrlCreateLabel($LngRsLine, $XYPos[0] / 2, 103, 160, 17, $SS_LEFTNOWORDWRAP)
; GUICtrlSetResizing(-1,  32 + 256 + 512)
$hListView02 = GUICtrlCreateListView("", $XYPos[0] / 2 + 3, 120, $XYPos[0] / 2 - 25, $XYPos[1] - 244, BitOR($LVS_REPORT, $LVS_SHOWSELALWAYS, $LVS_NOCOLUMNHEADER), $WS_EX_CLIENTEDGE)
GUICtrlSetResizing(-1, 4 + 32)
$hListView2 = GUICtrlGetHandle($hListView02)
_GUICtrlListView_SetExtendedListViewStyle($hListView2, $exStyles)
GUICtrlSetState($hListView02, $GUI_DROPACCEPTED)

$b1 = GUICtrlCreateButton($LngCln, $XYPos[0] - 82, 103, 60, 17)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
GUICtrlSetOnEvent(-1, "_Clear")

; колонки
_GUICtrlListView_AddColumn($hListView, "", $XYPos[0] / 2 - 50)
_GUICtrlListView_AddColumn($hListView2, "", $XYPos[0] / 2 - 30)

For $i = 0 To UBound($aType) - 1
	_GUICtrlListView_AddItem($hListView, $aType[$i], $i)
Next
$BtnRight = GUICtrlCreateButton(">", $XYPos[0] / 2 - 18, $XYPos[1] / 2 - 40, 18, 35)
GUICtrlSetOnEvent(-1, "_CopyRight")
GUICtrlSetTip(-1, $LngsRightH)

$BtnLeft = GUICtrlCreateButton("<", $XYPos[0] / 2 - 18, $XYPos[1] / 2 + 5, 18, 35)
GUICtrlSetOnEvent(-1, "_Delete")
GUICtrlSetTip(-1, $LngsLeftH)

$BtnUp = GUICtrlCreateButton("^", $XYPos[0] - 20, $XYPos[1] / 2 - 40, 18, 35)
GUICtrlSetOnEvent(-1, "_Up")
GUICtrlSetTip(-1, $LngsUpH)

$BtnDown = GUICtrlCreateButton("v", $XYPos[0] - 20, $XYPos[1] / 2 + 5, 18, 35)
GUICtrlSetOnEvent(-1, "_Down")
GUICtrlSetTip(-1, $LngsDwnH)

$StartBtn = GUICtrlCreateButton($LngbSrt, $XYPos[0] - 110, $XYPos[1] - 50, 100, 40)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)
GUICtrlSetOnEvent(-1, "_Start")

$StopBtn = GUICtrlCreateLabel($LngCEsc, $XYPos[0] - 227, $XYPos[1] - 18, 100, 17, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)
GUICtrlSetFont(-1, -1, 700)
GUICtrlSetColor(-1, 0xff0000)
GUICtrlSetState(-1, $GUI_HIDE)

$b2 = GUICtrlCreateButton($LngbSet, $XYPos[0] - 272, $XYPos[1] - 50, 70, 25)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)
GUICtrlSetOnEvent(-1, "_Setting")

$b6 = GUICtrlCreateButton($LngVLF, $XYPos[0] - 406, $XYPos[1] - 50, 122, 25)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)
GUICtrlSetOnEvent(-1, "_ViewListFiles")

If $CmdLine[0] = 0 Then
	GUICtrlCreateButton("R", $XYPos[0] - 192, $XYPos[1] - 50, 30, 30)
	GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)
	GUICtrlSetOnEvent(-1, "_restart")
	GUICtrlSetTip(-1, $LngReSt)
EndIf

$b3 = GUICtrlCreateButton("@", $XYPos[0] - 152, $XYPos[1] - 50, 30, 30)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)
GUICtrlSetOnEvent(-1, "_About")
GUICtrlSetTip(-1, $LngAbout)

$InputTxt = GUICtrlCreateInput($iniInputTxt, $XYPos[0] - 242, $XYPos[1] - 115, 125, 22)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)
$b4 = GUICtrlCreateButton($LngAdLn, $XYPos[0] - 110, $XYPos[1] - 117, 100, 26)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)
GUICtrlSetOnEvent(-1, "_Add")

$L7 = GUICtrlCreateLabel($LngSep, 10, $XYPos[1] - 112, 75, 17, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing(-1, 2 + 64 + 256 + 512)
$ComboSep = GUICtrlCreateCombo('', 85, $XYPos[1] - 115, 110)
GUICtrlSetResizing(-1, 2 + 64 + 256 + 512)
GUICtrlSetData(-1, $iniSep, StringRegExpReplace($iniSep, '^(.*?)\|.*', '\1'))

$L8 = GUICtrlCreateLabel($LngFmDt, 10, $XYPos[1] - 82, 75, 17, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing(-1, 2 + 64 + 256 + 512)
$ComboDate = GUICtrlCreateCombo('', 85, $XYPos[1] - 85, 110)
GUICtrlSetResizing(-1, 2 + 64 + 256 + 512)
GUICtrlSetData(-1, 'D.M.Y H:N:S|D/M/Y H:N:S|Y.M.D H:N:S|Y.M.D|D.M.y|H:N:S', 'Y.M.D H:N:S')

$L9 = GUICtrlCreateLabel($LngcTmpl, $XYPos[0] - 262, $XYPos[1] - 82, 65, 17, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)
$ComboTml = GUICtrlCreateCombo('', $XYPos[0] - 215, $XYPos[1] - 85, 130)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)
GUICtrlSetOnEvent(-1, "_SetTml")

$b5 = GUICtrlCreateButton($LngbSv, $XYPos[0] - 80, $XYPos[1] - 85, 70, 26)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)
GUICtrlSetOnEvent(-1, "_SaveTml")
GUICtrlSetTip(-1, $LngbSvH)

$IniTData = ''
$aIniTml = IniReadSection($ini, 'Template')
If Not @error Then
	For $i = 1 To $aIniTml[0][0]
		$IniTData &= $aIniTml[$i][0] & '|'
	Next
	$IniTData = StringTrimRight($IniTData, 1)
	GUICtrlSetData($ComboTml, 'LastTemplate|' & StringRegExpReplace($IniTData, '(LastTemplate\||\|LastTemplate|LastTemplate)', ''), 'LastTemplate')
	_SetTml()
EndIf


$Helphtm = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_Dummy")
Func _Dummy()
	If FileExists(@ScriptDir & '\Create_list_files.chm') Then
		ShellExecute(@ScriptDir & '\Create_list_files.chm')
	Else
		_About()
	EndIf
EndFunc

Dim $AccelKeys[6][2] = [["{F1}", $Helphtm],["^{Left}", $BtnLeft],["^{Right}", $BtnRight],["^{Up}", $BtnUp],["^{Down}", $BtnDown],["^{Del}", $BtnLeft]]
GUISetAccelerators($AccelKeys)

_Crypt_Startup()

GUISetState()
GUIRegisterMsg(0x05, "WM_SIZE")
OnAutoItExitRegister("_Exit")
GUIRegisterMsg($WM_NOTIFY, 'WM_NOTIFY')
GUIRegisterMsg(0x0046, "WM_WINDOWPOSCHANGING")
GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")

While 1
	Sleep(1000000)
WEnd

Func _Include()
	If GUICtrlRead($hChInc) = 1 Then
		$TrInc = False
	Else
		$TrInc = True
	EndIf
EndFunc   ;==>_Include

; Сохраняем список как шаблон в ini
Func _SaveTml()
	Local $answer, $Count, $i, $Tmp, $Tmp1
	$Count = _GUICtrlListView_GetItemCount($hListView2)
	If $Count <> 0 Then
		Local $aCnt[$Count][2]
		$Tmp1 = ''
		For $i = 0 To $Count - 1
			$Tmp = _GUICtrlListView_GetItemText($hListView2, $i)
			$Tmp = StringRegExp($Tmp, '(^\d\d).(.*)$', 3)
			If @error Then ContinueLoop
			$aCnt[$i][0] = $Tmp[0]
			$aCnt[$i][1] = StringReplace($Tmp[1], '|', '¤')
			$Tmp1 &= $Tmp[0] & '-'
		Next
		If $stat = 0 Then
			$answer = InputBox($LngBx1, $LngBx2, StringTrimRight($Tmp1, 1), '', 100, 130, Default, Default, '', $Gui)
			$err = @error
		Else
			$answer = 'LastTemplate'
			$err = 0
		EndIf
		If Not $err And $answer Then
			GUICtrlSetData($ComboTml, $answer, $answer)
			$Tmp1 = ''
			For $i = 0 To $Count - 1
				If $aCnt[$i][0] <> '00' Then
					$Tmp1 &= $aCnt[$i][0] & '|'
				Else
					$Tmp1 &= $aCnt[$i][0] & ' ' & $aCnt[$i][1] & '|'
				EndIf
			Next
			IniWrite($ini, 'Template', $answer, StringTrimRight($Tmp1, 1))
		EndIf
	Else
		If $stat <> 0 Then IniWrite($ini, 'Template', 'LastTemplate', '')
	EndIf
EndFunc   ;==>_SaveTml

Func _SetTml()
	$Tmp = IniRead($ini, 'Template', GUICtrlRead($ComboTml), '')
	If Not @error And $Tmp Then
		_Clear()
		; $aTmp=StringSplit($Tmp, '|')
		; Добавляем в список из ini
		$aTmp = StringRegExp($Tmp & '|', '(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|00 .*?)\|', 3)
		For $i = 0 To UBound($aTmp) - 1
			If StringLeft($aTmp[$i], 2) <> '00' Then
				$Ind = _ArraySearch($aType, $aTmp[$i], 0, 0, 0, 1)
				If $Ind <> -1 Then _GUICtrlListView_AddItem($hListView2, $aType[$Ind])
			Else
				_GUICtrlListView_AddItem($hListView2, StringReplace($aTmp[$i], '¤', '|'))
			EndIf
		Next
	EndIf
EndFunc   ;==>_SetTml

Func _Clear()
	_GUICtrlListView_DeleteAllItems($hListView2)
EndFunc   ;==>_Clear

Func _Stop()
	$trStop = 1
EndFunc   ;==>_Stop

Func _OpenFldr()
	$Tmp = FileSelectFolder($LngOpen, '', 3, '', $Gui)
	If @error Then Return
	GUICtrlSetData($PathFldr, $Tmp)
EndFunc   ;==>_OpenFldr

Func _OpenFilelist()
	$Tmp = FileOpenDialog($LngOpen, @WorkingDir, $LngOAll & ' (*.*)', 8, $LngOLst, $Gui)
	If @error Then Return
	If Not StringInStr($Tmp, '.') Then $Tmp &= '.txt'
	GUICtrlSetData($PathFileList, $Tmp)
EndFunc   ;==>_OpenFilelist

Func _Add()
	$InputTxt0 = GUICtrlRead($InputTxt)
	If $InputTxt0 = '' Then Return
	_GUICtrlListView_AddItem($hListView2, '00 ' & $InputTxt0)
EndFunc   ;==>_Add

Func _Up()
	$i = _GUICtrlListView_GetSelectedIndices($hListView2)
	If StringInStr($i, '|') Or $i = '' Or $i = 0 Then Return MsgBox(0, $LngMs1, $LngMs4)
	$Txt1 = _GUICtrlListView_GetItemText($hListView2, $i)
	$Txt2 = _GUICtrlListView_GetItemText($hListView2, $i - 1)
	_GUICtrlListView_SetItemText($hListView2, $i, $Txt2)
	_GUICtrlListView_SetItemText($hListView2, $i - 1, $Txt1)
	_GUICtrlListView_SetItemSelected($hListView2, $i - 1)
	_GUICtrlListView_SetItemSelected($hListView2, $i, 0)
EndFunc   ;==>_Up

Func _Down()
	$Count = _GUICtrlListView_GetItemCount($hListView2)
	$i = _GUICtrlListView_GetSelectedIndices($hListView2)
	If StringInStr($i, '|') Or $i = '' Or $i = $Count - 1 Then Return MsgBox(0, $LngMs1, $LngMs4)
	$Txt1 = _GUICtrlListView_GetItemText($hListView2, $i)
	$Txt2 = _GUICtrlListView_GetItemText($hListView2, $i + 1)
	_GUICtrlListView_SetItemText($hListView2, $i, $Txt2)
	_GUICtrlListView_SetItemText($hListView2, $i + 1, $Txt1)
	_GUICtrlListView_SetItemSelected($hListView2, $i + 1)
	_GUICtrlListView_SetItemSelected($hListView2, $i, 0)
EndFunc   ;==>_Down

Func _Start()
	$TrSort = 0
	GUICtrlSetState($StartBtn, $GUI_DISABLE)
	GUICtrlSetData($StatusBar, $LngSBr2)
	$PathFldr0 = GUICtrlRead($PathFldr)
	$PathFileList0 = GUICtrlRead($PathFileList)
	$FileEx0 = GUICtrlRead($FileEx)
	$LevelFld0 = Number(GUICtrlRead($LevelFld))
	$ComboSep0 = GUICtrlRead($ComboSep)
	$ComboSort0 = GUICtrlRead($ComboSort)
	$ComboDate0 = GUICtrlRead($ComboDate)
	If $ComboSep0 = '-Tab-' Then $ComboSep0 = @TAB
	If Not FileExists($PathFldr0) Or Not StringInStr(FileGetAttrib($PathFldr0), "D") Then
		GUICtrlSetState($StartBtn, $GUI_ENABLE)
		GUICtrlSetData($StatusBar, $LngSBr3)
		Return MsgBox(0, $LngMs1, $LngSBr3)
	EndIf
	$fileBs = FileOpen($PathFileList0, 2 + 8)
	If $fileBs = -1 Then
		FileClose($fileBs)
		GUICtrlSetState($StartBtn, $GUI_ENABLE)
		GUICtrlSetData($StatusBar, $LngSBr5)
		Return MsgBox(0, $LngMs1, $LngMs5)
	EndIf

	$ComboDate0 = StringRegExpReplace($ComboDate0, '([YMDHMS])\1+', '$1')
	$lenSep0 = StringLen($ComboSep0)
	$length = StringLen($PathFldr0)
	If StringRight($PathFldr0, 1) <> '\' Then $length += 1
	If $LevelFld0 < 0 Then $LevelFld0 = 0
	If $LevelFld0 > 125 Then $LevelFld0 = 125
	GUICtrlSetData($LevelFld, $LevelFld0)

	$Count = _GUICtrlListView_GetItemCount($hListView2)
	If $Count = 0 Then
		GUICtrlSetState($StartBtn, $GUI_ENABLE)
		GUICtrlSetData($StatusBar, $LngSBr6)
		Return MsgBox(0, $LngMs1, $LngMs6)
	EndIf

	Local $aCnt[$Count][2]
	For $i = 0 To $Count - 1
		$Tmp = _GUICtrlListView_GetItemText($hListView2, $i)
		$Tmp = StringRegExp($Tmp, '(^\d\d).(.*)$', 3)
		If @error Then ContinueLoop
		$aCnt[$i][0] = $Tmp[0]
		$aCnt[$i][1] = $Tmp[1]
	Next
	; _ArrayDisplay($aCnt, 'Array')

	; если колонка сортировки отсутствует, включаем триггер и добавляем колонку в массив
	If $ComboSort0 <> '' Then
		$indSort0 = StringLeft($ComboSort0, 2)
		$Ind = _ArraySearch($aCnt, $indSort0)
		If $Ind = -1 Then
			$TrSort = 1
			$Count += 1
			ReDim $aCnt[$Count][2]
			$aCnt[$Count - 1][0] = $indSort0
			$aCnt[$Count - 1][1] = ''
		EndIf
	EndIf

	$timer = TimerInit()
	$Text = ''
	$SizeTotal = 0
	$Text = _FO_FileSearch($PathFldr0, _FO_CorrectMask(StringReplace($FileEx0, ';', '|')), $TrInc, $LevelFld0, 1, 0, 0)
	$Text = StringStripCR($Text)
	$aText = StringSplit($Text, @LF)
	If @error And $aText[1] = '' Then Dim $aText[1] = [0]

	If _ArraySearch($aCnt, '17', 0, 0, 0, 1) <> -1 Or _ArraySearch($aCnt, '18', 0, 0, 0, 1) <> -1 Then
		$trHash = 1
		For $i = 1 To $aText[0]
			$SizeTotal += FileGetSize($aText[$i])
		Next
		$SizeTotal = Int($SizeTotal / 1048576) & $LngsMb
	Else
		$trHash = 0
	EndIf
	If $Text = '' Then
		GUICtrlSetState($StartBtn, $GUI_ENABLE)
		GUICtrlSetData($StatusBar, $LngSBr7)
		Return MsgBox(0, $LngMs1, $LngSBr7)
	EndIf
	$DT[0] = @YEAR
	$DT[1] = @MON
	$DT[2] = @MDAY
	$DT[3] = @HOUR
	$DT[4] = @MIN
	$DT[5] = @SEC
	If $aText[0] > $iniLimit And MsgBox(4, $LngMs1, $LngMs7 & ' ' & $aText[0] & ' ' & $LngMs8) = 7 Then
		GUICtrlSetState($StopBtn, $GUI_HIDE)
		GUICtrlSetState($StartBtn, $GUI_ENABLE)
		GUICtrlSetData($StatusBar, $LngSBr8)
		$trHash = 0
		Return
	EndIf
	Local $aBase[$aText[0]][$Count]
	$SizeTmp = 0
	$SizeTmp2 = 0
	If $trHash = 1 Then
		HotKeySet("{ESC}", "_Stop")
		GUICtrlSetState($StopBtn, $GUI_SHOW)
		For $i = 0 To $aText[0] - 1
			For $j = 0 To $Count - 1
				$aBase[$i][$j] = _Execute($aText[$i + 1], $aCnt[$j][0], $aCnt[$j][1])
			Next
			$SizeTmp += FileGetSize($aText[$i + 1])
			If $SizeTmp > 10485760 Then
				$SizeTmp2 += $SizeTmp
				$SizeTmp = 0
				GUICtrlSetData($StatusBar, $LngSBr2 & ' ' & $SizeTotal & ' / ' & Int($SizeTmp2 / 1048576) & $LngsMb)
				If $trStop = 1 Then
					GUICtrlSetState($StopBtn, $GUI_HIDE)
					$trStop = 0
					HotKeySet("{ESC}")
					GUICtrlSetState($StartBtn, $GUI_ENABLE)
					GUICtrlSetData($StatusBar, $LngSBr8)
					$trHash = 0
					Return
				EndIf
			EndIf
		Next
		GUICtrlSetState($StopBtn, $GUI_HIDE)
	Else
		For $i = 0 To $aText[0] - 1
			For $j = 0 To $Count - 1
				$aBase[$i][$j] = _Execute($aText[$i + 1], $aCnt[$j][0], $aCnt[$j][1])
			Next
		Next
	EndIf

	If $ComboSort0 <> '' Then
		$Ind = _ArraySearch($aCnt, $indSort0)
		If GUICtrlRead($ChSort) = 1 Then
			$sort = 1
		Else
			$sort = 0
		EndIf
		If $Ind <> -1 Then _ArraySort($aBase, $sort, 0, 0, $Ind)
	EndIf
	If $TrGMK = 1 Then
		$Ind = _ArraySearch($aCnt, '06', 0, 0, 0, 1)
		If $Ind <> -1 Then
			For $i = 0 To $aText[0] - 1
				_GMK($aBase[$i][$Ind])
			Next
		EndIf
	EndIf
	; If Not @error Then _Crypt_Startup()
	$Text = ''
	$Line = ''
	If $TrSort = 1 Then $Count -= 1
	For $i = 0 To $aText[0] - 1
		For $j = 0 To $Count - 1
			$Line &= $aBase[$i][$j] & $ComboSep0
		Next
		$Text &= StringTrimRight($Line, $lenSep0) & @CRLF
		$Line = ''
	Next

	FileWrite($fileBs, StringTrimRight($Text, 2))
	FileClose($fileBs)
	GUICtrlSetState($StartBtn, $GUI_ENABLE)
	GUICtrlSetData($StatusBar, $LngSBr9 & ' ' & Round(TimerDiff($timer) / 1000, 2) & ' ' & $LngSBr10 & ' ' & $aText[0] & ' ' & $LngSBr11)
	If $TrAV = 1 Then Run('"' & $Editor & '" "' & $PathFileList0 & '"')
	If $trHash = 1 Then HotKeySet("{ESC}")
	$trHash = 0
EndFunc   ;==>_Start


Func _TypeGetPath($type)
	Local $aPath = ''
	Local $typefile = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $type, 'Progid')
	If @error Or $typefile = '' Then
		$typefile = RegRead('HKCR\.' & $type, '')
		If @error Then
			$aPath = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $type & '\OpenWithList', 'a')
			If @error Or $aPath = '' Then Return SetError(1)
		EndIf
	EndIf
	If $aPath = '' Then
		Local $Open = RegRead('HKCR\' & $typefile & '\shell', '')
		If @error Or $Open = '' Then $Open = 'open'
		$typefile = RegRead('HKCR\' & $typefile & '\shell\' & $Open & '\command', '')
		If @error Then
			$aPath = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $type & '\OpenWithList', 'a')
			If @error Or $aPath = '' Then
				Return SetError(1)
			Else
				$typefile = $aPath
			EndIf
		EndIf
	Else
		$typefile = $aPath
	EndIf
	Local $aPath = StringRegExp($typefile, '(?i)(^.*)(\.exe.*)$', 3)
	If @error Then Return SetError(1)
	$aPath = StringReplace($aPath[0], '"', '') & '.exe'
	Opt('ExpandEnvStrings', 1)
	If FileExists($aPath) Then
		$aPath = $aPath
		Opt('ExpandEnvStrings', 0)
		Return $aPath
	EndIf
	Opt('ExpandEnvStrings', 0)
	If FileExists(@SystemDir & '\' & $aPath) Then
		Return @SystemDir & '\' & $aPath
	ElseIf FileExists(@WindowsDir & '\' & $aPath) Then
		Return @WindowsDir & '\' & $aPath
	EndIf
	Return SetError(1)
EndFunc   ;==>_TypeGetPath


Func _Execute($Path, $n, $my)
	Switch $n
		Case '00'
			Return $my
		Case '01'
			; Return StringRegExpReplace($Path, '(^.*?)\\(.*)$', '\1')
			Return StringLeft($Path, 1)&':'
		Case '02'
			Return $Path
		Case '03'
			Return StringTrimLeft($Path, $length)
		Case '04'
			; Return StringRegExpReplace($Path, '(^.*)\\(.*)$', '\2')
			Return StringTrimLeft($Path, StringInStr($Path, "\", 0, -1))
		Case '05'
			; Return StringRegExpReplace($Path, '.*\.(\S+)', '\1')
			$tmp = StringInStr($Path, ".", 0, -1)
			If $tmp=0 Then
				Return ''
			Else
				$tmp = StringTrimLeft($Path, $tmp)
				If StringInStr($tmp, '\') Then
					Return ''
				Else
					Return $tmp
				EndIf
			EndIf
		Case '06'
			Return FileGetSize($Path)
		Case '07'
			Return FileGetAttrib($Path)
		Case '08'
			$a = FileGetTime($Path)
			If Not @error Then
				$Tmp = StringReplace($ComboDate0, 'Y', $a[0], 0, 1)
				$Tmp = StringReplace($Tmp, 'y', StringRight($a[0], 2), 0, 1)
				$Tmp = StringReplace($Tmp, 'M', $a[1], 0, 1)
				$Tmp = StringReplace($Tmp, 'D', $a[2], 0, 1)
				$Tmp = StringReplace($Tmp, 'H', $a[3], 0, 1)
				$Tmp = StringReplace($Tmp, 'N', $a[4], 0, 1)
				$Tmp = StringReplace($Tmp, 'S', $a[5], 0, 1)
				Return $Tmp
			EndIf
		Case '09'
			$a = FileGetTime($Path, 1)
			If Not @error Then
				$Tmp = StringReplace($ComboDate0, 'Y', $a[0], 0, 1)
				$Tmp = StringReplace($Tmp, 'y', StringRight($a[0], 2), 0, 1)
				$Tmp = StringReplace($Tmp, 'M', $a[1], 0, 1)
				$Tmp = StringReplace($Tmp, 'D', $a[2], 0, 1)
				$Tmp = StringReplace($Tmp, 'H', $a[3], 0, 1)
				$Tmp = StringReplace($Tmp, 'N', $a[4], 0, 1)
				$Tmp = StringReplace($Tmp, 'S', $a[5], 0, 1)
				Return $Tmp
			EndIf
		Case '10'
			$a = FileGetTime($Path, 2)
			If Not @error Then
				$Tmp = StringReplace($ComboDate0, 'Y', $a[0], 0, 1)
				$Tmp = StringReplace($Tmp, 'y', StringRight($a[0], 2), 0, 1)
				$Tmp = StringReplace($Tmp, 'M', $a[1], 0, 1)
				$Tmp = StringReplace($Tmp, 'D', $a[2], 0, 1)
				$Tmp = StringReplace($Tmp, 'H', $a[3], 0, 1)
				$Tmp = StringReplace($Tmp, 'N', $a[4], 0, 1)
				$Tmp = StringReplace($Tmp, 'S', $a[5], 0, 1)
				Return $Tmp
			EndIf
		Case '11'
			$a = FileGetTime($Path)
			If Not @error Then
				$m=''
				$Df=_DateDiff_2($DT, $a)
				If $Df[0]<0 Then
					$Df=_DateDiff_2($a, $DT)
					$m='-'
				EndIf

				Return $m&StringFormat('%02d.%02d.%02d %02d:%02d:%02d', $Df[0], $Df[1], $Df[2], $Df[3], $Df[4], $Df[5])
			EndIf
		Case '12'
			$a = FileGetTime($Path)
			If Not @error Then
				Return _DateDiff('s', $a[0] & '/' & $a[1] & '/' & $a[2] & ' ' & $a[3] & ':' & $a[4] & ':' & $a[5], $DT[0] & '/' & $DT[1] & '/' & $DT[2] & ' ' & $DT[3] & ':' & $DT[4] & ':' & $DT[5])
			EndIf
		Case '13'
			$a = FileGetTime($Path, 1)
			If Not @error Then
				$m=''
				$Df=_DateDiff_2($DT, $a)
				If $Df[0]<0 Then
					$Df=_DateDiff_2($a, $DT)
					$m='-'
				EndIf

				Return $m&StringFormat('%02d.%02d.%02d %02d:%02d:%02d', $Df[0], $Df[1], $Df[2], $Df[3], $Df[4], $Df[5])
			EndIf
		Case '14'
			$a = FileGetTime($Path, 1)
			If Not @error Then
				Return _DateDiff('s', $a[0] & '/' & $a[1] & '/' & $a[2] & ' ' & $a[3] & ':' & $a[4] & ':' & $a[5], $DT[0] & '/' & $DT[1] & '/' & $DT[2] & ' ' & $DT[3] & ':' & $DT[4] & ':' & $DT[5])
			EndIf
		Case '15'
			$a = FileGetTime($Path, 2)
			If Not @error Then
				$m=''
				$Df=_DateDiff_2($DT, $a)
				If $Df[0]<0 Then
					$Df=_DateDiff_2($a, $DT)
					$m='-'
				EndIf

				Return $m&StringFormat('%02d.%02d.%02d %02d:%02d:%02d', $Df[0], $Df[1], $Df[2], $Df[3], $Df[4], $Df[5])
			EndIf
		Case '16'
			$a = FileGetTime($Path, 2)
			If Not @error Then
				Return _DateDiff('s', $a[0] & '/' & $a[1] & '/' & $a[2] & ' ' & $a[3] & ':' & $a[4] & ':' & $a[5], $DT[0] & '/' & $DT[1] & '/' & $DT[2] & ' ' & $DT[3] & ':' & $DT[4] & ':' & $DT[5])
			EndIf
		Case '17'
			Return _Crypt_HashFile($Path, $CALG_MD5)
		Case '18'
			Return _Crypt_HashFile($Path, $CALG_SHA1)
		Case '19'
			Return StringLen(StringRegExpReplace($Path, '(^.*)\\(.*)$', '\2'))
		Case '20'
			Return StringLen($Path)
		Case '21'
			StringReplace($Path, '\', '')
			Return @extended
	EndSwitch
EndFunc   ;==>_Execute

Func _DateDiff_2($1, $2)
	$t = 0
	Dim $L[6] = [5, 12, 0, 24, 60, 60]
	For $i = 5 to 1 Step -1
		If $i = 2 Then
			Switch $2[1]
				Case 1, 3, 5, 7, 8, 10, 12
					$L[$i] = 31
				Case 2
					If _DateIsLeapYear($2[0]) Then
						$L[$i] = 29
					Else
						$L[$i] = 28
					EndIf
				Case Else
					$L[$i] = 30
			EndSwitch
		EndIf
		If $1[$i] - $t < $2[$i] Then
			$t = 1
			$2[$i] = $1[$i] + $L[$i] - $t - $2[$i]
		Else
			$2[$i] = $1[$i] - $t - $2[$i]
			$t = 0
		EndIf
	Next

	$2[0] = $1[0] - $2[0] - $t
	Return $2
EndFunc

Func _Delete()
	_GUICtrlListView_DeleteItemsSelected($hListView2)
EndFunc   ;==>_Delete

Func _Dropped()
	Select
		Case @GUI_DropId = $PathFldr
			If StringInStr(FileGetAttrib(@GUI_DragFile), "D") Then
				GUICtrlSetData($PathFldr, @GUI_DragFile)
			Else
				GUICtrlSetData($PathFldr, '')
			EndIf
		Case @GUI_DropId = $PathFileList
			If StringInStr(FileGetAttrib(@GUI_DragFile), "D") Then
				GUICtrlSetData($PathFileList, '')
			Else
				GUICtrlSetData($PathFileList, @GUI_DragFile)
			EndIf
		Case @GUI_DropId = $hListView02 And @GUI_DragId = $hListView0
			_GUICtrlListView_CopyItems(@GUI_DragId, @GUI_DropId)
		Case @GUI_DropId = $hListView0 And @GUI_DragId = $hListView02
			_GUICtrlListView_DeleteItemsSelected($hListView2)
	EndSelect
EndFunc   ;==>_Dropped

Func _CopyRight()
	_GUICtrlListView_CopyItems($hListView, $hListView2)
EndFunc   ;==>_CopyRight


; валидность координат проверяем при запуске
Func _SetCoor(ByRef $XYPos)
	$Xtmp = Number($XYPos[2])
	$Ytmp = Number($XYPos[3])
	If $Xtmp < 0 And $Xtmp <> -1 Then $Xtmp = 0
	If $Xtmp > @DesktopWidth - $XYPos[0] Then $Xtmp = @DesktopWidth - $XYPos[0]
	If $XYPos[2] = '' Then $Xtmp = -1
	If $Ytmp < 0 And $Ytmp <> -1 Then $Ytmp = 0
	If $Ytmp > @DesktopHeight - $XYPos[1] Then $Ytmp = @DesktopHeight - $XYPos[1]
	If $XYPos[3] = '' Then $Ytmp = -1
	$XYPos[2] = $Xtmp
	$XYPos[3] = $Ytmp
EndFunc   ;==>_SetCoor

Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
	Local $sRect = DllStructCreate("Int[6]", $lParam)
	Switch $Tr7
		Case 1
			If DllStructGetData($sRect, 1, 5) <> 0 And Not BitAND(WinGetState($Gui), 16) Then
				$XYPos[2] = DllStructGetData($sRect, 1, 3)
				$XYPos[3] = DllStructGetData($sRect, 1, 4)
			EndIf
		Case Else
			If DllStructGetData($sRect, 1, 2) And DllStructGetData($sRect, 1, 5) <> 0 And Not BitAND(WinGetState($Gui), 16) Then
				$XYPos[2] = DllStructGetData($sRect, 1, 3)
				$XYPos[3] = DllStructGetData($sRect, 1, 4)
			EndIf
	EndSwitch
	Return 'GUI_RUNDEFMSG'
EndFunc   ;==>WM_WINDOWPOSCHANGING

Func WM_SIZE($hWnd, $Msg, $wParam, $lParam)
	#forceref $Msg, $wParam

	$XYPos[0] = BitAND($lParam, 0x0000FFFF)
	$XYPos[1] = BitShift($lParam, 16)

	$w1 = $XYPos[0] / 2
	$h1 = $XYPos[1] / 2
	GUICtrlSetPos($hListView0, 5, 120, $w1 - 25, $XYPos[1] - 244)
	GUICtrlSetPos($hListView02, $w1 + 3, 120, $w1 - 25, $XYPos[1] - 244)

	GUICtrlSetPos($Label2, $w1 + 3, 103)
	GUICtrlSetPos($BtnLeft, $w1 - 18, $h1 - 40)
	GUICtrlSetPos($BtnRight, $w1 - 18, $h1 + 5)
	GUICtrlSetPos($BtnUp, $XYPos[0] - 20, $h1 - 40)
	GUICtrlSetPos($BtnDown, $XYPos[0] - 20, $h1 + 5)
	_GUICtrlListView_SetColumnWidth($hListView, "", $XYPos[0] / 2 - 50)
	_GUICtrlListView_SetColumnWidth($hListView2, "", $XYPos[0] / 2 - 30)
	Return 'GUI_RUNDEFMSG'
EndFunc   ;==>WM_SIZE

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $Gui Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 498)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 420)
	EndIf
EndFunc   ;==>WM_GETMINMAXINFO

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iCode, $tNMHDR, $tInfo

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, 'hWndFrom'))
	$iCode = DllStructGetData($tNMHDR, 'Code')
	Switch $hWndFrom
		Case $hListView2
			Switch $iCode
				Case $NM_DBLCLK
					_GUICtrlListView_DeleteItemsSelected($hListView2)
				Case $LVN_BEGINDRAG
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$iItem = DllStructGetData($tInfo, 'Index')
					$iOld = $iItem
					$sOld = _GUICtrlListView_GetItemText($hListView2, $iOld)
					$fDrag = True
				Case $LVN_HOTTRACK
					If $fDrag Then
						$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
						$iItem = DllStructGetData($tInfo, 'Index')
						If $iItem > -1 Then
							;перетаскивать
							_GUICtrlListView_DeleteItem($hListView2, $iOld)
							_GUICtrlListView_InsertItem($hListView2, $sOld, $iItem)
							; If $iOld>$iItem Then
							; _GUICtrlListView_InsertItem($hListView2, $sOld, $iItem)
							; Else
							; _GUICtrlListView_InsertItem($hListView2, $sOld, $iItem-1)
							; EndIf
						EndIf
						; If $iItem = -1 Then
						; _GUICtrlListView_DeleteItem($hListView2, $iOld)
						; _GUICtrlListView_InsertItem($hListView2, $sOld, 1000)
						; EndIf
						$fDrag = False
					EndIf
			EndSwitch
		Case $hListView
			Switch $iCode
				Case $NM_DBLCLK
					_GUICtrlListView_CopyItems($hListView, $hListView2)
				Case $LVN_HOTTRACK
					If $fDrag Then $fDrag = False
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _Exit()
	IniWrite($ini, 'Set', 'X', $XYPos[2])
	IniWrite($ini, 'Set', 'Y', $XYPos[3])
	IniWrite($ini, 'Set', 'W', $XYPos[0])
	IniWrite($ini, 'Set', 'H', $XYPos[1])

	IniWrite($ini, 'Set', 'Limit', $iniLimit)
	$TrInc1 = 1
	If $TrInc Then $TrInc1 = 0
	IniWrite($ini, 'Set', 'Include', $TrInc1)
	IniWrite($ini, 'Set', 'LastFolder', GUICtrlRead($PathFldr))
	IniWrite($ini, 'Set', 'LastFileList', GUICtrlRead($PathFileList))
	IniWrite($ini, 'Set', 'LevelFld', GUICtrlRead($LevelFld))
	IniWrite($ini, 'Set', 'LastType', GUICtrlRead($FileEx))
	IniWrite($ini, 'Set', 'Text', '"' & GUICtrlRead($InputTxt) & '"')
	IniWrite($ini, 'Set', 'Sep', GUICtrlRead($ComboSep))
	IniWrite($ini, 'Set', 'ChSort', GUICtrlRead($ChSort))
	IniWrite($ini, 'Set', 'CmSort', StringLeft(GUICtrlRead($ComboSort), 2))
	$stat = 1
	_SaveTml()
	; IniWrite($Ini, 'Set', 'Sort', GUICtrlRead($ComboSort))

	_Crypt_Shutdown()
	Exit
EndFunc   ;==>_Exit

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
EndFunc   ;==>_restart


Func _ChildCoor($Gui, $w, $h, $c = 0, $d = 0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
			$GP = WinGetPos($Gui), _
			$wgcs = WinGetClientSize($Gui)
	Local $dLeft = ($GP[2] - $wgcs[0]) / 2, _
			$dTor = $GP[3] - $wgcs[1] - $dLeft
	If $c = 0 Then
		$GP[0] = $GP[0] + ($GP[2] - $w) / 2 - $dLeft
		$GP[1] = $GP[1] + ($GP[3] - $h - $dLeft - $dTor) / 2
	EndIf
	If $d > ($aWA[2] - $aWA[0] - $w - $dLeft * 2) / 2 Or $d > ($aWA[3] - $aWA[1] - $h - $dLeft + $dTor) / 2 Then $d = 0
	If $GP[0] + $w + $dLeft * 2 + $d > $aWA[2] Then $GP[0] = $aWA[2] - $w - $d - $dLeft * 2
	If $GP[1] + $h + $dLeft + $dTor + $d > $aWA[3] Then $GP[1] = $aWA[3] - $h - $dLeft - $dTor - $d
	If $GP[0] <= $aWA[0] + $d Then $GP[0] = $aWA[0] + $d
	If $GP[1] <= $aWA[1] + $d Then $GP[1] = $aWA[1] + $d
	$GP[2] = $w
	$GP[3] = $h
	Return $GP
EndFunc   ;==>_ChildCoor

Func _WinAPI_GetWorkingArea()
	Local Const $SPI_GETWORKAREA = 48
	Local $stRECT = DllStructCreate("long; long; long; long")

	Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
	If @error Then Return 0
	If $SPIRet[0] = 0 Then Return 0

	Local $sLeftArea = DllStructGetData($stRECT, 1)
	Local $sTopArea = DllStructGetData($stRECT, 2)
	Local $sRightArea = DllStructGetData($stRECT, 3)
	Local $sBottomArea = DllStructGetData($stRECT, 4)

	Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
	Return $aRet
EndFunc   ;==>_WinAPI_GetWorkingArea

Func _Setting()
	$GP = _ChildCoor($Gui, 280, 270)
	GUIRegisterMsg(0x05, "")
	GUIRegisterMsg(0x0046, "")
	GUISetState(@SW_DISABLE, $Gui)
	$Gui1 = GUICreate($LngbSet, $GP[2], $GP[3], $GP[0], $GP[1], BitOr($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\Create_list_files.ico')
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
	$StatusBar1 = GUICtrlCreateLabel($LngSBr1, 3, $GP[3] - 18, 260, 17, $SS_LEFTNOWORDWRAP)

	$ChReg = GUICtrlCreateCheckbox($LngCntM, 10, 10, 175, 17)
	GUICtrlSetOnEvent(-1, "_ChReg")

	RegRead('HKCR\Folder\shell\Create_list_files\command', '')
	If Not @error Then GUICtrlSetState($ChReg, 1)

	$L21 = GUICtrlCreateLabel($LngMFile, 10, 32, 195, 17, $SS_LEFTNOWORDWRAP)
	$InpLimit = GUICtrlCreateInput($iniLimit, 205, 30, 50, 22)

	GUICtrlCreateGroup('', 5, 52, 270, 100)
	$ChOpenList = GUICtrlCreateCheckbox($LngAuLEd, 10, 62, 260, 17)
	GUICtrlSetOnEvent(-1, "_ChOpenList")

	$RdTxt = GUICtrlCreateRadio($LngAsTXT, 10, 82, 260, 17)
	$RdMy = GUICtrlCreateRadio($LngOthPr, 10, 102, 260, 17)
	$InpMy = GUICtrlCreateInput($Editor, 10, 122, 260, 22)

	If Not $EditorTmp Then
		$EditorTmp = _TypeGetPath('txt')
		If @error Then $EditorTmp = @SystemDir & '\notepad.exe'
	EndIf
	If $Editor = $EditorTmp Then
		GUICtrlSetState($RdTxt, 1)
	Else
		GUICtrlSetState($RdMy, 1)
	EndIf
	If $TrAV = 1 Then
		GUICtrlSetState($ChOpenList, 1)
	Else
		_ChOpenList()
	EndIf

	$ChGbMbKb = GUICtrlCreateCheckbox($LngARnd, 10, 155, 260, 17)
	If $TrGMK = 1 Then GUICtrlSetState(-1, 1)

	$search = FileFindFirstFile(@ScriptDir & '\Lang\*.ini')
	If $search <> -1 Then
		$LangList = 'none'
		While 1
			$file = FileFindNextFile($search)
			If @error Then ExitLoop
			$LangList &= '|' & $file
		WEnd
		GUICtrlCreateLabel('Language', 10, 182, 75, 17, $SS_LEFTNOWORDWRAP)
		$ComboLang = GUICtrlCreateCombo('', 85, 180, 70, 22, $CBS_DROPDOWNLIST)
		GUICtrlSetData(-1, $LangList, $LangPath)
		GUICtrlSetOnEvent(-1, "_SetLang")
	EndIf
	FileClose($search)

	$OK = GUICtrlCreateButton("OK", 110, $GP[3] - 48, 60, 30)
	GUICtrlSetOnEvent(-1, "_OK")

	GUISetState(@SW_SHOW, $Gui1)
EndFunc   ;==>_Setting

Func _SetLang()
	Local $aLng
	$LangPath = GUICtrlRead($ComboLang)
	If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then
		$aLng = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng')
		If Not @error Then
			For $i = 1 To $aLng[0][0]
				If StringInStr($aLng[$i][1], '\r\n') Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\r\n', @CRLF)
				If IsDeclared('Lng' & $aLng[$i][0]) Then Assign('Lng' & $aLng[$i][0], $aLng[$i][1])
			Next
			_SetLang2()
			IniWrite($ini, 'Set', 'Lang', $LangPath)
		EndIf
	Else
		For $i = 1 To $aLng0[0][0]
			If StringInStr($aLng0[$i][1], '\r\n') Then $aLng0[$i][1] = StringReplace($aLng0[$i][1], '\r\n', @CRLF)
			Assign('Lng' & $aLng0[$i][0], $aLng0[$i][1])
		Next
		_SetLang2()
		IniWrite($ini, 'Set', 'Lang', 'none')
	EndIf
EndFunc   ;==>_SetLang

Func _SetLang2()
	WinSetTitle($Gui, '', $LngTitle)
	WinSetTitle($Gui1, '', $LngbSet)
	GUICtrlSetData($StatusBar, $LngSBr1)

	GUICtrlSetTip(-1, $LngAdLnH)
	GUICtrlSetData($L1, $LngSFd)
	GUICtrlSetData($L2, $LngFLst)
	GUICtrlSetData($L3, $LngFType)
	GUICtrlSetData($L4, $LngLnSub)
	GUICtrlSetData($L5, $LngFSrt)
	GUICtrlSetData($L6, $LngAvEL)
	GUICtrlSetData($L7, $LngSep)
	GUICtrlSetData($L8, $LngFmDt)
	GUICtrlSetData($L9, $LngcTmpl)
	GUICtrlSetData($ChSort, $LngSrtD)
	GUICtrlSetData($Label2, $LngRsLine)
	GUICtrlSetData($b1, $LngCln)
	GUICtrlSetData($b2, $LngbSet)
	GUICtrlSetData($b4, $LngAdLn)
	GUICtrlSetData($b5, $LngbSv)
	GUICtrlSetData($b6, $LngVLF)
	GUICtrlSetData($StartBtn, $LngbSrt)
	GUICtrlSetData($StopBtn, $LngCEsc)
	GUICtrlSetTip($BtnRight, $LngsRightH)
	GUICtrlSetTip($BtnLeft, $LngsLeftH)
	GUICtrlSetTip($BtnUp, $LngsUpH)
	GUICtrlSetTip($BtnDown, $LngsDwnH)
	GUICtrlSetTip($b3, $LngAbout)
	GUICtrlSetTip($b4, $LngAdLnH)
	GUICtrlSetTip($b5, $LngbSvH)

	GUICtrlSetData($StatusBar1, $LngSBr1)
	GUICtrlSetData($ChReg, $LngCntM)
	GUICtrlSetData($L21, $LngMFile)
	GUICtrlSetData($ChOpenList, $LngAuLEd)
	GUICtrlSetData($RdTxt, $LngAsTXT)
	GUICtrlSetData($RdMy, $LngOthPr)
	GUICtrlSetData($ChGbMbKb, $LngARnd)
EndFunc   ;==>_SetLang2

Func _ChOpenList()
	If GUICtrlRead($ChOpenList) = 1 Then
		$Tmp = $GUI_ENABLE
	Else
		$Tmp = $GUI_DISABLE
	EndIf
	GUICtrlSetState($RdTxt, $Tmp)
	GUICtrlSetState($RdMy, $Tmp)
	GUICtrlSetState($InpMy, $Tmp)
EndFunc   ;==>_ChOpenList

Func _OK()
	$iniLimit = Number(GUICtrlRead($InpLimit))
	If Not StringIsInt($iniLimit) Or $iniLimit < 2 Then $iniLimit = 20000

	$Tmp = GUICtrlRead($ChOpenList)
	If $TrAV <> $Tmp Then
		$TrAV = $Tmp
		IniWrite($ini, 'Set', 'TrAV', $TrAV)
	EndIf

	$Tmp = GUICtrlRead($ChGbMbKb)
	If $TrGMK <> $Tmp Then
		$TrGMK = $Tmp
		IniWrite($ini, 'Set', 'TrGMK', $TrGMK)
	EndIf

	If GUICtrlRead($RdTxt) = 1 Then
		$Tmp = $EditorTmp
	ElseIf GUICtrlRead($RdMy) = 1 Then
		$Tmp = GUICtrlRead($InpMy)
	EndIf
	If FileExists($Tmp) And $Editor <> $Tmp Then
		$Editor = $Tmp
		IniWrite($ini, 'Set', 'Editor', $Editor)
	EndIf
	_Exit1()
EndFunc   ;==>_OK

Func _GMK(ByRef $iBytes)
    Switch $iBytes
        ; Case 110154232090684 To 1125323453007766
            ; $iBytes = Round($iBytes / (1099511627776 + $iBytes * $GMKConst)) & ' TB'
        ; Case 1098948684577 To 110154232090683
            ; $iBytes = Round($iBytes / (1099511627776 + $iBytes * $GMKConst), 1) & ' TB'
        Case 107572492277 To 1098948684576
            $iBytes = Round($iBytes / (1073741824 + $iBytes * $GMKConst)) & ' ' & $LngsGb
        Case 1073192075 To 107572492276
            $iBytes = Round($iBytes / (1073741824 + $iBytes * $GMKConst), 1) & ' ' & $LngsGb
        Case 105156613 To 1073192074
            $iBytes = Round($iBytes / (1048576 + $iBytes * $GMKConst)) & ' ' & $LngsMb
        Case 1048040 To 105156612
            $iBytes = Round($iBytes / (1048576 + $iBytes * $GMKConst), 1) & ' ' & $LngsMb
        Case 102693 To 1048039
            $iBytes = Round($iBytes / (1024 + $iBytes * $GMKConst)) & ' ' & $Lngskb
        Case 1024 To 102692
            $iBytes = Round($iBytes / (1024 + $iBytes * $GMKConst), 1) & ' ' & $Lngskb
        Case 0 To 1023
            $iBytes = Int($iBytes / 1.024)
    EndSwitch
EndFunc   ;==>_GMK

Func _ChReg()
	If GUICtrlRead($ChReg) = 1 Then
		RegWrite("HKCR\Folder\shell\Create_list_files", "", "REG_SZ", $LngReg)
		If @Compiled Then
			RegWrite("HKCR\Folder\shell\Create_list_files\command", "", "REG_SZ", '"' & @AutoItExe & '" "%1"')
		Else
			RegWrite("HKCR\Folder\shell\Create_list_files\command", "", "REG_SZ", @AutoItExe & ' "' & @ScriptDir & '\Create_list_files.au3" "%1"')
		EndIf
		RegRead('HKCR\Folder\shell\Create_list_files\command', '')
		If @error Then
			GUICtrlSetData($StatusBar1, $LngSBr12)
		Else
			GUICtrlSetData($StatusBar1, $LngSBr13)
		EndIf
	Else
		RegDelete('HKCR\Folder\shell\Create_list_files')
		RegRead('HKCR\Folder\shell\Create_list_files', '')
		If @error Then
			GUICtrlSetData($StatusBar1, $LngSBr14)
		Else
			GUICtrlSetData($StatusBar1, $LngSBr15)
		EndIf
	EndIf
EndFunc   ;==>_ChReg

Func _About()
	$GP = _ChildCoor($Gui, 290, 190)
	GUIRegisterMsg(0x05, "")
	GUIRegisterMsg(0x0046, "")
	GUISetState(@SW_DISABLE, $Gui)
	$font = "Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOr($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui) ; WS_CAPTION+WS_SYSMENU
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\Create_list_files.ico')
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 290, 63, BitOr($SS_CENTER, $SS_CENTERIMAGE))
	GUICtrlSetFont(-1, 14, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 288, 1, $SS_ETCHEDHORZ)

	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.6  2012.09.30', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 55, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetOnEvent(-1, "_url")
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetOnEvent(-1, "_WbMn")
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2009-2011', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
EndFunc   ;==>_About

Func _url()
	ShellExecute('http://azjio.ucoz.ru')
EndFunc   ;==>_url

Func _WbMn()
	ClipPut('R939163939152')
EndFunc   ;==>_WbMn

Func _Exit1()
	GUISetState(@SW_ENABLE, $Gui)
	GUIDelete($Gui1)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	GUIRegisterMsg(0x05, "WM_SIZE")
	GUIRegisterMsg(0x0046, "WM_WINDOWPOSCHANGING")
EndFunc   ;==>_Exit1

Func _Exit2()
	_Exit1()
	_GUIImageList_Destroy($hImage)
	$hImage = ''
EndFunc   ;==>_Exit1

Func _ViewListFiles()
	Local $ListFile = FileOpenDialog($LngOpen, @WorkingDir, $LngOAll & ' (*.*)', 3, $LngOLst, $Gui)
	If @error Then Return
	Local $aE, $aLastPath, $aList, $E, $GP, $hTreeView, $i, $ico1, $sep, $sExt, $timer, $TreeView, _
	$aLastPath[125][3] = [[0]] ; (массив = "папка | дескриптор пункта | счётчик папок")

$GP = _ChildCoor($Gui, 540, 560)
GUIRegisterMsg(0x05, "")
GUIRegisterMsg(0x0046, "")
GUISetState(@SW_DISABLE, $Gui)

$Gui1 = GUICreate($LngVLF, $GP[2], $GP[3], $GP[0], $GP[1], BitOr($WS_CAPTION, $WS_SYSMENU, $WS_POPUP, $WS_OVERLAPPEDWINDOW), -1, $Gui)
If Not @Compiled Then GUISetIcon(@ScriptDir & '\Create_list_files.ico')
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit2")

GUICtrlCreateTreeView(0, 0, 540, 560, -1, $WS_EX_CLIENTEDGE)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
$hTreeView = GUICtrlGetHandle(-1)

$hImage = _GUIImageList_Create(16, 16, 5, 1) ; Создаём список иконок
_GUIImageList_AddIcon($hImage, @SystemDir & '\shell32.dll', -4)
_GUIImageList_AddIcon($hImage, @SystemDir & '\shell32.dll', -5)
_GUIImageList_AddIcon($hImage, @SystemDir & '\shell32.dll', 0)
_GUICtrlTreeView_SetNormalImageList($hTreeView, $hImage)

; Вытаскиваем иконки расширений из реестра и добавляем их в список изображений (скорость импорта 0,5 сек)
$E = ''
$i = 1
While 1
	$i += 1
	$sExt = RegEnumKey("HKCR", $i)
	If @error Or StringLeft($sExt, 1) <> '.' Then ExitLoop
	$ico1 = _FileDefaultIcon($sExt)
	If Not @error Then
		Switch UBound($ico1)
			Case 2
				If StringInStr(';.exe;.scr;.ico;.ani;.cur;', ';' & $sExt & ';') Then
					ContinueLoop
				Else
					_GUIImageList_AddIcon($hImage, $ico1[1], 0)
					If @error Then ContinueLoop
				EndIf
			Case 3
				_GUIImageList_AddIcon($hImage, $ico1[1], $ico1[2])
				If @error Then ContinueLoop
		EndSwitch
		$E &= '|' & $sExt
	EndIf
WEnd
$E = StringTrimLeft($E, 1)
$aE = StringSplit($E, '|') ; Создаём массив расширений, позиция которых совпадает с позицией иконок

$aLastPath[0][1] = _GUICtrlTreeView_Add($hTreeView, 0, $LngLst, 0, 0) ; добавляем корневой пункт
$aList = StringSplit(StringReplace(FileRead($ListFile), ':', ''), @CRLF, 1) ; читаем список в массив

$sep = Opt("GUIDataSeparatorChar", "\")
$timer = TimerInit()
_ArraySort($aList, 0, 1) ; сортируем список, обязательно если не сортированный
_AddFileList($aList, $aLastPath, $hTreeView, $aE)
WinSetTitle($Gui1, '', $LngVLF & ' (' & $aList[0] & ' ' & $LngLF1 & ' ' & Round(TimerDiff($timer) / 1000, 2) & ' ' & $LngLF2 & ')')
Opt("GUIDataSeparatorChar", $sep)
ControlTreeView($Gui1, '', $hTreeView, 'Expand', $LngLst) ; раскрыть корневой
GUISetState()
EndFunc

Func _AddFileList($aList, ByRef $aLastPath, $hTreeView, $aE)
	Local $hItem, $i, $ind, $j, $tmp, $tmp1, $z
	For $z = 1 To $aList[0]
		$tmp = StringSplit($aList[$z], '\') ; делим путь
		For $i = 1 To $tmp[0]
			If $tmp[$i] <> $aLastPath[$i][0] Then ; ищем последнее различие в пути, то есть уровеь вложения, на котором новый пункт не совпадает с предыдущим
				For $j = $i To $tmp[0]
					$aLastPath[$j][0] = $tmp[$j] ; кэшируем новый путь в двумерный массив
					$aLastPath[$j + 1][2] = 0 ; сбрасываем счётчик папок в 0
				Next
				ExitLoop
			EndIf
		Next
		For $i = $i To $tmp[0] ; отсчёт цикла начинается с индекса на котором было несовпадение, а значит они ещё не созданы
			If $i = $tmp[0] Then ; если последний элемент пути (то есть файл), то... (условие для определения иконки пункту)
				$tmp1 = StringRegExpReplace($tmp[$i], '.*(\.\S+)', '\1') ; ищем расширение
				$ind = _ArraySearch($aE, $tmp1) + 2 ; ищем расширение в масиве, чтобы определить индекс
				If @error Then $ind = 2 ; если нет расширения
				$aLastPath[$i][1] = _GUICtrlTreeView_AddChild($hTreeView, $aLastPath[$i - 1][1], $tmp[$i], $ind, $ind) ; добавляем пункт (файл) в конец списка
			Else
				$ind = 0
				; если папка
				If $aLastPath[$i][2] Then
					$hItem = _GUICtrlTreeView_GetItemByIndex($hTreeView, $aLastPath[$i - 1][1], $aLastPath[$i][2] - 1) ; десриптор последнего пункта папки
					$aLastPath[$i][1] = _GUICtrlTreeView_InsertItem($hTreeView, $tmp[$i], $aLastPath[$i - 1][1], $hItem, $ind, $ind)
				Else ; иначе если индекс 0, добавляем первым в список, так как Insert не может добавить в самое начало
					$aLastPath[$i][1] = _GUICtrlTreeView_AddChildFirst($hTreeView, $aLastPath[$i - 1][1], $tmp[$i], $ind, $ind) ; добавляем пункт
				EndIf
				$aLastPath[$i][2] += 1 ; увеличиваем счётчик папок на 1 для вставки папок оп индексу
			EndIf
		Next
	Next
EndFunc

Func _FileDefaultIcon($sExt)
	If $sExt = '' Or StringInStr($sExt, ':') Then Return SetError(1)

	Local $aCall = DllCall("shlwapi.dll", "int", "AssocQueryStringW", _
			"dword", 0x00000040, _ ;$ASSOCF_VERIFY
			"dword", 15, _ ;$ASSOCSTR_DEFAULTICON
			"wstr", $sExt, _
			"ptr", 0, _
			"wstr", "", _
			"dword*", 65536)

	If @error Then Return SetError(1, 0, "")

	If Not $aCall[0] Then
		$sExt = StringReplace($aCall[5], '"', '')
		$sExt = StringSplit($sExt, ',')
		Opt('ExpandEnvStrings', 1)
		$sExt[1] = $sExt[1]
		Opt('ExpandEnvStrings', 0)
		Return SetError(0, 0, $sExt)
	ElseIf $aCall[0] = 0x80070002 Then
		Return SetError(1, 0, "{unknown}")
	ElseIf $aCall[0] = 0x80004005 Then
		Return SetError(1, 0, "{fail}")
	Else
		Return SetError(2, $aCall[0], "")
	EndIf
EndFunc