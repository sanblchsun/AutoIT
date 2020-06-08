#include <ToolbarConstants.au3>
#include <WindowsConstants.au3>
#include <Memory.au3>
#include <WinAPI.au3>


$hWnd = WinGetHandle("[CLASS:1by1WndClass]")
$iProcID = WinGetProcess("[CLASS:1by1WndClass]")
$hToolBar = ControlGetHandle($hWnd, "", "[CLASS:ToolbarWindow32; INSTANCE:1]")
#cs

0 - Play track from beginning
1 - Stop / Resume (Unpause)
2 - Play previous track
3-  Play next track
5 - Search a directory/list backwards
6 - Search a directory/list forward
8 - Repeat off
10 - Settings
11 - Toggle compact view
12 - Toggle tree view
14 - Next: Move track to be played after current
15 - Skip: remove track from current list (not delete the file)
17 - (Re-)Shuffle 
19 - Toggle playlist view
21 - Reload file list
22 - Go to current track
23 - Mute
25 - Main menu IMHO не нужна

#ce

_TBClickButton($hToolBar, 0)

Func _TBClickButton($hToolBar, $iButtonID)
    Local $hTBBUTTON, $iProcessID, $hProcess, $hButton
    Local Const $t_TBBUTTON = "int Bitmap;" & _
                              "int Command;" & _
                              "byte State;" & _
                              "byte Style;" & _
                              "byte;" & _
                              "dword_ptr Param;" & _
                              "int_ptr String"
                              
    $hTBBUTTON = DllStructCreate($t_TBBUTTON)
    _WinAPI_GetWindowThreadProcessId($hToolBar, $iProcessID)
    $hProcess = _WinAPI_OpenProcess(BitOR($PROCESS_ALL_ACCESS, $PROCESS_DUP_HANDLE), True, $iProcessID)
    $hButton = _MemVirtualAllocEx($hProcess, 0, DllStructGetSize($hTBBUTTON), BitOR($MEM_COMMIT, $MEM_TOP_DOWN), $PAGE_READWRITE)
    _SendMessage($hToolBar, $TB_GETBUTTON,$iButtonID, $hButton)
    _WinAPI_ReadProcessMemory($hProcess, $hButton, DllStructGetPtr($hTBBUTTON), DllStructGetSize($hTBBUTTON), 0)
    _SendMessage($hToolBar, $WM_COMMAND , DllStructGetData($hTBBUTTON, "Command") , $hToolBar)
    _MemVirtualFreeEx($hProcess, $hButton, DllStructGetSize($hTBBUTTON), $MEM_RELEASE)
    _WinAPI_CloseHandle($hProcess)
EndFunc