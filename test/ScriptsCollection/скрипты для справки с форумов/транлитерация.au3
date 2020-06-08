$sCyrrilicString = "Привет, Как дела?" 
 
$sTranslitString = _Translit_Proc($sCyrrilicString) 
MsgBox(64, "_Translit_Proc in Action!", $sCyrrilicString & @CRLF & $sTranslitString) 
 
Func _Translit_Proc($sStringToTranslit) 
    Local $sCyrrilicTable = 'а|б|в|г|д|е|ё|ж|з|и|й|к|л|м|н|о|п|р|с|т|у|ф|х|ц|ч|ш|щ|ь|ъ|ы|э|ю|я' 
    $sCyrrilicTable &= '|' & StringUpper($sCyrrilicTable) 
 
    Local $sLatinTable = 'a|b|v|g|d|e|yo|zh|z|i|j|k|l|m|n|o|p|r|s|t|u|f|h|ts|ch|sh|sch|''|"|y|e|yu|ya' 
    $sLatinTable &= '|' & StringUpper($sLatinTable) 
 
    Local $aCyrrilicTable = StringSplit($sCyrrilicTable, "|") 
    Local $aLatinTable = StringSplit($sLatinTable, "|") 
 
    Local $sRetString = $sStringToTranslit 
 
    For $i = 1 To $aCyrrilicTable[0] 
        $sRetString = StringReplace($sRetString, $aCyrrilicTable[$i], $aLatinTable[$i], 0, 1) 
        If StringIsASCII($sRetString) Then ExitLoop 
    Next 
 
    Return $sRetString 
EndFunc   ;==>_Translit_Proc 