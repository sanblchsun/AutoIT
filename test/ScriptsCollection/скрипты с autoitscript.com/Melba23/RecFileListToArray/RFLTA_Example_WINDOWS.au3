#include <Array.au3>
#include "RecFileListToArray.au3"

; A sorted list of all files and folders in the AutoIt installation
$aArray = _RecFileListToArray('C:\WINDOWS', "*", 0, 1, 1)
_ArrayDisplay($aArray, "Sorted tree")

; A non-sorted list of all but the .exe files in the \AutoIt3 folder
$aArray = _RecFileListToArray('C:\WINDOWS', "*", 1, 0, 1, 0, "*.exe")
_ArrayDisplay($aArray, "Non .EXE files")

; And here are the .exe files we left out last time
$aArray = _RecFileListToArray('C:\WINDOWS', "*.exe", 1)
_ArrayDisplay($aArray, ".EXE Files")

; A test for all folders and .exe files only throughout the folder tree
$aArray = _RecFileListToArray('C:\WINDOWS', "*exe", 0, 1, 1)
_ArrayDisplay($aArray, "Recur with filter")

; And to show that the filter applies to folders when not recursive
$aArray = _RecFileListToArray('C:\WINDOWS', "*.exe", 0, 0, 1)
_ArrayDisplay($aArray, "Non-recur with filter")

; The filter also applies to folders when recursively searching for folders
$aArray = _RecFileListToArray('C:\WINDOWS', "Icons", 2, 1)
_ArrayDisplay($aArray, "Folder recur with filter")