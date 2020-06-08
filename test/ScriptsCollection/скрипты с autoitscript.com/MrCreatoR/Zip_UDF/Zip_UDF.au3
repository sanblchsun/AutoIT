#include-once

#CS ============= Header Info ============
;     Zip_UDF.au3 -- v1.01 -- 21 October, 2009
;         An AutoIT User Defined Function (UDF) file.
;
;         Requires AutoIT 3.1.127 or later.
;         Uses the native compression API of Windows XP, Windows 2003, or later.
;
;     By PsaltyDS (modified by MrCreatoR) at http://www.autoitscript.com/forum.
;        Includes code from other forum users, especially as posted at:
;            http://www.autoitscript.com/forum/index.php?showtopic=21004
;
;     Includes the following functions:
;         _ZipCreate($sZip, $iFlag = 0)
;         _ZipAdd($sZip, $sSrc)
;         _ZipList($sZip)
;         _UnZip($sZip, $sDest)
;     See each function below for full usage.
#CE ======================================
;

Global $UseExternalZipApp = True
Global $iZipFuncsIsActive = False
Global $sExternal_7zip_Path, $sExternal_Rar_Path

If $UseExternalZipApp Then
	$sExternal_7zip_Path = RegRead("HKEY_CURRENT_USER\Software\7-Zip", "Path") & "\7z.exe"
	If Not FileExists($sExternal_7zip_Path) Then _
		$sExternal_7zip_Path = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip", "Path") & "\7z.exe"

	$sExternal_Rar_Path = RegRead("HKEY_CLASSES_ROOT\WinRAR\shell\open\command", "")
	$sExternal_Rar_Path = StringRegExpReplace($sExternal_Rar_Path, '(?i)"(.*)".*', '\1')

	If Not FileExists($sExternal_Rar_Path) Then $sExternal_Rar_Path = @ProgramFilesDir & "\WinRaR\WinRAR.exe"
	If Not FileExists($sExternal_Rar_Path) Then $sExternal_Rar_Path = "C:\Program Files\WinRaR\WinRAR.exe"
EndIf

;----------------------------------
; Function _ZipCreate($sZip, $iFlag = 0)
;     Creates an empty .zip archive file.
;     Where:
;         $sZip is the .zip file to create
;         $iFlag: 0 = prompts to overwrite (default)
;                 1 = overwrite without prompt
;     Returns 1 on success, 0 for fail
;   On fail, @Error is:
;         1 = Not permitted to overwrite
;         2 = FileOpen failed
;       3 = FileWrite failed
;----------------------------------
Func _ZipCreate($sZip, $iFlag = 0)
	; Test zip file
	If FileExists($sZip) And Not $iFlag Then Return SetError(1, 0, 0)
	
	; Create header data
	Local $sHeader = Chr(80) & Chr(75) & Chr(5) & Chr(6)

	For $i = 1 To 18
		$sHeader &= Chr(0)
	Next
	
	; Create empty zip file
	$hFile = FileOpen($sZip, 8 + 18); Mode = Create folder, Overwrite
	If $hFile = -1 Then SetError(2, 0, 0)
	
	If FileWrite($hFile, $sHeader) Then Return FileClose($hFile)

	Return SetError(3, 0, 0)
EndFunc

;----------------------------------
; Function _ZipAdd($sZip, $sSrc)
;     Adds a file or folder to a pre-existing .zip archive.
;     Where:
;         $sZip is the .zip file to add to
;         $sSrc is the source file or folder to add
;     Returns 1 on success, 0 for fail
;   On fail, @Error is:
;         1 = Creating Zip file failed [@Extended = @Error from _ZipCreate()]
;         2 = Source did not exist
;       3 = Shell ObjCreate error
;       4 = Zip file namespace object error
;         5 = Error copying data
;----------------------------------
Func _ZipAdd($sZip, $sSrc)
	; Test zip file and create if required
	If Not FileExists($sZip) And Not _ZipCreate($sZip) Then Return SetError(1, 0, 0)
	
	; Test source
	If Not FileExists($sSrc) Then SetError(2, 0, 0)
	
	If $UseExternalZipApp Then
		__External_ZipAdd($sZip, $sSrc)
		If Not @error Then Return 1
	EndIf
	
	Local $oZip_COM_Error = ObjEvent("AutoIt.Error", "__Zip_COM_Err_Handler")
	$iZipFuncsIsActive = True
	
	; Create shell object
	Local $oShell = ObjCreate('Shell.Application')
	If @error Or Not IsObj($oShell) Then Return SetError(@error, 3, __Disable_COM_Err_Handler())
	
	; Get zip file object
	Local $oFolder = $oShell.NameSpace($sZip)
	If @error Or Not IsObj($oFolder) Then Return SetError(@error, 4, __Disable_COM_Err_Handler())
	
	; Copy source file or folder to zip file
	If StringInStr(FileGetAttrib($sSrc), "D") Then
		Local $oShell_NameSpace = $oShell.NameSpace($sSrc)
		If @error Or Not IsObj($oFolder) Then Return SetError(@error, 5, __Disable_COM_Err_Handler())
		
		$oFolder.CopyHere($oShell_NameSpace.Items, 64)
	Else
		$oFolder.CopyHere($sSrc, 64)
	EndIf
	
	If @error Then Return SetError(@error, 6, __Disable_COM_Err_Handler())
	
	Sleep(1000)
	
	__Disable_COM_Err_Handler()
	Return 1
EndFunc

;----------------------------------
; Function _ZipList($sZip)
;     List the contents of a .zip archive file
;     Where: $sZip is the .zip file
;     On Success, returns a 1D array of items in the zip file, with [0]=count
;   On fail, returns array with [0]=0 and @Error is:
;         1 = Zip file did not exist
;       2 = Shell ObjCreate error
;       3 = Zip file namespace object error
;         4 = Error copying data
;----------------------------------
Func _ZipList($sZip)
	Local $aNames[1] = [0], $i
	; Test zip file
	If Not FileExists($sZip) Then Return SetError(1, 0, 0)
	
	Local $oZip_COM_Error = ObjEvent("AutoIt.Error", "__Zip_COM_Err_Handler")
	$iZipFuncsIsActive = True
	
	; Create shell object
	Local $oShell = ObjCreate('Shell.Application')
	If @error Or Not IsObj($oShell) Then Return SetError(2, 0, __Disable_COM_Err_Handler())
	
	; Get zip file object
	Local $oFolder = $oShell.NameSpace ($sZip)
	If @error Or Not IsObj($oFolder) Then Return SetError(3, 0, __Disable_COM_Err_Handler())
	
	; Get list of items
	Local $oItems = $oFolder.Items ()
	If @error Or Not IsObj($oItems) Then Return SetError(4, 0, __Disable_COM_Err_Handler())
	
	; Read items into array
	For $i In $oItems
		$aNames[0] += 1
		ReDim $aNames[$aNames[0] + 1]
		$aNames[$aNames[0]] = $oFolder.GetDetailsOf ($i, 0)
	Next
	
	__Disable_COM_Err_Handler()
	
	Return $aNames
EndFunc

;----------------------------------
; Function _UnZip($sZip, $sDest)
;     Uncompress items from a .zip file a destination folder.
;     Where:
;         $sZip is the .zip file
;         $sDest is the folder to uncompress to (without trailing '\')
;     Returns 1 on success, 0 for fail
;   On fail, @Error is:
;         1 = Source zip file did not exist
;         2 = Error creating destination folder
;       3 = Shell ObjCreate error
;       4 = Zip file namespace object error
;         5 = Error creating item list object
;         6 = Destination folder namespace object error
;         7 = Error copying data
;----------------------------------
Func _UnZip($sZip, $sDest)
	; Test zip file
	If Not FileExists($sZip) Then Return SetError(1, 0, 0)
	
	; Test destination folder
	If Not FileExists($sDest & "\") And Not DirCreate($sDest) Then Return SetError(2, 0, 0)
	
	If $UseExternalZipApp Then
		__External_UnZip($sZip, $sDest)
		If Not @error Then Return 1
	EndIf
	
	Local $oZip_COM_Error = ObjEvent("AutoIt.Error", "__Zip_COM_Err_Handler")
	$iZipFuncsIsActive = True
	
	; Create shell object
	Local $oShell = ObjCreate('Shell.Application')
	If @error Or Not IsObj($oShell) Then Return SetError(@error, 3, __Disable_COM_Err_Handler())
	
	; Get zip file namespace object
	Local $oFolder = $oShell.NameSpace($sZip)
	If @error Or Not IsObj($oFolder) Then Return SetError(@error, 4, __Disable_COM_Err_Handler())
	
	; Get list of items in zip file
	Local $oItems = $oFolder.Items()
	If @error Or Not IsObj($oItems) Then Return SetError(@error, 5, __Disable_COM_Err_Handler())
	
	; Get destination folder namespace object
	$oDest = $oShell.NameSpace($sDest & "\")
	If @error Or Not IsObj($oDest) Then Return SetError(@error, 6, __Disable_COM_Err_Handler())
	
	; Copy the files
	$oDest.CopyHere ($oItems, 64)
	If @error Then Return SetError(@error, 7, __Disable_COM_Err_Handler())
	
	Sleep(500)
	
	__Disable_COM_Err_Handler()
	
	Return 1
EndFunc

Func __External_ZipAdd($sZip, $sSrc)
	If FileExists($sExternal_7zip_Path) Then
		Local $iError = RunWait($sExternal_7zip_Path & ' a -tzip -mx7 "' & $sZip & '" "' & $sSrc & '"', '', @SW_HIDE)
		If @error Then $iError = 1
		
		Return SetError($iError)
	EndIf
	
	Local $iError = RunWait($sExternal_Rar_Path & ' a "' & $sZip & '" "' & $sSrc & '"', '', @SW_HIDE)
	If @error Then $iError = 1
	
	Return SetError($iError)
EndFunc

Func __External_UnZip($sZip, $sDest)
	If FileExists($sExternal_7zip_Path) Then
		Local $iError = 0, $sCurrent_StdOut_Read = "", $sStdOut_Check = ""
		
		Local $iPID = Run($sExternal_7zip_Path & ' e "' & $sZip & '" -o"' & $sDest & '" -y', $sDest, @SW_HIDE, 1 + 2)
		If @error Then $iError = 1
		
		While ProcessExists($iPID)
			Sleep(10)
			
			$sCurrent_StdOut_Read = StdoutRead($iPID)
			If @error Then ExitLoop
			
			$sStdOut_Check &= $sCurrent_StdOut_Read
			
			If StringInStr($sCurrent_StdOut_Read, "Enter password:") Then
				$sPassword = InputBox("7zip - Password protected archive", _
					"This archive is protected with password." & @LF & "Please enter password:")
				
				StdinWrite($iPID, $sPassword & @CRLF)
				StdinWrite($iPID)
			EndIf
		WEnd
		
		If StringInStr($sStdOut_Check, "Error") Then
			$iError = 1
			If StringInStr($sStdOut_Check, "Enter password:") Then $iError = 2
		EndIf
		
		Return SetError($iError)
	EndIf
	
	If Not FileExists($sExternal_Rar_Path) Then Return SetError(1, 0, 0)
	
	$iError = 0
	RunWait($sExternal_Rar_Path & ' e -y "' & $sZip & '"', $sDest, @SW_HIDE)
	If @error Then $iError = 1
	
	Return SetError($iError)
EndFunc

Func __Disable_COM_Err_Handler()
	$iZipFuncsIsActive = False
	
	ObjEvent("AutoIt.Error")
	
	Return 0
EndFunc

Func __Zip_COM_Err_Handler()
	If $iZipFuncsIsActive Then SetError(1)
EndFunc
