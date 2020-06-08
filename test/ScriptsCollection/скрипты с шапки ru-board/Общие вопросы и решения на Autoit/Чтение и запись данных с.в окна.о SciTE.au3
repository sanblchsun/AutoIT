; Retrieve all text from the SciTE control
$sSciTE_Data = ControlGetText("[CLASS:SciTEWindow]", "", "Scintilla1")

; Convert to Binary Using Unicode
$sSciTE_Data = StringToBinary($sSciTE_Data, 2)

; Translate back to ANSI text
$sSciTE_Data = BinaryToString($sSciTE_Data, 1)

; Strip ending 00 plus extra chars
$sSciTE_Data = String($sSciTE_Data)

MsgBox(64, 'SciTE Get Text Demo', $sSciTE_Data)

; Add to the text...
$sSciTE_Data &= @CRLF & "; Added some data"

; Translate text to Binary
$sSciTE_Data = StringToBinary($sSciTE_Data, 1)

; Add 00 plus stuffing to have an even number of characters needed for UNICODE
$sSciTE_Data &= StringRight("0000", Mod(StringLen($sSciTE_Data), 4) + 2)

; Translated into UNICODE String
$sSciTE_Data = BinaryToString($sSciTE_Data, 2)

; Set Control text back
ControlSetText("[CLASS:SciTEWindow]", "", "Scintilla1", $sSciTE_Data)