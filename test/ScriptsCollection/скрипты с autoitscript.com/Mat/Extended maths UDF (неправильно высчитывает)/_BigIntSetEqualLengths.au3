
#include<MathExt.au3>

$myBigInt1 = _BigIntCreate (1234)
$myBigInt2 = _BigIntCreate (123123234234345634534)

MsgBox (0, "Original", "1: " & UBound ($myBigInt1) & @CRLF & "2: " & UBound ($myBigInt2))

_BigIntSetEqualLengths ($myBigInt1, $myBigInt2)

MsgBox (0, "New", "1: " & UBound ($myBigInt1) & @CRLF & "2: " & UBound ($myBigInt2))
