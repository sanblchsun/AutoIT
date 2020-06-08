#AutoIt3Wrapper_Outfile=ColorText.exe
#AutoIt3Wrapper_Icon=ColorText.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=
#AutoIt3Wrapper_Res_Description=ColorText.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.1.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.3.1
#AutoIt3Wrapper_Res_Field=Build|2012.11.11
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"

;  @AZJIO  11.11.2012 (AutoIt3_v3.3.6.1)

#NoTrayIcon

; En
$LngTitle = 'ColorText'
$LngAbout = 'About'
$LngVer = 'Version'
$LngCopy = 'Copy'
$LngSite = 'Site'
$LngRe = 'Restart ColorText'
$LngMn = 'Menu'
$LngRTF = 'Convert to RTF'
$LngHTML = 'Convert to HTML'
$LngBBC = 'Convert to BBC'
$LngInT = 'from the window'
$LngClT = 'from the buffer'
$LngFlT = 'from a file'
$LngHlp = 'Help'
$LngSmp = 'Samples'
$LngCm0 = '1 Reset'
$LngCm1 = '|2 Winter|3 Autumn|4 three colors'
$LngGHCI = 'Get the code for the forum to Clipboard'
$LngNC = 'Number of cycles'
$LngRSp = 'The range of the spectrum'
$LngSTn = 'The shift of tone'
$LngBld = 'Bold'
$LngItc = 'Italic'
$LngBck = 'Back'
$LngCrr = 'Correction'
$LngEtx = 'Enter text'
$LngTSm = 'Happy Birthday!'
$LngOp = 'Open'
$LngAlF = 'All Files'
$LngHIE = 'Clipboard converted to BBCode'
$LngFnt = 'Font'
$LngSvAs = 'Save As...'
$LngTp1 = 'Document'
$LngTp2 = 'Web page'
$LngTp3 = 'BBCode'
$LngPrVw = 'Preview'
$LngFnm = 'Congratulation'
$LngFle = 'File'
$LngCnv = 'converted into'
$LngMsH = 'Regulator "' & $LngSTn & '", set the color of the first symbol.' & @CRLF & 'Further, the regulator "' & $LngRSp & '" , set the color of the last character.' & @CRLF & @CRLF & 'When you save a proposed automatically correct data format, which was last run' & @CRLF & @CRLF & 'For HTML and BBCode font size must be specified in the browser when submitting your.'
$LngErr = 'Error'
$LngMs1 = 'no data'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'ColorText'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngCopy = 'Копировать'
	$LngSite = 'Сайт'
	$LngRe = 'Перезапуск утилиты'
	$LngMn = 'Меню'
	$LngRTF = 'Преобразовать в RTF'
	$LngHTML = 'Преобразовать в HTML'
	$LngBBC = 'Преобразовать в BBC'
	$LngInT = 'из окна'
	$LngClT = 'из буфера'
	$LngFlT = 'из файла'
	$LngHlp = 'Справка'
	$LngSmp = 'Образцы'
	$LngCm0 = '1 Сброс'
	$LngCm1 = '|2 Зима|3 Осень|4 три цвета'
	$LngGHCI = 'Получить код для форума в буфер обмена'
	$LngNC = 'Количество циклов'
	$LngRSp = 'Диапазон спектра'
	$LngSTn = 'Сдвиг тона'
	$LngBld = 'Жирный'
	$LngItc = 'Курсив'
	$LngBck = 'Обратно'
	$LngCrr = 'Коррекция'
	$LngEtx = 'Введите текст'
	$LngTSm = 'Поздравляю с днём рождения!!!'
	$LngOp = 'Открыть'
	$LngAlF = 'Все файлы'
	$LngHIE = 'Буфер преобразован в BBCode'
	$LngFnt = 'Шрифт'
	$LngSvAs = 'Сохранить как...'
	$LngTp1 = 'Документ'
	$LngTp2 = 'Веб-страница'
	$LngTp3 = 'BBCode'
	$LngPrVw = 'Предпросмотр'
	$LngFnm = 'Поздравление'
	$LngFle = 'Файл'
	$LngCnv = 'преобразован в'
	$LngMsH = 'Регулятором "' & $LngSTn & '" установите цвет первой буквы.' & @CRLF & 'Далее регулятором "' & $LngRSp & '" установите цвет последней буквы.' & @CRLF & @CRLF & 'При сохранении предлагается автоопределяемый формат данных, который выполнялся последним' & @CRLF & @CRLF & 'Для HTML и BBCode размер шрифта необходимо указывать в браузере в отправляемом сообщении.'
	$LngErr = 'Ошибка'
	$LngMs1 = 'нет данных'
EndIf

#include <ComboConstants.au3>
#include <GuiRichEdit.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <ie.au3>
#include <Color.au3>
#include <ForColorText.au3>
; #include <Array.au3>
GUIRegisterMsg(0x0114, "WM_HSCROLL")
Opt("GUIResizeMode", 2 + 32 + 256 + 512) ; 802
GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")
Global $cycle0 = 1, $diap0 = 360, $cdvig0 = 0, $obr = 0, $korr0 = 1, $sCodeToSave, $oBody, $sMultiCode, $iarkost, $a_font[8] = [7, 2, 'Arial', 36, 700], $sBold = '\b', $sItalic = '\i', $hRichEdit
OnAutoItExitRegister("Error")
Func Error()
	_GUICtrlRichEdit_Destroy($hRichEdit)
EndFunc

FileChangeDir(@ScriptDir)

$Gui = GUICreate($LngTitle, 502, 335, -1, -1, $WS_OVERLAPPEDWINDOW + $WS_CLIPCHILDREN)
If Not @Compiled Then GUISetIcon(@ScriptDir & '\ColorText.ico')

$ActionM = GUICtrlCreateMenu($LngMn)
$SelFont = GUICtrlCreateMenuItem($LngFnt, $ActionM)
$SaveToFile = GUICtrlCreateMenuItem($LngSvAs, $ActionM)
GUICtrlCreateMenuItem('', $ActionM)

$SubRTF = GUICtrlCreateMenu($LngRTF, $ActionM)
$RTFM = GUICtrlCreateMenuItem($LngInT, $SubRTF)
$byferRTF = GUICtrlCreateMenuItem($LngClT, $SubRTF)
$FileRTF = GUICtrlCreateMenuItem($LngFlT, $SubRTF)

$SubHTM = GUICtrlCreateMenu($LngHTML, $ActionM)
$HTMLM = GUICtrlCreateMenuItem($LngInT, $SubHTM)
$byferHTML = GUICtrlCreateMenuItem($LngClT, $SubHTM)
$FileHTML = GUICtrlCreateMenuItem($LngFlT, $SubHTM)

$SubBBC = GUICtrlCreateMenu($LngBBC, $ActionM)
$BBCM = GUICtrlCreateMenuItem($LngInT, $SubBBC)
$byferBBC = GUICtrlCreateMenuItem($LngClT, $SubBBC)
$FileBBC = GUICtrlCreateMenuItem($LngFlT, $SubBBC)

$HelpM = GUICtrlCreateMenu('?')
$Help = GUICtrlCreateMenuItem($LngHlp, $HelpM)
$About = GUICtrlCreateMenuItem($LngAbout, $HelpM)

$restart = GUICtrlCreateButton("R", 502 - 21, 1, 18, 18)
GUICtrlSetTip(-1, $LngRe)

GUICtrlCreateLabel($LngSmp & ' :', 10, 12, 60, 17)
$Combo = GUICtrlCreateCombo('', 70, 10, 110, -1, $CBS_DROPDOWNLIST + $WS_VSCROLL)
GUICtrlSetData(-1, $LngCm0 & $LngCm1, $LngCm0)

$StartBBC = GUICtrlCreateButton($LngGHCI, 200, 10, 240, 25)

GUICtrlCreateLabel($LngNC & ' :', 10, 45, 110, 17)
$cycleL = GUICtrlCreateLabel('1', 120, 45, 25, 20)
GUICtrlCreateLabel($LngRSp & ' :', 10, 75, 110, 17)
$diapL = GUICtrlCreateLabel('360', 120, 75, 25, 20)
GUICtrlCreateLabel($LngSTn & ' :', 10, 105, 110, 17)
$cdvigL = GUICtrlCreateLabel('0', 120, 105, 25, 20)

$bold = GUICtrlCreateCheckbox($LngBld, 420, 45, 80, 17)
GUICtrlSetState(-1, 1)
$italic = GUICtrlCreateCheckbox($LngItc, 420, 65, 80, 17)
GUICtrlSetState(-1, 1)
$obrtext = GUICtrlCreateCheckbox($LngBck, 420, 85, 80, 17)
$korr = GUICtrlCreateCheckbox($LngCrr, 420, 105, 80, 17)
GUICtrlSetState(-1, 1)

; GUICtrlCreateLabel($LngEtx, 10, 140, 110, 17)
; $Text=GUICtrlCreateInput($LngTSm, 10, 157, 460, 20)
; $Start=GUICtrlCreateButton('>', 470, 157, 20, 20)

$hRichEdit = _GUICtrlRichEdit_Create($Gui, $LngTSm, 10, 145, 480, 160, _
		BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
Global $aText0 = StringSplit(_GUICtrlRichEdit_GetText($hRichEdit), '')

$cycle = GUICtrlCreateSlider(145, 40, 270, 30)
GUICtrlSetLimit(-1, 10, 1)
GUICtrlSetData(-1, 1)
$hSlider_Handle1 = GUICtrlGetHandle(-1)

$diap = GUICtrlCreateSlider(145, 70, 270, 30)
GUICtrlSetLimit(-1, 360, 0)
GUICtrlSetData(-1, 360)
$hSlider_Handle2 = GUICtrlGetHandle(-1)

$cdvig = GUICtrlCreateSlider(145, 100, 270, 30)
GUICtrlSetLimit(-1, 360, 0)
GUICtrlSetData(-1, 0)
$hSlider_Handle3 = GUICtrlGetHandle(-1)

_Start()
GUISetState()
GUIRegisterMsg($WM_SIZE, "WM_SIZE")

While 1
	Switch GUIGetMsg()
		Case $SelFont
			$aRet = _GUICtrlRichEdit_GetFont($hRichEdit)
			_GUICtrlRichEdit_SetSel($hRichEdit, 0, -1, True)
			$aRet2 = _GUICtrlRichEdit_GetCharAttributes($hRichEdit)
			_GUICtrlRichEdit_Deselect($hRichEdit)
			If StringInStr($aRet2, 'bo+') Then
				$bo = 700
			Else
				$bo = 400
			EndIf
			If StringInStr($aRet2, 'it+') Then
				$it = True
			Else
				$it = False
			EndIf
			$a_font = _ChooseFont($a_font[2], $a_font[3], 0, $a_font[4], $a_font[1], 0, 0, $Gui)
			If Not @error Then
				$atrb = ''
				If $a_font[4] = 700 Then
					$atrb &= '+bo'
					GUICtrlSetState($bold, 1)
				ElseIf $a_font[4] = 400 Then
					$atrb &= '-bo'
					GUICtrlSetState($bold, 4)
				EndIf
				If BitAND($a_font[1], 2) Then
					$atrb &= '+it'
					GUICtrlSetState($italic, 1)
				Else
					$atrb &= '-it'
					GUICtrlSetState($italic, 4)
				EndIf
				_GUICtrlRichEdit_PauseRedraw($hRichEdit)
				_GUICtrlRichEdit_SetSel($hRichEdit, 0, -1, True)
				_GUICtrlRichEdit_SetFont($hRichEdit, $a_font[3], $a_font[2])
				_GUICtrlRichEdit_SetCharAttributes($hRichEdit, $atrb)
				_GUICtrlRichEdit_Deselect($hRichEdit)
				_Start()
				_GUICtrlRichEdit_ResumeRedraw($hRichEdit)
			EndIf

		Case $SaveToFile
			$SaveFile = FileSaveDialog($LngSvAs, @WorkingDir, $LngTp1 & ' (*.rtf)|' & $LngTp2 & ' (*.htm;*.html)|' & $LngTp3 & ' (*.txt)', 24, $LngFnm& '.rtf', $Gui)
			If @error Then ContinueLoop
			If Not StringInStr(';.rtf;.htm;html;.txt;', ';' & StringRight($SaveFile, 4) & ';') Then $SaveFile &= '.rtf'
			
			$aBtext = _SplitStr(_GUICtrlRichEdit_GetText($hRichEdit))
			If @error Then ContinueLoop
			Switch StringRight($SaveFile, 4)
				Case '.rtf'
					_Multi_RTF($aBtext)
					_GUICtrlRichEdit_StreamToFile($hRichEdit, $SaveFile)
				Case '.htm', 'html'
					_Multi_HTM($aBtext)
					$file = FileOpen($SaveFile, 2)
					FileWrite($file, '<HTML><HEAD><META http-equiv="Content-Type" content="text/html; charset=1251"></HEAD><Style>body{font-family: Arial;FONT-SIZE:' & $a_font[3] & ';}</Style><BODY>' & @CRLF & @CRLF & $sMultiCode & @CRLF & @CRLF & '</BODY></HTML>')
					FileClose($file)
				Case '.txt'
					_Multi_BBC($aBtext)
					$file = FileOpen($SaveFile, 2)
					FileWrite($file, $sMultiCode)
					FileClose($file)
			EndSwitch
			
		Case $Help
			MsgBox(0, $LngHlp, $LngMsH, 0, $Gui)
		Case $korr
			If GUICtrlRead($korr) = 1 Then
				$korr0 = 1
			Else
				$korr0 = 0
			EndIf
			_Start()
			
		Case $bold
			_GUICtrlRichEdit_SetSel($hRichEdit, 0, -1, True)
			If GUICtrlRead($bold) = 1 Then
				_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+bo')
				$sBold = '\b'
			Else
				_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '-bo')
				$sBold = ''
			EndIf
			_GUICtrlRichEdit_Deselect($hRichEdit)
			
		Case $italic
			_GUICtrlRichEdit_SetSel($hRichEdit, 0, -1, True)
			If GUICtrlRead($italic) = 1 Then
				_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+it')
				$sItalic = '\i'
			Else
				_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '-it')
				$sItalic = ''
			EndIf
			_GUICtrlRichEdit_Deselect($hRichEdit)
			
		Case $HTMLM
			$aBtext = _SplitStr(_GUICtrlRichEdit_GetText($hRichEdit))
			If @error Then ContinueLoop
			; _ArrayDisplay($aBtext, 'Array')
			_Multi_HTM($aBtext)
			
		Case $StartBBC, $BBCM
			$aBtext = _SplitStr(_GUICtrlRichEdit_GetText($hRichEdit))
			If @error Then ContinueLoop
			_Multi_BBC($aBtext)
			; _IEBodyWriteHTML($oBody, '<b><font color=#009900>'&$LngHIE&'</font></b>')
			_GUICtrlRichEdit_SetText($hRichEdit, $LngHIE)
			_GUICtrlRichEdit_SetSel($hRichEdit, 0, -1, True)
			_GUICtrlRichEdit_SetFont($hRichEdit, 18, 'Arial')
			_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+bo')
			_GUICtrlRichEdit_SetCharColor($hRichEdit, 0x009900)
			_GUICtrlRichEdit_Deselect($hRichEdit)

		Case $byferHTML
			$aBtext = _SplitStr(ClipGet())
			If @error Then ContinueLoop
			_Multi_HTM($aBtext)

		Case $FileHTML
			$OpenFile = FileOpenDialog($LngOp, @WorkingDir, $LngAlF & " (*.*)", 3, "", $Gui)
			If @error Then ContinueLoop
			$file = FileOpen($OpenFile, 0)
			$Opentext = FileRead($file)
			FileClose($file)
			
			$aBtext = _SplitStr($Opentext)
			If @error Then ContinueLoop
			_Multi_HTM($aBtext)

		Case $byferBBC
			$aBtext = _SplitStr(ClipGet())
			If @error Then ContinueLoop
			_Multi_BBC($aBtext)
			; _IEBodyWriteHTML($oBody, '<b><font color=#009900>'&$LngHIE&'</font></b>')
			_GUICtrlRichEdit_SetText($hRichEdit, $LngHIE)
			_GUICtrlRichEdit_SetSel($hRichEdit, 0, -1, True)
			_GUICtrlRichEdit_SetFont($hRichEdit, 18, 'Arial')
			_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+bo')
			_GUICtrlRichEdit_SetCharColor($hRichEdit, 0x009900)
			_GUICtrlRichEdit_Deselect($hRichEdit)

		Case $FileBBC
			$OpenFile = FileOpenDialog($LngOp, @WorkingDir, $LngAlF & " (*.*)", 3, "", $Gui)
			If @error Then ContinueLoop
			$file = FileOpen($OpenFile, 0)
			$Opentext = FileRead($file)
			FileClose($file)
			
			$aBtext = _SplitStr($Opentext)
			If @error Then ContinueLoop
			_Multi_BBC($aBtext)
			; _IEBodyWriteHTML($oBody, '<b><font color=#009900>Файл</font> <font color=#990000>'&$OpenFile&'</font> <font color=#009900>преобразован в BBCode</font></b>')
			_GUICtrlRichEdit_SetText($hRichEdit, $LngFle & ' "' & StringRegExpReplace($OpenFile, '(^.*)\\(.*)$', '\2') & '" ' & $LngCnv & ' BBCode')
			_GUICtrlRichEdit_SetSel($hRichEdit, 0, -1, True)
			_GUICtrlRichEdit_SetFont($hRichEdit, 18, 'Arial')
			_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+bo')
			_GUICtrlRichEdit_SetCharColor($hRichEdit, 0x009900)
			_GUICtrlRichEdit_Deselect($hRichEdit)

		Case $RTFM
			$aBtext = _SplitStr(_GUICtrlRichEdit_GetText($hRichEdit))
			If @error Then ContinueLoop
			_Multi_RTF($aBtext)

		Case $byferRTF
			$aBtext = _SplitStr(ClipGet())
			If @error Then ContinueLoop
			_Multi_RTF($aBtext)

		Case $FileRTF
			$OpenFile = FileOpenDialog($LngOp, @WorkingDir, $LngAlF & " (*.*)", 3, "", $Gui)
			If @error Then ContinueLoop
			$file = FileOpen($OpenFile, 0)
			$Opentext = FileRead($file)
			FileClose($file)
			
			$aBtext = _SplitStr($Opentext)
			If @error Then ContinueLoop
			_Multi_RTF($aBtext)
			
		Case $obrtext
			If GUICtrlRead($obrtext) = 1 Then
				$obr = 1
			Else
				$obr = 0
			EndIf
			_Start()
		Case $Combo
			Switch StringLeft(GUICtrlRead($Combo), 1)
				Case 1
					$obr = 0
					$cycle0 = 1
					$diap0 = 360
					$cdvig0 = 0
					$korr0 = 1
					GUICtrlSetState($korr, 1)
				Case 2
					$obr = 0
					$cycle0 = 1
					$diap0 = 41
					$cdvig0 = 0
					$korr0 = 0
					GUICtrlSetState($korr, 4)
				Case 3
					$obr = 1
					$cycle0 = 1
					$diap0 = 41
					$cdvig0 = 185
					$korr0 = 0
					GUICtrlSetState($korr, 4)
				Case 4
					$obr = 0
					$cycle0 = 1
					$diap0 = 161
					$cdvig0 = 237
			EndSwitch
			GUICtrlSetData($cycle, $cycle0)
			GUICtrlSetData($diap, $diap0)
			GUICtrlSetData($cdvig, $cdvig0)
			_Start()
		Case $restart
			_restart()
		Case $About
			_About()
		Case -3
			GUIDelete()
			Exit
	EndSwitch
WEnd

Func WM_SIZE($hWnd, $msg, $wParam, $lParam)
    $iWidth = BitAND($lParam, 0xFFFF) ; _WinAPI_LoWord
    $iHeight = BitShift($lParam, 16) ; _WinAPI_HiWord
	_WinAPI_MoveWindow($hRichEdit, 10, 145, $iWidth - 20, $iHeight - 155)
	; 10, 185, 480, 120,
	Return $GUI_RUNDEFMSG
EndFunc

Func WM_HSCROLL($hWnd, $msg, $wParam, $lParam)
	#forceref $Msg, $wParam, $lParam
	Local $nScrollCode = BitAND($wParam, 0x0000FFFF)
	Local $value = BitShift($wParam, 16)
	
	Switch $lParam
		Case $hSlider_Handle1
			If $nScrollCode = 5 Then
				$cycle0 = $value
				GUICtrlSetData($cycleL, $value)
				_Start()
			EndIf
		Case $hSlider_Handle2
			If $nScrollCode = 5 Then
				$diap0 = $value
				GUICtrlSetData($diapL, $value)
				_Start()
			EndIf
		Case $hSlider_Handle3
			If $nScrollCode = 5 Then
				$cdvig0 = $value
				GUICtrlSetData($cdvigL, $value)
				_Start()
			EndIf
	EndSwitch
	Return 'GUI_RUNDEFMSG'
EndFunc

Func _Start()
	If _GUICtrlRichEdit_IsModified($hRichEdit) = True Then $aText0 = StringSplit(_GUICtrlRichEdit_GetText($hRichEdit), '')
	Local $sColorTableRTF
	$iarkost = 100
	$sRTFCode = ''
	$Sep = Chr(1)
	; _GUICtrlRichEdit_PauseRedraw($hRichEdit)
	For $i = 1 To $aText0[0]
		$aRGB = __Start___($i)
		$sColorTableRTF &= '\red' & $aRGB[0] & '\green' & $aRGB[1] & '\blue' & $aRGB[2] & ';'
		$sRTFCode &= $Sep & 'cf' & $i & ' ' & $aText0[$i]
	Next

	; обрамляем escape-символы для RTF кода
	$sRTFCode = StringRegExpReplace($sRTFCode, '[{}\\]', '\\$0')
	$sRTFCode = StringReplace($sRTFCode, @CR, '\par ' & @CRLF, 0, 2)
	$sRTFCode = StringReplace($sRTFCode, @TAB, '\tab ', 0, 2)
	$sRTFCode = StringReplace($sRTFCode, $Sep, '\', 0, 2) ; возвращаем "\" вместо Chr(1)
	
	; $sRTFCode = '{\rtf\ansi\ansicpg1251\deff0\deflang1049{\fonttbl{\f0\fswiss\fprq2\fcharset204{\*\fname '&$a_font[2]&';}'&$a_font[2]&' CYR;}}' & _
	$sRTFCode = '{\rtf\ansi\ansicpg1251\deff0\deflang1049{\fonttbl{\f0\fnil\fcharset0 ' & $a_font[2] & ';}}' & _
			'{\colortbl;' & $sColorTableRTF & '}{\*\generator Msftedit 5.41.21.2510;}\viewkind4\uc1\pard\f0\fs' & $a_font[3] & $sBold & $sItalic & _
			StringStripWS($sRTFCode, 2) & '}'
	_GUICtrlRichEdit_SetText($hRichEdit, $sRTFCode)
EndFunc

Func __Start___($i)
	If $obr Then
		$vColor = Int(($aText0[0] - $i) * $cycle0 * $diap0 / $aText0[0] + $cdvig0)
	Else
		$vColor = Int(($i - 1) * $cycle0 * $diap0 / $aText0[0] + $cdvig0)
	EndIf
	While $vColor >= 360
		$vColor -= 360
	WEnd
	If $korr0 Then
		Switch $vColor
			Case 39 To 43
				$iarkost = 96
			Case 44 To 48
				$iarkost = 93
			Case 49 To 53
				$iarkost = 86
			Case 54 To 180
				$iarkost = 82
			Case 181 To 190
				$iarkost = 86
			Case 191 To 200
				$iarkost = 90
			Case Else
				$iarkost = 100
		EndSwitch
	EndIf
	Dim $aHSB[3] = [$vColor, '100', $iarkost]
	$aRGB = _HSB_to_RGB($aHSB)
	Return $aRGB
EndFunc

Func _StartRTF($aBtext_i)
	_GUICtrlRichEdit_SetText($hRichEdit, $aBtext_i)
	$sCodeToSave = ''
	$iarkost = 100
	For $i = 1 To $aText0[0]
		$aRGB = __Start___($i)
		_GUICtrlRichEdit_SetSel($hRichEdit, $i - 1, -1, True)
		_GUICtrlRichEdit_SetCharColor($hRichEdit, Dec(Hex($aRGB[0], 2) & Hex($aRGB[1], 2) & Hex($aRGB[2], 2)))
	Next
	_GUICtrlRichEdit_Deselect($hRichEdit)
	$sCodeToSave = _GUICtrlRichEdit_StreamToVar($hRichEdit)
EndFunc

Func _StartHTML()
	$sCodeToSave = ''
	$iarkost = 100
	For $i = 1 To $aText0[0]
		$aRGB = __Start___($i)
		$sCodeToSave &= '<font color=#' & Hex($aRGB[0], 2) & Hex($aRGB[1], 2) & Hex($aRGB[2], 2) & '>' & $aText0[$i] & '</font>'
	Next
	If $sBold Then $sCodeToSave = '<b>' & $sCodeToSave & '</b>'
	If $sItalic Then $sCodeToSave = '<i>' & $sCodeToSave & '</i>'
EndFunc

Func _StartBBC()
	$sCodeToSave = ''
	$iarkost = 100
	For $i = 1 To $aText0[0]
		$aRGB = __Start___($i)
		$sCodeToSave &= '[color=#' & Hex($aRGB[0], 2) & Hex($aRGB[1], 2) & Hex($aRGB[2], 2) & ']' & $aText0[$i] & '[/color]'
	Next
	If $sBold Then $sCodeToSave = '[b]' & $sCodeToSave & '[/b]'
	If $sItalic Then $sCodeToSave = '[i]' & $sCodeToSave & '[/i]'
EndFunc

; кусок кода из UDF File.au3 для разделения образца построчно в массив
Func _SplitStr($sText)
	If StringInStr($sText, @LF) Then
		$sText = StringSplit(StringStripCR($sText), @LF)
	ElseIf StringInStr($sText, @CR) Then
		$sText = StringSplit($sText, @CR)
	Else
		If StringLen($sText) Then
			Local $tmp = $sText
			Dim $sText[2] = [1, $tmp]
		Else
			MsgBox(0, $LngErr, $LngMs1, 0, $Gui)
			Return SetError(1)
		EndIf
	EndIf
	Return $sText
EndFunc

Func _Multi_HTM($aBtext)
	$sMultiCode = ''
	For $i = 1 To $aBtext[0]
		If $aBtext[$i] = '' Then
			$sMultiCode &= '<br>'
		Else
			; GUICtrlSetData($Text, $aBtext[$i])
			$aText0 = StringSplit($aBtext[$i], '')
			_StartHTML()
			$sMultiCode &= $sCodeToSave & '<br>'
		EndIf

	Next
	ClipPut($sMultiCode)
	_Preview($sMultiCode)
EndFunc

Func _Multi_BBC($aBtext)
	$sMultiCode = ''
	For $i = 1 To $aBtext[0]
		If $aBtext[$i] = '' Then
			$sMultiCode &= @CRLF
		Else
			; GUICtrlSetData($Text, $aBtext[$i])
			$aText0 = StringSplit($aBtext[$i], '')
			_StartBBC()
			$sMultiCode &= $sCodeToSave & @CRLF
		EndIf
	Next
	ClipPut($sMultiCode)
EndFunc

Func _Multi_RTF($aBtext)
	$sMultiCode = ''
	_GUICtrlRichEdit_PauseRedraw($hRichEdit)
	For $i = 1 To $aBtext[0]
		If $aBtext[$i] = '' Then
			$aBtext[$i] = @CRLF
		Else
			$aText0 = StringSplit($aBtext[$i], '')
			_StartRTF($aBtext[$i])
			$aBtext[$i] = $sCodeToSave
		EndIf
	Next
	_GUICtrlRichEdit_SetText($hRichEdit, '')
	For $i = 1 To $aBtext[0]
		_GUICtrlRichEdit_AppendText($hRichEdit, $aBtext[$i])
	Next
	_GUICtrlRichEdit_SetSel($hRichEdit, 0, -1, True)
	_GUICtrlRichEdit_SetFont($hRichEdit, 12, 'Arial')
	_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+bo+it')
	_GUICtrlRichEdit_Deselect($hRichEdit)
	_GUICtrlRichEdit_ResumeRedraw($hRichEdit)
	; WinSetState($Gui, '', @SW_HIDE) ; такая заморочка из-за того что текст выделяется без подсвечивания
	; WinSetState($Gui, '', @SW_SHOW)
EndFunc

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $Gui Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 508)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 261)
	EndIf
EndFunc

Func _Preview($TmpHtml = -1)
	GUIRegisterMsg($WM_SIZE, "")
	Local $EditBut, $hGui1, $GP, $StrBut
	$GP = _ChildCoor($Gui, 470, 300)
	GUISetState(@SW_DISABLE, $Gui)
	
	$hGui1 = GUICreate($LngPrVw, $GP[2], $GP[3], $GP[0], $GP[1], $WS_OVERLAPPEDWINDOW, -1, $Gui)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\ColorText.ico')

	$oIE = _IECreateEmbedded()
	GUICtrlCreateObj($oIE, 5, 5, 460, 290)
	GUICtrlSetResizing(-1, 2 + 32 + 4 + 64)
	_IENavigate($oIE, 'about:blank')
	$sHEAD = '<HTML><HEAD><META http-equiv="Content-Type" content="text/html; charset=1251"></HEAD><Style>body{font-family: ' & $a_font[2] & ';FONT-SIZE:' & $a_font[3] & ';}</Style><BODY>' & @CRLF

	If $TmpHtml = -1 Then
		$aText0 = StringSplit(_GUICtrlRichEdit_GetText($hRichEdit), '')
		_StartHTML()
		_IEDocWriteHTML($oIE, $sHEAD & $sCodeToSave & '</BODY></HTML>')
	Else
		_IEDocWriteHTML($oIE, $sHEAD & $TmpHtml & '</BODY></HTML>')
	EndIf
	GUISetState(@SW_SHOW, $hGui1)
	While 1
		Switch GUIGetMsg()
			Case -3
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($hGui1)
				GUIRegisterMsg($WM_SIZE, "WM_SIZE")
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func _About()
	Local $font, $GP, $hGui1, $url, $WbMn
	GUIRegisterMsg($WM_SIZE, "")
	$GP = _ChildCoor($Gui, 210, 180)
	GUISetState(@SW_DISABLE, $Gui)
	$font = "Arial"
	$hGui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\ColorText.ico')
	GUISetBkColor(0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 210, 63, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 14, 600, -1, $font)
	GUICtrlSetColor(-1, 0xa13d00)
	GUICtrlSetBkColor(-1, 0xfbe13f)
	GUICtrlCreateLabel("-", 2, 64, 208, 1, 0x10)
	
	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.3.1  11.11.2012', 15, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 15, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 52, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 15, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 90, 130, 125, 17)
	GUICtrlSetColor(-1, 0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010', 15, 145, 210, 17)
	GUISetState(@SW_SHOW, $hGui1)
	While 1
		Switch GUIGetMsg()
			Case $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $WbMn
				ClipPut('R939163939152')
			Case -3
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($hGui1)
				GUIRegisterMsg($WM_SIZE, "WM_SIZE")
				ExitLoop
		EndSwitch
	WEnd
EndFunc