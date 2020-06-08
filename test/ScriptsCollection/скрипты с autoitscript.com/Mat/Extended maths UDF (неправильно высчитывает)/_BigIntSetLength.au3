
#include<MathExt.au3>

$myBigInt1 = _BigIntCreate (1234)

MsgBox (0, "Original", UBound ($myBigInt1))

_BigIntSetLength ($myBigInt1, 20)

MsgBox (0, "New", UBound ($myBigInt1))