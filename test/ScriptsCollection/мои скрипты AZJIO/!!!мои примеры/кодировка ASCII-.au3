

$EnDef = "`qwertyuiop[]asdfghjkl;'zxcvbnm,./~QWERTYUIOP{}ASDFGHJKL:""|ZXCVBNM<>?@#$^&"
$RuDef = "¸יצףךוםדרשחץתפûגאןנמכהז‎ÿקסלטעüב‏.¨ÉÖÓÊÅÍÃØÙÇÕÚÔÛÂÀÏÐÎËÄÆÝ/‗×ÑÌÈÒÜÁÞ,""¹;:?"
$UkDef = "¸יצףךוםדרשחץ¿פ³גאןנמכהז÷ÿקסלטעüב‏.¨ÉÖÓÊÅÍÃØÙÇÕ¯Ô²ÂÀÏÐÎËÄÆ×/‗×ÑÌÈÒÜÁÞ,""¹;:?"
$EnText= 'qwertyuiopasdfghjklzxcvbnm'
$RuText = '¸יצףךוםדרשחץתפûגאןנמכהז‎ÿקסלטעüב‏'
$UkText = '¸יצףךוםדרשחץ¿פ³גאןנמכהז÷ÿקסלטעüב‏'

$aDef1 = StringSplit($RuDef , "")
$aDef2 = StringSplit($UkDef , "")
$aDef3 = StringSplit($EnDef , "")


For $i = 1 to 74
	MsgBox(0, $i, 'Ru - '&$aDef1[$i]&' - '&Asc($aDef1[$i])&@CRLF& 'Uk - '&$aDef2[$i]&' - '&Asc($aDef2[$i])&@CRLF& 'En - '&$aDef3[$i]&' - '&Asc($aDef3[$i]))
Next
