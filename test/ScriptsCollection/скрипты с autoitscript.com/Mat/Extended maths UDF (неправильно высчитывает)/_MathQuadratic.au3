
#include<MathExt.au3>

$temp = _MathQuadratic ("2x^2+4x-51")

MsgBox (0, "Result", _
   "The Formula: " & @TAB & $temp[0] & @CRLF & _
   "Answer 1: " & @TAB & $temp[1] & @CRLF & _
   "Answer 2: " & @TAB & $temp[2] & @CRLF & _
   "Min point: " & @TAB & $temp[3])