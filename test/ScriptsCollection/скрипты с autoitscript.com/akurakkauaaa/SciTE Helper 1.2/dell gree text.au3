#cs ----------------------------------------------------------------------------
	usuwaj zielony tekst
	dell gren text
#ce ----------------------------------------------------------------------------
global $sPath, $textAU3

$sPath = FileOpenDialog('Select File', '', 'AutoIt v3 Script (*.au3)', 3)

$textAU3 = FileRead($sPath)

If Not StringInStr($textAU3, @CRLF) Then $textAU3 = StringReplace($textAU3, @LF, @CRLF)
If Not StringInStr($textAU3, @CRLF) Then $textAU3 = StringReplace($textAU3, @CR, @CRLF)

$textAU3 = @CRLF & $textAU3 & @CRLF

$textAU3 = StringRegExpReplace($textAU3, '(?ims)^\s*(#cs\b.*?\r\n[\s]*#ce\b.*?)\r\n|' & _
		'(?ims)^\s*(#comments-start\b.*?\r\n[\s]*#comments-end\b.*?)\r\n', @CRLF) ;dell coments

$textAU3 = StringRegExpReplace($textAU3, "('')|('.*?')|" & '("")|(".*?")|(\s*;.*?)(\r\n)', '\1\2\3\4\6') ; dell gren text

$textAU3 = StringRegExpReplace($textAU3, "\r\n([[:space:]]+)", @CRLF) ; del white space (przod)

$textAU3 = StringRegExpReplace($textAU3, "([[:space:]]+)\r\n", @CRLF) ; del white space (tyl)

ConsoleWrite($textAU3 & @CRLF)


