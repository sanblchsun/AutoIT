#include <GuiListView.au3>
#include <ButtonConstants.au3>
#include <File.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <String.au3>
#include <WindowsConstants.au3>

Opt("GUIOnEventMode", 1)
Opt("MustDeclareVars", 1)   ; Variables must be pre-declared
Opt("TrayIconHide", 1)  ; Hide the AutoIt tray icon

Dim $frmExplorer, $cmdParentDir, $cmdCut, $cmdCopy, $cmdPaste, $lvwFiles, $iColWidth, $cmdAddress, $txtAddress
Dim $sCurrDirPath = "C:\"

$frmExplorer = GUICreate("", 545, 412, (@DesktopWidth - 545) / 2, (@DesktopHeight - 412) / 2, $WS_SYSMENU)
GUISetOnEvent($GUI_EVENT_CLOSE, "frmExplorer_Unload")
GUISetOnEvent($GUI_EVENT_SECONDARYUP, "frmExplorer_ContextMenuHandler")
GUISetOnEvent($GUI_EVENT_MOUSEMOVE, "frmExplorer_MouseHover")
GUISetIcon("icons\1.ico", 0)
GUICtrlCreateMenu("&File", -1)
GUICtrlCreateMenu("&Edit", -1)

; Toolbar buttons
GUICtrlCreateGroup("", 0, 0, 537, 44)
GUICtrlCreateButton("", 2, 9, 32, 32, $BS_ICON + $BS_FLAT)
GUICtrlSetImage(-1, "icons\5.ico", 0, 0)
GUICtrlCreateButton("", 33, 9, 32, 32, $BS_ICON + $BS_FLAT)
GUICtrlSetImage(-1, "icons\6.ico", 0, 0)
$cmdParentDir = GUICtrlCreateButton("", 64, 9, 32, 32, $BS_ICON + $BS_FLAT)
GUICtrlSetImage(-1, "icons\7.ico", 0, 0)
GuiCtrlSetOnEvent(-1, "cmdParentDir_Click")

$cmdCut = GUICtrlCreateButton("", 106, 9, 32, 32, $BS_ICON + $BS_FLAT)
GUICtrlSetImage(-1, "icons\8.ico", 0, 0)

$cmdCopy = GUICtrlCreateButton("", 137, 9, 32, 32, $BS_ICON + $BS_FLAT)
GUICtrlSetImage(-1, "icons\9.ico", 0, 0)

$cmdPaste = GUICtrlCreateButton("", 168, 9, 32, 32, $BS_ICON + $BS_FLAT)
GUICtrlSetImage(-1, "icons\10.ico", 0, 0)


GUICtrlCreateButton("", 210, 9, 32, 32, $BS_ICON + $BS_FLAT)
GUICtrlSetImage(-1, "icons\11.ico", 0, 0)
GUICtrlCreateButton("", 241, 9, 32, 32, $BS_ICON + $BS_FLAT)
GUICtrlSetImage(-1, "icons\12.ico", 0, 0)

GUICtrlCreateGroup("", 0, 36, 537, 34)
GUICtrlCreateLabel("A&ddress", 8, 48, 45, 20)
GUICtrlSetFont(-1, 8.5, 400, 0, "Tahoma")
$txtAddress = GUICtrlCreateInput("", 55, 46, 452, 20)
$cmdAddress = GUICtrlCreateButton("", 509, 46, 22, 20, $BS_ICON + $BS_FLAT)
GUICtrlSetImage(-1, "icons\4.ico", 0, 0)
GuiCtrlSetOnEvent(-1, "cmdAddress_Click")


_RefreshFileList($sCurrDirPath)
GUISwitch($frmExplorer)
GUISetState(@SW_SHOW)

While 1
 Sleep(1000) ; Idle around
WEnd


Func frmExplorer_Unload()
    Exit
EndFunc

Func _RefreshFileList($sDirPath)
    Local $hFileList, $sFileName, $sFileAttrib, $sFileSize, $iColWidth
    Local $asPathSplit[5], $asIconInfo[3]

    GUICtrlDelete($lvwFiles)

    If StringInstr($sDirPath, "\", 0, 2) = 0 Then
        GUISetIcon("icons\1.ico", 0)
    Else
        GUISetIcon("icons\13.ico", 4)
    EndIf

    $lvwFiles = GUICtrlCreateListView("Name|Size|Type|Attributes", 0, 70, 537, 297, _
            0 + $LVS_NOSORTHEADER, $LVS_EX_TRACKSELECT + $LVS_EX_TWOCLICKACTIVATE + $WS_EX_CLIENTEDGE)

    ; Size column is right justified
    _GUICtrlListView_JustifyColumn($lvwFiles, 1, 1)

    ; $lvwFiles Formatting
    $iColWidth = (500 / 4) - 1
    For $i = 0 to 3
        _GUICtrlListView_SetColumnWidth($lvwFiles, $i, $iColWidth)
    Next

    ; Default File Icon
    GUICtrlSetImage($lvwFiles, "shell32.dll", 0)

    ; Clear $lvwFiles
    _GUICtrlListView_DeleteAllItems($lvwFiles)

    GUICtrlSetData($txtAddress, $sDirPath)

    ; Add directories
    $hFileList = FileFindFirstFile($sDirPath & "\*.*")
    If $hFileList = -1 Then
        Return
    EndIf

    GUISetCursor(15, 1)

    While 1
        $sFileName = FileFindNextFile($hFileList)
        If @error Then ExitLoop

        $sFileAttrib = FileGetAttrib($sDirPath & $sFileName)

        If StringInStr($sFileAttrib, "D") <> 0 Then
            If $sFileName = "." Or $sFileName = ".." Then
                ; Don't add to list
            Else
                GUICtrlCreateListViewItem($sFileName & "||File Folder|" & $sFileAttrib, $lvwFiles)
                GUICtrlSetImage(-1, "icons\2.ico")
                GuiCtrlSetOnEvent(-1, "lvwFolderItem_Click")
            EndIf
        EndIf
    WEnd

    FileClose($hFileList)

    ; Add files
    $hFileList = FileFindFirstFile($sDirPath & "\*.*")
    If $hFileList = -1 Then
        Return
    EndIf

    While 1
        $sFileName = FileFindNextFile($hFileList)
        If @error Then ExitLoop

        $sFileAttrib = FileGetAttrib($sDirPath & $sFileName)

        If StringInStr($sFileAttrib, "D") = 0 Then
            $sFileSize = Round(FileGetSize($sDirPath & $sFileName) / 1024, 1) & " KB"

            $asPathSplit = _PathSplit($sFileName, $asPathSplit[1], $asPathSplit[2], $asPathSplit[3], $asPathSplit[4])

            If $asPathSplit[4] = ".EXE" Then
                GUICtrlCreateListViewItem($sFileName & "|" & $sFileSize & "||" & $sFileAttrib, $lvwFiles)
                GUICtrlSetImage(-1, $sDirPath & $sFileName, 0)
                GuiCtrlSetOnEvent(-1, "lvwFileItem_Click")
            Else
                $asIconInfo = _GetAssociatedIcon($asPathSplit[4])
                GUICtrlCreateListViewItem($sFileName & "|" & $sFileSize & "||" & $sFileAttrib, $lvwFiles)
                GUICtrlSetImage(-1, $asIconInfo[1], $asIconInfo[2])
                GuiCtrlSetOnEvent(-1, "lvwFileItem_Click")
            EndIf
        EndIf
    WEnd

    FileClose($hFileList)

    GUISetCursor(6, 1)
EndFunc

Func cmdParentDir_Click()
    $sCurrDirPath = _PathFull($sCurrDirPath & "..\")
    _RefreshFileList($sCurrDirPath)
    GUICtrlSetState($lvwFiles, $GUI_FOCUS)
EndFunc

Func lvwFolderItem_Click()
    Local $iSelFolder, $sDirPath
    $iSelFolder = _GUICtrlListView_GetNextItem($lvwFiles)
    $sCurrDirPath = $sCurrDirPath & _GUICtrlListView_GetItemText($lvwFiles, $iSelFolder, 0) & "\"
    _RefreshFileList($sCurrDirPath)
EndFunc

Func cmdAddress_Click()
    GUICtrlSetData($txtAddress, _StringProper(GUICtrlRead($txtAddress)))
    If StringRight(GUICtrlRead($txtAddress), 1) <> "\" Then
        GUICtrlSetData($txtAddress, GUICtrlRead($txtAddress) & "\")
    EndIf
    $sCurrDirPath = GUICtrlRead($txtAddress)
    _RefreshFileList($sCurrDirPath)
EndFunc

Func _GetAssociatedIcon($sFileExt)
    Local $sFileType, $sIconInfo, $asIconInfo[3]

    For $i = 0 to 2
        $asIconInfo[$i] = ""
    Next

    $sFileType = RegRead("HKCR\" & $sFileExt, "")

    If $sFileType <> "" Then
        $sIconInfo = RegRead("HKCR\" & $sFileType & "\DefaultIcon", "")
        If $sIconInfo <> "" Then
            $asIconInfo = StringSplit($sIconInfo, ",")
            If @error Then
                ReDim $asIconInfo[3]
                $asIconInfo[0] = "2"
                $asIconInfo[1] = _ExpandEnvStrings(FileGetLongName($sIconInfo))
                $asIconInfo[2] = "0"
            EndIf
        EndIf
    EndIf

    Return $asIconInfo
EndFunc

Func _ExpandEnvStrings($sInput)
    Local $aPart = StringSplit($sInput,'%')
    If @error Then
        SetError(1)
        Return $sInput
    EndIf

    Dim $sOut = $aPart[1], $i = 2, $env = ''
    ;loop through the parts
    While $i <= $aPart[0]
        $env = EnvGet($aPart[$i])
        If $env <> '' Then
            ;this part is an expandable environment variable
            $sOut = $sOut & $env
            $i = $i + 1
            If $i <= $aPart[0] Then
                $sOut = $sOut & $aPart[$i]
            ElseIf $aPart[$i] = '' Then
                ;a double-percent is used to force a single percent
                $sOut = $sOut & '%'
                $i = $i + 1
                If $i <= $aPart[0] Then
                    $sOut = $sOut & $aPart[$i]
                Else ;this part is to be returned literally
                    $sOut = $sOut & '%' & $aPart[$i]
                EndIf
            EndIf
        EndIf
        $i = $i + 1
    WEnd

    Return $sOut
EndFunc

Func frmExplorer_ContextMenuHandler()
    Local $asCurInfo[5], $sFileName
    $asCurInfo = GUIGetCursorInfo()
    If _GUICtrlListView_GetHotItem($lvwFiles) <> -1 Then
        $sFileName = $sCurrDirPath & _GUICtrlListView_GetItemText($lvwFiles, _GUICtrlListView_GetHotItem($lvwFiles), 0)
        DllCall("Cfexpmnu.dll", "int", "DoExplorerMenu", "hwnd", $frmExplorer, "str", $sFileName, _
                "long", $asCurInfo[0], "long", $asCurInfo[1])
    EndIf
EndFunc

Func lvwFileItem_Click()
    Local $sFileName
    $sFileName = $sCurrDirPath & _GUICtrlListView_GetItemText($lvwFiles, _GUICtrlListView_GetHotItem($lvwFiles), 0)
    Run(@ComSpec & " /c " & $sFileName, $sCurrDirPath, @SW_HIDE)

EndFunc

Func frmExplorer_MouseHover()

EndFunc
 
