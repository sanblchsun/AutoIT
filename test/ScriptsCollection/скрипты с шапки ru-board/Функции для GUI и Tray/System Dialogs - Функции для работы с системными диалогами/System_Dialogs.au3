#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
;

#Region Constants and Variables

#Region _FileSelectFolder Constants
;~ Сообщения, формируемые диалогом выбора
Global Const $BFFM_INITIALIZED = 1 ;~ Инициализация диалога завершена
Global Const $BFFM_SELCHANGED = 2 ;~ Выбор пользователем нового каталога
Global Const $BFFM_VALIDATEFAILEDA = 3 ;~ ANSI: в окно редактирования введен некорректный текст
Global Const $BFFM_VALIDATEFAILEDW = 4 ;~ WideChar: в окно редактирования введен некорректный текст
Global Const $BFFM_IUNKNOWN = 5 ;~ При инициализации: передача указателя на экземпляр IUnknown
;~ Сообщения, принимаемые диалогом выбора
Global Const $BFFM_ENABLEOK = $WM_USER + 101 ;~ Включить/выключить кнопку "Ok"
Global Const $BFFM_SETOKTEXT = $WM_USER + 105 ;~ Задать текст кнопки "Ok"
Global Const $BFFM_SETEXPANDED = $WM_USER + 106 ;~ Раскрыть в дереве определенную папку
Global Const $BFFM_SETSTATUSTEXTA = $WM_USER + 100 ;~ ANSI: задать текст статусной строки
Global Const $BFFM_SETSTATUSTEXTW = $WM_USER + 104 ;~ WideChar: задать текст статусной строки
Global Const $BFFM_SETSELECTIONA = $WM_USER + 102 ;~ ANSI: переместить курсор к определенному каталогу в дереве
Global Const $BFFM_SETSELECTIONW = $WM_USER + 103 ;~ WideChar: переместить курсор к определенному каталогу в дереве
;~ Флаг, включающий "новый стиль" диалога
Global Const $BIF_NEWDIALOGSTYLE = 0x40 ;~ Вывести диалоговое окно "нового стиля" (IE 5.0)
;~ Флаги, применимые только для диалога в "старом стиле" (флаг $BIF_NEWDIALOGSTYLE сброшен)
Global Const $BIF_RETURNONLYFSDIRS = 0x1 ;~ Выбирать только объекты файловой системы
Global Const $BIF_STATUSTEXT = 0x4 ;~ Отображение дополнительного текстовое поля
Global Const $BIF_BROWSEFORCOMPUTER = 0x1000 ;~ Выбирать только компьютеры в сетевом окружении
Global Const $BIF_BROWSEFORPRINTER = 0x2000 ;~ Выбирать только принтеры в сетевом окружении
;~ Флаги, применимые только для диалога в "новом стиле" (флаг $BIF_NEWDIALOGSTYLE установлен)
Global Const $BIF_UAHINT = 0x100 ;~ Показывать текст "подсказки", недействителен для флага $BIF_EDITBOX (IE 6.0)
Global Const $BIF_NONEWFOLDERBUTTON = 0x200 ;~ Не отображать кнопку создания нового каталога (IE 6.0)
Global Const $BIF_SHAREABLE = 0x8000 ;~ Отображать специфические сетевые ресурсы: диски, принтеры, задания, etc. (IE 5.0)
;~ Флаги, примененимые к обоим стилям диалога
Global Const $BIF_DONTGOBELOWDOMAIN = 0x2 ;~ Не открывать домены в сетевом окружении
Global Const $BIF_BROWSEINCLUDEFILES = 0x4000 ;~ Позволить выбирать файлы (IE 5.0)
Global Const $BIF_EDITBOX = 0x10 ;~ Включить строку редактирования (IE 4.71)
Global Const $BIF_VALIDATE = 0x20 ;~ Посылать сообщение о наборе недопустимого имени (IE 4.71)
;~ Маска допустимых флагов для диалога "старого стиля"
Global Const $BIF_ALLOLDSTYLEFLAGS = BitOR( _
		$BIF_DONTGOBELOWDOMAIN, $BIF_BROWSEINCLUDEFILES, $BIF_EDITBOX, $BIF_VALIDATE, _
		$BIF_BROWSEFORCOMPUTER, $BIF_BROWSEFORPRINTER, $BIF_RETURNONLYFSDIRS, $BIF_STATUSTEXT)
;~ Маска допустимых флагов для диалога "нового стиля"
Global Const $BIF_ALLNEWSTYLEFLAGS = BitOR($BIF_NEWDIALOGSTYLE, _
		$BIF_DONTGOBELOWDOMAIN, $BIF_BROWSEINCLUDEFILES, $BIF_EDITBOX, $BIF_VALIDATE, _
		$BIF_NONEWFOLDERBUTTON, $BIF_UAHINT, $BIF_SHAREABLE)

Global $sFSF_Files_Filter = ""
#EndRegion _FileSelectFolder Constants
;

#Region _FileDialog Constants
;===============================================================================
;Specifies that the File Name list box allows multiple selections.
;The user can select more than one file at run time by pressing the
;SHIFT key and using the UP ARROW and DOWN ARROW keys to select the desired files.
;When this is done, the FileName property returns a string containing the names of
;all selected files. The names in the string are delimited by spaces.
;===============================================================================
Global Const $cdlOFNAllowMultiselect = 0x200

;===============================================================================
;Specifies that the dialog box prompts the user to create a file that
;doesn't currently exist. This flag automatically sets the cdlOFNPathMustExist
;and cdlOFNFileMustExist flags.
;===============================================================================
Global Const $cdlOFNCreatePrompt = 0x2000

;===============================================================================
;Use the Explorer-like Open A File dialog box template.
;Works with Windows 95, Windows NT 4.0, or later versions.
;===============================================================================
Global Const $cdlOFNExplorer = 0x80000

;===============================================================================
;Indicates that the extension of the returned filename is different from the
;extension specified by the DefaultExt property. This flag isn't set if the
;DefaultExt property is Null, if the extensions match, or if the file has no
;extension.
;This flag value can be checked upon closing the dialog box.
;===============================================================================
Global Const $CdlOFNExtensionDifferent = 0x400

;===============================================================================
;Specifies that the user can enter only names of existing files in the File Name
;text box.
;If this flag is set and the user enters an invalid filename, a warning is
;displayed.
;This flag automatically sets the cdlOFNPathMustExist flag.
;===============================================================================
Global Const $cdlOFNFileMustExist = 0x1000

;===============================================================================
;Causes the dialog box to display the Help button.
;===============================================================================
Global Const $cdlOFNHelpButton = 0x10

;===============================================================================
;Hides the Read Only check box.
;===============================================================================
Global Const $cdlOFNHideReadOnly = 0x4

;===============================================================================
;Use long filenames.
;===============================================================================
Global Const $cdlOFNLongNames = 0x200000

;===============================================================================
;Forces the dialog box to set the current directory to what it was when the
;dialog box was opened.
;===============================================================================
Global Const $cdlOFNNoChangeDir = 0x8

;===============================================================================
;Do not dereference shell links (also known as shortcuts). By default, choosing
;a shell link causes it to be dereferenced by the shell.
;===============================================================================
Global Const $CdlOFNNoDereferenceLinks = 0x100000

;===============================================================================
;No long file names.
;===============================================================================
Global Const $cdlOFNNoLongNames = 0x40000

;===============================================================================
;Specifies that the returned file won't have the Read Only attribute set and
;won't be in a write-protected directory.
;===============================================================================
Global Const $CdlOFNNoReadOnlyReturn = 0x8000

;===============================================================================
;Specifies that the common dialog box allows invalid characters in the returned
;filename.
;===============================================================================
Global Const $cdlOFNNoValidate = 0x100

;===============================================================================
;Causes the Save As dialog box to generate a message box if the selected file
;already exists.
;The user must confirm whether to overwrite the file.
;===============================================================================
Global Const $cdlOFNOverwritePrompt = 0x2

;===============================================================================
;Specifies that the user can enter only valid paths.
;If this flag is set and the user enters an invalid path, a warning message is
;displayed.
;===============================================================================
Global Const $cdlOFNPathMustExist = 0x800

;===============================================================================
;Causes the Read Only check box to be initially checked when the dialog box is
;created.
;This flag also indicates the state of the Read Only check box when the dialog
;box is closed.
;===============================================================================
Global Const $cdlOFNReadOnly = 0x1

;===============================================================================
;Specifies that sharing violation errors will be ignored
;===============================================================================
Global Const $cdlOFNShareAware = 0x4000

Global $DialogError
#EndRegion _FileDialog Constants
;

#Region _RestartDialog Constants
Global Const $EWX_LOGOFF = 0
Global Const $EWX_SHUTDOWN = 1
Global Const $EWX_REBOOT = 2
Global Const $EWX_FORCE = 4
Global Const $EWX_POWEROFF = 8
Global Const $EWX_FORCEIFHUNG = 16
#EndRegion _RestartDialog Constants
;

#Region _EmptyRecycleBin Constants
Global Const $SHERB_NOCONFIRMATION = 0x00000001
Global Const $SHERB_NOPROGRESSUI = 0x00000002
Global Const $SHERB_NOSOUND = 0x00000004
#EndRegion _EmptyRecycleBin Constants
;
#EndRegion Constants and Variables
;

;~ System Message Box Dialog.
Func _MsgBox($MsgBoxType, $MsgBoxTitle, $MsgBoxText, $Main_GUI = 0)
	Local $aRet = DllCall("user32.dll", "int", "MessageBoxW", _
			"hwnd", $Main_GUI, _
			"wstr", $MsgBoxText, _
			"wstr", $MsgBoxTitle, _
			"int", $MsgBoxType)
	
	Return $aRet[0]
EndFunc ;==>_MsgBox

;~ В этом варианте (это касается и следующей функции) можно использовать круглые скобки для "отображаемой части фильтра"...
;~ В самом же фильтре круглые скобки больше не нужны!
;~ Синтаксис:
;~ "Видимый_текст_1|Файловый_фильтр_1|текст_2|фильтр_2|текст_N|фильтр_N"
Func _FileSaveDialog($sTitle, $sInitDir, $sFilter = 'All (*.*)|*.*', $iOpt = 0, $sDefFile = '', $sDefExt = '', $iDefFilter = 1, $hWnd = 0)
	Local $iFileLen = 32768 ; Max chars in returned string
	
	; API flags prepare
	Local $iFlag = BitOR(BitShift(BitAND($iOpt, 2), -10), BitShift(BitAND($iOpt, 16), 3))
	
	; Filter string to array convertion
	If Not StringInStr($sFilter, '|') Then $sFilter &= '|*.*'
	$sFilter = StringRegExpReplace($sFilter, '|+', '|')
	
	Local $asFLines = StringSplit($sFilter, '|')
	Local $i, $suFilter = ''

	For $i = 1 To $asFLines[0] Step 2
		If $i < $asFLines[0] Then _
				$suFilter &= 'wchar[' & StringLen($asFLines[$i]) + 1 & '];wchar[' & StringLen($asFLines[$i + 1]) + 1 & '];'
	Next
	
	; Create API structures
	Local $uOFN = DllStructCreate('dword;int;int;ptr;ptr;dword;dword;ptr;dword' & _
			';ptr;int;ptr;ptr;dword;short;short;ptr;ptr;ptr;ptr;ptr;dword;dword')
	Local $usTitle = DllStructCreate('wchar[' & StringLen($sTitle) + 1 & ']')
	Local $usInitDir = DllStructCreate('wchar[' & StringLen($sInitDir) + 1 & ']')
	Local $usFilter = DllStructCreate($suFilter & 'wchar')
	Local $usFile = DllStructCreate('wchar[' & $iFileLen & ']')
	Local $usExtn = DllStructCreate('wchar[' & StringLen($sDefExt) + 1 & ']')
	
	For $i = 1 To $asFLines[0]
		DllStructSetData($usFilter, $i, $asFLines[$i])
	Next
	
	; Set Data of API structures
	DllStructSetData($usTitle, 1, $sTitle)
	DllStructSetData($usInitDir, 1, $sInitDir)
	DllStructSetData($usFile, 1, $sDefFile)
	DllStructSetData($usExtn, 1, $sDefExt)
	DllStructSetData($uOFN, 1, DllStructGetSize($uOFN))
	DllStructSetData($uOFN, 2, $hWnd)
	DllStructSetData($uOFN, 4, DllStructGetPtr($usFilter))
	DllStructSetData($uOFN, 7, $iDefFilter)
	DllStructSetData($uOFN, 8, DllStructGetPtr($usFile))
	DllStructSetData($uOFN, 9, $iFileLen)
	DllStructSetData($uOFN, 12, DllStructGetPtr($usInitDir))
	DllStructSetData($uOFN, 13, DllStructGetPtr($usTitle))
	DllStructSetData($uOFN, 14, $iFlag)
	DllStructSetData($uOFN, 17, DllStructGetPtr($usExtn))
	DllStructSetData($uOFN, 23, BitShift(BitAND($iOpt, 32), 5))
	
	; Call API function
	Local $aRet = DllCall('comdlg32.dll', 'int', 'GetSaveFileNameW', 'ptr', DllStructGetPtr($uOFN))
	If Not IsArray($aRet) Or Not $aRet[0] Then Return SetError(1, 0, "")
	
	;Return Results
	Local $sRet = StringStripWS(DllStructGetData($usFile, 1), 3)
	Return SetExtended(DllStructGetData($uOFN, 7), $sRet) ;@extended is the 1-based index of selected filter
EndFunc ;==>_FileSaveDialog

Func _FileOpenDialog($sTitle, $sInitDir, $sFilter = 'All (*.*)|*.*', $iOpt = 0, $sDefFile = '', $sDefExt = '', $iDefFilter = 1, $hWnd = 0)
	Local $iFileLen = 65536 ; Max chars in returned string
	
	; API flags prepare
	Local $iFlag = BitOR( _
			BitShift(BitAND($iOpt, 1), -12), BitShift(BitAND($iOpt, 2), -10), BitShift(BitAND($iOpt, 4), -7), _
			BitShift(BitAND($iOpt, 8), -10), BitShift(BitAND($iOpt, 4), -17))
	
	; Filter string to array convertion
	If Not StringInStr($sFilter, '|') Then $sFilter &= '|*.*'
	$sFilter = StringRegExpReplace($sFilter, '|+', '|')
	
	Local $asFLines = StringSplit($sFilter, '|')
	Local $i, $suFilter = ''

	For $i = 1 To $asFLines[0] Step 2
		If $i < $asFLines[0] Then _
				$suFilter &= 'wchar[' & StringLen($asFLines[$i]) + 1 & '];wchar[' & StringLen($asFLines[$i + 1]) + 1 & '];'
	Next
	
	; Create API structures
	Local $uOFN = DllStructCreate('dword;int;int;ptr;ptr;dword;dword;ptr;dword' & _
			';ptr;int;ptr;ptr;dword;short;short;ptr;ptr;ptr;ptr;ptr;dword;dword')
	Local $usTitle = DllStructCreate('wchar[' & StringLen($sTitle) + 1 & ']')
	Local $usInitDir = DllStructCreate('wchar[' & StringLen($sInitDir) + 1 & ']')
	Local $usFilter = DllStructCreate($suFilter & 'wchar')
	Local $usFile = DllStructCreate('wchar[' & $iFileLen & ']')
	Local $usExtn = DllStructCreate('wchar[' & StringLen($sDefExt) + 1 & ']')
	
	For $i = 1 To $asFLines[0]
		DllStructSetData($usFilter, $i, $asFLines[$i])
	Next
	
	; Set Data of API structures
	DllStructSetData($usTitle, 1, $sTitle)
	DllStructSetData($usInitDir, 1, $sInitDir)
	DllStructSetData($usFile, 1, $sDefFile)
	DllStructSetData($usExtn, 1, $sDefExt)
	DllStructSetData($uOFN, 1, DllStructGetSize($uOFN))
	DllStructSetData($uOFN, 2, $hWnd)
	DllStructSetData($uOFN, 4, DllStructGetPtr($usFilter))
	DllStructSetData($uOFN, 7, $iDefFilter)
	DllStructSetData($uOFN, 8, DllStructGetPtr($usFile))
	DllStructSetData($uOFN, 9, $iFileLen)
	DllStructSetData($uOFN, 12, DllStructGetPtr($usInitDir))
	DllStructSetData($uOFN, 13, DllStructGetPtr($usTitle))
	DllStructSetData($uOFN, 14, $iFlag)
	DllStructSetData($uOFN, 17, DllStructGetPtr($usExtn))
	DllStructSetData($uOFN, 23, BitShift(BitAND($iOpt, 32), 5))
	
	; Call API function
	Local $aRet = DllCall('comdlg32.dll', 'int', 'GetOpenFileNameW', 'ptr', DllStructGetPtr($uOFN))
	If Not IsArray($aRet) Or Not $aRet[0] Then Return SetError(1, 0, "")
	
	If BitAND($iOpt, 4) Then
		$i = 1
		
		While 1
			If Binary(DllStructGetData($usFile, 1, $i)) = 0 Then
				If Binary(DllStructGetData($usFile, 1, $i + 1)) = 0 Then ExitLoop
				DllStructSetData($usFile, 1, '|', $i)
			EndIf
			
			$i += 1
		WEnd
	EndIf
	
	Local $sRet = StringStripWS(DllStructGetData($usFile, 1), 3)
	Return SetExtended(DllStructGetData($uOFN, 7), $sRet)
EndFunc ;==>_FileOpenDialog

;~ Список принимаемых параметров:
;~	$sText - текст приглашения;
;~	$iRoot - код корневого каталога (0 - "рабочий стол");
;~	$iFlags - набор флагов;
;~	$sInitDir - стартовый каталог;
;~	$hWnd - хэндл родительского окна;
;~	$sCallbackProc - имя CallBack-процедуры
Func _FileSelectFolder($sText = '', $iRoot = 0, $iFlags = 0, $sInitDir = @ScriptDir, $hWnd = 0, $sCallbackProc = '_FileSFCallbackProc')
	Local $pidl, $iRes = '', $pCallbackProc = 0, $iMask = $BIF_ALLOLDSTYLEFLAGS, $Error = 0
	; Контроль входных параметров
	;$sInitDir = StringRegExpReplace($sInitDir, '([^\\])\\*$', '\1\\')
	;If StringRight($sInitDir, 1)=':' Then $sInitDir &= '\'
	If BitAND($iFlags, $BIF_NEWDIALOGSTYLE) Then $iMask = $BIF_ALLNEWSTYLEFLAGS
	; Создание и инициализация основных структур данных
	Local $uBI = DllStructCreate("hwnd;ptr;ptr;ptr;int;ptr;ptr;int") ; BROWSEINFO
	Local $uTX = DllStructCreate("wchar[260];wchar") ; Текст приглашения
	Local $uMP = DllStructCreate("wchar[260]") ; MAX_PATH
	Local $uCB = DllStructCreate("wchar[260];int") ; CallBack структура
	DllStructSetData($uTX, 1, $sText)
	DllStructSetData($uCB, 1, $sInitDir)
	DllStructSetData($uCB, 2, $iFlags)
	; Заполнение структуры BROWSEINFO
	DllStructSetData($uBI, 1, $hWnd)
	DllStructSetData($uBI, 3, DllStructGetPtr($uMP))
	DllStructSetData($uBI, 4, DllStructGetPtr($uTX))
	DllStructSetData($uBI, 5, BitAND($iFlags, $iMask))
	DllStructSetData($uBI, 7, DllStructGetPtr($uCB))
	; Получение указателя на CallBack-функцию
	If $sCallbackProc <> '' Then $pCallbackProc = DllCallbackRegister($sCallbackProc, 'int', 'hwnd;int;long;ptr')
	If @error Then Return SetError(2, @error, '') ; ОШИБКА получения указателя
	DllStructSetData($uBI, 6, DllCallbackGetPtr($pCallbackProc))
	; Получение указателя на корневую папку (PIDL)
	Local $iRet = DllCall("shell32.dll", "ptr", "SHGetSpecialFolderLocation", _
			"int", 0, "int", $iRoot, "ptr", DllStructGetPtr($uBI, 2))
	If $iRet[0] = 0 Then
		; Запуск системного диалога
		$pidl = DllCall("shell32.dll", "ptr", "SHBrowseForFolderW", "ptr", DllStructGetPtr($uBI))
		$iRes = DllStructGetData($uMP, 1) ; сохраняем имя объекта
		If $pidl[0] Then
			; Обработка полученного указателя (PIDL)
			$iRet = DllCall("shell32.dll", "int", "SHGetPathFromIDListW", "ptr", $pidl[0], "ptr", DllStructGetPtr($uMP))
			If $iRet[0] Then $iRes = DllStructGetData($uMP, 1)
			DllCall("ole32.dll", "int", "CoTaskMemFree", "ptr", $pidl[0]) ; чистим за собой
		Else
			$Error = 1
		EndIf
		DllCall("ole32.dll", "int", "CoTaskMemFree", "ptr", DllStructGetData($uBI, 2)) ; чистим за собой
	Else
		SetError(1, 0, '') ; ОШИБКА в параметре корневой папки
	EndIf
	If $pCallbackProc Then DllCallbackFree($pCallbackProc) ; закрытие указателя
	Return SetError($Error, 0, $iRes)
EndFunc ;==> _FileSelectFolder

; Функция обратного вызова для _FileSelectFolder по умолчанию
Func _FileSFCallbackProc($hWnd, $iMsg, $wParam, $lParam)
	Local $uTB = DllStructCreate("wchar[260];ptr"), $uCB = DllStructCreate("wchar[260];int", $lParam)
	Local Const $iFSF_Flags = BitOR($BIF_NEWDIALOGSTYLE, $BIF_RETURNONLYFSDIRS)
	Local $aRet, $iTst_Flags = BitXOR(BitAND(DllStructGetData($uCB, 2), $iFSF_Flags), $iFSF_Flags)
	Local $sFiles_Split = StringSplit($sFSF_Files_Filter, "|")
	Local $iEnable_OK = 0
	
	Switch $iMsg
		Case $BFFM_INITIALIZED
			DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", $BFFM_SETSELECTIONW, "int", 1, _
				"ptr", DllStructGetPtr($uCB, 1))
			
			$aRet = DllCall("shell32.dll", "int", "SHParseDisplayNameW", _
				"wstr", DllStructGetData($uCB, 1), "ptr", 0, "ptr", DllStructGetPtr($uTB, 2), "int", 0, "ptr", 0)
			
			If IsArray($aRet) And $aRet[0] = 0 Then
				_FileSFCallbackProc($hWnd, $BFFM_SELCHANGED, DllStructGetData($uTB, 2), $lParam)
				DllCall("ole32.dll", "int", "CoTaskMemFree", "ptr", DllStructGetData($uTB, 2)) ; Cleaning
			EndIf
			
			Local $sCurrent_Path = DllStructGetData($uCB, 1)
			
			For $i = 1 To $sFiles_Split[0]
				If FileExists($sCurrent_Path & "\" & $sFiles_Split[$i]) Then
					$iEnable_OK = 1
					ExitLoop
				EndIf
			Next
			
			DllCall("User32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", $BFFM_ENABLEOK, "int", 0, "ptr", $iEnable_OK)
		Case $BFFM_SELCHANGED
			If $iTst_Flags = 0 Then
				$aRet = DllCall("shell32.dll", "int", "SHGetPathFromIDListW", "ptr", $wParam, "ptr", DllStructGetPtr($uTB, 1))
				
				If IsArray($aRet) Then
					Local $sPrompt_Data = StringRegExpReplace(ControlGetText($hWnd, "", "Static1"), "(?i)(?s)(\r\n)+.*$", "")
					Local $sCurrent_Path = DllStructGetData($uTB, 1)
					
					If $sCurrent_Path = "" Then
						$sCurrent_Path = StringSplit(ControlTreeView($hWnd, "", "SysTreeView321", "GetSelected"), "|")
						$sCurrent_Path = $sCurrent_Path[$sCurrent_Path[0]]
					EndIf
					
					If $sFSF_Files_Filter <> "" Then
						For $i = 1 To $sFiles_Split[0]
							If FileExists($sCurrent_Path & "\" & $sFiles_Split[$i]) Then
								$iEnable_OK = 1
								ExitLoop
							EndIf
						Next
					ElseIf $aRet[0] Then
						$iEnable_OK = 1
					EndIf
					
					DllCall("User32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", $BFFM_ENABLEOK, "int", 0, "ptr", $iEnable_OK)
					
					;Local $aLabel_Pos = ControlGetPos($hWnd, "", "Static1")
					;Local $iTextLen = Number($aLabel_Pos[2] - 230)
					
					ControlSetText($hWnd, "", "Static1", $sPrompt_Data & @CRLF & @CRLF & _StringGetShortString($sCurrent_Path, 50))
				EndIf
			EndIf
	EndSwitch
EndFunc ;==> __FileSFCallbackProc

;Open Dialog to pick an icon of certain file.
Func _PickIconDlg($sFileName, $nIconIndex = 0, $hWnd = 0)
	Local $nRet, $aRetArr[2]
	
	$nRet = DllCall("shell32.dll", "int", "PickIconDlg", _
			"hwnd", $hWnd, _
			"wstr", $sFileName, "int", 1000, "int*", $nIconIndex)
	
	If Not $nRet[0] Then Return SetError(1, 0, -1)
	
	$aRetArr[0] = $nRet[2]
	$aRetArr[1] = $nRet[4]
	
	Return $aRetArr
EndFunc

;Function to Open System dialog using "MSComDlg.CommonDialog" COM object (allows to select and return a *.lnk file).
Func _FileDialog($s_Caption, $s_InitDir = "", $s_FileName = "", $s_Filter = "All (*.*)|*.*", $i_FilterIndex = 1, $i_Flags = 512, $ShowSave = 0)
	$DialogError = 0
	Local $OpenDialog = ObjCreate("MSComDlg.CommonDialog")
	$DialogError = ObjEvent("AutoIt.Error", "DialogErrFunc") ; Initialize a COM error handler
	
	;===============================================================================
	; For description of the filter format, see:
	; http://msdn.microsoft.com/library/en-us/cmdlg98/html/vbproFilter.asp
	;===============================================================================
	
	With $OpenDialog; set the dialog's properties
		.DialogTitle = $s_Caption
		
		.Filter = $s_Filter; Set my filter
		.FilterIndex = $i_FilterIndex; Default position in the above filter
		.MaxFileSize = 260
		.CancelError = 1
		.Flags = $i_Flags
		.Filename = $s_FileName
		.InitDir = $s_InitDir
		If $ShowSave Then
			.ShowSave
		Else
			.ShowOpen; This will display the Open File Dialog
		EndIf
		
		$s_FileName = .FileName; Assign the filename selected to a variable.
	EndWith
	
	$OpenDialog = 0
	If Not @error Then Return $s_FileName
	Return ""
EndFunc

;==================================================================
; _RestartDialog: Display Restart dialog window
;==================================================================
Func _RestartDialog($sPrompt = '', $iFlag = 2, $hWnd = 0)
	Local $sStrType = "str"
	If @OSTYPE = "WIN32_NT" Then $sStrType = "wstr"
	
	If $sPrompt <> '' Then $sPrompt &= @CRLF & @CRLF
	Local $aRet = DllCall("Shell32.dll", "int", "RestartDialog", "hwnd", $hWnd, $sStrType, $sPrompt, "int", $iFlag)
	
	Return $aRet[0]
EndFunc

;==================================================================
; _EmptyRecycleBin: Empty Recycle Bin :)
;==================================================================
Func _EmptyRecycleBin($sPath = '', $iFlag = 0, $hWnd = 0)
	Local $iLen = 256
	Local $sCharType = "char"
	If @OSTYPE = "WIN32_NT" Then $sCharType = "wchar"
	
	Local $usPath = DllStructCreate($sCharType & "[" & $iLen & "]")
	DllStructSetData($usPath, 1, $sPath & @CRLF)
	
	Local $aRet = DllCall("shell32.dll", "int", "SHEmptyRecycleBin", "hwnd", $hWnd, "ptr", _
			DllStructGetData($usPath, 1), "dword", $iFlag)
	
	Return $aRet[0]
EndFunc

;==================================================================
; _ShellAboutBox: Display Shellabout dialog window
;==================================================================
Func _ShellAboutDialog($sTitle, $sText, $hWnd = 0)
	Local $iLen = 256
	Local $sCharType = "char"
	Local $sStrType = "str"
	
	If @OSTYPE = "WIN32_NT" Then
		$sCharType = "wchar"
		$sStrType = "wstr"
	EndIf
	
	Local $usTitle = DllStructCreate($sCharType & "[" & $iLen & "]")
	Local $usText = DllStructCreate($sCharType & "[" & $iLen & "]")
	
	DllStructSetData($usTitle, 1, $sTitle)
	DllStructSetData($usText, 1, $sText)
	
	DllCall("shell32.dll", "int", "ShellAbout", _
			"hwnd", $hWnd, _
			$sStrType, DllStructGetData($usTitle, 1), _
			$sStrType, DllStructGetData($usText, 1), "ptr", 0)
EndFunc

;===============================================================================
; This is custom defined error handler
;===============================================================================
Func DialogErrFunc()
	SetError(1) ; to check for after this function returns
EndFunc

Func _StringGetShortString($sString, $iMax_Ret_Lenght = 30)
	If StringLen($sString) < $iMax_Ret_Lenght Then Return $sString
	
	If $iMax_Ret_Lenght <= 4 Then $iMax_Ret_Lenght = 5
	Local $iSide_Lenght = Round(($iMax_Ret_Lenght / 2) - 2, 0)
	
	Local $sLeft_Side = StringStripWS(StringLeft($sString, $iSide_Lenght), 3)
	Local $sRight_Side = StringStripWS(StringRight($sString, $iSide_Lenght), 3)
	
	Return $sLeft_Side & "...." & $sRight_Side
EndFunc
