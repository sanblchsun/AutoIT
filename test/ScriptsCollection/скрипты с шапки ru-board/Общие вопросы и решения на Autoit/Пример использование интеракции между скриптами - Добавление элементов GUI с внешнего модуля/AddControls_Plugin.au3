#include <WindowsConstants.au3>

$hWindow = WinGetHandle("[CLASS:AutoIt v3 GUI;TITLE:_CommandsHandler_Proc]")

_AU3COM_SendData($hWindow, 'GUICtrlCreateCheckbox("Added checkbox 1", 20, 30)|GUICtrlCreateCheckbox("Added checkbox 2", 20, 50)')

Func _AU3COM_SendData($hRecvWinHandle, $sInfoToSend)
    Local $StructDef_COPYDATA = "dword var1;dword var2;ptr var3"
    Local $sCDString = DllStructCreate("char var1[256];char var2[256]") ;the array to hold the string we are sending

    DllStructSetData($sCDString, 1, $sInfoToSend)
    Local $pCDString = DllStructGetPtr($sCDString) ;the pointer to the string
    Local $vs_cds = DllStructCreate($StructDef_COPYDATA);create the message struct

    DllStructSetData($vs_cds, "var1", 0) ;0 here indicates to the receiving program that we are sending a string
    DllStructSetData($vs_cds, "var2", String(StringLen($sInfoToSend) + 1));tell the receiver the length of the string
    DllStructSetData($vs_cds, "var3", $pCDString) ;the pointer to the string

    Local $pStruct = DllStructGetPtr($vs_cds)

    DllCall("User32.dll", "int", "SendMessage", "hwnd", $hRecvWinHandle, "int", $WM_COPYDATA, "int", 0, "ptr", $pStruct)

    $vs_cds = 0 ;free the struct
    $sCDString = 0 ;free the struct

    Return 1
EndFunc