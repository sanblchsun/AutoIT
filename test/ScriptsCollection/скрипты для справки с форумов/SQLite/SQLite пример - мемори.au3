#NoTrayIcon
; #include <GUIListBox.au3>
#include <GuiListView.au3>
#include <SQLite.au3>
;#include <SQLite.dll.au3>
Opt("GUICloseOnESC", 1) ; ����� �� ESC
Global $Msg, $hQuery, $aRow
Global $a, $b, $c, $TypeID1='Text'

; ��� ������� � �����
Global $NameTable='TestTable', $ID1='ID1', $ID2='ID2', $ID3='ID3'

; $SQLite_Data_Path = ":memory:"
_SQLite_Startup() ; �������� SQLite.dll � ������ (2��)
_SQLite_Open()
$Gui = GUICreate("SQLite ������", 340, 475)
GUISetBkColor(0xECE9D8) ; ���� ���� ���������
$StatusBar=GUICtrlCreateLabel("������ ���������", 5, 459, 335, 15)
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


$Type = GUICtrlCreateCheckbox('Type', 10, 317, 73, 23)

$Generate = GUICtrlCreateButton("�������������", 96, 317, 88, 23)
GUICtrlSetTip(-1, '������������� �������� ����')
$Open = GUICtrlCreateButton("�������", 196, 317, 73, 23)
GUICtrlSetTip(-1, '������� ��� ������� ����')
$Insert = GUICtrlCreateButton("��������", 246, 368, 73, 23)
GUICtrlSetTip(-1, '��������� �������')
$Select = GUICtrlCreateButton("���������", 166, 400, 73, 23)
GUICtrlSetTip(-1, '��������� ������� �� ����')
$Delete = GUICtrlCreateButton("�������", 246, 400, 73, 23)
GUICtrlSetTip(-1, '������� ������� �� ������ �������')

$Create = GUICtrlCreateButton("�������", 246, 432, 73, 23, 0)
GUICtrlSetTip(-1, '������� / ������� ������ ����')
$GUI_Input6 = GUICtrlCreateInput("", 88, 432, 73, 23)

$TableGet = GUICtrlCreateButton("TableGet", 166, 432, 73, 23, 0)

; GUICtrlCreateGroup("", 2, 307, 336, 134)
GUISetState()

While 1
	$Msg = GUIGetMsg()
	Switch $Msg
		Case $Type
			If GUICtrlRead($Type)=1 Then
				$TypeID1='INTEGER PRIMARY KEY'
			Else
				$TypeID1='Text'
			EndIf
		Case $TableGet
			TableGetSQL()
		Case $Create
			$tmp=GUICtrlRead($GUI_Input6)
			If $tmp Or Not StringRegExp($tmp, '\d', 0) Then
				$NameTable=$tmp
			Else
				GUICtrlSetData($StatusBar, '������� ��� �������')
				ContinueLoop
			EndIf
			CreateSQL()
			ReadSQL()
		Case $Generate
			CreateSQL()
			Insert('1', '2', '3') ; ��������� �������
			Insert('�����', 8, 9)
			Insert('567', 'sad', 'zag')
			Insert('23', 'dfajhk', 'ertert')
			Insert('wert', '4325', '15')
			Insert('������', '�������', '�����')
			Insert('�;:?*', '������', 'Yes')
			ReadSQL()
		Case $Open ; ������ ���� �� �����
			CreateSQL()
		Case $Insert
			Insert(GUICtrlRead($GUI_Input1), GUICtrlRead($GUI_Input2), GUICtrlRead($GUI_Input3)) ; ��������� �������
			ReadSQL()
		Case $Select ; �������� �������
			SelectItemSQL(GUICtrlRead($GUI_Input5))
		Case $Delete ; ������� �������
			DeleteItemSQL()
			ReadSQL()
		Case -3 ; �����
			_SQLite_Close()
			_SQLite_Shutdown() ; �������� SQLite.dll
			ExitLoop
	EndSwitch

WEnd

Func CreateSQL() ; ������� �������� ����� ����
	_SQLite_Exec(-1, "Create Table IF NOT Exists "&$NameTable&" ("&$ID1&" "&$TypeID1&", "&$ID2&" Text, "&$ID3&" Text);")
EndFunc

Func ReadSQL() ; ������� ������ ������ ����� ����
	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($GUI_ListView))
	If _SQLite_Query(-1, "SELECT * FROM "&$NameTable&" ORDER BY "&$ID1&" ASC;", $hQuery)<>$SQLITE_OK Then
		_err('����������� �������')
		Return SetError(1)
	EndIf
	While _SQLite_FetchData($hQuery, $aRow) = $SQLITE_OK
		_GUICtrlListView_AddItem($GUI_ListView, $aRow[0])
		_GUICtrlListView_AddSubItem($GUI_ListView, _GUICtrlListView_FindInText($GUI_ListView, $aRow[0]), $aRow[1], 1)
		_GUICtrlListView_AddSubItem($GUI_ListView, _GUICtrlListView_FindInText($GUI_ListView, $aRow[0]), $aRow[2], 2)
	WEnd
EndFunc

Func Insert($a, $b, $c) ; ������� ���������� ��������� � ���� ����
	_SQLite_QuerySingleRow(-1, "SELECT "&$ID1&" FROM "&$NameTable&" WHERE "&$ID1&" = '" & $a & "';", $aRow)
	If $aRow[0] = '' Then _SQLite_Exec(-1, "Insert into "&$NameTable&" ("&$ID1&") values ('" & $a & "');")
	_SQLite_Exec(-1, "UPDATE "&$NameTable&" SET "&$ID2&" = '" & $b & "' WHERE "&$ID1&" = '" & $a & "';")
	_SQLite_Exec(-1, "UPDATE "&$NameTable&" SET "&$ID3&" = '" & $c & "' WHERE "&$ID1&" = '" & $a & "';")
EndFunc

Func SelectItemSQL($a) ; ������� ������ �������� ����� ����
	If _SQLite_QuerySingleRow(-1, "SELECT * FROM "&$NameTable&" WHERE "&GUICtrlRead($Combo)&" = '" & $a & "';", $aRow)<>$SQLITE_OK Then
		_err('������ � ������ ������� �����������')
		Return SetError(1)
	EndIf
	If $aRow[0] = '' Then
		_err('������ � ������ ������� �����������')
	Else
		GUICtrlSetData($GUI_Input1, $aRow[0])
		GUICtrlSetData($GUI_Input2, $aRow[1])
		GUICtrlSetData($GUI_Input3, $aRow[2])
		GUICtrlSetData($StatusBar, '������ ���� ���������')
	EndIf
EndFunc

Func TableGetSQL() ; �������� ������ ������ ����� ����
	; If _SQLite_QuerySingleRow(-1, "SELECT * FROM sqlite_master WHERE type='table' ORDER BY name;", $aRow)<>$SQLITE_OK Then
	If _SQLite_QuerySingleRow(-1, "SELECT name FROM (SELECT * FROM sqlite_master UNION ALL SELECT * FROM sqlite_temp_master) WHERE type='table' ORDER BY name;", $aRow)<>$SQLITE_OK Then
		_err('������')
		Return SetError(1)
	EndIf
	If $aRow[0] = '' Then
		_err('������� �����������')
	Else
		$itog=''
		For $i = 0 to UBound($aRow)-1
			$itog&=$aRow[$i]&@CRLF
		Next
		MsgBox(0, '���������', $itog)
	EndIf
	; $NameTable='Test'
	; SelectItemSQL('23')
	; Sleep(2000)
	; $NameTable='TestTable'
	; SelectItemSQL('23')
EndFunc

Func DeleteItemSQL() ; ������� �������� �������� ����� ����
	If _SQLite_Exec(-1, "DELETE FROM "&$NameTable&" WHERE "&GUICtrlRead($Combo)&" = '"&GUICtrlRead($GUI_Input5)& "';")<>$SQLITE_OK Then
		_err('������ � ������ ������� �����������')
	Else
		GUICtrlSetData($StatusBar, '������ ���� �������')
	EndIf
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