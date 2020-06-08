; guinness
; http://www.autoitscript.com/forum/topic/128993-guictrllistview-createarray-create-an-array-from-a-listview/#entry895462
#include <Array.au3> ; Required only for _ArrayDisplay().
#include <GUIConstantsEx.au3>
#include <GUIListView.au3>
#include <WindowsConstants.au3>
#include <_GUICtrlListView_CreateArray.au3>

Example()

Func Example()
    Local $iWidth = 600, $iHeight = 400, $iListView
    Local $hGUI = GUICreate('_GUICtrlListView_CreateArray()', $iWidth, $iHeight, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_MAXIMIZEBOX, $WS_SIZEBOX))
	
	_CreateListView($hGUI, $iListView)

    Local $iGetArray = GUICtrlCreateButton('Получить массив', $iWidth - 120, $iHeight - 28, 115, 27)
    GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKSIZE + $GUI_DOCKBOTTOM)

    Local $iRefresh = GUICtrlCreateButton('Обновить', $iWidth - 240, $iHeight - 28, 115, 27)
    GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKSIZE + $GUI_DOCKBOTTOM)

    GUISetState(@SW_SHOW, $hGUI)

    Local $aReturn = 0, $aStringSplit = 0
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                ExitLoop

            Case $iGetArray
                $aReturn = _GUICtrlListView_CreateArray($iListView, Default) ; Использует символ "|" как разделитель по умолчанию.
                _ArrayDisplay($aReturn, '_GUICtrlListView_CreateArray.')

                $aStringSplit = StringSplit($aReturn[0][2], '|')
                _ArrayDisplay($aStringSplit, 'StringSplit для извлечения имён колонок.')

            Case $iRefresh
				GUICtrlDelete($iListView)
				_CreateListView($hGUI, $iListView)

        EndSwitch
    WEnd
    GUIDelete($hGUI)
EndFunc   ;==>Example

Func _CreateListView($hGUI, ByRef $iListView)
	$ClientSize = WinGetClientSize($hGUI)
	$iListView = GUICtrlCreateListView('', 0, 0, $ClientSize[0], $ClientSize[1] - 30)
	GUICtrlSetResizing($iListView, $GUI_DOCKBORDERS)
	Sleep(250)

	$iCol = Random(1, 5, 1)
    __ListViewFill($iListView, $iCol, Random(25, 100, 1)) ; Заполняет ListView случайными данными.
	For $i = 0 To $iCol
		GUICtrlSendMsg($iListView, $LVM_SETCOLUMNWIDTH, $i, -1)
		GUICtrlSendMsg($iListView, $LVM_SETCOLUMNWIDTH, $i, -2)
	Next
EndFunc

; Эта функция только для демонстрации примера, но не для UDF!
Func __ListViewFill($hListView, $iColumns, $iRows)
    If Not IsHWnd($hListView) Then
        $hListView = GUICtrlGetHandle($hListView)
    EndIf
    Local $fIsCheckboxesStyle = (BitAND(_GUICtrlListView_GetExtendedListViewStyle($hListView), $LVS_EX_CHECKBOXES) = $LVS_EX_CHECKBOXES)

    _GUICtrlListView_BeginUpdate($hListView)
    For $i = 0 To $iColumns - 1
        _GUICtrlListView_InsertColumn($hListView, $i, 'Колонка ' & $i + 1, 50)
        _GUICtrlListView_SetColumnWidth($hListView, $i - 1, -2)
    Next
    For $i = 0 To $iRows - 1
        _GUICtrlListView_AddItem($hListView, 'Стр ' & $i + 1 & ': Кол 1', $i)
        If Random(0, 1, 1) And $fIsCheckboxesStyle Then
            _GUICtrlListView_SetItemChecked($hListView, $i)
        EndIf
        For $j = 1 To $iColumns
            _GUICtrlListView_AddSubItem($hListView, $i, 'Стр ' & $i + 1 & ': Кол ' & $j + 1, $j)
        Next
    Next
    _GUICtrlListView_EndUpdate($hListView)
EndFunc   ;==>__ListViewFill