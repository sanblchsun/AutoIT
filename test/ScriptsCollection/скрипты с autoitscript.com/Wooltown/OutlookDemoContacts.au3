#Include <Array.au3>
#Include "V:\Source Code\Outlook\Outlook.au3"
$oOutlook = _OutlookOpen()

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
;
; Create a new contact "Charles Canon", "Charles.Canon1@domain.com" with a lot of different options
; _OutlookCreateContact($oOutlook,"Charles","Canon","Charles.Canon1@domain.com", "Mr", "Sebastian", "III", "Charles Canon1","Charles.Canon2@domain.com", "Charles Canon2","Charles.Canon3@domain.com", "Charles Canon3","Job Title","Company Name","Body",$olBusiness,"Business","+99 999 999 999","111 111","Street 1","Staden 1","The State 1","Zip code 1","CountryA","222 222","Street 2","Staden 2","The State 2","Zip code 2","CountryB","333 333","Street 3","Staden 3","The State 3","Zip code 3","CountryC","http://www.domain.com","charles@hotmail.com", "1999-12-31","Sales dep.","Office 23","Manager","Boss name","Assistant name","Nick name","spouse","1999-12-24")



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
;
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
;
; Get all contacts containg "son" in the last name, displaying all fields in an array
$xx = _OutlookGetContacts($oOutlook,"","son","",True,False,"V:\Source Code\Outlook\OutlookWarning2.exe")
; Get all contacts named "Andersson" in the last name, displaying a short list in an array
;$xx = _OutlookGetContacts($oOutlook,"","Anderson","",False,False,"V:\Source Code\Outlook\OutlookWarning2.exe")
_Arraydisplay($xx)
