; Zip Example
; _________________________________
;
; Zip UDF Example by torels_
; _________________________________

#include "Zip.au3"
Dim $Zip, $myfile
$myfile = @ScriptDir & "\Zip.au3"

$Zip = _Zip_Create(@ScriptDir & "\zip_002.zip") ;Create The Zip File. Returns a Handle to the zip File
_Zip_AddFile($Zip,$myfile) ;add $myfile to the zip archive
_Zip_AddFolder($Zip,@ScriptDir & "\Example_Folder_001",4) ;Add a folder to the zip file (files/subfolders will be added)
_Zip_AddFolderContents($Zip, @ScriptDir & "\Example_MyFolder") ;Add a folder's content in the zip file
MsgBox(0,"Items in Zip","there are " & _Zip_Count($Zip) & " items in " & $Zip) ;Msgbox Counting Items in $Zip
MsgBox(0,"Items in Zip","there are " & _Zip_CountAll($Zip) & " Elements in " & $Zip) ;Msgbox Counting Elements in $Zip

$search = _Zip_Search($Zip,"Zip.au3") ;Returns an array containing the search results
For $i = 0 to UBound($search) - 1   ; Print Each
    ConsoleWrite($search[$i]) & @LF ; Corresponding value
Next                            ; In The Console

$list = _Zip_List($Zip) ;Returns an array containing all the files in the zip file
ConsoleWrite("============== ZIP Contents ============" & @LF)
For $i = 0 to UBound($list) - 1     
    ConsoleWrite($list[$i] & @LF)   ;Print Search Results in the console
Next

Exit
