#RequireAdmin ;это для Win 7
#include <File.au3>
#include <Array.au3>

;$Time = TimerInit()
$sFolder = @WindowsDir & '\inf\'
$sFileResult = @ScriptDir & '\FromINF.txt'
$sWhatFind = 'PCI\VEN'
Dim $aFind[1]
$z = 0

$aInfFiles = _FileListToArray($sFolder, '*.inf', 1)
For $i = 1 To $aInfFiles[0]
    $hFile = FileOpen($sFolder & $aInfFiles[$i], 0)
    $sText = FileRead($hFile)
    FileClose($hFile)
    $aTextTemp = StringRegExp($sText, '(\Q' & $sWhatFind & '\E.*?)\.', 3)
    If IsArray($aTextTemp) Then
        $aTextTemp = _ArrayUnique($aTextTemp)
        For $j = 1 To $aTextTemp[0]
            $z += 1
            ReDim $aFind[$z + 1]
            $aFind[$z] = StringReplace(StringStripWS($aTextTemp[$j], 7), @TAB, '') & _
                    ' >>>> INF File: ' & $sFolder & $aInfFiles[$i]
            Sleep(1)
        Next
    EndIf
    Sleep(1)
Next
$aFind[0] = 'Найдено ' & UBound($aFind) - 1 & ' записей.'
;MsgBox(0, '', Round(TimerDiff($Time) / 1000, 2) & " секунд.")
;_ArrayDisplay($aFind)
_FileWriteFromArray($sFileResult, $aFind)