#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=ConverterCMD.exe
#AutoIt3Wrapper_icon=ConverterCMD.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=ConverterCMD.exe
#AutoIt3Wrapper_Res_Fileversion=0.7.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.7
#AutoIt3Wrapper_Res_Field=Build|2011.11.01
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#Obfuscator_Ignore_Variables=$TrEcho, $TrNoCode, $TrB_KW, $TrB_Var, $Tri_Com, $TrCB, $TrBB, $TrEn, $TrCheck, $tmpNoCode, $tmpB_KW, $tmpB_Var, $tmpi_Com, $tmpCB, $tmpBB, $tmpEn, $tmpCheck, $tmpEcho
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 01.11.2011 (AutoIt3_v3.3.6.1)
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <ComboConstants.au3>
#Include <Array.au3>

#NoTrayIcon
Global $TrEn, $tmpEn, $TrCB, $tmpCB, $TrBB, $tmpBB, $TrSB, $TrNoCode, $TrB_KW, $TrB_Var, $Tri_Com, $tmpNoCode, $tmpB_KW, $tmpB_Var, $tmpi_Com, _
$aWord, $kOperator, $k0=0, $type, $TrVarCn=0, $Timer, $iCNT, $iDEL, $aRoot, $tmpCheck, $TrCheck, $tmpEcho, $TrEcho, $ChecHTML, $TrSvErr=0, _
$ini=@ScriptDir&'\ConverterCMD.ini', $CurPath, $tmp, $Xpos, $Ypos, $Tr7=0
Global $BACKGROUND, $BKGRD2, $BORDER, $DEFAULT, $COMMENT, $KEYWORDS, $LABEL, $HIDESYBOL, $COMMAND, $VARIABLE, $OPERATOR
Global $SysExe='Append|Arp|At|Atmadm|Attrib|Bootcfg|Cacls|Chkdsk|Chkntfs|Cipher|Cmd|Cmstp|Comp|Compact|Convert|CScript|Defrag|DiskPart|Doskey|Driverquery|Eventcreate|Eventtriggers|Exe2bin|Expand|Explorer|Find|Findstr|Finger|Fsutil|Ftp|Getmac|Gpresult|Gpupdate|Help|Hostname|Ipconfig|Ipxroute|Label|Lodctr|Logman|Lpq|Lpr|Mmc|Mountvol|Msiexec|Nbtstat|Net|Netsh|Netstat|Nslookup|Ntbackup|Ntsd|Openfiles|Pathping|Pentnt|Perfmon|Ping|Print|Rasdial|Rcp|Recover|Reg|Regsvr32|Relog|Replace|Reset|Rexec|Route|Rsh|Rsm|Runas|Rundll32|Secedit|Setver|Sfc|Share|Shutdown|Sort|Subst|Systeminfo|xcopy|taskkill|imagex|imdisk|nircmd|upx|setenv'
Global $Word='assign|assoc|break|call|cd|chcp|chdir|cls|cmdextversion|copy|date|defined|del|dir|diskcomp|diskcopy|do|echo|else|endlocal|erase|errorlevel|exist|exit|fc|for|format|ftype|goto|graftabl|graphics|if|in|md|mkdir|mode|more|move|not|nul|path|pause|popd|prompt|pushd|rd|ren|rename|rmdir|set|setlocal|shift|start|time|title|to|tree|type|ver|verify|vol|eol|skip|delims|tokens|usebackq'

Switch @OSVersion
	Case 'WIN_VISTA', 'WIN_7'
		$Tr7=1
EndSwitch

If Not FileExists($ini) Then
	$file = FileOpen($ini,2)
	FileWrite($file, '[Set]' &@CRLF& _
	'CB=1' &@CRLF& _
	'BB=1' &@CRLF& _
	'NoCode=4' &@CRLF& _
	'B_KW=1' &@CRLF& _
	'B_Var=1' &@CRLF& _
	'i_Com=1' &@CRLF& _
	'Check=1' &@CRLF& _
	'Echo=1' &@CRLF& _
	'En=4' &@CRLF& _
	'Topmost=4' &@CRLF& _
	'X=' &@CRLF& _
	'Y=' &@CRLF& _
	'SB="из ini"' &@CRLF& _
	'SysExe="'&$SysExe&'"' &@CRLF& _
	'Operator="=+<>*?|)(&^"' &@CRLF& _
	'KeyWord="'&$Word&'"' &@CRLF&@CRLF& _
	'[Color]' &@CRLF& _
	'BACKGROUND=FFFFFF' &@CRLF& _
	'BKGRD2=FFFF00' &@CRLF& _
	'BORDER=AAAAAA' &@CRLF& _
	'DEFAULT=000000' &@CRLF& _
	'COMMENT=008000' &@CRLF& _
	'KEYWORDS=0000FF' &@CRLF& _
	'LABEL=FF0000' &@CRLF& _
	'HIDESYBOL=FF00FF' &@CRLF& _
	'COMMAND=0080FF' &@CRLF& _
	'VARIABLE=FF8000' &@CRLF& _
	'OPERATOR=FF0000')
	FileClose($file)
EndIf

$Xtmp=IniRead($Ini, 'Set', 'X', '')
$Ytmp=IniRead($Ini, 'Set', 'Y', '')
$Xpos=Number($Xtmp)
$Ypos=Number($Ytmp)

$Topmost=Number(IniRead($Ini, 'Set', 'Topmost', 4))
$TrEn=Number(IniRead($Ini, 'Set', 'En', 4))
$TrCB=Number(IniRead($Ini, 'Set', 'CB', 1))
$TrBB=Number(IniRead($Ini, 'Set', 'BB', 1))
$TrCheck=Number(IniRead($Ini, 'Set', 'Check', 4))
$TrEcho=Number(IniRead($Ini, 'Set', 'Echo', 4))
$TrSB=IniRead($Ini, 'Set', 'SB', 'из ini')
$CurPath=IniRead($Ini, 'Set', 'CurPath', @ScriptDir)
$SysExe=IniRead($Ini, 'Set', 'SysExe', $SysExe)
$aSysExe=StringSplit($SysExe, '|')
$aSysExe=_ArrayUnique($aSysExe, 1, 1)

$kOperator=IniRead($Ini, 'Set', 'Operator', '=+<>*?|)(&^')
$kOperator=StringRegExpReplace($kOperator, '[][\\-]', '\\$0')

$Word=IniRead($Ini, 'Set', 'KeyWord', $Word)
If StringInStr('|'&$Word&'|', '|color|') Then
	$Word=StringReplace('|'&$Word&'|', '|color|', '|')
	$Word=StringTrimLeft($Word, 1)
	$Word=StringTrimRight($Word, 1)
EndIf
$aWord=StringSplit('color|'&$Word, '|')
$aWord=_ArrayUnique($aWord, 1, 1)

$TrNoCode=Number(IniRead($Ini, 'Set', 'NoCode', 4))
$TrB_KW=Number(IniRead($Ini, 'Set', 'B_KW', 4))
$TrB_Var=Number(IniRead($Ini, 'Set', 'B_Var', 4))
$Tri_Com=Number(IniRead($Ini, 'Set', 'i_Com', 4))

$StyleAll='из ini|Black(HTML)|White'
If Not StringInStr('|'&$StyleAll&'|', '|'&$TrSB&'|') Then
	$TrSB='из ini'
	IniWrite($Ini, 'Set', 'SB', '"'&$TrSB&'"')
EndIf

_StyleIni($TrSB)
If Not FileExists(@ScriptDir&'\Style.css') Then _CreateCSS()

; En
$LngTitle='Converter CMD2BBcode'
$LngAbout='About'
$LngVer='Version'
$LngSite='Site'
$LngCopy='Copy'
$LngUDr='use drag-and-drop'
$LngCbFl='In clipboard (otherwise file)'
$LngBBHL='BBcode (otherwise HTML)'
$LngChk='Checking'
$LngChkH='Checking Disposal Tag'
$LngEch='Highlighting after Echo'
$LngThs='Theme:'
$LngThsH='Overwrite CSS'
$LngOpF='Open'
$LngOpFH='Open file cmd, bat'
$LngFCb='from clipboard'
$LngFCbH='Convert the code'&@CRLF&'read from the clipboard'
$LngSet='Settings BBcode'
$LngNCd='Do not add [code]...[/code]'
$LngBkw='[b] for keywords'
$LngBvr='[b] for variables'
$LngIcm='[i] for comments'
$LngOpC='Script'
$LngHlp1='Help'
$LngHlp2='Utility to convert (add tags) files CMD, BAT in HTML or BBcode for later putting some on the forums.'&@CRLF&@CRLF&'Drag and drop in CMD, BAT on the utility and it will automatically perform the conversion.'&@CRLF&@CRLF&'Try to compare the final product by copying from the forum, usually the difference may be in the gaps.'&@CRLF&@CRLF&'In some forums to delete tag [code]'
$LngSD1='Sent to clipboard'
$LngSD2='times in'
$LngSD3='sec'
$LngSD4='Created'
$LngSD5=' for'
$LngSD6='Processing ...'
$LngErr='Error'
$LngMs1='Comparison with original failed.'&@CRLF&'Save in Error.txt?'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngTitle='Converter CMD2BBcode'
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngSite='Сайт'
	$LngCopy='Копировать'
	$LngUDr='используйте drag-and-drop'
	$LngCbFl='В буфер (иначе в файл)'
	$LngBBHL='BBcode (иначе HTML)'
	$LngChk='Обратная проверка'
	$LngChkH='Проверка удалением тегов'
	$LngEch='Подсвечивание после Echo'
	$LngThs='Тема:'
	$LngThsH='Перезапишет CSS'
	$LngOpF='Открыть'
	$LngOpFH='Открыть файл cmd, bat'
	$LngFCb='из буфера'
	$LngFCbH='Обработать код, прочитав'&@CRLF&'из буфера обмена'
	$LngSet='Настройки BBcode'
	$LngNCd='Не добавлять [code]...[/code]'
	$LngBkw='[b] для ключевых слов'
	$LngBvr='[b] для переменных'
	$LngIcm='[i] для комментариев'
	$LngOpC='Скрипт'
	$LngHlp1='Справка'
	$LngHlp2='Утилитка конвертирующая (обрамляет тегами) файлы CMD, BAT в формат HTML или BBcode для последующего выкладывания на форумах.'&@CRLF&@CRLF&'Перетаскивайте скрипт на утилиту и она автоматически выполнит конвертирование.'&@CRLF&@CRLF&'Попробуйте сравнить готовый результат скопировав с форума, обычно разница может быть в пробелах.'&@CRLF&@CRLF&'На некоторых форумах необходимо удалить теги [code]'
	$LngSD1='Отправлено в буфер'
	$LngSD2='раз, за'
	$LngSD3='сек'
	$LngSD4='Создан'
	$LngSD5=', за'
	$LngSD6='Обработка ...'
	$LngErr='Ошибка'
	$LngMs1='Сравнение с оригиналом неудачно '&@CRLF&'Хотите сохранить неисправную копию в файл Error.txt?'
EndIf

If $Xpos < 0 Then $Xpos=0
If $Xpos> @DesktopWidth-260 Then $Xpos=@DesktopWidth-260
If $Xtmp='' Then $Xpos=-1
If $Ypos < 0 Then $Ypos=0
If $Ypos> @DesktopHeight-280 Then $Ypos=@DesktopHeight-280
If $Ytmp='' Then $Ypos=-1

;создание оболочки
$Gui=GUICreate("CMD to BBcode",260,280, $Xpos, $Ypos, -1, $WS_EX_ACCEPTFILES)
If Not @compiled Then GUISetIcon(@ScriptDir&'\ConverterCMD.ico', 0)
$CatchDrop = GUICtrlCreateLabel("", 0, 0, 260, 280)
GUICtrlSetState(-1, 136)
$StatusBar=GUICtrlCreateLabel ($LngUDr, 3,280-17,260-6,17, 0xC)
GUICtrlSetState(-1, 8)
$About = GUICtrlCreateButton("@", 260-21, 2, 18, 20)
GUICtrlSetState(-1, 8)
$Help = GUICtrlCreateButton("?", 260-42, 2, 18, 20)
GUICtrlSetState(-1, 8)

$chCB=GUICtrlCreateCheckbox ($LngCbFl, 10, 10,160,20)
GUICtrlSetState(-1, 8)
If $TrCB=1 Then GuiCtrlSetState(-1, 1)

$chBBcode=GUICtrlCreateCheckbox ($LngBBHL, 10,30,160,20)
GUICtrlSetState(-1, 8)

$chEn=GUICtrlCreateCheckbox ("866 > 1251", 10, 50,160,20)
GUICtrlSetState(-1, 8)
If $TrEn=1 Then GuiCtrlSetState(-1, 1)

$chCheck=GUICtrlCreateCheckbox ($LngChk, 10, 70,160,20)
GUICtrlSetState(-1, 8)
If $TrCheck=1 Then GuiCtrlSetState(-1, 1)
GUICtrlSetTip(-1, $LngChkH)

$chEcho=GUICtrlCreateCheckbox ($LngEch, 10, 90,160,20)
GUICtrlSetState(-1, 8)
If $TrEcho=1 Then GuiCtrlSetState(-1, 1)

GUICtrlCreateLabel($LngThs, 10, 116, 43, 17)
$StyleCombo=GUICtrlCreateCombo('', 53, 113, 90,18, $CBS_DROPDOWNLIST)
GUICtrlSetData($StyleCombo, $StyleAll, $TrSB)
GUICtrlSetTip(-1, $LngThsH)
GUICtrlSetState(-1, 8)

$OpFile=GUICtrlCreateButton ($LngOpF, 170, 30, 86, 28)
GUICtrlSetTip(-1, $LngOpFH)

$Byfer=GUICtrlCreateButton ($LngFCb, 170, 63, 86, 28)
GUICtrlSetTip(-1, $LngFCbH)

GUICtrlCreateGroup($LngSet, 5, 143, 180, 98)
GUICtrlSetState(-1, 8)
$ChCode=GUICtrlCreateCheckbox ($LngNCd, 10,160,170,17)
GUICtrlSetState(-1, 8)
If $TrNoCode=1 Then GuiCtrlSetState(-1, 1)

$ChB_KW=GUICtrlCreateCheckbox ($LngBkw, 10,180,170,17)
GUICtrlSetState(-1, 8)
If $TrB_KW=1 Then GuiCtrlSetState(-1, 1)

$ChB_Var=GUICtrlCreateCheckbox ($LngBvr, 10,200,170,17)
GUICtrlSetState(-1, 8)
If $TrB_Var=1 Then GuiCtrlSetState(-1, 1)

$Chi_Com=GUICtrlCreateCheckbox ($LngIcm, 10,220,170,17)
GUICtrlSetState(-1, 8)
If $Tri_Com=1 Then GuiCtrlSetState(-1, 1)

$LngTpm='Поверх всех окон'
$ChTopmost=GUICtrlCreateCheckbox ($LngTpm, 10,245,170,17)
GUICtrlSetState(-1, 8)

If $TrBB=1 Then
	GuiCtrlSetState($chBBcode, 1)
Else
	_ChState($GUI_DISABLE)
EndIf

GUISetState()
OnAutoItExitRegister("_Exit_Save_Ini")
GUIRegisterMsg(0x0046 , "WM_WINDOWPOSCHANGING")

If $Topmost=1 Then
	WinSetOnTop($GUI, '', 1)
	GUICtrlSetState($ChTopmost, 1)
EndIf

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case -13
			If StringInStr(';.cmd;.bat;', ';'&StringRight(@GUI_DRAGFILE, 4)&';') Then
				GUICtrlSetData($StatusBar, $LngSD6)
				_OpenCMD(@GUI_DRAGFILE)
			EndIf
       Case $ChTopmost
			If GUICtrlRead($ChTopmost)=1 Then
				WinSetOnTop($GUI, '', 1)
			Else
				WinSetOnTop($GUI, '', 0)
			EndIf
	  Case $StyleCombo
		$TrSB=GUICtrlRead($StyleCombo)
		IniWrite($Ini, 'Set', 'SB', '"'&$TrSB&'"')
		_StyleIni($TrSB)
		_CreateCSS()

	  Case $chBBcode
		If GUICtrlRead($chBBcode)=1 Then
			_ChState($GUI_ENABLE)
		Else
			_ChState($GUI_DISABLE)
		EndIf
	  Case $Byfer
		GUICtrlSetData($StatusBar, $LngSD6)
		$Timer=TimerInit()
		_SaveCMD(_ConvCMD(ClipGet()))

		; кнопки "Обзор"
	  Case $OpFile
		If Not FileExists($CurPath) Then $CurPath=@ScriptDir
		$tmp = FileOpenDialog($LngOpF, $CurPath , $LngOpC&' (*.cmd;*.bat)', '', '', $Gui)
		If Not @error And StringInStr(';.cmd;.bat;', ';'&StringRight($tmp, 4)&';') Then
			$CurPath=StringRegExpReplace($tmp, '(^.*)\\(.*)$', '\1')
			GUICtrlSetData($StatusBar, $LngSD6)
			_OpenCMD($tmp)
		EndIf

       Case $Help
           MsgBox(8192, $LngHlp1, StringRegExpReplace($LngHlp2, '(.{70,}?[ ])(.*?)', '$0'&@CRLF))
       Case $About
           _About()
		Case -3
			IniWrite($Ini, 'Set', 'CurPath', $CurPath)
			Exit
	EndSwitch
WEnd

Func _Exit_Save_Ini()
	IniWrite($Ini, 'Set', 'X', $Xpos)
	IniWrite($Ini, 'Set', 'Y', $Ypos)

	IniWrite($Ini, 'Set', 'BB', GUICtrlRead($chBBcode))
	IniWrite($Ini, 'Set', 'CB', GUICtrlRead($chCB))
	IniWrite($Ini, 'Set', 'En', GUICtrlRead($ChEn))
	IniWrite($Ini, 'Set', 'Check', GUICtrlRead($ChCheck))
	IniWrite($Ini, 'Set', 'Echo', GUICtrlRead($ChEcho))
	
	IniWrite($Ini, 'Set', 'SB', '"'&GUICtrlRead($StyleCombo)&'"')
	
	IniWrite($Ini, 'Set', 'NoCode', GUICtrlRead($ChCode))
	IniWrite($Ini, 'Set', 'B_KW', GUICtrlRead($ChB_KW))
	IniWrite($Ini, 'Set', 'B_Var', GUICtrlRead($ChB_Var))
	IniWrite($Ini, 'Set', 'i_Com', GUICtrlRead($Chi_Com))
	
	IniWrite($Ini, 'Set', 'Topmost', GUICtrlRead($ChTopmost))
EndFunc

Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
	Local $sRect = DllStructCreate("Int[5]", $lparam)
	Switch $Tr7
		Case 1
			If DllStructGetData($sRect, 1, 5)<>0 And Not BitAnd(WinGetState($Gui), 16) Then
				$Xpos=DllStructGetData($sRect, 1, 3)
				$Ypos=DllStructGetData($sRect, 1, 4)
			EndIf
		Case Else
			If DllStructGetData($sRect, 1, 2) And DllStructGetData($sRect, 1, 5)<>0 And Not BitAnd(WinGetState($Gui), 16) Then
				$Xpos=DllStructGetData($sRect, 1, 3)
				$Ypos=DllStructGetData($sRect, 1, 4)
			EndIf
	EndSwitch
	Return 'GUI_RUNDEFMSG'
EndFunc

Func _OpenCMD($input)
	$file = FileOpen($input, 0)
	$HTML = FileRead($file)
	FileClose($file)
	$Timer=TimerInit()
	_SaveCMD(_ConvCMD($HTML), $input)
EndFunc

Func _SaveCMD($HTML, $input='byfer')
	Local $tmp1, $tmp2=Round(TimerDiff($timer) / 1000, 2)
	If $TrCB=1 Then
		ClipPut($HTML)
		$k0+=1
		GUICtrlSetData($StatusBar, $LngSD1&' '&$k0&' '&$LngSD2&' '&$tmp2& ' '&$LngSD3)
		GUICtrlSetTip($StatusBar, $LngSD1&' '&$k0&' '&$LngSD2&' '&$tmp2& ' '&$LngSD3)
		If $TrSvErr=1 Then
			$file = FileOpen(@ScriptDir&'\Error.txt',2)
			FileWrite($file, $ChecHTML)
			FileClose($file)
			$TrSvErr=0
		EndIf
	Else
		$input=StringRegExpReplace($input, '(^.*)\.(.*)$', '\1')
		$i = 0
		Do
			$i+=1
		Until Not FileExists($input&'_'&$i&$type)
		$output=$input&'_'&$i&$type
		$file = FileOpen($output,2)
		FileWrite($file, $HTML)
		FileClose($file)
		$tmp1=StringRegExpReplace($output, '(^.*)\\(.*)$', '\2')
		GUICtrlSetData($StatusBar, $LngSD4&' "'&$tmp1&'"'&$LngSD5&' '&$tmp2& ' '&$LngSD3)
		GUICtrlSetTip($StatusBar, $LngSD4&' "'&$tmp1&'"'&$LngSD5&' '&$tmp2& ' '&$LngSD3)
		If $TrSvErr=1 Then
			$file = FileOpen($input&'_'&$i&'Error.txt',2)
			FileWrite($file, $ChecHTML)
			FileClose($file)
			$TrSvErr=0
		EndIf
	EndIf
EndFunc


Func _ConvCMD($HTML)
	$tmpBB=GUICtrlRead($chBBcode)
	$tmpCB=GUICtrlRead($chCB)
	$tmpEn=GUICtrlRead($ChEn)
	$tmpCheck=GUICtrlRead($ChCheck)
	$tmpEcho=GUICtrlRead($ChEcho)
	If $tmpEn=1 Then $HTML=_Encoding_866To1251($HTML)
	
	$tmpHTML=$HTML
	$HTML=@CRLF&$HTML
	
	; шаблоны замены для переменных
	Local $sh0= _
	'(?<!%)%[a-zA-Z_$]\w*?%|'& _				; %Time3%
	'(?<!%)%[a-zA-Z_$]\w*?:~.*?%|'& _			; %Time:~1,1%   	'%[^%]\w+?:[\w*/\-+=]*?\w+?[^%]%|'& _	; %Time:*4=t%
	'(?<!%)%\d|'& _										; %1
	'%{1,2}~[fdpnxsatz]*[0-9a-z]|'& _				; %~dp0 или %%~nxi 
	'%%[a-zA-Z_$]\w{2,}?%%|'& _					; %%windir%% (добавил нижний предел 3 символа)
	'%%[a-zA-Z_$]\w*?:~[^%]*?%%|'& _							; %%Time:~1,1%%			'%%\w+?:[\w*/\-+=]*?\w+?%%|'& _			; %%Time:*4=t%%
	'%%[a-zA-Z0-9]|'& _								; %%i
	'![a-zA-Z_$%][\w%]*?!|'& _						; !Time!
	'!\w+?:~.*?!'											; !tn:~-2!
	; '%[^%]\*'												; %*
	; '%{1,2}~\w+?\b|'& _								; %~dp0 или %%~nxi
	; %~2%~1
	
	; патерн символов исключения (не содержит символов OPERATOR)
	$ExPat='\w:%!@#$\-;.,'
	
	If $tmpBB=1 Then
		$type='.txt'
		
		$tmpNoCode=GUICtrlRead($ChCode)
		$tmpB_KW=GUICtrlRead($ChB_KW)
		$tmpB_Var=GUICtrlRead($ChB_Var)
		$tmpi_Com=GUICtrlRead($Chi_Com)
		_Sini('NoCode')
		_Sini('B_KW')
		_Sini('B_Var')
		_Sini('i_Com')

		;i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
		; модуль замены ключевых слов BBcode
		$HTML=StringReplace($HTML, '[', ' 3ksl4¤nl3r01k ') ; замена временно для того чтоб не мешал детекту вложенных тегов
		$H16='[0-9A-Fa-f]{6}'
		
		$HTML=StringRegExpReplace($HTML, '['&$kOperator&']+', '[color=#'&$OPERATOR&']$0[/color]') ; OPERATOR
		$HTML=StringRegExpReplace($HTML, '(?mi)^([ 	]*color)\b(?!=)', '[color=#'&$KEYWORDS&']$1[/color]') ; KEYWORDS
		$HTML=StringRegExpReplace($HTML, '(?m)^([ 	]*@)', '[color=#'&$HIDESYBOL&']$1[/color]') ; HIDE SYBOL

		; отсчёт с 2 пропуская Color
		For $i = 2 to $aWord[0]
			; $HTML=StringRegExpReplace($HTML, '(?i)\b('&$aWord[$i]&')\b', '[color=#'&$KEYWORDS&']$1[/color]') ; KEYWORDS
			$HTML=StringRegExpReplace($HTML, '(?im)(?<!['&$ExPat&'\\/]|goto )('&$aWord[$i]&')\b', '[color=#'&$KEYWORDS&']$1[/color]') ; KEYWORDS
		Next
		For $i = 1 to $aSysExe[0]
			$HTML=StringRegExpReplace($HTML, '(?im)(?<!['&$ExPat&']|goto )('&$aSysExe[$i]&'\.exe|'&$aSysExe[$i]&')(?!['&$ExPat&'\\/\[])', '[color=#'&$COMMAND&']$1[/color]') ; COMMAND, EXE
		Next

		$HTML=StringRegExpReplace($HTML, '(?i)(\[color=#'&$H16&'\]if\[.*?)\b(EQU|NEQ|LSS|LEQ|GTR|GEQ)\b', '$1[color=#'&$OPERATOR&']$2[/color]') ; OPERATOR, команды сравнения
		$HTML=StringRegExpReplace($HTML, '(?i)(?<=\[color=#'&$H16&'\]Call\[/color\])([	 ]*:?\w+)\b', '[color=#'&$LABEL&']$1[/color]') ; LABEL (метки после Call)
		$HTML=StringRegExpReplace($HTML, '(?i)(?<=\[color=#'&$H16&'\]goto\[/color\])([	 ]*:?\w+)\b', '[color=#'&$LABEL&']$1[/color]') ; LABEL (метки после goto)
		$HTML=StringRegExpReplace($HTML, '(?m)^([ 	]*:[^:][^\r\n]*)', '[color=#'&$LABEL&']$1[/color]') ; LABEL, метки
		$HTML=StringRegExpReplace($HTML, '(?im)^([ 	]*::[^\r\n]*|[ 	]*rem[ 	]+[^\r\n]*)', '[color=#'&$COMMENT&']$0[/color]') ; COMMENT, комментарии
		$HTML=StringRegExpReplace($HTML, '(?i)('&$sh0&')', '[color=#'&$VARIABLE&']$0[/color]') ; VARIABLE, переменные	
		$HTML=StringRegExpReplace($HTML, '(?i)(?<=\[/color\])(%[a-zA-Z_$]\w*?%|%[a-zA-Z_$]\w*?:~.*?%)', '[color=#'&$VARIABLE&']$0[/color]') ; VARIABLE, переменные
		$HTML=StringRegExpReplace($HTML, '(\[color=#'&$VARIABLE&'\][^[]+?)(\[/color\]\[color=#'&$VARIABLE&'\])(.*?\[/color\])', '\1\3') ; объединение переменных
		
		; Дополнительный поиск переменных
		$sh0= _
			'(?<!%)%[\w$]+?%|'& _
			'(?<!%)%\d|'& _
			'%%[\w$]+?%%|'
		$HTML_Var=StringRegExpReplace($tmpHTML, '('&$sh0&')', '') ; удаляем переменные первого прохода
		$aHTML_Var=StringRegExp($HTML_Var, '((%[^%][\w$]+?:[\w.,;@#$*/\-+=]*?%|%%[a-zA-Z_$][\w$]*?:[\w.,;@#$*/\-+=]*?%%)', 3) ; переменные содержащие операторы
		If Not @error Then
			For $i = 0 to UBound($aHTML_Var)-1
				$tmp=StringRegExpReplace($aHTML_Var[$i], '['&$kOperator&']+', '[color=#'&$OPERATOR&']$0[/color]') ; OPERATOR
				$tmp=StringRegExpReplace($tmp, '(%%\w)', '[color=#'&$VARIABLE&']$0[/color]') ; VARIABLE, переменные
				$HTML=StringReplace($HTML, $tmp, '[color=#'&$VARIABLE&']'&$aHTML_Var[$i]&'[/color]')
			Next
		EndIf
		; конец: Дополнительный поиск переменных
		
		; исключительные переменные
		$HTML=StringRegExpReplace($HTML, '(?<!%)%\[color=#'&$OPERATOR&'\]\*\[/color\]', '[color=#'&$VARIABLE&']%*[/color]') ; %*
		$HTML=StringRegExpReplace($HTML, '%ProgramFiles\[color=#'&$OPERATOR&'\]\(\[/color\]x86\[color=#'&$OPERATOR&'\]\)\[/color\]%', '[color=#'&$VARIABLE&']%ProgramFiles(x86)%[/color]')

		; удаление из строк коментариев иные стили
		Do
			$HTML=StringRegExpReplace($HTML, '(?mi)^([ 	]*\[color=#'&$H16&'\]rem[ 	].*?)\[color=#'&$H16&'\](.+?)\[/color\](.*?\[/color\])', '$1$2$3')
		Until @Extended=0
		; удаление из строк коментариев и меток иные стили
		Do
			$HTML=StringRegExpReplace($HTML, '(?mi)^([ 	]*\[color=#'&$H16&'\]:{1,2}.*?)\[color=#'&$H16&'\](.+?)\[/color\](.*?\[/color\])', '$1$2$3')
		Until @Extended=0
		$HTML=StringRegExpReplace($HTML, '(?mi)^([ 	]*\[color=#'&$LABEL&'\]:.+?[ 	])(.+?\[/color\])', '$1[/color][color=#'&$COMMENT&']$2') ; комментарии после метки
		; Отменить подсвечивание после title, кроме переменных
		Do
			$HTML=StringRegExpReplace($HTML, '(?mi)^([ 	]*\[color=#'&$H16&'\]title\[/color\] .*?)\[color=#('&$KEYWORDS&'|'&$HIDESYBOL&'|'&$COMMAND&'|'&$OPERATOR&')\](.+?)\[/color\](.*?)', '$1$3$4')
		Until @Extended=0
		
		; Отменить подсвечивание после echo, кроме переменных
		If $tmpEcho<>1 Then
			Do
				; $HTML=StringRegExpReplace($HTML, '(?mi)^([ 	]*\[color=#'&$H16&'\]echo\[/color\] .*?)\[color=#'&$H16&'\](.+?)\[/color\](.*?)', '$1$2$3')
				$HTML=StringRegExpReplace($HTML, '(?mi)^([ 	]*\[color=#'&$H16&'\]echo\[/color\] .*?)\[color=#('&$KEYWORDS&'|'&$HIDESYBOL&'|'&$COMMAND&'|'&$OPERATOR&')\](.+?)\[/color\](.*?)', '$1$3$4')
			Until @Extended=0
		EndIf
		
		; удаление вложенных тегов
			; $HTML=StringRegExpReplace($HTML, '(?mi)(\[color=#'&$H16&'\].*?)(?!\[/color\])\[color=#'&$H16&'\](.*?)\[/color\](.*?\[/color\])', '$1$2$3')
			; $HTML=StringRegExpReplace($HTML, '(?mi)(\[color=#'&$H16&'\].*?)(?!\[/color\])\[color=#'&$H16&'\](.*?)\[/color\]', '$1$2')
		Do
			$HTML=StringRegExpReplace($HTML, '(?mi)(\[color=#'&$H16&'\][^\[]*?)\[color=#'&$H16&'\](.+?)\[/color\]', '$1$2')
		Until @Extended=0
		; удаление последовательных одинаковых тегов
		Do
			$HTML=StringRegExpReplace($HTML, '(?s)(\[color=#('&$H16&')\][^\[]*?)\[/color\]([\s]*)\[color=#\2\]', '\1\3')
		Until @Extended=0
		$HTML=StringReplace($HTML, ' 3ksl4¤nl3r01k ', '[') ; восстановление символа временно заменённого

		; формат шрифта
		If $tmpB_KW=1 Then $HTML=StringRegExpReplace($HTML, '(?si)(\[color=#'&$KEYWORDS&'\].*?\[/color\])', '[b]$1[/b]')
		If $tmpB_Var=1 Then $HTML=StringRegExpReplace($HTML, '(?si)(\[color=#'&$VARIABLE&'\].*?\[/color\])', '[b]$1[/b]')
		If $tmpi_Com=1 Then $HTML=StringRegExpReplace($HTML, '(?si)(\[color=#'&$COMMENT&'\].*?\[/color\])', '[i]$1[/i]')
		
		$HTML=StringTrimLeft($HTML, 2)
		
		; проверка удалением тегов
		If $tmpCheck=1 Then
			$ChecHTML=StringRegExpReplace($HTML, '(?s)\[color=#'&$H16&'\](.*?)\[/color\]', '$1')
			If $tmpB_KW=1 Or $tmpB_Var=1 Then $ChecHTML=StringRegExpReplace($ChecHTML, '(?s)\[b\](.*?)\[/b\]', '$1')
			If $tmpi_Com=1 Then $ChecHTML=StringRegExpReplace($ChecHTML, '(?s)\[i\](.*?)\[/i\]', '$1')
			If $tmpHTML<>$ChecHTML And MsgBox(4, $LngErr, $LngMs1)=6 Then $TrSvErr=1
		EndIf
		;i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
		If $TrNoCode<>1 Then $HTML='[code]'&$HTML&'[/code]'
	Else
		$type='.htm'
		$head1= _
		'<html>' & @CRLF & _
		'<head>' & @CRLF & _
		'<LINK REL=STYLESHEET TYPE="text/css" HREF="'&@ScriptDir&'\Style.css" title="style">'& @CRLF & _
		'<pre class=au3_codebox>' & @CRLF

		$End2= @CRLF & _
		'</pre>' & @CRLF & _
		'</html>'

		;i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
		; модуль замены ключевых слов HTML
		; If StringRegExp($HTML, '(?i)%%(ProgramFiles|SystemRoot|windir|TEMP|SystemDrive|COMMONPROGRAMFILES|AllUsersProfile|UserProfile)%%', 0) Then $TrVarCn=1
		$HTML=StringReplace($HTML, '<', ' 3ksl4¤nl3r01k ')
		
		$HTML=StringRegExpReplace($HTML, '['&$kOperator&']+', '<span class="S7">$0</span>') ; OPERATOR
		$HTML=StringRegExpReplace($HTML, '(?m)^([ 	]*@)', '<span class="S4">$1</span>') ; HIDE SYBOL

		For $i = 1 to $aWord[0]
			; $HTML=StringRegExpReplace($HTML, '(?i)\b('&$aWord[$i]&')\b', '<span class="S2">$1</span>') ; KEYWORDS
			$HTML=StringRegExpReplace($HTML, '(?im)(?<!['&$ExPat&'/\\\]\[]|goto )('&$aWord[$i]&')\b', '<span class="S2">$1</span>') ; KEYWORDS
			; $HTML=StringRegExpReplace($HTML, '(?im)(?<![\w:%]|^rem |^title |^echo |goto )('&$aWord[$i]&')\b(?=.*$)', '<span class="S2">$1</span>') ; KEYWORDS
			; $HTML=StringRegExpReplace($HTML, '(?i)(?<!\N?rem |:|\N?title |goto |\N?echo |%|[\w])('&$aWord[$i]&')\b', '<span class="S2">$1</span>') ; KEYWORDS
			; $HTML=StringRegExpReplace($HTML, '(?im)(?<!^rem .*|^:.*|^title .*|%|\w)('&$aWord[$i]&')\b', '<span class="S2">$1</span>') ; KEYWORDS
		Next
		For $i = 1 to $aSysExe[0]
			$HTML=StringRegExpReplace($HTML, '(?im)(?<!['&$ExPat&']|goto )('&$aSysExe[$i]&'\.exe|'&$aSysExe[$i]&')(?!['&$ExPat&'<\\/\[])', '<span class="S5">$1</span>') ; COMMAND, EXE
		Next

		$HTML=StringRegExpReplace($HTML, '(?i)(<span class="S2">if<.*?)\b(EQU|NEQ|LSS|LEQ|GTR|GEQ)\b', '$1<span class="S7">$2</span>') ; OPERATOR
		$HTML=StringRegExpReplace($HTML, '(?i)(?<=<span class="S2">Call<\/span>)([ 	]*:?\w+)\b', '<span class="S3">$1</span>') ; LABEL
		$HTML=StringRegExpReplace($HTML, '(?i)(?<=<span class="S2">goto<\/span>)([	 ]*:?\w+)\b', '<span class="S3">$1</span>') ; LABEL
		$HTML=StringRegExpReplace($HTML, '(?m)^([ 	]*:[^:][^\r\n]*)', '<span class="S3">$1</span>') ; LABEL
		$HTML=StringRegExpReplace($HTML, '(?im)^([ 	]*::[^\r\n]*|[ 	]*rem[ 	]+[^\r\n]*)', '<span class="S1">$1</span>') ; COMMENT
		$HTML=StringRegExpReplace($HTML, '(?i)('&$sh0&')', '<span class="S6">$0</span>') ; VARIABLE
		$HTML=StringRegExpReplace($HTML, '(?i)(?<=</span>)(%[a-zA-Z_$]\w*?%|%[a-zA-Z_$]\w*?:~.*?%)', '<span class="S6">$0</span>') ; VARIABLE, переменные
		$HTML=StringRegExpReplace($HTML, '(<span class="S6">[^<]+?)(</span><span class="S6">)(.*?</span>)', '\1\3') ; объединение переменных
		
		; Дополнительный поиск переменных
		$sh0= _
			'(?<!%)%[\w$]+?%|'& _
			'(?<!%)%\d|'& _
			'%%[\w$]+?%%|'
		$HTML_Var=StringRegExpReplace($tmpHTML, '('&$sh0&')', '') ; удаляем переменные первого прохода
		$aHTML_Var=StringRegExp($HTML_Var, '(%[^%][\w$]+?:[\w.,;@#$*/\-+=]*?[^%]%|%%[a-zA-Z_$][\w$]*?:[\w.,;@#$*/\-+=]*?%%)', 3) ; переменные содержащие операторы
		If Not @error Then
			For $i = 0 to UBound($aHTML_Var)-1
				$tmp=StringRegExpReplace($aHTML_Var[$i], '['&$kOperator&']+', '<span class="S7">$0</span>') ; OPERATOR
				$tmp=StringRegExpReplace($tmp, '(%%\w)', '<span class="S6">$0</span>') ; VARIABLE, переменные
				$HTML=StringReplace($HTML, $tmp, '<span class="S6">'&$aHTML_Var[$i]&'</span>')
			Next
		EndIf
		; конец: Дополнительный поиск переменных
		
		; исключительные переменные
		$HTML=StringRegExpReplace($HTML, '(?<!%)%<span class="S7">\*</span>', '<span class="S6">%*</span>') ; %*
		$HTML=StringRegExpReplace($HTML, '%ProgramFiles<span class="S7">\(</span>x86<span class="S7">\)</span>%', '<span class="S6">%ProgramFiles(x86)%</span>')

		; удаление из строк коментариев иные стили
		Do
			$HTML=StringRegExpReplace($HTML, '(?mi)^([ 	]*<span class="S\d">rem[ 	].*?)<span class="S\d">(.+?)</span>(.*?</span>)', '$1$2$3')
		Until @Extended=0
		; удаление из строк коментариев и меток иные стили
		Do
			$HTML=StringRegExpReplace($HTML, '(?mi)^([ 	]*<span class="S\d">:{1,2}.*?)<span class="S\d">(.+?)</span>(.*?</span>)', '$1$2$3')
		Until @Extended=0
		$HTML=StringRegExpReplace($HTML, '(?mi)^([ 	]*<span class="S3">:.+?[ 	]+)(.+?</span>)', '$1</span><span class="S1">$2') ; комментарии после метки
		; Отменить подсвечивание после title, кроме переменных
		Do
			$HTML=StringRegExpReplace($HTML, '(?mi)^([ 	]*<span class="S\d">title</span> .*?)<span class="S[0-57]">(.+?)</span>(.*?)', '$1$2$3')
		Until @Extended=0
		
		; Отменить подсвечивание после echo, кроме переменных
		If $tmpEcho<>1 Then
			Do
				$HTML=StringRegExpReplace($HTML, '(?mi)^([ 	]*<span class="S\d">echo</span> .*?)<span class="S[0-57]">(.+?)</span>(.*?)', '$1$2$3') ;[^=+<>*?|)(&^]
			Until @Extended=0
		EndIf
		
		; удаление вложенных тегов
		; $HTML=StringRegExpReplace($HTML, '(?mi)(<span class="S\d">.*?)(?!</span>)<span class="S\d">(.+?)</span>(.*?</span>)', '$1$2$3')
																		 ; '<span class="S6">%TP:~0,<span class="S7">-</span>1%</span>'
		; $HTML=StringRegExpReplace($HTML, '(?mi)(<span class="S\d">.*?)(?!</span>)<span class="S\d">', '$1')
		; $HTML=StringRegExpReplace($HTML, '(?mi)(</span>)(?!<span class="S\d">)(.*?</span>)', '$2')
		Do
			$HTML=StringRegExpReplace($HTML, '(?mi)(<span class="S\d">[^<]*?)<span class="S\d">(.+?)</span>', '$1$2')
		Until @Extended=0
		; удаление последовательных одинаковых тегов
		Do
			$HTML=StringRegExpReplace($HTML, '(?s)(<span class="S(\d)">[^<]*?)</span>([\s]*)<span class="S\2">', '\1\3')
		Until @Extended=0
		$HTML=StringReplace($HTML, ' 3ksl4¤nl3r01k ', '<span class="S7"><</span>') ; восстановление символа временно заменённого
		
		; замена отмены переменных
		; If $TrVarCn=1 Then
			; $sysvar=StringSplit('ProgramFiles|SystemRoot|windir|TEMP|SystemDrive|COMMONPROGRAMFILES|AllUsersProfile|UserProfile', '|')
			; For $i = 1 to $sysvar[0]
				; $sys0=StringLeft($sysvar[$i], 1)
				; $sys1=StringTrimLeft($sysvar[$i], 1)
				; $HTML=StringRegExpReplace($HTML, '(?i)<span class="S6">%%'&$sys0&'</span>'&$sys1&'%%', '<span class="S6">%%'&$sys0&$sys1&'%%</span>')
			; Next
			; $TrVarCn=0
		; EndIf
		$HTML=StringTrimLeft($HTML, 2)
		
		; проверка удалением тегов
		If $tmpCheck=1 Then
			$ChecHTML=StringRegExpReplace($HTML, '(?s)<span class="S\d">(.*?)</span>', '$1')
			If $tmpHTML<>$ChecHTML And MsgBox(4, $LngErr, $LngMs1)=6 Then $TrSvErr=1
		EndIf
		;i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
		$HTML=$head1&$HTML&$End2
	EndIf

	_Sini('CB')
	_Sini('BB')
	_Sini('En')
	_Sini('Check')
	_Sini('Echo')
	
	Return $HTML
EndFunc

Func _Sini($var)
	If Eval('Tr' & $var)<>Eval('tmp' & $var) Then
		Assign('Tr'& $var, Eval('tmp' & $var))
		IniWrite($Ini, 'Set', $var, Eval('Tr' & $var))
	EndIf
EndFunc

Func _ChState($st)
	GUICtrlSetState($ChCode, $st)
	GUICtrlSetState($ChB_KW, $st)
	GUICtrlSetState($ChB_Var, $st)
	GUICtrlSetState($Chi_Com, $st)
EndFunc

Func _StyleIni($Style)
	Switch $Style
		Case 'из ini'
			$BACKGROUND=IniRead($Ini, 'Color', 'BACKGROUND', 'FFFFFF')
			$BKGRD2=IniRead($Ini, 'Color', 'BKGRD2', 'FFFF00')
			$BORDER=IniRead($Ini, 'Color', 'BORDER', 'AAAAAA')
			$DEFAULT=IniRead($Ini, 'Color', 'DEFAULT', '000000')
			$COMMENT=IniRead($Ini, 'Color', 'COMMENT', '008000')
			$KEYWORDS=IniRead($Ini, 'Color', 'KEYWORDS', '0000FF')
			$LABEL=IniRead($Ini, 'Color', 'LABEL', 'FF0000')
			$HIDESYBOL=IniRead($Ini, 'Color', 'HIDESYBOL', 'FF00FF')
			$COMMAND=IniRead($Ini, 'Color', 'COMMAND', '0080FF')
			$VARIABLE=IniRead($Ini, 'Color', 'VARIABLE', 'FF8000')
			$OPERATOR=IniRead($Ini, 'Color', 'OPERATOR', 'FF0000')
		Case 'Black(HTML)'
			$BACKGROUND='3F3F3F'
			$BKGRD2='000'
			$BORDER='AAAAAA'
			$DEFAULT='999999'
			$COMMENT='71AE71'
			$KEYWORDS='009FFF'
			$LABEL='C8C800'
			$HIDESYBOL='FF46FF'
			$COMMAND='AAA6DB'
			$VARIABLE='D39D72'
			$OPERATOR='FF8080'
		Case 'White'
			$BACKGROUND='FFFFFF'
			$BKGRD2='FFFF00'
			$BORDER='AAAAAA'
			$DEFAULT='000000'
			$COMMENT='008000'
			$KEYWORDS='0000FF'
			$LABEL='FF0000'
			$HIDESYBOL='FF00FF'
			$COMMAND='0080FF'
			$VARIABLE='FF8000'
			$OPERATOR='FF0000'
	EndSwitch
EndFunc

; #Include <Encoding.au3> ; не поддаётся обфускации, пришлось вытащить функцию.
;Description: Converts cyrillic string from IBM 866 codepage to Microsoft 1251 codepage
;Author: Latoid
Func _Encoding_866To1251($sString)
	Local $sResult = "", $iCode
	Local $Var866Arr = StringSplit($sString, "")

	For $i = 1 To $Var866Arr[0]
		$iCode = Asc($Var866Arr[$i])

		Select
			Case $iCode >= 128 And $iCode <= 175
				$Var866Arr[$i] = Chr($iCode + 64)
			Case $iCode >= 224 And $iCode <= 239
				$Var866Arr[$i] = Chr($iCode + 16)
			Case $iCode = 240
				$Var866Arr[$i] = Chr(168)
			Case $iCode = 241
				$Var866Arr[$i] = Chr(184)
			Case $iCode = 252
				$Var866Arr[$i] = Chr(185)
		EndSelect

		$sResult &= $Var866Arr[$i]
	Next

	Return $sResult
EndFunc   ;==>_Encoding_866To1251

; вычисление координат дочернего окна
Func _ChildCoor($Gui, $w, $h, $c=0, $d=0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
	$GP = WinGetPos($Gui), _
	$wgcs=WinGetClientSize($Gui)
	Local $dLeft=($GP[2]-$wgcs[0])/2, _
	$dTor=$GP[3]-$wgcs[1]-$dLeft
	If $c = 0 Then
		$GP[0]=$GP[0]+($GP[2]-$w)/2-$dLeft
		$GP[1]=$GP[1]+($GP[3]-$h-$dLeft-$dTor)/2
	EndIf
	If $d>($aWA[2]-$aWA[0]-$w-$dLeft*2)/2 Or $d>($aWA[3]-$aWA[1]-$h-$dLeft+$dTor)/2 Then $d=0
	If $GP[0]+$w+$dLeft*2+$d>$aWA[2] Then $GP[0]=$aWA[2]-$w-$d-$dLeft*2
	If $GP[1]+$h+$dLeft+$dTor+$d>$aWA[3] Then $GP[1]=$aWA[3]-$h-$dLeft-$dTor-$d
	If $GP[0]<=$aWA[0]+$d Then $GP[0]=$aWA[0]+$d
	If $GP[1]<=$aWA[1]+$d Then $GP[1]=$aWA[1]+$d
	$GP[2]=$w
	$GP[3]=$h
	Return $GP
EndFunc

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
EndFunc

Func _About()
$GP=_ChildCoor($Gui, 270, 180)
GUISetState(@SW_DISABLE, $Gui)
$font="Arial"
    $Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOr($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,15, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,268,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.7  01.11.2011', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 55, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010-2011', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
$msg = $Gui1
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg = $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $msg = $WbMn
			ClipPut('R939163939152')
		Case $msg = -3
			$msg = $Gui
			GUISetState(@SW_ENABLE, $Gui)
			GUIDelete($Gui1)
			ExitLoop
		EndSelect
    WEnd
EndFunc

Func _CreateCSS()
$text= _
'.au3_codebox /* BK */' & @CRLF & _
'{' & @CRLF & _
'	BORDER-BOTTOM: #'&$BORDER&' 1px solid;' & @CRLF & _
'	BORDER-LEFT: #'&$BORDER&' 1px solid;' & @CRLF & _
'	BORDER-RIGHT: #'&$BORDER&' 1px solid;' & @CRLF & _
'	BORDER-TOP: #'&$BORDER&' 1px solid;' & @CRLF & _
'	PADDING-RIGHT: 8px;' & @CRLF & _
'	PADDING-LEFT: 8px;' & @CRLF & _
'	PADDING-BOTTOM: 8px;' & @CRLF & _
'	PADDING-TOP: 8px;' & @CRLF & _
'	FONT-SIZE: 12px;' & @CRLF & _
'	FONT-FAMILY: Arial, Courier New, Verdana, Courier, Helvetica, sans-serif, MS sans serif;' & @CRLF & _
'	FONT-WEIGHT: normal;' & @CRLF & _
'	BACKGROUND-color: #'&$BACKGROUND&';' & @CRLF & _
'	WHITE-SPACE: pre;' & @CRLF & _
'	font-family: Arial;' & @CRLF & _
'	font-weight: normal;' & @CRLF & _
'	color: #'&$DEFAULT&';' & @CRLF & _
'	line-height: normal;' & @CRLF & _
'	margin-top: 0.5em;' & @CRLF & _
'	margin-bottom: 0.5em;' & @CRLF & _
'}' & @CRLF & _
@CRLF & _
'.S0 /* DEFAULT */' & @CRLF & _
'{' & @CRLF & _
'	font-weight: normal;' & @CRLF & _
'	color: #'&$DEFAULT&';' & @CRLF & _
'}' & @CRLF & _
'.S1 /* COMMENT */' & @CRLF & _
'{' & @CRLF & _
'	font-style: italic;' & @CRLF & _
'	color: #'&$COMMENT&';' & @CRLF & _
'}' & @CRLF & _
'.S2 /* KEYWORDS */' & @CRLF & _
'{' & @CRLF & _
'	font-weight: bold;' & @CRLF & _
'	color: #'&$KEYWORDS&';' & @CRLF & _
'}' & @CRLF & _
'.S3 /* LABEL */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$LABEL&';' & @CRLF & _
'	background-color: #'&$BKGRD2&';' & @CRLF & _
'}' & @CRLF & _
'.S4 /* HIDE SYBOL */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$HIDESYBOL&';' & @CRLF & _
'}' & @CRLF & _
'.S5 /* COMMAND */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$COMMAND&';' & @CRLF & _
'}' & @CRLF & _
'.S6 /* VARIABLE */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$VARIABLE&';' & @CRLF & _
'}' & @CRLF & _
'.S7 /* OPERATOR */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$OPERATOR&';' & @CRLF & _
'}'

$file = FileOpen(@ScriptDir&'\Style.css',2)
FileWrite($file, $text)
FileClose($file)
EndFunc