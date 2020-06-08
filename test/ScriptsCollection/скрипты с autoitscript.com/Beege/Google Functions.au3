#include <inet.au3>
#include <array.au3>

$suggestions = _GoogleSuggestions('autoit s')
_ArrayDisplay($suggestions, 'Suggestions')

$Definitions = _GoogleDefine("Pulp")
_ArrayDisplay($Definitions, 'Pulp ')

$Translate = _GoogleTranslate("Hello how are you?")
MsgBox(0, 'English to Spanish  ', "Hello how are you?" & @CRLF & $Translate)

$convert = _GoogleUnitConvert(10, 'gallons', 'liters')
MsgBox(0,'Gallons to Liters', '10 Gallons = ' &$convert& ' Liters')


Func _GoogleSuggestions($sSuggest); Retruns an Array of Suggestions
    Local $sSource, $aResults;, $aQueries
    $sSource = _INetGetSource("http://google.com/complete/search?output=toolbar&q=" & $sSuggest)
    If @error Then Return SetError(1)
    $aResults = StringRegExp($sSource, '<CompleteSuggestion><suggestion data="(.*?)"/>', 3)
    ;~ $sQueries = StringRegExp($source, '"/><num_queries int="(\d{0,})"/>', 3)
    Return $aResults
EndFunc   ;==>_GoogleSuggestions

Func _GoogleDefine($sKeyWord)
    Local $aDefintions, $sSource
    $sSource = _INetGetSource("http://www.google.com/search?q=define%3A" & $sKeyWord)
    If @error Then Return SetError(1)
    $aDefintions = StringRegExp($sSource, "<li>(.*?)<br>", 1)
    Return StringSplit(StringRegExpReplace($aDefintions[0], '(<li>)', '|'), '|')
EndFunc   ;==>_GoogleDefine

Func _GoogleTranslate($sText, $sTo = "es", $sFrom = "en")
    Local $sTranslation, $sUrl, $sSource
    $sUrl = StringFormat("http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=%s&langpair=%s%%7C%s", $sText, $sFrom, $sTo)
    $sSource = _INetGetSource($sUrl)
    $sTranslation = StringRegExp(BinaryToString($sSource, 4), '"translatedText":"([^"]+)"', 1)
    Return $sTranslation[0]
EndFunc   ;==>_GoogleTranslate
;~ spanish = es, Albanian = sq, Arabic = ar, Bulgarian = bg,Catalan = ca, Croatian = hr, Czech = cs,Danish = da
;~ dutch = nl,Estonian = et,Filipino = tl, Finnish = fi, French = fr, Galician = gl,German = de,Greek = el
;~ Hebrew = iw,Hindi = hi - no, Hungarian = hu,Indonesian = id, Italian = it, Latvian = lv,Vietnamese = vi
;~ Turkish = tr,Swedish = sv,Russian = ru, Portuguese = pt, English = en

Func _GoogleUnitConvert($sValue, $sFrom, $sTo)
    Local $sSource
    $sSource = _INetGetSource("http://www.google.com/search?q=" & $sValue & "%20" & StringLower($sFrom) & "%20in%20" & StringLower($sTo))
    If @error Then Return SetError(1)
    $sSource = StringRegExp($sSource, '<h2(.*?)More about calculator.</a>', 1)
    $sSource = StringRegExp($sSource[0], '=\s(.*?)\s[a-z]*(\s?[a-z]*?)</b>', 1)
    Return StringReplace($sSource[0], Chr(160), '')
EndFunc   ;==>_GoogleUnitConvert