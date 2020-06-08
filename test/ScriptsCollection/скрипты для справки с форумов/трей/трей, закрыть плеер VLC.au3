#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=test_test.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Constants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#NoTrayIcon
;---------
Global $pid
Opt("TrayMenuMode", 1)

$item_menu = TrayCreateMenu("Menu")
$item_vlc = TrayCreateItem("VLC", $item_menu)
TrayCreateItem("")
$item_close = TrayCreateItem("Closer VLC")
TrayCreateItem("")
$item_exit = TrayCreateItem("Exit")

TraySetState()

While 1
    $msg = TrayGetMsg()
    If ProcessExists($pid) = 0 Then TrayItemSetState($item_close, $TRAY_DISABLE)
    Select
        Case $msg = 0
            ContinueLoop
        Case $msg = $item_vlc
            $pid = PlayIt()
            TrayTip("Debug", "PID is " & $pid, 5)
        Case $msg = $item_close
            ProcessClose($pid)
            TrayItemSetState($item_close, $TRAY_DISABLE)
        Case $msg = $item_exit
            ExitLoop
    EndSelect

WEnd

Func PlayIt()
    $pid = Run(@ProgramFilesDir & "\VideoLAN\VLC\vlc.exe --one-instance")

    TrayItemSetState($item_close, $TRAY_ENABLE)
    Return $pid
EndFunc
 
