#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
GUICreate(' инь сюда группу файлов', 470, 280, -1, -1, $WS_OVERLAPPEDWINDOW,  $WS_EX_ACCEPTFILES)
GUICtrlCreateEdit("Ёлемент Edit принимает пути файлов как многострочный текст", 5, 5, 460, 270)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUISetState()
Do
Until GUIGetMsg() = -3