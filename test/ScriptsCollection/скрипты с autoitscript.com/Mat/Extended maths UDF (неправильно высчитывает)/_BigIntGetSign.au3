; BigIntCreate Example

#include<MathExt.au3>

$myBigInt = _BigIntCreate (123456789)

_BigIntSetSign ($myBigInt, "-")
$sString = _BigIntGetSign ($myBigInt)
MsgBox (0, "Result", $sString)

_BigIntSetSign ($myBigInt, -1) ; -1 = reverse!!
$sString = _BigIntGetSign ($myBigInt)
MsgBox (0, "Result", $sString)