#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Calculator.exe
#AutoIt3Wrapper_icon=Calculator.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Calculator.exe
#AutoIt3Wrapper_Res_Fileversion=0.6.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 10.10.2010 (AutoIt3_v3.2.12.1+)
#NoTrayIcon
#include <BigNum.au3>
Opt("GUIResizeMode", 0x0322)
Global $aN[10], $MG='', $Oper='', $MS0='', $trOper=0, $RES='', $trRavno=0, $aM[10][3], $aCalcini, $Mtmp, $LngFile='', $BaseFile='', $MGST=''
Global $Ini=@ScriptDir&'\Calc.ini'
$tablo0=''
$s0=''
$HoldCh=0

; En
$LngTitle='CalculatorMR'
$LngRet='Return'
$LngErr='Error'
$LngAbout='About'
$LngVer='Version'
$LngSite='Site'
$LngHK='HotKey'
$LngHKMsg= 'Number = Number'&@CRLF&@CRLF&'"=" - Space, Enter'&@CRLF&'"/" - Shift+(, \'&@CRLF&'"5 function" - Shift+1...Shift+5'&@CRLF&'"Add in extended memory" - Ctrl+1...Ctrl+9'&@CRLF&'"Return from extended memory" - Alt+1...Alt+9'&@CRLF&'"Unfold/roll up panel" - End'&@CRLF&'"MS" - Up'&@CRLF&'"MR" - Down'&@CRLF&'"M+" - PageUp'&@CRLF&'"+/-" - PageDown'&@CRLF&'"CE" - Ctrl+Delete'&@CRLF&'"BS" - Ctrl+Backspace'&@CRLF&'"RE" - Pause'
$LngL='Read memory'
$LngRest='"Restart CalculatorMR"'
$LngMS='Add in memory'&@CRLF&'"Up"'
$LngMR='Return from memory'&@CRLF&'"Down"'
$LngMP='Add to memories'&@CRLF&'PageUp'
$LngCE='Clean'&@CRLF&'Ctrl+Delete'
$LngBS='Take away numeral on the right'&@CRLF&'Ctrl+BackSpace'
$LngRE='Return the previous number'&@CRLF&'Pause Break'
$LngEX='Extended memory'&@CRLF&'End'
$LngDelit='Divide'&@CRLF&'Shift+('
$LngYmno='Multiply'
$LngMinus='Subtract'
$LngPlus='Add'
$LngRavno='Calculate'&@CRLF&'Enter, Space'
$LngPT='Point'
$LngPM='Change sign'&@CRLF&'PageDown'
$LngAMEx='Add in cell'
$LngRMEx='Return from cell'
$LngSave= 'Save cells. When Exit'&@CRLF&'is saved automatically'
$LngDX='Reciprocal'&@CRLF&'Shift+1'
$LngX2='in square'&@CRLF&'Shift+2'
$LngXY='Exponentiate'&@CRLF&'Shift+3'
$LngKoren='Square root'&@CRLF&'Shift+4'
$LngPI='pi - 3,14'&@CRLF&'Shift+5'
$LngSl='Choose file'
$LngType='To choose a language file'
$LngNum='File of numbers'
$LngOpConf='Open file a cell to memories'
$LngCl='Clean all cells'
$LngInvF='Invalid format of the file'
$LngCrIni='Create'
$LngHold='Hold'


If FileExists($Ini) Then
	$file = FileOpen($Ini, 0)
	$Calcini = FileRead($file)
	FileClose($file)
	;==============================
	;UDF File.au3
	If StringInStr($Calcini, @LF) Then
		$aCalcini = StringSplit(StringStripCR($Calcini), @LF)
	ElseIf StringInStr($Calcini, @CR) Then
		$aCalcini = StringSplit($Calcini, @CR)
	Else
		If StringLen($Calcini) Then
			Dim $aCalcini[2] = [1, $Calcini]
		Else
			MsgBox(0, $LngErr, "Error Calc.ini")
		EndIf
	EndIf
Else
	Dim $aCalcini[11]=['','position*-1*-1*0**','','','','','','','','','']
EndIf

$aPos=StringSplit($aCalcini[1], '*')
If $aPos[4] = 1 Then
	$PosW=275+235
	$Chr='0x25C4'
Else
	$PosW=275
	$Chr='0x25BA'
EndIf

$Gui = GUICreate($LngTitle, $PosW, 208, $aPos[2], $aPos[3])

$About = GUICtrlCreateButton("@", 217, 2, 18, 20)
GUICtrlSetTip(-1, $LngAbout)

$HotKey = GUICtrlCreateButton("?", 237, 2, 18, 20)
GUICtrlSetTip(-1, $LngHK)

$restart = GUICtrlCreateButton("R", 257, 2, 18, 20)
GUICtrlSetTip(-1, $LngRest)

$LRE = GUICtrlCreateLabel('', 15, 6, 203, 12,0xC)
GUICtrlSetColor (-1, 0x999999)
$MT = GUICtrlCreateLabel('', 17, 21, 203, 12,0xC)
GUICtrlSetColor (-1, 0x999999)
$Err = GUICtrlCreateLabel('', 220, 21, 35, 12,0xC)
GUICtrlSetColor (-1, 0xff0000)
GUICtrlSetFont (-1,8.5, 700)
$FileN= GUICtrlCreateLabel('Calc', 325, 3, 175, 15,0xC)
$tablo = GUICtrlCreateInput("", 13, 34, 245, 25,0x0002)
GUICtrlSetFont (-1,15, 400)
$LOper = GUICtrlCreateLabel('', 260, 34, 16, 25)
GUICtrlSetFont (-1,15, 400)

GUISetFont (15, 400)
$aN[0] = GUICtrlCreateButton("0", 70, 171, 30, 29)
;_bc()
$l=0
$v =0
For $i = 1 to 9
    If $l > 60 Then
        $l = 0
        $v -= 29
    EndIf
	$aN[$i] = GUICtrlCreateButton($i, 70+$l, 142+$v, 30, 29)
    $l += 30
	;_bc()
Next

$PM = GUICtrlCreateButton("+/-", 101, 171, 30, 29)
GUICtrlSetBkColor (-1, 0 )
GUICtrlSetColor (-1, 0xffffff)
GUICtrlSetFont (-1,12, 400)
GUICtrlSetTip(-1, $LngPM)
$PT = GUICtrlCreateButton(".", 131, 171, 30, 29)
GUICtrlSetTip(-1, $LngPT)
_bc()

$Divide = GUICtrlCreateButton("/", 165, 85, 25, 25)
GUICtrlSetTip(-1, $LngDelit)
_bc2()
$Multiply = GUICtrlCreateButton("*", 165, 115, 25, 25)
GUICtrlSetTip(-1,$LngYmno)
_bc2()
$minus = GUICtrlCreateButton("-", 165, 145, 25, 25)
GUICtrlSetTip(-1, $LngMinus)
_bc2()
$plus = GUICtrlCreateButton("+", 165, 175, 25, 25)
GUICtrlSetTip(-1, $LngPlus)
_bc2()
$ravno = GUICtrlCreateButton("=", 195, 175, 25, 25)
GUICtrlSetTip(-1, $LngRavno)
_bc2()

GUISetFont (9, 700)
$MS = GUICtrlCreateButton("MS", 195, 85, 25, 25)
GUICtrlSetTip(-1, $LngMS)
GUICtrlSetBkColor (-1, 0xffffff )
GUICtrlSetColor (-1, 0xff0000)
$MR = GUICtrlCreateButton("MR", 195, 115, 25, 25)
GUICtrlSetTip(-1, $LngMR)
GUICtrlSetBkColor (-1, 0xffffff )
GUICtrlSetColor (-1, 0xff0000)
$MP = GUICtrlCreateButton("M+", 195, 145, 25, 25)
GUICtrlSetTip(-1, $LngMP)
GUICtrlSetBkColor (-1, 0xffffff )
GUICtrlSetColor (-1, 0xff0000)
$CE = GUICtrlCreateButton("CE", 225, 85, 25, 25)
GUICtrlSetTip(-1, $LngCE)
GUICtrlSetBkColor (-1, 0x00aa00)
GUICtrlSetColor (-1, 0xffffff)
$BS = GUICtrlCreateButton("BS", 225, 115, 25, 25)
GUICtrlSetTip(-1, $LngBS)
GUICtrlSetBkColor (-1, 0x00aa00)
GUICtrlSetColor (-1, 0xffffff)
$RE = GUICtrlCreateButton("RE", 225, 145, 25, 25)
GUICtrlSetTip(-1,$LngRE)
GUICtrlSetBkColor (-1, 0x00aa00)
GUICtrlSetColor (-1, 0xffffff)
$EX = GUICtrlCreateButton(ChrW($Chr) , 225, 175, 25, 25)
GUICtrlSetTip(-1, $LngEX)
GUICtrlSetFont (-1,-1, -1, -1, 'Arial')

GUISetFont (8.5, 400)
$OpenConf = GUICtrlCreateButton('Open', 470, 20, 34, 18)
GUICtrlSetTip(-1,  $LngOpConf)
$Save = GUICtrlCreateButton('Save', 470, 40, 34, 18)
GUICtrlSetTip(-1,  $LngSave)
$Hold = GUICtrlCreateButton('Hold', 470, 60, 34, 18)
GUICtrlSetTip(-1,  $LngHold)
$OpenLng = GUICtrlCreateButton(' Lang', 470, 160, 34, 18)
GUICtrlSetTip(-1, $LngType)
$Clear = GUICtrlCreateButton(' Clear', 470, 180, 34, 18)
GUICtrlSetTip(-1, $LngCl)

$v =0
For $i = 1 to 9
	GUICtrlCreateLabel($i, 314, 23+$v, 17, 20)
	GUICtrlSetFont (-1,9, 700)
	$aM[$i][0] = GUICtrlCreateButton('>', 292, 20+$v, 17, 20)
	GUICtrlSetTip(-1, $LngAMEx&' '&$i&@CRLF&'Ctrl+'&$i)
GUICtrlSetBkColor (-1, 0xf01700)
GUICtrlSetColor (-1, 0xffffff)
GUICtrlSetFont (-1,11, 700)
	$aM[$i][1] = GUICtrlCreateButton('<', 275, 20+$v, 17, 20)
GUICtrlSetBkColor (-1, 0x00b300)
GUICtrlSetColor (-1, 0xffffff)
GUICtrlSetFont (-1,11, 700)
	GUICtrlSetTip(-1,  $LngRMEx&' '&$i&@CRLF&'Alt+'&$i)
	$aM[$i][2] = GUICtrlCreateInput('', 325, 20+$v, 140, 21)
	If Mod($i,2) = 0 Then GUICtrlSetBkColor(-1,0xf3f3f3)
	GUICtrlSetData($aM[$i][2],$aCalcini[$i+1])
    $v += 20
Next

GUISetFont (8.5, 700)
$dx = GUICtrlCreateButton("1/x", 10, 85, 28, 20)
GUICtrlSetTip(-1, $LngDX)
$x2 = GUICtrlCreateButton("x^2", 10, 105, 28, 20)
GUICtrlSetTip(-1, $LngX2)
$xy = GUICtrlCreateButton("x^y", 10, 125, 28, 20)
GUICtrlSetTip(-1, $LngXY)
$koren = GUICtrlCreateButton("V"&ChrW ('0x203E'), 10, 145, 28, 20)
GUICtrlSetFont (-1,-1, -1, -1, 'Arial')
GUICtrlSetTip(-1, $LngKoren)

; GUICtrlCreateGroup ("", 13, 53, 56, 25)
; $pi = GUICtrlCreateLabel("pi", 17, 61, 12, 14)
; GUICtrlSetTip(-1, $LngPI)
; $rad = GUICtrlCreateLabel("rad", 33, 61, 17, 14)
; $e= GUICtrlCreateLabel("e", 56, 61, 9, 14)
$pi = GUICtrlCreateButton("pi", 10, 165, 28, 20)
GUICtrlSetTip(-1, $LngPI)

If $aPos[6]<>'' And FileExists($aPos[6]) Then _OpenLng($aPos[6])
If $aPos[5]<>'' And FileExists($aPos[5]) Then _OpenConf($aPos[5])

Dim $AccelKeys[65][2]=[["1", $aN[1]], ["2", $aN[2]], ["3", $aN[3]], ["4", $aN[4]], ["5", $aN[5]], ["6", $aN[6]], ["7", $aN[7]], ["8", $aN[8]], ["9", $aN[9]], ["0", $aN[0]], ["{NUMPAD1}", $aN[1]], _
["{NUMPAD2}", $aN[2]], ["{NUMPAD3}", $aN[3]], ["{NUMPAD4}", $aN[4]], ["{NUMPAD5}", $aN[5]], ["{NUMPAD6}", $aN[6]], ["{NUMPAD7}", $aN[7]], ["{NUMPAD8}", $aN[8]], ["{NUMPAD9}", $aN[9]], ["{NUMPAD0}", $aN[0]], ["{NUMPADDIV}", _
$Divide], ["+{(}", $Divide], ["{\}", $Divide], ["{NUMPADMULT}", $Multiply], ["+{8}", $Multiply], ["{NUMPADSUB}", $minus], ["{-}", $minus], ["{NUMPADADD}", $plus], ["+{=}", $plus], ["{SPACE}", $ravno], ["{=}", $ravno], ["{Enter}", $ravno], _
["{UP}", $MS], ["{DOWN}", $MR], ["^{DEL}", $CE], ["{NUMPADDOT}", $PT], ["{.}", $PT], ["{PGDN}", $PM], ["{PGUP}", $MP], ["^{BS}", $BS], ["{PAUSE}", $RE], ["{END}", $EX], _
["+{1}", $dx], ["+{2}", $x2], ["+{3}", $xy], ["+{4}", $koren], ["+{5}", $pi], _
["^{1}", $aM[1][0]], ["^{2}", $aM[2][0]], ["^{3}", $aM[3][0]], ["^{4}", $aM[4][0]], ["^{5}", $aM[5][0]], ["^{6}", $aM[6][0]], ["^{7}", $aM[7][0]], ["^{8}", $aM[8][0]], ["^{9}", $aM[9][0]], _
["!{1}", $aM[1][1]], ["!{2}", $aM[2][1]], ["!{3}", $aM[3][1]], ["!{4}", $aM[4][1]], ["!{5}", $aM[5][1]], ["!{6}", $aM[6][1]], ["!{7}", $aM[7][1]], ["!{8}", $aM[8][1]], ["!{9}", $aM[9][1]]]

Dim $AccelKeys1[65][2]=[["+{1}", $dx], ["+{2}", $x2], ["+{3}", $xy], ["+{4}", $koren], ["+{5}", $pi]] ; для кнопки Hold

GUISetAccelerators($AccelKeys)
If $aPos[2]= '-1' Then _Save()
GUISetState(@SW_SHOW)

While 1
	$msg = GUIGetMsg()
	For $i = 1 to 9
		If $msg = $aM[$i][0] Then
			If $HoldCh=1 Then ContinueLoop
			$tablo0=GUICtrlRead ($tablo)
			If $tablo0<>'' Then
				GUICtrlSetColor ($Mtmp, 0x000000)
				GUICtrlSetData($aM[$i][2],$tablo0)
				GUICtrlSetColor ($aM[$i][2], 0xee0000)
				$Mtmp=$aM[$i][2]
			EndIf
		EndIf
	Next
	For $i = 1 to 9
		If $msg = $aM[$i][1] Then
			$tablo0=GUICtrlRead ($aM[$i][2])
			If $tablo0<>'' Then GUICtrlSetData($tablo,$tablo0)
		EndIf
	Next
	
	For $i = 0 to 9
		If $msg = $aN[$i] Then
		GUICtrlSetData($Err,'')
		$tablo0=GUICtrlRead ($tablo)
		If $i = 0 And ($tablo0='' Or $trOper=1 Or $trRavno=1) Then
			$s0='.'
		Else
			$s0=''
		EndIf
			If $trRavno=1 or $trOper=1 Then
				GUICtrlSetData($tablo,$i&$s0)
				$trRavno=0
				$trOper=0
				If GUICtrlRead ($LOper)='=' Then GUICtrlSetData($LOper,'')
			Else
				GUICtrlSetData($tablo,$tablo0&$i&$s0)
			EndIf
		EndIf
	Next
	Select
		Case $msg = $About
			_About()
		Case $msg = $HotKey
			MsgBox(0, $LngHK, $LngHKMsg)
		Case $msg = $Save
			_Save()
		Case $msg = $OpenLng
			$tmp = FileOpenDialog($LngSl, @WorkingDir, $LngType&" (*.lng)", 1, "", $Gui)
			If @error Then ContinueLoop
			_OpenLng($tmp)
		Case $msg = $OpenConf
			$tmp = FileOpenDialog($LngSl, @WorkingDir, $LngNum&" (*.ini)", "", "", $Gui)
			If @error Then ContinueLoop
			If StringRight($tmp, 4)<>'.ini' Then $tmp&='.ini'
			_OpenConf($tmp)
		Case $msg = $Clear
			If $HoldCh=1 Then ContinueLoop
			For $i = 1 to 9
				GUICtrlSetData($aM[$i][2],'')
			Next
		Case $msg = $Divide
			If GUICtrlRead ($LOper)='/' And Not($trRavno=1 or $trOper=1) Then _ravno()
			If GUICtrlRead ($tablo)<>'' Then
				GUICtrlSetData($LOper,'/')
				_Oper()
				$Oper=1
			EndIf
		Case $msg = $Multiply
			If GUICtrlRead ($LOper)='*' And Not($trRavno=1 or $trOper=1) Then _ravno()
			If GUICtrlRead ($tablo)<>'' Then
				GUICtrlSetData($LOper,'*')
				_Oper()
				$Oper=2
			EndIf
		Case $msg = $minus
			If GUICtrlRead ($LOper)='-' And Not($trRavno=1 or $trOper=1) Then _ravno()
			If GUICtrlRead ($tablo)<>'' Then
				GUICtrlSetData($LOper,'-')
				_Oper()
				$Oper=3
			EndIf
		Case $msg = $plus
			If GUICtrlRead ($LOper)='+' And Not($trRavno=1 or $trOper=1) Then _ravno()
			If GUICtrlRead ($tablo)<>'' Then
				GUICtrlSetData($LOper,'+')
				_Oper()
				$Oper=4
			EndIf
		Case $msg = $Hold
			If $HoldCh = 0 Then
				$HoldCh=1
				For $i = 1 to 9
					GUICtrlSetState($aM[$i][0],128)
					GUICtrlSetBkColor ($aM[$i][0], 0xbbbbbb)
					GUICtrlSetStyle ($aM[$i][2],0x0800)
					If Mod($i,2) = 0 Then
						GUICtrlSetBkColor($aM[$i][2],0xfffbd7)
					Else
						GUICtrlSetBkColor($aM[$i][2],0xffffee)
					EndIf
				Next
				GUISetAccelerators($AccelKeys1)
			Else
				$HoldCh=0
				For $i = 1 to 9
					GUICtrlSetState($aM[$i][0],64)
					GUICtrlSetBkColor ($aM[$i][0], 0xf01700)
					GUICtrlSetStyle ($aM[$i][2],0)
					If Mod($i,2) = 0 Then
						GUICtrlSetBkColor($aM[$i][2],0xf3f3f3)
					Else
						GUICtrlSetBkColor($aM[$i][2],0xffffff)
					EndIf
				Next
				GUISetAccelerators($AccelKeys)
			EndIf
		Case $msg = $ravno
			_ravno()
		Case $msg = $MS
			$MS0T=GUICtrlRead ($tablo)
			If $MS0T <>'' Then
				$MS0=$MS0T
				GUICtrlSetTip($MR, $LngL&' ' &$MS0)
				;GUICtrlSetBkColor ($MS, 0xddffdd )
				GUICtrlSetData($MT,'M='&$MS0)
				_mig(0xffaaaa)
			EndIf
		Case $msg = $MR
			If $MS0 <>'' Then
				GUICtrlSetData($tablo,$MS0)
				_mig(0xaaffaa)
			EndIf
		Case $msg = $MP
			$tablo0=GUICtrlRead ($tablo)
			If $tablo0 <>'' Then
				$MS0+=$tablo0
				GUICtrlSetTip($MR, $LngL&' ' &$MS0)
				GUICtrlSetData($MT,'M='&$MS0)
				_mig(0xaaaaff)
			EndIf
		Case $msg = $CE
			GUICtrlSetData($Err,'')
			GUICtrlSetData($tablo,'')
			GUICtrlSetData($LOper,'')
			$trRavno=1
		Case $msg = $BS
			$tablo0=GUICtrlRead ($tablo)
			GUICtrlSetData($tablo,StringTrimRight ($tablo0, 1 ))
		Case $msg = $RE
			GUICtrlSetData($tablo,$RES)
		Case $msg = $EX
			$GuiPos = WinGetPos($Gui)
			If $GuiPos[2] > 250 And $GuiPos[2] < 300 Then
				WinMove($Gui, "", $GuiPos[0], $GuiPos[1], $GuiPos[2]+235, $GuiPos[3])
				GUICtrlSetData($EX,ChrW ('0x25C4'))
			Else
				WinMove($Gui, "", $GuiPos[0], $GuiPos[1], $GuiPos[2]-235, $GuiPos[3])
				GUICtrlSetData($EX,ChrW ('0x25BA'))
			EndIf

		Case $msg = $PM
			$tablo0=GUICtrlRead ($tablo)
			If $tablo0='' Then ContinueLoop
			If StringLeft($tablo0, 1 )='-'  Then
				$tablo0=StringTrimLeft($tablo0, 1 )
			Else
				$tablo0='-'&$tablo0
			EndIf
			GUICtrlSetData($tablo,$tablo0)
		Case $msg = $PT
			$tablo0=GUICtrlRead ($tablo)
			If $tablo0<>'' Then
				If $trRavno=1 Or $trOper=1 Then
					GUICtrlSetData($tablo,'0.')
					$trOper=0
					$trRavno=0
				Else
					If StringInStr($tablo0, '.')>0 Then ContinueLoop
					GUICtrlSetData($tablo,$tablo0&'.')
				EndIf
			Else
				GUICtrlSetData($tablo,'0.')
				$trRavno=0
			EndIf
		Case $msg = $dx
			GUICtrlSetData($Err,'')
			$tablo0=GUICtrlRead ($tablo)
			If $tablo0='' Then ContinueLoop
			If $tablo0=0 Then
				_err()
				ContinueLoop
			EndIf
			GUICtrlSetData($tablo,1/$tablo0)
			$trRavno=1
			_re($tablo0)
		Case $msg = $x2
			GUICtrlSetData($Err,'')
			$tablo0=GUICtrlRead ($tablo)
			If $tablo0='' Then ContinueLoop
			$rech=Execute($tablo0)^2
			If StringInStr($rech, "1.#IN") Then
				_err()
				ContinueLoop
			EndIf
			GUICtrlSetData($tablo, $rech)
			$trRavno=1
			_re($tablo0)
		Case $msg = $xy
			GUICtrlSetData($Err,'')
			If GUICtrlRead ($tablo)='' Then ContinueLoop
				GUICtrlSetData($LOper,'^')
				_Oper()
				$Oper=5
		Case $msg = $koren
			GUICtrlSetData($Err,'')
			$tablo0=GUICtrlRead ($tablo)
			If $tablo0='' Then ContinueLoop
			If $tablo0<0 Then
				_err()
				ContinueLoop
			EndIf
			GUICtrlSetData($tablo,Sqrt($tablo0))
			$trRavno=1
			_re($tablo0)
		Case $msg = $pi
			GUICtrlSetData($Err,'')
			GUICtrlSetData($tablo,'3.141592653589793')
			$trRavno=1
			If GUICtrlRead ($tablo0)<>'' Then _re($tablo0)
		Case $msg = $restart
			_restart()
		Case $msg = -3
			_Save()
			Exit
	EndSelect
WEnd

Func _OpenLng($Path)
	$aLng = IniReadSection($Path, 'lng')
	If @error Then 
		$LngFile=''
		Return
	Else
		For $i = 1 To $aLng[0][0]
			If StringInStr($aLng[$i][1], '\r\n') <>0 Then $aLng[$i][1]=StringReplace($aLng[$i][1],'\r\n',@CRLF)
			Assign($aLng[$i][0],$aLng[$i][1])
		Next
		$LngFile=$Path
		GUICtrlSetTip($About, $LngAbout)
		GUICtrlSetTip($HotKey, $LngHK)
		GUICtrlSetTip($restart, $LngRest)
		GUICtrlSetTip($Divide, $LngDelit)
		GUICtrlSetTip($Multiply,$LngYmno)
		GUICtrlSetTip($minus, $LngMinus)
		GUICtrlSetTip($plus, $LngPlus)
		GUICtrlSetTip($ravno, $LngRavno)
		GUICtrlSetTip($MS, $LngMS)
		GUICtrlSetTip($MR, $LngMR)
		GUICtrlSetTip($MP, $LngMP)
		GUICtrlSetTip($CE, $LngCE)
		GUICtrlSetTip($BS, $LngBS)
		GUICtrlSetTip($RE,$LngRE)
		GUICtrlSetTip($EX, $LngEX)
		GUICtrlSetTip($Save,  $LngSave)
		GUICtrlSetTip($dx, $LngDX)
		GUICtrlSetTip($x2, $LngX2)
		GUICtrlSetTip($xy, $LngXY)
		GUICtrlSetTip($koren, $LngKoren)
		GUICtrlSetTip($pi, $LngPI)
		GUICtrlSetTip($OpenLng, $LngType)
		GUICtrlSetTip($Hold, $LngHold)
		GUICtrlSetTip($Clear , $LngCl)
		GUICtrlSetTip($OpenConf , $LngOpConf)
		For $i = 1 to 9
			GUICtrlSetTip($aM[$i][0], $LngAMEx&' '&$i&@CRLF&'Ctrl+'&$i)
			GUICtrlSetTip($aM[$i][1] ,  $LngRMEx&' '&$i&@CRLF&'Alt+'&$i)
		Next
	EndIf
EndFunc

Func _ravno()
	$tablo0=GUICtrlRead ($tablo)
	$tablo0Tmp=$tablo0
	If $tablo0<>'' Then
		If StringInStr($tablo0, ',') Then $tablo0=StringReplace($tablo0, ',' , '.')
		If StringInStr($MG, ',') Then $MG=StringReplace($MG, ',' , '.')
		
		If StringInStr($tablo0, 'e+') Then $tablo0=_ConvNumP($tablo0)
		If StringInStr($MG, 'e+') Then $MG=_ConvNumP($MG)

		If StringInStr($tablo0, 'e-') Then $tablo0=_ConvNumM($tablo0)
		If StringInStr($MG, 'e-') Then $MG=_ConvNumM($MG)
		$rech=''
		Switch $Oper
			Case 1
				If GUICtrlRead ($LOper)<>'=' Then
					If $tablo0='0' Or $tablo0='0.' Then
						_err()
						Return
					EndIf
					$rech = _BigNum_Div($MG, $tablo0,'200')
					$MGST=$tablo0
				Else
					If $MGST='0' Or $tablo0='0.' Then
						_err()
						Return
					EndIf
					$rech = _BigNum_Div($tablo0, $MGST,'200')
				EndIf
			Case 2
			   $rech = _BigNum_Mul($MG, $tablo0)
			   If GUICtrlRead ($LOper)<>'=' Then $MG=$tablo0
			Case 3
				If GUICtrlRead ($LOper)<>'=' Then
					$rech = _BigNum_Sub($MG, $tablo0)
					$MGST=$tablo0
				Else
					$rech = _BigNum_Sub($tablo0, $MGST)
				EndIf
			   If GUICtrlRead ($LOper)<>'=' Then $MG=$tablo0
			Case 4
			   $rech = _BigNum_Add($MG, $tablo0)
			   If GUICtrlRead ($LOper)<>'=' Then $MG=$tablo0
			Case 5
				If GUICtrlRead ($LOper)<>'=' Then
					$rech = $MG^$tablo0
					$MGST=$tablo0
				Else
					$rech = $tablo0^$MGST
				EndIf
			Case Else
			   Return
		EndSwitch
		If StringInStr($rech, "1.#IN") Then
			_err()
			Return
		EndIf
; 1200  > 1.2e+003
		If StringLen($rech)>20 And Not(StringInStr($rech, 'e+') Or StringInStr($rech, 'e-')) Then
			If StringLen(Int($rech))>20 Then
				$exp=StringLen(Int($rech))-1
				If StringLen($exp)<3 Then $exp='0'&$exp
				If StringLen($exp)<3 Then $exp='0'&$exp
				$rech=StringMid($rech, 1, 1)&'.'&StringTrimLeft(StringTrimRight(Int($rech),5),1)&'e+'$exp
			Else
				If StringMid($rech, 1, 1)<>0 Then
					$Npt = StringInStr($rech, '.')
					$rech= Round($rech, 20-$Npt)
				Else
					$aRech1=StringRegExp($rech, '(0\.)(0*)(\d+)',3)
					$exp=StringLen($aRech1[1])+1
					If StringLen($exp)<3 Then $exp='0'&$exp
					If StringLen($exp)<3 Then $exp='0'&$exp
					$rech=StringMid($aRech1[2], 1, 1)&'.'&StringTrimLeft($aRech1[2],1)
					$rech= Round($rech, 15)&'e-'&$exp
				EndIf
			EndIf
		EndIf
; End 1200  > 1.2e+003
		If StringInStr($rech, "1.#IN") Then
			_err()
			Return
		EndIf
		GUICtrlSetData($tablo,$rech)
		GUICtrlSetData($LOper,'=')
		_re($tablo0Tmp)
	EndIf
	$trRavno=1
EndFunc

; 1.2e+003  > 1200
Func _ConvNumP($num)
	$exp='1'
		$aRech1=StringSplit($num, '+')
		For $i = 1 to Execute($aRech1[2])
			$exp&='0'
		Next
		$num = _BigNum_Mul(StringTrimRight($aRech1[1],1), $exp)
	Return $num
EndFunc

; 1.2e-003  > 0.0012
Func _ConvNumM($num)
	$exp='1'
		$aRech1=StringSplit($num, '-')
		For $i = 1 to $aRech1[2]
			$exp&='0'
		Next
		$num = _BigNum_Div(StringTrimRight($aRech1[1],1), $exp,'200')
	Return $num
EndFunc

Func _err()
	GUICtrlSetData($Err,' Error ')
	$trOper=1
	For $i = 1 to 4
		GUICtrlSetBkColor ($Err, 0xff0000 )
		GUICtrlSetColor ($Err, 0xffffff)
		Sleep(40)
		GUICtrlSetBkColor ($Err, -1 )
		GUICtrlSetColor ($Err, 0xff0000)
		Sleep(40)
	Next
EndFunc

Func _Save()
	$GuiPos = WinGetPos($Gui)
	If $GuiPos[2] > 250 And $GuiPos[2] < 300 Then
		$W=0
	Else
		$W=1
	EndIf
	$Save0=''
	$Save11=''
	$Save1=''
	If $BaseFile = $Ini Then $BaseFile =''
	If $GuiPos[0] < 0 Or $GuiPos[1]< 0 Then
		$GuiPos[0]=$aPos[2]
		$GuiPos[1]=$aPos[3]
	EndIf
	$Save0&='position*'&$GuiPos[0]&'*'&$GuiPos[1]&'*'&$W&'*'&$BaseFile&'*'&$LngFile&@CRLF
	For $i = 1 to 9
		$Save1&=GUICtrlRead ($aM[$i][2])&@CRLF
	Next
	If $BaseFile<>'' And FileExists($BaseFile) Then
		$file = FileOpen($BaseFile,2)
		FileWrite($file, $Save0&$Save1)
		FileClose($file)
	$file = FileOpen($Ini, 0)
	$Save11 = FileRead($file)
	FileClose($file)
	$Save11=StringRegExpReplace($Save11, '(?s)(.*?\r\n)(.*)', '\2')
		$file = FileOpen($Ini,2)
		FileWrite($file, $Save0&$Save11)
		FileClose($file)
	Else
		$file = FileOpen($Ini,2)
		FileWrite($file, $Save0&$Save1)
		FileClose($file)
	EndIf
EndFunc

Func _OpenConf($Path)
	$file = FileOpen($Path, 0)
	$Calcini = FileRead($file)
	FileClose($file)
	If Not(StringLeft($Calcini, 8)='position' or $Calcini='') Then
		MsgBox(0, $LngErr, $LngInvF)
		Return
	EndIf
	$aCalcini=''
	$filename=StringRegExpReplace($Path, '(^.*)\\(.*)\.(.*)$', '\2')
	;==============================
	;UDF File.au3
	If StringInStr($Calcini, @LF) Then
		$aCalcini = StringSplit(StringStripCR($Calcini), @LF)
	ElseIf StringInStr($Calcini, @CR) Then
		$aCalcini = StringSplit($Calcini, @CR)
	Else
		If StringLen($Calcini) Then
			Dim $aCalcini[2] = [1, $Calcini]
		Else
			If MsgBox(4, $LngErr, $LngCrIni&' '&$filename&'?')=6 Then
				$file = FileOpen($Path, 2+8)
				FileClose($file)
				$BaseFile=$Path
				_Save()
				_OpenConf($Path)
			EndIf
			Return
		EndIf
	EndIf
	GUICtrlSetColor ($Mtmp, 0x000000)
	For $i = 1 to 9
		GUICtrlSetData($aM[$i][2],$aCalcini[$i+1])
	Next
	$BaseFile=$Path
	GUICtrlSetData($FileN,$filename)
	GUICtrlSetTip($OpenConf, 'Current' &@CRLF&$filename&'.ini')
EndFunc

Func _mig($t)
	GUICtrlSetBkColor ($tablo, $t)
	Sleep(40)
	GUICtrlSetBkColor ($tablo, 0xffffff )
EndFunc

Func _re($t)
	$RES=$t
	GUICtrlSetTip($RE, $LngRet&' '&$RES)
	GUICtrlSetData($LRE,'RE='&$RES)
EndFunc

Func _bc()
	GUICtrlSetBkColor (-1, 0 )
	GUICtrlSetColor (-1, 0xffffff)
EndFunc

Func _bc2()
	GUICtrlSetBkColor (-1, 0x003C74)
	GUICtrlSetColor (-1, 0xffffff)
EndFunc

Func _Oper()
	$MG=GUICtrlRead ($tablo)
	_re($MG)
	$trOper=1
	;GUICtrlSetData($tablo,'')
EndFunc

Func _restart()
	_Save()
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

Func _About()
$GuiPos = WinGetPos($Gui)
GUISetState(@SW_HIDE, $Gui)
$font="Arial"
    $Gui1 = GUICreate($LngAbout, 270, 180,$GuiPos[0], $GuiPos[1], -1, 0x00000080)
	GUISetBkColor (0xf8c848)
	GUICtrlCreateLabel($LngTitle, 0, 20, 270, 23, 0x01)
	GUICtrlSetFont (-1,15, 600, -1, $font)
	GUICtrlSetColor(-1,0xa21a10)
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.6  29.07.2010', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 55, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney: R939163939152', 55, 130, 210, 17)
	GUICtrlCreateLabel('Copyright AZJIO © 2010', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
$msg = $Gui1
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg = $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $msg = -3
			$msg = $Gui
			GUIDelete($Gui1)
			GUISetState(@SW_SHOW, $Gui)
			ExitLoop
		EndSelect
    WEnd
EndFunc