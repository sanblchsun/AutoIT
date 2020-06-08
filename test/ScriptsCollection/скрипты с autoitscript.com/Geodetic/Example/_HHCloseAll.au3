;================================================
; Demo assumes "HtmlHelp.au3" is in this folder.
; If not, put it in the AutoIt "Include" folder
; and change "#include" comments.
;================================================
#include "HtmlHelp.au3"
;#include <HtmlHelp.au3>

; CHM files ASSUMED to be on your system
Dim $sCHM1=@WindowsDir&"\Help\charmap.chm"
Dim $sCHM2=@WindowsDir&"\Help\datetime.chm"
Dim $iKey=0
Const $iYes=6

; better check for files
If Not FileExists($sCHM1) Then
	MsgBox(16,"Help File",'Help file "'&$sCHM1&'" not found')
	Exit
EndIf
If Not FileExists($sCHM2) Then
	MsgBox(16,"Help File",'Help file "'&$sCHM2&'" not found')
	Exit
EndIf

_HHopen() ; initialize help system

_HHDispTOC($sCHM1) ; open first help file
_HHDispTOC($sCHM2) ; open second
While $iKey <> $iYes
$iKey=MsgBox(4,"Example: _HHCloseAll","	Close all Help files?"&@CRLF& _
			"(No: this message reappears in 5 seconds)")
	If $iKey=$iYes Then
		_HHCloseAll()
	EndIf
	If $iKey <> $iYes Then Sleep(5000)
WEnd
MsgBox(0,"Example: _HHCloseAll","Help files are closed, but 'app'"& _
		" (and help system) still running!")

_HHClose() ; shut down help system (files would close here anyway)