;================================================
; Demo assumes "HtmlHelp.au3" is in this folder.
; If not, put it in the AutoIt "Include" folder
; and change "#include" comments.
;================================================
#include "HtmlHelp.au3"
;#include <HtmlHelp.au3>

; CHM file ASSUMED to be on your system
Dim $sCHM=@WindowsDir&"\Help\iexplore.chm"

; better check for file
If Not FileExists($sCHM) Then
	MsgBox(16,"Help File",'Help file "'&$sCHM&'" not found')
	Exit
EndIf

_HHopen() ; initialize help system

_HHDispTOC($sCHM)
Sleep(200)
MsgBox(0,"Example: _HHDispTOC","Change tabs, then close MsgBox")
_HHDispTOC($sCHM)
Sleep(200)
MsgBox(0,	"Example: _HHDispTOC","You should be looking at the Contents tab again"&@CRLF& _
			"Closing MsgBox will end example and close Help")

_HHClose()