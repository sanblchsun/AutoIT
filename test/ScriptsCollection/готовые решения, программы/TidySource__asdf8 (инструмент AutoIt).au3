#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Fileversion=1.2.2.0
#AutoIt3Wrapper_Run_After=del "%scriptfile%_Obfuscated.au3"
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------
AutoIt Version: 3.3.7.14

#ce ----------------------------------------------------------------------------

#NoTrayIcon

#Region    ;************ Includes ************
#Include <WindowsConstants.au3>
#Include <GUIConstantsEx.au3>
#Include <EditConstants.au3>
#Include <ButtonConstants.au3>
#Include <WinAPI.au3>
#Include <Array.au3>
#Include <File.au3>
#EndRegion ;************ Includes ************

#Region Lang
$Lng_1 = 'Select file'
$Lng_2 = '-> Full processing'
$Lng_3 = '-> Partial processing (under incomplete selection of the logical block, possible wrong formatting)'
$Lng_4 = '--- -> List of variables :'
$Lng_5 = "Tidy function names"
$Lng_6 = "Do not change"
$Lng_7 = 'On samples from files "au3*.api"'
$Lng_8 = 'Use custom rules and files "au3*.api"'
$Lng_9 = "Tidy variable names"
$Lng_10 = "Use custom rules"
$Lng_11 = "Other"
$Lng_12 = "No more than one blank line"
$Lng_13 = "Tidy whitespace"
$Lng_14 = "- tabs after line break   _"
$Lng_15 = "Save backup"
$Lng_16 = "Cancel"
$Lng_17 = "Help"
$Lng_18 = "Edit custom rules"
$Lng_19 = "  Custom rules"
$Lng_20 = "Save"
$Lng_21 = 'ALT+1 - Upper Case'
$Lng_22 = 'ALT+2 - Lower Case'
$Lng_23 = 'ALT+3 - First letter upper case'
$Lng_24 = 'ALT+4 - add words beginning with capital letters from clipboard'
$Lng_25 = 'Warning'
$Lng_26 = 'No custom rules'
$Lng_27 = '> Processing empty lines'
$Lng_28 = '> Not processing empty lines'
$Lng_29 = '> Processing function names'
$Lng_30 = '> Not processing functions names'
$Lng_31 = '> Processing variable names'
$Lng_32 = '> Not processing variable names'
$Lng_33 = '> Processing whitespace'
$Lng_34 = '> Not processing whitespace'
$Lng_35 = '> Processing indentations'
$Lng_36 = 'Line('
$Lng_37 = ') : ERROR: wrong formatting'
$Lng_38 = '> Not processing indentations'
$Lng_39 = '-> Ready'
$Lng_40 = '!> Error pasting text into editor'
$Lng_41 = '!> Failed to start editor'
$Lng_42 = '!> !> Error - not found files "au3*.api"'
$Lng_43 = '-> Save backup "'
$Lng_44 = '!> ERROR - processing is not completed'
$Lng_hlp = '<html><head><meta http-equiv="Content-Language" content="en"><meta http-equiv="Content-Type" content="text/html; charset=windows-1251"><title>Help</title></head><body><table border="1" width="100%" bgcolor="#F2F0E3" style="border-collapse: collapse"><tr><td><p style="margin-left: 15px; margin-top: 25px; margin-right:40px" align="right"><i><font size="5" color="#800000"><b>TIDY SOURCE</b></font></i></p><p style="margin-left: 15px; margin-top: 0px"><b><font size="4" color="#000080">Command line options:</font></b></p><ul><li><font color="#800000"><b>/h</b></font> or <font color="#800000"><b>/help</b></font> or <font color="#800000"><b>/?</b></font> - launch help</li><li><b><font color="#800000">/NoGui</font>&nbsp; </b>- do not show the preferences window</li><li><b><font color="#800000">/BackUp</font> </b>- save a backup copy of the file</li><li><b><font color="#800000">/f</font> </b>- parameters processing names of functions</li> <ul><li><font color="#800000"><b>/f0</b></font> - <i>not processing functions names</i></li><li><font color="#800000"><b>/f1</b></font> - <i>on samples from the files</i> &quot;au3*.api&quot;<i> (by default)</i></li><li><font color="#800000"><b>/f2</b></font> - <i>processing for custom rules and on samples from the files</i> &quot;au3*.api&quot;</li></ul><li><font color="#800000"><b>/v</b></font> - parameters processing names of variables</li> <ul><li><font color="#800000"><b>/v0</b></font> - <i>not processing variable names (by default)</i></li><li><font color="#800000"><b>/v1</b></font> - <i>processing for custom rules</i></li></ul><li><font color="#800000"><b>/s</b></font> - processing whitespace</li> <ul><li><font color="#800000"><b>/s0</b></font> - <i>not processing</i></li><li><font color="#800000"><b>/s1</b></font> - <i>processing (by default)</i></li></ul><li><font color="#800000"><b>/l</b></font> - no more than one blank line</li> <ul><li><font color="#800000"><b>/l0</b></font> - <i>not processing</i></li><li><font color="#800000"><b>/l1</b></font> - <i>processing (by default)</i></li></ul><li><font color="#800000"><b>/b0-9</b></font> - tabs after line break _ (by default <b>2</b>)</li></ul><p style="margin-left: 15px"><b><font size="4" color="#000080">Example of connection to SciTE (file &quot;au3.properties&quot;)</font></b></p><div align="center"><table border="1" width="94%" style="border-collapse: collapse" bgcolor="#FFFFFF"><tr><td>command.9.*.au3=&quot;$(autoit3dir)\autoit3.exe&quot; &quot;$(SciteDefaultHome)\TidySource\TidySource.au3&quot; &quot;$(FilePath)&quot; /NoGui /BackUp<br>command.name.9.*.au3=Tidy AutoIt Source <br>command.save.before.9.*.au3=1<br>command.shortcut.9.*.au3=Ctrl+T</td></tr></table><p>&nbsp;</div></td></tr></table></body></html>'

$UserIntLang = DllCall("kernel32.dll", "int", "GetUserDefaultUILanguage")
If Not @Error Then $UserIntLang = Hex($UserIntLang[0], 4)

If $UserIntLang = 0419 Then ;rus
	$Lng_1 = 'Выбрать файл'
	$Lng_2 = '-> Полная обработка'
	$Lng_3 = '-> Обработка выделенного (при неполном выделении логического блока, возможны ошибки форматирования)'
	$Lng_4 = '--- -> Список переменных :'
	$Lng_5 = "Обработка имен функций"
	$Lng_6 = "Не обрабатывать"
	$Lng_7 = 'Из файлов "au3*.api"'
	$Lng_8 = 'Из файлов "au3*.api" и использовать правила'
	$Lng_9 = "Обработка имен переменных"
	$Lng_10 = "Использовать правила"
	$Lng_11 = "Разное"
	$Lng_12 = "Не более одной пустой строки подряд"
	$Lng_13 = "Обрабатывать пробелы в коде"
	$Lng_14 = "- табов после переноса строки _"
	$Lng_15 = "Сохранить резервную копию"
	$Lng_16 = "Отмена"
	$Lng_17 = "Справка"
	$Lng_18 = "Редактировать правила"
	$Lng_19 = "  Правила замены"
	$Lng_20 = "Сохранить"
	$Lng_21 = 'ALT+1 - ПРОПИСНЫЕ'
	$Lng_22 = 'ALT+2 - строчные'
	$Lng_23 = 'ALT+3 - Первая буква заглавная'
	$Lng_24 = 'ALT+4 - добавить слова с заглавной буквы из буфера обмена'
	$Lng_25 = 'Предупреждение'
	$Lng_26 = 'Правила отсутствуют'
	$Lng_27 = '> Обработка пустых строк'
	$Lng_28 = '> Пустые строки не обрабатываются'
	$Lng_29 = '> Обработка имен функций'
	$Lng_30 = '> Имена функций не обрабатываются'
	$Lng_31 = '> Обработка имен переменных'
	$Lng_32 = '> Имена переменных не обрабатываются'
	$Lng_33 = '> Обработка пробелов в коде'
	$Lng_34 = '> Пробелы в коде не обрабатываются'
	$Lng_35 = '> Обработка отступов'
	$Lng_36 = 'Строка('
	$Lng_37 = ') : ОШИБКА: неправильный отступ'
	$Lng_38 = '> Отсупы не обрабатываются'
	$Lng_39 = '-> Готово'
	$Lng_40 = '!> Ошибка вставки текста в редактор'
	$Lng_41 = '!> Ошибка запуска редактора'
	$Lng_42 = '!> Ошибка - не найдены файлы "au3*.api"'
	$Lng_43 = '-> Сохранена резервная копия "'
	$Lng_44 = '!> ОШИБКА - обработка не завершена'
	$Lng_hlp = '<html><head><meta http-equiv="Content-Language" content="ru"><meta http-equiv="Content-Type" content="text/html; charset=windows-1251"><title>Справка</title></head><body><table border="1" width="100%" bgcolor="#F2F0E3" style="border-collapse: collapse"><tr><td><p style="margin-left: 15px; margin-top: 25px; margin-right:40px" align="right"><i><font size="5" color="#800000"><b>TIDY SOURCE</b></font></i></p><p style="margin-left: 15px; margin-top: 0px"><b><font size="4" color="#000080">Параметры командной строки:</font></b></p><ul><li><font color="#800000"><b>/h</b></font> или <font color="#800000"><b>/help</b></font> или <font color="#800000"><b>/?</b></font> - вызов справки</li><li><b><font color="#800000">/NoGui</font>&nbsp; </b>- не показывать окно настроек</li><li><b><font color="#800000">/BackUp</font> </b>- сохранять резервную копию обрабатываемого файла</li><li><b><font color="#800000">/f</font> </b>- параметры обработки имен функций</li> <ul><li><font color="#800000"><b>/f0</b></font> - <i>не обрабатывать имена функции</i></li><li><font color="#800000"><b>/f1</b></font> - <i>по образцам из файлов</i> &quot;au3*.api&quot;<i> (по умолчанию)</i></li><li><font color="#800000"><b>/f2</b></font> - <i>по пользовательским правилам и по образцам из файлов</i> &quot;au3*.api&quot;</li></ul><li><font color="#800000"><b>/v</b></font> - параметры обработки имен переменных</li> <ul><li><font color="#800000"><b>/v0</b></font> - <i>не обрабатывать имена переменных (по умолчанию)</i></li><li><font color="#800000"><b>/v1</b></font> - <i>обрабатывать по пользовательским правилам</i></li></ul><li><font color="#800000"><b>/s</b></font> - обработка пробелов в коде</li> <ul><li><font color="#800000"><b>/s0</b></font> - <i>не обрабатывать</i></li><li><font color="#800000"><b>/s1</b></font> - <i>обрабатывать (по умолчанию)</i></li></ul><li><font color="#800000"><b>/l</b></font> - не более одной пустой строки подряд</li> <ul><li><font color="#800000"><b>/l0</b></font> - <i>не обрабатывать</i></li><li><font color="#800000"><b>/l1</b></font> - <i>обрабатывать (по умолчанию)</i></li></ul><li><font color="#800000"><b>/b0-9</b></font> - табов после переноса строки _ (по умолчанию <b>2</b>)</li></ul><p style="margin-left: 15px"><b><font size="4" color="#000080">Пример подключения к SciTE (файл &quot;au3.properties&quot;)</font></b></p><div align="center"><table border="1" width="94%" style="border-collapse: collapse" bgcolor="#FFFFFF"><tr><td>command.9.*.au3=&quot;$(autoit3dir)\autoit3.exe&quot; &quot;$(SciteDefaultHome)\TidySource\TidySource.au3&quot; &quot;$(FilePath)&quot; /NoGui /BackUp<br>command.name.9.*.au3=Tidy AutoIt Source <br>command.save.before.9.*.au3=1<br>command.shortcut.9.*.au3=Ctrl+T</td></tr></table><p>&nbsp;</div></td></tr></table></body></html>'
EndIf
#EndRegion Lang

Global $iPart, $aMask, $aComment, $sFile, $iShowGui, $iBackUp = 0
Global $hSciTE, $hCtrl1, $hCtrl2, $pathSciTE
Global $sAPI, $aVAR, $sVAR, $aBlockComment[100]
Global $iModeFuncProc = 1, $iModeVarProc = 2, $iModeAddShift = 2, $iModeSpaceProc = 1, $iModeEmtyLineProc = 1
Global $aRules, $iStartLine = 0

#Region get param
If StringRegExp($CmdLineRaw, '(?i)/(help|h|\?)') Then
	_Help()
	Exit
EndIf

If $CmdLine[0] > 0 Then
	For $i = 0 To $CmdLine[0]
		If $CmdLine[$i] And FileExists($CmdLine[$i]) And StringRegExp($CmdLine[$i], '(?i)\.au3$') Then
			$sFile = $CmdLine[$i]
			ExitLoop
		EndIf
	Next
EndIf

If $sFile Then
	If ProcessExists('AutoIt3Wrapper.exe') Then Exit
Else
	$sFile = FileOpenDialog('TIDY SOURCE :: ' & $Lng_1, "", 'Script files (*.au3)', 3)
EndIf

If StringInStr($CmdLineRaw, '/NoGui') Then
	$iShowGui = 0
Else
	$iShowGui = 1
EndIf

If StringRegExp($CmdLineRaw, '(?i)/BackUp') Then $iBackUp = 1

$aTmp = StringRegExp($CmdLineRaw, '(?i)/f([0-2])', 3)
If IsArray($aTmp) Then $iModeFuncProc = Number($aTmp[0])
$aTmp = StringRegExp($CmdLineRaw, '(?i)/v([0-1])', 3)
If IsArray($aTmp) Then $iModeVarProc = Number($aTmp[0])
$aTmp = StringRegExp($CmdLineRaw, '(?i)/s([0-1])', 3)
If IsArray($aTmp) Then $iModeSpaceProc = Number($aTmp[0])
$aTmp = StringRegExp($CmdLineRaw, '(?i)/l([0-1])', 3)
If IsArray($aTmp) Then $iModeEmtyLineProc = Number($aTmp[0])
$aTmp = StringRegExp($CmdLineRaw, '(?i)/b([0-9])', 3)
If IsArray($aTmp) Then $iModeAddShift = Number($aTmp[0])

$hSciTE = WinGetHandle('[Class:SciTEWindow]')
If $hSciTE And StringInStr(WinGetTitle($hSciTE), StringRegExpReplace($sFile, '.+\\(.+)', '\1')) And StringInStr(WinGetTitle($hSciTE), StringRegExpReplace($sFile, '(.+)\\.+', '\1')) Then
	$hCtrl1 = ControlGetHandle($hSciTE, '', '[CLASS:Scintilla; INSTANCE:1]')
	$hCtrl2 = ControlGetHandle($hSciTE, '', '[CLASS:Scintilla; INSTANCE:2]')
	$pathSciTE = _WinAPI_GetProcessFileName(WinGetProcess($hSciTE))
	$curPos = _GetCurPos()
Else
	$hSciTE = 0
	$pathSciTE = RegRead('HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\App Paths\SciTE.exe', '')
	If Not $pathSciTE Or Not FileExists($pathSciTE) Then $pathSciTE = ''
	Dim $curPos[2]
EndIf

If $pathSciTE And StringInStr($pathSciTE, '\SciTE.exe') Then
	$pathSciTE = StringRegExpReplace($pathSciTE, '(.+\\).+', '\1')
EndIf

_ConsoleWrite('> TIDY SOURCE :: ' & $sFile & @CRLF, 1)

If $hSciTE Then
	$str = _GetText(1)
	If StringRegExpReplace($str, '[ \t]+', '') = '' Then
		_ConsoleWrite($Lng_2 & @CRLF)
		$iPart = 0
		$str = FileRead($sFile)
	Else
		_ConsoleWrite($Lng_3 & @CRLF)
		$iPart = 1
		$sTmp = StringLeft(FileRead($sFile), $curPos[0])
		$aTmp = StringRegExp($sTmp, @CRLF, 3)
		If IsArray($aTmp) Then $iStartLine = UBound($aTmp)
		$sTmp = StringRegExpReplace($sTmp, '(?s)^.*[\r\n]', '')
		$curPos[0] -= StringLen($sTmp)
		_SetCurPos($curPos[0], $curPos[1])
		$str = _GetText(1)
		If Not StringRegExp($str, '[\r\n]$') Then $iPart = 2
	EndIf
Else
	_ConsoleWrite($Lng_2 & @CRLF)
	$iPart = 0
	$str = FileRead($sFile)
EndIf

If $hSciTE And $iShowGui Then
	$sTmp = _DelComment($str, 1)
	$sVAR = ''
	$aVAR = StringRegExp($sTmp, '(?i)(\$[0-9a-z_]+)', 3)
	$aVAR = _ArProc($aVAR)
	If IsArray($aVAR) Then
		For $i = 0 To UBound($aVAR) - 1
			If StringLower($aVAR[$i]) <> '$CmdLine' And StringLower($aVAR[$i]) <> '$CmdLineRaw' Then
				$sVAR &= $aVAR[$i] & ' '
			EndIf
		Next
		_ConsoleWrite($Lng_4 & @CRLF)
		_ConsoleWrite($sVAR & @CRLF)
	EndIf
EndIf
#EndRegion get param
$sOut = $str
$sForTest = StringStripWS($str, 8)

If $iShowGui Then
	#Region ### START Koda GUI section ###
	$hForm = GUICreate("  TIDY SOURCE :: ", 335, 413, -1, -1, 0, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
	GUISetFont(10, 400, 0, "Arial")
	GUISetBkColor(0xF3F3F3)
	GUICtrlCreateGroup($Lng_5, 8, 8, 313, 93)
	GUICtrlSetColor(-1, 0x0000FF)
	$Radio_f0 = GUICtrlCreateRadio($Lng_6, 20, 28, 293, 17)
	$Radio_f1 = GUICtrlCreateRadio($Lng_7, 20, 52, 293, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$Radio_f2 = GUICtrlCreateRadio($Lng_8, 20, 76, 293, 17)
	Switch $iModeFuncProc
		Case 0
			GUICtrlSetState($Radio_f0, $GUI_CHECKED)
		Case 1
			GUICtrlSetState($Radio_f1, $GUI_CHECKED)
		Case 2
			GUICtrlSetState($Radio_f2, $GUI_CHECKED)
	EndSwitch
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup($Lng_9, 8, 112, 313, 77)
	$Radio_v0 = GUICtrlCreateRadio($Lng_6, 20, 136, 293, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$Radio_v1 = GUICtrlCreateRadio($Lng_10, 20, 160, 293, 17)
	Switch $iModeVarProc
		Case 0
			GUICtrlSetState($Radio_v0, $GUI_CHECKED)
		Case 1
			GUICtrlSetState($Radio_v1, $GUI_CHECKED)
	EndSwitch
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlCreateGroup($Lng_11, 8, 200, 313, 133)
	$CheckboxES = GUICtrlCreateCheckbox($Lng_12, 20, 220, 293, 17)
	If $iModeEmtyLineProc Then GUICtrlSetState($CheckboxES, $GUI_CHECKED)
	$CheckboxPS = GUICtrlCreateCheckbox($Lng_13, 20, 244, 293, 17)
	If $iModeSpaceProc Then GUICtrlSetState($CheckboxPS, $GUI_CHECKED)
	$InputTab = GUICtrlCreateInput($iModeAddShift, 20, 272, 25, 24, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
	GUICtrlSetLimit(-1, 1)
	GUICtrlCreateLabel($Lng_14, 52, 272, 264, 17)
	$CheckboxBU = GUICtrlCreateCheckbox($Lng_15, 20, 304, 293, 17)
	If $iBackUp Then GUICtrlSetState($CheckboxBU, $GUI_CHECKED)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$ButtonOk = GUICtrlCreateButton("Ok", 144, 348, 75, 25, $BS_DEFPUSHBUTTON)
	$ButtonCancel = GUICtrlCreateButton($Lng_16, 236, 348, 75, 25)
	GUICtrlCreateIcon('shell32.dll', -211, 13, 352, 16, 16)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$ButtonHelp = GUICtrlCreateButton("", 8, 348, 27, 25, $WS_CLIPSIBLINGS)
	GUICtrlSetTip(-1, $Lng_17)
	GUICtrlCreateIcon('shell32.dll', -2, 50, 352, 16, 16)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$ButtonEdit = GUICtrlCreateButton("", 44, 348, 27, 25, $WS_CLIPSIBLINGS)
	GUICtrlSetTip(-1, $Lng_18)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###
	$begin = -1
	
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $ButtonCancel
				Exit
			Case $ButtonHelp
				_Help()
			Case $ButtonOk
				If BitAND(GUICtrlRead($Radio_f0), $GUI_CHECKED) Then $iModeFuncProc = 0
				If BitAND(GUICtrlRead($Radio_f1), $GUI_CHECKED) Then $iModeFuncProc = 1
				If BitAND(GUICtrlRead($Radio_f2), $GUI_CHECKED) Then $iModeFuncProc = 2
				If BitAND(GUICtrlRead($Radio_v0), $GUI_CHECKED) Then $iModeVarProc = 0
				If BitAND(GUICtrlRead($Radio_v1), $GUI_CHECKED) Then $iModeVarProc = 1
				If BitAND(GUICtrlRead($CheckboxES), $GUI_CHECKED) Then
					$iModeEmtyLineProc = 1
				Else
					$iModeEmtyLineProc = 0
				EndIf
				If BitAND(GUICtrlRead($CheckboxPS), $GUI_CHECKED) Then
					$iModeSpaceProc = 1
				Else
					$iModeSpaceProc = 0
				EndIf
				$iModeAddShift = Number(GUICtrlRead($InputTab))
				If $iModeAddShift < 0 Then $iModeAddShift = 0
				If $iModeAddShift > 9 Then $iModeAddShift = 9
				If BitAND(GUICtrlRead($CheckboxBU), $GUI_CHECKED) Then
					$iBackUp = 1
				Else
					$iBackUp = 0
				EndIf
				GUIDelete($hForm)
				ExitLoop
			Case $ButtonEdit
				GUISetState(@SW_HIDE, $hForm)
				$hFormEdit = GUICreate($Lng_19, 335, 413, -1, -1, 0, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
				GUISetBkColor(0xF3F3F3)
				$Button_Save = GUICtrlCreateButton($Lng_20, 152, 348, 79, 25, $BS_DEFPUSHBUTTON)
				$Button_Cancel = GUICtrlCreateButton($Lng_16, 240, 348, 75, 25)
				$Edit = GUICtrlCreateEdit("", 8, 8, 313, 325, BitOR($ES_NOHIDESEL,$ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN, $WS_VSCROLL))
				$hEdit = GUICtrlGetHandle($Edit)
				_SendMessage($hEdit, $EM_SETLIMITTEXT, 1058000)
				If FileExists(@ScriptDir & '\TidySourceRules.dat') Then
					$sTmp = FileRead(@ScriptDir & '\TidySourceRules.dat')
					$aTmp = StringRegExp($sTmp, '(?i)([a-z0-9_#$]+)', 3)
					$aTmp = _ArProc($aTmp)
					If IsArray($aTmp) Then
						$sTmp = ''
						For $i = 0 To UBound($aTmp) -1
							$sTmp &= $aTmp[$i] & @CRLF
						Next
						GUICtrlSetData($Edit, $sTmp)
					EndIf
				Else
					_GetApiInfo()
					If $sAPI Then
						$aTmp = StringRegExp($sAPI, '[A-Z][a-z]+', 3)
						$aTmp = _ArProc($aTmp)
						If IsArray($aTmp) Then
							$sTmp = ''
							For $i = 0 To UBound($aTmp) -1
								$sTmp &= $aTmp[$i] & @CRLF
							Next
							GUICtrlSetData($Edit, $sTmp)
						EndIf
					EndIf
				EndIf
				GUICtrlSetFont(-1, 11, 400, 0, "Courier New")
				GUICtrlSetColor(-1, 0x800000)
				GUICtrlCreateIcon('shell32.dll', -74, 21, 352, 16, 16)
				GUICtrlSetState(-1, $Gui_Disable)
				$Selected_UCase = GUICtrlCreateButton("", 16, 348, 27, 25, $WS_ClipSiblingS)
				GUICtrlSetTip(-1, $Lng_21)
				GUICtrlCreateIcon('shell32.dll', -76, 49, 352, 16, 16)
				GUICtrlSetState(-1, $Gui_Disable)
				$Selected_LCase = GUICtrlCreateButton("", 44, 348, 27, 25, $WS_ClipSiblingS)
				GUICtrlSetTip(-1, $Lng_22)
				GUICtrlCreateIcon('shell32.dll', -75, 77, 352, 16, 16)
				GUICtrlSetState(-1, $Gui_Disable)
				$Selected_FirstUp = GUICtrlCreateButton("", 72, 348, 27, 25, $WS_ClipSiblingS)
				GUICtrlSetTip(-1, $Lng_23)
				GUICtrlCreateIcon('shell32.dll', -71, 105, 352, 16, 16)
				GUICtrlSetState(-1, $Gui_Disable)
				$add_ClipBoard = GUICtrlCreateButton("", 100, 348, 27, 25, $WS_ClipSiblingS)
				GUICtrlSetTip(-1, $Lng_24)
				GUISetState(@SW_SHOW)
				
				Dim $AccelKeys[3][2] = [["!1", $Selected_UCase], ["!2", $Selected_LCase], ["!3", $Selected_FirstUp]]
				GUISetAccelerators($AccelKeys, $hFormEdit)
				
				While 1
					$nMsg = GUIGetMsg()
					Switch $nMsg
						Case $Button_Cancel
							GUIDelete($hFormEdit)
							GUISetState(@SW_SHOW, $hForm)
							ExitLoop
						Case $Button_Save
							$sTmp = GUICtrlRead($Edit)
							GUISetState(@SW_DISABLE, $hFormEdit)
							$aTmp = StringRegExp($sTmp, '(?i)([a-z0-9_#$]+)', 3)
							$aRules = _ArProc($aTmp, 1)
							If IsArray($aRules) Then
								$sTmp = ''
								For $i = 0 To UBound($aRules) -1
									$sTmp &= $aRules[$i] & Chr(7)
								Next
								$file = FileOpen(@ScriptDir & '\TidySourceRules.dat', 2)
								FileWrite($file, $sTmp)
								FileClose($file)
							EndIf
							GUIDelete($hFormEdit)
							GUISetState(@SW_SHOW, $hForm)
							ExitLoop
						Case $selected_UCase
							$sEdit = GUICtrlRead($Edit)
							If $sEdit Then
								$wparam = DllStructCreate("uint Start")
								$lparam = DllStructCreate("uint End")
								_SendMessage($hEdit, $EM_GETSEL, DllStructGetPtr($wparam), DllStructGetPtr($lparam), 0, "ptr", "ptr")
								$posStart = DllStructGetData($wparam, "Start")
								$posEnd = DllStructGetData($lparam, "End")
								If $posStart <> $posEnd Then
									$tmp = StringMid($sEdit, $posStart + 1, $posEnd - $posStart)
									$tmp = StringUpper($tmp)
									_SendMessage($hEdit, $EM_REPLACESEL, True, $tmp, 0, "wparam", "wstr")
									GUICtrlSetState($Edit, $GUI_FOCUS)
									_SendMessage($hEdit, $EM_SETSEL, $posStart, $posEnd)
								EndIf
							EndIf
						Case $selected_LCase
							$sEdit = GUICtrlRead($Edit)
							If $sEdit Then
								$wparam = DllStructCreate("uint Start")
								$lparam = DllStructCreate("uint End")
								_SendMessage($hEdit, $EM_GETSEL, DllStructGetPtr($wparam), DllStructGetPtr($lparam), 0, "ptr", "ptr")
								$posStart = DllStructGetData($wparam, "Start")
								$posEnd = DllStructGetData($lparam, "End")
								If $posStart <> $posEnd Then
									$tmp = StringMid($sEdit, $posStart + 1, $posEnd - $posStart)
									$tmp = StringLower($tmp)
									_SendMessage($hEdit, $EM_REPLACESEL, True, $tmp, 0, "wparam", "wstr")
									GUICtrlSetState($Edit, $GUI_FOCUS)
									_SendMessage($hEdit, $EM_SETSEL, $posStart, $posEnd)
								EndIf
							EndIf
						Case $selected_FirstUp
							$sEdit = GUICtrlRead($Edit)
							If $sEdit Then
								$wparam = DllStructCreate("uint Start")
								$lparam = DllStructCreate("uint End")
								_SendMessage($hEdit, $EM_GETSEL, DllStructGetPtr($wparam), DllStructGetPtr($lparam), 0, "ptr", "ptr")
								$posStart = DllStructGetData($wparam, "Start")
								$posEnd = DllStructGetData($lparam, "End")
								If $posStart <> $posEnd Then
									$tmp = StringMid($sEdit, $posStart + 1, $posEnd - $posStart)
									$tmp = StringLower($tmp)
									$aTmp = StringRegExp($tmp, '(?s).', 3)
									$tmp = ''
									For $i = 0 To UBound($aTmp) - 1
										If $i Then
											If StringRegExp($aTmp[$i - 1], '(?i)[a-z]') Then
												$tmp &= $aTmp[$i]
											Else
												$tmp &= StringUpper($aTmp[$i])
											EndIf
										Else
											$tmp &= StringUpper($aTmp[$i])
										EndIf
									Next
									_SendMessage($hEdit, $EM_REPLACESEL, True, $tmp, 0, "wparam", "wstr")
									GUICtrlSetState($Edit, $GUI_FOCUS)
									_SendMessage($hEdit, $EM_SETSEL, $posStart, $posEnd)
								EndIf
							EndIf
						Case $add_ClipBoard
							$tmp = ClipGet()
							If $tmp Then
								$aTmp = StringRegExp($tmp, '[A-Z][a-z]+', 3)
								$aTmp = _ArProc($aTmp)
								If IsArray($aTmp) Then
									$tmp = ''
									For $i = 0 To UBound($aTmp) -1
										$tmp &= $aTmp[$i] & @CRLF
									Next
									_SendMessage($hEdit, $EM_SETSEL, 0, 0)
									_SendMessage($hEdit, $EM_ReplaceSel, True, $tmp, 0, "wparam", "wstr")
									GUICtrlSetState($Edit, $GUI_FOCUS)
									_SendMessage($hEdit, $EM_SetSel, 0, StringLen($tmp) - 2)
								EndIf
							EndIf
					EndSwitch
				WEnd
		EndSwitch
		If $begin = -1 Then
			Select
				Case BitAND(GUICtrlRead($Radio_f2), $GUI_CHECKED)
					$begin = 0
					If Not FileExists(@ScriptDir & '\TidySourceRules.dat') Then
						Do
							$pos = WinGetPos(GUICtrlGetHandle($Radio_f2))
							Sleep(20)
						Until IsArray($pos)
						ToolTip($Lng_26, $pos[0], $pos[1], $Lng_25, 2, 1)
						$begin = TimerInit()
					EndIf
				Case BitAND(GUICtrlRead($Radio_v1), $GUI_CHECKED)
					$begin = 0
					If Not FileExists(@ScriptDir & '\TidySourceRules.dat') Then
						Do
							$pos = WinGetPos(GUICtrlGetHandle($Radio_v1))
							Sleep(20)
						Until IsArray($pos)
						ToolTip($Lng_26, $pos[0], $pos[1], $Lng_25, 2, 1)
						$begin = TimerInit()
					EndIf
			EndSelect
		EndIf
		If $begin > 0 And TimerDiff($begin) > 4000 Then
			$begin = 0
			ToolTip('')
		EndIf
	WEnd
	If $begin > 0 Then ToolTip('')
EndIf

If StringRegExp($sOut, '[\r\n]') Then ;block comment
	If $iModeEmtyLineProc Then
		_ConsoleWrite($Lng_27 & @CRLF)
		$sOut = StringRegExpReplace($sOut, '(?<=^|[\r\n])([ \t]*\r\n){2,}', @CRLF)
	Else
		_ConsoleWrite($Lng_28 & @CRLF)
	EndIf
	$aTmp = _StrigToArray($sOut)
	If IsArray($aTmp) Then
		$sOut = ''
		$iComment = 0
		$sComment = ''
		For $i = 0 To UBound($aTmp) - 1
			If $iComment Then
				If StringRegExp($aTmp[$i], '(?i)^[ \t]*#(cs|comments-start)') Then
					$iComment += 1
					$sComment &= StringStripWS($aTmp[$i], 2) & @CRLF
				ElseIf StringRegExp($aTmp[$i], '(?i)^[ \t]*#(ce|comments-end)') Then
					$iComment -= 1
					If $i = UBound($aTmp) - 1 Then
						$sComment &= StringStripWS($aTmp[$i], 2)
					Else
						$sComment &= StringStripWS($aTmp[$i], 2) & @CRLF
					EndIf
					If $iComment = 0 Then
						$aBlockComment[0] += 1
						If UBound($aBlockComment) <= $aBlockComment[0] Then ReDim $aBlockComment[2 * UBound($aBlockComment)]
						$aBlockComment[$aBlockComment[0]] = $sComment
						$sOut &= Chr(3) & $aBlockComment[0] & Chr(3) & @CRLF
						$sComment = ''
					EndIf
				Else
					$sComment &= StringStripWS($aTmp[$i], 2) & @CRLF
				EndIf
			Else
				If StringRegExp($aTmp[$i], '(?i)^[ \t]*#(cs|comments-start)') Then
					$iComment = 1
					$sComment = StringStripWS($aTmp[$i], 2) & @CRLF
				Else
					If $i And StringRegExp($aTmp[$i], '(?i)^[ \t]*Func[ \t]+') Then
						If Not StringRegExp($aTmp[$i - 1], '(?i)^([ \t]*$|[ \t]*EndFunc)') Then
							$aTmp[$i] = @CRLF & $aTmp[$i]
						EndIf
					EndIf
					If $i < UBound($aTmp) - 1 And StringRegExp($aTmp[$i], '(?i)^[ \t]*EndFunc[^a-z0-9_]*') Then
						If Not StringRegExp($aTmp[$i + 1], '^[ \t]*$') Then
							$aTmp[$i] &= @CRLF
						EndIf
					EndIf
					If $i = UBound($aTmp) - 1 Then
						$sOut &= $aTmp[$i]
					Else
						$sOut &= $aTmp[$i] & @CRLF
					EndIf
				EndIf
			EndIf
		Next
		If $sComment Then
			$aBlockComment[0] += 1
			If UBound($aBlockComment) <= $aBlockComment[0] Then ReDim $aBlockComment[2 * UBound($aBlockComment)]
			$aBlockComment[$aBlockComment[0]] = $sComment
			$sOut &= Chr(3) & $aBlockComment[0] & Chr(3) & @CRLF
		EndIf
	EndIf
Else
	_ConsoleWrite($Lng_28 & @CRLF)
EndIf

$aTmp = StringRegExp($sOut, '("|'')([^\1\r\n]*?\1)', 3)
If IsArray($aTmp) Then
	Dim $aMask[Int(UBound($aTmp) / 2)]
	For $i = 0 To UBound($aMask) - 1
		$aMask[$i] = $aTmp[2 * $i] & $aTmp[2 * $i + 1]
		$sOut = StringReplace($sOut, $aMask[$i], Chr(7) & $i & Chr(7), 1, 1)
	Next
EndIf

$aComment = StringRegExp($sOut, '(;[^\r\n]*)', 3)
If IsArray($aComment) Then
	For $i = 0 To UBound($aComment) - 1
		If StringRegExp($aComment[$i], '^;(~|( \t))') Then
			$sOut = StringReplace($sOut, $aComment[$i], Chr(8) & Chr(1) & $i & Chr(2), 1, 1)
		Else
			$sOut = StringReplace($sOut, $aComment[$i], Chr(8) & $i & Chr(2), 1, 1)
		EndIf
		$aComment[$i] = StringStripWS($aComment[$i], 2)
	Next
EndIf

$a_Comment = StringRegExp($sOut, '(?i)(#[a-z0-9_-]+[^\r\n]*)', 3)
If IsArray($a_Comment) Then
	For $i = 0 To UBound($a_Comment) - 1
		$aTmp = StringRegExp($a_Comment[$i], '(?i)(#[a-z0-9_-]+[ \t]*)(.*)', 3)
		If IsArray($aTmp) Then
			If StringStripWS($aTmp[1], 2) Then
				$sOut = StringReplace($sOut, $aTmp[0] & $aTmp[1], $aTmp[0] & Chr(4) & $i & Chr(4), 1, 1)
				$a_Comment[$i] = StringStripWS($aTmp[1], 2)
			Else
				$a_Comment[$i] = ''
			EndIf
		Else
			$a_Comment[$i] = ''
		EndIf
	Next
EndIf

If $iModeFuncProc Then ; tidy names
	_ConsoleWrite($Lng_29 & @CRLF)
	$aNames = StringRegExp($sOut, '(?i)(?<![\$#@a-z_0-9])([#@a-z_0-9]+(?i:-once)?)(?![\$#@a-z_0-9])', 3)
	$aNames = _ArProc($aNames, 2)
	If IsArray($aNames) Then
		$iFlag = 0
		If $iModeFuncProc > 1 Then
			If Not IsArray($aRules) And FileExists(@ScriptDir & '\TidySourceRules.dat') Then
				$aRules = StringRegExp(FileRead(@ScriptDir & '\TidySourceRules.dat'), '(?i)([a-z0-9_#$]+)', 3)
			EndIf
			If IsArray($aRules) Then
				$sTmp = ''
				For $i = 0 To UBound($aNames) -1
					$sTmp &= $aNames[$i] & Chr(7)
				Next
				For $i = 0 To UBound($aRules) -1
					$sTmp = StringReplace($sTmp, $aRules[$i], $aRules[$i])
					If @Extended Then $iFlag = 1
				Next
				$aNames = StringRegExp($sTmp, '([^\a]+)', 3)
			EndIf
		EndIf
		_GetApiInfo()
		If $sAPI Then
			For $i = 0 To UBound($aNames) - 1
				$aTmp = StringRegExp($sAPI, '(?i)\|(\Q' & $aNames[$i] & '\E)\|', 3)
				If IsArray($aTmp) Then
					$aNames[$i] = $aTmp[0]
					$iFlag = 1
				EndIf
			Next
		EndIf
		If $iFlag Then
			For $i = 0 To UBound($aNames) - 1
				$sOut = StringRegExpReplace($sOut, '(?i)(?<![\$#@a-z_0-9])\Q' & $aNames[$i] & '\E(?![\$#@a-z_0-9])', $aNames[$i])
			Next
		EndIf
	EndIf
	$aTmp = StringRegExp($sOut, '(?i)(?<![a-z0-9_\$])(0x[0-9a-f]+)', 3)
	$aTmp = _ArProc($aTmp, 1)
	If IsArray($aTmp) Then
		For $i = 0 To UBound($aTmp) - 1
			$sOut = StringRegExpReplace($sOut, '(?i)(?<![a-z0-9_\$])' & $aTmp[$i], '0x' & StringUpper(StringTrimLeft($aTmp[$i], 2)))
		Next
	EndIf
Else
	_ConsoleWrite($Lng_30 & @CRLF)
EndIf

If $iModeVarProc Then ; tidy var names
	_ConsoleWrite($Lng_31 & @CRLF)
	If Not IsArray($aRules) And FileExists(@ScriptDir & '\TidySourceRules.dat') Then
		$aRules = StringRegExp(FileRead(@ScriptDir & '\TidySourceRules.dat'), '(?i)([a-z0-9_#$]+)', 3)
	EndIf
	If IsArray($aRules) Then
		If Not $sVAR Then
			$aVAR = StringRegExp($sOut, '(?i)(\$[0-9a-z_]+)', 3)
			$aVAR = _ArProc($aVAR)
			If IsArray($aVAR) Then
				$sVAR = ''
				For $i = 0 To UBound($aVAR) -1
					$sVAR &= $aVAR[$i] & ' '
				Next
			EndIf
		EndIf
		
		If $sVAR Then
			$iFlag = 0
			For $i = 0 To UBound($aRules) -1
				$sVAR = StringReplace($sVAR, $aRules[$i], $aRules[$i])
				If @Extended Then $iFlag = 1
			Next
			If $iFlag Then
				$aVAR = StringRegExp($sVAR, '([^ ]+)', 3)
				For $i = 0 To UBound($aVAR) -1
					$sOut = StringRegExpReplace($sOut, '(?i)(?<![\$#@a-z_0-9])\Q' & $aVAR[$i] & '\E(?![\$#@a-z_0-9])', $aVAR[$i])
				Next
				$sOut = StringReplace($sOut, '$CmdLineRaw', '$CmdLineRaw')
				$sOut = StringReplace($sOut, '$CmdLine', '$CmdLine')
			EndIf
		EndIf
	EndIf
Else
	_ConsoleWrite($Lng_32 & @CRLF)
EndIf

If $iModeSpaceProc Then
	_ConsoleWrite($Lng_33 & @CRLF)
	$leftTab = StringRegExp($sOut, '^(\t*)', 3)
	If IsArray($leftTab) Then $leftTab = $leftTab[0]
	
	$sOut = StringRegExpReplace($sOut, '(?i)(#Include)(?![ \t-])', '\1 ')
	
	$sOut = StringReplace($sOut, @TAB, ' ')
	$sOut = StringRegExpReplace($sOut, '[ ]+([\(\[])', '\1')
	$sOut = StringRegExpReplace($sOut, '[ ]+,', ',')
	$sOut = StringRegExpReplace($sOut, ',(?! )', ', ')
	$sOut = StringReplace($sOut, Chr(8), ' ' & Chr(8))
	
	$sOut = StringRegExpReplace($sOut, '([=<>*/^&+-])', ' \1 ')
	$sOut = StringRegExpReplace($sOut, '([<>=/*&+-])[ ]+=', '\1=')
	$sOut = StringRegExpReplace($sOut, '<[ ]+>', '<>')
	$sOut = StringRegExpReplace($sOut, '(?i)(?<![a-z0-9_$.])(And|Or|Not)(?![a-z0-9_$.])', ' \1 ')
	$sOut = StringRegExpReplace($sOut, '(?i)(?<=[,=&<>*/])[ ]*-[ ]+([0-9])', ' -\1')
	$sOut = StringRegExpReplace($sOut, '(?i)(?<![a-z0-9_\$])([a-z]+)[ ]*-[ ]+([0-9])', '\1 -\2')
	$sOut = StringRegExpReplace($sOut, '(?<=[\(\[])[ ]*-[ ]+([0-9])', '-\1')
	$sOut = StringRegExpReplace($sOut, '(?i)(?<![a-z0-9_$.#])(If|EndIf|Switch|With|While|Case)\(', '\1 (')
	$sOut = StringRegExpReplace($sOut, '(?i)([' & Chr(7) & '\)])(Then)(?![a-z0-9_$.#])', '\1 \2')
	$sOut = StringRegExpReplace($sOut, '(?i)(?<![a-z0-9_$.#])(To)(?![a-z0-9_$.#])', ' \1 ')
	$sOut = StringRegExpReplace($sOut, '[ ]+([\)\]])', '\1')
	$sOut = StringRegExpReplace($sOut, '([\(\[])[ ]+', '\1')
	$sOut = StringRegExpReplace($sOut, '(?i)(?<![a-z0-9_\$])_[ \t]*(?=[\r\n' & Chr(8) & '])', ' _ ')
	$sOut = StringRegExpReplace($sOut, '[ ]{2,}', ' ')
	$sOut = StringRegExpReplace($sOut, '(?i)(#[a-z0-9_]+)[ \t]+-[ \t]*', '\1-')
	
	$sOut = StringRegExpReplace($sOut, '^[ ]+', '')
	$sOut = StringRegExpReplace($sOut, '[ ]+$', '')
	$sOut = $leftTab & $sOut
Else
	_ConsoleWrite($Lng_34 & @CRLF)
EndIf

If IsArray($a_Comment) Then
	For $i = 0 To UBound($a_Comment) - 1
		If $a_Comment[$i] Then $sOut = StringReplace($sOut, Chr(4) & $i & Chr(4), $a_Comment[$i], 1, 1)
	Next
EndIf

If IsArray($aBlockComment) And $aBlockComment[0] > 0 Then
	For $i = 1 To $aBlockComment[0]
		$sOut = StringReplace($sOut, Chr(3) & $i & Chr(3) & @CRLF, $aBlockComment[$i], 1, 1)
	Next
EndIf

If StringRegExp($sOut, '[\r\n]') Then ; tidy indent
	_ConsoleWrite($Lng_35 & @CRLF)
	$iShift = 0
	$aTmp = StringRegExp($str, '^([\t]+)', 3)
	If IsArray($aTmp) Then $iShift = StringLen($aTmp[0])
	
	$aTmp = _StrigToArray($sOut)
	$sOut = ''
	$iComment = 0
	$iShiftComment = 0
	$iCase = 0
	For $i = 0 To UBound($aTmp) - 1
		If $iComment Then
			If StringRegExp($aTmp[$i], '(?i)^[ \t]*#(cs|comments-start)') Then
				$iComment += 1
				$sOut &= _Shift($iShift) & StringRegExpReplace(StringStripWS($aTmp[$i], 2), '^[\t]{' & $iShiftComment & '}', '') & @CRLF
			ElseIf StringRegExp($aTmp[$i], '(?i)^[ \t]*#(ce|comments-end)') Then
				$iComment -= 1
				If $iComment Then
					$sOut &= _Shift($iShift) & StringRegExpReplace(StringStripWS($aTmp[$i], 2), '^[\t]{' & $iShiftComment & '}', '') & @CRLF
				Else
					$sOut &= _Shift($iShift) & StringStripWS($aTmp[$i], 3) & @CRLF
				EndIf
			Else
				$sOut &= _Shift($iShift) & StringRegExpReplace(StringStripWS($aTmp[$i], 2), '^[\t]{' & $iShiftComment & '}', '') & @CRLF
			EndIf
		Else
			If StringRegExp($aTmp[$i], '(?i)^[ \t]*#(cs|comments-start)') Then
				$iComment = 1
				$sOut &= _Shift($iShift) & StringStripWS($aTmp[$i], 3) & @CRLF
				$iShiftComment = 0
				$aTmp2 = StringRegExp($aTmp[$i], '^([\t]+)', 3)
				If IsArray($aTmp2) Then $iShiftComment = StringLen($aTmp2[0])
			Else
				$aTmp[$i] = StringStripWS($aTmp[$i], 3)
				Select
					Case StringRegExp($aTmp[$i], '(?i)(?<![a-z_0-9.\$])Then(?![a-z_0-9.])')
						If $i And StringRegExp($aTmp[$i - 1], '(?i)[^a-z0-9_\$]_[ \t]*($|' & Chr(8) & ')') Then
							$sOut &= _Shift($iShift + $iModeAddShift) & $aTmp[$i] & @CRLF
						ElseIf StringRegExp($aTmp[$i], '(?i)^ElseIf(?![a-z_0-9.])') Then
							$iShift -= 1
							$sOut &= _Shift($iShift) & $aTmp[$i] & @CRLF
						Else
							$sOut &= _Shift($iShift) & $aTmp[$i] & @CRLF
						EndIf
						$str = StringRegExpReplace($aTmp[$i], '(?i).*(?<![a-z_0-9.\$])Then(?![a-z_0-9.])', '')
						$str = StringRegExpReplace($str, Chr(8) & '.+', '')
						If Not StringStripWS($str, 3) Then
							$iShift += 1
						EndIf
					Case StringRegExp($aTmp[$i], '(?i)^(ElseIf|Else)(?![a-z_0-9.])')
						$sOut &= _Shift($iShift - 1) & $aTmp[$i] & @CRLF
					Case StringRegExp($aTmp[$i], '(?i)^(For|Func|With|While|Do)(?![a-z_0-9.])')
						If $iShift And StringRegExp($aTmp[$i], '(?i)^Func(?![a-z_0-9.])') Then
							$iShift = 0
							_ConsoleWrite($Lng_36 & ($i + 1 + $iStartLine) & $Lng_37 & @CRLF)
						EndIf
						$sOut &= _Shift($iShift) & $aTmp[$i] & @CRLF
						$iShift += 1
					Case StringRegExp($aTmp[$i], '(?i)^(EndIf|Next|EndFunc|EndWith|WEnd|Until)(?![a-z_0-9.])')
						$iShift -= 1
						If $iShift < 0 Then
							$iShift = 0
							_ConsoleWrite($Lng_36 & ($i + 1 + $iStartLine) & $Lng_37 & @CRLF)
						EndIf
						If $iShift And StringRegExp($aTmp[$i], '(?i)^EndFunc(?![a-z_0-9.])') Then
							$iShift = 0
							_ConsoleWrite($Lng_36 & ($i + 1 + $iStartLine) & $Lng_37 & @CRLF)
						EndIf
						$sOut &= _Shift($iShift) & $aTmp[$i] & @CRLF
					Case StringRegExp($aTmp[$i], '(?i)^(Select|Switch)(?![a-z_0-9.])')
						$sOut &= _Shift($iShift) & $aTmp[$i] & @CRLF
						$iShift += 2
						$iCase = 1
					Case StringRegExp($aTmp[$i], '(?i)^(EndSelect|EndSwitch)(?![a-z_0-9.])')
						$iShift -= 2
						If $iShift < 0 Then
							$iShift = 0
							_ConsoleWrite($Lng_36 & ($i + 1 + $iStartLine) & $Lng_37 & @CRLF)
						EndIf
						$sOut &= _Shift($iShift) & $aTmp[$i] & @CRLF
						$iCase = 0
					Case StringRegExp($aTmp[$i], '(?i)^Case(?![a-z_0-9.])')
						$sOut &= _Shift($iShift - 1) & $aTmp[$i] & @CRLF
						$iCase = 0
					Case Else
						If $i Then
							If StringRegExp($aTmp[$i - 1], '(?i)[^a-z0-9_\$]_[ \t]*($|' & Chr(8) & ')') Then
								$sOut &= _Shift($iShift + $iModeAddShift - $iCase) & $aTmp[$i] & @CRLF
							Else
								If StringLeft($aTmp[$i], 2) = Chr(8) & Chr(1) Then
									$sOut &= $aTmp[$i] & @CRLF
								Else
									$sOut &= _Shift($iShift - $iCase) & $aTmp[$i] & @CRLF
								EndIf
							EndIf
						Else
							If StringLeft($aTmp[$i], 2) = Chr(8) & Chr(1) Then
								$sOut &= $aTmp[$i] & @CRLF
							Else
								$sOut &= _Shift($iShift - $iCase) & $aTmp[$i] & @CRLF
							EndIf
						EndIf
				EndSelect
			EndIf
		EndIf
	Next
	$sOut = StringTrimRight($sOut, 2)
Else
	_ConsoleWrite($Lng_38 & @CRLF)
EndIf

If IsArray($aComment) Then
	$sOut = StringReplace($sOut, Chr(1), '')
	For $i = 0 To UBound($aComment) - 1
		$sOut = StringReplace($sOut, Chr(8) & $i & Chr(2), $aComment[$i], 1, 1)
	Next
EndIf

If IsArray($aMask) Then
	For $i = 0 To UBound($aMask) - 1
		$sOut = StringReplace($sOut, Chr(7) & $i & Chr(7), $aMask[$i], 1, 1)
	Next
EndIf

If StringCompare(StringStripWS($sOut, 8), $sForTest) Then
	ConsoleWrite($Lng_44 & @CRLF)
	Exit
EndIf

If $iBackUp Then _BackUp()

If $iPart > 0 Then
	If $iPart > 1 Then
		$sOut = StringRegExpReplace($sOut, '([\r\n]+)$', '')
	EndIf
	If _ChekSciTE() Then
		_SetCurPos($curPos[0], $curPos[1])
		_SetText($sOut, 1)
		_ConsoleWrite($Lng_39 & @CRLF)
	Else
		_ConsoleWrite($Lng_40 & @CRLF)
	EndIf
Else
	If StringRight($sOut, 2) <> @CRLF Then $sOut &= @CRLF
	If _ChekSciTE() Then
		_SetText($sOut, 2)
		_SetCurPos($curPos[1])
	Else
		$file = FileOpen($sFile, 2)
		FileWrite($file, $sOut)
		FileClose($file)
	EndIf
	_ConsoleWrite($Lng_39 & @CRLF)
EndIf

Func _ArProc($inArray, $iMode = 0)
	If Not IsArray($inArray) Then Return 0
	_ArraySort($inArray)
	Local $outArray, $i, $lastVal = '', $aTmp, $iNum = 0
	If $iMode Then
		Dim $aTmp[UBound($inArray)][2]
		For $i = 0 To UBound($inArray) - 1
			If $inArray[$i] <> '' And $lastVal <> $inArray[$i] Then
				$lastVal = $inArray[$i]
				If $iMode > 1 And StringRegExp($inArray[$i], '(?i)^([0-9]+|0x[0-9a-f]+)$') Then ContinueLoop
				$aTmp[$iNum][1] = $lastVal
				$aTmp[$iNum][0] = StringLen($lastVal)
				$iNum += 1
			EndIf
		Next
		If Not $iNum Then Return 0
		ReDim $aTmp[$iNum][2]
		_ArraySort($aTmp)
		Dim $outArray[UBound($aTmp)]
		For $i = 0 To UBound($aTmp) - 1
			$outArray[$i] = $aTmp[$i][1]
		Next
		Return $outArray
	Else
		Dim $aTmp[UBound($inArray)]
		For $i = 0 To UBound($inArray) - 1
			If $inArray[$i] <> '' And $lastVal <> $inArray[$i] Then
				$lastVal = $inArray[$i]
				$aTmp[$iNum] = $lastVal
				$iNum += 1
			EndIf
		Next
		If Not $iNum Then Return 0
		ReDim $aTmp[$iNum]
		Return $aTmp
	EndIf
EndFunc

Func _Shift($iNum)
	If $iNum < 0 Then $iNum = 0
	If Not $iNum Then Return ''
	Local $sRet = '', $i
	For $i = 1 To $iNum
		$sRet &= @TAB
	Next
	Return $sRet
EndFunc

Func _ConsoleWrite($s_Text, $overwrite = 0)
	If Not $hSciTE Then
		ConsoleWrite($s_Text)
		Return
	EndIf
	If $s_Text Then
		$s_Text = StringToBinary($s_Text, 1)
		$s_Text &= StringRight('0000', Mod(StringLen($s_Text), 4) + 2)
		$s_Text = BinaryToString($s_Text, 2)
	EndIf
	If $overwrite <> 1 Then
		Local $iLength = _SendMessage($hCtrl2, $WM_GETTEXTLENGTH)
		_SendMessage($hCtrl2, $EM_SETSEL, $iLength, $iLength)
		_SendMessage($hCtrl2, $EM_REPLACESEL, True, $s_Text, 0, "wparam", "wstr")
	Else
		ControlSetText($hSciTE, '', $hCtrl2, $s_Text)
	EndIf
EndFunc

Func _GetCurPos()
	Local $wparam, $lparam, $aRet[2]
	If Not $hSciTE Then Return SetError(1, 0, $aRet)
	$wparam = DllStructCreate("uint Start")
	$lparam = DllStructCreate("uint End")
	_SendMessage($hCtrl1, $EM_GETSEL, DllStructGetPtr($wparam), DllStructGetPtr($lparam), 0, "ptr", "ptr")
	$aRet[0] = DllStructGetData($wparam, "Start")
	$aRet[1] = DllStructGetData($lparam, "End")
	Return SetError(@Error, 0, $aRet)
EndFunc

Func _SetCurPos($iStart, $iEnd = 0)
	If Not $hSciTE Then Return SetError(1, 0, 0)
	If $iEnd < 1 Then $iEnd = $iStart
	_SendMessage($hCtrl1, $EM_SETSEL, $iStart, $iEnd)
EndFunc

Func _GetText($iSelectedText = 0)
	If Not $hSciTE Then Return SetError(1, 0, 0)
	Local $s_Text, $wparam, $lparam, $aSel[2]
	$s_Text = ControlGetText($hSciTE, '', $hCtrl1)
	$s_Text = BinaryToString(StringToBinary($s_Text, 2), 1)
	If $iSelectedText Then
		$wparam = DllStructCreate("uint Start")
		$lparam = DllStructCreate("uint End")
		_SendMessage($hCtrl1, $EM_GETSEL, DllStructGetPtr($wparam), DllStructGetPtr($lparam), 0, "ptr", "ptr")
		$aSel[0] = DllStructGetData($wparam, "Start")
		$aSel[1] = DllStructGetData($lparam, "End")
		If $aSel[1] > $aSel[0] Then
			$s_Text = StringMid($s_Text, $aSel[0] + 1, $aSel[1] - $aSel[0])
		Else
			$s_Text = ''
		EndIf
	EndIf
	Return $s_Text
EndFunc

Func _SetText($s_Text, $iMode = 0) ;0 - paste to end, 1 - paste to cur pos, 2 - overwrite all text
	If Not $hSciTE Then Return SetError(1, 0, 0)
	If $s_Text Then
		$s_Text = StringToBinary($s_Text, 1)
		$s_Text &= StringRight('0000', Mod(StringLen($s_Text), 4) + 2)
		$s_Text = BinaryToString($s_Text, 2)
	EndIf
	If $iMode = 2 Then
		ControlSetText($hSciTE, '', $hCtrl1, $s_Text)
	Else
		If $iMode = 0 Then ; paste to end, else - paste to cur pos
			Local $iLength = _SendMessage($hCtrl1, $WM_GETTEXTLENGTH)
			_SendMessage($hCtrl1, $EM_SETSEL, $iLength, $iLength)
		EndIf
		_SendMessage($hCtrl1, $EM_REPLACESEL, True, $s_Text, 0, "wparam", "wstr")
	EndIf
EndFunc

Func _DelComment($str, $delAll = 0)
	Local $aTmp, $iComment = 0, $i, $j, $flag, $tmp, $len, $chr
	$aTmp = StringRegExp($str, '([^\r\n]+)', 3)
	If IsArray($aTmp) Then
		$str = @CRLF
		For $i = 0 To UBound($aTmp) - 1
			If $iComment Then
				If StringRegExp($aTmp[$i], '(?i)^[ \t]*#(cs|comments-start)') Then
					$iComment += 1
				ElseIf StringRegExp($aTmp[$i], '(?i)^[ \t]*#(ce|comments-end)') Then
					$iComment -= 1
				EndIf
			Else
				If StringRegExp($aTmp[$i], '(?i)^[ \t]*#(cs|comments-start)') Then
					$iComment = 1
				Else
					If StringRegExp($aTmp[$i], '(?i)^[ \t]*#(?=AutoIt3TidySourse)') Then
						$str &= StringStripWS($aTmp[$i], 7) & @CRLF
						ContinueLoop
					EndIf
					If StringRegExp($aTmp[$i], '(?i)^[ \t]*#(?!include)') Then ContinueLoop
					If Not StringRegExp($aTmp[$i], '^[ \t]*;') Then
						If $delAll Then
							If StringRegExp($aTmp[$i], '(?i)^[ \t]*#include') Then
								$aTmp[$i] = StringRegExpReplace($aTmp[$i], '([^;]+).*', '\1')
								$aTmp[$i] = StringStripWS($aTmp[$i], 7)
							Else
								$flag = 0
								$tmp = ''
								$len = StringLen($aTmp[$i])
								If $len Then
									For $j = 1 To $len
										$chr = StringMid($aTmp[$i], $j, 1)
										Switch $chr
											Case ';'
												If Not $flag Then
													$flag = -1
													ExitLoop
												EndIf
											Case '"'
												Switch $flag
													Case 0
														$flag = 1
														$tmp &= '"'
													Case 1
														$flag = 0
														$tmp &= '"'
												EndSwitch
											Case "'"
												Switch $flag
													Case 0
														$flag = 2
														$tmp &= '"'
													Case 2
														$flag = 0
														$tmp &= '"'
												EndSwitch
											Case Else
												If Not $flag Then $tmp &= $chr
										EndSwitch
									Next
									$aTmp[$i] = StringStripWS($tmp, 7)
								EndIf
							EndIf
						EndIf
						$str &= $aTmp[$i] & @CRLF
					EndIf
				EndIf
			EndIf
		Next
	EndIf
	Return $str
EndFunc

Func _ChekSciTE()
	If $hSciTE And $pathSciTE Then
		Local $tmp, $name, $path
		$tmp = WinGetTitle($hSciTE)
		$name = StringRegExpReplace($sFile, '.+\\(.+)', '\1')
		$path = StringRegExpReplace($sFile, '(.+)\\.+', '\1')
		If StringInStr($tmp, $name) And StringInStr($tmp, $path) Then
			Return 1
		Else
			Run('"' & $pathSciTE & 'SciTE.exe" "' & $sFile & '"')
			If Not WinExists($hSciTE) Then
				$hSciTE = WinWait('[Class:SciTEWindow]', '', 5)
				If Not $hSciTE Then
					_ConsoleWrite($Lng_41 & @CRLF)
					Exit
				EndIf
				$hCtrl1 = ControlGetHandle($hSciTE, '', '[CLASS:Scintilla; INSTANCE:1]')
				$hCtrl2 = ControlGetHandle($hSciTE, '', '[CLASS:Scintilla; INSTANCE:2]')
			EndIf
			Local $begin = TimerInit()
			Do
				Sleep(250)
				$tmp = WinGetTitle($hSciTE)
				If StringInStr($tmp, $name) And StringInStr($tmp, $path) Then
					Sleep(400)
					Return 1
				EndIf
			Until TimerDiff($begin) > 3000
		EndIf
	EndIf
	Return 0
EndFunc

Func _StrigToArray($str)
	Local $aRet, $numStr = 1
	$aRet = StringRegExp($str, '([^\r\n]*)(?:\r\n|\r|\n|$)', 3)
	$numStr = StringRegExp($str, '(\r\n|\r|\n)', 3)
	If IsArray($numStr) Then $numStr = UBound($numStr) + 1
	ReDim $aRet[$numStr]
	Return SetError(0, $numStr, $aRet)
EndFunc

Func _GetApiInfo()
	If Not $pathSciTE Then Return
	If $sAPI Then Return
	$aPath = _FileListToArray($pathSciTE & 'api', 'au3*.api', 1)
	If IsArray($aPath) And $aPath[0] > 0 Then
		$sAPI = '|'
		For $i = 1 To $aPath[0]
			$sTmp = FileRead($pathSciTE & 'api\' & $aPath[$i])
			$aTmp = StringRegExp($sTmp, '(?i)(?<=^|[\r\n])([#@_a-z0-9]+(?i:-once)?)', 3)
			If IsArray($aTmp) Then
				For $j = 0 To UBound($aTmp) - 1
					$sAPI &= $aTmp[$j] & '|'
				Next
			EndIf
		Next
		If $sAPI = '|' Then $sAPI = ''
	Else
		_ConsoleWrite($Lng_42 & @CRLF)
	EndIf
EndFunc

Func _BackUp()
	Local $i = 1, $sOutName, $sPath, $sName
	$sPath = StringRegExpReplace($sFile, '(.+\\).+', '\1')
	$sName = StringRegExpReplace($sFile, '.+\\(.+)\.[^.]+', '\1')
	Do
		$sOutName = $sPath & 'BackUp\' & $sName & '_old' & $i & '.au3'
		$i += 1
	Until Not FileExists($sOutName)
	FileCopy($sFile, $sOutName, 9)
	_ConsoleWrite($Lng_43 & $sOutName & '"' & @CRLF)
EndFunc

Func _Help()
	If Not $Lng_hlp Then Return
	$file = FileOpen(@TempDir & '\_tshf.htm', 2)
	FileWrite($file, $Lng_hlp)
	FileClose($file)
	Run('hh.exe -800 "' & @TempDir & '\_tshf.htm' & '"')
	Sleep(1000)
	FileDelete(@TempDir & '\_tshf.htm')
EndFunc

Func _WinAPI_GetProcessFileName($PID = 0) ;#Include <WinAPIEx.au3>
	If Not $PID Then
		$PID = _WinAPI_GetCurrentProcessID()
		If Not $PID Then
			Return SetError(1, 0, '')
		EndIf
	EndIf
	Local $hProcess = DllCall('kernel32.dll', 'ptr', 'OpenProcess', 'dword', 0x00000410, 'int', 0, 'dword', $PID)
	If (@Error) Or (Not $hProcess[0]) Then
		Return SetError(1, 0, '')
	EndIf
	Local $tPath = DllStructCreate('wchar[1024]')
	Local $Ret = DllCall(@SystemDir & '\psapi.dll', 'int', 'GetModuleFileNameExW', 'ptr', $hProcess[0], 'ptr', 0, 'ptr', DllStructGetPtr($tPath), 'int', 1024)
	If (@Error) Or (Not $Ret[0]) Then
		$Ret = 0
	EndIf
	_WinAPI_CloseHandle($hProcess[0])
	If Not IsArray($Ret) Then
		Return SetError(1, 0, '')
	EndIf
	Return DllStructGetData($tPath, 1)
EndFunc

