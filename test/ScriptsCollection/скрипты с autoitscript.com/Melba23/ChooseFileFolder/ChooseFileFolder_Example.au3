
#include <Array.au3>

#include "ChooseFileFolder.au3"

Local $sRet, $aRet
Local $sProgFiles = @ProgramFilesDir
If @AutoItX64 Then $sProgFiles &= " (x86)"

; Pick a single *.au3 or *.ico file from within the AutoIt installation folders
; All folders are displayed whether they contain files or not
SplashTextOn("Info", "All folders displayed even if no files present" & @CRLF & @CRLF & "Look at the 'Koda' folder for instance", 400, 200)
Sleep(4000)
SplashOff()
; Display at default of 0 so all folders are displayed even if they have no .au3 files within
; Use the "Select" button - only files can be selected
$sRet = _CFF_Choose("Ex 1: Choose a file - Select button only", 300, 500, -1, -1, $sProgFiles & "\AutoIt3", "*.au3;*.ico")
If $sRet Then
	MsgBox(64, "Ex 1", "Selected:" & @CRLF & @CRLF & $sRet)
Else
	MsgBox(64, "Ex 1", "No Selection")
EndIf

; Enable double click to select from TreeView
$sRet = _CFF_RegMsg()

If $sRet Then
	MsgBox(64, "Success!", "Selections now available with double clicks")
Else
	MsgBox(64, "Failure!", "Selections only available with 'Select' Button")
EndIf

; Pick a single *.au3 or *.ico file from within the AutoIt installation folders
; Only folders containing .au3 or .ico files are displayed - $iDisplay set to 3
SplashTextOn("Info", "Only folders with files displayed" & @CRLF & @CRLF & "Note 'Koda' folder is now absent", 400, 200)
Sleep(3000)
SplashOff()
; Use either the "Select" button or a double click - only files can be selected
$sRet = _CFF_Choose("Ex 2: Choose a file", 300, 500, -1, -1, $sProgFiles & "\AutoIt3", "*.au3;*.ico", 3)
If $sRet Then
	MsgBox(64, "Ex 2", "Selected:" & @CRLF & @CRLF & $sRet)
Else
	MsgBox(64, "Ex 2", "No Selection")
EndIf

; Create a pre-existing array of the AutoIt installation folders and save it as default to increase loading speed
SplashTextOn("Indexing", "Pre-indexing folder array" & @CRLF & @CRLF & "Note almost immediate load once GUI visible", 400, 200)
$sRet = _CFF_IndexDefault($sProgFiles & "\AutoIt3")
Sleep(2000)
SplashOff()
Sleep(1000)

; Pick a single folder within the default folder tree set by _CFF_SetDefault
; Use either the "Select" button or a double click - no files are displayed
Global $sRet = _CFF_Choose("Ex 3: Select a folder", 300, 500, -1, -1, Default, "", 2)
If $sRet Then
	MsgBox(64, "Ex 3", "Selected:" & @CRLF & @CRLF & $sRet)
Else
	MsgBox(64, "Ex 3", "No Selection")
EndIf

SplashTextOn("Indexing", "Indexing files and folders when called" & @CRLF & @CRLF & "Note loading delay once GUI visible", 400, 200)
Sleep(2000)
SplashOff()
Sleep(1000)

; Pick a multiple *.au3 files from within the default folder/file tree set by _CFF_SetDefault
; Use either the "Add" button or a double click to add to the list - only files can be added
; Press "Return" button when selection ended to get "|" delimited string of selected files
$sRet = _CFF_Choose("Ex 4a: Select multiple .au3 files", 300, 500, -1, -1, $sProgFiles & "\AutoIt3", "*.au3", 3, False)
If $sRet Then
	$aRet = StringSplit($sRet, "|")
	$sRet = ""
	For $i = 1 To $aRet[0]
		$sRet &= $aRet[$i] & @CRLF
	Next
	MsgBox(64, "Ex 4a", "Selected:" & @CRLF & @CRLF & $sRet)
Else
	MsgBox(64, "Ex 4a", "No Selection")
EndIf

; Create a pre-existing array of the AutoIt installation folders and all *.au3 files and save it as default to increase loading speed
SplashTextOn("Indexing", "Pre-indexing folder and file array" & @CRLF & @CRLF & "Note quicker loading time once GUI visible", 400, 200)
$sRet = _CFF_IndexDefault($sProgFiles & "\AutoIt3", "*.au3", True)
Sleep(2000)
SplashOff()
Sleep(1000)

; Now do the same thing with the pre-loaded array
$sRet = _CFF_Choose("Ex 4b: Select multiple .au3 files", 300, 500, -1, -1, Default, Default, 3, False)
If $sRet Then
	$aRet = StringSplit($sRet, "|")
	$sRet = ""
	For $i = 1 To $aRet[0]
		$sRet &= $aRet[$i] & @CRLF
	Next
	MsgBox(64, "Ex 4b", "Selected:" & @CRLF & @CRLF & $sRet)
Else
	MsgBox(64, "Ex 4b", "No Selection")
EndIf

; Clear the default arrays
_CFF_ClearDefault()

; Pick any file on any drive
; WARNING - indexing large drives can take a considerable time - you have been warned!!!!
$sRet = _CFF_Choose("Ex 5: Select a file", 300, 500, -1, -1)
If $sRet Then
	MsgBox(64, "Ex 5", "Selected:" & @CRLF & @CRLF & $sRet)
Else
	MsgBox(64, "Ex 5", "No Selection")
EndIf

; Pick multiple files from any drive
; Use either the "Add" button or a double click to add to the list - only files can be added
; WARNING - indexing large drives can take a considerable time - you have been warned!!!!
; Press "Return" button when selection ended to get "|" delimited string of selected files
$sRet = _CFF_Choose("Ex 6: Select multiple files", 300, 500, -1, -1, "", Default, 0, False)
If $sRet Then
	$aRet = StringSplit($sRet, "|")
	$sRet = ""
	For $i = 1 To $aRet[0]
		$sRet &= $aRet[$i] & @CRLF
	Next
	MsgBox(64, "Ex 6", "Selected:" & @CRLF & @CRLF & $sRet)
Else
	MsgBox(64, "Ex 6", "No Selection")
EndIf

; Choose a single file from a specified folder - no subfolders displayed
; Note file exts displayed because of *.* mask even though requested to be hidden
$sRet = _CFF_Choose("Ex 7: Select a file", 300, 500, -1, -1, $sProgFiles & "\AutoIt3", "*.*", 5)
If $sRet Then
	MsgBox(64, "Ex 7", "Selected:" & @CRLF & @CRLF & $sRet)
Else
	MsgBox(64, "Ex 7", "No Selection")
EndIf

; Choose a single file from a specified folder - no subfolders displayed
; Note file exts not displayed, but returned
$sRet = _CFF_Choose("Ex 8: Select a file - no extensions displayed", 300, 500, -1, -1, $sProgFiles & "\AutoIt3\Include", "*.au3", 5)
If $sRet Then
	MsgBox(64, "Ex 7", "Selected:" & @CRLF & @CRLF & $sRet)
Else
	MsgBox(64, "Ex 7", "No Selection")
EndIf
