#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <GUIImageList.au3>
#include <GUIListView.au3>
#include <WindowsConstants.au3>

Global $iGUI_Left = -1
Global $iGUI_Top = -1
Global $iGUI_Width = 750
Global $iGUI_Height = 600

_GDIPlus_Startup()

$hMain_GUI = GUICreate('Test GUI', $iGUI_Width, $iGUI_Height, $iGUI_Left, $iGUI_Top)

$hMenuItems_ListView = GUICtrlCreateListView('Item Name                |Type|Displayed on...|Item Full Value', 20, 20, $iGUI_Width-40, $iGUI_Height - 140, BitOR($LVS_ICON, $LVS_SHOWSELALWAYS, $LVS_SINGLESEL, $LVS_REPORT, $LVS_NOSORTHEADER))
$hMenuItems_ListView = GUICtrlGetHandle($hMenuItems_ListView)
_GUICtrlListView_SetExtendedListViewStyle($hMenuItems_ListView, $LVS_EX_CHECKBOXES)
$hImageList = _GUIImageList_Create(32, 32, 5, 1)
_GUICtrlListView_SetImageList($hMenuItems_ListView, $hImageList, 1)

_GUICtrlListView_InsertItem($hMenuItems_ListView, 'table.bmp', 0)
_GUICtrlListView_SetItemImageEx($hMenuItems_ListView, 0, @ProgramFilesDir&'\Windows NT\Pinball\table.bmp')

_GUICtrlListView_InsertItem($hMenuItems_ListView, 'wmpnss_color32.jpg', 0)
_GUICtrlListView_SetItemImageEx($hMenuItems_ListView, 0, @ProgramFilesDir&'\Windows Media Player\Network Sharing\wmpnss_color32.jpg')

_GUICtrlListView_InsertItem($hMenuItems_ListView, 'wmpnss_bw32.jpg', 0)
_GUICtrlListView_SetItemImageEx($hMenuItems_ListView, 0, @ProgramFilesDir&'\Windows Media Player\Network Sharing\Web\wmpnss_bw32.jpg')

_GUICtrlListView_InsertItem($hMenuItems_ListView, 'Wallpaper.jpg', 0)
_GUICtrlListView_SetItemImageEx($hMenuItems_ListView, 0, @WindowsDir&'\Web\Wallpaper.jpg')

_GUICtrlListView_InsertItem($hMenuItems_ListView, 'oemlogo.bmp', 0)
_GUICtrlListView_SetItemImageEx($hMenuItems_ListView, 0, @SystemDir&'\oemlogo.bmp')

_GUICtrlListView_InsertItem($hMenuItems_ListView, 'gif не работает', 0)
_GUICtrlListView_SetItemImageEx($hMenuItems_ListView, 0, @SystemDir&'\merlin.gif')

_GUICtrlListView_InsertItem($hMenuItems_ListView, 'MyImage.png', 0)
_GUICtrlListView_SetItemImageEx($hMenuItems_ListView, 0, 'MyImage.png')

_GUICtrlListView_InsertItem($hMenuItems_ListView, 'MyImage.png', 0)
_GUICtrlListView_SetItemImageEx($hMenuItems_ListView, 0, @ScriptDir&'\MyImage.png')

_GUICtrlListView_InsertItem($hMenuItems_ListView, 'winnt.bmp', 0)
_GUICtrlListView_SetItemImageEx($hMenuItems_ListView, 0, @WindowsDir&'\winnt.bmp')

GUISetState()

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            ExitLoop
    EndSwitch
WEnd

_GDIPlus_Shutdown()



Func _WinAPI_SwitchColor($iColor)
    Return BitOR(BitAND($iColor, 0x00FF00), BitShift(BitAND($iColor, 0x0000FF), -16), BitShift(BitAND($iColor, 0xFF0000), 16))
EndFunc   ;==>_WinAPI_SwitchColor






Func _GUICtrlListView_SetItemImageEx($hWnd, $iIndex, $sFile)

    Local $hBitmap, $hImage, $hGraphic, $hBrush, $hPic, $W, $H

    $hBitmap = _WinAPI_CreateBitmap(32, 32, 1, 32)
    $hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
    _WinAPI_DeleteObject($hBitmap)
    $hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage)
    $hBrush = _GDIPlus_BrushCreateSolid(_WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_WINDOW)))
    $hBrush = _GDIPlus_BrushCreateSolid(BitOR(0xFF000000, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_WINDOW))))
    _GDIPlus_GraphicsFillRect($hGraphic, 0, 0, 32, 32, $hBrush)
    $hPic = _GDIPlus_ImageLoadFromFile($sFile)
    $W = _GDIPlus_ImageGetWidth($hPic)
    $H = _GDIPlus_ImageGetHeight($hPic)
    If ($W) And ($H) Then
        If $W < $H Then
            $W = 32 * $W / $H
            $H = 32
        Else
            $H = 32 * $H / $W
            $W = 32
        EndIf
        _GDIPlus_GraphicsDrawImageRect($hGraphic, $hPic, (32 - $W) / 2, (32 - $H) / 2, $W, $H)
    EndIf
    $hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
    _GDIPlus_GraphicsDispose($hGraphic)
    _GDIPlus_BrushDispose($hBrush)
    _GDIPlus_ImageDispose($hImage)
    _GDIPlus_ImageDispose($hPic)
    _GUIImageList_Add($hImageList, $hBitmap)
    _GUICtrlListView_SetItemImage($hWnd, $iIndex, _GUIImageList_GetImageCount($hImageList) - 1)
    _WinAPI_DeleteObject($hBitmap)
EndFunc   ;==>_GUICtrlListView_SetItemImageEx