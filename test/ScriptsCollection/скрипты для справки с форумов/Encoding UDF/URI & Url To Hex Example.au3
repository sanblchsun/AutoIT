#include <Encoding.au3>

$sOriginal_URL = "http://ru.wikipedia.org/wiki/Википедия"

$sStringURLToHex = _Encoding_URLToHex($sOriginal_URL)
$sStringHexToURL = _Encoding_HexToURL($sStringURLToHex)

MsgBox(64, 'Results', _
	StringFormat("Original: %s\n\nURL To Hex: %s\n\n\nOriginal: %s\n\nHex To URL: %s", _
		$sOriginal_URL, $sStringURLToHex, $sStringURLToHex, $sStringHexToURL))
