; AZJIO
; http://www.autoitscript.com/forum/topic/145840-fast-delete-multiple-lines-from-text-file/#entry1031341
$sText = ''
For $i = 1 To 20
	$sText &= $i & ' Line' & @CRLF
Next
; $sText ='1 Line'
; MsgBox(0, 'Preview', $sText)
_StringDelete($sText, 2, 18)
MsgBox(0, 'After', $sText)
; MsgBox(0, 'After, @error=' & @error, $sText)

Func _StringDelete(ByRef $sText, $iStart, $iEnd)
	If $iStart > $iEnd Then
		Local $tmp = $iStart
		$iStart = $iEnd
		$iEnd = $tmp
	EndIf
	Local $iPosStart, $iPosEnd
	$iStart -= 1
	If $iStart < 1 Then
		$iPosStart = 0
		$iStart = 0
	Else
		$iPosStart = StringInStr($sText, @CRLF, 1, $iStart)
		If Not $iPosStart Then Return
	EndIf
	$iPosEnd = StringInStr($sText, @CRLF, 1, $iEnd - $iStart, $iPosStart + 1)
	If $iPosEnd Then
		$sText = StringLeft($sText, $iPosStart) & StringTrimLeft($sText, $iPosEnd)
	Else
		$sText = StringLeft($sText, $iPosStart)
	EndIf
EndFunc