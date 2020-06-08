#include <Array.au3>

;============= Example with default usage =============
$aProcListEx = _ProcessListEx()

If @error Then
    MsgBox(48, "_ProcessListEx - Error", StringFormat("There was an error to get ProcessList (@error = %i)", @error))
Else
    _ArrayDisplay($aProcListEx, "_ProcessListEx Demo (All Processes)")
EndIf
;============= Example with default usage =============

;============= Example with Resource Name usage =============
$aAutoItProcList = _ProcessListEx("CompiledScript", "AutoIt", 0)

If @error Then
    MsgBox(48, "_ProcessListEx - Error", StringFormat("There was an error to get ProcessList (@error = %i)", @error))
Else
    _ArrayDisplay($aAutoItProcList, "_ProcessListEx Demo (AutoIt Processes)")
EndIf
;============= Example with Resource Name usage =============

;===============================================================================
;
; Function Name:           _ProcessListEx()
;
; Function Description:    Gets Process List with extended info, plus can retrieve only a processes with specific resources strings.
;
; Parameter(s):            $sResourceName [Optional] - Resource name of the process filename, i.e. "CompiledScript".
;                          $sInResString [Optional] - String to check in the resource name.
;                          $iWholeWord [Optional] - Defines if the $sInResString will be compared as whole string (default is 1).
;
; Requirement(s):          None.
;
; Return Value(s):         On Success -  Return 2-dimentional array, where:
;                                                                   $aRet_List[0][0] = Total processes (array elements).
;                                                                   $aRet_List[N][0] = Process Name.
;                                                                   $aRet_List[N][1] = PID (Process ID).
;                                                                   $aRet_List[N][2] = Process File Path.
;                          On Failure -  Return '' (empty string) and set @error to:
;                                                                   1 - Unable to Open Kernel32.dll.
;                                                                   2 - Unable to Open Psapi.dll.
;                                                                   3 - No Processes Found.
;
; Author(s):               G.Sandler (a.k.a MrCreatoR) - CreatoR's Lab (http://creator-lab.ucoz.ru)
;
;=====================================================================
Func _ProcessListEx($sResourceName="", $sInResString="", $iWholeWord=1)
    Local $aProcList = ProcessList()
    Local $hKernel32_Dll = DllOpen('Kernel32.dll'), $hPsapi_Dll = DllOpen('Psapi.dll')
    Local $aOpenProc, $aProcPath, $sFileVersion, $aRet_List[1][1]

    If $hKernel32_Dll = -1 Then Return SetError(1, 0, '')

    If $hPsapi_Dll = -1 Then $hPsapi_Dll = DllOpen(@SystemDir & '\Psapi.dll')
    If $hPsapi_Dll = -1 Then $hPsapi_Dll = DllOpen(@WindowsDir & '\Psapi.dll')
    If $hPsapi_Dll = -1 Then Return SetError(2, 0, '')

    Local $vStruct      = DllStructCreate('int[1024]')
    Local $pStructPtr   = DllStructGetPtr($vStruct)
    Local $iStructSize  = DllStructGetSize($vStruct)

    For $i = 1 To UBound($aProcList)-1
        $aOpenProc = DllCall($hKernel32_Dll, 'hwnd', 'OpenProcess', _
            'int', BitOR(0x0400, 0x0010), 'int', 0, 'int', $aProcList[$i][1])

        If Not IsArray($aOpenProc) Or Not $aOpenProc[0] Then ContinueLoop

        DllCall($hPsapi_Dll, 'int', 'EnumProcessModules', _
            'hwnd', $aOpenProc[0], _
            'ptr', $pStructPtr, _
            'int', $iStructSize, _
            'int*', 0)

        $aProcPath = DllCall($hPsapi_Dll, 'int', 'GetModuleFileNameEx', _
            'hwnd', $aOpenProc[0], _
            'int', DllStructGetData($vStruct, 1), _
            'str', '', _
            'int', 2048)

        DllCall($hKernel32_Dll, 'int', 'CloseHandle', 'int', $aOpenProc[0])

        If Not IsArray($aProcPath) Or StringLen($aProcPath[3]) = 0 Then ContinueLoop

        $sFileVersion = FileGetVersion($aProcPath[3], $sResourceName)

        If $sResourceName = "" Or $sFileVersion = $sInResString Or _
            ($iWholeWord = 0 And StringInStr($sFileVersion, $sInResString)) Then

            $aRet_List[0][0] += 1
            ReDim $aRet_List[$aRet_List[0][0]+1][3]
            $aRet_List[$aRet_List[0][0]][0] = $aProcList[$i][0]     ;Process Name
            $aRet_List[$aRet_List[0][0]][1] = $aProcList[$i][1]     ;PID (Process ID)
            $aRet_List[$aRet_List[0][0]][2] = $aProcPath[3]         ;Process File Path
        EndIf
    Next

    DllClose($hKernel32_Dll)
    DllClose($hPsapi_Dll)

    If $aRet_List[0][0] < 1 Then Return SetError(3, 0, '')
    Return $aRet_List
EndFunc