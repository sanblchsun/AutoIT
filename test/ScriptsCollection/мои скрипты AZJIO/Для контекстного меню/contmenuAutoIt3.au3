;  @AZJIO 5.10.2010
; скрипт позвол€ет дл€ au3 файлов выбрать версию AutoIt3 из контекстного меню, дл€ запуска. »ли сменить версию в реестре дл€ пунктов конт. меню.
; при перетаскивании скомпилированного EXE-файла AutoIt3 в окно утилиты - получаем версию использованного дл€ компил€ции AutoIt3
; требуетс€ в строках 9-12 указать свои пути дл€ разных версий.

#NoTrayIcon
$PathNotepad=@ProgramFilesDir&'\Notepad++\notepad++.exe'

Dim $AutoIt3Path[5]=[4, _
@ProgramFilesDir&'\AutoIt3_v3.2.12.1\AutoIt3.exe', _
@ProgramFilesDir&'\AutoIt3_v3.3.0.0\AutoIt3.exe', _
@ProgramFilesDir&'\AutoIt3_v3.3.4.0\AutoIt3.exe', _
@ProgramFilesDir&'\AutoIt3_v3.3.6.1\AutoIt3.exe']

Global $Path, $Select_v0

; En
$LngVer='Version'
$LngContM='Other version'
$LngSelV='Version is chosen:'
$LngCur='To make current'
$LngCurH='In the contextual menu'&@CRLF&'the chosen version will be used'
$LngAut='Automatically'
$LngAutH='Automatically to do the version'&@CRLF&'chosen in the list current'
$LngAu3H='Use of the version specified in the list'&@CRLF&'without version preservation in the register'
$LngAuWH='Compilation with the specified version'
$LngNP='The path does not exist.'
$LngUnl='To remove registration of this menu in the register'&@CRLF&'accordingly removal from the contextual menu'
$LngMs1='Message'
$LngMs2='File is not a compiled script AutoIt3'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русска€ локализаци€, то русский €зык
If $UserIntLang = 0419 Then
	$LngVer='¬ерси€'
	$LngContM='ƒруга€ верси€'
	$LngSelV='выбрана верси€:'
	$LngCur='—делать текущей'
	$LngCurH='¬ контекстном меню будет'&@CRLF&'использоватьс€ выбранна€ верси€'
	$LngAut='атоматически'
	$LngAutH='јвтоматически делать выбранную'&@CRLF&'в списке версию текущей'
	$LngAu3H='»спользование версии указанной в списке'&@CRLF&'без сохранени€ версии в реестре'
	$LngAuWH=' омпилирование с указанной версией'
	$LngNP='ѕуть не существует.'
	$LngUnl='”далить регистрацию этого меню в реестре'&@CRLF&'соответственно удаление из контекст. меню'
	$LngMs1='—ообщение'
	$LngMs2='‘айл не €вл€етс€ скомпилированным скриптом AutoIt3'
EndIf

$curret = RegRead("HKLM\SOFTWARE\script_az\contmenuAutoIt3", "Default")
If @error Then _regscr()
$other = RegRead("HKCR\AutoIt3Script\Shell\other",'')
If @error Then _regscr()

If $CmdLine[0]=0 Then Exit
$filename=StringRegExpReplace($CmdLine[1], '(^.*)\\(.*)$', '\2')
$filepath=$CmdLine[1]


$Gui = GUICreate($filename,  360, 170, -1, -1, -1, 0x00000010)

$CatchDrop = GUICtrlCreateLabel("", 0, 0, 360, 170)
GUICtrlSetState(-1, 136)

$lang=GUICtrlCreateGroup ("", 10, 31, 340, 35)
$StatusBar = GUICtrlCreateLabel($LngSelV, 16,42,130,18)
$curretButt = GUICtrlCreateButton($LngCur, 140, 40, 100, 24)
GUICtrlSetTip(-1, $LngCurH)
$curretdef = GUICtrlCreateCheckbox($LngAut, 250, 42, 90, 17)
GUICtrlSetTip(-1, $LngAutH)
If $curret = '1' Then GuiCtrlSetState(-1, 1)

$Select_v=GUICtrlCreateCombo ("", 10,10,340,18, 0x3)
$curretPath = RegRead("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir")&'\AutoIt3.exe'
If @error Then $curretPath=$AutoIt3Path[1]
$setcombo=''
For $i=1 To $AutoIt3Path[0]
	$setcombo&=$AutoIt3Path[$i]&'|'
Next
If StringInStr($setcombo, $curretPath)=0 Then $setcombo&=$curretPath&'|'
GUICtrlSetData ($Select_v, StringTrimRight($setcombo, 1), $curretPath)

$AutoIt3=GUICtrlCreateButton("AutoIt3", 10, 80, 122, 25)
GUICtrlSetTip(-1, $LngAu3H)
$AutoIt3Wrapper=GUICtrlCreateButton("AutoIt3Wrapper", 10, 110, 122, 25)
GUICtrlSetTip(-1, $LngAuWH)
$AutoIt3Wrapper_Gui=GUICtrlCreateButton("AutoIt3Wrapper_Gui", 10, 140, 122, 25)
GUICtrlSetTip(-1, $LngAuWH)
$SciTE=GUICtrlCreateButton("SciTE", 140, 80, 122, 25)
$Tidy=GUICtrlCreateButton("Tidy", 140, 110, 122, 25)
$Au3ToPost=GUICtrlCreateButton("Au3ToPost", 140, 140, 122, 25)
_read()
If Not @error Then GUICtrlSetData ($StatusBar, $LngSelV&' '&FileGetVersion($Select_v0))

GUICtrlCreateLabel('drag-and-drop '&@CRLF&'au3, exe (AutoIt3)', 265,80,88,34, 0x2)

$uninstall = GUICtrlCreateButton("unl", 337, 147, 21, 21, 0x0040)
GUICtrlSetTip(-1, $LngUnl)
GUICtrlSetImage(-1, @SystemDir & '\xpsp2res.dll', 1, 0)

GUISetState()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = -13
			If StringRight(@GUI_DRAGFILE, 4)='.au3' Then
				$filename=StringRegExpReplace(@GUI_DRAGFILE, '(^.*)\\(.*)$', '\2')
				WinSetTitle($Gui, '', $filename)
				$filepath=@GUI_DRAGFILE
			ElseIf StringRight(@GUI_DRAGFILE, 4)='.exe' Then
				; определ€ем принадлежность exe к AutoIt3 и определ€ем версию AutoIt3
				$file = FileOpen(@GUI_DRAGFILE, 0)
				FileSetPos($file, FileGetSize(@GUI_DRAGFILE)-8, 1)
				$AU3EA = FileRead($file)
				FileClose($file)
				If $AU3EA='AU3!EA06' Then
					Run('"'&@GUI_DRAGFILE&'" /AutoIt3ExecuteLine "MsgBox(0, ""'&StringRegExpReplace(@GUI_DRAGFILE, '(^.*)\\(.*)$', '\2')&' ('&$LngVer&' AutoIt3)"", @AutoItVersion)"')
				Else
					MsgBox(0, $LngMs1, $LngMs2)
				EndIf
			EndIf
		Case $msg = $uninstall
			RegDelete("HKLM\SOFTWARE\script_az\contmenuAutoIt3")
			RegDelete("HKCR\AutoIt3Script\Shell\other")
		Case $msg = $curretdef
			_curretdef()
		Case $msg = $curretButt
			_read()
			_cd()
		Case $msg = $Select_v
			_read()
			If @error Then ContinueLoop
			GUICtrlSetData ($StatusBar, $LngSelV&' '&FileGetVersion($Select_v0))
			 If GUICtrlRead($curretdef) = 1 Then _cd()
		Case $msg = $AutoIt3
			_read()
			If @error Then ContinueLoop
			ShellExecute($Path&'\AutoIt3.exe', '"'&$filepath&'" %*')
		Case $msg = $AutoIt3Wrapper
			_read()
			If @error Then ContinueLoop
			If GUICtrlRead($curretdef) = 1 Then
				ShellExecute($Path&'\SciTE\AutoIt3Wrapper\AutoIt3Wrapper.exe', '/in "'&$filepath&'"')
			Else
				$PathOld=RegRead("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir")
				RegWrite("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir","REG_SZ",$Path)
				ShellExecuteWait($Path&'\SciTE\AutoIt3Wrapper\AutoIt3Wrapper.exe', '/in "'&$filepath&'"')
				RegWrite("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir","REG_SZ",$PathOld)
			EndIf
		Case $msg = $AutoIt3Wrapper_Gui
			_read()
			If @error Then ContinueLoop
			If GUICtrlRead($curretdef) = 1 Then
				ShellExecute($Path&'\SciTE\AutoIt3Wrapper\AutoIt3Wrapper.exe', '/ShowGui /in "'&$filepath&'"')
			Else
				$PathOld=RegRead("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir")
				RegWrite("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir","REG_SZ",$Path)
				ShellExecuteWait($Path&'\SciTE\AutoIt3Wrapper\AutoIt3Wrapper.exe', '/ShowGui /in "'&$filepath&'"')
				RegWrite("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir","REG_SZ",$PathOld)
			EndIf
		Case $msg = $SciTE
			_read()
			If @error Then ContinueLoop
			ShellExecute($Path&'\SciTE\SciTE.exe', '"'&$filepath&'"')
		Case $msg = $Tidy
			_read()
			If @error Then ContinueLoop
			ShellExecute($Path&'\SciTE\Tidy\Tidy.exe', '"'&$filepath&'"')
		Case $msg = $Au3ToPost
			_read()
			If @error Then ContinueLoop
			ShellExecute($Path&'\SciTE\Au3ToPost\Au3ToPost.exe', '/FilePath:"'&$filepath&'"')
		Case $msg = -3
			ExitLoop
	EndSelect
WEnd

Func _cd()
	If @error = 1 Then Return
	$as='HKCR\AutoIt3Script'
	
	; проверка в реестре существование ветки и при успехе происходит изменение пути
	; Check in the register existence of section and at success to execute change
	
	RegRead($as&"\Shell\Au3ToPost\Command", "")
	If Not @error Then RegWrite($as&"\Shell\Au3ToPost\Command","","REG_SZ",'"'&$Path&'\SciTE\Au3ToPost\Au3ToPost.exe" /FilePath:"%1"')
	
	RegRead($as&"\Shell\Tidy\Command", "")
	If Not @error Then RegWrite($as&"\Shell\Tidy\Command","","REG_SZ",'"'&$Path&'\SciTE\Tidy\Tidy.exe" "%1"')

	RegRead($as&"\Shell\AutoIt3Wrapper_Gui\Command", "")
	If Not @error Then RegWrite($as&"\Shell\AutoIt3Wrapper_Gui\Command","","REG_SZ",'"'&$Path&'\SciTE\AutoIt3Wrapper\AutoIt3Wrapper.exe" /ShowGui /in "%l"')

	RegRead($as&"\Shell\Compile with Options\Command", "")
	If Not @error Then RegWrite($as&"\Shell\Compile with Options\Command","","REG_SZ",'"'&$Path&'\SciTE\AutoIt3Wrapper\AutoIt3Wrapper.exe" /ShowGui /in "%l"')

	RegRead($as&"\Shell\AutoIt3Wrapper\Command", "")
	If Not @error Then RegWrite($as&"\Shell\AutoIt3Wrapper\Command","","REG_SZ",'"'&$Path&'\SciTE\AutoIt3Wrapper\AutoIt3Wrapper.exe" /in "%l"')

	RegRead($as&"\Shell\Compile\Command", "")
	If Not @error Then RegWrite($as&"\Shell\Compile\Command","","REG_SZ",'"'&$Path&'\Aut2Exe\Aut2Exe.exe" /in "%l"')

	RegRead($as&"\Shell\rx_re\Command", "")
	If Not @error Then RegWrite($as&"\Shell\rx_re\Command","","REG_SZ",'"'&$Path&'\AutoIt3.exe" "'&$Path&'\re_au3.au3" %*"')

	$tmpreg=RegRead($as&"\Shell\Open\Command", "")
	If Not @error Then
		If StringInStr($tmpreg, "AutoIt3.exe") Then RegWrite($as&"\Shell\Open\Command","","REG_SZ",'"'&$Path&'\AutoIt3.exe" "%1" %*')
		If StringInStr($tmpreg, "SciTE.exe") Then RegWrite($as&"\Shell\Open\Command","","REG_SZ",'"'&$Path&'\SciTE\SciTE.exe" "%1"')
		If StringInStr($tmpreg, "notepad++.exe") Then RegWrite($as&"\Shell\Open\Command","","REG_SZ",'"'&$PathNotepad&'" "%1"')
	EndIf

	$tmpreg=RegRead($as&"\Shell\Run\Command", "")
	If Not @error Then
		If StringInStr($tmpreg, "AutoIt3.exe") Then RegWrite($as&"\Shell\Run\Command","","REG_SZ",'"'&$Path&'\AutoIt3.exe" "%1" %*')
		If StringInStr($tmpreg, "SciTE.exe") Then RegWrite($as&"\Shell\Run\Command","","REG_SZ",'"'&$Path&'\SciTE\SciTE.exe" "%1"')
		If StringInStr($tmpreg, "notepad++.exe") Then RegWrite($as&"\Shell\Run\Command","","REG_SZ",'"'&$PathNotepad&'" "%1"')
	EndIf

	$tmpreg=RegRead($as&"\Shell\Edit\Command", "")
	If Not @error Then
		If StringInStr($tmpreg, "SciTE.exe") Then RegWrite($as&"\Shell\Edit\Command","","REG_SZ",'"'&$Path&'\SciTE\SciTE.exe" "%1"')
		If StringInStr($tmpreg, "notepad++.exe") Then RegWrite($as&"\Shell\Edit\Command","","REG_SZ",'"'&$PathNotepad&'" "%1"')
	EndIf
	RegWrite("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir","REG_SZ",$Path)
	RegWrite("HKLM\SOFTWARE\AutoIt v3\AutoIt","Version","REG_SZ",'v'&FileGetVersion($Select_v0))
EndFunc

Func _read()
	$Select_v0=GUICtrlRead ($Select_v)
	If Not FileExists($Select_v0) Then
		GUICtrlSetState($curretButt, 128)
		GUICtrlSetState($AutoIt3, 128)
		GUICtrlSetState($AutoIt3Wrapper, 128)
		GUICtrlSetState($AutoIt3Wrapper_Gui, 128)
		GUICtrlSetState($SciTE, 128)
		GUICtrlSetState($Tidy, 128)
		GUICtrlSetData ($StatusBar, $LngNP)
		Return SetError(1)
	Else
		GUICtrlSetState($curretButt, 64)
		GUICtrlSetState($AutoIt3, 64)
		GUICtrlSetState($AutoIt3Wrapper, 64)
		GUICtrlSetState($AutoIt3Wrapper_Gui, 64)
		GUICtrlSetState($SciTE, 64)
		GUICtrlSetState($Tidy, 64)
	EndIf
	$Path=StringRegExpReplace($Select_v0, '(^.*)\\(.*)$', '\1')
EndFunc

Func _curretdef()
	If GUICtrlRead($curretdef) = 1 Then
		RegWrite("HKLM\SOFTWARE\script_az\contmenuAutoIt3", "Default", "REG_SZ", "1")
	Else
		RegWrite("HKLM\SOFTWARE\script_az\contmenuAutoIt3", "Default", "REG_SZ", "0")
	EndIf
EndFunc

Func _regscr()
	RegWrite("HKLM\SOFTWARE\script_az\contmenuAutoIt3", "Default", "REG_SZ", "0")
	$curret = '0'
	RegWrite("HKCR\AutoIt3Script\Shell\other", "", "REG_SZ", $LngContM)
	RegWrite("HKCR\AutoIt3Script\Shell\other\Command", "", "REG_SZ", @AutoItExe & ' "' & @SystemDir & '\contmenuAutoIt3.au3" "%1"')
	If Not FileExists(@SystemDir & '\contmenuAutoIt3.au3') Then FileCopy(@ScriptDir & '\' &@ScriptName, @SystemDir & '\contmenuAutoIt3.au3', 1)
EndFunc