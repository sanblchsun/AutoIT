#include<array.au3>
#include<GetConstFromVal.au3>

$sInp = InputBox("Enter...", "Please enter a value or a name for a valid constant...", "$GUI_EVENT_CLOSE", " M")
If @error Then Exit

If StringLeft($sInp, 1) = "$" Then ; Is a name!
	$temp = _FindValByConst($sInp)
Else
	$temp = _FindConstByVal($sInp)
EndIf
_ArrayDisplay($temp)
