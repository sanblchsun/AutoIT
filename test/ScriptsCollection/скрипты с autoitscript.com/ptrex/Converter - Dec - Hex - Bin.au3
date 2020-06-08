#include <Color.au3>
#include <GUIConstantsEX.au3>
#include <String.au3>

Global Const $HX_REF="0123456789ABCDEF"
Global Const $color1 = 0x99A8AC
Global Const $color2 = 0xFFFFFF

$Gui = GUICreate("Converter @  Dec - Bin - Hex"& _StringRepeat(" ",125) & " by ptrex" , 833, 247, 161, 166)
GUISetIcon (@windowsdir & "\system32\Calc.exe",-1,$Gui)
$Size = WinGetClientSize($Gui)

$radio1 = GUICtrlCreateRadio ("Dec", 100, 10, 60, 20)
GUICtrlSetBkColor(-1,0xA1AFB2)
$radio2 = GUICtrlCreateRadio ("Hex", 160, 10, 60, 20)
GUICtrlSetBkColor(-1,0xA1AFB2)
$radio3 = GUICtrlCreateRadio ("Bin", 220, 10, 60, 20)
GUICtrlSetBkColor(-1,0xA1AFB2)
;GUICtrlSetState ($radio1, $GUI_CHECKED)

$label = GUICtrlCreateLabel("Input", 10, 15, 50, 15)
GUICtrlSetBkColor(-1,0xA1AFB2)
$labelout = GUICtrlCreateLabel("Result", 10, 45, 50, 15)
GUICtrlSetBkColor(-1,0xAEBABD)
$Input1 = GUICtrlCreateInput("", 100, 40, 650, 21)
$Label1 = GUICtrlCreateLabel("Hexadecimal", 10, 80, 70, 15) 
GUICtrlSetBkColor(-1,0xBAC4C7)
$Label1out = GUICtrlCreateLabel("0", 100, 80, 600, 15)
GUICtrlSetBkColor(-1,0xBAC4C7)
$Label2 = GUICtrlCreateLabel("Binary", 10, 115, 50, 15)
GUICtrlSetBkColor(-1,0xCBD3D5)
$Label2out = GUICtrlCreateLabel("0", 100, 115, 600, 15)
GUICtrlSetBkColor(-1,0xCBD3D5)

_GUICtrlCreateGradient($color1, $color2, 0, 0, $size[0]*1.5, $size[1])
GUISetState(@SW_SHOW)


While 1
    $msg = GUIGetMsg()
    Select
        Case $msg = $GUI_EVENT_CLOSE
            ExitLoop
        Case $msg = $radio1 And BitAND(GUICtrlRead($radio1), $GUI_CHECKED) = $GUI_CHECKED
           
            GUICtrlSetData($Label1out,_DecimalToHex(int(StringStripWS(GUICtrlRead($Input1,1),8))))
            GUICtrlSetData($Label1,"Hexadecimal")
            GUICtrlSetData($Label2out,_DecToBinary(StringStripWS(GUICtrlRead($Input1,1),8)))
            GUICtrlSetData($Label2,"Binary")
                ;ConsoleWrite("_DecimalToHex " & _DecimalToHex(Int(GUICtrlRead($Input1,1))) & @LF)
                ;ConsoleWrite("_DecToBinary " & _DecToBinary(GUICtrlRead($Input1,1)) & @CRLF)
                                
        Case $msg = $radio2 And BitAND(GUICtrlRead($radio2), $GUI_CHECKED) = $GUI_CHECKED
            GUICtrlSetData($Label1out,_HexToDecimal(StringStripWS(GUICtrlRead($Input1,1),8)))
            GUICtrlSetData($Label1,"Decimal")
            GUICtrlSetData($Label2out,_HexToBinaryString(StringStripWS(GUICtrlRead($Input1,1),8)))
            GUICtrlSetData($Label2,"Binary")
                ;ConsoleWrite("_HexToDecimal " & _HexToDecimal(GUICtrlRead($Input1,1)) & @LF)
                ;ConsoleWrite("_HexToBinaryString " & _HexToBinaryString(GUICtrlRead($Input1,1)) & @LF)
                
        Case $msg = $radio3 And BitAND(GUICtrlRead($radio3), $GUI_CHECKED) = $GUI_CHECKED
            GUICtrlSetData($Label1out,_BinaryToHexString(StringStripWS(GUICtrlRead($Input1,1),8)))
            GUICtrlSetData($Label1,"Hexadecimal")
            GUICtrlSetData($Label2out,_BinaryToDec(StringStripWS(GUICtrlRead($Input1,1),8)))
            GUICtrlSetData($Label2,"Decimal")
                ;ConsoleWrite("_BinaryToHexString " & _BinaryToDec(GUICtrlRead($Input1,1)) & @LF)
                ;ConsoleWrite("_HexToBinaryString " & _HexToBinaryString(GUICtrlRead($Input1,1)) & @LF)     
    EndSelect
WEnd

; Conversion Code - Chart  
; DECIMAL 0    1    2    3    4    5    6    7    8    9    10   11   12   13   14   15   16
; HEX     0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F    10
; BINARY 0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111  10000 


; --------------------- Functions -----------------------------
; Binary to Decimal
Func _BinaryToDec($strBin)
Local $Return
Local $lngResult
Local $intIndex

If StringRegExp($strBin,'[0-1]') then
$lngResult = 0
  For $intIndex = StringLen($strBin) to 1 step -1
    $strDigit = StringMid($strBin, $intIndex, 1)
    Select 
      case $strDigit="0"
        ; do nothing
      case $strDigit="1"
        $lngResult = $lngResult + (2 ^ (StringLen($strBin)-$intIndex))
      case else
        ; invalid binary digit, so the whole thing is invalid
        $lngResult = 0
        $intIndex = 0 ; stop the loop
    EndSelect
  Next

  $Return = $lngResult
    Return $Return
Else
    MsgBox(0,"Error","Wrong input, try again ...")
    Return
EndIf   
EndFunc
 
; Decimal To Binary
Func _DecToBinary($iDec)
Local $i, $sBinChar = ""

If StringRegExp($iDec,'[[:digit:]]') then
$i = 1

Do
 $x = 16^$i
 $i +=1 
 ; Determine the Octets
Until $iDec < $x
 
For $n = 4*($i-1) To 1 Step -1
    If BitAND(2 ^ ($n-1), $iDec) Then
        $sBinChar &= "1"
    Else
        $sBinChar &= "0"
    EndIf
Next
 Return $sBinChar
Else
    MsgBox(0,"Error","Wrong input, try again ...")
    Return
EndIf   
EndFunc


; #FUNCTION# ==============================================================
; Function Name..: _HexToDec ( "expression" )
; Description ...: Returns decimal expression of a hexadecimal string.
; Parameters ....: expression   - String representation of a hexadecimal expression to be converted to decimal.
; Return values .: Success      - Returns decimal expression of a hexadecimal string.
;                  Failure      - Returns "" (blank string) and sets @error to 1 if string is not hexadecimal type.
; Author ........: jennico (jennicoattminusonlinedotde)
; Remarks .......: working input format: "FFFF" or "0xFFFF" (string format), do NOT pass 0xFFFF without quotation marks (number format).
;               current AutoIt Dec() limitation: 0x7FFFFFFF (2147483647).
; Related .......: Hex(), Dec(), _DecToHex()
; =======================================================================
Func _HexToDecimal($hx_hex)
    If StringLeft($hx_hex, 2) = "0x" Then $hx_hex = StringMid($hx_hex, 3)
    If StringIsXDigit($hx_hex) = 0 Then
        SetError(1)
        MsgBox(0,"Error","Wrong input, try again ...")
        Return ""
    EndIf
    Local $ret="", $hx_count=0, $hx_array = StringSplit($hx_hex, ""), $Ii, $hx_tmp
    For $Ii = $hx_array[0] To 1 Step -1
        $hx_tmp = StringInStr($HX_REF, $hx_array[$Ii]) - 1
        $ret += $hx_tmp * 16 ^ $hx_count
        $hx_count += 1
    Next
    Return $ret
EndFunc  ;==>_HexToDec()

; #FUNCTION# ==============================================================
; Function Name..: _DecToHex ( expression [, length] )
; Description ...: Returns a string representation of an integer converted to hexadecimal.
; Parameters ....: expression   - The integer to be converted to hexadecimal.
;                               - [optional] Number of characters to be returned (no limit).
;                                 If no length specified, leading zeros will be stripped from result.
; Return values .: Success      - Returns a string of length characters representing a hexadecimal expression, zero-padded if necessary.
;                  Failure      - Returns "" (blank string) and sets @error to 1 if expression is not an integer.
; Author ........: jennico (jennicoattminusonlinedotde)
; Remarks .......: Output format "FFFF".
;               The function will also set @error to 1 if requested length is not sufficient - the returned string will be left truncated.
;               Be free to modify the function to be working with binary type input - I did not try it though.
;               current AutoIt Hex() limitation: 0xFFFFFFFF (4294967295).
; Related .......: Hex(), Dec(), _HexToDec()
; =======================================================================
Func _DecimalToHex($hx_dec, $hx_length = 21)

    If IsInt($hx_dec) = 0 Then
        SetError(1)
        MsgBox(0,"Error","Wrong input, try again ...")
        Return ""
    EndIf
    Local $ret = "", $Ii, $hx_tmp, $hx_max
    If $hx_dec < 4294967296 Then 
        If $hx_length < 9 Then Return Hex($hx_dec, $hx_length)
        If $hx_length = 21 Then
            $ret = Hex($hx_dec)
            While StringLeft($ret, 1) = "0"
                $ret = StringMid($ret, 2)
            WEnd
            Return $ret
        EndIf
    EndIf
    For $Ii = $hx_length - 1 To 0 Step -1
        $hx_max = 16 ^ $Ii - 1
        If $ret = "" And $hx_length = 21 And $hx_max > $hx_dec Then ContinueLoop
        $hx_tmp = Int($hx_dec/($hx_max+1))
        If $ret = "" And $hx_length = 21 And $Ii > 0 And $hx_tmp = 0 Then ContinueLoop
        $ret &= StringMid($HX_REF, $hx_tmp+1, 1)
        $hx_dec -= $hx_tmp * ($hx_max + 1)
    Next
    $ret=String($ret)
    If $hx_length < 21 And StringLen($ret) < $hx_length Then SetError(1)
    Return $ret
EndFunc  ;==>_DecToHex()

; ----------------------------------------------------------------
; Hex to Decimal Conversion ; Correct till Decimal 65789 ?!
Func _HexToDecimal_NotCorrect($Input)
Local $Temp, $i, $Pos, $Ret, $Output

If StringRegExp($input,'[[:xdigit:]]') then
$Temp = StringSplit($Input,"")

For $i = 1 to $Temp[0]
    $Pos = $Temp[0] - $i
    $Ret =  Dec (Hex ("0x" & $temp[$i] )) * 16 ^ $Pos
    $Output &= $Ret
Next
    return $Output
Else
    MsgBox(0,"Error","Wrong input, try again ...")
    Return
EndIf   
EndFunc

; Decimal To Hex Conversion
Func _DecimalToHex_NotCorrect($Input)
local $Output, $Ret

If StringRegExp($input,'[[:digit:]]') then
Do
    $Ret = Int(mod($Input,16))
    $Input = $Input/16
    $Output = $Output & StringRight(Hex($Ret),1)
Until Int(mod($Ret,16))= 0

    Return StringMid(_StringReverse($Output),2)
Else
    MsgBox(0,"Error","Wrong input, try again ...")
    Return
EndIf   
EndFunc
;-------------------------------------------------------------------

; Binary To Hex
Func _BinaryToHexString($BinaryValue)
    Local $test, $Result = '',$numbytes,$nb

If StringRegExp($BinaryValue,'[0-1]') then
    
    if $BinaryValue = '' Then
        SetError(-2)
        Return
    endif

    Local $bits = "0000|0001|0010|0011|0100|0101|0110|0111|1000|1001|1010|1011|1100|1101|1110|1111"
    $bits = stringsplit($bits,'|')
    #region check string is binary

    $test = stringreplace($BinaryValue,'1','')
    $test = stringreplace($test,'0','')
    if $test <> '' Then
        SetError(-1);non binary character detected
        Return
    endif
    #endregion check string is binary

    #region make binary string an integral multiple of 4 characters
    While 1
        $nb = Mod(StringLen($BinaryValue),4)
        if $nb = 0 then exitloop
        $BinaryValue = '0' & $BinaryValue
    WEnd
    #endregion make binary string an integral multiple of 4 characters

    $numbytes = Int(StringLen($BinaryValue)/4);the number of bytes

    Dim $bytes[$numbytes],$Deci[$numbytes]
    For $j = 0 to $numbytes - 1;for each byte
    ;extract the next byte
        $bytes[$j] = StringMid($BinaryValue,1+4*$j,4)

    ;find what the dec value of the byte is
        for $k = 0 to 15;for all the 16 possible hex values
            if $bytes[$j] = $bits[$k+1] Then
                $Deci[$j] = $k
                ExitLoop
            EndIf
        next
    Next
    
;now we have the decimal value for each byte, so stitch the string together again
    $Result = ''
    for $l = 0 to $numbytes - 1
        $Result &= Hex($Deci[$l],1)
    Next
    return $Result
Else
    MsgBox(0,"Error","Wrong input, try again ...")
    Return
EndIf   
EndFunc


; Hex To Binary
Func _HexToBinaryString($HexValue)
    Local $Allowed = '0123456789ABCDEF'
    Local $Test,$n
    Local $Result = ''
    if $hexValue = '' then
        SetError(-2)
        Return
    EndIf

    $hexvalue = StringSplit($hexvalue,'')
    for $n = 1 to $hexValue[0]
        if not StringInStr($Allowed,$hexvalue[$n]) Then
            SetError(-1)
            return 0
        EndIf
    Next

    Local $bits = "0000|0001|0010|0011|0100|0101|0110|0111|1000|1001|1010|1011|1100|1101|1110|1111"
    $bits = stringsplit($bits,'|')
    for $n = 1 to $hexvalue[0]
        $Result &=  $bits[Dec($hexvalue[$n])+1]
    Next

    Return $Result

EndFunc

Func _GUICtrlCreateGradient($nStartColor, $nEndColor, $nX, $nY, $nWidth, $nHeight)
    Local $color1R = _ColorGetRed($nStartColor)
    Local $color1G = _ColorGetGreen($nStartColor)
    Local $color1B = _ColorGetBlue($nStartColor)

    Local $nStepR = (_ColorGetRed($nEndColor) - $color1R) / $nHeight
    Local $nStepG = (_ColorGetGreen($nEndColor) - $color1G) / $nHeight
    Local $nStepB = (_ColorGetBlue($nEndColor) - $color1B) / $nHeight

    GuiCtrlCreateGraphic($nX, $nY, $nWidth, $nHeight)
    For $i = 0 To $nHeight - $nY
        $sColor = "0x" & StringFormat("%02X%02X%02X", $color1R+$nStepR*$i, $color1G+$nStepG*$i, $color1B+$nStepB*$i)
        GUICtrlSetGraphic(-1, $GUI_GR_COLOR, $sColor, 0xffffff)
        GUICtrlSetGraphic(-1, $GUI_GR_MOVE, 0, $i)
        GUICtrlSetGraphic(-1, $GUI_GR_LINE, $nWidth, $i)
    Next
EndFunc