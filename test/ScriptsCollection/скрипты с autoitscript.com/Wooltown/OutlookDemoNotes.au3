#Include <Array.au3>
#Include "V:\Source Code\Outlook\Outlook.au3"
$oOutlook = _OutlookOpen()

; Function Name:    _OutlookCreateNote()
; Description:      Create a note using Microsoft Outlook.
; Syntax.........:  _OutlookCreateNote($oOutlook, $sSubject, $sBody = "", $sCategories = "", $iColor = "")
; Parameter(s):     $oOutlook 		- Outlook object opened by a preceding call to _OutlookOpen()
; 					$sSubject      	- The Subject of the Note
;                   $sBody         	- Optional: The Body of the Note
;					$sCategories	- Optional: Categories for the note, separated by ;
;					$iColor			- Optional: The color of the Note, 0 - Blue, 1 - Green, 2 - Pink, 3 - Yellow, 4 - White
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Returns 1
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 9   	- ObjEvent error.
;
; Create a note with the subject: "Test" and the body; "body" and categories: "Business" and "Ideas"
; _OutlookCreateNote($oOutlook,"test","body","Business;Ideas",1)



; Function Name:    _OutlookGetNotes()
; Description:      Get the Notes in Microsoft Outlook
; Syntax.........:  _OutlookGetNotes($oOutlook)
; Parameter(s):     $oOutlook 			- Outlook object opened by a preceding call to _OutlookOpen().
;                   $sWarningClick 		- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   		- Array in the following format: [1000][6]
;										  [0][0] - Number of items
;										  [1][0] - Subject
;										  [1][1] - Body
;										  [1][2] - Color
;										  [1][3] - Categories
;										  [1][4] - Creation time
;										  [1][5] - Last modification time
;										  [n][n] - Item n
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 2   	- OutlookWarning2.exe not found.
;					@ERROR = 3 		- More than 999 Notes found, the first 999 notes will be returned.
;					@ERROR = 9   	- ObjEvent error.
;
; Get all notes from Outlook, return them in an array
;$xx = _OutlookGetNotes($oOutlook,"V:\Source Code\Outlook\OutlookWarning2.exe")
;_Arraydisplay($xx)



; Function Name:    _OutlookDeleteNote()
; Description:      Get the Notes in Microsoft Outlook
; Syntax.........:  _OutlookDeleteNote($oOutlook, $sSubject, $fDeleteMultipleNotes = False, $sWarningClick = "")
; Parameter(s):     $oOutlook 				- Outlook object opened by a preceding call to _OutlookOpen().
; 					$sSubject      			- The Subject of the Note
;					$fDeleteMultipleNotes	- Default : False - If True, delete multiple files with same subject.
;                   $sWarningClick 			- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Array in the following format: [999]
;									  [0] - Number of deleted notes
;									  [1] - Deleted note 1
;									  [2] - Deleted note 2
;									  [n] - Deleted note n
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 2   	- OutlookWarning2.exe not found.
;					@ERROR = 3 		- More than 999 Notes found matching criteria.
;					@ERROR = 4 		- 0 notes found
;					@ERROR = 5 		- More than 1 Notes found and $fDeleteMultipleFiles = False
;					@ERROR = 9   	- ObjEvent error.
;
; Delete "Subject", delete all if several are discovered.
;$xx = _OutlookDeleteNote($oOutlook,"Subject",True,"V:\Source Code\Outlook\OutlookWarning2.exe")
;_Arraydisplay($xx)


; Function Name:    _OutlookModifyNote()
; Description:      Get the Notes in Microsoft Outlook
; Syntax.........:  _OutlookModifyNote($oOutlook, $sSubject, $sBody = "", $sNewSubject = "", $sNewBody = "", $sCategories = "", $iColor = "", $sWarningClick = "")
; Parameter(s):     $oOutlook 			- Outlook object opened by a preceding call to _OutlookOpen().
; 					$sSubject      		- The Subject of the Note
;					$sBody				- Optional: Necessary if more than one item has the same subject, search if string is found somewhere in body. 
; 					$sNewSubject      	- Optional: The new Subject
;					$sNewBody			- Optional: The New Body
;					$sNewCategories		- Optional: Categories for the note, separated by ;
;					$iNewColor			- Optional: The color of the Note, 0 - Blue, 1 - Green, 2 - Pink, 3 - Yellow, 4 - White
;                   $sWarningClick 		- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Returns 1
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 2   	- OutlookWarning2.exe not found.
;					@ERROR = 3 		- Note not found.
;					@ERROR = 4 		- More than 1 Note found.
;					@ERROR = 9   	- ObjEvent error.
;
; Modify the Subject of the note with "Test" as subject and "body" as body, resulting in new subject: "Test3"
;$xx = _OutlookModifyNote($oOutlook,"Test","body","Test3","","V:\Source Code\Outlook\OutlookWarning2.exe")