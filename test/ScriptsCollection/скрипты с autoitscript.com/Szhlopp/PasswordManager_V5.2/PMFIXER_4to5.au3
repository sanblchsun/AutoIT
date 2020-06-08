; If you don't want to loose your data from version 4: 
; 1) Run this first on the data file.
; 2) Retrieve the compile passwords and put them into the V5.au3


$FoD = FileOpenDialog("Open", @DesktopDir, "All (*.*)", 1)
if @error <> 1 Then
	
FileCopy($FoD, @DesktopDir & '\PassManDataBackup.ini', 1)

	$input = InputBox("Account", "Please enter your account name", @UserName)
	if @error <> 1 Then
		
		$username = IniReadSection($FoD, $input)
		If @error <> 1 Then
			
			For $I = 1 To $username[0][0]
				
				MsgBox(0, "", $username[$I][0])
				;$inicursec = IniRead($FoD, $input, $username[$I][0], "")
				IniWrite($FoD, $input, $username[$I][0], $username[$I][1] & "|")
				
			Next
		
		Else
		
			MsgBox(0, "", "Unable to read file/account")
		
		EndIf

	EndIf

EndIf

