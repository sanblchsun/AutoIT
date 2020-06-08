;================================================
; Demo assumes "HtmlHelp.au3" is in this folder.
; If not, put it in the AutoIt "Include" folder
; and change "#include" comments.
;================================================
#include "HtmlHelp.au3"
;#include <HtmlHelp.au3>

#cs
The example file MUST have topicIDs embedded in it.  There aren't many (on my system) which
qualify - I have chosen "msdasc.chm" which has topicIDs of:
	20  40  50  60  200  2010  2020  2030  2040
If this file is NOT on your system, try the following files; you will have to change the
topicID to a valid integer (shown) and re-run the example.
	msorcl32.chm	IDs available:	4000  4100  4101  4102  4103  4104 
	odbcinst.chm	IDs available:	100  200  300  400  500  600  700  800  900  1000
	odbcjet.chm		IDs available:	1  100  200  300  400  500  600  700  800  900
									10000  10100  10200  10300  10400
Topic IDs typical are assigned by the programmer, relative to 'control' IDs, and, therefore,
may be "all over the map".
#ce

; CHM file ASSUMED to be on your system
Dim $sCHM=@WindowsDir&"\Help\msdasc.chm"

; better check for file
If Not FileExists($sCHM) Then
	MsgBox(16,"Help File",'Help file "'&$sCHM&'" not found')
	Exit
EndIf

_HHopen() ; initialize help system

MsgBox(0,	"Example: _HHOpenTopicByID", _
			"I'm opening the default page when you close this dialog.")
_HHDispTOC($sCHM)
MsgBox(0,	"Example: _HHOpenTopicByID", _
			"There doesn't seem to be a way to access other pages..."&@CRLF& _
			"Close this dialog, and I will open a different page!")
_HHOpenTopicByID($sCHM,200)
MsgBox(0,"Example: _HHOpenTopicByID","Just close this dialog when you're ready")

_HHClose()
