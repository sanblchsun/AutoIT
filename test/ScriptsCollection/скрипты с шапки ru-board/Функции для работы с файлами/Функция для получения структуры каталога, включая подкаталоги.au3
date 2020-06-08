#include <Array.au3>

;Папка аутоита
$AutoItPath = StringRegExpReplace(@AutoItExe, '\\[^\\]+$', '')

$DirsArray = DirListToArray($AutoItPath)
_ArrayDisplay($DirsArray)

Func DirListToArray($sPath, $sRootPath=1)
    $sPath = StringRegExpReplace($sPath, '\\+$', '')
    Local $aRetArray[1], $aSubDirsArr, $sFindNextFile, $sCurrentPath

    Local $sFindFirstFile = FileFindFirstFile($sPath & "\*.*")
    If @error = 1 Then Return SetError(1, 0, -1)

    If $sRootPath = 1 Then
        ReDim $aRetArray[2]
        $aRetArray[1] = $sPath
    EndIf

    While 1
        $sFindNextFile = FileFindNextFile($sFindFirstFile)
        If @error = 1 Then ExitLoop

        $sCurrentPath = $sPath & "\" & $sFindNextFile

        If StringInStr(FileGetAttrib($sCurrentPath), "D") Then
            $aRetArray[0] += 1
            ReDim $aRetArray[$aRetArray[0]+1]
            $aRetArray[$aRetArray[0]] = $sCurrentPath

            $aSubDirsArr = DirListToArray($sCurrentPath, 0)

            If IsArray($aSubDirsArr) Then
                For $i = 1 To $aSubDirsArr[0]
                    $aRetArray[0] += 1
                    ReDim $aRetArray[$aRetArray[0]+1]
                    $aRetArray[$aRetArray[0]] = $aSubDirsArr[$i]
                Next
            EndIf
        EndIf
    WEnd

    FileClose($sFindFirstFile)

    Return $aRetArray
EndFunc