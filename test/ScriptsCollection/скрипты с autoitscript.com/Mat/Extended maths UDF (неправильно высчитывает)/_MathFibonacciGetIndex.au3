
#include<MathExt.au3>

While 1
   $inp = InputBox ("Enter Fibonacci Number...", "Please enter a VALID fibonacci number!") + 0
   If @Error Then ExitLoop
   If _FibonacciCheck ($inp) = 0 Then
      MsgBox (0, "Oh dear...", "Thats not a fibonnaci number!! Try again.")
   Else
      MsgBox (0, "well Done!!", "You entered a valid fibonacci number! The index for that fibonacci number is: " & _
         _FibonacciGetIndex ($inp))
      ExitLoop
   EndIf
WEnd