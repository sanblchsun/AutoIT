;================================================
; Demo assumes "HtmlHelp.au3" is in this folder.
; If not, put it in the AutoIt "Include" folder
; and change "#include" comments.
;================================================
#include "HtmlHelp.au3"
;#include <HtmlHelp.au3>

; DLL file ASSUMED to be on your system (from Help/Support system)
Dim $sDLL=@SystemDir&"\user32.dll"
; better check for file
If Not FileExists($sDLL) Then
	MsgBox(16,"Help File",'Help file "'&$sDLL&'" not found')
	Exit
EndIf

Dim $sMsg=	"A 'newbie' computer user was having trouble with Windows."&@CRLF& _
			"         He couldn't seem to get it up and running."&@CRLF& _
			"            Do you know why? (...wait for it!...)"

_HHopen() ; initialize help system

_HHPopupText($sMsg,-1,-1)
Sleep(10000)
_PopupSetFont(10,0x000000FF,"BOLD")
_HHPopupResource($sDLL,8284,-1,-1)
Sleep(5000)

_HHClose()
