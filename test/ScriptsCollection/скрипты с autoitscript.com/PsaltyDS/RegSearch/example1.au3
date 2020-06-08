#include <Array.au3>; Only for _ArrayDisplay() in demo
#include <_RegSearch.au3>
$SearchKey = "HKLM\SOFTWARE\AutoIt v3"

; Find only values, return as an array
$SearchString = "*" ; find all values
$Timer = TimerInit()
$Results = _RegSearch($SearchKey, $SearchString, 2, 1)
$Timer = TimerDiff($Timer) / 1000
_ArrayDisplay($Results, "Results (data only) in " & $Timer & " seconds")

; Find only values, by RegExp, return as an array
$SearchString = "(?<=Install)Dir" ; find "Dir", only where preceded by "Install", using a RegExp look-behind assertion
$Timer = TimerInit()
$Results = _RegSearch($SearchKey, $SearchString, 2+8, 1)
$Timer = TimerDiff($Timer) / 1000
_ArrayDisplay($Results, "Results (data only) in " & $Timer & " seconds")