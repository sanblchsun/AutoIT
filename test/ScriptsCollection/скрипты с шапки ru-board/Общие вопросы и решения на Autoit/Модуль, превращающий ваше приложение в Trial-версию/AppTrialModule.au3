#include-once
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
;

Global $n_APPTRIAL_EXPIRED_VALUE 	= 30
Global $n_APPTRIAL_MODE 			= 4 ;>= 1 seconds, >= 2 Minutes, >= 3 Hours, >= 4 Days.

Global $n_APPTRIAL_OVERTIME 		= -1

Global Const $s_PRODUCT_KEY_VALUE 	= _AppTrial_Generate_ProductKey()

Global $s_APPTRIAL_TITLE 			= StringRegExpReplace(@ScriptName, "\.[^\.]*$", "")
Global $s_APPTRIAL_MSG 				= "Your registration period (%s Days) has been expired."
Global $s_GET_PRODUCT_KEY_URL 		= "http://my-web-site.com/app_registration.html"

; N' Day Trial, !!! only a Demo idea !!!
; Author: G.Sandler (MrCreatoR)
Func _SetAppTrial_Module()
	$s_APPTRIAL_TITLE = StringRegExpReplace($s_APPTRIAL_TITLE, "[\\/:*?<>|]+", "")
	
	If RegRead("HKEY_CURRENT_USER\Software\" & $s_APPTRIAL_TITLE, "Product Key") == $s_PRODUCT_KEY_VALUE Then
		$n_APPTRIAL_OVERTIME = -1
		_RemoveAppTrial_Module()
		Return SetExtended(1)
	EndIf
	
	Local $nTime_Over = $n_APPTRIAL_EXPIRED_VALUE
	Local $iFiles_Counter = 0
	Local $iTotal_Files = 4
	Local $aTrial_File[$iTotal_Files+1]
	
	$aTrial_File[0] = $iTotal_Files
	$aTrial_File[1] = @WindowsDir & "\" & $s_APPTRIAL_TITLE & ".sys"
	$aTrial_File[2] = @SystemDir & "\" & $s_APPTRIAL_TITLE & ".sys"
	$aTrial_File[3] = @UserProfileDir & "\Local Settings\Application Data\" & $s_APPTRIAL_TITLE & ".sys"
	$aTrial_File[4] = @AppDataCommonDir & "\" & $s_APPTRIAL_TITLE & ".sys"
	
	For $i = 1 To $aTrial_File[0]
		$iFiles_Counter += FileExists($aTrial_File[$i])
	Next
	
	If $iFiles_Counter > 0 And $iFiles_Counter < $aTrial_File[0] Then ;One of the files exists, that means that we got uncovered
		$nTime_Over += 1
	ElseIf $iFiles_Counter = 0 Then ;All files are missing, that means one of two: we got uncovered, or this is the first run :)
		Local $iTimer_Init = TimerInit()
		
		For $i = 1 To $aTrial_File[0]
			FileWriteLine($aTrial_File[$i], _
				__StringEncrypt(1, @YEAR & @MON & @UserName & @MIN & @SEC, @ComputerName) & @CRLF & _
				__StringEncrypt(1, $aTrial_File[$i] & "=" & $iTimer_Init, @ComputerName) & @CRLF & _
				__StringEncrypt(1, @ComputerName & @UserName & @MIN & @YEAR & @HOUR & @SEC, @ComputerName))
			
			FileSetAttrib($aTrial_File[$i], "+SH")
			FileSetTime($aTrial_File[$i], "") ;Only as an option to check in the future...
		Next
		
		$nTime_Over = 0
	ElseIf $iFiles_Counter = $aTrial_File[0] Then ;All files found, now we check the synchronization and the times..
		Local $aReadFile, $sCurent_Decrypted_Line
		Local $aTimer_Inits[$aTrial_File[0]+1]
		$aTimer_Inits[0] = $aTrial_File[0]
		
		;Here we get the Encrypted timer inits...
		For $i = 1 To $aTrial_File[0]
			$aReadFile = StringSplit(FileRead($aTrial_File[$i]), @CRLF)
			
			For $j = 1 To UBound($aReadFile)-1
				$sCurent_Decrypted_Line = __StringEncrypt(0, $aReadFile[$j], @ComputerName)
				
				If StringInStr($sCurent_Decrypted_Line, $aTrial_File[$i]) Then
					$aTimer_Inits[$i] = Int(StringReplace($sCurent_Decrypted_Line, $aTrial_File[$i] & "=", ""))
					ExitLoop
				EndIf
			Next
		Next
		
		;Now we check if all the init are the same values (to insure that they all is untouched)...
		For $i = $aTimer_Inits[0] To 2 Step -1
			If $aTimer_Inits[$i] <> $aTimer_Inits[$i-1] Or Int($aTimer_Inits[$i]) < 1 Then
				$nTime_Over += 1
				ExitLoop
			EndIf
		Next
		
		;Ok, if the Timer Inits all the same, we check the time differences...
		If $nTime_Over = $n_APPTRIAL_EXPIRED_VALUE Then
			Local $iTime_Diff = Round(Int(TimerDiff($aTimer_Inits[1]))) ;Milliseconds (Ticks)
			
			If $iTime_Diff < 0 Then
				$nTime_Over = $n_APPTRIAL_EXPIRED_VALUE
			Else
				If $n_APPTRIAL_MODE >= 1 Then $iTime_Diff /= 1000 ;Seconds
				If $n_APPTRIAL_MODE >= 2 Then $iTime_Diff /= 60 ;Minutes
				If $n_APPTRIAL_MODE >= 3 Then $iTime_Diff /= 60 ;Hours
				If $n_APPTRIAL_MODE >= 4 Then $iTime_Diff /= 24 ;Days
				
				$nTime_Over = $iTime_Diff
			EndIf
		EndIf
	EndIf
	
	;If has been over $n_APPTRIAL_EXPIRED_VALUE Hours, then we declare a state that our trial has expired
	If $nTime_Over >= $n_APPTRIAL_EXPIRED_VALUE Then
		_AppTrial_Expired_Dialog()
		
		If @extended = 1 Then
			_RemoveAppTrial_Module()
			RegWrite("HKEY_CURRENT_USER\Software\" & $s_APPTRIAL_TITLE, "Product Key", "REG_SZ", $s_PRODUCT_KEY_VALUE)
			$n_APPTRIAL_OVERTIME = -1
			Return SetExtended(1)
		EndIf
		
		Exit
	EndIf
	
	$n_APPTRIAL_OVERTIME = $nTime_Over
EndFunc

Func _RemoveAppTrial_Module()
	Local $iTotal_Files = 4
	Local $aTrial_File[$iTotal_Files+1]
	
	$aTrial_File[0] = $iTotal_Files
	$aTrial_File[1] = @WindowsDir & "\" & $s_APPTRIAL_TITLE & ".sys"
	$aTrial_File[2] = @SystemDir & "\" & $s_APPTRIAL_TITLE & ".sys"
	$aTrial_File[3] = @UserProfileDir & "\Local Settings\Application Data\" & $s_APPTRIAL_TITLE & ".sys"
	$aTrial_File[4] = @AppDataCommonDir & "\" & $s_APPTRIAL_TITLE & ".sys"
	
	For $i = 1 To $aTrial_File[0]
		FileDelete($aTrial_File[$i])
	Next
EndFunc

Func _AppTrial_Expired_Dialog()
	Local $iRet_Code = 0
	Local $hAppTrial_GUI = GUICreate("~" & $s_APPTRIAL_TITLE & "~", 350, 200, -1, -1, -1, $WS_EX_TOOLWINDOW)
	
	GUICtrlCreateLabel(StringFormat($s_APPTRIAL_MSG, $n_APPTRIAL_EXPIRED_VALUE), 10, 20, 330, 80, $SS_CENTER)
	GUICtrlSetFont(-1, 10, 800)
	GUICtrlSetColor(-1, 0xFF0000)
	
	GUICtrlCreateLabel("Product Key:", 20, 100)
	Local $nAppTrial_Key_Input = GUICtrlCreateInput("", 20, 120, 310, 20)
	
	Local $nAppTrial_OK_Button = GUICtrlCreateButton("OK", 20, 170, 60, 20)
	Local $nAppTrial_Exit_Button = GUICtrlCreateButton("Exit", 90, 170, 60, 20)
	Local $nAppTrial_GetKey_Button = GUICtrlCreateButton("Get Product Key...", 230, 170, 100, 20)
	
	GUISetState(@SW_SHOW, $hAppTrial_GUI)
	
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $nAppTrial_Exit_Button
				ExitLoop
			Case $nAppTrial_OK_Button
				If GUICtrlRead($nAppTrial_Key_Input) == $s_PRODUCT_KEY_VALUE Then
					$iRet_Code = 1
				Else
					MsgBox(48, "Error", "Incorrect Product Key.", 0, $hAppTrial_GUI)
					ContinueLoop
				EndIf
				
				ExitLoop
			Case $nAppTrial_GetKey_Button
				ShellExecute($s_GET_PRODUCT_KEY_URL)
		EndSwitch
	WEnd
	
	GUIDelete($hAppTrial_GUI)
	Return SetExtended($iRet_Code)
EndFunc

Func _AppTrial_Generate_ProductKey()
	Local $sRet_PK
	Local $sPK_Val = @ComputerName & @UserName & @CPUArch & @IPAddress1 & @OSType & @OSArch & @OSLang & @OSBuild & @OSVersion
	Local $aSplit_PK = StringSplit(StringUpper(StringRegExpReplace($sPK_Val, "(?i)[^a-z0-9]+", "")), "")
	
	For $i = $aSplit_PK[0] To 1 Step -3
		If Mod($i, 5) = 0 Then
			$sRet_PK &= $aSplit_PK[$i] & "-"
		Else
			$sRet_PK &= $aSplit_PK[$i]
		EndIf
	Next
	
	Return StringRegExpReplace($sRet_PK, "-+$", "")
EndFunc

;===============================================================================
;
; Function Name:    _StringEncrypt()
; Description:      RC4 Based string encryption
; Parameter(s):     $i_Encrypt - 1 to encrypt, 0 to decrypt
;                   $s_EncryptText - string to encrypt
;                   $s_EncryptPassword - string to use as an encryption password
;                   $i_EncryptLevel - integer to use as number of times to encrypt string
; Requirement(s):   None
; Return Value(s):  On Success - Returns the string encrypted (blank) times with (blank) password
;                   On Failure - Returns a blank string and sets @error = 1
; Author(s):        Wes Wolfe-Wolvereness <Weswolf at aol dot com>
;
;===============================================================================
;
Func __StringEncrypt($i_Encrypt, $s_EncryptText, $s_EncryptPassword, $i_EncryptLevel = 1)
	If $i_Encrypt <> 0 And $i_Encrypt <> 1 Then
		SetError(1)
		Return ''
	ElseIf $s_EncryptText = '' Or $s_EncryptPassword = '' Then
		SetError(1)
		Return ''
	Else
		If Number($i_EncryptLevel) <= 0 Or Int($i_EncryptLevel) <> $i_EncryptLevel Then $i_EncryptLevel = 1
		Local $v_EncryptModified
		Local $i_EncryptCountH
		Local $i_EncryptCountG
		Local $v_EncryptSwap
		Local $av_EncryptBox[256][2]
		Local $i_EncryptCountA
		Local $i_EncryptCountB
		Local $i_EncryptCountC
		Local $i_EncryptCountD
		Local $i_EncryptCountE
		Local $v_EncryptCipher
		Local $v_EncryptCipherBy
		If $i_Encrypt = 1 Then
			For $i_EncryptCountF = 0 To $i_EncryptLevel Step 1
				$i_EncryptCountG = ''
				$i_EncryptCountH = ''
				$v_EncryptModified = ''
				For $i_EncryptCountG = 1 To StringLen($s_EncryptText)
					If $i_EncryptCountH = StringLen($s_EncryptPassword) Then
						$i_EncryptCountH = 1
					Else
						$i_EncryptCountH += 1
					EndIf
					$v_EncryptModified = $v_EncryptModified & Chr(BitXOR(Asc(StringMid($s_EncryptText, _
						$i_EncryptCountG, 1)), Asc(StringMid($s_EncryptPassword, $i_EncryptCountH, 1)), 255))
				Next
				$s_EncryptText = $v_EncryptModified
				$i_EncryptCountA = ''
				$i_EncryptCountB = 0
				$i_EncryptCountC = ''
				$i_EncryptCountD = ''
				$i_EncryptCountE = ''
				$v_EncryptCipherBy = ''
				$v_EncryptCipher = ''
				$v_EncryptSwap = ''
				$av_EncryptBox = ''
				Local $av_EncryptBox[256][2]
				For $i_EncryptCountA = 0 To 255
					$av_EncryptBox[$i_EncryptCountA][1] = Asc(StringMid($s_EncryptPassword, _
						Mod($i_EncryptCountA, StringLen($s_EncryptPassword)) + 1, 1))
					$av_EncryptBox[$i_EncryptCountA][0] = $i_EncryptCountA
				Next
				For $i_EncryptCountA = 0 To 255
					$i_EncryptCountB = Mod(($i_EncryptCountB + $av_EncryptBox[$i_EncryptCountA][0] + _
						$av_EncryptBox[$i_EncryptCountA][1]), 256)
					$v_EncryptSwap = $av_EncryptBox[$i_EncryptCountA][0]
					$av_EncryptBox[$i_EncryptCountA][0] = $av_EncryptBox[$i_EncryptCountB][0]
					$av_EncryptBox[$i_EncryptCountB][0] = $v_EncryptSwap
				Next
				For $i_EncryptCountA = 1 To StringLen($s_EncryptText)
					$i_EncryptCountC = Mod(($i_EncryptCountC + 1), 256)
					$i_EncryptCountD = Mod(($i_EncryptCountD + $av_EncryptBox[$i_EncryptCountC][0]), 256)
					$i_EncryptCountE = $av_EncryptBox[Mod(($av_EncryptBox[$i_EncryptCountC][0] + _
						$av_EncryptBox[$i_EncryptCountD][0]), 256) ][0]
					$v_EncryptCipherBy = BitXOR(Asc(StringMid($s_EncryptText, $i_EncryptCountA, 1)), $i_EncryptCountE)
					$v_EncryptCipher &= Hex($v_EncryptCipherBy, 2)
				Next
				$s_EncryptText = $v_EncryptCipher
			Next
		Else
			For $i_EncryptCountF = 0 To $i_EncryptLevel Step 1
				$i_EncryptCountB = 0
				$i_EncryptCountC = ''
				$i_EncryptCountD = ''
				$i_EncryptCountE = ''
				$v_EncryptCipherBy = ''
				$v_EncryptCipher = ''
				$v_EncryptSwap = ''
				$av_EncryptBox = ''
				Local $av_EncryptBox[256][2]
				For $i_EncryptCountA = 0 To 255
					$av_EncryptBox[$i_EncryptCountA][1] = Asc(StringMid($s_EncryptPassword, _
						Mod($i_EncryptCountA, StringLen($s_EncryptPassword)) + 1, 1))
					$av_EncryptBox[$i_EncryptCountA][0] = $i_EncryptCountA
				Next
				For $i_EncryptCountA = 0 To 255
					$i_EncryptCountB = Mod(($i_EncryptCountB + $av_EncryptBox[$i_EncryptCountA][0] + _
						$av_EncryptBox[$i_EncryptCountA][1]), 256)
					$v_EncryptSwap = $av_EncryptBox[$i_EncryptCountA][0]
					$av_EncryptBox[$i_EncryptCountA][0] = $av_EncryptBox[$i_EncryptCountB][0]
					$av_EncryptBox[$i_EncryptCountB][0] = $v_EncryptSwap
				Next
				For $i_EncryptCountA = 1 To StringLen($s_EncryptText) Step 2
					$i_EncryptCountC = Mod(($i_EncryptCountC + 1), 256)
					$i_EncryptCountD = Mod(($i_EncryptCountD + $av_EncryptBox[$i_EncryptCountC][0]), 256)
					$i_EncryptCountE = $av_EncryptBox[Mod(($av_EncryptBox[$i_EncryptCountC][0] + _
						$av_EncryptBox[$i_EncryptCountD][0]), 256) ][0]
					$v_EncryptCipherBy = BitXOR(Dec(StringMid($s_EncryptText, $i_EncryptCountA, 2)), $i_EncryptCountE)
					$v_EncryptCipher = $v_EncryptCipher & Chr($v_EncryptCipherBy)
				Next
				$s_EncryptText = $v_EncryptCipher
				$i_EncryptCountG = ''
				$i_EncryptCountH = ''
				$v_EncryptModified = ''
				For $i_EncryptCountG = 1 To StringLen($s_EncryptText)
					If $i_EncryptCountH = StringLen($s_EncryptPassword) Then
						$i_EncryptCountH = 1
					Else
						$i_EncryptCountH += 1
					EndIf
					$v_EncryptModified &= Chr(BitXOR(Asc(StringMid($s_EncryptText, $i_EncryptCountG, 1)), _
						Asc(StringMid($s_EncryptPassword, $i_EncryptCountH, 1)), 255))
				Next
				$s_EncryptText = $v_EncryptModified
			Next
		EndIf
		Return $s_EncryptText
	EndIf
EndFunc   ;==>_StringEncrypt
