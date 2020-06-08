
;  @AZJIO
#NoTrayIcon
#include <ComboConstants.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>

FileChangeDir(@ScriptDir)
$ghost32 = @ScriptDir & '\ghost32.exe'
Global $Ini = @ScriptDir & '\ghost_set.ini', $sWinTitleRE = '[CLASS:GhostScreen]'

If Not FileExists($Ini) And MsgBox(4, "���������", "������ ������� ����������� ghost_set.ini ��� ���������� ����������?") = 6 Then
	$tmp = IniWriteSection($Ini, _
			"Ghost", 'Compression=3' & @LF & _
			'split=2048' & @LF & _
			'dsk=1:1' & @LF & _
			'gho=1:2' & @LF & _
			'Path1=D' & @LF & _
			'Path2=SYS\ImageHDD' & @LF & _
			'dvd=E' & @LF & _
			'namegho=myhdd')
	If Not $tmp Then MsgBox(0, '���������', '�� ������� ������� ghost_set.ini, �������� ���� �� �������� ��� ������')
EndIf
; 'auto=" -AUTO"' & @LF & _

;��������� ghost_set.ini
$sCompression = IniRead($Ini, "Ghost", "Compression", "3")
$sSplit = IniRead($Ini, "Ghost", "split", "2048")
$dsk = IniRead($Ini, "Ghost", "dsk", "1:1")
$gho = IniRead($Ini, "Ghost", "gho", "1:2")
$Path1 = IniRead($Ini, "Ghost", "Path1", "D")
$Path2 = IniRead($Ini, "Ghost", "Path2", "SYS\ImageHDD")
$dvd = IniRead($Ini, "Ghost", "dvd", "E")
$namegho = IniRead($Ini, "Ghost", "namegho", "myhdd")

; �������� ����������
If Not StringRegExp($dsk, '^\d+:\d+$') Then $dsk = '1:1'
If Not StringRegExp($gho, '^\d+:\d+$') Then $gho = '1:2'

$Path2 = '\' & $Path2 & '\'
If StringInStr($Path2, '\\') Then $Path2 = StringReplace($Path2, '\\', '\')
If Not StringInStr('abcdefghijklmnopqrstuvwxyz', $Path1) Then $Path1 = 'D'
$Path1 = $Path1 & ':'
If Not StringInStr('abcdefghijklmnopqrstuvwxyz', $dvd) Then $dvd = 'E'
$dvd = $dvd & ':'

If Not StringIsDigit($sCompression) Or StringLen($sCompression) > 1 Then $sCompression = '3'
If Not StringIsDigit($sSplit) Or $sSplit > 2048 Then $sSplit = '2048'
$sSizeList = '0|695|2048'
If Not StringInStr('|' & $sSizeList & '|', $sSplit) Then $sSizeList = $sSplit & '|' & $sSizeList
; ����� "�������� ����������"

$hGui = GUICreate("!!!������!!! �������������� Windows XP �� ������", 500, 327) ; ������ ����

GUICtrlCreateLabel("��������� ������� ���������� ������������������ (�������������)", 40, 10, 420, 22)
$iHelp = GUICtrlCreateButton("V", 15, 10, 21, 21, $BS_ICON)
GUICtrlSetTip(-1, "�������")
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 2, 0)

GUICtrlCreateLabel("������� ������� � ���������� ��� ���������", 40, 35, 420, 22)
$start8 = GUICtrlCreateButton("V", 15, 35, 21, 21, $BS_ICON)
GUICtrlSetTip(-1, "������� ������� � ���������� ��� ���������")
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 4, 0)

GUICtrlCreateLabel("������ Ghost32 (���������)", 40, 60, 420, 22)
$iStartGhost32 = GUICtrlCreateButton("V", 15, 60, 21, 21, $BS_ICON)
GUICtrlSetTip(-1, "����� ��� ����������.")
GUICtrlSetImage(-1, $ghost32, 0, 0)

GUICtrlCreateGroup('�������������� �������� ������', 10, 85, 480, 70)

GUICtrlCreateLabel("�������� ������ ����� C � ������ ����� D (���������)", 40, 105, 420, 22)
GUICtrlSetColor(-1, 0xbb0000)
$iCreateToRoot = GUICtrlCreateButton("V", 15, 105, 21, 21, $BS_ICON)
GUICtrlSetTip(-1, "�������� ������ ����� C � ������ ����� D (���������)")
GUICtrlSetImage(-1, $ghost32, 0, 0)

GUICtrlCreateLabel("�������� ������ ����� C � ����-������� ����� D (���������)", 40, 130, 420, 22)
GUICtrlSetColor(-1, 0xbb0000)
$iCreateToFolder = GUICtrlCreateButton("V", 15, 130, 21, 21, $BS_ICON)
GUICtrlSetTip(-1, "�������� ������ ����� C � ����-������� ����� D (���������)")
GUICtrlSetImage(-1, $ghost32, 0, 0)

GUICtrlCreateGroup('�������������� �������������� �� ������', 10, 160, 480, 95)

GUICtrlCreateLabel("!!! ������ !!! �������������� �� ������ � ����� ����� D", 40, 180, 420, 22)
GUICtrlSetColor(-1, 0xbb0000)
$restore1 = GUICtrlCreateButton("V", 15, 180, 21, 21, $BS_ICON)
GUICtrlSetTip(-1, "!!! ������ !!! �������������� �� ������ � ����� ����� D")
GUICtrlSetImage(-1, $ghost32, 0, 0)

GUICtrlCreateLabel("!!! ������ !!! �������������� �� ������ � ����-�������� ����� D", 40, 205, 420, 22)
GUICtrlSetColor(-1, 0xbb0000)
$restore2 = GUICtrlCreateButton("V", 15, 205, 21, 21, $BS_ICON)
GUICtrlSetTip(-1, "!!! ������ !!! �������������� �� ������ � ����-�������� ����� D")
GUICtrlSetImage(-1, $ghost32, 0, 0)

GUICtrlCreateLabel("!!! ������ !!! �������������� �� ������ � ����-�������� DVD-�����", 40, 230, 420, 22)
GUICtrlSetColor(-1, 0xbb0000)
$restore3 = GUICtrlCreateButton("V", 15, 230, 21, 21, $BS_ICON)
GUICtrlSetTip(-1, "!!! ������ !!! �������������� �� ������ � ����-�������� DVD-�����")
GUICtrlSetImage(-1, $ghost32, 0, 0)

$Label20 = GUICtrlCreateLabel("������� ������:", 20, 265, 100, 20)
GUICtrlSetTip(-1, "������� ������� ������ ������ ��� ����������")
$combozip = GUICtrlCreateCombo("", 130, 262, 65, 18, $CBS_DROPDOWNLIST + $WS_VSCROLL)
GUICtrlSetData(-1, '0|1|2|3|4|5|6|7|8|9', $sCompression)

$Label23 = GUICtrlCreateLabel("������ ����, ��:", 20, 300, 110, 20)
GUICtrlSetTip(-1, "������� ������, �� ������� ����� ������� �����, ��.")
$combosplit = GUICtrlCreateCombo("", 130, 297, 65, 18)
GUICtrlSetData(-1, $sSizeList, $sSplit)

GUICtrlCreateLabel("������������ � ghost_set.ini.", 250, 280, 200, 20)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $iHelp
			ShellExecute(@ScriptDir & '\Readme_auto.txt')
		Case $iStartGhost32
			If WinExists($sWinTitleRE) Then ; ���� ���� ����������, ��
				WinActivate($sWinTitleRE) ; ���������� ����
			Else ; �����
				$sSplitCom = _GetSplit()
				If @error Then ContinueLoop
				Run($ghost32 & $sSplitCom, '', @SW_HIDE) ; ��������� Ghost32
				$hWnd = WinWait($sWinTitleRE, '', 5) ; ������� ���� (������ ���������)
				If Not $hWnd Then
					MsgBox(4096, '���������', '�� ������� ��������� Ghost32, ��������� ������ �������')
					Exit
				EndIf
				If WinWaitActive($hWnd) Then ; ���� ���������, ��� ���� ��������, ��
					Send("{Enter}") ; �������� ������� ������
					Send("{RIGHT}")
					Send("{DOWN}")
					Send("{RIGHT}")
					Send("{DOWN}")
				EndIf
			EndIf
		Case $iCreateToRoot
			; ����� ���������� ������� �� ������.
			;�� ������ �������, � �������� ��� ����� ������� �� ����� ��� �� 4-� ������.
			$Path3 = $Path1 & '\' & $namegho
			If FileExists($Path3 & '.gho3.BAK') Then FileDelete($Path3 & '.gho3.BAK')
			If FileExists($Path3 & '.gho2.BAK') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '.gho2.BAK ' & $namegho & '.gho3.BAK', '', @SW_HIDE)
			If FileExists($Path3 & '.gho1.BAK') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '.gho1.BAK ' & $namegho & '.gho2.BAK', '', @SW_HIDE)
			If FileExists($Path3 & '.gho.BAK') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '.gho.BAK ' & $namegho & '.gho1.BAK', '', @SW_HIDE)
			If FileExists($Path3 & '.gho') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '.gho ' & $namegho & '.gho.BAK', '', @SW_HIDE)

			If FileExists($Path3 & '001.ghs3.BAK') Then FileDelete($Path3 & '001.ghs3.BAK')
			If FileExists($Path3 & '001.ghs2.BAK') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '001.ghs2.BAK ' & $namegho & '001.ghs3.BAK', '', @SW_HIDE)
			If FileExists($Path3 & '001.ghs1.BAK') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '001.ghs1.BAK ' & $namegho & '001.ghs2.BAK', '', @SW_HIDE)
			If FileExists($Path3 & '001.ghs.BAK') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '001.ghs.BAK ' & $namegho & '001.ghs1.BAK', '', @SW_HIDE)
			If FileExists($Path3 & '001.ghs') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '001.ghs ' & $namegho & '001.ghs.BAK', '', @SW_HIDE)

			If FileExists($Path3 & '002.ghs3.BAK') Then FileDelete($Path3 & '002.ghs3.BAK')
			If FileExists($Path3 & '002.ghs2.BAK') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '002.ghs2.BAK ' & $namegho & '002.ghs3.BAK', '', @SW_HIDE)
			If FileExists($Path3 & '002.ghs1.BAK') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '002.ghs1.BAK ' & $namegho & '002.ghs2.BAK', '', @SW_HIDE)
			If FileExists($Path3 & '002.ghs.BAK') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '002.ghs.BAK ' & $namegho & '002.ghs1.BAK', '', @SW_HIDE)
			If FileExists($Path3 & '002.ghs') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '002.ghs ' & $namegho & '002.ghs.BAK', '', @SW_HIDE)

			If FileExists($Path3 & '003.ghs3.BAK') Then FileDelete($Path3 & '003.ghs3.BAK')
			If FileExists($Path3 & '003.ghs2.BAK') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '003.ghs2.BAK ' & $namegho & '003.ghs3.BAK', '', @SW_HIDE)
			If FileExists($Path3 & '003.ghs1.BAK') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '003.ghs1.BAK ' & $namegho & '003.ghs2.BAK', '', @SW_HIDE)
			If FileExists($Path3 & '003.ghs.BAK') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '003.ghs.BAK ' & $namegho & '003.ghs1.BAK', '', @SW_HIDE)
			If FileExists($Path3 & '003.ghs') Then RunWait(@ComSpec & ' /C ren ' & $Path3 & '003.ghs ' & $namegho & '003.ghs.BAK', '', @SW_HIDE)

			$sSplitCom = _GetSplit()
			If @error Then ContinueLoop

			Run($ghost32 & ' -AUTO -Z' & GUICtrlRead($combozip) & $sSplitCom & _
					' -clone,mode=pdump,src=' & $dsk & ',dst=' & $gho & '\' & $namegho & '.gho -sure', '', '', @SW_HIDE)
		Case $iCreateToFolder
			; ����� ���������� ������� �� ������.
			;�� ������ �������, � �������� ��� ����� ������� �� ����� ��� �� 4-� ������.
			$Path4 = $Path1 & $Path2 & $namegho
			If FileExists($Path4 & '.gho3.BAK') Then FileDelete($Path4 & '.gho3.BAK')
			If FileExists($Path4 & '.gho2.BAK') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '.gho2.BAK myhdd.gho3.BAK', '', @SW_HIDE)
			If FileExists($Path4 & '.gho1.BAK') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '.gho1.BAK myhdd.gho2.BAK', '', @SW_HIDE)
			If FileExists($Path4 & '.gho.BAK') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '.gho.BAK myhdd.gho1.BAK', '', @SW_HIDE)
			If FileExists($Path4 & '.gho') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '.gho myhdd.gho.BAK', '', @SW_HIDE)

			If FileExists($Path4 & '001.ghs3.BAK') Then FileDelete($Path4 & '001.ghs3.BAK')
			If FileExists($Path4 & '001.ghs2.BAK') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '001.ghs2.BAK myhdd001.ghs3.BAK', '', @SW_HIDE)
			If FileExists($Path4 & '001.ghs1.BAK') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '001.ghs1.BAK myhdd001.ghs2.BAK', '', @SW_HIDE)
			If FileExists($Path4 & '001.ghs.BAK') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '001.ghs.BAK myhdd001.ghs1.BAK', '', @SW_HIDE)
			If FileExists($Path4 & '001.ghs') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '001.ghs myhdd001.ghs.BAK', '', @SW_HIDE)

			If FileExists($Path4 & '002.ghs3.BAK') Then FileDelete($Path4 & '002.ghs3.BAK')
			If FileExists($Path4 & '002.ghs2.BAK') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '002.ghs2.BAK myhdd002.ghs3.BAK', '', @SW_HIDE)
			If FileExists($Path4 & '002.ghs1.BAK') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '002.ghs1.BAK myhdd002.ghs2.BAK', '', @SW_HIDE)
			If FileExists($Path4 & '002.ghs.BAK') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '002.ghs.BAK myhdd002.ghs1.BAK', '', @SW_HIDE)
			If FileExists($Path4 & '002.ghs') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '002.ghs myhdd002.ghs.BAK', '', @SW_HIDE)

			If FileExists($Path4 & '003.ghs3.BAK') Then FileDelete($Path4 & '003.ghs3.BAK')
			If FileExists($Path4 & '003.ghs2.BAK') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '003.ghs2.BAK myhdd003.ghs3.BAK', '', @SW_HIDE)
			If FileExists($Path4 & '003.ghs1.BAK') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '003.ghs1.BAK myhdd003.ghs2.BAK', '', @SW_HIDE)
			If FileExists($Path4 & '003.ghs.BAK') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '003.ghs.BAK myhdd003.ghs1.BAK', '', @SW_HIDE)
			If FileExists($Path4 & '003.ghs') Then RunWait(@ComSpec & ' /C ren  ' & $Path4 & '003.ghs myhdd003.ghs.BAK', '', @SW_HIDE)

			$sSplitCom = _GetSplit()
			If @error Then ContinueLoop

			Run($ghost32 & ' -AUTO -Z' & GUICtrlRead($combozip) & $sSplitCom & _
					' -clone,mode=pdump,src=' & $dsk & ',dst=' & $gho & $Path2 & $namegho & '.gho -sure', '', @SW_HIDE)
		Case $restore1
			If MsgBox(4 + 256, '���������', '������ �� ����� ����� ��������. �� ������������� ������ ������������ ����?') = 6 Then Run($ghost32 & '-clone,mode=pload,src=' & $gho & '\' & $namegho & '.gho:1,dst=' & $dsk & ' -sure', '', @SW_HIDE)
		Case $restore2
			If MsgBox(4 + 256, '���������', '������ �� ����� ����� ��������. �� ������������� ������ ������������ ����?') = 6 Then Run($ghost32 & '-clone,mode=pload,src=' & $gho & $Path2 & $namegho & '.gho:1,dst=' & $dsk & ' -sure', '', @SW_HIDE)
		Case $restore3
			If MsgBox(4 + 256, '���������', '������ �� ����� ����� ��������. �� ������������� ������ ������������ ����?') = 6 Then Run($ghost32 & '-clone,mode=pload,src=' & $dvd & '\z-imahdd\' & $namegho & '.gho:1,dst=' & $dsk & ' -sure', '', @SW_HIDE)
		Case $start8
			Run('explorer.exe ' & @ScriptDir)
		Case -3
			IniWrite($Ini, "Ghost", "split", GUICtrlRead($combosplit))
			IniWrite($Ini, "Ghost", "Compression", GUICtrlRead($combozip))
			Exit
	EndSwitch
WEnd

Func _GetSplit()
	$sSplit = GUICtrlRead($combosplit)
	If Not StringIsDigit($sSplit) Or $sSplit > 2048 Then
		$sSplit = '2048'
		If MsgBox(4 + 256, '���������', _
				'������� ������ ������������ ������ ������ ������ (����� �� ����� 2048 ��).' & @LF & _
				'����������� 0, ����� ��������� ������� �� �����.' & @LF & _
				'���������� ��������� 2048 ��') = 7 Then Return SetError(1, 0, '')
	EndIf
	If $sSplit = '0' Then
		$sSplitCom = ''
	Else
		$sSplitCom = ' -SPLIT=' & $sSplit
	EndIf
	Return SetError(0, 0, $sSplitCom)
EndFunc   ;==>_GetSplit