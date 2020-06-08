
; amel27
; http://forum.oszone.net/post-1233240.html#post1233240


#Include <File.au3>

$sRoot = "C:\AutoIt3-2"

ProgressOn ("Поиск пустых папок", "Подготовка к поиску...")
Global $iCNT = 0, $iDEL = 0, $aRoot = DirGetSize($sRoot, 1)

$aRoot[2]+=1
_DirRemoveEmpty($sRoot)

ProgressOff()
MsgBox(64, "Поиск пустых папок", "Поиск завершен"&@CRLF&@CRLF&"Папок ВСЕГО: "&@TAB&$iCNT&@CRLF&"Папок удалено: "&@TAB&$iDEL)

Func _DirRemoveEmpty($sDIR)
    Local $iPRC, $aDIR = _FileListToArray($sDIR,'*', 2)

    If IsArray($aDIR) Then
        For $i=1 To $aDIR[0]
            $iDEL += _DirRemoveEmpty($sDIR &"\"& $aDIR[$i])
        Next
    EndIf

    $iCNT +=1
    $iPRC = Int($iCNT*100/$aRoot[2])
    ProgressSet($iPRC, "Обработано папок: "&$iCNT&@TAB&@TAB&" Удалено: "&$iDEL, $sDIR)

    If DirGetSize($sDIR)=0 Then $iDEL += DirRemove($sDIR)
EndFunc