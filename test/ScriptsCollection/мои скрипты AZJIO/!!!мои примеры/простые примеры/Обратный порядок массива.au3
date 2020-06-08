
#include <Array.au3>

Global $h[5]=[4,1,2,3, 4]

_ArrayDisplay( $h, "��������" )
$h=_ArrBackOrderS($h)
_ArrayDisplay( $h, "�������� ������� ��� StringSplit" )
$h=_ArrBackOrderU($h)
_ArrayDisplay( $h, "�������� ������� ��� UBound" )

Func _ArrBackOrderS($a)
	Local $b[$a[0]+1]
	$b[0]=$a[0]
	$a[0]+=1
	For $i = 1 to $a[0]-1
		$b[$i]=$a[$a[0]-$i]
	Next
    return $b
EndFunc

Func _ArrBackOrderU($a)
	Local $k=UBound($a), $b[$k]
	$k-=1
	For $i = 0 to $k
		$b[$i]=$a[$k-$i]
	Next
    return $b
EndFunc