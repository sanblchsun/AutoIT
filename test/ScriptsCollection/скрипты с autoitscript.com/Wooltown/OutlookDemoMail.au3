#Include <Array.au3>
#Include "V:\Source Code\Outlook\Outlook.au3"
$oOutlook = _OutlookOpen()

; ===============================================================================================================================
; Function Name:    _OutlookSendMail()
; Description:      Send an email using Microsoft Outlook.
; Syntax.........:  _OutlookSendMail($oOutlook, $sTo = "", $sCc = "", $sBCc = "", $sSubject = "", $sBody = "", $sAttachments = "", $iBodyFormat = $olFormatUnspecified, $iImportance = $olImportanceNormal, $sWarningClick = "")
; Parameter(s):     $oOutlook 		- Outlook object opened by a preceding call to _OutlookOpen()
;                   $sTo           	- Optional: The recipiant(s), separated by ;
;                   $sCc         	- Optional: The CC recipiant(s) of the mail, separated by ;
;                   $sBCc        	- Optional: The BCC recipiant(s) of the mail, separated by ;
;					$sSubject      	- Optional: The Subject of the mail
;                   $sBody         	- Optional: The Body of the mail
;           		$sAttachments	- Optional: Attachments, separated by ;
;                   $iBodyFormat 	- Optional: The Bodyformat of the mail, default = $olFormatUnspecified
;                   $iImportance 	- Optional: The Importance of the mail, default = $olImportanceNormal
;					$sWarningClick 	- Optional: The Entire SearchString to 'OutlookWarning1.exe', Default = None
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Returns 1
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1   	- No To, Cc or BCc specified.
;					@ERROR = 2   	- OutlookWarning1.exe not found.
;					@ERROR = 9   	- ObjEvent error.
;
; Send a mail to "name@domain.com" in Rich Text, attachin 3 files
;_OutlookSendMail($oOutlook, "name@domain.com","","", "Header", "The Body Rich Text","c:\temp\xx.txt;c:\temp\aa.txt;c:\temp\bb.txt;c:\temp\cc.txt",$olFormatRichText,"","V:\Source code\Outlook\OutlookWarning1.exe")
; Send a mail to "name@domain.com", cc: "other@domain.com" in HTML format, attaching 1 file 
;_OutlookSendMail($oOutlook, "name@domain.com","other@domain.com","", "Header", "The Body HTML","c:\temp\xx.txt",$olFormatHTML,"","V:\Source code\Outlook\OutlookWarning1.exe")



; ===============================================================================================================================
; Function Name:    _OutlookGetMail()
; Description:      Get all email using Microsoft Outlook.
; Syntax.........:  _OutlookGetMail($oOutlook, $sFolder = $olFolderInbox, $fSubFolder = False, $sFrom = "", $sTo = "", $sCc = "", $sBCc = "", $sSubject = "", $iImportance = "", $fOnlyReturnUnread = False, $sWarningClick = "", $iSetStatus = 0)
; Parameter(s):     $oOutlook 			- Outlook object opened by a preceding call to _OutlookOpen()
;                   $sFolder       		- Optional: Folder, default = $olFolderInbox, add subfolders if wish to start search at a lower level, ex: $olFolderInbox & "\Archive"
;                   $fSubFolders   		- Optional: Search subfolders, default = False
;                   $sFrom        		- Optional: The e-mail address of the sender
;                   $sTo           		- Optional: The recipiant(s)
;                   $sCc         		- Optional: The CC recipiant(s) of the mail
;                   $sBCc        		- Optional: The BCC recipiant(s) of the mail
;					$sSubject      		- Optional: The Subject of the mail
;                   $iImportance 		- Optional: The Importance of the mail
;					$fOnlyReturnUnread 	- Optional: Default = False, set to True if you only wish the unread.
;					$sWarningClick		- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
;					$iSetStatus			- Optional: - 0 - Don't change status
;													  1 - Set as Read
;													  2 - Set as UnRead
;													  3 - Change status Read > Unread, Unread > Read
;					$fCountMailOnly		- False - Report all
;										  True  - Report only number of items
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Array in the following format: [10000][16]
;									  [0][0] - Total Number of items
;									  [0][1] - Number of unread items
;									  [1][0] - Sender name
;									  [1][1] - Sender Email address
;									  [1][2] - To
;									  [1][3] - Cc
;									  [1][4] - Bcc
;									  [1][5] - ReceivedTime
;									  [1][6] - SentOn
;									  [1][7] - Subject
;									  [1][8] - Folder
;									  [1][9] - Body
;									  [1][10] - BodyFormat
;									  [1][11] - Importance
;									  [1][12] - Unread
;									  [1][13] - Size
;									  [1][14] - FlagIcon
;									  [1][15] - Attachments
;									  [1][16] - Class - $olMail, $olMeetingRequest Or $olTaskRequest
;									  [n][n] - Item n
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 2   	- OutlookWarning2.exe not found.
;					@ERROR = 3   	- No Mail found/Folder not found.
;					@ERROR = 4 		- More than 9999 Mail, the first 9999 mail will be returned
;					@ERROR = 5 		- Mailfolder not found
;					@ERROR = 9   	- ObjEvent error.
;
; Search Inbox for all mail from everybody, including all subfolders.
;$xx = _OutlookGetMail($oOutlook,$olFolderInbox  ,False,"","","","","","",False,"V:\Source Code\Outlook\OutlookWarning2.exe",0)
; Search Inbox\ToSave for mail from "First User", not including subfolders.
;$xx = _OutlookGetMail($oOutlook,$olFolderInbox & "\ToSave",False,"First User","","","","","",False,"V:\Source Code\Outlook\OutlookWarning2.exe",0)
;_Arraydisplay($xx)
; Search Inbox for mail, only counting the total numbers and the numbers unread
;$xx = _OutlookGetMail($oOutlook,$olFolderInbox ,False,"","","","","","",True,"V:\Source Code\Outlook\OutlookWarning2.exe",0,True)
;_Arraydisplay($xx)


; ===============================================================================================================================
; Function Name:    _OutlookSaveMail()
; Description:      Save an email from Microsoft Outlook, you must specify enough parameters so you will have a unique mail.
; Syntax.........:  _OutlookSaveMail($oOutlook, $sFolder = $olFolderInbox, $sFrom = "", $sSubject = "", $sReceivedTime = "", $sSaveFormat = $olMSG, $sSaveDir = "", $sWarningClick = "", $iSetStatus = 0)
; Parameter(s):     $oOutlook 		- Outlook object opened by a preceding call to _OutlookOpen()
;                   $sFolder       	- Optional: Folder, default = $olFolderInbox, add subfolders if wish to start search at a lower level, ex: $olFolderInbox & "\Archive"
;                   $sFrom        	- Optional: The e-mail address of the sender
;					$sSubject      	- Optional: The Subject of the mail
;                   $sReceivedTime 	- Optional: The Time the mail is received
;                   $sSaveFormat 	- Optional: Format to save the mail in, default = $olMSG, other values: $olTXT, $olHTML
;                   $sSaveDir 		- Optional: Directory to save the message and attachments, if not specified: attached files will not be saved.
;                   $sWarningClick 	- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
;					$iSetStatus		- Optional: - 0 - Don't change status
;												  1 - Set as Read
;												  2 - Set as UnRead
;												  3 - Change status Read > Unread, Unread > Read
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Array containing
;									  [0] - Number of saved files, message and attachments
;									  [1] - Directory and Filename of the saved mail.
;									  [2] - Directory and Filename of the first saved file.
;									  [n] - Directory and Filename of the [n] saved file.
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 2   	- OutlookWarning2.exe not found.
;					@ERROR = 3   	- Mail not found/Folder not found.
;					@ERROR = 4 		- Directory specified doesn't exist
;					@ERROR = 5 		- More than one mail found
;					@ERROR = 9   	- ObjEvent error.
;
;Save a mail with the Subject "Testing" in HTML format in C:\Temp
;$xx = _OutlookSaveMail($oOutlook,$olFolderInbox,"","Testing","",$olHTML,"C:\Temp","V:\Source Code\Outlook\OutlookWarning2.exe",0)
;Save a mail from "FirstName SirName" in Msg format in C:\Temp
;$xx = _OutlookSaveMail($oOutlook,$olFolderInbox,"FirstName SirName","","",$olMSG,"C:\Temp","V:\Source Code\Outlook\OutlookWarning2.exe",0)
;_Arraydisplay($xx)


; ===============================================================================================================================
; Function Name:    _OutlookDeleteMail()
; Description:      Delete one or more email from Microsoft Outlook, you must specify enough parameters so you will have a unique mail or set $fDeleteMultipleMail = True
; Syntax.........:  _OutlookDeleteMail($oOutlook, $sFolder = $olFolderInbox, $sFrom = "", $sSubject = "", $sReceivedTime = "", $fDeleteMultipleMail = False, $fRemoveFromDeletedItems = False, $sWarningClick = "")
; Parameter(s):     $oOutlook 				- Outlook object opened by a preceding call to _OutlookOpen()
;                   $sFolder  	     		- Optional: Folder, default = $olFolderInbox, add subfolders if wish to start search at a lower level, ex: $olFolderInbox & "\Archive"
;                   $sFrom      	  		- Optional: The e-mail address of the sender
;					$sSubject 		     	- Optional: The Subject of the mail
;                   $sReceivedTime		 	- Optional: The Time the mail is received
;                   $fDeleteMultipleMail 	- Optional: Default: False, True - If you wish to delete multiple files
;                   $fRemoveFromDeletedItems- Optional: Default: False, True - If you wish to delete the files from Deleted Items as well
;                   $sWarningClick 			- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success			   	- Array containing
;											  [0] - Number of deleted mails
;											  [1] - Deleted Mail 1
;											  [2] - Deleted Mail 2
;											  [n] - Deleted Mail n
;                   On Failure		   		- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 				- Illegal parameters 
;					@ERROR = 2   			- OutlookWarning2.exe not found.
;					@ERROR = 3   			- Mail not found/Folder not found.
;					@ERROR = 4 				- More than one mail found, and $fDeleteMultipleMail = False
;					@ERROR = 9  	 		- ObjEvent error.
;
; Delete all mail with the Subject "Test" from the inbox, delete them from "Deleted items" as well
;$xx = _OutlookDeleteMail($oOutlook,$olFolderInbox,"","Test","",True,True,"V:\Source Code\Outlook\OutlookWarning2.exe")
; Delete a mail with the Subject "Test" from "User12" in the inbox
;$xx = _OutlookDeleteMail($oOutlook,$olFolderInbox,"User12","Test","",False,False,"V:\Source Code\Outlook\OutlookWarning2.exe")
;_Arraydisplay($xx)