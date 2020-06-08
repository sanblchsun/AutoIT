#include-once
; ----------------------------------------------------------------------------
;
; AutoIt Version: 3.3.6.1
; Author:         Evilertoaster <evilertoaster at yahoo dot com>
;
; Script Function:
;	Basic BMP file managment.
;Script Version:
;   3.3
; ----------------------------------------------------------------------------

; #FUNCTION# ====================================================================================================================
; Name...........: _BMPCreate
; Description ...: Creates a BMP 'Handle' to be used in later functions. The BMP dimensions will be decided by the parameters.
; Syntax.........: _BMPCreate($Width,$Height)
; Parameters ....: $Width  - "" in pixels
;                  $Height - "" in pixels
; Return values .: Success - A BMP handle
; #FUNCTION# ====================================================================================================================
Func _BMPCreate ($Width,$Height)
	Local $c=Mod($Width,4)
	Local $d=Binary("")
	if $c=3 then $d=Binary("0x000000")
	if $c=2 then $d=Binary("0x0000")
	if $c=1 then $d=Binary("0x00")
														;***BMP header (54bytes total)***
	Local $Header=Binary("0x424D"& _    				;2bytes, BM signature
						"00000000"& _					;4bytes, filesize (optional, omitted)
						"0000"& _						;2bytes, reserved
						"0000"& _						;2bytes, reserved
						"36000000"& _					;4bytes, offset to image data
						"28000000"& _					;4bytes, BITMAPINFOHEADER
						_Reverse8(Hex($Width,8))& _		;4bytes, bitmap width
						_Reverse8(Hex($Height,8))& _	;4bytes, bitmap hieght
						"0100"& _						;2bytes, bitmap planes
						"1800"& _						;2bytes, bitmap bitdepth
						"00000000"& _					;4bytes, bitmap compression type (none)
						_Reverse8(Hex(($Height)* _
						($Width)*3+($Height*$c),8))& _	;4bytes, bitmap data size
						"00000000"& _					;4bytes, bitmap horizontal resolution (optional,omitted)
						"00000000"& _					;4bytes, bitmap vertical resolution (optional,omitted)
						"00000000"& _					;4bytes, bitmap colors (optional?, omitted)
						"00000000")						;4bytes, important colors (optional?, omitted)
														;***End Header***
	Local $rowData=Binary("")
	Local $imageData=Binary("")
	for $n=1 to $Width
		$rowData&=Binary("0xFFFFFF")
	Next
	$rowData&=$d
	for $m=1 to $Height
		$imageData&=$rowData
	Next
	Local $binaryData=$Header&$imageData
	Local $BMPHandle[4]
	$BMPHandle[0]=$c
	$BMPHandle[1]=$Width
	$BMPHandle[2]=$Height
	$BMPHandle[3]=DllStructCreate('ubyte['&BinaryLen($binaryData)&']')
	DllStructSetData($BMPHandle[3],1,$binaryData)
	Return $BMPHandle
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _BMPOpen
; Description ...: Creates a BMP 'Handle' from a BMP file.
; Syntax.........: _BMPOpen($Path)
; Parameters ....: $Path - Path to the file
; Return values .: Success - A BMP handle
;                  Failure - -1: FileOpen() returned -1
;							 -2: Not a valid BMP file header
;							 -3: BMP file header has invalid hieght or width specified
; #FUNCTION# ====================================================================================================================
Func _BMPOpen($Path,$Progress=1)
	Local $Bpath=FileOpen($Path,16)
	If $Bpath=-1 then Return -1
	$AllOf=FileRead($Bpath)
	FileClose($Bpath)
	If BinaryMid($AllOf,1,2)<>"0x424D" then Return -2
	$x=Dec(_Reverse8(Hex(BinaryMid($AllOf,19,4))))
	$y=Dec(_Reverse8(Hex(BinaryMid($AllOf,23,4))))
	if $x=0 or $y=0 then Return -3
	for $c=$x to 0 step -4
		if $c<4 then ExitLoop
	Next
	Local $BMPHandle[4]
	$BMPHandle[0]=$c
	$BMPHandle[1]=$x
	$BMPHandle[2]=$y
	$BMPHandle[3]=DllStructCreate('ubyte['&BinaryLen($AllOf)&']')
	DllStructSetData($BMPHandle[3],1,$AllOf)
	return $BMPHandle
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _PixelRead
; Description ...: Returns the color at the pixel coordinate and BMPHandle given.
; Syntax.........: _PixelRead($BMPHandle,$X,$Y)
; Parameters ....: $BMPHandle - ""
;				   $X		  - X coordinate of the pixel	
;				   $Y		  - ""
; Return values .: Success -  A Color as a hex string in RRGGBB format
; #FUNCTION# ====================================================================================================================
Func _PixelRead(ByRef $BMPHandle,$x,$y)
	If IsArray($BMPHandle)=False or $x>$BMPHandle[1]-1 Or $x<0 Or $y>$BMPHandle[2]-1 Or $y<0 Then Return 0
	local $offset = _ChordToOffset($x,$y,$BMPHandle)
	Return hex(DllStructGetData($BMPHandle[3],1,$offset+3),2)&hex(DllStructGetData($BMPHandle[3],1,$offset+2),2)&hex(DllStructGetData($BMPHandle[3],1,$offset+1),2)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _PixelWrite
; Description ...: Writes the color to the pixel coordinate and BMPHandle given.
; Syntax.........: _PixelWrite($BMPHandle,$X,$Y,$Color)
; Parameters ....: $BMPHandle - ""
;				   $X		  - X coordinate of the pixel	
;				   $Y		  - ""
;				   $Color	  - A Color as a hex string in RRGGBB format (e.g. "AAFF00")
; Return values .: Success -  Returns 1
; #FUNCTION# ====================================================================================================================
Func _PixelWrite(ByRef $BMPHandle,$x,$y,$color)
	If $x>$BMPHandle[1]-1 Or $x<0 Or $y>$BMPHandle[2]-1 Or $y<0 or StringLen($color)<>6 Then Return 0
	local $offset = _ChordToOffset($x,$y,$BMPHandle)
	DllStructSetData($BMPHandle[3],1,dec(StringLeft($color,2)),$offset+3)
	DllStructSetData($BMPHandle[3],1,dec(stringmid($color,3,2)),$offset+2)
	DllStructSetData($BMPHandle[3],1,dec(StringRight($color,2)),$offset+1)
	Return 1
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _BMPWrite
; Description ...: Writes the BMP Handle $BMPHandle to the file path $Fpath.
; Syntax.........: _BMPWrite($BMPHandle,$Fpath)
; Parameters ....: $BMPHandle - ""
;				   $Fpath 	  - Path to the file;				   
; Return values .: Success - Returns 1
;                  Failure - -1: FileOpen() returned -1
; #FUNCTION# ====================================================================================================================
Func _BMPWrite(ByRef $BMPHandle,$Fpath)
	if IsArray($BMPHandle)=False then Return 0
	$out=FileOpen($Fpath,18)
	if $out=-1 then return -1
	FileWrite($out,DllStructGetData($BMPHandle[3],1))
	FileClose($out)
	Return 1
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _BMPGetWidth
; Description ...: Returns the width in pixels of the BMP. Same as $BMPHandle[1].
; Syntax.........: _BMPGetWidth($BMPHandle)
; Parameters ....: $BMPHandle - ""
; #FUNCTION# ====================================================================================================================
Func _BMPGetWidth(ByRef $BMPHandle)
	If IsArray($BMPHandle)=0 Then Return 0
	Return $BMPHandle[1]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _BMPGetHeight
; Description ...: Returns the Height in pixels of the BMP. Same as $BMPHandle[2].
; Syntax.........: _BMPGetHeight($BMPHandle)
; Parameters ....: $BMPHandle - ""
; #FUNCTION# ====================================================================================================================
Func _BMPGetHeight(ByRef $BMPHandle)
	If IsArray($BMPHandle)=0 Then Return 0
	Return $BMPHandle[2]
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _PixelFill
; Description ...: Does a paint "fill" effect on the given pixel with the given color. It will also shade in pixels within the 
; 				   given shade variation (defualt 0 is exact match for pixel color, 1 would allow 1 shade lighter or darker than
;				   the starting pixel ect.).
; Syntax.........: _PixelFill($BMPHandle,$x,$y,$color[,$variation=0])
; Parameters ....: $BMPHandle,$x,$y,$color see _PixelWrite()
; Return values .: Success - Returns the number of pixels filled
; #FUNCTION# ====================================================================================================================
Func _PixelFill(ByRef $BMPHandle,$x,$y,$color,$variation=0)
	Local $CheckChart[UBound($BMPHandle,1)][UBound($BMPHandle,2)]
	Local $count=0
	$Tset=1
	Local $tracer[$Tset]
	$tracer[$tset-1]=$x&","&$y
	Local $CheckColor=Dec(_PixelRead($BMPHandle,$x,$y))
	$CheckChart[$y][$x]=1
	While 1
		if Abs(Dec(_PixelRead($BMPHandle,$x-1,$y))-$CheckColor)<=$variation Then
			$CheckChart[$x-1][$y]=1
			$count+=1
			_PixelWrite($BMPHandle,$x-1,$y,$color)
			$Tset+=1
			ReDim $tracer[$Tset]
			$tracer[$Tset-1]=$x&","&$y
			$x=$x-1
			ContinueLoop
		EndIf
		if Abs(Dec(_PixelRead($BMPHandle,$x,$y-1))-$CheckColor)<=$variation Then
			$CheckChart[$x][$y-1]=1
			$count+=1
			_PixelWrite($BMPHandle,$x,$y-1,$color)
			$Tset+=1
			ReDim $tracer[$Tset]
			$tracer[$Tset-1]=$x&","&$y
			$y=$y-1
			ContinueLoop
		EndIf
		if Abs(Dec(_PixelRead($BMPHandle,$x+1,$y))-$CheckColor)<=$variation Then
			$CheckChart[$x+1][$y]=1
			$count+=1
			_PixelWrite($BMPHandle,$x+1,$y,$color)
			$Tset+=1
			ReDim $tracer[$Tset]
			$tracer[$Tset-1]=$x&","&$y
			$x=$x+1
			ContinueLoop
		EndIf
		if Abs(Dec(_PixelRead($BMPHandle,$x,$y+1))-$CheckColor)<=$variation Then
			$CheckChart[$x][$y+1]=1
			$count+=1
			_PixelWrite($BMPHandle,$x,$y+1,$color)
			$Tset+=1
			ReDim $tracer[$Tset]
			$tracer[$Tset-1]=$x&","&$y
			$y=$y+1
			ContinueLoop
		EndIf
		$Point=StringSplit($tracer[$Tset-1],",")
		$x=$Point[1]
		$y=$Point[2]
		$Tset-=1
		ReDim $tracer[$Tset]
		if $tset=1 then ExitLoop
	Wend
	Return $count
EndFunc

Func _ChordToOffset($x,$y,ByRef $BMPHandle)
	Local $row=($BMPHandle[1]*3+$BMPHandle[0])
	return 54+(($BMPHandle[2]*$row)-(($y+1)*$row)+($x*3))
EndFunc

Func _Reverse8($inHex)
	Return StringMid($inHex,7,2)&StringMid($inHex,5,2)&StringMid($inHex,3,2)&StringMid($inHex,1,2)
EndFunc
