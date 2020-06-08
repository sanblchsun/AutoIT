#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Compare_strings.exe
#AutoIt3Wrapper_Icon=Compare_strings.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Compare_strings.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Icon_Add=1.ico
#AutoIt3Wrapper_Res_Field=Version|0.2
#AutoIt3Wrapper_Res_Field=Build|2012.12.25
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2012.12.25 AutoIt3_v3.3.6.1

#NoTrayIcon

#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <File.au3>
#include <FileOperations.au3>
#include "Function.au3"
; #include <Array.au3>

; En
$LngTitle = 'Compare strings'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngSB = 'Statusbar'
$LngCS1 = 'Unique strings 2-file which are not present in the first'
$LngCS2 = 'Duplicate strings in 2-x files'
$LngCS3 = 'Unique strings of the one file, removes duplicates'
$LngCS4 = 'Counting unique strings in a file'
$LngErr = 'Error'
$LngRe = 'Restart "Compare strings"'
$LngScn = 'Start'
$LngOpF = 'Open file'
$LngMS2 = 'left and right path pointing to the same file'
$LngSpr = 'Separator'
$LngSp1 = 'Line break'
$LngSp2 = 'Any white space character'
$LngSp3 = 'Enter your separator'
$LngAll = 'All files'
$LngSB1 = 'Elements are reversed'
$LngSB2 = '... comparison is executed ...'
$LngSB3 = 'Completed, Count = '
$LngMB1 = 'Object 1 is not an existing file'
$LngMB2 = 'Object 2 is not an existing file'
$LngMB3 = 'Other error'
$LngMB4 = 'Differences it is not found'
$LngMB5 = 'Delimiter not found'
$LngClb = 'Insert from Clipboard'
$LngSwp = 'Swap'
$LngTm1 = 'within'
$LngTm2 = 'sec'
$LngOSp = 'Separator in result :'
$LngCSs = 'Case sensitive'
$LngASt = 'Entire delimiter string'

$LngCheck = 'Not to ask any more'
$LngYes = 'Yes'
$LngNo = 'No'
$sTitle = 'Message'
$sText = 'Clears the cache?'
; $Lng = ''

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	; $LngTitle = 'Compare strings'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngCopy = 'Копировать'
	$LngSB = 'Строка состояния'
	$LngCS1 = 'Уникальные строки 2-го файла, которых нет в первом'
	$LngCS2 = 'Одинаковые строки в 2-х файлах'
	$LngCS3 = 'Уникальные строки одного файла, удаляет повторы'
	$LngCS4 = 'Подсчёт уникальных строк одного файла'
	$LngErr = 'Ошибка'
	$LngRe = 'Перезапуск утилиты'
	$LngScn = 'Выполнить'
	$LngOpF = 'Открыть файл'
	$LngMS2 = 'Правый и левый путь указывают на один и тот же файл'
	$LngSpr = 'Разделитель при чтении'
	$LngSp1 = 'Перенос строки'
	$LngSp2 = 'Любой пробельный символ'
	$LngSp3 = 'Введите ваш разделитель'
	$LngAll = 'Все файлы'
	$LngSB1 = 'Элементы поменяны местами'
	$LngSB2 = '... выполняется сравнение ...'
	$LngSB3 = 'Сравнение выполнено, найдено'
	$LngMB1 = 'Объект 1 не является существующим файлом'
	$LngMB2 = 'Объект 2 не является существующим файлом'
	$LngMB3 = 'Другая ошибка'
	$LngMB4 = 'Отличий не найдено'
	$LngMB5 = 'Не найден разделитель'
	$LngClb = 'Вставить из буфера обмена'
	$LngSwp = 'Поменять местами'
	$LngTm1 = 'за'
	$LngTm2 = 'сек'
	$LngOSp = 'Разделитель в результатах :'
	$LngCSs = 'Учитывать регистр'
	$LngASt = 'Вся строка является разделителем'

	$LngCheck = 'Больше не спрашивать'
	$LngYes = 'Да'
	$LngNo = 'Нет'
	$sTitle = 'Сообщение'
	$sText = 'Очистить кэш?'
EndIf

Global $hGui, $hGui1, $sClipboard1, $sClipboard2, $k1, $k2, $sText1, $sText2, $Path01, $Path02, $sSpr, $sSpr2, $iAll, $Editor
Global $timer, $TempDir = @TempDir & '\Comparing_strings'

$iBorderHoriz = _WinAPI_GetSystemMetrics(32) * 2
$iBorderVert = _WinAPI_GetSystemMetrics(4) + _WinAPI_GetSystemMetrics(33) * 2

$Editor = _TypeGetPath('txt')
If @error Then $Editor = @SystemDir & '\notepad.exe'

Opt("GUIOnEventMode", 1)
; Opt("GUIResizeMode", 802)
; GUIRegisterMsg($WM_SIZE, "WM_SIZE")
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")

$hGui = GUICreate($LngTitle, 510, 250, -1, -1, $WS_OVERLAPPEDWINDOW + $WS_CLIPCHILDREN, $WS_EX_ACCEPTFILES)
If @Compiled Then
	$AutoItExe = @AutoItExe
Else
	$AutoItExe = @ScriptDir & '\Compare_strings.dll'
	GUISetIcon($AutoItExe, 99)
EndIf
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
GUISetOnEvent($GUI_EVENT_DROPPED, "_Dropped")

$StatusBar = GUICtrlCreateLabel($LngSB, 5, 250 - 17, 390, 17, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing(-1, 2 + 64 + 512)

GUICtrlCreateButton('R', 510 - 18, 0, 18, 18)
GUICtrlSetOnEvent(-1, "_Restart")
GUICtrlSetTip(-1, $LngRe)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateButton('@', 510 - 40, 0, 18, 18)
GUICtrlSetOnEvent(-1, "_About")
GUICtrlSetTip(-1, $LngAbout)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateLabel('1', 6, 23, -1, 17)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
GUICtrlCreateLabel('2', 6, 63, -1, 17)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)

$Path1 = GUICtrlCreateInput('', 20, 20, 435, 22)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)

$Path2 = GUICtrlCreateInput('', 20, 60, 435, 22)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)

$Open1 = GUICtrlCreateButton('opn', 456, 20, 22, 22, $BS_ICON)
GUICtrlSetOnEvent(-1, "_Open1")
GUICtrlSetImage(-1, 'shell32.dll', 4, 0)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$Open2 = GUICtrlCreateButton('opn', 456, 60, 22, 22, $BS_ICON)
GUICtrlSetOnEvent(-1, "_Open2")
GUICtrlSetImage(-1, 'shell32.dll', 4, 0)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$iClipboard1 = GUICtrlCreateButton('clb', 480, 20, 22, 22, $BS_ICON)
GUICtrlSetOnEvent(-1, "_Clipboard1")
GUICtrlSetImage(-1, $AutoItExe, 201, 0)
GUICtrlSetTip(-1, $LngClb)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$iClipboard2 = GUICtrlCreateButton('clb', 480, 60, 22, 22, $BS_ICON)
GUICtrlSetOnEvent(-1, "_Clipboard2")
GUICtrlSetImage(-1, $AutoItExe, 201, 0)
GUICtrlSetTip(-1, $LngClb)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$ComboM = GUICtrlCreateCombo("", 20, 99, 375, 23, $CBS_DROPDOWNLIST + $WS_VSCROLL) ; стиль не редактируемого списка
GUICtrlSetData(-1, '1 ' & $LngCS1 & '|2 ' & $LngCS2 & '|3 ' & $LngCS3 & '|4 ' & $LngCS4, '1 ' & $LngCS1)
GUICtrlSetOnEvent(-1, "_DeAct")
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)

GUICtrlCreateLabel($LngSpr, 45, 133, 150, 17)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
$ComboSpr = GUICtrlCreateCombo("", 195, 130, 200)
GUICtrlSetData(-1, '< ' & $LngSp1 & ' >|< ' & $LngSp2 & ' >|' & $LngSp3, '< ' & $LngSp1 & ' >')
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)
; GUICtrlSetOnEvent(-1, "_SetSeparator")

GUICtrlCreateLabel($LngOSp, 45, 163, 150, 17)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
$iOutSep = GUICtrlCreateCombo("", 195, 160, 200)
GUICtrlSetData(-1, '< ' & $LngSp1 & ' >|' & $LngSp3, '< ' & $LngSp1 & ' >')
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)

$iCSense = GUICtrlCreateCheckbox($LngCSs, 45, 190, 120, 17)
; GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetResizing(-1, 2)

$iAllStr = GUICtrlCreateCheckbox($LngASt, 45, 210, 200, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetResizing(-1, 2)

; Func _SetSeparator()
; $ComboSpr0 = GUICtrlRead($ComboSpr)
; Switch $ComboSpr0
; Case '< ' &$LngSp1 & ' >', '< ' &$LngSp2 & ' >' ; не удалось переключить стиль
; GUICtrlSetStyle($ComboSpr, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST, $WS_VSCROLL))
; Case Else
; GUICtrlSetStyle($ComboSpr, 0)
; EndSwitch
; EndFunc

$iOther = GUICtrlCreateButton('^ v', 205, 43, 32, 16, $BS_ICON)
GUICtrlSetOnEvent(-1, "_Other")
GUICtrlSetTip(-1, $LngSwp)
GUICtrlSetResizing(-1, 32 + 256 + 512)

$Scan = GUICtrlCreateButton($LngScn, 400, 200, 90, 43)
GUICtrlSetOnEvent(-1, "_Scan")
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)

$HelpCHM = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_HelpCHM")

Dim $AccelKeys[2][2] = [["{F1}", $HelpCHM],["{Enter}", $Scan]]
GUISetAccelerators($AccelKeys)

GUISetState()
While 1
	Sleep(100)
WEnd

Func _HelpCHM()
	If FileExists(@ScriptDir & '\Compare_strings.chm') Then
		ShellExecute(@ScriptDir & '\Compare_strings.chm')
	Else
		_About()
	EndIf
EndFunc   ;==>_HelpCHM

Func _Other()
	$sTmp = GUICtrlRead($Path1)
	GUICtrlSetData($Path1, GUICtrlRead($Path2))
	GUICtrlSetData($Path2, $sTmp)
	$sTmp = $sClipboard1
	$sClipboard1 = $sClipboard2
	$sClipboard2 = $sTmp
	GUICtrlSetData($StatusBar, $LngSB1)
EndFunc   ;==>_Other

Func _DeAct()
	$ComboM0 = Number(StringLeft(GUICtrlRead($ComboM), 1))
	Switch $ComboM0
		Case 1, 2
			GUICtrlSetState($Path2, $GUI_ENABLE)
			GUICtrlSetState($Open2, $GUI_ENABLE)
			GUICtrlSetState($iClipboard2, $GUI_ENABLE)
		Case 3, 4
			GUICtrlSetState($Path2, $GUI_DISABLE)
			GUICtrlSetState($Open2, $GUI_DISABLE)
			GUICtrlSetState($iClipboard2, $GUI_DISABLE)
	EndSwitch
EndFunc   ;==>_DeAct

Func _Exit2()
	GUISetState(@SW_ENABLE, $hGui)
	GUIDelete($hGui1)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
EndFunc   ;==>_Exit2

Func _Open1()
	Local $sTmp = FileOpenDialog($LngOpF, @WorkingDir, $LngAll & ' (*.*)', 1, '', $hGui)
	If @error Then Return
	GUICtrlSetData($Path1, $sTmp)
EndFunc   ;==>_Open1

Func _Open2()
	Local $sTmp = FileOpenDialog($LngOpF, @WorkingDir, $LngAll & ' (*.*)', 1, '', $hGui)
	If @error Then Return
	GUICtrlSetData($Path2, $sTmp)
EndFunc   ;==>_Open2

Func _Clipboard1()
	$sClipboard1 = ClipGet()
	$k1 += 1
	GUICtrlSetData($Path1, '< ' & $k1 & ' >')
EndFunc   ;==>_Clipboard1

Func _Clipboard2()
	$sClipboard2 = ClipGet()
	$k2 += 1
	GUICtrlSetData($Path2, '< ' & $k2 & ' >')
EndFunc   ;==>_Clipboard2

Func _Dropped()
	$sTmp = _FO_IsDir(@GUI_DragFile)
	Switch @GUI_DropId
		Case $Path1
			If Not (@error Or $sTmp) Then
				GUICtrlSetData($Path1, @GUI_DragFile)
			Else
				GUICtrlSetData($Path1, '')
			EndIf
		Case $Path2
			If Not (@error Or $sTmp) Then
				GUICtrlSetData($Path2, @GUI_DragFile)
			Else
				GUICtrlSetData($Path2, '')
			EndIf
	EndSwitch
EndFunc   ;==>_Dropped

Func _DisableGuiBtn($State)
	GUICtrlSetState($Scan, $State)
	GUICtrlSetState($ComboM, $State)
	; GUICtrlSetState($Path1, $State)
	; GUICtrlSetState($Path2, $State)
	GUICtrlSetState($Open1, $State)
	GUICtrlSetState($Open2, $State)
	GUICtrlSetState($iClipboard1, $State)
	GUICtrlSetState($iClipboard2, $State)
EndFunc   ;==>_DisableGuiBtn

Func _Scan()
	GUICtrlSetData($StatusBar, $LngSB2)
	$Path01 = GUICtrlRead($Path1)
	$Path02 = GUICtrlRead($Path2)
	$ComboM0 = Number(StringLeft(GUICtrlRead($ComboM), 1))

	If StringLeft($Path01, 1) = '<' Then
		$sText1 = $sClipboard1
	Else
		$fTmp = _FO_IsDir($Path01)
		If @error Or $fTmp Then
			GUICtrlSetData($StatusBar, $LngErr)
			MsgBox(0, $LngErr, $LngMB1, 0, $hGui)
			Return
		EndIf
		$sText1 = FileRead($Path01)
	EndIf

	If $ComboM0 = 1 Or $ComboM0 = 2 Then ; Если комбо не является случаем выбора одного файла
		If StringLeft($Path02, 1) = '<' Then
			$sText2 = $sClipboard2
		Else
			$fTmp = _FO_IsDir($Path02)
			If @error Or $fTmp Then
				GUICtrlSetData($StatusBar, $LngErr)
				MsgBox(0, $LngErr, $LngMB2, 0, $hGui)
				Return
			EndIf
			$sText2 = FileRead($Path02)
			If $Path01 = $Path02 Then
				GUICtrlSetData($StatusBar, $LngErr)
				MsgBox(0, $LngErr, $LngMS2, 0, $hGui)
				Return
			EndIf
		EndIf
	EndIf
	_DisableGuiBtn($GUI_DISABLE)

	If BitAND(GUICtrlRead($iAllStr),$GUI_CHECKED) Then
		$iAll = 1
	Else
		$iAll = 0
	EndIf
	$sSpr2 = GUICtrlRead($iOutSep)
	If $sSpr2 == '< ' &$LngSp1 & ' >' Then $sSpr2 = @CRLF

	$ComboSpr0 = GUICtrlRead($ComboSpr)
	Switch $ComboSpr0
		Case '< ' &$LngSp1 & ' >'
			$sSpr = @CRLF
		Case '< ' &$LngSp2 & ' >'
			$sSpr = @CRLF & @TAB & ' ' & Chr(160) & Chr(12) & Chr(11)
			$iAll = 0
		Case Else
			$sSpr = $ComboSpr0
	EndSwitch

	$Count = _Compare($ComboM0)

	_DisableGuiBtn($GUI_ENABLE)
	GUICtrlSetData($StatusBar, $LngSB3 & ' ' & $Count & ', ' & $LngTm1 & ' ' & $timer & ' ' & $LngTm2)
EndFunc   ;==>_Scan

Func _Compare($ComboM0)
	If Not FileExists($TempDir) Then DirCreate($TempDir)
	Local $s_TempFile = _TempFile($TempDir, '~', '.txt'), $err, $Count = 0
	If BitAND(GUICtrlRead($iCSense),$GUI_CHECKED) Then
		$casesense = 0
	Else
		$casesense = 1
	EndIf
	$timer = TimerInit()
	Switch $ComboM0
		Case 1
			$sText_Out = _Unique_Lines_Text2($sText1, $sText2, $sSpr, $sSpr2, $iAll, $casesense)
			$err = @error
			$Count = @extended
		Case 2
			$sText_Out = _Alike_Lines($sText1, $sText2, $sSpr, $sSpr2, $iAll, $casesense)
			$err = @error
			$Count = @extended
		Case 3
			$sText_Out = _StringUnique($sText1, $sSpr, $sSpr2, $iAll, $casesense)
			$err = @error
			$Count = @extended
		Case 4
			$sText_Out = _CountingStringUnique($sText1, $sSpr, $sSpr2, $iAll, $casesense)
			$err = @error
			$Count = @extended
		Case Else
			Return MsgBox(0, $LngErr, $LngMB3, 0, $hGui)
	EndSwitch
	$timer = Round(TimerDiff($timer) / 1000, 2)
	Switch $err
		Case 2
			MsgBox(0, $LngErr, $LngMB4, 0, $hGui)
		Case 1
			MsgBox(0, $LngErr, $LngMB5, 0, $hGui)
		Case 0
			$hFile = FileOpen($s_TempFile, 2) ; пишем в файл
			FileWrite($hFile, $sText_Out)
			FileClose($hFile)
			Run('"' & $Editor & '" "' & $s_TempFile & '"')
			Return $Count
		Case Else
			MsgBox(0, $LngErr, $LngMB3, 0, $hGui)
	EndSwitch
	; ClipPut($sText_Out)
EndFunc   ;==>_Compare

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $hGui Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 510 + $iBorderHoriz) ; минимальные размеры окна
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 250 + $iBorderVert)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeY", 250 + $iBorderVert)
	EndIf
EndFunc   ;==>WM_GETMINMAXINFO

Func _Exit()
	If FileExists($TempDir) Then
		$Ini = @ScriptDir & '\Compare_strings.ini'
		$iAsk = Number(IniRead($Ini, 'Setting', 'ask', '1'))
		$iAnswer = Number(IniRead($Ini, 'Setting', 'Answer', '0'))
		If $iAsk Then
			$iAnswer = _MsgAsk($sTitle, $sText, 200, 100, 0, $LngCheck, $LngYes, $LngNo, $hGui)
			If @extended Then
				IniWrite($Ini, 'Setting', 'ask', '0')
				IniWrite($Ini, 'Setting', 'Answer', $iAnswer)
			EndIf
		EndIf
		If $iAnswer Then DirRemove($TempDir, 1)
	EndIf
	Exit
EndFunc   ;==>_Exit

Func _About()
	$GP = _ChildCoor($hGui, 290, 190)
	GUIRegisterMsg(0x05, "")
	GUIRegisterMsg(0x0046, "")
	GUISetState(@SW_DISABLE, $hGui)
	$font = "Arial"
	$hGui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $hGui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 1)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit2")
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 290, 63, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 14, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 288, 1, 0x10)

	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.2  25.12.2012', 55, 100, 210, 17)
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
	GUICtrlCreateLabel('Copyright AZJIO © 2012', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $hGui1)
EndFunc   ;==>_About

Func _url()
	ShellExecute('http://azjio.ucoz.ru')
EndFunc   ;==>_url

Func _WbMn()
	ClipPut('R939163939152')
EndFunc   ;==>_WbMn