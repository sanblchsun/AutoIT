#NoTrayIcon

Global $ini = @ScriptDir&'\RegToScript.ini'
;Проверка существования RegToScript.ini
If Not FileExists($ini) Then
	If MsgBox(4, "Выгодное предложение", 'Хотите создать необходимый RegToScript.ini' & @CRLF &'для сохранения вводимых параметров?') = 6 Then
		$fileini = FileOpen($ini, 2)
		FileWrite($fileini, '[Setup]' & @CRLF & _
'DebugText=..............' & @CRLF & @CRLF & _
'[Script_BeginText]' & @CRLF & _
'=RegHiveLoad,WB-software,%TargetDir%\i386\System32\Config\software' & @CRLF & _
'=RegHiveLoad,WB-default,%TargetDir%\i386\System32\Config\default' & @CRLF & _
'=RegHiveLoad,WB-system,%TargetDir%\i386\System32\SetupReg.hiv' & @CRLF & @CRLF & _
'[Script_Include]' & @CRLF & _
'HKLM\\SYSTEM=WB-system' & @CRLF & _
'HKLM\\SOFTWARE=WB-software' & @CRLF & _
'HKCU=WB-default' & @CRLF & _
'HKCR=WB-software\\Classes' & @CRLF & _
'HKU\\.DEFAULT=WB-default' & @CRLF & @CRLF & _
'[Script_Exclude]' & @CRLF & _
'=\b\w*mru' & @CRLF & @CRLF & _
'[Script_ReplaceData]' & @CRLF & _
'c:\\=x:\\' & @CRLF & @CRLF & _
'[Script_EndText]' & @CRLF & _
'=RegHiveUnLoad,WB-software' & @CRLF & _
'=RegHiveUnLoad,WB-default' & @CRLF & _
'=RegHiveUnLoad,WB-system' & @CRLF & @CRLF & _
'[Au3_Include]' & @CRLF & _
'HKLM=HKLM' & @CRLF & _
'HKCR=HKCR' & @CRLF & _
'HKCU=HKCU' & @CRLF & _
'HKU=HKU' & @CRLF & _
'HKCC=HKCC' & @CRLF & @CRLF & _
'[Au3_Exclude]' & @CRLF & _
'=\b\w*mru' & @CRLF & @CRLF & _
'[Au3_ReplaceData]' & @CRLF & @CRLF & _
'[Bat_Include]' & @CRLF & _
'HKLM=HKLM' & @CRLF & _
'HKCR=HKCR' & @CRLF & _
'HKCU=HKCU' & @CRLF & _
'HKU=HKU' & @CRLF & _
'HKCC=HKCC' & @CRLF & @CRLF & _
'[Bat_Exclude]' & @CRLF & _
'=\b\w*mru' & @CRLF & @CRLF & _
'[Bat_ReplaceData]' & @CRLF & @CRLF & _
'[setting]' & @CRLF & _
'type=au3' & @CRLF & _
'autoclip=0' & @CRLF & _
'autofile=1' & @CRLF)
		FileClose($fileini)
	EndIf
EndIf
;считываем RegToScript.ini
$type= IniRead ($ini, "setting", "type", "au3")
$autoclipset= IniRead ($ini, "setting", "autoclip", "0")
$autofileset= IniRead ($ini, "setting", "autofile", "1")

$Gui = GUICreate("RegToScript",  350, 140, -1, -1, -1, 0x00000010)
$StatusBar = GUICtrlCreateLabel('Строка состояния', 5,123,275,18)
GUICtrlCreateLabel ("используйте drag-and-drop", 110,1,160,18)

GUICtrlCreateLabel ("in", 10,20,9,18)
$inp_reg = GUICtrlCreateInput("", 25, 20, 280, 20) 
GUICtrlSetState(-1,8) 
$fold_reg = GUICtrlCreateButton("...", 315, 20, 27, 21)
GUICtrlSetFont (-1,13)

GUICtrlCreateLabel ("out", 3,50,15,18)
$inp_out = GUICtrlCreateInput("", 25, 50, 280, 20) 
GUICtrlSetState(-1,8) 
$fold_out = GUICtrlCreateButton("...", 315, 50, 27, 21)
GUICtrlSetFont (-1,13)


GUICtrlCreateGroup ("output", 5, 74, 170, 40)
$Au3 = GUICtrlCreateRadio("Au3", 20, 88, 38, 20)
$Bat = GUICtrlCreateRadio("Bat", 70, 88, 38, 20)
$Script = GUICtrlCreateRadio("Script", 120, 88, 50, 20)

$clipboard = GUICtrlCreateButton("clipboard", 282, 80, 60, 25)
$fileout = GUICtrlCreateButton("file", 282, 110, 60, 25)

$autoclip=GUICtrlCreateCheckbox ("auto-clipboard", 185,79,90,20)
$autofile=GUICtrlCreateCheckbox ("auto-file", 185,99,70,20)

If $autoclipset="1" Then GuiCtrlSetState($autoclip, 1)
If $autofileset="1" Then GuiCtrlSetState($autofile, 1)
If $type='au3' Then GUICtrlSetState ($Au3,1)
If $type='bat' Then GUICtrlSetState ($Bat,1)
If $type='script' Then GUICtrlSetState ($Script,1)

 
GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = -13
				If @GUI_DropID=$inp_reg Then
						GUICtrlSetData($inp_reg, @GUI_DRAGFILE)
						$aPath = StringRegExp(@GUI_DRAGFILE, "(^.*)\\(.*)\.(.*)$", 3)
						If $aPath[2]<>'reg' Then
							MsgBox(0, "Ошибка", 'Принимается только reg-файл')
							GUICtrlSetData($inp_reg, '')
							ContinueLoop
						EndIf
						GUICtrlSetData($inp_out, $aPath[0]&'\'&$aPath[1]&'.'&$type)
				
					If GUICtrlRead ($autofile)=1 Then
						RunWait(@ScriptDir&'\RegToScript.exe /'&$type&' "'&@GUI_DRAGFILE&'" "'&$aPath[0]&'\'&$aPath[1]&'.'&$type&'"', '', @SW_HIDE)
						_saveini()
						If FileExists($aPath[0]&'\'&$aPath[1]&'.'&$type) Then
						GUICtrlSetData ($StatusBar, 'Complete "'&$aPath[1]&'.'&$type&'"')
						Else
							GUICtrlSetData ($StatusBar, 'Error "'&$aPath[1]&'.'&$type&'"')
						EndIf
					Endif
					
					If GUICtrlRead ($autoclip)=1 Then _clipboard()
				Endif
				
				If @GUI_DropID=$inp_out Then GUICtrlSetData($inp_out, @GUI_DRAGFILE)
				
			Case $msg = $fileout
					_fileout()
			Case $msg = $clipboard
					_clipboard()
				
			Case $msg = $Au3
					$type = 'au3'
					_saveini()
			Case $msg = $Bat
					$type='bat'
					_saveini()
			Case $msg = $Script
					$type='script'
					_saveini()
			Case $msg = $autoclip
					_saveini()
			Case $msg = $autofile
					_saveini()
				
				; кнопки обзор
			Case $msg = $fold_reg
				$openfile = FileOpenDialog("Выбрать reg-файл", @WorkingDir & "", "(*.reg)", 1 + 4 )
				GUICtrlSetData($inp_reg, $openfile)
				If GUICtrlRead ($autofile)=1 Then _fileout()
				If GUICtrlRead ($autoclip)=1 Then _clipboard()
			Case $msg = $fold_out
				$savefile = FileSaveDialog( "Выбрать имя файла.", @WorkingDir & "", "Scripts (*.au3;*.bat;*.cmd;*.Script)", 2)
				GUICtrlSetData($inp_out, $savefile)
			Case $msg = -3
				ExitLoop
		EndSelect
	WEnd

; кнопка clipboard
Func _clipboard()
$inp_reg0=GUICtrlRead ($inp_reg)
$inp_out0=@TempDir&'\temp.tmp'
;If FileExists($inp_out0) Then FileDelete($inp_out0)
$aPath = StringRegExp($inp_reg0, "(^.*)\\(.*)\.(.*)$", 3)
If $aPath[2]<>'reg' Then
	MsgBox(0, "Ошибка", 'Принимается только reg-файл')
	GUICtrlSetData($inp_reg, '')
	return
EndIf
RunWait(@ScriptDir&'\RegToScript.exe /'&$type&' "'&$inp_reg0&'" "'&$inp_out0&'"', '', @SW_HIDE)
_saveini()
$file = FileOpen($inp_out0, 0)
$text= FileRead($file)
FileClose($file)
ClipPut ($text )
GUICtrlSetData ($StatusBar, 'Complete clipboard "'&$aPath[1]&'"')
EndFunc

; кнопка file
Func _fileout()
$inp_reg0=GUICtrlRead ($inp_reg)
$inp_out0=GUICtrlRead ($inp_out)
$aPath = StringRegExp($inp_reg0, "(^.*)\\(.*)\.(.*)$", 3)
If $aPath[2]<>'reg' Then
	MsgBox(0, "Ошибка", 'Принимается только reg-файл')
	GUICtrlSetData($inp_reg, '')
	return
EndIf
If $inp_out0='' Then $inp_out0=$aPath[0]&'\'&$aPath[1]&'.'&$type
RunWait(@ScriptDir&'\RegToScript.exe /'&$type&' "'&$inp_reg0&'" "'&$inp_out0&'"', '', @SW_HIDE)
_saveini()
$aPath = StringRegExp($inp_reg0, "(^.*)\\(.*)$", 3)
If FileExists($inp_out0) Then
	GUICtrlSetData ($StatusBar, 'Complete "'&$aPath[1]&'"')
Else
	GUICtrlSetData ($StatusBar, 'Error "'&$aPath[1]&'"')
EndIf
EndFunc



; сохранение состояния чекбоксов и радиокнопок
Func _saveini()
If GUICtrlRead ($autoclip)=1 Then
	IniWrite(@ScriptDir&'\RegToScript.ini', "setting", "autoclip", '1')
Else
	IniWrite(@ScriptDir&'\RegToScript.ini', "setting", "autoclip", '0')
Endif
If GUICtrlRead ($autofile)=1 Then
	IniWrite(@ScriptDir&'\RegToScript.ini', "setting", "autofile", '1')
Else
	IniWrite(@ScriptDir&'\RegToScript.ini', "setting", "autofile", '0')
Endif
IniWrite(@ScriptDir&'\RegToScript.ini', "setting", "type", $type)
EndFunc
