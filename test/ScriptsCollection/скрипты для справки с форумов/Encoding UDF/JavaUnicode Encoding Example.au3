#include <Encoding.au3>

$sString = "Привет Мир!"
$sStringToJavaUnicode = _Encoding_JavaUnicodeEncode($sString)
$sJavaUnicodeToString = _Encoding_JavaUnicodeDecode($sStringToJavaUnicode)

$sResults = StringFormat("Original $sString = %s\n\n" & _
	"_Encoding_JavaUnicodeEncode($sString) = %s\n\n_Encoding_JavaUnicodeDecode($sStringToJavaUnicode) = %s", _
	$sString, $sStringToJavaUnicode, $sJavaUnicodeToString)

MsgBox(64, "Results", $sResults)
