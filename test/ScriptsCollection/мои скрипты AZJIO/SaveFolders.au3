;  @AZJIO 6.05.2011
; AutoIt3 v3.3.6.1.
; сохраняем несколько сессий, при старте программы все сессии в текущем каталоге будут найдены и можно переключаться между ними. Особенно удобно при переключениями между виндами или LiveCD, когда нужно открыть сессию каталогов, создав рабочую обстановку.
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=SaveFolders.exe
#AutoIt3Wrapper_Icon=SaveFolders.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=SaveFolders.exe
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/StripOnly
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;ModernMenuRaw.au3 - http://www.autoitscript.com/forum/index.php?showtopic=20967
#include <WindowsConstants.au3>
#include <File.au3>
#include <ListboxConstants.au3>
#include "ModernMenuRaw.au3"
#include <Array.au3>
; #include <user.au3>

#NoTrayIcon
Opt("GUIOnEventMode", 1)
Opt("TrayMenuMode", 7)

Global $sTmp, $d, $file, $file_open0, $obj = "[CLASS:Edit; INSTANCE:1]", $1a, $1f, $1n, $1g, $Tr7 = 0, $y = 0
Global $avTrayItems[1][4] ;создаём с чередующимся через три элемента массив, с элементами идентификации ID, имя пункта, имя меню. К массиву будем добавлять по три элемента группой.
Global $SessionM[1][6], $FolderM[1][5], $nMain, $Gui1, $nSetGui, $aPathS, $n, $Folderlist, $ChPos, $ChSml, $ChDskIni, $ChHK, $TrPos, $TrSml, $TrDskIni, $TrHK, $Ini=@ScriptDir&'\SaveFolders.ini'
$SessionM[0][0] = 0
$FolderM[0][0] = 0
; ID раздела, ID пункта, Полный путь, имя последнего каталога, возможно размер окна


If Not FileExists($Ini) And DriveStatus(StringLeft(@ScriptDir, 1))<>'NOTREADY' Then
$file = FileOpen($Ini,2)
FileWrite($file, _
'[Setting]' & @CRLF & _
'Pos=4' & @CRLF & _
'Sml=1' & @CRLF & _
'DskIni=1' & @CRLF & _
'HK=1')
FileClose($file)
EndIf

$TrPos = Execute(IniRead($Ini, 'Setting', 'Pos', '4'))
$TrSml = Execute(IniRead($Ini, 'Setting', 'Sml', '1'))
$TrDskIni = Execute(IniRead($Ini, 'Setting', 'DskIni', '1'))
$TrHK = Execute(IniRead($Ini, 'Setting', 'HK', '1'))

; Case 'WIN_2000', 'WIN_XP', 'WIN_2003'
Switch @OSVersion
	Case 'WIN_VISTA', 'WIN_7'
		$obj = "[CLASS:ToolbarWindow32; INSTANCE:2]"
		$Tr7 = 1
	Case Else
		If $TrHK = 1 Then HotKeySet("{F2}", "_Rename") ; переименование файлов не затрагивая расширение
EndSwitch

If $TrHK = 1 Then
; HotKeySet('!{ESC}', "_Quit") ;по желанию выход по ALT+ESC
HotKeySet("{F1}", "_Rename2") ; переименование файлов
HotKeySet("{F9}", "_CreateFT") ; создаём папку
$CrTx = "{F10}"
HotKeySet($CrTx, "_CreateFT") ; создаём файл текстовый
EndIf

$LngTitle='SaveFolders'
; En
$LngVer='Version'
$LngSite='Site'
$LngCopy='Copy'
$LngES = 'Edit session'
$LngDad = 'drag-and-drop'
$LngAdd = 'Add'
$LngDel = 'Remove item'
$LngRe = 'Rerun'
$LngReH = 'To update the tray' & @CRLF & 'needs to be restarted'
$LngCS = 'current startup'
$LngOF = 'Open these directories'
$LngAc = 'Actions'
$LngEx = 'Exit'
$LngRS = 'Rerun to update the list of current'
$LngSR = 'Save open folders and rerun'
$LngCf = 'Close the open folders'
$LngAdS = 'Add session'
$LngFP = 'Program Folder'
$LngSet = 'Setting'
$LngEr = 'Error'
$LngM1 = 'Unable to open file.'
$LngM2 = 'Предупреждение'
$LngM3 = 'Path exists in the session' & @CRLF & 'and will not be added.'
$LngFs = 'Select Folder'
$LngOs = 'Open session'
$LngCf1 = 'Close these directories'
$LngSS = 'Save Session'
$LngID = 'Not Found ID'
$LngM4 = 'No folders'
$LngAbout = "About"
$LngAbT2 = "Hot keys" & @CRLF & _
		"F1 - rename extension" & @CRLF & _
		"F2 - renamed without extension" & @CRLF & _
		"F9 - create a folder" & @CRLF & _
		"F10 - create a text file"
$LngCPs='Take into account the position and size'
$LngSml='Reduce the long path'
$LngDico='Display the icons of folders'
$LngHKe='Use HotKey'


$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если есть русский в раскладках клавиатуры, то использовать его
If $UserIntLang = 0419 Then
	$LngVer='Версия'
	$LngSite='Сайт'
	$LngCopy='Копировать'
	$LngES = 'Редактировать сессию'
	$LngDad = 'используйте drag-and-drop'
	$LngAdd = 'Добавить'
	$LngDel = 'Удалить пункт'
	$LngRe = 'Перезапуск'
	$LngReH = 'Для обновления в трее' & @CRLF & 'требуется перезапуск'
	$LngCS = 'текущие при старте'
	$LngOF = 'Открыть эти каталоги'
	$LngAc = 'Действия'
	$LngEx = 'Выход'
	$LngRS = 'Перезапуск для обновление списка текущих'
	$LngSR = 'Сохранить открытые каталоги и перезапуск'
	$LngCf = 'Закрыть открытые каталоги'
	$LngAdS = 'Добавить сессию'
	$LngFP = 'Папка программы'
	$LngSet = 'Настройки'
	$LngEr = 'Ошибка'
	$LngM1 = 'Невозможно открыть файл.'
	$LngM2 = 'Предупреждение'
	$LngM3 = 'Добавляемый путь существует в сессии' & @CRLF & 'и не будет добавлен.'
	$LngFs = 'Выбрать добавляемую папку'
	$LngOs = 'Открываем сессию'
	$LngCf1 = 'Закрыть эти каталоги'
	$LngSS = 'Сохраняем сессию'
	$LngID = 'Не найден ID'
	$LngM4 = 'нет папки'
	$LngAbout = "О программе"
	$LngAbT2 = "Горячие клавиши" & @CRLF & _
			"F1 - переименование c расширением" & @CRLF & _
			"F2 - переименование без расширения" & @CRLF & _
			"F9 - создание папки" & @CRLF & _
			"F10 - создание текстового файла"
	$LngCPs='Открывать учитывая позицию и размеры'
	$LngSml='Сократить длинные пути'
	$LngDico='Отображать иконки папок'
	$LngHKe='Использовать горячие клавиши'
EndIf

$1a = 'a'
$1f = 'f'
$1n = 'n'
$1g = 'g'
If $UserIntLang = 0419 Then
	$1a = 'ф'
	$1f = 'а'
	$1n = 'т'
	$1g = 'п'
EndIf

_SetFlashTimeOut(250)
If @Compiled Then
	$nTrayIcon1 = _TrayIconCreate("SaveFolders", @ScriptDir&"\SaveFolders.exe", -1)
Else
	$nTrayIcon1 = _TrayIconCreate("SaveFolders", "shell32.dll", -111)
EndIf
$nTrayMenu1 = _TrayCreateContextMenu()
$bUseAdvTrayMenu = False



$search = FileFindFirstFile(@ScriptDir & "\*.inc") ; перебираем файлы сессии
If $search <> -1 Then
	For $d = 1 To 20
		$file_open = FileFindNextFile($search)
		If @error Then ExitLoop
		_add(25)
	Next
EndIf
FileClose($search)

_TrayCreateItem("")
$d+=1
ReDim $SessionM[$d+1][6] ; увеличили массив сессий
$SessionM[$d][0] = _TrayCreateMenu($LngCS) ; меню - текущие папки
_TrayItemSetIcon(-1, "shell32.dll", -5)
_TrayCreateItem("")

	
$SessionM[$d][2] = _TrayCreateItem($LngOF, $SessionM[$d][0]) ; создание пункта Открыть все папки - allfolder
GUICtrlSetOnEvent(-1, "_allfolder")
_TrayItemSetIcon(-1, "shell32.dll", -5)
_TrayCreateItem("", $SessionM[$d][0])

$tmp1 = '|'
$AllWindows = WinList()
For $i = 1 To $AllWindows[0][0]
	If _IsVisible($AllWindows[$i][1]) And $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 13) = '\explorer.exe' Then
		$y += 1
		$tmp = ControlGetText($AllWindows[$i][0], '', $obj)
		If $Tr7 = 1 Then
			If $tmp = '' Then $tmp = $AllWindows[$i][0]
			$tmp = StringRegExpReplace($tmp, '(.*)(.:\\.*)', '\2')
			If Not FileExists($tmp) Then ContinueLoop
		EndIf
		If StringInStr($tmp1, '|'&$tmp&'|') Then ContinueLoop ; избавление от повторов
		$tmp1&=$tmp&'|'
		ReDim $FolderM[$y+1][5] ; увеличили массив итемов
		$FolderM[$y][0] = $d ; храним индекс массива соответсвующей сессии в каждой группе
		$FolderM[$y][2] = $tmp
		If $TrSml=1 Then $tmp=_cut($tmp)
		$FolderM[$y][1] = _TrayCreateItem($tmp, $SessionM[$d][0])
		GUICtrlSetOnEvent(-1, "_TrayItemHit")
		_TrayItemSetIcon(-1, "shell32.dll", -4)
		; ========== обработка иконок из desktop.ini
		If $TrDskIni=1 And FileExists($FolderM[$y][2]&'\desktop.ini') Then
			$desktop1=IniRead($FolderM[$y][2]&'\desktop.ini', '.ShellClassInfo', 'IconFile', '-|-')
			$desktop2=IniRead($FolderM[$y][2]&'\desktop.ini', '.ShellClassInfo', 'IconIndex', '-|-')
			If FileExists($FolderM[$y][2]&'\'&$desktop1) Then
				_TrayItemSetIcon(-1, $FolderM[$y][2]&'\'&$desktop1, $desktop2)
			ElseIf FileExists($desktop1) Then
				_TrayItemSetIcon(-1, $desktop1, $desktop2)
			EndIf
		; ==========
		EndIf
	EndIf
Next


$action = _TrayCreateMenu($LngAc)
_TrayItemSetIcon(-1, "shell32.dll", -177)

$nUpd = _TrayCreateItem($LngRS, $action)
GUICtrlSetOnEvent(-1, "_restart")
_TrayItemSetIcon(-1, "shell32.dll", -147)

$nSave = _TrayCreateItem($LngSR, $action)
GUICtrlSetOnEvent(-1, "_save")
_TrayItemSetIcon(-1, "shell32.dll", -195)

$nClose = _TrayCreateItem($LngCf, $action)
GUICtrlSetOnEvent(-1, "_close")
_TrayItemSetIcon(-1, "shell32.dll", -110)

$nAdd = _TrayCreateItem($LngAdS, $action)
GUICtrlSetOnEvent(-1, "_addses")
_TrayItemSetIcon(-1, "shell32.dll", -5)

$nSFolder = _TrayCreateItem($LngFP, $action)
GUICtrlSetOnEvent(-1, "_sfolder")
_TrayItemSetIcon(-1, "shell32.dll", -4)

$nSet = _TrayCreateItem($LngSet, $action)
GUICtrlSetOnEvent(-1, "_Setting")
_TrayItemSetIcon(-1, "shell32.dll", -91)

$nAbout = _TrayCreateItem($LngAbout, $action)
GUICtrlSetOnEvent(-1, "_about")
_TrayItemSetIcon(-1, "shell32.dll", -222)

;_ArrayDisplay( $avTrayItems, "Смотрим текущий массив" )
$nExit = _TrayCreateItem($LngEx)
GUICtrlSetOnEvent(-1, "_Quit")
_TrayItemSetIcon(-1, "shell32.dll", -216)

_TrayIconSetState()

While 1
	Sleep(20)
WEnd

Func _GUI(); вызов окна "Редактирование сессии"
	;Opt("TrayIconHide", 1) ; скрываем иконку в трее
	;деактивация пунктов
	_ActItem(128)
	
; Окно "Редактирование сессии"
$nMain = GUICreate($LngES, 602, 285, -1, -1, $WS_OVERLAPPEDWINDOW, $WS_EX_ACCEPTFILES) ;drag-and-drop
GUISetBkColor(0xF9F9F9)

$Folderlist = GUICtrlCreateList("", 10, 10, 580, 237, $GUI_SS_DEFAULT_LIST+$LBS_NOINTEGRALHEIGHT)
GUICtrlSetState(-1, 8)
GUICtrlSetResizing(-1, 2+4+32+64)
; $Cmenu = GUICtrlCreateContextMenu($Folderlist)
; $CmenuD=GUICtrlCreateMenuItem($LngDel, $Cmenu)
; GUICtrlSetOnEvent(-1, "_nDel")
GUISetOnEvent(-13, "_Folderlist")

GUICtrlCreateLabel($LngDad, 10, 259, 150, 16)
GUICtrlSetResizing(-1, 8+64+256+512)

$nOpen = GUICtrlCreateButton($LngAdd, 160, 255, 80, 24)
GUICtrlSetOnEvent(-1, "_nOpen")
GUICtrlSetResizing(-1, 8+64+256+512)
$nDel = GUICtrlCreateButton($LngDel, 250, 255, 90, 24)
GUICtrlSetOnEvent(-1, "_nDel")
GUICtrlSetResizing(-1, 8+64+256+512)
$nRestart = GUICtrlCreateButton($LngRe, 350, 255, 80, 24)
GUICtrlSetOnEvent(-1, "_restart")
GUICtrlSetResizing(-1, 8+64+256+512)
GUICtrlSetTip(-1, $LngReH)

GUISetOnEvent(-3, "_CloseMain")

; редактировать сессию, поиск ID элемента, считывание пути, отправление для редактирования
	$n = _ArraySearch($SessionM, @GUI_CtrlId, 1, 0, 0, 0, 1, 1) ; последний параметр - индекс колонки для поиска
	If @error Then
		MsgBox(0, $LngEr, $LngID)
		Exit
	EndIf
	WinSetTitle($nMain, '', $LngES&' - '&$SessionM[$n][5])
	If Not _FileReadToArray($SessionM[$n][4],$aPathS) Then ; открываем файл-сессию
		MsgBox(0, $LngEr, $LngM1 &' - '&$SessionM[$d][5])
	   Return
	EndIf
	_SetFlist()
	
GUISetState()
Dim $AccelKeys[1][2]=[["{Del}", $nDel]]
GUISetAccelerators($AccelKeys)
EndFunc

Func _SetFlist() ; обновление списка сессии
	$sTmp=''
	For $i = 1 to $aPathS[0]
		$aTmp = StringSplit($aPathS[$i], "|")
		$sTmp&='|'&$aTmp[1]
	Next
	GUICtrlSetData($Folderlist, $sTmp)
EndFunc

Func _Folderlist() ; drag-and-drop в список
	If StringInStr(FileGetAttrib(@GUI_DragFile), "D") = 0 Then Return ; не папка
	; If StringInStr('|'&$sTmp&'|', '|'&@GUI_DragFile&'|') > 0 Then ; уже присутствует в сессии
	If _ArraySearch($aPathS, @GUI_DragFile) > 0 Then ; уже присутствует в сессии
		MsgBox(0, $LngM2, $LngM3)
		Return
	EndIf
	_ArrayAdd($aPathS, @GUI_DragFile)
	$aPathS[0]+=1
	_updedit()
EndFunc

Func _nOpen() ; кнопка Добавить
	Local $addfold = FileSelectFolder($LngFs, '', 3,@WorkingDir)
	If @error Then Return
	If StringInStr('|'&$sTmp&'|', '|'&$addfold&'|') > 0 Then
		MsgBox(0, $LngM2, $LngM3)
		Return
	EndIf
	_ArrayAdd($aPathS, $addfold)
	$aPathS[0]+=1
	_updedit()
EndFunc   ;==>_nOpen

Func _nDel() ; Кнопка удаления
	If GUICtrlRead($Folderlist) = '' Then Return
	Local $aTmp[$aPathS[0]+1]
	For $i = 0 to $aPathS[0]
		$Tmp = StringSplit($aPathS[$i], "|")
		$aTmp[$i] = $Tmp[1]
	Next
	_ArrayDelete($aPathS, _ArraySearch($aTmp, GUICtrlRead($Folderlist)))
	$aPathS[0]-=1
	_updedit()
EndFunc   ;==>_nDel

Func _updedit() ; обновление файла при редактировании сессии
	_FileWriteFromArray($SessionM[$n][4],$aPathS, 1)
	If @error Then
		MsgBox(0, $LngEr, $LngM1)
		Return
	EndIf
	_SetFlist()
EndFunc   ;==>_updedit

Func _ActItem($Ch) ; активация деактивация пунктов в трее
	For $i = 1 To UBound($FolderM) - 1
		GUICtrlSetState($FolderM[$i][1], $Ch)
		If @error Then ExitLoop
	Next
	For $i = 1 To UBound($SessionM) - 1
		GUICtrlSetState($SessionM[$i][1], $Ch)
		GUICtrlSetState($SessionM[$i][2], $Ch)
		GUICtrlSetState($SessionM[$i][3], $Ch)
		If @error Then ExitLoop
	Next
	GUICtrlSetState($nAdd, $Ch)
	GUICtrlSetState($nUpd, $Ch)
	GUICtrlSetState($nSave, $Ch)
	GUICtrlSetState($nClose, $Ch)
	GUICtrlSetState($nSFolder, $Ch)
	GUICtrlSetState($nAbout, $Ch)
	GUICtrlSetState($nSet, $Ch)
EndFunc

Func _CloseMain()
	_ActItem(64)
	GUIDelete($nMain)
EndFunc

Func _addses() ; добавить сессию
	$d += 1
	$file_open = FileOpenDialog($LngOs, @ScriptDir & "", "Session (*.inc)", 1 + 4, "Session.inc")
	If @error Then Return
	_add(0)
EndFunc   ;==>_addses

; добавить пункты в меню трея для файлов сессий
Func _add($sor)
	Local $aPath, $aTmp
	ReDim $SessionM[$d+1][6] ; увеличили массив сессий
	; MsgBox(0, 'Message', $d)
; _ArrayDisplay($SessionM, 'SessionM')
	If StringInStr($file_open, "\") = 0 Then $file_open = @ScriptDir & "\" & $file_open
	$SessionM[$d][4] = $file_open
	$SessionM[$d][5] = StringRegExpReplace($file_open, "(^.*)\\(.*)\.(.*)$", '\2') ; выделяем имя файл-сессии
	
	If Not _FileReadToArray($file_open,$aPath) Then ; открываем файл-сессию
		MsgBox(0, $LngEr, $LngM1 &' - '&$SessionM[$d][5])
	   Return
	EndIf

	$SessionM[$d][0] = _TrayCreateMenu($SessionM[$d][5], -1, $sor) ; создание разделов в трее
	_TrayItemSetIcon(-1, "shell32.dll", -5)

	$SessionM[$d][1] = _TrayCreateItem($LngES, $SessionM[$d][0]) ; создание пункта Редактировать - edit
	GUICtrlSetOnEvent(-1, "_GUI")
	_TrayItemSetIcon(-1, "shell32.dll", -2)

	$SessionM[$d][2] = _TrayCreateItem($LngOF, $SessionM[$d][0]) ; создание пункта Открыть все папки - allfolder
	GUICtrlSetOnEvent(-1, "_allfolder")
	_TrayItemSetIcon(-1, "shell32.dll", -5)

	$SessionM[$d][3] = _TrayCreateItem($LngCf1, $SessionM[$d][0]) ; создание пункта Закрыть все папки - sesfolclose
	GUICtrlSetOnEvent(-1, "_sesfolclose")
	_TrayItemSetIcon(-1, "shell32.dll", -110)

	_TrayCreateItem("", $SessionM[$d][0]) ; разделитель
	For $i = 1 To $aPath[0]
		$aTmp = StringSplit($aPath[$i], "|") ; разбиваем на путь и координаты
		If FileExists($aTmp[1]) Then
			$y += 1
			ReDim $FolderM[$y+1][5] ; увеличили массив итемов
			$FolderM[$y][0] = $d ; храним индекс массива соответсвующей сессии в каждой группе
			$FolderM[$y][2] = $aTmp[1]
			If $aTmp[0]>1 Then $FolderM[$y][3] = $aTmp[2]
			If $TrSml=1 Then $aTmp[1]=_cut($aTmp[1])
			$FolderM[$y][1] = _TrayCreateItem($aTmp[1], $SessionM[$d][0])
			GUICtrlSetOnEvent(-1, "_TrayItemHit")
			_TrayItemSetIcon(-1, "shell32.dll", -4)
			; ========== обработка иконок из desktop.ini
			If $TrDskIni=1 And FileExists($FolderM[$y][2]&'\desktop.ini') Then
				$desktop1=IniRead($FolderM[$y][2]&'\desktop.ini', '.ShellClassInfo', 'IconFile', '-|-')
				$desktop2=IniRead($FolderM[$y][2]&'\desktop.ini', '.ShellClassInfo', 'IconIndex', '-|-')
				If FileExists($FolderM[$y][2]&'\'&$desktop1) Then
					_TrayItemSetIcon(-1, $FolderM[$y][2]&'\'&$desktop1, $desktop2)
				ElseIf FileExists($desktop1) Then
					_TrayItemSetIcon(-1, $desktop1, $desktop2)
				EndIf
			; ==========
			EndIf
		EndIf
	Next
EndFunc   ;==>_add


Func _cut($text)
	If StringLen($text)>40 Then
		Return StringRegExpReplace($text, '(^.{3,11}\\|.{11})(.*)(\\.{6,27}|.{27})$', '\1...\3')
	Else
		Return $text
	EndIf
EndFunc

Func _save()
	$file_save = FileSaveDialog($LngSS, @ScriptDir & "", "Session (*.inc)", 24, "Session.inc")
	If @error Then Return
	If StringRight($file_save, 4) <> '.inc' Then $file_save &= '.inc'
	$DX=@DesktopWidth
	$DY=@DesktopHeight
	$AllWindows = WinList()
	$sTmp = ""
	For $i = 1 To $AllWindows[0][0]
		If _IsVisible($AllWindows[$i][1]) And $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 13) = '\explorer.exe' Then
			$tmp = ControlGetText($AllWindows[$i][0], '', $obj)
			If $Tr7 = 1 Then
				If $tmp = '' Then $tmp = $AllWindows[$i][0]
				$tmp = StringRegExpReplace($tmp, '(.*)(.:\\.*)', '\2')
				If Not FileExists($tmp) Then ContinueLoop
			EndIf
			;===============
			$aGP = WinGetPos($AllWindows[$i][0]) ; размеры сохраняем тоже
			If $aGP[0]>$DX Or $aGP[0]<0 Then $aGP[0]=0
			If $aGP[1]>$DY Or $aGP[1]<0 Then $aGP[1]=0
			If $aGP[2]<120 Then $aGP[2]=600
			If $aGP[3]<120 Then $aGP[3]=470
			$aGP = _ArrayToString($aGP, ',')
			$tmp&='|'&$aGP
			;===============
			$sTmp &= '*'& $tmp ; создаём список путей
		EndIf
	Next
	$tmp=StringSplit(StringTrimLeft($sTmp, 1), '*')
	$tmp = _ArrayUnique($tmp, 1, 1) ; убрать повторы
	_FileWriteFromArray($file_save, $tmp, 1)
	If @error Then
		MsgBox(0, $LngEr, $LngM1)
		Return
	EndIf
	_restart()
EndFunc   ;==>_save

; открыть все папки, поиск ID элемента, считывание имя группы, открытие папок группы
Func _allfolder()
	If $Tr7 = 1 Then ; условие запрета на повторное открытие каталогов в Win7
		$AllWindows = WinList()
		Local $sTmp = '|'
		For $i = 1 To $AllWindows[0][0]
			If _IsVisible($AllWindows[$i][1]) And $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 13) = '\explorer.exe' Then
				$y += 1
				$tmp = ControlGetText($AllWindows[$i][0], '', $obj)
				If $tmp = '' Then $tmp = $AllWindows[$i][0]
				$tmp = StringRegExpReplace($tmp, '(.*)(.:\\.*)', '\2')
				If Not FileExists($tmp) Then ContinueLoop
				$sTmp &= $tmp & '|'
			EndIf
		Next
	EndIf

	$n = _ArraySearch($SessionM, @GUI_CtrlId, 1, 0, 0, 0, 1, 2) ; последний параметр - индекс колонки для поиска
	If @error Then
		MsgBox(0, $LngEr, $LngID)
		Return
	EndIf
	$a = _ArrayFindAll($FolderM, $n, 1)
	If @error Then
		MsgBox(0, $LngEr, $LngID)
		Return
	EndIf
	For $i = 0 To UBound($a)-1
		If Not FileExists($FolderM[$a[$i]][2]) Then ContinueLoop
		If $Tr7 = 1 Then
			If StringInStr('|' & $sTmp & '|', '|' & $FolderM[$a[$i]][2] & '|') = 0 Then Run('Explorer.exe "' & $FolderM[$a[$i]][2] & '"')
		Else
			Run('Explorer.exe "' & $FolderM[$a[$i]][2] & '"')
		EndIf
		; модуль перемещения окна
		If $TrPos=1 And WinWaitActive('[CLASS:CabinetWClass]', $FolderM[$a[$i]][2], 1) And $FolderM[$a[$i]][3] Then
			$aGP=StringSplit($FolderM[$a[$i]][3], ',')
			If UBound($aGP)=5 Then
				$DX=@DesktopWidth
				$DY=@DesktopHeight
				If $aGP[3]>$DX Then $aGP[3]=$DX
				If $aGP[4]>$DY Then $aGP[4]=$DY
				If $aGP[1]+$aGP[3]>$DX Then $aGP[1]=$DX-$aGP[3]
				If $aGP[2]+$aGP[4]>$DY Then $aGP[2]=$DY-$aGP[4]
				WinMove('[CLASS:CabinetWClass]', $FolderM[$a[$i]][2], $aGP[1], $aGP[2], $aGP[3], $aGP[4])
			EndIf
		EndIf
	Next
EndFunc   ;==>_allfolder

; открыть все папки, поиск ID элемента, считывание имя группы, открытие папок группы
Func _sesfolclose()
	$n = _ArraySearch($SessionM, @GUI_CtrlId, 1, 0, 0, 0, 1, 3) ; последний параметр - индекс колонки для поиска
	If @error Then
		MsgBox(0, $LngEr, $LngID)
		Return
	EndIf
	$a = _ArrayFindAll($FolderM, $n, 1) ; массив индексов с одинаковыми ID
	If @error Then
		MsgBox(0, $LngEr, $LngID)
		Return
	EndIf
	For $i = 0 To UBound($a)-1
		; в обоих случаях, когда имя окна может быть путь и имя папки
		$file_open = StringRegExpReplace($FolderM[$a[$i]][2], "(^.*)\\(.*)$", '\2')
		If WinExists($FolderM[$a[$i]][2]) And _IsVisible($FolderM[$a[$i]][2]) And StringRight(_ProcessGetPath(WinGetProcess($FolderM[$a[$i]][2])), 13) = '\explorer.exe' Then WinClose($FolderM[$a[$i]][2])
		If WinExists($file_open) And _IsVisible($file_open) And StringRight(_ProcessGetPath(WinGetProcess($file_open)), 13) = '\explorer.exe' Then WinClose($file_open)
	Next
EndFunc   ;==>_sesfolclose

; считывание ID пункта меню, поиск в массиве, сдвиг на 1 и открыть путь
Func _TrayItemHit()
	Local $i = _ArraySearch($FolderM, @GUI_CtrlId, 1, 0, 0, 0, 1, 1) ; последний параметр - индекс колонки для поиска
	If @error Then
		MsgBox(16, $LngEr, $LngEr)
		Return
	EndIf
	If Not FileExists($FolderM[$i][2]) Then
		MsgBox(16, $LngEr, $LngM4)
		Return
	EndIf
	Run('Explorer.exe "' & $FolderM[$i][2] & '"')
	; модуль перемещения окна
	If $TrPos=1 And WinWaitActive('[CLASS:CabinetWClass]', $FolderM[$i][2], 1) And $FolderM[$i][3] Then
		$aGP=StringSplit($FolderM[$i][3], ',')
		If UBound($aGP)=5 Then
		$DX=@DesktopWidth
		$DY=@DesktopHeight
		If $aGP[3]>$DX Then $aGP[3]=$DX
		If $aGP[4]>$DY Then $aGP[4]=$DY
		If $aGP[1]+$aGP[3]>$DX Then $aGP[1]=$DX-$aGP[3]
		If $aGP[2]+$aGP[4]>$DY Then $aGP[2]=$DY-$aGP[4]
		WinMove('[CLASS:CabinetWClass]', $FolderM[$i][2], $aGP[1], $aGP[2], $aGP[3], $aGP[4])
		EndIf
	EndIf

EndFunc   ;==>_TrayItemHit

; проверка открытых окнон
Func _IsVisible($handle)
	If BitAND(WinGetState($handle), 4) And BitAND(WinGetState($handle), 2) Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>_IsVisible

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
EndFunc   ;==>_ProcessGetPath

; закрытие открытых окон
Func _close()
	$AllWindows = WinList()
	$sTmp = ""
	For $i = 1 To $AllWindows[0][0]
		If _IsVisible($AllWindows[$i][1]) And $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 13) = '\explorer.exe' Then
			WinClose($AllWindows[$i][0])
		EndIf
	Next
EndFunc   ;==>_close

Func _Quit()
	_TrayIconDelete($nTrayIcon1)
	Exit
EndFunc   ;==>_Quit

Func _Rename2()
	$window = WinGetTitle('')
	If (_WinGetClass($window) = "CabinetWClass") Or (_WinGetClass($window) = "Progman") Then
		HotKeySet("{F1}")
		HotKeySet("{F2}")
		Send("{F2}")
		Send("{SHIFTDOWN}{END}{SHIFTUP}")
		HotKeySet("{F2}", "_Rename")
		HotKeySet("{F1}", "_Rename2")
	Else
		HotKeySet("{F1}")
		Send("{F1}")
		HotKeySet("{F1}", "_Rename2")
	EndIf
EndFunc   ;==>_Rename2

; функцию _Rename заимствовал у Monamo, немного изменив.
;http://www.autoitscript.com/forum/index.php?showtopic=88903
Func _Rename()
	HotKeySet("{F2}"); откл. горячей клавиши
	Send("{F2}")
	$window = WinGetTitle('')
	$adrPath = ControlGetText($window, '', $obj)
	If (_WinGetClass($window) = "CabinetWClass") Or (_WinGetClass($window) = "Progman") Then
		$oldClipboard = ClipGet()
		Sleep(100)
		Send("^{insert}")
		$sFilename = ClipGet()
		If StringInStr(FileGetAttrib($adrPath & "\" & $sFilename), "D") = 0 Then ; проверка что объёкт является файлом
			$iExtPosition = StringInStr($sFilename, ".", 0, -1)
			If $iExtPosition <> 0 Then
				$iPosition = StringLen($sFilename) - $iExtPosition + 1
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
EndFunc   ;==>_Rename

Func _CreateFT()
	$L1 = Hex(_WinAPI_GetKeyboardLayout(WinGetHandle('')))
	$window = WinGetTitle('')
	If $window <> "" And $window <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($window)), 13) = '\explorer.exe' Then
		If $Tr7 = 1 Then Send("{ESC}")
		$win_handle = WinGetHandle($window)
		_SetKeyboardLayout('0000' & $UserIntLang, $win_handle)
		; Send('!{'&$1a&'}')
		Send('{ALTDOWN}{' & $1a & '}{ALTUP}')
		Sleep(100)
		Send('{' & $1f & '}')
		If @HotKeyPressed = $CrTx Then
			Send('{' & $1n & '}') ; текстовый документ
			_Rename()
		Else
			Send('{' & $1g & '}') ; папка
		EndIf
		_SetKeyboardLayout($L1, $win_handle) ; возвращаем язык по умолчанию
	EndIf
EndFunc   ;==>_CreateFT

Func _restart()
	_TrayIconDelete($nTrayIcon1)
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

Func _WinAPI_GetKeyboardLayout($hWnd)

	Local $ret

	$ret = DllCall('user32.dll', 'long', 'GetWindowThreadProcessId', 'hwnd', $hWnd, 'ptr', 0)
	If (@error) Or (Not $ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	$ret = DllCall('user32.dll', 'long', 'GetKeyboardLayout', 'long', $ret[0])
	If (@error) Or (Not $ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return BitAND($ret[0], 0xFFFF)
EndFunc   ;==>_WinAPI_GetKeyboardLayout

Func _sfolder()
	Run('Explorer.exe "' & @ScriptDir)
EndFunc   ;==>_sfolder

; Func _about()
	; MsgBox(0, $LngAbT1, $LngAbT2)
; EndFunc   ;==>_about

; переключение раскладки клавиатуры
Func _SetKeyboardLayout($sLayoutID, $hWnd)
	Local $aRet = DllCall("user32.dll", "long", "LoadKeyboardLayout", "str", $sLayoutID, "int", 0)
	If Not @error And $aRet[0] Then DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", 0x50, "int", 1, "int", $aRet[0])
EndFunc   ;==>_SetKeyboardLayout

Func _WinGetClass($hWnd)
	; credit = SmOke_N from post http://www.autoitscript.com/forum/index.php?showtopic=41622&view=findpost&p=309799
	If IsHWnd($hWnd) = 0 And WinExists($hWnd) Then $hWnd = WinGetHandle($hWnd)
	Local $aGCNDLL = DllCall('User32.dll', 'int', 'GetClassName', 'hwnd', $hWnd, 'str', '', 'int', 4095)
	If @error = 0 Then Return $aGCNDLL[2]
	Return SetError(1, 0, '')
EndFunc   ;==>_WinGetClass


Func _About()
	If $Gui1 Then Return
	_ActItem(128)
$font="Arial"
    $Gui1 = GUICreate($LngAbout, 270, 180,@DesktopWidth-479, @DesktopHeight-250, -1, $WS_EX_TOOLWINDOW+$WS_EX_TOPMOST)
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,15, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,268,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 1.0  6.05.2011', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 55, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetOnEvent(-1, "_url")
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetOnEvent(-1, "_WbMn")
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010-2011', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
	GUISetOnEvent(-3, "_CloseGui1")
EndFunc

Func _CloseGui1()
	_ActItem(64)
	GUIDelete($Gui1)
	$Gui1=0
EndFunc


Func _url()
	ShellExecute ('http://azjio.ucoz.ru')
EndFunc

Func _WbMn()
	ClipPut('R939163939152')
EndFunc

Func _Setting()
	_ActItem(128)
$nSetGui = GUICreate($LngSet, 300, 230) ;drag-and-drop
GUICtrlCreateLabel($LngAbT2, 4, 3, 290, 85)
$ChPos = GUICtrlCreateCheckbox($LngCPs, 10, 100, 290, 17)
If $TrPos = 1 Then GUICtrlSetState(-1, 1)
$ChSml = GUICtrlCreateCheckbox($LngSml, 10, 120, 290, 17)
If $TrSml = 1 Then GUICtrlSetState(-1, 1)
$ChDskIni = GUICtrlCreateCheckbox($LngDico, 10, 140, 290, 17)
If $TrDskIni = 1 Then GUICtrlSetState(-1, 1)
$ChHK = GUICtrlCreateCheckbox($LngHKe, 10, 160, 290, 17)
If $TrHK = 1 Then GUICtrlSetState(-1, 1)
$nRestart = GUICtrlCreateButton('OK', 110, 190, 80, 24)
GUICtrlSetOnEvent(-1, "_Set_OK")
GUISetOnEvent(-3, "_CloseSet")
GUISetState()
EndFunc

Func _CloseSet()
	_ActItem(64)
	GUIDelete($nSetGui)
EndFunc

Func _Set_OK()
	$TmpPos = GUICtrlRead($ChPos)
	$TmpSml = GUICtrlRead($ChSml)
	$TmpDskIni = GUICtrlRead($ChDskIni)
	$TmpHK = GUICtrlRead($ChHK)
	If Not($TrPos=Execute($TmpPos) And $TrSml=Execute($TmpSml) And $TrDskIni=Execute($TmpDskIni) And $TrHK=Execute($TmpHK)) Then
		$TrPos = $TmpPos
		$TrSml = $TmpSml
		$TrDskIni = $TmpDskIni
		$TrHK = $TmpHK
		IniWrite($Ini, 'Setting', 'Pos', $TrPos)
		IniWrite($Ini, 'Setting', 'Sml', $TrSml)
		IniWrite($Ini, 'Setting', 'DskIni', $TrDskIni)
		IniWrite($Ini, 'Setting', 'HK', $TrHK)
		GUIDelete($nSetGui)
		_restart()
	Else
		_CloseSet()
	EndIf
EndFunc