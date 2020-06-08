; Author: ProgAndy
ConsoleWrite(_BytesToBits(1024) & @CRLF)

Func _BytesToBits($bBinary) ;coded by ProgAndy

	Local $byte, $bits = "", $i, $j, $s
	#forceref $j
	For $i = 1 To BinaryLen($bBinary)
		$byte = BinaryMid($bBinary, $i, 1)
		For $j = 1 To 8
			$bits &= BitAND($byte, 1)
			$byte = BitShift($byte, 1)
		Next
	Next
	$s = StringSplit($bits, "")
	$bits = ""
	For $i = $s[0] To 1 Step -1
		$bits &= $s[$i]
	Next
	Return $bits
EndFunc   ;==>_BytesToBits