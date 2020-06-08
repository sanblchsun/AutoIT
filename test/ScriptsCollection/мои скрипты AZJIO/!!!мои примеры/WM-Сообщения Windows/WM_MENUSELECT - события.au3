#include <WindowsConstants.au3>
; #include <MenuConstants.au3>
#include <GUIConstantsEx.au3>
Global $k = 0

Global $k = 0, $store[2] = [1000000, 0], $Item[6] = [5] ; здесь 1000000 не даёт сработать событию и в тоже время ID практически не может совпасть с этим числом на практике.
$Gui = GUICreate("WM_MENUSELECT", 590, 270)
GUICtrlCreateLabel('Функция WM_MENUSELECT срабатывает в момент выбора главного или контекстного меню и его пунктов.', 5, 5, 380, 34)
$FileMenu = GUICtrlCreateMenu('&File')
$Item[1] = GUICtrlCreateMenuItem('Открыть', $FileMenu)
; GUICtrlSetState(-1, $GUI_CHECKED)
$Item[2] = GUICtrlCreateMenuItem('Сохранить', $FileMenu)
; GUICtrlSetState(-1, $GUI_DISABLE)
$Item[3] = GUICtrlCreateMenuItem('Выход', $FileMenu)
$HelpMenu = GUICtrlCreateMenu('Справка')
$Item[4] = GUICtrlCreateMenuItem('Web', $HelpMenu)
$Item[5] = GUICtrlCreateMenuItem('Поддержка', $HelpMenu)

$statist = GUICtrlCreateLabel('', 425, 40, 165, 234)

$ContMenu = GUICtrlCreateContextMenu()
GUICtrlCreateMenuItem('Удалить', $ContMenu)
GUICtrlCreateMenuItem('Выход', $ContMenu)

GUISetState()
GUIRegisterMsg($WM_MENUSELECT, "WM_MENUSELECT")


While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case -3
            Exit
    EndSwitch
    If Not $store[0] Then ; событие проверяется только при закрытии меню
        If $msg = $store[1] Then ; и только для пункта, который был выделен при закрытии меню
            $k += 1
            If Not $store[1] Then ; при отказе выбора в меню переходим к концу цикла
                $store[0] = 1000000 ; защита от генерации при неиспользованнии меню более 2-х раз
                ContinueLoop
            EndIf
            WinSetTitle($Gui, '', 'Вызов, '&$k&' - ID = '&$store[1])
            MsgBox(0, 'Событие', 'ID = '&$store[1])
        EndIf
    EndIf
WEnd

Func WM_MENUSELECT($hWnd, $Msg, $wParam, $lParam)
    Local $ID = BitAND($wParam, 0xFFFF) ; _WinAPI_LoWord
    $store[1] = $store[0] ; кешируется предыдущий ID
    $store[0] = $ID
EndFunc