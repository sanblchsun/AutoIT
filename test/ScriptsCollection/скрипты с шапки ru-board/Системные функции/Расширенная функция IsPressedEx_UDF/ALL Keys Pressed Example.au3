#include <IsPressedEx_UDF.au3>

HotKeySet("^q", "_Quit")

$hU32_DllOpen = DllOpen("User32.dll")

While 1
	$iRet = _IsPressedEx("[:ALLKEYS:]", $hU32_DllOpen)
	
	If $iRet = 1 Then _Output_IsPressedEx_Result($iRet, @Extended)
	
	Sleep(50)
WEnd

Func _Output_IsPressedEx_Result($iRet, $iExtended)
	Local $sTT_Data = StringFormat("+ _IsPressedEx Return:\t%s\n! @Extended code:\t%i (see docs for details)", $iRet, $iExtended)
	ToolTip($sTT_Data)
EndFunc

Func _Quit()
	DllClose($hU32_DllOpen)
	Exit
EndFunc
