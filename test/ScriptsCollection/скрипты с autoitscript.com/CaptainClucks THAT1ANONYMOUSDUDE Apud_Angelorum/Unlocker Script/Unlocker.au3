#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Unlocker.ico
#AutoIt3Wrapper_Outfile=Unlocker.exe
#AutoIt3Wrapper_Outfile_x64=Unlocker[64].exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=File - Directory Unlocker
#AutoIt3Wrapper_Res_Fileversion=1.0.0.11
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 6
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/so
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.8.1

	Author :         Apud_Angelorum aka THAT1ANONYMOUSDUDE

	Credits:         Yashid, monoceres, wraithdu, Manko, JScript, Larry, _
	SmOke_N and mrRevoked, Trancexx

	And thanks to anyone who I have taken other code from
	but cannot remember where I found it or who made it.

	Script Function: Unlock files and directories.
	Autoit Unlocker - AutoIt script.

#ce ----------------------------------------------------------------------------

#include <WindowsConstants.au3>
#include <GuiStatusBar.au3>
#include <GuiListView.au3>
#include <GuiToolTip.au3>
#region - Globals -

;If @OSArch <> "X86" Then Exit MsgBox(16, "Advisory!", "This application is not compatable with the architecture of this operating system." & @CR & "The application will now exit.")

Global Const $hNTDLL = DllOpen("ntdll.dll")
Global Const $hPSAPI = DllOpen("psapi.dll")
Global Const $hUSER32 = DllOpen("user32.dll")
Global Const $hKERNEL32 = DllOpen("kernel32.dll")
Global Const $hADVAPI32 = DllOpen("advapi32.dll")

Global Const $Compiled = @Compiled
Global Const $Is64 = @AutoItX64

Global $temporariis
Global $Datum
Global $ProcessHwnd
Global $CurrentProcess

Global Const $Critical[13] = [ _
        'winlogon.exe', _
        'services.exe', _
        'csrss.exe', _
        'smss.exe', _
        'lsass.exe', _
        'alg.exe', _
        'svchost.exe', _
        'spoolsv.exe', _
        'wdfmgr.exe', _
        'dwm.exe', _
        'logonui.exe', _
        'wininit.exe', _
        'lsm.exe' _
        ]

;~ Global $sMicroSeconds = DllStructCreate("int64 100;int64 200")
;~ DllStructSetData($sMicroSeconds, 1, -10)
;~ DllStructSetData($sMicroSeconds, 2, -20)
;~ Global $1MS = DllStructGetPtr($sMicroSeconds, 1);very short sleep calls to keep CPU low when enumerating process handles
;~ Global $2MS = DllStructGetPtr($sMicroSeconds, 2)

Global $HasIconResource = 0
Global $hResEnumProc

Global $OwnerPrivilages = 0
Global $FileObject = 0

Global $ListView1
Global $StatusBar1
Global $progress
Global $hProgress

Global $GUIMINWID = 592; Resizing / minimum width
Global $GUIMINHT = 465; Resizing / minimum hight

Global Const $WS_RESIZABLE = 0x00070000
Global $hGUI

Global Const $DUPLICATE_CLOSE_SOURC = 0x00000001

#endregion - Globals -

_Main(FileSelectFolder('', ''))

Func _Main($BaseLocation)

    If Not FileExists($BaseLocation) Then Terminate()

    AutoItSetOption("GUIOnEventMode", 1)

    #region - GUI -

    $hGUI = GUICreate("AutoIt - UnLocker", $GUIMINWID, $GUIMINHT, -1, -1, BitOR($WS_RESIZABLE, $WS_CAPTION, $WS_POPUP))
    GUISetOnEvent(-3, "Terminate")
    If Not $Compiled Then GUISetIcon("Unlocker.ico")

    $StatusBar1 = _GUICtrlStatusBar_Create($hGUI)
    Local $StatusBar1_PartsWidth[4] = [100, 350, 99999, -1]
    _GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
    _GUICtrlStatusBar_SetText($StatusBar1, "Status: Idle", 0)
    $progress = GUICtrlCreateProgress(0, 0, -1, -1)
    $hProgress = GUICtrlGetHandle($progress)
    _GUICtrlStatusBar_EmbedControl($StatusBar1, 2, $hProgress)
    _GUICtrlStatusBar_SetMinHeight($StatusBar1, 20)

    $ListView1 = GUICtrlCreateListView("Process|Path Locked|PID|Handle|Process Path", 8, 8, 577, 401)
    GUICtrlSetOnEvent(-1, "SortIt")
    GUICtrlSetResizing(-1, 102)

    _GUICtrlListView_RegisterSortCallBack($ListView1)

    DllCall($hUSER32, "lresult", "SendMessageW", "hwnd", GUICtrlGetHandle($ListView1), "uint", 0x1000 + 30, "wparam", 0, "lparam", 85)
    DllCall($hUSER32, "lresult", "SendMessageW", "hwnd", GUICtrlGetHandle($ListView1), "uint", 0x1000 + 30, "wparam", 1, "lparam", 200)
    DllCall($hUSER32, "lresult", "SendMessageW", "hwnd", GUICtrlGetHandle($ListView1), "uint", 0x1000 + 30, "wparam", 3, "lparam", 50)
    DllCall($hUSER32, "lresult", "SendMessageW", "hwnd", GUICtrlGetHandle($ListView1), "uint", 0x1000 + 30, "wparam", 4, "lparam", 200)

    GUICtrlCreateButton("Quit", 528, 416, 57, 22)
    GUICtrlSetOnEvent(-1, "Terminate")
    GUICtrlSetResizing(-1, 768 + 4 + 64)

    GUICtrlCreateButton("Unlock All", 440, 416, 81, 22)
    GUICtrlSetOnEvent(-1, "UnlockAll")
    GUICtrlSetResizing(-1, 768 + 4 + 64)
    _GuiCtrlSetTip(-1, "Will unlock all items in the list view, use with caution!", "Warning!", @ScriptFullPath & ",99", 3, 0x000000, 0xFFFF00, 1000)

    GUICtrlCreateButton("Unlock", 368, 416, 65, 22)
    GUICtrlSetOnEvent(-1, "Unlock")
    GUICtrlSetResizing(-1, 768 + 4 + 64)

    GUICtrlCreateButton("Kill Process", 280, 416, 81, 22)
    GUICtrlSetOnEvent(-1, "_ProcessClose")
    GUICtrlSetResizing(-1, 768 + 4 + 64)
    _GuiCtrlSetTip(-1, "Take coution not to terminate a critical process!", "Warning!", @ScriptFullPath & ",99", 3, 0x000000, 0xFF0000, 1000)

    Local $Context = GUICtrlCreateContextMenu($ListView1)

    GUICtrlCreateMenuItem("Unlock", $Context)
    GUICtrlSetOnEvent(-1, "Unlock")

    GUICtrlCreateMenuItem("Terminate", $Context)
    GUICtrlSetOnEvent(-1, "_ProcessClose")

    GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")
    GUIRegisterMsg($WM_SIZE, "MY_WM_SIZE")

    GUISetState()

    #endregion - GUI -

    AdjustPrivilege(20)

    Local $aHandles = _ListHwnds(0, $Is64);change second parameter to true in order to skip critical system files.
    ;Local $aModuals = _ProcessListModules()

    If @error Then Exit MsgBox(16, "Error Code: " & @error & " Extended: " & @extended, "The application has encounterd an error and will now close, sorry for the inconvenience.", 0, $hGUI)
    If UBound($aHandles) < 1 Then Exit MsgBox(64, "Advisory", "No handles seem to have been fetched during the process, the application will now close.", 0, $hGUI)

    Local $Datum
    Local $Entry = 0
    Local $Temp
    Local $Size = UBound($aHandles) - 1
    Local $Items = 0

    _GUICtrlStatusBar_SetText($StatusBar1, "Stage 4 of 6", 0)
    _GUICtrlStatusBar_SetText($StatusBar1, "Building List...", 1)

    For $I = 0 To $Size
        ;If Random(0,5,1) = 3 Then DllCall($hNTDLL, "dword", "NtDelayExecution", "int", 0, "ptr", $2MS)
        GUICtrlSetData($progress, 100 * $I / $Size)
        If StringInStr($aHandles[$I][2], $BaseLocation, 2) Then
            $Datum = _ProcessGetPath($aHandles[$I][0])
            ;$aHandles[$I][0]
            $Temp = $Datum
            $Datum = StringSplit($Datum, "\")
            $Entry = $Datum[$Datum[0]] & "|" & $aHandles[$I][2] & "|" & $aHandles[$I][0] & "|" & String($aHandles[$I][1]) & "|" & $Temp
			If $Is64 Then
				GUICtrlCreateListViewItem($Entry, $ListView1)
			Else
				_CheckIconResource($Temp, GUICtrlCreateListViewItem($Entry, $ListView1))
			EndIf
            $Items += 1
        EndIf
    Next
    GUICtrlSetData($progress, 0)

	If Not $Is64 Then

		_GUICtrlStatusBar_SetText($StatusBar1, "Stage 5 of 6", 0)
		_GUICtrlStatusBar_SetText($StatusBar1, "Discovering Dlls...", 1)

		$aHandles = _ListModules()
		$Size = UBound($aHandles) - 1

		_GUICtrlStatusBar_SetText($StatusBar1, "Stage 6 of 6", 0)
		_GUICtrlStatusBar_SetText($StatusBar1, "Building List...", 1)

		For $I = 0 To $Size
			;If Random(0,5,1) = 3 Then DllCall($hNTDLL, "dword", "NtDelayExecution", "int", 0, "ptr", $2MS)
			GUICtrlSetData($progress, 100 * $I / $Size)
			If $aHandles[$I][4] = 65535 Then ContinueLoop
			If StringInStr($aHandles[$I][1], $BaseLocation, 2) Then
				$Datum = _ProcessGetPath($aHandles[$I][2])
				;$aHandles[$I][0]
				$Temp = $Datum
				$Datum = StringSplit($Datum, "\")
				$Entry = "*" & $Datum[$Datum[0]] & "|" & $aHandles[$I][1] & "|" & $aHandles[$I][2] & "|" & String($aHandles[$I][3]) & "|" & $Temp ; signify dll
				_CheckIconResource($Temp, GUICtrlCreateListViewItem($Entry, $ListView1))
				$Items += 1
			EndIf
		Next
		GUICtrlSetData($progress, 0)
	EndIf

    _GUICtrlStatusBar_SetText($StatusBar1, "Status: Idle", 0)
    _GUICtrlStatusBar_SetText($StatusBar1, "Listing " & $Items & " item(s)", 1)

    Sleep(999999999)

    Exit

EndFunc   ;==>_Main

#region - EVENTS -

Func _ProcessClose()
    Local $Temp
    Local $Data = FetchListViewEntry($ListView1, 3)
    If @error Then Return
    If ProcessClose($Data[0]) Then GUICtrlDelete($Data[1])
    Local $ItemCount = _GUICtrlListView_GetItemCount($ListView1)
    For $I = 0 To $ItemCount
        GUICtrlSetData($progress, 100 * $I / $ItemCount)
        $Temp = _GUICtrlListView_GetItemText($ListView1, $I, 2)
        If (Int($Temp) = Int($Data[0])) Then
            _GUICtrlListView_DeleteItem($ListView1, $I)
            $I = 0
        EndIf
    Next
    GUICtrlSetData($progress, 0)
EndFunc   ;==>_ProcessClose

Func UnlockAll()
    Switch MsgBox(3 + 48 + 256 + 262144, "Warning!", "This is not recomended! This can also take a long time, continue?", 0, $hGUI)
        Case 6

            Local $ItemCount = _GUICtrlListView_GetItemCount($ListView1)
            Local $PID
            Local $Handle
            Local $Stolen
            Local $Name
            Local $Test[2]

            $CurrentProcess = DllCall($hKERNEL32, "handle", "GetCurrentProcess")

			Beep(100,100)

            For $I = 0 To $ItemCount
                GUICtrlSetData($progress, 100 * $I / $ItemCount)
                $Name = _GUICtrlListView_GetItemText($ListView1, $I, 0)
                $PID = _GUICtrlListView_GetItemText($ListView1, $I, 2)
                $Handle = _GUICtrlListView_GetItemText($ListView1, $I, 3)

                Switch StringLeft($Name, 1)
                    Case "*"
                        $Test[0] = _ProcessListModulesCount($PID)
                        _UnloadDll($PID, $Handle)
                        $Test[1] = _ProcessListModulesCount($PID)
                        Switch ($Test[0] <> $Test[1])
                            Case True
								_GUICtrlListView_DeleteItem($ListView1,$I)

                        EndSwitch

                    Case Else

                        $ProcessHwnd = DllCall("Kernel32.dll", "ptr", "OpenProcess", "dword", $PROCESS_DUP_HANDLE, "int", 0, "dword", $PID)
                        If @error Or Not $ProcessHwnd[0] Then ContinueLoop
                        $ProcessHwnd = $ProcessHwnd[0]

                        $Stolen = DllCall($hKERNEL32, "int", _
                                "DuplicateHandle", _
                                "ptr", $ProcessHwnd, _
                                "ptr", $Handle, _
                                "ptr", $CurrentProcess[0], _
                                "ptr", 0, _
                                "dword", 2, _
                                "int", 0, _
                                "dword", $DUPLICATE_CLOSE_SOURC _
                                )
						If Not @error Then; And Not $Stolen[0] Then ; I don't get why the return value is zero even though it works :/
							_GUICtrlListView_DeleteItem($ListView1,$I)
							DllCall($hKERNEL32, 'ptr', 'CloseHandle', 'ptr', $Stolen[4])
						EndIf

                        DllCall($hKERNEL32, 'ptr', 'CloseHandle', 'ptr', $ProcessHwnd)

                EndSwitch

            Next

            DllCall($hKERNEL32, 'ptr', 'CloseHandle', 'ptr', $CurrentProcess[0])

            GUICtrlSetData($progress, 0)

            Return

        Case Else
            Return
    EndSwitch

EndFunc   ;==>UnlockALl

Func Unlock()
    Local $Stolen
    Local $Return = FetchListViewEntry($ListView1, 4)
    Local $Ext = FetchListViewEntry($ListView1, 3)
    Local $Name = FetchListViewEntry($ListView1, 1, 0)
    Local $Test[2]
    Local $temporariis[3]

    If @error Then Return 0

    Switch StringLeft($Name, 1)
        Case "*"
            $Test[0] = _ProcessListModulesCount($Ext[0])
            _UnloadDll($Ext[0], $Return[0])
            $Test[1] = _ProcessListModulesCount($Ext[0])
            Switch ($Test[0] <> $Test[1])
                Case True
                    $temporariis[0] = FetchListViewEntry($ListView1, 1, 0)
                    $temporariis[1] = FetchListViewEntry($ListView1, 2, 0)
                    $temporariis[2] = FetchListViewEntry($ListView1, 3, 0)
                    GUICtrlSetData($Return[1], $temporariis[0] & "|" & $temporariis[1] & "|" & $temporariis[2] & "|CLOSED!")
                    GUICtrlSetBkColor($Return[1], 0x00FF00)

                Case Else
                    GUICtrlSetBkColor($Return[1], 0xFF0000)

            EndSwitch

        Case Else

            $CurrentProcess = DllCall($hKERNEL32, "handle", "GetCurrentProcess")
            $ProcessHwnd = DllCall("Kernel32.dll", "ptr", "OpenProcess", "dword", $PROCESS_DUP_HANDLE, "int", 0, "dword", $Ext[0])
            If @error Or Not $ProcessHwnd[0] Then
                DllCall($hKERNEL32, 'ptr', 'CloseHandle', 'ptr', $CurrentProcess[0])
                GUICtrlSetBkColor($Return[1], 0xFF0000)
                Return
            EndIf

            $ProcessHwnd = $ProcessHwnd[0]

            $Stolen = DllCall($hKERNEL32, "int", _; no need to check for errors here since we already have access for doing this
                    "DuplicateHandle", _
                    "ptr", $ProcessHwnd, _
                    "ptr", $Return[0], _
                    "ptr", $CurrentProcess[0], _
                    "ptr", 0, _
                    "dword", 2, _
                    "int", 0, _
                    "dword", $DUPLICATE_CLOSE_SOURC _
                    )
			If Not @error Then; And Not $Stolen[0] Then ; I don't get why the return value is zero even though it works :/
				$Stolen = $Stolen[4]

				DllCall($hKERNEL32, 'ptr', 'CloseHandle', 'ptr', $ProcessHwnd)
				DllCall($hKERNEL32, 'ptr', 'CloseHandle', 'ptr', $Stolen)

				$temporariis[0] = FetchListViewEntry($ListView1, 1, 0)
				$temporariis[1] = FetchListViewEntry($ListView1, 2, 0)
				$temporariis[2] = FetchListViewEntry($ListView1, 3, 0)
				GUICtrlSetData($Return[1], $temporariis[0] & "|" & $temporariis[1] & "|" & $temporariis[2] & "|CLOSED!")
				GUICtrlSetBkColor($Return[1], 0x00FF00)
			Else
				GUICtrlSetBkColor($Return[1], 0xFF0000)
			EndIf

    EndSwitch

    Return 0

EndFunc   ;==>Unlock

Func SortIt()
    _GUICtrlListView_SortItems($ListView1, GUICtrlGetState($ListView1))
EndFunc   ;==>SortIt

#endregion - EVENTS -

#region - Main -

; #FUNCTION# ====================================================================================================================
; Name ..........: _ListHwnds
; Description ...: Returns a list of obtainable handles in a specified process, some handles cannot be obtained. This is limited
;                       to directories only! In order to unlock files in use, I'd recommend an application like the well known
;                       "unlocker.exe" that uses a kernel mode driver to handle this.
; Syntax ........: _ListHwnds([$PID = 0[, $IgnoreSys = 0[, $FileObject]]])
; Parameters ....: $PID                 - [optional] PID of process to retrieve hwnds from. Default is 0, which is all processes.
;                  $IgnoreSys           - [optional] True to ignore system files, false otherwise. Default is false.
;                  $FileObject          - [Internal] Ignore this parameter, it is used only by the function.
; Return values .: An array of hwnds and process inforamtion.
; Authors .......: Yashied, monoceres, wraithdu, Manko, THAT1ANONYMOUSDUDE
; Modified ......:
; Remarks .......: This function is a compilation of different peoples code, a lot of yashideds winapiex code
;                  was taken to create this, the reason I took functions apart and created this frankenstein-ish function
;                  is for speed, I must also give credit to everyone listed in Authors because I have also taken bits and
;                  snips of code from them. I noticed that this was too slow when including winapiex.au3 so I took apart
;                  the things that were needed and the end result was this function which is monsterously faster than before.
;
; Related .......:
; Link ..........: http://www.autoitscript.com/forum/topic/139347-autoit-unlocker/
;                  http://www.autoitscript.com/forum/topic/83145-basic-file-unlocker/page__st__20
;                  http://www.autoitscript.com/forum/topic/84939-prodller-unknown-code-running-befriend-or-kill/page__view__findpost__p__703384
;
; Example .......: No
; ===============================================================================================================================

Func _ListHwnds($PID = 0, $IgnoreSys = 0, $FileObject = 0)

    If $FileObject = 0 Then
        If Not IsArray($FileObject) Then
            $FileObject = _ListHwnds(False, False, -1)
            If @error Then Return SetError(1, @error, 0)
        EndIf
    EndIf

    Local $tSHI
    Local $tHandle
    Local $pData
    Local $Ret
    Local $Size
    Local $ResultCount
    Local $IgnoreList
    Local $temporariis
    Local $OS

    Switch @OSVersion
        Case "WIN_XP", "WIN_7"
            $OS = 1
    EndSwitch

    $tSHI = DllStructCreate('ulong;byte[4194304]')



    $Ret = DllCall($hNTDLL, 'uint', 'NtQuerySystemInformation', 'uint', 16, 'ptr', DllStructGetPtr($tSHI), 'ulong', DllStructGetSize($tSHI), 'ulong*', 0)
    If @error Then
        Return SetError(2, 0, 0)
    Else
        If $Ret[0] Then
            Return SetError(3, 0, 0)
        EndIf
    EndIf

    Local $Status, $Op
    $pData = DllStructGetPtr($tSHI, 2)
    ;$Size = DllStructGetSize(DllStructCreate('ulong;ubyte;ubyte;ushort;ptr;ulong'))

    #region - Globalization -

    If $FileObject = -1 Then

        _GUICtrlStatusBar_SetText($StatusBar1, "Stage 1 of 6", 0)
        _GUICtrlStatusBar_SetText($StatusBar1, "Discovering object types...", 1)

        Local $aObject[1][2]

		#CS
			In an attempt to make this globally operable with on a multitude of varying operating system types
			I have taken the approach of discovering the system file object type by using this code
			below in order to avoid depending on a static value that may not be accurate.
		#CE

        Local $tPOTI = DllStructCreate('ushort;ushort;ptr;byte[128]')
        $Status = DllStructGetData($tSHI, 1)
        For $I = 1 To $Status
            GUICtrlSetData($progress, 100 * $I / $Status)
            ;If Random(0,5,1) = 3 Then DllCall($hNTDLL, "dword", "NtDelayExecution", "int", 0, "ptr", $1MS)

			If $Is64 Then
				$OP = 4 + ($i - 1) * 24
			Else
				$OP = ($i - 1) * 16
			EndIf

            $tHandle = DllStructCreate('align 4;ulong;ubyte;ubyte;ushort;ptr;ulong', $pData + $OP)
            If DllStructGetData($tHandle, 1) <> @AutoItPID Then ContinueLoop; only search our process for now
            $temporariis = Ptr(DllStructGetData($tHandle, 4))
            Local $Ret2 = DllCall($hNTDLL, 'uint', 'NtQueryObject', 'ptr', $temporariis, 'uint', 2, 'ptr', DllStructGetPtr($tPOTI), 'ulong', DllStructGetSize($tPOTI), 'ptr', 0)
            If @error Then
                ContinueLoop;I figured we don't need to return any errors, we can still continue without fear here.
                ;Return SetError(4, 0, 0)
            Else
                If $Ret2[0] Then
                    ContinueLoop
                    ;Return SetError(5, 0, 0)
                EndIf
            EndIf
            ;DllCall($hNTDLL, "dword", "NtDelayExecution", "int", 0, "ptr", $1MS)
            Local $pData2 = DllStructGetData($tPOTI, 3)
            If Not $pData2 Then
                ContinueLoop
                ;Return SetError(6, 0, 0)
            EndIf
            Local $Length = DllCall($hKERNEL32, 'int', 'lstrlenW', 'ptr', $pData2)
            If @error Then
                ContinueLoop
                ;Return SetError(7, 0, 0)
            EndIf
            $Length = $Length[0]
            If @error Then
                ContinueLoop
                ;Return SetError(8, 0, 0)
            EndIf
            If Not $Length Then
                ContinueLoop
                ;Return SetError(9, 0, 0)
            EndIf
            Local $tString = DllStructCreate('wchar[' & ($Length + 1) & ']', $pData2)
            If @error Then
                ContinueLoop
                ;Return SetError(10, 0, 0)
            EndIf
            If DllStructGetData($tString, 1) == "File" Then; Or DllStructGetData($tString, 1) == "Process" Then;we found the type needed
                ;I believe we can't really do anything with process objects so I may remove this part in the furure.
                For $M = 0 To UBound($aObject) - 1
                    If $aObject[$M][0] == DllStructGetData($tHandle, 2) Then ContinueLoop (2); for some reason I get an error here when using continueloop
                Next
                $aObject[0][0] = DllStructGetData($tHandle, 2);return it so we can use it to find them
                $aObject[0][1] = DllStructGetData($tString, 1)
                Return SetError(0, 0, $aObject)
            EndIf
        Next
        Return SetError(13, 0, 0)
    EndIf

    #endregion - Globalization -

    Local $CurrentPID
    Local $iTotalHandles
    Local $Result[99999][4]

    If $IgnoreSys Then
        For $I = 0 To UBound($Critical) - 1
            $temporariis = ProcessList($Critical[$I])
            For $x = 1 To $temporariis[0][0]
                $IgnoreList &= $temporariis[$x][1] & "|"
            Next
        Next
    EndIf

;~ 	If $PID Then
;~ 		Local $pHandle = DllCall($hKERNEL32, "ptr", "OpenProcess", "int", 0x1F0FFF, "int", 0, "int", $PID)
;~ 		$iTotalHandles = DllCall($hKERNEL32,"int","GetProcessHandleCount","ptr",$pHandle[0],"DWORD*",0)
;~ 		DllCall($hKERNEL32, 'ptr', 'CloseHandle', 'ptr', $pHandle[0])
;~ 		$iTotalHandles = $iTotalHandles[2]
;~ 	Else
;~ 		Local $tPI = DllStructCreate($TagPERFORMANCE_INFORMATION)
;~ 		DllCall($hPSAPI, 'int', 'GetPerformanceInfo', 'ptr', DllStructGetPtr($tPI), 'dword', DllStructGetSize($tPI))
;~ 		$iTotalHandles = DllStructGetData($tPI, 12)
;~ 	EndIf

    $Status = DllStructGetData($tSHI, 1)
    _GUICtrlStatusBar_SetText($StatusBar1, "Stage 2 of 6", 0)
    _GUICtrlStatusBar_SetText($StatusBar1, "Filtering...", 1)

    For $I = 1 To $Status
        GUICtrlSetData($progress, 100 * $I / $Status)

		If $Is64 Then
			$OP = 4 + ($i - 1) * 24
		Else
			$OP = ($i - 1) * 16
		EndIf

		$tHandle = DllStructCreate('align 4;ulong;ubyte;ubyte;ushort;ptr;ulong', $pData + $OP)
        $CurrentPID = DllStructGetData($tHandle, 1)
        If $CurrentPID <> 0 And $CurrentPID <> 4 Then

            If $PID Then
                If Not ($CurrentPID == $PID) Then ContinueLoop
            EndIf
            If $IgnoreSys Then
                If StringInStr($IgnoreList, $CurrentPID, 2) <> 0 Then ContinueLoop
            EndIf

            #region - Danger Zone -

            ;We need to avoid these attributes or we will freeze indefinately.
            $temporariis = DllStructGetData($tHandle, 6)
            If $temporariis == 0x00120189 Then ContinueLoop
            If $temporariis == 0x0012019f Then ContinueLoop
            If $temporariis == 0x00100000 Then ContinueLoop

            If $OS Then
                If Not 0x00100020 == $temporariis Then ContinueLoop
            Else
                ;Just include it since I don't really know what I should be looking for on any other OS...
            EndIf

            ;If Random(0,5,1) = 3 Then DllCall($hNTDLL, "dword", "NtDelayExecution", "int", 0, "ptr", $1MS)

            #endregion - Danger Zone -
            $Ret = DllStructGetData($tHandle, 2)
            If $Ret = $FileObject[0][0] Then
                $ResultCount += 1
                ;ReDim $Result[$ResultCount + 1][4]
                $Result[$ResultCount - 1][0] = $CurrentPID
                $Result[$ResultCount - 1][1] = Ptr(DllStructGetData($tHandle, 4))
                $Result[$ResultCount - 1][2] = DllStructGetData($tHandle, 2)
                ;If CloseHandle($CurrentPID,Ptr(DllStructGetData($tHandle, 4))) Then ConsoleWrite(DllStructGetData($tHandle, 2) & @CR); Don't do it D:
            EndIf
        EndIf
    Next

    If Not $ResultCount Then
        Return SetError(11, 0, 0)
    Else
        ReDim $Result[$ResultCount][3]
    EndIf

    Local $hSource
    Local $hObject
    Local $TempDat[99999][3]
    Local $TempCount
    Local $LastPID

    Local $hTarget = DllCall($hKERNEL32, "handle", "GetCurrentProcess")
    If @error Then Return SetError(14, 0, 0)
    $hTarget = $hTarget[0]

    Local $struct = DllStructCreate("char[255];")
    Local $Temp = DriveGetDrive("ALL")
    Local $drivesinfo[UBound($Temp) - 1][2]
    For $I = 0 To UBound($drivesinfo) - 1
        $drivesinfo[$I][0] = $Temp[$I + 1]
        DllCall($hKERNEL32, "dword", "QueryDosDevice", "str", $drivesinfo[$I][0], "ptr", DllStructGetPtr($struct), "dword", 255)
        $drivesinfo[$I][1] = DllStructGetData($struct, 1)
    Next

    Local $PUBLIC_OBJECT_TYPE_INFORMATION = "ushort Length;" & _
            "ushort MaximumLength;" & _
            "ptr Buffer;" & _ ;UNICODE_STRING struct
            "wchar Reserved[260];"

    Local $poti = DllStructCreate($PUBLIC_OBJECT_TYPE_INFORMATION)
    Local $devicestr
    Local $Solid

    $iTotalHandles = UBound($Result) - 1

    _GUICtrlStatusBar_SetText($StatusBar1, "Stage 3 of 6", 0)
    _GUICtrlStatusBar_SetText($StatusBar1, "Resolving Objects...", 1)

    For $I = 0 To $iTotalHandles
        GUICtrlSetData($progress, 100 * $I / $iTotalHandles)
        If Not $LastPID Or $Result[$I][0] <> $LastPID Then
            If $LastPID Then DllCall($hKERNEL32, 'ptr', 'CloseHandle', 'ptr', $hSource)
            $hSource = DllCall($hKERNEL32, 'int', "OpenProcess", "int", $PROCESS_DUP_HANDLE, "int", 0, "int", $Result[$I][0])
            If @error Then ContinueLoop
            $hSource = $hSource[0]
            $LastPID = $Result[$I][0]
        EndIf

        $hObject = DllCall($hKERNEL32, _;there is a small chance that we can freeze here...
                "bool", "DuplicateHandle", _; if we do freeze here, our script can only be killed by
                "handle", $hSource, _; killing the process that we tried to hijack a handle from.
                "handle", $Result[$I][1], _
                "handle", $hTarget, _
                "handle*", 0, _
                "dword", 0, _
                "bool", 0, _
                "dword", $DUPLICATE_SAME_ACCESS _
                )
        If @error Then ContinueLoop
        $hObject = $hObject[4]

        $Solid = False
        If $Result[$I][2] = $FileObject[0][0] Then
            DllCall($hNTDLL, "ulong", "NtQueryObject", "ptr", $hObject, "int", 1, "ptr", DllStructGetPtr($poti), "ulong", DllStructGetSize($poti), "ulong*", "")
            $devicestr = DllStructCreate("wchar[" & Ceiling(DllStructGetData($poti, "Length") / 2) & "];", DllStructGetData($poti, "buffer"))
            $devicestr = DllStructGetData($devicestr, 1)

            For $y = 0 To UBound($drivesinfo) - 1
                If StringLeft($devicestr, StringLen($drivesinfo[$y][1])) = $drivesinfo[$y][1] Then
                    $Solid = StringUpper($drivesinfo[$y][0]) & StringTrimLeft($devicestr, StringLen($drivesinfo[$y][1]))
                    ExitLoop
                EndIf
            Next
        Else
            $Solid = DllCall("kernel32.dll", "int", "GetProcessId", "hwnd", $hObject)
            If Not @error Then
                $Solid = _ProcessGetPath($Solid[0])
            Else
                $Solid = "N/A"
            EndIf
        EndIf

        ;If Random(0,5,1) = 3 Then DllCall($hNTDLL, "dword", "NtDelayExecution", "int", 0, "ptr", $1MS) ; uncomment to save CPU resources

        If $Solid Then
            $TempCount += 1
            ;ReDim $TempDat[$TempCount + 1][3]
            $TempDat[$TempCount - 1][0] = $Result[$I][0];pid
            $TempDat[$TempCount - 1][1] = $Result[$I][1];hwnd
            $TempDat[$TempCount - 1][2] = $Solid
        EndIf

        DllCall($hKERNEL32, 'ptr', 'CloseHandle', 'ptr', $hObject)

    Next

    DllCall($hKERNEL32, 'ptr', 'CloseHandle', 'ptr', $hSource)

    GUICtrlSetData($progress, 0)

    If $TempCount Then
        ReDim $TempDat[$TempCount][3]
        Return SetError(0, 0, $TempDat)
    Else
        Return SetError(12, 0, 0)
    EndIf
EndFunc   ;==>_ListHwnds

; #FUNCTION# ====================================================================================================================
; Name ..........: _ProcessListModules
; Description ...: Returns loaded dlls in a process
; Syntax ........: _ProcessListModules($dwPID)
; Parameters ....: $dwPID               - Process ID.
; Return values .: Array with lots of info
; Author ........: Smoke_N
; Example .......: No
; ===============================================================================================================================

Func _ListModules()

    ;If $dwPID = 0 Or  $dwPID = 4 Then Return @error

    Local $modlist[99999][7]
    Local $iAdd = 0

    Local Const $TH32CS_SNAPMODULE = 0x08

    Local $Plist = ProcessList()

    For $x = 1 To $Plist[0][0]
        GUICtrlSetData($progress, 100 * $x / $Plist[0][0])
        If Not $Plist[$x][1] Or $Plist[$x][1] = 4 Then ContinueLoop
        Local $aDLLCall = DllCall($hKERNEL32, "ptr", "CreateToolhelp32Snapshot", "int", $TH32CS_SNAPMODULE, "dword", $Plist[$x][1])
        Local $hModuleSnap = $aDLLCall[0]
        Local $tagMODULEENTRY32 = DllStructCreate("dword;dword;dword;dword;dword;byte;dword;ptr;char[256];char[257]")
        DllStructSetData($tagMODULEENTRY32, 1, DllStructGetSize($tagMODULEENTRY32))
        $aDLLCall = DllCall($hKERNEL32, "int", "Module32First", "ptr", $hModuleSnap, "long", DllStructGetPtr($tagMODULEENTRY32))
        $aDLLCall = DllCall($hKERNEL32, "int", "Module32Next", "ptr", $hModuleSnap, "long", DllStructGetPtr($tagMODULEENTRY32))
        While 1
            If Not $aDLLCall[0] Then ExitLoop
            While 1
;~ 		typedef struct tagMODULEENTRY32 {
                ;$avArray[$iAdd][0] = DllStructGetData($tagMODULEENTRY32, 1) ;~ 			DWORD   dwSize;
                ;$avArray[$iAdd][1] = DllStructGetData($tagMODULEENTRY32, 2) ;~ 			DWORD   th32ModuleID;
                $modlist[$iAdd][2] = DllStructGetData($tagMODULEENTRY32, 3) ;~ 				DWORD   th32ProcessID;
                ;$avArray[$iAdd][3] = DllStructGetData($tagMODULEENTRY32, 4) ;~ 			DWORD   GlblcntUsage;
                $modlist[$iAdd][4] = DllStructGetData($tagMODULEENTRY32, 5) ;~ 				DWORD   ProccntUsage;
                ;$avArray[$iAdd][5] = DllStructGetData($tagMODULEENTRY32, 6) ;~ 			BYTE  * modBaseAddr;
                ;$modlist[$iAdd][2] = DllStructGetData($tagMODULEENTRY32, 7) ;~ 				DWORD   modBaseSize;
                $modlist[$iAdd][3] = DllStructGetData($tagMODULEENTRY32, 8) ;~ 				HMODULE hModule;
                $modlist[$iAdd][0] = DllStructGetData($tagMODULEENTRY32, 9) ;~ 				char    szModule[MAX_MODULE_NAME32 + 1];
                $modlist[$iAdd][1] = StringLower(DllStructGetData($tagMODULEENTRY32, 10));~ char    szExePath[MAX_PATH];
;~ 		} MODULEENTRY32;

                $aDLLCall = DllCall($hKERNEL32, "int", "Module32Next", "ptr", $hModuleSnap, "long", DllStructGetPtr($tagMODULEENTRY32))
                $iAdd += 1
                If Not $aDLLCall[0] Then ExitLoop 2
            WEnd
        WEnd
    Next

    ReDim $modlist[$iAdd][5]
    GUICtrlSetData($progress, 0)
    DllCall($hKERNEL32, "int", "CloseHandle", "ptr", $hModuleSnap)
    Return $modlist
EndFunc   ;==>_ListModules

Func _ProcessListModulesCount($dwPID)

    Local $iAdd = 0

    Local Const $TH32CS_SNAPMODULE = 0x08
    Local $aDLLCall = DllCall($hKERNEL32, "ptr", "CreateToolhelp32Snapshot", "int", $TH32CS_SNAPMODULE, "dword", $dwPID)
    Local $hModuleSnap = $aDLLCall[0]
    Local $tagMODULEENTRY32 = DllStructCreate("dword;dword;dword;dword;dword;byte;dword;ptr;char[256];char[257]")
    DllStructSetData($tagMODULEENTRY32, 1, DllStructGetSize($tagMODULEENTRY32))
    $aDLLCall = DllCall($hKERNEL32, "int", "Module32First", "ptr", $hModuleSnap, "long", DllStructGetPtr($tagMODULEENTRY32))
    $aDLLCall = DllCall($hKERNEL32, "int", "Module32Next", "ptr", $hModuleSnap, "long", DllStructGetPtr($tagMODULEENTRY32))

    If $aDLLCall[0] Then
        While 1
            $aDLLCall = DllCall($hKERNEL32, "int", "Module32Next", "ptr", $hModuleSnap, "long", DllStructGetPtr($tagMODULEENTRY32))
            $iAdd += 1
            If Not $aDLLCall[0] Then ExitLoop
        WEnd
    EndIf

    DllCall($hKERNEL32, "int", "CloseHandle", "ptr", $hModuleSnap)
    Return $iAdd
EndFunc   ;==>_ProcessListModulesCount

; #FUNCTION# ====================================================================================================================
; Name ..........: _UnloadDll
; Description ...: Unloads a dll from the given process
; Syntax ........: _UnloadDll($PID, $hMod[, $tries = 20])
; Parameters ....: $PID                 - Process ID.
;                  $hMod                - A handle value of the dll in the process.
;                  $tries               - [optional] Number of attempts to try. Default is 20.
; Return values .: None
; Author ........: Manko?
; Example .......: No
; ===============================================================================================================================

Func _UnloadDll($PID, $hMod, $tries = 20)
    Local $hThread
    Local $pHandle = DllCall($hKERNEL32, "int", "OpenProcess", "int", BitOR($PROCESS_CREATE_THREAD, $PROCESS_QUERY_INFORMATION, $PROCESS_VM_OPERATION, $PROCESS_VM_WRITE, $PROCESS_VM_READ), "int", 0, "int", $PID)
    Local $modHandle = DllCall($hKERNEL32, "long", "GetModuleHandle", "str", "kernel32.dll")
    Local $FreeLibrary = DllCall($hKERNEL32, "long", "GetProcAddress", "long", $modHandle[0], "str", "FreeLibrary")
    For $I = 1 To $tries
        $hThread = DllCall($hKERNEL32, "int", "CreateRemoteThread", "int", $pHandle[0], "int", 0, "int", 0, "long", $FreeLibrary[0], "long", $hMod, "int", 0, "int", 0)
        DllCall($hKERNEL32, "int", "CloseHandle", "int", $hThread[0])
    Next
    DllCall($hKERNEL32, "int", "CloseHandle", "int", $modHandle[0])
    DllCall($hKERNEL32, "int", "CloseHandle", "int", $pHandle[0])
    Return True
EndFunc   ;==>_UnloadDll

; #FUNCTION# ====================================================================================================================
; Name ..........: _ProcessGetPath
; Description ...: Gets the image base of a process
; Syntax ........: _ProcessGetPath($vProcess)
; Parameters ....: $vProcess            - Process ID.
; Return values .: Image base of given process
; Author ........: JScript, Larry, SmOke_N and mrRevoked
; Example .......: No
; ===============================================================================================================================

Func _ProcessGetPath($vProcess)
    Local $i_PID, $aProcessHandle, $tDLLStruct, $iError, $sProcessPath
    $i_PID = ProcessExists($vProcess)
    If Not $i_PID Then Return SetError(1, 0, "");process doesn't exist?
    $aProcessHandle = DllCall($hKERNEL32, "int", "OpenProcess", "int", $PROCESS_QUERY_INFORMATION + $PROCESS_VM_READ, "int", 0, "int", $i_PID)
    $iError = @error
    If $iError Or $aProcessHandle[0] = 0 Then
        Return SetError(2, $iError, "");openprocess failed
    EndIf
    $tDLLStruct = DllStructCreate("char[1000]")
    DllCall($hPSAPI, "long", "GetModuleFileNameEx", "int", $aProcessHandle[0], "int", 0, "ptr", DllStructGetPtr($tDLLStruct), "long", DllStructGetSize($tDLLStruct))
    $iError = @error
    DllCall($hKERNEL32, "int", "CloseHandle", "int", $aProcessHandle[0])
    If $iError Then
        $tDLLStruct = 0
        Return SetError(4, $iError, "");getmodulefilenamex failed
    EndIf
    $sProcessPath = DllStructGetData($tDLLStruct, 1)
    $tDLLStruct = 0;format the output
    If StringLen($sProcessPath) < 2 Then Return SetError(5, 0, "");is empty or non readable
    If StringLeft($sProcessPath, 4) = "\??\" Then $sProcessPath = StringReplace($sProcessPath, "\??\", "")
    If StringLeft($sProcessPath, 20) = "\SystemRoot\System32" Then $sProcessPath = StringReplace($sProcessPath, "\SystemRoot\System32", @SystemDir)
    Return SetError(0, 0, $sProcessPath)
EndFunc   ;==>_ProcessGetPath

Func AdjustPrivilege($Type)
    Local $aReturn = DllCall("ntdll.dll", "int", "RtlAdjustPrivilege", "int", $Type, "int", 1, "int", 0, "int*", 0)
    If @error Or $aReturn[0] Then Return SetError(1, 0, 0)
    Return SetError(0, 0, 1)
EndFunc   ;==>AdjustPrivilege

#endregion - Main -

#region - Find Icon -

#CS
	This section is used to check if a file has resources in order to display them
	in the list view controls.
#CE

Func _CheckIconResource($Host, $CTRL)
    If Not FileExists($Host) Then GUICtrlSetImage($CTRL, "shell32.dll", 3, 0)
    If _CheckIcon($Host) Then Return GUICtrlSetImage($CTRL, $Host, 0, 0)
    GUICtrlSetImage($CTRL, "shell32.dll", 3, 0)
    Return
EndFunc   ;==>_CheckIconResource

Func _CheckIcon($hModule)
    Local $Loaded = 1
    $hModule = _WinAPI_LoadLibraryEx($hModule, 0x00000003)
    If Not $hModule Then Return SetError(1, 0, 0)
    $hResEnumProc = DllCallbackRegister('_EnumResTypesProc', 'int', 'ptr;ptr;long_ptr')
    DllCall('kernel32.dll', 'int', 'EnumResourceTypesW', 'ptr', $hModule, 'ptr', DllCallbackGetPtr($hResEnumProc), 'long_ptr', 0)
    DllCallbackFree($hResEnumProc)
    If $Loaded Then _WinAPI_FreeLibrary($hModule)
    If Not $HasIconResource Then Return 0
    $HasIconResource = 0
    Return 1
EndFunc   ;==>_CheckIcon

Func _EnumResTypesProc($hModule, $iType, $lParam)
    If Number($iType) = 14 Then
        $HasIconResource = 1
        DllCallbackFree($hResEnumProc)
    EndIf
    Return 1
EndFunc   ;==>_EnumResTypesProc

#endregion - Find Icon -

#region - Misc -

; #FUNCTION# ====================================================================================================================
; Name ..........: FetchListViewEntry
; Description ...: Gets the list view sub item information
; Syntax ........: FetchListViewEntry($Hndl, $Item)
; Parameters ....: $Hndl                - List view control handle.
;                  $Item                - List view item to grab starting at 1.
; Return values .: An array with the list view control item handle and its text.
;						- Index 0 is the item text
;						- Index 1 is the handle
;					Sets @error to a positive value if function failed.
;
; Author ........: THAT1ANONYMOUSDUDE
; Example .......: No
; ===============================================================================================================================
Func FetchListViewEntry($Hndl, $Item, $Array = 1)
    If Not IsNumber($Item) Then Return SetError(1, 0, 0)
    $Item = $Item - 1
    Local $String = GUICtrlRead(GUICtrlRead($Hndl))
    Local $M = StringSplit($String, "|", 2)
    If @error Then Return SetError(2, 0, 0)
    If $Array Then
        Local $Ret[2] = [$M[$Item], GUICtrlRead($Hndl)]
    Else
        Return $M[$Item]
    EndIf
    Return $Ret
EndFunc   ;==>FetchListViewEntry

; #FUNCTION# ====================================================================================================================
; Name ..........: _GuiCtrlSetTip
; Description ...: Easy to use wrapper for the GUIToolTip UDF.
; Syntax ........: _GuiCtrlSetTip($hControl, $sText[, $sTitle = ""[, $iIcon = 0[, $iOptions = 0[, $iBackGroundColor = -1[,
;                  $itextColor = -1[, $iDelay = 500]]]]]])
; Parameters ....: $hControl            - A handle to the control, use -1 to assign to the last recently created control.
;                  $sText               - Tip text that will be displayed when the mouse is hovered over the control.
;                  $sTitle              - [optional] The title for the tooltip Requires IE5+
;                  $iIcon               - [optional] Pre-defined icon to show next to the title: Requires IE5+. Requires a title.
;                                        	 | 0 = No icon
;											 | 1 = Info icon
;											 | 2 = Warning icon
; 											 | 3 = Error Icon
;                                        	 | - This parameter can also be a string in the below example format~
;                                        	 | [@WindowsDir & "\Explorer.exe,100"] where 100 is the icon index in the file that
;                                        	 | contains the icon resource to use, this can be any file with icon resources.
;                  $iOptions            - [optional] Sets different options for how the tooltip will be displayed
;											 | (Can be added together):
;											 | 1 = Display as Balloon Tip Requires IE5+
;											 | 2 = Center the tip horizontally along the control.
;                  $iBackGroundColor    - [optional] A hex RGB color value to use for the tip background color.
;                  $itextColor          - [optional] A hex RGB color value to use for the tip text color.
;                  $iDelay              - [optional] A positive vale in miliseconds to set the tips delay time. Default is 500.
; Return values .: The newly created tooltip handle
; Author ........: THAT1ANONYMOUSDUDE
; Modified ......:
; Remarks .......: Just a wrapper for the GUIToolTip UDF.
; Related .......: None
; Link ..........:
; Example .......: _GUICtrlSetTip(-1,"Test tip with text, title, Icon & balloon style.","Optional title",1,1)
; ===============================================================================================================================
Func _GuiCtrlSetTip($hControl, $sText, $sTitle = "", $iIcon = 0, $iOptions = 0, $iBackGroundColor = -1, $itextColor = -1, $iDelay = 500)
    If Not IsHWnd($hControl) Then $hControl = GUICtrlGetHandle($hControl)
    If Not IsHWnd($hControl) Then Return SetError(1, 0, 0)
    If $sText = "" Then Return SetError(1, 0, 0)
    Local $aReturn
    Local $hicon
    Local $ExtStyle = 0
    Switch $iOptions
        Case 0
            $iOptions = 9
            $ExtStyle = 0
        Case 1
            $iOptions = 9
            $ExtStyle = $TTS_BALLOON
        Case 2
            $iOptions = 11
            $ExtStyle = 0
        Case 3
            $iOptions = 11
            $ExtStyle = $TTS_BALLOON
        Case Else
            $iOptions = 9
    EndSwitch
    Local $hToolTip = _GUIToolTip_Create($hControl, BitOR($ExtStyle, $TTS_ALWAYSTIP, $TTS_NOPREFIX))
    _GUIToolTip_AddTool($hToolTip, 0, $sText, $hControl, 0, 0, 0, 0, $iOptions, 0)
    $hicon = DllStructCreate("ptr")
    If IsNumber($iIcon) And $iIcon <= 3 Then
        Switch $iIcon
            Case 1
                $iIcon = -104
            Case 2
                $iIcon = -101
            Case 3
                $iIcon = -103
            Case Else
                $iIcon = 0
        EndSwitch
        If $iIcon <> 0 Then
            $aReturn = DllCall("Shell32.dll", "uint", "ExtractIconExW", "wstr", @SystemDir & "\user32.dll", "int", $iIcon, "ptr", 0, "ptr", DllStructGetPtr($hicon), "uint", 1)
            If Not @error And $aReturn[0] Then
                $hicon = DllStructGetData($hicon, 1)
            Else
                $hicon = 0
            EndIf
        Else
            $hicon = 0
        EndIf
        _GUIToolTip_SetTitle($hToolTip, $sTitle, $hicon)
        DllCall("User32.dll", "none", "DestroyIcon", "handle", $hicon)
    Else
        $iIcon = StringSplit($iIcon, ",")
        If $iIcon[0] > 1 Then
            $aReturn = DllCall("shell32.dll", "uint", "ExtractIconExW", "wstr", $iIcon[$iIcon[0] - 1], "int", -1 * (Int($iIcon[$iIcon[0]])), "ptr", 0, "ptr", DllStructGetPtr($hicon), "uint", 1)
            If Not @error And $aReturn[0] Then
                $hicon = DllStructGetData($hicon, 1)
            Else
                $hicon = 0
            EndIf
            _GUIToolTip_SetTitle($hToolTip, $sTitle, $hicon)
            DllCall("user32.dll", "none", "DestroyIcon", "handle", $hicon)
        Else
            _GUIToolTip_SetTitle($hToolTip, $sTitle, $hicon);probably a handle
        EndIf
    EndIf

    If $iBackGroundColor <> -1 Or $itextColor <> -1 Then DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", $hToolTip, "wstr", "", "wstr", "")
    If $iBackGroundColor <> -1 Then _GUIToolTip_SetTipBkColor($hToolTip, BitAND(BitShift(String(Binary($iBackGroundColor)), 8), 0xFFFFFF))
    If $itextColor <> -1 Then _GUIToolTip_SetTipTextColor($hToolTip, BitAND(BitShift(String(Binary($itextColor)), 8), 0xFFFFFF))
    _GUIToolTip_SetDelayTime($hToolTip, 0, $iDelay)
    Return $hToolTip
EndFunc   ;==>_GuiCtrlSetTip

Func MY_WM_SIZE($hWnd, $iMsg, $iwParam, $ilParam)
    _GUICtrlStatusBar_Resize($StatusBar1)
    AdlibRegister("FixIt", 10)
    Return 'GUI_RUNDEFMSG'
EndFunc   ;==>MY_WM_SIZE

Func FixIt()
    AdlibUnRegister("FixIt")
    _GUICtrlStatusBar_EmbedControl($StatusBar1, 2, $hProgress)
EndFunc   ;==>FixIt

Func WM_GETMINMAXINFO($hWnd, $Msg, $WPARAM, $lParam)
    Local $tagMaxinfo = DllStructCreate("int;int;int;int;int;int;int;int;int;int", $lParam)
    DllStructSetData($tagMaxinfo, 7, $GUIMINWID / 1.1) ; min X
    DllStructSetData($tagMaxinfo, 8, $GUIMINHT / 1.1) ; min Y
    ;DllStructSetData($tagMaxinfo, 9, @DesktopWidth); max X
    ;DllStructSetData($tagMaxinfo, 10, @DesktopHeight) ; max Y
    Return 0
EndFunc   ;==>WM_GETMINMAXINFO

#endregion - Misc -

Func Terminate()

    GUIDelete($hGUI)

    OnAutoItExitUnRegister("Terminate")

    DllClose($hNTDLL)
    DllClose($hPSAPI)
    DllClose($hUSER32)
    DllClose($hKERNEL32)

    Exit 0
EndFunc   ;==>Terminate
