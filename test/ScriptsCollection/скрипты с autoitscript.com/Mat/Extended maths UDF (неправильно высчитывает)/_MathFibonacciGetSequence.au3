
#include<MathExt.au3>

$inp = InputBox ("Enter the index to go up to...", "Please enter an index. High numbers will take a long time though!") + 0
If @Error Then Exit
MsgBox (0, "Result - Normal", _FibonacciGetSequence ($inp))