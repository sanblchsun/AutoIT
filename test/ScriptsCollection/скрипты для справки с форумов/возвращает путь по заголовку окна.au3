#Include <WinAPIEx.au3> 
 
$Id = WinGetProcess("Title") 
MsgBox(0, "", $Id) 
If $Id > 0 Then 
    MsgBox(0, "", _WinAPI_GetModuleFileNameEx($Id)) 
Else 
    MsgBox(0, "","NO") 
EndIf 