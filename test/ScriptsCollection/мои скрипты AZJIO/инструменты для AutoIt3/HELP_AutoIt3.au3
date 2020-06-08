;  @AZJIO
; Скрипт для вызова справки из Notepad++ выделенного слова. Скрипт передаёт в ком строку слово и число 1-3, всоответствии с этим открывается соответствующая справка с поиском слова. Если справка открыта, то она не открывается повторно, а активизируется необходимое окно. Предыдущая версия перезапускала справку, с неудобством закрытия дерева содержания.
;"C:\Program Files\AutoIt3\AutoIt3.exe" "C:\Program Files\AutoIt3\\HELP_AutoIt3.au3 $(CURRENT_WORD) 1


; En
; $LngMs1='Error'
; $LngMs2='Select the text you want to send to the help file'
; $LngMs3='Word in the UDF, but the directory (Include) is not found'
; $LngMs4='Not found'

; Ru
$LngMs1='Ошибка'
$LngMs2='Выделите текст, который требуется отправить в справку'
$LngMs3='Слово в списке UDF, но каталог Include не найден'
$LngMs4='Не найден'

; $LngTitle1='AutoIt Help' ; En
$LngTitle1='Справка AutoIt' ; Ru
$sFile1='AutoIt.chm'

$LngTitle2='AutoIt'
$sFile2='AutoIt3_2_5_4_ru.chm'

$LngTitle3='Справка AutoIt по UDF'
$sFile3='UDFs3_google.chm'

; Выбираем редактор в котором открывать UDF
$sPath_Edit = 'Notepad++\notepad++.exe'
; $sPath_Edit = 'SciTE\SciTE.exe'

; Global $Title_File[3][2] = [ _
; ['Справка AutoIt', 'AutoIt.chm'], _
; ['AutoIt', 'AutoIt3_2_5_4_ru.chm'], _
; ['Справка AutoIt по UDF', 'UDFs3_google.chm']]

;#include <Array.au3>
; Opt("WinTitleMatchMode", 3) ; выставляем точное соответствие, чтобы точно определить окно

If $CmdLine[0] > 1 Then
	; Opt("WinTextMatchMode", 3) ; точный поиск окна
	Opt("WinTextMatchMode", 2) ; быстрый режим
	$sAutoIt_Path = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "InstallDir")
	; в ком-строке параметром 1-3 вызываем соответствующую справку
	Switch $CmdLine[2]
		Case 1
			; _call('AutoIt UDFs Help', 'UDFs3.chm')
			; _call('AutoIt Help', 'AutoIt.chm') ; команда объединяет AutoIt3 (новая русская) и UDFs3 справку
			_call($LngTitle1, $sFile1) ; команда объединяет AutoIt3 (новая русская) и UDFs3 справку
		Case 2
			_call($LngTitle2, $sFile2) ; старая русская от Иванова.
		Case 3
			_call($LngTitle3, $sFile3) ; справка с переводом в google
	EndSwitch
Else
	MsgBox(0, $LngMs1, $LngMs2)
EndIf

Func _call($sWinTitle, $sName_File_CHM)
	; Участок кода открывает UDF в редакторе
	$SearchText = 'SQLite.dll,GDIP,WinAPIEx,WinAPI,GuiListView,GuiRichEdit,GuiTreeView,StructureConstants,IE,GDIPlus,GuiToolbar,AutoItObject,Services,Date,GuiMenu,GuiReBar,GuiComboBoxEx,GuiEdit,Word,ModernMenuRaw,GuiListBox,GuiToolTip,GuiComboBox,GDIPConstants,GuiMonthCal,GuiHeader,WinNet,NetShare,_XMLDomWrapper,FTPEx,GuiTab,Array,Excel,SQLite,Visa,Table,GuiSlider,GuiScrollBars,GuiButton,SoundGetSetQuery,GuiStatusBar,GuiImageList,ID3,Midiudf - для v3.3.0.0,Clipboard,Icons,EventLog,Misc,Midiudf,File,audio,LocalAccount,ColorPicker,GDIpProgress,GuiDateTimePicker,NamedPipes,Security,GraphGDIPlus,Crypt,Sound,Memory,ExpListView,Debug,SysTray_UDF,HotKey_17b,BigNum,HotKey,GUICtrlOnHover,WindowsConstants,HKCUReg,Constants,Resources,Encoding,GuiIPAddress,ListViewConstants,AutoItObject.dll,GUICtrlSetOnHover_UDF,HotKeyInput,GuiAVI,String,GUICtrlSetOnHover,Inet,hash,ScreenCapture,Timers,IsPressed_UDF,Reg,ToolTip_UDF,ToolbarConstants,RichEditConstants,HotKeySelect,GDIPlusConstants,Registry_UDFs,Color,TIG,WMMedia,ComboConstants,ListView_Progress,TreeViewConstants,UDFGlobalID,Math,GUIScroll,HeaderConstants,DateTimeConstants,RebarConstants,TabConstants,ToolTipConstants,ListBoxConstants,vkConstants,Process,MenuConstants,EditConstants,SendMessage,vkArray,SliderConstants,SecurityConstants,ButtonConstants,Privilege,FileConstants,StatusBarConstants,GUIConstantsEx,FontConstants,WinAPIError,ColorConstants,Описание Include.txt,ProgressConstants,BorderConstants,MemoryConstants,FrameConstants,ScrollBarConstants,ImageListConstants,StaticConstants,IPAddressConstants,ProcessConstants,UpDownConstants,DirConstants,AVIConstants,GUIConstants'
	$CmdLine_1 = $CmdLine[1]
	If StringRight($CmdLine_1, 4) = '.au3' Then $CmdLine_1 = StringTrimRight($CmdLine_1, 4)
	If StringInStr($SearchText, ',' & $CmdLine_1 & ',') Then

		$sInclude_Path = RegRead("HKLM\SOFTWARE\AutoIt v3\AutoIt", "InstallDir")
		If @error Or Not FileExists($sInclude_Path) Then
			$sInclude_Path = RegRead('HKCU\Software\AutoIt v3\Autoit', 'Include')
			If @error Or Not FileExists($sInclude_Path) Then
				MsgBox(0, $LngMs1, $LngMs3)
			EndIf
		Else
			$sInclude_Path &= "\Include"
		EndIf
		If FileExists($sInclude_Path & '\' & $CmdLine_1 & '.au3') Then
			Run('"' & $sAutoIt_Path & '\' & $sPath_Edit & '" "' & $sInclude_Path & '\' & $CmdLine_1 & '.au3"')
		Else
			MsgBox(0, $LngMs1, $LngMs4 & ' ' & $CmdLine_1 & '.au3')
		EndIf
		Exit
	EndIf
	
	; Если слово не UDF-файл, то открываем его как функцию в справке
	$WinR = '[TITLE:' & $sWinTitle & ';CLASS:HH Parent]'

	If WinExists($WinR) Then
		$hWnd = WinActivate($WinR)
		If Not $hWnd Then Exit
	Else
		; If $CmdLine[2]=1 And FileExists($sAutoIt_Path & '\AutoIt3Help.exe') Then ; если основная справка и существует exe, то
			; Run($sAutoIt_Path & '\AutoIt3Help.exe ' & $CmdLine_1) ; запускаем основную
			; Exit
		; Else
			ShellExecute($sAutoIt_Path & '\' & $sName_File_CHM, "", $sAutoIt_Path) ; запускаем указанный файл
			$hWnd = WinWaitActive($WinR, '', 3)
			If Not $hWnd Then Exit
		; EndIf
	EndIf
	; $hWnd получен
	$hControl = ControlGetHandle($hWnd, "", '[CLASS:SysTabControl32;INSTANCE:1]') ; Получаем дескриптор вкладки
	If Not $hControl Then Exit
	$Tab = ControlCommand($hWnd, "", $hControl, "CurrentTab") ; Получаем номер вкладки

	If ControlGetFocus($hWnd)='Internet Explorer_Server1' Then ; Если активна правая часть окна, то
		ControlSend($hWnd, "", "[CLASS:Internet Explorer_Server;INSTANCE:1]", '{F6}')
		Sleep(50)
	EndIf

	Switch $Tab ; Взависимости от текущего номера вкладки переключаем на нужную вкладку
		Case 1
			ControlCommand($hWnd, "", $hControl, "TabRight")
		Case 2
			Sleep(10)
		Case 3
			ControlCommand($hWnd, "", $hControl, "TabLeft")
		Case 4
			ControlCommand($hWnd, "", $hControl, "TabLeft")
			ControlCommand($hWnd, "", $hControl, "TabLeft")
		Case Else ; если что то иное, значит это неправильно и выход
			Exit
	EndSwitch
	Sleep(30)
	$hControlEdit = ControlGetHandle($hWnd, "", '[CLASS:Edit;INSTANCE:3]') ; Получаем дескриптор поля ввода
	ControlSetText($hWnd, '', $hControlEdit, $CmdLine_1) ; Вставляем текст в поле ввода
	ControlFocus($hWnd, '', $hControlEdit) ; Фокусируем поле ввода
	Sleep(50)
	Send("{ENTER}") ; Эмулируем Enter в поле ввода, для перехода к функции
EndFunc