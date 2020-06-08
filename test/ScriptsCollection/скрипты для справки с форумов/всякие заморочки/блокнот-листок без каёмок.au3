#include <GuiConstants.au3> 
#include <WindowsConstants.au3> 
; 
 
$Main_Gui = GUICreate("", 400, 400, 20, 20, $WS_POPUP, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST) 
 
$But1 = GUICtrlCreateButton(" Exit ", 100, 100, 80, 21) 
$Info_Edit = GUICtrlCreateEdit("A few words to start off with", 80, 150, 300, 220) 
 
_GUISetControlsVisible($Main_Gui) 
 
GUISetState() 
 
While 1 
    $nMsg = GUIGetMsg() 
 
    Switch $nMsg 
        Case $GUI_EVENT_CLOSE, $But1 
            Exit 
    EndSwitch 
WEnd 
 
Func _GUISetControlsVisible($hWnd) 
    Local $aClassList, $aM_Mask, $aCtrlPos, $aMask 
 
    $aClassList = StringSplit(_WinGetClassListEx($hWnd), @LF) 
    $aM_Mask = DllCall("gdi32.dll", "long", "CreateRectRgn", "long", 0, "long", 0, "long", 0, "long", 0) 
 
    For $i = 1 To UBound($aClassList) - 1 
        $aCtrlPos = ControlGetPos($hWnd, '', $aClassList[$i]) 
        If Not IsArray($aCtrlPos) Then ContinueLoop 
 
        $aMask = DllCall("gdi32.dll", "long", "CreateRectRgn", _ 
            "long", $aCtrlPos[0], _ 
            "long", $aCtrlPos[1], _ 
            "long", $aCtrlPos[0] + $aCtrlPos[2], _ 
            "long", $aCtrlPos[1] + $aCtrlPos[3]) 
        DllCall("gdi32.dll", "long", "CombineRgn", "long", $aM_Mask[0], "long", $aMask[0], "long", $aM_Mask[0], "int", 2) 
    Next 
    DllCall("user32.dll", "long", "SetWindowRgn", "hwnd", $hWnd, "long", $aM_Mask[0], "int", 1) 
EndFunc 
 
Func _WinGetClassListEx($sTitle) 
    Local $sClassList = WinGetClassList($sTitle) 
    Local $aClassList = StringSplit($sClassList, @LF) 
    Local $sRetClassList = "", $sHold_List = "|" 
    Local $aiInHold, $iInHold 
 
    For $i = 1 To UBound($aClassList) - 1 
        If $aClassList[$i] = "" Then ContinueLoop 
 
        If StringRegExp($sHold_List, "\|" & $aClassList[$i] & "~(\d+)\|") Then 
            $aiInHold = StringRegExp($sHold_List, ".*\|" & $aClassList[$i] & "~(\d+)\|.*", 1) 
            $iInHold = Number($aiInHold[UBound($aiInHold)-1]) 
 
            If $iInHold = 0 Then $iInHold += 1 
 
            $aClassList[$i] &= "~" & $iInHold + 1 
            $sHold_List &= $aClassList[$i] & "|" 
 
            $sRetClassList &= $aClassList[$i] & @LF 
        Else 
            $aClassList[$i] &= "~1" 
            $sHold_List &= $aClassList[$i] & "|" 
            $sRetClassList &= $aClassList[$i] & @LF 
        EndIf 
    Next 
 
    Return StringReplace(StringStripWS($sRetClassList, 3), "~", "") 
EndFunc 