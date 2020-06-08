;================================================
; Demo assumes "HtmlHelp.au3" is in this folder.
; If not, put it in the AutoIt "Include" folder
; and change "#include" comments.
;================================================
#include "HtmlHelp.au3"
;#include <HtmlHelp.au3>

Const $sMsg1="This popup uses the default text - Tahoma 8.5pt, no 'adornment'"&@CRLF& _
		"(displayed 10 sec)"
Const $sMsg2="This popup uses a different background and margins"&@CRLF& _
		"(displayed 10 sec)"

_HHopen() ; initialize help system
; use default settings, middle of screen
_HHPopupText($sMsg1,-1,-1)
sleep(10000)
; now change window a bit
_PopupSetWindow(0x00F5F5F5,30,30,$skip,30)
_HHPopupText($sMsg2,-1,-1)
sleep(10000)

_HHClose()