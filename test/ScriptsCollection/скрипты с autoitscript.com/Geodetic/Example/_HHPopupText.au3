;================================================
; Demo assumes "HtmlHelp.au3" is in this folder.
; If not, put it in the AutoIt "Include" folder
; and change "#include" comments.
;================================================
#include "HtmlHelp.au3"
;#include <HtmlHelp.au3>

Const $sMsg1="This popup is from a string constant - nothing fancy"&@CRLF& _
		"(displayed 10 sec)"
Const $sMsg2="Now we've changed the position"&@CRLF& _
		"(displayed 10 sec)"

_HHopen() ; initialize help system
; use default settings, middle of screen
_HHPopupText($sMsg1,-1,-1)
sleep(10000)
; now change position
_HHPopupText($sMsg2,150,100)
sleep(10000)

_HHClose()