#AutoIt3Wrapper_Outfile=ColorText.exe
#AutoIt3Wrapper_Icon=ColorText.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=
#AutoIt3Wrapper_Res_Description=ColorText.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.3
#AutoIt3Wrapper_Res_Field=Build|2011.06.06
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"

;  @AZJIO 6.06.2011 (AutoIt3_v3.3.6.1)

#NoTrayIcon

; En
$LngTitle='ColorText'
$LngAbout='About'
$LngVer='Version'
$LngCopy='Copy'
$LngSite='Site'
$LngRe='Restart ColorText'
$LngMn='Menu'
$LngGHC='Get the HTML to the clipboard'
$LngGBC='Get the BBCode to the clipboard'
$LngCMH='Convert text from clipboard to HTML'
$LngCMB='Convert text from clipboard to BBCode'
$LngCFH='Convert text from a file in HTML'
$LngCFB='Convert text from a file in BBCode'
$LngHlp='Help'
$LngSmp='Samples'
$LngCm0='1 Reset'
$LngCm1='|2 Winter|3 Autumn|4 three colors'
$LngGHCI='Get the code for the forum to Clipboard'
$LngNC='Number of cycles'
$LngRSp='The range of the spectrum'
$LngSTn='The shift of tone'
$LngBld='Bold'
$LngItc='Italic'
$LngBck='Back'
$LngCrr='Correction'
$LngEtx='Enter text'
$LngTSm='Happy Birthday!'
$LngOp='Open'
$LngAlF='All Files'
$LngHIE='Clipboard converted to BBCode'
$LngGRC='Convert typed text into RTF'
$LngCMR='Convert text from the clipboard in RTF'
$LngCFR='Convert text from a file in RTF'
$LngFnt='Font'
$LngSvAs='Save As...'
$LngTp1='Document'
$LngTp2='Web page'
$LngTp3='BBCode'
$LngFnm='Congratulation'
$LngFle='File'
$LngCnv='converted into'
$LngMsH='Regulator "'&$LngSTn&'", set the color of the first symbol.'&@CRLF&'Further, the regulator "'&$LngRSp&'" , set the color of the last character.'&@CRLF&@CRLF&'When you save a proposed automatically correct data format, which was last run'&@CRLF&@CRLF&'For HTML and BBCode font size must be specified in the browser when submitting your.'
$LngErr='Error'
$LngMs1='no data'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngTitle='ColorText'
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngCopy='Копировать'
	$LngSite='Сайт'
	$LngRe='Перезапуск утилиты'
	$LngMn='Меню'
	$LngGHC='Преобразовать введённый текст в HTML в буфер'
	$LngGBC='Преобразовать введённый текст в BBCode в буфер'
	$LngCMH='Преобразовать текст из буфера в HTML в буфер'
	$LngCMB='Преобразовать текст из буфера в BBCode в буфер'
	$LngCFH='Преобразовать текст из файла в HTML в буфер'
	$LngCFB='Преобразовать текст из файла в BBCode в буфер'
	$LngHlp='Справка'
	$LngSmp='Образцы'
	$LngCm0='1 Сброс'
	$LngCm1='|2 Зима|3 Осень|4 три цвета'
	$LngGHCI='Получить код для форума в буфер обмена'
	$LngNC='Количество циклов'
	$LngRSp='Диапазон спектра'
	$LngSTn='Сдвиг тона'
	$LngBld='Жирный'
	$LngItc='Курсив'
	$LngBck='Обратно'
	$LngCrr='Коррекция'
	$LngEtx='Введите текст'
	$LngTSm='Поздравляю с днём рождения!!!'
	$LngOp='Открыть'
	$LngAlF='Все файлы'
	$LngHIE='Буфер преобразован в BBCode'
	$LngGRC='Преобразовать введённый текст в RTF'
	$LngCMR='Преобразовать текст из буфера в RTF'
	$LngCFR='Преобразовать текст из файла в RTF'
	$LngFnt='Шрифт'
	$LngSvAs='Сохранить как...'
	$LngTp1='Документ'
	$LngTp2='Веб-страница'
	$LngTp3='BBCode'
	$LngFnm='Поздравление'
	$LngFle='Файл'
	$LngCnv='преобразован в'
	$LngMsH='Регулятором "'&$LngSTn&'" установите цвет первой буквы.'&@CRLF&'Далее регулятором "'&$LngRSp&'" установите цвет последней буквы.'&@CRLF&@CRLF&'При сохранении предлагается автоопределяемый формат данных, который выполнялся последним'&@CRLF&@CRLF&'Для HTML и BBCode размер шрифта необходимо указывать в браузере в отправляемом сообщении.'
	$LngErr='Ошибка'
	$LngMs1='нет данных'
EndIf


#include <GuiRichEdit.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <Misc.au3>
#include <ie.au3>
#Include <Color.au3>
GUIRegisterMsg(0x0114 , "WM_HSCROLL")
Opt("GUIResizeMode", 2 + 32 + 256 + 512) ; 802
GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")
Global $cycle0=1, $diap0=360, $cdvig0=0, $obr=4, $htm, $oBody, $multihtm
OnAutoItExitRegister("Error")
Func Error()
	GUIDelete()
EndFunc

$Gui = GUICreate($LngTitle, 502, 365, -1 , -1, 0x00040000+0x00020000+0x00010000)
If Not @compiled Then GUISetIcon(@ScriptDir&'\ColorText.ico')

$ActionM=GUICtrlCreateMenu($LngMn)
$SelFont=GUICtrlCreateMenuitem($LngFnt, $ActionM)
$SaveToFile=GUICtrlCreateMenuitem($LngSvAs, $ActionM)
GUICtrlCreateMenuitem('', $ActionM)
$RTFM=GUICtrlCreateMenuitem($LngGRC, $ActionM)
$HTMLM=GUICtrlCreateMenuitem($LngGHC, $ActionM)
$BBCM=GUICtrlCreateMenuitem($LngGBC, $ActionM)
GUICtrlCreateMenuitem('', $ActionM)
$byferRTF=GUICtrlCreateMenuitem($LngCMR, $ActionM)
$byferHTML=GUICtrlCreateMenuitem($LngCMH, $ActionM)
$byferBBC=GUICtrlCreateMenuitem($LngCMB, $ActionM)
GUICtrlCreateMenuitem('', $ActionM)
$FileRTF=GUICtrlCreateMenuitem($LngCFR, $ActionM)
$FileHTML=GUICtrlCreateMenuitem($LngCFH, $ActionM)
$FileBBC=GUICtrlCreateMenuitem($LngCFB, $ActionM)

$HelpM=GUICtrlCreateMenu('?')
$Help=GUICtrlCreateMenuitem($LngHlp, $HelpM)
$About=GUICtrlCreateMenuitem($LngAbout, $HelpM)

$restart=GUICtrlCreateButton ("R", 502-21,1,18,18)
GUICtrlSetTip(-1, $LngRe)

GUICtrlCreateLabel($LngSmp&' :', 10, 12, 60, 17)
$Combo=GUICtrlCreateCombo('', 70, 10, 110)
GUICtrlSetData(-1,$LngCm0&$LngCm1, $LngCm0)

$StartBBC=GUICtrlCreateButton($LngGHCI, 200, 10, 240, 25)


GUICtrlCreateLabel($LngNC&' :', 10, 45, 110, 17)
$cycleL=GUICtrlCreateLabel('1', 120, 45, 25, 20)
GUICtrlCreateLabel($LngRSp&' :', 10, 75, 110, 17)
$diapL=GUICtrlCreateLabel('360', 120, 75, 25, 20)
GUICtrlCreateLabel($LngSTn&' :', 10, 105, 110, 17)
$cdvigL=GUICtrlCreateLabel('0', 120, 105, 25, 20)

$bold=GUICtrlCreateCheckbox($LngBld, 420, 45, 80, 17)
GUICtrlSetState(-1, 1)
$italic=GUICtrlCreateCheckbox($LngItc, 420, 65, 80, 17)
GUICtrlSetState(-1, 1)
$obrtext=GUICtrlCreateCheckbox($LngBck, 420, 85, 80, 17)
$korr=GUICtrlCreateCheckbox($LngCrr, 420, 105, 80, 17)
GUICtrlSetState(-1, 1)

; GUICtrlCreateLabel($LngEtx, 10, 140, 110, 17)
; $Text=GUICtrlCreateInput($LngTSm, 10, 157, 460, 20)
; $Start=GUICtrlCreateButton('>', 470, 157, 20, 20)


$hRichEdit = _GUICtrlRichEdit_Create($Gui, $LngTSm, 10, 145, 480, 160, _
BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
Global $aText0=StringSplit(_GUICtrlRichEdit_GetText($hRichEdit), '')
_GuiCtrlRichEdit_SetSel($hRichEdit,  0, -1, True)
_GUICtrlRichEdit_SetFont($hRichEdit, 18, 'Arial')
_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+bo+it')
_GUICtrlRichEdit_Deselect($hRichEdit)


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
	$msg = GUIGetMsg()
	Switch $msg
		Case $SelFont
			$aRet =_GUICtrlRichEdit_GetFont($hRichEdit)
			_GuiCtrlRichEdit_SetSel($hRichEdit,  0, -1, True)
			$aRet2 =_GUICtrlRichEdit_GetCharAttributes($hRichEdit)
			_GUICtrlRichEdit_Deselect($hRichEdit)
			; MsgBox(0, 'Message', $aRet2)
			If StringInStr($aRet2, 'bo+') Then
				$bo=700
			Else
				$bo=400
			EndIf
			If StringInStr($aRet2, 'it+') Then
				$it=True
			Else
				$it=False
			EndIf
			; MsgBox(0, 'Message', $aRet[0]&@CRLF&$aRet[1]&@CRLF&$bo&@CRLF&$it)
			$a_font = _ChooseFont($aRet[1], $aRet[0], 0, $bo, $it, 0, 0, $Gui)
			If Not @error Then
				 $atrb=''
				If $a_font[4]=700 Then
					$atrb&='+bo'
					GUICtrlSetState($bold, 1)
				ElseIf $a_font[4]=400 Then
					$atrb&='-bo'
					GUICtrlSetState($bold, 4)
				EndIf
				If BitAND($a_font[1], 2) Then
					$atrb&='+it'
					GUICtrlSetState($italic, 1)
				Else
					$atrb&='-it'
					GUICtrlSetState($italic, 4)
				EndIf
				_GuiCtrlRichEdit_SetSel($hRichEdit,  0, -1, True)
				_GUICtrlRichEdit_SetFont($hRichEdit, $a_font[3], $a_font[2])
				_GUICtrlRichEdit_SetCharAttributes($hRichEdit,  $atrb)
				_GUICtrlRichEdit_Deselect($hRichEdit)
			EndIf

		Case $SaveToFile
			$tmp1=$LngTp1&' (*.rtf)'
			$tmp2=$LngTp2&' (*.htm;*.html)'
			$tmp3=$LngTp3&' (*.txt)'
			$tmp4='rtf'
			If StringRegExp($multihtm,'<font color=#[0-9A-Fa-f]{6}>.</font>') Then
				$tmp1=$tmp2&'|'&$tmp1&'|'&$tmp3
				$tmp4='htm'
			ElseIf StringRegExp($multihtm, '\[color=#[0-9A-Fa-f]{6}\].\[/color\]') Then
				$tmp1=$tmp3&'|'&$tmp1&'|'&$tmp2
				$tmp4='txt'
			Else
				$tmp1=$tmp1&'|'&$tmp2&'|'&$tmp3
			EndIf
			$SaveFile = FileSaveDialog($LngSvAs, @WorkingDir , $tmp1, 24, $LngFnm&'.'&$tmp4, $Gui)
			If @error Then ContinueLoop
			If Not StringInStr(';.rtf;.htm;html;.txt;', ';'&StringRight($SaveFile, 4)&';') Then $SaveFile&='.rtf'
			
			Switch StringRight($SaveFile, 4)
				Case '.rtf'
					_GuiCtrlRichEdit_StreamToFile($hRichEdit, $SaveFile)
				Case '.htm', 'html'
					$file = FileOpen($SaveFile, 2)
					FileWrite($file, '<HTML><HEAD><META http-equiv="Content-Type" content="text/html; charset=1251"></HEAD>'&@CRLF&@CRLF&$multihtm&@CRLF&@CRLF&'</HTML>')
					FileClose($file)
				Case '.txt'
					$file = FileOpen($SaveFile, 2)
					FileWrite($file, $multihtm)
					FileClose($file)
			EndSwitch
			
		Case $Help
			MsgBox(0, $LngHlp, $LngMsH)
		Case $korr
			_Start()
			
		Case $bold
			_GuiCtrlRichEdit_SetSel($hRichEdit, 0, -1, True)
			If GUICtrlRead($bold)=1 Then
				_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+bo')
			Else
				_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '-bo')
			EndIf
			_GUICtrlRichEdit_Deselect($hRichEdit)
			
		Case $italic
			_GuiCtrlRichEdit_SetSel($hRichEdit, 0, -1, True)
			If GUICtrlRead($italic)=1 Then
				_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+it')
			Else
				_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '-it')
			EndIf
			_GUICtrlRichEdit_Deselect($hRichEdit)
			
		Case $HTMLM
			$aBtext=_SplitStr(_GUICtrlRichEdit_GetText($hRichEdit))
			If @error Then ContinueLoop
			_multihtmH($aBtext)
			
		Case $StartBBC, $BBCM
			$aBtext=_SplitStr(_GUICtrlRichEdit_GetText($hRichEdit))
			If @error Then ContinueLoop
			_multihtmB($aBtext)
			; _IEBodyWriteHTML($oBody, '<b><font color=#009900>'&$LngHIE&'</font></b>')
			_GUICtrlRichEdit_SetText($hRichEdit, $LngHIE)
			_GuiCtrlRichEdit_SetSel($hRichEdit,  0, -1, True)
			_GUICtrlRichEdit_SetFont($hRichEdit, 18, 'Arial')
			_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+bo')
			_GuiCtrlRichEdit_SetCharColor($hRichEdit, 0x009900)
			_GUICtrlRichEdit_Deselect($hRichEdit)

		Case $byferHTML
			$aBtext=_SplitStr(ClipGet())
			If @error Then ContinueLoop
			_multihtmH($aBtext)

		Case $FileHTML
			$OpenFile = FileOpenDialog($LngOp, @WorkingDir , $LngAlF&" (*.*)", 3, "", $Gui)
			If @error Then ContinueLoop
			$file = FileOpen($OpenFile, 0)
			$Opentext = FileRead($file)
			FileClose($file)
			
			$aBtext=_SplitStr($Opentext)
			If @error Then ContinueLoop
			_multihtmH($aBtext)

		Case $byferBBC
			$aBtext=_SplitStr(ClipGet())
			If @error Then ContinueLoop
			_multihtmB($aBtext)
			; _IEBodyWriteHTML($oBody, '<b><font color=#009900>'&$LngHIE&'</font></b>')
			_GUICtrlRichEdit_SetText($hRichEdit, $LngHIE)
			_GuiCtrlRichEdit_SetSel($hRichEdit,  0, -1, True)
			_GUICtrlRichEdit_SetFont($hRichEdit, 18, 'Arial')
			_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+bo')
			_GuiCtrlRichEdit_SetCharColor($hRichEdit, 0x009900)
			_GUICtrlRichEdit_Deselect($hRichEdit)

		Case $FileBBC
			$OpenFile = FileOpenDialog($LngOp, @WorkingDir , $LngAlF&" (*.*)", 3, "", $Gui)
			If @error Then ContinueLoop
			$file = FileOpen($OpenFile, 0)
			$Opentext = FileRead($file)
			FileClose($file)
			
			$aBtext=_SplitStr($Opentext)
			If @error Then ContinueLoop
			_multihtmB($aBtext)
			; _IEBodyWriteHTML($oBody, '<b><font color=#009900>Файл</font> <font color=#990000>'&$OpenFile&'</font> <font color=#009900>преобразован в BBCode</font></b>')
			_GUICtrlRichEdit_SetText($hRichEdit, $LngFle&' "'&StringRegExpReplace($OpenFile, '(^.*)\\(.*)$', '\2')&'" '&$LngCnv&' BBCode')
			_GuiCtrlRichEdit_SetSel($hRichEdit,  0, -1, True)
			_GUICtrlRichEdit_SetFont($hRichEdit, 18, 'Arial')
			_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+bo')
			_GuiCtrlRichEdit_SetCharColor($hRichEdit, 0x009900)
			_GUICtrlRichEdit_Deselect($hRichEdit)

		Case $RTFM
			$aBtext=_SplitStr(_GUICtrlRichEdit_GetText($hRichEdit))
			If @error Then ContinueLoop
			_multihtmR($aBtext)


		Case $byferRTF
			$aBtext=_SplitStr(ClipGet())
			If @error Then ContinueLoop
			_multihtmR($aBtext)

		Case $FileRTF
			$OpenFile = FileOpenDialog($LngOp, @WorkingDir , $LngAlF&" (*.*)", 3, "", $Gui)
			If @error Then ContinueLoop
			$file = FileOpen($OpenFile, 0)
			$Opentext = FileRead($file)
			FileClose($file)
			
			$aBtext=_SplitStr($Opentext)
			If @error Then ContinueLoop
			_multihtmR($aBtext)
			
		Case $obrtext
			If GUICtrlRead($obrtext)=1 Then
				$obr=1
			Else
				$obr=4
			EndIf
			_Start()
		Case $Combo
			Switch StringLeft(GUICtrlRead($Combo), 1)
				Case 1
				   $obr=4
				   $cycle0=1
				   $diap0=360
				   $cdvig0=0
					GUICtrlSetState($korr, 1)
				Case 2
				   $obr=1
				   $cycle0=1
				   $diap0=41
				   $cdvig0=185
					GUICtrlSetState($korr, 4)
				Case 3
				   $obr=4
				   $cycle0=1
				   $diap0=41
				   $cdvig0=0
					GUICtrlSetState($korr, 4)
				Case 4
				   $obr=4
				   $cycle0=1
				   $diap0=161
				   $cdvig0=237
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

Func WM_SIZE($hWnd, $Msg, $wParam, $lParam)
    $iWidth = _WinAPI_LoWord($lParam)
    $iHeight = _WinAPI_HiWord($lParam)
    _WinAPI_MoveWindow($hRichEdit, 10, 145, $iWidth-20, $iHeight-155)
	; 10, 185, 480, 120,
    Return $GUI_RUNDEFMSG
EndFunc

Func WM_HSCROLL($hWnd, $Msg, $wParam, $lParam)
	#forceref $Msg, $wParam, $lParam
	Local $nScrollCode = BitAND($wParam, 0x0000FFFF)
	Local $value = BitShift($wParam, 16)
	
	Switch $lParam
		Case $hSlider_Handle1
		   If $nScrollCode = 5 Then
			   $cycle0=$value
			   GUICtrlSetData($cycleL, $value)
			   _Start()
		   EndIf
		Case $hSlider_Handle2
		   If $nScrollCode = 5 Then
			   $diap0=$value
			   GUICtrlSetData($diapL, $value)
			   _Start()
		   EndIf
		Case $hSlider_Handle3
		   If $nScrollCode = 5 Then
			   $cdvig0=$value
			   GUICtrlSetData($cdvigL, $value)
			   _Start()
		   EndIf
	EndSwitch
	Return 'GUI_RUNDEFMSG'
EndFunc

Func _Start()
	If _GUICtrlRichEdit_IsModified($hRichEdit)=True Then $aText0=StringSplit(_GUICtrlRichEdit_GetText($hRichEdit), '')
	$iarkost=100
	For $i = 1 to $aText0[0]
		If $obr=1 Then
			$vColor=Int(($aText0[0]-$i)*$cycle0*$diap0/$aText0[0]+$cdvig0)
		Else
			$vColor=Int(($i-1)*$cycle0*$diap0/$aText0[0]+$cdvig0)
		EndIf
		While $vColor>=360
			$vColor-=360
		WEnd
		If GUICtrlRead($korr)=1 Then
			Switch $vColor
				Case 39 To 43
				   $iarkost = 96
				Case 44 To 48
				   $iarkost = 93
				Case 49 To 53
				   $iarkost = 86
				Case 54 To 180
					$iarkost =82
				Case 181 To 190
				   $iarkost = 86
				Case 191 To 200
				   $iarkost = 90
				Case Else
				   $iarkost =100
			EndSwitch
		EndIf
		Dim $aHSB[3] = [$vColor, '100', $iarkost]
		$aRGB= _HSB_to_RGB($aHSB)
		_GuiCtrlRichEdit_SetSel($hRichEdit, $i-1, -1, True)
		_GuiCtrlRichEdit_SetCharColor($hRichEdit, Dec($aRGB[2]&$aRGB[1]&$aRGB[0]))
	Next
	_GUICtrlRichEdit_Deselect($hRichEdit)
EndFunc

Func _StartRTF($aBtext_i)
	; $aText0=StringSplit(_GUICtrlRichEdit_GetText($hRichEdit), '')
	; $Text0=GUICtrlRead($Text)
	; $aText0=StringSplit($Text0, '')
	_GUICtrlRichEdit_SetText($hRichEdit, $aBtext_i)
	$htm=''
	$iarkost=100
	For $i = 1 to $aText0[0]
		If $obr=1 Then
			$vColor=Int(($aText0[0]-$i)*$cycle0*$diap0/$aText0[0]+$cdvig0)
		Else
			$vColor=Int(($i-1)*$cycle0*$diap0/$aText0[0]+$cdvig0)
		EndIf
		While $vColor>=360
			$vColor-=360
		WEnd
		If GUICtrlRead($korr)=1 Then
			Switch $vColor
				Case 39 To 43
				   $iarkost = 96
				Case 44 To 48
				   $iarkost = 93
				Case 49 To 53
				   $iarkost = 86
				Case 54 To 180
					$iarkost =82
				Case 181 To 190
				   $iarkost = 86
				Case 191 To 200
				   $iarkost = 90
				Case Else
				   $iarkost =100
			EndSwitch
		EndIf
		Dim $aHSB[3] = [$vColor, '100', $iarkost]
		$aRGB= _HSB_to_RGB($aHSB)
		_GuiCtrlRichEdit_SetSel($hRichEdit, $i-1, -1, True)
		_GuiCtrlRichEdit_SetCharColor($hRichEdit, Dec($aRGB[2]&$aRGB[1]&$aRGB[0]))
	Next
	_GUICtrlRichEdit_Deselect($hRichEdit)
	$htm=_GUICtrlRichEdit_StreamToVar($hRichEdit)
EndFunc

Func _StartHTML()
	; $Text0=GUICtrlRead($Text)
	; $aText0=StringSplit($Text0, '')
	$htm=''
	$iarkost=100
	For $i = 1 to $aText0[0]
		If $obr=1 Then
			$vColor=Int(($aText0[0]-$i)*$cycle0*$diap0/$aText0[0]+$cdvig0)
		Else
			$vColor=Int(($i-1)*$cycle0*$diap0/$aText0[0]+$cdvig0)
		EndIf
		While $vColor>=360
			$vColor-=360
		WEnd
		If GUICtrlRead($korr)=1 Then
			Switch $vColor
				Case 39 To 43
				   $iarkost = 96
				Case 44 To 48
				   $iarkost = 93
				Case 49 To 53
				   $iarkost = 86
				Case 54 To 180
					$iarkost =82
				Case 181 To 190
				   $iarkost = 86
				Case 191 To 200
				   $iarkost = 90
				Case Else
				   $iarkost =100
			EndSwitch
		EndIf
		Dim $aHSB[3] = [$vColor, '100', $iarkost]
		$aRGB= _HSB_to_RGB($aHSB)
		$htm&='<font color=#'&$aRGB[0]&$aRGB[1]&$aRGB[2]&'>'&$aText0[$i]&'</font>'
	Next
	If GUICtrlRead($bold)=1 Then $htm='<b>'&$htm&'</b>'
	If GUICtrlRead($italic)=1 Then $htm='<i>'&$htm&'</i>'
EndFunc

Func _StartBBC()
	; $aText0=StringSplit(_GUICtrlRichEdit_GetText($hRichEdit), '')
	; $Text0=GUICtrlRead($Text)
	; $aText0=StringSplit($Text0, '')
	$htm=''
	$iarkost=100
	For $i = 1 to $aText0[0]
		If $obr=1 Then
			$vColor=Int(($aText0[0]-$i)*$cycle0*$diap0/$aText0[0]+$cdvig0)
		Else
			$vColor=Int(($i-1)*$cycle0*$diap0/$aText0[0]+$cdvig0)
		EndIf
		While $vColor>=360
			$vColor-=360
		WEnd
		If GUICtrlRead($korr)=1 Then
			Switch $vColor
				Case 39 To 43
				   $iarkost = 96
				Case 44 To 48
				   $iarkost = 93
				Case 49 To 53
				   $iarkost = 86
				Case 54 To 180
					$iarkost =82
				Case 181 To 190
				   $iarkost = 86
				Case 191 To 200
				   $iarkost = 90
				Case Else
				   $iarkost =100
			EndSwitch
		EndIf
		Dim $aHSB[3] = [$vColor, '100', $iarkost]
		$aRGB= _HSB_to_RGB($aHSB)
		$htm&='[color=#'&$aRGB[0]&$aRGB[1]&$aRGB[2]&']'&$aText0[$i]&'[/color]'
	Next
	If GUICtrlRead($bold)=1 Then $htm='[b]'&$htm&'[/b]'
	If GUICtrlRead($italic)=1 Then $htm='[i]'&$htm&'[/i]'
EndFunc

Func _SplitStr($tmp)
;==============================
;кусок кода из UDF File.au3 для разделения образца построчно в массив
	If StringInStr($tmp, @LF) Then
		$aBtext = StringSplit(StringStripCR($tmp), @LF)
	ElseIf StringInStr($tmp, @CR) Then
		$aBtext = StringSplit($tmp, @CR)
	Else
		If StringLen($tmp) Then
			Dim $aBtext[2] = [1, $tmp]
		Else
			MsgBox(0, $LngErr, $LngMs1)
			Return SetError(1)
		EndIf
	EndIf
	Return $aBtext
EndFunc

Func _multihtmH($aBtext)
	$multihtm=''
	For $i = 1 To $aBtext[0]
		If $aBtext[$i] = '' Then
			$multihtm&='<br>'
		Else
			; GUICtrlSetData($Text, $aBtext[$i])
			$aText0=StringSplit($aBtext[$i], '')
			_StartHTML()
			$multihtm&=$htm&'<br>'
		EndIf
	Next
	ClipPut($multihtm)
	_Preview($multihtm)
EndFunc

Func _multihtmB($aBtext)
	$multihtm=''
	For $i = 1 To $aBtext[0]
		If $aBtext[$i] = '' Then
			$multihtm&=@CRLF
		Else
			; GUICtrlSetData($Text, $aBtext[$i])
			$aText0=StringSplit($aBtext[$i], '')
			_StartBBC()
			$multihtm&=$htm&@CRLF
		EndIf
	Next
	ClipPut($multihtm)
EndFunc

Func _multihtmR($aBtext)
	$multihtm=''
	For $i = 1 To $aBtext[0]
		If $aBtext[$i] = '' Then
			$aBtext[$i]=@CRLF
		Else
			; GUICtrlSetData($Text, $aBtext[$i])
			$aText0=StringSplit($aBtext[$i], '')
			_StartRTF($aBtext[$i])
			$aBtext[$i]=$htm
		EndIf
	Next
	_GUICtrlRichEdit_SetText($hRichEdit, '')
	For $i = 1 To $aBtext[0]
		_GUICtrlRichEdit_AppendText($hRichEdit, $aBtext[$i])
	Next
	_GuiCtrlRichEdit_SetSel($hRichEdit,  0, -1, True)
	_GUICtrlRichEdit_SetFont($hRichEdit, 12, 'Arial')
	_GUICtrlRichEdit_SetCharAttributes($hRichEdit, '+bo+it')
	_GUICtrlRichEdit_Deselect($hRichEdit)
	WinSetState($Gui,'',@SW_HIDE) ; такая заморочка из-за того что текст выделяется без подсвечивания
	WinSetState($Gui,'',@SW_SHOW)
EndFunc

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
EndFunc




; ===============================================================================
; Function Name ...: _HSB_to_RGB
; AutoIt Version ....: 3.2.12.1+
; Description ........: Конвертирование цветового пространства из HSB в RGB
; Parameters .......: Массив
; Return values ....: Массив
; Author(s) ..........: AZJIO
; ===============================================================================
Func _HSB_to_RGB($aHSB)
	Local $min, $max, $aRGB[3]
	
	$aHSB[2]/=100
	
	If $aHSB[1] = 0 Then
		$aRGB[0]=Hex(Round($aHSB[2]*255), 2)
		$aRGB[1]=$aRGB[0]
		$aRGB[2]=$aRGB[0]
		Return $aRGB
	EndIf
	
	While $aHSB[0]>=360
		$aHSB[0]-=360
	WEnd
	
	$aHSB[1]/=100
	$aHSB[0] /= 60
	$Sector=Int($aHSB[0])
	
	$f=$aHSB[0] - $Sector
	$p=$aHSB[2]*(1-$aHSB[1])
	$q=$aHSB[2]*(1-$aHSB[1]*$f)
	$t=$aHSB[2]*(1-$aHSB[1]*(1-$f))
	
	Switch $Sector
		Case 0
		   $aRGB[0]=$aHSB[2]
		   $aRGB[1]=$t
		   $aRGB[2]=$p
		Case 1
		   $aRGB[0]=$q
		   $aRGB[1]=$aHSB[2]
		   $aRGB[2]=$p
		Case 2
		   $aRGB[0]=$p
		   $aRGB[1]=$aHSB[2]
		   $aRGB[2]=$t
		Case 3
		   $aRGB[0]=$p
		   $aRGB[1]=$q
		   $aRGB[2]=$aHSB[2]
		Case 4
		   $aRGB[0]=$t
		   $aRGB[1]=$p
		   $aRGB[2]=$aHSB[2]
		Case Else
		   $aRGB[0]=$aHSB[2]
		   $aRGB[1]=$p
		   $aRGB[2]=$q
	EndSwitch
	
   $aRGB[0]=Hex(Round($aRGB[0]*255), 2)
   $aRGB[1]=Hex(Round($aRGB[1]*255), 2)
   $aRGB[2]=Hex(Round($aRGB[2]*255), 2)
	
	Return $aRGB
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
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 508)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 261)
	EndIf
EndFunc

Func _Preview($TmpHtml=-1)
GUIRegisterMsg($WM_SIZE, "")
	Local $EditBut, $Gui1, $GP, $msg, $StrBut
	$GP=_ChildCoor($Gui, 470, 300)
	GUISetState(@SW_DISABLE, $Gui)
	
    $Gui1 = GUICreate('Сообщение', $GP[2], $GP[3], $GP[0], $GP[1], $WS_OVERLAPPEDWINDOW, -1, $Gui)

	$oIE = _IECreateEmbedded()
	GUICtrlCreateObj($oIE, 5, 5, 460, 290)
	GUICtrlSetResizing(-1,  2 + 32 + 4 + 64)
	_IENavigate($oIE, 'about:blank')
	 $oBody=_IETagNameGetCollection($oIE,"body",0)
	; $StrBut=GUICtrlCreateButton ('Калькулятор', 100, 40, 80, 22)
	GUISetState(@SW_SHOW, $Gui1)
	If $TmpHtml=-1 Then
		$aText0=StringSplit(_GUICtrlRichEdit_GetText($hRichEdit), '')
		_StartHTML()
		_IEBodyWriteHTML($oBody,$htm)
	Else
		_IEBodyWriteHTML($oBody,$TmpHtml)
	EndIf
	While 1
	  $msg = GUIGetMsg()
	  Select
		; Case $msg = $StrBut
			; ShellExecute('Calc.exe')
		Case $msg = -3
			GUISetState(@SW_ENABLE, $Gui)
			GUIDelete($Gui1)
			GUIRegisterMsg($WM_SIZE, "WM_SIZE")
			ExitLoop
		EndSelect
    WEnd
EndFunc

; вычисление координат дочернего окна
Func _ChildCoor($Gui, $w, $h, $c=0, $d=0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
	$GP = WinGetPos($Gui), _
	$wgcs=WinGetClientSize($Gui), _
	$dLeft=($GP[2]-$wgcs[0])/2, _
	$dTor=$GP[3]-$wgcs[1]-$dLeft
	If $c = 0 Then
		$GP[0]=$GP[0]+($GP[2]-$w)/2-$dLeft
		$GP[1]=$GP[1]+($GP[3]-$h-$dLeft-$dTor)/2
	EndIf
	If $d>($aWA[2]-$aWA[0]-$w-$dLeft*2)/2 Or $d>($aWA[3]-$aWA[1]-$h-$dLeft+$dTor)/2 Then $d=0
	If $GP[0]+$w+$dLeft*2+$d>$aWA[2] Then $GP[0]=$aWA[2]-$w-$d-$dLeft*2
	If $GP[1]+$h+$dLeft+$dTor+$d>$aWA[3] Then $GP[1]=$aWA[3]-$h-$dLeft-$dTor-$d
	If $GP[0]<=$aWA[0]+$d Then $GP[0]=$aWA[0]+$d
	If $GP[1]<=$aWA[1]+$d Then $GP[1]=$aWA[1]+$d
	$GP[2]=$w
	$GP[3]=$h
	Return $GP
EndFunc

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
EndFunc


Func _About()
Local $font, $GP, $Gui1, $msg, $url, $WbMn
GUIRegisterMsg($WM_SIZE, "")
$GP=_ChildCoor($Gui, 210, 180)
GUISetState(@SW_DISABLE, $Gui)
$font="Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], $WS_CAPTION+$WS_SYSMENU, -1, $Gui)
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 210, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,14, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,208,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.3  6.06.2011', 15, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 15, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 52, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 15, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 90, 130, 125, 17)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010', 15, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg = $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $msg = $WbMn
			ClipPut('R939163939152')
		Case $msg = -3
			GUISetState(@SW_ENABLE, $Gui)
			GUIDelete($Gui1)
			GUIRegisterMsg($WM_SIZE, "WM_SIZE")
			ExitLoop
		EndSelect
    WEnd
EndFunc