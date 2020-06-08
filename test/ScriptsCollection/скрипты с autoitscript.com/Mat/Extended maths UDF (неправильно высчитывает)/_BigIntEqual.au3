
#include<MathExt.au3>

$myBigInt1 = _BigIntCreate (12349860234)
$myBigInt2 = _BigIntCreate (12349860234)
$ret = _BigIntEqual ($myBigInt1, $myBigInt2) <> 0

MsgBox (0, "Result", "expression ""12349860234=12349860234"" is " & $ret)

$myBigInt1 = _BigIntCreate (12349860234)
$myBigInt2 = _BigIntCreate (14563566234)
$ret = _BigIntEqual ($myBigInt1, $myBigInt2) <> 0

MsgBox (0, "Result", "expression ""12349860234=14563566234"" is " & $ret)