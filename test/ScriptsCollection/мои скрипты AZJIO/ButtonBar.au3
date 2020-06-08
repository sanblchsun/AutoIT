;  @AZJIO 27.06.2013 (AutoIt3_v3.3.8.1)

#region
#AutoIt3Wrapper_Outfile=ButtonBar.exe
#AutoIt3Wrapper_OutFile_X64=ButtonBarX64.exe
; #AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Icon=ButtonBar.ico
; #AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=
#AutoIt3Wrapper_Res_Description=ButtonBar.exe
#AutoIt3Wrapper_Res_Fileversion=0.7.6.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.7.6
#AutoIt3Wrapper_Res_Field=Build|2013.06.27
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#endregion

#NoTrayIcon
#include <ButtonConstants.au3>
#include <ForButtonBar.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <Constants.au3>
#include <WinAPI.au3>
#include <StaticConstants.au3>

; #include <Array.au3> ; Для теста

#region
; En
$LngTitle = 'ButtonBar'
$LngAbout = 'About'
$LngVer = 'Version'
$LngCopy = 'Copy'
$LngSite = 'Site'
$LngMs1 = 'First start'
$LngMs2 = 'In the upper left corner of the panel appears and creates a configuration file ButtonBar.ini' & @CRLF & @CRLF & 'Help' & @CRLF
$LngErr = 'Error'
$LngMs3 = 'The section name has repeated - "'
$LngMs4 = 'It is necessary to correct ButtonBar.ini'
$LngMs5 = 'Corrupted file ButtonBar.ini'
$LngMs6 = 'It is impossible leave without buttons'
$LngMs7 = 'Path and arguments already exist'
$LngMs8 = 'The path contains a GUID, and probably add a button will be broken. Want to add this (Yes)? Or cancel (No) - open the program directory to throw at the panel EXE- file?'
$LngExt = 'Exit'
$LngRe = 'Restart ButtonBar'
$LngTM = 'Always on top'
$LngOini = 'Open ButtonBar.ini'
$LngVrt = 'Vertical'
$LngISz = '32 / 16 The size of icons'
$LngSUp = 'Startup'
$LngUSB = 'USB'
$LngDel = 'Remove the shortcut'
$LngHM = 'Help'
$LngHide = 'AutoHide'
$LngHTp = 'Sensitive edge'
$LngRd1 = 'Top of the screen'
$LngRd2 = 'On the right screen'
$LngRd3 = 'Left of the screen'
$LngRd4 = 'Bottom of the screen'
$LngDly = 'Delay, ms :'
$LngOpnE = 'Open in Explorer'

$LngHelp = 'Drag the shortcut or file or folder on the toolbar. Button appears on the panel and saved in ButtonBar.ini.' & @CRLF & 'The left side of the panel is intended to drag the panel and has a context menu with "Exit", "always on top".' & @CRLF & 'It supports all file formats, folder (with support for icons). If the icon does not match, then remove the "-" symbol before the number of icons'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'ButtonBar'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngCopy = 'Копировать'
	$LngSite = 'Сайт'
	$LngMs1 = 'Первый запуск'
	$LngMs2 = 'В левом верхнем углу появится панель и создастся файл настройки ButtonBar.ini' & @CRLF & @CRLF & 'Справка' & @CRLF
	$LngErr = 'Ошибка'
	$LngMs3 = 'Повторилось имя секции "'
	$LngMs4 = 'Необходимо исправить ButtonBar.ini'
	$LngMs5 = 'Неисправный файл ButtonBar.ini'
	$LngMs6 = 'Нельзя оставлять без кнопок'
	$LngMs7 = 'Кнопка с такой ссылкой и параметрами уже существует'
	$LngMs8 = 'Путь содержит GUID, добавляемая кнопка будет неработающей. Хотите продолжить добавление (Да)? Или отменяем (Нет) открывая каталог программы, чтоб бросить на панель EXE-файл?'
	$LngExt = 'Выход'
	$LngRe = 'Перезапуск'
	$LngTM = 'Поверх всех окон'
	$LngOini = 'Открыть ButtonBar.ini'
	$LngVrt = 'Вертикально'
	$LngISz = '32 / 16 Размер иконок'
	$LngSUp = 'Автозагрузка с Windows'
	$LngUSB = 'USB'
	$LngDel = 'Удалить ярлык'
	$LngHM = 'Справка'
	$LngHide = 'Автоскрытие'
	$LngHTp = 'Чувствительный край'
	$LngRd1 = 'Сверху экрана'
	$LngRd2 = 'Справа экрана'
	$LngRd3 = 'Слева экрана'
	$LngRd4 = 'Снизу экрана'
	$LngDly = 'Задержка, мсек :'
	$LngOpnE = 'Открыть в проводнике'
	$LngHelp = 'Перетаскиваем ярлык, файл или папку на панель, появится кнопка на панели и сохранится в ButtonBar.ini.' & @CRLF & 'Левая часть панели предназначена для перетаскивания панели и имеет контекстное меню с пунктами "выход", "поверх всех окон".' & @CRLF & 'Поддерживаются все форматы файлов, папки (с поддержкой иконок), обработка ярлыков.' & @CRLF & 'Если иконка не соответствует, то удалите символ "-" перед номером иконки'
EndIf
#endregion

Global $DWidth = @DesktopWidth, $DHeight = @DesktopHeight, $hd[6], $TrMn = 0, $tmp, $TrgSave_ini = 0, $sOpenToExplorerDef = 'Explorer.exe /select,'
Opt('GUIResizeMode', 802) ; не перемещать, не изменять размеры кнопок

$Ini = @ScriptDir & '\ButtonBar.ini'
If $CmdLine[0] Then
	If FileExists($CmdLine[1]) Then $Ini = $CmdLine[1]
EndIf
If Not FileExists($Ini) Then
	MsgBox(0, $LngMs1, $LngMs2 & $LngHelp) ; первый запуск
	$hFile = FileOpen($Ini, 2)
	FileWrite($hFile, '[ButtonBar]' & @CRLF & _
			'xpos=0' & @CRLF & _
			'ypos=0' & @CRLF & _
			'Topmost=1' & @CRLF & _
			'Color=3f3f3f' & @CRLF & _
			'Vertical=0' & @CRLF & _
			'IconSize=0' & @CRLF & _
			'AutoHide=0' & @CRLF & _
			'Delay=800' & @CRLF & _
			'DisplayChange=1' & @CRLF & _
			'HotKey=0' & @CRLF & _
			'usb=0' & @CRLF & _
			'OpenToExplorer=' & $sOpenToExplorerDef & @CRLF & _
			@CRLF & _
			'[0]' & @CRLF & _
			'exe=%SystemRoot%\system32\notepad.exe' & @CRLF & _
			'ico=%SystemRoot%\system32\notepad.exe' & @CRLF)
	FileClose($hFile)
EndIf

$aIniSec = IniReadSectionNames($Ini)
If @error Or $aIniSec[0] < 2 Then ; ошибка если ini-файл пустой
	Exit MsgBox(0, $LngErr, $LngMs5)
EndIf
_test_Ini() ; тест дубликатов

$sOpenToExplorer = IniRead($Ini, 'ButtonBar', 'OpenToExplorer', $sOpenToExplorerDef)
If Not $sOpenToExplorer Then $sOpenToExplorer = $sOpenToExplorerDef

$ifLargeIcon = Number(IniRead($Ini, 'ButtonBar', 'IconSize', '0'))
If $ifLargeIcon Then
	$iSizeICO = 39
Else
	$iSizeICO = 23
	$ifLargeIcon = 0
EndIf
$ifHide = Number(IniRead($Ini, 'ButtonBar', 'AutoHide', '0'))
$HotKey = IniRead($Ini, 'ButtonBar', 'HotKey', '0')
$Delay = Number(IniRead($Ini, 'ButtonBar', 'Delay', '800'))
$usb = Number(IniRead($Ini, 'ButtonBar', 'usb', '0'))
$ifVertical = Number(IniRead($Ini, 'ButtonBar', 'Vertical', '0'))
$Color = IniRead($Ini, 'ButtonBar', 'Color', '3f3f3f')
$xpos = IniRead($Ini, 'ButtonBar', 'xpos', -1)
$ypos = IniRead($Ini, 'ButtonBar', 'ypos', -1)
If $usb Then $ScriptDrive = StringLeft(@ScriptDir, 1) ; Извлечь букву диска с которого запущен скрипт
$tmppos = $xpos & 'x' & $ypos ; для проверки изменений перед сохранением координат
$WidthBar = ($aIniSec[0] - 1) * $iSizeICO + 10 ; длина по количеству кнопок

If $HotKey <> '0' And Not $ifHide Then ; Скрытие по горячей клавиши
	$tmp = _HotKeyString_To_AutoitCode($HotKey)
	If Not @error Then
		; если раскладка не совпадает с англ. яз. то переключаем в неё, чтобы зарегистрировать горячие клавиши
		$KeyLayout = RegRead("HKCU\Keyboard Layout\Preload", 1)
		If Not @error And $KeyLayout <> 00000409 Then _WinAPI_LoadKeyboardLayoutEx(0x0409)
		HotKeySet($tmp, "_Visible")
	EndIf
EndIf

If $ifHide Then
	_SetHide($DWidth, $DHeight, 1) ; GUI-полоска в один пискель для актвирования наведением
	$Gui_tr = GUICreate('', $hd[2], $hd[3], $hd[0], $hd[1], $WS_POPUP, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST + $WS_EX_LAYERED)
	_WinAPI_SetLayeredWindowAttributes($Gui_tr, 0x0, 1)
	GUISetState()
EndIf

If $ifVertical Then
	$x2 = $iSizeICO
	$y2 = ($aIniSec[0] - 1) * $iSizeICO + 10
	$x3 = $iSizeICO
	$y3 = 9
	$HeightBar = $WidthBar
	$WidthBar = $iSizeICO
	$x1 = 0
Else
	;горизонтально
	$x2 = ($aIniSec[0] - 1) * $iSizeICO + 10
	$y2 = $iSizeICO
	$x3 = 9
	$y3 = $iSizeICO
	$HeightBar = $iSizeICO
	$y1 = 0
EndIf
If $xpos > $DWidth - $WidthBar Then $xpos = $DWidth - $WidthBar
If $ypos > $DHeight - $HeightBar Then $ypos = $DHeight - $HeightBar
If $HeightBar >= $DHeight Or $ypos < -1 Then $ypos = 0
If $WidthBar >= $DWidth Or $xpos < -1 Then $xpos = 0

$GUI = GUICreate("ButtonBar", $WidthBar, $HeightBar, $xpos, $ypos, $WS_POPUP, BitOR($WS_EX_ACCEPTFILES, $WS_EX_TOOLWINDOW, $WS_EX_LAYERED))
GUISetBkColor(Dec($Color))
_WinAPI_SetLayeredWindowAttributes($GUI, 0, 255, 0x02, True)
; _WinAPI_SetLayeredWindowAttributes($GUI, 0xE0DFE3, 255, 0x01) ; делает кнопки прозрачными

$CatchDrop = GUICtrlCreateLabel('', 0, 0, $x2, $y2) ; лэйбл для бросания ярлыков на панель
GUICtrlSetState(-1, 128 + 8)
GUICtrlSetResizing(-1, 1)

$Label = GUICtrlCreateLabel('', 0, 0, $x3, $y3, -1, $GUI_WS_EX_PARENTDRAG) ; лэйбл для перетаскивания панели
GUICtrlSetBkColor(-1, Dec($Color))

$contextmenu = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
$hMenuMain = GUICtrlGetHandle($contextmenu)
$Exit = GUICtrlCreateMenuItem($LngExt, $contextmenu)
$restart = GUICtrlCreateMenuItem($LngRe, $contextmenu)
$Topmost = GUICtrlCreateMenuItem($LngTM, $contextmenu)
$OpenIni = GUICtrlCreateMenuItem($LngOini, $contextmenu)
$VerticalM = GUICtrlCreateMenuItem($LngVrt, $contextmenu)
$IconSizeM = GUICtrlCreateMenuItem($LngISz, $contextmenu)
$HideM = GUICtrlCreateMenuItem($LngHide, $contextmenu)
$StartupM = GUICtrlCreateMenuItem($LngSUp, $contextmenu)
$USBM = GUICtrlCreateMenuItem($LngUSB, $contextmenu)
$Help = GUICtrlCreateMenuItem($LngHM, $contextmenu)
$About = GUICtrlCreateMenuItem($LngAbout, $contextmenu)
If $ifHide Then GUICtrlSetState($HideM, 1)
If $usb Then GUICtrlSetState($USBM, 1)
If $ifLargeIcon Then GUICtrlSetState($IconSizeM, 1)
If $ifVertical Then GUICtrlSetState($VerticalM, 1)

; проверка автозагрузки
$TrSUp = RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", 'ButtonBar_azjio')
If Not @error And $TrSUp = '"' & @ScriptFullPath & '"' Then
	GUICtrlSetState($StartupM, 1)
	$TrSUp = 1
Else
	$TrSUp = 0
EndIf

$Mark = GUICtrlCreateLabel('', -2, -1, 1, 1)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetBkColor(-1, 0xFF0000)

Global $aEXE[$aIniSec[0]][7], $iSizeICO
Global $d = 1
For $i = 1 To $aIniSec[0]
	If $aIniSec[$i] = 'ButtonBar' Then ContinueLoop
	$dsc = IniRead($Ini, $aIniSec[$i], 'dsc', '')
	$aEXE[$d][1] = IniRead($Ini, $aIniSec[$i], 'exe', '')
	If $aEXE[$d][1] = '' Then ContinueLoop ; игнорирование кнопки с пустой строкой
	If $usb <> 0 Then $aEXE[$d][1] = $ScriptDrive & ':' & StringRegExpReplace($aEXE[$d][1], '(^.*):(.*)$', '\2')
	$aEXE[$d][2] = IniRead($Ini, $aIniSec[$i], 'arg', '')
	$aEXE[$d][3] = IniRead($Ini, $aIniSec[$i], 'wrk', '')
	If $usb <> 0 Then $aEXE[$d][3] = $ScriptDrive & ':' & StringRegExpReplace($aEXE[$d][3], '(^.*):(.*)$', '\2')
	$ico = IniRead($Ini, $aIniSec[$i], 'ico', '')
	If $usb <> 0 Then $ico = $ScriptDrive & ':' & StringRegExpReplace($ico, '(^.*):(.*)$', '\2')
	$nmr = IniRead($Ini, $aIniSec[$i], 'nmr', 0)
	If $ifVertical = 0 Then
		$x1 = ($d - 1) * $iSizeICO + 10
	Else
		$y1 = ($d - 1) * $iSizeICO + 10
	EndIf
	$aEXE[$d][0] = GUICtrlCreateButton($d, $x1, $y1, $iSizeICO, $iSizeICO, $BS_ICON + $BS_FLAT)
	If $ico <> '' Then
		Number($nmr)
		GUICtrlSetImage(-1, $ico, $nmr, $ifLargeIcon)
	EndIf
	$aEXE[$d][6] = $aIniSec[$i]
	If $dsc <> '' Then
		If StringLen($dsc) < 35 Then
			GUICtrlSetTip($aEXE[$d][0], $dsc)
		Else
			GUICtrlSetTip($aEXE[$d][0], StringRegExpReplace($dsc, '(.{35,}?)\h', '$1' & @CRLF))
		EndIf
	EndIf
	$d += 1
Next
$aEXE[0][0] = $d - 1
$iFirst = $aEXE[1][0]

; Массив aEXE
; [0] - ID кнопки
; [1] - путь к объекту
; [2] - аргументы запуска
; [3] - Рабочий каталог
; [4] - ContextMenu
; [5] - MenuItem Удаление кнопок
; [6] - Имя секции

; 0=ID
; 1=exe
; 2=arg
; 3=wrk
; 4=ContextMenu
; 5=Menuitem_Delete
; 6=name_section

; _ArrayDisplay($aEXE, 'Array')

$ContMenu = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
$hMenu = GUICtrlGetHandle($ContMenu)
$iMenuDel = GUICtrlCreateMenuItem($LngDel, $ContMenu)
$iMenuOpnE = GUICtrlCreateMenuItem($LngOpnE, $ContMenu)

GUISetState(@SW_SHOW, $GUI)
If $ifHide Then ; Если скрытие, то плавно скрываем панель
	Sleep(300)
	For $i = 245 To 1 Step -7
		_WinAPI_SetLayeredWindowAttributes($GUI, 0x0, $i, 0x02, True)
		Sleep(10)
	Next
	GUISetState(@SW_HIDE, $GUI)
	GUIRegisterMsg(0x0084, 'WM_NCHITTEST')
	GUIRegisterMsg(0x011F, "WM_MENUSELECT")
EndIf

Global Const $SPI_GETWORKAREA = 0x30
Global $nGap = 5

GUIRegisterMsg(0x0046, "WM_WINDOWPOSCHANGING") ; Прилипать к краям экрана
If IniRead($Ini, 'ButtonBar', 'DisplayChange', '1') <> 0 Then GUIRegisterMsg(0x007E, "WM_DISPLAYCHANGE") ; реагировать на смену разрешения экрана
If IniRead($Ini, 'ButtonBar', 'Topmost', 0) = 1 Then ; Поверх всех окон
	WinSetOnTop($GUI, '', 1)
	GUICtrlSetState($Topmost, 1)
EndIf

OnAutoItExitRegister('_Exit_Save') ; Сохранение координат при выходе

Local $aInfoID[5]

While 1
	$Msg = GUIGetMsg()
	; ToolTip($Msg &@CRLF& $ertwer) ; частый код -11 при активном окне и 0 при неактивном
	If $Msg = 0 Then ; 0 это когда окно неактивно, чтобы уменьшить проверку
		Sleep(20)
		ContinueLoop
	EndIf
	Switch $Msg
		Case $GUI_EVENT_SECONDARYUP
			$aInfoID = GUIGetCursorInfo()
			If Not @error Then
				If $aInfoID[4] >= $iFirst Then
					$tmp = $hMenu
				ElseIf $aInfoID[4] = $Label Then
					$tmp = $hMenuMain
				EndIf
				$x = MouseGetPos(0)
				$y = MouseGetPos(1)
				DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $tmp, "int", 0, "int", $x, "int", $y, "hwnd", $GUI, "ptr", 0)
			EndIf
		Case $iMenuDel
			For $i = 1 To $aEXE[0][0]
				If $aInfoID[4] = $aEXE[$i][0] Then
					_Del($i)
					ExitLoop
				EndIf
			Next
		Case $iMenuOpnE
			For $i = 1 To $aEXE[0][0]
				If $aInfoID[4] = $aEXE[$i][0] Then
					Opt('ExpandEnvStrings', 1)
					If Not FileExists($aEXE[$i][1]) Then ContinueLoop 2
					Run($sOpenToExplorer & ' "' & $aEXE[$i][1] & '"')
					Opt('ExpandEnvStrings', 0)
				EndIf
			Next
		Case $GUI_EVENT_PRIMARYDOWN
			_MoveButton() ; перемещение кнопки
			; If @error Then ContinueCase
			; _ArrayDisplay($aEXE, 'Проверка массива')
		Case $iFirst To 100000 ; теперь циклы проверяются только при событии клика
			For $i = 1 To $aEXE[0][0]
				If $Msg = $aEXE[$i][0] Then
					Opt('ExpandEnvStrings', 1)
					If Not FileExists($aEXE[$i][1]) Then ContinueLoop 2
					If $aEXE[$i][3] = '' And StringInStr('|exe|bat|cmd|vbs|au3|', '|' & StringRegExpReplace($aEXE[$i][1], '.*\.(\w+)', '\1') & '|') Then $aEXE[$i][3] = StringRegExpReplace($aEXE[$i][1], '^(.*)\\.*$', '\1') ; если рабочий каталог не задан, то используется текущий
					; If _FO_IsDir($aEXE[$i][1]) Then
						; $tmp = $aEXE[$i][1]
					; Else
						; $tmp = FileGetShortName($aEXE[$i][1])
					; EndIf
					ShellExecute(FileGetShortName($aEXE[$i][1]), $aEXE[$i][2], $aEXE[$i][3])
					Opt('ExpandEnvStrings', 0)
				EndIf
			Next
		Case $HideM
			If $ifHide = 0 Then
				_Gui_Hide()
			Else
				IniWrite($Ini, 'ButtonBar', 'AutoHide', 0)
			EndIf
			_restart()
		Case $USBM
			If $usb = 0 Then
				IniWrite($Ini, 'ButtonBar', 'usb', 1)
			Else
				IniWrite($Ini, 'ButtonBar', 'usb', 0)
			EndIf
			_restart()
		Case $IconSizeM
			If $ifLargeIcon = 0 Then
				IniWrite($Ini, 'ButtonBar', 'IconSize', 1)
			Else
				IniWrite($Ini, 'ButtonBar', 'IconSize', 0)
			EndIf
			_restart()
		Case $VerticalM
			If $ifVertical = 0 Then
				IniWrite($Ini, 'ButtonBar', 'Vertical', 1)
			Else
				IniWrite($Ini, 'ButtonBar', 'Vertical', 0)
			EndIf
			_restart()
		Case $StartupM
			If $TrSUp = 0 Then
				RegWrite("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", 'ButtonBar_azjio', "REG_SZ", '"' & @ScriptFullPath & '"')
				GUICtrlSetState($StartupM, 1)
				$TrSUp = 1
			Else
				RegDelete("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", 'ButtonBar_azjio')
				GUICtrlSetState($StartupM, 4)
				$TrSUp = 0
			EndIf
		Case $OpenIni
			$Editor = _FileAssociation('.txt')
			If @error And Not FileExists($Editor) Then $Editor = 'notepad.exe'
			Run($Editor & ' "' & $Ini & '"')
		Case $Help
			_Gui_Help()
		Case $Topmost
			$TrTop = IniRead($Ini, 'ButtonBar', 'Topmost', 0)
			If $TrTop = 0 Then
				WinSetOnTop($GUI, '', 1)
				IniWrite($Ini, 'ButtonBar', 'Topmost', 1)
				GUICtrlSetState($Topmost, 1)
			Else
				WinSetOnTop($GUI, '', 0)
				IniWrite($Ini, 'ButtonBar', 'Topmost', 0)
				GUICtrlSetState($Topmost, 4)
			EndIf
		Case -13
			_add(@GUI_DragFile)
		Case $About
			_About()
		Case $restart
			_restart()
		Case $Exit
			Exit
	EndSwitch
WEnd

Func _MoveButton()
	Local $idxBtn2, $aClientSize, $aCur_Info, $tmp, $idx, $w, $h, $aID_Pos, $iTmpID, $iTmpPos
	$aCur_Info = GUIGetCursorInfo($GUI)
	If $aCur_Info[4] >= $iFirst Then ; если ID больше минимального, то
		If $ifVertical Then
			; $y1 = $d * $iSizeICO + 10
			$idx = 1
			$w = $iSizeICO
			$h = 3
		Else
			; $x1 = $d * $iSizeICO + 10
			$idx = 0
			$w = 3
			$h = $iSizeICO
		EndIf
		$iTmpID = $aCur_Info[4] ; Идентификатор целевой кнопки
		$iTmpPos = $aCur_Info[$idx] ; координата целевой кнопки
		$tmp = $aCur_Info[$idx] ; кэш координаты для игнорирования, если мышь не движется
		; $aID_Pos = ControlGetPos($GUI, '', $Mark)
		$aClientSize = WinGetClientSize($GUI) ; определение длины панели для игнорирования действий за пределами панели
		$hMark = GUICtrlGetHandle($Mark) ; дескриптор для _WinAPI_SetWindowPos
		GUICtrlSetState($Mark, $GUI_SHOW) ; показывает разделитель
		; _WinAPI_SetWindowPos($hMark, $HWND_TOP, 0, 0, 0, 0, $SWP_SHOWWINDOW) ; попытка переместить на верх Z-порядка и потом обработать
		While 1
			Sleep(10)
			$aCur_Info = GUIGetCursorInfo($GUI) ; получаем новую инфу

			; If Not ($tmp = $aCur_Info[$idx] Or $aCur_Info[$idx] < 10 Or $aClientSize[$idx] < $aCur_Info[$idx]) Then ; если курсор на панели и он изменился, то
			If $tmp <> $aCur_Info[$idx] And $aCur_Info[$idx] > 10 And $aClientSize[$idx] > $aCur_Info[$idx] Then ; если курсор на панели и он изменился, то
				$idxBtn2 = Int(($aCur_Info[$idx] - 10) / $iSizeICO) ; вычисление номера кнопки назначения
				$iPos = $idxBtn2 * $iSizeICO + 10 ; вычисление позиции кнопки назначения в пикселах
				If $aCur_Info[$idx] > $iTmpPos Then $iPos +=$iSizeICO ; если кнопка назначения болшьше (левее) целевой, то разделитель делаем правее кнопки
				If $ifVertical Then
					_WinAPI_SetWindowPos($hMark, $HWND_TOP, 0, $iPos, $w, $h, $SWP_SHOWWINDOW)
					; _WinAPI_SetWindowPos($iTmpID, $HWND_TOP, 0, $iPos, $iSizeICO, $iSizeICO, $SWP_SHOWWINDOW)
					; GUICtrlSetPos($iTmpID, 0, $iPos, $w, $h)
				Else
					_WinAPI_SetWindowPos($hMark, $HWND_TOP, $iPos, 0, $w, $h, $SWP_SHOWWINDOW)
					; _WinAPI_SetWindowPos($iTmpID, $HWND_TOP, $iPos, 0, $iSizeICO, $iSizeICO, $SWP_SHOWWINDOW)
					; GUICtrlSetPos($iTmpID, $iPos, 0, $w, $h)
				EndIf
				$tmp = $aCur_Info[$idx] ; кэшируем координату
			EndIf
			If Not $aCur_Info[2] Then ExitLoop ; выход если курсор отпущен
		WEnd
		GUICtrlSetState($Mark, $GUI_HIDE) ; скрывает разделитель
		$aID_Pos = ControlGetPos($GUI, '', $Mark)
		If $aID_Pos[$idx] = -2 Or IsString($idxBtn2) Then Return SetError(1, 0, 0) ; Если позиция мыши не изменилась и разделитель не перемещался (что является кликом), то вылет
		GUICtrlSetPos($Mark, -2, -2, 1, 1) ; восстанавливаем позицию разделителя

		; $idxBtn2 = Int(($tmp - 10) / $iSizeICO) +1
		; $idxBtn2 +=1
		For $i = 1 To $aEXE[0][0] ; Определяем точную позицию целевой кнопки по положению в массиве
			If $aEXE[$i][0] = $iTmpID Then
				$idxBtn1 = $i
				ExitLoop
			EndIf
		Next
		; MsgBox(0, 'Сообщение', $idxBtn1 &@CRLF& $idxBtn2)
		; Номер кнопки назначения вычисляется по координатам, что даёт возможность вычислить, даже если курсор не находится в пределах панели.
		$idxBtn2 += 1
		If $idxBtn2 < 0 Then $idxBtn2 = 0
		If $idxBtn2 > $aEXE[0][0] Then $idxBtn2 = $aEXE[0][0]
		If $idxBtn1 = $idxBtn2  Then Return SetError(1, 0, 0)
		; ToolTip($idxBtn1 & @CRLF & $idxBtn2) ; проверяем индексы

		If $idxBtn1 > $idxBtn2 Then
			; MsgBox(0, 'Сообщение', $idxBtn1 &@CRLF& $idxBtn2 &@CRLF& $aEXE[$idxBtn1][6] &@CRLF& $aEXE[$idxBtn2][6])
			Local $aTemp[7]
			For $j = 0 To 6
				$aTemp[$j] = $aEXE[$idxBtn1][$j]
			Next

			$y1 = Default
			$x1 = Default
			For $i = $idxBtn1 - 1 To $idxBtn2 Step -1
				If $ifVertical Then
					$y1 = $i * $iSizeICO + 10
				Else
					$x1 = $i * $iSizeICO + 10
				EndIf
				GUICtrlSetPos($aEXE[$i][0], $x1, $y1)
				For $j = 0 To 6
					$aEXE[$i + 1][$j] = $aEXE[$i][$j]
				Next
			Next
			For $j = 0 To 6
				$aEXE[$idxBtn2][$j] = $aTemp[$j]
			Next
			If $ifVertical Then
				$y1 = ($idxBtn2 - 1) * $iSizeICO + 10
			Else
				$x1 = ($idxBtn2 - 1) * $iSizeICO + 10
			EndIf
			GUICtrlSetPos($aTemp[0], $x1, $y1)

		Else ; Перемещение в левую часть
			Local $aTemp[7]
			For $j = 0 To 6
				$aTemp[$j] = $aEXE[$idxBtn1][$j]
			Next

			$y1 = Default
			$x1 = Default
			For $i = $idxBtn1 + 1 To $idxBtn2 ; этот сдвиг правильный
				If $ifVertical Then
					$y1 = ($i - 2) * $iSizeICO + 10
				Else
					$x1 = ($i - 2) * $iSizeICO + 10
				EndIf
				GUICtrlSetPos($aEXE[$i][0], $x1, $y1)
				For $j = 0 To 6
					$aEXE[$i - 1][$j] = $aEXE[$i][$j]
				Next
			Next
			For $j = 0 To 6
				$aEXE[$idxBtn2][$j] = $aTemp[$j]
			Next
			If $ifVertical Then
				$y1 = ($idxBtn2 - 1) * $iSizeICO + 10
			Else
				$x1 = ($idxBtn2 - 1) * $iSizeICO + 10
			EndIf
			GUICtrlSetPos($aTemp[0], $x1, $y1)
		EndIf
		$TrgSave_ini = 1
		AdlibRegister('_Save_ini', 60 * 1000) ; регистрируем сохренение ini-файла с задержкой, чтобы дать выполнить несколько изменений пользователю
	EndIf
EndFunc   ;==>_MoveButton

Func _Save_ini()
	AdlibUnRegister("_Save_ini")
	If $TrgSave_ini = 0 Then Return
	$TrgSave_ini = 0
	$SectionNames = IniReadSectionNames($Ini)
	Local $aKeyValue[$SectionNames[0] +1]
	For $i = 1 To $SectionNames[0]
		$aKeyValue[$i] = IniReadSection($Ini, $SectionNames[$i])
	Next
	
	If FileDelete($Ini) Then
		For $j = 1 To $SectionNames[0]
			If $SectionNames[$j] = 'ButtonBar' Then IniWriteSection($Ini, $SectionNames[$j], $aKeyValue[$j])
		Next
		For $i = 1 To $aEXE[0][0]
			For $j = 1 To $SectionNames[0]
				If $SectionNames[$j] = $aEXE[$i][6] Then IniWriteSection($Ini, $SectionNames[$j], $aKeyValue[$j])
			Next
		Next
	EndIf
EndFunc   ;==>_Exit_Save

Func _Exit_Save()
	If $TrgSave_ini Then _Save_ini()
	; If Not IsDeclared('Gui') Then Exit
	$GP = WinGetPos($GUI)
	If $tmppos <> $GP[0] & 'x' & $GP[1] Then
		IniWrite($Ini, 'ButtonBar', 'xpos', $GP[0])
		IniWrite($Ini, 'ButtonBar', 'ypos', $GP[1])
	EndIf
EndFunc   ;==>_Exit_Save

Func _Del($idx)
	; If $TrgSave_ini Then _Save_ini()
	If $aEXE[0][0] = 1 Then
		MsgBox(0, $LngErr, $LngMs6)
		Return
	EndIf
	IniDelete($Ini, $aEXE[$idx][6]) ; удаление секции
	GUICtrlDelete($aEXE[$idx][0]) ; удаление кнопки с панели

	For $i = $idx + 1 To $aEXE[0][0]
		If $ifVertical Then
			$y1 = ($i - 2) * $iSizeICO + 10
		Else
			$x1 = ($i - 2) * $iSizeICO + 10
		EndIf
		GUICtrlSetPos($aEXE[$i][0], $x1, $y1)
		For $j = 0 To 6
			$aEXE[$i - 1][$j] = $aEXE[$i][$j]
		Next
	Next

	ReDim $aEXE[$aEXE[0][0]][7]
	$aEXE[0][0] -= 1

	Local $GP = WinGetPos($GUI)
	If $ifVertical Then
		$GP[3] -= $iSizeICO
	Else
		$GP[2] -= $iSizeICO
	EndIf
	WinMove($GUI, '', $GP[0], $GP[1], $GP[2], $GP[3])
EndFunc   ;==>_Del

Func _add($gaDropFiles)
	; If $TrgSave_ini Then _Save_ini()
	Local $type = StringRegExpReplace($gaDropFiles, '.*\.([^\\/:*?"<>|]+)', '\1') ; Извлеч расширение файла
	Local $aLNK[7]
	$NAME = StringRegExpReplace($gaDropFiles, '^(?:.*\\)([^\\]+?)(?:\.[^.]+)?$', '\1') ; извлекаем имя файла без расширения
	$aLNK[0] = $gaDropFiles
	If StringInStr(FileGetAttrib($gaDropFiles), "D") Then ; Если папка, то
		$aLNK[4] = @SystemDir & '\shell32.dll' ; Используем иконку папки
		$aLNK[5] = 3
		Opt('ExpandEnvStrings', 1) ; извлечение путей из desktop.ini требует раскрытия переменных типа %name%
		If FileExists($gaDropFiles & '\desktop.ini') Then ; Если есть desktop.ini, тоизвлекаем иконку из него
			$desktop1 = IniRead($gaDropFiles & '\desktop.ini', '.ShellClassInfo', 'IconFile', '-|-')
			$desktop2 = IniRead($gaDropFiles & '\desktop.ini', '.ShellClassInfo', 'IconIndex', '-|-')
			If FileExists($gaDropFiles & '\' & $desktop1) Then
				$aLNK[4] = $gaDropFiles & '\' & $desktop1
				$aLNK[5] = $desktop2
			ElseIf FileExists($desktop1) Then
				$aLNK[4] = $desktop1
				$aLNK[5] = $desktop2
			EndIf
		EndIf
		Opt('ExpandEnvStrings', 0)
	Else ; Иначе если файл
		Switch $type
			Case "lnk"
				Opt('ExpandEnvStrings', 1) ; извлечение путей из lnk требует раскрытия переменных типа %name%
				$aLNK = FileGetShortcut($gaDropFiles)
				If Not @error And StringInStr(FileGetAttrib($aLNK[0]), "D") Then ; Если ярлык на папку, то
					$aLNK[4] = @SystemDir & '\shell32.dll'
					$aLNK[5] = 3
					If FileExists($aLNK[0] & '\desktop.ini') Then
						$desktop1 = IniRead($aLNK[0] & '\desktop.ini', '.ShellClassInfo', 'IconFile', '-|-')
						$desktop2 = IniRead($aLNK[0] & '\desktop.ini', '.ShellClassInfo', 'IconIndex', '-|-')
						If FileExists($aLNK[0] & '\' & $desktop1) Then
							$aLNK[4] = $aLNK[0] & '\' & $desktop1
							$aLNK[5] = $desktop2
						ElseIf FileExists($desktop1) Then
							$aLNK[4] = $desktop1
							$aLNK[5] = $desktop2
						EndIf
					EndIf
				ElseIf Not @error And $aLNK[4] = '' And StringRight($aLNK[0], 4) <> '.exe' Then ; Если не на exe-файл, то
					$aPathIco = _TypeGetIco(StringRegExpReplace($aLNK[0], '.*\.([^\\/:*?"<>|]+)', '\1'))
					If Not @error Then
						$aLNK[4] = $aPathIco[0]
						If $aPathIco[2] <> '' Then $aLNK[5] = $aPathIco[2]
					EndIf
				EndIf
				Opt('ExpandEnvStrings', 0)
			Case 'exe', 'scr', 'ico' ; если кинут exe-файл, то
				$aLNK[4] = $gaDropFiles
			Case Else
				$aPathIco = _TypeGetIco($type)
				If Not @error Then
					$aLNK[4] = $aPathIco[0]
					If $aPathIco[2] <> '' Then $aLNK[5] = $aPathIco[2]
				EndIf
		EndSwitch
	EndIf

	For $i = 1 To $aEXE[0][0]
		If $aEXE[$i][1] & $aEXE[$i][2] = $aLNK[0] & $aLNK[2] Then ; Проверка, что такая команда уже есть на панели
			MsgBox(0, $LngErr, $LngMs7)
			Return
		EndIf
	Next

	; Если GUID вместо пути в ярлыке, то
	If StringRegExp($aLNK[0], '(?i)\{[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}\}') Then
		If MsgBox(4 + 256, $LngErr, $LngMs8) = 7 Then ; Рекомендуемая кнопка по умолчению "Нет" (256)
			$tmpGUID = StringRegExpReplace($aLNK[0], '(?i).*?(\{[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}\}).*', '\1')
			$tmpGUID = RegRead('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' & $tmpGUID, 'InstallLocation')
			If Not @error Then ShellExecute(FileGetShortName($tmpGUID)) ; открыть папку, если удалось извлечь путь из реестра
			Return
		EndIf
	EndIf

	$aEXE[0][0] += 1
	$d = $aEXE[0][0] ; так удобный читать, $d это индекс последней кнопки
	ReDim $aEXE[$d + 1][7] ; увеличивает массив под новую кнопку

	$GP = WinGetPos($GUI)
	If $ifVertical Then
		$y1 = $GP[3]
		$GP[3] += $iSizeICO
	Else
		$x1 = $GP[2]
		$GP[2] += $iSizeICO
	EndIf
	WinMove($GUI, '', $GP[0], $GP[1], $GP[2], $GP[3]) ; увелививает панель согласно новому размеру

	$NameSec = StringRegExpReplace($gaDropFiles, '^(?:.*\\)([^\\]+?)(?:\.[^.]+)?$', '\1') ; извлекаем имя файла без расширения
	$NameSec &= '_' & Random(100, 999, 1) & '_' & $d ; формирует имя секции
	$aEXE[$d][1] = $aLNK[0]
	$aEXE[$d][2] = $aLNK[2]
	If $aLNK[1] <> '' Then
		$aLNK[1] = StringReplace($aLNK[1], '"', '')
		IniWrite($Ini, $NameSec, 'wrk', $aLNK[1])
		$aEXE[$d][3] = $aLNK[1]
	EndIf
	IniWrite($Ini, $NameSec, 'exe', $aLNK[0])
	If $aLNK[2] <> '' Then IniWrite($Ini, $NameSec, 'arg', $aLNK[2])
	$aEXE[$d][0] = GUICtrlCreateButton($d, $x1, $y1, $iSizeICO, $iSizeICO, $BS_ICON + $BS_FLAT)
	If $aLNK[5] = '' Then $aLNK[5] = 0
	If $aLNK[4] Then ; исключения
		If StringInStr(';ini;inf;html;', ';' & $type & ';') Then
			$aLNK[5] = StringReplace($aLNK[5], '-', '')
		ElseIf StringLeft($aLNK[5], 1) = '-' Then
			$aLNK[5] = Number($aLNK[5])
		ElseIf StringInStr('.dll.exe.cpl.apl.', '.' & StringRegExpReplace($aLNK[4], '.*\.([^\\/:*?"<>|]+)', '\1') & '.') And $aLNK[5] > 0 Then
			$aLNK[5] = Execute(-1 - $aLNK[5])
		Else
			$aLNK[5] = Number(1 + $aLNK[5])
		EndIf
		GUICtrlSetImage($aEXE[$d][0], $aLNK[4], $aLNK[5], $ifLargeIcon)
		IniWrite($Ini, $NameSec, 'ico', $aLNK[4])
		IniWrite($Ini, $NameSec, 'nmr', $aLNK[5])
	Else
		GUICtrlSetImage($aEXE[$d][0], $aLNK[0], 0, $ifLargeIcon)
		IniWrite($Ini, $NameSec, 'ico', $aLNK[0])
	EndIf
	$aEXE[$d][6] = $NameSec
	If $aLNK[3] <> '' Then
		$NAME &= ' - ' & $aLNK[3]
	EndIf
	IniWrite($Ini, $NameSec, 'dsc', $NAME)
	If StringLen($NAME) < 35 Then
		GUICtrlSetTip($aEXE[$d][0], $NAME)
	Else
		GUICtrlSetTip($aEXE[$d][0], StringRegExpReplace($NAME, '(.{35,}?)\h', '$1' & @CRLF))
	EndIf
EndFunc   ;==>_add

Func _test_Ini()
	For $i = 1 To $aIniSec[0]
		If IsDeclared($aIniSec[$i] & '/') Then
			Exit MsgBox(0, $LngErr, $LngMs3 & $aIniSec[$i] & '"' & @CRLF & $LngMs4)
		Else
			Assign($aIniSec[$i] & '/', '', 1)
		EndIf
	Next
EndFunc   ;==>_test_Ini

Func _TypeGetIco($type)
	Local $aPathErr[3] = [@SystemDir & '\shell32.dll', ',', 0]
	Local $typefile = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $type, 'Progid'), $aPath[3]
	If @error Or $typefile = '' Then
		$typefile = RegRead('HKCR\.' & $type, '')
		If @error Then Return $aPathErr
	EndIf
	$typefile = RegRead('HKCR\' & $typefile & '\DefaultIcon', '')
	If @error Then Return $aPathErr
	Local $aPath = StringRegExp($typefile, '(?i)(^.*)(,)(.*)$', 3)
	If @error Then
		Local $aPath[3]
		$aPath[0] = $typefile
	Else
		$aPath[0] = StringReplace($aPath[0], '"', '')
	EndIf
	Opt('ExpandEnvStrings', 1)
	If FileExists($aPath[0]) Then
		$aPath[0] = $aPath[0]
		Opt('ExpandEnvStrings', 0)
		Return $aPath
	EndIf
	Opt('ExpandEnvStrings', 0)
	If FileExists(@SystemDir & '\' & $aPath[0]) Then
		$aPath[0] = @SystemDir & '\' & $aPath[0]
		Return $aPath
	ElseIf FileExists(@WindowsDir & '\' & $aPath[0]) Then
		$aPath[0] = @WindowsDir & '\' & $aPath[0]
		Return $aPath
	EndIf
	Return $aPathErr
EndFunc   ;==>_TypeGetIco

Func _Visible()
	If BitAND(WinGetState($GUI), 2) Then
		; $Text&='не скрыто'&@LF ; @SW_SHOW
		GUISetState(@SW_HIDE, $GUI)
	Else
		; $Text&='скрыто'&@LF ; @SW_HIDE
		GUISetState(@SW_SHOW, $GUI)
	EndIf
EndFunc   ;==>_Visible

; Прилипать к краям экрана
; http://www.autoitscript.com/forum/topic/24342-form-snap/page__view__findpost__p__170144
Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
	Local $stRect = DllStructCreate("int;int;int;int")
	Local $stWinPos = DllStructCreate("uint;uint;int;int;int;int;uint", $lParam)
	DllCall("User32.dll", "int", "SystemParametersInfo", "int", $SPI_GETWORKAREA, "int", 0, "ptr", DllStructGetPtr($stRect), "int", 0)
	Local $nRight = DllStructGetData($stRect, 3) - DllStructGetData($stWinPos, 5)
	Local $nBottom = DllStructGetData($stRect, 4) - DllStructGetData($stWinPos, 6)
	If Abs(DllStructGetData($stWinPos, 3)) <= $nGap Then DllStructSetData($stWinPos, 3, 0)
	If Abs(DllStructGetData($stWinPos, 4)) <= $nGap Then DllStructSetData($stWinPos, 4, 0)
	If Abs($nRight - DllStructGetData($stWinPos, 3)) <= $nGap Then DllStructSetData($stWinPos, 3, $nRight)
	If Abs($nBottom - DllStructGetData($stWinPos, 4)) <= $nGap Then DllStructSetData($stWinPos, 4, $nBottom)
	$xpos = DllStructGetData($stWinPos, 3)
	$ypos = DllStructGetData($stWinPos, 4)
	Return 0
EndFunc   ;==>WM_WINDOWPOSCHANGING

Func WM_DISPLAYCHANGE($hWnd, $iMsg, $wParam, $lParam)
	Local $tmpW = $DWidth, $tmpH = $DHeight
	$DWidth = Dec(StringMid(Hex($lParam), 5, 8))
	$DHeight = Dec(StringMid(Hex($lParam), 1, 4))
	If $ifHide Then _SetHide($DWidth, $DHeight)
	Local $GP = WinGetPos($GUI)

	If $GP[0] > $DWidth - $GP[2] Then $GP[0] = $DWidth - $GP[2]
	If $GP[1] > $DHeight - $GP[3] Then $GP[1] = $DHeight - $GP[3]

	If $DWidth > $tmpW And $GP[0] > $tmpW / 2 Then $GP[0] = $DWidth - $tmpW + $GP[0]
	If $DHeight > $tmpH And $GP[1] > $tmpH / 2 Then $GP[1] = $DHeight - $tmpH + $GP[1]

	If $DWidth < $tmpW And $xpos > $tmpW / 2 Then $GP[0] = $DWidth - $tmpW + $xpos
	If $DHeight < $tmpH And $ypos > $tmpH / 2 Then $GP[1] = $DHeight - $tmpH + $ypos

	If $GP[3] >= $DHeight Or $GP[1] < -1 Then $GP[1] = 0
	If $GP[2] >= $DWidth Or $GP[0] < -1 Then $GP[0] = 0
	WinMove($GUI, '', $GP[0], $GP[1], $GP[2], $GP[3])
EndFunc   ;==>WM_DISPLAYCHANGE

Func _SetHide($xD, $yD, $Start = 0)
	Switch $ifHide
		Case 1
			$hd[0] = 0
			$hd[1] = 0
			$hd[2] = $xD
			$hd[3] = 2
			$hd[4] = -2
			$hd[5] = 0
		Case 2
			$hd[0] = $xD - 1
			$hd[1] = 0
			$hd[2] = 1
			$hd[3] = $yD
			$hd[4] = 2
			$hd[5] = 1
		Case 3
			$hd[0] = 0
			$hd[1] = 0
			$hd[2] = 1
			$hd[3] = $yD
			$hd[4] = -2
			$hd[5] = 1
		Case 4
			$hd[0] = 0
			$hd[1] = $yD - 1
			$hd[2] = $xD
			$hd[3] = 1
			$hd[4] = 2
			$hd[5] = 0
		Case Else
			MsgBox(0, 'Message', $LngErr & ' > ini > ' & $LngHide)
			Exit
	EndSwitch
	If $Start = 0 Then WinMove($Gui_tr, '', $hd[0], $hd[1], $hd[2], $hd[3])
EndFunc   ;==>_SetHide

Func _Gui_Help()
	GUISetState(@SW_DISABLE, $GUI)
	Local $Gui1 = GUICreate($LngHM, 400, 140, -1, -1, BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $GUI)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\ButtonBar.ico', 1)
	GUICtrlCreateLabel($LngHelp, 15, 10, 380, 130)
	GUISetState(@SW_SHOW, $Gui1)
	While 1
		If GUIGetMsg() = -3 Then
			GUISetState(@SW_ENABLE, $GUI)
			GUIDelete($Gui1)
			ExitLoop
		EndIf
	WEnd
EndFunc   ;==>_Gui_Help

Func _Gui_Hide()
	GUISetState(@SW_DISABLE, $GUI)
	$GP = _GetChildCoor($GUI, 190, 170)
	Local $Gui1 = GUICreate($LngHTp, $GP[0], $GP[1], $GP[2], $GP[3], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $GUI)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\ButtonBar.ico', 1)
	; GUICtrlCreateGroup('', 6, 3, 168, 128)
	Local $Radio[5]
	$Radio[1] = GUICtrlCreateRadio($LngRd1, 15, 20, 140, 17)
	GUICtrlSetState(-1, 1)
	$Radio[2] = GUICtrlCreateRadio($LngRd2, 15, 40, 140, 17)
	$Radio[3] = GUICtrlCreateRadio($LngRd3, 15, 60, 140, 17)
	$Radio[4] = GUICtrlCreateRadio($LngRd4, 15, 80, 140, 17)
	GUICtrlCreateLabel($LngDly, 15, 103, 90, 17)
	Local $DelayInput = GUICtrlCreateInput($Delay, 106, 101, 45, 20)
	Local $ok = GUICtrlCreateButton('OK', 60, 136, 70, 30)
	GUISetState(@SW_SHOW, $Gui1)
	While 1
		Switch GUIGetMsg()
			Case $ok
				$Delay = GUICtrlRead($DelayInput)
				If $Delay < 400 Then $Delay = 400
				IniWrite($Ini, 'ButtonBar', 'Delay', $Delay)
				For $i = 1 To 4
					$Radio0 = GUICtrlRead($Radio[$i])
					If $Radio0 = 1 Then
						IniWrite($Ini, 'ButtonBar', 'AutoHide', $i)
						ExitLoop
					EndIf
				Next
				ContinueCase
			Case -3
				GUISetState(@SW_ENABLE, $GUI)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_Gui_Hide

Func WM_NCHITTEST($hWnd, $Msg, $wParam, $lParam)
	Local $yClient = BitShift($lParam, 16)

	If $yClient Then
		If $hWnd = $Gui_tr Then
			If Not BitAND(WinGetState($GUI), 2) Then
				GUISetState(@SW_SHOW, $GUI)
				For $i = 15 To 235 Step 20
					_WinAPI_SetLayeredWindowAttributes($GUI, 0x0, $i, 0x02, True)
					Sleep(10)
				Next
				_WinAPI_SetLayeredWindowAttributes($GUI, 0x0, 255, 0x02, True)
			Else
				GUISetState(@SW_SHOW, $GUI)
			EndIf
			AdlibRegister('_DelayGui', $Delay)
			If $ifHide = 1 Or $ifHide = 4 Then
				WinMove($Gui_tr, '', Default, $hd[1] + $hd[4])
			Else
				WinMove($Gui_tr, '', $hd[0] + $hd[4], Default)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>WM_NCHITTEST

Func _DelayGui()
	Local $MP = MouseGetPos()
	If $MP[Number(Not $hd[5])] = $hd[Number(Not $hd[5])]Then Return

	Local $WinPos = WinGetPos($GUI)
	If $MP[0] >= $WinPos[0] And $MP[0] <= $WinPos[0] + $WinPos[2] And $MP[1] >= $WinPos[1] And $MP[1] <= $WinPos[1] + $WinPos[3] Then Return

	If $TrMn Then Return

	AdlibUnRegister('_DelayGui')
	For $i = 245 To 1 Step -14
		_WinAPI_SetLayeredWindowAttributes($GUI, 0x0, $i, 0x02, True)
		Sleep(10)
	Next
	GUISetState(@SW_HIDE, $GUI)
	If $ifHide = 1 Or $ifHide = 4 Then
		WinMove($Gui_tr, '', Default, $hd[1])
	Else
		WinMove($Gui_tr, '', $hd[0], Default)
	EndIf
EndFunc   ;==>_DelayGui

Func WM_MENUSELECT($hWnd, $Msg, $wParam, $lParam)
	$TrMn = BitShift($lParam, 16) ; если активировано меню, то не скрывать GUI
EndFunc   ;==>WM_MENUSELECT

; Func _FO_IsDir($sTmp)
	; $sTmp = FileGetAttrib($sTmp)
	; Return SetError(@error, 0, StringInStr($sTmp, 'D', 2) > 0)
; EndFunc   ;==>_FO_IsDir

Func _About()
	Local $font, $GP, $Gui1, $url, $WbMn
	$GP = _GetChildCoor($GUI, 270, 180)
	GUISetState(@SW_DISABLE, $GUI)
	$font = "Arial"
	$Gui1 = GUICreate($LngAbout, $GP[0], $GP[1], $GP[2], $GP[3], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $GUI)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\ButtonBar.ico', 1)
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, $SS_CENTER + $SS_CENTERIMAGE)
	GUICtrlSetFont(-1, 15, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 268, 1, 0x10)

	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.7.6   27.06.2013', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 55, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010-2013', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
	While 1
		Switch GUIGetMsg()
			Case $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $WbMn
				ClipPut('R939163939152')
			Case -3
				GUISetState(@SW_ENABLE, $GUI)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_About