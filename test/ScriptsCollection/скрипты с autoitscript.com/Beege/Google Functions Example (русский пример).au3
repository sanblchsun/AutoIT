#include <inet.au3>
#include <array.au3>

$Translate = _GoogleTranslate("I was working on a project to create an automated Windows NT 4 build for a company in the UK. It became clear that around half the applications required featured no way to silently install them. Searched around for a while for some way to force button presses and came across Microsoft ScriptIt which was a compiled WinBatch script designed for clicking buttons in automated builds. ScriptIt worked OK but it was extremely unreliable. It was notoriously fussy about the speed of the machine it was used on and had no way to control the key delays between keystrokes. Another feature that caused problems was that there was no way to specify a working directory when running a program which caused loads of problems with many of the applications I was scripting. Also, some of the functions didn't work under NT 5 beta (i.e. Windows 2000).")
MsgBox(0, 'Английский > Русский', $Translate)

Func _GoogleTranslate($sText, $sTo = "ru", $sFrom = "en")
    Local $sTranslation, $sUrl, $sSource
    $sUrl = StringFormat("http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=%s&langpair=%s%%7C%s", $sText, $sFrom, $sTo)
    $sSource = _INetGetSource($sUrl)
    $sTranslation = StringRegExp(BinaryToString($sSource, 4), '"translatedText":"([^"]+)"', 1)
    Return $sTranslation[0]
EndFunc   ;==>_GoogleTranslate