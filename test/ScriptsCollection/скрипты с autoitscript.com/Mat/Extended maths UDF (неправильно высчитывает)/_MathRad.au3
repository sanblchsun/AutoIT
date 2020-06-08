
#include<MathExt.au3>

$inp = InputBox ("Enter the Anount in degrees", "Enter the amount in gegrees to be converted into radians") + 0
If @Error Then Exit
MsgBox (0, "Result", _MathRad ($inp))