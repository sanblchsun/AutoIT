#include <WindowsConstants.au3>
#include <MenuConstants.au3>
#include <WinAPI.au3>
#include <AVIConstants.au3>

AutoItSetOption("TrayIconHide", 1)
 
$Gui = GUICreate("progress", 208,14, -1, -1, $WS_POPUP) 
GuiCtrlCreateAvi("progress.avi",0, 0, 0, 5, 5, $ACS_AUTOPLAY)

; ����������� ����
$contextMenu = GuiCtrlCreateContextMenu()
$closeitem = GuiCtrlCreateMenuItem("�������", $contextMenu)

GuiSetState()
While 1
	$msg = GUIGetMsg()
	If $msg = $closeitem Then ExitLoop
	_SendMessage($GUI, $WM_SYSCOMMAND, BitOR($SC_MOVE, $HTCAPTION), 0) ; ��� ����������� ���� �� ���� ����
WEnd