Global $Path = @ScriptDir & '\color.bmp'
Global $w = 120
Global $h = 104 

$X1 = 0
$Y1 = 0
$X2 = $X1+$w-1
$Y2 = $Y1+$h-1

$Timer=TimerInit()
_BMPFiller($X1, $X2, $Y1, $Y2)
MsgBox(0, 'Таймер', 'Выполнено за '&Round(TimerDiff($timer), 1)&' мсек')

Func _BMPFiller($X1, $X2, $Y1, $Y2)
    $imsize = ($w * 3 + Mod($w, 4)) * $h
	$data="0x424D"&FixFormat(Hex($imsize+54,8))&"000000003600000028000000"&FixFormat(Hex($w,8)) & _
	FixFormat(Hex($h,8))&"0100180000000000"&FixFormat(Hex($imsize,8))&"00000000000000000000000000000000"
	$dl=''
	If Mod($w, 4) > 0 Then
		For $i = 1 to Mod($w, 4)
			$dl &='00'
		Next
	EndIf
    For $j = $Y2 to $Y1 Step -1
        For $i = $X1 to $X2
            $data &= StringTrimRight(StringTrimLeft(Binary(PixelGetColor($i, $j)), 2), 2)
        Next
		$data &= $dl
    Next
	$file = FileOpen($Path,16 + 2)
	FileWrite($file, Binary($data))
	FileClose($file)
EndFunc

Func FixFormat($HexData)
    Local $i,$Value=""
    For $i=7 To 1 Step -2
        $Value &= StringMid($HexData,$i,2)
    Next
    Return ($Value)
EndFunc