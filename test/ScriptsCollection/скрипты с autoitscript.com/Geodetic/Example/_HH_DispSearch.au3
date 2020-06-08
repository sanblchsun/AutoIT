;================================================
; Demo assumes "HtmlHelp.au3" is in this folder.
; If not, put it in the AutoIt "Include" folder
; and change "#include" comments.
;================================================
#include "HtmlHelp.au3"
;#include <HtmlHelp.au3>

; CHM file ASSUMED to be on your system - try changing it for your version
; such as wmp11.chm or wmp12.chm
Dim $sCHM=@WindowsDir&"\Help\wmp10.chm"

; better check for file
If Not FileExists($sCHM) Then
	MsgBox(16,"Help File",'Help file "'&$sCHM&'" not found')
	Exit
EndIf

_HHopen() ; initialize help system

MsgBox(0,	"Example: _HH_DispSearch","We're going to open Help, then do a search"&@CRLF& _
			"We will look for 'options NEAR offline' using 'Match similar words' option")
_HH_DispSearch($sCHM,"options NEAR offline",1)
Sleep(200)
MsgBox(0,	"Example: _HH_DispSearch","Now let's look for 'add' in the page titles")
_HH_DispSearch($sCHM,"add",2)
Sleep(200)
MsgBox(0,	"Example: _HH_DispSearch","Close MsgBox to end example - Help will close")

_HHClose()