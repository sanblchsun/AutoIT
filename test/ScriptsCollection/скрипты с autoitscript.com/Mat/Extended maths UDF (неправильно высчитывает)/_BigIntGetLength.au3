
#include<MathExt.au3>

$myBigInt1 = _BigIntCreate (1234)

$nLen = _BigIntGetLength ($myBigInt1)

MsgBox (0, "Length", $nLen)
