#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=The_generator_of_melodies.exe
#AutoIt3Wrapper_icon=The_generator_of_melodies.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=The_generator_of_melodies.exe
#AutoIt3Wrapper_Res_Fileversion=0.4.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 24.07.2010 (AutoIt3_v3.2.12.1+)
#NoTrayIcon

; En
$LngTitle='Generator of melodies'
$LngTempo='Tempo'
$LngStd='Standard'
$LngOctave='Octave'
$LngDuration='Duration'
$LngTone='Tone'
$LngSec='sec'
$LngHz='Hz'
$LngPlay='Play'
$LngCancel='Cancel'
$LngClear='Clear'
$LngSave='Save'
$LngOpen='Open'
$LngStop='Stop'
$LngErr='Error'
$LngFile='file'
$LngScr='script'
$LngSel='Select'
$LngText='Is absent function _Beep in script'
$LngAbout='About'
$LngVer='Version'
$LngSite='Site'
$LngCopy='Copy'
$LngHK='HotKey'
$LngHKMsg= 'Play Note - Alt+1...n'&@CRLF&'Add  Note - Ctrl+1...n'&@CRLF&'Change Octave - Alt+1...n (left)'&@CRLF&$LngOpen&' - Alt+.'&@CRLF&$LngPlay&' - Space'&@CRLF&$LngCancel&' - Ctrl+Backspace'&@CRLF&$LngClear&' - Ctrl+Delete'&@CRLF&$LngSave&' - "+ (left)"'&@CRLF&$LngStop&' - "0 (left)"'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngTitle='Генератор мелодий'
	$LngTempo='Темп'
	$LngStd='Эталон'
	$LngOctave='Октава'
	$LngDuration='Длительность'
	$LngTone='Тон'
	$LngSec='сек'
	$LngHz='Гц'
	$LngPlay='Воспроизв.'
	$LngCancel='Отмена'
	$LngClear='Очистить'
	$LngSave='Сохранить'
	$LngOpen='Открыть'
	$LngStop='Стоп'
	$LngErr='Сообщение'
	$LngFile='файла'
	$LngScr='скрипт'
	$LngSel='Выбор'
	$LngText='Отсутствует функция _Beep в скрипте'
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngSite='Сайт'
	$LngCopy='Копировать'
	$LngHK='Горячие клавиши'
	$LngHKMsg= 'Воспроизведение ноты - Alt+первый ряд цифр основной клавиатуры'&@CRLF&'Добавление ноты - Ctrl+первый ряд цифр основной клавиатуры'&@CRLF&'Смена октавы - Alt+цифры на цифровой клавиатуре'&@CRLF&$LngOpen&' - Alt+.'&@CRLF&$LngPlay&' - Space (пробел)'&@CRLF&$LngCancel&' - Ctrl+Backspace'&@CRLF&$LngClear&' - Ctrl+Delete'&@CRLF&$LngSave&' - "+ на цифровой клавиатуре"'&@CRLF&$LngStop&' - "0 на цифровой клавиатуре"'
EndIf




Global $text='', $Octave
$pid=''
GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")

 $Gui = GUICreate($LngTitle,270,420, -1, -1, 0x00040000+0x00020000+0x00010000)
If @compiled=0 Then GUISetIcon("wmploc.dll",-32)

$About = GUICtrlCreateButton("@", 225, 5, 18, 20)
GUICtrlSetTip(-1, $LngAbout)
GUICtrlSetResizing(-1, 802)

$HotKey = GUICtrlCreateButton("?", 245, 5, 18, 20)
GUICtrlSetTip(-1, $LngHK)
GUICtrlSetResizing(-1, 802)

GUICtrlCreateLabel ($LngStd, 5,8,60,20)
GUICtrlSetResizing(-1, 802)
$kamerton=GUICtrlCreateCombo ("", 80,5,60,20)
GUICtrlSetResizing(-1, 802)
GUICtrlSetData(-1,'330|349|370|392|415|440|466|494|523|554|587|622', '440')
$FrequencyOut=GUICtrlCreateLabel ('', 150,8,60,20)
GUICtrlSetResizing(-1, 802)


GUICtrlCreateLabel ($LngTone, 5,38,60,20)
GUICtrlSetResizing(-1, 802)
$Tone=GUICtrlCreateCombo ("", 80,35,60,20)
GUICtrlSetResizing(-1, 802)
GUICtrlSetData(-1,'-12|-9|-7|-5|-3|0|+3|+5|+7|+9|+12', '0')


GUICtrlCreateLabel ($LngTempo, 160,38,74,20)
GUICtrlSetResizing(-1, 802)
$tempo=GUICtrlCreateCombo ("", 200,35,50,20)
GUICtrlSetResizing(-1, 802)
GUICtrlSetData(-1,'0.5|0.7|1|1.3|1.5|1.7|2', '1')

GUICtrlCreateLabel ($LngDuration, 5,68,74,20)
GUICtrlSetResizing(-1, 802)
$Duration=GUICtrlCreateCombo ("", 90,65,50,20)
GUICtrlSetResizing(-1, 802)
GUICtrlSetData(-1,'1|2|3|4|5|6|7|8', '4')
GUICtrlCreateLabel ('/10 '&$LngSec, 150,68,60,20)
GUICtrlSetResizing(-1, 802)

GUICtrlCreateLabel ($LngOctave, 5,108,60,20)
GUICtrlSetResizing(-1, 802)
$Octave=4
$octaveL=GUICtrlCreateLabel ($Octave, 50,108,10,20)
GUICtrlSetResizing(-1, 802)
For $i = 1 To 8
	Assign('octave' & $i, GUICtrlCreateButton ($i, $i*20+50,106,20,20))
		GUICtrlSetBkColor (-1, 0xffffff )
		GUICtrlSetColor (-1, 0)
		GUICtrlSetResizing(-1, 802)
Next
GUICtrlSetBkColor ($Octave4, 0x99ff99 )

$pause=GUICtrlCreateButton ("p", 245,163,20,20)
GUICtrlSetResizing(-1, 802)


For $i = 1 To 12
	Assign('nota' & $i, GUICtrlCreateButton ($i, $i*20-15,140,20,20))
	GUICtrlSetResizing(-1, 802)
	If StringInStr(',2,4,7,9,11,', ','&$i&',') Then
		GUICtrlSetBkColor (-1, 0 )
		GUICtrlSetColor (-1, 0xffffff)
	Else
		GUICtrlSetBkColor (-1, 0xffffff )
		GUICtrlSetColor (-1, 0)
	EndIf
	Assign('addnota' & $i, GUICtrlCreateButton ($i, $i*20-15,163,20,20))
	GUICtrlSetResizing(-1, 802)
	If StringInStr(',2,4,7,9,11,', ','&$i&',') Then
		GUICtrlSetBkColor (-1, 0 )
		GUICtrlSetColor (-1, 0xffffff)
	Else
		GUICtrlSetBkColor (-1, 0xffffff )
		GUICtrlSetColor (-1, 0)
	EndIf
Next

$Edit1 = GUICtrlCreateEdit('', 5, 190, 260, 170)
GUICtrlSetResizing(-1, 102+256)
$play=GUICtrlCreateButton ($LngPlay, 5,363,65,22)
GUICtrlSetResizing(-1, 512+256+64+2)
$Cancel=GUICtrlCreateButton ($LngCancel, 75,363,60,22)
GUICtrlSetResizing(-1, 512+256+64+2)
$Clear=GUICtrlCreateButton ($LngClear, 140,363,60,22)
GUICtrlSetResizing(-1, 512+256+64+2)
$save=GUICtrlCreateButton ($LngSave, 205,363,60,22)
GUICtrlSetResizing(-1, 512+256+64+2)
$Open=GUICtrlCreateButton ($LngOpen, 205,65,60,22)
GUICtrlSetResizing(-1, 802)
$Stop=GUICtrlCreateButton ($LngStop, 205,-22,60,22)
GUICtrlSetResizing(-1, 802)

Dim $AccelKeys[39][2]=[["!{1}", $nota1], ["!{2}", $nota2], ["!{3}", $nota3], ["!{4}", $nota4], ["!{5}", $nota5], ["!{6}", $nota6], ["!{7}", $nota7], ["!{8}", $nota8], ["!{9}", $nota9], ["!{0}", $nota10], ["!{-}", $nota11], ["!{=}", $nota12], _
["^{1}", $addnota1], ["^{2}", $addnota2], ["^{3}", $addnota3], ["^{4}", $addnota4], ["^{5}", $addnota5], ["^{6}", $addnota6], ["^{7}", $addnota7], ["^{8}", $addnota8], ["^{9}", $addnota9], ["^{0}", $addnota10], ["^{-}", $addnota11], ["^{=}", $addnota12], _
["!{NUMPAD1}", $octave1], ["!{NUMPAD2}", $octave2], ["!{NUMPAD3}", $octave3], ["!{NUMPAD4}", $octave4], ["!{NUMPAD5}", $octave5], ["!{NUMPAD6}", $octave6], ["!{NUMPAD7}", $octave7], ["!{NUMPAD8}", $octave8], _
["{SPACE}", $play], ["^{DEL}", $Clear], ["^{BS}", $Cancel], ["!{.}", $Open], ["!{NUMPAD0}", $Stop], ["{NUMPADADD}", $save], ["{PAUSE}", $pause]]

GUISetAccelerators($AccelKeys)

GUISetState ()

While 1
	$msg = GUIGetMsg()
	For $i = 1 To 12
		If $msg = Eval('nota' & $i) Then _nota($i)
		If $msg = Eval('addnota' & $i) Then
			_addnota($i)
			ControlFocus ( $LngTitle, '', $Edit1)
			Send('^{END}')
		EndIf
	Next
	For $i = 1 To 8
		If $msg = Eval('octave' & $i) Then
			GUICtrlSetBkColor (Eval('octave' & $Octave) , 0xffffff )
			$Octave=$i
			GUICtrlSetData($octaveL, $i)
			GUICtrlSetBkColor (Eval('octave' & $Octave) , 0x99ff99)
		EndIf
	Next
	Select
		Case $msg = $About
			_About()
		Case $msg = $HotKey
			MsgBox(0,$LngHK,$LngHKMsg)
		Case $msg = $Cancel
			$text=GUICtrlRead ($Edit1)
			$text=StringRegExpReplace($text, '(?s)(^.*)\r\n(.*_Beep.*)[\r\n]*$', '\1')&@CRLF
			If @Extended=0 Then $text=''
			GUICtrlSetData($Edit1, $text)
			ControlFocus ( $LngTitle, '', $Edit1)
			Send('^{END}')
		Case $msg = $Clear
			$text=''
			GUICtrlSetData($Edit1, '')
		Case $msg = $Stop
			If ProcessExists($pid) Then
				ProcessClose($pid)
			EndIf
			_pos()
		Case $msg = $play
			If ProcessExists($pid) Then
				ProcessClose($pid)
				_pos()
				ContinueLoop
			EndIf
			$text=GUICtrlRead ($Edit1)
			If $text<>'' Then
				_save(@TempDir&'\Beepfile.au3')
				$pid=Run('"'&@AutoItExe&'" /AutoIt3ExecuteScript "'&@TempDir&'\Beepfile.au3"', '', @SW_HIDE)
				GUICtrlSetPos ($About, 225, -22)
				GUICtrlSetPos ($HotKey, 245, -22)
				GUICtrlSetPos ($Stop, 205,5)
			EndIf
		Case $msg = $Open
			If ProcessExists($pid) Then
				ProcessClose($pid)
				_pos()
			EndIf
			$file_Open = FileOpenDialog($LngSel&" au3-"&$LngFile&".", @WorkingDir & "", $LngScr&" (*.au3)", 1 + 4 )
			If @error Then ContinueLoop
			$file = FileOpen($file_Open, 0)
			$text = FileRead($file)
			FileClose($file)
			$tmpTempo=StringRegExpReplace($text, '(?s)(.*Tempo=)(.*?)(\r\n.*)', '\2')
			$tmpTone=StringRegExpReplace($text, '(?s)(.*Tone=)(.*?)(\r\n.*)', '\2')
			$text=StringRegExpReplace($text, '(?s)(.*?)(_Beep.*?)(Func .*)', '\2')
			If StringRegExp($text, '_Beep\(\d+,\d+,\d+', 0)=0 Then
				MsgBox(0, $LngErr, $LngText)
				ContinueLoop
			EndIf
			GUICtrlSetData($Edit1, $text)
			GUICtrlSetData($tempo,$tmpTempo,$tmpTempo)
			GUICtrlSetData($Tone,$tmpTone,$tmpTone)
		Case $msg = $save
			$text=GUICtrlRead ($Edit1)
			If $text<>'' Then
				$file_save = FileSaveDialog( "save", @ScriptDir & "", "Beepfile (*.au3)", 24, "Beepfile.au3")
				_save($file_save)
			EndIf
		Case $msg = $pause
			$Duration0=GUICtrlRead ($Duration)*100
			$text&='Sleep('&$Duration0&')'&@CRLF
			GUICtrlSetData($Edit1, $text)
			ControlFocus ( $LngTitle, '', $Edit1)
			Send('^{END}')
		Case $msg = -3
			ExitLoop
	EndSelect
WEnd


Func _pos()
GUICtrlSetPos ($About, 225, 5)
GUICtrlSetPos ($HotKey, 245, 5)
GUICtrlSetPos ($Stop, 205,-22)
EndFunc


Func _nota($i)
$Duration0=GUICtrlRead ($Duration)*100
$kamerton0=GUICtrlRead ($kamerton)*2^(1/6)/16
$Frequency=Ceiling ($kamerton0*2^$Octave*2^($i/12))
GUICtrlSetData($FrequencyOut, 'f: '&$Frequency&' '&$LngHz)
Beep($Frequency, $Duration0)
EndFunc


Func _addnota($i)
$Duration0=GUICtrlRead ($Duration)*100
$kamerton0=GUICtrlRead ($kamerton)*2^(1/6)/16
$Frequency=Ceiling ($kamerton0*2^$Octave*2^($i/12))
GUICtrlSetData($FrequencyOut, 'f: '&$Frequency&' '&$LngHz)
Beep($Frequency, $Duration0)

$text=GUICtrlRead ($Edit1)
If StringRight($text, 2)<>@CRLF Then $text&=@CRLF
$text&='_Beep('&$i&','&$Octave&','&$Duration0&')'&@CRLF
GUICtrlSetData($Edit1, $text)
EndFunc


Func _save($file_save)
$file = FileOpen($file_save,2)
FileWrite($file, '#NoTrayIcon'& @CRLF & _
	'Global $nTempo='&GUICtrlRead ($tempo) & @CRLF & _
	'Global $iTone='&GUICtrlRead ($Tone) & @CRLF & _
	'HotKeySet("{ESC}", "_Quit")' & @CRLF & @CRLF & _
	$text & @CRLF & @CRLF & _
	'Func _Beep($iNote,$iOctave=4,$iDuration=200,$iPause=0)' & @CRLF & _
	'	$Frequency='&GUICtrlRead ($kamerton)&'*2^(($iNote+$iTone)/12+$iOctave+1/6-4)' & @CRLF & _
	'	Beep($Frequency, $iDuration/$nTempo)' & @CRLF & _
	'	If $iPause<>0 Then Sleep($iPause/$nTempo)' & @CRLF & _
	'EndFunc' & @CRLF & @CRLF & _
	'Func _Quit()' & @CRLF & _
	'    Exit' & @CRLF & _
	'EndFunc')
FileClose($file)
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
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 276)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 426)
	EndIf
EndFunc

Func _About()
$GuiPos = WinGetPos($Gui)
GUISetState(@SW_DISABLE, $Gui)
$font="Arial"
    $Gui1 = GUICreate($LngAbout, 270, 180,$GuiPos[0]+$GuiPos[2]/2-135, $GuiPos[1]+$GuiPos[3]/2-90, -1, 0x00000080,$Gui)
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,15, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,268,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.4  24.07.2010', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 55, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
$msg = $Gui1
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg = $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $msg = $WbMn
			ClipPut('R939163939152')
		Case $msg = -3
			$msg = $Gui
			GUISetState(@SW_ENABLE, $Gui)
			GUIDelete($Gui1)
			ExitLoop
		EndSelect
    WEnd
EndFunc