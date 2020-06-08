;  @AZJIO
; ������������ ��� �������� �������� � �������� ������������� � ���������� ������ ru-board
; ������� ��� Notepad++, Alt+Shift+D
; <Command name="DelSpace" Ctrl="no" Alt="yes" Shift="yes" Key="68">&quot;$(NPP_DIRECTORY)\..\AutoIt3.exe&quot; &quot;$(NPP_DIRECTORY)\Instrument_azjio\DelSpace.au3&quot; &quot;$(FULL_CURRENT_PATH)&quot;</Command>

$bufer_read = 1 ; ���� 1 �� ������ �� ������, ���� 0 �� ������ ������ �����
$bufer_write = 1 ; ���� 1 �� ��������� � �����, ���� 0 �� ��������� � ���� file_0.au3 � �������� ����������

; ���� ������ ���� ����� ���-������, �� ����� �������
If $CmdLine[0] Then
	If FileExists($CmdLine[1]) Then
		$sText = FileRead($CmdLine[1])
	Else
		Exit
	EndIf
Else
	If $bufer_read Then
		$sText = ClipGet()
	Else
		$sTmpPath = FileOpenDialog("����� �����.", @WorkingDir & "", "������ (*.au3)", 1 + 4)
		If @error Then Exit
		$sText = FileRead($sTmpPath)
	EndIf
EndIf

$sText = StringRegExpReplace($sText, '\h+(?=\r|\n|\z)', '') ; �������� �������� � ����� �����

If $CmdLine[0] Then
	$hFile = FileOpen($CmdLine[1], 2)
	FileWrite($hFile, $sText)
	FileClose($hFile)
	MsgBox(4096, '', 'Yes...', 1) ; ����� Notepad++ ������� ���� � ������� ������ ����������.
Else
	If $bufer_write Then
		ClipPut($sText)
	Else
		$sPath = @ScriptDir & '\file_'
		$i = 0
		While FileExists($sPath & $i & '.au3')
			$i += 1
		WEnd
		$sPath = $sPath & $i & '.au3'

		$hFile = FileOpen($sPath, 2)
		FileWrite($hFile, $sText)
		FileClose($hFile)
	EndIf
EndIf