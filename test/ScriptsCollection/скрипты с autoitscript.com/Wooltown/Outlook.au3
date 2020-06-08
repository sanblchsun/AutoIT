#include-once
#Include <Date.au3>
#Include <Array.au3>
; #INDEX# =======================================================================================================================
; Title .........: 	Outlook
; AutoIt Version: 	3.3.0
; Language:       	English
; Description ...: 	Functions that assist with MS Outlook
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_OutlookOpen
;_OutlookSendMail
;_OutlookGetMail
;_OutlookSaveMail
;_OutlookDeleteMail
;_OutlookCopyMail - Not started
;_OutlookMoveMail - Not started
;_OutlookCreateNote
;_OutlookGetNotes
;_OutlookDeleteNote
;_OutlookModifyNote
;_OutlookCreateTask
;_OutlookGetTasks
;_OutlookDeleteTask
;_OutlookModifyTask
;_OutlookCreateAppointment
;_OutlookGetAppointments
;_OutlookModifyAppointment - Modify single appointment in a recurring appointment doesn't work.
;_OutlookDeleteAppointment - Not started
;_OutlookCreateContact
;_OutlookGetContacts
;_OutlookModifyContact - Not started
;_OutlookDeleteContact - Not started
;_OutlookCreateDistList
;_OutlookGetDistLists
;_OutlookDeleteDistList
;_OutlookDeleteDistListMember
;_OutlookModifyDistList - Not working
;_OutlookFolderExist
;_OutlookFolderAdd
;_OutlookFolderDelete
;_OutlookError
; ===============================================================================================================================

const $olForward=2
const $olReply=0
const $olReplyAll=1
const $olReplyFolder=3
const $olRespond=4
const $olEmbedOriginalItem=1
const $olIncludeOriginalText=2
const $olIndentOriginalText=3
const $olLinkOriginalItem=4
const $olOmitOriginalText=0
const $olReplyTickOriginalText=1000
const $olUserPreference=5
const $olOpen=0
const $olPrompt=2
const $olSend=1
const $olDontShow=0
const $olMenu=1
const $olMenuAndToolbar=2
const $olByReference=4
const $olByValue=1
const $olEmbeddeditem=5
const $olOLE=6
const $olFormatHTML=2
const $olFormatPlain=1
const $olFormatRichText=3
const $olFormatUnspecified=0
const $olBusy=2
const $olFree=0
const $olOutOfOffice=3
const $olTentative=1
const $olLowBandwidth=200
const $olFriday=32
const $olMonday=2
const $olSaturday=64
const $olSunday=1
const $olThursday=16
const $olTuesday=4
const $olWednesday=8
const $olFolderCalendar=9
const $olFolderContacts=10
const $olFolderDeletedItems=3
const $olFolderDrafts=16
const $olFolderInbox=6
const $olFolderJournal=11
const $olFolderJunk=23
const $olFolderNotes=12
const $olFolderOutbox=4
const $olFolderSentMail=5
const $olFolderTasks=13
const $olPublicFoldersAllPublicFolders=18
const $olFolderConflicts=19
const $olFolderLocalFailures=21
const $olFolderServerFailures=22
const $olFolderSyncIssues=20
const $olAgent=3
const $olDistList=1
const $olForum=2
const $olOrganization=4
const $olPrivateDistList=5
const $olRemoteUser=6
const $olUser=0
const $olFullItem=1
const $olHeaderOnly=0
const $olEditorHTML=2
const $olEditorRTF=3
const $olEditorText=1
const $olEditorWord=4
const $olCachedConnectedDrizzle=600
const $olCachedConnectedFull=700
const $olCachedConnectedHeaders=500
const $olCachedDisconnected=400
const $olCachedOffline=200
const $olDisconnected=300
const $olNoExchange=0
const $olOffline=100
const $olOnline=800
const $olBlueFlagIcon=5
const $olGreenFlagIcon=3
const $olNoFlagIcon=0
const $olOrangeFlagIcon=2
const $olPurpleFlagIcon=1
const $olRedFlagIcon=6
const $olYellowFlagIcon=4
const $olFlagComplete=1
const $olFlagMarked=2
const $olNoFlag=0
const $olFolderDisplayFolderOnly=1
const $olFolderDisplayNoNavigation=2
const $olFolderDisplayNormal=0
const $olDefaultRegistry=0
const $olFolderRegistry=3
const $olOrganizationRegistry=4
const $olPersonalRegistry=2
const $olFemale=1
const $olMale=2
const $olUnspecified=0
const $olImportanceHigh=2
const $olImportanceLow=0
const $olImportanceNormal=1
const $olDiscard=1
const $olPromptForSave=2
const $olSave=0
const $olAppointmentItem=1
const $olContactItem=2
const $olDistributionListItem=7
const $olJournalItem=4
const $olMailItem=0
const $olNoteItem=5
const $olPostItem=6
const $olTaskItem=3
const $olAssociatedContact=1
const $olBusiness=2
const $olHome=1
const $olNone=0
const $olOther=3
const $olBCC=3
const $olCC=2
const $olOriginator=0
const $olTo=1
const $olOptional=2
const $olOrganizer=0
const $olRequired=1
const $olResource=3
const $olMeetingAccepted=3
const $olMeetingDeclined=4
const $olMeetingTentative=2
const $olMeeting=1
const $olMeetingCanceled=5
const $olMeetingReceived=3
const $olNonMeeting=0
const $olExchangeConferencing=2
const $olNetMeeting=0
const $olNetShow=1
const $olBlue=0
const $olGreen=1
const $olPink=2
const $olWhite=4
const $olYellow=3
const $olAction=32
const $olActions=33
const $olAddressEntries=21
const $olAddressEntry=8
const $olAddressList=7
const $olAddressLists=20
const $olApplication=0
const $olAppointment=26
const $olAttachment=5
const $olAttachments=18
const $olConflict=117
const $olConflicts=118
const $olContact=40
const $olDistributionList=69
const $olDocument=41
const $olException=30
const $olExceptions=29
const $olExplorer=34
const $olExplorers=60
const $olFolder=2
const $olFolders=15
const $olFormDescription=37
const $olInspector=35
const $olInspectors=61
const $olItemProperties=98
const $olItemProperty=99
const $olItems=16
const $olJournal=42
const $olLink=75
const $olLinks=76
const $olMail=43
const $olMeetingCancellation=54
const $olMeetingRequest=53
const $olMeetingResponseNegative=55
const $olMeetingResponsePositive=56
const $olMeetingResponseTentative=57
const $olNamespace=1
const $olNote=44
const $olOutlookBarGroup=66
const $olOutlookBarGroups=65
const $olOutlookBarPane=63
const $olOutlookBarShortcut=68
const $olOutlookBarShortcuts=67
const $olOutlookBarStorage=64
const $olPages=36
const $olPanes=62
const $olPost=45
const $olPropertyPages=71
const $olPropertyPageSite=70
const $olRecipient=4
const $olRecipients=17
const $olRecurrencePattern=28
const $olReminder=101
const $olReminders=100
const $olRemote=47
const $olReport=46
const $olResults=78
const $olSearch=77
const $olSelection=74
const $olSyncObject=72
const $olSyncObjects=73
const $olTask=48
const $olTaskRequest=49
const $olTaskRequestAccept=51
const $olTaskRequestDecline=52
const $olTaskRequestUpdate=50
const $olUserProperties=38
const $olUserProperty=39
const $olView=80
const $olViews=79
const $olExcelWorkSheetItem=8
const $olPowerPointShowItem=10
const $olWordDocumentItem=9
const $olLargeIcon=0
const $olSmallIcon=1
const $olFolderList=2
const $olNavigationPane=4
const $olOutlookBar=1
const $olPreview=3
const $olDoNotForward=1
const $olPermissionTemplate=2
const $olUnrestricted=0
const $olUnknown=0
const $olWindows=1
const $olPassport=2
const $olApptException=3
const $olApptMaster=1
const $olApptNotRecurring=0
const $olApptOccurrence=2
const $olRecursDaily=0
const $olRecursMonthly=2
const $olRecursMonthNth=3
const $olRecursWeekly=1
const $olRecursYearly=5
const $olRecursYearNth=6
const $olMarkedForCopy=3
const $olMarkedForDelete=4
const $olMarkedForDownload=2
const $olRemoteStatusNone=0
const $olUnMarked=1
const $olResponseAccepted=3
const $olResponseDeclined=4
const $olResponseNone=0
const $olResponseNotResponded=5
const $olResponseOrganized=1
const $olResponseTentative=2
const $olDoc=4
const $olHTML=5
const $olICal=8
const $olMSG=3
const $olMSGUnicode=9
const $olRTF=1
const $olTemplate=2
const $olTXT=0
const $olVCal=7
const $olVCard=6
const $olConfidential=3
const $olNormal=0
const $olPersonal=1
const $olPrivate=2
const $olNoItemCount=0
const $olShowTotalItemCount=2
const $olShowUnreadItemCount=1
const $olAscending=1
const $olDescending=2
const $olSortNone=0
const $olStoreANSI=3
const $olStoreDefault=1
const $olStoreUnicode=2
const $olSyncStarted=1
const $olSyncStopped=0
const $olTaskDelegationAccepted=2
const $olTaskDelegationDeclined=3
const $olTaskDelegationUnknown=1
const $olTaskNotDelegated=0
const $olDelegatedTask=1
const $olNewTask=0
const $olOwnTask=2
const $olFinalStatus=3
const $olUpdate=2
const $olTaskAccept=2
const $olTaskAssign=1
const $olTaskDecline=3
const $olTaskSimple=0
const $olTaskComplete=2
const $olTaskDeferred=4
const $olTaskInProgress=1
const $olTaskNotStarted=0
const $olTaskWaiting=3
const $olTrackingDelivered=1
const $olTrackingNone=0
const $olTrackingNotDelivered=2
const $olTrackingNotRead=3
const $olTrackingRead=6
const $olTrackingRecallFailure=4
const $olTrackingRecallSuccess=5
const $olTrackingReplied=7
const $olCombination=19
const $olCurrency=14
const $olDateTime=5
const $olDuration=7
const $olFormula=18
const $olKeywords=11
const $olNumber=3
const $olOutlookInternal=0
const $olPercent=12
const $olText=1
const $olYesNo=6
const $olViewSaveOptionAllFoldersOfType=2
const $olViewSaveOptionThisFolderEveryone=0
const $olViewSaveOptionThisFolderOnlyMe=1
const $olCalendarView=2
const $olCardView=1
const $olIconView=3
const $olTableView=0
const $olTimelineView=4

;===============================================================================
;
; Function Name:    _OutlookOpen()
; Description:      Open a connection to Microsoft Outlook.
; Syntax.........:  _OutlookOpen()
; Parameter(s):     None
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success 		- Returns new object identifier
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1   	- Unable to Create Outlook Object.
; Author(s):        Wooltown
; Created:          2009-02-09       
; Modified:         -
;
;===============================================================================
Func _OutlookOpen()
	Local $oOutlook = ObjCreate("Outlook.Application")
	If @error Or Not IsObj($oOutlook) Then
		Return SetError(1, 0, 0)
	EndIf
	Return $oOutlook
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-02-09       
; Modified:         2009-02-24		- Several attachments didn't work
;
;===============================================================================
Func _OutlookSendMail($oOutlook, $sTo = "", $sCc = "", $sBcc = "", $sSubject = "", $sBody = "", $sAttachments = "", $iBodyFormat = $olFormatPlain, $iImportance = $olImportanceNormal, $sWarningClick = "")
	Local $iRc = 0, $asAttachments
	If $sTo = "" And $sCc = "" And $sBCc = "" Then
		Return SetError(1, 0, 0)
	EndIf
	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
		Return SetError(2, 0, 0)
	Else
		Run($sWarningClick)
	EndIf
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oMessage = $oOutlook.CreateItem($olMailItem)
    $oMessage.To = $sTo
    $oMessage.Cc = $sCc
    $oMessage.Bcc = $sBCc
    $oMessage.Subject = $sSubject
    $oMessage.Body = $sBody
    $oMessage.BodyFormat = $iBodyFormat
    $oMessage.Importance = $iImportance
    If $sAttachments <> "" Then 
    	$asAttachments = StringSplit($sAttachments,";")
    	For $iNumOfAttachments = 1 to $asAttachments[0]
    		$oMessage.Attachments.Add($asAttachments[$iNumOfAttachments])	
    	Next
    EndIf
    $oMessage.Send
    $iRc = @ERROR
    If $iRc = 0 Then
    	Return 1
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
; Function Name:    _OutlookGetMail()
; Description:      Get all email using Microsoft Outlook.
; Syntax.........:  _OutlookGetMail($oOutlook, $sFolder = $olFolderInbox, $fSubFolder = False, $sFrom = "", $sTo = "", $sCc = "", $sBCc = "", $sSubject = "", $iImportance = "", $fOnlyReturnUnread = False, $sWarningClick = "", $iSetStatus = 0, $fCountMailOnly = False)
; Parameter(s):     $oOutlook 			- Outlook object opened by a preceding call to _OutlookOpen()
;                   $sFolder       		- Optional: Folder, default = $olFolderInbox, add subfolders if wish to start search at a lower level, ex: $olFolderInbox & "\Archive"
;													If you wish to access the root, use "\", Sent Items, write "\Sent Items"
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
; Author(s):        Wooltown
; Created:          2009-02-25       
; Modified:         2009-03-02
;					2009-03-10		- If folder not found, an error occured
;					2009-06-08		- Added $fCountMailOnly
;
;===============================================================================
Func _OutlookGetMail($oOutlook, $sFolder = $olFolderInbox, $fSubFolders = False, $sFrom = "", $sTo = "", $sCc = "", $sBCc = "", $sSubject = "", $iImportance = "", $fOnlyReturnUnread = False, $sWarningClick = "", $iSetStatus = 0, $fCountMailOnly = False)
	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
		Return SetError(2, 0, 0)
	Else
		Run($sWarningClick)
	EndIf
	Local $fRoot = False, $oFolder, $fOtherMailBox = False
	If StringLeft($sFolder,2) = "\\" Then 
		$fOtherMailBox = True
		Local $asFolderID = StringSplit(StringMid($sFolder,3),"\\",1)
		_Arraydisplay($asFolderID)
	Else 
		If StringLeft($sFolder,1) = "\" Then 
			$fRoot = True
			$sFolder = StringMid($sFolder,2)
		EndIf
	EndIf
	If $iImportance < 0 Or $iImportance > 2 Then Return SetError(1, 0, 0)
	If $fCountMailOnly = True Then 
		Local $asMail[1][2]
	Else
		Local $asMail[10000][17]
	EndIf
	Local $iRc = 0, $iFolderFound = 1
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	If StringRight($sFolder,1) = "\" Then $sFolder = StringLeft($sFolder,StringLen($sFolder) - 1)
	Local $sSubFolderParts = StringSplit ( $sFolder, "\"), $sFolderName
	If $fOtherMailBox = True Then
		Local $oSession = $oOutlook.Session
		$oFolder = $oSession.GetFolderFromID($asFolderID[1], $asFolderID[2])
		msgbox(0,"obj",isobj($oFolder))
	EndIf
	If $fRoot = True Then 
		$sSubFolderParts[0] = 0
		Local $oInbox = $oNamespace.GetDefaultFolder($olFolderInbox)
		If $sFolder = "" Then 
			$oFolder = $oInbox.Parent
	    Else
	    	$sFolderName = $oInbox.Parent
	    	;$sFolderName = $sFolderName.Parent
		 	For $idx = 1 To $sFolderName.Folders.Count
	        	If $sFolderName.Folders.Item($idx).Name = $sFolder Then $oFolder = $sFolderName.Folders.Item($idx)
	    	Next
	    EndIf
	Else
		If $fOtherMailBox = False Then $oFolder = $oNamespace.GetDefaultFolder($sSubFolderParts[1])
	EndIf
	If IsObj($oFolder) = 0 Then Return SetError(5, 0, 0)
	Local $sRootFolderName = $oFolder.Name
	msgbox(0,"folder",$sRootFolderName)
	$asMail[0][0] = 0
	$asMail[0][1] = 0
	If $fOtherMailBox = False And $sSubFolderParts[0] > 1  Then
		$iFolderFound = _OutlookFindRootFolder($oFolder,$sRootFolderName,StringMid($sFolder,StringInStr($sFolder,"\")+ 1))
	EndIf
	If $iFolderFound = 0 Then Return SetError(5, 0, 0)
	_OutlookFindMailInTree($asMail, $oFolder, $sRootFolderName, $fSubFolders, $sFrom, $sTo, $sCc, $sBCc, $sSubject, $iImportance, $fOnlyReturnUnread, $iSetStatus, $fCountMailOnly)
	$iRc = @ERROR
	If $iRc = 4 Then SetError (4)
    If $asMail[0][0] = 0 Then Return SetError(3, 0, 0)
    If $fCountMailOnly = False Then 
	    If $fOnlyReturnUnread = True Then
	    	Redim $asMail[$asMail[0][1] + 1][17]
		Else
			Redim $asMail[$asMail[0][0] + 1][17]
		EndIf
		_ArraySort($asMail,1,1,0,5)
	EndIf
	Return $asMail
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-02-27       
; Modified:         -
;
;===============================================================================
Func _OutlookSaveMail($oOutlook, $sFolder = $olFolderInbox, $sFrom = "", $sSubject = "", $sReceivedTime = "", $sSaveFormat = $olMSG, $sSaveDir = "", $sWarningClick = "", $iSetStatus = 0)
	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
		Return SetError(2, 0, 0)
	Else
		Run($sWarningClick)
	EndIf
	Local $fRoot = False, $oFolder
	If StringLeft($sFolder,1) = "\" Then 
		$fRoot = True
		$sFolder = StringMid($sFolder,2)
	EndIf
	Local $sRootFolderName, $iRc = 0, $iAttachCnt, $oFilteredItems, $sFilter = "", $sFileName, $oTemp, $asResult[999], $sSuffix
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $sSubFolderParts = StringSplit ( $sFolder, "\")
	$oFolder = $oNamespace.GetDefaultFolder($sSubFolderParts[1])
	If $fRoot = True Then 
		$sSubFolderParts[0] = 0
		Local $oInbox = $oNamespace.GetDefaultFolder($olFolderInbox)
		If $sFolder = "" Then 
			$oFolder = $oInbox.Parent
	    Else
	    	Local $sFolderName = $oInbox.Parent
		 	For $idx = 1 To $sFolderName.Folders.Count
	        	If $sFolderName.Folders.Item($idx).Name = $sFolder Then $oFolder = $sFolderName.Folders.Item($idx)
	    	Next
	    EndIf
	Else
		$oFolder = $oNamespace.GetDefaultFolder($sSubFolderParts[1])
	EndIf
	If $sFrom = "" And $sSubject = "" And $sReceivedTime = "" Then Return SetError(1, 0, 0)
	If Not ($sSaveFormat = $olMSG Or $sSaveFormat = $olTXT Or $sSaveFormat = $olHTML) Then Return SetError(1, 0, 0)
	Switch $sSaveFormat
		Case $olMSG	
			$sSuffix = ".msg"
		Case $olTXT
			 $sSuffix = ".txt"
		Case $olHTML
			$sSuffix = ".html"
	EndSwitch
	If FileExists($sSaveDir) = 0 Or StringInStr(FileGetAttrib ($sSaveDir),"D") = 0 Then Return SetError(4, 0, 0)
	If StringRight($sSaveDir,1) <> "\" Then $sSaveDir &= "\"
	$sRootFolderName = $oFolder.Name
	$asResult[0] = 0
	If $sSubFolderParts[0] > 1  Then
		_OutlookFindRootFolder($oFolder,$sRootFolderName,StringMid($sFolder,StringInStr($sFolder,"\")+ 1))
	EndIf
	Local $oMailItems = $oFolder.Items
	If $sFrom <> "" Then
		$sFilter = '[SenderName] = "' & $sFrom & '"'
	EndIf
	If $sSubject <> "" Then
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[Subject] = "' & $sSubject & '"'
	EndIf
	If $sReceivedTime <> "" Then
		If Not _DateIsValid($sReceivedTime) Then Return SetError(1, 0, 0)
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[ReceivedTime] = "' & $sReceivedTime & '"'
	EndIf	
	$oFilteredItems = $oMailItems.Restrict($sFilter)
	If $oFilteredItems.Count = 0 Then Return SetError(3, 0, 0)
	If $oFilteredItems.Count > 1 Then Return SetError(5, 0, 0)
	For $oItem In $oFilteredItems
		$sSubject = StringRegExpReplace($oItem.Subject,'[\/:*?"<>|]', '_')
		$oItem.SaveAs ($sSaveDir & $sSubject & $sSuffix, $sSaveFormat )
		$asResult[0] += 1
		$asResult[$asResult[0]] = $sSaveDir & $sSubject & $sSuffix
		If $sSaveDir <> "" Then
			$iAttachCnt = $oItem.Attachments.Count
			If $iAttachCnt > 0 Then
				For $iAttachNum = 1 to $iAttachCnt
					$oTemp = $oItem.Attachments.Item($iAttachNum)
					$sFileName = $iAttachNum & "_" & $oTemp.FileName
					$oTemp = $oItem.Attachments.Item($iAttachNum)
					$asResult[0] += 1
					$asResult[$asResult[0]] = $sSaveDir & $sFileName
					$oTemp.SaveAsFile ($sSaveDir & $sFileName )
				Next
			EndIf
		EndIf
		Switch $iSetStatus
			Case 1
				$oItem.UnRead = False
			Case 2
				$oItem.UnRead = True
			Case 3
				If $oItem.UnRead = False Then
					$oItem.UnRead = True
				Else
					$oItem.UnRead = False
				EndIf
		EndSwitch
	Next
 	$iRc = @ERROR
 	If $iRc = 0 Then
    	Redim $asResult[$asResult[0] + 1]
		Return $asResult
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-02-27       
; Modified:         -
;
;===============================================================================
Func _OutlookDeleteMail($oOutlook, $sFolder = $olFolderInbox, $sFrom = "", $sSubject = "", $sReceivedTime = "", $fDeleteMultipleMail = False, $fRemoveFromDeletedItems = False, $sWarningClick = "")
	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
		Return SetError(2, 0, 0)
	Else
		Run($sWarningClick)
	EndIf
	Local $sRootFolderName, $iRc = 0, $oFilteredItems, $sFilter = "", $asResult[999], $aoDelete[999], $oDelete
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $sSubFolderParts = StringSplit ( $sFolder, "\")
	Local $oFolder = $oNamespace.GetDefaultFolder($sSubFolderParts[1])
	If $sFrom = "" And $sSubject = "" And $sReceivedTime = "" Then Return SetError(1, 0, 0)
	$sRootFolderName = $oFolder.Name
	$asResult[0] = 0
	If $sSubFolderParts[0] > 1  Then
		_OutlookFindRootFolder($oFolder,$sRootFolderName,StringMid($sFolder,StringInStr($sFolder,"\")+ 1))
	EndIf
	Local $oMailItems = $oFolder.Items
	If $sFrom <> "" Then
		$sFilter = '[SenderName] = "' & $sFrom & '"'
	EndIf
	If $sSubject <> "" Then
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[Subject] = "' & $sSubject & '"'
	EndIf
	If $sReceivedTime <> "" Then
		If Not _DateIsValid($sReceivedTime) Then Return SetError(1, 0, 0)
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[ReceivedTime] = "' & $sReceivedTime & '"'
	EndIf	
	$oFilteredItems = $oMailItems.Restrict($sFilter)
	If $oFilteredItems.Count = 0 Then Return SetError(3, 0, 0)
	If $oFilteredItems.Count > 1 And $fDeleteMultipleMail = False Then Return SetError(4, 0, 0)
	For $oItem In $oFilteredItems
		$asResult[0] += 1
		$asResult[$asResult[0]] = $oItem.Subject & " - " & $oItem.SenderName & " - " & $oItem.ReceivedTime
		$aoDelete[$asResult[0]] = $oItem
	Next
	For $iDeleteNr = 1 To $asResult[0]
		$oDelete = $aoDelete[$iDeleteNr]
		$oDelete.Delete
	Next
	If $fRemoveFromDeletedItems = True Then	_OutlookDeleteMail($oOutlook, $olFolderDeletedItems, $sFrom, $sSubject, $sReceivedTime, True, False, $sWarningClick)
 	$iRc = @ERROR
 	If $iRc = 0 or $iRc = 1 Then
    	Redim $asResult[$asResult[0] + 1]
		Return $asResult
    Else
   		Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-02-09       
; Modified:         -
;
;===============================================================================
Func _OutlookCreateNote($oOutlook, $sSubject, $sBody = "", $sCategories = "", $iColor = "")
	Local $iRc = 0
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNote = $oOutlook.CreateItem($olNoteItem)
    $oNote.Categories = $sCategories
    $oNote.Body = $sSubject & @CRLF & $sBody
    $oNote.Color = $iColor
    $oNote.Close ($olSave)
        $iRc = @ERROR
    If $iRc = 0 Then
    	Return 1
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-03-02
; Modified:         -
;
;===============================================================================
Func _OutlookGetNotes($oOutlook,$sWarningClick = "")
 	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
 		Return SetError(2, 0, 0)
 	Else
 		Run($sWarningClick)
 	EndIf
	Local $avNotes[1000][6]
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	$avNotes[0][0] = 0
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderNotes)
	Local $oColItems = $oFolder.Items
	$oColItems.Sort("[Subject]")
	For $oItem In $oColItems
 			If $avNotes[0][0] = 999 Then
 				SetError (3)
 				Return $avNotes
 			EndIf
 			$avNotes[0][0] += 1
 			$avNotes[$avNotes[0][0]][0] = $oItem.Subject
 			$avNotes[$avNotes[0][0]][1] = $oItem.Body
 			$avNotes[$avNotes[0][0]][2] = $oItem.Color
 			$avNotes[$avNotes[0][0]][3] = $oItem.Categories
 			$avNotes[$avNotes[0][0]][4] = $oItem.CreationTime
 			$avNotes[$avNotes[0][0]][5] = $oItem.LastModificationTime
	Next
	$oItem = ""
	$oColItems = ""
	$oFolder = ""
	$oNamespace = ""
	If $avNotes[0][0] = 0 Then Return SetError(2, 0, 0)
	Redim $avNotes[$avNotes[0][0] + 1][6]
	Return $avNotes
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-03-02
; Modified:         -
;
;===============================================================================
Func _OutlookDeleteNote($oOutlook, $sSubject, $fDeleteMultipleNotes = False, $sWarningClick = "")
 	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
 		Return SetError(2, 0, 0)
 	Else
 		Run($sWarningClick)
 	EndIf
	Local $avNotes[1000], $oDelete, $aoDelete[1000]
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	$avNotes[0] = 0
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderNotes)
	Local $oColItems = $oFolder.Items
	Local $oFilteredItems = $oColItems.Restrict('[Subject] = "' & $sSubject & '"')
	$oColItems.Sort("[Subject]")
	If $oFilteredItems.Count > 999 Then Return SetError(3, 0, 0)
	If $oFilteredItems.Count = 0 Then Return SetError(4, 0, 0)
	If $oFilteredItems.Count > 1 and $fDeleteMultipleNotes = False Then Return SetError(5, 0, 0)
	For $oItem In $oFilteredItems
		$avNotes[0] += 1
		$avNotes[$avNotes[0]] = $oItem.Body
		$aoDelete[$avNotes[0]] = $oItem
	Next
	For $iDeleteNr = 1 To $avNotes[0]
		$oDelete = $aoDelete[$iDeleteNr]
		$oDelete.Delete
	Next
	$oItem = ""
	$oColItems = ""
	$oFolder = ""
	$oNamespace = ""
	If $avNotes[0] = 0 Then Return SetError(2, 0, 0)
	Redim $avNotes[$avNotes[0] + 1]
	Return $avNotes
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-03-02
; Modified:         -
;
;===============================================================================
Func _OutlookModifyNote($oOutlook, $sSubject, $sBody = "", $sNewSubject = "", $sNewBody = "", $sCategories = "", $iColor = "", $sWarningClick = "")
 	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
 		Return SetError(2, 0, 0)
 	Else
 		Run($sWarningClick)
 	EndIf
	Local $iRc
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderNotes)
	Local $oColItems = $oFolder.Items
	Local $oFilteredItems = $oColItems.Restrict('[Subject] = "' & $sSubject & '"')
	$oColItems.Sort("[Subject]")
	If $oFilteredItems.Count = 0 Then Return SetError(3, 0, 0)
	If $oFilteredItems.Count > 1 and $sBody = "" Then Return SetError(4, 0, 0)
	If $oFilteredItems.Count >= 1 Then
		Local $iNumFound = 0
		For $oItem In $oFilteredItems
			If StringInStr($oItem.Body,$sBody) > 0 Then $iNumFound += 1
		Next
		If $iNumFound = 0 Then Return SetError(3, 0, 0)
		If $iNumFound > 1 Then Return SetError(4, 0, 0)
	EndIf
	For $oItem In $oFilteredItems
		$oItem.Body = $sNewSubject & @CRLF & $sNewBody
		If $sCategories <> "" Then $oItem.Categories = $sCategories
		If $iColor <> "" Then 
			If $iColor < 0 And $iColor > 4 Then Return SetError(1, 0, 0)
			$oItem.Color = $iColor
		EndIf
		$oItem.Close ($olSave)
		$iRc = @ERROR
	Next
	$oItem = ""
	$oColItems = ""
	$oFolder = ""
	$oNamespace = ""
    If $iRc = 0 Then
    	Return 1
    Else
    	Return SetError(9, 0, 0)
    EndIf
	Return 1
EndFunc
;===============================================================================
;
; Function Name:    _OutlookCreateTask()
; Description:      Create a task using Microsoft Outlook.
; Syntax.........:  _OutlookCreateTask($oOutlook, $sSubject, $sBody = "", $sStartDate = "", $sDueDate = "", $iImportance = "", $sReminderDate = "", $sCategories = "")
; Parameter(s):     $oOutlook 		- Outlook object opened by a preceding call to _OutlookOpen()
; 					$sSubject      	- The Subject of the Task
;                   $sBody         	- Optional: The Body of the Task
;					$sStartDate		- Optional: Start date of the task
;					$sDueDate		- Optional: End date the Task should be complete
;					$iImportance 	- Optional: The Importance of the task, default = $olImportanceNormal
;					$sReminderDate	- Optional: When you should be reminded of the task, Date and time
;					$sCategories	- Optional: Categories for the note, separated by ;
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Returns 1
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 9   	- ObjEvent error.
; Author(s):        Wooltown
; Created:          2009-02-09       
; Modified:         -
;
;===============================================================================
Func _OutlookCreateTask($oOutlook, $sSubject, $sBody = "", $sStartDate = "", $sDueDate = "", $iImportance = "", $sReminderDate = "", $sCategories = "")
	Local $iRc = 0
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNote = $oOutlook.CreateItem($olTaskItem)
    $oNote.Subject = $sSubject
    $oNote.Body = $sBody
    $oNote.StartDate = $sStartDate
    $oNote.DueDate  = $sDueDate
    $oNote.Importance = $iImportance
    $oNote.Categories = $sCategories
    If $sReminderDate <> "" Then
    	$oNote.ReminderTime = $sReminderDate
    	$oNote.ReminderSet = True
    EndIf
    $oNote.Close ($olSave)
    $iRc = @ERROR
    If $iRc = 0 Then
    	Return 1
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
; Function Name:    _OutlookGetTasks()
; Description:      Get the Tasks in Microsoft Outlook, specify Subject and/or Date Interval and/or Status to filter
; Syntax.........:  _OutlookGetTasks($oOutlook, $sSubject = "", $sStartDate = "", $sEndDate = "", $sStatus = "", $sWarningClick = "")
; Parameter(s):     $oOutlook 			- Outlook object opened by a preceding call to _OutlookOpen().
; 					$sSubject   	   	- Optional: The Subject of the Task.
;					$sStartDate			- Optional: Start date & time of the Task, format YYYY-MM-DD HH:MM - or what is set locally.
;					$sEndDate			- Optional: End date & time of the Task, format YYYY-MM-DD HH:MM - or what is set locally.
;					$sStatus			- Optional: The status of the Task:
;										  $olTaskNotStarted=0
;										  $olTaskInProgress=1
;										  $olTaskComplete=2
;										  $olTaskWaiting=3
;										  $olTaskDeferred=4
;                   $sWarningClick 		- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   		- Array in the following format: [1000][6]
;										  [0][0] - Number of items
;										  [0][1] - Number of items not started
;										  [1][0] - Subject
;										  [1][1] - StartDate
;										  [1][2] - EndDate
;										  [1][3] - sStatus
;										  [1][4] - Priority
;										  [1][5] - Complete
;										  [1][6] - PercentComplete
;										  [1][7] - ReminderSet
;										  [1][8] - ReminderMinutesBeforeStart
;										  [1][9] - Owner
;										  [1][10] - Body
;										  [1][11] - Date Completed
;										  [1][12] - Total Work in minutes
;										  [1][13] - Actual work in minutes
;										  [1][14] - Mileage
;										  [1][15] - Billing Information
;										  [1][16] - Companies
;										  [1][17] - Delegator
;										  [1][18] - Categories
;										  [n][n] - Item n
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 2 		- No tasks found
;					@ERROR = 3 		- More than 999 Tasks found, the first 999 tasks will be returned.
;					@ERROR = 9   	- ObjEvent error.
; Author(s):        Wooltown
; Created:          2009-03-02
; Modified:         -
;
;===============================================================================
Func _OutlookGetTasks($oOutlook, $sSubject = "", $sStartDate = "", $sEndDate = "", $sStatus = "", $sWarningClick = "")
	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
		Return SetError(2, 0, 0)
	Else
		Run($sWarningClick)
	EndIf
	Local $avTasks[1000][19], $sFilter = "", $oFilteredItems
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	$avTasks[0][0] = 0
	$avTasks[0][1] = 0
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderTasks)
	Local $oColItems = $oFolder.Items
	$oColItems.Sort("[Start]")
	$oColItems.IncludeRecurrences = True 
	If $sSubject <> "" Then
		$sFilter = '[Subject] = "' & $sSubject & '"'
	EndIf
	If $sStartDate <> "" Then
		If Not _DateIsValid($sStartDate) Then Return SetError(1, 0, 0)
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[Start] >= "' & $sStartDate & '"'
	EndIf	
	If $sEndDate <> "" Then
		If Not _DateIsValid($sEndDate) Then Return SetError(1, 0, 0)
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[Due] <= "' & $sEndDate & '"'
	EndIf	
	If $sStatus <> "" Then
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[Status] = "' & $sStatus & '"'
	EndIf
	If $sFilter = "" Then
		$oFilteredItems = $oColItems
	Else
		$oFilteredItems = $oColItems.Restrict($sFilter)
	EndIf
	For $oItem In $oFilteredItems
 			If $avTasks[0][0] = 999 Then
 				SetError (3)
 				Return $avTasks
 			EndIf
 			$avTasks[0][0] += 1
 			$avTasks[$avTasks[0][0]][0] = $oItem.Subject
 			$avTasks[$avTasks[0][0]][1] = $oItem.StartDate
 			$avTasks[$avTasks[0][0]][2] = $oItem.DueDate
 			$avTasks[$avTasks[0][0]][3] = $oItem.Status
 			$avTasks[$avTasks[0][0]][4] = $oItem.Importance
 			$avTasks[$avTasks[0][0]][5] = $oItem.Complete
 			$avTasks[$avTasks[0][0]][6] = $oItem.PercentComplete
 			If $avTasks[$avTasks[0][0]][6] = 0 Then $avTasks[0][1] += 1
 			$avTasks[$avTasks[0][0]][7] = $oItem.ReminderSet
 			$avTasks[$avTasks[0][0]][8] = $oItem.ReminderTime
 			$avTasks[$avTasks[0][0]][9] = $oItem.Owner
 			$avTasks[$avTasks[0][0]][10] = $oItem.Body
 			$avTasks[$avTasks[0][0]][11] = $oItem.DateCompleted
 			$avTasks[$avTasks[0][0]][12] = $oItem.TotalWork
 			$avTasks[$avTasks[0][0]][13] = $oItem.ActualWork
 			$avTasks[$avTasks[0][0]][14] = $oItem.Mileage
 			$avTasks[$avTasks[0][0]][15] = $oItem.BillingInformation
 			$avTasks[$avTasks[0][0]][16] = $oItem.Companies
 			$avTasks[$avTasks[0][0]][17] = $oItem.Delegator
 			$avTasks[$avTasks[0][0]][18] = $oItem.Categories
	Next
	$oItem = ""
	$oColItems = ""
	$oFolder = ""
	$oNamespace = ""
	If $avTasks[0][0] = 0 Then Return SetError(2, 0, 0)
	Redim $avTasks[$avTasks[0][0] + 1][19]
	Return $avTasks
EndFunc
;===============================================================================
;
; Function Name:    _OutlookDeleteTask()
; Description:      Delete a Task in Microsoft Outlook, specify Subject and eventually Start Date.
; Syntax.........:  _OutlookDeleteTask($oOutlook, $sSubject, $sStartDate = "", $fDeleteMultipleTasks = False, $sWarningClick = "")
; Parameter(s):     $oOutlook 				- Outlook object opened by a preceding call to _OutlookOpen().
; 					$sSubject   		   	- The Subject of the Task.
;					$sStartDate				- Optional: Start date & time of the Task, format YYYY-MM-DD HH:MM - or what is set locally.
;					$fDeleteMultipleTasks	- Optional: Default: False, set to True to delete multiple occurences
;                   $sWarningClick 			- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   			- Array in the following format: [1000]
;											  [0] - Number of items deleted
;											  [1] - Deleted item 1
;											  [2] - Deleted item 2
;											  [n] - Deleted item n
;                   On Failure 			  	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 				- Illegal parameters 
;					@ERROR = 2   			- OutlookWarning2.exe not found.
;					@ERROR = 3 				- More than 999 Notes found matching criteria.
;					@ERROR = 4 				- 0 notes found
;					@ERROR = 5 				- More than 1 Notes found and $fDeleteMultipleFiles = False
;					@ERROR = 9   			- ObjEvent error.
; Author(s):        Wooltown
; Created:          2009-03-04
; Modified:         -
;
;===============================================================================
Func _OutlookDeleteTask($oOutlook, $sSubject, $sStartDate = "", $fDeleteMultipleTasks = False, $sWarningClick = "")
	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
		Return SetError(2, 0, 0)
	Else
		Run($sWarningClick)
	EndIf
	Local $avTasks[1000], $aoDelete[1000], $sFilter = "", $oFilteredItems
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	$avTasks[0] = 0
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderTasks)
	Local $oColItems = $oFolder.Items
	$oColItems.IncludeRecurrences = True
	$sFilter = '[Subject] = "' & $sSubject & '"'
	If $sStartDate <> "" Then
		If Not _DateIsValid($sStartDate) Then Return SetError(1, 0, 0)
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[StartDate] = "' & $sStartDate & '"'
	EndIf	
	$oFilteredItems = $oColItems.Restrict($sFilter)
	If $oFilteredItems.Count > 999 Then Return SetError(3, 0, 0)
	If $oFilteredItems.Count = 0 Then Return SetError(4, 0, 0)
	If $oFilteredItems.Count > 1 And $fDeleteMultipleTasks = False Then Return SetError(5, 0, 0)
	For $oItem In $oFilteredItems
		$avTasks[0] += 1
		$avTasks[$avTasks[0]] = $oItem.Subject & " - " & $oItem.StartDate
		$aoDelete[$avTasks[0]] = $oItem
	Next
	For $iDeleteNr = 1 To $avTasks[0]
		$oDelete = $aoDelete[$iDeleteNr]
		$oDelete.Delete
	Next
	$oItem = ""
	$oColItems = ""
	$oFolder = ""
	$oNamespace = ""
	If $avTasks[0] = 0 Then Return SetError(2, 0, 0)
	Redim $avTasks[$avTasks[0] + 1]
	Return $avTasks
EndFunc
;===============================================================================
;
; Function Name:    _OutlookModifyTask()
; Description:      Modify a Task in Microsoft Outlook, specify Subject and/or Start Date.
; Syntax.........:  _OutlookModifyTask($oOutlook, $sSubject, $sStartDate = "", $sNewSubject = "", $sNewStartDate = "", $sDueDate = "", $iStatus = "", $iImportance = "", $fComplete = "", $iPercentComplete = "", $fReminderSet = "", $sReminderTime = "", $sOwner = "", $sBody = "", $sDateCompleted = "", $iTotalWork = "", $iActualWork = "", $sMileage = "", $sBillingInformation = "", $sCompanies = "", $sDelegator = "", $sCategories = "", $sWarningClick = "")
; Parameter(s):     $oOutlook 				- Outlook object opened by a preceding call to _OutlookOpen().
; 					$sSubject   		   	- The Subject of the Task.
;					$sStartDate				- Optional: Start date & time of the Task, format YYYY-MM-DD HH:MM - or what is set locally.
;					$sNewSubject			- Optional: New Subject
;					$sNewStartDate			- Optional: New Start Date, format YYYY-MM-DD HH:MM - or what is set locally.
;					$sDueDate				- Optional: Due Date, format YYYY-MM-DD HH:MM - or what is set locally.
;					$iStatus				- Optional: $olTaskNotStarted=0
;														$olTaskInProgress=1
;														$olTaskComplete=2
;														$olTaskWaiting=3
;														$olTaskDeferred=4
;					$iImportance			- Optional: $olImportanceLow=0
;														$olImportanceNormal=1
;														$olImportanceHigh=2
;					$fComplete				- Optional: True or False, sets DateCompleted to actual Date and Time and PercentComplete = 100
;					$iPercentComplete		- Optional: Percent complete, sets DateCompleted to actual Date and Time, Sets complete to True
;					$fReminderSet			- Optional: True or False
;					$sReminderTime			- Optional: Reminder Date, format YYYY-MM-DD HH:MM - or what is set locally.
;					$sOwner					- Optional: Owner 
;					$sBody					- Optional: Body
;					$sDateCompleted			- Optional: Completed Date, format YYYY-MM-DD HH:MM - or what is set locally, also sets Complete = True and PercentComplete = 100
;					$iTotalWork				- Optional: Total Work in minutes
;					$iActualWork			- Optional: Actual Work in minutes
;					$sMileage				- Optional: Mileage
;					$sBillingInformation	- Optional: Billing Information
;					$sCompanies				- Optional: Companies
;					$sDelegator				- Optional: Delegator
;					$sCategories			- Optional: Categories
;                   $sWarningClick 			- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   			- Array in the following format: [1000]
;											  [0] - Number of items deleted
;											  [1] - Deleted item 1
;											  [2] - Deleted item 2
;											  [n] - Deleted item n
;                   On Failure 			  	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 				- Illegal parameters 
;					@ERROR = 2   			- OutlookWarning2.exe not found.
;					@ERROR = 4 				- 0 notes found
;					@ERROR = 5 				- More than 1 Notes found
;					@ERROR = 9   			- ObjEvent error.
; Author(s):        Wooltown
; Created:          2009-03-06
; Modified:         -
;
;===============================================================================
Func _OutlookModifyTask($oOutlook, $sSubject, $sStartDate = "", $sNewSubject = "", $sNewStartDate = "", $sDueDate = "", $iStatus = "", $iImportance = "", $fComplete = "", $iPercentComplete = "", $fReminderSet = "", $sReminderTime = "", $sOwner = "", $sBody = "", $sDateCompleted = "", $iTotalWork = "", $iActualWork = "", $sMileage = "", $sBillingInformation = "", $sCompanies = "", $sDelegator = "", $sCategories = "", $sWarningClick = "")
	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
		Return SetError(2, 0, 0)
	Else
		Run($sWarningClick)
	EndIf
	If $sSubject = "" And $sStartDate = "" Then Return SetError(1, 0, 0)
	Local $iRc = 0, $sFilter = "", $oFilteredItems
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderTasks)
	Local $oColItems = $oFolder.Items
	$oColItems.IncludeRecurrences = True
	$sFilter = '[Subject] = "' & $sSubject & '"'
	If $sStartDate <> "" Then
		If Not _DateIsValid($sStartDate) Then Return SetError(1, 0, 0)
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[StartDate] = "' & $sStartDate & '"'
	EndIf	
	$oFilteredItems = $oColItems.Restrict($sFilter)
	If $oFilteredItems.Count = 0 Then Return SetError(4, 0, 0)
	If $oFilteredItems.Count > 1 Then Return SetError(5, 0, 0)
	For $oItem In $oFilteredItems
		If $sNewSubject <> "" Then
			$oItem.Subject = $sNewSubject
		EndIf
		If $sNewStartDate <> "" Then
			If Not _DateIsValid($sNewStartDate) Then Return SetError(1, 0, 0)
	 		$oItem.StartDate = $sNewStartDate
	 	EndIf
		If $sDueDate <> "" Then
	 		$oItem.DueDate = $sDueDate
	 	EndIf
		If $iStatus <> "" Then
	 		$oItem.Status = $iStatus
	 	EndIf
		If $iImportance <> "" Then
	 		$oItem.Importance = $iImportance
	 	EndIf
		If $fComplete <> "" Then
	 		$oItem.Complete = $fComplete
	 	EndIf
		If $iPercentComplete <> "" Then
	 		$oItem.PercentComplete = $iPercentComplete
	 	EndIf
		If $fReminderSet <> "" Then
	 		$oItem.ReminderSet = $fReminderSet
	 	EndIf
		If $sReminderTime <> "" Then
	 		$oItem.ReminderTime = $sReminderTime
	 	EndIf
		If $sOwner <> "" Then
	 		$oItem.Owner = $sOwner
	 	EndIf
		If $sBody <> "" Then
	 		$oItem.Body = $sBody
	 	EndIf
		If $sDateCompleted <> "" Then
			If Not _DateIsValid($sDateCompleted) Then Return SetError(1, 0, 0)
	 		$oItem.DateCompleted = $sDateCompleted
	 	EndIf
		If $iTotalWork <> "" Then
	 		$oItem.TotalWork = $iTotalWork
	 	EndIf
		If $iActualWork <> "" Then
	 		$oItem.ActualWork = $iActualWork
	 	EndIf
		If $sMileage <> "" Then
	 		$oItem.Mileage = $sMileage
	 	EndIf
		If $sBillingInformation <> "" Then
	 		$oItem.BillingInformation = $sBillingInformation
	 	EndIf
		If $sCompanies <> "" Then
	 		$oItem.Companies = $sCompanies
	 	EndIf
		If $sDelegator <> "" Then
	 		$oItem.Delegator = $sDelegator
	 	EndIf
		If $sCategories <> "" Then
	 		$oItem.Categories = $sCategories
	 	EndIf
	 	$oItem.Close ($olSave)
	 	$iRc = @ERROR
	Next
	$oItem = ""
	$oColItems = ""
	$oFolder = ""
	$oNamespace = ""
    If $iRc = 0 Then
    	Return 1
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
; Function Name:    _OutlookCreateAppointment()
; Description:      Create an appointment using Microsoft Outlook.
; Syntax.........:  _OutlookCreateAppointment($oOutlook, $sSubject, $sStartDate, $sEndDate = "", $sLocation = "", $fAllDayEvent = False, $sBody = "", $sReminder = 15, $sShowTimeAs = "", $iImportance = "", $iSensitivity = "", $iRecurrenceType = "", $sPatternStartDate = "", $sPatternEndDate = "", $iInterval = "", $iDayOfWeekMask = "", $iDay_MonthOfMonth_Year = "", $iInstance = "")
; Parameter(s):     $oOutlook 			- Outlook object opened by a preceding call to _OutlookOpen().
; 					$sSubject   	   	- The Subject of the Appointment.
;					$sStartDate			- Start date & time of the Appointment, format YYYY-MM-DD HH:MM - or what is set locally.
;					$sEndDate			- Optional: End date & time of the Appointment, format YYYY-MM-DD HH:MM - or what is set locally.
;										  Number of minutes. If not set 30 minutes is used.
;					$sLocation			- Optional: The location where the meeting is going to take place.
;					$fAllDayEvent		- Optional: True or False(default), if set to True and the appointment is lasting for more than one day, end Date
;										  must be one day higher than the actual end Date.
;                   $sBody	         	- Optional: The Body of the Appointment.
;					$sReminder	 		- Optional: Reminder in Minutes before start, 0 for no reminder
;					$sShowTimeAs		- Optional: $olBusy=2 (default), $olFree=0, $olOutOfOffice=3, $olTentative=1
;					$iImportance 		- Optional: $olImportanceNormal=1 (default), $olImportanceHigh=2, $olImportanceLow=0
;					$iSensitivity		- Optional: $olNormal=0, $olPersonal=1, $olPrivate=2, $olConfidential=3
;					$iRecurrenceType 	- Optional: $olRecursDaily=0, $olRecursWeekly=1, $olRecursMonthly=2, $olRecursMonthNth=3, $olRecursYearly=5, $olRecursYearNth=6
;					$sPatternStartDate	- Optional: Start Date of the Reccurent Appointment, format YYYY-MM-DD - or what is set locally.
;					$sPatternEndDate	- Optional: End Date of the Reccurent Appointment, format YYYY-MM-DD - or what is set locally.
;					$iInterval 			- Optional: Interval between the Reccurent Appointment
;					$iDayOfWeekMask 	- Optional: Add the values of the days the appointment shall occur. $olSunday=1, $olMonday=2, $olTuesday=4, $olWednesday=8, $olThursday=16, $olFriday=32, $olSaturday=64
;					$iDay_MonthOfMonth_Year	- Optional: DayOfMonth or MonthOfYear, Day of the month or month of the year on which the recurring appointment or task occurs
;					$iInstance			- Optional: This property is only valid for recurrences of the $olRecursMonthNth and $olRecursYearNth type and allows the definition of a recurrence pattern that is only valid for the Nth occurrence, such as "the 2nd Sunday in March" pattern. The count is set numerically: 1 for the first, 2 for the second, and so on through 5 for the last. Values greater than 5 will generate errors when the pattern is saved. 
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Returns 1
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 9   	- ObjEvent error.
; Author(s):        Wooltown
; Created:          2009-02-11       
; Modified:         -
;
;===============================================================================
Func _OutlookCreateAppointment($oOutlook, $sSubject, $sStartDate = "", $sEndDate = "", $sLocation = "", $fAllDayEvent = False, $sBody = "", $sReminder = 0, $sShowTimeAs = "", $iImportance = "", $iSensitivity = "", $iRecurrenceType = "", $sPatternStartDate = "", $sPatternEndDate = "", $iInterval = "", $iDayOfWeekMask = "", $iDay_MonthOfMonth_Year = "", $iInstance = "")
	Local $iRc = 0
	If $fAllDayEvent = "" Then Return SetError(1, 0, 0)
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNote = $oOutlook.CreateItem($olAppointmentItem)
	$oNote.Subject = $sSubject
    $oNote.Location = $sLocation
    $oNote.AllDayEvent = $fAllDayEvent
    If Not _DateIsValid($sStartDate) Then Return SetError(1, 0, 0)
	$oNote.Start = $sStartDate
	If _DateIsValid($sEndDate) Then
    	$oNote.End = $sEndDate
    Else
		$oNote.Duration = Number($sEndDate)
	EndIf
	$oNote.Body = $sBody
    If $sReminder <> 0 Then
    	$oNote.ReminderSet = True
    	$oNote.ReminderMinutesBeforeStart = $sReminder
    Else
    	$oNote.ReminderSet = False
    EndIf
    $oNote.Importance = $iImportance
    $oNote.BusyStatus = $sShowTimeAs
    If $iSensitivity <> "" Then $oNote.Sensitivity = $iSensitivity
    If $iRecurrenceType <> "" Then
    	Local $oRecurrent = $oNote.GetRecurrencePattern
    	$oRecurrent.RecurrenceType = $iRecurrenceType
    	If $sPatternStartDate <> "" And $sPatternEndDate <> "" Then
    		If $iDayOfWeekMask <> "" Then $oRecurrent.DayOfWeekMask = $iDayOfWeekMask
    		If Not _DateIsValid($sPatternStartDate) Then Return SetError(1, 0, 0)
    		If Not _DateIsValid($sPatternEndDate) Then Return SetError(1, 0, 0)
    		$oRecurrent.PatternStartDate = $sPatternStartDate
    		If $iInterval <> "" Then $oRecurrent.Interval = $iInterval
    		$oRecurrent.PatternEndDate = $sPatternEndDate
    	EndIf
    	If $iRecurrenceType = $olRecursMonthNth Or $iRecurrenceType = $olRecursYearNth Then
    		If $iRecurrenceType = $olRecursMonthNth Then
    			$oRecurrent.DayOfMonth = $iDay_MonthOfMonth_Year
    			$oRecurrent.Instance = $iInstance
    		Else
    			$oRecurrent.MonthOfYear = $iDay_MonthOfMonth_Year
    			$oRecurrent.Instance = $iInstance
    		EndIf
    	EndIf
    EndIf
	$oNote.Save
    $oNote.Close ($olSave)
    $iRc = @ERROR
    If $iRc = 0 Then
    	Return 1
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
; Function Name:    _OutlookModifyAppointment()
; Description:      Modify an appointment using Microsoft Outlook.
; Syntax.........:  _OutlookModifyAppointment($oOutlook, $sSubject, $sStartDate, $sNewSubject = "", $sNewStartDate = "", $sEndDate = "", $sLocation = "", $fAllDayEvent = False, $sBody = "", $sReminder = 15, $sShowTimeAs = "", $iImportance = "", $iSensitivity = "", $iRecurrenceType = "", $sPatternStartDate = "", $sPatternEndDate = "", $iInterval = "", $iDayOfWeekMask = "", $iDay_MonthOfMonth_Year = "", $iInstance = "")
; Parameter(s):     $oOutlook 			- Outlook object opened by a preceding call to _OutlookOpen().
; 					$sSubject   	   	- The Subject of the Appointment.
;					$sStartDate			- Start date & time of the Appointment, format YYYY-MM-DD HH:MM - or what is set locally.
;					$sNewSubject		- Optional: New Subject of the Appointment.
;					$sNewStartDate		- Optional: New start date & time of the Appointment, format YYYY-MM-DD HH:MM - or what is set locally.
;					$sEndDate			- Optional: End date & time of the Appointment, format YYYY-MM-DD HH:MM - or what is set locally.
;										            Number of minutes. 
;					$sLocation			- Optional: The location where the meeting is going to take place.
;					$fAllDayEvent		- Optional: True or False if set to True and the appointment is lasting for more than one day, end Date
;										  must be one day higher than the actual end Date.
;                   $sBody	         	- Optional: The Body of the Appointment.
;					$sReminder	 		- Optional: Reminder in Minutes before start, 0 for no reminder
;					$sShowTimeAs		- Optional: $olBusy=2, $olFree=0, $olOutOfOffice=3, $olTentative=1
;					$iImportance 		- Optional: $olImportanceNormal=1, $olImportanceHigh=2, $olImportanceLow=0
;					$iSensitivity		- Optional: $olNormal=0, $olPersonal=1, $olPrivate=2, $olConfidential=3
;					$iRecurrenceType 	- Optional: $olRecursDaily=0, $olRecursWeekly=1, $olRecursMonthly=2, $olRecursMonthNth=3, $olRecursYearly=5, $olRecursYearNth=6. Remove Recurrence=-1
;					$sPatternStartDate	- Optional: Start Date of the Reccurent Appointment, format YYYY-MM-DD - or what is set locally.
;					$sPatternEndDate	- Optional: End Date of the Reccurent Appointment, format YYYY-MM-DD - or what is set locally.
;					$iInterval 			- Optional: Interval between the Reccurent Appointment
;					$iDayOfWeekMask 	- Optional: Add the values of the days the appointment shall occur. $olSunday=1, $olMonday=2, $olTuesday=4, $olWednesday=8, $olThursday=16, $olFriday=32, $olSaturday=64
;					$iDay_MonthOfMonth_Year	- Optional: DayOfMonth or MonthOfYear, Day of the month or month of the year on which the recurring appointment or task occurs
;					$iInstance			- Optional: This property is only valid for recurrences of the $olRecursMonthNth and $olRecursYearNth type and allows the definition of a recurrence pattern that is only valid for the Nth occurrence, such as "the 2nd Sunday in March" pattern. The count is set numerically: 1 for the first, 2 for the second, and so on through 5 for the last. Values greater than 5 will generate errors when the pattern is saved. 
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Returns 1
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 2 		- Appointment not found
;					@ERROR = 9   	- ObjEvent error.
; Author(s):        Wooltown
; Created:          2009-02-23       
; Modified:         -
;
;===============================================================================
Func _OutlookModifyAppointment($oOutlook, $sSubject, $sStartDate = "", $sNewSubject = "", $sNewStartDate = "", $sEndDate = "", $sLocation = "", $fAllDayEvent = "", $sBody = "", $sReminder = "", $sShowTimeAs = "", $iImportance = "", $iSensitivity = "", $iRecurrenceType = "", $sPatternStartDate = "", $sPatternEndDate = "", $iInterval = "", $iDayOfWeekMask = "", $iDay_MonthOfMonth_Year = "", $iInstance = "")
	Local $iRc = 0, $fItemFound = False, $fIsRecurring, $oRecPatt, $oOrig
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderCalendar)
	Local $oColItems = $oFolder.Items
	$oColItems.Sort("[Start]")
	$oColItems.IncludeRecurrences = True 
	Local $sFilter = '[Subject] = "' & $sSubject & '"'
	Local $oFilteredItems = $oColItems.Restrict($sFilter)
	For $oItem In $oFilteredItems
		$fItemFound = True
		$fIsRecurring = $oItem.IsRecurring
		If $fIsRecurring = False Then							; ----- Non Recurring Appointment
 			If $oItem.Start > StringLeft($sStartDate,4) & StringMid($sStartDate,6,2) & StringMid($sStartDate,9,2) & StringMid($sStartDate,12,2) & StringMid($sStartDate,15,2) & "00" Then Return SetError(2, 0, 0)
 			If $oItem.Start = StringLeft($sStartDate,4) & StringMid($sStartDate,6,2) & StringMid($sStartDate,9,2) & StringMid($sStartDate,12,2) & StringMid($sStartDate,15,2) & "00" Then
 	 			If $sNewSubject <> "" Then $oItem.Subject = $sNewSubject
	 			If $sLocation <> "" Then $oItem.Location = $sLocation
	 			If $fAllDayEvent <> "" Then $oItem.AllDayEvent = $fAllDayEvent
		        If $sNewStartDate <> "" Then 
		        	If Not _DateIsValid($sNewStartDate) Then Return SetError(1, 0, 0)
		        	$oItem.Start = $sNewStartDate
		        EndIf
		        If $sEndDate <> "" Then 
			    	If _DateIsValid($sEndDate) Then
			        	$oItem.End = $sEndDate
				    Else
			    		$oItem.Duration = Number($sEndDate)
			    	EndIf
			    EndIf
				    If $sBody <> "" Then $oItem.Body = $sBody
			    If $sReminder <> "" Then
			        If $sReminder <> 0 Then
			        	$oItem.ReminderSet = True
			        	$oItem.ReminderMinutesBeforeStart = Number($sReminder)
			        Else
			        	$oItem.ReminderSet = False
			        EndIf
				EndIf
				If $iImportance <> "" Then $oItem.Importance = $iImportance
		        If $sShowTimeAs <> "" Then $oItem.BusyStatus = $sShowTimeAs
		        If $iSensitivity <> "" Then $oItem.Sensitivity = $iSensitivity
		        If $iRecurrenceType <> "" Then
		        	Local $oRecurrent = $oItem.GetRecurrencePattern
		        	$oRecurrent.RecurrenceType = $iRecurrenceType
		        	If $sPatternStartDate <> "" And $sPatternEndDate <> "" Then
		        		If $iDayOfWeekMask <> "" Then $oRecurrent.DayOfWeekMask = $iDayOfWeekMask
		       			If Not _DateIsValid($sPatternStartDate) Then Return SetError(1, 0, 0)
		        		$oRecurrent.PatternStartDate = $sPatternStartDate
		        		If Not _DateIsValid($sPatternEndDate) Then 
		        			If Not IsNumber(Number($sPatternEndDate)) Then 
		        				Return SetError(1, 0, 0)
		        			Else
		        				$oRecurrent.Occurrences = Number($sPatternEndDate)
		        			EndIf
		        		Else
		        			$oRecurrent.PatternEndDate = $sPatternEndDate
		        		EndIf
		        		If $iInterval <> "" Then $oRecurrent.Interval = $iInterval
		        	EndIf
		        	If $iRecurrenceType = $olRecursMonthNth Or $iRecurrenceType = $olRecursYearNth Then
		        		If $iRecurrenceType = $olRecursMonthNth Then
		        			$oRecurrent.DayOfMonth = $iDay_MonthOfMonth_Year
		        			$oRecurrent.Instance = $iInstance
		        		Else
		        			$oRecurrent.MonthOfYear = $iDay_MonthOfMonth_Year
		        			$oRecurrent.Instance = $iInstance
		        		EndIf
		        	EndIf
		        EndIf
				$oItem.Save
		        $oItem.Close 
		        $iRc = @ERROR
		        If $iRc = 0 Or $iRc = -2147352561 Then
			    	Return 1
			    Else
			    	Return SetError(9, 0, 0)
			    EndIf
			EndIf
		Else														; ----- Recurring Appointment, change all occurences
 			$oItem.GetFirst
 			$oRecPatt = $oItem.GetRecurrencePattern
				If $sNewStartDate <> "" Then 
					If Not _DateIsValid($sNewStartDate) Then Return SetError(1, 0, 0)
	        	$oRecPatt.StartTime = $sNewStartDate
	        EndIf
				If $sEndDate <> "" Then 
		    	If _DateIsValid($sEndDate) Then
		        	$oRecPatt.EndTime = $sEndDate
			    Else
		    		$oRecPatt.Duration = Number($sEndDate)
		    	EndIf
		    EndIf
				$oRecPatt.Save
				$oRecPatt.Close 
  			$oOrig = $oRecPatt.Parent
			If $sLocation <> "" Then $oOrig.Location = $sLocation
	 		If $fAllDayEvent <> "" Then $oOrig.AllDayEvent = $fAllDayEvent
		    If $sBody <> "" Then $oOrig.Body = $sBody
		    If $sReminder <> "" Then
		        If $sReminder <> 0 Then
		        	$oOrig.ReminderSet = True
		        	$oOrig.ReminderMinutesBeforeStart = Number($sReminder)
		        Else
		        	$oOrig.ReminderSet = False
		        EndIf
			EndIf
			If $iImportance <> "" Then $oOrig.Importance = $iImportance
	        If $sShowTimeAs <> "" Then $oOrig.BusyStatus = $sShowTimeAs
	        If $iSensitivity <> "" Then $oOrig.Sensitivity = $iSensitivity
	        If $iRecurrenceType <> "" Then
	        	$oRecurrent = $oOrig.GetRecurrencePattern
	        	$oRecurrent.RecurrenceType = $iRecurrenceType
	        	If $sPatternStartDate <> "" And $sPatternEndDate <> "" Then
	        		If $iDayOfWeekMask <> "" Then $oRecurrent.DayOfWeekMask = $iDayOfWeekMask
	       			If Not _DateIsValid($sPatternStartDate) Then Return SetError(1, 0, 0)
	        		$oRecurrent.PatternStartDate = $sPatternStartDate
	        		If Not _DateIsValid($sPatternEndDate) Then 
	        			If Not IsNumber(Number($sPatternEndDate)) Then 
	        				Return SetError(1, 0, 0)
	        			Else
	        				$oRecurrent.Occurrences = Number($sPatternEndDate)
	        			EndIf
	        		Else
	        			$oRecurrent.PatternEndDate = $sPatternEndDate
	        		EndIf
	        		If $iInterval <> "" Then $oRecurrent.Interval = $iInterval
	        	EndIf
	        	If $iRecurrenceType = $olRecursMonthNth Or $iRecurrenceType = $olRecursYearNth Then
	        		If $iRecurrenceType = $olRecursMonthNth Then
	        			$oRecurrent.DayOfMonth = $iDay_MonthOfMonth_Year
	        			$oRecurrent.Instance = $iInstance
	        		Else
	        			$oRecurrent.MonthOfYear = $iDay_MonthOfMonth_Year
	        			$oRecurrent.Instance = $iInstance
	        		EndIf
	        	EndIf
	        EndIf								
			$oOrig.Subject = $sNewSubject
			$oOrig.Save
			$oOrig.Close 
			$iRc = @ERROR
		    If $iRc = 0 Or $iRc = -2147352561 Then
		    	Return 1
		    Else
		    	Return SetError(9, 0, 0)
		    EndIf
		EndIf
	Next
	If $fItemFound = False Then Return SetError(2, 0, 0)
EndFunc
;===============================================================================
;
; Function Name:    _OutlookGetAppointments()
; Description:      Get the appointments in Microsoft Outlook specify Subject and or Date Interval
; Syntax.........:  _OutlookGetAppointments($oOutlook, $sSubject = "", $sStartDate = "", $sEndDate = "", $sLocation = "", $iAllDayEvent = 2, $iImportance = "")
; Parameter(s):     $oOutlook 			- Outlook object opened by a preceding call to _OutlookOpen().
; 					$sSubject   	   	- The Subject of the Appointment.
;					$sStartDate			- Start date & time of the Appointment, format YYYY-MM-DD HH:MM - or what is set locally.
;					$sEndDate			- Optional: End date & time of the Appointment, format YYYY-MM-DD HH:MM - or what is set locally.
;					$sLocation			- Optional: The location where the meeting is going to take place.
;					$iAllDayEvent		- Optional: 0 - Part of Day, 1 - All Day, 2 - Both (default)
;					$iImportance 		- Optional: $olImportanceNormal=1, $olImportanceHigh=2, $olImportanceLow=0
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   		- Array in the following format: [1000][8]
;										  [0][0] - Number of items
;										  [1][0] - Subject
;										  [1][1] - StartDate
;										  [1][2] - EndDate
;										  [1][3] - Location
;										  [1][4] - AllDayEvent
;										  [1][5] - Importance
;										  [1][6] - Body
;										  [1][7] - Categories
;										  [n][n] - Item n
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 2 		- No appointments found
;					@ERROR = 3 		- More than 999 Appointments found, the first 999 appointments will be returned
;					@ERROR = 9   	- ObjEvent error.
; Author(s):        Wooltown
; Created:          2009-02-24
; Modified:         -
;
;===============================================================================
Func _OutlookGetAppointments($oOutlook, $sSubject = "", $sStartDate = "", $sEndDate = "", $sLocation = "", $iAllDayEvent = 2, $iImportance = "")
	Local $avAppointments[1000][8], $sFilter = "", $fAllDayEvent, $oFilteredItems
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Switch $iAllDayEvent
		Case 0 
			$fAllDayEvent = False
		Case 1
			$fAllDayEvent = True
	EndSwitch
	$avAppointments[0][0] = 0
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderCalendar)
	Local $oColItems = $oFolder.Items
	$oColItems.Sort("[Start]")
	$oColItems.IncludeRecurrences = True 
	If $sSubject <> "" Then
		$sFilter = '[Subject] = "' & $sSubject & '"'
	EndIf
	If $sStartDate <> "" Then
		If Not _DateIsValid($sStartDate) Then Return SetError(1, 0, 0)
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[Start] >= "' & $sStartDate & '"'
	EndIf	
	If $sEndDate <> "" Then
		If Not _DateIsValid($sEndDate) Then Return SetError(1, 0, 0)
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[End] <= "' & $sEndDate & '"'
	EndIf	
	If $sLocation <> "" Then
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[Location] = "' & $sLocation & '"'
	EndIf	
	If $iImportance <> "" Then
		If $sFilter <> "" Then $sFilter &= ' And '
		$sFilter &= '[Importance] = "' & $iImportance & '"'
	EndIf	
	$oFilteredItems = $oColItems.Restrict($sFilter)
	If $sFilter = "" Then Return SetError(1, 0, 0)
	For $oItem In $oFilteredItems
		$oItem.IsRecurring
 			If $avAppointments[0][0] = 999 Then
 				SetError (3)
 				Return $avAppointments
 			EndIf
 			If $iAllDayEvent <> 2 Then
 				If $fAllDayEvent = True Then
 					If $oItem.AllDayEvent = False Then ContinueLoop
 				Else	
 					If $oItem.AllDayEvent = True Then ContinueLoop
 				EndIf
 			EndIf
 			$avAppointments[0][0] += 1
 			$avAppointments[$avAppointments[0][0]][0] = $oItem.Subject
 			$avAppointments[$avAppointments[0][0]][1] = $oItem.Start
 			$avAppointments[$avAppointments[0][0]][2] = $oItem.End
 			$avAppointments[$avAppointments[0][0]][3] = $oItem.Location
 			$avAppointments[$avAppointments[0][0]][4] = $oItem.AllDayEvent
 			$avAppointments[$avAppointments[0][0]][5] = $oItem.Importance
 			$avAppointments[$avAppointments[0][0]][6] = $oItem.Body
			$avAppointments[$avAppointments[0][0]][7] = $oItem.Categories
	Next
	$oItem = ""
	$oColItems = ""
	$oFolder = ""
	$oNamespace = ""
	If $avAppointments[0][0] = 0 Then Return SetError(2, 0, 0)
	Redim $avAppointments[$avAppointments[0][0] + 1][8]
	Return $avAppointments
EndFunc
;===============================================================================
;
; Function Name:    _OutlookCreateContact()
; Description:      Create a contact using Microsoft Outlook.
; Syntax.........:  _OutlookCreateContact($oOutlook, $sFirstName, $sLastName, $sEmail1Adress, $sTitle = "", $sMiddleName = "", $sSuffix = "", $sEmail1DisplayName = "", $sEmail2Adress = "", $sEmail2DisplayName = "", $sEmail3Adress = "", $sEmail3DisplayName = "", $sJobTitle = "", $sCompanyName = "", $sBody = "", $sSelectedMailingAddress = "", $sCategories = "", $sMobileTelephoneNumber = "", $sHomeTelephoneNumber = "", $sHomeAddressStreet = "", $sHomeAddressCity = "", $sHomeAddressState = "", $sHomeAddressPostalCode = "", $sHomeAddressCountry = "", $sBusinessTelephoneNumber = "", $sBusinessAddressStreet = "", $sBusinessAddressCity = "", $sBusinessAddressState = "", $sBusinessAddressPostalCode = "", $sBusinessAddressCountry = "", $sOtherTelephoneNumber = "", $sOtherAddressStreet = "", $sOtherAddressCity = "", $sOtherAddressState = "", $sOtherAddressPostalCode = "", $sOtherAddressCountry = "", $sWebPage = "", $sIMaddress = "",$sBirthday = "", $sDepartment = "", $sOfficeLocation = "", $sProfession = "", $sManagerName = "", $sAssistantName = "", $sNickName = "", $sSpouse = "", $sAnniversary = "")
; Parameter(s):     $oOutlook 						- Outlook object opened by a preceding call to _OutlookOpen().
;					$sFirstName						- First Name
;					$sLastName						- Last Name
;					$sEmail1Adress					- E-mail address 1
;					$sTitle							- Optional: Title, example: Mr, Mrs, Dr
;					$sMiddleName					- Optional: Middle Name
;					$sSuffix						- Optional: Suffix, example: I, II, III, Jr, Sr
;					$sEmail1DisplayName				- Optional: E-mail display name 1
;					$sEmail2Adress					- Optional: E-mail address 2
;					$sEmail2DisplayName				- Optional: E-mail display name 2
;					$sEmail3Adress					- Optional: E-mail address 3
;					$sEmail3DisplayName				- Optional: E-mail display name 3
;					$sJobTitle						- Optional: Job Title
;					$sCompanyName					- Optional: Company Name
;					$sBody							- Optional: Body
;					$sSelectedMailingAddress		- Optional: Which address is the selected ? 
;													  $olNone=0, $olHome=1, $olBusiness=2, $olOther=3
;					$sCategories					- Optional: Categories for the note, separated by ;
;					$sMobileTelephoneNumber			- Optional: Mobile Phone Number
;					$sHomeTelephoneNumber			- Optional: Home Phone Number
;					$sHomeAddressStreet				- Optional: Home Address
;					$sHomeAddressCity				- Optional: Home City
;					$sHomeAddressState				- Optional: Home State
;					$sHomeAddressPostalCode			- Optional: Home Postal Code
;					$sHomeAddressCountry			- Optional: Home Country
;					$sBusinessTelephoneNumber		- Optional: Business Phone number
;					$sBusinessAddressStreet			- Optional: Business Address
;					$sBusinessAddressCity			- Optional: Business City
;					$sBusinessAddressState			- Optional: Business State
;					$sBusinessAddressPostalCode		- Optional: Business Postal Code
;					$sBusinessAddressCountry		- Optional: Business Country
;					$sOtherTelephoneNumber			- Optional: Other Phone Number
;					$sOtherAddressStreet			- Optional: Other Address
;					$sOtherAddressCity				- Optional: Other City
;					$sOtherAddressState				- Optional: Other State
;					$sOtherAddressPostalCode		- Optional: Other Postal Code
;					$sOtherAddressCountry			- Optional: Other Country
;					$sWebPage						- Optional: WebPage
;					$sIMaddress						- Optional: Instant Messenger address
;					$sBirthday						- Optional: Birthday, format YYYY-MM-DD - or what is set locally.
;			        $sDepartment					- Optional: Department
;			        $sOfficeLocation				- Optional: Office
;			        $sProfession					- Optional: Profession
;			        $sManagerName					- Optional: The name of your manager
;			        $sAssistantName					- Optional: The name of your assistant
;			        $sNickName						- Optional: Your nickname
;			        $sSpouse						- Optional: Your Spouse
;			        $sAnniversary					- Optional: Anniversary to remember
;
;					***** On the General Tab I have failed to find how to set Contacts and Private *****
;
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Returns 1
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 9   	- ObjEvent error.
; Author(s):        Wooltown
; Created:          2009-02-12       
; Modified:         -
;
;===============================================================================
Func _OutlookCreateContact($oOutlook, $sFirstName, $sLastName, $sEmail1Adress, $sTitle = "", $sMiddleName = "", $sSuffix = "", $sEmail1DisplayName = "", $sEmail2Adress = "", $sEmail2DisplayName = "", $sEmail3Adress = "", $sEmail3DisplayName = "", $sJobTitle = "", $sCompanyName = "", $sBody = "", $sSelectedMailingAddress = "", $sCategories = "", $sMobileTelephoneNumber = "", $sHomeTelephoneNumber = "", $sHomeAddressStreet = "", $sHomeAddressCity = "", $sHomeAddressState = "", $sHomeAddressPostalCode = "", $sHomeAddressCountry = "", $sBusinessTelephoneNumber = "", $sBusinessAddressStreet = "", $sBusinessAddressCity = "", $sBusinessAddressState = "", $sBusinessAddressPostalCode = "", $sBusinessAddressCountry = "", $sOtherTelephoneNumber = "", $sOtherAddressStreet = "", $sOtherAddressCity = "", $sOtherAddressState = "", $sOtherAddressPostalCode = "", $sOtherAddressCountry = "", $sWebPage = "", $sIMaddress = "",$sBirthday = "", $sDepartment = "", $sOfficeLocation = "", $sProfession = "", $sManagerName = "", $sAssistantName = "", $sNickName = "", $sSpouse = "", $sAnniversary = "")
	Local $iRc = 0
	If $sFirstName = "" Or $sLastName = "" Or $sEmail1Adress = "" Then Return SetError(1, 0, 0)
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oContact = $oOutlook.CreateItem($olContactItem)
	$oContact.FirstName = $sFirstName
  	$oContact.LastName = $sLastName
  	$oContact.Email1Address = $sEmail1Adress
  	$oContact.Email1AddressType = "SMTP"
  	If $sTitle <> "" Then  $oContact.Title = $sTitle
	If $sMiddleName <> "" Then $oContact.MiddleName = $sMiddleName
	If $sSuffix <> "" Then $oContact.Suffix = $sSuffix
  	If $sEmail1DisplayName <> "" Then $oContact.Email1DisplayName = $sEmail1DisplayName
  	If $sEmail2Adress <> "" Then 
  		$oContact.Email2Address = $sEmail2Adress
  		$oContact.Email2AddressType = "SMTP"
  	EndIf
  	If $sEmail2DisplayName <> "" Then $oContact.Email2DisplayName = $sEmail2DisplayName
  	If $sEmail3Adress <> "" Then 
  		$oContact.Email3Address = $sEmail3Adress
  		$oContact.Email3AddressType = "SMTP"
  	EndIf
  	If $sEmail3DisplayName <> "" Then $oContact.Email3DisplayName = $sEmail3DisplayName
  	If $sJobTitle <> "" Then $oContact.JobTitle = $sJobTitle
  	If $sCompanyName <> "" Then $oContact.CompanyName = $sCompanyName
  	If $sBody <> "" Then $oContact.Body = $sBody
  	If $sSelectedMailingAddress <> "" Then $oContact.SelectedMailingAddress = $sSelectedMailingAddress
    If $sCategories <> "" Then $oContact.Categories = $sCategories
  	If $sMobileTelephoneNumber <> "" Then $oContact.MobileTelephoneNumber = $sMobileTelephoneNumber
  	If $sHomeTelephoneNumber <> "" Then $oContact.HomeTelephoneNumber = $sHomeTelephoneNumber
    If $sHomeAddressStreet <> "" Then $oContact.HomeAddressStreet = $sHomeAddressStreet
    If $sHomeAddressCity <> "" Then $oContact.HomeAddressCity = $sHomeAddressCity
    If $sHomeAddressState <> "" Then $oContact.HomeAddressState = $sHomeAddressState
    If $sHomeAddressPostalCode <> "" Then $oContact.HomeAddressPostalCode = $sHomeAddressPostalCode
    If $sHomeAddressCountry <> "" Then $oContact.HomeAddressCountry = $sHomeAddressCountry
    If $sBusinessTelephoneNumber <> "" Then $oContact.BusinessTelephoneNumber = $sBusinessTelephoneNumber
  	If $sBusinessAddressStreet <> "" Then $oContact.BusinessAddressStreet = $sBusinessAddressStreet
    If $sBusinessAddressCity <> "" Then $oContact.BusinessAddressCity = $sBusinessAddressCity
    If $sBusinessAddressState <> "" Then $oContact.BusinessAddressState = $sBusinessAddressState
    If $sBusinessAddressPostalCode <> "" Then $oContact.BusinessAddressPostalCode = $sBusinessAddressPostalCode
    If $sBusinessAddressCountry <> "" Then $oContact.BusinessAddressCountry = $sBusinessAddressCountry
    If $sOtherTelephoneNumber <> "" Then $oContact.OtherTelephoneNumber = $sOtherTelephoneNumber
  	If $sOtherAddressStreet <> "" Then $oContact.OtherAddressStreet = $sOtherAddressStreet
    If $sOtherAddressCity <> "" Then $oContact.OtherAddressCity = $sOtherAddressCity
    If $sOtherAddressState <> "" Then $oContact.OtherAddressState = $sOtherAddressState
    If $sOtherAddressPostalCode <> "" Then $oContact.OtherAddressPostalCode = $sOtherAddressPostalCode
    If $sOtherAddressCountry <> "" Then $oContact.OtherAddressCountry = $sOtherAddressCountry
    If $sWebPage <> "" Then $oContact.WebPage = $sWebPage
    If $sIMaddress <> "" Then $oContact.IMaddress = $sIMaddress
    If $sBirthday <> "" Then $oContact.Birthday = $sBirthday
	If $sDepartment <> "" Then $oContact.Department = $sDepartment
	If $sOfficeLocation <> "" Then $oContact.OfficeLocation = $sOfficeLocation
	If $sProfession <> "" Then $oContact.Profession = $sProfession
	If $sManagerName <> "" Then $oContact.ManagerName = $sManagerName
	If $sAssistantName <> "" Then $oContact.AssistantName = $sAssistantName
	If $sNickName <> "" Then $oContact.NickName = $sNickName
	If $sSpouse <> "" Then $oContact.Spouse = $sSpouse
	If $sAnniversary <> "" Then $oContact.Anniversary = $sAnniversary
    $oContact.Close ($olSave)
    $iRc = @ERROR
    If $iRc = 0 Then
    	Return 1
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
; Function Name:    _OutlookGetContacts()
; Description:      Get contacts using Microsoft Outlook, returning an array of all information
; Syntax.........:  _OutlookGetContacts($oOutlook, $sFirstName = "", $sLastName = "", $sEmail1Adress = "", $fSearchPart = False, $fFullList = False, $sWarningClick = "")
; Parameter(s):     $oOutlook 						- Outlook object opened by a preceding call to _OutlookOpen().
;					$sFirstName						- Optional: First Name
;					$sLastName						- Optional: Last Name
;					$sEmail1Adress					- Optional: E-mail address 1
;					fSearchPart						- Optional: Default: False, True if match part of the string
;					fFullList						- Optional: Default: False, If False, only return Small array.
;					$sWarningClick 					- Optional: The Entire SearchString to 'OutlookWarning2.exe', Default = None
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   					- Array in the following format: [1000][5]
;													[0][0] - Total Number of items
;													[1][0] - First Name
;													[1][1] - Last Name
;													[1][2] - E-mail address 1
;													[1][3] - E-mail address 2
;													[1][4] - Mobile Phone Number
;												  	[n][n] - Item n
;													- Array in the following format: [1000][46]
;													[0][0] - Total Number of items
;													[1][0] - First Name
;													[1][1] - Last Name
;													[1][2] - E-mail address 1
;													[1][3] - Title, example: Mr, Mrs, Dr
;													[1][4] - Middle Name
;													[1][5] - Suffix, example: I, II, III, Jr, Sr
;													[1][6] - E-mail display name 1
;													[1][7] - E-mail address 2
;													[1][8] - E-mail display name 2
;													[1][9] - E-mail address 3
;													[1][10] - E-mail display name 3
;													[1][11] - Job Title
;													[1][12] - Company Name
;													[1][13] - Body
;													[1][14] - Which address is the selected ? 
;															  $olNone=0, $olHome=1, $olBusiness=2, $olOther=3
;													[1][15] - Categories for the note, separated by ;
;													[1][16] - Mobile Phone Number
;													[1][17] - Home Phone Number
;													[1][18] - Home Address
;													[1][19] - Home City
;													[1][20] - Home State
;													[1][21] - Home Postal Code
;													[1][22] - Home Country
;													[1][23] - Business Phone number
;													[1][24] - Business Address
;													[1][25] - Business City
;													[1][26] - Business State
;													[1][27] - Business Postal Code
;													[1][28] - Business Country
;													[1][29] - Other Phone Number
;													[1][30] - Other Address
;													[1][31] - Other City
;													[1][32] - Other State
;													[1][33] - Other Postal Code
;													[1][34] - Other Country
;													[1][35] - WebPage
;													[1][36] - Instant Messenger address
;													[1][37] - Birthday, format YYYY-MM-DD - or what is set locally.
;			        								[1][38] - Department
;									        		[1][39] - Office
;			        								[1][40] - Profession
;			        								[1][41] - The name of your manager
;								        			[1][42] - The name of your assistant
;			        								[1][43] - Your nickname
;							        				[1][44] - Your Spouse
;						        					[1][45] - Anniversary to remember
;												  	[n][n]  - Item n
;                   On Failure   	- Returns 0 and sets @ERROR > 0
;					@ERROR = 1 		- Illegal parameters 
;					@ERROR = 9   	- ObjEvent error.
; Author(s):        Wooltown
; Created:          2009-03-04       
; Modified:         -
;
;===============================================================================
Func _OutlookGetContacts($oOutlook, $sFirstName = "", $sLastName = "", $sEmail1Adress = "", $fSearchPart = False, $fFullList = False, $sWarningClick = "")
	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
		Return SetError(2, 0, 0)
	Else
		Run($sWarningClick)
	EndIf
	;Local $oSecurityManager = ObjCreate("AddinExpress.Outlook.SecurityManager")
	;msgbox(0,"SM",IsObj($oSecurityManager))
	;$oSecurityManager.DisableOOMWarnings = True
	Local $iRc = 0, $iArraySize
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderContacts)
	Local $oColItems = $oFolder.Items
	Local $iNumOfContacts = $oColItems.Count
	If $fFullList = True Then 
		$iArraySize = 46
	Else
		$iArraySize = 5
	EndIf	
	Local $asContacts[1000][$iArraySize], $sTemp
	$asContacts[0][0] = 0
;	Msgbox(0,"antal",$iNumOfContacts)
    For $iNum = 1 to $iNumOfContacts
    ;	Msgbox(0,"antal",$iNum & " / " & $iNumOfContacts)
    	If $oColItems.Item($iNum).Class <> $olContact Then ContinueLoop
    	If $sFirstName <> "" Then
    		If $fSearchPart = False Then
    			If $sFirstName <> $oColItems.Item($iNum).FirstName Then ContinueLoop
    		Else
    			If StringInStr($oColItems.Item($iNum).FirstName,$sFirstName) = 0 Then ContinueLoop
    		EndIf	
    	EndIf
    	If $sLastName <> "" Then
    		If $fSearchPart = False Then
    			If $sLastName <> $oColItems.Item($iNum).LastName Then ContinueLoop
    		Else
    			If StringInStr($oColItems.Item($iNum).LastName,$sLastName) = 0 Then ContinueLoop
    		EndIf	
    	EndIf
    	If $sEmail1Adress <> "" Then
    		$sTemp = $oColItems.Item($iNum).Email1Address
    		If $fSearchPart = False Then
    			If $sEmail1Adress <> $sTemp Then ContinueLoop
    		Else
    			If StringInStr($sTemp,$sEmail1Adress) = 0 Then ContinueLoop
    		EndIf	
    	EndIf
    	$asContacts[0][0] += 1
    	If $fFullList = False Then 
			$asContacts[$asContacts[0][0]][0] = $oColItems.Item($iNum).FirstName
			$asContacts[$asContacts[0][0]][1] = $oColItems.Item($iNum).LastName
			$asContacts[$asContacts[0][0]][2] = $oColItems.Item($iNum).Email1Address
			$asContacts[$asContacts[0][0]][3] = $oColItems.Item($iNum).Email2Address
			$asContacts[$asContacts[0][0]][4] = $oColItems.Item($iNum).MobileTelephoneNumber
		Else
			$asContacts[$asContacts[0][0]][3] = $oColItems.Item($iNum).Title
			$asContacts[$asContacts[0][0]][4] = $oColItems.Item($iNum).MiddleName
			$asContacts[$asContacts[0][0]][5] = $oColItems.Item($iNum).Suffix
			$asContacts[$asContacts[0][0]][6] = $oColItems.Item($iNum).Email1DisplayName
			$asContacts[$asContacts[0][0]][7] = $oColItems.Item($iNum).Email2Address
			$asContacts[$asContacts[0][0]][8] = $oColItems.Item($iNum).Email2DisplayName
			$asContacts[$asContacts[0][0]][9] = $oColItems.Item($iNum).Email3Address
			$asContacts[$asContacts[0][0]][10] = $oColItems.Item($iNum).Email3DisplayName
			$asContacts[$asContacts[0][0]][11] = $oColItems.Item($iNum).JobTitle
			$asContacts[$asContacts[0][0]][12] = $oColItems.Item($iNum).CompanyName
			$asContacts[$asContacts[0][0]][13] = $oColItems.Item($iNum).Body
			$asContacts[$asContacts[0][0]][14] = $oColItems.Item($iNum).SelectedMailingAddress
			$asContacts[$asContacts[0][0]][15] = $oColItems.Item($iNum).Categories
			$asContacts[$asContacts[0][0]][16] = $oColItems.Item($iNum).MobileTelephoneNumber
			$asContacts[$asContacts[0][0]][17] = $oColItems.Item($iNum).HomeTelephoneNumber
			$asContacts[$asContacts[0][0]][18] = $oColItems.Item($iNum).HomeAddressStreet
			$asContacts[$asContacts[0][0]][19] = $oColItems.Item($iNum).HomeAddressCity
			$asContacts[$asContacts[0][0]][20] = $oColItems.Item($iNum).HomeAddressState
			$asContacts[$asContacts[0][0]][21] = $oColItems.Item($iNum).HomeAddressPostalCode
			$asContacts[$asContacts[0][0]][22] = $oColItems.Item($iNum).HomeAddressCountry
			$asContacts[$asContacts[0][0]][23] = $oColItems.Item($iNum).BusinessTelephoneNumber
			$asContacts[$asContacts[0][0]][24] = $oColItems.Item($iNum).BusinessAddressStreet
			$asContacts[$asContacts[0][0]][25] = $oColItems.Item($iNum).BusinessAddressCity
			$asContacts[$asContacts[0][0]][26] = $oColItems.Item($iNum).BusinessAddressState
			$asContacts[$asContacts[0][0]][27] = $oColItems.Item($iNum).BusinessAddressPostalCode
			$asContacts[$asContacts[0][0]][28] = $oColItems.Item($iNum).BusinessAddressCountry
			$asContacts[$asContacts[0][0]][29] = $oColItems.Item($iNum).OtherTelephoneNumber
			$asContacts[$asContacts[0][0]][30] = $oColItems.Item($iNum).OtherAddressStreet
			$asContacts[$asContacts[0][0]][31] = $oColItems.Item($iNum).OtherAddressCity
			$asContacts[$asContacts[0][0]][32] = $oColItems.Item($iNum).OtherAddressState
			$asContacts[$asContacts[0][0]][33] = $oColItems.Item($iNum).OtherAddressPostalCode
			$asContacts[$asContacts[0][0]][34] = $oColItems.Item($iNum).OtherAddressCountry
			$asContacts[$asContacts[0][0]][35] = $oColItems.Item($iNum).WebPage
			$asContacts[$asContacts[0][0]][36] = $oColItems.Item($iNum).IMaddress
			$asContacts[$asContacts[0][0]][37] = $oColItems.Item($iNum).Birthday
			$asContacts[$asContacts[0][0]][38] = $oColItems.Item($iNum).Department
			$asContacts[$asContacts[0][0]][39] = $oColItems.Item($iNum).OfficeLocation
			$asContacts[$asContacts[0][0]][40] = $oColItems.Item($iNum).Profession
			$asContacts[$asContacts[0][0]][41] = $oColItems.Item($iNum).ManagerName
			$asContacts[$asContacts[0][0]][42] = $oColItems.Item($iNum).AssistantName
			$asContacts[$asContacts[0][0]][43] = $oColItems.Item($iNum).NickName
			$asContacts[$asContacts[0][0]][44] = $oColItems.Item($iNum).Spouse
			$asContacts[$asContacts[0][0]][45] = $oColItems.Item($iNum).Anniversary
		EndIf
    Next
	$iRc = @ERROR
	Redim $asContacts[$asContacts[0][0] + 1][$iArraySize]
    If $iRc = 0 Then
    	;$oSecurityManager.DisableOOMWarnings = True
    	Return $asContacts
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-02-17       
; Modified:         -
;
;===============================================================================
Func _OutlookCreateDistList($oOutlook, $sDistList, $sFullName, $sEmailAddress, $sNotes = "", $fSameFullName = False , $sWarningClick = "")
	Local $iRc = 0, $oMemberName, $oMemberAddress, $oRecipients
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
		Return SetError(2, 0, 0)
	Else
		Run($sWarningClick)
	EndIf
	Local $oNameSpace = $oOutlook.GetNamespace("MAPI")
	Local $oMailItem = $oOutlook.CreateItem($olMailItem)
	Local $oDistList = $oOutlook.CreateItem($olDistributionListItem)
    Local $oContacts = $oNameSpace.GetDefaultFolder($olFolderContacts)

    Local $oDistListItem = $oContacts.Items( $sDistList )
    If @ERROR  = -2147352567 Then					; Add Group and member
    	SetError(0, 0, 0)
    	If $sEmailAddress = "AddMembers" Then
	    	$oRecipients = $oMailItem.Recipients
	    	$oDistList.DLName = $sDistList
	    	$oDistList.Body = $sNotes
			$oRecipients.Add ($sFullName)
			$oRecipients.ResolveAll
			$oDistList.AddMembers ($oRecipients)
	    	$oDistList.Save
			$oDistList.Close ($olSave)
			$iRc = @ERROR
		Else
			$oRecipients = $oOutlook.Session.CreateRecipient($sFullName & " <" & $sEmailAddress & ">")
	    	$oRecipients.Resolve
	    	$oDistList.AddMember ($oRecipients)
	    	$oDistList.DLName = $sDistList
	    	$oDistList.Body = $sNotes
	    	$oDistList.Save
			$oDistList.Close ($olSave)
			$iRc = @ERROR
		EndIf
    Else											; Add Member only
    	SetError(0, 0, 0)
  		If $sEmailAddress = "AddMembers" Then
  			For $iMember = 1 to $oDistListItem.MemberCount
	    		$oMemberName = $oDistListItem.GetMember($iMember).Name
	    		If $fSameFullName = False and $oMemberName = $sFullName Then Return SetError(3, 0, 0)
			Next
			$oRecipients = $oMailItem.Recipients
			$oRecipients.Add ($sFullName)
			$oRecipients.ResolveAll
			$oDistListItem.AddMembers ($oRecipients)
	    	$oDistListItem.Save
			$oDistListItem.Close ($olSave)
			$iRc = @ERROR
		Else
		   	For $iMember = 1 to $oDistListItem.MemberCount
	    		$oMemberName = $oDistListItem.GetMember($iMember).Name
	    		$oMemberAddress = $oDistListItem.GetMember($iMember).Address
	    		If $fSameFullName = False and $oMemberName = $sFullName Then Return SetError(3, 0, 0)
	    		If $oMemberAddress = $sEmailAddress Then Return SetError(4, 0, 0)
			Next
			$oRecipients = $oOutlook.Session.CreateRecipient($sFullName & " <" & $sEmailAddress & ">")
	    	$oRecipients.Resolve
	    	$oDistListItem.AddMember ($oRecipients)
	    	$oDistListItem.Save
			$oDistListItem.Close ($olSave)
			$iRc = @ERROR
		EndIf
    EndIf
    If $iRc = 0 Then
    	Return 1
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-03-04       
; Modified:         -
;
;===============================================================================
Func _OutlookGetDistLists($oOutlook, $sDistListName = "", $sFullName = "", $sEmailAddress = "", $fSearchPart = False, $sWarningClick = "")
	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
		Return SetError(2, 0, 0)
	Else
		Run($sWarningClick)
	EndIf
	If $sDistListName <> "" And ($sFullName <> "" or $sEmailAddress <> "") Then Return SetError(3, 0, 0)
	Local $iRc = 0
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderContacts)
	Local $oColItems = $oFolder.Items
	Local $iNumOfDistLists = $oColItems.Count
	Local $asDistList[1000][3]
	$asDistList[0][0] = 0
    For $iNum = 1 to $iNumOfDistLists
    	If $oColItems.Item($iNum).Class <> $olDistributionList Then ContinueLoop
    	If $sDistListName <> "" Then
    		If $fSearchPart = False Then
    			If $sDistListName <> $oColItems.Item($iNum).DLName Then ContinueLoop
    		Else
    			If StringInStr($oColItems.Item($iNum).DLName,$sDistListName) = 0 Then ContinueLoop
    		EndIf	
    	EndIf
		If $asDistList[0][0] = 999 Then
				SetError (4)
				Return $asDistList
			EndIf
		For $iMember = 1 to $oColItems.Item($iNum).MemberCount
			If $sFullName <> "" Then
	    		If $fSearchPart = False Then
    				If $sFullName <> $oColItems.Item($iNum).GetMember($iMember).Name Then ContinueLoop
    			Else
    				If StringInStr($oColItems.Item($iNum).GetMember($iMember).Name,$sFullName) = 0 Then ContinueLoop
    			EndIf	
    		EndIf
				If $sEmailAddress <> "" Then
	    		If $fSearchPart = False Then
    				If $sEmailAddress <> $oColItems.Item($iNum).GetMember($iMember).Address Then ContinueLoop
    			Else
    				If StringInStr($oColItems.Item($iNum).GetMember($iMember).Address,$sEmailAddress) = 0 Then ContinueLoop
    			EndIf	
    		EndIf
			$asDistList[0][0] += 1
			$asDistList[$asDistList[0][0]][0] = $oColItems.Item($iNum).DLName
    		$asDistList[$asDistList[0][0]][1] = $oColItems.Item($iNum).GetMember($iMember).Name
    		$asDistList[$asDistList[0][0]][2] = $oColItems.Item($iNum).GetMember($iMember).Address
		Next
    Next
	$iRc = @ERROR
	Redim $asDistList[$asDistList[0][0] + 1][3]
	If $asDistList[0][0] = 0 Then Return SetError(5, 0, 0)
    If $iRc = 0 Then
    	Return $asDistList
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-03-09 
; Modified:         -
;
;===============================================================================
Func _OutlookDeleteDistListMember($oOutlook, $sDistListName = "", $sFullName = "", $sEmailAddress = "", $sWarningClick = "")
	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
		Return SetError(2, 0, 0)
	Else
		Run($sWarningClick)
	EndIf
	Local $iRc = 0, $fDistListFound = False, $fDistListMemberFound = False
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderContacts)
	Local $oColItems = $oFolder.Items
	Local $iNumOfDistLists = $oColItems.Count
    For $iNum = 1 to $iNumOfDistLists
    	If $oColItems.Item($iNum).Class <> $olDistributionList Then ContinueLoop
    	If $sDistListName <> $oColItems.Item($iNum).DLName Then ContinueLoop
    	$fDistListFound = True
		For $iMember = 1 to $oColItems.Item($iNum).MemberCount
			If ($sFullName <> "") And ($sEmailAddress <> "") Then
    			If $sFullName = $oColItems.Item($iNum).GetMember($iMember).Name And $sEmailAddress = $oColItems.Item($iNum).GetMember($iMember).Address Then
    		    	$fDistListMemberFound = True
    		    	$oColItems.Item($iNum).GetMember($iMember).resolve
    				$oColItems.Item($iNum).RemoveMember ($oColItems.Item($iNum).GetMember($iMember))
    				$oColItems.Item($iNum).Save
					$oColItems.Item($iNum).Close ($olSave)
					Exitloop 2
    			Else 
    				ContinueLoop
    			EndIf
    		Else
    			If $sFullName <> "" Then
    				If $sFullName = $oColItems.Item($iNum).GetMember($iMember).Name Then
    		    		$fDistListMemberFound = True
    		    		$oColItems.Item($iNum).GetMember($iMember).resolve
    					$oColItems.Item($iNum).RemoveMember ($oColItems.Item($iNum).GetMember($iMember))
    					$oColItems.Item($iNum).Save
						$oColItems.Item($iNum).Close ($olSave)
						Exitloop 2
	    			Else 
    					ContinueLoop
    				EndIf
    			Else
    				If $sEmailAddress = $oColItems.Item($iNum).GetMember($iMember).Address Then
    					$fDistListMemberFound = True
    					$oColItems.Item($iNum).GetMember($iMember).resolve
    					$oColItems.Item($iNum).RemoveMember ($oColItems.Item($iNum).GetMember($iMember))
    					$oColItems.Item($iNum).Save
						$oColItems.Item($iNum).Close ($olSave)
						Exitloop 2
	    			Else 
    					ContinueLoop
    				EndIf
    			EndIf
    		EndIf
		Next
    Next
	$iRc = @ERROR
	If $fDistListFound = False Then Return SetError(3, 0, 0)
	If $fDistListMemberFound = False Then Return SetError(4, 0, 0)
    If $iRc = 0 Then
    	Return 1
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-03-09 
; Modified:         -
;
;===============================================================================
Func _OutlookDeleteDistList($oOutlook, $sDistListName)
	Local $iRc = 0, $fDistListFound = False
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderContacts)
	Local $oColItems = $oFolder.Items
	Local $iNumOfDistLists = $oColItems.Count
    For $iNum = 1 to $iNumOfDistLists
    	If $oColItems.Item($iNum).Class <> $olDistributionList Then ContinueLoop
    	If $sDistListName <> $oColItems.Item($iNum).DLName Then ContinueLoop
    	$fDistListFound = True
    	$oColItems.Item($iNum).Delete
    	ExitLoop
    Next
	$iRc = @ERROR
	If $fDistListFound = False Then Return SetError(1, 0, 0)
    If $iRc = 0 Then
    	Return 1
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
; Function Name:    _OutlookModifyDistList()
; Description:      Modify Distribution list
; Syntax.........:  _OutlookModifyDistList($oOutlook, $sDistListName, $sNewDistListName = "", $sNotes = "", $fMergeWithCurrentNotes = False, $sCategories = "", $sWarningClick = "")
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
; Author(s):        Wooltown
; Created:          2009-03-09 
; Modified:         -
;
;===============================================================================
Func _OutlookModifyDistList($oOutlook, $sDistListName, $sNewDistListName = "", $sNotes = "", $fMergeWithCurrentNotes = False, $sCategories = "", $fMergeWithCurrentCategories = False, $sWarningClick = "")
	If $sWarningClick <> "" And	FileExists($sWarningClick) = 0 Then
		Return SetError(2, 0, 0)
	Else
		Run($sWarningClick)
	EndIf
	Local $iRc = 0, $fDistListFound = False, $sTemp
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $oFolder = $oNamespace.GetDefaultFolder($olFolderContacts)
	Local $oColItems = $oFolder.Items
	Local $iNumOfDistLists = $oColItems.Count
    For $iNum = 1 to $iNumOfDistLists
    	If $oColItems.Item($iNum).Class <> $olDistributionList Then ContinueLoop
    	If $sDistListName <> $oColItems.Item($iNum).DLName Then ContinueLoop
    	$fDistListFound = True
    	If $sNewDistListName <> "" Then
    		
    		;$oColItems.Item($iNum).DLName   = $sNewDistListName 
    		$oColItems.Item($iNum).Subject   = "Kalle"
    	EndIf
    	If $sNotes <> "" Then
    		If $fMergeWithCurrentNotes = True Then
    			
    			$sTemp = $oColItems.Item($iNum).Body
    			$oColItems.Item($iNum).Body  = $sTemp & @CRLF & $sNotes
    		Else
    			$oColItems.Item($iNum).Body = $sNotes
    		EndIf
    	EndIf
    	If $sCategories <> "" Then
    		If $fMergeWithCurrentCategories = True Then
    			$sTemp = $oColItems.Item($iNum).Categories
    			$oColItems.Item($iNum).Categories = $sTemp & @CRLF & $sCategories
    		Else
    			$oColItems.Item($iNum).Categories = $sCategories
    		EndIf
    	EndIf
    	$oColItems.Item($iNum).Save
		$oColItems.Item($iNum).Close ($olSave)
    	ExitLoop
    Next
	$iRc = @ERROR
	If $fDistListFound = False Then Return SetError(3, 0, 0)
    If $iRc = 0 Then
    	Return 1
    Else
    	Return SetError(9, 0, 0)
    EndIf
EndFunc
;===============================================================================
;
; Function Name:    _OutlookFolderExist()
; Description:      Check if an Outlook folder exist
; Syntax.........:  _OutlookFolderExist($oOutlook, $sFolder)
; Parameter(s):     $oOutlook 						- Outlook object opened by a preceding call to _OutlookOpen().
;					$sFolder 						- The Name of the Folder
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	On Success   	- Return 1
;                   On Failure   	- Return 0, and sets @ERROR > 0
;					@ERROR = 9   	- ObjEvent error.
; Author(s):        Wooltown
; Created:          2009-03-11
; Modified:
;
;===============================================================================
Func _OutlookFolderExist($oOutlook, $sFolder)
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	If StringRight($sFolder,1) = "\" Then $sFolder = StringLeft($sFolder,StringLen($sFolder) - 1)
	Local $sSubFolderParts = StringSplit ( $sFolder, "\")
	Local $oFolder = $oNamespace.GetDefaultFolder($sSubFolderParts[1])
	Local $iFolderFound = 0
	If IsObj($oFolder) = 0 Then 
		Return 0
	Else
		$iFolderFound = 1
	EndIf
	Local $sRootFolderName = $oFolder.Name
	If $sSubFolderParts[0] > 1  Then
		$iFolderFound = _OutlookFindRootFolder($oFolder,$sRootFolderName,StringMid($sFolder,StringInStr($sFolder,"\")+ 1))
	EndIf
	If $iFolderFound = 0 Then Return 0
	Return 1
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-03-11
; Modified:
;
;===============================================================================
Func _OutlookFolderAdd($oOutlook, $sFolder)
	If StringRight($sFolder,1) = "\" Then $sFolder = StringLeft($sFolder,StringLen($sFolder) - 1)
	If _OutlookFolderExist($oOutlook, $sFolder) Then Return SetError(1, 0, 0)
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $sSubFolderParts = StringSplit ( $sFolder, "\")
	Local $oFolder = $oNamespace.GetDefaultFolder($sSubFolderParts[1])
	Local $fSubFolderExist = False
	If IsObj($oFolder) = 0 Then Return SetError(2, 0, 0)
	Local $sFolderName = $oFolder.Name
	For $iLevel = 2 to $sSubFolderParts[0]
		$sFolderName &= "\" & $sSubFolderParts[$iLevel]
		If _OutlookFolderExist($oOutlook, $sFolderName) Then ContinueLoop
		$fSubFolderExist = False
		
		For $oSubFolder in $oFolder.Folders
			If StringMid($sFolderName,StringInStr($sFolderName,"\",0,-1) + 1) = $oSubFolder.Name Then 
				$fSubFolderExist = True
				ExitLoop
			EndIf
		Next
		If $fSubFolderExist = True Then
			$oFolder = $oSubFolder
		Else
		    $oFolder.Folders.Add($sSubFolderParts[$iLevel])
			$oFolder = $oSubFolder
		EndIf
	Next
	If _OutlookFolderExist($oOutlook, $sFolder) = 0 Then Return SetError(3, 0, 0)
	Return 1
EndFunc
;===============================================================================
;
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
; Author(s):        Wooltown
; Created:          2009-03-11
; Modified:
;
;===============================================================================
Func _OutlookFolderDelete($oOutlook, $sFolder, $fDeleteSubFolders = False)
	If StringRight($sFolder,1) = "\" Then $sFolder = StringLeft($sFolder,StringLen($sFolder) - 1)
	If _OutlookFolderExist($oOutlook, $sFolder) = 0 Then Return SetError(1, 0, 0)
	Local $oOuError = ObjEvent("AutoIt.Error", "_OutlookError")
	Local $oNamespace = $oOutlook.GetNamespace("MAPI")
	Local $sSubFolderParts = StringSplit ( $sFolder, "\")
	Local $oFolder = $oNamespace.GetDefaultFolder($sSubFolderParts[1])
	Local $oFolderName
	If IsObj($oFolder) = 0 Then Return SetError(1, 0, 0)
	Local $sFolderName = $oFolder.Name
	For $iLevel = 2 to $sSubFolderParts[0]
		$sFolderName &= "\" & $sSubFolderParts[$iLevel]
		If _OutlookFolderExist($oOutlook, $sFolderName) Then ContinueLoop
		For $oSubFolder in $oFolder.Folders
			If StringMid($sFolderName,StringInStr($sFolderName,"\",0,-1) + 1) = $oSubFolder.Name Then
				If $iLevel + 1 = $sSubFolderParts[0] Then 
					For $iIdx = 1 to $oSubFolder.Folders.Count 
						$oFolderName = $oSubFolder.Folders.Item($iIdx)
						If $oFolderName.Name = $sSubFolderParts[$sSubFolderParts[0]] Then 
							If $oFolderName.Folders.Count > 0 And $fDeleteSubFolders = False Then Return SetError(3, 0, 0)
							$oSubFolder.Folders.Remove ($iIdx)
						EndIf
					Next
					ExitLoop 2
				EndIf
				$oFolder = $oSubFolder
				ExitLoop
			EndIf
		Next
	Next
	If _OutlookFolderExist($oOutlook, $sFolder) = 1 Then Return SetError(2, 0, 0)
	Return 1
EndFunc
;===============================================================================
;
; Function Name:    _OutlookFindRootFolder()
; Description:      Find the Mail Root folder 
; Syntax.........:  _OutlookFindRootFolder(ByRef $oFolder, Byref $sRootFolderName, $sFolder)
; Parameter(s):     $oFolder 						- The Folder Object
;					$sRootFolderName				- The name of the Root Folder
;					$sFolder						- The Folder to search for
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	Return 1 if folder is found, otherwise 0
; Author(s):        Wooltown
; Created:          2009-02-26       
; Modified:         2009-03-11						- Return 1 if folder is found, otherwise 0
;
;===============================================================================
Func _OutlookFindRootFolder(ByRef $oFolder, Byref $sRootFolderName, $sFolder)
	Local $sSubFolder = "", $iReturnValue = 0
	If StringInStr($sFolder,"\") > 0 Then
		$sSubFolder = StringMid($sFolder,StringInStr($sFolder,"\") + 1)
		$sFolder = StringLeft($sFolder,StringInStr($sFolder,"\") - 1)
	EndIf
	For $oSubFolder in $oFolder.Folders
		If $sFolder = $oSubFolder.Name Then
			$sRootFolderName &= "\" & $oSubFolder.Name
			$oFolder = $oSubFolder
			If $sSubFolder <> "" Then 
				$iReturnValue = _OutlookFindRootFolder($oFolder, $sRootFolderName, $sSubFolder)
			Else
				$iReturnValue = 1
			EndIf
			Return $iReturnValue
		EndIf
	Next
	Return $iReturnValue
EndFunc

;===============================================================================
;
; Function Name:    _OutlookFindMailInTree()
; Description:      Find all Mail in tree structure 
; Syntax.........:  _OutlookFindMailInTree(ByRef $asMail, $oFolder, $sFolderName, $fSubFolders, $sFrom, $sTo, $sCc, $sBCc, $sSubject, $iImportance, $fOnlyReturnUnread, $iSetStatus, $fCountMailOnly = False)
; Parameter(s):     $asMail 			- Array with all mails
; Parameter(s):     $oFolder 			- The Folder Object
;					$sFolderName		- The Folder to search for mail in
;					$fSubFolders		- Will Subfolders be searched ?
;					$sFrom        		- The e-mail address of the sender
;                   $sTo          	 	- The recipiant(s)
;                   $sCc        	 	- The CC recipiant(s) of the mail
;                   $sBCc        		- The BCC recipiant(s) of the mail
;					$sSubject	      	- The Subject of the mail
;                   $iImportance	 	- The Importance of the mail
;					$fOnlyReturnUnread 	- Return all mail - False, only unread - True
;					$iSetStatus			- 0 - Don't change status
;										  1 - Set as Read
;										  2 - Set as UnRead
;										  3 - Change status Read > Unread, Unread > Read
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
;									  [1][16] - Class
;									  [n][n] - Item n
; Author(s):        Wooltown
; Created:          2009-02-26       
; Modified:         2009-03-02
;
;===============================================================================
Func _OutlookFindMailInTree(ByRef $asMail, $oFolder, $sFolderName, $fSubFolders, $sFrom, $sTo, $sCc, $sBCc, $sSubject, $iImportance, $fOnlyReturnUnread, $iSetStatus, $fCountMailOnly)
	If $fSubFolders = True Then
		For $oSubFolder in $oFolder.Folders
			_OutlookFindMailInTree($asMail, $oSubFolder, $sFolderName & "\" & $oSubFolder.Name, $fSubFolders, $sFrom, $sTo, $sCc, $sBCc, $sSubject, $iImportance, $fOnlyReturnUnread, $iSetStatus, $fCountMailOnly)
		Next
	EndIf
	Local $oFileName, $iMail = $asMail[0][0]
	Local $oItems = $oFolder.Items
	$asMail[0][0] += $oItems.Count
	$asMail[0][1] += $oFolder.UnReadItemCount
	If $asMail[0][0] >= 9999 Then
   		SetError (4)
   		Return $asMail
   	EndIf
   	If $fCountMailOnly = False Then 
	 	For $oMessage In $oFolder.Items
	 		$iMail += 1
	    	$iAttachCnt = $oMessage.Attachments.Count
	    	$asMail[$iMail][0] = $oMessage.SenderName
	    	$asMail[$iMail][1] = $oMessage.SenderEmailAddress
	    	$asMail[$iMail][2] = $oMessage.To
	    	$asMail[$iMail][3] = $oMessage.Cc
	    	$asMail[$iMail][4] = $oMessage.Bcc
	    	$asMail[$iMail][5] = $oMessage.ReceivedTime
	    	$asMail[$iMail][6] = $oMessage.SentOn
	    	$asMail[$iMail][7] = $oMessage.Subject
	    	$asMail[$iMail][8] = $sFolderName
	    	$asMail[$iMail][9] = $oMessage.Body
	    	$asMail[$iMail][10] = $oMessage.BodyFormat
	    	$asMail[$iMail][11] = $oMessage.Importance
	    	$asMail[$iMail][12] = $oMessage.UnRead 
	    	$asMail[$iMail][13] = $oMessage.Size
	    	$asMail[$iMail][14] = $oMessage.FlagIcon
	        $iAttachCnt = $oMessage.Attachments.Count
			If $iAttachCnt > 0 Then
				For $iCtr = 1 To $iAttachCnt
					If $iCtr = 1 Then
						$oFileName = $oMessage.Attachments.Item($iCtr)
						;$asMail[$iMail][15] &= $oMessage.Attachments.Item($iCtr).FileName
						$asMail[$iMail][15] &= $oFileName.FileName
					Else
						$oFileName = $oMessage.Attachments.Item($iCtr)
						;$asMail[$iMail][15] &= ";" & $oMessage.Attachments.Item($iCtr).FileName
						$asMail[$iMail][15] &= ";" & $oFileName.FileName
					EndIf
				Next
			EndIf
			$asMail[$iMail][16] = $oMessage.Class
			If $fOnlyReturnUnread = True Then
				If $asMail[$iMail][12] = False Then
					$iMail -= 1
					ContinueLoop
				EndIf
			EndIf
			If Not ($sFrom = "" And $sTo = "" And $sCc = "" And $sBCc = "" And $sSubject = "" And $iImportance = "") Then
				If $sFrom <> "" Then
					If StringInStr($asMail[$iMail][0],$sFrom) = 0 Then
						$iMail -= 1
						ContinueLoop
					EndIf
				EndIf
				If $sTo <> "" Then
					If StringInStr($asMail[$iMail][2],$sTo) = 0 Then
						$iMail -= 1
						ContinueLoop
					EndIf
				EndIf
				If $sCc <> "" Then
					If StringInStr($asMail[$iMail][3],$sCc) = 0 Then
						$iMail -= 1
						ContinueLoop
					EndIf
				EndIf
				If $sBcc <> "" Then
					If StringInStr($asMail[$iMail][4],$sBcc) = 0 Then
						$iMail -= 1
						ContinueLoop
					EndIf
				EndIf
				If $sSubject <> "" Then
					If StringInStr($asMail[$iMail][7],$sSubject) = 0 Then
						$iMail -= 1
						ContinueLoop
					EndIf
				EndIf
				If $iImportance <> "" Then
					If StringInStr($asMail[$iMail][11],$iImportance) = 0 Then
						$iMail -= 1
						ContinueLoop
					EndIf
				EndIf
			EndIf
			Switch $iSetStatus
				Case 1
					$oMessage.UnRead = False
				Case 2
					$oMessage.UnRead = True
				Case 3
					If $oMessage.UnRead = False Then
						$oMessage.UnRead = True
					Else
						$oMessage.UnRead = False
					EndIf
			EndSwitch
		Next
	EndIf
EndFunc
;===============================================================================
;
; Function Name:    _OutlookError()
; Description:      Called if an ObjEvent error occurs
; Requirement(s):   AutoIt3 with COM support (post 3.1.1)
; Return Value(s): 	9
; Author(s):        Wooltown
; Created:          2009-02-09       
; Modified:         -
;
;===============================================================================
Func _OutlookError()
	Return SetError(9, 0, 0)
EndFunc