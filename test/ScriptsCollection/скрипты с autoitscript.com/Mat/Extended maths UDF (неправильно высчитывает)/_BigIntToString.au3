; BigIntCreate Example

#include<MathExt.au3>

$myBigInt = _BigIntCreate (123456789)

$sString = _BigIntToString ($myBigInt)

MsgBox (0, "String of 123456789", $sString)