#include <WindowsConstants.au3>
#include "SkinH.au3"
_SkinH_Init(@ScriptDir, 0)
Global $hGui = GUICreate("Просто смени скин...", 470, 300, -1, -1, $WS_MAXIMIZEBOX + $WS_MINIMIZEBOX)
$Btn1 = GUICtrlCreateButton("Button1", 100, 110, 75, 30)
; _SkinH_Map(GUICtrlGetHandle($Btn1), $SkinH_TYPE_RADIOBUTTON)
; _SkinH_SetMenuAlpha(200)
GUISetState()

Global $msg
Do
	$msg = GUIGetMsg()
	If $msg = $Btn1 Then _SkinH_AttachEx(@ScriptDir & '\She\darkroyale.she')
Until $msg = -3

GUIDelete()
_SkinH_DeInit(1)
Exit