#Include <Array.au3>
#Include "V:\Source Code\Outlook\Outlook.au3"
$oOutlook = _OutlookOpen()

; Function Name:    _OutlookFolderExist()
; Description:      Check if an Outlook folder exist
; Syntax.........:  _OutlookFolderExist($oOutlook, $sFolder)
; Parameter(s):     $oOutlook 						- Outlook object opened by a preceding call to _OutlookOpen().
;					$sFolder 						- The Name of the Folder
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Return 1
;                   On Failure   	- Return 0, and sets @ERROR > 0
;					@ERROR = 9   	- ObjEvent error.
;
; Test if "Inbox\Old\Missing" exist
;$xx = _OutlookFolderExist($oOutlook,$olFolderInbox & "\Old\Missing")



; Function Name:    _OutlookFolderAdd()
; Description:      Add a new Outlook folder
; Syntax.........:  _OutlookFolderAdd($oOutlook, $sFolder)
; Parameter(s):     $oOutlook 						- Outlook object opened by a preceding call to _OutlookOpen().
;					$sFolder 						- The Name of the Folder
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Return 1
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Folder does already exist.
;					@ERROR = 2 		- Couldn't find root folder.
;					@ERROR = 3 		- Error when creating folder.
;					@ERROR = 9   	- ObjEvent error.
;
; Add a new folder "Inbox\Old\Missing"
;$xx = _OutlookFolderAdd($oOutlook,$olFolderInbox & "\Old\Missing\")



; Function Name:    _OutlookFolderDelete()
; Description:      Delete an Outlook folder
; Syntax.........:  _OutlookFolderDelete($oOutlook, $sFolder, $fDeleteSubFolders = False)
; Parameter(s):     $oOutlook 						- Outlook object opened by a preceding call to _OutlookOpen().
;					$sFolder 						- The Name of the Folder
;					$fDeleteSubFolders				- Optional: Delete existing subfolder as well, default = False
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Return 1
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Folder doesn't exist.
;					@ERROR = 2 		- Error when deleting folder.
;					@ERROR = 3 		- Subfolders found, and $fDeleteSubFolders = False
;					@ERROR = 9   	- ObjEvent error.
;
; Delete folder "Inbox\Old\Missing" and the subfolders if they exist.
;$xx = _OutlookFolderDelete($oOutlook,$olFolderInbox & "\Old\Missing\",True)