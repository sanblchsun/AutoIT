#include <WindowsConstants.au3>
#include <MenuConstants.au3>
#include <WinAPI.au3>
#include <AVIConstants.au3>

AutoItSetOption("TrayIconHide", 1)
FileInstall("C:\progress.avi", "*") ; при компилировании добавить файл по указанному пути
FileMove(@ScriptDir&'\progress.avi', @TempDir, 9)
 
$Gui = GUICreate("progress", 208,14, -1, -1, $WS_POPUP) 
GuiCtrlCreateAvi(@TempDir&"\progress.avi",0, 0, 0, 5, 5, $ACS_AUTOPLAY)

; контекстное меню
$contextMenu = GuiCtrlCreateContextMenu()
$closeitem = GuiCtrlCreateMenuItem("«акрыть", $contextMenu)

GuiSetState()
While 1
	$msg = GUIGetMsg()
	If $msg = $closeitem Then ExitLoop
	_SendMessage($GUI, $WM_SYSCOMMAND, BitOR($SC_MOVE, $HTCAPTION), 0) ; дл€ перемещени€ окна за само окно
WEnd