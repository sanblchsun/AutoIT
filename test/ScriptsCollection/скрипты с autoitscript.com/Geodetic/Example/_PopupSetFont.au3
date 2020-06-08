;================================================
; Demo assumes "HtmlHelp.au3" is in this folder.
; If not, put it in the AutoIt "Include" folder
; and change "#include" comments.
;================================================
#include "HtmlHelp.au3"
;#include <HtmlHelp.au3>

Const $sMsg1="This popup uses the default text - Tahoma 8.5pt, no 'adornment'"&@CRLF& _
		"(displayed 10 sec)"
Const $sMsg2="This popup uses red Arial, 12pt, Bold Italic"&@CRLF& _
		"(displayed 10 sec)"

_HHopen() ; initialize help system
; use default settings, middle of screen
_HHPopupText($sMsg1,-1,-1)
sleep(10000)
; now change text
_PopupSetFont(12,0x000000FF,"BOLD ITALIC","Arial")
_HHPopupText($sMsg2,-1,-1)
sleep(10000)

_HHClose()