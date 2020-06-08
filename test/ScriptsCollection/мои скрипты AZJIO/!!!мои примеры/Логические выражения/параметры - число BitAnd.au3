; #include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

; $Style=BitOr($GUI_CHECKED , $GUI_SHOW)
; $Style=0x00000110
$Style=1023

MsgBox(0, 'Стиль', _GetState($Style))

Func _GetState($Value)
	If $Value = 0 Then Return
	Local $sOut, $n = 0.5
	For $i = 0 To Int(Log($Value) / Log(2))
		$n *= 2
		If BitAND($Value, $n) Then $sOut &= $n & @Tab & StringFormat("%#x", $n) & @Tab & _State($n) & @CRLF
	Next
	Return $sOut
EndFunc

Func _State($St)
	Switch $St
		Case 1
		   $r='$GUI_CHECKED'
		Case 2
		   $r='$GUI_INDETERMINATE'
		Case 4
		   $r='$GUI_UNCHECKED'
		Case 8
		   $r='$GUI_DROPACCEPTED'
		Case 16
		   $r='$GUI_SHOW'
		Case 32
		   $r='$GUI_HIDE'
		Case 64
		   $r='$GUI_ENABLE'
		Case 128
		   $r='$GUI_DISABLE'
		Case 256
		   $r='$GUI_FOCUS'
		Case 512
		   $r='$GUI_DEFBUTTON '
		Case 1024
		   $r='$GUI_EXPAND'
		Case 2048
		   $r='$GUI_ONTOP'
		Case 4096
		   $r='$GUI_NODROPACCEPTED'
		Case 8192
		   $r='$GUI_NOFOCUS'
		Case Else
		   $r='??? (>10 000)'
	EndSwitch
	Return $r
EndFunc