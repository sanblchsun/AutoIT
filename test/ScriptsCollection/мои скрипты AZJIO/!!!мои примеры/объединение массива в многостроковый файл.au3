Exit ; только для чтения

;вариант1
; по примеру из справки
For $element IN $aRegfileT1 ; объединение массива в многостроковый файл
    $regfileT1&=$element&@CRLF
Next

; по своему примеру
For $i = 0 to UBound($aRegfileT1) - 1 ; объединение массива в многостроковый файл
$regfileT1&=$aRegfileT1[$i]&@CRLF
Next