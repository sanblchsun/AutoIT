
#include<MathExt.au3>

$myBigInt1 = _BigIntCreate (12349860234)
$myBigInt2 = _BigIntCreate (123423445)
$myBigInt3 = _BigIntMin ($myBigInt1, $myBigInt2)

$myBigInt1 = _BigIntToString ($myBigInt1)
$myBigInt2 = _BigIntToString ($myBigInt2)
$myBigInt3 = _BigIntToString ($myBigInt3)

MsgBox (0, "Result", "Min of: " & $myBigInt1 & " or " & $myBigInt2 & " = " & $myBigInt3)