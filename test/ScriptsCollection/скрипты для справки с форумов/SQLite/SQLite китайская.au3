#NoTrayIcon
#include <GUIListBox.au3>
#include <GuiListView.au3>
#include <SQLite.au3>
;#include <SQLite.dll.au3>
Opt("GUICloseOnESC", 1) ; выход по ESC
;Global $GUI_ListBox
;Global $GUI_Input1, $GUI_Input2, $GUI_Input3, $GUI_Input4, $GUI_Input5
;Global $Open, $Insert, $Select, $Delete
Global $Msg, $hQuery, $aRow
Global $Temp, $a, $b, $c
$SQLite_Data_Path = "SQLite.db"
_SQLite_Startup() ; загрузка SQLite.dll в память (2мб)
$GUI_Form = GUICreate("SQLite пример", 320, 460)
GUISetBkColor(0xECE9D8) ; цвет фона программы
$GUI_ListBox = GUICtrlCreateListView("", 2, 2, 316, 309, 0x0010)
_GUICtrlListView_AddColumn($GUI_ListBox, "№ Add", 80, 0)
_GUICtrlListView_AddColumn($GUI_ListBox, "№ Del, Sel", 100, 1)
_GUICtrlListView_AddColumn($GUI_ListBox, "Данные", 120, 1)
GUICtrlCreateLabel("Добавляем эти данные в базу", 44, 352, 210, 15)
$GUI_Input1 = GUICtrlCreateInput("", 10, 368, 73, 20)
$GUI_Input2 = GUICtrlCreateInput("", 88, 368, 73, 20)
$GUI_Input3 = GUICtrlCreateInput("", 166, 368, 73, 20)
$GUI_Input4 = GUICtrlCreateInput("", 88, 393, 73, 20)
$GUI_Input5 = GUICtrlCreateInput("", 88, 418, 73, 20)
$Create = GUICtrlCreateButton("Создать", 246, 317, 68, 22, 0)
GUICtrlSetTip(-1, 'Создать пустую базу в файле')
$Open = GUICtrlCreateButton("Открыть", 246, 342, 68, 22, 0)
GUICtrlSetTip(-1, 'Открыть базу из файла')
$Insert = GUICtrlCreateButton("Добавить", 246, 367, 68, 22, 0)
GUICtrlSetTip(-1, 'Добавляем элемент')
$Select = GUICtrlCreateButton("Выделить", 246, 392, 68, 22, 0)
GUICtrlSetTip(-1, 'Выбираем элемент')
$Delete = GUICtrlCreateButton("Удалить", 246, 417, 68, 22, 0)
GUICtrlSetTip(-1, 'Удаляем элемент по второй колонке')
GUICtrlCreateGroup("", 2, 307, 316, 134)
GUICtrlCreateLabel("здесь была база данных SQL", 72, 446, 240, 15)
GUICtrlSetState(-1, $GUI_DISABLE)
GUISetState()

While 1
	$Msg = GUIGetMsg()
	Select
		Case $Msg = $Create ; читаем базу из файла
			$SQLite_Data_Path = FileSaveDialog("Выбор файла сохранения", @ScriptDir & "", "файл база (*.db)", 24, 'SQLite.db')
			If @error Then ContinueLoop
			If Not FileExists($SQLite_Data_Path) Then CreateSQL($SQLite_Data_Path) ; если не существует базы создаём её.
		Case $Msg = $Open ; читаем базу из файла
			$SQLite_Data_Path = FileOpenDialog("Выбрать файл", @WorkingDir & "", "Все файлы (*.*)", 1 + 4)
			ReadSQL()
		Case $Msg = $Insert
			Insert(GUICtrlRead($GUI_Input1), GUICtrlRead($GUI_Input2), GUICtrlRead($GUI_Input3)) ; добавляем элемент
			ReadSQL()
		Case $Msg = $Select ; выбираем элемент
			SelectItemSQL(GUICtrlRead($GUI_Input4))
		Case $Msg = $Delete ; удаляем элемент
			DeleteItemSQL(GUICtrlRead($GUI_Input5))
			ReadSQL()
		Case $Msg = -3 ; выход
			_SQLite_Shutdown() ; вызрузка SQLite.dll
			ExitLoop
	EndSelect

WEnd

Func CreateSQL($SQLite_Path) ; функция создания файла базы
	_SQLite_Open($SQLite_Path)
	_SQLite_Exec(-1, "Create Table IF NOT Exists TestTable (IDs Text PRIMARY KEY, Name Text, Age Text);")
	_SQLite_Close()
EndFunc

Func ReadSQL() ; функция чтения данных файла базы
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

Func Insert($a, $b, $c) ; функция добавления элементов в файл базы
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

Func SelectItemSQL($a) ; функция выбора элемента файла базы
	_SQLite_Open($SQLite_Data_Path)
	_SQLite_QuerySingleRow(-1, "SELECT * FROM TestTable WHERE Name = '" & $a & "';", $aRow)
	$Temp = $aRow[0]
	If $Temp = "" Then
		MsgBox(262208, "Сообщение...", "Нет таких данных [" & $a & "] блин!")
	Else
		_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($GUI_ListBox))
		_GUICtrlListView_AddItem($GUI_ListBox, $aRow[0])
		_GUICtrlListView_AddSubItem($GUI_ListBox, _GUICtrlListView_FindInText($GUI_ListBox, $aRow[0]), $aRow[1], 1)
		_GUICtrlListView_AddSubItem($GUI_ListBox, _GUICtrlListView_FindInText($GUI_ListBox, $aRow[0]), $aRow[2], 2)
		MsgBox(262208, "Сообщение...", "Оставлено: 1=[" & $aRow[0] & "] 2=[" & $aRow[1] & "] 3=[" & $aRow[2] & "] !")
	EndIf
	_SQLite_Close()
EndFunc

Func DeleteItemSQL($a) ; функция удаления элемента файла базы
	_SQLite_Open($SQLite_Data_Path)
	_SQLite_Exec(-1, "DELETE FROM TestTable WHERE Name = '" & $a & "';")
	_SQLite_Close()
	MsgBox(262208, "Сообщение...", "Удаляем ячейку [" & $a & "] и обновляем данные в списке.")
EndFunc