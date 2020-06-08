#include <Array.au3>

$aWinList = WinList("[REGEXPCLASS:(Explore|Cabinet)WClass]")
ReDim $aWinList[$aWinList[0][0]+1][3]

For $i = 1 To UBound($aWinList) - 1
	$aWinList[$i][2]=_GetWindowsExplorerPath($aWinList[$i][1])
Next
_ArrayDisplay($aWinList, "aWinList")

; ===================================================================================================================
; Name...........: _GetWindowsExplorerPath
; Description....: Функция для получения пути в открытом окне эксплореа
; Syntax.........: _GetWindowsExplorerPath($hWnd)
; Parameters.....: $hWnd - Дескриптор окна эксплорера
; AutoIt Version.: 3.3.6.1
; Return values..: Успешно  -  Путь каталога, открытого в эксплорере
;                  Неудачно  -  0
;                               Устанавливает @error не равным нулю.
;                               @error = 1 - $hwnd не является дескриптором
;                               @error = 2 - $hwnd не является дескриптором окна эксплорера
;                               @error = 3 - объект "Shell.Application" не может быть создан
;                               @error = 4 - объект "$oShellApp.Windows()" не может быть создан
; Author.........: Ascend4nt, KaFu, klaus.s
; (урезал функцию AZJIO, оригинал здесь http://www.autoitscript.com/forum/topic/89833-windows-explorer-current-folder/page__view__findpost__p__875837)
; ===================================================================================================================

Func _GetWindowsExplorerPath($hWnd)
    If Not IsHWnd($hWnd) Then Return SetError(1)
    Local $aWinList = WinList("[REGEXPCLASS:(Explore|Cabinet)WClass]")
    While 1
        For $i = 1 To UBound($aWinList) - 1
            If $hWnd = $aWinList[$i][1] Then ExitLoop 2
        Next
        Return SetError(2)
    WEnd
    Local $oShellApp = ObjCreate("Shell.Application")
    If Not IsObj($oShellApp) Then Return SetError(3)
    Local $oShellApp_Windows = $oShellApp.Windows()
    If Not IsObj($oShellApp_Windows) Then Return SetError(4)
    For $oShellApp_Inst In $oShellApp_Windows
        If $oShellApp_Inst.hwnd = $hWnd Then ExitLoop
    Next
    Local $iShellApp_Inst_SelectedItems_Count = $oShellApp_Inst.Document.SelectedItems.Count
    Local $sShellApp_Inst_LocationURL = $oShellApp_Inst.LocationURL
    Local $aRet = DllCall('shlwapi.dll', 'long', 'PathCreateFromUrlW', 'wstr', $sShellApp_Inst_LocationURL, 'wstr', '', 'dword*', 65534, 'dword', 0)
    If Not @error And $aRet[0] = 0 Then $sShellApp_Inst_LocationURL = $aRet[2]
    $oShellApp = 0
    $oShellApp_Windows = 0
    $oShellApp_Inst = 0
    Return $sShellApp_Inst_LocationURL
EndFunc   ;==>_GetWindowsExplorerPath