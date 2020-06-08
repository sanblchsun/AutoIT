;  @AZJIO 25.03.2010
; ��������� ��������� �����, ��� ������ ��������� ��� ������ � ������� �������� ����� ������� � ����� ������������� ����� ����. �������� ������ ��� �������������� ����� ������� ��� LiveCD, ����� ����� ������� ������ ���������, ������ ������� ����������.
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=SaveFolders.exe
#AutoIt3Wrapper_icon=SaveFolders.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=SaveFolders.exe
#AutoIt3Wrapper_Res_Fileversion=0.4.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#NoTrayIcon
Global $sTmp, $amountS, $amountF=0, $add=0, $sestmp

$form=GUICreate("SaveFolders v0.4",500, 456)

GUICtrlCreateLabel("������", 35, 57, 41, 18)
$Session = GUICtrlCreateList ("", 15, 75, 470, 185) ; $CBS_DROPDOWNLIST=0x3 - ����� ���������������� ����������.

$Folderlist = GUICtrlCreateList ("", 485, 75, 470, 225)

$OpenF = GUICtrlCreateButton("�����", 132, 55, 73, 20)
GUICtrlSetTip(-1, "������� ����� ����� ������")

$Open = GUICtrlCreateButton("��������", 212, 55, 73, 20)
GUICtrlSetTip(-1, "�������� ������")

$Upd_list = GUICtrlCreateButton("��������", 332, 55, 73, 20)
GUICtrlSetTip(-1, "�������� ������")

$Save = GUICtrlCreateButton("���������", 412, 55, 73, 20)
GUICtrlSetTip(-1, "��������� ����� � ������")

$close = GUICtrlCreateButton("������� ��� �����", 80, 10, 130, 30)
GUICtrlSetTip(-1, "�� �������� ������")

$Openfolder = GUICtrlCreateButton("������� ��� �����", 290, 10, 130, 30)
GUICtrlSetTip(-1, "�� �������� ������")

;$auto = GUICtrlCreateCheckbox("���� ��������", 340, 134, 97, 18)
;GUICtrlSetState($auto, 1)

_search() ; ������� ������ ������
_GetWindows() ; ������ ������� ���������

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
			GUICtrlSetPos ($form, 970, 562)
			
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
			_GetWindows()
			FileWrite($file, $sTmp)
			FileClose($file)
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
			FileClose($file)
			If StringInStr($sestmp, $file_open)=0 Then $add+=1
			$sestmp&='|'&$file_open
			GUICtrlSetPos ($Session, 15,75, 470, $amountS*16+$add*16+5)
			GUICtrlSetData($Session, $file_open)
			GUICtrlDelete($Folderlist)
			$aPath = StringSplit($sTmp, "|")
			$Folderlist = GUICtrlCreateList ("", 15, $amountS*16+80+$add*16, 470, $aPath[0]*16+5)
			GUICtrlSetData($Folderlist, $sTmp)
			
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
			GUICtrlDelete($Folderlist)
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
			$aPath = StringSplit($sTmp, "|")
			
			If $amountS+$aPath[0]+$add > 23 Then
				$aPath[0]=23-$amountS-$add
			EndIf
			
			$Folderlist = GUICtrlCreateList ("", 15, $amountS*16+80+$add*16, 470, $aPath[0]*16+5)
			If $sTmp <> '' Then
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
	GUICtrlDelete($Folderlist)
	$AllWindows = WinList() ; ������� ���� ������ ����, ������ � ���������� � ���������������
	$sTmp = ""
	$amountF=0
	For $i = 1 To $AllWindows[0][0]
		; ������� ���� ��������� ����������� � ������ ������ ��� ����������
		If _IsVisible($AllWindows[$i][1]) and $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 12)='explorer.exe' Then
			$amountF+=1
			If $sTmp = "" Then
				$sTmp &= ControlGetText ( $AllWindows[$i][0], '', "[CLASS:Edit; INSTANCE:1]") ; ������ ������ �����
			Else
				$sTmp &= "|"&ControlGetText ( $AllWindows[$i][0], '', "[CLASS:Edit; INSTANCE:1]")
			EndIf
		EndIf
	Next
	If $amountS+$amountF+$add > 23 Then
		$amountF=23-$amountS-$add
	EndIf
	$Folderlist = GUICtrlCreateList ("",15, $amountS*16+80+$add*16, 470, $amountF*16+5)
	If $sTmp <> "" Then
		GUICtrlSetData($Folderlist, $sTmp) ; ������������� ������ � ���������
	Else
		GUICtrlDelete($Folderlist)
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
$amountS=1
GUICtrlDelete($Session)
$sestmp='�������'
$search = FileFindFirstFile(@ScriptDir & "\*.inc")
If $search <> -1 Then
While 1
    $file = FileFindNextFile($search) 
    If @error Then ExitLoop
	$sestmp&='|'&@ScriptDir & "\"&$file
	$amountS+=1
WEnd
EndIf
$Session = GUICtrlCreateList ("", 15, 75, 470, $amountS*16+5)
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