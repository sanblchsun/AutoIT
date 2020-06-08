;  @AZJIO 2012.09.02
; программа исправления текста набранного в неправильной раскладке клавиатуры
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=TextCorrection.exe
;#AutoIt3Wrapper_icon=TextCorrection.ico
;#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=TextCorrection.exe
#AutoIt3Wrapper_Res_Fileversion=0.8.0.0
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.8
#AutoIt3Wrapper_Res_Field=Build|2012.09.02
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -add "%out%", "%out%", %scriptdir%\icons\0.ico, IconGroup, 1, 0
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -add "%out%", "%out%", %scriptdir%\icons\1.ico, IconGroup, 2, 0
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -add "%out%", "%out%", %scriptdir%\icons\2.ico, IconGroup, 3, 0
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -add "%out%", "%out%", %scriptdir%\icons\3.ico, IconGroup, 4, 0
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -delete "%out%", "%out%", DIALOG, 1000,
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -delete "%out%", "%out%", ICON, 161,
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -delete "%out%", "%out%", ICON, 162,
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -delete "%out%", "%out%", ICON, 164,
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -delete "%out%", "%out%", ICON, 169,
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -delete "%out%", "%out%", ICON, 99,
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\upx\upx.exe -7 --compress-icons=0 "%out%"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

$LngTitle = 'Text Correction'

; En
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site:'
$LngCopy = 'Copy'
$LngHlp = 'Help'
$LngSet = 'Setting'
$LngExit = 'Exit'

$LngMs1 = 'Message'
$LngMs2 = 'Could not register hot key'
$LngMs3 = 'It may be in use by another application.'
$LngMs4 = 'One copy of the program is already running.'
$LngGr = 'Setting hotkeys'
$LngHkH = 'Place the cursor in the edit box and press the hotkey'
$LngTxA = _
'1 correcting words, everything in one language|' & _
'2 correcting line, invert|' & _
'3 correcting words before the first space|' & _
'4 correcting words, invert|' & _
'5 the first letter uppercase, the rest lowercase|' & _
'6 to upper case|' & _
'7 to lower case|' & _
'8 switching to an alternative language (3)'
$LngS1 = 'Delimiter for words to Mode 3. Valid characters:'
$LngS2 = 'as CapsLock (recommended)'
$LngS2H = 'Pay attention to the processing of 23467' & @CRLF & 'when translated to uppercase'
$LngS3A = 'Startup'
$LngS3H = 'Startup, when Windows starts'
$LngApl = 'Apply'
$LngRdm1 = 'Purpose of the program'
$LngRdm2 = 'The program is designed to automatically edit the text typed in the wrong keyboard layout. Enough to put the cursor to the end of the corrected text. To fix selectively, you can select the necessary part of the word.'
$LngRdm3 = 'Appropriate languages: 409 - En, 419 - Ru, 422 - Uk' & @CRLF & @CRLF & 'Languages are installed on your computer:'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт:'
	$LngCopy = 'Копировать'
	$LngHlp = 'Справка'
	$LngSet = 'Настройки'
	$LngExit = 'Выход'
	$LngMs1 = 'Сообщение'
	$LngMs2 = 'Не удалось зарегистрировать горячую клавишу'
	$LngMs3 = 'возможно она используется другим приложением.'
	$LngMs4 = 'Одна копия программы уже выполняется.'
	$LngGr = 'Установка горячих клавиш'
	$LngHkH = 'Установите курсор в поле ввода и нажмите горячую клавишу'
	$LngTxA = _
	'1 исправление слова либо всё русское, либо английское|' & _
	'2 исправление строки инвертированием|' & _
	'3 исправление слова до первого пробела|' & _
	'4 исправление слова инвертированием|' & _
	'5 красная строка, первая буква заглавная|' & _
	'6 перевод в верхний регистр|' & _
	'7 перевод в нижний регистр|' & _
	'8 переключение на альтернативный язык (Ctrl+p)'
	$LngS1 = 'Разделитель слов для режима 3, допустимые символы'
	$LngS2 = 'Обрабатывать как CapsLock (рекомендуется)'
	$LngS2H = 'Обратите внимание на обработку 23467' & @CRLF & 'при переводе в верхний регистр'
	$LngS3A = 'Автозагрузка'
	$LngS3H = 'Автозагрузка при старте Windows'
	$LngApl = 'Применить'
	$LngRdm1 = 'Назначение программы'
	$LngRdm2 = 'Программа предназначена для автоматического исправления текста набранного в неправильной раскладке клавиатуры. Достаточно поставить курсор в конец исправляемого текста. Чтобы исправить избирательно, нужно выделить необходимую часть слова.'
	$LngRdm3 = 'Соответствие языков: 409 - En, 419 - Ru, 422 - Uk' & @CRLF & @CRLF & 'Языки установленные в текущем компьютере:'
EndIf

If WinExists('Text_Correction_AZJIO') Then
	Opt("TrayIconHide", 1)
	MsgBox(0, $LngMs1, $LngMs4)
	Exit
EndIf
#include <GuiConstantsEx.au3>
#include <GuiHotKey.au3>
#include <Misc.au3>
#include <StaticConstants.au3>
#include <ForTextCorrection.au3>

Opt("SendKeyDelay", 1)
Opt("SendKeyDownDelay", 1)
Opt("TrayMenuMode", 3)
Opt("TrayOnEventMode", 1)

Global $En, $Ru, $Uk, $CapsLock, $EnT, $RuT, $UkT, $L1, $Pattern, $PatOut, $LangTmp, $Temp1 = '', $Temp2 = '', $Temp3 = '', $LangTmp2
Global $HotkeyID[9] = [8, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008], $HotkeyCode[9]
If @Compiled Then
	$sPathIcon = @AutoItExe
Else
	$sPathIcon = @ScriptDir & '\TextCorrection.dll'
EndIf
Global $Ini = @ScriptDir & '\TextCorrection.ini' ; путь к TextCorrection.ini
Global $hHz = ExtractIcon($sPathIcon, 0)
Global $hEn = ExtractIcon($sPathIcon, 1)
Global $hRu = ExtractIcon($sPathIcon, 2)
Global $hUk = ExtractIcon($sPathIcon, 3)

$EnDef = "`qwertyuiop[]asdfghjkl;'zxcvbnm,./~QWERTYUIOP{}ASDFGHJKL:""|ZXCVBNM<>?@#$^&"
$RuDef = "ёйцукенгшщзхъфывапролджэячсмитьбю.ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭ/ЯЧСМИТЬБЮ,""№;:?"
$UkDef = "ёйцукенгшщзхїфівапролджєячсмитьбю.ЁЙЦУКЕНГШЩЗХЇФІВАПРОЛДЖЄ/ЯЧСМИТЬБЮ,""№;:?"
$EnText = 'qwertyuiopasdfghjklzxcvbnm'
$RuText = 'ёйцукенгшщзхъфывапролджэячсмитьбю'
$UkText = 'ёйцукенгшщзхїфівапролджєячсмитьбю'

;Проверка существования TextCorrection.ini
If Not FileExists($Ini) Then
	$iniopen = FileOpen($Ini, 2)
	FileWrite($iniopen, '[General]' & @CRLF & _
			'Lang1=' & $EnDef & @CRLF & _
			'Lang2=' & $RuDef & @CRLF & _
			'Lang3=' & $UkDef & @CRLF & _
			'LangT1=' & $EnText & @CRLF & _
			'LangT2=' & $RuText & @CRLF & _
			'LangT3=' & $UkText & @CRLF & _
			'LangR1=00000409' & @CRLF & _
			'LangR2=00000419' & @CRLF & _
			'LangR2=00000422' & @CRLF & _
			'Pattern=\()=+%!' & @CRLF & _
			'AutoStart=0' & @CRLF & _
			'CapsLock=1' & @CRLF & @CRLF & _
			'[HotKey]' & @CRLF & _
			'HotKey1=131292' & @CRLF & _
			'HotKey2=131294' & @CRLF & _
			'HotKey3=131258' & @CRLF & _
			'HotKey4=131148' & @CRLF & _
			'HotKey5=131263' & @CRLF & _
			'HotKey6=131291' & @CRLF & _
			'HotKey7=131293' & @CRLF & _
			'HotKey8=0')
	FileClose($iniopen)
EndIf

;читаем TextCorrection.ini
$En = IniRead($Ini, "General", "Lang1", $EnDef)
$Ru = IniRead($Ini, "General", "Lang2", $RuDef)
$Uk = IniRead($Ini, "General", "Lang3", $UkDef)
$EnT = IniRead($Ini, "General", "LangT1", $EnText)
$RuT = IniRead($Ini, "General", "LangT2", $RuText)
$UkT = IniRead($Ini, "General", "LangT3", $UkText)
$LangR1 = IniRead($Ini, "General", "LangR1", '00000409')
$LangR2 = IniRead($Ini, "General", "LangR2", '00000419')
$LangR3 = IniRead($Ini, "General", "LangR3", '00000422')
$CapsLock = IniRead($Ini, "General", "CapsLock", 1)
$Pattern = IniRead($Ini, "General", "Pattern", '\()=+%!')
$aDef = StringSplit("732,734,698,588,703,731,733,0", ",")
For $i = 1 To 8
	$HotkeyCode[$i] = IniRead($Ini, "HotKey", "HotKey" & $i, $aDef[$i])
Next
$AutoStart = IniRead($Ini, "General", "AutoStart", 0)
_Autostart()
$LangN1 = $LangR1
$LangN2 = $LangR2
$LangN3 = $LangR3

$LangTmp = $LangR2
$LangTmp2 = $LangR2
_Pattern()
_Tray_SetHIcon($hRu)

$hGui = GUICreate('Text_Correction_AZJIO')
For $i = 1 To 8
	If $HotkeyCode[$i] <> '0' Then
		$HotkeyCode[$i] = Number($HotkeyCode[$i])
		If Not _GuiCtrlHotKey_RegisterHotkey($hGui, $HotkeyID[$i], _WinAPI_LoWord($HotkeyCode[$i]), _WinAPI_HiWord($HotkeyCode[$i])) Then
			MsgBox(0, $LngMs1, $LngMs2 & _GetKey($HotkeyCode[$i]) & ',' & @LF & $LngMs3, 0, $hGui)
			$HotkeyCode[$i] = 0
		EndIf
	Else
		$HotkeyCode[$i] = 0
	EndIf
Next

$About = TrayCreateItem($LngAbout)
TrayItemSetOnEvent(-1, "_About")

$Readme = TrayCreateItem($LngHlp)
TrayItemSetOnEvent(-1, "_Readme")

$GuiHotKey = TrayCreateItem($LngSet)
TrayItemSetOnEvent(-1, "_Setting")

$Quit = TrayCreateItem($LngExit)
TrayItemSetOnEvent(-1, "_Exit")

$L2 = 0
TraySetToolTip('TextCorrection')

GUIRegisterMsg($WM_HOTKEY, "WM_HOTKEY")
While 1
	Sleep(100)
	$L1 = GetActiveKeyboardLayout(WinGetHandle('')) ; получаем дескриптор активного окна и раскладку клавиатуры в нём
	If Not $L1 Then $L1 = @KBLayout ; если не удалось получить, то устанавливаем по умолчанию
	If $L1 <> $L2 Then ; если раскладка изменилась, то меняем иконку
		Switch $L1
			Case $LangN1
				_Tray_SetHIcon($hEn)
			Case $LangN2
				_Tray_SetHIcon($hRu)
			Case $LangN3
				_Tray_SetHIcon($hUk)
			Case Else
				_Tray_SetHIcon($hHz)
		EndSwitch
		$L2 = $L1
	EndIf
WEnd

Func _Exit()
	_WinAPI_DestroyIcon($hHz)
	_WinAPI_DestroyIcon($hEn)
	_WinAPI_DestroyIcon($hRu)
	_WinAPI_DestroyIcon($hUk)
	Exit
EndFunc

Func _Re($hk, $mode = 0)
	Local $Selected_Text, $New_Text, $Old_bufer, $aBykvText, $hWnd, $WinList, $Lang

	; определение активного окна и проверка раскладки клавиатуры
	$Lang = GetActiveKeyboardLayout(WinGetHandle(''))
	$setLang = ''

	$Old_bufer = ClipGet() ; для восстановления буфера
	ClipPut('')
	;проверка выделенного текста, если не выделен, то выделяем
	_SendEx("^{INS}") ; копирование текста
	Sleep(10)
	$Selected_Text = ClipGet() ; из буфера в переменную
	If $Selected_Text = '' Then ; если вновь скопированная выделенная часть равна предыдущим данным (равносильно отсутсвию выделенного текста), то
		_SendEx($hk) ; выделяем текст
		Sleep(30)
		_SendEx("^{INS}") ; копируем текст
		Sleep(30)
		$Selected_Text = ClipGet()
	EndIf
	$New_Text = ''
	If $Selected_Text <> '' Then

		If $mode = 5 Then ; исправление слова до пробела
			$aSelected_Text = StringRegExp($Selected_Text, '(^.*)( ' & $PatOut & ')(.*)$', 3)
			If UBound($aSelected_Text) < 2 Then
				$mode = 0
			Else
				$New_Text = $aSelected_Text[0] & $aSelected_Text[1]
				$Selected_Text = $aSelected_Text[2]
				$mode = 0
			EndIf
		EndIf
		
		$aBykvText = StringSplit($Selected_Text, "")

		; ищем справа-налево последний валидный символ в тексте, по которому можно определить язык
		$bykva = ''
		For $i = StringLen($Selected_Text) To 1 Step -1
			If StringInStr($RuT & $EnT, StringMid($Selected_Text, $i, 1)) <> 0 Then
				$bykva = StringMid($Selected_Text, $i, 1)
				ExitLoop
			EndIf
		Next

		; установка языка, иначе по раскладке
		If $bykva <> '' Then
			If StringInStr($EnT, $bykva) Then
				$Lang = $LangN1
			Else
				If StringInStr($RuT, $bykva) Then $Lang = $LangN2
			EndIf
		EndIf
		If $Lang = '' Then Return

	Switch $mode
		Case 4 ; красная строка, режим перевода в верхний регистр первой буквы
			$bykva1 = ''
			$Selected_Text = StringLower($Selected_Text)
			For $i = 1 To StringLen($Selected_Text)
				If StringInStr($RuT & $EnT, StringMid($Selected_Text, $i, 1)) <> 0 Then
					$New_Text = StringReplace($Selected_Text, $i, StringUpper(StringMid($Selected_Text, $i, 1)))
					ExitLoop
				EndIf
			Next
		Case 3 ; режим перевода в нижний регистр, в том числе спец-символов
			$New_Text = StringLower($Selected_Text)
			If $Lang = $LangN1 And $CapsLock <> 1 Then
				$New_Text = StringReplace($New_Text, StringMid($En, 70, 1), '2')
				$New_Text = StringReplace($New_Text, StringMid($En, 71, 1), '3')
				$New_Text = StringReplace($New_Text, StringMid($En, 72, 1), '4')
				$New_Text = StringReplace($New_Text, StringMid($En, 73, 1), '6')
				$New_Text = StringReplace($New_Text, StringMid($En, 74, 1), '7')
			EndIf

			If $Lang = $LangN2 And $CapsLock <> 1 Then
				$New_Text = StringReplace($New_Text, StringMid($Ru, 70, 1), '2')
				$New_Text = StringReplace($New_Text, StringMid($Ru, 71, 1), '3')
				$New_Text = StringReplace($New_Text, StringMid($Ru, 72, 1), '4')
				$New_Text = StringReplace($New_Text, StringMid($Ru, 73, 1), '6')
				$New_Text = StringReplace($New_Text, StringMid($Ru, 74, 1), '7')
			EndIf
		Case 2 ; режим перевода в верхний регистр, в том числе спец-символов
			$New_Text = StringUpper($Selected_Text)
			If $Lang = $LangN1 And $CapsLock <> 1 Then
				$New_Text = StringReplace($New_Text, '2', StringMid($En, 70, 1))
				$New_Text = StringReplace($New_Text, '3', StringMid($En, 71, 1))
				$New_Text = StringReplace($New_Text, '4', StringMid($En, 72, 1))
				$New_Text = StringReplace($New_Text, '6', StringMid($En, 73, 1))
				$New_Text = StringReplace($New_Text, '7', StringMid($En, 74, 1))
			EndIf

			If $Lang = $LangN2 And $CapsLock <> 1 Then
				$New_Text = StringReplace($New_Text, '2', StringMid($Ru, 70, 1))
				$New_Text = StringReplace($New_Text, '3', StringMid($Ru, 71, 1))
				$New_Text = StringReplace($New_Text, '4', StringMid($Ru, 72, 1))
				$New_Text = StringReplace($New_Text, '6', StringMid($Ru, 73, 1))
				$New_Text = StringReplace($New_Text, '7', StringMid($Ru, 74, 1))
			EndIf
		Case 1 ; режим инвертирования
			;определяем язык
			; если русский, то меняем на англ.
			If $Lang = $LangN2 Then
				For $i = 1 To $aBykvText[0]
					$n = StringInStr($Ru, $aBykvText[$i], 1)
					;===========================================================
					; особое распознавание в смешанном тексте для ;:? по левому символу
					If StringInStr(';:?', $aBykvText[$i]) Then
						$v = 1
						$bbb = 0
						While $i - $v > 0 And $bbb = 0
							$bbb = StringInStr($RuT & $EnT, $aBykvText[$i - $v])
							$v += 1
						WEnd
						If $bbb > 33 Then
							If $aBykvText[$i] = ';' Then $New_Text &= StringMid($Ru, 23, 1)
							If $aBykvText[$i] = ':' Then $New_Text &= StringMid($Ru, 57, 1)
							If $aBykvText[$i] = '?' Then $New_Text &= StringMid($Ru, 69, 1)
							ContinueLoop
						EndIf
					EndIf
					;===========================================================
					If $n = 0 Then
						$n = StringInStr($En, $aBykvText[$i], 1)
						If $n = 0 Then
							$New_Text &= $aBykvText[$i]
						Else
							$New_Text &= StringMid($Ru, $n, 1)
						EndIf
					Else
						$New_Text &= StringMid($En, $n, 1)
					EndIf
				Next
				$setLang = $LangN1
			EndIf
			; если английский, то меняем на русс.
			If $Lang = $LangN1 Then
				For $i = 1 To $aBykvText[0]
					$n = StringInStr($En, $aBykvText[$i], 1)
					;===========================================================
					; особое распознавание в смешанном тексте для ;:? по левому символу
					If StringInStr(';:?', $aBykvText[$i]) Then
						$v = 1
						$bbb = 0
						While $i - $v > 0 And $bbb = 0
							$bbb = StringInStr($RuT & $EnT, $aBykvText[$i - $v])
							$v += 1
						WEnd
						If $bbb <= 33 And $bbb > 0 Then
							If $aBykvText[$i] = ';' Then $New_Text &= StringMid($En, 72, 1)
							If $aBykvText[$i] = ':' Then $New_Text &= StringMid($En, 73, 1)
							If $aBykvText[$i] = '?' Then $New_Text &= StringMid($En, 74, 1)
							ContinueLoop
						EndIf
					EndIf
					;===========================================================
					If $n = 0 Then
						$n = StringInStr($Ru, $aBykvText[$i], 1)
						If $n = 0 Then
							$New_Text &= $aBykvText[$i]
						Else
							$New_Text &= StringMid($En, $n, 1)
						EndIf
					Else
						$New_Text &= StringMid($Ru, $n, 1)
					EndIf
				Next
				$setLang = $LangN2
			EndIf
		Case 0 ; режим НЕ инвертирования
			;определяем язык
			; если русский, то меняем на англ.
			If $Lang = $LangN2 Then
				For $i = 1 To $aBykvText[0]
					$n = StringInStr($Ru, $aBykvText[$i], 1)
					If $n = 0 Then
						$New_Text &= $aBykvText[$i]
					Else
						$New_Text &= StringMid($En, $n, 1)
					EndIf
				Next
				$setLang = $LangN1
			EndIf
			; если английский, то меняем на русс.
			If $Lang = $LangN1 Then
				For $i = 1 To $aBykvText[0]
					$n = StringInStr($En, $aBykvText[$i], 1)
					If $n = 0 Then
						$New_Text &= $aBykvText[$i]
					Else
						$New_Text &= StringMid($Ru, $n, 1)
					EndIf
				Next
				$setLang = $LangN2
			EndIf
	EndSwitch

	EndIf

	If $New_Text <> '' Then
		ClipPut($New_Text) ; отправляем в буфер
		Sleep(10)
		_SendEx("+{INS}") ; вставляем из буфера
	Else
		_SendEx("{RIGHT}")
	EndIf
	ClipPut($Old_bufer) ; отправляем в буфер старый патерн

	Switch $setLang
		Case $LangN1
			_SetKeyboardLayout($LangR1, WinGetHandle(''))
		Case $LangN2
			_SetKeyboardLayout($LangR2, WinGetHandle(''))
	EndSwitch
EndFunc

Func _Pattern()
	$aSymb = StringSplit($Pattern, '')
	$Pattern = ''
	$PatOut = ''
	For $i = 1 To $aSymb[0]
		If StringInStr('=!%-_', $aSymb[$i]) Then
			$PatOut &= '|' & $aSymb[$i]
			$Pattern &= $aSymb[$i]
		EndIf
		If StringInStr('()\+*', $aSymb[$i]) Then
			$PatOut &= '|\' & $aSymb[$i]
			$Pattern &= $aSymb[$i]
		EndIf
	Next
EndFunc

Func _SendEx($sSend_Data)
	Local $hUser32DllOpen = DllOpen("User32.dll")
	While _IsPressed("10", $hUser32DllOpen) Or _IsPressed("11", $hUser32DllOpen) Or _IsPressed("12", $hUser32DllOpen)
		Sleep(30)
	WEnd
	Send($sSend_Data)
	DllClose($hUser32DllOpen)
EndFunc

Func _Setting()
GUIRegisterMsg($WM_HOTKEY, "")
	Local $f1 = 25, $TL = StringSplit($LngTxA, '|')
	Opt("TrayIconHide", 1)
	$hGui1 = GUICreate($LngSet, 460, 320, -1, -1, BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $hGui)
	GUISetIcon($sPathIcon)
	GUICtrlCreateGroup($LngGr, 7, 2, 445, 240)
	GUICtrlCreateLabel($LngHkH, 20, 19, 410, 20, $SS_LEFTNOWORDWRAP)
	Local $HotkeyInput[9] = [8]

	For $i = 1 To 8
		GUICtrlCreateLabel($TL[$i], 153, $f1 * $i + 16, 290, 17, $SS_LEFTNOWORDWRAP)
		$HotkeyInput[$i] = _GuiCtrlHotKey_Create($hGui1, 16, $f1 * $i + 14, 130, 20)
		_GuiCtrlHotKey_SetHotkey($HotkeyInput[$i], _WinAPI_LoWord($HotkeyCode[$i]), _WinAPI_HiWord($HotkeyCode[$i]))
	Next

	$PatInp = GUICtrlCreateInput($Pattern, 10, 248, 70, 20)
	GUICtrlCreateLabel($LngS1 & " \()=+%!*-_", 90, 250, 360, 20, $SS_LEFTNOWORDWRAP)

	$chCapsLock = GUICtrlCreateCheckbox($LngS2, 10, 275, 320, 20)
	GUICtrlSetTip(-1, $LngS2H)
	If $CapsLock = 1 Then GUICtrlSetState(-1, 1)

	$chAutostart = GUICtrlCreateCheckbox($LngS3A, 10, 295, 320, 20)
	GUICtrlSetTip(-1, $LngS3H)
	If $AutoStart = 1 Then GUICtrlSetState(-1, 1)

	$apply = GUICtrlCreateButton($LngApl, 355, 280, 95, 33)
	GUISetState()

	While 1
		Switch GUIGetMsg()
			Case $apply
				
				If GUICtrlRead($PatInp) <> $Pattern Then
					$Pattern = GUICtrlRead($PatInp)
					_Pattern()
					IniWrite($Ini, "General", "Pattern", $Pattern)
				EndIf
				
				If GUICtrlRead($chAutostart) = 1 Then
					$AutoStart = 1
				Else
					$AutoStart = 0
				EndIf
				IniWrite($Ini, "General", "AutoStart", $AutoStart)
				_Autostart()
				
				If GUICtrlRead($chCapsLock) = 1 Then
					$CapsLock = 1
				Else
					$CapsLock = 0
				EndIf
				IniWrite($Ini, "General", "CapsLock", $CapsLock)
				
				For $i = 1 To 8
					$aHotkey = _GuiCtrlHotKey_GetHotkey($HotkeyInput[$i])
					If IsArray($aHotkey) Then
						$tmp = _WinAPI_MakeLong($aHotkey[0], $aHotkey[1])
						If $HotkeyCode[$i] <> $tmp Then
							If _GuiCtrlHotKey_RegisterHotkey($hGui, $HotkeyID[$i], $aHotkey[0], $aHotkey[1]) Then
								$HotkeyCode[$i] = $tmp
								IniWrite($Ini, "HotKey", "HotKey" & $i, $HotkeyCode[$i])
							Else
								MsgBox(0, $LngMs1, $LngMs2 & _GetKey($tmp) & ',' & @LF & $LngMs3, 0, $hGui1)
								$HotkeyCode[$i] = 0
							EndIf
						EndIf
					Else
						_GuiCtrlHotKey_UnregisterHotkey($hGui, $HotkeyID[$i])
						IniWrite($Ini, "HotKey", "HotKey" & $i, 0)
						$HotkeyCode[$i] = 0
					EndIf
				Next
				ContinueCase
			Case -3
				For $i = 1 To 8
					_WinAPI_DestroyWindow($HotkeyInput[$i])
				Next
				GUIDelete($hGui1)
				Opt("TrayIconHide", 0)
				_IconTrey()
				GUIRegisterMsg($WM_HOTKEY, "WM_HOTKEY")
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func WM_HOTKEY($hWnd, $Msg, $wParam, $lParam)
	Switch BitAND($wParam, 0xFFFF)
		Case $HotkeyID[1]
			_Re("^+{LEFT}")
		Case $HotkeyID[2]
			_Re("+{HOME}", 1)
		Case $HotkeyID[3]
			_Re("+{HOME}", 5)
		Case $HotkeyID[4]
			_Re("^+{LEFT}", 1)
		Case $HotkeyID[5]
			_Re("^+{LEFT}", 4)
		Case $HotkeyID[6]
			_Re("^+{LEFT}", 2)
		Case $HotkeyID[7]
			_Re("^+{LEFT}", 3)
		Case $HotkeyID[8]
			If $LangTmp = $LangTmp2 Then
				$Temp1 = $Ru
				$Temp2 = $RuT
				$Temp3 = $LangR2
				$Ru = $Uk
				$RuT = $UkT
				$LangR2 = $LangR3
				$LangTmp = $LangR3
			Else
				$Ru = $Temp1
				$RuT = $Temp2
				$LangR2 = $Temp3
				$LangTmp = $LangR2
			EndIf
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc

; восстановление иконки после вызова пунктов в трее
Func _IconTrey()
	$L1 = GetActiveKeyboardLayout(WinGetHandle(''))
	If Not $L1 Then $L1 = @KBLayout
	Switch $L1
		Case $LangN1
			_Tray_SetHIcon($hEn)
		Case $LangN2
			_Tray_SetHIcon($hRu)
		Case $LangN3
			_Tray_SetHIcon($hUk)
		Case Else
			_Tray_SetHIcon($hHz)
	EndSwitch
EndFunc

Func _Autostart()
	$filename = StringRegExpReplace(@ScriptName, '^(.*)\.(.*)$', '\1')
	If $AutoStart = 1 Then
		If Not FileExists(@StartupDir & '\' & $filename & '.lnk') Then FileCreateShortcut(@ScriptFullPath, @StartupDir & '\' & $filename & '.lnk')
		;RegWrite("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", "TextCorrection", "REG_SZ", '"'&@AutoItExe&'"')
	Else
		If FileExists(@StartupDir & '\' & $filename & '.lnk') Then FileDelete(@StartupDir & '\' & $filename & '.lnk')
		;RegDelete("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", "TextCorrection")
	EndIf
EndFunc

Func _Readme()
	Opt("TrayIconHide", 1)
	$hGui1 = GUICreate($LngRdm1, 370, 200, -1, -1, BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $hGui)
	GUISetIcon($sPathIcon)
	GUICtrlCreateLabel($LngRdm2, 10, 10, 350, 160)
	GUICtrlCreateLabel($LngRdm3, 10, 80, 250, 51)
	
	For $i = 1 To 3
		$tmp = RegRead("HKCU\Keyboard Layout\Preload", $i)
		If @error Then ExitLoop
		GUICtrlCreateLabel('', 10, 113 + $i*17, 250, 17)
		GUICtrlSetData(-1, 'Lang'&$i&': ' & $tmp & ' , ' & Dec($tmp))
	Next

	GUISetState(@SW_SHOW, $hGui1)
	Do
	Until GUIGetMsg() = -3
	GUIDelete($hGui1)
	Opt("TrayIconHide", 0)
	_IconTrey()
EndFunc

Func _About()
	Opt("TrayIconHide", 1)
	$font = "Arial"
	$Gui1 = GUICreate($LngAbout, 270, 180, -1, -1, BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP))
	GUISetIcon($sPathIcon)
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 15, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 268, 1, 0x10)
	
	GUISetFont(9, 600, -1, $font)

	GUICtrlCreateLabel($LngVer & ' 0.8  2012.09.02', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 55, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2012', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
	; GUISwitch($Gui1)
	While 1
		Switch GUIGetMsg()
			Case $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $WbMn
				ClipPut('R939163939152')
			Case -3
				GUIDelete($Gui1)
				Opt("TrayIconHide", 0)
				_IconTrey()
				ExitLoop
		EndSwitch
	WEnd
EndFunc