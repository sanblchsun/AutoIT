#Include <Array.au3>
#Include "V:\Source Code\Outlook\Outlook.au3"
$oOutlook = _OutlookOpen()

; Function Name:    _OutlookCreateDistList()
; Description:      Create a distribution and DL member using Microsoft Outlook, if Distribution list exist, create only DL member
; Syntax.........:  _OutlookCreateDistList($oOutlook, $sDistList, $sFullName, $sEmailAddress, $sNotes = "", $fSameFullName = False , $sWarningClick = "")
; Parameter(s):     $oOutlook 						- Outlook object opened by a preceding call to _OutlookOpen().
;					$sDistList						- Name of Distribution list
;					$sFullName						- Full name of person in distribution list
;					$sEmailAddress					- E-mail of person in distribution list or "AddMembers" - Adds people from contacts or global address list
;					$sNotes							- Optional: Notes about the distribution list
;					$fSameFullName					- Optional: Accept Multiple persons with same name in Distribution List, Default = False
;					$sWarningClick 					- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
;
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Returns 1
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 2   	- OutlookWarning2.exe not found.
;					@ERROR = 3   	- $fSameFullName = False AND $sFullName already found in distrbution list
;					@ERROR = 4   	- $sEmailAddress already found in distributionslist
;					@ERROR = 9   	- ObjEvent error.
;
; NOTE - If a distribution list already exist, only the member will be added - NOTE
; Create a mail group "The Test Group", full name "Charles Canon", mailaddress "Charles.Canon@domain.com", notes "Test Group", 
; don't accept multiple users with same full name.
; _OutlookCreateDistList($oOutlook,"The Test Group","Charles Canon","Charles.Canon@domain.com","Test Group",False,"V:\Source Code\Outlook\OutlookWarning2.exe")
; Add "Mickey Mouse" who already exist as a contact in your private contactlist to the distribution list.
; _OutlookCreateDistList($oOutlook,"The Test Group","Mickey Mouse","AddMembers","",False,"V:\Source Code\Outlook\OutlookWarning2.exe")



; Function Name:    _OutlookGetDistLists()
; Description:      Get Distribution lists and their members using Microsoft Outlook, returning an array of all information
; Syntax.........:  _OutlookGetDistLists($oOutlook, $sDistListName = "", $sFullName = "", $sEmailAddress = "", $fSearchPart = False, $sWarningClick = "")
; Parameter(s):     $oOutlook 						- Outlook object opened by a preceding call to _OutlookOpen().
;					$sDistListName					- Optional: Distribution list Name
;					$sFullName						- Optional: Full Name
;					$sEmailAddress					- Optional: E-mail address
;					fSearchPart						- Optional: Default: False
;					$sWarningClick 					- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   					- Array in the following format: [1000][3]
;													[0][0] - Total Number of items
;													[1][0] - Distribution List
;													[1][1] - Full Name
;													[1][2] - E-mail address
;												  	[n][n] - Item n
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 2   	- OutlookWarning2.exe not found.
;					@ERROR = 3   	- Both Distribution list And (Full name or E-mail address specified).
;					@ERROR = 4 		- More than 999 records found, the first 999 records will be returned
;					@ERROR = 5 		- No distribution list found.
;					@ERROR = 9   	- ObjEvent error.
;
; Get a list of all users in all distributionlists with a mailaddress belonging to "domain.com
;$xx = _OutlookGetDistLists($oOutlook,"","","domain.com",True,"V:\Source Code\Outlook\OutlookWarning2.exe")
; Get all users from distribution list "DistListName"
;$xx = _OutlookGetDistLists($oOutlook,"DistListName","","",False,"V:\Source Code\Outlook\OutlookWarning2.exe")
; Get all distribution lists containing "Charles Canon" as full name.
;$xx = _OutlookGetDistLists($oOutlook,"","Charles Canon","",False,"V:\Source Code\Outlook\OutlookWarning2.exe")
;_Arraydisplay($xx)


; Function Name:    _OutlookDeleteDistListMember()
; Description:      Delete Distribution list member
; Syntax.........:  _OutlookDeleteDistListMember($oOutlook, $sDistListName, $sFullName = "", $sEmailAddress = "", $sWarningClick = "")
; Parameter(s):     $oOutlook 		- Outlook object opened by a preceding call to _OutlookOpen().
;					$sDistListName	- Optional: Distribution list Name
;					$sFullName		- Optional: Full Name
;					$sEmailAddress	- Optional: E-mail address
;					$sWarningClick 	- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Return 1
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 2   	- OutlookWarning2.exe not found.
;					@ERROR = 3 		- Distribution list not found.
;					@ERROR = 4 		- Distribution list member not found.
;					@ERROR = 9   	- ObjEvent error.
;
; Delete "charles.canon@domain.com" from "Test Group"
;$xx = _OutlookDeleteDistListMember($oOutlook,"Test Group","","charles.canon@domain.com", "V:\Source Code\Outlook\OutlookWarning2.exe")
; Delete a user with e-mail address "charles.canon@domain.com" from all distribution lists.
;$xx = _OutlookDeleteDistListMember($oOutlook,"","","charles.canon@domain.com", "V:\Source Code\Outlook\OutlookWarning2.exe")



; Function Name:    _OutlookDeleteDistList()
; Description:      Delete Distribution list
; Syntax.........:  _OutlookDeleteDistList($oOutlook, $sDistListName)
; Parameter(s):     $oOutlook 		- Outlook object opened by a preceding call to _OutlookOpen().
;					$sDistListName	- Distribution list Name
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Return 1
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Distribution list not found.
;					@ERROR = 9   	- ObjEvent error.
;
; Delete the distribution list "The Test Group"
;$xx = _OutlookDeleteDistList($oOutlook,"The Test Group")