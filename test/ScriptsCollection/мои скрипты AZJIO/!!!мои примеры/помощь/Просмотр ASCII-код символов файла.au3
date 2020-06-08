#include <Array.au3>

Global $Chr[33] = ['NUL', 'SOH', 'STX', 'ETX', 'EOT', 'ENQ', 'ACK', 'BEL', 'BS', 'HT', 'LF', 'VT', 'FF', 'CR', 'SO', 'SI', _
		'DLE', 'DC1', 'DC2', 'DC3', 'DC4', 'NAK', 'SYN', 'ETB', 'CAN', 'EM', 'SUB', 'ESC', 'FS', 'GS', 'RS', 'US', 'Space']
; $sText = FileRead(@ScriptDir&'\file.txt')
$sText = FileRead('C:\ntldr')
If StringLen($sText) > 4000 Then
	MsgBox(0, 'Long', 'Cut off')
	$sText = StringLeft($sText, 4000)
EndIf

$aText = StringSplit($sText, '')
Global $aView[$aText[0] + 1][4] = [[$aText[0]]]

For $i = 1 To $aText[0]
	$aView[$i][0] = $aText[$i]
	$aView[$i][1] = Asc($aText[$i])
	$aView[$i][2] = Hex(Int($aView[$i][1]), 2)
	$aView[$i][3] = StringFormat("%03o", $aView[$i][1])
	
	Switch $aView[$i][1]
		Case 0 To 32
			$aView[$i][0] = $Chr[$aView[$i][1]]
		Case 127
			$aView[$i][0] = 'DEL'
		Case 160
			$aView[$i][0] = 'Space2'
	EndSwitch
Next

_ArrayDisplay($aView, 'View = Txt|Dec|Hex|Oct')