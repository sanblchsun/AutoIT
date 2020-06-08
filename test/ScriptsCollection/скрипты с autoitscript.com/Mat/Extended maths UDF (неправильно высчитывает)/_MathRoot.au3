
#include<MathExt.au3>

$nNum = -27
$nExp = 3

MsgBox (0, "Result", "$nNum^(1/$nExp):" & $nNum^(1/$nExp) & @CRLF & "MathRoot: " & _MathRoot ($nNum, $nExp))