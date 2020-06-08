; ������ ���������� AZJIO
; http://pastebin.com/v6g3RQig

#include <ButtonConstants.au3>
#include <ListViewConstants.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <Array.au3>
#include <ComboConstants.au3>
#NoTrayIcon

$sHelp = _
		'1. ���� ������ �� �����������, �������� ��� ���� "AutoIt3\Include\SQLite.dll.au3" �� ������ (~2 ��) � ������ ����� ���� ������.' & @CRLF & _
		'2. ��� ������ ������� ��� "�������������" - �������� ���� ���� � ����������� �������. � ���������� ����� "�������" ����-����.' & @CRLF & _
		'3. ������ ��������� ����� �������, ����� ��� � ������ "�������������".' & @CRLF & _
		'4. ��� ������ ���������� ��� �������, � ������� ������. ���������� ������� ����� ������ ��� ������' & @CRLF & _
		'5. ��� ������ ��� �������� ������ ���� ���������� ����� ������ ���������.' & @CRLF & _
		'������:' & @CRLF & _
		'http://sb-money.ru/sqlite.php?page=21' & @CRLF & _
		'http://sb-money.ru/sqlite.php?page=6' & @CRLF & _
		'FAQ, ����� � 15 ������ �������, ��� �� ������ ������������ SQLite � ������������ ��������.'

Global $Msg, $hQuery, $aRow
Global $a, $b, $c
Global $sRes, $mem = 0

; ��� ������� � �����
Global $sNameTable = 'TestTable', $ID1 = '�', $ID2 = '���', $ID3 = '����'
FileChangeDir(@ScriptDir) ; ������������� ������� �������

$SQLite_Data_Path = 'SQLite.db'
_SQLite_Startup() ; �������� SQLite.dll � ������ (2��)
$hGui = GUICreate('SQLite ������', 850, 413)
GUISetBkColor(0xECE9D8) ; ���� ���� ���������
$StatusBar = GUICtrlCreateLabel('������ ���������', 480, 413 - 17, 370, 17)
$iListView = GUICtrlCreateListView($ID1 & '|' & $ID2 & '|' & $ID3, 2, 2, 466, 409) ; $LVS_SORTASCENDING

$iMemory = GUICtrlCreateCheckbox('���� � ������', 660, 340, 100, 17)
GUICtrlCreateLabel('��� �������', 487, 371, 70, 23)
$TableCombo = GUICtrlCreateCombo('', 560, 369, 90, 23)
GUICtrlSetTip(-1, '��� ����� ������ � ����')
$Create = GUICtrlCreateButton('�������������', 660, 365, 98, 28)
GUICtrlSetTip(-1, '������������� �������� ����')

$Open = GUICtrlCreateButton('�������', 770, 365, 67, 28)
GUICtrlSetTip(-1, '������� ��� ������� ���� �� �����')

GUICtrlCreateGroup('��������� ��� ������ � ����', 487, 10, 350, 100)
GUICtrlCreateLabel($ID1, 500, 37, 40, 23)
GUICtrlCreateLabel($ID2, 500, 58, 40, 23)
GUICtrlCreateLabel($ID3, 500, 83, 40, 23)
$ID1_Input1 = GUICtrlCreateInput('', 540, 30, 200, 23)
$ID1_Input2 = GUICtrlCreateInput('', 540, 55, 200, 23)
$ID1_Input3 = GUICtrlCreateInput('', 540, 80, 200, 23)
$Insert = GUICtrlCreateButton('��������' & @LF & '���' & @LF & '��������', 750, 30, 75, 70, $BS_MULTILINE)
GUICtrlSetTip(-1, '��������� �������')

GUICtrlCreateGroup('�������� � ���������', 487, 120, 350, 100)
GUICtrlCreateLabel('��� �������', 500, 143, 70, 17)
$Combo = GUICtrlCreateCombo('', 570, 140, 90, 23, 0x3)
GUICtrlSetData($Combo, $ID1 & '|' & $ID2 & '|' & $ID3, $ID2)

GUICtrlCreateLabel('����� ������', 500, 168, 70, 17)
$GUI_Input5 = GUICtrlCreateInput('', 500, 185, 160, 23)

$Delete = GUICtrlCreateButton('�������', 670, 130, 73, 23)
GUICtrlSetTip(-1, '������� ������� �� ������ �������')

$Select = GUICtrlCreateButton('���������', 750, 130, 73, 23)
GUICtrlSetTip(-1, '��������� ������� �� ����')

$Find = GUICtrlCreateButton('����� ������', 750, 160, 73, 23)
GUICtrlSetTip(-1, '����� ������ ��������� ����� ������ �� ����')

$FindAll = GUICtrlCreateButton('����� ����', 750, 190, 73, 23)
GUICtrlSetTip(-1, '����� ���� ��������� ����� ������ �� ���� (Exec)')

$FindAll2 = GUICtrlCreateButton('����� ����2', 670, 190, 73, 23)
GUICtrlSetTip(-1, '��������� ����� ���� ��������� ����� ������ �� ���� (Query + FetchData)')

; GUICtrlCreateGroup('', 2, 307, 336, 134)

$AllItem = GUICtrlCreateButton('��� ������', 490, 230, 73, 23)
GUICtrlSetTip(-1, '�������� ��� ������ � ��������')
$GetTableToArray2D = GUICtrlCreateButton('� ������', 490, 260, 73, 23)
GUICtrlSetTip(-1, '�������� ��� ������ � ��������')

$DelTable = GUICtrlCreateButton('������� �������', 570, 230, 100, 23)
GUICtrlSetTip(-1, '�������� ��� ������ � ��������')

$GetNameTable = GUICtrlCreateButton('����� ������', 570, 260, 100, 23)
GUICtrlSetTip(-1, '�������� ��� ����� ������ � ����')

$GetColum = GUICtrlCreateButton('����� �������', 570, 290, 100, 23)
GUICtrlSetTip(-1, '�������� ����� ������� � �������')

$Test = GUICtrlCreateButton('����', 490, 290, 73, 23)
GUICtrlSetTip(-1, '�� ����������� ������, ��� ���' & @CRLF & '����� ������������ �������')

$iHelp = GUICtrlCreateButton('?', 770, 260, 23, 23)
GUICtrlSetTip(-1, '�������')

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $iHelp
			MsgBox(0, '�������', $sHelp, 0, $hGui)
		Case $TableCombo
			$sNameTable = GUICtrlRead($TableCombo)
			_Read_sql()
		Case $GetNameTable
			_GetNameTable()
			MsgBox(0, '���������', $sRes, 0, $hGui)
		Case $GetColum
			_GetColum_sql()
		Case $DelTable
			_DelTable()
			GUICtrlSetData($StatusBar, '������� �������, ���� ������������')
		Case $GetTableToArray2D
			_GetTableToArray2D()
		Case $AllItem
			_GetAllItem_sql()
		Case $Test
			_Test_sql()
		Case $Create
			_SQLite_Close()
			If GUICtrlRead($iMemory) = 1 Then
				$mem = 1
			Else
				$mem = 0
			EndIf
			Select
				Case $mem = 1
					$SQLite_Data_Path = ":memory:"
					ContinueCase
				Case FileExists($SQLite_Data_Path)
					$sNameTable = GUICtrlRead($TableCombo)
					If $sNameTable = '' Then $sNameTable = 'TestTable'
					_SQLite_Open($SQLite_Data_Path)
				Case Else
					_Open_sql()
					If @error Then ContinueLoop
			EndSelect
			If $mem = 1 Then ; ���� ���� � ������ �� ����������� 1000 ���������
				_SQLite_Exec(-1, "Create Table IF NOT Exists '" & $sNameTable & "' (" & $ID1 & " int, '" & $ID2 & "' Text, '" & $ID3 & "' Text);")
				$kod = ''
				; �� ����� ����������� ��������  _SQLite_Exec ��� ������� �������, ���������� ��� ������� ������� ���������� � ���� ������, �������� �������� ";"
				; ���� �������� ������ �������� ����� �������
				For $i = 1 To 3000
					$kod &= "Insert into '" & $sNameTable & "' (" & $ID1 & "," & $ID2 & "," & $ID3 & ") values ('" & $i & "','" & Random(10000, 12000, 1) & "','" & Random(10000, 99999, 1) & "');"
				Next
				_SQLite_Exec(-1, $kod)
			Else ; ����� ����������� ��������� ����
				; ������ 3000 ����� ����������� �� 0.27 ���
				_SQLite_Exec(-1, "Create Table IF NOT Exists '" & $sNameTable & "' (" & $ID1 & " int, '" & $ID2 & "' Text, '" & $ID3 & "' Text);")
				$kod = 'BEGIN TRANSACTION;'
				; �� ����� ����������� ��������  _SQLite_Exec ��� ������� �������, ���������� ��� ������� ������� ���������� � ���� ������, �������� �������� ";"
				; ���� �������� ������ �������� ����� �������
				For $i = 1 To 3000
					$kod &= "Insert into '" & $sNameTable & "' (" & $ID1 & "," & $ID2 & "," & $ID3 & ") values ('" & $i & "','" & Random(10000, 12000, 1) & "','" & Random(10000, 99999, 1) & "');"
				Next
				$kod &= 'COMMIT;'
				_SQLite_Exec(-1, $kod)
				; _Insert_sql('1', '�������� ������ ������������', '15.08.2011')
				; _Insert_sql('2', '������ ������ ����������', '12.11.2005')
				; _Insert_sql('3', '������ ���������� �����������', '01.12.2011')
				; _Insert_sql('4', '��������� ������ ����������', '11.09.2001')
				; _Insert_sql('5', '������ ������ ����������', '22.07.2011')
				; _Insert_sql('6', '������� ��� ��������', '18.10.2007')
				; _Insert_sql('7', '���������� ������ ������������', '02.01.2012')
				; _Insert_sql('8', '�������� ��������� ������������', '30.08.2011')
				; _Insert_sql('9', '������������ ������ ������������', '22.01.2008')
				; _Insert_sql('10', '������ ������ �������', '14.05.2009')
			EndIf
			GUICtrlSetData($StatusBar, '������ �������������')
			_Read_sql()
			; ��������� ����� ����� ��������� �������
			_UpdateCombo($sNameTable)
		Case $Open ; ������ ���� �� �����
			_SQLite_Close()
			_Open_sql()
		Case $Insert
			_Insert_sql(GUICtrlRead($ID1_Input1), GUICtrlRead($ID1_Input2), GUICtrlRead($ID1_Input3)) ; ��������� �������
			_Read_sql()
		Case $Select ; �������� �������
			_SelectItem_sql(GUICtrlRead($GUI_Input5))
		Case $Find ; ����� ������
			_FindFirst_sql()
		Case $FindAll ; ����� ���� ��������� (Exec)
			_FindAll_sql()
		Case $FindAll2 ; ����� ���� ��������� (Query + FetchData)
			_FindAll_sql2()
		Case $Delete ; ������� �������
			_DeleteItem_sql()
			_Read_sql()
		Case -3 ; �����
			_SQLite_Shutdown() ; �������� SQLite.dll
			ExitLoop
	EndSwitch
WEnd

Func _UpdateCombo($flag = 0)
	GUICtrlSendMsg($TableCombo, $CB_RESETCONTENT, 0, 0) ; �������� ������
	_GetNameTable()
	$sRes = StringRegExpReplace(StringReplace($sRes, @TAB, '|'), '\R', '')
	If $flag Then
		GUICtrlSetData($TableCombo, $sRes, $flag)
		$sNameTable = $flag
	Else
		GUICtrlSetData($TableCombo, $sRes, StringLeft($sRes, StringInStr($sRes & '|', '|') - 1))
		$sNameTable = GUICtrlRead($TableCombo)
	EndIf
EndFunc   ;==>_UpdateCombo

Func _Open_sql() ; ������� �������� / �������� ����� ����
	$SQLite_Data_Path = FileOpenDialog("������� ����", @WorkingDir, "��� ����� (*.db)", 24, 'SQLite.db', $hGui)
	If @error Then Return SetError(1)
	_SQLite_Open($SQLite_Data_Path)
	If FileGetSize($SQLite_Data_Path) = 0 Then ; ���� ������ ����� ���� ����� ���� �� ������ �, ����� ������ ������.
		$sNameTable = GUICtrlRead($TableCombo)
		If $sNameTable = '' Then $sNameTable = 'TestTable'
		_Create_sql()
	Else
		_UpdateCombo()
		_Read_sql()
	EndIf
	GUICtrlSetData($StatusBar, '������ ���� ���� ' & StringRegExpReplace($SQLite_Data_Path, '(^.*)\\(.*)$', '\2'))
EndFunc   ;==>_Open_sql

Func _Create_sql() ; ������� �������� ����� ����
	; _SQLite_Exec(-1, "Create Table IF NOT Exists '" & $sNameTable & "' (" & $ID1 & ", " & $ID2 & ", '" & $ID3 & "');")
	; ���� �� ���������� �������, �� ������ � 3-�� ��������� (������) ID, � ������� int (��������) � Text (���������).
	; ���������� '' ��������� ������������ ������� � ������ ������ � �������
	_SQLite_Exec(-1, "Create Table IF NOT Exists '" & $sNameTable & "' (" & $ID1 & " int, '" & $ID2 & "' Text, '" & $ID3 & "' Text);")
EndFunc   ;==>_Create_sql

Func _Read_sql() ; ������� ������ ������ ����� ����
	GUICtrlSendMsg($iListView, $LVM_DELETEALLITEMS, 0, 0)
	; If _SQLite_Query(-1, "SELECT * FROM '" & $sNameTable & "' ORDER BY " & $ID1 & " DESC;", $hQuery) <> $SQLITE_OK Then
	; ORDER BY - ����������, DESC - �������� ����������
	If _SQLite_Query(-1, "SELECT * FROM '" & $sNameTable & "' ORDER BY " & $ID1 & ";", $hQuery) <> $SQLITE_OK Then
		_err('����������� �������')
		Return SetError(1)
	EndIf
	; _SQLite_Query �������������� ������ ��� _SQLite_FetchData
	While _SQLite_FetchData($hQuery, $aRow) = $SQLITE_OK
		GUICtrlCreateListViewItem($aRow[0] & '|' & $aRow[1] & '|' & $aRow[2], $iListView)
	WEnd
	For $i = 0 To 2 ; ������������ �������� ListView �� ������ ������
		GUICtrlSendMsg($iListView, $LVM_SETCOLUMNWIDTH, $i, -1)
		GUICtrlSendMsg($iListView, $LVM_SETCOLUMNWIDTH, $i, -2)
	Next
EndFunc   ;==>_Read_sql

; ������� Insert, ��� ���������, ��� ��������� ������������� ID, ��� ��� ��� ���������� ����������
Func _InsertFast_sql($a, $b, $c) ; ������� ���������� ��������� � ���� ����
	_SQLite_Exec(-1, "Insert into '" & $sNameTable & "' (" & $ID1 & "," & $ID2 & "," & $ID3 & ") values ('" & $a & "','" & $b & "','" & $c & "');")
EndFunc   ;==>_InsertFast_sql

Func _Insert_sql($a, $b, $c) ; ������� ���������� ��������� � ���� ����
	; ���� ������� ���, �� ��������. ������ �� ������ ������� � �������������� �������
	_SQLite_Exec(-1, "Create Table IF NOT Exists '" & $sNameTable & "' (" & $ID1 & " int, '" & $ID2 & "' Text, '" & $ID3 & "' Text);")
	; ������ ������ ������� � ��������� ���������� � $aRow
	_SQLite_QuerySingleRow(-1, "SELECT " & $ID1 & " FROM '" & $sNameTable & "' WHERE " & $ID1 & " = '" & $a & "';", $aRow)
	; If _SQLite_QuerySingleRow(-1, "SELECT " & $ID1 & " FROM '" & $sNameTable & "' WHERE " & $ID1 & " = '" & $a & "';", $aRow)=$SQLITE_OK Then
	If $aRow[0] = '' Then ; ���� ID �� ����������, �� ������
		; _SQLite_Exec(-1, "Insert into '" & $sNameTable & "' (" & $ID1 & ") values ('" & $a & "');")
		_SQLite_Exec(-1, "Insert into '" & $sNameTable & "' (" & $ID1 & "," & $ID2 & "," & $ID3 & ") values ('" & $a & "','" & $b & "','" & $c & "');")
		GUICtrlSetData($StatusBar, '������ �������')
	Else ; ����� �������� ������������
		; ��������� ��� ��������
		_SQLite_Exec(-1, "UPDATE '" & $sNameTable & "' SET " & $ID2 & " = '" & $b & "' WHERE " & $ID1 & " = '" & $a & "';")
		_SQLite_Exec(-1, "UPDATE '" & $sNameTable & "' SET '" & $ID3 & "' = '" & $c & "' WHERE " & $ID1 & " = '" & $a & "';")
		GUICtrlSetData($StatusBar, '������ ��������')
	EndIf
EndFunc   ;==>_Insert_sql

Func _FindFirst_sql() ; ����� � ���� ������ ������ ��������������� �������
	_SQLite_QuerySingleRow(-1, "SELECT * FROM '" & $sNameTable & "' WHERE " & GUICtrlRead($Combo) & " LIKE '%" & GUICtrlRead($GUI_Input5) & "%';", $aRow)
	If $aRow[0] = '' Then
		_err('������ � ������ ������� �����������')
	Else
		GUICtrlSetData($ID1_Input1, $aRow[0])
		GUICtrlSetData($ID1_Input2, $aRow[1])
		GUICtrlSetData($ID1_Input3, $aRow[2])
		GUICtrlSetData($StatusBar, '������ ���� �������')
	EndIf
EndFunc   ;==>_FindFirst_sql

; ������ ������ � ������� Exec ��������� ����� ���� ����� � ��� 10000 ��������� ���� ��������� �������� �������� ������ ������.
Func _FindAll_sql() ; ����� ���� � ����
	$sRes = ''
	; * ��������� �������� � ���������� ���� ������ (id �� ������ �������). ���� ������� id, �� ��� ������� � ����� ��������� ������
	; ������� ��������� ������ _CallbackRow ��������� ������������ � ��������� ��� ��������� ������
	$timer = TimerInit()
	_SQLite_Exec(-1, "SELECT * FROM '" & $sNameTable & "' WHERE " & GUICtrlRead($Combo) & " LIKE '%" & GUICtrlRead($GUI_Input5) & "%';", "_CallbackRow")
	; _SQLite_Exec(-1, "SELECT " & GUICtrlRead($Combo) & " FROM '" & $sNameTable & "' WHERE " & GUICtrlRead($Combo) & " LIKE '%" & GUICtrlRead($GUI_Input5) & "%';", "_CallbackRow")
	MsgBox(0, '����� ������ : ' & Round(TimerDiff($timer), 2) & ' ����', $sRes, 0, $hGui)
EndFunc   ;==>_FindAll_sql

; �������� ������ � ������� Query : �������� ���������� �� 0.28 �� � ����� ������� � ������� �������� ������ � �� ������� � ����������, �.�. ���������.
Func _FindAll_sql2() ; ����� ���� � ����
	; $sRes=''
	; * ��������� �������� � ���������� ���� ������ (id �� ������ �������). ���� ������� id, �� ��� ������� � ����� ��������� ������
	; ������� _SQLite_FetchData ���������� ��������� ������� ������������ � ��������� ��� ��������� ������
	$timer = TimerInit()
	_SQLite_Query(-1, "SELECT * FROM '" & $sNameTable & "' WHERE " & GUICtrlRead($Combo) & " LIKE '%" & GUICtrlRead($GUI_Input5) & "%';", $hQuery)
	$timer = Round(TimerDiff($timer), 2)
	While _SQLite_FetchData($hQuery, $aRow) = $SQLITE_OK
		; $sRes &=$aRow[0] & '|' & $aRow[1] & '|' & $aRow[2]&@CRLF ; ����� ������������ ���������� � ������� ����� ���
		If MsgBox(4, '����������? (����� ������� Query : ' & $timer & ' ����)', $aRow[0] & '|' & $aRow[1] & '|' & $aRow[2], 0, $hGui) = 7 Then _SQLite_QueryFinalize($hQuery)
	WEnd
	; MsgBox(0, '���������', $sRes, 0, $hGui)
EndFunc   ;==>_FindAll_sql2

Func _GetAllItem_sql() ; �������� ��� ������ �������
	$sRes = ''
	Local $d = _SQLite_Exec(-1, "Select oid,* FROM '" & $sNameTable & "'", "_CallbackRow") ; _CallbackRow ����� ������� ��� ������ ������
	MsgBox(0, '���������', $sRes, 0, $hGui)
EndFunc   ;==>_GetAllItem_sql

Func _CallbackRow($aRow)
	For $s In $aRow
		$sRes &= $s & @TAB
	Next
	$sRes &= @CRLF
EndFunc   ;==>_CallbackRow

Func _GetTableToArray2D() ; ������� � 2D ������
	Local $aResult, $iRows, $iColumns
	$iRval = _SQLite_GetTable2d(-1, "SELECT * FROM '" & $sNameTable & "'", $aResult, $iRows, $iColumns)
	If $iRval = $SQLITE_OK Then
		; _SQLite_Display2DResult($aResult) - ���������� ���������� � �������
		_ArrayDisplay($aResult, 'Array')
	Else
		MsgBox(16, "������ SQLite: " & $iRval, _SQLite_ErrMsg(), 0, $hGui)
	EndIf
EndFunc   ;==>_GetTableToArray2D

Func _DelTable() ; ������� �������
	; IF EXISTS - ��������� �� ������ �������� �������������� �������
	_SQLite_Exec(-1, "Drop Table IF EXISTS '" & $sNameTable & "'")
	_UpdateCombo()
	_Read_sql()
EndFunc   ;==>_DelTable

Func _GetNameTable() ; �������� ����� ������
	$sRes = ''
	; sqlite_master - ��������� �������, ���������� ����� ������ � ����
	; ORDER BY name - ���������� �� ���� ����� (name) ������
	_SQLite_Exec(-1, "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;", "_CallbackRow")
	
	; _SQLite_QuerySingleRow(-1, "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;", $aRow)
	; MsgBox(0, '���������', $aRow[0], 0, $hGui)
EndFunc   ;==>_GetNameTable

; �������� �������, ������������, ��� ������������
Func _Test_sql2() ; ���������� � ������������� ��������
	Local $hQuery, $aRow, $aNames
	$name = StringRegExpReplace($SQLite_Data_Path, '(^.*)\\(.*)\.(.*)$', '\2')
	; MsgBox(0, '���������', _SQLite_Exec(-1, "REINDEX "&$SQLite_Data_Path&".'"&$sNameTable&"'")=$SQLITE_OK, 0, $hGui)
	MsgBox(0, '���������', _SQLite_Exec(-1, "REINDEX collation " & $name) = $SQLITE_OK, 0, $hGui)
EndFunc   ;==>_Test_sql2

; �������� �������, ������������, ��� ������������
Func _Test_sql() ; �������� ���������� ������ ��� ��������� ������������� �������
	; $name=StringRegExpReplace($SQLite_Data_Path, '(^.*)\\(.*)\.(.*)$', '\2')
	; MsgBox(0, '���������', _SQLite_Exec(-1, "SELECT count(name) FROM sqlite_master WHERE name='"&$sNameTable&"'")=$SQLITE_OK, 0, $hGui)
	
	
	$sRes = ''
	; _SQLite_QuerySingleRow(-1, "SELECT count FROM sqlite_master WHERE name='"&$sNameTable&"'", $aRow)
	_SQLite_Query(-1, "SELECT count(" & $ID1 & ") FROM '" & $sNameTable & "'", $hQuery)
	MsgBox(0, '���������', $aRow[0], 0, $hGui)
	
	
	; MsgBox(0, '���������', _SQLite_Exec(-1, "SELECT name FROM sqlite_master WHERE type='table' AND name='%s'"&$sNameTable)=$SQLITE_OK, 0, $hGui)
	; MsgBox(0, '���������', _SQLite_Exec(-1, "SELECT name FROM sqlite_master WHERE type='table'"), 0, $hGui)
	; MsgBox(0, '���������',_SQLite_Exec(-1, "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;", "_CallbackRow"), 0, $hGui)
	; MsgBox(0, '���������', _SQLite_Exec(-1, "SHOW TABLES FROM "&$name&" LIKE "&$sNameTable)=$SQLITE_OK, 0, $hGui)
EndFunc   ;==>_Test_sql

Func _GetColum_sql() ; �������� ����� �������
	Local $hQuery, $aNames
	_SQLite_Query(-1, "SELECT ROWID,* FROM '" & $sNameTable & "' ORDER BY " & $ID1, $hQuery)
	_SQLite_FetchNames($hQuery, $aNames)
	MsgBox(0, '���������', StringFormat(" %-10s  %-10s  %-10s  %-10s ", $aNames[0], $aNames[1], $aNames[2], $aNames[3]), 0, $hGui)
EndFunc   ;==>_GetColum_sql

Func _SelectItem_sql($a) ; �������� ������� ����� ����
	If _SQLite_QuerySingleRow(-1, "SELECT * FROM '" & $sNameTable & "' WHERE " & GUICtrlRead($Combo) & " = '" & $a & "';", $aRow) <> $SQLITE_OK Then
		_err('������ � ������ ������� �����������')
		Return SetError(1)
	EndIf
	If $aRow[0] = '' Then
		_err('������ � ������ ������� �����������')
	Else
		GUICtrlSetData($ID1_Input1, $aRow[0])
		GUICtrlSetData($ID1_Input2, $aRow[1])
		GUICtrlSetData($ID1_Input3, $aRow[2])
		GUICtrlSetData($StatusBar, '������ ���� ���������')
	EndIf
EndFunc   ;==>_SelectItem_sql

Func _DeleteItem_sql() ; ������� ������� ����� ����
	If _SQLite_Exec(-1, "DELETE FROM '" & $sNameTable & "' WHERE " & GUICtrlRead($Combo) & " = '" & GUICtrlRead($GUI_Input5) & "';") <> $SQLITE_OK Then
		_err('������ � ������ ������� �����������')
	Else
		GUICtrlSetData($StatusBar, '������ ���� �������')
	EndIf
EndFunc   ;==>_DeleteItem_sql

Func _err($tx)
	GUICtrlSetData($StatusBar, $tx)
	For $i = 1 To 4
		GUICtrlSetColor($StatusBar, 0xffffff)
		Sleep(40)
		GUICtrlSetColor($StatusBar, -1)
		Sleep(40)
	Next
EndFunc   ;==>_err