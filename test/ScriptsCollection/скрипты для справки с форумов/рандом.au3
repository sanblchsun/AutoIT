$sVar = "ќсенн€€ пора - очей очарованье" 
 
$aWords = StringRegExp($sVar, "\s*([а-€ј-яa-zA-Z0-9-_\.]+)\s*", 3) 
$sVar = "" 
 
_ArrayRandomize($aWords) 
 
For $i = 0 To UBound($aWords)-1 
    $sVar &= $aWords[$i] & " " 
Next 
 
MsgBox(0, "", StringStripWS($sVar, 3)) 
 
Func _ArrayRandomize(ByRef $avArray, $iBase=0) 
    Local $iRandom, $sTemp, $iUbound = UBound($avArray)-1 
 
    For $i = $iBase To $iUbound 
        $sTemp = $avArray[$i] 
        $iRandom = Random($i, $iUbound, 1) 
        $avArray[$i] = $avArray[$iRandom] 
        $avArray[$iRandom] = $sTemp 
    Next 
EndFunc 