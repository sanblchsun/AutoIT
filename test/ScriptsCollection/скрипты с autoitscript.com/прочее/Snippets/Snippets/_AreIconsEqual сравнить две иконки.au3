;#### Example ####
#include <WinAPI.au3>
#include <Constants.au3>

;get handles to two icons
;Change the numberss 3 or load an icon from another source
$sModule = @SystemDir & "\shell32.dll"
$hModule = _WinAPI_GetModuleHandle($sModule)
$hmyIcon1 = _WinAPI_LoadImage($hModule, 3, $IMAGE_ICON, 0, 0, 0)
$hmyIcon2 = _WinAPI_LoadImage($hModule, 3, $IMAGE_ICON, 0, 0, 0)

$bEqual = _AreIconsEqual($hmyIcon1, $hmyIcon2)
If @error Then
   Exit MsgBox(0, "Error", @error)
EndIf
MsgBox(0, "Icons Equal", $bEqual)

;Checks if two Icons are the same.
Func _AreIconsEqual($hicon1, $hicon2)
   Local $aRtn = DllCall("shlwapi.dll", "BOOL", 548, "handle", $hicon1, "handle", $hicon2)
   If @error Then
     Return SetError(@error)
   EndIf
   Return $aRtn[0]
EndFunc   ;==>_AreIconsEqual