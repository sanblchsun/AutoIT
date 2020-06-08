;  @AZJIO 25.03.2010
; ��������� ��������� �����, ��� ������ ��������� ��� ������ � ������� �������� ����� ������� � ����� ������������� ����� ����. �������� ������ ��� �������������� ����� ������� ��� LiveCD, ����� ����� ������� ������ ���������, ������ ������� ����������.
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=SaveFolders.exe
#AutoIt3Wrapper_icon=SaveFolders.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=SaveFolders.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#NoTrayIcon
Global $sTmp

GUICreate("SaveFolders v0.3", 500, 180)

GUICtrlCreateLabel("������", 15, 15, 41, 18)
$Session = GUICtrlCreateCombo("", 15, 32, 470, 25, 0x3) ; $CBS_DROPDOWNLIST=0x3 - ����� ���������������� ����������.

GUICtrlCreateLabel("������ �����", 15, 71, 74, 18)
$Folderlist = GUICtrlCreateCombo("", 15, 88, 470, 25, 0x3)

$OpenF = GUICtrlCreateButton("�����", 310, 12, 73, 20)
GUICtrlSetTip(-1, "������� ����� ����� ������")

$Open = GUICtrlCreateButton("�������", 390, 12, 73, 20)
GUICtrlSetTip(-1, "������� ������")

$Upd_list = GUICtrlCreateButton("��������", 310, 68, 73, 20)
GUICtrlSetTip(-1, "�������� ������")

$Save = GUICtrlCreateButton("���������", 390, 68, 73, 20)
GUICtrlSetTip(-1, "��������� ����� � ������")

$close = GUICtrlCreateButton("������� ��� �����", 80, 130, 130, 33)
GUICtrlSetTip(-1, "�� �������� ������")

$Openfolder = GUICtrlCreateButton("������� ��� �����", 290, 130, 130, 33)
GUICtrlSetTip(-1, "�� �������� ������")

;$auto = GUICtrlCreateCheckbox("���� ��������", 340, 134, 97, 18)
;GUICtrlSetState($auto, 1)

_GetWindows() ; ������ ������� ���������
_search() ; ������� ������ ������

GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $OpenF
			$file=GUICtrlRead ($Session)
			If $file='�������' Then
				Run('Explorer.exe "'&@ScriptDir&'"')
			Else
				$file = StringRegExpReplace($file, "(^.*)\\(.*)$", '\1')
				Run('Explorer.exe "'&$file&'"')
			EndIf
		Case $msg = $Upd_list
			_GetWindows()
			
		Case $msg = $Save
			$file_save = FileSaveDialog( "��������� ������", @ScriptDir & "", "Session (*.inc)", 24, "Session.inc")
			If @error Then ContinueLoop
			If StringRight($file_save, 4 )<>'.inc' Then $file_save&='.inc'
			$file = FileOpen($file_save, 2)
			If $file = -1 Then
 			   MsgBox(0, "������", "���������� ������� ����.")
 			   ContinueLoop
			EndIf
			FileWrite($file, $sTmp)
			FileClose($file)
			GUICtrlSendMsg($Session, 0x14B, 0, 0)
			_search()
			
		Case $msg = $Open
			$file_open = FileOpenDialog("��������� ������", @ScriptDir & "", "Session (*.inc)", 1 + 4 , "Session.inc")
			If @error Then ContinueLoop
			$file = FileOpen($file_open, 0)
			If $file = -1 Then
 			   MsgBox(0, "������", "���������� ������� ����.")
 			   ContinueLoop
			EndIf
			$sTmp = FileRead($file)
			GUICtrlSetData($Session, $file_open) 
			GUICtrlSetData($Folderlist, $sTmp) 
			FileClose($file)
			
		Case $msg = $Openfolder
			$aPath = StringSplit($sTmp, "|")
			For $i=1 To $aPath [0]
				If FileExists($aPath[$i]) Then Run('Explorer.exe "'&$aPath[$i]&'"')
			Next
			Sleep(300)
			_GetWindows()
			Sleep(300)
			WinActivate ( "SaveFolders") 
			
		Case $msg = $close
			_close()
			_GetWindows()
			
		Case $msg = $Session
			$file_open=GUICtrlRead ($Session)
			If $file_open ='�������' Then
			_GetWindows()
			Else
			$file = FileOpen($file_open, 0)
			If $file = -1 Then
 			   MsgBox(0, "������", "���������� ������� ����.")
 			   ContinueLoop
			EndIf
			$sTmp = FileRead($file)
			FileClose($file)
			GUICtrlSetData($Session, $file_open) 
			If $sTmp <> '' Then
			GUICtrlSendMsg($Folderlist, 0x14B, 0, 0)
			GUICtrlSetData($Folderlist, $sTmp)
			EndIf
			EndIf
			
		Case $msg = $Folderlist
			;If GUICtrlRead ($auto)=1 Then
				$myFolder = GUICtrlRead($Folderlist)
				If FileExists($myFolder) Then
					Run('Explorer.exe "'&$myFolder&'"')
					;ShellExecute($myFolder, "", $myFolder) ; ���������� �������� ��������
				EndIf
			;EndIf
		Case $msg = -3
			Exit
	EndSelect
WEnd

; 1 ������� ������ ������� ��������� � ���������� �� � ���������
Func _GetWindows() ; ������� ���������������, ������ �� ��������, ������ ������ ������ ���������.
	GUICtrlSendMsg($Folderlist, 0x14B, 0, 0) ; ������� ���������
	$AllWindows = WinList() ; ������� ���� ������ ����, ������ � ���������� � ���������������
	$sTmp = ""
	For $i = 1 To $AllWindows[0][0]
		; ������� ���� ��������� ����������� � ������ ������ ��� ����������
		If _IsVisible($AllWindows[$i][1]) and $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 12)='explorer.exe' Then
			If $sTmp = "" Then
				$sTmp &= ControlGetText ( $AllWindows[$i][0], '', "[CLASS:Edit; INSTANCE:1]") ; ������ ������ �����
			Else
				$sTmp &= "|"&ControlGetText ( $AllWindows[$i][0], '', "[CLASS:Edit; INSTANCE:1]")
			EndIf
		EndIf
	Next
	If $sTmp <> "" Then
		GUICtrlSetData($Folderlist, $sTmp) ; ������������� ������ � ���������
	Else
		GUICtrlSetData($Folderlist, "<��� ���������>")
	EndIf
EndFunc

; 2 ������� �������� ����, ����������� _GetWindows(), �� � WinClose
Func _close()
	$AllWindows = WinList()
	$sTmp = ""
	For $i = 1 To $AllWindows[0][0]
		If _IsVisible($AllWindows[$i][1]) And $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 12)='explorer.exe' Then
				WinClose($AllWindows[$i][0])
		EndIf
	Next
EndFunc

; 3 ������� ������������� ��������, ���������� ���������� ��������
Func _IsVisible($handle) ; �������� �������� ���� � �������� �� ������ �����
	If BitAND(WinGetState($handle), 4) and BitAND(WinGetState($handle), 2) Then ; ������� ��������� ��������� ���������� ����. | ��������� ��������� ���������� ��������� AND. ������ ��������� ����� 4, ������ ������� ����������, ������ ��������� ����� ���� 0, ���� 2. ���� 0, �� else Return 0, ���� 2, �� Return 1
			Return 1
		Else
			Return 0 ; ��� ������ ������� ������������
	EndIf
EndFunc

; 4 ����� ������
Func _search()
$sestmp='�������'
$search = FileFindFirstFile(@ScriptDir & "\*.inc")
If $search <> -1 Then
While 1
    $file = FileFindNextFile($search) 
    If @error Then ExitLoop
	$sestmp&='|'&@ScriptDir & "\"&$file
WEnd
EndIf
FileClose($search)
GUICtrlSetData($Session, $sestmp, '�������')
EndFunc

; 5 ���� PID �������� ���� � ����� ���������� �������
Func _ProcessGetPath($PID)
    If IsString($PID) Then $PID = ProcessExists($PID)
    $Path = DllStructCreate('char[1000]')
    $dll = DllOpen('Kernel32.dll')
    $handle1 = DllCall($dll, 'int', 'OpenProcess', 'dword', 0x0400 + 0x0010, 'int', 0, 'dword', $PID)
    $ret = DllCall('Psapi.dll', 'long', 'GetModuleFileNameEx', 'long', $handle1[0], 'int', 0, 'ptr', DllStructGetPtr($Path), 'long', DllStructGetSize($Path))
    $ret = DllCall($dll, 'int', 'CloseHandle', 'hwnd', $handle1[0])
    DllClose($dll)
    Return DllStructGetData($Path, 1)
EndFunc