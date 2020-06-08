
#include <Array.au3>

#include "RecFileListToArray.au3"

Global $sAutoItDir = StringReplace(StringReplace(@AutoItExe, "\AutoIt3.exe", ""), "\beta", "") & "\"
ConsoleWrite($sAutoItDir & @CRLF)

; A sorted list of all files and folders in the AutoIt installation
$aArray = _RecFileListToArray($sAutoItDir, "*", 0, 1, 1)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Sorted tree")

; A non-sorted list of all but the .exe files in the \AutoIt3 folder
$aArray = _RecFileListToArray($sAutoItDir, "*|*.exe", 1, 0, 1, 0)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Non .EXE files")

; And here are the .exe files we left out last time
$aArray = _RecFileListToArray($sAutoItDir, "*.exe", 1)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, ".EXE Files")

; A test for all folders and .exe files only throughout the folder tree, omitting folders beginning with I (Icons and Include)
$aArray = _RecFileListToArray($sAutoItDir, "*.exe||I*", 0, 1, 1)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Recur with filter")

; And to show that the filter applies to folders when not recursive
$aArray = _RecFileListToArray($sAutoItDir, "*.exe", 0, 0, 1)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Non-recur with filter")

; The filter also applies to folders when recursively searching for folders
$aArray = _RecFileListToArray($sAutoItDir, "Icons", 2, 1)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Folder recur with filter")

; The root of C:\Windows showing hidden/system folders
$aArray = _RecFileListToArray("C:\Windows\", "*", 2)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Show hidden folders")

; The root of C:\Windows omitting hidden/system folders
$aArray = _RecFileListToArray("C:\Windows\", "*", 2 + 4 + 8)
ConsoleWrite("Error: " & @error & " - " & " Extended: " &  @extended & @CRLF)
_ArrayDisplay($aArray, "Hide hidden folders")

