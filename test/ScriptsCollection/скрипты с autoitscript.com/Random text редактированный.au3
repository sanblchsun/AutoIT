; http://www.autoitscript.com/forum/topic/96701-random-text/#entry770204
Global $temp
While 1
	MsgBox(0, "рандом", _RandomText(10))
WEnd

Func _RandomText($length)
    Local $text = "", $temp
    For $i = 1 To $length
        $temp = Random(55, 116, 1)
        $text&= Chr($temp+6*($temp>90)-7*($temp<65))
    Next
    Return $text
EndFunc   ;==>_RandomText