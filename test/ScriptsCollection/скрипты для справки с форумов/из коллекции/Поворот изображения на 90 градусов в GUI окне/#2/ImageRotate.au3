#include <GDIPlus.au3>

_GDIPlus_Startup ()
$hImage = _GDIPlus_ImageLoadFromFile (@ScriptDir & "\arrow.jpg")
$sCLSID = _GDIPlus_EncodersGetCLSID ("JPG")
$tData = DllStructCreate("int Data")
DllStructSetData($tData, "Data", $GDIP_EVTTRANSFORMROTATE90)
$tParams = _GDIPlus_ParamInit (1)
_GDIPlus_ParamAdd ($tParams, $GDIP_EPGTRANSFORMATION, 1, $GDIP_EPTLONG, DllStructGetPtr($tData, "Data"))
_GDIPlus_ImageSaveToFileEx ($hImage, @ScriptDir & "\arrow1.jpg", $sCLSID, DllStructGetPtr($tParams))


$Form1 = GUICreate("Form1", 236, 133, 573, 455)
$Pic1 = GUICtrlCreatePic(@ScriptDir & "\arrow.jpg", 16, 16, 100, 100)
$Pic2 = GUICtrlCreatePic(@ScriptDir & "\arrow1.jpg", 120, 16, 100, 100)
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case -3
			_GDIPlus_ShutDown ()
			Exit
	EndSwitch
WEnd







