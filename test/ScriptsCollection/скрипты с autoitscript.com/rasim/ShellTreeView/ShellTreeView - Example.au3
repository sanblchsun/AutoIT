#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ShellTreeView.au3>
#include <TreeViewConstants.au3>

Global Const $TVN_ITEMEXPANDING = $TVN_FIRST - 54 ; добавил константу, которая аналогична $TVN_ITEMEXPANDINGW

GUICreate("TreeView", 400, 500)

$hTreeView = GUICtrlCreateTreeView(2, 2, 396, 496)
$hTreeView = GUICtrlGetHandle($hTreeView)
_ShellTreeView_Create($hTreeView)
GUISetState()

; Loop until user exits
Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
GUIDelete()