#include-once
#include <GuiTreeView.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>

Global $hImage, $hWndTreeView, $objFSO, $hCommonDocs, $hMyDocs

$objFSO = ObjCreate("Scripting.FileSystemObject")

$hImage = _GUIImageList_Create(16, 16, 5, 3)
_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 15)
_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 6)
_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 8)
_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 3)
_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 7)
_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 4)
_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 11)

; #FUNCTION# ==================================================================================================
; Name............: _ShellTreeView_Create
; Description.....: Add TreeView items with drives structures
; Syntax..........: _ShellTreeView_Create($hTreeView)
; Parameter(s)....: $hTreeView - Handle to the TreeView control
; Return value(s).: None
; Note(s).........: Tested on AutoIt 3.2.12.1 and Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ==============================================================================================================
Func _ShellTreeView_Create($hTreeView)
    Local $RootItem, $aDrives, $hChild, $i
    
    $hWndTreeView = $hTreeView
    
    GUIRegisterMsg($WM_NOTIFY, "_TVN_ITEMEXPANDING")
    
    _GUICtrlTreeView_SetNormalImageList($hWndTreeView, $hImage)
    
    $RootItem = _GUICtrlTreeView_Add($hWndTreeView, 0, "My computer", 0, 0)
    
    $aDrives = DriveGetDrive("ALL")
    
    For $i = 1 To $aDrives[0]
        $aDrives[$i] = StringUpper($aDrives[$i])
    Next
    
    For $i = 1 To $aDrives[0]
        Switch DriveGetType($aDrives[$i])
            Case "Removable"
                If ($aDrives[$i] = "a:") Or ($aDrives[$i] = "b:") Then
                    $hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDrives[$i], 1, 1)
                    ;_ShellTreeView_GetSelected($aDrives[$i], $hChild)
                Else
                    _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDrives[$i], 4, 4)
                EndIf
            Case "Fixed"
                $hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDrives[$i], 2, 2)
                _ShellTreeView_GetSelected($hWndTreeView, $aDrives[$i], $hChild)
            Case "CDROM"
                $hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDrives[$i], 6, 6)
                _ShellTreeView_GetSelected($hWndTreeView, $aDrives[$i], $hChild)
        EndSwitch
    Next
    
    $hCommonDocs = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, StringRegExpReplace(@DocumentsCommonDir, "^.*\\", ""), 3, 5)
    _ShellTreeView_GetSelected($hWndTreeView, @DocumentsCommonDir, $hCommonDocs)
    
    $hMyDocs = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, StringRegExpReplace(@MyDocumentsDir, "^.*\\", ""), 3, 5)
    _ShellTreeView_GetSelected($hWndTreeView, @MyDocumentsDir, $hMyDocs)
EndFunc   ;==>_ShellTreeView_Create

Func _TVN_ITEMEXPANDING($hWnd, $Msg, $wParam, $lParam)
    Local $tNMHDR, $hWndFrom, $iCode
    
    $tNMHDR = DllStructCreate($tagNMHDR, $lParam)
    $hWndFrom = DllStructGetData($tNMHDR, "hWndFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    
    Switch $hWndFrom
        Case $hWndTreeView
            Switch $iCode
                Case $TVN_ITEMEXPANDING
                    Local $tINFO = DllStructCreate($tagNMTREEVIEW, $lParam)
                    Local $hControl = DllStructGetData($tINFO, "NewhItem")
                    
                    If _GUICtrlTreeView_GetExpanded($hWndTreeView, $hControl) = False Then
                        _ShellTreeView_GetSelected($hWndFrom, _GUICtrlTreeView_GetText($hWndFrom, $hControl), $hControl)
                    EndIf
            EndSwitch
    EndSwitch
    
    Return "GUI_RUNDEFMSG"
EndFunc   ;==>_TVN_ITEMEXPANDING

; #FUNCTION# ==================================================================================================
; Name............: _ShellTreeView_GetSelected
; Description.....: Add TreeView items with directorys structures
; Syntax..........: _ShellTreeView_GetSelected($hWndTreeView, $sDrive, $hControl)
; Parameter(s)....: $hTreeView - Handle to the TreeView control
;                   $sDrive    - String contains drive letter or text of selected TreeView item
;                   $hControl  - Child handle
; Return value(s).: A full path to a selected directory
; Note(s).........: Tested on AutoIt 3.2.12.1 and Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ==============================================================================================================
Func _ShellTreeView_GetSelected($hWndTreeView, $sDrive, $hControl)
    Switch _IsDocDir($sDrive, $hControl)
        Case 1
            $sDrive = @DocumentsCommonDir
        Case 2
            $sDrive = @MyDocumentsDir
    EndSwitch
    
    If Not FileExists($sDrive) Then
        Local $hParent = _GUICtrlTreeView_GetParentHandle($hWndTreeView, $hControl), $iFullPath
        
        If _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = StringRegExpReplace(@DocumentsCommonDir, "^.*\\", "") Then
            $iFullPath = @DocumentsCommonDir & "\" & $sDrive
        ElseIf _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = StringRegExpReplace(@MyDocumentsDir, "^.*\\", "") Then
            $iFullPath = @MyDocumentsDir & "\" & $sDrive
        Else
            $iFullPath = _GUICtrlTreeView_GetText($hWndTreeView, $hParent) & "\" & $sDrive
        EndIf
        
        While 1
            If $hParent = 0 Then Return
            
            If FileExists($iFullPath) Then ExitLoop
            
            $hParent = _GUICtrlTreeView_GetParentHandle($hWndTreeView, $hParent)
            
            If _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = StringRegExpReplace(@DocumentsCommonDir, "^.*\\", "") Then
                $iFullPath = @DocumentsCommonDir & "\" & $iFullPath
            ElseIf _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = StringRegExpReplace(@MyDocumentsDir, "^.*\\", "") Then
                $iFullPath = @DocumentsCommonDir & "\" & $iFullPath
            Else
                $iFullPath = _GUICtrlTreeView_GetText($hWndTreeView, $hParent) & "\" & $iFullPath
            EndIf
        WEnd
        $sDrive = $iFullPath
    EndIf
    
    _GUICtrlTreeView_DeleteChildren($hWndTreeView, $hControl)
    
    Local $objFolder, $colSubFolder, $objSubFolder, $iSubChild, $iSub
    
    $objFolder = $objFSO.GetFolder($sDrive & "\")
    $colSubFolder = $objFolder.SubFolders
    
    For $objSubFolder In $colSubFolder
        $iSubChild = _GUICtrlTreeView_AddChild($hWndTreeView, $hControl, $objSubFolder.Name, 3, 5)
        $iSub = _GetSub($objSubFolder.Path)
        If $iSub Then _GUICtrlTreeView_AddChild($hWndTreeView, $iSubChild, $iSub, 3, 3)
    Next
    Return $sDrive
EndFunc   ;==>_ShellTreeView_GetSelected

Func _IsDocDir($sPath, $hControl)
    If ($sPath = StringRegExpReplace(@DocumentsCommonDir, "^.*\\", "")) And ($hControl = $hCommonDocs) Then
        Return 1
    ElseIf ($sPath = StringRegExpReplace(@MyDocumentsDir, "^.*\\", "")) And ($hControl = $hMyDocs) Then
        Return 2
    Else
        Return False
    EndIf
EndFunc   ;==>_IsDocDir

Func _GetSub($sPath)
    Local $objFolder, $colSubFolder, $objSubFolder
    
    $objFolder = $objFSO.GetFolder($sPath & "\")

    $colSubFolder = $objFolder.SubFolders

    For $objSubFolder In $colSubFolder
        If $objSubFolder.Name Then Return $objSubFolder.Name
    Next
EndFunc   ;==>_GetSub