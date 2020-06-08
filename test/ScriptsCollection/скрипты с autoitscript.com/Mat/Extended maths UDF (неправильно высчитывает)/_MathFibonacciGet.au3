
#include<MathExt.au3>

While 1
   $inp = InputBox ("Enter Nth term...", "Please enter the nth term for the fibonacci number") + 0
   If @Error Then ExitLoop
   MsgBox (0, "Result", _FibonacciGet ($inp) & @CRLF & "Err: " & @ERROR & @CRLF & "Ext: " & @EXTENDED)
WEnd