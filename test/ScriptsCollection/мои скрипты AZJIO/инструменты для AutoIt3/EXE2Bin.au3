;  @AZJIO
#NoTrayIcon ; ������ ������ � ����
Opt("GUICloseOnESC", 1) ; ����� �� ESC

$Gui = GUICreate("EXE2Bin.au3",  300, 94, -1, -1, -1, 0x00000010)

$filemenu = GUICtrlCreateMenu ("����")
$folder1 = GUICtrlCreateMenuitem ("�������",$filemenu)
$Readme = GUICtrlCreateMenuitem ("� ���������",$filemenu)
$Quit = GUICtrlCreateMenuitem ("�����",$filemenu)

$Input1 = GUICtrlCreateLabel('', 0, 0, 300, 94)
GUICtrlSetState(-1, 136) ; ������ ����
GUICtrlCreateLabel ("���� ���� ���� ��� ����������� � ���� �������", 10,2,280,17)
$StatusBar=GUICtrlCreateLabel (@CRLF&@CRLF&'������ ���������', 10,23,280,57)

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = -13
				$filename=StringRegExp(@GUI_DRAGFILE,'(^.*)\\(.*)\.(.*)$',3)
				GUICtrlSetData($StatusBar, '���� '&$filename[1]&'.'&$filename[2]&' ������'&@CRLF&'������...')
				$ScrBin='$sData  = ''0x'''&@CRLF
				$file = FileOpen(@GUI_DRAGFILE, 16)
				While 1
					$Bin = FileRead($file, 2040)
					If @error = -1 Then ExitLoop
					$ScrBin&='$sData  &= '''&StringTrimLeft($Bin,2)&''''&@CRLF
					Sleep(1)
				WEnd
				FileClose($file)
				GUICtrlSetData($StatusBar, '���� '&$filename[1]&'.'&$filename[2]&' ������'&@CRLF&'������...')
				
				; ���������� ��� ������ ����� � ������� ����� �� ������ ���� ���� ����������
				$Output = $filename[0]& '\Bin_'
				$i = 1
				While FileExists($Output & $i & '_'&$filename[1]&'.au3')
					$i += 1
				WEnd
				$Output = $Output & $i & '_'&$filename[1]&'.au3'
				
				; ��������� �������� ������ � ����
				$file = FileOpen($Output,2)
				FileWrite($file, $ScrBin&@CRLF& _
				'$sData=Binary($sData)'&@CRLF& _
				'$file = FileOpen(@ScriptDir&''\Copy_'&$filename[1]&'.'&$filename[2]&''',18)'&@CRLF& _
				'FileWrite($file, $sData)'&@CRLF& _
				'FileClose($file)')
				FileClose($file)
				GUICtrlSetData($StatusBar, '���� '&$filename[1]&'.'&$filename[2]&' ������'&@CRLF&'������-���� Bin_'& $i & '_'&$filename[1]&'.au3 ������.')
				
			; Case $msg = $folder1
				; $folder01 = FileOpenDialog("������� ����", @WorkingDir & "", "��� ����� (*.*)", 1 + 4 )
				; If @error Then ContinueLoop
				; GUICtrlSetData($Input1, $folder01)
				
			Case $msg = $Readme
				MsgBox(0, 'Readme', '     �������� ������������� ��� ��������� ������ ����� � ���� �������. ��� ������������� ������������ ������ � ��� �� ����� ��� � ��� ����������� ����, � ������� � �������� ���� ��������� ����������� ����. ��� ������ ����������� �������, �������� ����� ����� �����, �� ��� ����������� �� �������, ��� �������� �������� �������������.'&@CRLF&'     ��� ����� ���������� ��� ������������� ��������� exe-������ ���������� � ���-�������. �������� ��������� ���� � %Temp%, ��������� � ���-�������, ����� ���������� �������. ��� ��� �������� ���������� �����-�������, �������� �������� � ��������� ���� ����� �������� � �����������.')
			Case $msg = -3 Or $msg = $Quit
				Exit
		EndSelect
	WEnd
