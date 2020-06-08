
; логин admin, пароль 275A-A484-0481-2F77-A34E
; нужно добавить скрытие иконки при старте, а потом если требуется, то отобразить.

#include <Crypt.au3>
$LK = @ScriptDir & '\LK.key'
If Not FileExists($LK) Then
	$GuiTrial = GUICreate("Старт", 340, 220)
	$Rnd = Random(1, 5, 1)
	$StBt_6 = GUICtrlCreateLabel('Вы используете программу в ознакомительном режиме. Для старта программы нажмите кнопку ' & $Rnd & '. Зарегистрируйте програму для скрытия этого стартового диалога.', 10, 5, 325, 50)

	GUICtrlCreateGroup('Регистрация', 5, 60, 330, 110)
	GUICtrlCreateLabel('Логин', 10, 82, 45, 20)
	$login = GUICtrlCreateInput('', 55, 80, 265, 20)

	GUICtrlCreateLabel('Пароль', 10, 112, 45, 20)
	$pasw = GUICtrlCreateInput('', 55, 110, 265, 20)
	$registr = GUICtrlCreateButton('Зарегистрировать', 210, 136, 110, 25)
	GUISetFont(13, 700, -1, 'Arial')
	$StBt_1 = GUICtrlCreateButton('1', 20, 180, 58, 28)
	$StBt_2 = GUICtrlCreateButton('2', 80, 180, 58, 28)
	$StBt_3 = GUICtrlCreateButton('3', 140, 180, 58, 28)
	$StBt_4 = GUICtrlCreateButton('4', 200, 180, 58, 28)
	$StBt_5 = GUICtrlCreateButton('5', 260, 180, 58, 28)

	GUISetState()
	While 1
		$msg = GUIGetMsg()
		Switch $msg
			Case $StBt_1
				_nBtn(1)
				ExitLoop
			Case $StBt_2
				_nBtn(2)
				ExitLoop
			Case $StBt_3
				_nBtn(3)
				ExitLoop
			Case $StBt_4
				_nBtn(4)
				ExitLoop
			Case $StBt_5
				_nBtn(5)
				ExitLoop

			Case $registr
				$login0 = GUICtrlRead($login)
				$pasw0 = GUICtrlRead($pasw)
				If $login0 = '' Or StringLen($login0) < 5 Then
					MsgBox(0, 'Ошибка', 'Введите логин длинной не менее 5 символов.')
					ContinueLoop
				EndIf
				If $pasw0 = '' Or StringLen($pasw0) < 5 Then
					MsgBox(0, 'Ошибка', 'Пароль отсутсвует или неверный')
					ContinueLoop
				EndIf
				; ClipPut(_GenKey($login0)) ; раскомментируйте строку чтобы получить временный ключ в буфер, и выполните повторную регистрацию.
				$file = FileOpen($LK, 2)
				FileWrite($file, __StringEncrypt(1, $login0 & @CRLF & $pasw0, 'my_key_8w4m0d')) ; ключ my_key просто шифрует файл-ключ
				FileClose($file)
				_restart()
			Case -3
				Exit
		EndSwitch
	WEnd
Else
	$file = FileOpen($LK, 0)
	$LK0 = FileRead($file)
	FileClose($file)
	$aLK = StringSplit(StringStripCR(__StringEncrypt(0, $LK0, 'my_key_8w4m0d')), @LF)

	If Not IsArray($aLK) Then
		If MsgBox(4, 'Ошибка', 'Ключ неверный.'&@CRLF&'Удалить ключ?')=6 Then FileDelete($LK)
		Exit
	EndIf
	If $aLK[2] <> _GenKey($aLK[1]) Then
		If MsgBox(4, 'Ошибка', 'Ключ неверный.'&@CRLF&'Удалить ключ?')=6 Then FileDelete($LK)
		Exit
	EndIf
EndIf
If IsDeclared('GuiTrial') Then GUIDelete($GuiTrial)


; здесь тело программы
MsgBox(0, 'Сообщение', 'Старт программы выполнен, ключ верный или стартовая кнопка верна')




Func _GenKey($login)
	; В качестве ключа хэш. Способ, как его многократно преобразовать и усложнить, это уже ваше дело
	; Сделал перемешку хэша, дабы беглым взглядом было незаметно.
	$g0 = ''
	$g = StringTrimLeft(_Crypt_HashData($login, 0x00008003), 2)
	For $i = 3 To 30 Step 2
		$g0&= StringMid($g, $i, 1)
	Next
	For $i = 3 To 30 Step 3
		$g0&= StringMid($g, $i, 1)
	Next
	$g=''
	For $i = 3 To 19 Step 4
		$g &= '-' & StringMid($g0, $i, 4)
	Next
	$g = StringTrimLeft($g, 1)
	Return $g
EndFunc   ;==>_GenKey

Func _nBtn($n)
	If $Rnd <> $n Then Exit
EndFunc   ;==>_nBtn


;===============================================================================
;
; Function Name:    __StringEncrypt()
; Description:      RC4 Based string encryption/decryption
; Parameter(s):     $i_Encrypt - 1 to encrypt, 0 to decrypt
;					 $s_EncryptText - string to encrypt
;					 $s_EncryptPassword - string to use as an encryption password
;					 $i_EncryptLevel - integer to use as number of times to encrypt string
; Requirement(s):   None
; Return Value(s):  On Success - Returns the encrypted string
;					 On Failure - Returns a blank string and sets @error = 1
; Author(s):		 (Original _StringEncrypt) Wes Wolfe-Wolvereness <Weswolf at aol dot com>
;					 (Modified __StringEncrypt) PsaltyDS at www.autoitscript.com/forum
;					 (RC4 function) SkinnyWhiteGuy at www.autoitscript.com/forum
;===============================================================================
;  1.0.0.0  |  03/08/08  |  First version posted to Example Scripts Forum
;===============================================================================
Func __StringEncrypt($i_Encrypt, $s_EncryptText, $s_EncryptPassword, $i_EncryptLevel = 1)
	Local $RET, $sRET = "", $iBinLen, $iHexWords

	; Sanity check of parameters
	If $i_Encrypt <> 0 And $i_Encrypt <> 1 Then
		SetError(1)
		Return ''
	ElseIf $s_EncryptText = '' Or $s_EncryptPassword = '' Then
		SetError(1)
		Return ''
	EndIf
	If Number($i_EncryptLevel) <= 0 Or Int($i_EncryptLevel) <> $i_EncryptLevel Then $i_EncryptLevel = 1

	; Encrypt/Decrypt
	If $i_Encrypt Then
		; Encrypt selected
		$RET = $s_EncryptText
		For $n = 1 To $i_EncryptLevel
			If $n > 1 Then $RET = Binary(Random(0, 2 ^ 31 - 1, 1)) & $RET & Binary(Random(0, 2 ^ 31 - 1, 1)) ; prepend/append random 32bits
			$RET = rc4($s_EncryptPassword, $RET) ; returns binary
		Next

		; Convert to hex string
		$iBinLen = BinaryLen($RET)
		$iHexWords = Int($iBinLen / 4)
		If Mod($iBinLen, 4) Then $iHexWords += 1
		For $n = 1 To $iHexWords
			$sRET &= Hex(BinaryMid($RET, 1 + (4 * ($n - 1)), 4))
		Next
		$RET = $sRET
	Else
		; Decrypt selected
		; Convert input string to primary binary
		$RET = Binary("0x" & $s_EncryptText) ; Convert string to binary

		; Additional passes, if required
		For $n = 1 To $i_EncryptLevel
			If $n > 1 Then
				$iBinLen = BinaryLen($RET)
				$RET = BinaryMid($RET, 5, $iBinLen - 8) ; strip random 32bits from both ends
			EndIf
			$RET = rc4($s_EncryptPassword, $RET)
		Next
		$RET = BinaryToString($RET)
	EndIf

	; Return result
	Return $RET
EndFunc   ;==>__StringEncrypt

; -------------------------------------------------------
; Function:  rc4
; Purpose:  An encryption/decryption RC4 implementation in AutoIt
; Syntax:  rc4($key, $value)
;   Where:  $key = encrypt/decrypt key
;		$value = value to be encrypted/decrypted
; On success returns encrypted/decrypted version of $value
; Author:  SkinnyWhiteGuy on the AutoIt forums at www.autoitscript.com/forum
; Notes:  The same function encrypts and decrypts $value.
; -------------------------------------------------------
Func rc4($key, $value)
	Local $S[256], $i, $j, $c, $t, $x, $y, $output
	Local $keyLength = BinaryLen($key), $valLength = BinaryLen($value)
	For $i = 0 To 255
		$S[$i] = $i
	Next
	For $i = 0 To 255
		$j = Mod($j + $S[$i] + Dec(StringTrimLeft(BinaryMid($key, Mod($i, $keyLength) + 1, 1), 2)), 256)
		$t = $S[$i]
		$S[$i] = $S[$j]
		$S[$j] = $t
	Next
	For $i = 1 To $valLength
		$x = Mod($x + 1, 256)
		$y = Mod($S[$x] + $y, 256)
		$t = $S[$x]
		$S[$x] = $S[$y]
		$S[$y] = $t
		$j = Mod($S[$x] + $S[$y], 256)
		$c = BitXOR(Dec(StringTrimLeft(BinaryMid($value, $i, 1), 2)), $S[$j])
		$output = Binary($output) & Binary('0x' & Hex($c, 2))
	Next
	Return $output
EndFunc   ;==>rc4

Func _restart()
	Local $sAutoIt_File = @TempDir & "\~Au3_ScriptRestart_TempFile.au3"
	Local $sRunLine, $sScript_Content, $hFile

	$sRunLine = @ScriptFullPath
	If Not @Compiled Then $sRunLine = @AutoItExe & ' /AutoIt3ExecuteScript ""' & $sRunLine & '""'
	If $CmdLine[0] > 0 Then $sRunLine &= ' ' & $CmdLineRaw

	$sScript_Content &= '#NoTrayIcon' & @CRLF & _
			'While ProcessExists(' & @AutoItPID & ')' & @CRLF & _
			'   Sleep(10)' & @CRLF & _
			'WEnd' & @CRLF & _
			'Run("' & $sRunLine & '")' & @CRLF & _
			'FileDelete(@ScriptFullPath)' & @CRLF

	$hFile = FileOpen($sAutoIt_File, 2)
	FileWrite($hFile, $sScript_Content)
	FileClose($hFile)

	Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sAutoIt_File & '"', @ScriptDir, @SW_HIDE)
	Sleep(1000)
	Exit
EndFunc   ;==>_restart