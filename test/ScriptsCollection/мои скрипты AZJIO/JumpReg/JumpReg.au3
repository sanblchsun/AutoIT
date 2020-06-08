#AutoIt3Wrapper_Outfile=JumpReg.exe
#AutoIt3Wrapper_OutFile_X64=JumpReg64.exe
#AutoIt3Wrapper_Icon=JumpReg.ico
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Compression=4
; #AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Comment=
#AutoIt3Wrapper_Res_Description=JumpReg.exe
#AutoIt3Wrapper_Res_Fileversion=0.8.1.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.8.1
#AutoIt3Wrapper_Res_Field=Build|2012.08.22
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#Obfuscator_Ignore_Variables=$LngAbout, $LngVer, $LngSite, $LngFIT, $LngFIT1, $LngFIT2, $LngFIT3, $LngFav, $LngEdF, $LngAFv, $LngOpF, $LngHis, $LngExp, $LngImp, $LngSzH, $LngAdF, $LngClF, $LngTpE, $LngSWR, $LngTop, $LngHsIB1, $LngHsIB2, $LngMs1, $LngMs2, $LngMs3, $LngMs4, $LngMs5, $LngMs6, $LngMs7, $LngMs8, $LngMs9, $LngSLng, $LngNRE, $LngMd, $LngUse, $LngNoU, $LngSHX, $LngWCB, $LngMs10, $LngMs11, $LngMs12, $LngMs13, $LngMs14, $LngSSY
#Obfuscator_Ignore_Funcs=_ArrayUnique2,_ArrayUnique3
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion

;  @AZJIO 2012.08.22 (AutoIt3_v3.3.6.1)
#RequireAdmin
#NoTrayIcon
#include <WindowsConstants.au3>
#include <ForJumpReg.au3>
#include <GUIConstantsEx.au3>
#include <File.au3>
#include <GuiComboBox.au3>
#include <GuiHotKey.au3>
#include <_Setting.au3>

FileChangeDir(@ScriptDir)
; FileInstall('RegScanner.exe', '*')
; FileInstall('RegScanner_lng.ini', '*') ;???
; FileInstall('RegScanner.chm', '*')

#Obfuscator_Off
; En
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngFIT = 'Define Favorites starting from the next line. After a separator | you can specify a name that has meaning only when importing favorites to Regedit; otherwise, the name is the last subkey.'
$LngFIT1 = 'Folders user'
$LngFIT2 = 'Environment Variables'
$LngFIT3 = 'Environment variables, current'
$LngFav = '&Favorites'
$LngEdF = 'Edit Favorites'
$LngAFv = 'Add to Favorites'
$LngOpF = 'Open another file'
$LngHis = 'History'
$LngExp = 'Export	Ctrl+Down'
$LngImp = 'Import'
$LngSzH = 'Size'
$LngAdF = 'Import Favorites to Regedit	Ctrl+Up'
$LngClF = 'Clear Favorites	Ctrl+Del'
$LngTpE = "Jump to the registry key in Regedit." & @CRLF & "Enter"
$LngSWR = 'Search with RegScanner	Alt+\'
$LngTop = 'Always on top'
$LngHsIB1 = 'History'
$LngHsIB2 = 'The number of records in the history:'
$LngMs1 = 'Message'
$LngMs2 = 'Clear Favorites in Regedit?'
$LngMs3 = 'Add JumpRegFav.ini entries' & @CRLF & 'to Regedit Favorites?'
$LngMs4 = 'Exported successfully to JumpRegSet.reg' & @CRLF & 'in the program folder.'
$LngMs5 = 'Error'
$LngMs6 = 'JumpRegSet.reg file not found.' & @CRLF & 'You can create it with the Export command.'
$LngMs7 = 'Error: invalid name for the root registry key'
$LngMs8 = 'The key does not exist. The nearest key is:'
$LngMs9 = 'Do you want to jump to it?'
$LngSLng = 'Language'
$LngNRE = 'Regedit in a new window	Ctrl+Enter'
$LngMd = 'Setting'
$LngUse = 'Using'
$LngNoU = 'No utilities'
$LngSHX = 'Hotkey to jump'
$LngWCB = 'Minimum width of a list'
$LngMs10 = 'Submitted text must contain a registry key'
$LngMs11 = 'Could not register hot key,'
$LngMs12 = 'it may be in use by another application.'
$LngMs13 = 'Add a string to the drop-down list? Otherwise, jump in the first'
$LngMs14 = 'Where to store settings?'&@CRLF&'(Yes) in the ini-file'&@CRLF&'(No) in the registry'
$LngSSY = 'Select utility'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	; $LngTitle = 'Прыжок в указанный раздел реестра'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngFIT = 'Указывайте Избранное, начиная с третьей строки. После разделителя | можно указать имя (имеет значение только при импорте избранного в Regedit), иначе именем становится последний подраздел.'
	$LngFIT1 = 'Папки пользователя'
	$LngFIT2 = 'Переменные среды'
	$LngFIT3 = 'Переменные среды текущего'
	$LngFav = '&Избранное'
	$LngEdF = 'Редактировать избранное'
	$LngAFv = 'Добавить в избранное'
	$LngOpF = 'Открыть другой файл избранного'
	$LngHis = 'И&стория'
	$LngExp = 'Экспорт	Ctrl+Down'
	$LngImp = 'Импорт'
	$LngSzH = 'Размер'
	$LngAdF = 'Добавить в Избранное	Ctrl+Up'
	$LngClF = 'Очистить Избранное	Ctrl+Del'
	$LngTpE = "Перейти в regedit" & @CRLF & "в указанный раздел реестра." & @CRLF & "Enter"
	$LngSWR = 'Поиск в RegScanner	Alt+\'
	$LngTop = 'Поверх всех окон'
	$LngHsIB1 = 'История'
	$LngHsIB2 = 'Количество записей в истории:'
	$LngMs1 = 'Сообщение'
	$LngMs2 = 'Очистить Избранное в Regedit?'
	$LngMs3 = 'Добавить разделы из JumpRegFav.ini' & @CRLF & 'в Избранное Regedit?'
	$LngMs4 = 'Экспорт выполнен в файл JumpRegSet.reg' & @CRLF & 'в папку программы.'
	$LngMs5 = 'Ошибка'
	$LngMs6 = 'Файл JumpRegSet.reg не найден.' & @CRLF & 'Его можно создать командой Экспорт.'
	$LngMs7 = 'Ошибка имени корневого раздела'
	$LngMs8 = 'Раздел не существует.' & @CRLF & 'Ближайший доступный раздел:'
	$LngMs9 = 'Перейти в него?'
	$LngSLng = 'Language (Язык интерфейса)'
	$LngNRE = 'Regedit в новом окне	Ctrl+Enter'
	$LngMd = 'Настройки'
	$LngUse = 'Используя'
	$LngNoU = 'Без сторонних утилит'
	$LngSHX = 'Горячая клавиша для прыжка'
	$LngWCB = 'Минимальная ширина списка'
	$LngMs10 = 'Переданный текст должен содержать раздел реестра'
	$LngMs11 = 'Не удалось зарегистрировать горячую клавишу'
	$LngMs12 = 'возможно она используется другим приложением.'
	$LngMs13 = 'Добавить строки в раскрывающися список? Иначе прыжок в первую'
	$LngMs14 = 'Где хранить настройки?'&@CRLF&'(Да) в ini-файле'&@CRLF&'(Нет) в реестре'
	$LngSSY = 'Выбор утилиты'
EndIf
#Obfuscator_On

Switch @OSArch
	Case 'X64'
		$HKCU = 'HKCU64'
		$HKCR = 'HKCR64'
	Case Else;'X86'
		$HKCU = 'HKCU'
		$HKCR = 'HKCR'
EndSwitch

Global $TrReg
$sPath_ini = @ScriptDir&'\JumpReg.ini'
$sPath_reg = $HKCU & '\Software\AZJIO_Soft\JumpReg'

If FileExists($sPath_ini) Then
	$TrReg = 0
	$sPath_Set = $sPath_ini
Else
	If _Reg_Exists($sPath_reg) Then
		$TrReg = 1
		$sPath_Set = $sPath_reg
	Else
		If MsgBox(4, $LngMs1, $LngMs14) = 6 Then
			$TrReg = 0
			$sPath_Set = $sPath_ini
			_Setting_Write($sPath_Set, 'Setting', 'History', '', $TrReg)
		Else
			$TrReg = 1
			$sPath_Set = $sPath_reg
			_Setting_Write($sPath_Set, 'Setting', 'History', '', $TrReg)
		EndIf
	EndIf
EndIf

$LangPath = _Setting_Read($sPath_Set, 'Setting', 'Lang', '', $TrReg)
If $LangPath Then
	If FileExists(@ScriptDir & '\Lang\' & $LangPath) Then
		$aLng = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng')
		If Not @error Then
			For $i = 1 To $aLng[0][0]
				If StringInStr($aLng[$i][1], '\r\n') Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\r\n', @CRLF)
				If IsDeclared('Lng' & $aLng[$i][0]) Then Assign('Lng' & $aLng[$i][0], $aLng[$i][1])
			Next
		EndIf
	Else
		_Setting_Delete($sPath_Set,'Setting', 'Lang', $TrReg)
	EndIf
EndIf

Global $aFavorites, $kol_item, $sHistory = '', $WHXY, $TrTop = 0, $TrNRE = 0, $aList, $FavM, $aSep[1] = [0], $TrClipGet = 0, $HotkeyID = 1001, $WidthCombo, $HotkeySave, $GUI
Global $Ini = @ScriptDir & '\JumpRegFav.ini', $PathRegScanner = @ScriptDir & '\RegScanner\RegScanner.exe'


$mode = Number(_Setting_Read($sPath_Set, 'Setting', 'mode', '0', $TrReg))
; If $mode = 0 And FileExists($PathRegScanner) Then $mode = 2
If $mode = 2 And Not FileExists($PathRegScanner) Then $mode = 0

; ком-строка
If $CmdLine[0] Then
	_CMDJump($CmdLine[1])
	Exit
EndIf

Func _CMDJump($key)
	If $key Then
		$key = StringRegExpReplace($key, '(?s)[\[\s-]*(HK[^\]]+[^\]\s\\])[\]\s\\]*$', '\1') ; Wrapper для строки с [HK....] и с переносом строк
		If @extended Then
			_Jump($key)
		Else
			MsgBox(0, $LngMs1, $LngMs10)
		EndIf
	EndIf
EndFunc

$WidthCombo = _CheckWidthCombo(Number(_Setting_Read($sPath_Set, 'Setting', 'WidthCombo', '600', $TrReg)))


$kol_item = Number(_Setting_Read($sPath_Set, 'Setting', 'HistorySize', '26', $TrReg))
If StringIsDigit($kol_item) = 0 Or $kol_item = '' Or $kol_item > 50 Then $kol_item = 26 ; количество пунктов в комбобоксе
$Xsz = 91
$Xsz2 = 54
$Jx = 5
$Js = 23
Switch @OSVersion
	Case 'WIN_VISTA', 'WIN_7'
		$Xsz = 91
		$Xsz2 = 53
		$Jx = 4
		$Js = 24
EndSwitch
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")

If Not FileExists($ini) Then
	$file = FileOpen($Ini, 2)
	FileWrite($file, '[Favorites]' & @CRLF & _
			'; ' & $LngFIT & @CRLF & _
			'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders|' & $LngFIT1 & @CRLF & _
			'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders|' & $LngFIT1 & ' 2' & @CRLF & _
			'HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment|' & $LngFIT2 & @CRLF & _
			'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|Run (all)' & @CRLF & _
			'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run' & @CRLF & _
			'HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MenuExt' & @CRLF & _
			'HKEY_CURRENT_USER\Environment|' & $LngFIT3 & @CRLF & _
			'HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices' & @CRLF & _
			'<--->' & @CRLF & _ ; так пишется разделитель для меню
			'HKEY_CLASSES_ROOT\Folder' & @CRLF & _
			'HKEY_CLASSES_ROOT\Directory' & @CRLF & _
			'HKEY_CLASSES_ROOT\Drive' & @CRLF & _
			'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' & @CRLF & _
			'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts')
	FileClose($file)
EndIf

$WHXY = _Setting_Read($sPath_Set, 'Setting', 'WHXY', '548|' & $Xsz2 & '|||0', $TrReg)
If Not StringInStr($WHXY, '|', 0, 4) Then $WHXY = '548|' & $Xsz2 & '|||0'
$WHXY = StringSplit($WHXY, '|', 2)
If @error Or UBound($WHXY) <> 5 Then Dim $WHXY[5] = [548, $Xsz2, -1, -1, 0]
$WHXY[0] = Number($WHXY[0])
$WHXY[1] = $Xsz2
$WHXY[4] = Number($WHXY[4])
If $WHXY[0] < 300 Then $WHXY[0] = 300 ; ограничение ширины
_SetCoor($WHXY)

$GUI = GUICreate('JumpReg', $WHXY[0], $Xsz2, $WHXY[2], $WHXY[3], BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPCHILDREN))
If Not @Compiled Then GUISetIcon(@ScriptDir & '\JumpReg.ico')

$FavM = GUICtrlCreateMenu($LngFav)
$runfav = GUICtrlCreateMenuItem($LngEdF, $FavM)
$AddFav = GUICtrlCreateMenuItem($LngAFv, $FavM)
$OpenFav = GUICtrlCreateMenuItem($LngOpF, $FavM)
GUICtrlCreateMenuItem('', $FavM)

_FavFileToListMenu()
Func _FavFileToListMenu()
	Local $list, $tmp

	If Not _FileReadToArray($Ini, $aFavorites) Then Dim $aFavorites[4] = ['3', '', '', 'HKEY_CURRENT_USER\Software']

	For $i = 3 To $aFavorites[0]
		If StringInStr($aFavorites[$i], '|') Then
			$list &= StringRegExpReplace($aFavorites[$i], '(.*?\|).*', '\1')
		Else
			$list &= $aFavorites[$i] & '|'
		EndIf
	Next

	$list = StringTrimRight($list, 1)
	$list = StringSplit($list, '|')
	Dim $aList[$list[0] + 1][2] = [[$list[0]]]

	$n = 0
	$s = 0
	For $i = 1 To $list[0]
		$tmp = StringLeft($list[$i], 2)
		If $tmp <> 'HK' Then
			If StringReplace($list[$i], '-', '') = '<>' Then
				ReDim $aSep[$aSep[0] + 2] ; создаём массив разделителей меню
				$s += 1
				$aSep[$s] = GUICtrlCreateMenuItem('', $FavM)
				$aSep[0] = $s
			EndIf
			ContinueLoop
		EndIf
		$n += 1
		$aList[$n][1] = $list[$i]
		$aList[$n][0] = GUICtrlCreateMenuItem($list[$i], $FavM) ; $aList, $aFavorites - глобальные
	Next
	$aList[0][0] = $n
EndFunc

$sHistory = _Setting_Read($sPath_Set, 'Setting', 'History', '', $TrReg)
If $TrReg Or _Reg_Exists($sPath_reg) Then
	$HisM = GUICtrlCreateMenu($LngHis)
	$Export = GUICtrlCreateMenuItem($LngExp, $HisM)
	$Import = GUICtrlCreateMenuItem($LngImp, $HisM)
Else
	$Export = 1000000
	$Import = $Export
EndIf

$RegM = GUICtrlCreateMenu('&Regedit')
$favorites = GUICtrlCreateMenuItem($LngAdF, $RegM)
$Clean = GUICtrlCreateMenuItem($LngClF, $RegM)
GUICtrlCreateMenuItem('', $RegM)
If FileExists($PathRegScanner) Then
	$SearchWRS = GUICtrlCreateMenuItem($LngSWR, $RegM)
Else
	$SearchWRS = 1000
EndIf
$NewREt = GUICtrlCreateMenuItem($LngNRE, $RegM)

$ActM = GUICtrlCreateMenu('?')
$About = GUICtrlCreateMenuItem($LngAbout, $ActM)
$Mmode = GUICtrlCreateMenuItem($LngMd, $ActM)
$Topmost = GUICtrlCreateMenuItem($LngTop, $ActM)
$SelLng = GUICtrlCreateMenuItem($LngSLng, $ActM)

$comboreg = GUICtrlCreateCombo("", 6, 5, $WHXY[0] - 37)
GUICtrlSetState(-1, $GUI_FOCUS)
_GUICtrlComboBox_SetDroppedWidth(-1, $WidthCombo)
GUICtrlSetResizing(-1, 2 + 4 + 32)
If $sHistory Then GUICtrlSetData(-1, '|' & $sHistory, '')
_HisSz()

$Jump = GUICtrlCreateButton(">", $WHXY[0] - 29, $Jx, $Js, $Js, 0x0040) ; $BS_ICON
GUICtrlSetTip(-1, $LngTpE)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', -138, 0)
GUICtrlSetState(-1, $GUI_DEFBUTTON)

$Editor = _TypeGetPath('txt')
If @error Then $Editor = @SystemDir & '\notepad.exe'

Dim $AccelKeys[6][2] = [ _
		["{Enter}", $Jump], _
		["^{Enter}", $NewREt], _
		["^{UP}", $favorites], _
		["^{DEL}", $Clean], _
		["!{\}", $SearchWRS], _
		["^{DOWN}", $Export]]
GUISetAccelerators($AccelKeys)

GUIRegisterMsg(0x0232, "WM_EXITSIZEMOVE") ; для сохранения размера и координат окна

GUISetState()
GUISetState(@SW_RESTORE)
Sleep(200)
WinSetOnTop($GUI, '', 1)
WinSetOnTop($GUI, '', 0)

$TrTop = Number(_Setting_Read($sPath_Set, 'Setting', 'Topmost', '0', $TrReg))
If $TrTop Then
	WinSetOnTop($GUI, '', 1)
	GUICtrlSetState($Topmost, 1)
EndIf

$HotkeySave = _Setting_Read($sPath_Set, 'Setting', 'Hotkey', '0', $TrReg)
If Not @error And $HotkeySave <> '0' Then
	$HotkeySave = Number($HotkeySave)
	If Not _GuiCtrlHotKey_RegisterHotkey($GUI, $HotkeyID, _WinAPI_LoWord($HotkeySave), _WinAPI_HiWord($HotkeySave)) Then
		MsgBox(0, $LngMs1, $LngMs11 & ' ' & _GetKey($HotkeySave) & ',' & @CRLF & $LngMs12, 0, $GUI)
		$HotkeySave = 0
	EndIf
Else
	$HotkeySave = 0
EndIf
GUIRegisterMsg($WM_HOTKEY, "WM_HOTKEY")

While 1
	$msg = GUIGetMsg()
	For $i = 1 To $aList[0][0]
		If $msg = $aList[$i][0] Then
			_Jump($aList[$i][1])
		EndIf
	Next

	Switch $msg

		Case $OpenFav
			$OpenFile = FileOpenDialog('Open', @ScriptDir, "Favorites (*.ini)", 3, "JumpRegFav.ini", $GUI)
			If @error Then ContinueLoop
			$Ini = $OpenFile
			For $i = 1 To $aList[0][0]
				GUICtrlDelete($aList[$i][0])
			Next
			$aList[0][0] = 0
			For $i = 1 To $aSep[0]
				GUICtrlDelete($aSep[$i])
			Next
			$aSep[0] = 0
			_FavFileToListMenu()

		Case $AddFav
			$comboreg0 = GUICtrlRead($comboreg)
			If $comboreg0 Then
				$tmp = FileRead($Ini)
				$hFile = FileOpen($Ini, 2)
				FileWrite($hFile, $tmp & @CRLF & $comboreg0)
				FileClose($hFile)

				$aList[0][0] += 1
				ReDim $aList[$aList[0][0] + 1][2]
				$aList[$aList[0][0]][1] = $comboreg0
				$aList[$aList[0][0]][0] = GUICtrlCreateMenuItem($comboreg0, $FavM)
			EndIf

		Case $Mmode
			_Setting()

		Case $SelLng
			$OpenFile = FileOpenDialog('Open', @ScriptDir & '\Lang', "Language (*.ini)", 3, "", $GUI)
			If @error Then ContinueLoop
			_Setting_Write($sPath_Set, 'Setting', 'Lang', StringRegExpReplace($OpenFile, '(^.*)\\(.*)$', '\2'), $TrReg)
			_restart()

		Case $SearchWRS
			If FileExists($PathRegScanner) Then
				Run($PathRegScanner)
			Else
				MsgBox(0, $LngMs1, 'Not found', 0, $GUI)
			EndIf

		Case $Clean
			If MsgBox(4, $LngMs1, $LngMs2, 0, $GUI) = 7 Then ContinueLoop
			RegDelete($HKCU & '\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites')
			GUICtrlSetState($comboreg, $GUI_FOCUS)

		Case $favorites
			If MsgBox(4, $LngMs1, $LngMs3, 0, $GUI) = 7 Then ContinueLoop
			For $i = 3 To $aFavorites[0]
				If StringLeft($aFavorites[$i], 2) <> 'HK' Then ContinueLoop
				If StringInStr($aFavorites[$i], '|') Then
					$aReg = StringSplit($aFavorites[$i], "|")
				Else
					Dim $aReg[3] = [2, $aFavorites[$i], StringRegExpReplace('t\\' & $aFavorites[$i], "(^.*)\\(.*)$", '\2')]
				EndIf
				RegWrite($HKCU & '\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites', $aReg[2], "REG_SZ", $aReg[1])
			Next
			If ProcessExists("regedit.exe") Then
				ContinueLoop
			Else
				Run(@WindowsDir & '\regedit.exe')
			EndIf
			GUICtrlSetState($comboreg, $GUI_FOCUS)

		Case $NewREt
			$TrNRE = 1
			ContinueCase

		Case $Jump, $comboreg
			_BtnJump(GUICtrlRead($comboreg))

		Case $Export
			_PosRegWrite()
			If FileExists(@ScriptDir & '\JumpRegSet.reg') Then FileDelete(@ScriptDir & '\JumpRegSet.reg')
			RunWait(@SystemDir & '\reg.exe export '&$sPath_reg&' "' & @ScriptDir & '\JumpRegSet.reg"', '', @SW_HIDE)
			MsgBox(0, $LngMs1, $LngMs4, 0, $GUI)

		Case $Import
			If FileExists(@ScriptDir & '\JumpRegSet.reg') Then
				ShellExecuteWait(@ScriptDir & '\JumpRegSet.reg')
				GUICtrlSendMsg($comboreg, 0x14B, 0, 0)
				$sHistory = _Setting_Read($sPath_Set, 'Setting', 'History', '', $TrReg)
				If $sHistory <> '' Then GUICtrlSetData(-1, $sHistory, StringRegExpReplace($sHistory, '(.*?)\|.*', '\1'))
				_HisSz()
			Else
				MsgBox(0, $LngMs5, $LngMs6, 0, $GUI)
			EndIf

		Case $Topmost
			
			$TrTop = Number(_Setting_Read($sPath_Set, 'Setting', 'Topmost', '0', $TrReg))
			If $TrTop Then
				WinSetOnTop($GUI, '', 0)
				_Setting_Write($sPath_Set, 'Setting', 'Topmost', '0', $TrReg)
				GUICtrlSetState($Topmost, 4)
			Else
				WinSetOnTop($GUI, '', 1)
				_Setting_Write($sPath_Set, 'Setting', 'Topmost', '1', $TrReg)
				GUICtrlSetState($Topmost, 1)
			EndIf

		Case $About
			_About()

		Case $runfav
			Run($Editor & ' ' & @ScriptDir & '\JumpRegFav.ini')
		Case -3
			_PosRegWrite()
			_Setting_Write($sPath_Set, 'Setting', 'History', $sHistory, $TrReg)
			Exit
	EndSwitch
WEnd

Func _SearchClipboard(ByRef $Out)
	Local $k=0, $tmp, $offset=1, $Clipboard = ClipGet()
	For $i = 1 To $kol_item
		$tmp = StringRegExp($Clipboard, '(?s)(HK(?:CR|CU|LM|U|CC|EY_CLASSES_ROOT|EY_CURRENT_USER|EY_LOCAL_MACHINE|EY_USERS|EY_CURRENT_CONFIG)(?:(?:[^\]\s]{1,100}[ ]*){0,4}\\)*(?:(?:[^\]\s]{1,100}[ ]*){0,4}[^\]\s](?:$|\b)|[^\]\s]+[^\]\s\\]))', 1, $offset)
		If @error Then
			ExitLoop
		Else
			$offset=@extended
			$Out &= $tmp[0] & '|'
			$k+=1
		EndIf
	Next
	If Not $k Then Return SetError(1)
	$Out = StringTrimRight($Out, 1)
	$Out = StringSplit($Out, '|', 2)
	Return $k
EndFunc

Func _BtnJump($comboreg0 = '') ; Основная функция для прыжка (кнопка/ хоткей)
	If $comboreg0 Then
		If StringInStr('[ ', StringLeft($comboreg0, 1)) Then $comboreg0 = StringRegExpReplace($comboreg0, '(?s)[\[\s-]*(HK[^\]]+[^\]\s\\])[\]\s\\]*$', '\1')
		$TrClipGet = 0
	Else
		If $TrNRE = 1 Then
			$TrNRE = 0
			Run('regedit -m')
			WinWaitActive('[CLASS:RegEdit_RegEdit]', '', 3)
		EndIf
		; $comboreg0=StringRegExpReplace(ClipGet(),'(?s)[\[\s-]*(HK[^\]]+[^\]\s\\])[\]\s\\]*$','\1') ; Wrapper для строки с [HK....] и с переносом строк, но при приёме из буфера обмена
		; (?s)[\[\s-]*(HK[^\]]+)[\]\s]*$ - бывшее
		; CR64|CU|CU64

		$aClipGet = ''
		$iCountKey = _SearchClipboard($aClipGet)
		If @error Then
			Return
		Else
			; UBound($aClipGet)
			If $iCountKey = 1 Then
				If StringLen($aClipGet[0]) > 256 Then Return
				$comboreg0 = $aClipGet[0]
				$TrClipGet = 1
				; MsgBox(0, 'Сообщение', $comboreg0)
				If $mode Then Sleep(200)
			Else
				$tmp = _ArrayUnique3($aClipGet, $iCountKey, $kol_item)
				If MsgBox(4, $LngMs1&' ('&$iCountKey&')', $LngMs13 & @LF & @LF & $tmp) = 6 Then
					$sHistory = StringReplace($tmp, @LF, '|') & $sHistory
					; GUICtrlSendMsg($comboreg, 0x14B, 0, 0)
					$sHistory = _ArrayUnique2($sHistory)

					StringReplace($sHistory, '|', '')
					If @extended > $kol_item - 1 Then $sHistory = StringMid($sHistory, 1,StringInStr($sHistory, '|', 0, $kol_item) - 1)
					GUICtrlSendMsg($comboreg, 0x14B, 0, 0)
					GUICtrlSetData($comboreg, $sHistory, StringRegExpReplace($sHistory, '(.*?)\|.*', '\1'))
					GUICtrlSetState($comboreg, $GUI_FOCUS)
					
					; GUICtrlSetData($comboreg, $sHistory)
					; MsgBox(0, 'Сообщение', $sHistory)
					Return
				Else
					If Not $aClipGet[0] Then Return
					$comboreg0 = $aClipGet[0]
					$TrClipGet = 1
				EndIf
			EndIf
		EndIf
	EndIf
	If StringInStr($comboreg0, '|') Then $comboreg0 = StringLeft($comboreg0, StringInStr($comboreg0 & '|', '|') - 1)
	$runyes = _Jump($comboreg0)
	If $runyes Then Return

	GUICtrlSendMsg($comboreg, 0x14B, 0, 0)
	If StringInStr('|' & $sHistory & '|', '|' & $comboreg0 & '|') Then
		$sHistory = StringReplace('|' & $sHistory & '|', '|' & $comboreg0 & '|', '|')
		$sHistory = StringRegExpReplace($sHistory, '^\|?(.*?)\|?$', '\1')
	EndIf
	If $sHistory = '' Then
		$sHistory = $comboreg0
	Else
		$sHistory = $comboreg0 & '|' & $sHistory
	EndIf
	StringReplace($sHistory, '|', '|')
	If @extended > $kol_item - 1 Then $sHistory = StringRegExpReplace($sHistory, '(^.*)\|.*$', '\1')
	GUICtrlSetData($comboreg, $sHistory, $comboreg0)
	GUICtrlSetState($comboreg, $GUI_FOCUS)
	If $TrClipGet Then
		$TrClipGet = 0
		_GUICtrlComboBox_SetEditText($comboreg, '')
	EndIf
EndFunc

#Obfuscator_Off
Func _ArrayUnique3($data, $iCount, $kol_item)
	Local $k, $i, $tmp
	Assign('/', 1, 1)
	$k = 0
	For $i = 0 To $iCount-1
		If StringLen($data[$i]) > 256 Then ContinueLoop
		Assign($data[$i] & '/', Eval($data[$i] & '/') + 1, 1)
		If Eval($data[$i] & '/') = 1 Then
			; $data[$k]=$data[$i]
			$tmp &= $data[$i] & @LF
			$k += 1
			If $k >= $kol_item Then ExitLoop
		EndIf
	Next
	If $k = 0 Then Return SetError(1, 0, '')
	Return $tmp
EndFunc

Func _ArrayUnique2($data)
	Local $k, $i, $tmp
	Assign('/', 1, 1) ;для исключения пустых строк и не совпадения с локальными переменными
	$data = StringSplit($data, '|')
	If Not @error Then
		$k = 0
		For $i = 1 To $data[0]
			Assign($data[$i] & '/', Eval($data[$i] & '/') + 1, 1)
			If Eval($data[$i] & '/') = 1 Then
				; $data[$k]=$data[$i]
				$tmp &= '|' & $data[$i]
				$k += 1
			EndIf
		Next
		If $k = 0 Then Return SetError(1, 0, '')
		; ReDim $data[$k]
		$tmp = StringTrimLeft($tmp, 1)
		Return $tmp
	Else
		Return SetError(1, 0, '')
	EndIf
EndFunc
#Obfuscator_On

Func _Jump(ByRef $comboreg0)
	If StringRight($comboreg0, 1) = '\' Then $comboreg0 = StringTrimRight($comboreg0, 1)

	Switch StringLeft($comboreg0, 4)
		Case 'HKLM'
			$comboreg0 = 'HKEY_LOCAL_MACHINE' & StringTrimLeft($comboreg0, 4)
		Case 'HKU'
			$comboreg0 = 'HKEY_USERS\' & StringTrimLeft($comboreg0, 4)
		Case 'HKCU'
			$comboreg0 = 'HKEY_CURRENT_USER' & StringTrimLeft($comboreg0, 4)
		Case 'HKCR'
			$comboreg0 = 'HKEY_CLASSES_ROOT' & StringTrimLeft($comboreg0, 4)
		Case 'HKCC'
			$comboreg0 = 'HKEY_CURRENT_CONFIG' & StringTrimLeft($comboreg0, 4)
	EndSwitch

	;проверяем существование раздела реестра
	If Not _Reg_Exists($comboreg0) Then
		Do
			$comboreg0 = StringRegExpReplace($comboreg0, '(.*)\\.*', '\1')
			If Not @extended Then
				MsgBox(0, $LngMs5, $LngMs7, 0, $GUI)
				If $TrNRE = 1 Then
					$TrNRE = 0
					Run(@WindowsDir & '\regedit.exe -m')
				EndIf
				Return 1
			EndIf
		Until _Reg_Exists($comboreg0)
		If MsgBox(4, $LngMs5, $LngMs8 & @CRLF & $comboreg0 & @CRLF & @CRLF & $LngMs9, 0, $GUI) = 7 Then Return 1
	EndIf

	If $TrNRE = 1 Then
		$TrNRE = 0
		Run('regedit -m')
		WinWaitActive('[CLASS:RegEdit_RegEdit]', '', 3)
	EndIf

	Switch $mode
		Case 1
			Run(@ComSpec & " /c " & 'regjump.exe ' & $comboreg0, "", @SW_HIDE)
		Case 2
			Run($PathRegScanner & ' /regedit "' & $comboreg0 & '"', "", @SW_HIDE)
		Case 3
			Run('nircmd.exe regedit  "' & $comboreg0 & '"', "", @SW_HIDE)
		Case Else
			_JumpRegistry($comboreg0)
	EndSwitch
EndFunc

Func _HisSz()
	StringReplace($sHistory, '|', '')
	If @extended > $kol_item - 1 Then
		$tmp = StringInStr($sHistory, '|', 0, $kol_item)
		$sHistory = StringMid($sHistory, 1, $tmp - 1)
		GUICtrlSendMsg($comboreg, 0x14B, 0, 0)
		GUICtrlSetData($comboreg, $sHistory, StringRegExpReplace($sHistory, '(.*?)\|.*', '\1'))
	EndIf
	GUICtrlSetState($comboreg, $GUI_FOCUS)
EndFunc

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $GUI Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeX", 1280)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeY", $Xsz)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 300)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", $Xsz)
		DllStructSetData($tMINMAXINFO, "MaxSizeX", 800)
		DllStructSetData($tMINMAXINFO, "MaxSizeY", $Xsz)
		DllStructSetData($tMINMAXINFO, "MaxPositionX", @DesktopWidth / 2 - 400)
		DllStructSetData($tMINMAXINFO, "MaxPositionY", 0)
	EndIf
EndFunc

Func WM_EXITSIZEMOVE($hWnd, $MsgID, $wParam, $lParam)
	Local $ClientSz, $GuiPos
	$GuiPos = WinGetPos($GUI)
	$ClientSz = WinGetClientSize($GUI) ; сохраняется размер клиентской области
	$WHXY[0] = $ClientSz[0]
	$WHXY[1] = $ClientSz[1]
	$WHXY[2] = $GuiPos[0]
	$WHXY[3] = $GuiPos[1]
EndFunc

Func _PosRegWrite()
	_Setting_Write($sPath_Set, 'Setting', 'WHXY', $WHXY[0] & '|' & $WHXY[1] & '|' & $WHXY[2] & '|' & $WHXY[3] & '|' & $WHXY[4], $TrReg)
EndFunc

Func WM_HOTKEY($hWnd, $msg, $wParam, $lParam)
	If BitAND($wParam, 0x0000FFFF) = $HotkeyID Then
		Send('^{INS}')
		Sleep(30)
		_BtnJump()
	EndIf
	Return $GUI_RUNDEFMSG
EndFunc

Func _Setting()
	Local $M1, $Gui1, $OK, $font = "Arial", $aID[3][3] = [[' regjump.exe'],[' regscanner.exe'],[' nircmd.exe']], $y = 25, $iWCB_Input, $hHotkey_Jump, $tmp
	$GP = _ChildCoor($GUI, 310, 245)
	GUISetState(@SW_DISABLE, $GUI)
	$Gui1 = GUICreate($LngMd, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $GUI)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\JumpReg.ico')

	GUICtrlCreateGroup($LngSSY, 10, 5, 225, 106)

	$M1 = GUICtrlCreateRadio($LngNoU, 20, 25, 150, 17)
	For $i = 0 To 2
		$y += 20
		$aID[$i][2] = GUICtrlCreateLabel('home', 180, $y, 50, 17)
		GUICtrlSetCursor(-1, 0)
		GUICtrlSetColor(-1, 0x0000ff)
		GUICtrlSetFont(-1, -1, 600, 6, $font)
		$aID[$i][1] = GUICtrlCreateRadio($LngUse & $aID[$i][0], 20, $y, 150, 17)
	Next
	Switch $mode
		Case 1
			GUICtrlSetState($aID[0][1], 1)
		Case 2
			GUICtrlSetState($aID[1][1], 1)
		Case 3
			GUICtrlSetState($aID[2][1], 1)
		Case Else
			GUICtrlSetState($M1, 1)
	EndSwitch

	GUICtrlCreateLabel($LngSHX, 10, 122, 165, 17)
	$hHotkey_Jump = _GuiCtrlHotKey_Create($Gui1, 175, 120, 110, 20)
	_GuiCtrlHotKey_SetHotkey($hHotkey_Jump, _WinAPI_LoWord($HotkeySave), _WinAPI_HiWord($HotkeySave))

	GUICtrlCreateLabel($LngWCB, 10, 147, 165, 17)
	$iWCB_Input = GUICtrlCreateInput('', 175, 145, 40, 20)
	GUICtrlSetData(-1, $WidthCombo)

	GUICtrlCreateLabel($LngHsIB2, 10, 172, 165, 17)
	$iHisSz = GUICtrlCreateInput('', 175, 170, 40, 20)
	GUICtrlSetData(-1, $kol_item)


	$OK = GUICtrlCreateButton("OK", 120, 205, 70, 28)
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
	GUISetState(@SW_SHOW, $Gui1)

	While 1
		Switch GUIGetMsg()
			Case $aID[0][2]
				ShellExecute('http://technet.microsoft.com/en-us/sysinternals/bb963880')
			Case $aID[1][2]
				ShellExecute('http://www.nirsoft.net/utils/regscanner.html')
			Case $aID[2][2]
				ShellExecute('http://www.nirsoft.net/utils/nircmd.html')
			Case $OK
				; установка режима
				If GUICtrlRead($M1) = 1 Then $mode = 0
				If GUICtrlRead($aID[0][1]) = 1 Then $mode = 1
				If GUICtrlRead($aID[1][1]) = 1 Then $mode = 2
				If GUICtrlRead($aID[2][1]) = 1 Then $mode = 3
				_Setting_Write($sPath_Set, 'Setting', 'mode', $mode, $TrReg)
				; If ProcessExists("regedit.exe") Then
				; ProcessClose("regedit.exe")
				; ProcessWaitClose("regedit.exe")
				; EndIf

				; ширина списка
				$tmp = _CheckWidthCombo(GUICtrlRead($iWCB_Input))
				If $tmp <> $WidthCombo Then
					$WidthCombo = $tmp
					_GUICtrlComboBox_SetDroppedWidth($comboreg, $WidthCombo)
					_Setting_Write($sPath_Set, 'Setting', 'WidthCombo', $WidthCombo, $TrReg)
				EndIf

				; горячая клавиша
				$aHotkey = _GuiCtrlHotKey_GetHotkey($hHotkey_Jump)
				If IsArray($aHotkey) Then
					$tmp = _WinAPI_MakeLong($aHotkey[0], $aHotkey[1])
					If $HotkeySave <> $tmp Then
						If _GuiCtrlHotKey_RegisterHotkey($GUI, $HotkeyID, $aHotkey[0], $aHotkey[1]) Then
							$HotkeySave = $tmp
							_Setting_Write($sPath_Set, 'Setting', 'Hotkey', $HotkeySave, $TrReg)
						Else
							MsgBox(0, $LngMs1, $LngMs11 & ' ' & _GetKey($tmp) & ',' & @CRLF & $LngMs12, 0, $Gui1)
							$HotkeySave = 0
						EndIf
					EndIf
				Else
					_GuiCtrlHotKey_UnregisterHotkey($GUI, $HotkeyID)
					_Setting_Write($sPath_Set, 'Setting', 'Hotkey', '0', $TrReg)
					$HotkeySave = 0
				EndIf

				; количество пунктов в списке
				$kol_item = Number(GUICtrlRead($iHisSz)) ;($LngHsIB1
				If StringIsDigit($kol_item) = 0 Or $kol_item = 0 Or $kol_item > 50 Then $kol_item = 26 ; количество пунктов в комбобоксе
				_Setting_Write($sPath_Set, 'Setting', 'HistorySize', $kol_item, $TrReg)
				_HisSz()

				ContinueCase
			Case -3
				_WinAPI_DestroyWindow($hHotkey_Jump)
				GUISetState(@SW_ENABLE, $GUI)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func _GetKey($HotkeySave)
	$LoW = _WinAPI_LoWord($HotkeySave)
	$HiW = _WinAPI_HiWord($HotkeySave)
	Local $key = 0

	If BitAND($HiW, $HOTKEYF_SHIFT) Then $key &= ' + Shift'
	If BitAND($HiW, $HOTKEYF_CONTROL) Then $key &= ' + Ctrl'
	If BitAND($HiW, $HOTKEYF_ALT) Then $key &= ' + Alt'

	$key &= ' + ' & Chr($LoW)
	$key = StringTrimLeft($key, 3)

	Return $key
EndFunc

Func _CheckWidthCombo($w)
	If Not StringIsDigit($w) Then $w = 600
	$w = Number($w)
	If $w > @DesktopWidth Then $w = @DesktopWidth
	Return $w
EndFunc

Func _About()
	Local $Gui1, $font, $url1, $url2
	$GP = _ChildCoor($GUI, 270, 180)
	GUISetState(@SW_DISABLE, $GUI)
	$font = "Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $GUI)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\JumpReg.ico')
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel('JumpReg', 0, 0, 270, 63, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 15, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 268, 1, 0x10)

	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.8.1  2012.08.22', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 55, 115, 40, 17)
	$url1 = GUICtrlCreateLabel('azjio.ucoz.ru', 55, 115, 150, 15, 0x1)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	$url2 = GUICtrlCreateLabel('oszone.net', 55, 130, 150, 15, 0x1)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('Copyright AZJIO © 2011-2012', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)

	While 1
		Switch GUIGetMsg()
			Case $url1
				ShellExecute('http://azjio.ucoz.ru')
			Case $url2
				ShellExecute('http://forum.oszone.net')
			Case -3
				GUISetState(@SW_ENABLE, $GUI)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc