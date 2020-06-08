#include <ListView_Progress.au3>

Global $iProgress = 0

$hGui = GUICreate("ListView with progressbar", 420, 400, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_SIZEBOX))

$hListView = GUICtrlCreateListView("Files|Path|Progress", 10, 10, 400, 180, BitOR($LVS_REPORT, $WS_BORDER))
_FillListView($hListView)

$hListView2 = GUICtrlCreateListView("Files|Path|Progress", 10, 205, 400, 180, BitOR($LVS_REPORT, $WS_BORDER))
_FillListView($hListView2)

Func _FillListView($hWnd)
	_GUICtrlListView_BeginUpdate($hWnd)
	
	_GUICtrlListView_SetColumnWidth($hWnd, 0, 100)
	_GUICtrlListView_SetColumnWidth($hWnd, 1, 140)
	_GUICtrlListView_SetColumnWidth($hWnd, 2, 150)
	
	_GUICtrlListView_AddItem($hWnd, "AutoIT")
	_GUICtrlListView_AddItem($hWnd, "")
	_GUICtrlListView_AddItem($hWnd, "Script")
	_GUICtrlListView_AddItem($hWnd, "Work")
	_GUICtrlListView_AddItem($hWnd, "New")
	_GUICtrlListView_AddItem($hWnd, "Test")
	_GUICtrlListView_AddItem($hWnd, "Image")
	_GUICtrlListView_AddItem($hWnd, "Soft")
	_GUICtrlListView_AddItem($hWnd, "News")
	_GUICtrlListView_AddItem($hWnd, "Info")
	
	_GUICtrlListView_AddSubItem($hWnd, 0, "C:\Program Files\AutoIt3", 2)
	_GUICtrlListView_AddSubItem($hWnd, 1, "C:\Program Files\Opera", 1)
	_GUICtrlListView_AddSubItem($hWnd, 1, "Opera", 2)
	_GUICtrlListView_AddSubItem($hWnd, 2, "C:\MyScript\Work", 1)
	_GUICtrlListView_AddSubItem($hWnd, 2, "Work", 2)
	_GUICtrlListView_AddSubItem($hWnd, 3, "C:\New\Script", 1)
	_GUICtrlListView_AddSubItem($hWnd, 4, "C:\Image\Image", 1)
	_GUICtrlListView_AddSubItem($hWnd, 5, "C:\Soft\New", 1)
	_GUICtrlListView_AddSubItem($hWnd, 6, "C:\Music\Info", 1)
	_GUICtrlListView_AddSubItem($hWnd, 7, "C:\Video\Soft", 1)
	_GUICtrlListView_AddSubItem($hWnd, 8, "C:\Project\Script", 1)
	_GUICtrlListView_AddSubItem($hWnd, 9, "C:\Work\Script", 1)
	
	_GUICtrlListView_EndUpdate($hWnd)
EndFunc

$hProgress1  = _ListView_InsertProgressBar($hListView, 0, 1)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", $hProgress1, "wstr", "", "wstr", "")
_Progress_SetBarColor($hProgress1,0xFF0000)

$hProgress2  = _ListView_InsertProgressBar($hListView, 1)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", $hProgress2, "wstr", "", "wstr", "")
_Progress_SetBkColor($hProgress2, 0x0000FF)

$hProgress3  = _ListView_InsertProgressBar($hListView, 2)
_Progress_SetBarColor($hProgress3,0x0000FF)

$hProgress4  = _ListView_InsertProgressBar($hListView, 3, 2)
_Progress_SetBkColor($hProgress3,0xFF00FF)
_Progress_SetPos($hProgress4, 6)

$hProgress5  = _ListView_InsertProgressBar($hListView, 4, 2)
_Progress_SetPos($hProgress5, 34)

$hProgress6  = _ListView_InsertProgressBar($hListView, 5, 1)

$hProgress7  = _ListView_InsertProgressBar($hListView, 6, 2)
_Progress_SetPos($hProgress7, 10)

$hProgress8  = _ListView_InsertProgressBar($hListView, 7, 2)
_Progress_SetPos($hProgress8, 20)

$hProgress9  = _ListView_InsertProgressBar($hListView, 8, 2)
$hProgress10 = _ListView_InsertProgressBar($hListView, 9, 2)

;_Progress_Delete($hProgress10)

;=========================================================================================
$hProgress11  = _ListView_InsertProgressBar($hListView2, 0, 1)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", $hProgress1, "wstr", "", "wstr", "")
_Progress_SetBarColor($hProgress1,0xFF0000)

$hProgress12  = _ListView_InsertProgressBar($hListView2, 1)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", $hProgress2, "wstr", "", "wstr", "")
_Progress_SetBkColor($hProgress2, 0x0000FF)

$hProgress13  = _ListView_InsertProgressBar($hListView2, 2)
_Progress_SetBarColor($hProgress3,0x0000FF)
$hProgress14  = _ListView_InsertProgressBar($hListView2, 3, 2)
_Progress_SetBkColor($hProgress3,0xFF00FF)
$hProgress15  = _ListView_InsertProgressBar($hListView2, 4, 2)
_Progress_SetStep($hProgress5,34)
$hProgress16  = _ListView_InsertProgressBar($hListView2, 5, 1)
$hProgress17  = _ListView_InsertProgressBar($hListView2, 6, 2)
$hProgress18  = _ListView_InsertProgressBar($hListView2, 7, 2)
$hProgress19  = _ListView_InsertProgressBar($hListView2, 8, 2)
$hProgress20 = _ListView_InsertProgressBar($hListView2, 9, 2)

GUISetState()

AdlibEnable("_Progress", 500)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _Progress()
    If $iProgress = 100 Then $iProgress = 0
    $iProgress += 10
    _Progress_SetPos($hProgress1, $iProgress + 10)
    _Progress_SetPos($hProgress2, $iProgress)
	_Progress_SetPos($hProgress3, $iProgress)
	_Progress_SetPos($hProgress6, $iProgress)
    _Progress_SetPos($hProgress9, $iProgress)
    _Progress_SetPos($hProgress10, $iProgress + 20)
    _Progress_SetPos($hProgress11, $iProgress + 2)
    _Progress_SetPos($hProgress14, $iProgress +3)
    _Progress_SetPos($hProgress16, $iProgress +4)
EndFunc   ;==>_Progress