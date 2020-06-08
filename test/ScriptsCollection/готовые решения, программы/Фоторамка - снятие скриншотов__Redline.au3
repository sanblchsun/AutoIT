#include <WindowsConstants.au3>
#include <GUIConstants.au3>
#Include <Constants.au3>
#include <WinAPIEx.au3>
#include <Misc.au3>
#include <ScreenCapture.au3>
#include <HotKeyInput.au3>
#include <HotKey.au3>

Opt('GUICloseOnESC', 0)
Opt('GUIOnEventMode', 1)
Opt('TrayMenuMode', 1)

$proj = 'Фоторамка | помощь - [F1]'
$ini = @ScriptDir & '\config.ini'
$width = IniRead($ini, 'conf', 'border_size', 10)
Global $flag = 0

#region - GUI Create
$hGUI = GUICreate($proj, 300, 300, -1, -1, $WS_OVERLAPPEDWINDOW, $WS_EX_LAYERED + $WS_EX_TOPMOST)
GUISetBkColor(0x0000F1)
$labelMenu = GUICtrlCreateLabel('', 0, 0, 300, 300, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetBkColor($labelMenu, 0x0000F1)
Dim $label[4] = [GUICtrlCreateLabel('', 0, 0, $width, 300),GUICtrlCreateLabel('', 0, 0, 300, $width),GUICtrlCreateLabel('', 300 - $width, 0, $width, 300),GUICtrlCreateLabel('', 0, 300 - $width, 300, $width)]
GUICtrlSetResizing($label[0], $GUI_DOCKLEFT + $GUI_DOCKWIDTH)
GUICtrlSetResizing($label[1], $GUI_DOCKTOP + $GUI_DOCKHEIGHT)
GUICtrlSetResizing($label[2], $GUI_DOCKRIGHT + $GUI_DOCKWIDTH)
GUICtrlSetResizing($label[3], $GUI_DOCKBOTTOM + $GUI_DOCKHEIGHT)
$cursor = IniRead($ini, 'conf', 'cursor', 1)
$colorOld = IniRead($ini, 'conf', 'color', '0xFF0000')
$negativeColor = '0x' & Hex(255 - BitAND(BitShift($colorOld, 16), 0xFF), 2) & Hex(255 - BitAND(BitShift($colorOld, 8), 0xFF), 2) & Hex(255 - BitAND($colorOld, 0xFF), 2)
$format = IniRead($ini, 'conf', 'format', '.jpeg')
$path = IniRead($ini, 'conf', 'path', @ScriptDir)
If FileExists($path) = 0 Then $path = @ScriptDir
$hotKeyRegion = IniRead($ini, 'conf', 'hotkeyregion', '556')
$hotKeyFull = IniRead($ini, 'conf', 'hotkeyfull', '300')
_HotKeyAssign($hotKeyRegion, '_region')
_HotKeyAssign($hotKeyFull, '_full')
$num = 1
For $i = 0 To 3
    GUICtrlSetBkColor($label[$i], $colorOld)
    GUICtrlSetStyle($label[$i], -1, $GUI_WS_EX_PARENTDRAG)
Next
_WinAPI_SetLayeredWindowAttributes($hGUI, 0x0000F1, 0, $LWA_COLORKEY)
$itemColor = TrayCreateItem('Цвет рамки')
$itemBorderSize = TrayCreateItem('Толщина рамки')
$itemCursor = TrayCreateItem('Захватывать курсор')
If $cursor = 1 Then TrayItemSetState($itemCursor, 65)
$FormatSubMenu = TrayCreateMenu('Формат файлов')
$itemJPEG = TrayCreateItem('JPEG', $FormatSubMenu, -1, 1)
$itemPNG = TrayCreateItem('PNG', $FormatSubMenu, -1, 1)
$itemBMP = TrayCreateItem('BMP', $FormatSubMenu, -1, 1)
$itemGIF = TrayCreateItem('GIF', $FormatSubMenu, -1, 1)
If $format = '.jpeg' Then
    TrayItemSetState($itemJPEG, $TRAY_CHECKED)
ElseIf $format = '.png' Then
    TrayItemSetState($itemPNG, $TRAY_CHECKED)
ElseIf $format = '.bmp' Then
    TrayItemSetState($itemBMP, $TRAY_CHECKED)
Else
    TrayItemSetState($itemGIF, $TRAY_CHECKED)
EndIf
TrayCreateItem('')
$itemHotKey = TrayCreateItem('Назначить горячие клавиши')
$itemPath = TrayCreateItem('Сохранять скриншоты в ... [' & $path & ']')
TrayCreateItem('')
$itemRegion = TrayCreateItem('Скриншот внутри рамки [' & _KeyToStr($hotKeyRegion) & ']')
$itemFull = TrayCreateItem('Скриншот всего экрана [' & _KeyToStr($hotKeyFull) & ']')
TrayCreateItem('')
$help = TrayCreateItem('Помощь')
TrayCreateItem('')
$exit = TrayCreateItem('Выход')

GUISetOnEvent($GUI_EVENT_CLOSE, '_exit')

_HotKeyAssign(37, '_moveLeft', $HK_FLAG_NOBLOCKHOTKEY, $proj)
_HotKeyAssign(38, '_moveUp', $HK_FLAG_NOBLOCKHOTKEY, $proj)
_HotKeyAssign(39, '_moveRight', $HK_FLAG_NOBLOCKHOTKEY, $proj)
_HotKeyAssign(40, '_moveDown', $HK_FLAG_NOBLOCKHOTKEY, $proj)

_HotKeyAssign(549, '_sizeWidthPlus', $HK_FLAG_NOBLOCKHOTKEY, $proj)
_HotKeyAssign(550, '_sizeHeightMinus', $HK_FLAG_NOBLOCKHOTKEY, $proj)
_HotKeyAssign(551, '_sizeWidthMinus', $HK_FLAG_NOBLOCKHOTKEY, $proj)
_HotKeyAssign(552, '_sizeHeightPlus', $HK_FLAG_NOBLOCKHOTKEY, $proj)

_HotKeyAssign(112, '_help', -1, $proj)

GUISetState()

$wincoord = WinGetPos($proj)
$labelcoord = ControlGetPos($proj, '', 'Static1')
$border = ($wincoord[2] - $labelcoord[2])/2
$hTitle = $wincoord[3] - $labelcoord[3] - $border

#endregion

While 1
    $msg = TrayGetMsg()
    Select
        Case $msg = $exit
            _exit()
        Case $msg = $help
            TrayItemSetState($help, 68)
            _help()
        Case $msg = $itemCursor
            If TrayItemGetState($itemCursor) = 68 Then
                $cursor = 0
                IniWrite($ini, 'conf', 'cursor', 0)
            Else
                $cursor = 1
                IniWrite($ini, 'conf', 'cursor', 1)
            EndIf
        Case $msg = $itemJPEG
            $format = '.jpeg'
            IniWrite($ini, 'conf', 'format', '.jpeg')
        Case $msg = $itemPNG
            $format = '.png'
            IniWrite($ini, 'conf', 'format', '.png')
        Case $msg = $itemBMP
            $format = '.bmp'
            IniWrite($ini, 'conf', 'format', '.bmp')
        Case $msg = $itemGIF
            $format = '.gif'
            IniWrite($ini, 'conf', 'format', '.gif')
        Case $msg = $itemHotKey
            _hotKeyMenu()
        Case $msg = $itemPath
            TrayItemSetState($itemPath, 68)
            Opt('TrayOnEventMode', 1)
            _HotKeyDisable()
            GUISetState(@SW_HIDE, $hGUI)
            $path = FileSelectFolder('Выбирите папку для сохранения скриншотов', @DesktopDir, 1, $path)
            If @error Then $path = IniRead($ini, 'conf', 'path', @ScriptDir)
            TrayItemSetText($itemPath, 'Сохранять скриншоты в ... [' & $path & ']')
            IniWrite($ini, 'conf', 'path', $path)
            GUISetState(@SW_SHOW, $hGUI)
            Opt('TrayOnEventMode', 0)
            _HotKeyEnable()
        Case $msg = $itemColor
            Opt('TrayOnEventMode', 1)
            TrayItemSetState($itemColor, 68)
            _HotKeyDisable()
            GUISetState(@SW_HIDE, $hGUI)
            $color = _ChooseColor(2, $colorOld, 2)
            If @error Then
                $color = $colorOld
                GUISetState(@SW_SHOW, $hGUI)
            Else
                If $color = '0x0000F1' Then $color = '0x0000F2'
                For $i = 0 To 3
                    GUICtrlSetBkColor($label[$i], $color)
                Next
                $colorOld = $color
                IniWrite($ini, 'conf', 'color', $color)
                $negativeColor = '0x' & Hex(255 - BitAND(BitShift($colorOld, 16), 0xFF), 2) & Hex(255 - BitAND(BitShift($colorOld, 8), 0xFF), 2) & Hex(255 - BitAND($colorOld, 0xFF), 2)
                GUISetState(@SW_SHOW, $hGUI)
            EndIf
            Opt('TrayOnEventMode', 0)
            _HotKeyEnable()
        Case $msg = $itemBorderSize
            TrayItemSetState($itemBorderSize, 68)
            Opt('TrayOnEventMode', 1)
            _HotKeyDisable()
            GUISetState(@SW_HIDE, $hGUI)
            $width = InputBox('Укажите толщину рамки', 'Минимальная/максимальная толщина - 10/40 pcx', $width, '', 300, 120)
            If @error > 0 Then $width = IniRead($ini, 'conf', 'border_size', 10)
            If $width < 10 Then $width = 10
            If $width > 40 Then $width = 40
            $coord = WinGetPos($proj)
            GUICtrlSetPos($label[0], 0, 0, $width, $coord[3])
            GUICtrlSetPos($label[1], 0, 0, $coord[2], $width)
            GUICtrlSetPos($label[2], $coord[2] - 2*$border - $width, 0, $width, $coord[3])
            GUICtrlSetPos($label[3], 0, $coord[3] - $hTitle - $border - $width, $coord[2], $width)
            IniWrite($ini, 'conf', 'border_size', $width)
            GUISetState(@SW_SHOW, $hGUI)
            Opt('TrayOnEventMode', 0)
            _HotKeyEnable()
        Case $msg = $itemRegion
            TrayItemSetState($itemRegion, 68)
            _region()
        Case $msg = $itemFull
            TrayItemSetState($itemFull, 68)
            _full()
    EndSelect
WEnd

Func _region()
    If BitAnd(WinGetState($proj), 16) Then Return
    $coord = WinGetPos($proj)
    $screen = _ScreenCapture_Capture('', $coord[0] + $border + $width, $coord[1] + $hTitle + $width, $coord[0] + $coord[2] - $border - $width, $coord[1] + $coord[3] - $border - $width, $cursor)
    _ScreenCapture_SaveImage($path & '\' & StringFormat('%04d', $num) & '[' & @MDAY & '_' & @MON & '_' & @YEAR & '] [' & @HOUR & '-' & @MIN & '] ' &  $format, $screen)
    For $i = 0 To 3
        GUICtrlSetBkColor($label[$i], $negativeColor)
    Next
    Sleep(250)
    For $i = 0 To 3
        GUICtrlSetBkColor($label[$i], $colorOld)
    Next
    $num += 1
EndFunc

Func _full()
    GUISetState(@SW_HIDE, $hGUI)
    Sleep(4)
    $screen = _ScreenCapture_Capture('', 0, 0, -1, -1, $cursor)
    _ScreenCapture_SaveImage($path & '\' & StringFormat('%04d', $num) & '[' & @MDAY & '_' & @MON & '_' & @YEAR & '] [' & @HOUR & '-' & @MIN & '] ' &  $format, $screen)
    $num += 1
    GUISetState(@SW_SHOW, $hGUI)
EndFunc

Func _hotKeyMenu()
    GUISetState(@SW_HIDE, $hGUI)
    TrayItemSetState($itemHotKey, 68)
    Opt('GUIOnEventMode', 0)
    Opt('TrayOnEventMode', 1)
    _HotKeyDisable()
    $hGUI2 = GUICreate('Назначить горячие клавиши', 300, 155, -1, -1, -1, $WS_EX_TOPMOST)
    GUICtrlCreateLabel('Сочетание клавиш для скриншота внутри рамки', 10, 5, 280, 21)
    $inputRegion = _GUICtrlCreateHotKeyInput($hotKeyRegion, 10, 30, 280, 20)
    GUICtrlCreateLabel('Сочетание клавиш для скриншота всего экрана', 10, 60, 280, 21)
    $inputFull = _GUICtrlCreateHotKeyInput($hotKeyFull, 10, 85, 280, 20)
    _KeyLock(37)
    _KeyLock(38)
    _KeyLock(39)
    _KeyLock(40)
    _KeyLock(112)
    _KeyLock(549)
    _KeyLock(550)
    _KeyLock(551)
    _KeyLock(552)
    $buttonOK = GUICtrlCreateButton('OK', 105, 120, 80, 25)
    GUISetState()
    While 1
        $msg = GUIGetMsg()
        Select
            Case $msg = -3
                GUIDelete($hGUI2)
                GUISetState(@SW_SHOW, $hGUI)
                ExitLoop
            Case $msg = $buttonOK
                $hotKeyRg_New = _GUICtrlReadHotKeyInput($inputRegion)
                If $hotKeyRg_New = 0 Then $hotKeyRg_New = $hotKeyRegion
                _HotKeyAssign($hotKeyRegion)
                $hotKeyRegion = $hotKeyRg_New
                _HotKeyAssign($hotKeyRegion, '_region')
                TrayItemSetText($itemRegion, 'Скриншот внутри рамки [' & _KeyToStr($hotKeyRegion) & ']')
                IniWrite($ini, 'conf', 'hotkeyregion', $hotKeyRegion)

                $hotKeyFl_New = _GUICtrlReadHotKeyInput($inputFull)
                If $hotKeyFl_New = 0 Then $hotKeyFl_New = $hotKeyFull
                _HotKeyAssign($hotKeyFull)
                $hotKeyFull = $hotKeyFl_New
                _HotKeyAssign($hotKeyFull, '_full')
                TrayItemSetText($itemFull, 'Скриншот всего экрана [' & _KeyToStr($hotKeyFull) & ']')
                IniWrite($ini, 'conf', 'hotkeyfull', $hotKeyFull)

                GUIDelete($hGUI2)
                GUISetState(@SW_SHOW, $hGUI)
                ExitLoop
        EndSelect
    WEnd
    Opt('GUIOnEventMode', 1)
    Opt('TrayOnEventMode', 0)
    _HotKeyEnable()
EndFunc

Func _moveLeft()
    $coord = WinGetPos($proj)
    WinMove($proj, '', $coord[0] - 1, $coord[1])
EndFunc

Func _moveRight()
    $coord = WinGetPos($proj)
    WinMove($proj, '', $coord[0] + 1, $coord[1])
EndFunc

Func _moveUp()
    $coord = WinGetPos($proj)
    WinMove($proj, '', $coord[0], $coord[1] - 1)
EndFunc

Func _moveDown()
    $coord = WinGetPos($proj)
    WinMove($proj, '', $coord[0], $coord[1] + 1)
EndFunc

Func _sizeWidthMinus()
    $coord = WinGetPos($proj)
    WinMove($proj, '', $coord[0], $coord[1], $coord[2] + 1)
EndFunc

Func _sizeWidthPlus()
    $coord = WinGetPos($proj)
    WinMove($proj, '', $coord[0], $coord[1], $coord[2] - 1)
EndFunc

Func _sizeHeightMinus()
    $coord = WinGetPos($proj)
    WinMove($proj, '', $coord[0], $coord[1], $coord[2], $coord[3] - 1)
EndFunc

Func _sizeHeightPlus()
    $coord = WinGetPos($proj)
    WinMove($proj, '', $coord[0], $coord[1], $coord[2], $coord[3] + 1)
EndFunc

Func _help()
    GUISetState(@SW_HIDE, $hGUI)
    MsgBox(0, 'Help', 'Меню вызывается из значка в системном трее.' & @CRLF & 'Управлять окном можно с помощью стрелок на клавиатуре,' & @CRLF & 'изменять размер окна - с помощью стрелок, при зажатом [Ctrl]')
    GUISetState(@SW_SHOW, $hGUI)
EndFunc

Func _exit()
    Exit
EndFunc
 