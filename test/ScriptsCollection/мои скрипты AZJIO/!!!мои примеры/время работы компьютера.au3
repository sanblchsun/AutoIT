#include <Date.au3>
MsgBox(0, 'Время работы компьютера', _TimeGetWorkPC())
Func _TimeGetWorkPC()
	Local $d=0, $h=0, $m=0, $c=0, $tmp
	$a=Int(_Date_Time_GetTickCount()/1000)
	__Conv($a, $d, 86400)
	__Conv($a, $h, 3600)
	__Conv($a, $m, 60)
	$c=$a
	Return StringFormat("%02d %02d:%02d:%02d", $d, $h, $m, $c)
EndFunc
Func __Conv(ByRef $a, ByRef $v, $z)
	If $a>=$z Then
		$tmp=Mod($a, $z)
		$v=($a-$tmp)/$z
		$a=$tmp
	EndIf
EndFunc