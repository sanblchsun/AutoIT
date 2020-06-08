#include <Encoding.au3>

$sString = 'Íåòðóäîâûå äîõîäû'
$sDecodedString = _Encoding_UTF8BOMDecode($sString)

MsgBox(64, "Results", $sString & @CRLF & $sDecodedString)
