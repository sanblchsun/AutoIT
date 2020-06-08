#include <GUIConstants.au3>

GUICreate("Test",500,80)
$info_text = GUICtrlCreateLabel("",10,10,480,60)
GUISetState()

Global $found = ""

SearchReg("HKCU","Version")
;SearchReg("HKLM","ProductName")
GUIDelete()

Msgbox(0,"",$found)

Exit


;*****************************************************
; Recursive search-function
;*****************************************************

Func SearchReg($startkey,$searchval)
    Local $val,$i,$key,$z
    
    $i = 1
    While 1
        $key = RegEnumKey($startkey,$i)
        If @error <> 0 Then ExitLoop
        ; GUICtrlSetData($info_text,$startkey & "\" & $key)
        $z = 1
        While 1
            $val = RegEnumVal($startkey & "\" & $key,$z)
            If @error <> 0 Then ExitLoop
            If StringInStr($val,$searchval) Then $found = $found & "ValueName, " & $startkey & "\" & $key & ", " & $val & @LF
            $readval = RegRead($startkey & "\" & $key,$val)
            If $readval <> "" And StringInStr($readval,$searchval) Then $found = $found & "Value, " & $startkey & "\" & $key & ", " & $val & ", " & $readval & @LF
            $z = $z + 1
        WEnd
        SearchReg($startkey & "\" & $key,$searchval)
        $i = $i + 1
    WEnd
;Sleep(1); just 1 idle milli second -> not used at the moment
EndFunc