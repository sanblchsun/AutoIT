MsgBox(0, 'Сообщение', _WinGetDesktopHandle())
; ===============================================================================================================================
; <_WinGetDesktopHandle.au3>
;
; Function to get the Windows' Desktop Handle.
;   Since this is no longer a simple '[CLASS:Progman]' on Aero-enabled desktops, this method uses a slightly
;   more involved method to find the correct Desktop Handle.
;
; Author: Ascend4nt, credits to Valik for pointing out the Parent->Child relationship: Desktop->'SHELLDLL_DefView'
; ===============================================================================================================================

Func _WinGetDesktopHandle()
	Local $i, $hDeskWin, $hSHELLDLL_DefView, $hListView
	; The traditional Windows Classname for the Desktop, not always so on newer O/S's
	$hDeskWin = WinGetHandle("[CLASS:Progman]")
	; Parent->Child relationship: Desktop->SHELLDLL_DefView
	$hSHELLDLL_DefView = ControlGetHandle($hDeskWin, '', '[CLASS:SHELLDLL_DefView; INSTANCE:1]')
	; No luck with finding the Desktop and/or child?
	If $hDeskWin = '' Or $hSHELLDLL_DefView = '' Then
		; Look through a list of WorkerW windows - one will be the Desktop on Windows 7+ O/S's
		$aWinList = WinList("[CLASS:WorkerW]")
		For $i = 1 To $aWinList[0][0]
			$hSHELLDLL_DefView = ControlGetHandle($aWinList[$i][1], '', '[CLASS:SHELLDLL_DefView; INSTANCE:1]')
			If $hSHELLDLL_DefView <> '' Then
				$hDeskWin = $aWinList[$i][1]
				ExitLoop
			EndIf
		Next
	EndIf
	; Parent->Child relationship: Desktop->SHELDLL_DefView->SysListView32
	$hListView = ControlGetHandle($hSHELLDLL_DefView, '', '[CLASS:SysListView32; INSTANCE:1]')
	If $hListView = '' Then Return SetError(-1, 0, '')
	Return SetExtended($hListView, $hDeskWin)
EndFunc   ;==>_WinGetDesktopHandle