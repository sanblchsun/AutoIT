
#include<MathExt.au3>

Local $myBigInt1[6] = ["+", 0, 0, 1, 0, 0]

$ret = _BigIntRemoveTrailingZeros ($mybigInt1)

$myBigIntString = $myBigInt1[0]
For $i = 1 to UBound ($myBigInt1) - 1
   $myBigIntString &= $myBigInt1[$i]
Next

$ret = _BigIntToString ($ret)

MsgBox (0, "Result", "with 0's" & @TAB & $myBigIntString & @CRLF & "w/out 0's" & @TAB & $ret)