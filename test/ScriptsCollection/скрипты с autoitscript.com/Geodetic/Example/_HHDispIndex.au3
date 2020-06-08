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

MsgBox(0,	"Example: _HHDispIndex","We're going to open Help, then do a Index search"&@CRLF& _
			"We will look for 'History button'")
_HHDispIndex($sCHM,"History button")
Sleep(200)
MsgBox(0,	"Example: _HHDispIndex","Close MsgBox to end example - Help will close")

_HHClose()