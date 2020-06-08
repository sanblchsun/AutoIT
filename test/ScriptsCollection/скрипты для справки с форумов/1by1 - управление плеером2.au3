#include <WindowsConstants.au3>
#include <GuiToolbar.au3>


$hWnd = WinGetHandle("[CLASS:1by1WndClass]")
$hToolBar = ControlGetHandle($hWnd, "", "[CLASS:ToolbarWindow32; INSTANCE:1]")
$iCommand = _GUICtrlToolbar_IndexToCommand($hToolBar, 0)
_SendMessage($hToolBar, $WM_COMMAND, $iCommand, $hToolBar)