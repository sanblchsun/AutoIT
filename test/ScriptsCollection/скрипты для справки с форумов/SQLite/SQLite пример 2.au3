#NoTrayIcon
#include <GUIListBox.au3>
#include <GuiListView.au3>
#include <SQLite.au3>
;#include <SQLite.dll.au3>
Opt("GUICloseOnESC", 1) ; ����� �� ESC
Global $Msg, $hQuery, $aRow
Global $a, $b, $c

; ��� ������� � �����
Global $NameTable='TestTable', $ID1='ID1', $ID2='ID2', $ID3='ID3'

$SQLite_Data_Path = "SQLite.db"
_SQLite_Startup() ; �������� SQLite.dll � ������ (2��)
$Gui = GUICreate("SQLite ������", 340, 460)
GUISetBkColor(0xECE9D8) ; ���� ���� ���������
$GUI_ListView = GUICtrlCreateListView('', 2, 2, 336, 309, 0x0010)
_GUICtrlListView_AddColumn($GUI_ListView, $ID1, 107, 0)
_GUICtrlListView_AddColumn($GUI_ListView, $ID2, 107, 0)
_GUICtrlListView_AddColumn($GUI_ListView, $ID3, 107, 0)
GUICtrlCreateLabel("��������� ��� ������ � ����", 44, 352, 210, 15)
$GUI_Input1 = GUICtrlCreateInput("", 10, 368, 73, 23)
$GUI_Input2 = GUICtrlCreateInput("", 88, 368, 73, 23)
$GUI_Input3 = GUICtrlCreateInput("", 166, 368, 73, 23)
$GUI_Input5 = GUICtrlCreateInput("", 88, 400, 73, 23)
$Combo = GUICtrlCreateCombo('', 10, 400, 73, 23, 0x3)
GUICtrlSetData($Combo,$ID1&'|'&$ID2&'|'&$ID3, $ID1)
$Create = GUICtrlCreateButton("�������������", 96, 317, 88, 23)
GUICtrlSetTip(-1, '������������� �������� ����')
$Open = GUICtrlCreateButton("�������", 196, 317, 73, 23)
GUICtrlSetTip(-1, '������� ��� ������� ���� �� �����')
$Insert = GUICtrlCreateButton("��������", 246, 368, 73, 23)
GUICtrlSetTip(-1, '��������� �������')
$Select = GUICtrlCreateButton("���������", 166, 400, 73, 23)
GUICtrlSetTip(-1, '��������� ������� �� ����')
$Delete = GUICtrlCreateButton("�������", 246, 400, 73, 23)
GUICtrlSetTip(-1, '������� ������� �� ������ �������')
; GUICtrlCreateGroup("", 2, 307, 336, 134)
$StatusBar=GUICtrlCreateLabel("������ ���������", 5, 444, 335, 15)
GUISetState()

While 1
	$Msg = GUIGetMsg()
	Switch $Msg
		Case $Create
			If Not FileExists($SQLite_Data_Path) Then
				_Open()
				If @error Then ContinueLoop
			EndIf
			Insert('1', '2', '3') ; ��������� �������
			Insert('�����', 8, 9)
			Insert('567', 'sad', 'zag')
			Insert('23', 'dfajhk', 'ertert')
			Insert('wert', '4325', '15')
			Insert('������', '�������', '�����')
			Insert('�;:?*', '������', 'Yes')
			ReadSQL()
		Case $Open ; ������ ���� �� �����
			_Open()
		Case $Insert
			Insert(GUICtrlRead($GUI_Input1), GUICtrlRead($GUI_Input2), GUICtrlRead($GUI_Input3)) ; ��������� �������
			ReadSQL()
		Case $Select ; �������� �������
			SelectItemSQL(GUICtrlRead($GUI_Input5))
		Case $Delete ; ������� �������
			DeleteItemSQL()
			ReadSQL()
		Case -3 ; �����
			_SQLite_Shutdown() ; �������� SQLite.dll
			ExitLoop
	EndSwitch

WEnd

Func _Open() ; ������� �������� / �������� ����� ����
	$SQLite_Data_Path = FileOpenDialog("������� ����", @WorkingDir, "��� ����� (*.db)", 24, 'SQLite.db', $Gui)
	If @error Then Return SetError(1)
	If FileGetSize($SQLite_Data_Path)=0 Then ; ���� ������ ����� ���� ����� ���� �� ������ �, ����� ������ ������.
		CreateSQL($SQLite_Data_Path)
	Else
		ReadSQL()
	EndIf
	GUICtrlSetData($StatusBar, '������ ���� ���� '&StringRegExpReplace($SQLite_Data_Path, '(^.*)\\(.*)$', '\2'))
EndFunc

Func CreateSQL($SQLite_Path) ; ������� �������� ����� ����
	_SQLite_Open($SQLite_Path)
	_SQLite_Exec(-1, "Create Table IF NOT Exists "&$NameTable&" ("&$ID1&", "&$ID2&", "&$ID3&");")
	_SQLite_Close()
EndFunc

Func ReadSQL() ; ������� ������ ������ ����� ����
	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($GUI_ListView))
	_SQLite_Open($SQLite_Data_Path)
	If _SQLite_Query(-1, "SELECT * FROM "&$NameTable&" ORDER BY "&$ID1&" DESC;", $hQuery)<>$SQLITE_OK Then
		_err('����������� �������')
		Return SetError(1)
	EndIf
	While _SQLite_FetchData($hQuery, $aRow) = $SQLITE_OK
		_GUICtrlListView_AddItem($GUI_ListView, $aRow[0])
		_GUICtrlListView_AddSubItem($GUI_ListView, _GUICtrlListView_FindInText($GUI_ListView, $aRow[0]), $aRow[1], 1)
		_GUICtrlListView_AddSubItem($GUI_ListView, _GUICtrlListView_FindInText($GUI_ListView, $aRow[0]), $aRow[2], 2)
	WEnd
	_SQLite_Close()
EndFunc

Func Insert($a, $b, $c) ; ������� ���������� ��������� � ���� ����
	_SQLite_Open($SQLite_Data_Path)
	_SQLite_QuerySingleRow(-1, "SELECT "&$ID1&" FROM "&$NameTable&" WHERE "&$ID1&" = '" & $a & "';", $aRow)
	If $aRow[0] = '' Then _SQLite_Exec(-1, "Insert into "&$NameTable&" ("&$ID1&") values ('" & $a & "');")
	_SQLite_Exec(-1, "UPDATE "&$NameTable&" SET "&$ID2&" = '" & $b & "' WHERE "&$ID1&" = '" & $a & "';")
	_SQLite_Exec(-1, "UPDATE "&$NameTable&" SET "&$ID3&" = '" & $c & "' WHERE "&$ID1&" = '" & $a & "';")
	_SQLite_Close()
EndFunc

Func SelectItemSQL($a) ; ������� ������ �������� ����� ����
	_SQLite_Open($SQLite_Data_Path)
	If _SQLite_QuerySingleRow(-1, "SELECT * FROM "&$NameTable&" WHERE "&GUICtrlRead($Combo)&" = '" & $a & "';", $aRow)<>$SQLITE_OK Then
		_err('������ � ������ ������� �����������')
		Return SetError(1)
	EndIf
	If $aRow[0] = '' Then
		; MsgBox(262208, "���������...", "������ � ������ ������� �����������")
		_err('������ � ������ ������� �����������')
	Else
		GUICtrlSetData($GUI_Input1, $aRow[0])
		GUICtrlSetData($GUI_Input2, $aRow[1])
		GUICtrlSetData($GUI_Input3, $aRow[2])
		GUICtrlSetData($StatusBar, '������ ���� ���������')
	EndIf
	_SQLite_Close()
EndFunc

Func DeleteItemSQL() ; ������� �������� �������� ����� ����
	_SQLite_Open($SQLite_Data_Path)
	If _SQLite_Exec(-1, "DELETE FROM "&$NameTable&" WHERE "&GUICtrlRead($Combo)&" = '"&GUICtrlRead($GUI_Input5)& "';")<>$SQLITE_OK Then
		_err('������ � ������ ������� �����������')
	Else
		GUICtrlSetData($StatusBar, '������ ���� �������')
	EndIf
	_SQLite_Close()
EndFunc

Func _err($tx)
	GUICtrlSetData($StatusBar, $tx)
	For $i = 1 to 4
		GUICtrlSetColor ($StatusBar, 0xffffff)
		Sleep(40)
		GUICtrlSetColor ($StatusBar, -1)
		Sleep(40)
	Next
EndFunc