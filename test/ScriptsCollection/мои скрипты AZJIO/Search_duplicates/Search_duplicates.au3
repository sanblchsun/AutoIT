;  @AZJIO  2013.03.04   (AutoIt3_v3.3.6.1)
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Search_duplicates.exe
#AutoIt3Wrapper_Icon=Search_duplicates.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Search_duplicates.exe
#AutoIt3Wrapper_Res_Fileversion=0.5.1.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.5.1
#AutoIt3Wrapper_Res_Field=Build|2013.03.04
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Icon_Add=1.ico
#AutoIt3Wrapper_Res_Icon_Add=2.ico
#AutoIt3Wrapper_Res_Icon_Add=3.ico
#AutoIt3Wrapper_Res_Icon_Add=4.ico
#AutoIt3Wrapper_Res_Icon_Add=5.ico
#AutoIt3Wrapper_Res_Icon_Add=6.ico
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#NoTrayIcon
#include <Crypt.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <GuiButton.au3>
#include <GuiImageList.au3>
#include <ListBoxConstants.au3>
#include <FileOperations.au3>
#include <ForSearch_duplicates.au3>

Opt("GUIOnEventMode", 1)
Opt("GUIResizeMode", 802)

Global $XYPos[4], $Tr7 = 1, $ini = @ScriptDir & '\Search_duplicates.ini'
Global $aArr, $a, $Dubl, $aSizePath = '', $AllBox = '', $AllCSV = '', $CSVname = '', $CSVpath = ''
Global $iScroll_Pos, $Gui, $Gui1, $nLAbt, $hAbt, $wAbtBt, $TrAbt1, $TrAbt2, $tabAbt1, $StopPlay, $vk1, $BkCol2, $tabAbt0, $BkCol1
Global $Mask = '*', $ComboMask, $TrInc = True, $TrSub = 125, $hChSub, $hChInc, $hDubl, $ItemText = '', $ContMenu, $hMenu
Global $TypeFile = 'avi;mpg;mpeg;mp4;vob;mkv;asf;asx;wmv;mov;3gp;flv;bik|mp3;wav;wma;ogg;ac3|bak;gid;log;tmp' & _
		'|htm;html;css;js;php|bmp;gif;jpg;jpeg;png;tif;tiff|exe;msi;scr;dll;cpl;ax|com;sys;bat;cmd'
HotKeySet('{ESC}', "_Exit") ; выход по ESC

; En
$LngTitle = 'Search duplicates'
$LngSB = 'Statusbar'
$LngRe = 'Restart Search duplicates'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngF = 'Folders, files (drag-and-drop)'
$LngD = 'Duplicates'
$LngOpen = 'Open'
$LngAllChH = 'Checked / Unchecked in list'
$LngOpFd = 'Folder'
$LngOpFl = 'File'
$LngbSet = 'Setting'
$LngCl = 'Clear'
$LngSe = 'Search'
$LngDel = 'Delete'
$LngErr = 'Error'
$LngErrM = 'Incorrect mask'
$LngErrD = 'impossible delete files'
$LngErrFld1 = 'Replays folders:'
$LngErrFld2 = 'subfolders:'
$LngErrFile1 = 'Replays files:'
$LngErrFile2 = 'subfiles:'
$LngErrLmt = 'The number of added objects are exceeded, not all added to the list'
$LngErrM3 = 'Files that are not able to hash.' & @CRLF & @CRLF
$LngSDelD = 'Start Delete...'
$LngEDelD = 'Deleted files: '
$LngCrLF = 'Creation of the list of files and preparation for hashing'
$LngSBttl = 'Total: '
$LngRes = 'Create a list of results'
$LngSBD = 'Duplicates: '
$LngCur = ', current: '
$LngGr = ', group: '
$LngAdd = ', added: '
$LngTm = ', time: '
; $LngSize=' sec, size: '
$LngKb = 'kb'
$LngErrSD = ' Files-duplicates is not found!'
$LngCh = ', marked: ' ;checked ???
$LngSec = ' sec'
$LngEnd = 'Finish! '
$lngMsk = 'Mask'
$lngInc = 'Search for all except those in the mask'
$lngSub = 'In sub-directories'
$LngSBsz = 'Comparison of the size and preparation for hashing'
$LngSBsrt = 'Create a list of duplicates and sorting'
$LngOpEpl = 'Open in Explorer'
$LngScsv = 'Data file'
$LngScsv2 = 'Save As ...'
$LngSB1 = 'You save a CSV file'
$LngErrCSV1 = 'Error in CSV, will not be added'
$LngSBadd = 'Added CSV-file:'
$LngErrCSV2 = 'Error in CSV'
$lngMrgCSV = 'Merge CSV'
$LngLns = 'lines'
$LngNoF = 'File not found'
$LngScrollAbt = 'Search duplicates' & @CRLF & _
		'Поиск дубликатов файлов.' & @CRLF & @CRLF & _
		'The utility creates the file list ' & _
		'and checks the match in size ' & _
		'And then again verifies the checksum MD5. ' & _
		'Execution speed depends on the number of files and number of duplicates that need to calculate MD5 ' & @CRLF & @CRLF & _
		'The utility is written in AutoIt3' & @CRLF & _
		'autoitscript.com'


; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngSB = 'Строка состояния'
	$LngRe = 'Перезапуск утилиты'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngCopy = 'Копировать'
	$LngF = 'Папки, файлы (используйте drag-and-drop)'
	$LngD = 'Дубликаты'
	$LngOpen = 'Открыть'
	$LngAllChH = 'Снять или поставить галочки в списке'
	$LngOpFd = 'Папка'
	$LngOpFl = 'Файл'
	$LngbSet = 'Опции'
	$LngCl = 'Очистить'
	$LngSe = 'Поиск'
	$LngDel = 'Удалить'
	$LngErr = 'Ошибка'
	$LngErrM = 'Неверно указана маска'
	$LngErrD = 'Эти файлы не удалось удалить'
	$LngErrFld1 = 'Повторы папок:'
	$LngErrFld2 = 'Вложенные папки:'
	$LngErrFile1 = 'Повторы файлов:'
	$LngErrFile2 = 'Вложенные файлы:'
	$LngErrLmt = 'Количество добавляемых объектов превышено, не все добавлены в список'
	$LngErrM3 = 'Файлы, которые не удалось хешировать.' & @CRLF & @CRLF
	$LngSDelD = 'Удаление выполняется..'
	$LngEDelD = 'Удалено файлов: '
	$LngCrLF = 'Создание списка файлов и подготовка к хешированию'
	$LngSBttl = 'Всего: '
	$LngRes = 'Создание списка результатов'
	$LngSBD = 'Дубликаты: '
	$LngCur = ', текущий: '
	$LngGr = ', групп: '
	$LngAdd = ', добавлено: '
	$LngTm = ', время: '
	; $LngSize=' сек, размер: '
	$LngKb = 'кб'
	$LngErrSD = ' файлов, дубликатов не найдено!'
	$LngCh = ', отмечено: '
	$LngSec = ' сек'
	$LngEnd = 'Готово! '
	$lngMsk = 'Маска'
	$lngInc = 'Искать, кроме указанных в маске'
	$lngSub = 'В подкаталогах'
	$LngSBsz = 'Сравнение по размеру и подготовка к хешированию'
	$LngSBsrt = 'Создание списка дубликатов MD5 и сортировка'
	$LngOpEpl = 'Открыть в проводнике'
	$LngScsv = 'Файл данных'
	$LngScsv2 = 'Сохранить как ...'
	$LngSB1 = 'Выполняется сохранение CSV'
	$LngErrCSV1 = 'Допущена ошибка в CSV, не будет добавлен'
	$LngSBadd = 'Добавлен CSV-файл:'
	$LngErrCSV2 = 'Допущена ошибка в CSV'
	$lngMrgCSV = 'Объединить CSV'
	$LngLns = 'строк'
	$LngNoF = 'Файлов не найдено'
	$LngScrollAbt = 'Search duplicates' & @CRLF & _
			'Поиск дубликатов файлов.' & @CRLF & @CRLF & _
			'Утилита производит создание списка файлов ' & _
			'и сверяет совпадения по размеру ' & _
			'И далее совпавшие снова сверяет по контрольным суммам MD5. ' & _
			'Скорость выполнения зависит от количества файлов и количества дубликатов, которым требуется вычисление MD5 ' & @CRLF & @CRLF & _
			'Утилита написана на AutoIt3' & @CRLF & _
			'autoitscript.com'
EndIf

Switch @OSVersion
	Case "WIN_2003", "WIN_XP", "WIN_XPe", "WIN_2000"
		$Tr7=0
EndSwitch

If Not FileExists($ini) Then
	$file = FileOpen($ini, 2)
	FileWrite($file, '[Set]' & @CRLF & _
			'TypeFile=' & $TypeFile & @CRLF & _
			'W=500' & @CRLF & _
			'H=428' & @CRLF & _
			'X=' & @CRLF & _
			'Y=')
	FileClose($file)
EndIf

$TypeFile = IniRead($ini, 'Set', 'TypeFile', $TypeFile)

$XYPos[0] = Number(IniRead($ini, 'Set', 'W', '500'))
$XYPos[1] = Number(IniRead($ini, 'Set', 'H', '428'))
$XYPos[2] = IniRead($ini, 'Set', 'X', '')
$XYPos[3] = IniRead($ini, 'Set', 'Y', '')

If $XYPos[0] < 349 Then $XYPos[0] = 349
If $XYPos[1] < 262 Then $XYPos[1] = 262
_SetCoor($XYPos)

$Gui = GUICreate($LngTitle, $XYPos[0], $XYPos[1], $XYPos[2], $XYPos[3], $WS_OVERLAPPEDWINDOW, $WS_EX_ACCEPTFILES)

If @Compiled Then
	$AutoItExe = @AutoItExe
Else
	$AutoItExe = @ScriptDir & '\Search_duplicates.dll'
	GUISetIcon($AutoItExe, 1)
EndIf
Global $hImgLst[6]
For $i = 0 To 5
	$hImgLst[$i] = _GUIImageList_Create(16, 16, 5, BitOR(0x00000001, 0x00000020), 0, 1)
	_GUIImageList_AddIcon($hImgLst[$i], $AutoItExe, -201 - $i)
Next

GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

$StatusBar = GUICtrlCreateLabel($LngSB, 5, $XYPos[1] - 18, $XYPos[0] - 10, 17)
GUICtrlSetResizing(-1, 512 + 4 + 64 + 2)

$restart = GUICtrlCreateButton("R", $XYPos[0] - 20, 2, 18, 20)
GUICtrlSetTip(-1, $LngRe)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_Restart")

$About = GUICtrlCreateButton("@", $XYPos[0] - 40, 2, 18, 20)
GUICtrlSetTip(-1, $LngAbout)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_About")

GUICtrlCreateLabel($LngF, 15, 10, 240, 17)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
$folder = GUICtrlCreateList("", 10, 25, $XYPos[0] - 20, 100, $WS_TABSTOP + $LBS_NOTIFY + $LBS_SORT + $WS_VSCROLL)
GUICtrlSetResizing(-1, 6 + 32 + 512)

GUICtrlCreateLabel($LngD, 15, 132, 60, 18)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)

_Dubl()

$bSaveCSV = GUICtrlCreateButton('CSV', $XYPos[0] - 285, 123, 65, 25)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_SaveCSV")
_GUICtrlButton_SetImageList(-1, $hImgLst[5], 0)

$bAddCSV = GUICtrlCreateButton('CSV', $XYPos[0] - 215, 123, 65, 25)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_AddCSV")
_GUICtrlButton_SetImageList(-1, $hImgLst[4], 0)

$bOpenFld = GUICtrlCreateButton($LngOpFd, $XYPos[0] - 145, 123, 65, 25)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_OpenFolder")
_GUICtrlButton_SetImageList(-1, $hImgLst[4], 0)

$bOpenFile = GUICtrlCreateButton($LngOpFl, $XYPos[0] - 75, 123, 65, 25)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_OpenFile")
_GUICtrlButton_SetImageList(-1, $hImgLst[4], 0)

; $Select = GUICtrlCreateButton("Select", 180, 355, 70, 25)
; GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$hAllChec = GUICtrlCreateCheckbox('', 10, $XYPos[1] - 38, 16, 16)
GUICtrlSetOnEvent(-1, "_AllChec")
GUICtrlSetResizing(-1, 2 + 64 + 256 + 512)
GUICtrlSetTip(-1, $LngAllChH)
GUICtrlSetState(-1, $GUI_HIDE)

$b2 = GUICtrlCreateButton($LngbSet, $XYPos[0] - 325, $XYPos[1] - 43, 75, 25)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)
GUICtrlSetOnEvent(-1, "_Setting")
_GUICtrlButton_SetImageList(-1, $hImgLst[3], 0)

$Clear = GUICtrlCreateButton($LngCl, $XYPos[0] - 245, $XYPos[1] - 43, 75, 25)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetOnEvent(-1, "_Clear")
_GUICtrlButton_SetImageList(-1, $hImgLst[2], 0)

$Delete = GUICtrlCreateButton($LngDel, $XYPos[0] - 165, $XYPos[1] - 43, 75, 25)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetOnEvent(-1, "_Delete")
_GUICtrlButton_SetImageList(-1, $hImgLst[1], 0)

$Search = GUICtrlCreateButton($LngSe, $XYPos[0] - 85, $XYPos[1] - 43, 75, 25)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetOnEvent(-1, "_SearchDubl")
_GUICtrlButton_SetImageList(-1, $hImgLst[0], 0)

$ContMenu = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
GUICtrlCreateMenuItem($LngOpEpl, $ContMenu)
GUICtrlSetOnEvent(-1, "_OpenExplorer")
$hMenu = GUICtrlGetHandle($ContMenu)

GUISetState()

GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")
GUIRegisterMsg($WM_NOTIFY, 'WM_NOTIFY')
GUIRegisterMsg($WM_SIZE, "WM_SIZE")
GUIRegisterMsg($WM_WINDOWPOSCHANGING, "WM_WINDOWPOSCHANGING")
Global Const $WM_DROPFILES = 0x0233 ; в AutoIt3 v3.3.6.1 эта константа не определена
GUIRegisterMsg($WM_DROPFILES, "WM_DROPFILES")
OnAutoItExitRegister("_Exit_Save_Ini")
_Crypt_Startup()

While 1
	Sleep(1000000)
WEnd

Func _Exit_Save_Ini()
	IniWrite($ini, 'Set', 'W', $XYPos[0])
	IniWrite($ini, 'Set', 'H', $XYPos[1])
	IniWrite($ini, 'Set', 'X', $XYPos[2])
	IniWrite($ini, 'Set', 'Y', $XYPos[3])
EndFunc   ;==>_Exit_Save_Ini

Func _AddCSV()
	Local $OpenFile, $s, $n, $Tmp, $k
	$OpenFile = FileOpenDialog($LngOpen, @WorkingDir, $LngScsv & ' (*.csv)', 3, '', $Gui)
	If @error Then Return
	$n = StringRegExpReplace($OpenFile, '(^.*)\\(.*)$', '\2')
	If $CSVname And StringInStr('|' & $CSVpath & '|', '|' & $OpenFile & '|') Then Return MsgBox(0, $LngErr, $LngErrFile1 & @CRLF & $n, 0, $Gui)

	$s = FileRead($OpenFile)
	$Tmp = StringRegExpReplace($s & @CRLF, '(?i)\d+\|0x[a-f0-9]{32}\r\n', '')
	$k = @extended
	If StringLen($Tmp) Then Return MsgBox(0, $LngErr, $LngErrCSV1, 0, $Gui)
	If $AllCSV = '' Then
		$AllCSV = $s
		$CSVname = '<' & $n & '> (' & $k & ' ' & $LngLns & ')'
		$CSVpath = $OpenFile
	Else
		$AllCSV &= @CRLF & $s
		$CSVname &= '|<' & $n & '> (' & $k & ' ' & $LngLns & ')'
		$CSVpath &= '|' & $OpenFile
	EndIf
	
	GUICtrlSetData($folder, '<' & $n & '> (' & $k & ' ' & $LngLns & ')')
	GUICtrlSetData($StatusBar, $LngSBadd & '  ' & $n)
EndFunc   ;==>_AddCSV

Func _SaveCSV()
	Local $sCSV, $aFolderList, $Tmp, $aArr0, $SaveFile
	If $AllBox = '' Then Return

	$SaveFile = FileSaveDialog($LngScsv2, @WorkingDir, $LngScsv & ' (*.csv)', 24, 'Data', $Gui)
	If @error Then Return
	If StringRight($SaveFile, 4) <> '.csv' Then $SaveFile &= '.csv'

	GUICtrlSetData($StatusBar, $LngSB1)
	$sCSV = ''
	$timer = TimerInit()
	If StringLeft($AllBox, 1) = '|' Then $AllBox = StringTrimLeft($AllBox, 1)
	$aFolderList = StringSplit($AllBox, '|')
	; Объединение списков файлов входных папок
	For $i = 1 To $aFolderList[0]
		If FileExists($aFolderList[$i]) Then
			If StringInStr(FileGetAttrib($aFolderList[$i]), "D") Then
				$Tmp = _FO_FileSearch($aFolderList[$i], _FO_CorrectMask(StringReplace($Mask, ';', '|')), $TrInc, $TrSub, 1, 0, 0)
				If @error = 1 Or @error = 2 Then Return MsgBox(0, $LngErr, $LngErrM, 0, $Gui)
				If $Tmp Then $sCSV &= $Tmp & @CRLF
			Else
				$sCSV &= $aFolderList[$i] & @CRLF
			EndIf
		EndIf
	Next
	
	If $sCSV = '' Then Return MsgBox(0, $LngErr, $LngNoF, 0, $Gui)
	$aArr0 = StringSplit(StringTrimRight($sCSV, 2), @CRLF, 1)
	$sCSV = ''

	$TotalSize = 0
	Dim $aArr[$aArr0[0] + 1][2]
	$aArr[0][0] = $aArr0[0]
	For $i = 1 To $aArr0[0]
		$Tmp = FileGetSize($aArr0[$i])
		If @error Then $Tmp = ''
		$aArr[$i][0] = $Tmp
		$TotalSize += $Tmp
	Next
	
	$Size = 0

	$err = ''
	$GuiPos = WinGetClientSize($Gui)
	
	GUICtrlSetState($StatusBar, $GUI_HIDE)
	$ProgressBar = GUICtrlCreateProgress(5, $GuiPos[1] - 18, $GuiPos[0] - 10, 17)
	GUICtrlSetResizing(-1, 512 + 4 + 64 + 2)
	
	For $i = 1 To $aArr[0][0]
		$Size += $aArr[$i][0]
		GUICtrlSetData($ProgressBar, $Size / $TotalSize * 100)
		$Tmp = _Crypt_HashFile($aArr0[$i], $CALG_MD5)
		If @error Then
			$err &= $aArr0[$i] & @CRLF
			$Tmp = ''
		EndIf
		$aArr[$i][1] = $Tmp
	Next
	GUICtrlDelete($ProgressBar)
	GUICtrlSetState($StatusBar, $GUI_SHOW)
	$aArr = _ArrayUnique3($aArr)
	If @error Then Return
	For $i = 1 To $aArr[0][0]
		$sCSV &= $aArr[$i][0] & '|' & $aArr[$i][1] & @CRLF
	Next
	
	If StringLen(StringRegExpReplace($sCSV, '(?i)\d+\|0x[a-f0-9]{32}\r\n', '')) Then MsgBox(0, $LngErr, $LngErrCSV2, 0, $Gui)
	$file = FileOpen($SaveFile, 2)
	FileWrite($file, StringTrimRight($sCSV, 2))
	FileClose($file)
	
	GUICtrlSetData($StatusBar, $LngEnd & $LngSBttl & $aArr0[0] & $LngAdd & $aArr[0][0] & $LngTm & Ceiling(TimerDiff($timer) / 1000) & $LngSec)
	If $err Then MsgBox(0, $LngErr, $LngErrM3 & $err, 0, $Gui)
EndFunc   ;==>_SaveCSV

Func _ArrayUnique3($data)
	Local $k, $i
	Assign('/', -1000000, 1)
	If IsArray($data) Then
		$k = 1
		For $i = 1 To $data[0][0]
			Assign($data[$i][1] & '/', Eval($data[$i][1] & '/') + 1, 1)
			If Eval($data[$i][1] & '/') = 1 Then
				$data[$k][0] = $data[$i][0]
				$data[$k][1] = $data[$i][1]
				$k += 1
			EndIf
		Next
		If $k = 1 Then Return SetError(1, 0, 0)
		ReDim $data[$k][2]
		$data[0][0] = $k - 1
		Return $data
	EndIf
EndFunc   ;==>_ArrayUnique3

Func _Setting()
	GUIRegisterMsg($WM_SIZE, "")
	GUIRegisterMsg($WM_WINDOWPOSCHANGING, "")
	$GP = _ChildCoor($Gui, 340, 170)
	GUISetState(@SW_DISABLE, $Gui)
	$Gui1 = GUICreate($LngbSet, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 1)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit2")

	GUICtrlCreateLabel($lngMsk, 10, 13, 40, 17)
	$ComboMask = GUICtrlCreateCombo("", 50, 10, 280)
	GUICtrlSetTip(-1, "Используйте маску, чтобы" & @CRLF & "ускорить поиск дубликатов")
	; GUICtrlSetData(-1, $TypeFile, StringRegExpReplace($TypeFile, '^(.*?)\|.*', '\1'))
	GUICtrlSetData(-1, '*|' & $TypeFile, '*')
	
	$hChInc = GUICtrlCreateCheckbox($lngInc, 10, 40, 260, 17)
	If Not $TrInc Then GUICtrlSetState(-1, 1)
	$hChSub = GUICtrlCreateCheckbox($lngSub, 10, 60, 260, 17)
	If $TrSub = 125 Then GUICtrlSetState(-1, 1)
	
	
	$hMrgCSV = GUICtrlCreateButton($lngMrgCSV, 10, 85, 100, 25)
	If $CSVname = '' Then GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "_MergeCSV")

	$OK = GUICtrlCreateButton("OK", ($GP[2] - 60) / 2, $GP[3] - 48, 60, 30)
	GUICtrlSetOnEvent(-1, "_OK")
	
	GUISetState(@SW_SHOW, $Gui1)
EndFunc   ;==>_Setting

Func _MergeCSV()
	$SaveFile = FileSaveDialog($LngScsv2, @WorkingDir, $LngScsv & ' (*.csv)', 24, 'Data', $Gui)
	If @error Then Return
	If StringRight($SaveFile, 4) <> '.csv' Then $SaveFile &= '.csv'
	
	$a = StringSplit($AllCSV, @CRLF, 1)
	$a = _ArrayDublLines($a)
	$AllCSV = ''
	For $i = 1 To $a[0]
		$AllCSV &= $a[$i] & @CRLF
	Next
	If StringLen(StringRegExpReplace($AllCSV, '(?i)\d+\|0x[a-f0-9]{32}\r\n', '')) Then MsgBox(0, $LngErr, $LngErrCSV2, 0, $Gui1)
	$file = FileOpen($SaveFile, 2)
	FileWrite($file, StringTrimRight($AllCSV, 2))
	FileClose($file)
EndFunc   ;==>_MergeCSV

Func _OK()
	$Mask = GUICtrlRead($ComboMask)
	
	If GUICtrlRead($hChInc) = 1 Then
		$TrInc = False
	Else
		$TrInc = True
	EndIf
	
	If GUICtrlRead($hChSub) = 1 Then
		$TrSub = 125
	Else
		$TrSub = 0
	EndIf
	_Exit2()
EndFunc   ;==>_OK

Func _Exit2()
	GUISetState(@SW_ENABLE, $Gui)
	GUIDelete($Gui1)
	GUIRegisterMsg($WM_SIZE, "WM_SIZE")
	GUIRegisterMsg($WM_WINDOWPOSCHANGING, "WM_WINDOWPOSCHANGING")
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
EndFunc   ;==>_Exit2

Func _OpenFolder()
	$Tmp = FileSelectFolder($LngOpen, '', 2, '', $Gui)
	If @error Then Return
	_CreateList($Tmp)
EndFunc   ;==>_OpenFolder

Func _OpenFile()
	$Tmp = FileOpenDialog($LngOpen, @WorkingDir, 'All (*.*)', 7, '', $Gui)
	If @error Then Return
	If StringInStr($Tmp, '|') Then
		$aTmp = StringSplit($Tmp, '|')
		$Tmp = ''
		For $i = 2 To $aTmp[0]
			$Tmp &= '|' & $aTmp[1] & '\' & $aTmp[$i]
		Next
	EndIf
	_CreateList($Tmp)
EndFunc   ;==>_OpenFile

Func WM_DROPFILES($hwnd, $msg, $wParam, $lParam)
	Local $aRet = DllCall("shell32.dll", "int", "DragQueryFile", "int", $wParam, "int", -1, "ptr", 0, "int", 0)
	If @error Then Return SetError(1, 0, 0)
	Local $sDroppedFiles, $i, $tBuffer = DllStructCreate("char[256]")
	For $i = 0 To $aRet[0] - 1 ; цикл запрашивает все объекты
		DllCall("shell32.dll", "int", "DragQueryFile", "int", $wParam, "int", $i, "ptr", DllStructGetPtr($tBuffer), "int", DllStructGetSize($tBuffer))
		$sDroppedFiles &= DllStructGetData($tBuffer, 1) & '|' ; имя файла присоединяем к результату
	Next
	DllCall("shell32.dll", "none", "DragFinish", "int", $wParam)
	$tBuffer = 0
	_CreateList(StringTrimRight($sDroppedFiles, 1))
	; WinActivate($Gui)
	Return "GUI_RUNDEFMSG"
EndFunc   ;==>WM_DROPFILES

Func _CreateList($Tmp)
	Local $ErrLislFld = '', $ErrLislFld2 = '', $ErrLislFile = '', $ErrLislFile2 = '', $aTest, $ErrAll, $FolderBox = '', $FileBox = '', $kol1, $kol2, $kol3, $kol4, $kolS
	$kolS = StringLen($Tmp)
	If $kolS >= 30000 Then $Tmp = StringLeft($Tmp, StringInStr($Tmp, '|', 0, -1) - 1)
	$AllBox &= '|' & $Tmp
	If StringLeft($AllBox, 1) = '|' Then $AllBox = StringTrimLeft($AllBox, 1)
	$aTmp = StringSplit($AllBox, '|')
	
	For $i = 1 To $aTmp[0]
		If StringLen($aTmp[$i]) < 4 Then ContinueLoop ; исключил корневые диски
		If StringInStr(FileGetAttrib($aTmp[$i]), "D") Then
			$FolderBox &= '|' & $aTmp[$i]
		Else
			$FileBox &= '|' & $aTmp[$i]
		EndIf
	Next
	$FolderBox = StringTrimLeft($FolderBox, 1)
	$FileBox = StringTrimLeft($FileBox, 1)
	; проверка повторов
	If StringInStr($FileBox, '|') Then
		$ErrLislFile &= _ArrayUnique2($FileBox)
		$kol1 = @extended
	EndIf
	If StringInStr($FolderBox, '|') Then ; если содержит '|' то проверяем повторы и вложенности
		$ErrLislFld &= _ArrayUnique2($FolderBox)
		$kol2 = @extended
		; проверка вложенных папок
		$aTest = StringSplit($FolderBox, '|')
		$FolderBox = ''
		$kol3 = 0
		For $i = 1 To $aTest[0]
			If $aTest[$i] = '' Then ContinueLoop
			For $j = 1 To $aTest[0]
				If $aTest[$j] = '' Or $i = $j Then ContinueLoop
				If StringInStr($aTest[$i] & '\', $aTest[$j] & '\') Then
					$ErrLislFld2 &= @CRLF & $aTest[$i]
					$aTest[$i] = ''
					$kol3 += 1
				EndIf
			Next
		Next
		For $i = 1 To $aTest[0]
			If $aTest[$i] = '' Then ContinueLoop
			$FolderBox &= '|' & $aTest[$i]
		Next
		$FolderBox = StringTrimLeft($FolderBox, 1)
	EndIf
	; проверяем вложенность файлов в папку
	If $FolderBox And $FileBox Then
		$aTest = StringSplit($FolderBox, '|')
		$aTestFile = StringSplit($FileBox, '|')
		$FileBox = ''
		$kol4 = 0
		For $i = 1 To $aTestFile[0]
			For $j = 1 To $aTest[0]
				If StringInStr($aTestFile[$i], $aTest[$j] & '\') Then
					$ErrLislFile2 &= @CRLF & $aTestFile[$i]
					$aTestFile[$i] = ''
					$kol4 += 1
				EndIf
			Next
		Next
		For $i = 1 To $aTestFile[0]
			If $aTestFile[$i] = '' Then ContinueLoop
			$FileBox &= '|' & $aTestFile[$i]
		Next
		$FileBox = StringTrimLeft($FileBox, 1)
	EndIf
	$AllBox = $FolderBox & '|' & $FileBox
	$aTest = StringRegExp($AllBox & '|', '([^\\]*?)(?:\|)', 3)
	Local $AllBox0 = ''
	For $i = 0 To UBound($aTest) - 1
		$AllBox0 &= '|' & $aTest[$i]
	Next
	If $CSVname Then $AllBox0 &= '|' & $CSVname
	$AllBox0 = StringReplace($AllBox0, '||', '|')
	GUICtrlSetData($folder, '')
	GUICtrlSetData($folder, StringTrimLeft($AllBox0, 1))
	If $kolS >= 30000 Then $ErrAll &= @CRLF & @CRLF & $LngErrLmt
	If $ErrLislFld Then $ErrAll &= @CRLF & @CRLF & $LngErrFld1 & ' ' & $kol2 & @CRLF & StringRegExpReplace($ErrLislFld, '(?m)^(?:.*\\)(.*)$', '\1')
	If $ErrLislFile Then $ErrAll &= @CRLF & @CRLF & $LngErrFile1 & ' ' & $kol1 & @CRLF & StringRegExpReplace($ErrLislFile, '(?m)^(?:.*\\)(.*)$', '\1')
	If $ErrLislFld2 Then $ErrAll &= @CRLF & @CRLF & $LngErrFld2 & ' ' & $kol3 & @CRLF & StringRegExpReplace($ErrLislFld2, '(?m)^(?:.*\\)(.*)$', '\1')
	If $ErrLislFile2 Then $ErrAll &= @CRLF & @CRLF & $LngErrFile2 & ' ' & $kol4 & @CRLF & StringRegExpReplace($ErrLislFile2, '(?m)^(?:.*\\)(.*)$', '\1')
	If UBound(StringRegExp($ErrAll, '(\r\n|\r|\n)', 3)) > 20 Then $ErrAll = StringRegExpReplace($ErrAll, '(?<=\S)(\r\n)(?=\S)', ', ')
	If $ErrAll Then MsgBox(0, $LngErr, StringTrimLeft($ErrAll, 4), 0, $Gui) ; вывод ошибок
EndFunc   ;==>_CreateList

Func _ArrayUnique2(ByRef $data)
	Local $k, $i, $a, $err = ''
	Assign('/', -1000000, 1)
	$a = StringSplit($data, '|')
	$data = ''
	$k = 0
	For $i = 1 To $a[0]
		Assign($a[$i] & '/', Eval($a[$i] & '/') + 1, 1)
		If Eval($a[$i] & '/') = 1 Then
			$data &= '|' & $a[$i]
		ElseIf Eval($a[$i] & '/') = 2 Then
			$err &= @CRLF & $a[$i]
			$k += 1
		EndIf
	Next
	$data = StringTrimLeft($data, 1)
	Return SetError(0, $k, $err)
EndFunc   ;==>_ArrayUnique2

Func _Clear()
	; GUICtrlDelete($Dubl)
	; _Dubl()
	If $Tr7 Then _GUICtrlListView_BeginUpdate($Dubl)
	_GUICtrlListView_DeleteAllItems($Dubl)
	If $Tr7 Then _GUICtrlListView_EndUpdate($Dubl)
	$GuiPos = WinGetClientSize($Gui)
	_GUICtrlListView_SetColumnWidth($Dubl, 0, $GuiPos[0] - 45)
	
	$AllBox = ''
	$AllCSV = ''
	$CSVname = ''
	$CSVpath = ''
	GUICtrlSetData($folder, '')
	$aSizePath = ''
	$aArr = ''
	GUICtrlSetState($hAllChec, $GUI_HIDE)
	GUICtrlSetData($StatusBar, $LngSB)
EndFunc   ;==>_Clear

Func _Delete()
	If $AllBox = '' Or Not IsArray($aArr) Then Return
	GUICtrlSetData($StatusBar, $LngSDelD)
	$kol = 0
	$ErrDel = ''
	If $Tr7 Then _GUICtrlListView_BeginUpdate($Dubl)
	For $i = 1 To $aArr[0][0]
		If GUICtrlRead($aArr[$i][3], 1) = 1 And FileExists($aArr[$i][0]) Then
			FileSetAttrib($aArr[$i][0], "-RST")
			If FileDelete($aArr[$i][0]) Then
				$kol += 1
				GUICtrlDelete($aArr[$i][3])
				$aArr[$i][0] = ''
				$aArr[$i][3] = ''
			Else
				$ErrDel &= $aArr[$i][0] & @CRLF
			EndIf
		EndIf
	Next
	If $Tr7 Then _GUICtrlListView_EndUpdate($Dubl)
	_GUICtrlListView_SetColumnWidth($Dubl, 0, $LVSCW_AUTOSIZE)
	$GuiPos = WinGetClientSize($Gui)
	If _GUICtrlListView_GetColumnWidth($Dubl, 0) < $GuiPos[0] - 45 Then _GUICtrlListView_SetColumnWidth($Dubl, 0, $GuiPos[0] - 45)
	GUICtrlSetData($StatusBar, $LngEDelD & $kol)
	If $ErrDel Then MsgBox(0, $LngErr, $LngErrD, 0, $Gui)
EndFunc   ;==>_Delete

Func _AllChec()
	If $aSizePath Then
		If $Tr7 Then _GUICtrlListView_BeginUpdate($Dubl)
		If GUICtrlRead($hAllChec) = 1 Then
			$TempMD5 = ''
			For $i = 1 To $aArr[0][0]
				If $aArr[$i][2] = $TempMD5 Then GUICtrlSetState($aArr[$i][3], 1)
				$TempMD5 = $aArr[$i][2]
			Next
		Else
			For $i = 1 To $aArr[0][0]
				GUICtrlSetState($aArr[$i][3], 4)
			Next
		EndIf
		If $Tr7 Then _GUICtrlListView_EndUpdate($Dubl)
	EndIf
EndFunc   ;==>_AllChec

Func _SearchDubl()
	If $AllBox = '' Then Return
	If $aSizePath Then
		If $Tr7 Then _GUICtrlListView_BeginUpdate($Dubl)
		_GUICtrlListView_DeleteAllItems($Dubl)
		If $Tr7 Then _GUICtrlListView_EndUpdate($Dubl)
		GUICtrlSetBkColor($Dubl, 0xf0f0f0)
		$GuiPos = WinGetClientSize($Gui)
		_GUICtrlListView_SetColumnWidth($Dubl, 0, $GuiPos[0] - 45)
		Sleep(50)
		$aArr = ''
	EndIf

	GUICtrlSetData($StatusBar, $LngCrLF)
	$aSizePath = ''
	$timer = TimerInit()
	If StringLeft($AllBox, 1) = '|' Then $AllBox = StringTrimLeft($AllBox, 1)
	$aFolderList = StringSplit($AllBox, '|')
	; Объединение списков файлов входных папок
	For $i = 1 To $aFolderList[0]
		If FileExists($aFolderList[$i]) Then
			If StringInStr(FileGetAttrib($aFolderList[$i]), "D") Then
				$Tmp = _FO_FileSearch($aFolderList[$i], _FO_CorrectMask(StringReplace($Mask, ';', '|')), $TrInc, $TrSub, 1, 0, 0)
				If @error = 1 Or @error = 2 Then Return MsgBox(0, $LngErr, $LngErrM, 0, $Gui)
				If $Tmp Then $aSizePath &= $Tmp & @CRLF
			Else
				$aSizePath &= $aFolderList[$i] & @CRLF
			EndIf
		EndIf
	Next

	If $aSizePath = '' Then
		GUICtrlSetData($StatusBar, $LngNoF)
		Return MsgBox(0, $LngErr, $LngNoF, 0, $Gui)
	EndIf
	$aArr0 = StringSplit(StringTrimRight($aSizePath, 2), @CRLF, 1)
	$aSizePath = '1'

	Dim $aArr[$aArr0[0] + 1][4]
	$aArr[0][0] = $aArr0[0]
	For $i = 1 To $aArr0[0]
		$aArr[$i][0] = $aArr0[$i]
		$Tmp = FileGetSize($aArr0[$i])
		If @error Then $Tmp = ''
		$aArr[$i][1] = $Tmp
	Next
	
	; If $AllCSV Then
	; $TrCSV=1
	; Else
	; $TrCSV=0
	; EndIf
	If $AllCSV Then
		$aAllCSV0 = StringSplit($AllCSV, @CRLF, 1)
		If StringInStr($CSVname, '<', 0, 2) Then $aAllCSV0 = _ArrayDublLines($aAllCSV0)
		$Tmp = $aArr[0][0]
		$aArr[0][0] += $aAllCSV0[0]
		ReDim $aArr[$aArr[0][0] + 1][4]
		For $i = 1 To $aAllCSV0[0]
			$tmp2 = StringSplit($aAllCSV0[$i], '|')
			$aArr[$i + $Tmp][0] = $i & ' - CSV'
			$aArr[$i + $Tmp][1] = $tmp2[1]
			$aArr[$i + $Tmp][2] = $tmp2[2]
		Next
	EndIf
	
	GUICtrlSetData($StatusBar, $LngSBsz)
	$aArr0 = $aArr0[0]
	_ArrayDublSize($aArr) ; возвращает только дубликаты по размеру
	If @error Then
		GUICtrlSetData($StatusBar, $LngSBttl & $aArr0 & $LngErrSD)
		$aArr = ''
		Return
	EndIf
	$TotalSize = @extended
	$Size = 0

	$err = ''
	$GuiPos = WinGetClientSize($Gui)
	
	GUICtrlSetState($StatusBar, $GUI_HIDE)
	$ProgressBar = GUICtrlCreateProgress(5, $GuiPos[1] - 18, $GuiPos[0] - 10, 17)
	GUICtrlSetResizing(-1, 512 + 4 + 64 + 2)
	
	For $i = 1 To $aArr[0][0]
		$Size += $aArr[$i][1]
		GUICtrlSetData($ProgressBar, $Size / $TotalSize * 100)
		If $aArr[$i][2] Then ExitLoop
		$Tmp = _Crypt_HashFile($aArr[$i][0], $CALG_MD5)
		If @error And $aArr[$i][0] Then
			$err &= $aArr[$i][0] & @CRLF
			$Tmp = ''
		EndIf
		$aArr[$i][2] = $Tmp
	Next
	GUICtrlDelete($ProgressBar)
	GUICtrlSetState($StatusBar, $GUI_SHOW)
	GUICtrlSetData($StatusBar, $LngSBsrt)
	
	_ArrayDublMD5($aArr)
	If @error Then
		GUICtrlSetData($StatusBar, $LngSBttl & $aArr0 & $LngErrSD)
		$aArr = ''
		Return
	EndIf

	$GP = 0
	$kol = 0
	$ch = 0
	$TempMD5 = ''

	_GUICtrlListView_SetColumnWidth($Dubl, 0, $GuiPos[0] - 45)
	GUICtrlSetData($StatusBar, $LngRes)
	_GUICtrlListView_BeginUpdate($Dubl)
	For $i = 1 To $aArr[0][0] ; MD5
		$kol += 1
		If $aArr[$i][2] <> $TempMD5 Then
			$GP += 1
			GUICtrlCreateListViewItem('---' & $GP & '---', $Dubl)
			GUICtrlSetColor(-1, 0x777777)
			GUICtrlSetBkColor(-1, 0xffffff)

			$aArr[$i][3] = GUICtrlCreateListViewItem($aArr[$i][0], $Dubl)
			GUICtrlSetColor(-1, 0x00B3A7)
		Else
			$ch += 1
			$aArr[$i][3] = GUICtrlCreateListViewItem($aArr[$i][0], $Dubl)
			GUICtrlSetState(-1, 1)
		EndIf
		$TempMD5 = $aArr[$i][2]
	Next
	_GUICtrlListView_EndUpdate($Dubl)
	_GUICtrlListView_SetColumnWidth($Dubl, 0, $LVSCW_AUTOSIZE)

	If _GUICtrlListView_GetColumnWidth($Dubl, 0) < $GuiPos[0] - 45 Then _GUICtrlListView_SetColumnWidth($Dubl, 0, $GuiPos[0] - 45)
	GUICtrlSetData($StatusBar, $LngEnd & $LngSBttl & $aArr0 & $LngGr & $GP & $LngAdd & $kol & $LngCh & $ch & $LngTm & Ceiling(TimerDiff($timer) / 1000) & $LngSec)
	GUICtrlSetState($hAllChec, $GUI_SHOW + $GUI_CHECKED)
	If $err Then MsgBox(0, $LngErr, $LngErrM3 & $err, 0, $Gui)
EndFunc   ;==>_SearchDubl

Func _ArrayDublLines($data)
	Local $k, $i
	Assign('/', -1000000, 1)
	$k = 1
	For $i = 1 To $data[0]
		Assign($data[$i] & '/', Eval($data[$i] & '/') + 1, 1)
		If Eval($data[$i] & '/') = 1 Then
			$data[$k] = $data[$i]
			$k += 1
		EndIf
	Next
	If $k = 1 Then Return SetError(1, 0, 0)
	ReDim $data[$k]
	$data[0] = $k - 1
	Return $data
EndFunc   ;==>_ArrayDublLines

Func _Dubl()
	; $GuiPos = WinGetClientSize($Gui)
	$Dubl = GUICtrlCreateListView(' ', 10, 150, $XYPos[0] - 20, $XYPos[1] - 198, $LVS_NOCOLUMNHEADER + $LVS_SHOWSELALWAYS, $LVS_EX_CHECKBOXES + $LVS_OWNERDRAWFIXED + $WS_EX_CLIENTEDGE)
	GUICtrlSendMsg($Dubl, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_FULLROWSELECT, $LVS_EX_FULLROWSELECT)
	GUICtrlSendMsg($Dubl, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_TRACKSELECT, $LVS_EX_TRACKSELECT)
	GUICtrlSetBkColor(-1, 0xf0f0f0) ; 0xE0DFE3
	GUICtrlSetResizing(-1, 6 + 32 + 64)
	$hDubl = GUICtrlGetHandle($Dubl)
EndFunc   ;==>_Dubl

Func WM_NOTIFY($hwnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iCode, $tNMHDR, $tInfo

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, 'hWndFrom'))
	$iCode = DllStructGetData($tNMHDR, 'Code')
	Switch $hWndFrom
		Case $hDubl
			Switch $iCode
				Case $NM_DBLCLK
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$iItem = DllStructGetData($tInfo, 'Index')
					If $iItem > -1 Then
						$Tmp = _GUICtrlListView_GetItemText($hDubl, $iItem)
						If FileExists($Tmp) Then ShellExecute('"' & $Tmp & '"')
					EndIf
				Case $NM_RCLICK
					Local $aSel = _GUICtrlListView_GetSelectedIndices($hDubl, 1)
					Switch $aSel[0]
						Case 1
							$ItemText = _GUICtrlListView_GetItemText($hDubl, $aSel[1])
							If StringRight($ItemText, 1) = '-' Then
								$ItemText = ''
								Return
							EndIf
							$x = MouseGetPos(0)
							$y = MouseGetPos(1)
							DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $Gui, "ptr", 0)
						Case Else
							Return
					EndSwitch
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _OpenExplorer()
	If FileExists($ItemText) Then Run('Explorer.exe /select,"' & $ItemText & '"')
	$ItemText = ''
EndFunc   ;==>_OpenExplorer

Func WM_GETMINMAXINFO($hwnd, $iMsg, $wParam, $lParam)
	If $hwnd = $Gui Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 357) ; минимальные размеры окна
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 300)
	EndIf
EndFunc   ;==>WM_GETMINMAXINFO

Func WM_SIZE($hwnd, $msg, $wParam, $lParam)
	$XYPos[0] = BitAND($lParam, 0x0000FFFF)
	$XYPos[1] = BitShift($lParam, 16)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE

Func WM_WINDOWPOSCHANGING($hwnd, $msg, $wParam, $lParam)
	Local $sRect = DllStructCreate("Int[6]", $lParam)
	Switch $Tr7
		Case 1
			If DllStructGetData($sRect, 1, 5) <> 0 And Not BitAND(WinGetState($Gui), 16) Then
				$XYPos[2] = DllStructGetData($sRect, 1, 3)
				$XYPos[3] = DllStructGetData($sRect, 1, 4)
			EndIf
		Case Else ; Если окно отпущено после перемещения, не вызвано диалогового окна, не свёрнуто при выходе, то сохраняем координаты в переменную
			If DllStructGetData($sRect, 1, 2) And DllStructGetData($sRect, 1, 5) <> 0 And Not BitAND(WinGetState($Gui), 16) Then
				$XYPos[2] = DllStructGetData($sRect, 1, 3)
				$XYPos[3] = DllStructGetData($sRect, 1, 4)
			EndIf
	EndSwitch
	Return 'GUI_RUNDEFMSG'
EndFunc   ;==>WM_WINDOWPOSCHANGING

Func _Exit()
	_Crypt_Shutdown()
	Exit
EndFunc   ;==>_Exit

Func _ArrayDublMD5(ByRef $a)
	Local $k, $i
	Assign('/', -100000000, 1)
	For $i = 1 To $a[0][0]
		Assign($a[$i][2] & '/', Eval($a[$i][2] & '/') & '|' & $a[$i][0], 1)
	Next

	$b = _ArrayUnique4($a)
	
	$k = 1
	For $i = 1 To $b[0][0]
		If StringInStr(Eval($b[$i][2] & '/'), '|', 0, 2) Then
			$aTmp = StringSplit(StringTrimLeft(Eval($b[$i][2] & '/'), 1), '|')
			For $j = $aTmp[0] To 1 Step -1
				$a[$k][0] = $aTmp[$j]
				$a[$k][1] = ''
				$a[$k][2] = $b[$i][2]
				$k += 1
			Next
		EndIf
	Next
	If $k = 1 Then
		Dim $a[1] = [0]
		Return SetError(1, 0, 0)
	EndIf
	ReDim $a[$k][4]
	$a[0][0] = $k - 1
EndFunc   ;==>_ArrayDublMD5

; создание локальных переменных в 34 символа не пересекаются с внутренними переменными
Func _ArrayUnique4($data)
	Local $k, $i
	Assign('', '', 1)
	$k = 1
	For $i = 1 To $data[0][0]
		If Not (IsDeclared($data[$i][2]) = -1) Then
			Assign($data[$i][2], '', 1)
			$data[$k][2] = $data[$i][2]
			$k += 1
		EndIf
	Next
	If $k = 1 Then Return SetError(1, 0, 0)
	ReDim $data[$k][4]
	$data[0][0] = $k - 1
	Return $data
EndFunc   ;==>_ArrayUnique4

Func _ArrayDublSize(ByRef $a)
	Local $k, $i, $TotalSize
	Assign('/', -100000000, 1)
	For $i = 1 To $a[0][0]
		Assign($a[$i][1] & '/', Eval($a[$i][1] & '/') + 1, 1)
	Next

	$k = 1
	$TotalSize = 0
	For $i = 1 To $a[0][0]
		If Eval($a[$i][1] & '/') > 1 Then
			$a[$k][0] = $a[$i][0]
			$a[$k][1] = $a[$i][1]
			$a[$k][2] = $a[$i][2]
			If $a[$i][2] = '' Then $TotalSize += $a[$i][1]
			$k += 1
		EndIf
	Next
	If $k = 1 Then
		Dim $a[1] = [0]
		Return SetError(1, 0, 0)
	EndIf
	ReDim $a[$k][4]
	$a[0][0] = $k - 1
	SetError(0, $TotalSize, 0)
EndFunc   ;==>_ArrayDublSize

Func _About()
	GUIRegisterMsg($WM_SIZE, "")
	GUIRegisterMsg($WM_WINDOWPOSCHANGING, "")
	$wAbt = 270
	$hAbt = 180
	$GP = _ChildCoor($Gui, $wAbt, $hAbt)
	$wAbtBt = 20
	$wA = $wAbt / 2 - 80
	$wB = $hAbt / 3 * 2
	$iScroll_Pos = -$hAbt
	$TrAbt1 = 0
	$TrAbt2 = 0
	$BkCol1 = 0xE1E3E7
	$BkCol2 = 0
	$GuiPos = WinGetPos($Gui)
	GUISetState(@SW_DISABLE, $Gui)
	$font = "Arial"

	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
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
	GUICtrlCreateLabel($LngVer & ' 0.5.1  04.03.2013', $wA, $wB - 36, 210, 17)
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
	GUISetState(@SW_ENABLE, $Gui)
	GUIDelete($Gui1)
	GUIRegisterMsg($WM_WINDOWPOSCHANGING, "WM_WINDOWPOSCHANGING")
	GUIRegisterMsg($WM_SIZE, "WM_SIZE")
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
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