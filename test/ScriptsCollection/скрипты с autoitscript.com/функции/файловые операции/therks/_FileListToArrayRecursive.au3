#include-once
; #FUNCTION# ====================================================================================================================
; Name...........: _FileListToArrayRecursive
; Description ...: Lists files and/or folders in a specified path recursively
; Syntax.........: _FileListToArrayRecursive($sPath[, $sFilter = '*'[, $iFlag = 0[, $sCallback = ''[, $sCallbackUserParam = '' ] ] ] ] )
; Parameters ....: $sPath             - Path to search
;                 $sFilter          - Optional: the filter to use, default is *
;                 $iFlag              - Optional: specifies options about return, add flags together
;                 |$iFlag =  0 (Default) Return both files and folders
;                 |$iFlag =  1 Return files only
;                 |$iFlag =  2 Return folders only
;                 |$iFlag =  4 search subfolders (Enable recursion)
;                 |$iFlag =  8 Make array 0-based (Disable return count in first element)
;                 |$iFlag = 16 Return full paths (default only returns from the search folder down)
;                 $sCallback          - Optional: function to call on each loop. See remarks for details (default: none)
;                 $sCallbackUserParam - Optional: a parameter to pass to the callback function (default: none)
; Return values .: @Error - 1 = Path not found or invalid
;                 |2 = Invalid $sFilter
;                 |3 = Invalid $iFilter
;                 |4 = No files found or folder inaccessible
;                 |5 = No files found or folder inaccessible
;                 |-1 = callback function returned -1
; Author ........: Rob Saunders (therks at therks dot com)
; Modified.......:
; Remarks .......: If $sCallback is defined the function will be called on each loop and it can alter what files are recorded
;                 in the return array. The callback function runs on every file result because it is called *before* the flag
;                 filter for files/folders ($iFlag 1 or 2).
;                   Return  0 = Item is added (depending on $iFlag 1 or 2)
;                   Return  1 = Item is skipped (note: if you skip a folder it will not be searched either)
;                   Return -1 = Stop searching. Main func returns false, @error = -1, @extended = Callback's @extended value
;                 The function is passed one parameter, a 6 item array with values as follows:
;                   [0] root search folder
;                   [1] current sub folder
;                   [2] current filename match
;                   [3] 1 if file is a folder; 0 if not
;                   [4] current file count
;                   [5] $sCallbackUserParam
;
; Related .......: _FileListToArray
; Link ..........:
; Example .......:
; Note ..........: Some parts from original function (by SolidSnake) and _FileListToArrayEx (by DXRW4E)
; ===============================================================================================================================

Func _FileListToArrayRecursive($sPath, $sFilter = '*', $iFlag = 0, $sCallback = '', $sCallbackUserParam = '')
    Local Const $FL_FILES = 1, $FL_FOLDERS = 2, $FL_RECURSE = 4, $FL_NOCOUNT = 8, $FL_FULLPATH = 16

    If Not StringInStr(FileGetAttrib($sPath), 'D') Then Return SetError(1, 1, '')
    If StringRegExp($sFilter, '[\\/:><\|]|(?s)\A\s*\z') Then Return SetError(2, 2, '')
    If $iFlag < 0 Or $iFlag > 1+2+4+8+16 Then Return SetError(3, 3, '')

    $sPath = StringRegExpReplace($sPath, '[\\/]+$', '') & '\'

    Local $sFileTrack, $iFileCount, $hParentSearch, $hSearch, $hSubCheck, $sSubDir, $sFile, $iIsFolder, $sRegExFilter, $sAddFullPath, _
        $iReturnFolders, $iReturnFiles, $iRecurse, $iReturnCount, $iSortOffset, _
        $aCallbackData[6], $vCallbackReturn, $iCallbackExt

    $aCallbackData[5] = $sCallbackUserParam

    If BitAND($iFlag, $FL_FULLPATH) Then $sAddFullPath = $sPath

    If BitAND($iFlag, $FL_RECURSE) Then
        $iRecurse = 1
        If StringReplace($sFilter, '*', '') Then ; If we ARE recursing, and the filter is something besides just * then initialize the regex filter
            $sRegExFilter = '(?i)^' & StringRegExpReplace(StringReplace(StringRegExpReplace($sFilter, '(\.|\||\+|\(|\)|\{|\}|\[|\]|\^|\$|\\)', "\\$1"), '?', '.'), '\*+', '.*') & '$'
            $sFilter = '*'
        EndIf
    EndIf

    If BitAND($iFlag, $FL_FILES) Then
        $iReturnFiles = 1
    ElseIf BitAND($iFlag, $FL_FOLDERS) Then
        $iReturnFolders = 1
    Else
        $iReturnFiles = 1
        $iReturnFolders = 1
    EndIf

    If BitAND($iFlag, $FL_NOCOUNT) Then
        $iReturnCount = 2 ; Param for StringSplit
        $iSortOffset = 0
    EndIf

    $hParentSearch = FileFindFirstFile($sPath & $sSubDir & $sFilter)
    If $hParentSearch = -1 Then Return SetError(4, 4, '')
    $hSearch = $hParentSearch
    While 1
        $sFile = FileFindNextFile($hSearch)
        If @error Then
            If $hParentSearch = $hSearch Then ExitLoop
            FileClose($hSearch)
            $hSearch -= 1
            $sSubDir = StringLeft($sSubDir, StringInStr(StringTrimRight($sSubDir, 1), '\', 0, -1))
            ContinueLoop
        EndIf
        $iIsFolder = @extended

        If $sCallback Then
            $aCallbackData[0] = $sPath
            $aCallbackData[1] = $sSubDir
            $aCallbackData[2] = $sFile
            $aCallbackData[3] = $iIsFolder
            $aCallbackData[4] = $iFileCount
            $vCallbackReturn = Call($sCallback, $aCallbackData)
            If @error = 0xDEAD And @extended = 0xBEEF Then
                FileClose($hSearch)
                FileClose($hParentSearch)
                Return SetError(5, 5, '')
            ElseIf $vCallbackReturn = -1 Then
                $iCallbackExt = @extended
                FileClose($hSearch)
                FileClose($hParentSearch)
                Return SetError(-1, $iCallbackExt, '')
            ElseIf $vCallbackReturn Then
                ContinueLoop
            EndIf
        EndIf

        If $iRecurse Then
            If ($iIsFolder And $iReturnFolders) Or (Not $iIsFolder And $iReturnFiles) Then
                If Not $sRegExFilter Or ($sRegExFilter And StringRegExp($sFile, $sRegExFilter)) Then
                    $sFileTrack &= '|' & $sAddFullPath & $sSubDir & $sFile
                    $iFileCount += 1
                EndIf
            EndIf

            If $iIsFolder Then
                $hSubCheck = FileFindFirstFile($sPath & $sSubDir & $sFile & '\' & $sFilter)
                If $hSubCheck = -1 Then ContinueLoop
                $sSubDir &= $sFile & '\'
                $hSearch = $hSubCheck
            EndIf
        Else
            If ($iIsFolder And $iReturnFolders) Or (Not $iIsFolder And $iReturnFiles) Then
                $sFileTrack &= '|' & $sAddFullPath & $sSubDir & $sFile
                $iFileCount += 1
            EndIf
        EndIf

    WEnd
    FileClose($hParentSearch)

    Local $aReturnList = StringSplit(StringTrimLeft($sFileTrack, 1), '|', $iReturnCount)
    If @error Then Return SetError(4, 4, '')
    Return $aReturnList
EndFunc