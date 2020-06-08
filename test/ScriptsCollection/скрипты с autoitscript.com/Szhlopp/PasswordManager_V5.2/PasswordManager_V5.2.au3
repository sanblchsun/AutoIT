#include <GUIConstants.au3>
#include <GuiComboBoxEx.au3>
#include <String.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>
#include <IE.au3>
#include <misc.au3>
;
Opt("TrayMenuMode",1)
$trayHideShow = TrayCreateItem("Hide/Show")
$trayExit = TrayCreateItem("Exit")
TrayItemSetState($trayExit, 128)
TrayItemSetState($trayHideShow, 128)

Global $loggedinName = ""
Global $loggedinPassword = ""
Global $loginSuccess = False
Global $IETimeout = False
Global $CallHotKey = False
Global $MainGUI, $List1, $Webinput, $Passinput, $Userinput, $InfoInput, $Search_group
Global $AE_DisplayInput, $AE_InfoInput, $AE_PassInput, $AE_UserInput, $AE_WebInput, $AE_AutoUser
Global $AE_AutoPass, $AE_AutoLogin, $AE_InfoLabel, $AE_list1, $AE_EnableAutoLogin, $AE_HotKeyLabel





; --------------------------------------------------------------------
Global $SavePasswordsPassword = "Abc" 
Global $PrimaryUserAccount = "123"
; If any important changes are made, you don't have to loose your data
; and re-enter it all because of the 3 lost passwords at compile time. 

; This option will show on the menu of the 'PrimaryUserAccount' account. 
; If these are forgotten, everytime this gets updated you have to re-enter all your information.
; It IS safe to store this information as an item in the password manager. I recommend doing so.

;




; This script is meant to be modified (Passwords/install location) and COMPILED! If you do not compile the script your data is NOT safe!
; After compiling delete the EncryptedPass, LIU and LIP passwords, then save. Your code is NOT safe if these passwords are obtainable!


; Change these options BEFORE compiling this script! ----------------------------------------------------------------------------------------------------------

Global $EncryptionPassword = "{11B264C8-240D-4A0D-8A8A-660CFFEAE83B}" ; These three are combined when creating the login information. 
Global $LIU = "{494C63BC-3D68-4391-B1D3-F5F1923A0B63}" ; ^^^^^^^^^^^^^^ Use the included keygen to auto update these ^^^^^^^^^^^^^^^^
Global $LIP = "{E52F3049-891C-4E59-B3EC-588166E4ED1D}" ; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Global $EncryptionLevel = 3 ; How secure do you want to be???  Default is 3

Global $INIFileLocation = @ScriptDir & '\PassMan.ini'
; I've used this INIlocation string in my whole script. Don't worry about renaming the file or directory. Change it to anything you want!
; i.e: @tempdir & '\PM.pmf'    ;   =D

; -------------------------------------------------------------------------------------------------------------------------------------------------------------

Login()

Func Login()

	$loginSuccess = False
	$loggedinName = $LIU
	$loggedinPassword = $LIP

	; ------- Default Username ------
	$defusername = IniRead($INIFileLocation, "Defaults", "Username", "")
	If $defusername = "" Then
		IniWrite($INIFileLocation, "Defaults", "Username", "")
		$defusername = @UserName
	EndIf
	; -------------------------------



	; ------- GUI create ------------
	$LoginGUI = GUICreate("Login", 302, 135)
	$loginusername = GUICtrlCreateCombo($defusername, 102, 21, 165, 21)
	GUICtrlCreateLabel("Username:", 30, 22, 55, 17)
	$loginpassword = GUICtrlCreateInput("", 102, 55, 165, 21, 32)
	GUICtrlCreateLabel("Password:", 30, 56, 53, 17)
	GUICtrlCreateGroup("Credentials", 6, 1, 286, 86)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$loginlogin = GUICtrlCreateButton("Login", 5, 105, 88, 25, 0)
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
	GUICtrlSetTip(-1, "Click here to login")
	$logincreate = GUICtrlCreateButton("Create", 206, 105, 88, 25, 0)
	GUICtrlSetTip(-1, "Don't have an account? Click here to create one!")
	; -------------------------------


	$Usernames = IniReadSection($INIFileLocation, "Usernames")
	If @error <> 1 Then

		$Usernames_Length = UBound($Usernames) - 1
		For $I = 1 To $Usernames_Length
			
			$split = StringSplit($Usernames[$I][1], "|")
			GUICtrlSetData($loginusername, _StringEncrypt(0, $split[1], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
			;MsgBox(0, "", $Usernames[$I][1])
			
		Next
		


	EndIf


	Local $warnicon1, $warnicon2
	$warnicon1 = GUICtrlCreateIcon("Shell32.dll", -132, 270, 22, 15, 15)
	GUICtrlSetState(-1, $GUI_HIDE)
	$warnicon2 = GUICtrlCreateIcon("Shell32.dll", -132, 270, 58, 15, 15)
	GUICtrlSetState(-1, $GUI_HIDE)
	$warnicon3 = GUICtrlCreateIcon("Shell32.dll", -145, 145, 95, 15, 15)
	GUICtrlSetState(-1, $GUI_HIDE)
	$statuslabel = GUICtrlCreateLabel("Successfully created!", 100, 118)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetState(-1, $GUI_HIDE)


	GUISetState(@SW_SHOW)

	$loginSuccess = False

	While 1
		
		Sleep(20)
		
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Exit
				
			Case $logincreate
				
				GUICtrlSetState($warnicon1, $GUI_HIDE)
				GUICtrlSetState($warnicon2, $GUI_HIDE)
				GUICtrlSetState($warnicon3, $GUI_HIDE)
				GUICtrlSetState($statuslabel, $GUI_HIDE)


				$loginUN = GUICtrlRead($loginusername)
				$loginPS = GUICtrlRead($loginpassword)
				
				If $loginUN = "" Then
					
					GUICtrlSetData($statuslabel, "Username is blank")
					GUICtrlSetState($statuslabel, $GUI_SHOW)
					GUICtrlSetState($warnicon1, $GUI_SHOW)
					
				ElseIf $loginPS = "" Then
					
					GUICtrlSetData($statuslabel, "Passsword is blank")
					GUICtrlSetState($statuslabel, $GUI_SHOW)
					GUICtrlSetState($warnicon2, $GUI_SHOW)
					
				Else
					
					$Usernames = IniReadSection($INIFileLocation, "Usernames")
					$Usernames_Length = UBound($Usernames) - 1
					$I = 1
					$error = 0
					If $Usernames_Length >= 1 Then
						
						For $I = 1 To $Usernames_Length
							
							$split = StringSplit($Usernames[$I][1], "|")
							If $loginUN == _StringEncrypt(0, $split[1], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel) Then
								
								
								
								$error = 1
								
								ExitLoop
								
							EndIf
							
						Next
						

						
					EndIf
					

					
					If $error = 0 Then
						
						IniWrite($INIFileLocation, "Usernames", "Username" & Int($Usernames_Length) + 1, _StringEncrypt(1, $loginUN, $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel) & "|" & _StringEncrypt(1, $loginPS, $loginUN & $EncryptionPassword, 3))
						GUICtrlSetState($warnicon3, $GUI_SHOW)
						GUICtrlSetData($statuslabel, "Successfully created!")
						GUICtrlSetState($statuslabel, $GUI_SHOW)
						
					Else
						
						GUICtrlSetState($warnicon1, $GUI_SHOW)
						GUICtrlSetState($warnicon2, $GUI_SHOW)
						GUICtrlSetData($statuslabel, "  Username in use!")
						GUICtrlSetState($statuslabel, $GUI_SHOW)
						
						
					EndIf
					
					
					
					
				EndIf
				
				
				

			Case $loginlogin
				$loginSuccess = False
				
				GUICtrlSetState($warnicon1, $GUI_HIDE)
				GUICtrlSetState($warnicon2, $GUI_HIDE)
				GUICtrlSetState($warnicon3, $GUI_HIDE)
				GUICtrlSetState($statuslabel, $GUI_HIDE)
				
				$loginUN = GUICtrlRead($loginusername)
				$loginPS = GUICtrlRead($loginpassword)
				
				
				$Usernames = IniReadSection($INIFileLocation, "Usernames")
				$Usernames_Length = UBound($Usernames) - 1
				
				For $I = 1 To $Usernames_Length
					
					$split = StringSplit($Usernames[$I][1], "|")
					If $split[2] == _StringEncrypt(1, $loginPS, $loginUN & $EncryptionPassword, $EncryptionLevel) Then
						
						
						; MsgBox(0, "", "Now logged in")
						GUICtrlSetState($warnicon3, $GUI_SHOW)
						GUICtrlSetData($statuslabel, "     Now logged in")
						GUICtrlSetState($statuslabel, $GUI_SHOW)
						$loggedinName = $loginUN
						$loggedinPassword = $loginPS
						$loginSuccess = True
						Sleep(500)
						ExitLoop
						
						
						
					EndIf
					
				Next
				
				
				GUICtrlSetState($warnicon1, $GUI_SHOW)
				GUICtrlSetState($warnicon2, $GUI_SHOW)
				GUICtrlSetData($statuslabel, "Invalid User/Pass!")
				GUICtrlSetState($statuslabel, $GUI_SHOW)
				
				
				
				

		EndSwitch
		
		If $loginSuccess = True Then
			GUIDelete($LoginGUI)
			MainGUI()
			ExitLoop
			
		EndIf
		
		
		
	WEnd

EndFunc   ;==>Login





Func MainGUI()
	
	
	TrayItemSetState($trayExit, 64)
	TrayItemSetState($trayHideShow, 64)

	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
	
	$MainGUI = GUICreate("Password Manager - Szhlopp", 538, 343)
	$menumain = GUICtrlCreateMenu("Account")
	$menudefault = GUICtrlCreateMenuItem("Set as default account", $menumain)
	$menulogout = GUICtrlCreateMenuItem("Logout", $menumain)
	$menudelete = GUICtrlCreateMenuItem("Delete account", $menumain)
	Global $menuGetPasswords = 999
	If $loggedinName = $PrimaryUserAccount Then 
		
		$menuGetPasswords = GUICtrlCreateMenuItem("Get Compile Passwords", $menumain)
		
	EndIf
	
	$List1 = GUICtrlCreateList("", 1, 1, 185, 318)


	_GUICtrlListBox_BeginUpdate($List1)

	$Items = IniReadSection($INIFileLocation, $loggedinName)
	$Items_Length = UBound($Items) - 1
	
	If $Items_Length <> -1 Then
		
		For $I = 1 To $Items_Length
			
			$split = StringSplit($Items[$I][1], "|")
			_GUICtrlListBox_AddString($List1, _StringEncrypt(0, $split[1], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
			If _StringEncrypt(0, $split[10], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel) <> "" Then HotKeySet(_StringEncrypt(0, $split[10], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel), "HotKeyPressed")
			
		Next
		
	EndIf
	
	_GUICtrlListBox_EndUpdate($List1)
	



	$Search_group = GUICtrlCreateGroup("Search (Entries: " & _GUICtrlListBox_GetCount($List1) & ")", 190, 2, 340, 72)

	$SearchInput = GUICtrlCreateInput("", 205, 31, 284, 21)
	GUICtrlCreateIcon("shell32.dll", -172, 496, 35, 16, 16) ; 135
	GUICtrlSetState(-1, $GUI_FOCUS)
	GUICtrlCreateGroup("", -99, -99, 1, 1)


	GUICtrlCreateGroup("", 190, 108 - 18, 340, 151)
	$Webinput = GUICtrlCreateInput("", 200, 133 - 18, 316 - 22, 21)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$WebIcon = GUICtrlCreateIcon("shell32.dll", -14, 496, 134 - 17, 16, 16)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetTip(-1, "Go to Website")


	$Userinput = GUICtrlCreateInput("", 200, 165 - 18, 316 - 22, 21)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$UserIcon = GUICtrlCreateIcon("shell32.dll", -174, 496, 168 - 18, 16, 16) ; 135
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetTip(-1, "Copy Username to Clipboard")
	

	$Passinput = GUICtrlCreateInput("", 200, 195 - 18, 316 - 22, 21)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$PassIcon = GUICtrlCreateIcon("shell32.dll", -48, 496, 197 - 18, 18, 18) ; 135
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetTip(-1, "Copy Password to Clipboard")
	

	$InfoInput = GUICtrlCreateInput("", 200, 224 - 18, 316 - 22, 21)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$InfoIcon = GUICtrlCreateIcon("shell32.dll", -222, 496, 227 - 18, 16, 16)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	

	GUICtrlCreateGroup("Controls", 190, 269 - 18, 340, 69)
	$AddButton = GUICtrlCreateButton("Add", 204, 292 - 18, 80, 35, 0)
	$Editbutton = GUICtrlCreateButton("Edit", 319, 292 - 18, 80, 35, 0)
	$DeleteButton = GUICtrlCreateButton("Delete", 429, 292 - 18, 80, 35, 0)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUISetState(@SW_SHOW)

	$LastSearch = ""
	$LastItem = ""
	$GUIVisible = True
	$ExitMainGui = False
	Global $UpdateListBox = False
	
	While 1
		
		Sleep(20)
		
		If $SearchInput <> "" Then

			$find = _GUICtrlListBox_FindString($List1, GUICtrlRead($SearchInput))
			If $LastSearch <> GUICtrlRead($SearchInput) Then _GUICtrlListBox_SetCurSel($List1, $find)
			$LastSearch = GUICtrlRead($SearchInput)
			
		EndIf
		
		
		
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Exit
				
			Case $AddButton
				AddEditGUI()
				
			Case $Editbutton
				AddEditGUI(1)
				
			Case $menudefault
				IniWrite($INIFileLocation, "Defaults", "Username", $loggedinName)
				MsgBox(0, "Default", "This is now the default account", 5)
	
				
			Case $menuGetPasswords
				$inputpass = InputBox("Password", "Enter the password to retrieve compile passwords:")
				if @error <> 1 Then
					
					If $inputpass == $SavePasswordsPassword Then
						MsgBox(0, "", "Saved to script directory")
						FileWrite(@ScriptDir & '\CompiledPasswords.txt', "EncryptPass: " & $EncryptionPassword & @CRLF & "LIU: " & $LIU & @CRLF & "LIP: " & $LIP)
						
						
					EndIf
					
					
				EndIf
				
				
			Case $DeleteButton

				
				$icursel = _GUICtrlListBox_GetCurSel($List1)
				$ListText = _GUICtrlListBox_GetText($List1, $icursel)
				
				$msgbox = MsgBox(4 + 48, "Delete", "Are you sure you want to delete " & $ListText & "?")
				If $msgbox = 6 Then
					
					$Usernames = IniReadSection($INIFileLocation, $loggedinName)
					$Usernames_Length = UBound($Usernames) - 1
					
					
					For $I = 1 To $Usernames_Length
						
						$split = StringSplit($Usernames[$I][1], "|")
						If _StringEncrypt(0, $split[1], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel) = $ListText Then
							IniDelete($INIFileLocation, $loggedinName, $Usernames[$I][0])
							ExitLoop
							
						EndIf

						
					Next
					
					; Now deleted... Time to update the list
					$Usernames = IniReadSection($INIFileLocation, $loggedinName)
					$Usernames_Length = UBound($Usernames) - 1

					If $Usernames_Length >= 0 Then
						Dim $tempfilecontents[$Usernames_Length]
						
						For $I = 1 To $Usernames_Length
							
							$tempfilecontents[$I - 1] = $Usernames[$I][1]
							
							
						Next
						
						; tempfile is now an array of the contents. loop through and re-apply the contents
						IniDelete($INIFileLocation, $loggedinName)
						
						For $I = 0 To $Usernames_Length - 1
							
							IniWrite($INIFileLocation, $loggedinName, "Item" & $I, $tempfilecontents[$I])
							
						Next
						
						
						
					EndIf
					
					$tempfilecontents = ""
					$UpdateListBox = True
					_GUICtrlListBox_DeleteString($List1, $icursel)
					GUICtrlSetData($Webinput, "")
					GUICtrlSetData($Userinput, "")
					GUICtrlSetData($Passinput, "")
					GUICtrlSetData($InfoInput, "")
					GUICtrlSetData($Search_group, "Search (Entries: " & _GUICtrlListBox_GetCount($List1) & ")")
					
					
				EndIf
				
				
			Case $WebIcon
				OnWWW(GUICtrlRead($Webinput))
				
			Case $UserIcon
				ClipPut(GUICtrlRead($Userinput))
				
			Case $PassIcon
				ClipPut(GUICtrlRead($Passinput))
				
			Case $menulogout
				
				$ExitMainGui = True
				
			Case $menudelete
				
				$msgbox = InputBox("Delete", "Are you sure you want to delete your account???" & @CRLF & @CRLF & "Type YES to confirm", "NO")
				If $msgbox == "YES" Then
					IniDelete($INIFileLocation, $loggedinName)
					
					$Usernames = IniReadSection($INIFileLocation, "usernames")
					$Usernames_Length = UBound($Usernames) - 1
					
					
					For $I = 1 To $Usernames_Length
						
						$split = StringSplit($Usernames[$I][1], "|")
						If _StringEncrypt(0, $split[1], $LIU & $LIP & $EncryptionPassword, $EncryptionLevel) = $loggedinName Then
							IniDelete($INIFileLocation, "Usernames", $Usernames[$I][0])
							ExitLoop
							
						EndIf

						
					Next
					
					
					$ExitMainGui = True
					
				EndIf

		EndSwitch

		Switch TrayGetMsg()
			
			Case $trayExit
				Exit
				
			Case $trayHideShow
				
				If $GUIVisible = True Then 
				
					GUISetState(@SW_HIDE, $MainGUI)
					$GUIVisible = False
				
				Else 
				
					$ExitMainGui = True
					
				
				EndIf
				
				
				
		EndSwitch


		$icursel = _GUICtrlListBox_GetCurSel($List1)
		$ListText = _GUICtrlListBox_GetText($List1, $icursel)

		If $LastItem <> $icursel Or $UpdateListBox = True Then

			
			
			; How many items there are
			$Items = IniReadSection($INIFileLocation, $loggedinName)
			$Items_Length = UBound($Items) - 1
			; -----------------------
			
			If $Items_Length >= 1 Then
				
				For $I = 1 To $Items_Length
					
					$split = StringSplit($Items[$I][1], "|")
					If _StringEncrypt(0, $split[1], $loggedinName & $loggedinPassword & $EncryptionPassword, 3) == $ListText Then
						
						;MsgBox(0, "", "found match! Item: " & $icursel & " |Text: " & $ListText)
						
						GUICtrlSetData($Webinput, _StringEncrypt(0, $split[2], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
						GUICtrlSetData($Userinput, _StringEncrypt(0, $split[3], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
						GUICtrlSetData($Passinput, _StringEncrypt(0, $split[4], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
						GUICtrlSetData($InfoInput, _StringEncrypt(0, $split[5], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
						
						ExitLoop
						
					EndIf
					
					
					
				Next
				
			EndIf

			$LastItem = $icursel
			$UpdateListBox = False
			
		EndIf

	 If $ExitMainGui = True Then ExitLoop

	WEnd

GUIDelete($MainGUI)
$loggedinName = ""
$loggedinPassword = ""
TrayItemSetState($trayExit, 128)
TrayItemSetState($trayHideShow, 128)
Login()



EndFunc   ;==>MainGUI

Func AddEditGUI($iAE = 0)
	
	; 0 Add
	; 1 Edit


	$AddEdit = GUICreate("Add/Edit", 318, 406, -1, -1, -1, BitOR($WS_EX_TOOLWINDOW, $WS_EX_WINDOWEDGE), $MainGUI)
	$AE_list1 = GUICtrlCreateList("", 4, 201, 145, 212, $WS_BORDER + $WS_VSCROLL + $WS_TABSTOP + $LBS_NOTIFY + $WS_HSCROLL)
	$AE_EnableAutoLogin = GUICtrlCreateCheckbox("Enable Auto-Login", 158, 195)

	$AE_AutoUser = GUICtrlCreateInput("", 158, 222, 140)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$AE_AutoUserButton = GUICtrlCreateButton("Select as username field", 158, 243, 140, 20)
	GUICtrlSetState(-1, $GUI_DISABLE)

	$AE_AutoPass = GUICtrlCreateInput("", 158, 265, 140)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$AE_AutoPassButton = GUICtrlCreateButton("Select as password field", 158, 285, 140, 20)
	GUICtrlSetState(-1, $GUI_DISABLE)

	$AE_AutoLogin = GUICtrlCreateInput("", 158, 308, 140)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$AE_AutoLoginButton = GUICtrlCreateButton("Login button", 158, 328, 69, 20)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$AE_AutoLoginButtonDelete = GUICtrlCreateButton("Remove", 228, 328, 69, 20)
	GUICtrlSetState(-1, $GUI_DISABLE)
	
	$AE_InfoLabel = GUICtrlCreateLabel("", 158, 350, 140, 65)

	GUICtrlCreateLabel("Display Name", 6, 18, 69, 17)
	$AE_DisplayInput = GUICtrlCreateInput("", 78, 16, 200, 21)

	GUICtrlCreateLabel("(EXE/URL)", 7, 49, 68, 17)
	$AE_WebInput = GUICtrlCreateInput("", 79, 47, 200, 21)

	GUICtrlCreateLabel("Username", 21, 77, 50, 17)
	$AE_UserInput = GUICtrlCreateInput("", 79, 75, 200, 21)

	GUICtrlCreateLabel("Password", 20, 106, 52, 17)
	$AE_PassInput = GUICtrlCreateInput("", 79, 104, 200, 21)

	GUICtrlCreateLabel("Notes", 38, 133, 32, 17)
	$AE_InfoInput = GUICtrlCreateInput("", 79, 131, 200, 21)

	$SaveButton = GUICtrlCreateButton("Save", 78, 158, 60, 22, 0)
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
	$CancelButton = GUICtrlCreateButton("Cancel", 148, 158, 60, 22, 0)
	$HotkeyButton = GUICtrlCreateButton("HotKey", 218, 158, 60, 22, 0)
	$AE_HotKeyLabel = GUICtrlCreateLabel("", 6, 162, 60, 20)
	GUICtrlSetColor(-1, 0x0000aa)
	;GUICtrlSetState(-1, $GUI_HIDE)

	GUICtrlCreateGroup("Auto-Login", 0, 185, 318, 230)

	$warnicon1 = GUICtrlCreateIcon("Shell32.dll", -132, 284, 18, 15, 15)
	GUICtrlSetState(-1, $GUI_HIDE)

	$warnicon2 = GUICtrlCreateIcon("Shell32.dll", -132, 284, 50, 15, 15)
	GUICtrlSetState(-1, $GUI_HIDE)
	
	
	Local $L = 1
		
	If $iAE = 1 Then
		
		
		$icursel = _GUICtrlListBox_GetCurSel($List1)
		$ListText = _GUICtrlListBox_GetText($List1, $icursel)
		
		if $icursel <> -1 Then
		
		GUICtrlSetData($AE_DisplayInput, $ListText)
		GUICtrlSetData($AE_WebInput, GUICtrlRead($Webinput))
		GUICtrlSetData($AE_UserInput, GUICtrlRead($Userinput))
		GUICtrlSetData($AE_PassInput, GUICtrlRead($Passinput))
		GUICtrlSetData($AE_InfoInput, GUICtrlRead($InfoInput))
		
		
		$Items = IniReadSection($INIFileLocation, $loggedinName)
		$Items_Length = UBound($Items) - 1
			
			If $Items_Length >= 1 Then
				
				For $I = 1 To $Items_Length
					
					$split = StringSplit($Items[$I][1], "|")
					If _StringEncrypt(0, $split[1], $loggedinName & $loggedinPassword & $EncryptionPassword, 3) == $ListText Then
						
						;MsgBox(0, "", "found match! Item: " & $icursel & " |Text: " & $ListText)
						; $display & "|" & $Web & "|" & $user & "|" & $pass & "|" & $info & "|" & $AutoLogin & "|" & $autousername & "|" & $autopassword & "|" & $autobutton
						$checkedstate =  _StringEncrypt(0, $split[6], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel)
						if $checkedstate = 1 then GUICtrlSetState($AE_EnableAutoLogin, $GUI_CHECKED)
						
						GUICtrlSetData($AE_AutoUser, _StringEncrypt(0, $split[7], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
						GUICtrlSetData($AE_AutoPass, _StringEncrypt(0, $split[8], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
						GUICtrlSetData($AE_AutoLogin, _StringEncrypt(0, $split[9], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
						GUICtrlSetData($AE_HotKeyLabel, _StringEncrypt(0, $split[10], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
						GUISetState(@SW_SHOW)
						
						ExitLoop
						
					EndIf
					
					
					
				Next
				
			EndIf
		
		Else
		
		$L = 0
		GUIDelete($AddEdit)
		
		EndIf
		
	Else
		
		GUISetState(@SW_SHOW)
		
		
	EndIf
	
	
	
	
	

	While $L = 1
		
		Sleep(20)
		$nMsg = GUIGetMsg()
		Switch $nMsg
			
			Case $GUI_EVENT_CLOSE
				GUIDelete($AddEdit)
				$L = 0
					
			Case $AE_AutoLoginButtonDelete
				GUICtrlSetData($AE_AutoLogin, "")

				
			Case $SaveButton
				
				GUICtrlSetState($warnicon1, $GUI_HIDE)
				
				If $iAE = 0 Then
					
					if GUICtrlRead($AE_DisplayInput) <> "" Then
						
					
					$bCanAdd = True
					$Usernames = IniReadSection($INIFileLocation, $loggedinName)
					$Usernames_Length = UBound($Usernames) - 1
					
					For $I = 1 To $Usernames_Length
						
						$split = StringSplit($Usernames[$I][1], "|")
						If _StringEncrypt(0, $split[1], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel) = GUICtrlRead($AE_DisplayInput) Then
							$bCanAdd = False
							ExitLoop
							
						EndIf
						
						
						
					Next
					
					If $bCanAdd = True Then
						
						_GUICtrlListBox_AddString($List1, GUICtrlRead($AE_DisplayInput))
						If $Usernames_Length = -1 Then
							IniWrite($INIFileLocation, $loggedinName, "Item1", CreateEncryptedItem());
							
						Else
							IniWrite($INIFileLocation, $loggedinName, "Item" & ($Usernames_Length + 1), CreateEncryptedItem())
							
						EndIf
						
						GUICtrlSetData($Search_group, "Search (Entries: " & _GUICtrlListBox_GetCount($List1) & ")")
						;MsgBox(0, "", $Usernames_Length)
						$L = 0
						;IniWriteSection($INIFileLocation, $loggedinName, "Item
						GUIDelete($AddEdit)
						$L = 0
						
					Else
						
						GUICtrlSetState($AE_DisplayInput, $GUI_FOCUS)
						GUICtrlSetState($warnicon1, $GUI_SHOW)
						
						
					EndIf
					
					Else
					
						GUICtrlSetState($AE_DisplayInput, $GUI_FOCUS)
						GUICtrlSetState($warnicon1, $GUI_SHOW)
					
					
					EndIf
					
				Else
					
					
					if GUICtrlRead($AE_DisplayInput) <> "" Then
					
					$icursel = _GUICtrlListBox_GetCurSel($List1)
					$ListText = _GUICtrlListBox_GetText($List1, $icursel)
					
					$inikeyname = ""
					$Usernames = IniReadSection($INIFileLocation, $loggedinName)
					$Usernames_Length = UBound($Usernames) - 1
					
					For $I = 1 To $Usernames_Length
						
						$split = StringSplit($Usernames[$I][1], "|")
						If _StringEncrypt(0, $split[1], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel) == $ListText Then
							_GUICtrlListBox_DeleteString($List1, $icursel)
							_GUICtrlListBox_AddString($List1, GUICtrlRead($AE_DisplayInput))
							$inikeyname = $Usernames[$I][0]
							ExitLoop
							
						EndIf
						
						
						
					Next
					
					IniWrite($INIFileLocation, $loggedinName, $inikeyname, CreateEncryptedItem());
					GUIDelete($AddEdit)
					$L = 0
					$UpdateListBox = True
					_GUICtrlListBox_SetCurSel($List1, $icursel)
					
					Else
					
						GUICtrlSetState($AE_DisplayInput, $GUI_FOCUS)
						GUICtrlSetState($warnicon1, $GUI_SHOW)
					
					
					EndIf
					
					
				EndIf
				
				
			Case $CancelButton
				GUIDelete($AddEdit)
				$L = 0
				
			Case $AE_EnableAutoLogin
				
				If GUICtrlRead($AE_EnableAutoLogin) = $GUI_CHECKED Then
					
					GUICtrlSetState($AE_AutoLoginButton, $GUI_ENABLE)
					GUICtrlSetState($AE_AutoPassButton, $GUI_ENABLE)
					GUICtrlSetState($AE_AutoUserButton, $GUI_ENABLE)
					GUICtrlSetState($AE_AutoLoginButtonDelete, $GUI_ENABLE)
					If StringLeft(GUICtrlRead($AE_WebInput), 4) = "www." Or StringLeft(GUICtrlRead($AE_WebInput), 7) = "http://" Or StringLeft(GUICtrlRead($AE_WebInput), 8) = "https://" Then
						GUICtrlSetData($AE_InfoLabel, "Downloading controls list. Please wait...")
						GetElementList(GUICtrlRead($AE_WebInput))
						if $IETimeout = False then

							; Username------------------------------------------

							If IEElementFindItem("Username", 1) = True Then 
								$IEEleFind = IEElementFindItem("Username")
								GUICtrlSetData($AE_AutoUser, $IEEleFind[1])
							ElseIf IEElementFindItem("User", 1) = True Then
								$IEEleFind = IEElementFindItem("User")
								GUICtrlSetData($AE_AutoUser, $IEEleFind[1])
								
							ElseIf IEElementFindItem("Name", 1) = True Then
								$IEEleFind = IEElementFindItem("Name")
								GUICtrlSetData($AE_AutoUser, $IEEleFind[1])
								
							ElseIf IEElementFindItem("Email", 1) = True Then
								$IEEleFind = IEElementFindItem("Email")
								GUICtrlSetData($AE_AutoUser, $IEEleFind[1])
								
							ElseIf IEElementFindItem("Login", 1) = True Then
								$IEEleFind = IEElementFindItem("Login")
								GUICtrlSetData($AE_AutoUser, $IEEleFind[1])
								
							EndIf
					
							; Password------------------------------------------
							
							If IEElementFindItem("Password", 1) = True Then 
								$IEEleFind = IEElementFindItem("Password")
								GUICtrlSetData($AE_AutoPass, $IEEleFind[1])
							ElseIf IEElementFindItem("Pass", 1) = True Then
								$IEEleFind = IEElementFindItem("Pass")
								GUICtrlSetData($AE_AutoPass, $IEEleFind[1])
								
							ElseIf IEElementFindItem("Pwd", 1) = True Then
								$IEEleFind = IEElementFindItem("Pwd")
								GUICtrlSetData($AE_AutoPass, $IEEleFind[1])
							EndIf
							
							
							
							
							; LoginButton------------------------------------------
							
							$bLoginButtonFound = False
							$seluserinput = GUICtrlRead($AE_AutoPass)
							If $seluserinput <> "" Then
								$itemIndex = _GUICtrlListBox_FindString($AE_list1, $seluserinput, True)
								$ItemText = _GUICtrlListBox_GetText($AE_list1, Int($itemIndex) + 2)
								If StringInStr($ItemText, "Submit", 0) >= 1 Then
									GUICtrlSetData($AE_AutoLogin, $ItemText)
									$bLoginButtonFound = True
								ElseIf StringInStr($ItemText, "SI", 0) >= 1 Then
									GUICtrlSetData($AE_AutoLogin, $ItemText)
									$bLoginButtonFound = True
								ElseIf StringInStr($ItemText, "Sign", 0) >= 1 Then
									GUICtrlSetData($AE_AutoLogin, $ItemText)
									$bLoginButtonFound = True
								ElseIf StringInStr($ItemText, "LogMe", 0) >= 1 Then
									GUICtrlSetData($AE_AutoLogin, $ItemText)
									$bLoginButtonFound = True
								ElseIf StringInStr($ItemText, "Login", 0) >= 1 Then
									GUICtrlSetData($AE_AutoLogin, $ItemText)
									$bLoginButtonFound = True
								ElseIf StringInStr($ItemText, "Log", 0) >= 1 Then
									GUICtrlSetData($AE_AutoLogin, $ItemText)
									$bLoginButtonFound = True
								EndIf
							
							EndIf
						
						
							If $bLoginButtonFound = False Then
							
								If IEElementFindItem("Submit", 1) = True Then 
									$IEEleFind = IEElementFindItem("Submit")
									GUICtrlSetData($AE_AutoLogin, $IEEleFind[1])
									
								ElseIf IEElementFindItem("SI", 1) = True Then
									$IEEleFind = IEElementFindItem("SI")
									GUICtrlSetData($AE_AutoLogin, $IEEleFind[1])
									
								ElseIf IEElementFindItem("Sign", 1) = True Then
									$IEEleFind = IEElementFindItem("Sign")
									GUICtrlSetData($AE_AutoLogin, $IEEleFind[1])
									
								ElseIf IEElementFindItem("LogMe", 1) = True Then
									$IEEleFind = IEElementFindItem("LogMe")
									GUICtrlSetData($AE_AutoLogin, $IEEleFind[1])
									
								ElseIf IEElementFindItem("Login", 1) = True Then
									$IEEleFind = IEElementFindItem("Login")
									GUICtrlSetData($AE_AutoLogin, $IEEleFind[1])
									
								ElseIf IEElementFindItem("Log", 1) = True Then
									$IEEleFind = IEElementFindItem("Log")
									GUICtrlSetData($AE_AutoLogin, $IEEleFind[1])
								ElseIf IEElementFindItem("DispHTMLButtonElement", 1) = True Then
									$IEEleFind = IEElementFindItem("DispHTMLButtonElement")
									GUICtrlSetData($AE_AutoLogin, $IEEleFind[1])
									
								EndIf
							
							EndIf
							
					
						EndIf
						
						
					Else
						
						GUICtrlSetData($AE_InfoLabel, "Invalid URL. (www.) (Http://) (Https://)")
						GUICtrlSetState($warnicon2, $GUI_SHOW)
						GUICtrlSetState($AE_EnableAutoLogin, $GUI_UNCHECKED)
						
					EndIf
					
					
				Else
					
					GUICtrlSetState($warnicon2, $GUI_HIDE)
					GUICtrlSetState($AE_AutoLoginButton, $GUI_DISABLE)
					GUICtrlSetState($AE_AutoPassButton, $GUI_DISABLE)
					GUICtrlSetState($AE_AutoUserButton, $GUI_DISABLE)
					GUICtrlSetState($AE_AutoLoginButtonDelete, $GUI_DISABLE)
					
					
					
				EndIf
				
			Case $AE_AutoUserButton
				
				$cursel = _GUICtrlListBox_GetCurSel($AE_list1)
				
				If $cursel <> -1 Then
					$curtext = _GUICtrlListBox_GetText($AE_list1, $cursel)
					GUICtrlSetData($AE_AutoUser, $curtext)
					
				Else
					
					GUICtrlSetData($AE_InfoLabel, "ERROR: No selected item!")
					
				EndIf
				
			Case $AE_AutoPassButton
				
				$cursel = _GUICtrlListBox_GetCurSel($AE_list1)
				
				If $cursel <> -1 Then
					$curtext = _GUICtrlListBox_GetText($AE_list1, $cursel)
					GUICtrlSetData($AE_AutoPass, $curtext)
					
				Else
					
					GUICtrlSetData($AE_InfoLabel, "ERROR: No selected item!")
					
				EndIf
				
			Case $AE_AutoLoginButton
				
				$cursel = _GUICtrlListBox_GetCurSel($AE_list1)
				
				If $cursel <> -1 Then
					$curtext = _GUICtrlListBox_GetText($AE_list1, $cursel)
					GUICtrlSetData($AE_AutoLogin, $curtext)
					
				Else
					
					GUICtrlSetData($AE_InfoLabel, "ERROR: No selected item!")
					
				EndIf
				
				
				
			Case $HotkeyButton
				$HK_GUI = GUICreate("HotKey", 355, 81, -1, -1, -1, $WS_EX_TOOLWINDOW, $AddEdit)
				$Combo1 = GUICtrlCreateCombo("-None-", 8, 7, 110, 25)
				GUICtrlSetData(-1, "Alt|Control|Shift")
				$Combo2 = GUICtrlCreateCombo("Alt", 123, 7, 110, 25)
				GUICtrlSetData(-1, "Control|Shift")
				$Combo3 = GUICtrlCreateCombo("0", 237, 7, 110, 25)
				GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|ENTER|BACKSPACE|DELETE|UP|DOWN|LEFT|RIGHT|HOME|END|ESCAPE|INSERT|PGUP|PGDN|F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|TAB|PRINTSCREEN|LWIN|RWIN|NUMPAD0|NUMPAD1|NUMPAD2|NUMPAD3|NUMPAD4|NUMPAD5|NUMPAD6|NUMPAD7|NUMPAD8|NUMPAD9")
				$HK_Set = GUICtrlCreateButton("Set Hotkey", 45, 46, 65, 26, 0)
				$HK_Cancel = GUICtrlCreateButton("Cancel", 140, 46, 65, 26, 0)
				$HK_Delete = GUICtrlCreateButton("Delete", 245, 46, 65, 26, 0)
				GUISetState(@SW_SHOW)
				$hotkeyloop = True
				While $hotkeyloop = true
					$nMsg = GUIGetMsg()
					Switch $nMsg
						Case $GUI_EVENT_CLOSE
							$hotkeyloop = False
							GUIDelete($HK_GUI)
							
						Case $HK_Cancel
							$hotkeyloop = False
							GUIDelete($HK_GUI)
							
						Case $HK_Delete
							GUICtrlSetData($AE_HotKeyLabel, "")
							$hotkeyloop = False
							GUIDelete($HK_GUI)
							
						Case $HK_Set
							
							$hotkeystring = ""
							If GUICtrlRead($Combo1) = "Alt" then 
								$hotkeystring = "!"
							ElseIf GUICtrlRead($Combo1) = "Control" then
								$hotkeystring = "^"
							ElseIf GUICtrlRead($Combo1) = "Shift" then
								$hotkeystring = "+"
							ElseIf GUICtrlRead($Combo1) = "-None-" then
								; Doesn't add anything, but also doesn't error.
							Else
								$hotkeystring = "Error"
							EndIf
							
							; Combo2
							If GUICtrlRead($Combo2) = "Alt" then 
								$hotkeystring &= "!"
								if $hotkeystring = "!!" Then $hotkeystring = "Error"
							ElseIf GUICtrlRead($Combo2) = "Control" then
								$hotkeystring &= "^"
								if $hotkeystring = "^^" Then $hotkeystring = "Error"
							ElseIf GUICtrlRead($Combo2) = "Shift" then
								$hotkeystring &= "+"
								if $hotkeystring = "++" Then $hotkeystring = "Error"
							Else
								$hotkeystring = "Error"
							EndIf
							
							if $hotkeystring <> "Error" Then
							
							$split = StringSplit("0|1|2|3|4|5|6|7|8|9|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|ENTER|BACKSPACE|DELETE|UP|DOWN|LEFT|RIGHT|HOME|END|ESCAPE|INSERT|PGUP|PGDN|F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|TAB|PRINTSCREEN|LWIN|RWIN|NUMPAD0|NUMPAD1|NUMPAD2|NUMPAD3|NUMPAD4|NUMPAD5|NUMPAD6|NUMPAD7|NUMPAD8|NUMPAD9", "|")
							For $I = 1 to $split[0]
								
								If GUICtrlRead($Combo3) = $split[$I] Then
									$hotkeystring &= "{" & StringLower($split[$I]) & "}"
									ExitLoop
								EndIf
								
								
							Next
							
							EndIf
							
							;TrayTip("Hotkey", $hotkeystring, 1)
							If $hotkeystring <> "Error" Then
								HotKeySet($hotkeystring, "HotKeyPressed")
								GUICtrlSetData($AE_HotKeyLabel, $hotkeystring)
								$hotkeyloop = False
								GUIDelete($HK_GUI)
							
							Else
								
								TrayTip("Error", "HotKey combination not possible", 1)
							
							EndIf
								

					EndSwitch
				WEnd
				

		EndSwitch
	WEnd

	
	
	
	
	
EndFunc   ;==>AddEditGUI

Func CreateEncryptedItem()
	
	$display = GUICtrlRead($AE_DisplayInput)
	$Web = GUICtrlRead($AE_WebInput)
	$user = GUICtrlRead($AE_UserInput)
	$pass = GUICtrlRead($AE_PassInput)
	$info = GUICtrlRead($AE_InfoInput)
	$HotKey = GUICtrlRead($AE_HotKeyLabel)
	$AutoLogin = 0
	If GUICtrlRead($AE_EnableAutoLogin) = $GUI_CHECKED Then $AutoLogin = 1
	
	$autousername = GUICtrlRead($AE_AutoUser)
	;if StringRight($autousername, 1) = ")" then $autousername = StringLeft($autousername, 3)
	
	$autopassword = GUICtrlRead($AE_AutoPass)
	;if StringRight($autopassword, 1) = ")" then $autopassword = StringLeft($autopassword, 3)
	
	$autobutton = GUICtrlRead($AE_AutoLogin)
	;if StringRight($autobutton, 1) = ")" then $autobutton = StringLeft($autobutton, 3)
	
	$display = _StringEncrypt(1, $display, $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel)
	$Web = _StringEncrypt(1, $Web, $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel)
	$user = _StringEncrypt(1, $user, $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel)
	$pass = _StringEncrypt(1, $pass, $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel)
	$info = _StringEncrypt(1, $info, $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel)
	$AutoLogin = _StringEncrypt(1, $AutoLogin, $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel)
	$autousername = _StringEncrypt(1, $autousername, $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel)
	$autopassword = _StringEncrypt(1, $autopassword, $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel)
	$autobutton = _StringEncrypt(1, $autobutton, $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel)
	$HotKey = _StringEncrypt(1, $HotKey, $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel)
	
	Return $display & "|" & $Web & "|" & $user & "|" & $pass & "|" & $info & "|" & $AutoLogin & "|" & $autousername & "|" & $autopassword & "|" & $autobutton & "|" & $HotKey
	
	
EndFunc   ;==>CreateEncryptedItem


Func OnWWW($address, $sHotKey = "*@8S2&A4@#C8$")
	if $address <> "" Then
	$icursel = _GUICtrlListBox_GetCurSel($List1)
	$ListText = _GUICtrlListBox_GetText($List1, $icursel)
	
	$Usernames = IniReadSection($INIFileLocation, $loggedinName)
	$Usernames_Length = UBound($Usernames) - 1
	
	For $I = 1 To $Usernames_Length
		
		$split = StringSplit($Usernames[$I][1], "|")

		If _StringEncrypt(0, $split[1], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel) == $ListText Or _StringEncrypt(0, $split[1], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel) == $sHotKey  Then
			

			If _StringEncrypt(0, $split[6], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel) = 1 Then
				
				$oIE = _IECreate ($address)

				$formNum = Int(StringLeft(_StringEncrypt(0, $split[7], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel), 2))
				$selitem = StringMid(_StringEncrypt(0, $split[7], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel), 3, 2)
				if StringRight($selitem, 1) = ")" then $selitem = StringTrimRight($selitem, 1)
				$oForm = _IEFormGetCollection ($oIE, $formNum)
				$IE = _IEFormElementGetCollection ($oForm, Int($selitem) - 1)
				_IEFormElementSetValue($IE, _StringEncrypt(0, $split[3], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
				
				$formNum = Int(StringLeft(_StringEncrypt(0, $split[8], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel), 2))
				$selitem = StringMid(_StringEncrypt(0, $split[8], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel), 3, 2)
				if StringRight($selitem, 1) = ")" then $selitem = StringTrimRight($selitem, 1)

				$oForm = _IEFormGetCollection ($oIE, $formNum)
				$IE = _IEFormElementGetCollection ($oForm, Int($selitem) - 1)
				_IEFormElementSetValue($IE, _StringEncrypt(0, $split[4], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
				
				$formNum = Int(StringLeft(_StringEncrypt(0, $split[9], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel), 2))
				$selitem = StringMid(_StringEncrypt(0, $split[9], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel), 3, 2)
				if StringRight($selitem, 1) = ")" then $selitem = StringTrimRight($selitem, 1)

				$oForm = _IEFormGetCollection ($oIE, $formNum)
				$IE = _IEFormElementGetCollection ($oForm, Int($selitem) - 1)
				;_IEFormElementSetValue($IE, _StringEncrypt(0, $split[9], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
				_IEAction($IE, "click")
				
				
			Else
				If StringRegExp($address, ".exe", 0) = 1 Then
					Run($address)
				Else
					Run(@ComSpec & " /c " & 'start ' & $address, "", @SW_HIDE)
				EndIf
				
		
			EndIf
			
			ExitLoop
			
		EndIf
		
		
		
	Next
	
	;GUICtrlSetData($AE_AutoUser, _StringEncrypt(0, $split[7], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
	;GUICtrlSetData($AE_AutoPass, _StringEncrypt(0, $split[8], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
	
	EndIf

EndFunc   ;==>OnWWW


Func GetElementList($webAdd)
	$HighestEleCount = 0
	_IELoadWaitTimeout(45000)
	$oIE = _IECreate($webAdd, 0, 0)
	If @error = 0 Then

		$oForms = _IEFormGetCollection($oIE)
		$iNumForms = @extended
		
		
		For $FM = 0 to $iNumForms - 1
			
			$oForm = _IEFormGetCollection($oIE, $FM)
			$ocollection = _IEFormElementGetCollection($oForm)
			$Elecount = @extended
			if $Elecount > $HighestEleCount then $HighestEleCount = $Elecount
			
		Next
	
		
		For $A = 0 To $iNumForms - 1
			

			
			$oForm = _IEFormGetCollection($oIE, $A)
			$ocollection = _IEFormElementGetCollection($oForm)
			$Elecount = @extended
			
			
			if $A = 0 then Global $IEelements[Int($iNumForms)][Int($HighestEleCount)][3]
			
			
			For $I = 0 To $Elecount - 1
				
				$IEelements[$A][$I][0] = _IEFormElementGetCollection($oForm, $I)
				;MsgBox(0, "", $A & "|" & $iNumForms & "  " & $I & "|" &$HighestEleCount & "  " & ObjName($IEelements[$A][$I][0]))
				;ClipPut(ObjName($IEelements[$A][$I][0]))
				If ObjName($IEelements[$A][$I][0]) == "DispHTMLInputElement" or ObjName($IEelements[$A][$I][0]) == "DispHTMLButtonElement" Then
				$IEelements[$A][$I][1] = $A & " " & $I + 1 & ") " & $IEelements[$A][$I][0].name
				$IEelements[$A][$I][2] = ObjName($IEelements[$A][$I][0])
				Else
				$IEelements[$A][$I][1] = $A & " " & $I + 1 & ") " & "ObjError"
				EndIf
				_GUICtrlListBox_AddString($AE_list1, $IEelements[$A][$I][1])
				; DispHTMLInputElement
				; DispHTMLFieldSetElement
				; DispHTMLButtonElement
				; DispHTMLObjectElement
			Next
			
			

		Next

		GUICtrlSetData($AE_InfoLabel, "Download complete! Please use the buttons above to change/modify the login data.")

	ElseIf @error = 6 Then
		
		GUICtrlSetData($AE_InfoLabel, "Error downloading controls list. Timed out")
		$IETimeout = True
	Else
		
		GUICtrlSetData($AE_InfoLabel, "Error downloading controls list.")
		$IETimeout = True

	EndIf

	if $HighestEleCount = 0 then $IETimeout = True

	_IEQuit($oIE)

EndFunc   ;==>GetElementList

Func IEElementFindItem($sFind, $iDem = 0)
	
	Dim $IsFound[2]
	$IsFound[0] = False
	$IsFound[1] = "Not Found"
	$IEelementcount = UBound($IEelements, 2)
	$IEformcount = UBound($IEelements)

For $A = 0 to $IEformcount - 1

	For $I = 0 to $IEelementcount - 1
		
		If $sFind <> "DispHTMLButtonElement" Then
			
			If StringInStr($IEelements[$A][$I][1], $sFind, 0) >= 1 Then 
				$IsFound[1] = $IEelements[$A][$I][1]
				$IsFound[0] = True
			ExitLoop
			
			EndIf
		
		
		Else
			
			If StringInStr($IEelements[$A][$I][2], $sFind, 0) >= 1 Then 
			$IsFound[1] = $IEelements[$A][$I][1]
			$IsFound[0] = True
			ExitLoop
			
			EndIf
			
	
		EndIf
	
	Next

if $IsFound[0] = True Then ExitLoop
	
Next


	if $iDem = 0 then 
	
		Return $IsFound
		
	Else
		
		Return $IsFound[0]
		
	EndIf
	
	

EndFunc

Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	
    Local $hWndFrom, $iIDFrom, $iCode, $hWndListBox
    If Not IsHWnd($List1) Then $hWndListBox = GUICtrlGetHandle($List1)
    $hWndFrom = $ilParam
    $iIDFrom = BitAND($iwParam, 0xFFFF) ; Low Word
    $iCode = BitShift($iwParam, 16) ; Hi Word
	
    Switch $hWndFrom
        Case $List1, $hWndListBox
            Switch $iCode
                Case $LBN_DBLCLK ; Sent when the user double-clicks a string in a list box
					OnWWW(GUICtrlRead($WebInput))

            EndSwitch
    EndSwitch

    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

Func HotKeyPressed()
	
	_GUICtrlListBox_SetCurSel($List1, -1)
	If $loginSuccess = True Then
	
	$Usernames = IniReadSection($INIFileLocation, $loggedinName)
	$Usernames_Length = UBound($Usernames) - 1
		
		For $I = 1 To $Usernames_Length
			
			$split = StringSplit($Usernames[$I][1], "|")
			If _StringEncrypt(0, $split[10], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel) = @HotKeyPressed Then
				TrayTip("Launching", '"' & _StringEncrypt(0, $split[1], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel) & '"', 1)
				OnWWW(_StringEncrypt(0, $split[2], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel), _StringEncrypt(0, $split[1], $loggedinName & $loggedinPassword & $EncryptionPassword, $EncryptionLevel))
				ExitLoop
				
			EndIf
			
			
			
		Next
		
	
	EndIf
	
	
	
EndFunc

