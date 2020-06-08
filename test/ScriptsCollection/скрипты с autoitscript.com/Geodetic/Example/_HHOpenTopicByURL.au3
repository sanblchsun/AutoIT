;================================================
; Demo assumes "HtmlHelp.au3" is in this folder.
; If not, put it in the AutoIt "Include" folder
; and change "#include" comments.
;================================================
#include "HtmlHelp.au3"
;#include <HtmlHelp.au3>

; CHM file ASSUMED to be on your system (from Help/Support system)
Dim $sCHM=@WindowsDir&"\Help\password.chm"

; better check for file
If Not FileExists($sCHM) Then
	MsgBox(16,"Help File",'Help file "'&$sCHM&'" not found')
	Exit
EndIf

_HHopen() ; initialize help system

MsgBox(0,	"Example: _HHOpenTopicByURL", _
			"I'm opening the default page when you close this dialog.")
_HHDispTOC($sCHM)
Sleep(500) ; to ensure MsgBox is on top...
MsgBox(0,	"Example: _HHOpenTopicByURL", _
			"There doesn't seem to be a way to access other pages..."&@CRLF& _
			"Close this dialog, and I will open a different page!")
_HHOpenTopicByURL($sCHM,"/windows_password_change.htm")
Sleep(500)
MsgBox(0,"Example: _HHOpenTopicByID","Just close this dialog when you're ready")

_HHClose()
