; BigIntCreate Example

#include<MathExt.au3>

$myBigInt = _BigIntCreate (123456789)

; Check a valid big int.
$nCheck = _BigIntCheck ($myBigInt)
MsgBox (0, "Check Result: " & $nCheck, "Error:" & @TAB & @ERROR & @CRLF & "Ext. :" & @TAB & @EXTENDED)

; Check a non- big int
$nCheck = _BigIntCheck (123456789)
MsgBox (0, "Check Result: " & $nCheck, "Error:" & @TAB & @ERROR & @CRLF & "Ext. :" & @TAB & @EXTENDED)

; Check a "damaged" big int
$myBigInt[3] = "hello!!"
$nCheck = _BigIntCheck ($myBigInt)
MsgBox (0, "Check Result: " & $nCheck, "Error:" & @TAB & @ERROR & @CRLF & "Ext. :" & @TAB & @EXTENDED)