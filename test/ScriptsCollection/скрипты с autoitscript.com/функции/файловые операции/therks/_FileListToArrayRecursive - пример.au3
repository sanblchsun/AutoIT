#include <Array.au3>
#include <_FileListToArrayRecursive.au3>

Global $sWFile
_FileListToArrayRecursive(@DesktopDir, '*', 4, '_Callback', 'Wfile')
If @error = -1 And @extended = 42 Then
    MsgBox(0, '', 'You have a W file:' & @LF & $sWFile)
Else
    MsgBox(0, '', 'No files/folders that start with W exist.')
EndIf

Global $aReadOnly = _FileListToArrayRecursive(@DesktopDir, '*', 1+4, '_Callback', 'readonly')
Global $aEmpty = _FileListToArrayRecursive(@DesktopDir, '*', 1+4, '_Callback', 'empty')

_ArrayDisplay($aReadOnly)
_ArrayDisplay($aEmpty)

Func _Callback($aParams)
    Switch $aParams[5]
        Case 'Wfile'
            If StringLeft($aParams[2], 1) == 'W' Then
                $sWFile = $aParams[1] & $aParams[2]
                Return SetExtended(42, -1)
            EndIf
        Case 'empty'
            If Not $aParams[3] Then
                If FileGetSize($aParams[0] & $aParams[1] & $aParams[2]) Then Return 1
            EndIf
        Case 'readonly'
            If Not $aParams[3] Then
                If Not StringInStr(FileGetAttrib($aParams[0] & $aParams[1] & $aParams[2]), 'R') Then Return 1
            EndIf
    EndSwitch
EndFunc