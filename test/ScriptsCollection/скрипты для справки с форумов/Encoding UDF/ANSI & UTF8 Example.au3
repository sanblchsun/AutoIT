#include <Encoding.au3>

$sANSI_String = "Тест"
$sUTF8_String = _Encoding_StringToUTF8($sANSI_String)

MsgBox(64, "UTF8 -> " & $sUTF8_String, "Is UTF-8 Format = " & _Encoding_IsUTF8Format($sUTF8_String))
MsgBox(64, "ANSI -> " & $sANSI_String, "Is UTF-8 Format = " & _Encoding_IsUTF8Format($sANSI_String))