#NoTrayIcon

If Not $CmdLine[0] Or Not FileExists($CmdLine[1]) Then Exit ; ���� �������� �� ��������� ��� �� ���������� �� �����
$aPath = StringRegExp($CmdLine[1], "^(.*)\\(.*)$", 3)
$namewim = StringTrimRight($aPath[1], 4)

Global $folder0, $boot0, $metka0, $rw0, $sPath_imagex = @SystemDir & '\imagex.exe' ; , $tom0

$close = RegRead("HKLM\SOFTWARE\script_az\contmenu_WIM", "close")
If @error Then
	RegWrite("HKLM\SOFTWARE\script_az\contmenu_WIM", "close", "REG_DWORD", 0)
	$close = 0
EndIf

; ����������� ����� WIM-�����
$wimlist = _Get_WimLabel($CmdLine[1])
If @error Then Exit MsgBox(0, "������", '�� ������� ����� wim-�����.' & @LF & '��� ����� ������� wim-���� ����������.')

$hGui = GUICreate($aPath[1], 310, 167) ; ������ ����
_setico('.wim')

$checkclose = GUICtrlCreateCheckbox("��������� ������ ��� ����� �� ������", 10, 10, 290, 24)
If $close Then GUICtrlSetState(-1, 1)

$extract = GUICtrlCreateButton("�������", 10, 40, 90, 24)
GUICtrlSetTip(-1, "�������")
$pack = GUICtrlCreateButton("���������", 110, 40, 90, 24)
GUICtrlSetTip(-1, "����� ���������� ��������.")
GUICtrlSetState($pack, 128)
$append = GUICtrlCreateButton("��������", 210, 40, 90, 24)
GUICtrlSetTip(-1, "�������� ����� ��� � wim" & @LF & "����������� �������� �����" & @LF & "������������ ����")

$mount = GUICtrlCreateButton("������", 10, 70, 70, 24)
GUICtrlSetTip(-1, "����������� " & $aPath[1])
$rw = GUICtrlCreateCheckbox("RW", 90, 70, 40, 24)
GUICtrlSetState(-1, 1) ; ���������������� ��� ������, ���� �� ����� ���������� ������� RW
GUICtrlSetTip($rw, "RW - � ���������� ���������" & @LF & "������ � �������� ������������")
$create = GUICtrlCreateButton("���������", 140, 70, 75, 24)
GUICtrlSetState($create, 128)
$unmount = GUICtrlCreateButton("��������", 225, 70, 75, 24)
GUICtrlSetState($unmount, 128)

$folder = GUICtrlCreateCombo("", 10, 100, 70, -1, 0x3) ; CBS_DROPDOWNLIST = 0x3
GUICtrlSetFont(-1, Default, 400, 0, 'Lucida Console') ; ������������ ����� ����������� ����� � �������
GUICtrlSendMsg(-1, 0x160, 340, 0) ; $CB_SETDROPPEDWIDTH = 0x160
GUICtrlSetData(-1, '�����|temp' & _ListDrive(), '�����')
GUICtrlSetTip(-1, "���� ���������?" & @CRLF & "����� wim_%name_wim%")


;$tom=GUICtrlCreateCombo ("", 100,100,40,24)
;GUICtrlSetData(-1,'1|2|3|4|5|6', '1')
;GUICtrlSetTip($tom, "����� ����,"&@CRLF&"��������� ��� ��������")
$Def_Metka = StringLeft($wimlist, StringInStr($wimlist&'|', '|')-1)
$metka = GUICtrlCreateCombo("", 90, 100, 150, 24)
GUICtrlSetData(-1, $wimlist, $Def_Metka)
GUICtrlSetTip($metka, "����� ����." & @LF & "������ � ������ ������������")
$boot = GUICtrlCreateCheckbox("boot", 250, 100, 50, 24)
GUICtrlSetTip(-1, "��� ����������� wim-������" & @LF & "WinPe.wim, BootSdi.wim")

$StatusBar = GUICtrlCreateLabel('������ ���������', 5, 150, 234, -1)
$LabelMb = GUICtrlCreateLabel('', 240, 148, 80, 20)
GUICtrlSetFont(-1, 14)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $extract
			GUICtrlSetState($mount, 128)
			GUICtrlSetState($rw, 128)
			GUICtrlSetData($StatusBar, '���������� ' & $aPath[1])
			_read()
			If Not FileExists($folder0 & '\wim_' & $namewim) Then DirCreate($folder0 & '\wim_' & $namewim)
			ShellExecuteWait($sPath_imagex, '/apply "' & $CmdLine[1] & '" "' & $metka0 & '" "' & $folder0 & '\wim_' & $namewim & '"', '', '', @SW_HIDE)
			GUICtrlSetData($StatusBar, '���������� ���������.')
			GUICtrlSetState($pack, 64)
			Run('Explorer.exe /select,' & $folder0 & '\wim_' & $namewim)
			If GUICtrlRead($checkclose) = 1 Then Exit
			
		Case $pack
			GUICtrlSetState($extract, 128)
			_read()
			GUICtrlSetData($StatusBar, '������������� � ' & $aPath[1] & '_New.wim.')
			
			
			_RunProcess($sPath_imagex & ' /capture' & $boot0 & '"' & $folder0 & '\wim_' & $namewim & '" "' & $folder0 & '\' & $namewim & '_New.wim" "' & $metka0 & '" /compress maximum', $folder0 & '\' & $namewim & '_New.wim')
			
			DirRemove($folder0 & '\wim_' & $namewim, 1)
			DllCall("shell32.dll", "none", "SHChangeNotify", "long", '0x8000000', "uint", '0x1000', "ptr", '0', "ptr", '0')
			Run('Explorer.exe /select,"' & $folder0 & '\' & $namewim & '_New.wim"')
			GUICtrlSetState($extract, 64)
			GUICtrlSetState($mount, 64)
			GUICtrlSetState($pack, 128)
			GUICtrlSetState($rw, 64)
			If GUICtrlRead($checkclose) = 1 Then Exit

			
		Case $append
			GUICtrlSetState($extract, 128)
			GUICtrlSetState($mount, 128)
			GUICtrlSetState($rw, 128)
			_read()
			If StringInStr($wimlist, $metka0) <> 0 Then
				MsgBox(0, "������", '������ �������� � wim-� ���' & @LF & '� ������, ��� ��������� � wim-�' & @LF & '�������� ����� "' & $metka0 & '"', 0, $hGui)
				_enb()
				ContinueLoop
			EndIf
			$folderwim = FileSelectFolder("������� ����������� �����", '', '3', @WorkingDir)
			If @error Then
				_enb()
				ContinueLoop
			EndIf
			$msgapp = 
			
			If MsgBox(4, "���������", '�������� � ���������?' & @LF & @LF & '"��" - � ' & $aPath[1] & @LF & '"���" - � ' & $namewim & '_New.wim', 0, $hGui) = 6 Then
				$appname = $aPath[1] ; ��
			Else
				$appname = $namewim & '_New.wim' ; ���
			EndIf
			GUICtrlSetData($StatusBar, '��������� �  ' & $appname)
			_RunProcess($sPath_imagex & ' /append' & $boot0 & '"' & $folderwim & '" "' & $folder0 & '\' & $appname & '" "' & $metka0 & '"', $folder0 & '\' & $appname)
			Run('Explorer.exe /select,"' & $folder0 & '\' & $appname & '"')
			_enb()
			If GUICtrlRead($checkclose) = 1 Then Exit

			
		Case $mount
			GUICtrlSetState($extract, 128)
			_read()
			If Not FileExists($folder0 & '\wim_' & $namewim) Then DirCreate($folder0 & '\wim_' & $namewim)
			ShellExecuteWait($sPath_imagex, $rw0 & ' "' & $CmdLine[1] & '" "' & $metka0 & '" "' & $folder0 & '\wim_' & $namewim & '"', '', '', @SW_HIDE)
			GUICtrlSetData($StatusBar, '������������ ���������.')
			GUICtrlSetState($create, 64)
			GUICtrlSetState($unmount, 64)
			Run('Explorer.exe /select,' & $folder0 & '\wim_' & $namewim)
			If GUICtrlRead($checkclose) = 1 Then Exit
			
		Case $unmount
			GUICtrlSetState($create, 128)
			GUICtrlSetState($mount, 128)
			ShellExecuteWait($sPath_imagex, '/unmount "' & $folder0 & '\wim_' & $namewim & '"', '', '', @SW_HIDE)
			DirRemove($folder0 & '\wim_' & $namewim, 1)
			GUICtrlSetState($mount, 64)
			GUICtrlSetState($extract, 64)
			GUICtrlSetState($unmount, 128)
			If GUICtrlRead($checkclose) = 1 Then Exit
			
		Case $create
			GUICtrlSetState($unmount, 128)
			GUICtrlSetState($mount, 128)
			_read()
			GUICtrlSetData($StatusBar, '������������� � ' & $aPath[1] & '_New.wim.')
			
			_RunProcess($sPath_imagex & ' /capture' & $boot0 & '"' & $folder0 & '\wim_' & $namewim & '" "' & $folder0 & '\' & $namewim & '_New.wim" "' & $metka0 & '" /compress maximum', $folder0 & '\' & $namewim & '_New.wim')
			DirRemove($folder0 & '\wim_' & $namewim, 1)
			Run('Explorer.exe /select,"' & $folder0 & '\' & $namewim & '_New.wim"')
			GUICtrlSetState($unmount, 64)
			DllCall("shell32.dll", "none", "SHChangeNotify", "long", '0x8000000', "uint", '0x1000', "ptr", '0', "ptr", '0')
			If GUICtrlRead($checkclose) = 1 Then Exit
			
		Case $checkclose
			If GUICtrlRead($checkclose) = 1 Then
				RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\contmenu_WIM", "close", "REG_DWORD", 1)
			Else
				RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\contmenu_WIM", "close", "REG_DWORD", 0)
			EndIf
		Case -3
			ExitLoop
	EndSwitch
WEnd

Func _RunProcess($sComand, $sPath)
	; �������� wim � ��������-�����
	$ProgressBar = GUICtrlCreateProgress(50, 127, 200, 14, 0x8) ; $PBS_MARQUEE
	GUICtrlSetColor(-1, 32250); ���� ��� ������������ ����
	$iPos = 0
	$tmp = 0
	$iPID = Run($sComand, '', @SW_HIDE)
	While ProcessExists($iPID)
		$sizewim = FileGetSize($sPath)
		If Not @error Then $sizewim = Ceiling($sizewim / 1048576)
		If $tmp <> $sizewim Then
			GUICtrlSetData($LabelMb, $sizewim & ' ��')
			$tmp = $sizewim
		EndIf
		$iPos += 1
		GUICtrlSetData($ProgressBar, $iPos)
		Sleep(60)
		If $iPos > 100 Then $iPos = 0
	WEnd
	$sizewim = FileGetSize($sPath)
	If Not @error Then $sizewim = Ceiling($sizewim / 1048576)
	If $tmp <> $sizewim Then GUICtrlSetData($LabelMb, $sizewim & ' ��')
	GUICtrlSetColor($LabelMb, 0xEE0000) ; Red
	GUICtrlDelete($ProgressBar)
	; �����: �������� wim � ��������-�����
	GUICtrlSetData($StatusBar, '������ !!! ������: ' & $sizewim & ' ��.')
EndFunc

Func _read()
	;$tom0=GUICtrlRead ($tom)
	$metka0 = GUICtrlRead($metka)
	If $metka0 = '' Then $metka0 = $Def_Metka
	If GUICtrlRead($boot) = 1 Then
		$boot0 = ' /boot '
	Else
		$boot0 = ' '
	EndIf
	If GUICtrlRead($rw) = 1 Then
		$rw0 = '/mountrw'
	Else
		$rw0 = '/mount'
	EndIf

	$folder0 = GUICtrlRead($folder)
	Switch StringMid($folder0, 2, 2)
		Case "��" ; �����
			$folder0 = $aPath[0]
		Case "em" ; temp
			$folder0 = @TempDir
		Case ": "
			$folder0 = StringLeft($folder0, 2)
		Case Else
			$folder0 = @TempDir
	EndSwitch
EndFunc   ;==>_read

Func _enb()
	GUICtrlSetState($extract, 64)
	GUICtrlSetState($mount, 64)
	GUICtrlSetState($rw, 64)
EndFunc   ;==>_enb

Func _ListDrive()
	Local $aDrives = DriveGetDrive('all'), $Type, $i, $list = '', $sString
	For $i = 1 To $aDrives[0]
		$Type = DriveGetType($aDrives[$i] & '\')

		If $aDrives[$i] = 'A:' Or  $Type = 'CDROM' Then ContinueLoop
		If $Type = 'Removable' Then $Type = 'Rem'
		$sLabel = DriveGetLabel($aDrives[$i] & '\')
		If StringLen($sLabel)>15 Then $sLabel = StringLeft($sLabel, 12) & '...'

		$sString = StringFormat("%-2s %-5s %-15s %-5s %9.03f Gb", StringUpper($aDrives[$i]), $Type, $sLabel, DriveGetFileSystem($aDrives[$i] & '\'), DriveSpaceTotal($aDrives[$i] & '\') / 1024)
		$list &= '|' & $sString
	Next
	Return $list
EndFunc

Func _Get_WimLabel($sPath)
	Local $s_WIM_List = ''
	$iPID = Run('imagex.exe /info /xml "' & $sPath & '"', @SystemDir, @SW_HIDE, 2)
	While 1
		$s_WIM_List &= StdoutRead($iPID, False, True)
		If @error Then ExitLoop
	WEnd
	$aLabel = StringRegExp(BinaryToString($s_WIM_List, 2), "(?m)(?<=<NAME>)(.*?)(?=</NAME>)", 3)
	If @error Then
		Return SetError(1, 0, '')
	Else
		$s_WIM_List = ''
		For $i = 0 To UBound($aLabel) - 1
			$s_WIM_List &= $aLabel[$i] & '|'
		Next
		Return SetError(0, 0, StringTrimRight($s_WIM_List, 1))
	EndIf
EndFunc   ;==>_Get_WimLabel

Func _setico($sICO)
	$sICO=_FileDefaultIcon($sICO)
	If @error Then Return
	$sICO = StringReplace($sICO, '"', '')
	Opt('ExpandEnvStrings', 1)
	$sICO=StringRegExp($sICO, '^(.*?)(?:,(\d+))?$', 3)
	If @error Then
		Return
	Else
		Switch UBound($sICO)
			Case 1
				GUISetIcon($sICO[0])
			Case 2
				GUISetIcon($sICO[0], - ($sICO[1] + 1))
		EndSwitch
	EndIf
	Opt('ExpandEnvStrings')
EndFunc

Func _FileDefaultIcon($sExt)

    Local $aCall = DllCall("shlwapi.dll", "int", "AssocQueryStringW", _
            "dword", 0x00000040, _ ;$ASSOCF_VERIFY
            "dword", 15, _ ;$ASSOCSTR_DEFAULTICON 
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

EndFunc  ;==>_FileAssociation