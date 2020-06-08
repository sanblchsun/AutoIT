#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Icon_of_folder.exe
#AutoIt3Wrapper_OutFile_X64=Icon_of_folderX64.exe
; #AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_icon=Icon_of_folder.ico
#AutoIt3Wrapper_Compression=n
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Icon_of_folder.exe
#AutoIt3Wrapper_Res_Fileversion=0.4.2.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.4.2
#AutoIt3Wrapper_Res_Field=Build|2011.05.07
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 7.05.2011  (AutoIt3_v3.3.6.1)
#NoTrayIcon
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

; количество иконок и строк
$kol = 24

; En
$LngTitle = 'Icon of folder'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngMs1 = 'Message'
$LngMs3 = 'Amount of the lines in folder_name.txt must be not less ' & $kol
$LngStB = 'StatusBar'
$LngReH = 'Restart "Icon of folder"'
$LngASl = 'Auto determination'
$LngASlH = 'icon is fixed automatically in accordance with list of the names of the folders'
$LngUDl = 'Use DLL'
$LngUDlH = 'The reference on DLL,' & @CRLF & 'differently icon extraction in a folder'
$LngAdd = 'drag-and-drop'
$LngSID = 'Choose Icon ICO, DLL'
$LngSIDH = 'Use Icon one of system DLL or ICO'
$LngApl = 'Apply'
$LngAplH = 'To apply the icon chosen on the right'
$LngClr = 'Clean'
$LngClrH = 'Delete desktop.ini and Desktop.ico from the folder'
$LngUIC = 'Refresh icons'
$LngCTh = 'change theme'
$LngErr = 'Error'
$LngMs4 = 'It is required to throw a folder in a program window'
$LngMs5 = 'Path does not exist'
; $LngMs6='To apply an icon?'
$LngFOD1 = 'Open'
$LngFOD2 = 'To choose DLL'
$LngSb2 = 'The folder is chosen :'
$LngSlDl = 'Choice DLL'
$LngFOD3 = 'Choose a file containing icon'
$LngFOD4 = 'Files with Icon'
$LngFOD5 = 'all'
$NameList = 'Games|Game' & @CRLF & _
		'Films|Clips|Cinema' & @CRLF & _
		'Music' & @CRLF & _
		'Pictures' & @CRLF & _
		'Office|Text|Texts' & @CRLF & _
		'reg' & @CRLF & _
		'wi-fi' & @CRLF & _
		'telephone' & @CRLF & _
		'delete' & @CRLF & _
		'CD-ROM|CD|DVD-ROM|DVD' & @CRLF & _
		'Favorites' & @CRLF & _
		'Internet' & @CRLF & _
		'Soft' & @CRLF & _
		'Tools' & @CRLF & _
		'Documents|MyDocum|MyDocuments' & @CRLF & _
		'Web' & @CRLF & _
		'Windows' & @CRLF & _
		'Script' & @CRLF & _
		'Abstracts' & @CRLF & _
		'Archives' & @CRLF & _
		'Drivers' & @CRLF & _
		'Letter|mail' & @CRLF & _
		'Downloads' & @CRLF & _
		'Folder'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang = DllCall($Lang_dll, "int", "GetUserDefaultUILanguage")
If Not @error Then $UserIntLang = Hex($UserIntLang[0], 4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngTitle = 'Смена иконки папки'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngCopy = 'Копировать'
	$LngMs1 = 'Сообщение'
	$LngMs3 = 'Количество строк в folder_name.txt должно быть не менее ' & $kol
	$LngStB = 'Строка состояния'
	$LngReH = 'Перезапуск утилиты'
	$LngASl = 'Авто определение'
	$LngASlH = 'Иконка назначается автоматически' & @CRLF & 'в соответствии со списком имён папок'
	$LngUDl = 'Использовать DLL'
	$LngUDlH = 'Ссылка на DLL, иначе' & @CRLF & 'извлечение иконки в папку'
	$LngAdd = 'Кинь в окно ' & @CRLF & 'утилиты папку'
	$LngSID = 'Выбрать иконку ICO, DLL'
	$LngSIDH = 'Использовать иконку одной' & @CRLF & 'из системных DLL или ICO'
	$LngApl = 'Применить'
	$LngAplH = 'Применить выбранную' & @CRLF & 'справа иконку'
	$LngClr = 'Очистить'
	$LngClrH = 'Удалить desktop.ini и Desktop.ico' & @CRLF & 'из каталога'
	$LngUIC = 'Обновить кэш иконок'
	$LngCTh = 'Сменить тему'
	$LngErr = 'Ошибка'
	$LngMs4 = 'Требуется кинуть папку в окно программы'
	$LngMs5 = 'Путь не существует'
	; $LngMs6='Применить иконку?'
	$LngFOD1 = 'Открыть'
	$LngFOD2 = 'Выбрать спец-DLL'
	$LngSb2 = 'Выбрана папка :'
	$LngSlDl = 'Выбор DLL'
	$LngFOD3 = 'Выберите файл, содержащий значки'
	$LngFOD4 = 'Со значками'
	$LngFOD5 = 'Все'
	$NameList = 'Игры|Игра|Games|Game' & @CRLF & _
			'Фильмы|Клипы|Кино|Films|Clips|Cinema' & @CRLF & _
			'Музыка|Music' & @CRLF & _
			'Рисунки|Pictures|Графика' & @CRLF & _
			'Офис|Office|Текст|Тексты|Text|Texts' & @CRLF & _
			'reg|реестр' & @CRLF & _
			'сеть|wi-fi' & @CRLF & _
			'телефон|для телефона|сотик' & @CRLF & _
			'удалить|временно|delete' & @CRLF & _
			'CD-ROM|CD|DVD-ROM|DVD' & @CRLF & _
			'Избранное|Favorites' & @CRLF & _
			'Интернет|Инет' & @CRLF & _
			'Программы|Soft' & @CRLF & _
			'Утилиты|Tools' & @CRLF & _
			'Мои документы|Документы|Documents|MyDocum|MyDocuments' & @CRLF & _
			'Web|странички|Web-мастер' & @CRLF & _
			'Windows|Program Files|Documents and Settings' & @CRLF & _
			'Скрипты|Script' & @CRLF & _
			'Рефераты' & @CRLF & _
			'Архивы' & @CRLF & _
			'Драйвера|Drivers' & @CRLF & _
			'Письма' & @CRLF & _
			'Downloads|Загрузки' & @CRLF & _
			'Папка'
EndIf

Global $k = 0

$txt = @ScriptDir & '\folder_name.txt'
If FileExists($txt) Then
	$NameList = FileRead($txt)
Else
	If DriveStatus(StringLeft(@ScriptDir, 3)) <> 'NOTREADY' Then
		$file = FileOpen($txt, 2)
		FileWrite($file, $NameList)
		FileClose($file)
	EndIf
EndIf

$aNameF = StringSplit(StringStripCR($NameList), @LF)
If UBound($aNameF) < $kol + 1 Then
	MsgBox(0, $LngMs1, $LngMs3)
	Exit
EndIf
; #include <Array.au3>
; _ArrayDisplay( $aNameF, "Array 2" )

Global $sFileName, $nIconIndex, $TrAuto = 1, $TrUseDll = 1, $TrIco = 0, $FileDll = 'SHELL32.DLL', $ind = 1
Global $aPath = '', $aEN[1], $F_Ico_Dll = @ScriptDir & '\themes\default.dll';, $themes_name='default.dll'
Global $aIco[$kol + 1][2]

$Gui = GUICreate($LngTitle, 270, 300, -1, -1, -1, $WS_EX_ACCEPTFILES)
$CatchDrop = GUICtrlCreateLabel("", 0, 0, 270, 300)
GUICtrlSetState(-1, 136)

If Not @Compiled Then GUISetIcon(@ScriptDir & '\Icon_of_folder.ico')
$Label = GUICtrlCreateLabel($LngStB, 3, 300 - 18, 264, 17, 0xC)

$About = GUICtrlCreateButton("@", 270 - 40, 2, 18, 20)
GUICtrlSetTip(-1, $LngAbout)
$restart = GUICtrlCreateButton("R", 270 - 20, 2, 18, 20)
GUICtrlSetTip(-1, $LngReH)

$auto = GUICtrlCreateCheckbox($LngASl, 124, 28, 124, 17)
GUICtrlSetState(-1, 1)
GUICtrlSetTip(-1, $LngASlH)
$UseDll = GUICtrlCreateCheckbox($LngUDl, 124, 48, 130, 17)
; GUICtrlSetState(-1, 1)
GUICtrlSetTip(-1, $LngUDlH)

GUICtrlCreateGroup('', 120, 62, 146, 79)
GUICtrlCreateLabel($LngAdd, 127, 74, 135, 48)
GUICtrlSetColor(-1, 0x787878)
GUICtrlSetFont(-1, 15)
$OpFolder = GUICtrlCreateButton('-', 174, 121, 30, 15)
GUICtrlSetFont(-1, 15)

$SelDll = GUICtrlCreateButton($LngSID, 120, 145, 140, 25)
GUICtrlSetTip(-1, $LngSIDH)

$apply = GUICtrlCreateButton($LngApl, 120, 175, 140, 25)
GUICtrlSetTip(-1, $LngAplH)

$Clean = GUICtrlCreateButton($LngClr, 120, 205, 140, 25)
GUICtrlSetTip(-1, $LngClrH)

$Iconcache = GUICtrlCreateButton($LngUIC, 120, 235, 140, 25)

$Ch_Dll = GUICtrlCreateButton($LngCTh, 10, 250, 90, 25)

$w = 10
$h = 0
For $i = 1 To $kol
	If $i > $kol / 2 Then
		$w = 70
		$h = $kol * 10
	EndIf
	$aIco[$i][0] = GUICtrlCreateRadio('', $w + 20, $i * 20 - 10 - $h, 13, 13)
	GUICtrlSetTip(-1, StringReplace($aNameF[$i], '|', ', '))
	$aIco[$i][1] = GUICtrlCreateIcon($F_Ico_Dll, $i, $w, $i * 20 - 12 - $h, 16, 16)
	GUICtrlSetTip(-1, StringReplace($aNameF[$i], '|', ', '))
Next

GUISetState()
While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $Iconcache
			_RebuildShellIconCache()
		Case $Clean
			If Not IsArray($aPath) Then
				MsgBox(0, $LngErr, $LngMs4)
				ContinueLoop
			EndIf
			If Not FileExists($aPath[0] & '\' & $aPath[1]) Then
				MsgBox(0, $LngErr, $LngMs5)
				ContinueLoop
			EndIf
			If FileExists($aPath[0] & '\' & $aPath[1] & '\Desktop.ico') Then
				FileSetAttrib($aPath[0] & '\' & $aPath[1] & '\Desktop.ico', '-RASHT')
				FileDelete($aPath[0] & '\' & $aPath[1] & '\Desktop.ico')
			EndIf
			If FileExists($aPath[0] & '\' & $aPath[1] & '\desktop.ini') Then
				FileSetAttrib($aPath[0] & '\' & $aPath[1] & '\desktop.ini', '-RASHT')
				FileDelete($aPath[0] & '\' & $aPath[1] & '\desktop.ini')
			EndIf
			DllCall("shell32.dll", "none", "SHChangeNotify", "long", '0x8000000', "uint", '0x1000', "ptr", '0', "ptr", '0')
			
		Case $Ch_Dll
			$OpenFile = FileOpenDialog($LngFOD1, @ScriptDir & '\themes', $LngFOD2 & " (*.dll)", 1, "default.dll", $Gui)
			If @error Then ContinueLoop
			$F_Ico_Dll = $OpenFile
			For $i = 1 To $kol
				GUICtrlSetImage($aIco[$i][1], $F_Ico_Dll, $i)
			Next
			; $themes_name=StringRegExpReplace($F_Ico_Dll, '(^.*)\\(.*)$', '\2')
			
		Case $auto
			If GUICtrlRead($auto) = 1 Then
				$TrAuto = 1
			Else
				$TrAuto = 0
			EndIf
			
		Case $UseDll
			If GUICtrlRead($UseDll) = 1 Then
				$TrUseDll = 1
			Else
				$TrUseDll = 0
			EndIf
		Case -13, $OpFolder
			If $msg = -13 Then
				If @GUI_DropId = $CatchDrop Then
					If StringInStr(FileGetAttrib(@GUI_DragFile), "D") = 0 Then
						MsgBox(0, 'Error', 'Only folders')
						ContinueLoop
					Else
						$aPath = StringRegExp(@GUI_DragFile, '(^.*)\\(.*)$', 3)
						GUICtrlSetData($Label, $LngSb2 & ' "' & $aPath[1] & '"')
					EndIf
				EndIf
			ElseIf $msg = $OpFolder Then
				$OpenPath = FileSelectFolder('', '', 3, @WorkingDir, $Gui)
				If @error Then ContinueLoop
				$aPath = StringRegExp($OpenPath, '(^.*)\\(.*)$', 3)
				GUICtrlSetData($Label, $LngSb2 & ' "' & $aPath[1] & '"')
			EndIf
			
			For $i = 1 To $kol ; сброс выбора
				GUICtrlSetState($aIco[$i][0], 4)
			Next
			If $TrAuto = 1 Then
				For $i = 1 To $kol
					If StringInStr('|' & $aNameF[$i] & '|', '|' & $aPath[1] & '|') Then
						GUICtrlSetState($aIco[$i][0], 1)
						ExitLoop
					EndIf
				Next
			Else
				ContinueLoop
			EndIf
			ContinueCase
		Case $apply
			If Not IsArray($aPath) Then
				MsgBox(0, $LngErr, $LngMs4)
				ContinueLoop
			EndIf
			If Not FileExists($aPath[0] & '\' & $aPath[1]) Then
				MsgBox(0, $LngErr, $LngMs5)
				ContinueLoop
			EndIf
			For $i = 1 To $kol
				If GUICtrlRead($aIco[$i][0]) = 1 Then
					_setico($i)
					ExitLoop
				EndIf
			Next
		Case $SelDll
			If Not IsArray($aPath) Then
				MsgBox(0, $LngErr, $LngMs4)
				ContinueLoop
			EndIf
			If Not FileExists($aPath[0] & '\' & $aPath[1]) Then
				MsgBox(0, $LngErr, $LngMs5)
				ContinueLoop
			EndIf
			_SelDLL()
		Case $restart
			_restart()
		Case $About
			_About()
		Case -3
			Exit
	EndSwitch
WEnd

Func _setico($i, $Ico_Dll = $F_Ico_Dll)
	; снимаем атрибуты
	If FileExists($aPath[0] & '\' & $aPath[1] & '\Desktop.ico') Then FileSetAttrib($aPath[0] & '\' & $aPath[1] & '\Desktop.ico', '-RASHT')
	If FileExists($aPath[0] & '\' & $aPath[1] & '\desktop.ini') Then FileSetAttrib($aPath[0] & '\' & $aPath[1] & '\desktop.ini', '-RASHT')
	FileSetAttrib($aPath[0] & '\' & $aPath[1], "-RASHT")
	
	If $TrUseDll = 0 Then
		_ExtractIconToFile($Ico_Dll, $i, $aPath[0] & '\' & $aPath[1] & '\Desktop.ico')
		FileSetAttrib($aPath[0] & '\' & $aPath[1] & '\Desktop.ico', '+RH')
		$info = _
				"[.ShellClassInfo]" & @CRLF & _
				"IconFile=Desktop.ico" & @CRLF & _
				"IconIndex=0" & @CRLF
		; & _
		; "InfoTip=Это подсказка к папке"&@CRLF)
	Else
		; If Not FileExists(@SystemDir&'\'&$themes_name) Then FileCopy($F_Ico_Dll, @SystemDir&'\'&$themes_name, 1)
		$info = _
				"[.ShellClassInfo]" & @CRLF & _
				"IconFile=" & $Ico_Dll & @CRLF & _
				"IconIndex=" & $i - 1 & @CRLF
		; & _
		; "InfoTip=Это подсказка к папке"&@CRLF)
	EndIf
	
	$file = FileOpen($aPath[0] & '\' & $aPath[1] & '\desktop.ini', 2)
	FileWrite($file, $info)
	FileClose($file)
	
	FileSetAttrib($aPath[0] & '\' & $aPath[1], "+S")
	FileSetAttrib($aPath[0] & '\' & $aPath[1] & '\desktop.ini', '+RH')
	; DllCall("shell32.dll", "none", "SHChangeNotify", "long", '0x8000000', "uint", '0x1000', "ptr", '0', "ptr", '0')
	If $TrUseDll = 0 Then
		; _RebuildShellIconCache()
	Else
		DllCall("shell32.dll", "none", "SHChangeNotify", "long", '0x8000000', "uint", '0x1000', "ptr", '0', "ptr", '0')
	EndIf
EndFunc   ;==>_setico

Func _set_ico($sFileName)
	; снимаем атрибуты
	If FileExists($aPath[0] & '\' & $aPath[1] & '\Desktop.ico') Then FileSetAttrib($aPath[0] & '\' & $aPath[1] & '\Desktop.ico', '-RASHT')
	If FileExists($aPath[0] & '\' & $aPath[1] & '\desktop.ini') Then FileSetAttrib($aPath[0] & '\' & $aPath[1] & '\desktop.ini', '-RASHT')
	FileSetAttrib($aPath[0] & '\' & $aPath[1], "-RASHT")
	
	FileCopy($sFileName, $aPath[0] & '\' & $aPath[1] & '\Desktop.ico', 1)
	FileSetAttrib($aPath[0] & '\' & $aPath[1] & '\Desktop.ico', '+RH')
	$info = _
			"[.ShellClassInfo]" & @CRLF & _
			"IconFile=Desktop.ico" & @CRLF & _
			"IconIndex=0" & @CRLF
	; & _
	; "InfoTip=Это подсказка к папке"&@CRLF)
	
	$file = FileOpen($aPath[0] & '\' & $aPath[1] & '\desktop.ini', 2)
	FileWrite($file, $info)
	FileClose($file)
	
	FileSetAttrib($aPath[0] & '\' & $aPath[1], "+S")
	FileSetAttrib($aPath[0] & '\' & $aPath[1] & '\desktop.ini', '+RH')
	; DllCall("shell32.dll", "none", "SHChangeNotify", "long", '0x8000000', "uint", '0x1000', "ptr", '0', "ptr", '0')
	; If $TrUseDll=0 Then _RebuildShellIconCache()
EndFunc   ;==>_set_ico

Func _SelDLL()

	Local $dll[45] = [42, _
			'Последняя', _
			'Библиотека', _
			'System32', _
			'shell32.dll', _
			'wmploc.dll', _
			'xpsp2res.dll', _
			'netshell.dll', _
			'setupapi.dll', _
			'mshtml.dll', _
			'rasdlg.dll', _
			'fontext.dll', _
			'msgina.dll', _
			'zipfldr.dll', _
			'mstask.dll', _
			'url.dll', _
			'shimgvw.dll', _
			'webcheck.dll', _
			'wiashext.dll', _
			'stobject.dll', _
			'mydocs.dll', _
			'moricons.dll', _
			'assot.dll', _
			'imageicons.dll', _
			'mpcicons.dll', _
			'explorer.exe', _
			'iexplore.exe', _
			'sndvol32.exe', _
			'mstsc.exe', _
			'taskmgr.exe', _
			'wmplayer.exe', _
			'wscript.exe', _
			'spider.exe', _
			'regedit.exe', _
			'notepad.exe', _
			'calc.exe', _
			'mspaint.exe', _
			'irprops.cpl', _
			'main.cpl', _
			'mmsys.cpl', _
			'sysdm.cpl', _
			'joy.cpl', _
			'telephon.cpl', _
			'timedate.cpl', _
			'desk.cpl']

	$GP = _ChildCoor($Gui, 320, 330, 1)
	
	$Gui1 = GUICreate($LngSlDl, $GP[2], $GP[3], $GP[0] + 10, $GP[1] + 10, BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	GUISetBkColor(0xdfdee2)
	
	Local $aZ[$dll[0] + 1]
	$w = 13
	$h = 2
	For $i = 1 To $dll[0]
		If $i > 14 Then
			If $i > 28 Then
				$w = 213
				$h = 562
			Else
				$w = 113
				$h = 282
			EndIf
		EndIf
		$aZ[$i] = GUICtrlCreateRadio($dll[$i], $w, $i * 20 - 5 - $h, 95, 20)
		Switch StringRight($dll[$i], 4)
			Case '.dll'
				GUICtrlSetBkColor($aZ[$i], 0xffffb2)
			Case '.exe'
				GUICtrlSetBkColor($aZ[$i], 0xd2ffcc)
			Case '.cpl'
				GUICtrlSetBkColor($aZ[$i], 0xd5c4f3)
			Case Else
				GUICtrlSetBkColor($aZ[$i], 0xceceff)
		EndSwitch
	Next
	GUICtrlSetState($aZ[$ind], 1)

	$StrBut = GUICtrlCreateButton('OK', 208, 299, 91, 28)
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
	GUISetState(@SW_SHOW, $Gui1)
	$dllOpen = ''
	$msg = $Gui1
	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $StrBut
				For $i = 1 To $dll[0]
					If GUICtrlRead($aZ[$i]) = 1 Then
						$dllOpen = $dll[$i]
						$ind = $i
						ExitLoop
					EndIf
				Next
				$msg = $Gui
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				ExitLoop
			Case $msg = -3
				$msg = $Gui
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				Return
		EndSelect
	WEnd

	;Открытие файла библиотеки значков

	$fdr = @SystemDir
	Switch $dllOpen
		Case 'Последняя'
			$fdr = @WorkingDir
			If $TrIco = 0 Then
				$fdr = @SystemDir
				$TrIco = 1
			EndIf
		Case 'Библиотека'
			$fdr = @ScriptDir
		Case 'System32'
			$fdr = @SystemDir
		Case 'explorer.exe'
			$fdr = @WindowsDir
		Case 'iexplore.exe'
			$fdr = @ProgramFilesDir & '\Internet Explorer'
	EndSwitch

	If Not FileExists($fdr & '\' & $dllOpen) Then
		$sFileName = FileOpenDialog($LngFOD3, $fdr, $LngFOD4 & ' (*.dll;*.ocx;*.ico;*.cpl;*.exe;*.icl)|' & $LngFOD5 & ' (*.*)|(*.dll)|(*.ico)|(*.exe)|(*.cpl)|(*.ocx)', 1, $FileDll, $Gui)
		If @error Then Return
		; If Not StringInStr(';.dll;.osx;.ico;.cpl;.exe;.icl;', ';'&StringRight($sFileName, 4)&';') Then $sFileName&='.dll'
		If Not FileExists($sFileName) Then Return
	Else
		$sFileName = $fdr & '\' & $dllOpen
	EndIf

	If StringRight($sFileName, 4) = '.ico' Then
		_set_ico($sFileName)
	Else
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		; Создаёт структуру для хранения индекса иконки
		$stIcon = DllStructCreate("int")
		$stString = DllStructCreate("wchar[260]")
		$structsize = DllStructGetSize($stString) / 2
		DllStructSetData($stString, 1, $sFileName)

		; Запускает PickIconDlg - с порядковым номером '62' для этой функции
		Local $aRes = DllCall("shell32.dll", "int", 62, "hwnd", $Gui, "ptr", DllStructGetPtr($stString), "int", $structsize, "ptr", DllStructGetPtr($stIcon))
		If @error Or Not $aRes[0] Then Return ; нажатие кнопки "Отмена" или закрыть окно

		$sFileName = DllStructGetData($stString, 1)
		$nIconIndex = DllStructGetData($stIcon, 1) ; Получение номера иконки
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		$stIcon = 0
		_setico($nIconIndex + 1, $sFileName)
		$FileDll = StringRegExpReplace($sFileName, '(^.*)\\(.*)$', '\2')
	EndIf
EndFunc   ;==>_SelDLL

;=====================================================================
; извлечение иконки в файл
; http://www.autoitscript.com/forum/index.php?showtopic=74565&st=20&p=670142&#entry670142

Func _ExtractIconToFile($sInFile, $iIcon, $sOutIco, $iPath = 0)
	Local Const $LOAD_LIBRARY_AS_DATAFILE = 0x00000002
	Local Const $RT_ICON = 3
	Local Const $RT_GROUP_ICON = 14
	Local $hInst, $iGN = "", $sData, $sHdr, $aHdr, $iCnt, $Offset, $FO, $FW, $iCrt = 18
	If $iPath = 1 Then $iCrt = 26
	If Not FileExists($sInFile) Then Return SetError(1, 0, 0)
	If Not IsInt($iIcon) Then Return SetError(2, 0, 0)
	$hInst = _LoadLibraryEx($sInFile, $LOAD_LIBRARY_AS_DATAFILE)
	If Not $hInst Then Return SetError(3, 0, 0)
	_ResourceEnumNames($hInst, $RT_GROUP_ICON)
	For $i = 1 To $aEN[0]
		If $i = StringReplace($iIcon, "-", "") Then
			$iGN = $aEN[$i]
			ExitLoop
		EndIf
	Next
	Dim $aEN[1]
	If $iGN = "" Then
		_FreeLibrary($hInst)
		Return SetError(4, 0, 0)
	EndIf
	$sData = _GetIconResource($hInst, $iGN, $RT_GROUP_ICON)
	If @error Then
		_FreeLibrary($hInst)
		Return SetError(5, 0, 0)
	EndIf
	$sHdr = BinaryMid($sData, 1, 6)
	$aHdr = StringRegExp(StringTrimLeft(BinaryMid($sData, 7), 2), "(.{28})", 3)
	$iCnt = UBound($aHdr)
	$Offset = ($iCnt * 16) + 6
	For $i = 0 To $iCnt - 1
		Local $sDByte = Dec(_RB(StringMid($aHdr[$i], 17, 8)))
		$sHdr &= StringTrimRight($aHdr[$i], 4) & _RB(Hex($Offset))
		$Offset += $sDByte
	Next
	For $i = 0 To $iCnt - 1
		$sData = _GetIconResource($hInst, "#" & Dec(_RB(StringRight($aHdr[$i], 4))), $RT_ICON)
		If @error Then
			_FreeLibrary($hInst)
			Return SetError(6, 0, 0)
		EndIf
		$sHdr &= StringTrimLeft($sData, 2)
	Next
	_FreeLibrary($hInst)
	$FO = FileOpen($sOutIco, $iCrt)
	If $FO = -1 Then Return SetError(7, 0, 0)
	$FW = FileWrite($FO, $sHdr)
	If $FW = 0 Then
		FileClose($FO)
		Return SetError(8, 0, 0)
	EndIf
	FileClose($FO)
	Return SetError(0, 0, 1)
EndFunc   ;==>_ExtractIconToFile

; ========================================================================================================
; Internal Helper Functions from this point on
; ========================================================================================================
Func _GetIconResource($hModule, $sResName, $iResType)
	Local $hFind, $aSize, $hLoad, $hLock, $tRes, $sRet
	$hFind = DllCall("kernel32.dll", "int", "FindResourceA", "int", $hModule, "str", $sResName, "long", $iResType)
	If @error Or Not $hFind[0] Then Return SetError(1, 0, 0)
	$aSize = DllCall("kernel32.dll", "dword", "SizeofResource", "int", $hModule, "int", $hFind[0])
	If @error Or Not $aSize[0] Then Return SetError(2, 0, 0)
	$hLoad = DllCall("kernel32.dll", "int", "LoadResource", "int", $hModule, "int", $hFind[0])
	If @error Or Not $hLoad[0] Then Return SetError(3, 0, 0)
	$hLock = DllCall("kernel32.dll", "int", "LockResource", "int", $hLoad[0])
	If @error Or Not $hLock[0] Then
		_FreeResource($hLoad[0])
		Return SetError(4, 0, 0)
	EndIf
	$tRes = DllStructCreate("byte[" & $aSize[0] & "]", $hLock[0])
	If Not IsDllStruct($tRes) Then
		_FreeResource($hLoad[0])
		Return SetError(5, 0, 0)
	EndIf
	$sRet = DllStructGetData($tRes, 1)
	If $sRet = "" Then
		_FreeResource($hLoad[0])
		Return SetError(6, 0, 0)
	EndIf
	_FreeResource($hLoad[0])
	Return $sRet
EndFunc   ;==>_GetIconResource

; Just a Reverse string byte function (smashly style..lol)
Func _RB($sByte)
	Local $aX = StringRegExp($sByte, "(.{2})", 3), $sX = ''
	For $i = UBound($aX) - 1 To 0 Step -1
		$sX &= $aX[$i]
	Next
	Return $sX
EndFunc   ;==>_RB

Func _LoadLibraryEx($sFile, $iFlag)
	Local $aRet = DllCall("Kernel32.dll", "hwnd", "LoadLibraryExA", "str", $sFile, "hwnd", 0, "int", $iFlag)
	Return $aRet[0]
EndFunc   ;==>_LoadLibraryEx

Func _FreeLibrary($hModule)
	DllCall("Kernel32.dll", "hwnd", "FreeLibrary", "hwnd", $hModule)
EndFunc   ;==>_FreeLibrary

Func _FreeResource($hglbResource)
	DllCall("kernel32.dll", "int", "FreeResource", "int", $hglbResource)
EndFunc   ;==>_FreeResource

Func _ResourceEnumNames($hModule, $iType)
	Local $aRet, $xCB
	If Not $hModule Then Return SetError(1, 0, 0)
	$xCB = DllCallbackRegister('___EnumResNameProc', 'int', 'int_ptr;int_ptr;int_ptr;int_ptr')
	$aRet = DllCall('kernel32.dll', 'int', 'EnumResourceNamesW', 'ptr', $hModule, 'int', $iType, 'ptr', DllCallbackGetPtr($xCB), 'ptr', 0)
	DllCallbackFree($xCB)
	If $aRet[0] <> 1 Then Return SetError(2, 0, 0)
	Return SetError(0, 0, 1)
EndFunc   ;==>_ResourceEnumNames

Func ___EnumResNameProc($hModule, $pType, $pName, $lParam)
	Local $aSize = DllCall('kernel32.dll', 'int', 'GlobalSize', 'ptr', $pName), $tBuf
	If $aSize[0] Then
		$tBuf = DllStructCreate('wchar[' & $aSize[0] & ']', $pName)
		ReDim $aEN[UBound($aEN) + 1]
		$aEN[0] += 1
		$aEN[UBound($aEN) - 1] = DllStructGetData($tBuf, 1)
	Else
		ReDim $aEN[UBound($aEN) + 1]
		$aEN[0] += 1
		$aEN[UBound($aEN) - 1] = "#" & $pName
	EndIf
	Return 1
EndFunc   ;==>___EnumResNameProc

; Обновление кэша значков
; Не сработало на WIN7
; engine
; http://www.autoitscript.com/forum/topic/70433-rebuild-shell-icon-cache/page__view__findpost__p__531242

Func _RebuildShellIconCache()
	Local Const $sKeyName = "HKCU\Control Panel\Desktop\WindowMetrics"
	Local Const $sValue = "Shell Icon Size"

	$sDataRet = RegRead($sKeyName, $sValue)
	If @error Then Return SetError(1)

	RegWrite($sKeyName, $sValue, "REG_SZ", $sDataRet + 1)
	If @error Then Return SetError(1)

	$bcA = _BroadcastChange()

	RegWrite($sKeyName, $sValue, "REG_SZ", $sDataRet)

	$bcB = _BroadcastChange()

	If $bcA = 0 Or $bcB = 0 Then Return SetError(1)

	Return
EndFunc   ;==>_RebuildShellIconCache

Func _BroadcastChange()
	Local Const $HWND_BROADCAST = 0xffff
	Local Const $WM_SETTINGCHANGE = 0x1a
	Local Const $SPI_SETNONCLIENTMETRICS = 0x2a
	Local Const $SMTO_ABORTIFHUNG = 0x2

	$bcResult = DllCall("user32.dll", "lresult", "SendMessageTimeout", _
			"hwnd", $HWND_BROADCAST, _
			"uint", $WM_SETTINGCHANGE, _
			"wparam", $SPI_SETNONCLIENTMETRICS, _
			"lparam", 0, _
			"uint", $SMTO_ABORTIFHUNG, _
			"uint", 10000, _
			"dword*", "success")
	If @error Then Return 0

	Return $bcResult[0]
EndFunc   ;==>_BroadcastChange

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

; вычисление координат дочернего окна

Func _ChildCoor($Gui, $w, $h, $c = 0, $d = 0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
			$GP = WinGetPos($Gui), _
			$wgcs = WinGetClientSize($Gui)
	Local $dLeft = ($GP[2] - $wgcs[0]) / 2, _
			$dTor = $GP[3] - $wgcs[1] - $dLeft
	If $c = 0 Then
		$GP[0] = $GP[0] + ($GP[2] - $w) / 2 - $dLeft
		$GP[1] = $GP[1] + ($GP[3] - $h - $dLeft - $dTor) / 2
	EndIf
	If $d > ($aWA[2] - $aWA[0] - $w - $dLeft * 2) / 2 Or $d > ($aWA[3] - $aWA[1] - $h - $dLeft + $dTor) / 2 Then $d = 0
	If $GP[0] + $w + $dLeft * 2 + $d > $aWA[2] Then $GP[0] = $aWA[2] - $w - $d - $dLeft * 2
	If $GP[1] + $h + $dLeft + $dTor + $d > $aWA[3] Then $GP[1] = $aWA[3] - $h - $dLeft - $dTor - $d
	If $GP[0] <= $aWA[0] + $d Then $GP[0] = $aWA[0] + $d
	If $GP[1] <= $aWA[1] + $d Then $GP[1] = $aWA[1] + $d
	$GP[2] = $w
	$GP[3] = $h
	Return $GP
EndFunc   ;==>_ChildCoor

Func _WinAPI_GetWorkingArea()
	Local Const $SPI_GETWORKAREA = 48
	Local $stRECT = DllStructCreate("long; long; long; long")

	Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
	If @error Then Return 0
	If $SPIRet[0] = 0 Then Return 0

	Local $sLeftArea = DllStructGetData($stRECT, 1)
	Local $sTopArea = DllStructGetData($stRECT, 2)
	Local $sRightArea = DllStructGetData($stRECT, 3)
	Local $sBottomArea = DllStructGetData($stRECT, 4)

	Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
	Return $aRet
EndFunc   ;==>_WinAPI_GetWorkingArea

Func _About()
	Local $msg
	$GP = _ChildCoor($Gui, 210, 180)
	GUISetState(@SW_DISABLE, $Gui)
	$font = "Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	GUISetBkColor(0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 210, 63, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 14, 600, -1, $font)
	GUICtrlSetColor(-1, 0xa13d00)
	GUICtrlSetBkColor(-1, 0xfbe13f)
	GUICtrlCreateLabel("-", 2, 64, 268, 1, 0x10)
	
	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.4.2  7.05.2011', 15, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 15, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 52, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 15, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 90, 130, 125, 17)
	GUICtrlSetColor(-1, 0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010-2011', 15, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $msg = $WbMn
				ClipPut('R939163939152')
			Case $msg = -3
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				ExitLoop
		EndSelect
	WEnd
EndFunc   ;==>_About