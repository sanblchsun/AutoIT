
; выдел€ем в буфер часть скрипта и стартуем скрипт, на выходе получаем необъ€вленные переменные.

#include <array.au3>

Global $aDefined[1], $aNotDefined[1], $Result

$Code = ClipGet()
$aCode = StringSplit($Code, @CRLF, 1)

for $x = 1 to $aCode[0]
    $aCode[$x] = $aCode[$x] & " "
    $aCode[$x] = StringRegExpReplace($aCode[$x], " (BitAND|BitNOT|BitOR)\(.+", "")
    Local $aMat = StringRegExp($aCode[$x], "(\$\w+)\W", 3)
    if @error = 0 Then
        if StringRegExp($aCode[$x], "(?i:Global|Dim|Local)") Then
            for $i = 0 to Ubound($aMat) - 1
                if Not StringInStr(_ArrayToString($aDefined, " "), $aMat[$i]) Then _ArrayAdd($aDefined, $aMat[$i])
            Next
        Else
            for $i = 0 to Ubound($aMat) - 1
                if Not StringInStr(_ArrayToString($aDefined, " "), $aMat[$i]) Then _ArrayAdd($aNotDefined, $aMat[$i])
            Next
        EndIf
    EndIf
Next

$aNotDefined = _ArrayUnique($aNotDefined)

For $x = 1 to UBound($aNotDefined) - 1
    $Result = $Result & $aNotDefined[$x] & ", "
Next

$Result = StringTrimLeft($Result, 2)
$Result = StringTrimRight($Result, 2)

MsgBox(0, "—ообщение", $Result)
Exit