;================================================
; Demo assumes "HtmlHelp.au3" is in this folder.
; If not, put it in the AutoIt "Include" folder
; and change "#include" comments.
;================================================
#include "HtmlHelp.au3"
;#include <HtmlHelp.au3>

; 1. Setup path to CHM - ASSUMED to be on your system
Dim $sCHM=@WindowsDir&"\Help\charmap.chm"
; better check for file
If Not FileExists($sCHM) Then
	MsgBox(16,"Help File",'Help file "'&$sCHM&'" not found')
	Exit
EndIf

; 2. open and initializes the HTML Help system
_HHopen()
; 3. just open the file to Contents and default page
_HHDispTOC($sCHM)
; and wait a bit... (it will close automatically)
Sleep(10000) ; 10 seconds
; 4. then close help file, shut down help system
_HHClose()