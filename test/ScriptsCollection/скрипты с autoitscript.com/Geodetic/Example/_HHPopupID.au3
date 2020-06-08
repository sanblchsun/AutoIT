;================================================
; Demo assumes "HtmlHelp.au3" is in this folder.
; If not, put it in the AutoIt "Include" folder
; and change "#include" comments.
;================================================
#include "HtmlHelp.au3"
;#include <HtmlHelp.au3>

; CHM file ASSUMED to be on your system
Dim $sCHM=@WindowsDir&"\Help\wuauhelp.chm"

; better check for file
If Not FileExists($sCHM) Then
	MsgBox(16,"Help File",'Help file "'&$sCHM&'" not found')
	Exit
EndIf

_HHopen() ; initialize help system

; It is 'possible' your installation contains "wuauhelp.chm", but that it is a
; different version and does not contain the "auw2ktt.txt" topic file.
_HHPopupID($sCHM&"::/auw2ktt.txt",3001,-1,-1)
Sleep(10000)

_HHClose()
