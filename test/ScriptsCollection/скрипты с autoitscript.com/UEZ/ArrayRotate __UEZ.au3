; UEZ
; http://www.autoitscript.com/forum/topic/137523-convert-array/#entry962953
#include <array.au3>

Global $aTest[4][3] = [ [1, 2, 3], _
                                        [4, 5, 6], _
                                        [7, 8, 9], _
                                        [10, 11, 12]]

$aRot = ArrayRotate($aTest, 90)
_ArrayDisplay($aRot)

$aRot = ArrayRotate($aTest, 180)
_ArrayDisplay($aRot)

Func ArrayRotate($aArray, $iDeg) ;coded by UEZ 2012 build 2012-02-15
    If Not IsArray($aArray) Then Return SetError(1, 0, 0) ;not an array
    If Not UBound($aArray, 0) = 2 Then Return SetError(2, 0, 0) ;not a 2D array
    If Mod($iDeg, 90) Then Return SetError(3, 0, 0) ;only 90° rotations allowed
    Local $i, $j, $k = 0, $l = 0
    Switch $iDeg
        Case 90, -270
            Local $aRotated[UBound($aArray, 2)][UBound($aArray)]
            For $i = 0 To UBound($aArray, 2) - 1
                For $j = UBound($aArray) -1 To 0 Step - 1
                    $aRotated[$i][$k] = $aArray[$j][$i]
                    $k += 1
                Next
                $k = 0
            Next
            Return $aRotated
        Case 270, -90
            Local $aRotated[UBound($aArray, 2)][UBound($aArray)]
            For $i = UBound($aArray, 2) - 1 To 0 Step - 1
                For $j = 0 To UBound($aArray) - 1
                    $aRotated[$l][$k] = $aArray[$j][$i]
                    $k += 1
                Next
                $l += 1
                $k = 0
            Next
            Return $aRotated
        Case 180, -180
            Local $aRotated[UBound($aArray)][UBound($aArray, 2)]
            For $i = UBound($aArray) - 1 To 0 Step - 1
                For $j = UBound($aArray, 2) - 1 To 0 Step - 1
                    $aRotated[$l][$k] = $aArray[$i][$j]
                    $k += 1
                Next
                $l += 1
                $k = 0
            Next
            Return $aRotated
    EndSwitch
EndFunc