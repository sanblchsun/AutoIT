#include <Array.au3>

Run(@WindowsDir & "\Notepad.exe")
WinWait("[CLASS:Notepad]")

$aHandles = _WinGetCtrlHandlesList("[CLASS:Notepad]")

_ArrayDisplay($aHandles, "Notepad's Control's Handles List")

Func _WinGetCtrlHandlesList($sTitle, $sText="")
    Local $aRetHandles[1][1]
    Local $aClassList = StringSplit(_WinGetNumeratedClassList($sTitle), @CRLF, 1)

    For $i = 1 To $aClassList[0]
        $aRetHandles[0][0] += 1
        ReDim $aRetHandles[$aRetHandles[0][0]+1][2]

        $aRetHandles[$aRetHandles[0][0]][0] = $aClassList[$i]
        $aRetHandles[$aRetHandles[0][0]][1] = ControlGetHandle($sTitle, "", $aClassList[$i])
    Next

    Return $aRetHandles
EndFunc

Func _WinGetNumeratedClassList($sTitle, $sText="")
    Local $sClassList = WinGetClassList($sTitle, $sText)
    Local $aClassList = StringSplit($sClassList, @CRLF)
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

            $sRetClassList &= $aClassList[$i] & @CRLF
        Else
            $aClassList[$i] &= "~1"
            $sHold_List &= $aClassList[$i] & "|"
            $sRetClassList &= $aClassList[$i] & @CRLF
        EndIf
    Next

    Return StringReplace(StringStripWS($sRetClassList, 3), "~", "")
EndFunc