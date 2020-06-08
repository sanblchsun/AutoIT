#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Converter_AU3_to_BBcode.exe
#AutoIt3Wrapper_icon=ConverterAU3.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Converter_AU3_to_BBcode.exe
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.1
#AutoIt3Wrapper_Res_Field=Build|2011.06.28
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
; #AutoIt3Wrapper_Run_Obfuscator=y
; #Obfuscator_Parameters=/StripOnly
; #AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 28.06.2011 (AutoIt3_v3.3.7.10)
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <ComboConstants.au3>
#include "SciTE.au3"

#NoTrayIcon
Global $TrEn, $tmpEn, $TrCB, $tmpCB, $TrBB, $tmpBB, $TrSB, $TrNoCode, $TrB_KW, $TrB_Var, $Tri_Com, $tmpNoCode, $tmpB_KW, $tmpB_Var, $tmpi_Com, _
$k0=0, $type, $TrVarCn=0, $Timer, $iCNT, $iDEL, $aRoot, $tmpCheck, $TrCheck, $ChecHTML, $TrSvErr=0, _
$ini=@ScriptDir&'\ConverterAU3.ini', $CurPath, $tmp, $Xpos, $Ypos, $Tr7=0
Global $BACKGROUND, $BKGRD2, $BORDER, $DEFAULT, $COMMENT, $KEYWORDS, $LABEL, $HIDESYBOL, $COMMAND, $VARIABLE, $OPERATOR
Global $aThColor[16], $TypeFile='.au3', $amClr=12, $StyleFile

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
	'B_KW=4' &@CRLF& _
	'B_Var=4' &@CRLF& _
	'i_Com=4' &@CRLF& _
	'Check=1' &@CRLF& _
	'En=4' &@CRLF& _
	'Topmost=4' &@CRLF& _
	'TypeFile=.au3' &@CRLF& _
	'X=' &@CRLF& _
	'Y=' &@CRLF& _
	'SB="из ini"' &@CRLF&@CRLF& _
	'[ColorCMD]' &@CRLF& _
	'BACKGROUND=FFFFFF' &@CRLF& _
	'BKGRD2=FFFF00' &@CRLF& _
	'BORDER=AAAAAA' &@CRLF& _
	'0=999999' &@CRLF& _
	'1=008000' &@CRLF& _
	'2=0000FF' &@CRLF& _
	'3=FF0000' &@CRLF& _
	'4=FF00FF' &@CRLF& _
	'5=0080FF' &@CRLF& _
	'6=FF8000' &@CRLF& _
	'7=FF0000' &@CRLF& _
	'8=D39D72' &@CRLF& _
	'9=D39D72' &@CRLF& _
	'10=448489' &@CRLF& _
	'11=F000FF' &@CRLF& _
	'12=A00FF0' &@CRLF& _
	'13=0080FF' &@CRLF& _
	'14=0000FF' &@CRLF& _
	'15=0080FF' &@CRLF&@CRLF& _
	'[ColorREG]' &@CRLF& _
	'BACKGROUND=FFFFFF' &@CRLF& _
	'BKGRD2=FFFF00' &@CRLF& _
	'BORDER=AAAAAA' &@CRLF& _
	'0=000000' &@CRLF& _
	'1=009933' &@CRLF& _
	'2=0080FF' &@CRLF& _
	'3=FF0000' &@CRLF& _
	'4=FF8380' &@CRLF& _
	'5=000000' &@CRLF& _
	'6=A7A7A7' &@CRLF& _
	'7=A7A7A7' &@CRLF& _
	'8=A7A7A7' &@CRLF& _
	'9=A7A7A7' &@CRLF& _
	'10=A7A7A7' &@CRLF& _
	'11=A7A7A7' &@CRLF& _
	'12=A7A7A7' &@CRLF& _
	'13=A7A7A7' &@CRLF& _
	'14=A7A7A7' &@CRLF& _
	'15=A7A7A7' &@CRLF&@CRLF& _
	'[ColorElse]' &@CRLF& _
	'BACKGROUND=FFFFFF' &@CRLF& _
	'BKGRD2=FFFF00' &@CRLF& _
	'BORDER=AAAAAA' &@CRLF& _
	'0=000000' &@CRLF& _
	'1=009933' &@CRLF& _
	'2=669900' &@CRLF& _
	'3=AC00A9' &@CRLF& _
	'4=000090' &@CRLF& _
	'5=0000FF' &@CRLF& _
	'6=FF33FF' &@CRLF& _
	'7=9999CC' &@CRLF& _
	'8=FF0000' &@CRLF& _
	'9=AA0000' &@CRLF& _
	'10=FF8800' &@CRLF& _
	'11=F000FF' &@CRLF& _
	'12=A00FF0' &@CRLF& _
	'13=0080FF' &@CRLF& _
	'14=0000FF' &@CRLF& _
	'15=0080FF')
	FileClose($file)
EndIf

$Xtmp=IniRead($Ini, 'Set', 'X', '')
$Ytmp=IniRead($Ini, 'Set', 'Y', '')
$Xpos=Execute($Xtmp)
$Ypos=Execute($Ytmp)

$Topmost=Execute(IniRead($Ini, 'Set', 'Topmost', 4))
$TrEn=Execute(IniRead($Ini, 'Set', 'En', 4))
$TrCB=Execute(IniRead($Ini, 'Set', 'CB', 1))
$TrBB=Execute(IniRead($Ini, 'Set', 'BB', 1))
$TrCheck=Execute(IniRead($Ini, 'Set', 'Check', 4))
$TrSB=IniRead($Ini, 'Set', 'SB', 'из ini')
$CurPath=IniRead($Ini, 'Set', 'CurPath', @ScriptDir)

$TrNoCode=Execute(IniRead($Ini, 'Set', 'NoCode', 4))
$TrB_KW=Execute(IniRead($Ini, 'Set', 'B_KW', 4))
$TrB_Var=Execute(IniRead($Ini, 'Set', 'B_Var', 4))
$Tri_Com=Execute(IniRead($Ini, 'Set', 'i_Com', 4))
$TypeFile=IniRead($Ini, 'Set', 'TypeFile', '.au3')

$StyleAll='из ini|Black|White'
If Not StringInStr('|'&$StyleAll&'|', '|'&$TrSB&'|') Then
	$TrSB='из ini'
	IniWrite($Ini, 'Set', 'SB', '"'&$TrSB&'"')
EndIf

_StyleIni()
If Not FileExists($StyleFile) Then _CreateCSS()

$TypeFileAll='.au3|.cmd|.reg'
If Not StringInStr('|'&$TypeFileAll&'|', '|'&$TypeFile&'|') Then
	$TypeFile='.au3'
	IniWrite($Ini, 'Set', 'TypeFile', $TypeFile)
EndIf

; En
$LngTitle='Converter AU3 to BBcode'
$LngAbout='About'
$LngVer='Version'
$LngSite='Site'
$LngCopy='Copy'
$LngUDr='use drag-and-drop'
$LngCbFl='In clipboard (otherwise file)'
$LngBBHL='BBcode (otherwise HTML)'
$LngChk='Checking BBcode'
$LngChkH='Checking Disposal Tag'
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
$LngHlp2='Utility to convert (add tags) files AU3, CMD, REG in HTML or BBcode for later putting some on the forums.'&@CRLF&@CRLF&'Drag and drop in AU3, CMD, REG on the utility and it will automatically perform the conversion.'&@CRLF&@CRLF&'Try to compare the final product by copying from the forum, usually the difference may be in the gaps.'&@CRLF&@CRLF&'In some forums to delete tag [code]'&@CRLF&@CRLF&'As a converter utility uses SciTE'
$LngSD1='Sent to clipboard'
$LngSD2='times in'
$LngSD3='sec'
$LngSD4='Created'
$LngSD5=' for'
$LngSD6='Processing ...'
$LngErr='Error'
$LngMs1='Comparison with original failed.'&@CRLF&'Save in Error.txt?'
$LngMs2='The difference is only in gaps and/or tab'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngTitle='Converter AU3 to BBcode'
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngSite='Сайт'
	$LngCopy='Копировать'
	$LngUDr='используйте drag-and-drop'
	$LngCbFl='В буфер (иначе в файл)'
	$LngBBHL='BBcode (иначе HTML)'
	$LngChk='Обратная проверка BBcode'
	$LngChkH='Проверка удалением тегов'
	$LngThs='Тема:'
	$LngThsH='Перезапишет CSS'
	$LngOpF='Открыть'
	$LngOpFH='Открыть файл au3, cmd, bat, reg, ini'
	$LngFCb='из буфера'
	$LngFCbH='Обработать код, прочитав'&@CRLF&'из буфера обмена'
	$LngSet='Настройки BBcode'
	$LngNCd='Не добавлять [code]...[/code]'
	$LngBkw='[b] для ключевых слов'
	$LngBvr='[b] для переменных'
	$LngIcm='[i] для комментариев'
	$LngOpC='Скрипт'
	$LngHlp1='Справка'
	$LngHlp2='Утилитка конвертирующая (обрамляет тегами) файлы AU3, CMD, REG в формат HTML или BBcode для последующего выкладывания на форумах.'&@CRLF&@CRLF&'Перетаскивайте скрипт на утилиту и она автоматически выполнит конвертирование.'&@CRLF&@CRLF&'Попробуйте сравнить готовый результат скопировав с форума, обычно разница может быть в пробелах.'&@CRLF&@CRLF&'На некоторых форумах необходимо удалить теги [code]'&@CRLF&@CRLF&'В качестве конвертера утилита использует SciTE'
	$LngSD1='Отправлено в буфер'
	$LngSD2='раз, за'
	$LngSD3='сек'
	$LngSD4='Создан'
	$LngSD5=', за'
	$LngSD6='Обработка ...'
	$LngErr='Ошибка'
	$LngMs1='Сравнение с оригиналом неудачно '&@CRLF&'Хотите сохранить неисправную копию в файл Error.txt?'
	$LngMs2='Разница только в пробелах и/или табуляции'
EndIf

If $Xpos < 0 Then $Xpos=0
If $Xpos> @DesktopWidth-260 Then $Xpos=@DesktopWidth-260
If $Xtmp='' Then $Xpos=-1
If $Ypos < 0 Then $Ypos=0
If $Ypos> @DesktopHeight-280 Then $Ypos=@DesktopHeight-280
If $Ytmp='' Then $Ypos=-1

;создание оболочки
$Gui=GUICreate("AU3 to BBcode",260,280, $Xpos, $Ypos, -1, $WS_EX_ACCEPTFILES)
If Not @compiled Then GUISetIcon(@ScriptDir&'\ConverterAU3.ico', 0)
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

$chCheck=GUICtrlCreateCheckbox ($LngChk, 10, 70,157,20)
GUICtrlSetState(-1, 8)
If $TrCheck=1 Then GuiCtrlSetState(-1, 1)
GUICtrlSetTip(-1, $LngChkH)

GUICtrlCreateLabel($LngThs, 10, 116, 43, 17)
$StyleCombo=GUICtrlCreateCombo('', 53, 113, 90,18, $CBS_DROPDOWNLIST)
GUICtrlSetData($StyleCombo, $StyleAll, $TrSB)
GUICtrlSetTip(-1, $LngThsH)
GUICtrlSetState(-1, 8)

GUICtrlCreateGroup('', 168, 54, 91, 67)
$TypeFileCombo=GUICtrlCreateCombo('', 190, 95, 50,18, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, $TypeFileAll, $TypeFile)
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

$SciTE = SciTE_Start()

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case -13
			$Tmp1=StringRight(@GUI_DRAGFILE, 4)
			If StringInStr(';.cmd;.bat;.au3;.reg;.ini;', ';'&$Tmp1&';') Then
				GUICtrlSetData($StatusBar, $LngSD6)
				If $TypeFile<>$Tmp1 Then
					$TypeFile=$Tmp1
					_StyleIni()
				EndIf
				_ConvCMD(@GUI_DRAGFILE)
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
		_StyleIni()
		_CreateCSS()

	  Case $chBBcode
		If GUICtrlRead($chBBcode)=1 Then
			_ChState($GUI_ENABLE)
		Else
			_ChState($GUI_DISABLE)
		EndIf
	  Case $Byfer
		$Tmp1=GUICtrlRead($TypeFileCombo)
		If $TypeFile<>$Tmp1 Then
			$TypeFile=$Tmp1
			_StyleIni()
		EndIf
		GUICtrlSetData($StatusBar, $LngSD6)
		$Timer=TimerInit()
		$Tmp=ClipGet()
		
		$file = FileOpen(@TempDir&'\Byfer_Conv_AU3'&$TypeFile, 2)
		FileWrite($file, $Tmp)
		FileClose($file)
		
		_ConvCMD(@TempDir&'\Byfer_Conv_AU3'&$TypeFile, 1)

		; кнопки "Обзор"
	  Case $OpFile
		If Not FileExists($CurPath) Then $CurPath=@ScriptDir
		$tmp = FileOpenDialog($LngOpF, $CurPath , $LngOpC&' (*.cmd;*.bat;*.au3;*.reg;*.ini)', '', '', $Gui)
		$Tmp1=StringRight($tmp, 4)
		If Not @error And StringInStr(';.cmd;.bat;.au3;.reg;.ini;', ';'&$Tmp1&';') Then
			If $TypeFile<>$Tmp1 Then
				$TypeFile=$Tmp1
				_StyleIni()
			EndIf
			$CurPath=StringRegExpReplace($tmp, '(^.*)\\(.*)$', '\1')
			GUICtrlSetData($StatusBar, $LngSD6)
			_ConvCMD($tmp)
		EndIf

       Case $Help
           MsgBox(8192, $LngHlp1, StringRegExpReplace($LngHlp2, '(.{70,}?[ ])(.*?)', '$0'&@CRLF))
       Case $About
           _About()
		Case -3
			IniWrite($Ini, 'Set', 'CurPath', $CurPath)
			SciTe_End($SciTE)
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
	
	IniWrite($Ini, 'Set', 'SB', '"'&GUICtrlRead($StyleCombo)&'"')
	
	IniWrite($Ini, 'Set', 'NoCode', GUICtrlRead($ChCode))
	IniWrite($Ini, 'Set', 'B_KW', GUICtrlRead($ChB_KW))
	IniWrite($Ini, 'Set', 'B_Var', GUICtrlRead($ChB_Var))
	IniWrite($Ini, 'Set', 'i_Com', GUICtrlRead($Chi_Com))
	
	IniWrite($Ini, 'Set', 'Topmost', GUICtrlRead($ChTopmost))
	IniWrite($Ini, 'Set', 'TypeFile', $TypeFile)
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


Func _ConvCMD($input, $byf=0)
	$tmpBB=GUICtrlRead($chBBcode)
	$tmpCB=GUICtrlRead($chCB)
	$tmpEn=GUICtrlRead($ChEn)
	$tmpCheck=GUICtrlRead($ChCheck)
	
	$Timer=TimerInit()
	
	If $tmpCheck=1 Then
		$file = FileOpen($input, 0)
		$tmpHTML = FileRead($file)
		FileClose($file)
	EndIf
	
	SciTe_Convert($SciTE, $input, @TempDir&'~ConvCMD.htm')
	
	$file = FileOpen(@TempDir&'~ConvCMD.htm', 0)
	$HTML = FileRead($file)
	FileClose($file)
	
	If $tmpEn=1 Then $HTML=_Encoding_866To1251($HTML)

	
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
		; модуль замены ключевых слов BBCode (замена HTML тегов на BBCode)
		$H16='[0-9A-Fa-f]{6}'

		$HTML = StringRegExpReplace($HTML, '(?s)^.*?<body bgcolor="#.*?<span>', '') ; удаляем шапку
		$HTML = StringLeft($HTML, StringInStr($HTML, '</body>') - 8) ; читаем до тега </body>
		$HTML = StringReplace($HTML, "<br />", "") ; удаляем <br />
		$HTML = StringReplace($HTML, "</span>", "[/color]") ; замена закрывающего тега

		For $i = 0 to $amClr
			$HTML = StringReplace($HTML, '<span class="S'&$i&'">', '[color=#'&$aThColor[$i]&']') ; замена открывающего тега
		Next
		$HTML = StringRegExpReplace($HTML, '&nbsp;', ' ') ; замена HTML-пробелов
		$HTML=StringRegExpReplace($HTML, '(?m)\[color=\#'&$H16&'\]([ ]*)\[/color\]', '$1') ; удаление тегов пробелов
		$HTML = StringTrimRight($HTML, 2) ; удаление в конце строки добавленные символы @CRLF
		
		; замена спецсимволов
		$HTML = StringRegExpReplace($HTML,'&(quot|#34);', '"')
		$HTML = StringRegExpReplace($HTML,'&(amp|#38);', '&')
		$HTML = StringRegExpReplace($HTML,'&(lt|#60);', '<')
		$HTML = StringRegExpReplace($HTML,'&(gt|#62);', '>')
		$HTML = StringRegExpReplace($HTML,'&(nbsp|#160);', ' ')
		$HTML = StringRegExpReplace($HTML,'&(iexcl|#161);', 'chr(161)')
		$HTML = StringRegExpReplace($HTML,'&(cent|#162);', 'chr(162)')
		$HTML = StringRegExpReplace($HTML,'&(pound|#163);', 'chr(163)')
		$HTML = StringRegExpReplace($HTML,'&(copy|#169);', 'chr(169)')
		$HTML = StringRegExpReplace($HTML,'&#(\d+);', 'chr(\\1)')
		
		$HTML=StringRegExpReplace($HTML, '(?m)(\[color=#('&$H16&')\][^\[]*?)\[/color\]([	 ]*)\[color=#\2\]', '\1\3')
		; $HTML=StringRegExpReplace($HTML, '(?m)\[color=#'&$H16&'\][ 	]*?\[/color\]', '')

		; формат шрифта
		If $tmpB_KW=1 Then
			$HTML=StringRegExpReplace($HTML, '(?i)(\[color=#'&$aThColor[5]&'\].*?\[/color\])', '[b]$1[/b]')
		EndIf
		
		If $tmpB_Var=1 Then
			$HTML=StringRegExpReplace($HTML, '(?i)(\[color=#'&$aThColor[9]&'\].*?\[/color\])', '[b]$1[/b]')
		EndIf
		
		If $tmpi_Com=1 Then
			$HTML=StringRegExpReplace($HTML, '(?i)(\[color=#'&$aThColor[1]&'\].*?\[/color\])', '[i]$1[/i]')
			; $HTML=StringRegExpReplace($HTML, '(?i)(\[color=#'&$aThColor[2]&'\].*?\[/color\])', '[i]$1[/i]')
		EndIf
		
		; $HTML=StringTrimLeft($HTML, 2)
		
		; проверка удалением тегов
		If $tmpCheck=1 Then
			$ChecHTML=StringRegExpReplace($HTML, '\[color=#'&$H16&'\](.*?)\[/color\]', '$1')
			If $tmpB_KW=1 Or $tmpB_Var=1 Then $ChecHTML=StringRegExpReplace($ChecHTML, '\[b\](.*?)\[/b\]', '$1')
			If $tmpi_Com=1 Then $ChecHTML=StringRegExpReplace($ChecHTML, '\[i\](.*?)\[/i\]', '$1')
			If $tmpHTML<>$ChecHTML Then
				$tmp=''
				If StringRegExpReplace($tmpHTML, '[	 ]+', '')==StringRegExpReplace($ChecHTML, '[	 ]+', '') Then $tmp=@CRLF&@CRLF&$LngMs2
				If MsgBox(4, $LngErr, $LngMs1&$tmp)=6 Then $TrSvErr=1
			EndIf
		EndIf
		;i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
		If $TrNoCode<>1 Then $HTML='[code]'&$HTML&'[/code]'
	Else
		If Not FileExists($StyleFile) Then _CreateCSS()
		$type='.htm'
		$head1= _
		'<html>' & @CRLF & _
		'<head>' & @CRLF & _
		'<LINK REL=STYLESHEET TYPE="text/css" HREF="'&$StyleFile&'" title="style">'& @CRLF & _
		'<pre class=au3_codebox>' & @CRLF

		$End2= @CRLF & _
		'</pre>' & @CRLF & _
		'</html>'
		;i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
		; модуль замены ключевых слов HTML
		$HTML = StringRegExpReplace($HTML, '(?s)^.*?<body bgcolor="#.*?<span>', '') ; удаляем шапку
		$HTML = StringLeft($HTML, StringInStr($HTML, '</body>') - 1) ; читаем до тега </body>
		$HTML = StringReplace($HTML, "<br />", "") ; удаляем <br />
		; $HTML = StringReplace($HTML, "</span>" & @CRLF, "</span><br>" & @CRLF) ; вставка перехода на новую строку
		$HTML = StringReplace($HTML, "  ", "&nbsp;&nbsp;") ; двойной пробел на спецсимвол пробела в HTML
		$HTML = StringTrimRight($HTML, 9) ; удаление в конце строки добавленные символы <br>" & @CRLF

		; $HTML=StringTrimLeft($HTML, 2)
		
		; проверка удалением тегов
		; If $tmpCheck=1 Then
			; $ChecHTML=StringRegExpReplace($HTML, '<span class="S\d{1,2}">(.*?)</span>', '$1')
			; If $tmpHTML<>$ChecHTML And MsgBox(4, $LngErr, $LngMs1)=6 Then
				; If StringRegExpReplace($tmpHTML, '[	 ]+', '')==StringRegExpReplace($ChecHTML, '[	 ]+', '') Then MsgBox(0, 'Сообщение', 'Разница только в пробелах и/или табуляции')
				; $TrSvErr=1
			; EndIf
		; EndIf
		;i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
		$HTML=$head1&$HTML&$End2
	EndIf

	_Sini('CB')
	_Sini('BB')
	_Sini('En')
	_Sini('Check')
	
	If $byf = 1 Then
		_SaveCMD($HTML)
	Else
		_SaveCMD($HTML, $input)
	EndIf
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
	GUICtrlSetState($chCheck, $st)
EndFunc

Func _StyleIni()
	Switch $TypeFile
		Case '.cmd', '.bat'
			$amClr=7
			$StyleFile=@ScriptDir&'\StyleCMD.css'
		Case '.reg', '.ini'
			$amClr=7
			$StyleFile=@ScriptDir&'\StyleREG.css'
		Case Else
			$amClr=15
			$StyleFile=@ScriptDir&'\Style.css'
	EndSwitch
	Switch $TrSB
		Case 'из ini'
			Switch $TypeFile
				Case '.cmd', '.bat'
					$BACKGROUND=IniRead($Ini, 'ColorCMD', 'BACKGROUND', 'FFFFFF')
					$BKGRD2=IniRead($Ini, 'ColorCMD', 'BKGRD2', 'FFFF00')
					$BORDER=IniRead($Ini, 'ColorCMD', 'BORDER', 'AAAAAA')
					$aThColor[0]=IniRead($Ini, 'ColorCMD', '0', '999999')
					$aThColor[1]=IniRead($Ini, 'ColorCMD', '1', '008000')
					$aThColor[2]=IniRead($Ini, 'ColorCMD', '2', '0000FF')
					$aThColor[3]=IniRead($Ini, 'ColorCMD', '3', 'FF0000')
					$aThColor[4]=IniRead($Ini, 'ColorCMD', '4', 'FF00FF')
					$aThColor[5]=IniRead($Ini, 'ColorCMD', '5', '0080FF')
					$aThColor[6]=IniRead($Ini, 'ColorCMD', '6', 'FF8000')
					$aThColor[7]=IniRead($Ini, 'ColorCMD', '7', 'FF0000')
					$aThColor[8]=IniRead($Ini, 'ColorCMD', '8', 'D39D72')
					$aThColor[9]=IniRead($Ini, 'ColorCMD', '9', 'D39D72')
					$aThColor[10]=IniRead($Ini, 'ColorCMD', '10', '448489')
					$aThColor[11]=IniRead($Ini, 'ColorCMD', '11', 'F000FF')
					$aThColor[12]=IniRead($Ini, 'ColorCMD', '12', 'A00FF0')
					$aThColor[13]=IniRead($Ini, 'ColorCMD', '13', '0080FF')
					$aThColor[14]=IniRead($Ini, 'ColorCMD', '14', '0000FF')
					$aThColor[15]=IniRead($Ini, 'ColorCMD', '15', '0080FF')
				Case '.reg', '.ini'
					$BACKGROUND=IniRead($Ini, 'ColorREG', 'BACKGROUND', 'FFFFFF')
					$BKGRD2=IniRead($Ini, 'ColorREG', 'BKGRD2', 'FFFF00')
					$BORDER=IniRead($Ini, 'ColorREG', 'BORDER', 'AAAAAA')
					$aThColor[0]=IniRead($Ini, 'ColorREG', '0', '000000')
					$aThColor[1]=IniRead($Ini, 'ColorREG', '1', '009933')
					$aThColor[2]=IniRead($Ini, 'ColorREG', '2', '0080FF')
					$aThColor[3]=IniRead($Ini, 'ColorREG', '3', 'FF0000')
					$aThColor[4]=IniRead($Ini, 'ColorREG', '4', 'FF8380')
					$aThColor[5]=IniRead($Ini, 'ColorREG', '5', '000000')
					$aThColor[6]=IniRead($Ini, 'ColorREG', '6', 'A7A7A7')
					$aThColor[7]=IniRead($Ini, 'ColorREG', '7', 'A7A7A7')
					$aThColor[8]=IniRead($Ini, 'ColorREG', '8', 'A7A7A7')
					$aThColor[9]=IniRead($Ini, 'ColorREG', '9', 'A7A7A7')
					$aThColor[10]=IniRead($Ini, 'ColorREG', '10', 'A7A7A7')
					$aThColor[11]=IniRead($Ini, 'ColorREG', '11', 'A7A7A7')
					$aThColor[12]=IniRead($Ini, 'ColorREG', '12', 'A7A7A7')
					$aThColor[13]=IniRead($Ini, 'ColorREG', '13', 'A7A7A7')
					$aThColor[14]=IniRead($Ini, 'ColorREG', '14', 'A7A7A7')
					$aThColor[15]=IniRead($Ini, 'ColorREG', '15', 'A7A7A7')
				Case Else
					$BACKGROUND=IniRead($Ini, 'ColorElse', 'BACKGROUND', 'FFFFFF')
					$BKGRD2=IniRead($Ini, 'ColorElse', 'BKGRD2', 'FFFF00')
					$BORDER=IniRead($Ini, 'ColorElse', 'BORDER', 'AAAAAA')
					$aThColor[0]=IniRead($Ini, 'ColorElse', '0', '000000')
					$aThColor[1]=IniRead($Ini, 'ColorElse', '1', '009933')
					$aThColor[2]=IniRead($Ini, 'ColorElse', '2', '669900')
					$aThColor[3]=IniRead($Ini, 'ColorElse', '3', 'AC00A9')
					$aThColor[4]=IniRead($Ini, 'ColorElse', '4', '000090')
					$aThColor[5]=IniRead($Ini, 'ColorElse', '5', '0000FF')
					$aThColor[6]=IniRead($Ini, 'ColorElse', '6', 'FF33FF')
					$aThColor[7]=IniRead($Ini, 'ColorElse', '7', '9999CC')
					$aThColor[8]=IniRead($Ini, 'ColorElse', '8', 'FF0000')
					$aThColor[9]=IniRead($Ini, 'ColorElse', '9', 'AA0000')
					$aThColor[10]=IniRead($Ini, 'ColorElse', '10', 'FF8800')
					$aThColor[11]=IniRead($Ini, 'ColorElse', '11', 'F000FF')
					$aThColor[12]=IniRead($Ini, 'ColorElse', '12', 'A00FF0')
					$aThColor[13]=IniRead($Ini, 'ColorElse', '13', '0080FF')
					$aThColor[14]=IniRead($Ini, 'ColorElse', '14', '0000FF')
					$aThColor[15]=IniRead($Ini, 'ColorElse', '15', '0080FF')
			EndSwitch
		Case 'Black'
			Switch $TypeFile
				Case '.cmd', '.bat'
					$BACKGROUND='3F3F3F'
					$BKGRD2='000'
					$BORDER='AAAAAA'
					$aThColor[0]='999999'
					$aThColor[1]='71AE71'
					$aThColor[2]='009FFF'
					$aThColor[3]='C8C800'
					$aThColor[4]='FF46FF'
					$aThColor[5]='AAA6DB'
					$aThColor[6]='D39D72'
					$aThColor[7]='FF8080'
					$aThColor[8]='D39D72'
					$aThColor[9]='D39D72'
					$aThColor[10]='448489'
					$aThColor[11]='F000FF'
					$aThColor[12]='A00FF0'
					$aThColor[13]='0080FF'
					$aThColor[14]='0000FF'
					$aThColor[15]='0080FF'
				Case '.reg', '.ini'
					$BACKGROUND='3F3F3F'
					$BKGRD2='000'
					$BORDER='AAAAAA'
					$aThColor[0]='A7A7A7'
					$aThColor[1]='71AE71'
					$aThColor[2]='4A88D2'
					$aThColor[3]='FF8080'
					$aThColor[4]='FF8380'
					$aThColor[5]='A7A7A7'
					$aThColor[6]='A7A7A7'
					$aThColor[7]='A7A7A7'
					$aThColor[8]='A7A7A7'
					$aThColor[9]='A7A7A7'
					$aThColor[10]='A7A7A7'
					$aThColor[11]='A7A7A7'
					$aThColor[12]='A7A7A7'
					$aThColor[13]='A7A7A7'
					$aThColor[14]='A7A7A7'
					$aThColor[15]='A7A7A7'
				Case Else
					$BACKGROUND='3F3F3F'
					$BKGRD2='000'
					$BORDER='AAAAAA'
					$aThColor[0]='72ADC0'
					$aThColor[1]='71AE71'
					$aThColor[2]='71AE71'
					$aThColor[3]='C738B9'
					$aThColor[4]='AAA6DB'
					$aThColor[5]='0080FF'
					$aThColor[6]='FF46FF'
					$aThColor[7]='999999'
					$aThColor[8]='FF8080'
					$aThColor[9]='D29A6C'
					$aThColor[10]='EA9515'
					$aThColor[11]='F000FF'
					$aThColor[12]='0080C0'
					$aThColor[13]='7D8AE6'
					$aThColor[14]='0080FF'
					$aThColor[15]='7D8AE6'
			EndSwitch
		Case 'White'
			Switch $TypeFile
				Case '.cmd', '.bat'
					$BACKGROUND='FFFFFF'
					$BKGRD2='FFFF00'
					$BORDER='AAAAAA'
					$aThColor[0]='999999'
					$aThColor[1]='008000'
					$aThColor[2]='0000FF'
					$aThColor[3]='FF0000'
					$aThColor[4]='FF00FF'
					$aThColor[5]='0080FF'
					$aThColor[6]='FF8000'
					$aThColor[7]='FF0000'
					$aThColor[8]='D39D72'
					$aThColor[9]='D39D72'
					$aThColor[10]='448489'
					$aThColor[11]='F000FF'
					$aThColor[12]='A00FF0'
					$aThColor[13]='0080FF'
					$aThColor[14]='0000FF'
					$aThColor[15]='0080FF'
				Case '.reg', '.ini'
					$BACKGROUND='FFFFFF'
					$BKGRD2='FFFF00'
					$BORDER='AAAAAA'
					$aThColor[0]='000000'
					$aThColor[1]='009933'
					$aThColor[2]='0080FF'
					$aThColor[3]='FF0000'
					$aThColor[4]='FF8380'
					$aThColor[5]='000000'
					$aThColor[6]='A7A7A7'
					$aThColor[7]='A7A7A7'
					$aThColor[8]='A7A7A7'
					$aThColor[9]='A7A7A7'
					$aThColor[10]='A7A7A7'
					$aThColor[11]='A7A7A7'
					$aThColor[12]='A7A7A7'
					$aThColor[13]='A7A7A7'
					$aThColor[14]='A7A7A7'
					$aThColor[15]='A7A7A7'
				Case Else
					$BACKGROUND='FFFFFF'
					$BKGRD2='FFFF00'
					$BORDER='AAAAAA'
					$aThColor[0]='000000'
					$aThColor[1]='009933'
					$aThColor[2]='669900'
					$aThColor[3]='AC00A9'
					$aThColor[4]='000090'
					$aThColor[5]='0000FF'
					$aThColor[6]='FF33FF'
					$aThColor[7]='9999CC'
					$aThColor[8]='FF0000'
					$aThColor[9]='AA0000'
					$aThColor[10]='FF8800'
					$aThColor[11]='F000FF'
					$aThColor[12]='A00FF0'
					$aThColor[13]='0080FF'
					$aThColor[14]='0000FF'
					$aThColor[15]='0080FF'
			EndSwitch
	EndSwitch
	
	
; $aThColor[0]='72ADC0'
; $aThColor[1]='71AE71'
; $aThColor[2]='71AE71'
; $aThColor[3]='C738B9'
; $aThColor[4]='AAA6DB'
; $aThColor[5]='0080FF'
; $aThColor[6]='FF46FF'
; $aThColor[7]='999999'
; $aThColor[8]='FF8080'
; $aThColor[9]='D29A6C'
; $aThColor[10]='EA9515'
; $aThColor[11]='F000FF'
; $aThColor[12]='0080C0'
; $aThColor[13]='7D8AE6'
; $aThColor[14]='0080FF'
; $aThColor[15]='7D8AE6'
; Global $aThColor[16]=[ _
; '72ADC0', _ ; 0 - DEFAULT
; '71AE71', _ ; 1 - Comment Line
; '71AE71', _ ; 2 - Comment
; 'C738B9', _ ; 3 - Number
; 'AAA6DB', _ ; 4 - Function
; '0080FF', _ ; 5 - Keyword
; 'FF46FF', _ ; 6 - Macro
; '999999', _ ; 7 - String
; 'FF8080', _ ; 8 - Operator
; 'D29A6C', _ ; 9 - Variable
; 'EA9515', _ ; 10 - Sent
; 'F000FF', _ ; 11 - Preprocessor
; '0080C0', _ ; 12 - Special
; '7D8AE6', _ ; 13 - Abbrev-Expand
; '0080FF', _ ; 14 - Com Objects
; '7D8AE6'] ; 15 - Standard UDF's
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
    $Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], $WS_CAPTION+$WS_SYSMENU, -1, $Gui)
	If Not @compiled Then GUISetIcon(@ScriptDir&'\ConverterAU3.ico', 0)
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,15, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,268,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.1  28.06.2011', 55, 100, 210, 17)
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
'body{background-color:#'&$BACKGROUND&';font-family: Arial;font-weight:normal;color:#999999;}' & @CRLF & _
@CRLF & _
'.au3_codebox {' & @CRLF & _
'	BORDER-BOTTOM: #AAAAAA 1px solid;' & @CRLF & _
'	BORDER-LEFT: #AAAAAA 1px solid;' & @CRLF & _
'	BORDER-RIGHT: #AAAAAA 1px solid;' & @CRLF & _
'	BORDER-TOP: #AAAAAA 1px solid;' & @CRLF & _
'	PADDING-RIGHT: 8px;' & @CRLF & _
'	PADDING-LEFT: 8px;' & @CRLF & _
'	PADDING-BOTTOM: 8px;' & @CRLF & _
'	PADDING-TOP: 8px;' & @CRLF & _
'	FONT-SIZE: x-small;' & @CRLF & _
'	FONT-FAMILY: Arial, Courier New, Courier, Verdana;' & @CRLF & _
'	COLOR: #72ADC0;' & @CRLF & _
'	WHITE-SPACE: normal;' & @CRLF & _
'	BACKGROUND-COLOR: #'&$BACKGROUND & @CRLF & _
'}' & @CRLF & _
@CRLF & _
'.S0 /* DEFAULT */' & @CRLF & _
'{' & @CRLF & _
'	font-weight: normal;' & @CRLF & _
'	color: #'&$aThColor[0]&';' & @CRLF & _
'}' & @CRLF & _
'.S1 /* Comment Line */' & @CRLF & _
'{' & @CRLF & _
'	font-style: italic;' & @CRLF & _
'	color: #'&$aThColor[1]&';' & @CRLF & _
'}' & @CRLF & _
'.S2 /* Comment */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[2]&';' & @CRLF & _
'}' & @CRLF & _
'.S3 /* Number */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[3]&';' & @CRLF & _
'}' & @CRLF & _
'.S4 /* Function */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[4]&';' & @CRLF & _
'}' & @CRLF & _
'.S5 /* Keyword */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[5]&';' & @CRLF & _
'}' & @CRLF & _
'.S6 /* Macro */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[6]&';' & @CRLF & _
'}' & @CRLF & _
'.S7 /* String */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[7]&';' & @CRLF & _
'}' & @CRLF & _
'.S8 /* Operator */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[8]&';' & @CRLF & _
'}' & @CRLF & _
'.S9 /* Variable */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[9]&';' & @CRLF & _
'}' & @CRLF & _
'.S10 /* Sent */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[10]&';' & @CRLF & _
'}' & @CRLF & _
'.S11 /* Preprocessor */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[11]&';' & @CRLF & _
'}' & @CRLF & _
'.S12 /* Special */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[12]&';' & @CRLF & _
'}' & @CRLF & _
'.S13 /* Abbrev-Expand */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[13]&';' & @CRLF & _
'}' & @CRLF & _
'.S14 /* Com Objects */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[14]&';' & @CRLF & _
'}' & @CRLF & _
'.S15 /* Standard UDF''s */' & @CRLF & _
'{' & @CRLF & _
'	color: #'&$aThColor[15]&';' & @CRLF & _
'}'
$file = FileOpen($StyleFile,2)
FileWrite($file, $text)
FileClose($file)
EndFunc