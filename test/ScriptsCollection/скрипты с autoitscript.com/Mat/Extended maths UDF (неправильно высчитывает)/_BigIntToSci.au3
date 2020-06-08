; BigIntCreate Example

#include<MathExt.au3>

$myBigInt = _BigIntCreate (123456789)

$sString = _BigIntToSci ($myBigInt)

MsgBox (0, "Scientific form of 123456789", $sString)