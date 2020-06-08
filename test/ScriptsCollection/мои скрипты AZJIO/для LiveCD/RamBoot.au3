#AutoIt3Wrapper_OutFile=RamBoot.exe
#AutoIt3Wrapper_icon=RamBoot.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=RamBoot.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=Author
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.2
#AutoIt3Wrapper_Res_Field=Build|2011.07.18
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

#NoTrayIcon

If Not(FileExists('vdk.exe') And FileExists('vdk.sys') And FileExists('zCopy.exe') And FileExists('ramdisk.sys')) Then
	MsgBox(0, '���������', '�������� � ����� ��������� ������� ������:'&@CRLF&'vdk.exe'&@CRLF&'vdk.sys'&@CRLF&'zCopy.exe'&@CRLF&'ramdisk.sys')
	Exit
EndIf


Global $Ini = @ScriptDir & '\RamBoot.ini' ; ���� � RamBoot.ini
Global Const $GMKConst=(1024 /1000 - 1)/1024
If Not FileExists($Ini) And MsgBox(4, "�������� �����������", "������ ������� ����������� RamBoot.ini ��� ���������� �������� ����������?") = 6 Then
	$file = FileOpen($Ini, 2)
	FileWrite($file, _
			'[general]' & @CRLF & _
			'nameimg=Boot.img' & @CRLF & _
			'PathBartPE=D:\pebuilder_xpe\BartPE' & @CRLF & _
			'disk_z=Z:' & @CRLF & _
			'cab=' & @CRLF & _
			'FS=NTFS' & @CRLF & _
			'Path2=C:\Boot' & @CRLF & _
			'size=222|230|362|480')
EndIf

;��������� RamBoot.ini
$nameimg = IniRead($Ini, "general", "nameimg", "Boot.img")
$PathBartPE = IniRead($Ini, "general", "PathBartPE", "C:\pebuilder_xpe\BartPE")
$disk_z = IniRead($Ini, "general", "disk_z", "Z:")
$cab = IniRead($Ini, "general", "cab", "-1")
$fs = IniRead($Ini, "general", "FS", "NTFS")
$Path2 = IniRead($Ini, "general", "Path2", "C:\Boot")
$SizeIni = IniRead($Ini, "general", "size", "222|230|362|480")
$aSize = StringSplit($SizeIni, '|')


$Gui=GUICreate("�������� Boot.img", 460, 150, -1, -1, -1, $WS_EX_ACCEPTFILES)
$StatusBar = GUICtrlCreateLabel('������ ���������			����������� drag-and-drop', 5, 133, 450, 17)
$MsgB = GUICtrlCreateButton('?', 460 - 20, 2, 18, 18)

GUICtrlCreateLabel('������� ��� img-�����', 10, 10, 200, 20)
GUICtrlSetTip(-1, "��� ��������� �� ���� ����� ������� ���" & @CRLF & "� ��������� ��� *.img � ����� Boot")
$File_combo = GUICtrlCreateCombo("", 160, 7, 105, 18)
$tmp = ''
For $i = 1 To $aSize[0]
	$tmp &= '|Boot' & $aSize[$i] & '.img'
Next
GUICtrlSetData(-1, $nameimg & '|Boot.img|BootSdi.img' & $tmp, $nameimg)

$check00 = GUICtrlCreateCheckbox("���������� (CAB)", 280, 8)
GUICtrlSetState($cab, $GUI_CHECKED)
GUICtrlSetTip($check00, "������� ����� � cab-�����." & @CRLF & "�� ������������ ������� ��������� ��� ��������.")

GUICtrlCreateLabel('������� ������ img-�����, ��', 10, 40, 180, 20)
GUICtrlSetTip(-1, "� �������� 40-480")
$Size_combo = GUICtrlCreateCombo("", 200, 37, 65, 18)
GUICtrlSetData(-1, $SizeIni, $aSize[1])

$SizeFreeDrive = DriveSpaceFree(@ScriptDir)
$tmp=$SizeFreeDrive*1048576
_GMK($tmp)
GUICtrlCreateLabel('�������� �� �����: ' & $tmp, 280, 40, 200, 20)

$input01 = GUICtrlCreateInput($PathBartPE, 10, 70, 410, 23)
GUICtrlSetState(-1, 8)
GUICtrlSetTip($input01, "� ��� ���� ����� ���������" & @CRLF & "����� BartPE (drag-and-drop).")
$OpenFld = GUICtrlCreateButton("...", 420, 70, 26, 23)
GUICtrlSetTip(-1, "������� ����� BartPE")
GUICtrlSetFont(-1, 16)


GUICtrlCreateLabel('FS:', 20, 103, 20, 20)
$combofs = GUICtrlCreateCombo("", 45, 100, 65, 18, 0x3)
GUICtrlSetData(-1, 'NTFS|FAT32', $fs)

$checktest = GUICtrlCreateButton("��������", 240, 100, 87, 24)
GUICtrlSetTip(-1, "�������� ������������" & @CRLF & "�������� ����������.")

$vdkdisk = GUICtrlCreateButton("������ R", 130, 100, 87, 24)

If FileExists('Y:\') Then
	GUICtrlSetData(-1, "��������")
	GUICtrlSetTip(-1, "������������� ���� Y.")
Else
	GUICtrlSetData(-1, "������ R")
	GUICtrlSetTip(-1, "����������� �����" & @CRLF & "� �������� ""������ ������"".")
EndIf

$start = GUICtrlCreateButton("�����", 350, 100, 87, 24)
GUICtrlSetTip(-1, "������� Boot.img.")
GUICtrlSetState(-1, $GUI_FOCUS)

GUISetState()

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $MsgB
			MsgBox(0, '�������', '����� ��� ��������� ����������� � ini-����.' & @CRLF & '���� ������� ���� � ini-�����, �������� Path2=C:\Boot, �� �����' & @CRLF & '�������� img-����� ������� ������ ����������� � ��������� �����.' & @CRLF & '��� �������� ������������ � ������ ���������.' & @CRLF & '����� ������������ ����� �����, ����������� ����������, ������ ���������' & @CRLF & '� �������� ���������.' & @CRLF & @CRLF & '		��������� AZJIO 2011.07.18')
		Case $vdkdisk
			If FileExists('Y:\') Then
				; �������������� ����� Z � ��������� ����. �������
				RunWait(@ComSpec & ' /C vdk.exe close 0 | find /v "http:" | find /v "version"', '', @SW_HIDE)
				RunWait(@ComSpec & ' /C vdk.exe stop | find /v "http:" | find /v "version"', '', @SW_HIDE)
				RunWait(@ComSpec & ' /C vdk.exe remove | find /v "http:" | find /v "version"', '', @SW_HIDE)
				If Not FileExists('Y:\') Then GUICtrlSetData($StatusBar, "���� ������������, ��������� �������. ������ �����")
			Else
				$IMG_NameFile0 = GUICtrlRead($File_combo)
				If Not FileExists(@ScriptDir & '\' & $IMG_NameFile0) Then
					MsgBox(0, "������ ������", '� ��� ���� ' & $IMG_NameFile0 & ' � ������� �����? ��� ������� ��� �����.')
					ContinueLoop
				EndIf
				; ��������� � ������ ������������ �������
				RunWait(@ComSpec & ' /C vdk.exe install | find /v "http:" | find /v "version"', '', @SW_HIDE)
				RunWait(@ComSpec & ' /C vdk.exe start | find /v "http:" | find /v "version"', '', @SW_HIDE)
				GUICtrlSetData($StatusBar, "����������� ������ ����������")
				; ������������ ����� Boot.img ��� ���� Y
				RunWait(@ComSpec & ' /C vdk.exe open 0 ' & @ScriptDir & '\' & $IMG_NameFile0 & ' /p:0 /l:Y: | find /v "http:" | find /v "version" | find /v "Failed"', '', @SW_HIDE)
				If FileExists('Y:\') Then GUICtrlSetData($StatusBar, '���� ' & $IMG_NameFile0 & ' ����������� � �������� "������ ������"')
			EndIf
			If FileExists('Y:\') Then
				GUICtrlSetData($vdkdisk, "��������")
				GUICtrlSetTip($vdkdisk, "������������� ���� Y.")
				Run('Explorer.exe Y:\')
			Else
				GUICtrlSetData($vdkdisk, "������ R")
				GUICtrlSetTip($vdkdisk, "����������� �����" & @CRLF & "� �������� ""������ ������"".")
			EndIf
			IniWrite($Ini, "general", "nameimg", $IMG_NameFile0)
		Case $checktest
			$size01 = GUICtrlRead($Size_combo)
			$PathBartPE00 = GUICtrlRead($input01)
			$IMG_NameFile0 = GUICtrlRead($File_combo)
			$check = 1
			If $IMG_NameFile0 = "" Or $PathBartPE00 = "" Or $size01 > 480 Or $size01 <= 40 Or $SizeFreeDrive < $size01 Or FileExists($IMG_NameFile0) Or Not FileExists($PathBartPE00) Then
				$check99 = "---------------�����---------------"
				GUICtrlSetData($StatusBar, "��������� ��������: ������� �� ���������!!!!!!!!!!!!")
			Else
				$check99 = "+++++++++++++������+++++++++++++"
				GUICtrlSetData($StatusBar, "��������� ��������: ������� ���������")
			EndIf
			$SizeFree = "� �����"
			If $SizeFreeDrive < $size01 Then $SizeFree = "������������!!!"
			If $IMG_NameFile0 = "" Then $IMG_NameFile0 = "������� ��� �����!!!"
			If $PathBartPE00 = "" Or Not FileExists($PathBartPE00) Then $PathBartPE00 = "������� ����!!!"
			If $size01 > 480 Then
				$size01 = "������ Boot.img ���������!!!"
			ElseIf $size01 <= 40 Then
				$size01 = "������ Boot.img ������� ���!!!"
			EndIf
			$CheckExp = "-----------"
			If FileExists($IMG_NameFile0) Then $CheckExp = "������� img-���� � ������� �����!!!"
			MsgBox(0, "��������� ��������", '��� �����=' & $IMG_NameFile0 & @CRLF & '���� � ����� BartPE=' & $PathBartPE00 & @CRLF & '������ Boot.img, ��=' & $size01 & @CRLF & '�������� �������=' & GUICtrlRead($combofs) & @CRLF & $CheckExp & @CRLF & '��������� ����� �� �����=' & $SizeFree & @CRLF & @CRLF & '����: ' & $check99)
		Case $start
			$fs00 = GUICtrlRead($combofs)
			$size01 = GUICtrlRead($Size_combo)
			$PathBartPE00 = GUICtrlRead($input01)
			$IMG_NameFile0 = GUICtrlRead($File_combo)
			If FileExists($IMG_NameFile0) Then
				MsgBox(0, "������ ������", '������� ���� ' & $IMG_NameFile0 & ' ����� ������������.')
				ContinueLoop
			EndIf
			If $PathBartPE00 = '' Or Not FileExists($PathBartPE00) Then
				MsgBox(0, "������ ������", '������� ���� � BartPE ����� ������������.')
				ContinueLoop
			EndIf
			If $size01 > 480 Then
				MsgBox(0, "������ ������", '������ img-����� ���������.')
				ContinueLoop
			EndIf
			If $size01 <= 40 Then
				MsgBox(0, "������ ������", '������ img-����� ������� ���.')
				ContinueLoop
			EndIf
			If $SizeFreeDrive < $size01 Then
				MsgBox(0, "������ ������", '������������ ���������� ����� �� �����.')
				ContinueLoop
			EndIf
			If $IMG_NameFile0 = "" Then
				MsgBox(0, "������ ������", '������� ��� �����.')
				ContinueLoop
			EndIf
			; �������� ������� ����� ���������� �������
			RunWait(@ComSpec & ' /C Fsutil file createnew ' & @ScriptDir & '\' & $IMG_NameFile0 & ' ' & $size01*1048576, '', @SW_HIDE)
			GUICtrlSetData($StatusBar, '���� 1. ���� ' & $IMG_NameFile0 & ' ������')
			; ��������� � ������ ������������ �������
			RunWait(@ComSpec & ' /C vdk.exe install | find /v "http:" | find /v "version"', '', @SW_HIDE)
			RunWait(@ComSpec & ' /C vdk.exe start | find /v "http:" | find /v "version"', '', @SW_HIDE)
			GUICtrlSetData($StatusBar, "���� 2. ����������� ������ ����������")
			; ������������ ������� ����� Boot.img ��� ���� Z
			RunWait(@ComSpec & ' /C vdk.exe open 0 ' & @ScriptDir & '\' & $IMG_NameFile0 & ' /rw /p:0 /l:' & $disk_z & ' | find /v "http:" | find /v "version" | find /v "Failed"', '', @SW_HIDE)
			GUICtrlSetData($StatusBar, '���� 3. ���� ' & $IMG_NameFile0 & ' �����������')
			; �������������� ������������ ����� Z
			RunWait(@ComSpec & ' /C format.com ' & $disk_z & ' /FS:' & $fs00 & ' /v:System /c /X /force', '', @SW_HIDE)
			GUICtrlSetData($StatusBar, '���� 4. ����������� ���� ' & $disk_z & ' ��������������')
			; ����������� ������ �� ���� Z
			RunWait(@ComSpec & ' /C zCopy.exe "' & $PathBartPE00 & '" ' & $disk_z & '  "size.ini" size size', '', @SW_HIDE)
			RunWait(@ComSpec & ' /C Copy /y "ramdisk.sys" ' & $disk_z & '\I386\System32\drivers\', '', @SW_HIDE)
			GUICtrlSetData($StatusBar, '���� 5. ����� �� ���� ' & $disk_z & ' �����������')
			; �������������� ����� Z � ��������� ����. �������
			RunWait(@ComSpec & ' /C vdk.exe close 0 | find /v "http:" | find /v "version"', '', @SW_HIDE)
			RunWait(@ComSpec & ' /C vdk.exe stop | find /v "http:" | find /v "version"', '', @SW_HIDE)
			RunWait(@ComSpec & ' /C vdk.exe remove | find /v "http:" | find /v "version"', '', @SW_HIDE)
			GUICtrlSetData($StatusBar, "���� 6. ���� ������������, ��������� �������. ������ �����")
			; ���������� � cab-����
			If GUICtrlRead($check00) = 1 Then
				GUICtrlSetData($StatusBar, "���� 6. ������ ����� � CAB-�����")
				RunWait(@ComSpec & ' /C makecab.exe /D Compress=ON  /D CompressionMemory=21 /D CompressionType=LZX /D CompressionLevel=7 ' & $IMG_NameFile0, '', @SW_HIDE)
			EndIf
			If Not StringInStr('|'&$SizeIni&'|', '|'&$size01&'|') Then $SizeIni=$size01&'|'&$SizeIni
			IniWrite($Ini, "general", "size", $SizeIni )
			IniWrite($Ini, "general", "nameimg", $IMG_NameFile0)
			IniWrite($Ini, "general", "PathBartPE", $PathBartPE00)
			IniWrite($Ini, "general", "FS", $fs00)
			GUICtrlSetData($StatusBar, "���� 7. ��������� ���������. ������.")
			If FileExists($Path2 & '\' & $IMG_NameFile0) Then
				$textBox = '�������� ���� ' & $IMG_NameFile0 & ' � ����� ' & $Path2 & '?'
				$nameBox = "������"
			Else
				$textBox = '���������� ���� ' & $IMG_NameFile0 & ' � ����� ' & $Path2 & '?'
				$nameBox = "�����������"
			EndIf
			If $Path2 <> "" And MsgBox(4, $nameBox, $textBox)=6 Then FileCopy(@ScriptDir & '\' & $IMG_NameFile0, $Path2 & '\', 1)
		Case $check00
			If GUICtrlRead($check00) = 1 Then
				IniWrite($Ini, "general", "cab", "-1")
			Else
				IniWrite($Ini, "general", "cab", "")
			EndIf
		Case $OpenFld
			$TmpBartPE = FileSelectFolder("������� ����� BartPE", '', '3', @WorkingDir, $Gui)
			If @error Then ContinueLoop
			GUICtrlSetData($input01, $TmpBartPE)
		Case -13
			If StringInStr(FileGetAttrib(@GUI_DragFile), "D") Then
				GUICtrlSetData($input01, @GUI_DragFile)
			Else
				GUICtrlSetData($input01, '')
				MsgBox(0, '���������', '������ ��������')
			EndIf
		Case -3
			ExitLoop
	EndSwitch
WEnd

Func _GMK(ByRef $a)
	Switch $a
		Case 0 To 1023
			$a=Int($a/1.024)
		Case 1024 To 102692
			$a=Round($a/(1024+$a*$GMKConst), 1)&' ��'
		Case 102693 To 1048039
			$a=Round($a/(1024+$a*$GMKConst))&' ��'
		Case 1048040 To 105156612
			$a=Round($a/(1048576+$a*$GMKConst), 1)&' ��'
		Case 105156613 To 1073192074
			$a=Round($a/(1048576+$a*$GMKConst))&' ��'
		Case 1073192075 To 107572492276
			$a=Round($a/(1073741824+$a*$GMKConst), 1)&' ��'
		Case 107572492277 To 1099511627775
			$a=Round($a/(1073741824+$a*$GMKConst))&' ��'
	EndSwitch
EndFunc