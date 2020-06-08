#include <File.au3> ; only used for the example script, not needed for the UDF
#include <Array.au3> ; only used for the example script, not needed for the UDF
$sFolder = FileSelectFolder("Select a folder to scan", "")
$sFolder &= ""
$aFiles = _FileListToArray($sFolder)
For $I = 1 To $aFiles[0]
$aDetails = _FileGetProperty($sFolder & "\" & $aFiles[$I]) ; Returns an array with all properties of the file
_ArrayDisplay($aDetails)
ConsoleWrite("File size of " & $sFolder & $aFiles[$I] & " = " & _FileGetProperty($sFolder & $aFiles[$I], "size") & @CRLF) ; displays in the console the Size of the file
Next

;===============================================================================
; Function Name.....: _FileGetProperty
; Description.......: Returns a property or all properties for a file.
; Version...........: 1.0.2
; Change Date.......: 05-16-2012
; AutoIt Version....: 3.2.12.1+
; Parameter(s)......: $S_PATH - String containing the file path to return the property from.
; $S_PROPERTY - [optional] String containing the name of the property to return. (default = "")
; Requirements(s)...: None
; Return Value(s)...: Success: Returns a string containing the property value.
; If $S_PROPERTY is empty, an two-dimensional array is returned:
; $av_array[0][0] = Number of properties.
; $av_array[1][0] = 1st property name.
; $as_array[1][1] = 1st property value.
; $av_array[n][0] = nth property name.
; $as_array[n][1] = nth property value.
; Failure: Returns 0 and sets @error to:
; 1 = The folder $S_PATH does not exist.
; 2 = The property $S_PROPERTY does not exist or the array could not be created.
; 3 = Unable to create the "Shell.Application" object $objShell.
; Author(s).........: - Simucal <Simucal@gmail.com>
; - Modified by: Sean Hart <autoit@hartmail.ca>
; - Modified by: teh_hahn <sPiTsHiT@gmx.de>
; - Modified by: BrewManNH
; URL...............: http://www.autoitscript.com/forum/topic/34732-udf-getfileproperty/page__view__findpost__p__557571
; Note(s)...........: Modified the script that teh_hahn posted at the above link to include the properties that
; Vista and Win 7 include that Windows XP doesn't. Also removed the ReDims for the $av_ret array and
; replaced it with a single ReDim after it has found all the properties, this should speed things up.
;===============================================================================
Func _FileGetProperty($S_PATH, Const $S_PROPERTY = "")
     $S_PATH = StringRegExpReplace($S_PATH, '["'']', "") ; strip the quotes, if any from the incoming string
     If Not FileExists($S_PATH) Then Return SetError(1, 0, 0)
     Local Const $objShell = ObjCreate("Shell.Application")
     If @error Then Return SetError(3, 0, 0)
     Local $iPropertyCount = 300 ; arbitrary number used, Windows 7 only returns 289 properties, Windows XP only returns 38 (future proofing)
     Local Const $S_FILE = StringTrimLeft($S_PATH, StringInStr($S_PATH, "\", 0, -1))
     Local Const $S_DIR = StringTrimRight($S_PATH, StringLen($S_FILE) + 1)
     Local Const $objFolder = $objShell.NameSpace($S_DIR)
     Local Const $objFolderItem = $objFolder.Parsename($S_FILE)
     If $S_PROPERTY Then
          For $I = 0 To $iPropertyCount
               If $objFolder.GetDetailsOf($objFolder.Items, $I) = $S_PROPERTY Then Return $objFolder.GetDetailsOf($objFolderItem, $I)
          Next
          Return SetError(2, 0, 0)
     EndIf
     Local $av_ret[300][2] = [[1]]
     For $I = 1 To $iPropertyCount - 1
          If $objFolder.GetDetailsOf($objFolder.Items, $I)<> "" Then
               $av_ret[$I][0] = $objFolder.GetDetailsOf($objFolder.Items, $I)
               $av_ret[$I][1] = $objFolder.GetDetailsOf($objFolderItem, $I)
 ; this line was updated incorrectly in the original version, it would just add one to the count, but if there are gaps in the returned information, it wouldn't 
; count all of the file properties correctly
               $av_ret[0][0] = $I
          EndIf
     Next
     ReDim $av_ret[$av_ret[0][0] + 1][2]
     If Not $av_ret[1][0] Then Return SetError(2, 0, 0)
     Return $av_ret
EndFunc   ;==>_FileGetProperty