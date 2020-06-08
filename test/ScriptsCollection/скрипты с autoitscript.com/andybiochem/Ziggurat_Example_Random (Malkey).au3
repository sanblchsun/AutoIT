#include <Array.au3>
#include "Ziggurat.au3"

Global $Array[10000], $iSum, $iSum2, $Array2[10000], $iSumDev, $iMean, $iSumDev2, $iMean2

;========== Gaussian ======================
$begin = TimerInit()
For $i = 0 To 9999
    $Array[$i] = _Random_Gaussian_Zig(0, 1)
    $iSum += $Array[$i]
Next
;_ArrayDisplay($Array,"1000 Gaussian Distribution numbers")
$iMean = $iSum / 10000
ConsoleWrite("Gaussian " & Round(TimerDiff($begin) / 1000, 4) & "secs   Mean = " & $iMean & "; s = ")
For $i = 0 To 9999
    $iSumDev += ($Array[$i] - $iMean) ^ 2
Next
ConsoleWrite(($iSumDev / 9999) ^ 0.5 & @CRLF)

;======== Random() =========================
$begin2 = TimerInit()
For $i = 0 To 9999
    $Array2[$i] = Random(-1.73, 1.73)
    $iSum2 += $Array2[$i]
Next
$iMean2 = $iSum2 / 10000
ConsoleWrite("Random() " & Round(TimerDiff($begin2) / 1000, 4) & "secs  Mean = " & $iMean2 & "; s = ")
For $i = 0 To 9999
    $iSumDev2 += ($Array2[$i] - $iMean2) ^ 2
Next
MsgBox(0,"test generator",($iSumDev2 / 9999) ^ 0.5 & @CRLF)
ConsoleWrite(($iSumDev2 / 9999) ^ 0.5 & @CRLF)
 
