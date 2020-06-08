; Author: Jos
; Check File Date To Current Date

#include<date.au3>
$n_tFile = "your file name"
$n_Fdate = FileGetTime($n_tFile, 1)
$sdate = $n_Fdate[0] & "/" & $n_Fdate[1] & "/" & $n_Fdate[2] & " " & $n_Fdate[3] & ":" & $n_Fdate[4] & ":" & $n_Fdate[5]
$edate = _NowCalc()
If _DateDiff('d', $sdate, $edate) > 5 Then
	;
EndIf