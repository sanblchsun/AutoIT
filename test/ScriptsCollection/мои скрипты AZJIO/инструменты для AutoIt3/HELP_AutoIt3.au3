;  @AZJIO
; ������ ��� ������ ������� �� Notepad++ ����������� �����. ������ ������� � ��� ������ ����� � ����� 1-3, ������������� � ���� ����������� ��������������� ������� � ������� �����. ���� ������� �������, �� ��� �� ����������� ��������, � �������������� ����������� ����. ���������� ������ ������������� �������, � ����������� �������� ������ ����������.
;"C:\Program Files\AutoIt3\AutoIt3.exe" "C:\Program Files\AutoIt3\\HELP_AutoIt3.au3 $(CURRENT_WORD) 1


; En
; $LngMs1='Error'
; $LngMs2='Select the text you want to send to the help file'
; $LngMs3='Word in the UDF, but the directory (Include) is not found'
; $LngMs4='Not found'

; Ru
$LngMs1='������'
$LngMs2='�������� �����, ������� ��������� ��������� � �������'
$LngMs3='����� � ������ UDF, �� ������� Include �� ������'
$LngMs4='�� ������'

; $LngTitle1='AutoIt Help' ; En
$LngTitle1='������� AutoIt' ; Ru
$sFile1='AutoIt.chm'

$LngTitle2='AutoIt'
$sFile2='AutoIt3_2_5_4_ru.chm'

$LngTitle3='������� AutoIt �� UDF'
$sFile3='UDFs3_google.chm'

; �������� �������� � ������� ��������� UDF
$sPath_Edit = 'Notepad++\notepad++.exe'
; $sPath_Edit = 'SciTE\SciTE.exe'

; Global $Title_File[3][2] = [ _
; ['������� AutoIt', 'AutoIt.chm'], _
; ['AutoIt', 'AutoIt3_2_5_4_ru.chm'], _
; ['������� AutoIt �� UDF', 'UDFs3_google.chm']]

;#include <Array.au3>
; Opt("WinTitleMatchMode", 3) ; ���������� ������ ������������, ����� ����� ���������� ����

If $CmdLine[0] > 1 Then
	; Opt("WinTextMatchMode", 3) ; ������ ����� ����
	Opt("WinTextMatchMode", 2) ; ������� �����
	$sAutoIt_Path = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "InstallDir")
	; � ���-������ ���������� 1-3 �������� ��������������� �������
	Switch $CmdLine[2]
		Case 1
			; _call('AutoIt UDFs Help', 'UDFs3.chm')
			; _call('AutoIt Help', 'AutoIt.chm') ; ������� ���������� AutoIt3 (����� �������) � UDFs3 �������
			_call($LngTitle1, $sFile1) ; ������� ���������� AutoIt3 (����� �������) � UDFs3 �������
		Case 2
			_call($LngTitle2, $sFile2) ; ������ ������� �� �������.
		Case 3
			_call($LngTitle3, $sFile3) ; ������� � ��������� � google
	EndSwitch
Else
	MsgBox(0, $LngMs1, $LngMs2)
EndIf

Func _call($sWinTitle, $sName_File_CHM)
	; ������� ���� ��������� UDF � ���������
	$SearchText = 'SQLite.dll,GDIP,WinAPIEx,WinAPI,GuiListView,GuiRichEdit,GuiTreeView,StructureConstants,IE,GDIPlus,GuiToolbar,AutoItObject,Services,Date,GuiMenu,GuiReBar,GuiComboBoxEx,GuiEdit,Word,ModernMenuRaw,GuiListBox,GuiToolTip,GuiComboBox,GDIPConstants,GuiMonthCal,GuiHeader,WinNet,NetShare,_XMLDomWrapper,FTPEx,GuiTab,Array,Excel,SQLite,Visa,Table,GuiSlider,GuiScrollBars,GuiButton,SoundGetSetQuery,GuiStatusBar,GuiImageList,ID3,Midiudf - ��� v3.3.0.0,Clipboard,Icons,EventLog,Misc,Midiudf,File,audio,LocalAccount,ColorPicker,GDIpProgress,GuiDateTimePicker,NamedPipes,Security,GraphGDIPlus,Crypt,Sound,Memory,ExpListView,Debug,SysTray_UDF,HotKey_17b,BigNum,HotKey,GUICtrlOnHover,WindowsConstants,HKCUReg,Constants,Resources,Encoding,GuiIPAddress,ListViewConstants,AutoItObject.dll,GUICtrlSetOnHover_UDF,HotKeyInput,GuiAVI,String,GUICtrlSetOnHover,Inet,hash,ScreenCapture,Timers,IsPressed_UDF,Reg,ToolTip_UDF,ToolbarConstants,RichEditConstants,HotKeySelect,GDIPlusConstants,Registry_UDFs,Color,TIG,WMMedia,ComboConstants,ListView_Progress,TreeViewConstants,UDFGlobalID,Math,GUIScroll,HeaderConstants,DateTimeConstants,RebarConstants,TabConstants,ToolTipConstants,ListBoxConstants,vkConstants,Process,MenuConstants,EditConstants,SendMessage,vkArray,SliderConstants,SecurityConstants,ButtonConstants,Privilege,FileConstants,StatusBarConstants,GUIConstantsEx,FontConstants,WinAPIError,ColorConstants,�������� Include.txt,ProgressConstants,BorderConstants,MemoryConstants,FrameConstants,ScrollBarConstants,ImageListConstants,StaticConstants,IPAddressConstants,ProcessConstants,UpDownConstants,DirConstants,AVIConstants,GUIConstants'
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
	
	; ���� ����� �� UDF-����, �� ��������� ��� ��� ������� � �������
	$WinR = '[TITLE:' & $sWinTitle & ';CLASS:HH Parent]'

	If WinExists($WinR) Then
		$hWnd = WinActivate($WinR)
		If Not $hWnd Then Exit
	Else
		; If $CmdLine[2]=1 And FileExists($sAutoIt_Path & '\AutoIt3Help.exe') Then ; ���� �������� ������� � ���������� exe, ��
			; Run($sAutoIt_Path & '\AutoIt3Help.exe ' & $CmdLine_1) ; ��������� ��������
			; Exit
		; Else
			ShellExecute($sAutoIt_Path & '\' & $sName_File_CHM, "", $sAutoIt_Path) ; ��������� ��������� ����
			$hWnd = WinWaitActive($WinR, '', 3)
			If Not $hWnd Then Exit
		; EndIf
	EndIf
	; $hWnd �������
	$hControl = ControlGetHandle($hWnd, "", '[CLASS:SysTabControl32;INSTANCE:1]') ; �������� ���������� �������
	If Not $hControl Then Exit
	$Tab = ControlCommand($hWnd, "", $hControl, "CurrentTab") ; �������� ����� �������

	If ControlGetFocus($hWnd)='Internet Explorer_Server1' Then ; ���� ������� ������ ����� ����, ��
		ControlSend($hWnd, "", "[CLASS:Internet Explorer_Server;INSTANCE:1]", '{F6}')
		Sleep(50)
	EndIf

	Switch $Tab ; ������������ �� �������� ������ ������� ����������� �� ������ �������
		Case 1
			ControlCommand($hWnd, "", $hControl, "TabRight")
		Case 2
			Sleep(10)
		Case 3
			ControlCommand($hWnd, "", $hControl, "TabLeft")
		Case 4
			ControlCommand($hWnd, "", $hControl, "TabLeft")
			ControlCommand($hWnd, "", $hControl, "TabLeft")
		Case Else ; ���� ��� �� ����, ������ ��� ����������� � �����
			Exit
	EndSwitch
	Sleep(30)
	$hControlEdit = ControlGetHandle($hWnd, "", '[CLASS:Edit;INSTANCE:3]') ; �������� ���������� ���� �����
	ControlSetText($hWnd, '', $hControlEdit, $CmdLine_1) ; ��������� ����� � ���� �����
	ControlFocus($hWnd, '', $hControlEdit) ; ���������� ���� �����
	Sleep(50)
	Send("{ENTER}") ; ��������� Enter � ���� �����, ��� �������� � �������
EndFunc