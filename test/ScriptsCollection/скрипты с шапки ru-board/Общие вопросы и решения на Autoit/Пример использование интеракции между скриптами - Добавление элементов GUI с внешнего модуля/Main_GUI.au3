#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $aRecv_Ctrls_Data[2][2]

$hGUI = GUICreate("_CommandsHandler_Proc", 200, 120)

$CheckBox = GUICtrlCreateCheckbox("Some checkbox", 20, 10)

$Check_Button = GUICtrlCreateButton("Check new controls...", 20, 80, 120, 20)

GUISetState()
GUIRegisterMsg($WM_COPYDATA, "_CommandsHandler_Proc")

While 1
    $nMsg = GUIGetMsg()

    Switch $nMsg
        Case -3
            Exit
        Case $aRecv_Ctrls_Data[1][0] To $aRecv_Ctrls_Data[$aRecv_Ctrls_Data[0][0]][0]
            Local $nCtrlID = $nMsg
            If $nCtrlID = 0 Then ContinueLoop

            ;Here you can do whatever you need with the recieved control
        Case $Check_Button
            ;Here we will check our added controls...

            Local $sMsg_Data = ""

            For $i = 1 To $aRecv_Ctrls_Data[0][0]
                $sMsg_Data &= "CtrlID: " & $aRecv_Ctrls_Data[$i][0] & ", Data[" & $aRecv_Ctrls_Data[$i][1] & "]" & @CRLF
            Next

            If $sMsg_Data = "" Then
                MsgBox(48, "Info", "There is no new added controls.", 0, $hGUI)
            Else
                MsgBox(64, "Info", "Added controls information:" & @CRLF & @CRLF & $sMsg_Data, 0, $hGUI)
            EndIf
    EndSwitch
WEnd

Func _CommandsHandler_Proc($hWnd, $iMsgID, $WParam, $LParam)
    If $iMsgID <> $WM_COPYDATA Then Return $GUI_RUNDEFMSG

    Local $sMSGRECVD = DllStructGetData(_AU3COM_RecvData($LParam), 1)
    Local $aSplit_sMSGRECVD = StringSplit($sMSGRECVD, "|")

    For $i = 1 To $aSplit_sMSGRECVD[0]
        $aRecv_Ctrls_Data[0][0] += 1
        ReDim $aRecv_Ctrls_Data[$aRecv_Ctrls_Data[0][0]+1][2]

        $aSplit_sMSGRECVD[$i] = StringReplace($aSplit_sMSGRECVD[$i], "~~", "|")

        $aRecv_Ctrls_Data[$aRecv_Ctrls_Data[0][0]][0] = Execute($aSplit_sMSGRECVD[$i])
        $aRecv_Ctrls_Data[$aRecv_Ctrls_Data[0][0]][1] = $aSplit_sMSGRECVD[$i]
    Next
EndFunc

Func _AU3COM_RecvData($iCOM_LParam)
    ; $COM_LParam = Poiter to a COPYDATA Struct
    Local $STRUCTDEF_AU3MESSAGE = "char var1[256];int"
    Local $StructDef_COPYDATA = "dword var1;dword var2;ptr var3"
    Local $vs_cds = DllStructCreate($StructDef_COPYDATA, $iCOM_LParam)
    ; Member No. 3 of COPYDATA Struct (PVOID lpData;) = Pointer to Costum Struct
    Local $vs_msg = DllStructCreate($STRUCTDEF_AU3MESSAGE, DllStructGetData($vs_cds, 3))
    Return $vs_msg
EndFunc