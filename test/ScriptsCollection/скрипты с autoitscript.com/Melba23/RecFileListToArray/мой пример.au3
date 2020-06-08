
#include <Array.au3>
#include "RecFileListToArray.au3"

$timer = TimerInit()
; путь | расширения | 1-только файлы | 1- подпапки (рекурсия) | 1- сортировка | 1-относительный путь | исключить расширения

; $aArray = _RecFileListToArray('C:\WINDOWS\system32', "*", 2, 1, 0, 2) ;  только папки
; $aArray = _RecFileListToArray('C:\', "*", 1, 0, 0, 2) ;  только файлы в корне диска С
$aArray = _RecFileListToArray(@WindowsDir, "*", 1, 1, 0, 2) ;  только файлы
$timer = Round(TimerDiff($timer) / 1000, 2) & ' сек'
_ArrayDisplay($aArray, $timer)

