#include <GUIConstants.au3>
#include <WindowsConstants.au3>

$Gui = GUICreate("Проверка drag-and-drop", 420, 200, -1, -1, -1, $WS_EX_ACCEPTFILES) ; стиль drag-and-drop, (0x00000010)

$CatchDrop = GUICtrlCreateLabel("", 0, 0, 420, 40) ; создаём область Label, первым элементом, чтоб не перекрывать остальные, размер можно указать на всё окно
GUICtrlSetState(-1, $GUI_DISABLE + $GUI_DROPACCEPTED) ; устанавливаем параметры области - скрытая и drag-and-drop (128+8)

GUICtrlCreateLabel("используйте drag-and-drop", 120, 3, 200, 18)

$Label1 = GUICtrlCreateLabel("Путь 1", 24, 40, 186, 17)
$Input1 = GUICtrlCreateInput("", 24, 57, 305, 21)
GUICtrlSetState(-1, $GUI_DROPACCEPTED) ; Input наделённый свойством drag-and-drop (8)
$folder1 = GUICtrlCreateButton("Обзор...", 344, 56, 57, 23)

$Label2 = GUICtrlCreateLabel("Путь 2", 24, 90, 186, 17)
$Input2 = GUICtrlCreateInput("", 24, 107, 305, 21)
GUICtrlSetState(-1, $GUI_DROPACCEPTED) ; Input наделённый свойством drag-and-drop (8)
$folder2 = GUICtrlCreateButton("Обзор...", 344, 106, 57, 23)

$Label3 = GUICtrlCreateLabel("Путь 3", 24, 140, 186, 17)
$Input3 = GUICtrlCreateInput("", 24, 157, 305, 21)
GUICtrlSetState(-1, $GUI_DROPACCEPTED) ; Input наделённый свойством drag-and-drop (8)
$folder3 = GUICtrlCreateButton("Обзор...", 344, 156, 57, 23)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_DROPPED ;событие приходящееся на drag-and-drop (-13)
			If @GUI_DropId = $Input1 Then GUICtrlSetData($Input1, @GUI_DragFile)
			If @GUI_DropId = $Input2 Then GUICtrlSetData($Input2, @GUI_DragFile)
			If @GUI_DropId = $Input3 Then GUICtrlSetData($Input3, @GUI_DragFile)
			If @GUI_DropId = $CatchDrop Then MsgBox(0, "В область drag-and-drop попал файл", @GUI_DragFile)
			; кнопки обзор
		Case $folder1
			$folder01 = FileOpenDialog("Указать файл", @WorkingDir & "", "Любой (*.*)", 1 + 4)
			If @error Then ContinueLoop
			GUICtrlSetData($Input1, $folder01)
		Case $folder2
			$folder02 = FileOpenDialog("Указать файл", @WorkingDir & "", "Любой (*.*)", 1 + 4)
			If @error Then ContinueLoop
			GUICtrlSetData($Input2, $folder02)
		Case $folder3
			$folder03 = FileOpenDialog("Указать файл", @WorkingDir & "", "Любой (*.*)", 1 + 4)
			If @error Then ContinueLoop
			GUICtrlSetData($Input3, $folder03)
		Case $GUI_EVENT_CLOSE ; закрыть (-3)
			Exit
	EndSwitch
WEnd

#cs
	Событие $GUI_EVENT_DROPPED можно удалить, но теряется универсальность. Если открыть путь кнопкой "Обзор..." и далее кинуть файл в Input, то пути складываются в одну строку последовательно. Именно $GUI_EVENT_DROPPED устраняет эту проблему установкой пути с помощью GUICtrlSetData.
#ce
