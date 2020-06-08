#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=GenPass.exe
#AutoIt3Wrapper_Icon=GenPass.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=GenPass.exe
#AutoIt3Wrapper_Res_Fileversion=0.4.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.4
#AutoIt3Wrapper_Res_Field=Build|2012.08.06
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; AZJIO 2012.08.06 (AutoIt3_v3.3.6.1)

#NoTrayIcon
; #include <Array.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <String.au3>
#include <WinAPI.au3>
#include <StaticConstants.au3>
#include <Crypt.au3>
#include <NumToNum.au3>
#include <ForGenPass.au3>
; #include <Misc.au3>

; En
$LngTitle = 'Password generator'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngEnPs = 'Will Enter key phrase'
$LngOut = 'Result'
$LngCopy = 'Copy'
; $LngLm = 'Limit the number of characters'
; $LngSmb = 'Symbols'
$LngSmb = 'Will Enter symbols using in password'
$LngNoRe = 'without repeat'
$LngDef = 'Default'
$LngDefH = 'Options by default'
$LngChB = 'Hide password'
$LngIns = 'Insert'
$LngInsH = 'Insert in active window' & @CRLF & 'Ctrl + Enter'
$LngCopyH = 'Copy password' & @CRLF & 'Ctrl + Space'
$LngStg = 'Settings'
$LngMxPw = 'Limit the maximum password length'
$LngPsw = 'Password:'
$LngExeH = 'Calculate' & @CRLF & 'Enter'
$LngMsH = 'Save to memory' & @CRLF & 'Ctrl + Up'
$LngMrH = 'Read from memory' & @CRLF & 'Ctrl + Down'
$LngCeH = 'Clear the input field' & @CRLF & 'Ctrl + Left'
$LngAlg = 'Algorithm of enciphering of the key phrase'
$LngHash = 'Hashing algorithm'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	; $LngTitle='Генератор пароля по ключевой фразе'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngCopy = 'Копировать'
	$LngSite = 'Сайт'
	$LngEnPs = 'Введите ключевую фразу'
	$LngOut = 'Результат'
	$LngCopy = 'Копировать'
	; $LngLm = 'Лимит количества символов'
	; $LngSmb = 'Символы'
	$LngSmb = 'Введите символы использующиеся в пароле'
	$LngNoRe = 'без повторов'
	$LngDef = 'Сброс'
	$LngDefH = 'Восстановить стандартные настройки'
	$LngChB = 'Скрыть пароль'
	$LngIns = 'Вставить'
	$LngInsH = 'Вставить в активное окно' & @CRLF & 'Ctrl + Enter'
	$LngCopyH = 'Копировать пароль' & @CRLF & 'Ctrl + Пробел'
	$LngStg = 'Настройки'
	$LngMxPw = 'Ограничение максимальной длины пароля'
	$LngPsw = 'Пароль:'
	$LngExeH = 'Вычислить' & @CRLF & 'Enter'
	$LngMsH = 'Сохранить в память' & @CRLF & 'Ctrl + Up'
	$LngMrH = 'Прочитать из памяти' & @CRLF & 'Ctrl + Down'
	$LngCeH = 'Очистить поле ввода' & @CRLF & 'Ctrl + Left'
	$LngAlg = 'Алгоритм шифрования ключевой фразы'
	$LngHash = 'Алгоритм хеширования'
	; $Lng=''
EndIf
; $LngEnPs = '<' & $LngEnPs & '>'

Global $smb, $smb0 = '0123456789qwertyuiopasdfghjklzxcvbnm' ; -_~@%#$& символы участвующие в пароле /// characters involved in the password
$smb = $smb0
Global $limit0 = 8, $ini = @ScriptDir & '\GenPass.ini', $MR, $sPassword
$LenDef = StringLen($LngEnPs)

If Not FileExists($ini) Then
	$file = FileOpen($ini, 2)
	FileWrite($file, '[Set]' & @CRLF & _
			'Symbols=' & $smb & @CRLF & _
			'NoRepeat=2' & @CRLF & _
			'Hide=0' & @CRLF & _
			'Limit=14' & @CRLF & _
			'Crypt=AES 256' & @CRLF & _
			'Hash=SHA1')
	FileClose($file)
EndIf

$smb = StringLower(IniRead($ini, 'Set', 'Symbols', $smb)) ; в нижний регистр
_NoRepeat($smb) ; удаление повторов
$NoRepeat0 = Number(IniRead($ini, 'Set', 'NoRepeat', 2))
If $NoRepeat0 > 2 Or $limit0 < 0 Then $limit0 = 2
$limit0 = Number(IniRead($ini, 'Set', 'Limit', $limit0))
If $limit0 > 30 Or $limit0 < 1 Then $limit0 = 8
$Hide = Number(IniRead($ini, 'Set', 'Hide', 0))

$iniCrypt = IniRead($ini, 'Set', 'Crypt', 'AES 256')
If Not StringInStr('|AES 256|AES 192|AES 128|3DES|DES|RC4|RC2|RC4 str|', '|' & $iniCrypt & '|') Then $iniCrypt = 'AES 256'
$iniHash = IniRead($ini, 'Set', 'Hash', 'SHA1')
If Not StringInStr('|SHA1|MD5|', '|' & $iniHash & '|') Then $iniHash = 'SHA1'

$Gui = GUICreate($LngTitle, 450, 120, -1, -1, BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPCHILDREN), $WS_EX_ACCEPTFILES)
If Not @Compiled Then GUISetIcon(@ScriptDir & '\GenPass.ico')

$About = GUICtrlCreateButton('@', 417, 1, 22, 22)
GUICtrlSetTip(-1, $LngAbout)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateLabel($LngEnPs, 10, 5, 270, 17)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)

$iBtnMS = GUICtrlCreateButton('MS', 320, 1, 25, 22)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
GUICtrlSetTip(-1, $LngMsH)

$iBtnMR = GUICtrlCreateButton('MR', 345, 1, 25, 22)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
GUICtrlSetTip(-1, $LngMrH)

$iBtnCE = GUICtrlCreateButton('CE', 370, 1, 25, 22)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
GUICtrlSetTip(-1, $LngCeH)

$iExecute = GUICtrlCreateButton('>', 417, 23, 22, 22)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
GUICtrlSetTip(-1, $LngExeH)

$keyN = GUICtrlCreateInput('', 10, 23, 407, 22)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)
$keyP = GUICtrlCreateInput('', 10, 23, 407, 22, BitOR($GUI_SS_DEFAULT_INPUT, $ES_PASSWORD))
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)

$iLout = GUICtrlCreateLabel($LngPsw, 10, 52, 95, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
$out = GUICtrlCreateLabel('', 110, 50, 235, 22, $SS_SUNKEN + $SS_CENTERIMAGE)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)

$LimitCur = GUICtrlCreateLabel('0', 345, 50, 20, 22, $SS_CENTERIMAGE + $SS_CENTER)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$ChPsHd = GUICtrlCreateCheckbox($LngChB, 120, 90, 130, 15)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
If $Hide = 1 Then
	GUICtrlSetState($keyP, $GUI_FOCUS)
	GUICtrlSetState($keyN, $GUI_HIDE)
	$key = $keyP
	GUICtrlSetState($ChPsHd, $GUI_CHECKED)
	GUICtrlSetState($out, $GUI_HIDE)
	GUICtrlSetState($iLout, $GUI_HIDE)
	GUICtrlSetState($LimitCur, $GUI_HIDE)
Else
	GUICtrlSetState($keyN, $GUI_FOCUS)
	GUICtrlSetState($keyP, $GUI_HIDE)
	$key = $keyN
	GUICtrlSetState($ChPsHd, $GUI_UNCHECKED)
EndIf

$Insert = GUICtrlCreateButton($LngIns, 260, 80, 80, 34)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
GUICtrlSetTip(-1, $LngInsH)
$copy = GUICtrlCreateButton($LngCopy, 360, 80, 80, 34)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
GUICtrlSetTip(-1, $LngCopyH)

$iBtnStg = GUICtrlCreateButton($LngStg, 10, 85, 80, 24)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

Dim $AccelKeys[6][2] = [ _
		["^{Left}", $iBtnCE], _
		["^{Up}", $iBtnMS], _
		["^{Down}", $iBtnMR], _
		["{Enter}", $iExecute], _
		["^{Enter}", $Insert], _
		["^{SPACE}", $copy]]
GUISetAccelerators($AccelKeys)

GUISetState()
Send('{home}')

GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
OnAutoItExitRegister("_Exit")
Func _Exit()
	_Crypt_Shutdown()
	IniWrite($ini, 'Set', 'Hide', $Hide)
EndFunc
_Crypt_Startup()

While 1
	Switch GUIGetMsg()
		Case $iBtnMR
			GUICtrlSetData($key, $MR)
		Case $iBtnMS
			$MR = GUICtrlRead($key)
		Case $iBtnCE
			GUICtrlSetData($key, '')
		Case $iExecute
			_Execute()
		Case $iBtnStg
			_Setting()
		Case $Insert
			_Execute()
			WinSetState($Gui, '', @SW_MINIMIZE)
			$tmp = ClipGet()
			ClipPut($sPassword)
			Sleep(100)
			Send('+{INS}')
			WinSetState($Gui, '', @SW_RESTORE)
			ClipPut($tmp)
		Case $ChPsHd
			If GUICtrlRead($ChPsHd) = $GUI_CHECKED Then
				GUICtrlSetData($keyP, GUICtrlRead($keyN))
				GUICtrlSetState($keyP, $GUI_SHOW)
				GUICtrlSetState($keyN, $GUI_HIDE)
				$key = $keyP
				$Hide = 1
				GUICtrlSetData($keyN, '') ; очищаем скрытое поле ввода
				GUICtrlSetState($out, $GUI_HIDE)
				GUICtrlSetState($iLout, $GUI_HIDE)
				GUICtrlSetState($LimitCur, $GUI_HIDE)
				
				GUICtrlSetData($out, '')
				GUICtrlSetData($LimitCur, '')
			Else
				$tmp = GUICtrlRead($keyP)
				GUICtrlSetData($keyN, $tmp)
				GUICtrlSetState($keyN, $GUI_SHOW)
				GUICtrlSetState($keyP, $GUI_HIDE)
				$key = $keyN
				$Hide = 0
				GUICtrlSetData($keyP, '') ; очищаем скрытое поле ввода
				GUICtrlSetState($out, $GUI_SHOW)
				GUICtrlSetState($iLout, $GUI_SHOW)
				GUICtrlSetState($LimitCur, $GUI_SHOW)
				
				GUICtrlSetData($out, $sPassword)
				GUICtrlSetData($LimitCur, StringLen($sPassword))
				If $tmp And Not $sPassword Then _Execute()
			EndIf
			GUICtrlSetState($key, $GUI_FOCUS)
		Case $copy
			ClipPut(GUICtrlRead($out, 1))
		Case $About
			_About()
		Case -3
			Exit
	EndSwitch
WEnd

Func _Execute()
	Local $tmp = GUICtrlRead($key, 1)
	If $tmp Then
		$tmp = _Conv($tmp)

		Switch $NoRepeat0
			Case 1
				$tmp = StringRegExpReplace($tmp, '(.)\1+', '\1') ; удаляем слитный повтор
			Case 2
				_NoRepeat($tmp) ; удаляем любой повтор
		EndSwitch

		; обрезаем пароль по лимиту
		If StringLen($tmp) > $limit0 Then
			$tmp = StringLeft($tmp, $limit0)
		EndIf
		$sPassword = $tmp
		If $Hide = 1 Then
			GUICtrlSetData($out, '')
			GUICtrlSetData($LimitCur, '')
		Else
			GUICtrlSetData($out, $tmp)
			GUICtrlSetData($LimitCur, StringLen($tmp))
		EndIf
	EndIf
EndFunc

; конвертируем фразу в пароль
; 1. Шифруем фразу
; 2. Создаём хеш MD5 шифрованых данных
; 3. Конвертируем хеш из 16-ричной системы в десятиричную систему счисления

 ; медленнаяза за сёт 64 символов минимальных
	; Switch StringLen($sKeyText) ; уровень шифрования позволяет получить длинную комбинацию пароля при коротких фразах
		; Case 1
			; $iLevel = 5
		; Case 2, 3
			; $iLevel = 4
		; Case 4 To 7
			; $iLevel = 3
		; Case 8 To 15
			; $iLevel = 2
		; Case Else
			; $iLevel = 1
	; EndSwitch

Func _Conv($sKeyText) ; очень быстрая, так как минимум операций конвертирования
	Local $sDec, $sPasw, $iLevel
	; _StringEncrypt работает быстрее чем _Crypt_EncryptData, к тому же _StringEncrypt не во внешнем файле и не подвержена модернизации
	Switch $iniCrypt
		Case 'AES 256'
			$sData = _Crypt_EncryptData($sKeyText, $sKeyText, $CALG_AES_256)
		Case 'AES 192'
			$sData = _Crypt_EncryptData($sKeyText, $sKeyText, $CALG_AES_192)
		Case 'AES 128'
			$sData = _Crypt_EncryptData($sKeyText, $sKeyText, $CALG_AES_128)
		Case '3DES'
			$sData = _Crypt_EncryptData($sKeyText, $sKeyText, $CALG_3DES)
		Case 'DES'
			$sData = _Crypt_EncryptData($sKeyText, $sKeyText, $CALG_DES)
		Case 'RC4'
			$sData = _Crypt_EncryptData($sKeyText, $sKeyText, $CALG_RC4)
		Case 'RC2'
			$sData = _Crypt_EncryptData($sKeyText, $sKeyText, $CALG_RC2)
		Case 'RC4 str'
			Switch StringLen($sKeyText)
				Case 1
					$iLevel = 5
				Case 2, 3
					$iLevel = 4
				Case 4 To 7
					$iLevel = 3
				Case 8 To 15
					$iLevel = 2
				Case Else
					$iLevel = 1
			EndSwitch
			$sData = '0x' & _StringEncrypt(1, $sKeyText, $sKeyText, $iLevel)
		Case Else
			Return SetError(1)
	EndSwitch
	Switch $iniHash
		Case 'SHA1'
			$sData = _Crypt_HashData($sData, $CALG_SHA1)
		Case 'MD5'
			$sData = _Crypt_HashData($sData, $CALG_MD5)
		Case Else
			Return SetError(1)
	EndSwitch
	$sDec = _NumToDec(StringTrimLeft($sData, 2), '0123456789ABCDEF')
	$sPasw = _DecToNum($sDec, $smb) ; конвертируем из десятиричной системы счисления в произвольный набор символов
	Return _Upper($sPasw, $sDec) ; переводим в верхний регистр буквы в позициях указаных в цифрах числа
EndFunc

Func _Upper($sPasw, $sDec) ; пароль и число (десятичное число пароля)
	Local $a, $am, $i, $k, $n
	$a = StringSplit($sPasw, '')
	$iRPasw = StringLen($sPasw)
	$sSymbol_0 = '123456789abcdefghijklmnopqrstuvwxyz' ; для 35 символьного пароля
	$n = StringSplit(_DecToNum($sDec, StringLeft($sSymbol_0, $iRPasw)), '') ; разрядность определяются длинной пароля
	_NumUnique($n)
	For $i = 1 To $n[0] ; заменяем буквы десятичными числами
		If StringIsAlpha($n[$i]) Then $n[$i] = StringInStr($sSymbol_0, $n[$i])
	Next
	; _ArrayDisplay($n, 'Array')
	; $tmp = ''
	; For $i = 1 To $n[0]
	; $tmp &= $n[$i]
	; Next
	; MsgBox(0, $sDec, $tmp)
	$am = Int(StringLen(StringRegExpReplace($sPasw, '[^a-z]+', '')) / 2) ; вычисляем количество букв в пароле и делим на 2 (то есть половина букв будет заглавные)
	$k = 0
	For $i = 1 To $n[0]
		; убрано условие проверки $n[$i]<=$a[0] And (если число не больше ширины пароля и)
		If StringIsAlpha($a[$n[$i]]) Then ; если в этой позиции в пароле буква, то
			$a[$n[$i]] = StringUpper($a[$n[$i]]) ; делаем её заглавной
			$k += 1
			If $k >= $am Then ExitLoop ; закончили, если сделана половина замен
		EndIf
	Next
	$sPasw = ''
	For $i = 1 To $a[0]
		$sPasw &= $a[$i]
	Next
	; MsgBox(0, 'Сообщение', $sPasw &@CRLF&$sDec  &@CRLF&$am)
	Return $sPasw
EndFunc

Func _NumUnique(ByRef $aNum)
	Local $ii, $kk ; двойные имена переменных, так как в $aNum используются односимвольные переменные
	$kk = 0
	For $ii = 1 To $aNum[0]
		If Not IsDeclared($aNum[$ii] & '\') Then
			Assign($aNum[$ii] & '\', 0, 1)
			$kk += 1
			$aNum[$kk] = $aNum[$ii]
		EndIf
	Next
	ReDim $aNum[$kk + 1]
	$aNum[0] = $kk
EndFunc

; удаление любого повтора
Func _NoRepeat(ByRef $tmp)
	Local $i, $data, $Tr0 = 0, $00 = Chr(0)
	If StringInStr($tmp, '[') Then
		$tmp = StringReplace($tmp, '[', $00)
		$Tr0 = 1
	EndIf
	$data = StringSplit($tmp, '')
	If @error Then
		$tmp = ''
	Else
		$tmp = ''
		For $i = 1 To $data[0]
			If Not IsDeclared('/' & $data[$i]) Then
				$tmp &= $data[$i]
				Assign('/' & $data[$i], '', 1)
			EndIf
		Next
		If $Tr0 Then $tmp = StringReplace($tmp, $00, '[')
	EndIf
EndFunc

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $Gui Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeY", 157)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 450)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 157)
		DllStructSetData($tMINMAXINFO, "MaxSizeY", 157)
		DllStructSetData($tMINMAXINFO, "MaxPositionY", 0)
	EndIf
EndFunc

Func _Setting()
	Local $EditBut, $Gui1, $GP, $msg, $StrBut
	$GP = _ChildCoor($Gui, 390, 240)
	GUISetState(@SW_DISABLE, $Gui)
	
	$Gui1 = GUICreate($LngStg, $GP[2], $GP[3], $GP[0], $GP[1], $WS_CAPTION + $WS_SYSMENU + $WS_POPUP, -1, $Gui)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\GenPass.ico')

	GUICtrlCreateLabel($LngSmb, 10, 5, 370, 17)
	$iSmb = GUICtrlCreateInput($smb, 10, 23, 370, 22)
	
	$limit = GUICtrlCreateInput($limit0, 10, 52, 45, 22)
	GUICtrlCreateUpdown($limit)
	GUICtrlSetLimit(-1, 30, 1)
	GUICtrlCreateLabel($LngMxPw, 60, 56, 180, 17)

	$NoRepeat = GUICtrlCreateCombo('', 10, 81, 45, 23, 0x3)
	GUICtrlSetData(-1, '0|1|2', $NoRepeat0)
	GUICtrlCreateLabel($LngNoRe, 60, 84, 180, 17)

	$def = GUICtrlCreateButton($LngDef, 300, 80, 80, 24)
	GUICtrlSetTip(-1, $LngDefH)
	
	$iAlgCrypt = GUICtrlCreateCombo('', 10, 111, 75, 23, 0x3)
	GUICtrlSetData(-1, 'AES 256|AES 192|AES 128|3DES|DES|RC4|RC2|RC4 str', $iniCrypt)
	GUICtrlCreateLabel($LngAlg, 90, 114, 210, 17)
	
	$iAlgHash = GUICtrlCreateCombo('', 10, 141, 75, 23, 0x3)
	GUICtrlSetData(-1, 'SHA1|MD5', $iniHash)
	GUICtrlCreateLabel($LngHash, 90, 144, 180, 17)

	$iOK = GUICtrlCreateButton('OK', 155, 190, 80, 33)
	GUICtrlSetTip(-1, $LngDefH)

	GUISetState(@SW_SHOW, $Gui1)
	While 1
		Switch GUIGetMsg()
			Case $def ; сброс
				GUICtrlSetData($limit, 14)
				GUICtrlSetData($NoRepeat, 2)
				GUICtrlSetData($iAlgCrypt, 'AES 256')
				GUICtrlSetData($iAlgHash, 'SHA1')
				GUICtrlSetData($iSmb, $smb0)
			Case $limit
				$limit0 = Number(GUICtrlRead($limit))
				$out0 = GUICtrlRead($out)
				If StringLen($out0) > $limit0 Then
					GUICtrlSetData($out, StringLeft($out0, $limit0))
					GUICtrlSetData($LimitCur, $limit0)
				EndIf
			Case $iOK ; применить
				$tmp = StringLower(GUICtrlRead($iSmb)) ; набор символов
				_NoRepeat($tmp)
				$smb = $tmp
				$iniHash = GUICtrlRead($iAlgHash)
				$iniCrypt = GUICtrlRead($iAlgCrypt)
				$limit0 = GUICtrlRead($limit)
				$NoRepeat0 = GUICtrlRead($NoRepeat)
				IniWrite($ini, 'Set', 'Symbols', $smb)
				IniWrite($ini, 'Set', 'NoRepeat', GUICtrlRead($NoRepeat))
				IniWrite($ini, 'Set', 'Limit', GUICtrlRead($limit))
				IniWrite($ini, 'Set', 'Crypt', $iniCrypt)
				IniWrite($ini, 'Set', 'Hash', $iniHash)
				_Execute()
				ContinueCase
			Case -3
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func WM_COMMAND($hWnd, $imsg, $iwParam, $ilParam)
	Local $nNotifyCode, $nID
	$nNotifyCode = BitShift($iwParam, 16)
	$nID = BitAND($iwParam, 0xFFFF)
	If $nID = $key And $nNotifyCode = $EN_CHANGE And Not $Hide Then GUICtrlSetData($out, '')
	Return $GUI_RUNDEFMSG
EndFunc

Func _About()
	$GP = _ChildCoor($Gui, 220, 180)
	GUISetState(@SW_DISABLE, $Gui)
	$font = "Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\GenPass.ico')
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 220, 63, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 14, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 220 - 2, 1, 0x10)
	
	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.4   2012.08.06', 15, 100, 220, 17)
	GUICtrlCreateLabel($LngSite & ':', 15, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 52, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 15, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 90, 130, 125, 17)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2011-2012', 15, 145, 220, 17)
	GUISetState(@SW_SHOW, $Gui1)

	While 1
		Switch GUIGetMsg()
			Case $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $WbMn
				ClipPut('R939163939152')
			Case -3
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc