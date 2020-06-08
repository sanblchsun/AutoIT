#include <Array.au3>
#include <FTPEx.au3>

$sServer = ''
$sUserName = ''
$sPass = ''

$hOpen =   _FTP_Open('MyFTP Control')
$Ftp_Conn =   _FTP_Connect($hOpen, $sServer, $sUserName, $sPass)

$a_Dirs = _FTP_DirsListToArray($Ftp_Conn, "www")
_ArrayDisplay($a_Dirs)

_FTP_Close($hOpen)

Func _FTP_DirsListToArray($Ftp_Conn, $sDirName)
    Local $aSubDirsArr, $aRetArray[1]

    _FTP_DirSetCurrent($Ftp_Conn, "/" & $sDirName & "/")

    Local $aRet = _FTP_ListToArray($Ftp_Conn, 1)
    If Not IsArray($aRet) Or $aRet[0] = 0 Or ($aRet[0] = 2 And $aRet[1] = "." And $aRet[2] = "..") Then Return SetError(1, 0, 0)

    For $i = 1 To $aRet[0]
        If $aRet[$i] = "." Or $aRet[$i] = ".." Then ContinueLoop

        $aRetArray[0] += 1
        ReDim $aRetArray[$aRetArray[0]+1]
        $aRetArray[$aRetArray[0]] = $sDirName & "/" & $aRet[$i]

        $aSubDirsArr = _FTP_DirsListToArray($Ftp_Conn, $sDirName & "/" & $aRet[$i])
        If @error Then ContinueLoop

        For $j = 1 To $aSubDirsArr[0]
            $aRetArray[0] += 1
            ReDim $aRetArray[$aRetArray[0]+1]
            $aRetArray[$aRetArray[0]] = $aSubDirsArr[$j]
        Next
    Next

    Return $aRetArray
EndFunc