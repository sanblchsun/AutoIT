; Пример подготовил AZJIO
; http://pastebin.com/v6g3RQig

#include <ButtonConstants.au3>
#include <ListViewConstants.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <Array.au3>
#include <ComboConstants.au3>
#NoTrayIcon

$sHelp = _
		'1. Если пример не запускается, проверте что файл "AutoIt3\Include\SQLite.dll.au3" не пустой (~2 Мб) в бетках может быть пустым.' & @CRLF & _
		'2. При первом запуске жмём "Сгенерировать" - создаётся файл базы и заполняется таблица. В дальнейшем можно "Открыть" файл-базы.' & @CRLF & _
		'3. Можете создавать новые таблицы, введя имя и нажать "Сгенерировать".' & @CRLF & _
		'4. При поиске указывайте имя столбца, в котором искать. Достаточно указать часть текста для поиска' & @CRLF & _
		'5. Для чтения или удаления строки базы указывайте текст ячейки полностью.' & @CRLF & _
		'Ссылки:' & @CRLF & _
		'http://sb-money.ru/sqlite.php?page=21' & @CRLF & _
		'http://sb-money.ru/sqlite.php?page=6' & @CRLF & _
		'FAQ, Здесь в 15 пункте сказано, что вы можете использовать SQLite в коммерческих проектах.'

Global $Msg, $hQuery, $aRow
Global $a, $b, $c
Global $sRes, $mem = 0

; Имя таблицы и ячеек
Global $sNameTable = 'TestTable', $ID1 = '№', $ID2 = 'ФИО', $ID3 = 'Дата'
FileChangeDir(@ScriptDir) ; устанавливает текущий каталог

$SQLite_Data_Path = 'SQLite.db'
_SQLite_Startup() ; загрузка SQLite.dll в память (2мб)
$hGui = GUICreate('SQLite пример', 850, 413)
GUISetBkColor(0xECE9D8) ; цвет фона программы
$StatusBar = GUICtrlCreateLabel('Строка состояния', 480, 413 - 17, 370, 17)
$iListView = GUICtrlCreateListView($ID1 & '|' & $ID2 & '|' & $ID3, 2, 2, 466, 409) ; $LVS_SORTASCENDING

$iMemory = GUICtrlCreateCheckbox('База в памяти', 660, 340, 100, 17)
GUICtrlCreateLabel('Имя таблицы', 487, 371, 70, 23)
$TableCombo = GUICtrlCreateCombo('', 560, 369, 90, 23)
GUICtrlSetTip(-1, 'Все имена таблиц в базе')
$Create = GUICtrlCreateButton('Сгенерировать', 660, 365, 98, 28)
GUICtrlSetTip(-1, 'Сгенерировать тестовую базу')

$Open = GUICtrlCreateButton('Открыть', 770, 365, 67, 28)
GUICtrlSetTip(-1, 'Открыть или создать базу из файла')

GUICtrlCreateGroup('Добавляем эти данные в базу', 487, 10, 350, 100)
GUICtrlCreateLabel($ID1, 500, 37, 40, 23)
GUICtrlCreateLabel($ID2, 500, 58, 40, 23)
GUICtrlCreateLabel($ID3, 500, 83, 40, 23)
$ID1_Input1 = GUICtrlCreateInput('', 540, 30, 200, 23)
$ID1_Input2 = GUICtrlCreateInput('', 540, 55, 200, 23)
$ID1_Input3 = GUICtrlCreateInput('', 540, 80, 200, 23)
$Insert = GUICtrlCreateButton('Добавить' & @LF & 'или' & @LF & 'Изменить', 750, 30, 75, 70, $BS_MULTILINE)
GUICtrlSetTip(-1, 'Добавляем элемент')

GUICtrlCreateGroup('Операция с элементом', 487, 120, 350, 100)
GUICtrlCreateLabel('Имя столбца', 500, 143, 70, 17)
$Combo = GUICtrlCreateCombo('', 570, 140, 90, 23, 0x3)
GUICtrlSetData($Combo, $ID1 & '|' & $ID2 & '|' & $ID3, $ID2)

GUICtrlCreateLabel('Текст поиска', 500, 168, 70, 17)
$GUI_Input5 = GUICtrlCreateInput('', 500, 185, 160, 23)

$Delete = GUICtrlCreateButton('Удалить', 670, 130, 73, 23)
GUICtrlSetTip(-1, 'Удаляем элемент по второй колонке')

$Select = GUICtrlCreateButton('Прочитать', 750, 130, 73, 23)
GUICtrlSetTip(-1, 'Прочитать элемент из базы')

$Find = GUICtrlCreateButton('Поиск одного', 750, 160, 73, 23)
GUICtrlSetTip(-1, 'Поиск одного используя часть текста из базы')

$FindAll = GUICtrlCreateButton('Поиск всех', 750, 190, 73, 23)
GUICtrlSetTip(-1, 'Поиск всех используя часть текста из базы (Exec)')

$FindAll2 = GUICtrlCreateButton('Поиск всех2', 670, 190, 73, 23)
GUICtrlSetTip(-1, 'Пошаговый поиск всех используя часть текста из базы (Query + FetchData)')

; GUICtrlCreateGroup('', 2, 307, 336, 134)

$AllItem = GUICtrlCreateButton('Все пункты', 490, 230, 73, 23)
GUICtrlSetTip(-1, 'Получить все пункты с индексом')
$GetTableToArray2D = GUICtrlCreateButton('в массив', 490, 260, 73, 23)
GUICtrlSetTip(-1, 'Получить все пункты с индексом')

$DelTable = GUICtrlCreateButton('Удалить таблицу', 570, 230, 100, 23)
GUICtrlSetTip(-1, 'Получить все пункты с индексом')

$GetNameTable = GUICtrlCreateButton('Имена таблиц', 570, 260, 100, 23)
GUICtrlSetTip(-1, 'Получить все имена таблиц в базе')

$GetColum = GUICtrlCreateButton('Имена колонок', 570, 290, 100, 23)
GUICtrlSetTip(-1, 'Получить имена колонок в таблице')

$Test = GUICtrlCreateButton('Тест', 490, 290, 73, 23)
GUICtrlSetTip(-1, 'Не используйте кнопку, это для' & @CRLF & 'теста неработающих функций')

$iHelp = GUICtrlCreateButton('?', 770, 260, 23, 23)
GUICtrlSetTip(-1, 'Справка')

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $iHelp
			MsgBox(0, 'Справка', $sHelp, 0, $hGui)
		Case $TableCombo
			$sNameTable = GUICtrlRead($TableCombo)
			_Read_sql()
		Case $GetNameTable
			_GetNameTable()
			MsgBox(0, 'Сообщение', $sRes, 0, $hGui)
		Case $GetColum
			_GetColum_sql()
		Case $DelTable
			_DelTable()
			GUICtrlSetData($StatusBar, 'Таблица удалена, если существовала')
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
			If $mem = 1 Then ; если база в памяти то импортируем 1000 элементов
				_SQLite_Exec(-1, "Create Table IF NOT Exists '" & $sNameTable & "' (" & $ID1 & " int, '" & $ID2 & "' Text, '" & $ID3 & "' Text);")
				$kod = ''
				; Не нужно многократно вызывать  _SQLite_Exec для каждого импорта, достаточно все команды импорта объединить в один запрос, разделяя символом ";"
				; Этот нативный способ является самым быстрым
				For $i = 1 To 3000
					$kod &= "Insert into '" & $sNameTable & "' (" & $ID1 & "," & $ID2 & "," & $ID3 & ") values ('" & $i & "','" & Random(10000, 12000, 1) & "','" & Random(10000, 99999, 1) & "');"
				Next
				_SQLite_Exec(-1, $kod)
			Else ; иначе импортируем небольшую базу
				; Импорт 3000 строк выполняется за 0.27 сек
				_SQLite_Exec(-1, "Create Table IF NOT Exists '" & $sNameTable & "' (" & $ID1 & " int, '" & $ID2 & "' Text, '" & $ID3 & "' Text);")
				$kod = 'BEGIN TRANSACTION;'
				; Не нужно многократно вызывать  _SQLite_Exec для каждого импорта, достаточно все команды импорта объединить в один запрос, разделяя символом ";"
				; Этот нативный способ является самым быстрым
				For $i = 1 To 3000
					$kod &= "Insert into '" & $sNameTable & "' (" & $ID1 & "," & $ID2 & "," & $ID3 & ") values ('" & $i & "','" & Random(10000, 12000, 1) & "','" & Random(10000, 99999, 1) & "');"
				Next
				$kod &= 'COMMIT;'
				_SQLite_Exec(-1, $kod)
				; _Insert_sql('1', 'Гашников Андрей Владимирович', '15.08.2011')
				; _Insert_sql('2', 'Иванов Сергей Генадьевич', '12.11.2005')
				; _Insert_sql('3', 'Петров Константин Григорьевич', '01.12.2011')
				; _Insert_sql('4', 'Проверкин Провер Проверович', '11.09.2001')
				; _Insert_sql('5', 'Иванов Сергей Генадьевич', '22.07.2011')
				; _Insert_sql('6', 'Фамилия Имя Отчество', '18.10.2007')
				; _Insert_sql('7', 'Чебурашкин Андрей Владимирович', '02.01.2012')
				; _Insert_sql('8', 'Калмыков Александр Владимирович', '30.08.2011')
				; _Insert_sql('9', 'Комстромской Андрей Владимирович', '22.01.2008')
				; _Insert_sql('10', 'Фадеев Михаил Юрьевич', '14.05.2009')
			EndIf
			GUICtrlSetData($StatusBar, 'Строки импортированы')
			_Read_sql()
			; обновляем комбо после генерации таблицы
			_UpdateCombo($sNameTable)
		Case $Open ; читаем базу из файла
			_SQLite_Close()
			_Open_sql()
		Case $Insert
			_Insert_sql(GUICtrlRead($ID1_Input1), GUICtrlRead($ID1_Input2), GUICtrlRead($ID1_Input3)) ; добавляем элемент
			_Read_sql()
		Case $Select ; выбираем элемент
			_SelectItem_sql(GUICtrlRead($GUI_Input5))
		Case $Find ; поиск текста
			_FindFirst_sql()
		Case $FindAll ; поиск всех вхождений (Exec)
			_FindAll_sql()
		Case $FindAll2 ; поиск всех вхождений (Query + FetchData)
			_FindAll_sql2()
		Case $Delete ; удаляем элемент
			_DeleteItem_sql()
			_Read_sql()
		Case -3 ; выход
			_SQLite_Shutdown() ; вызрузка SQLite.dll
			ExitLoop
	EndSwitch
WEnd

Func _UpdateCombo($flag = 0)
	GUICtrlSendMsg($TableCombo, $CB_RESETCONTENT, 0, 0) ; очистить список
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

Func _Open_sql() ; функция открытия / создания файла базы
	$SQLite_Data_Path = FileOpenDialog("Выбрать файл", @WorkingDir, "Все файлы (*.db)", 24, 'SQLite.db', $hGui)
	If @error Then Return SetError(1)
	_SQLite_Open($SQLite_Data_Path)
	If FileGetSize($SQLite_Data_Path) = 0 Then ; если размер файла базы равен нулю то создаём её, иначе читаем данные.
		$sNameTable = GUICtrlRead($TableCombo)
		If $sNameTable = '' Then $sNameTable = 'TestTable'
		_Create_sql()
	Else
		_UpdateCombo()
		_Read_sql()
	EndIf
	GUICtrlSetData($StatusBar, 'Открыт файл базы ' & StringRegExpReplace($SQLite_Data_Path, '(^.*)\\(.*)$', '\2'))
EndFunc   ;==>_Open_sql

Func _Create_sql() ; функция создания файла базы
	; _SQLite_Exec(-1, "Create Table IF NOT Exists '" & $sNameTable & "' (" & $ID1 & ", " & $ID2 & ", '" & $ID3 & "');")
	; Если не существует таблица, то создаём с 3-мя колонками (полями) ID, в формате int (числовой) и Text (текстовый).
	; Обрамление '' позволяет использовать пробелы в именах таблиц и колонок
	_SQLite_Exec(-1, "Create Table IF NOT Exists '" & $sNameTable & "' (" & $ID1 & " int, '" & $ID2 & "' Text, '" & $ID3 & "' Text);")
EndFunc   ;==>_Create_sql

Func _Read_sql() ; функция чтения данных файла базы
	GUICtrlSendMsg($iListView, $LVM_DELETEALLITEMS, 0, 0)
	; If _SQLite_Query(-1, "SELECT * FROM '" & $sNameTable & "' ORDER BY " & $ID1 & " DESC;", $hQuery) <> $SQLITE_OK Then
	; ORDER BY - сортировка, DESC - обратная сортировка
	If _SQLite_Query(-1, "SELECT * FROM '" & $sNameTable & "' ORDER BY " & $ID1 & ";", $hQuery) <> $SQLITE_OK Then
		_err('Отсутствует таблица')
		Return SetError(1)
	EndIf
	; _SQLite_Query подготавливает запрос для _SQLite_FetchData
	While _SQLite_FetchData($hQuery, $aRow) = $SQLITE_OK
		GUICtrlCreateListViewItem($aRow[0] & '|' & $aRow[1] & '|' & $aRow[2], $iListView)
	WEnd
	For $i = 0 To 2 ; Выравнивание столбцов ListView по ширине текста
		GUICtrlSendMsg($iListView, $LVM_SETCOLUMNWIDTH, $i, -1)
		GUICtrlSendMsg($iListView, $LVM_SETCOLUMNWIDTH, $i, -2)
	Next
EndFunc   ;==>_Read_sql

; Быстрый Insert, для генерации, без проверкии существования ID, так как они изначально уникальные
Func _InsertFast_sql($a, $b, $c) ; функция добавления элементов в файл базы
	_SQLite_Exec(-1, "Insert into '" & $sNameTable & "' (" & $ID1 & "," & $ID2 & "," & $ID3 & ") values ('" & $a & "','" & $b & "','" & $c & "');")
EndFunc   ;==>_InsertFast_sql

Func _Insert_sql($a, $b, $c) ; функция добавления элементов в файл базы
	; если таблицы нет, то создаётся. Защита от ошибки вставки в несуществующую таблицу
	_SQLite_Exec(-1, "Create Table IF NOT Exists '" & $sNameTable & "' (" & $ID1 & " int, '" & $ID2 & "' Text, '" & $ID3 & "' Text);")
	; Запрос строки таблицы с отправкой результата в $aRow
	_SQLite_QuerySingleRow(-1, "SELECT " & $ID1 & " FROM '" & $sNameTable & "' WHERE " & $ID1 & " = '" & $a & "';", $aRow)
	; If _SQLite_QuerySingleRow(-1, "SELECT " & $ID1 & " FROM '" & $sNameTable & "' WHERE " & $ID1 & " = '" & $a & "';", $aRow)=$SQLITE_OK Then
	If $aRow[0] = '' Then ; Если ID не существует, то создаём
		; _SQLite_Exec(-1, "Insert into '" & $sNameTable & "' (" & $ID1 & ") values ('" & $a & "');")
		_SQLite_Exec(-1, "Insert into '" & $sNameTable & "' (" & $ID1 & "," & $ID2 & "," & $ID3 & ") values ('" & $a & "','" & $b & "','" & $c & "');")
		GUICtrlSetData($StatusBar, 'Строка создана')
	Else ; иначе изменяем существующую
		; Вставляем два значения
		_SQLite_Exec(-1, "UPDATE '" & $sNameTable & "' SET " & $ID2 & " = '" & $b & "' WHERE " & $ID1 & " = '" & $a & "';")
		_SQLite_Exec(-1, "UPDATE '" & $sNameTable & "' SET '" & $ID3 & "' = '" & $c & "' WHERE " & $ID1 & " = '" & $a & "';")
		GUICtrlSetData($StatusBar, 'Строка изменена')
	EndIf
EndFunc   ;==>_Insert_sql

Func _FindFirst_sql() ; поиск в базе первой строки удовлетворяющей условию
	_SQLite_QuerySingleRow(-1, "SELECT * FROM '" & $sNameTable & "' WHERE " & GUICtrlRead($Combo) & " LIKE '%" & GUICtrlRead($GUI_Input5) & "%';", $aRow)
	If $aRow[0] = '' Then
		_err('Ячейка с такими данными отсутствует')
	Else
		GUICtrlSetData($ID1_Input1, $aRow[0])
		GUICtrlSetData($ID1_Input2, $aRow[1])
		GUICtrlSetData($ID1_Input3, $aRow[2])
		GUICtrlSetData($StatusBar, 'Ячейка базы найдена')
	EndIf
EndFunc   ;==>_FindFirst_sql

; Запрос поиска с помощью Exec выполняет сразу весь поиск и при 10000 элементов базы возникает заметная задержка вывода данных.
Func _FindAll_sql() ; поиск всех в базе
	$sRes = ''
	; * указывает выводить в результаты всей строки (id из каждой колонки). Если указать id, то той колонки и будет выводится ячейка
	; Функция обратного вызова _CallbackRow позволяет присоединить в результат все найденные строки
	$timer = TimerInit()
	_SQLite_Exec(-1, "SELECT * FROM '" & $sNameTable & "' WHERE " & GUICtrlRead($Combo) & " LIKE '%" & GUICtrlRead($GUI_Input5) & "%';", "_CallbackRow")
	; _SQLite_Exec(-1, "SELECT " & GUICtrlRead($Combo) & " FROM '" & $sNameTable & "' WHERE " & GUICtrlRead($Combo) & " LIKE '%" & GUICtrlRead($GUI_Input5) & "%';", "_CallbackRow")
	MsgBox(0, 'Время поиска : ' & Round(TimerDiff($timer), 2) & ' мсек', $sRes, 0, $hGui)
EndFunc   ;==>_FindAll_sql

; Прелесть поиска с помощью Query : получаем дескриптор за 0.28 мс и далее переход к первому элементу поиска и по желанию к следующему, т.е. пошаговый.
Func _FindAll_sql2() ; поиск всех в базе
	; $sRes=''
	; * указывает выводить в результаты всей строки (id из каждой колонки). Если указать id, то той колонки и будет выводится ячейка
	; Функция _SQLite_FetchData перебирает результат запроса присоединияя в результат все найденные строки
	$timer = TimerInit()
	_SQLite_Query(-1, "SELECT * FROM '" & $sNameTable & "' WHERE " & GUICtrlRead($Combo) & " LIKE '%" & GUICtrlRead($GUI_Input5) & "%';", $hQuery)
	$timer = Round(TimerDiff($timer), 2)
	While _SQLite_FetchData($hQuery, $aRow) = $SQLITE_OK
		; $sRes &=$aRow[0] & '|' & $aRow[1] & '|' & $aRow[2]&@CRLF ; можно присоединить результаты и вывести сразу все
		If MsgBox(4, 'Продолжить? (Время запроса Query : ' & $timer & ' мсек)', $aRow[0] & '|' & $aRow[1] & '|' & $aRow[2], 0, $hGui) = 7 Then _SQLite_QueryFinalize($hQuery)
	WEnd
	; MsgBox(0, 'Сообщение', $sRes, 0, $hGui)
EndFunc   ;==>_FindAll_sql2

Func _GetAllItem_sql() ; Получить все пункты таблицы
	$sRes = ''
	Local $d = _SQLite_Exec(-1, "Select oid,* FROM '" & $sNameTable & "'", "_CallbackRow") ; _CallbackRow будет вызвана для каждой строки
	MsgBox(0, 'Сообщение', $sRes, 0, $hGui)
EndFunc   ;==>_GetAllItem_sql

Func _CallbackRow($aRow)
	For $s In $aRow
		$sRes &= $s & @TAB
	Next
	$sRes &= @CRLF
EndFunc   ;==>_CallbackRow

Func _GetTableToArray2D() ; таблицу в 2D массив
	Local $aResult, $iRows, $iColumns
	$iRval = _SQLite_GetTable2d(-1, "SELECT * FROM '" & $sNameTable & "'", $aResult, $iRows, $iColumns)
	If $iRval = $SQLITE_OK Then
		; _SQLite_Display2DResult($aResult) - отправляет результаты в консоль
		_ArrayDisplay($aResult, 'Array')
	Else
		MsgBox(16, "Ошибка SQLite: " & $iRval, _SQLite_ErrMsg(), 0, $hGui)
	EndIf
EndFunc   ;==>_GetTableToArray2D

Func _DelTable() ; удаляет таблицу
	; IF EXISTS - избавляет от ошибок удаления несуществующей таблицы
	_SQLite_Exec(-1, "Drop Table IF EXISTS '" & $sNameTable & "'")
	_UpdateCombo()
	_Read_sql()
EndFunc   ;==>_DelTable

Func _GetNameTable() ; получает имена таблиц
	$sRes = ''
	; sqlite_master - системная таблица, содержащая имена таблиц в базе
	; ORDER BY name - сортировка по полю имени (name) таблиц
	_SQLite_Exec(-1, "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;", "_CallbackRow")
	
	; _SQLite_QuerySingleRow(-1, "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;", $aRow)
	; MsgBox(0, 'Сообщение', $aRow[0], 0, $hGui)
EndFunc   ;==>_GetNameTable

; Тестовые функции, недоделанные, для эксперимента
Func _Test_sql2() ; Сортировка с пересозданием индексов
	Local $hQuery, $aRow, $aNames
	$name = StringRegExpReplace($SQLite_Data_Path, '(^.*)\\(.*)\.(.*)$', '\2')
	; MsgBox(0, 'Сообщение', _SQLite_Exec(-1, "REINDEX "&$SQLite_Data_Path&".'"&$sNameTable&"'")=$SQLITE_OK, 0, $hGui)
	MsgBox(0, 'Сообщение', _SQLite_Exec(-1, "REINDEX collation " & $name) = $SQLITE_OK, 0, $hGui)
EndFunc   ;==>_Test_sql2

; Тестовые функции, недоделанные, для эксперимента
Func _Test_sql() ; получить количество таблиц или проверить существование таблицы
	; $name=StringRegExpReplace($SQLite_Data_Path, '(^.*)\\(.*)\.(.*)$', '\2')
	; MsgBox(0, 'Сообщение', _SQLite_Exec(-1, "SELECT count(name) FROM sqlite_master WHERE name='"&$sNameTable&"'")=$SQLITE_OK, 0, $hGui)
	
	
	$sRes = ''
	; _SQLite_QuerySingleRow(-1, "SELECT count FROM sqlite_master WHERE name='"&$sNameTable&"'", $aRow)
	_SQLite_Query(-1, "SELECT count(" & $ID1 & ") FROM '" & $sNameTable & "'", $hQuery)
	MsgBox(0, 'Сообщение', $aRow[0], 0, $hGui)
	
	
	; MsgBox(0, 'Сообщение', _SQLite_Exec(-1, "SELECT name FROM sqlite_master WHERE type='table' AND name='%s'"&$sNameTable)=$SQLITE_OK, 0, $hGui)
	; MsgBox(0, 'Сообщение', _SQLite_Exec(-1, "SELECT name FROM sqlite_master WHERE type='table'"), 0, $hGui)
	; MsgBox(0, 'Сообщение',_SQLite_Exec(-1, "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;", "_CallbackRow"), 0, $hGui)
	; MsgBox(0, 'Сообщение', _SQLite_Exec(-1, "SHOW TABLES FROM "&$name&" LIKE "&$sNameTable)=$SQLITE_OK, 0, $hGui)
EndFunc   ;==>_Test_sql

Func _GetColum_sql() ; получить имена колонок
	Local $hQuery, $aNames
	_SQLite_Query(-1, "SELECT ROWID,* FROM '" & $sNameTable & "' ORDER BY " & $ID1, $hQuery)
	_SQLite_FetchNames($hQuery, $aNames)
	MsgBox(0, 'Сообщение', StringFormat(" %-10s  %-10s  %-10s  %-10s ", $aNames[0], $aNames[1], $aNames[2], $aNames[3]), 0, $hGui)
EndFunc   ;==>_GetColum_sql

Func _SelectItem_sql($a) ; получает элемент файла базы
	If _SQLite_QuerySingleRow(-1, "SELECT * FROM '" & $sNameTable & "' WHERE " & GUICtrlRead($Combo) & " = '" & $a & "';", $aRow) <> $SQLITE_OK Then
		_err('Ячейка с такими данными отсутствует')
		Return SetError(1)
	EndIf
	If $aRow[0] = '' Then
		_err('Ячейка с такими данными отсутствует')
	Else
		GUICtrlSetData($ID1_Input1, $aRow[0])
		GUICtrlSetData($ID1_Input2, $aRow[1])
		GUICtrlSetData($ID1_Input3, $aRow[2])
		GUICtrlSetData($StatusBar, 'Ячейка базы прочитана')
	EndIf
EndFunc   ;==>_SelectItem_sql

Func _DeleteItem_sql() ; удаляет элемент файла базы
	If _SQLite_Exec(-1, "DELETE FROM '" & $sNameTable & "' WHERE " & GUICtrlRead($Combo) & " = '" & GUICtrlRead($GUI_Input5) & "';") <> $SQLITE_OK Then
		_err('Ячейка с такими данными отсутствует')
	Else
		GUICtrlSetData($StatusBar, 'Ячейка базы удалена')
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