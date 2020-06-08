

#include <Array.au3>

Global $arr[256][2]

For $i = 0 To 255
	$arr[$i][0]=String(Chr($i))
	$arr[$i][1]=$i
Next
; _ArrayDisplay($arr, 'Array')
_ArraySort($arr)

For $i = 0 To 254
	If $arr[$i][0]=$arr[$i+1][0] Then
		$arr[$i][0]&=$arr[$i+1][0]
		$arr[$i][1]&=','&$arr[$i+1][1]
		$arr[$i+1][0]=''
		$arr[$i+1][1]=''
	EndIf
Next

$k=0
For $i = 0 To 255
	If Not($arr[$i][1]=='') Then
		$arr[$k][0]=$arr[$i][0]
		$arr[$k][1]=$arr[$i][1]
		$k+=1
	EndIf
Next
ReDim $arr[$k][2]

_ArrayDisplay($arr, 'Лексикографический порядок')

; If '_'<'=' Then MsgBox(0, 'Сообщение', 'Да')