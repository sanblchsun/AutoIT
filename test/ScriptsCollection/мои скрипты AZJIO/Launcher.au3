#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Launcher.exe
#AutoIt3Wrapper_Icon=Launcher.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Launcher.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.3
#AutoIt3Wrapper_Res_Field=Build|2013.01.02
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2010.10.01 - 2013.01.02 (AutoIt3_v3.3.6.1)

#include <GUIConstantsEx.au3>
#include <GuiButton.au3>
#include <GuiImageList.au3>
#NoTrayIcon
Opt('ExpandEnvStrings', 1)

FileChangeDir(@ScriptDir)
$IniName = StringRegExpReplace(@ScriptName, '^(.*?)(?:\.[^.]+)?$', '\1') & '.ini'
$Ini = @ScriptDir & '\' & $IniName ; Name.ini = Name.exe

; En
$LngErr = 'Error'
$LngMs0 = 'Message'
$LngMs1 = 'Not found'
$LngMs2 = 'Can not create file "' & $IniName & '", the completion of the program.'
$LngMs3 = 'Repeated the name of the section'
$LngMs4 = 'The name section blank'
$LngMs5 = @LF & 'You must correct the File "' & $IniName & '"'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngErr = 'Ошибка'
	$LngMs0 = 'Сообщение'
	$LngMs1 = 'Не найден файл'
	$LngMs2 = 'Невозможно создать файл "' & $IniName & '", завершение программы.'
	$LngMs3 = 'Повторилось имя секции'
	$LngMs4 = 'Имя секции пустое'
	$LngMs5 = @LF & 'Необходимо исправить файл "' & $IniName & '"'
EndIf

If Not FileExists($Ini) Then
	_Create_ini()
	If Not FileExists($Ini) Then
		MsgBox(0, $LngErr, $LngMs1 & ' ' & $IniName)
		Exit
	EndIf
EndIf

Global $aIniSec = IniReadSectionNames($Ini)
_test_Ini($aIniSec)

$GuiBkColor = Dec(IniRead($Ini, 'GUI', 'GuiBkColor', ''))
$ButColor = Dec(IniRead($Ini, 'GUI', 'ButColor', ''))
$TextColor = Dec(IniRead($Ini, 'GUI', 'TextColor', ''))
$minW = IniRead($Ini, 'GUI', 'ButMinW', 15)
$minH = IniRead($Ini, 'GUI', 'ButMinH', 19)
If $minW < 15 Then $minW = 15
If $minH < 19 Then $minH = 19

$font = IniRead($Ini, 'GUI', 'FontSize', '')
$fontB = Number(IniRead($Ini, 'GUI', 'FontBold', ''))
$icon = IniRead($Ini, 'GUI', 'icon', '')
$PathPic = IniRead($Ini, 'GUI', 'Picture', '')
If Not StringInStr($PathPic, ':') Then
	If StringLeft($PathPic, 1) = '\' Then StringTrimLeft($PathPic, 1)
	$PathPic = @ScriptDir & '\' & $PathPic
EndIf
$row = IniRead($Ini, 'GUI', 'Row', '1')
$col = Ceiling(($aIniSec[0] - 1) / $row)
$row = Ceiling(($aIniSec[0] - 1) / $col)
$FormWidth = IniRead($Ini, 'GUI', 'FormWidth', '100')
$FormHeight = IniRead($Ini, 'GUI', 'FormHeight', ($aIniSec[0] - 1) * 25)
$GuiName = IniRead($Ini, 'GUI', 'Title', 'Launcher')

$AreaX = IniRead($Ini, 'GUI', 'AreaX', '0')
$AreaY = IniRead($Ini, 'GUI', 'AreaY', '0')
$AreaWidth = IniRead($Ini, 'GUI', 'AreaWidth', $FormWidth)
$AreaHeight = IniRead($Ini, 'GUI', 'AreaHeight', ($aIniSec[0] - 1) * 25)

$mrgn = IniRead($Ini, 'GUI', 'Margin', '2')
If $AreaWidth < 30 Then $AreaWidth = 30
If $AreaWidth / ($aIniSec[0] - 1) * $col - $mrgn < $minW Then $AreaWidth = ($aIniSec[0] - 1) / $col * ($minW + $mrgn)
If $AreaHeight / ($aIniSec[0] - 1) * $row - $mrgn < $minH Then $AreaHeight = ($aIniSec[0] - 1) / $row * ($minH + $mrgn)
Global $aEXE[$aIniSec[0] - 1][4]
$Bw = Int(($AreaWidth - $mrgn) / $row)
$Bh = Int(($AreaHeight - $mrgn) / ($aIniSec[0] - 1) * $row)

While $Bw - $mrgn < $minW
	$mrgn -= 1
	$Bw = Int(($AreaWidth - $mrgn) / $row)
	$Bh = Int(($AreaHeight - $mrgn) / ($aIniSec[0] - 1) * $row)
	If $mrgn = 0 Then ExitLoop
WEnd
While $Bh - $mrgn < $minH
	$mrgn -= 1
	$Bw = Int(($AreaWidth - $mrgn) / $row)
	$Bh = Int(($AreaHeight - $mrgn) / ($aIniSec[0] - 1) * $row)
	If $mrgn = 0 Then ExitLoop
WEnd

$AreaWidth = $Bw * $row + $mrgn
$AreaHeight = $Bh * $col + $mrgn
If $AreaWidth + $AreaX > $FormWidth Then $FormWidth = $AreaWidth + $AreaX
If $AreaHeight + $AreaY > $FormHeight Then $FormHeight = $AreaHeight + $AreaY

$hGui = GUICreate($GuiName, $FormWidth, $FormHeight)
If $icon <> '' And FileExists($icon) Then GUISetIcon($icon)
If $fontB Then
	$fontB = 700
Else
	$fontB = -1
EndIf
If $font <> '' Then GUISetFont($font, $fontB)
If $PathPic And FileExists($PathPic) Then
	$iPic = GUICtrlCreatePic($PathPic, 0, 0, $FormWidth, $FormHeight)
	GUICtrlSetState(-1, $GUI_DISABLE)
Else
	If $GuiBkColor <> '' Then GUISetBkColor($GuiBkColor)
EndIf
$k = _Button_Create($aIniSec)

GUICtrlCreateButton('Button', -5, -5, 1, 1)
GUICtrlSetState(-1, 256)

Global $AccelKeys[1][2]
$d = 0
For $i = 0 To $aIniSec[0] - 2
	If $aEXE[$i][3] Then
		ReDim $AccelKeys[$d + 1][2]
		$AccelKeys[$d][0] = $aEXE[$i][3]
		$AccelKeys[$d][1] = $aEXE[$i][0]
		$d += 1
	EndIf
Next

If $d Then
	; если раскладка не совпадает с англ. яз. то временно переключаем в неё, чтобы зарегистрировать горячие клавиши
	$tmp = 0
	$KeyLayout = RegRead("HKCU\Keyboard Layout\Preload", 1)
	If Not @error And $KeyLayout <> 00000409 Then
		_WinAPI_LoadKeyboardLayout(0x0409)
		$tmp = 1
	EndIf
	GUISetAccelerators($AccelKeys)
	If $tmp = 1 Then _WinAPI_LoadKeyboardLayout(Dec($KeyLayout)) ; восстанавливаем раскладку по умолчанию
EndIf

; #include <Array.au3>
; _ArrayDisplay($AccelKeys, 'AccelKeys')

GUISetState()
While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $aEXE[0][0] To $aEXE[$k][0]
			$i = $msg - $aEXE[0][0]
			ShellExecute($aEXE[$i][1], $aEXE[$i][2])
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

Func _Button_Create($aIniSec)
	$Nrow = 0
	$d = 0
	For $i = 1 To $aIniSec[0]
		If $aIniSec[$i] = 'GUI' Then ContinueLoop
		$aEXE[$d][0] = GUICtrlCreateButton(IniRead($Ini, $aIniSec[$i], 'name', '-'), $mrgn + $Bw * $Nrow + $AreaX, $mrgn + ($d - $Nrow * $col) * $Bh + $AreaY, $Bw - $mrgn, $Bh - $mrgn)
		$BtnIcon = IniRead($Ini, $aIniSec[$i], 'Icon', '')
		If $BtnIcon <> '' Then
			If Number(IniRead($Ini, $aIniSec[$i], 'LargeIcon', '0')) Then
				$Large = 32
			Else
				$Large = 16
			EndIf
			; $test=StringRegExp($BtnIcon, '^(.+),\h*(\d+)$', 3)
			If Not StringInStr($BtnIcon, ':') Then
				If StringLeft($PathPic, 1) = '\' Then StringTrimLeft($PathPic, 1)
				If StringInStr($BtnIcon, '\') Then
					$BtnIcon = @ScriptDir & '\' & $BtnIcon
				Else
					$BtnIcon = _WinAPI_PathFindOnPath($BtnIcon, @ScriptDir)
				EndIf
			EndIf
			$hImage = _GUIImageList_Create($Large, $Large, 5, 3)
			_GUIImageList_AddIcon($hImage, $BtnIcon, Number(IniRead($Ini, $aIniSec[$i], 'IndexIcon', '0')), $Large)
			If FileExists($BtnIcon) Then _GUICtrlButton_SetImageList($aEXE[$d][0], $hImage, 0, 5)
		EndIf
		
		$ButBkColor = Dec(IniRead($Ini, $aIniSec[$i], 'ButColor', ''))
		If $ButBkColor <> '' Then
			GUICtrlSetBkColor($aEXE[$d][0], $ButBkColor)
		Else
			If $ButColor <> '' Then GUICtrlSetBkColor($aEXE[$d][0], $ButColor)
		EndIf
		
		$ButTextColor = Dec(IniRead($Ini, $aIniSec[$i], 'TextColor', ''))
		If $ButTextColor <> '' Then
			GUICtrlSetColor($aEXE[$d][0], $ButTextColor)
		Else
			If $TextColor <> '' Then GUICtrlSetColor($aEXE[$d][0], $TextColor)
		EndIf
		
		$tmp = IniRead($Ini, $aIniSec[$i], 'Accelerators', '')
		If $tmp Then
			$tmp = _HotKeyString_To_AutoitCode($tmp)
			If Not @error Then $aEXE[$d][3] = $tmp
		EndIf
		
		$Hint = IniRead($Ini, $aIniSec[$i], 'hint', '')
		If $Hint <> '' Then GUICtrlSetTip($aEXE[$d][0], $Hint)

		$aEXE[$d][1] = IniRead($Ini, $aIniSec[$i], 'exe', '')
		$aEXE[$d][2] = IniRead($Ini, $aIniSec[$i], 'arg', '')
		If IsInt(($d + 1) / $col) Then $Nrow = ($d + 1) / $col
		$d += 1
	Next
	Return $d - 1
EndFunc   ;==>_Button_Create

Func _test_Ini($aIniSec)
	Local $s = Chr(1)
	Assign($s, 1, 1)
	For $i = 1 To $aIniSec[0]
		Assign($aIniSec[$i] & $s, Eval($aIniSec[$i] & $s) + 1, 1)
		If Eval($aIniSec[$i] & $s) = 2 Then
			If $aIniSec[$i] == '' Then
				MsgBox(0, $LngErr, $LngMs4 & $LngMs5)
				Exit
			EndIf
			MsgBox(0, $LngErr, $LngMs3 & ' "' & $aIniSec[$i] & '"' & $LngMs5)
			Exit
		EndIf
	Next
EndFunc   ;==>_test_Ini

Func _HotKeyString_To_AutoitCode($Key)
	Local $ch, $k
	If $Key = '' Then Return SetError(1, 0, '')
	; $Key = '{'&StringReplace(StringStripWS($Key, 8),'+', '}{')&'}'
	$Key = '{' & StringRegExpReplace(StringStripWS($Key, 8), '(?<!\+)\+', '}{') & '}' ; удаляем пробелы, используем "+" как разделитель
	$Key = StringRegExpReplace($Key, '\{([^!+^#{}])\}', '\1') ; если не метасимволы то убираем обрамляющие фигурные скобки
	
	; проверка наличие только одной клавиши в сочетании с модификаторами
	$ch = StringRegExpReplace($Key, '(\{Alt\}|\{Shift\}|\{Ctrl\}|\{Win\})', '') ; удаляем модификаторы
	$ch = StringRegExpReplace($ch, '\{.*?\}', '') ; подсчитываем элементы обрамлённые фигурными скобками
	$k = @extended
	$k += StringLen($ch) ; добавляем количество символов без фигурных скобок
	If $k <> 1 Then Return SetError(1, 0, '') ; возвращает пустую строку при ошибке
	
	; замены модификаторов
	$Key = StringReplace($Key, '{Alt}', '!')
	$Key = StringReplace($Key, '{Shift}', '+')
	$Key = StringReplace($Key, '{Ctrl}', '^')
	$Key = StringReplace($Key, '{Win}', '#')
	Return $Key
EndFunc   ;==>_HotKeyString_To_AutoitCode

Func _Create_ini()
	$hFile = FileOpen($Ini, 2)
	If $hFile = -1 Then
		MsgBox(4096, $LngErr, $LngMs2)
		Exit
	EndIf
	FileWrite($hFile, '[gui]' & @CRLF & _
			'Title=Launcher' & @CRLF & _
			'FormWidth=430' & @CRLF & _
			'FormHeight=280' & @CRLF & _
			'AreaX=90' & @CRLF & _
			'AreaY=70' & @CRLF & _
			'AreaWidth=320' & @CRLF & _
			'AreaHeight=190' & @CRLF & _
			'Picture = Launcher.jpg' & @CRLF & _
			'Margin=5' & @CRLF & _
			'Row=2' & @CRLF & _
			'FontSize=12' & @CRLF & _
			'FontBold=1' & @CRLF & _
			'icon=launcher.ico' & @CRLF & _
			'ButMinW=' & @CRLF & _
			'ButMinH=' & @CRLF & _
			'GuiBkColor=3F3F3F' & @CRLF & _
			'ButColor=' & @CRLF & _
			@CRLF & _
			'[1]' & @CRLF & _
			'name=Notepad' & @CRLF & _
			'hint=Run Notepad' & @CRLF & _
			'exe=notepad.exe' & @CRLF & _
			'Accelerators=Ctrl + e' & @CRLF & _
			'icon=notepad.exe' & @CRLF & _
			'LargeIcon = 1' & @CRLF & _
			@CRLF & _
			'[2]' & @CRLF & _
			'name=Calc (Alt+q)' & @CRLF & _
			'hint=Run Calc' & @CRLF & _
			'exe=calc.exe' & @CRLF & _
			'Accelerators=Alt + q' & @CRLF & _
			'icon=calc.exe' & @CRLF & _
			'LargeIcon = 1' & @CRLF & _
			@CRLF & _
			'[3]' & @CRLF & _
			'name=Paint' & @CRLF & _
			'hint=Run Paint' & @CRLF & _
			'exe=mspaint.exe' & @CRLF & _
			'icon=mspaint.exe' & @CRLF & _
			'LargeIcon = 1' & @CRLF & _
			@CRLF & _
			'[4]' & @CRLF & _
			'name=Export' & @CRLF & _
			'hint=Export from the registry' & @CRLF & _
			'exe=regedit.exe' & @CRLF & _
			'arg=/e myfile.reg "HKEY_CURRENT_USER\Keyboard Layout\Preload"' & @CRLF & _
			'icon=regedit.exe' & @CRLF & _
			'LargeIcon = 1' & @CRLF & _
			@CRLF & _
			'[5]' & @CRLF & _
			'name=Sound' & @CRLF & _
			'hint=Open a file' & @CRLF & _
			'exe=rundll32.exe' & @CRLF & _
			'arg= shell32.dll,Control_RunDLL mmsys.cpl,,0' & @CRLF & _
			'icon=stobject.dll' & @CRLF & _
			'IndexIcon = 2' & @CRLF & _
			'LargeIcon = 1' & @CRLF & _
			@CRLF & _
			'[6]' & @CRLF & _
			'name=Launcher.ini' & @CRLF & _
			'hint=Open a file' & @CRLF & _
			'exe=Launcher.ini' & @CRLF & _
			'ButColor=0080ff' & @CRLF & _
			'TextColor=ffff00')
	FileClose($hFile)
EndFunc   ;==>_Create_ini

Func _WinAPI_LoadKeyboardLayout($sLayoutID, $hWnd = 0)
	Local Const $WM_INPUTLANGCHANGEREQUEST = 0x50
	Local $aRet = DllCall("user32.dll", "long", "LoadKeyboardLayoutW", "wstr", Hex($sLayoutID, 8), "int", 0)

	If Not @error And $aRet[0] Then
		If $hWnd = 0 Then
			$hWnd = WinGetHandle(AutoItWinGetTitle())
		EndIf

		DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hWnd, "int", $WM_INPUTLANGCHANGEREQUEST, "int", 1, "int", $aRet[0])
		Return 1
	EndIf

	Return SetError(1)
EndFunc   ;==>_WinAPI_LoadKeyboardLayout