#NoTrayIcon
#include <GuiConstants.au3>
;

RegisterScriptMsg("SendMessage Test", $CmdLineRaw)

$Gui = GUICreate("SendMessage Test")
GUISetState()

While 1
    $Msg = GUIGetMsg()
    Switch $Msg
        Case -3
            Exit
    EndSwitch
WEnd

Func Main_Msg_Function($vsMsg)
    MsgBox(0, "", "Recieved message:" & @LF & @LF & $vsMsg)
    ;Exit
EndFunc

;=====================================
Func RegisterScriptMsg($sTitle, $vMsg)
    Local $OccurName = StringReplace(@ScriptFullPath, "\", "")
    Local $ERROR_ALREADY_EXISTS = 183

    Local $ihWnd = WinGetHandle($sTitle)

    Local $hDll = DllCall("kernel32.dll", "int", "CreateMutex", "int", 0, "long", 1, "str", $OccurName)
    Local $iLastError = DllCall("kernel32.dll", "int", "GetLastError")
    If $iLastError[0] = $ERROR_ALREADY_EXISTS Then
        _AU3COM_SendData($vMsg, $ihWnd)
        Exit
    Else
        Local Const $WM_COPYDATA = 0x4A
        GUIRegisterMsg($WM_COPYDATA, "_GUIRegisterMsgProc")
    EndIf
EndFunc

Func _GUIRegisterMsgProc($hWnd, $MsgID, $WParam, $LParam)
    Local Const $WM_COPYDATA = 0x4A

    If $MsgID = $WM_COPYDATA Then
        Local $vsMsg = _AU3COM_RecvData($LParam)
        Local $MSGRECVD = DllStructGetData($vsMsg, 1)
        ;Here is go whatever we need to do with the recieved string ($MSGRECVD)
        Call("Main_Msg_Function", $MSGRECVD)
    EndIf
EndFunc

Func _AU3COM_SendData($InfoToSend, $RecvWinHandle)
    Local Const $WM_COPYDATA = 0x4A
    Local $StructDef_COPYDATA = "dword var1;dword var2;ptr var3"
    Local $CDString = DllStructCreate("char var1[256];char var2[256]") ;the array to hold the string we are sending

    DllStructSetData($CDString, 1, $InfoToSend)
    Local $pCDString = DllStructGetPtr($CDString) ;the pointer to the string
    Local $vs_cds = DllStructCreate($StructDef_COPYDATA);create the message struct
    DllStructSetData($vs_cds, "var1", 0) ;0 here indicates to the receiving program that we are sending a string
    DllStructSetData($vs_cds, "var2", String(StringLen($InfoToSend) + 1));tell the receiver the length of the string
    DllStructSetData($vs_cds, "var3", $pCDString) ;the pointer to the string
    Local $pStruct = DllStructGetPtr($vs_cds)
    DllCall("user32.dll", "long", "SendMessage", "hwnd", $RecvWinHandle, "int", $WM_COPYDATA, "int", 0, "int", $pStruct)

    $vs_cds = 0 ;free the struct
    $CDString = 0 ;free the struct

    Return 1
EndFunc

Func _AU3COM_RecvData($COM_LParam)
    ; $COM_LParam = Poiter to a COPYDATA Struct
    Local $STRUCTDEF_AU3MESSAGE = "char var1[256];int"
    Local $StructDef_COPYDATA = "dword var1;dword var2;ptr var3"
    Local $vs_cds = DllStructCreate($StructDef_COPYDATA, $COM_LParam)
    ; Member No. 3 of COPYDATA Struct (PVOID lpData;) = Pointer to Costum Struct
    Local $vs_msg = DllStructCreate($STRUCTDEF_AU3MESSAGE, DllStructGetData($vs_cds, 3))
    Return $vs_msg
EndFunc