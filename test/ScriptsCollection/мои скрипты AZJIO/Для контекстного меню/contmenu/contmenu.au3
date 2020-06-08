;  @AZJIO
#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=contmenu.exe
#AutoIt3Wrapper_OutFile_X64=contmenu.exe
; #AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_icon=contmenu.ico
#AutoIt3Wrapper_Compression=n
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=contmenu.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.3
#AutoIt3Wrapper_Res_Field=Build|2013.06.30
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <FileOperations.au3>
#include <ComboConstants.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>

#NoTrayIcon
Opt("GUIOnEventMode", 1)

If RegRead("HKLM\SOFTWARE\AZJIO_Soft\contmenu", "Path") <> @ScriptFullPath Then RegDelete("HKLM\SOFTWARE\AZJIO_Soft\contmenu")
$close = RegRead("HKLM\SOFTWARE\AZJIO_Soft\contmenu", "close")
If @error Then
	RegWrite("HKLM\SOFTWARE\AZJIO_Soft\contmenu", "close", "REG_SZ", "1")
	RegWrite("HKLM\SOFTWARE\AZJIO_Soft\contmenu", "Path", "REG_SZ", @ScriptFullPath)
	$close = '1'
	;регистрация в реестре и копирование в системную папку при первом запуске
	RegWrite("HKCR\*\shell\AZJIO_contmenu", "", "REG_SZ", 'Управление файлом')
	RegWrite("HKCR\Directory\shell\AZJIO_contmenu", "", "REG_SZ", 'Управление каталогом')
	RegWrite("HKCR\Drive\shell\AZJIO_contmenu", "", "REG_SZ", 'Управление каталогом')
	RegWrite("HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shell\AZJIO_contmenu", "", "REG_SZ", 'Управление каталогом') ; мои документы
	If @Compiled Then
		RegWrite("HKCR\*\shell\AZJIO_contmenu\command", "", "REG_SZ", '"' & @ScriptFullPath & '" "%1"')
		RegWrite("HKCR\Directory\shell\AZJIO_contmenu\command", "", "REG_SZ", '"' & @ScriptFullPath & '" "%1"')
		RegWrite("HKCR\Drive\shell\AZJIO_contmenu\command", "", "REG_SZ", '"' & @ScriptFullPath & '" "%1"')
		RegWrite("HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shell\AZJIO_contmenu\command", "", "REG_SZ", '"' & @ScriptFullPath & '" "%1"')
	Else
		RegWrite("HKCR\*\shell\AZJIO_contmenu\command", "", "REG_SZ", @AutoItExe & ' "' & @ScriptFullPath & '" "%1"')
		RegWrite("HKCR\Directory\shell\AZJIO_contmenu\command", "", "REG_SZ", @AutoItExe & ' "' & @ScriptFullPath & '" "%1"')
		RegWrite("HKCR\Drive\shell\AZJIO_contmenu\command", "", "REG_SZ", @AutoItExe & ' "' & @ScriptFullPath & '" "%1"')
		RegWrite("HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shell\AZJIO_contmenu\command", "", "REG_SZ", @AutoItExe & ' "' & @ScriptFullPath & '" "%1"')
	EndIf
	MsgBox(0, 'Сообщение', 'Утилита добавлена в контекстное меню каталогов и файлов, ' & @CRLF & 'Удаление утилиты из контекстного меню доступно из окна управления файлами')
EndIf

Global $Typelist, $subfol, $listfull, $delcombo, $sTarget, $assot, $aPath, $7zipPath, $Ini, $password, $ScanPath, $textedit, $WinRARPath, $TrF
Global $sIniExt0 = 'bak;gid;log;tmp|htm;html;css;js;php|bmp;gif;jpg;jpeg;png;tif;tiff|exe;msi;scr;dll;cpl;ax|com;sys;bat;cmd|*Пустые папки'

$Ini = @ScriptDir & '\contmenu.ini'
If Not FileExists($Ini) Then
	If DriveStatus(StringLeft(@ScriptDir, 1)) <> 'NOTREADY' Then
		_SaveINI()
		While 1
			Sleep(100000)
		WEnd
	Else
		MsgBox(0, 'Ошибка', 'Отсутствует contmenu.ini и невозможно его создать на диске.')
		Exit
	EndIf
EndIf

$password = IniRead($Ini, 'set', 'password', 'my_password')
$ScanPath = IniRead($Ini, 'set', 'ScanPath', @ProgramFilesDir & '\Scanner\Scanner.exe')
$WinRARPath = IniRead($Ini, 'set', 'WinRARPath', @ProgramFilesDir & '\WinRAR\WinRAR.exe')
$7zipPath = IniRead($Ini, 'set', '7zipPath', @ProgramFilesDir & '\7-Zip\7z')
$textedit = IniRead($Ini, 'set', 'textedit', @SystemDir & '\notepad.exe')
$sIniExt = IniRead($Ini, 'set', 'Ext', $sIniExt0)
If Not $sIniExt Then $sIniExt = $sIniExt0

; , $LastExt=1
; $LastExt = IniRead($Ini, 'set', 'LastExt', $LastExt)
; $tmp = StringSplit($sIniExt, '|')
; If $LastExt> Then

If $CmdLine[0] = 0 Then Exit
$sTarget = $CmdLine[1]
Global $aFolder, $aPathexe[1], $aPath = StringRegExp($sTarget, "(^.*)\\(.*)$", 3)
; если каталог, тогда ... иначе ...
If StringInStr(FileGetAttrib($sTarget), 'D') Then
	$TrF = 1
	; начало создания окна, вкладок, кнопок.
	GUICreate($aPath[1], 310, 198) ; размер окна
	GUISetBkColor(0xF9F9F9)
	GUISetIcon('shell32.dll', -4)
	GUISetOnEvent(-3, "_Exit")
	$StatusBar = GUICtrlCreateLabel('Строка состояния', 5, 181, 300, 17, 0xC) ; лейбл без автопереноса

	$checkclose = GUICtrlCreateCheckbox("Закрывать диалог при клике на кнопке", 10, 10, 290, 24)
	GUICtrlSetOnEvent(-1, "_checkclose")
	If $close = '1' Then GUICtrlSetState(-1, 1)

	$comstr = GUICtrlCreateButton("cmd", 10, 40, 21, 21, 0x0040)
	GUICtrlSetOnEvent(-1, "_cmd")
	GUICtrlSetTip(-1, "Открыть ком-строку отсюда" & @CRLF & "Для выполнения DOS-команд")
	GUICtrlSetImage(-1, @SystemDir & '\cmd.exe', 1, 0)

	If $ScanPath <> '' And FileExists($ScanPath) Then
		$Scanner = GUICtrlCreateButton("scn", 35, 40, 21, 21, 0x0040)
		GUICtrlSetOnEvent(-1, "_Scanner")
		GUICtrlSetTip(-1, "Открыть в Scanner, для просмотра" & @CRLF & "занимаемого пространтсва на харде")
		GUICtrlSetImage(-1, $ScanPath, 1, 0)
	EndIf

	$Virtcd1 = GUICtrlCreateButton("cd+", 315, 40, 21, 21, 0x0040)
	GUICtrlSetOnEvent(-1, "_Virtcd1")
	GUICtrlSetTip(-1, "Создать виртуальный" & @CRLF & "диск Y: из папки")
	GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 10, 0)

	$Virtcd2 = GUICtrlCreateButton("cd-", 315, 40, 21, 21, 0x0040)
	GUICtrlSetOnEvent(-1, "_Virtcd2")
	GUICtrlSetTip(-1, "Отключить виртуальный" & @CRLF & "диск Y:")
	GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 11, 0)
	_subst()

	If $WinRARPath <> '' And FileExists($WinRARPath) Then
		$winrar = GUICtrlCreateButton("rar", 85, 40, 21, 21, 0x0040)
		GUICtrlSetOnEvent(-1, "_winrar")
		GUICtrlSetTip(-1, "Упаковать с паролем" & @CRLF & "(указан в ini)")
		GUICtrlSetImage(-1, $WinRARPath, 1, 0)
	EndIf

	If $7zipPath <> '' And FileExists($7zipPath & '.exe') Then
		$7zip = GUICtrlCreateButton("7z", 110, 40, 21, 21, 0x0040)
		GUICtrlSetOnEvent(-1, "_7zip")
		GUICtrlSetTip(-1, "Упаковать с паролем" & @CRLF & "(указан в ini)")
		GUICtrlSetImage(-1, $7zipPath & 'FM.exe', 1, 0)
	EndIf

	$compression = GUICtrlCreateButton("prs", 135, 40, 21, 21)
	GUICtrlSetOnEvent(-1, "_compression")
	GUICtrlSetTip(-1, "Применить NTFS-сжатие" & @CRLF & "к папке и её содержимому ")
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlSetBkColor(-1, 0xdddddd)

	$decompression = GUICtrlCreateButton("de", 160, 40, 21, 21)
	GUICtrlSetOnEvent(-1, "_decompression")
	GUICtrlSetTip(-1, "Отменить NTFS-сжатие" & @CRLF & "к папке и её содержимому")
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetBkColor(-1, 0xdddddd)

	GUICtrlCreateGroup("", 7, 65, 296, 33)
	$list = GUICtrlCreateButton("", 10, 74, 21, 21, 0x0040)
	GUICtrlSetOnEvent(-1, "_FileList")
	GUICtrlSetTip(-1, "Создать список файлов")
	GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 2, 0)
	$listfull = GUICtrlCreateCheckbox("Полный путь", 35, 75, 90, 20)
	$subfol = GUICtrlCreateCheckbox("подпапки", 130, 75, 70, 20)
	GUICtrlSetTip(-1, 'Включая вложенные')
	
	GUICtrlCreateLabel("Тип:", 207, 77, 29, 17)
	$Typelist = GUICtrlCreateInput("", 230, 75, 70, 20)
	GUICtrlSetTip(-1, "Список только для" & @CRLF & 'указанных типов файлов' & @CRLF & 'например exe;dll;com' & @CRLF & 'Или маска "Мо*.tx?"')

	GUICtrlCreateGroup("", 7, 100, 296, 36)
	$cacls = GUICtrlCreateButton("Доступ", 10, 110, 90, 24)
	GUICtrlSetOnEvent(-1, "_cacls")
	GUICtrlSetTip(-1, "Можно дать доступ к папке" & @CRLF & "System Volume Information")
	$accfncombo = GUICtrlCreateCombo("", 105, 110, 95, 24)
	GUICtrlSetData(-1, 'Все|Administrator|Admin|Администратор|System|Гость', 'Все')
	GUICtrlSetTip($accfncombo, "Пользователи и группы")
	$access = GUICtrlCreateCombo("", 205, 110, 95, 24, $CBS_DROPDOWNLIST + $WS_VSCROLL)
	GUICtrlSetData(-1, 'запрет|чтение|запись|изменение|полный', 'полный')
	GUICtrlSetTip(-1, "Тип доступа")

	GUICtrlCreateGroup("", 7, 138, 296, 36)
	$dfile = GUICtrlCreateButton("Удалить", 10, 148, 55, 24)
	GUICtrlSetOnEvent(-1, "_Delete")
	GUICtrlSetTip(-1, "Удалить тип файлов," & @CRLF & "разделяя через ;")
	$delcombo = GUICtrlCreateCombo("", 70, 148, 130, 24)
	GUICtrlSetData(-1, $sIniExt, StringLeft($sIniExt, StringInStr($sIniExt & '|', '|') - 1))
	_GUICtrlComboBox_SetDroppedWidth(-1, 227)
	; $checkAtrb = GUICtrlCreateCheckbox("Снять атрибут", 205, 148, 95, 24)
	; GuiCtrlSetState(-1, 1)
	; GUICtrlSetTip($checkAtrb, "Снимать атрибуты файла" & @CRLF & "для возможности его удалить")

	$script = GUICtrlCreateButton("au3", 279, 40, 21, 21, 0x0040)
	GUICtrlSetOnEvent(-1, "_Script_Edit")
	GUICtrlSetTip(-1, "Редактировать скрипт" & @CRLF & "(пароль, пути)")
	GUICtrlSetImage(-1, @AutoItExe, 1, 0)

Else
	; здесь для файлов.
	; начало создания окна, вкладок, кнопок.
	$TrF = 0
	GUICreate($aPath[1], 310, 125) ; размер окна
	GUISetBkColor(0xF9F9F9)
	
	Global $sExt = StringRegExpReplace($sTarget, '^(?:.*\\[^\\]+?)(\.[^.]+)?$', '\1')
	$ico1 = _FileDefaultIcon($sExt)
	If Not @error Then
		Switch UBound($ico1)
			Case 2
				If StringInStr(';.exe;.scr;.ico;.ani;.cur;', ';' & $sExt & ';') Then
					GUISetIcon($sTarget)
				Else
					GUISetIcon($ico1[1])
				EndIf
			Case 3
				If $ico1[2] = '-151' And $sExt = '.ini' And $ico1[1] = 'shell32.dll' Then $ico1[2] = 69
				GUISetIcon($ico1[1], ($ico1[2] + 1) * -1)
		EndSwitch
	EndIf
	GUISetOnEvent(-3, "_Exit")
	$StatusBar = GUICtrlCreateLabel('Строка состояния', 5, 108, 300, 17, 0xC) ; лейбл без автопереноса

	$checkclose = GUICtrlCreateCheckbox("Закрывать диалог при клике на кнопке", 10, 10, 266, 24)
	GUICtrlSetOnEvent(-1, "_checkclose")
	If $close = '1' Then GUICtrlSetState(-1, 1)

	$uninstall = GUICtrlCreateButton("unl", 280, 10, 21, 21, 0x0040)
	GUICtrlSetOnEvent(-1, "_uninstall")
	GUICtrlSetTip(-1, "Удалить регистрацию панельки в реестре" & @CRLF & "соответственно удаление из контекст. меню")
	GUICtrlSetImage(-1, @SystemDir & '\xpsp2res.dll', 1, 0)
	
	$ix = -15
	
	$ix += 25
	$assot = GUICtrlCreateButton("", $ix, 40, 21, 21, 0x0040)
	GUICtrlSetOnEvent(-1, "_assot")
	GUICtrlSetTip(-1, "Открыть каталог" & @CRLF & "ассоциированной программы")
	GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 4, 0)

	$ix += 25
	$JumpRegistry = GUICtrlCreateButton("reg", $ix, 40, 21, 21, 0x0040)
	GUICtrlSetOnEvent(-1, "_JumpRegistry0")
	GUICtrlSetTip(-1, "Прыжок в реестр" & @CRLF & "к регистрации файла")
	GUICtrlSetImage(-1, @WindowsDir & '\regedit.exe', 1, 0)

	$ix += 25
	$Pathfull = GUICtrlCreateButton("", $ix, 40, 21, 21, 0x0040)
	GUICtrlSetOnEvent(-1, "_Pathfull")
	GUICtrlSetTip(-1, "Линк файла в буфер," & @CRLF & "полный путь и имя")
	GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 2, 0)

	If $WinRARPath <> '' And FileExists($WinRARPath) Then
		$ix += 25
		$winrar = GUICtrlCreateButton("rar", $ix, 40, 21, 21, 0x0040)
		GUICtrlSetOnEvent(-1, "_winrar")
		GUICtrlSetTip(-1, "Упаковать с паролем" & @CRLF & "(указан в ini)")
		GUICtrlSetImage(-1, $WinRARPath, 1, 0)
	EndIf

	If $7zipPath <> '' And FileExists($7zipPath & '.exe') Then
		$ix += 25
		$7zip = GUICtrlCreateButton("7z", $ix, 40, 21, 21, 0x0040)
		GUICtrlSetOnEvent(-1, "_7zip")
		GUICtrlSetTip(-1, "Упаковать с паролем" & @CRLF & "(указан в ini)")
		GUICtrlSetImage(-1, $7zipPath & 'FM.exe', 1, 0)
	EndIf

	$ix += 25
	$compression = GUICtrlCreateButton("prs", $ix, 40, 21, 21)
	GUICtrlSetOnEvent(-1, "_compression")
	GUICtrlSetTip(-1, "Применить NTFS-сжатие" & @CRLF & "к файлу ")
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlSetBkColor(-1, 0xdddddd)

	$ix += 25
	$decompression = GUICtrlCreateButton("de", $ix, 40, 21, 21)
	GUICtrlSetOnEvent(-1, "_decompression")
	GUICtrlSetTip(-1, "Отменить NTFS-сжатие" & @CRLF & "к файлу")
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetBkColor(-1, 0xdddddd)

	$ix += 25
	$comfile = GUICtrlCreateButton("Открыть ком-строку отсюда", $ix, 40, 21, 21, 0x0040)
	GUICtrlSetOnEvent(-1, "_comfile")
	GUICtrlSetTip(-1, "Открыть ком-строку отсюда" & @CRLF & "Для выполнения DOS-команд")
	GUICtrlSetImage(-1, @SystemDir & '\cmd.exe', 1, 0)

	GUICtrlCreateGroup("", 7, 65, 296, 37)
	
	$cacls = GUICtrlCreateButton("Доступ", 10, 75, 90, 24)
	GUICtrlSetOnEvent(-1, "_cacls")
	GUICtrlSetTip(-1, "Установить доступ к файлам")
	$accfncombo = GUICtrlCreateCombo("", 105, 75, 95, 24)
	GUICtrlSetData(-1, 'Все|Administrator|Admin|Администратор|System|Гость', 'Все')
	GUICtrlSetTip($accfncombo, "Пользователи и группы")
	$access = GUICtrlCreateCombo("", 210, 75, 90, 24, $CBS_DROPDOWNLIST + $WS_VSCROLL)
	GUICtrlSetData(-1, 'запрет|чтение|запись|изменение|полный', 'полный')
	GUICtrlSetTip($access, "Тип доступа")

	$script = GUICtrlCreateButton("au3", 279, 40, 21, 21, 0x0040)
	GUICtrlSetOnEvent(-1, "_Script_Edit")
	GUICtrlSetTip(-1, "Редактировать скрипт" & @CRLF & "(пароль, пути)")
	GUICtrlSetImage(-1, @AutoItExe, 1, 0)
EndIf

GUISetState()

While 1
	Sleep(100000)
WEnd

Func _cacls()
	Local $access0, $access00, $accfncombo0
	$accfncombo0 = GUICtrlRead($accfncombo)
	$access00 = GUICtrlRead($access)
	Switch $access00
		Case $access00 = "запрет"
			$access0 = "N"
		Case $access00 = "чтение"
			$access0 = "R"
		Case $access00 = "запись"
			$access0 = "W"
		Case $access00 = "изменение"
			$access0 = "C"
		Case $access00 = "полный"
			$access0 = "F"
		Case Else
			$access0 = "F"
	EndSwitch
	ShellExecuteWait(@SystemDir & '\cacls.exe', '"' & $sTarget & '" /t /e /p "' & $accfncombo0 & '":' & $access0, '', '', @SW_HIDE)
	_cc()
	_sb('Изменение доступа выполнено')
EndFunc   ;==>_cacls

Func _Script_Edit()
	Local $Pathexe
	If @Compiled Then
		If FileExists($textedit) Then
			Run('"' & $textedit & '" "' & @ScriptDir & '\contmenu.ini"')
		Else
			$Pathexe = _FileAssociation('.txt')
			If Not @error And FileExists($Pathexe) Then Run('"' & $Pathexe & '" "' & @ScriptDir & '\contmenu.ini"')
		EndIf
	Else
		$Pathexe = StringRegExpReplace(@AutoItExe, '(.*)\\(?:.*)$', '\1')
		If FileExists($Pathexe & '\SciTE\SciTE.exe') Then
			Run('"' & $Pathexe & '\SciTE\SciTE.exe" "' & @ScriptFullPath & '"')
		Else
			If FileExists($textedit) Then
				Run('"' & $textedit & '" "' & @ScriptFullPath & '"')
			Else
				$Pathexe = _FileAssociation('.txt')
				If Not @error And FileExists($Pathexe) Then
					Run('"' & $Pathexe & '" "' & @ScriptFullPath & '"')
				Else
					Run('Notepad.exe "' & @ScriptFullPath & '"')
				EndIf
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_Script_Edit

Func _subst()
	If FileExists("Y:\") Then
		GUICtrlSetPos($Virtcd2, 60, 40)
		GUICtrlSetPos($Virtcd1, 315, 40)
	Else
		GUICtrlSetPos($Virtcd1, 60, 40)
		GUICtrlSetPos($Virtcd2, 315, 40)
	EndIf
EndFunc   ;==>_subst

Func _winrar()
	Local $filename, $i
	_sb('Выполняется...')
	; генерируем имя нового файла с номером копии на случай если файл существует
	$i = 1
	While FileExists($aPath[0] & '\' & $aPath[1] & $i & '.rar')
		$i += 1
	WEnd
	$filename = $aPath[0] & '\' & $aPath[1] & $i & '.rar'
	If Not FileExists($aPath[0] & '\' & $aPath[1] & '.rar') Then $filename = $aPath[0] & '\' & $aPath[1] & '.rar'
	RunWait($WinRARPath & ' a -hp"' & $password & '" -m5  "' & $filename & '" "' & $aPath[1] & '"', '', @SW_HIDE)
	_sb('Готово - "' & StringRegExpReplace($filename, '(?:.*)\\(.*)$', '\1') & '"')
	_cc()
EndFunc   ;==>_winrar

Func _7zip()
	Local $filename, $i
	_sb('Выполняется...')
	; генерируем имя нового файла с номером копии на случай если файл существует
	$i = 1
	While FileExists($aPath[0] & '\' & $aPath[1] & $i & '.7z')
		$i += 1
	WEnd
	$filename = $aPath[0] & '\' & $aPath[1] & $i & '.7z'
	If Not FileExists($aPath[0] & '\' & $aPath[1] & '.7z') Then $filename = $aPath[0] & '\' & $aPath[1] & '.7z'
	RunWait($7zipPath & '.exe a "' & $filename & '" -p"' & $password & '" -mhe -mx9 "' & $aPath[1] & '"', '', @SW_HIDE)
	_sb('Готово - "' & StringRegExpReplace($filename, '(?:.*)\\(.*)$', '\1') & '"')
	_cc()
EndFunc   ;==>_7zip

Func _cc()
	If GUICtrlRead($checkclose) = 1 Then Exit
EndFunc   ;==>_cc

Func _sb($i)
	GUICtrlSetData($StatusBar, $i)
EndFunc   ;==>_sb

Func _checkclose()
	If GUICtrlRead($checkclose) = 1 Then
		RegWrite("HKLM\SOFTWARE\AZJIO_Soft\contmenu", "close", "REG_SZ", "1")
	Else
		RegWrite("HKLM\SOFTWARE\AZJIO_Soft\contmenu", "close", "REG_SZ", "0")
	EndIf
EndFunc   ;==>_checkclose

Func _cmd()
	Run(@SystemDir & '\cmd.exe /k cd "' & $sTarget & '"')
	_cc()
EndFunc   ;==>_cmd

Func _Scanner()
	ShellExecute($ScanPath, '"' & $sTarget & '"', '', '', @SW_HIDE)
	_cc()
EndFunc   ;==>_Scanner

Func _Virtcd1()
	Run(@ComSpec & ' /C subst y: "' & $sTarget & '"', '', @SW_HIDE)
	Sleep(150)
	_subst()
	_cc()
	_sb('Диск Y создан')
EndFunc   ;==>_Virtcd1

Func _Virtcd2()
	Run(@ComSpec & ' /C subst y: /d', '', @SW_HIDE)
	Sleep(150)
	_subst()
	_cc()
	_sb('Диск Y отключен')
EndFunc   ;==>_Virtcd2

Func _compression()
	Local $s = ''
	If $TrF = 1 Then $s = '/s:'
	_sb('Выполняется...')
	RunWait(@ComSpec & ' /C compact /c /i ' & $s & '"' & $sTarget & '"', '', @SW_HIDE)
	_cc()
	_sb('NTFS-сжатие выполнено')
EndFunc   ;==>_compression

Func _decompression()
	Local $s = ''
	If $TrF = 1 Then $s = '/s:'
	_sb('Выполняется...')
	RunWait(@ComSpec & ' /C compact /u /i ' & $s & '"' & $sTarget & '"', '', @SW_HIDE)
	_cc()
	_sb('NTFS-разжатие выполнено')
EndFunc   ;==>_decompression

Func _JumpRegistry0()
	$Type0 = StringTrimLeft($sExt, 1)
	If $Type0 Then
		$TypeNR = RegRead('HKEY_CLASSES_ROOT\.' & $Type0, '')
		If @error Then
			$TypeNR = RegEnumVal('HKEY_CLASSES_ROOT\.' & $Type0 & '\OpenWithProgids', 1)
			If @error Then Return
		EndIf
		$ProgidR = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $Type0, 'Progid')
		If Not @error And $ProgidR Then $TypeNR = $ProgidR
		$sKey = 'HKEY_CLASSES_ROOT\' & $TypeNR & '\shell'
		If _RegExists($sKey & '\open\command') Then
			$sKey &= '\open\command'
		Else
			For $i = 1 To 10
				$NameR = RegEnumKey('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell', $i)
				If @error Then ExitLoop
				If _RegExists($sKey & '\' & $NameR & '\command') Then $sKey &= '\' & $NameR & '\command'
			Next
		EndIf
	Else
		$sKey = 'HKEY_CLASSES_ROOT\*\shell'
	EndIf
	_JumpRegistry($sKey)
	_cc()
	_sb('Прыжок выполнен')
EndFunc   ;==>_JumpRegistry0

Func _RegExists($sKey)
	RegRead($sKey, '')
	Return Not (@error > 0)
EndFunc   ;==>_RegExists

Func _JumpRegistry($sKey)
	Local $hWnd, $hControl, $aKey, $i
	If Not ProcessExists("regedit.exe") Then
		Run(@WindowsDir & '\regedit.exe')
		If Not WinWaitActive('[CLASS:RegEdit_RegEdit]', '', 3) Then Return SetError(1, 1, 1)
	EndIf
	If Not WinActive('[CLASS:RegEdit_RegEdit]') Then WinActivate('[CLASS:RegEdit_RegEdit]')

	$hWnd = WinGetHandle("[CLASS:RegEdit_RegEdit]")
	$hControl = ControlGetHandle($hWnd, "", "[CLASS:SysTreeView32; INSTANCE:1]")

	$aKey = StringSplit($sKey, '\')
	$sKey = '#0'
	For $i = 1 To $aKey[0]
		ControlTreeView($hWnd, "", $hControl, "Expand", $sKey)
		$sKey &= '|' & $aKey[$i]
	Next
	ControlTreeView($hWnd, "", $hControl, "Expand", $sKey)
	ControlTreeView($hWnd, "", $hControl, "Select", $sKey)
EndFunc   ;==>_JumpRegistry

Func _FileList()
	Local $aPath, $file, $folder, $listfull0, $Pathexe, $subfol0, $Text, $timer, $Typelist0
	$Typelist0 = GUICtrlRead($Typelist)
	If GUICtrlRead($subfol) = 1 Then ; поиск в подпапках
		$subfol0 = 125
	Else
		$subfol0 = 0
	EndIf
	If GUICtrlRead($listfull) = 1 Then
		$listfull0 = 1
	Else
		$listfull0 = 2
	EndIf
	$timer = TimerInit()
	$Text = _FO_FileSearch($sTarget, _FO_CorrectMask(StringReplace($Typelist0, ';', '|')), True, $subfol0, $listfull0, 0, 0)
	If @error = 2 Then Return MsgBox(0, 'Сообщение', 'Неверная маска')
	
	If $subfol0 = 0 And ($Typelist0 = '' Or $Typelist0 = '*') Then
		$folder = _FolderSearch1($sTarget)
		If $listfull0 = 2 Then $folder = StringRegExpReplace($folder, '(?m)^(?:.*\\)(.*)$', '\1')
		$Text = $folder & $Text
	EndIf
	
	If $Text = '' Then Return MsgBox(0, 'Сообщение', 'Ничего не найдено')
	_sb('Выполнено за  ' & Round(TimerDiff($timer) / 1000, 1) & ' сек')
	ClipPut($Text)
	$file = FileOpen(@TempDir & '\contmenu_file.txt', 2)
	If $file = -1 Then
		MsgBox(0, "Ошибка", "Не возможно открыть файл.")
		Exit
	EndIf
	FileWrite($file, $Text)
	FileClose($file)
	
	If FileExists($textedit) Then
		Run('"' & $textedit & '" "' & @TempDir & '\contmenu_file.txt"')
	Else
		$Pathexe = _FileAssociation('.txt')
		If Not @error And FileExists($Pathexe) Then
			Run('"' & $Pathexe & '" "' & @TempDir & '\contmenu_file.txt"')
		Else
			Run('Notepad.exe ' & @TempDir & '\contmenu_file.txt')
		EndIf
	EndIf
	_cc()
EndFunc   ;==>_FileList

Func _FolderSearch1($Path)
	Local $FileList = '', $file, $s = FileFindFirstFile($Path & '\*')
	If $s = -1 Then Return ''
	While 1
		$file = FileFindNextFile($s)
		If @error Then ExitLoop
		If @extended Then
			$FileList &= $Path & '\' & $file & @CRLF
		EndIf
	WEnd
	FileClose($s)
	Return $FileList
EndFunc   ;==>_FolderSearch1

Func _Delete()
	Local $aFile, $delcombo0, $i, $kol, $timer, $err
	$delcombo0 = GUICtrlRead($delcombo)
	_sb('Подготавливается список удаления')
	If $delcombo0 = '*Пустые папки' Then
		$aFile = _FO_SearchEmptyFolders($sTarget)
		If @error Then Return _sb('Не найдено')
		$kol = 0
		For $i = 1 To $aFile[0]
			If DirRemove($aFile[$i], 1) Then
				$kol += 1
			Else
				FileSetAttrib($aFile[$i], "-R")
				If DirRemove($aFile[$i], 1) Then
					$kol += 1
				Else
					$err &= $aFile[$i] & @CRLF
				EndIf
			EndIf
			; GUICtrlSetData($StatusBar, $aFile[0]& ' \ ' &$i& ' \ ' &$kol & '  (Общ\текущ\удалено)')
		Next
		_cc()
		_sb('Удалено ' & $kol & ' папок из ' & $aFile[0])
		If $err Then MsgBox(0, 'Неудалённых папок ' & $aFile[0] - $kol, $err)
		Return
	EndIf

	; $timer = TimerInit()
	$aFile = _FO_FileSearch($sTarget, _FO_CorrectMask(StringReplace($delcombo0, ';', '|')), True, 125, 1, 1, 0)
	Switch @error
		Case 2
			Return MsgBox(0, 'Сообщение', 'Неверная маска')
		Case 3
			Return MsgBox(0, 'Сообщение', 'Ничего не найдено')
	EndSwitch
	_sb('Удаляются ' & $aFile[0] & ' файлов.')
	$kol = 0
	For $i = 1 To $aFile[0]
		If FileDelete($aFile[$i]) Then
			$kol += 1
		Else
			FileSetAttrib($aFile[$i], "-RST")
			If FileDelete($aFile[$i]) Then
				$kol += 1
			Else
				$err &= $aFile[$i] & @CRLF
			EndIf
		EndIf
		GUICtrlSetData($StatusBar, $aFile[0] & ' \ ' & $i & ' \ ' & $kol & '  (Общ\текущ\удалено)')
	Next
	_cc()
	_sb('Удалено ' & $kol & ' файлов из ' & $aFile[0])
	If $err Then MsgBox(0, 'Неудалённых файлов ' & $aFile[0] - $kol, $err)
EndFunc   ;==>_Delete

Func _Exit()
	Exit
EndFunc   ;==>_Exit

Func _uninstall()
	RegDelete("HKCR\*\shell\AZJIO_contmenu")
	RegDelete("HKCR\Directory\shell\AZJIO_contmenu")
	RegDelete("HKCR\Drive\shell\AZJIO_contmenu")
	RegDelete("HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shell\AZJIO_contmenu") ; мои документы
	RegDelete("HKLM\SOFTWARE\AZJIO_Soft\contmenu")
	_cc()
EndFunc   ;==>_uninstall

Func _PathFull()
	ClipPut($sTarget)
	_cc()
	GUICtrlSetTip($Pathfull, "Полный путь и имя" & @CRLF & $sTarget)
	_sb('В буфере полный путь к файлу - "' & StringRegExpReplace($sTarget, '(?:.*)\\(.*)$', '\1') & '"')
EndFunc   ;==>_Pathfull

Func _assot()
	Local $Path, $type
	$type = StringRegExpReplace($sTarget, '.*(\.\S+)', '\1')
	$Path = _FileAssociation($type)
	If @error Or Not FileExists($Path) Then
		_sb('Каталог не определён')
		GUICtrlSetPos($assot, 315, 40)
		Return
	Else
		Run('Explorer.exe /select,"' & $Path & '"')
	EndIf
	_cc()
EndFunc   ;==>_assot

Func _FileAssociation($sExt)
	Local $aCall = DllCall("shlwapi.dll", "int", "AssocQueryStringW", _
			"dword", 0x00000040, _ ;$ASSOCF_VERIFY
			"dword", 2, _ ;$ASSOCSTR_EXECUTABLE
			"wstr", $sExt, _
			"ptr", 0, _
			"wstr", "", _
			"dword*", 65536)
	If @error Then Return SetError(1, 0, "")
	If Not $aCall[0] Then
		Return SetError(0, 0, $aCall[5])
	ElseIf $aCall[0] = 0x80070002 Then
		Return SetError(1, 0, "{unknown}")
	ElseIf $aCall[0] = 0x80004005 Then
		Return SetError(1, 0, "{fail}")
	Else
		Return SetError(2, $aCall[0], "")
	EndIf
EndFunc   ;==>_FileAssociation

Func _comfile()
	Local $aPath = StringRegExp($sTarget, "(^.*)\\(.*)$", 3)
	ClipPut($aPath[1])
	Run(@SystemDir & '\cmd.exe /k cd "' & $aPath[0] & '"')
	WinWait("[CLASS:ConsoleWindowClass]")
	Send("!{SPACE}")
	Send("{DOWN 6}")
	Send("{ENTER}")
	Send("{DOWN 2}")
	Send("{ENTER}")
	_cc()
EndFunc   ;==>_comfile

Func _SaveINI()
	$Gui1 = GUICreate('Первый запуск', 320, 300)
	GUISetOnEvent(-3, "_Exit1")
	Global $inpSet[5]
	
	GUICtrlCreateLabel('Укажите путь к WinRAR', 10, 13, 300, 17)
	$inpSet[0] = GUICtrlCreateInput('', 10, 30, 300, 20)
	
	GUICtrlCreateLabel('Укажите путь к 7-Zip', 10, 63, 300, 17)
	$inpSet[1] = GUICtrlCreateInput('', 10, 80, 300, 20)
	
	GUICtrlCreateLabel('Укажите путь к блокноту', 10, 113, 300, 17)
	$inpSet[2] = GUICtrlCreateInput('', 10, 130, 300, 20)
	
	GUICtrlCreateLabel('Укажите путь к Scanner', 10, 163, 300, 17)
	$inpSet[3] = GUICtrlCreateInput('', 10, 180, 300, 20)
	
	GUICtrlCreateLabel('Укажите пароль', 10, 213, 300, 17)
	$inpSet[4] = GUICtrlCreateInput('', 10, 230, 300, 20)
	
	GUICtrlCreateButton('OK', 125, 260, 70, 25)
	GUICtrlSetOnEvent(-1, "_OK")
	
	If FileExists(@ProgramFilesDir & '\WinRAR\WinRAR.exe') Then
		GUICtrlSetData($inpSet[0], @ProgramFilesDir & '\WinRAR\WinRAR.exe')
	Else
		GUICtrlSetData($inpSet[0], 'C:\Program Files\WinRAR\WinRAR.exe')
	EndIf

	If FileExists(@ProgramFilesDir & '\7-Zip\7z.exe') Then
		GUICtrlSetData($inpSet[1], @ProgramFilesDir & '\7-Zip\7z')
	Else
		GUICtrlSetData($inpSet[1], 'C:\Program Files\7-Zip\7z')
	EndIf

	If FileExists(@ProgramFilesDir & '\Notepad++\Notepad++.exe') Then
		GUICtrlSetData($inpSet[2], @ProgramFilesDir & '\Notepad++\Notepad++.exe')
	Else
		GUICtrlSetData($inpSet[2], @SystemDir & '\notepad.exe')
	EndIf

	If FileExists(@ProgramFilesDir & '\Scanner\Scanner.exe') Then
		GUICtrlSetData($inpSet[3], @ProgramFilesDir & '\Scanner\Scanner.exe')
	Else
		GUICtrlSetData($inpSet[3], 'C:\Program Files\Scanner\Scanner.exe')
	EndIf
	
	GUICtrlSetData($inpSet[4], 'my_password')

	GUISetState(@SW_SHOW, $Gui1)
EndFunc   ;==>_SaveINI

Func _OK()
	$file = FileOpen($Ini, 2)
	FileWrite($file, '[set]' & @CRLF & _
			'WinRARPath=' & GUICtrlRead($inpSet[0]) & @CRLF & _
			'7zipPath=' & GUICtrlRead($inpSet[1]) & @CRLF & _
			'password=' & GUICtrlRead($inpSet[2]) & @CRLF & _
			'ScanPath=' & GUICtrlRead($inpSet[3]) & @CRLF & _
			'textedit=' & GUICtrlRead($inpSet[4]) & @CRLF & _
			'Ext=' & $sIniExt0)
	FileClose($file)
	Exit
EndFunc   ;==>_OK

Func _Exit1()
	$file = FileOpen($Ini, 2)
	FileWrite($file, '[set]' & @CRLF & _
			'WinRARPath=' & @CRLF & _
			'7zipPath=' & @CRLF & _
			'password=' & @CRLF & _
			'ScanPath=' & @CRLF & _
			'textedit=')
	FileClose($file)
	Exit
EndFunc   ;==>_Exit1

Func _FileDefaultIcon($sExt)
	If $sExt = '' Or StringInStr($sExt, ':') Then Return SetError(1)

	Local $aCall = DllCall("shlwapi.dll", "int", "AssocQueryStringW", _
			"dword", 0x00000040, _ ;$ASSOCF_VERIFY
			"dword", 15, _ ;$ASSOCSTR_DEFAULTICON
			"wstr", $sExt, _
			"ptr", 0, _
			"wstr", "", _
			"dword*", 65536)

	If @error Then Return SetError(1, 0, "")

	If Not $aCall[0] Then
		$sExt = StringReplace($aCall[5], '"', '')
		$sExt = StringSplit($sExt, ',')
		Opt('ExpandEnvStrings', 1)
		$sExt[1] = $sExt[1]
		Opt('ExpandEnvStrings', 0)
		Return SetError(0, 0, $sExt)
	ElseIf $aCall[0] = 0x80070002 Then
		Return SetError(1, 0, "{unknown}")
	ElseIf $aCall[0] = 0x80004005 Then
		Return SetError(1, 0, "{fail}")
	Else
		Return SetError(2, $aCall[0], "")
	EndIf

EndFunc   ;==>_FileDefaultIcon