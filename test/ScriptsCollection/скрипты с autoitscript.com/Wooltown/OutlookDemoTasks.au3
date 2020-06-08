#Include <Array.au3>
#Include "V:\Source Code\Outlook\Outlook.au3"
$oOutlook = _OutlookOpen()

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
;
;
; Create a Task with Subject "test" and body "body" with high importance, starting "2009-02-10" and ending "2009-03-01", category Business
; _OutlookCreateTask($oOutlook,"test","body","2009-02-10","2009-03-01",$olImportanceHigh,"2009-02-25 09:00","Business")



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
;
; Display all tasks, returning them in an array
;$xx = _OutlookGetTasks($oOutlook,"","","","","V:\Source Code\Outlook\OutlookWarning2.exe")
; Display all not started tasks, returning them in an array
;$xx = _OutlookGetTasks($oOutlook,"","","",$olTaskNotStarted,"V:\Source Code\Outlook\OutlookWarning2.exe")
;_Arraydisplay($xx)


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
;
; 
; Delete a task with the subject "Demo", returning a list of all deleted tasks.
;$xx = _OutlookDeleteTask($oOutlook,"Demo","","","","V:\Source Code\Outlook\OutlookWarning2.exe")
;_Arraydisplay($xx)


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
;
; Modify task "Create Outlook UDF" and name it "Create enhanced Outlook UDF" and set it to 100% complete
;$xx = _OutlookModifyTask($oOutlook,"Create Outlook UDF","","Create enhanced Outlook UDF","","","",  "",  "",100,"", "",  "",  "",  "","",  "",  "",  "", "", "",  "","V:\Source Code\Outlook\OutlookWarning2.exe")