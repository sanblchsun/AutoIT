;	_FileDialogsEx.au3 example #1:
;	create big resizeable file open dialog, defaulting to thumbnails view
; 	demonstrates how to set size/position of dialog window, how to set default view mode for listview.

#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include "_FileDialogsEx.au3"

Global $f_CDN_Start = 1

$Return = _FileOpenDialogEx("Open picture", @WindowsDir & "\Web\Wallpaper", "All Files (*.*)", BitOR($OFN_ENABLESIZING,$OFN_ALLOWMULTISELECT), "", 0, "_OFN_HookProc")
If @error Then 
	ConsoleWrite('No file selected.' & @CRLF)
Else
	ConsoleWrite($Return & @CRLF)
EndIf

Func _OFN_HookProc($hWnd, $Msg, $wParam, $lParam)
	Switch $Msg
		Case $WM_NOTIFY
			Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR
			$tNMHDR = DllStructCreate("hwnd hWndFrom;int idFrom;int code", $lParam)
			$hWndFrom = DllStructGetData($tNMHDR, "hWndFrom")
			$iIDFrom = DllStructGetData($tNMHDR, "idFrom")
			$iCode = DllStructGetData($tNMHDR, "code")
			Switch $iCode
				Case $CDN_INITDONE
				Case $CDN_FOLDERCHANGE
					If $f_CDN_Start Then;if executing first time
						Local $hODLV = _FindWindowEx($hWndFrom, 0, "SHELLDLL_DefView", "")
						If $hODLV <> 0 Then
							DllCall('user32.dll','int','SendMessage','hwnd',$hODLV,'uint',$WM_COMMAND,'wparam',$ODM_VIEW_THUMBS,'lparam',0)
						EndIf
						WinMove($hWndFrom, "", 0,0, 800,600, 0)
						$f_CDN_Start = 0;to make sure these tweaks happens only once.
					EndIf
				Case $CDN_SELCHANGE
				Case $CDN_FILEOK
			EndSwitch
		Case Else
	EndSwitch
EndFunc
Func _FindWindowEx($hWndParent,$hWndChildAfter,$sClassName,$sWinTitle="")
	Local $aRet = DllCall('user32.dll','hwnd','FindWindowEx', 'hwnd', $hWndParent,'hwnd',$hWndChildAfter,'str',$sClassName,'str',$sWinTitle)
	If $aRet[0] = 0 Then ConsoleWrite('_FindWindowEx() Error : ' & _WinAPI_GetLastErrorMessage())
	Return $aRet[0]
EndFunc

Exit