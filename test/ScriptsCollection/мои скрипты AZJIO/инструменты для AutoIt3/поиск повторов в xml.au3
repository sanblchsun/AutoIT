;  @AZJIO
; ������ ������ �� ������ ������� "����� ���������� � �������.au3". ����� ��� ��� �������� �������� � ��������������� xml �� api, ������� �������������� �� SciTE � Notepad++ ��� ��������� ��������������� � Notepad++. ����� �������� xml �������� ������ � ���� � ����� ����. ������ xml ����� ������ � ����, ��������� �� ����������, ������ ��������� � ���� ����� �������� �������.

;����������� batch.api ������ ���������� ���������� � Notepad++
;��������� Ctrl+R � ����������� "Regular Expr", "Incremental"
;����� ^(\w+).*$
;�������� �� <KeyWord name="\1" ></KeyWord>
;�������� ������� �������. ��� ������ ������ ���������, ��� ��������� ������� Notepad++ �� ������������: @, #, _

$bufer_read = 0 ; ���� 1 �� ������ �� ������, ���� 0 �� ������ ������ �����
$bufer_write = 0 ; ���� 1 �� ��������� � �����, ���� 0 �� ��������� � ���� file_0.au3 � �������� ����������
Global $text, $Info_Edit1

If $bufer_read = 1 Then
	$text = ClipGet()
Else
	$Path = FileOpenDialog("����� �����.", @WorkingDir & "", "������ (*.xml)", 1 + 4)
	$file = FileOpen($Path, 0)
	$text = FileRead($file)
	FileClose($file)
EndIf
_ReadAU3($text)


	$pos = 20

$Main_Gui = GUICreate("�������� �������� � XML", 390, $pos * 17 + 120, -1, -1, 786432, 0x00000010)
$CatchDrop = GUICtrlCreateLabel("", 0, 0, 390, $pos * 17 + 120)
GUICtrlSetState(-1, 128 + 8)
$Info_Edit1 = GUICtrlCreateEdit($text, 8, 10, 374, $pos * 17 + 40)
GUICtrlSetResizing(-1, 1)

GUISetState()

While 1
	Sleep(10)
	$msg = GUIGetMsg()
	Select
		Case $msg = -13
			$file = FileOpen(@GUI_DragFile, 0)
			$text = FileRead($file)
			FileClose($file)
			_ReadAU3($text)
		Case $msg = -3
			Exit
	EndSelect
WEnd
;=====================================

If $bufer_write = 1 Then
	ClipPut($text)
Else
	$filetxt = @ScriptDir & '\file_'
	$i = 0
	While FileExists($filetxt & $i & '.au3')
		$i = $i + 1
	WEnd
	$filetxt = $filetxt & $i & '.au3'

	$file = FileOpen($filetxt, 2)
	FileWrite($file, $text)
	FileClose($file)
EndIf


Func _ReadAU3($text)
	;����� ���� �� UDF File.au3 ��� ���������� ������� ��������� � ������
	If StringInStr($text, @LF) Then
		$aText1 = StringSplit(StringStripCR($text), @LF)
	ElseIf StringInStr($text, @CR) Then
		$aText1 = StringSplit($text, @CR)
	Else
		If StringLen($text) Then
			Dim $aText1[2] = [1, $text]
		Else
			MsgBox(0, "���������", "��� ������")
			Exit
		EndIf
	EndIf

	$text = ''
	For $i = 1 To UBound($aText1) - 1 ; ����������� ������� � �������������� �����
		$text &= $aText1[$i] & @CRLF
	Next

	For $i = 1 To UBound($aText1) - 1
		$text = StringRegExpReplace($text, StringRegExpReplace($aText1[$i], "[][{}()*+?.\\^$|=<>#]", "\\$0") & @CRLF, @CRLF)
		If @extended > 0 Then $text &= @CRLF & $aText1[$i] ; ��������� �������� ���������� � ����� ������, ����� ������ �������� ������� ���������� � ������ $text
	Next
	$text = StringRegExpReplace($text, '(\n\r)+', '') ;�������� ������ �����
	GUICtrlSetData($Info_Edit1, $text)

EndFunc   ;==>_ReadAU3


