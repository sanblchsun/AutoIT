
#include <GUIConstantsEx.au3>


Global $a, $wi=40, $hi=20, $ww=10, $hh=10, $nP=3, $z=0
Dim $a1[6]
$gui = GUICreate('Chords', 300, 283,30,10)
$restart = GUICtrlCreateButton("R", 10, 260, 18, 20)

$Combo = GUICtrlCreateList('', 240, 10, 50, 17*16+2)
GUICtrlSetData(-1,"Cm|C|C7|Cm7|Cm75|Cm6|Cmj7|Cj7|C75-|C5+|Cm5-|C7+5+|Csus7|C75+|Co|C9-|C9","Cm") 

Dim $Lab[6]
For $i = 0 to 5
	$Lab[$i]=GUICtrlCreateLabel ("", $ww+$wi*5-$i*$wi+8,$hh,10,13)
	GUICtrlSetBkColor(-1, 0xffffff)
Next

$a2 = GUICtrlCreateGraphic(10, 150, 15, 88)
GUICtrlSetGraphic($a2, $GUI_GR_COLOR, 0, 0xFF0000)
GUICtrlSetGraphic($a2, $GUI_GR_ELLIPSE, 0, 0, 11, 11)
GUICtrlSetGraphic($a2, $GUI_GR_COLOR, 0, 0x00dd00)
GUICtrlSetGraphic($a2, $GUI_GR_ELLIPSE, 0, 20, 11, 11)
GUICtrlSetGraphic($a2, $GUI_GR_COLOR, 0, 0x5555FF)
GUICtrlSetGraphic($a2, $GUI_GR_ELLIPSE, 0, 40, 11, 11)
GUICtrlSetGraphic($a2, $GUI_GR_COLOR, 0, 0)
GUICtrlSetGraphic($a2, $GUI_GR_ELLIPSE, 0, 60, 11, 11)
GUICtrlCreateLabel ("1", 25, 148,10,13)
GUICtrlCreateLabel ("2", 25, 168,10,13)
GUICtrlCreateLabel ("3", 25, 188,10,13)
GUICtrlCreateLabel ("4", 25, 208,10,13)


$Play=GUICtrlCreateCheckbox("Play", 55, 148, 60,13)


$a = GUICtrlCreateGraphic($ww, $hh, $wi*6-20, $hi*6+5)
GUICtrlSetBkColor($a, 0xffffff)

; струны
For $i = 0 to 5
	GUICtrlSetGraphic($a, $GUI_GR_RECT, $ww,$hh+$i*$hi+5, $wi*5+1, 1)
Next

; лады
For $i = 0 to 5
	GUICtrlSetGraphic($a, $GUI_GR_RECT, $ww+$i*$wi,$hh+5, 1, $hi*5)
Next

_nLab()
_Point(1, 1, 3)
_Point(2, 2, 2)
_Point(3, 3, 1)
_Point(4, 3, 3)
_Point(5, 1, 1)
_Point(6, 1, 3)


GUISetState()

While 1
	 $msg = GUIGetMsg()
	 Select
		Case $msg = -3
			Exit
		Case $msg = $Combo
			For $i = 0 to 5
				GUICtrlDelete($a1[$i])
			Next
			Switch GUICtrlRead($Combo)
				Case 'Cm'
_nLab()
_Point(1, 1, 3)
_Point(2, 2, 2)
_Point(3, 3, 1)
_Point(4, 3, 3)
_Point(5, 1, 1)
_Point(6, 1, 3)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 1, 3)
	_BeepG(2, 2, 2)
	_BeepG(3, 3, 1)
	_BeepG(4, 3, 3)
	_BeepG(5, 1, 1)
	_BeepG(6, 1, 3)
EndIf
				Case 'C'
_nLab()
_Point(1, 1, 3)
_Point(2, 3, 2)
_Point(3, 3, 1)
_Point(4, 3, 3)
_Point(5, 1, 1)
_Point(6, 1, 3)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 1, 3)
	_BeepG(2, 3, 2)
	_BeepG(3, 3, 1)
	_BeepG(4, 3, 3)
	_BeepG(5, 1, 1)
	_BeepG(6, 1, 3)
EndIf
				Case 'C7'
_nLab()
_Point(1, 1, 3)
_Point(2, 3, 2)
_Point(3, 1)
_Point(4, 3, 3)
_Point(5, 1, 1)
_Point(6, 1, 3)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 1, 3)
	_BeepG(2, 3, 2)
	_BeepG(3, 1)
	_BeepG(4, 3, 3)
	_BeepG(5, 1, 1)
	_BeepG(6, 1, 3)
EndIf
				Case 'Cm7'
_nLab()
_Point(1, 1, 3)
_Point(2, 2, 2)
_Point(3, 1)
_Point(4, 3, 3)
_Point(5, 1, 1)
_Point(6, 1, 3)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 1, 3)
	_BeepG(2, 2, 2)
	_BeepG(3, 1)
	_BeepG(4, 3, 3)
	_BeepG(5, 1, 1)
	_BeepG(6, 1, 3)
EndIf
				Case 'Cm75'
				$nP+=1
_nLab()
_Point(1, 3)
_Point(2, 1, 2)
_Point(3, 2, 1)
_Point(4, 1, 3)
_Point(5, 3, 2)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 3)
	_BeepG(2, 1, 2)
	_BeepG(3, 2, 1)
	_BeepG(4, 1, 3)
	_BeepG(5, 3, 2)
EndIf
				$nP-=1
				Case 'Cm6'
				$nP-=2
_nLab()
_Point(1, 3, 3)
_Point(2, 1, 1)
_Point(3, 2)
_Point(4, 1, 2)
_Point(5, 3, 1)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 3, 3)
	_BeepG(2, 1, 1)
	_BeepG(3, 2)
	_BeepG(4, 1, 2)
	_BeepG(5, 3, 1)
EndIf
				$nP+=2
				Case 'Cmj7'
_nLab()
_Point(1, 1, 3)
_Point(2, 2, 2)
_Point(3, 2)
_Point(4, 3, 3)
_Point(5, 1, 1)
_Point(6, 1, 3)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 1, 3)
	_BeepG(2, 2, 2)
	_BeepG(3, 2)
	_BeepG(4, 3, 3)
	_BeepG(5, 1, 1)
	_BeepG(6, 1, 3)
EndIf
				Case 'Cj7'
_nLab()
_Point(1, 1, 3)
_Point(2, 3, 2)
_Point(3, 2)
_Point(4, 3, 3)
_Point(5, 1, 1)
_Point(6, 1, 3)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 1, 3)
	_BeepG(2, 3, 2)
	_BeepG(3, 2)
	_BeepG(4, 3, 3)
	_BeepG(5, 1, 1)
	_BeepG(6, 1, 3)
EndIf
				Case 'C75-'
				$nP-=2
_nLab()
_Point(1, 2, 3)
_Point(2, 1, 1)
_Point(3, 3)
_Point(4, 2, 2)
_Point(5, 1)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 2, 3)
	_BeepG(2, 1, 1)
	_BeepG(3, 3)
	_BeepG(4, 2, 2)
	_BeepG(5, 1)
EndIf
				$nP+=2
				Case 'C5+'
				$nP+=1
_nLab()
_Point(1, 1, 3)
_Point(2, 2, 2)
_Point(3, 2, 1)
_Point(4, 3, 3)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 1, 3)
	_BeepG(2, 2, 2)
	_BeepG(3, 2, 1)
	_BeepG(4, 3, 3)
EndIf
				$nP-=1
				Case 'Cm5-'
				$nP-=1
_nLab()
_Point(1, 1, 3)
_Point(2, 3, 2)
_Point(3, 4, 1)
_Point(4, 3, 3)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 1, 3)
	_BeepG(2, 3, 2)
	_BeepG(3, 4, 1)
	_BeepG(4, 3, 3)
EndIf
				$nP+=1
				Case 'C7+5+'
				$nP+=2
_nLab()
_Point(1, 3)
_Point(2, 1, 2)
_Point(3, 1, 1)
_Point(4, 2, 3)
_Point(5, 3, 2)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 3)
	_BeepG(2, 1, 2)
	_BeepG(3, 1, 1)
	_BeepG(4, 2, 3)
	_BeepG(5, 3, 2)
EndIf
				$nP-=2
				Case 'Csus7'
_nLab()
_Point(1, 1, 3)
_Point(2, 4, 2)
_Point(3, 1)
_Point(4, 3, 3)
_Point(5, 1, 1)
_Point(6, 1, 3)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 1, 3)
	_BeepG(2, 4, 2)
	_BeepG(3, 1)
	_BeepG(4, 3, 3)
	_BeepG(5, 1, 1)
	_BeepG(6, 1, 3)
EndIf
				Case 'C75+'
				$nP+=2
_nLab()
_Point(1, 2)
_Point(2, 1, 2)
_Point(3, 1, 1)
_Point(4, 2, 3)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 2)
	_BeepG(2, 1, 2)
	_BeepG(3, 1, 1)
	_BeepG(4, 2, 3)
EndIf
				$nP-=2
				Case 'Co'
				$nP-=2
_nLab()
_Point(1, 2)
_Point(2, 1)
_Point(3, 2)
_Point(4, 1)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 2)
	_BeepG(2, 1)
	_BeepG(3, 2)
	_BeepG(4, 1)
EndIf
				$nP+=2
				Case 'C9-'
				$nP-=1
_nLab()
_Point(1, 2)
_Point(2, 1)
_Point(3, 2)
_Point(4, 1)
_Point(5, 2)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 2)
	_BeepG(2, 1)
	_BeepG(3, 2)
	_BeepG(4, 1)
	_BeepG(5, 2)
EndIf
				$nP+=1
				Case 'C9'
				$nP+=2
_nLab()
_Point(1, 2)
_Point(2, 1, 2)
_Point(3, 1, 1)
_Point(4, 1, 3)
_Point(5, 1)

If GUICtrlRead($Play)=1 Then
	_BeepG(1, 2)
	_BeepG(2, 1, 2)
	_BeepG(3, 1, 1)
	_BeepG(4, 1, 3)
	_BeepG(5, 1)
EndIf
				$nP-=2
			EndSwitch
		Case $msg = $restart
			_restart()
	EndSelect
WEnd

Func _nLab()
	For $i = 0 to 5
		GUICtrlSetData($Lab[$i],$i+$nP-1)
	Next
	$z=0
EndFunc

Func _Point($S, $L, $C=0)
$clr = 0
Switch $C
	Case 1
 	   $clr = 0xFF0000
	Case 2
 	   $clr = 0x00dd00
	Case 3
 	   $clr = 0x5555FF
	Case Else
 	   $clr = 0
EndSwitch

$a1[$z] = GUICtrlCreateGraphic($ww, $hh)
GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0, $clr) ; цвет круга
GUICtrlSetGraphic(-1, $GUI_GR_ELLIPSE, $wi*6-$L*$wi-$wi/2+5, $hi*6-$S*$hi+5+5, 11, 11)
GUICtrlSetGraphic(-1, $GUI_GR_REFRESH)
$z+=1
EndFunc

Func _BeepG($S, $L, $C=0)
Switch $S
	Case 1
 	   $delta = 24
	Case 2
 	   $delta = 19
	Case 3
 	   $delta = 15
	Case 4
 	   $delta = 10
	Case 5
 	   $delta = 5
	Case 6
 	   $delta = 0
EndSwitch
$iNote=$delta+$nP+$L
$iFrequency=440*2^(($iNote)/12+3+1/6-4)
Beep($iFrequency, 200)
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
EndFunc   ;==>_restart

