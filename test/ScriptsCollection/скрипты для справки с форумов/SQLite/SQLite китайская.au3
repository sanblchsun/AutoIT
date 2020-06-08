#NoTrayIcon
#include <GUIListBox.au3>
#include <GuiListView.au3>
#include <SQLite.au3>
;#include <SQLite.dll.au3>
Opt("GUICloseOnESC", 1) ; ����� �� ESC
;Global $GUI_ListBox
;Global $GUI_Input1, $GUI_Input2, $GUI_Input3, $GUI_Input4, $GUI_Input5
;Global $Open, $Insert, $Select, $Delete
Global $Msg, $hQuery, $aRow
Global $Temp, $a, $b, $c
$SQLite_Data_Path = "SQLite.db"
_SQLite_Startup() ; �������� SQLite.dll � ������ (2��)
$GUI_Form = GUICreate("SQLite ������", 320, 460)
GUISetBkColor(0xECE9D8) ; ���� ���� ���������
$GUI_ListBox = GUICtrlCreateListView("", 2, 2, 316, 309, 0x0010)
_GUICtrlListView_AddColumn($GUI_ListBox, "� Add", 80, 0)
_GUICtrlListView_AddColumn($GUI_ListBox, "� Del, Sel", 100, 1)
_GUICtrlListView_AddColumn($GUI_ListBox, "������", 120, 1)
GUICtrlCreateLabel("��������� ��� ������ � ����", 44, 352, 210, 15)
$GUI_Input1 = GUICtrlCreateInput("", 10, 368, 73, 20)
$GUI_Input2 = GUICtrlCreateInput("", 88, 368, 73, 20)
$GUI_Input3 = GUICtrlCreateInput("", 166, 368, 73, 20)
$GUI_Input4 = GUICtrlCreateInput("", 88, 393, 73, 20)
$GUI_Input5 = GUICtrlCreateInput("", 88, 418, 73, 20)
$Create = GUICtrlCreateButton("�������", 246, 317, 68, 22, 0)
GUICtrlSetTip(-1, '������� ������ ���� � �����')
$Open = GUICtrlCreateButton("�������", 246, 342, 68, 22, 0)
GUICtrlSetTip(-1, '������� ���� �� �����')
$Insert = GUICtrlCreateButton("��������", 246, 367, 68, 22, 0)
GUICtrlSetTip(-1, '��������� �������')
$Select = GUICtrlCreateButton("��������", 246, 392, 68, 22, 0)
GUICtrlSetTip(-1, '�������� �������')
$Delete = GUICtrlCreateButton("�������", 246, 417, 68, 22, 0)
GUICtrlSetTip(-1, '������� ������� �� ������ �������')
GUICtrlCreateGroup("", 2, 307, 316, 134)
GUICtrlCreateLabel("����� ���� ���� ������ SQL", 72, 446, 240, 15)
GUICtrlSetState(-1, $GUI_DISABLE)
GUISetState()

While 1
	$Msg = GUIGetMsg()
	Select
		Case $Msg = $Create ; ������ ���� �� �����
			$SQLite_Data_Path = FileSaveDialog("����� ����� ����������", @ScriptDir & "", "���� ���� (*.db)", 24, 'SQLite.db')
			If @error Then ContinueLoop
			If Not FileExists($SQLite_Data_Path) Then CreateSQL($SQLite_Data_Path) ; ���� �� ���������� ���� ������ �.
		Case $Msg = $Open ; ������ ���� �� �����
			$SQLite_Data_Path = FileOpenDialog("������� ����", @WorkingDir & "", "��� ����� (*.*)", 1 + 4)
			ReadSQL()
		Case $Msg = $Insert
			Insert(GUICtrlRead($GUI_Input1), GUICtrlRead($GUI_Input2), GUICtrlRead($GUI_Input3)) ; ��������� �������
			ReadSQL()
		Case $Msg = $Select ; �������� �������
			SelectItemSQL(GUICtrlRead($GUI_Input4))
		Case $Msg = $Delete ; ������� �������
			DeleteItemSQL(GUICtrlRead($GUI_Input5))
			ReadSQL()
		Case $Msg = -3 ; �����
			_SQLite_Shutdown() ; �������� SQLite.dll
			ExitLoop
	EndSelect

WEnd

Func CreateSQL($SQLite_Path) ; ������� �������� ����� ����
	_SQLite_Open($SQLite_Path)
	_SQLite_Exec(-1, "Create Table IF NOT Exists TestTable (IDs Text PRIMARY KEY, Name Text, Age Text);")
	_SQLite_Close()
EndFunc

Func ReadSQL() ; ������� ������ ������ ����� ����
	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($GUI_ListBox))
	_SQLite_Open($SQLite_Data_Path)
	_SQLite_Query(-1, "SELECT * FROM TestTable ORDER BY IDs DESC;", $hQuery)
	While _SQLite_FetchData($hQuery, $aRow) = $SQLITE_OK
		_GUICtrlListView_AddItem($GUI_ListBox, $aRow[0])
		_GUICtrlListView_AddSubItem($GUI_ListBox, _GUICtrlListView_FindInText($GUI_ListBox, $aRow[0]), $aRow[1], 1)
		_GUICtrlListView_AddSubItem($GUI_ListBox, _GUICtrlListView_FindInText($GUI_ListBox, $aRow[0]), $aRow[2], 2)
	WEnd
	_SQLite_Close()
EndFunc

Func Insert($a, $b, $c) ; ������� ���������� ��������� � ���� ����
	_SQLite_Open($SQLite_Data_Path)
	_SQLite_QuerySingleRow(-1, "SELECT IDs FROM TestTable WHERE IDs = '" & $a & "';", $aRow)
	$Temp = $aRow[0]
	If $Temp = "" Then
		_SQLite_Exec(-1, "Insert into TestTable (IDs) values ('" & $a & "');")
	EndIf
	_SQLite_Exec(-1, "UPDATE TestTable SET Name = '" & $b & "' WHERE IDs = '" & $a & "';")
	_SQLite_Exec(-1, "UPDATE TestTable SET Age = '" & $c & "' WHERE IDs = '" & $a & "';")
	_SQLite_Close()
EndFunc

Func SelectItemSQL($a) ; ������� ������ �������� ����� ����
	_SQLite_Open($SQLite_Data_Path)
	_SQLite_QuerySingleRow(-1, "SELECT * FROM TestTable WHERE Name = '" & $a & "';", $aRow)
	$Temp = $aRow[0]
	If $Temp = "" Then
		MsgBox(262208, "���������...", "��� ����� ������ [" & $a & "] ����!")
	Else
		_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($GUI_ListBox))
		_GUICtrlListView_AddItem($GUI_ListBox, $aRow[0])
		_GUICtrlListView_AddSubItem($GUI_ListBox, _GUICtrlListView_FindInText($GUI_ListBox, $aRow[0]), $aRow[1], 1)
		_GUICtrlListView_AddSubItem($GUI_ListBox, _GUICtrlListView_FindInText($GUI_ListBox, $aRow[0]), $aRow[2], 2)
		MsgBox(262208, "���������...", "���������: 1=[" & $aRow[0] & "] 2=[" & $aRow[1] & "] 3=[" & $aRow[2] & "] !")
	EndIf
	_SQLite_Close()
EndFunc

Func DeleteItemSQL($a) ; ������� �������� �������� ����� ����
	_SQLite_Open($SQLite_Data_Path)
	_SQLite_Exec(-1, "DELETE FROM TestTable WHERE Name = '" & $a & "';")
	_SQLite_Close()
	MsgBox(262208, "���������...", "������� ������ [" & $a & "] � ��������� ������ � ������.")
EndFunc