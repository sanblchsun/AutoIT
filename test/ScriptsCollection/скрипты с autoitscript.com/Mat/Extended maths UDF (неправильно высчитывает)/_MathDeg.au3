
#include<MathExt.au3>

$inp = InputBox ("Enter the Anount in radians", "Enter the amount in radians to be converted into degrees") + 0
If @Error Then Exit
MsgBox (0, "Result", _MathDeg ($inp))