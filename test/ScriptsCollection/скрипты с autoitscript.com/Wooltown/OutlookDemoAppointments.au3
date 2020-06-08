#Include <Array.au3>
#Include "V:\Source Code\Outlook\Outlook.au3"
$oOutlook = _OutlookOpen()

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
;
; Create a recurring appointment called "Meeting" starting 2009-02-12 09:00, ending 2009-02-12 10:00 in Conference room, recurring from 2009-02-11 00:00 to 2009-03-31 23:59, reminder 15 minutes before, High Importance, Confidential
; _OutlookCreateAppointment($oOutlook, "Meeting", "2009-02-12 09:00","2009-02-12 10:00", "Conference room", "False", "Details",15, $olTentative,$olImportanceHigh,$olConfidential,$olRecursWeekly,"2009-02-11 00:00","2009-03-31 23:59")
; create a single appointment called "Meeting" starting 2009-02-12 09:00, ending 2009-02-12 10:00 in Conference room, reminder 15 minutes before
; _OutlookCreateAppointment($oOutlook, "Meeting", "2009-02-12 09:00","2009-02-12 10:00", "Conference room", "False", "Details",15)



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
;
; Change Single Appointment from "2009-02-27 12:00" Lunch to "2009-02-27 18:00" Dinner, Confidential, Importance: High
;$xx = _OutlookModifyAppointment($oOutlook, "Lunch", "2009-02-27 12:00", "Dinner", "2009-02-27 18:00","2009-02-27 19:00", "Conference room", "False", "Details",15, $olTentative,$olImportanceHigh,$olConfidential)
; Change Recurrent Appointment from "2009-02-27 12:00" Lunch to "2009-02-27 18:00" Dinner, recurring Monthly on 2nd friday per month, Confidential, Importance: High
;$xx = _OutlookModifyAppointment($oOutlook, "Lunch", "2009-02-27 12:00", "Dinner", "2009-02-27 18:00","2009-02-27 19:00", "Conference room", "False", "Details",15, $olTentative,$olImportanceHigh,$olConfidential,$olRecursMonthNth,"2009-02-22 00:00","2009-12-31 23:59","",$olFriday,"",2)


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
;
;
; Get all appointments from "2009-01-01 00:00" to "2009-02-27 00:00" both Part of day and All day events, in any place.
;$xx = _OutlookGetAppointments($oOutlook, "","2009-01-01 00:00","2009-02-27 00:00","",2,"")
;_Arraydisplay($xx)