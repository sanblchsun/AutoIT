#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=CaptureText.exe
#AutoIt3Wrapper_Icon=CaptureText.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=CaptureText.exe
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.1
#AutoIt3Wrapper_Res_Field=Build|2012.06.12
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2012.06.12 (AutoIt3_v3.3.6.1)

#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <Misc.au3>

Opt("TrayMenuMode", 1 + 2) ; Не отображать в трее пункты меню по умолчанию (Script Paused/Exit) и не отмечать галочками при выборе.
Opt("TrayOnEventMode", 1)

; En
$LngTitle = 'CaptureText'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngQuit = 'Exit'
$LngSet = 'Setting'
$LngTtx = 'Text'
$LngCls = 'Class'
$LngCID = 'ID'
$LngRct = 'Rect'
$LngStl = 'Style'
$LngSEx = 'ExStyle'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngCopy = 'Копировать'
	$LngQuit = 'Выход'
	$LngSet = 'Настройки'
	$LngTtx = 'Текст'
	$LngCls = 'Класс'
	$LngCID = 'Идентификатор'
	$LngRct = 'Прямоугольник'
	$LngStl = 'Стили'
	$LngSEx = 'Расширенные'
EndIf

Global $stl[24][2] = [[ _
		23, 23],[ _
		'0x00800000', 'WS_BORDER'],[ _
		'0x80000000', 'WS_POPUP'],[ _
		'0x00C00000', 'WS_CAPTION'],[ _
		'0x02000000', 'WS_CLIPCHILDREN'],[ _
		'0x04000000', 'WS_CLIPSIBLINGS'],[ _
		'0x08000000', 'WS_DISABLED'],[ _
		'0x00400000', 'WS_DLGFRAME'],[ _
		'0x00100000', 'WS_HSCROLL'],[ _
		'0x01000000', 'WS_MAXIMIZE'],[ _
		'0x00010000', 'WS_MAXIMIZEBOX, WS_TABSTOP'],[ _
		'0x20000000', 'WS_MINIMIZE'],[ _
		'0x00020000', 'WS_MINIMIZEBOX, WS_GROUP'],[ _
		'0x00000000', 'WS_OVERLAPPED'],[ _
		'0x00CF0000', 'WS_OVERLAPPEDWINDOW'],[ _
		'0x80880000', 'WS_POPUPWINDOW'],[ _
		'0x00080000', 'WS_SYSMENU'],[ _
		'0x00040000', 'WS_SIZEBOX, WS_THICKFRAME'],[ _
		'0x00200000', 'WS_VSCROLL'],[ _
		'0x10000000', 'WS_VISIBLE'],[ _
		'0x40000000', 'WS_CHILD'],[ _
		'0x00000080', 'DS_MODALFRAME'],[ _
		'0x00000200', 'DS_SETFOREGROUND'],[ _
		'0x00002000', 'DS_CONTEXTHELP']]

Global $estl[16][2] = [[ _
		15, 15],[ _
		'0x00000010', 'WS_EX_ACCEPTFILES'],[ _
		'0x00040000', 'WS_EX_APPWINDOW'],[ _
		'0x02000000', 'WS_EX_COMPOSITED'],[ _
		'0x00000200', 'WS_EX_CLIENTEDGE'],[ _
		'0x00000400', 'WS_EX_CONTEXTHELP'],[ _
		'0x00000001', 'WS_EX_DLGMODALFRAME'],[ _
		'0x00000040', 'WS_EX_MDICHILD'],[ _
		'0x00000300', 'WS_EX_OVERLAPPEDWINDOW'],[ _
		'0x00020000', 'WS_EX_STATICEDGE'],[ _
		'0x00000008', 'WS_EX_TOPMOST'],[ _
		'0x00000020', 'WS_EX_TRANSPARENT'],[ _
		'0x00000080', 'WS_EX_TOOLWINDOW'],[ _
		'0x00000100', 'WS_EX_WINDOWEDGE'],[ _
		'0x00080000', 'WS_EX_LAYERED'],[ _
		'0x00100000', 'GUI_WS_EX_PARENTDRAG']]

Global $Struct = DllStructCreate($tagPoint), $tmp, $xyTmp[2], $hGUI, $TrRst = 0, $hGuiR

_Create_GUI()

HotKeySet("{ESC}", "_Exit")
Func _Exit()
	Exit
EndFunc

$nSet = TrayCreateItem($LngSet)
TrayItemSetOnEvent(-1, "_Setting")

$nAbout = TrayCreateItem($LngAbout)
TrayItemSetOnEvent(-1, "_about")

$nExit = TrayCreateItem($LngQuit)
TrayItemSetOnEvent(-1, "_Exit")

TraySetToolTip($LngTitle)

TraySetOnEvent($TRAY_EVENT_PRIMARYDOWN, "_Capture")

TraySetState(1) ; Показывает меню трея
TraySetClick(16) ; Меню вызывается отпуском вторичной кнопки мыши
If Not @Compiled Then TraySetIcon(@ScriptDir & '\CaptureText.ico')

While 1
	Sleep(10000) ; бездействующий цикл
WEnd

Func _Capture()
	AdlibRegister('_Reset', 1000) ; каждую секунду проверяем нажатость мыши на случай сбоя нажатием нескольких клавиш.
	$dh = @DesktopHeight / 2
	GUISetState(@SW_UNLOCK, $hGUI)
	GUISetState(@SW_SHOW, $hGUI)
	While 1
		Switch GUIGetMsg()
			; Case $GUI_EVENT_PRIMARYDOWN, $GUI_EVENT_SECONDARYDOWN, $GUI_EVENT_SECONDARYUP
			; ContinueLoop
			Case $GUI_EVENT_PRIMARYUP
				_CaptureClipboard()
				ExitLoop
		EndSwitch
		$xy = MouseGetPos()
		; If $xy[0] <> $xyTmp[0] And $xy[1] <> $xyTmp[1] Then
		; $xyTmp[0] = $xy[0]
		; $xyTmp[1] = $xy[1]
		WinMove($hGUI, '', $xy[0] - 9, $xy[1] - 9)
		
		DllStructSetData($Struct, "x", $xy[0])
		DllStructSetData($Struct, "y", $xy[1])
		$hwnd = _WinAPI_WindowFromPoint($Struct)
		If $tmp <> $hwnd And $hwnd <> $hGuiR Then
			$a = WinGetClientSize($hwnd)
			$b = WinGetPos($hwnd)
			$tStru = _WinAPI_GetWindowRect($hwnd) ; тоже что WinGetPos
			$sText = WinGetTitle($hwnd)
			If StringLen($sText) > 150 Then $sText = StringLeft($sText, 150)
			
			$Long = _WinAPI_GetWindowLong($hwnd, $GWL_ID)
			$info = _
					$LngTtx & ' = ' & $sText & @CRLF & _
					$LngCls & ' = ' & _WinAPI_GetClassName($hwnd) & @CRLF & _
					$LngCID & ' = ' & _WinAPI_GetDlgCtrlID($hwnd) & ',  Long = ' & $Long & @CRLF & _
					$LngRct & ': L=' & DllStructGetData($tStru, 1) & ', T=' & DllStructGetData($tStru, 2) & ', R=' & DllStructGetData($tStru, 3) & ', B=' & DllStructGetData($tStru, 4) & @CRLF & _
					'x,y,w,h = ' & $b[0] & ', ' & $b[1] & ',' & @TAB & $b[2] & ', ' & $b[3] & @TAB & ' (client:' & $a[0] & ', ' & $a[1] & ')'
			If $Long <= 0 Then
				$aStyle = _WinAPI_GetWindowLong($hwnd, $GWL_STYLE)
				$aExStyle = _WinAPI_GetWindowLong($hwnd, $GWL_EXSTYLE)
				If $aStyle > 0 Then $aStyle = @CRLF & $LngStl & ': 0x' & Hex(Int($aStyle), 8) & @CRLF & _Assot(_ArrGetVal($aStyle), $stl)
				If $aExStyle > 0 Then $aExStyle = @CRLF & $LngSEx & ': 0x' & Hex(Int($aExStyle), 8) & @CRLF & _Assot(_ArrGetVal($aExStyle), $estl)
			Else
				$aStyle = ''
				$aExStyle = ''
			EndIf
			$info &= _
					$aStyle & $aExStyle
			If $xy[1] > $dh Then
				ToolTip($info, 0, 0)
			Else
				ToolTip($info, 0, $dh + 40)
			EndIf
			$tmp = $hwnd
			_RedRect($b[0] - 1, $b[1] - 1, $b[2] + 3, $b[3] + 3)
		EndIf
		If $TrRst Then
			_CaptureClipboard()
			$TrRst = 0
			ExitLoop
		EndIf
	WEnd
EndFunc

Func _RedRect($x, $y, $w, $h)
	If $x = -1 Then $x = 0
	If $y = -1 Then $y = 0
	If $hGuiR Then GUIDelete($hGuiR)
	$hGuiR = GUICreate('', $w, $h, $x, $y, $WS_POPUP, $WS_EX_TOPMOST + $WS_EX_TOOLWINDOW)
	GUISetBkColor(0xFF0000)
	$rgn = _WinAPI_CreateRoundRectRgn(0, 0, $w, $h, 0, 0)
	$rgn2 = _WinAPI_CreateRoundRectRgn(2, 2, $w - 2, $h - 2, 0, 0)
	_WinAPI_CombineRgn($rgn, $rgn, $rgn2, $RGN_DIFF)
	_WinAPI_DeleteObject($rgn2)
	_WinAPI_SetWindowRgn($hGuiR, $rgn)
	GUISetState(@SW_SHOW, $hGuiR)
	GUISetState(@SW_DISABLE, $hGuiR)
EndFunc

Func _ArrGetVal($Value)
	Local $sOut, $n = 0.5
	For $i = 0 To Int(Log($Value) / Log(2))
		$n *= 2
		If BitAND($Value, $n) Then $sOut &= '0x' & Hex(Int($n), 8) & @LF
		; If BitAnd($Value, $n) Then $sOut&='0x'&StringFormat("%08x", $n) &@LF
		; If BitAnd($Value, $n) Then $sOut&=StringFormat("%#x", $n) &@LF
	Next
	Return StringTrimRight($sOut, 1)
EndFunc

Func _Assot($val, $aStl)
	If $val = '' Then Return ''
	Local $tmp, $out
	$val = StringSplit($val, @LF)
	For $i = 1 To $val[0]
		$tmp = ''
		For $j = 1 To $aStl[0][0]
			If Number($val[$i]) = Number($aStl[$j][0]) Then
				$tmp = $val[$i] & ' - ' & $aStl[$j][1] & @CRLF
				ExitLoop
			EndIf
		Next
		If Not $tmp Then $tmp = $val[$i] & ' - не найдено' & @CRLF
		$out &= $tmp
	Next
	Return StringTrimRight($out, 2)
EndFunc

Func _CaptureClipboard()
	$xy = MouseGetPos()
	; GUIDelete()
	GUISetState(@SW_HIDE, $hGUI)
	GUISetState(@SW_LOCK, $hGUI)
	DllStructSetData($Struct, "x", $xy[0])
	DllStructSetData($Struct, "y", $xy[1])
	$hwnd = _WinAPI_WindowFromPoint($Struct)
	Switch 1
		Case _IsPressed(11) ; Ctrl
			ClipPut(Hex(Int(PixelGetColor($xy[0], $xy[1])), 6)) ; Цвет
		Case _IsPressed(12) ; Shift
			ClipPut(_WinAPI_GetClassName($hwnd)) ; Класс окна
		Case _IsPressed(10) ; Alt
			$aStyle = _WinAPI_GetWindowLong($hwnd, $GWL_STYLE)
			$aExStyle = _WinAPI_GetWindowLong($hwnd, $GWL_EXSTYLE)
			If $aStyle > 0 Then $aStyle = @CRLF & $LngStl & ': 0x' & Hex(Int($aStyle), 8) & @CRLF & _Assot(_ArrGetVal($aStyle), $stl)
			If $aExStyle > 0 Then $aExStyle = @CRLF & $LngSEx & ': 0x' & Hex(Int($aExStyle), 8) & @CRLF & _Assot(_ArrGetVal($aExStyle), $estl)
			ClipPut($aStyle & $aExStyle)
		Case Else
			ClipPut(WinGetTitle($hwnd)) ; Заголовок или Текст окна
	EndSwitch
	ToolTip('')
	If $hGuiR Then GUIDelete($hGuiR)
	AdlibUnRegister('_Reset')
EndFunc

Func _Reset()
	If Not _IsPressed(01) Then $TrRst = 1
EndFunc

Func _Create_GUI()
	Local $hFile, $hImage, $sData
	$sData = '0x89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF61000000BE4944415478DA6364C003FE0311230303233E358C5834C901A93C200E036259207E0CC4AB80781250F123BC0600351702A96020CE05E24B40FC07885980580F882703F15AA0867EAC0640358B0205AA707901C86F0352AF910D614472F63220C786810000AA3D02A4A260DE8119D003A4960239E78930C010484503D596201B00324D11C8F94B28168062CC40EA3E23C4D50C8CFFC16228810233F43F3E319838E52EA0561850160B14A7033443C84B894886909F17B018467A6E241500005523501162A6990D0000000049454E44AE426082'
	$hFile = FileOpen(@TempDir & '\CaptureCursor.png', 18)
	FileWrite($hFile, Binary($sData))
	FileClose($hFile)

	$hGUI = GUICreate("", 16, 16, @DesktopWidth, @DesktopHeight, $WS_POPUP, $WS_EX_LAYERED + $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST)
	; GUISetCursor(16)
	_GDIPlus_Startup()
	$hImage = _GDIPlus_ImageLoadFromFile(@TempDir & '\CaptureCursor.png') ; иконка в центре должна иметь прозрачные пикселы, чтобы захватывать окна под курсором, а не окно курсора
	If @error Then
		MsgBox(0, 'Сообщение', 'Не удалось открыть иконку курсора')
		Exit
	EndIf
	SetBitmap($hGUI, $hImage, 255)
	_WinAPI_DeleteObject($hImage)
	_GDIPlus_Shutdown()
	GUISetState(@SW_LOCK)
EndFunc

Func SetBitmap($hGUI, $hImage, $iOpacity)
	Local $hScrDC, $hMemDC, $hBitmap, $hOld, $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend

	$hScrDC = _WinAPI_GetDC(0)
	$hMemDC = _WinAPI_CreateCompatibleDC($hScrDC)
	$hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
	$hOld = _WinAPI_SelectObject($hMemDC, $hBitmap)
	$tSize = DllStructCreate($tagSIZE)
	$pSize = DllStructGetPtr($tSize)
	DllStructSetData($tSize, "X", _GDIPlus_ImageGetWidth($hImage))
	DllStructSetData($tSize, "Y", _GDIPlus_ImageGetHeight($hImage))
	$tSource = DllStructCreate($tagPoint)
	$pSource = DllStructGetPtr($tSource)
	$tBlend = DllStructCreate($tagBLENDFUNCTION)
	$pBlend = DllStructGetPtr($tBlend)
	DllStructSetData($tBlend, "Alpha", $iOpacity)
	DllStructSetData($tBlend, "Format", 1)
	_WinAPI_UpdateLayeredWindow($hGUI, $hScrDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA)
	_WinAPI_ReleaseDC(0, $hScrDC)
	_WinAPI_SelectObject($hMemDC, $hOld)
	_WinAPI_DeleteObject($hBitmap)
	_WinAPI_DeleteDC($hMemDC)
EndFunc

Func _About()
	TraySetOnEvent($TRAY_EVENT_PRIMARYDOWN, '')
	; $TrGui=1
	_StateMenu(128)
	$font = "Arial"
	$Gui1 = GUICreate($LngAbout, 270, 180, @DesktopWidth - 350, @DesktopHeight - 260, BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP))
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\CaptureText.ico')
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 15, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 268, 1, 0x10)
	
	GUISetFont(9, 600, -1, $font)

	GUICtrlCreateLabel($LngVer & ' 0.1  12.06.2012', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 55, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2012', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
	; GUISwitch($Gui1)
	While 1
		Switch GUIGetMsg()
			Case $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $WbMn
				ClipPut('R939163939152')
			Case -3
				GUIDelete($Gui1)
				; GUISwitch($hGUI)
				_StateMenu(64)
				TraySetOnEvent($TRAY_EVENT_PRIMARYDOWN, "_Capture")
				; $TrGui=0
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func _Setting()
	TrayItemSetState($nSet, 128)
EndFunc

Func _StateMenu($s)
	TrayItemSetState($nSet, $s)
	TrayItemSetState($nAbout, $s)
	TrayItemSetState($nExit, $s)
EndFunc