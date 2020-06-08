#include-once
#include <WinAPI.au3>
#include <Memory.au3>
#include <Crypt.au3>

; #FUNCTION# ====================================================================================================
; Name...........:  _LargeFileCopy
; Description....:  Copy large files in such a way as to keep AutoIt GUIs responsive
; Syntax.........:  _LargeFileCopy($sSrc, $sDest[, $iFlags = 0[, $iToRead = 8388608[, $iAlg = $CALG_MD5[, $sFunction = ""[, $vUserVar = Default]]]]])
; Parameters.....:  $sSrc       - Source file name
;                   $sDest      - Destination: may be a file name or directory
;                   $iFlags     - [Optional] Combine flags with BitOR
;                               | 1 - Overwrite existing file
;                               | 2 - Create destination directory structure
;                               | 4 - Flush the destination file buffer before returning
;                               | 8 - Verify source and destination are identical via bit by bit comparison
;                               |16 - Verify source and destination are identical via MD5 hash
;                               |32 - Verify source and destination file size only
;                               + If more than one verify flag is set, the smallest flag will take precedence
;                   $iToRead    - [Optional] Size of the read buffer (Default = 8 MB)
;                   $iAlg       - [Optional] Algorithm to use for file verification (Default = $CALG_MD5)
;                               + Available algorithms: $CALG_MD2, $CALG_MD4, $CALG_MD5, $CALG_SHA1
;                   $sFunction  - [Optional] Function to be called after each write operation (Default = "")
;                               + Function will be called with the following parameters:
;                               | 1 - Total bytes written
;                               | 2 - Total file size in bytes
;                               | 3 - Optional user variable
;                   $vUserVar   - [Optional] User variable to pass to function (Default = Default)
;
; Return values..:  Success     - 1
;                   Failure     - 0 and sets @error
;                               | 1 - Failed to open source file, or source was a directory
;                               | 2 - Destination file exists and overwrite flag not set
;                               | 3 - Failed to create destination file
;                               | 4 - Read error during copy
;                               | 5 - Write error during copy
;                               | 6 - Verify failed
; Author.........:  Erik Pilsits
; Modified.......:
; Remarks........:
; Related........:
; Link...........:
; Example........:
; ===============================================================================================================
Func _LargeFileCopy($sSrc, $sDest, $iFlags = 0, $iToRead = 8388608, $iAlg = $CALG_MD5, $sFunction = "", $vUserVar = Default)
    ; check / fix source and dest path syntax
    _LFC_FixPaths($sSrc, $sDest)

    ; open file for reading, fail if it doesn't exist or directory
    Local $hSrc = _LFC_CreateFile($sSrc, $GENERIC_READ, $FILE_SHARE_READ, $OPEN_EXISTING, 0)
    If Not $hSrc Then Return SetError(1, 0, 0)

    ; set option flags
    Local $fOverwrite = (BitAND($iFlags, 1) = 1)
    Local $fCreate = (BitAND($iFlags, 2) = 2)
    Local $fFlush = (BitAND($iFlags, 4) = 4)
    Local $fVerify = 0
    If (BitAND($iFlags, 8) = 8) Then
        ; bit by bit
        $fVerify = 1
    ElseIf (BitAND($iFlags, 16) = 16) Then
        ; MD5
        $fVerify = 2
    ElseIf (BitAND($iFlags, 32) = 32) Then
        ; file size
        $fVerify = 3
    EndIf

    ; check destination
    _LFC_CheckDestination($sSrc, $sDest, $fOverwrite, $fCreate)
    If @error Then
        _WinAPI_CloseHandle($hSrc)
        Return SetError(2, 0, 0)
    EndIf

    ; create new file for writing, overwrite
    Local $hDest = _LFC_CreateFile($sDest, BitOR($GENERIC_READ, $GENERIC_WRITE), 0, $CREATE_ALWAYS, 0)
    If Not $hDest Then
        _WinAPI_CloseHandle($hSrc)
        Return SetError(3, 0, 0)
    EndIf

    ; check for 0 byte source file
    Local $iSize = _WinAPI_GetFileSizeEx($hSrc)
    If $iSize = 0 Then
        ; done, close handles and return success
        _WinAPI_CloseHandle($hDest)
        _WinAPI_CloseHandle($hSrc)
        Return 1
    EndIf

    ; perform copy
    Local $iRead, $iWritten, $iTotal = 0, $mSrc = 0, $iReadError = 0, $iWriteError = 0, $iVerifyError = 0
    ; allocate buffers
    Local $hBuffer = DllStructCreate("byte[" & $iToRead & "]")
    Local $pBuffer = DllStructGetPtr($hBuffer)
    If $fVerify = 1 Then
        ; verify read buffer
        Local $vBuffer = DllStructCreate("byte[" & $iToRead & "]")
        Local $pvBuffer = DllStructGetPtr($vBuffer)
    ElseIf $fVerify = 2 Then
        _Crypt_Startup()
    EndIf

    Do
        If Not _WinAPI_ReadFile($hSrc, $pBuffer, $iToRead, $iRead) Then
            $iReadError = 1
            ExitLoop
        EndIf
        If $iRead = 0 Then ExitLoop ; end of file, edge case if file is an exact multiple of the buffer size
        If Not _WinAPI_WriteFile($hDest, $pBuffer, $iRead, $iWritten) Or ($iRead <> $iWritten) Then
            $iWriteError = 1
            ExitLoop
        EndIf
        If $sFunction Then
            $iTotal += $iRead
            Call($sFunction, $iTotal, $iSize, $vUserVar)
        EndIf
        If $fVerify = 1 Then
            ; compare data
            If Not _LFC_BitCompare($hDest, $pBuffer, $pvBuffer, $iWritten) Then
                $iVerifyError = 1
                ExitLoop
            EndIf
        ElseIf $fVerify = 2 Then
            ; hash source inline
            $mSrc = _LFC_ChunkHash($mSrc, $pBuffer, $iWritten, $iAlg)
        EndIf
    Until $iRead < $iToRead

    ; the FlushFileBuffers command here can take some time: ~1s for a 75MB file, ~4s for a 700MB file
    ; it's probably safest to enable this if you need to make sure the write buffer is empty before continuing
    ; the FileCopy function does NOT seem to do this based on execution time
    If $fFlush Then _WinAPI_FlushFileBuffers($hDest)
    ; check file size in verify mode 3 before closing handles
    If $fVerify = 3 Then
        If Not _LFC_SizeCompare($hSrc, $hDest) Then $iVerifyError = 1
    EndIf
    ; close handles
    _WinAPI_CloseHandle($hDest)
    _WinAPI_CloseHandle($hSrc)
    If $fVerify = 2 Then
        ; finalize hash
        $mSrc = _LFC_ChunkHashFinal($mSrc)
        _Crypt_Shutdown()
    EndIf

    If $iReadError Then
        Return SetError(4, 0, 0)
    ElseIf $iWriteError Then
        Return SetError(5, 0, 0)
    Else
        If ($fVerify = 1) Or ($fVerify = 3) Then
            If $iVerifyError Then Return SetError(6, 0, 0)
        ElseIf ($fVerify = 2) Then
            ; hash destination and verify
            Local $mDest = _LFC_HashFile($sDest, $iAlg)
            If ($mSrc = "") Or ($mDest = "") Or ($mSrc <> $mDest) Then Return SetError(6, 0, 0)
        EndIf
        Return 1
    EndIf
EndFunc   ;==>_LargeFileCopy

; #FUNCTION# ====================================================================================================
; Name...........:  _LargeFileCopyUnbuffered
; Description....:  Copy large files in such a way as to keep AutoIt GUIs responsive
; Syntax.........:  _LargeFileCopyUnbuffered($sSrc, $sDest[, $iFlags = 0[, $iToRead = 8388608[, $iAlg = $CALG_MD5[, $sFunction = ""[, $vUserVar = Default]]]]])
; Parameters.....:  $sSrc       - Source file name
;                   $sDest      - Destination: may be a file name or directory
;                   $iFlags     - [Optional] Combine flags with BitOR
;                               | 1 - Overwrite existing file
;                               | 2 - Create destination directory structure
;                               | 8 - Verify source and destination are identical via bit by bit comparison
;                               |16 - Verify source and destination are identical via MD5 hash
;                               + If more than one verify flag is set, the smallest flag will take precedence
;                   $iToRead    - [Optional] Size of the read buffer (Default = 8 MB)
;                   $iAlg       - [Optional] Algorithm to use for file verification (Default = $CALG_MD5)
;                               + Available algorithms: $CALG_MD2, $CALG_MD4, $CALG_MD5, $CALG_SHA1
;                   $sFunction  - [Optional] Function to be called after each write operation (Default = "")
;                               + Function will be called with the following parameters:
;                               | 1 - Total bytes written
;                               | 2 - Total file size in bytes
;                               | 3 - Optional user variable
;                   $vUserVar   - [Optional] User variable to pass to function (Default = Default)
;
; Return values..:  Success     - 1
;                   Failure     - 0 and sets @error
;                               | 1 - Failed to open source file, or source was a directory
;                               | 2 - Destination file exists and overwrite flag not set
;                               | 3 - Failed to create destination file
;                               | 4 - Read error during copy
;                               | 5 - Write error during copy
;                               | 6 - Verify failed
;                               | 7 - Failed to set destination file size
; Author.........:  Erik Pilsits
; Modified.......:
; Remarks........:
; Related........:
; Link...........:
; Example........:
; ===============================================================================================================
Func _LargeFileCopyUnbuffered($sSrc, $sDest, $iFlags = 0, $iToRead = 8388608, $iAlg = $CALG_MD5, $sFunction = "", $vUserVar = Default)
    ; check / fix source and dest path syntax
    _LFC_FixPaths($sSrc, $sDest)

    ; open file for reading, fail if it doesn't exist or directory
    Local $hSrc = _LFC_CreateFile($sSrc, $GENERIC_READ, $FILE_SHARE_READ, $OPEN_EXISTING, 0)
    If Not $hSrc Then Return SetError(1, 0, 0)

    ; set option flags
    Local $fOverwrite = (BitAND($iFlags, 1) = 1)
    Local $fCreate = (BitAND($iFlags, 2) = 2)
    Local $fVerify = 0
    If (BitAND($iFlags, 8) = 8) Then
        ; bit by bit
        $fVerify = 1
    ElseIf (BitAND($iFlags, 16) = 16) Then
        ; MD5
        $fVerify = 2
    EndIf

    ; check destination
    _LFC_CheckDestination($sSrc, $sDest, $fOverwrite, $fCreate)
    If @error Then
        _WinAPI_CloseHandle($hSrc)
        Return SetError(2, 0, 0)
    EndIf

    ; create new file for writing, overwrite
    Local $hDest = _LFC_CreateFile($sDest, BitOR($GENERIC_READ, $GENERIC_WRITE), 0, $CREATE_ALWAYS, 0xA0000000) ; FILE_FLAG_NO_BUFFERING | FILE_FLAG_WRITE_THROUGH
    If Not $hDest Then
        _WinAPI_CloseHandle($hSrc)
        Return SetError(3, 0, 0)
    EndIf

    ; check for 0 byte source file
    Local $iSize = _WinAPI_GetFileSizeEx($hSrc)
    If $iSize = 0 Then
        ; done, close handles and return success
        _WinAPI_CloseHandle($hDest)
        _WinAPI_CloseHandle($hSrc)
        Return 1
    EndIf

    ; get destination disk cluster size for unbuffered i/o
    Local $ClusterSize = _LFC_GetDiskClusterSize($sDest)
    ; if error, default to 512 and hope for the best, at worst the write operation will fail later on
    If @error Then $ClusterSize = 512

    ; perform copy
    ; create aligned buffer
    $iToRead = Ceiling($iToRead / $ClusterSize) * $ClusterSize
    Local $alignToWrite = $iToRead
    Local $pBuffer = _MemVirtualAlloc(0, $iToRead, $MEM_COMMIT, $PAGE_READWRITE)
    Local $iRead, $iWritten, $iTotal = 0, $mSrc = 0, $iReadError = 0, $iWriteError = 0, $iVerifyError = 0
    If $fVerify = 1 Then
        ; verify read buffer
        Local $vBuffer = DllStructCreate("byte[" & $iToRead & "]")
        Local $pvBuffer = DllStructGetPtr($vBuffer)
    ElseIf $fVerify = 2 Then
        _Crypt_Startup()
    EndIf

    Do
        If Not _WinAPI_ReadFile($hSrc, $pBuffer, $iToRead, $iRead) Then
            $iReadError = 1
            ExitLoop
        EndIf
        If $iRead = 0 Then ExitLoop ; end of file, edge case if file is an exact multiple of the buffer size
        ; set aligned write size for final pass
        If $iRead < $iToRead Then $alignToWrite = Ceiling($iRead / $ClusterSize) * $ClusterSize
        If Not _WinAPI_WriteFile($hDest, $pBuffer, $alignToWrite, $iWritten) Or ($alignToWrite <> $iWritten) Then
            $iWriteError = 1
            ExitLoop
        EndIf
        If $sFunction Then
            $iTotal += $iRead
            Call($sFunction, $iTotal, $iSize, $vUserVar)
        EndIf
        If $fVerify = 1 Then
            ; compare data
            If Not _LFC_BitCompare($hDest, $pBuffer, $pvBuffer, $iWritten) Then
                $iVerifyError = 1
                ExitLoop
            EndIf
        ElseIf $fVerify = 2 Then
            ; hash source inline
            $mSrc = _LFC_ChunkHash($mSrc, $pBuffer, $iRead, $iAlg)
        EndIf
    Until $iRead < $iToRead

    ; cleanup
    _MemVirtualFree($pBuffer, 0, $MEM_RELEASE)
    _WinAPI_CloseHandle($hDest)
    _WinAPI_CloseHandle($hSrc)
    If $fVerify = 2 Then
        ; finalize hash
        $mSrc = _LFC_ChunkHashFinal($mSrc)
        _Crypt_Shutdown()
    EndIf

    ; don't bother if errors above
    If (Not $iReadError) And (Not $iWriteError) And (Not $iVerifyError) Then
        ; set correct destination file size
        $hDest = _LFC_CreateFile($sDest, BitOR($GENERIC_READ, $GENERIC_WRITE), 0, $OPEN_EXISTING, 0)
        If $hDest Then
            DllCall("kernel32.dll", "bool", "SetFilePointerEx", "handle", $hDest, "int64", $iSize, "ptr", 0, "dword", 0)
            _WinAPI_SetEndOfFile($hDest)
            _WinAPI_CloseHandle($hDest)
        Else
            Return SetError(7, 0, 0)
        EndIf
    EndIf

    If $iReadError Then
        Return SetError(4, 0, 0)
    ElseIf $iWriteError Then
        Return SetError(5, 0, 0)
    Else
        If ($fVerify = 1) Then
            If $iVerifyError Then Return SetError(6, 0, 0)
        ElseIf ($fVerify = 2) Then
            ; hash destination and verify
            Local $mDest = _LFC_HashFile($sDest, $iAlg)
            If ($mSrc = "") Or ($mDest = "") Or ($mSrc <> $mDest) Then Return SetError(6, 0, 0)
        EndIf
        Return 1
    EndIf
EndFunc   ;==>_LargeFileCopyUnbuffered

; #FUNCTION# ====================================================================================================
; Name...........:  _LargeRawCopy
; Description....:  Copy large memory blocks to files in such a way as to keep AutoIt GUIs responsive
; Syntax.........:  _LargeRawCopy($pSrc, $iSrcSize, $sDest[, $iFlags = 0[, $iToRead = 8388608[, $iAlg = $CALG_MD5[, $sFunction = ""[, $vUserVar = Default]]]]])
; Parameters.....:  $pSrc       - Pointer to source raw data
;                   $iSrcSize   - Size of raw data
;                   $sDest      - Destination file name, must not be an existing directory
;                   $iFlags     - [Optional] Combine flags with BitOR
;                               | 1 - Overwrite existing file
;                               | 2 - Create destination directory structure
;                               | 4 - Flush the destination file buffer before returning
;                               | 8 - Verify source and destination are identical via bit by bit comparison
;                               |16 - Verify source and destination are identical via MD5 hash
;                               |32 - Verify source and destination file size only
;                               + If more than one verify flag is set, the smallest flag will take precedence
;                   $iToRead    - [Optional] Size of the read buffer (Default = 8 MB)
;                   $iAlg       - [Optional] Algorithm to use for file verification (Default = $CALG_MD5)
;                               + Available algorithms: $CALG_MD2, $CALG_MD4, $CALG_MD5, $CALG_SHA1
;                   $sFunction  - [Optional] Function to be called after each write operation (Default = "")
;                               + Function will be called with the following parameters:
;                               | 1 - Total bytes written
;                               | 2 - Total file size in bytes
;                               | 3 - Optional user variable
;                   $vUserVar   - [Optional] User variable to pass to function (Default = Default)
;
; Return values..:  Success     - 1
;                   Failure     - 0 and sets @error
;                               |-1 - $iSrcSize may not be 0
;                               | 1 - $pSrc and $iSrcSize point to inaccessible memory
;                               | 2 - Destination is an existing directory
;                               | 3 - Destination file exists and overwrite flag not set
;                               | 4 - Failed to create destination file
;                               | 5 - Write error during copy
;                               | 6 - Verify failed
; Author.........:  Erik Pilsits
; Modified.......:
; Remarks........:
; Related........:
; Link...........:
; Example........:
; ===============================================================================================================
Func _LargeRawCopy($pSrc, $iSrcSize, $sDest, $iFlags = 0, $iToRead = 8388608, $iAlg = $CALG_MD5, $sFunction = "", $vUserVar = Default)
    ; check source size
    If $iSrcSize = 0 Then Return SetError(-1, 0, 0)
    ; check source memory, 0 = success
    Local $ret = DllCall("kernel32.dll", "bool", "IsBadReadPtr", "ptr", $pSrc, "uint_ptr", $iSrcSize)
    If $ret[0] Then Return SetError(1, 0, 0)

    ; check / fix dest path syntax
    _LFC_FixPath($sDest)

    ; set option flags
    Local $fOverwrite = (BitAND($iFlags, 1) = 1)
    Local $fCreate = (BitAND($iFlags, 2) = 2)
    Local $fFlush = (BitAND($iFlags, 4) = 4)
    Local $fVerify = 0
    If (BitAND($iFlags, 8) = 8) Then
        ; bit by bit
        $fVerify = 1
    ElseIf (BitAND($iFlags, 16) = 16) Then
        ; MD5
        $fVerify = 2
    ElseIf (BitAND($iFlags, 32) = 32) Then
        ; file size
        $fVerify = 3
    EndIf

    ; check destination
    _LFC_CheckDestination("", $sDest, $fOverwrite, $fCreate)
    Switch @error
        Case 1
            ; overwrite fail
            Return SetError(3, 0, 0)
        Case 2
            ; no file name
            Return SetError(2, 0, 0)
    EndSwitch

    ; create new file for writing, overwrite
    Local $hDest = _LFC_CreateFile($sDest, BitOR($GENERIC_READ, $GENERIC_WRITE), 0, $CREATE_ALWAYS, 0)
    If Not $hDest Then Return SetError(4, 0, 0)

    ; perform copy
    If $iToRead > $iSrcSize Then $iToRead = $iSrcSize
    Local $pRead = $pSrc, $iToGo = $iSrcSize
    Local $iWritten, $iWriteError = 0, $iVerifyError = 0
    Local $iTotal = 0, $mSrc = 0
    If $fVerify = 1 Then
        ; verify read buffer
        Local $vBuffer = DllStructCreate("byte[" & $iToRead & "]")
        Local $pvBuffer = DllStructGetPtr($vBuffer)
    ElseIf $fVerify = 2 Then
        _Crypt_Startup()
    EndIf

    Do
        If Not _WinAPI_WriteFile($hDest, $pRead, $iToRead, $iWritten) Or ($iToRead <> $iWritten) Then
            $iWriteError = 1
            ExitLoop
        EndIf
        If $sFunction Then
            $iTotal += $iToRead
            Call($sFunction, $iTotal, $iSrcSize, $vUserVar)
        EndIf
        If $fVerify = 1 Then
            ; compare data
            If Not _LFC_BitCompare($hDest, $pRead, $pvBuffer, $iWritten) Then
                $iVerifyError = 1
                ExitLoop
            EndIf
        ElseIf $fVerify = 2 Then
            ; hash source inline
            $mSrc = _LFC_ChunkHash($mSrc, $pRead, $iWritten, $iAlg)
        EndIf
        ; ready next chunk
        $pRead += $iToRead
        $iToGo -= $iToRead
        ; set $iToRead for final pass
        If $iToGo < $iToRead Then $iToRead = $iToGo
    Until $iToGo = 0

    ; the FlushFileBuffers command here can take some time: ~1s for a 75MB file, ~4s for a 700MB file
    ; it's probably safest to enable this if you need to make sure the write buffer is empty before continuing
    ; the FileCopy function does NOT seem to do this based on execution time
    If $fFlush Then _WinAPI_FlushFileBuffers($hDest)
    ; check file size in verify mode 3 before closing handles
    If $fVerify = 3 Then
        If Not _LFC_SizeCompare($iSrcSize, $hDest) Then $iVerifyError = 1
    EndIf
    _WinAPI_CloseHandle($hDest)
    If $fVerify = 2 Then
        ; finalize hash
        $mSrc = _LFC_ChunkHashFinal($mSrc)
        _Crypt_Shutdown()
    EndIf

    If $iWriteError Then
        Return SetError(5, 0, 0)
    Else
        If ($fVerify = 1) Or ($fVerify = 3) Then
            If $iVerifyError Then Return SetError(6, 0, 0)
        ElseIf ($fVerify = 2) Then
            ; hash destination and verify
            Local $mDest = _LFC_HashFile($sDest, $iAlg)
            If ($mSrc = "") Or ($mDest = "") Or ($mSrc <> $mDest) Then Return SetError(6, 0, 0)
        EndIf
        Return 1
    EndIf
EndFunc   ;==>_LargeRawCopy

; #FUNCTION# ====================================================================================================
; Name...........:  _LargeRawCopyUnbuffered
; Description....:  Copy large memory blocks to files in such a way as to keep AutoIt GUIs responsive
; Syntax.........:  _LargeRawCopyUnbuffered($pSrc, $iSrcSize, $sDest[, $iFlags = 0[, $iToRead = 8388608[, $iAlg = $CALG_MD5[, $sFunction = ""[, $vUserVar = Default]]]]])
; Parameters.....:  $pSrc       - Pointer to source raw data
;                   $iSrcSize   - Size of raw data
;                   $sDest      - Destination file name, must not be an existing directory
;                   $iFlags     - [Optional] Combine flags with BitOR
;                               | 1 - Overwrite existing file
;                               | 2 - Create destination directory structure
;                               | 8 - Verify source and destination are identical via bit by bit comparison
;                               |16 - Verify source and destination are identical via MD5 hash
;                               + If more than one verify flag is set, the smallest flag will take precedence
;                   $iToRead    - [Optional] Size of the read buffer (Default = 8 MB)
;                   $iAlg       - [Optional] Algorithm to use for file verification (Default = $CALG_MD5)
;                               + Available algorithms: $CALG_MD2, $CALG_MD4, $CALG_MD5, $CALG_SHA1
;                   $sFunction  - [Optional] Function to be called after each write operation (Default = "")
;                               + Function will be called with the following parameters:
;                               | 1 - Total bytes written
;                               | 2 - Total file size in bytes
;                               | 3 - Optional user variable
;                   $vUserVar   - [Optional] User variable to pass to function (Default = Default)
;
; Return values..:  Success     - 1
;                   Failure     - 0 and sets @error
;                               |-1 - $iSrcSize may not be 0
;                               | 1 - $pSrc and $iSrcSize point to inaccessible memory
;                               | 2 - Destination is an existing directory
;                               | 3 - Destination file exists and overwrite flag not set
;                               | 4 - Failed to create destination file
;                               | 5 - Write error during copy
;                               | 6 - Verify failed
;                               | 7 - Failed to set destination file size
; Author.........:  Erik Pilsits
; Modified.......:
; Remarks........:
; Related........:
; Link...........:
; Example........:
; ===============================================================================================================
Func _LargeRawCopyUnbuffered($pSrc, $iSrcSize, $sDest, $iFlags = 0, $iToRead = 8388608, $iAlg = $CALG_MD5, $sFunction = "", $vUserVar = Default)
    ; check source size
    If $iSrcSize = 0 Then Return SetError(-1, 0, 0)
    ; check source memory, 0 = success
    Local $ret = DllCall("kernel32.dll", "bool", "IsBadReadPtr", "ptr", $pSrc, "uint_ptr", $iSrcSize)
    If $ret[0] Then Return SetError(1, 0, 0)

    ; check / fix dest path syntax
    _LFC_FixPath($sDest)

    ; set option flags
    Local $fOverwrite = (BitAND($iFlags, 1) = 1)
    Local $fCreate = (BitAND($iFlags, 2) = 2)
    Local $fVerify = 0
    If (BitAND($iFlags, 8) = 8) Then
        ; bit by bit
        $fVerify = 1
    ElseIf (BitAND($iFlags, 16) = 16) Then
        ; MD5
        $fVerify = 2
    EndIf

    ; check destination
    _LFC_CheckDestination("", $sDest, $fOverwrite, $fCreate)
    Switch @error
        Case 1
            ; overwrite fail
            Return SetError(3, 0, 0)
        Case 2
            ; no file name
            Return SetError(2, 0, 0)
    EndSwitch

    ; get destination disk cluster size for unbuffered i/o
    Local $ClusterSize = _LFC_GetDiskClusterSize($sDest)
    ; if error, default to 512 and hope for the best, at worst the write operation will fail later on
    If @error Then $ClusterSize = 512

    ; create new file for writing, overwrite
    Local $hDest = _LFC_CreateFile($sDest, BitOR($GENERIC_READ, $GENERIC_WRITE), 0, $CREATE_ALWAYS, 0xA0000000) ; FILE_FLAG_NO_BUFFERING | FILE_FLAG_WRITE_THROUGH
    If Not $hDest Then Return SetError(4, 0, 0)

    ; perform copy
    ; create aligned buffer
    $iToRead = Ceiling($iToRead / $ClusterSize) * $ClusterSize
    Local $alignToWrite = $iToRead
    Local $pBuffer = _MemVirtualAlloc(0, $iToRead, $MEM_COMMIT, $PAGE_READWRITE)
    ; resize $iToRead if necessary (ie copy will be performed in one pass)
    If $iToRead > $iSrcSize Then $iToRead = $iSrcSize
    Local $pRead = $pSrc, $iToGo = $iSrcSize
    Local $iWritten, $iWriteError = 0, $iVerifyError = 0
    Local $iTotal = 0, $mSrc = 0
    If $fVerify = 1 Then
        ; verify read buffer
        Local $vBuffer = DllStructCreate("byte[" & $iToRead & "]")
        Local $pvBuffer = DllStructGetPtr($vBuffer)
    ElseIf $fVerify = 2 Then
        _Crypt_Startup()
    EndIf

    Do
        ; copy memory to write buffer
        _LFC_memcpy($pBuffer, $pRead, $iToRead)
        ; set aligned write size for final pass
        If $iToRead < $alignToWrite Then $alignToWrite = Ceiling($iToRead / $ClusterSize) * $ClusterSize
        ; fill buffer with 00 up to cluster boundary
;~      _LFC_memset($pBuffer + $iToRead, 0, $alignToWrite - $iToRead)
        ; write data
        If Not _WinAPI_WriteFile($hDest, $pBuffer, $alignToWrite, $iWritten) Or ($alignToWrite <> $iWritten) Then
            $iWriteError = 1
            ExitLoop
        EndIf
        If $sFunction Then
            $iTotal += $iToRead
            Call($sFunction, $iTotal, $iSrcSize, $vUserVar)
        EndIf
        If $fVerify = 1 Then
            ; compare data
            If Not _LFC_BitCompare($hDest, $pBuffer, $pvBuffer, $iWritten) Then
                $iVerifyError = 1
                ExitLoop
            EndIf
        ElseIf $fVerify = 2 Then
            ; hash source inline
            $mSrc = _LFC_ChunkHash($mSrc, $pBuffer, $iToRead, $iAlg)
        EndIf
        ; ready next chunk
        $pRead += $iToRead
        $iToGo -= $iToRead
        ; set $iToRead for final pass
        If $iToGo < $iToRead Then $iToRead = $iToGo
    Until $iToGo = 0

    ; cleanup
    _MemVirtualFree($pBuffer, 0, $MEM_RELEASE)
    _WinAPI_CloseHandle($hDest)
    If $fVerify = 2 Then
        ; finalize hash
        $mSrc = _LFC_ChunkHashFinal($mSrc)
        _Crypt_Shutdown()
    EndIf

    ; don't bother if errors above
    If (Not $iWriteError) And (Not $iVerifyError) Then
        ; set correct destination file size
        $hDest = _LFC_CreateFile($sDest, BitOR($GENERIC_READ, $GENERIC_WRITE), 0, $OPEN_EXISTING, 0)
        If $hDest Then
            DllCall("kernel32.dll", "bool", "SetFilePointerEx", "handle", $hDest, "int64", $iSrcSize, "ptr", 0, "dword", 0)
            _WinAPI_SetEndOfFile($hDest)
            _WinAPI_CloseHandle($hDest)
        Else
            Return SetError(7, 0, 0)
        EndIf
    EndIf

    If $iWriteError Then
        Return SetError(5, 0, 0)
    Else
        If ($fVerify = 1) Then
            If $iVerifyError Then Return SetError(6, 0, 0)
        ElseIf ($fVerify = 2) Then
            ; hash destination and verify
            Local $mDest = _LFC_HashFile($sDest, $iAlg)
            If ($mSrc = "") Or ($mDest = "") Or ($mSrc <> $mDest) Then Return SetError(6, 0, 0)
        EndIf
        Return 1
    EndIf
EndFunc   ;==>_LargeRawCopyUnbuffered

#Region INTERNAL FUNCTIONS
Func _LFC_CheckDestination($sSrc, ByRef $sDest, $fOverwrite, $fCreate)
    If (StringRight($sDest, 1) = "\") Or StringInStr(FileGetAttrib($sDest), "D") Then
        ; assume directory
        If $sSrc = "" Then
            ; raw copy, must provide a file name
            Return SetError(2)
        Else
            ; use source file name
            If StringRight($sDest, 1) <> "\" Then $sDest &= "\" ; add trailing \
            $sDest &= StringRegExpReplace($sSrc, ".*\\", "")
        EndIf
    EndIf
    ; check overwrite
    If (Not $fOverwrite) And FileExists($sDest) Then Return SetError(1)
    ; create destination parent directory
    ; if create flag not set and destination doesn't exist, CreateFile will fail
    If $fCreate Then DirCreate(StringRegExpReplace($sDest, "^(.*)\\.*?$", "${1}"))
EndFunc   ;==>_LFC_CheckDestination

Func _LFC_ChunkHash($hCryptHash, $pSrc, $iSize, $iAlg = $CALG_MD5)
    Local $aRet
    If $hCryptHash = 0 Then
        ; Create Hash object
        $aRet = DllCall(__Crypt_DllHandle(), "bool", "CryptCreateHash", "handle", __Crypt_Context(), "uint", $iAlg, "ptr", 0, "dword", 0, "handle*", 0)
        If @error Or Not $aRet[0] Then Return SetError(1, 0, -1)
        $hCryptHash = $aRet[5]
    ElseIf $hCryptHash = -1 Then
        ; previous error
        Return SetError(3, 0, -1)
    EndIf

    $aRet = DllCall(__Crypt_DllHandle(), "bool", "CryptHashData", "handle", $hCryptHash, "ptr", $pSrc, "dword", $iSize, "dword", $CRYPT_USERDATA)
    If @error Or Not $aRet[0] Then
        DllCall(__Crypt_DllHandle(), "bool", "CryptDestroyHash", "handle", $hCryptHash)
        Return SetError(2, 0, -1)
    EndIf

    Return $hCryptHash
EndFunc   ;==>_LFC_ChunkHash

Func _LFC_ChunkHashFinal($hCryptHash)
    Local $iError, $vReturn
    If $hCryptHash = -1 Then
        ; previous error
        $iError = 1
        $vReturn = ""
        $hCryptHash = 0
    Else
        ; get hash size, in $aRet[3]
        Local $aRet = DllCall(__Crypt_DllHandle(), "bool", "CryptGetHashParam", "handle", $hCryptHash, "dword", $HP_HASHSIZE, "dword*", 0, "dword*", 4, "dword", 0)
        If @error Or Not $aRet[0] Then
            $iError = 2
            $vReturn = ""
        Else
            ; get hash
            Local $hBuff = DllStructCreate("byte[" & $aRet[3] & "]")
            $aRet = DllCall(__Crypt_DllHandle(), "bool", "CryptGetHashParam", "handle", $hCryptHash, "dword", $HP_HASHVAL, "ptr", DllStructGetPtr($hBuff), "dword*", DllStructGetSize($hBuff), "dword", 0)
            If @error Or Not $aRet[0] Then
                $iError = 3
                $vReturn = ""
            Else
                $iError = 0
                $vReturn = DllStructGetData($hBuff, 1)
            EndIf
        EndIf
    EndIf

    ; Cleanup and return hash
    If $hCryptHash <> 0 Then DllCall(__Crypt_DllHandle(), "bool", "CryptDestroyHash", "handle", $hCryptHash)
    Return SetError($iError, 0, $vReturn)
EndFunc   ;==>_LFC_ChunkHashFinal

Func _LFC_HashFile($sFile, $iAlg = $CALG_MD5)
    ; check target exists and is a file
    If Not FileExists($sFile) Or StringInStr(FileGetAttrib($sFile), "D") Then Return SetError(1, 0, "")
    Local $sHash = _LFC_HashFileInternal($sFile, $iAlg)
    If @error Or ($sHash = "") Then
        Return SetError(2, 0, "")
    Else
        Return $sHash
    EndIf
EndFunc   ;==>_LFC_HashFile

Func _LFC_HashFileInternal($sFile, $iAlg = $CALG_MD5)
    Local $hSrc = _LFC_CreateFile($sFile, $GENERIC_READ, $FILE_SHARE_READ, $OPEN_EXISTING, 0)
    If Not $hSrc Then Return SetError(1, 0, "")

    Local $iRead, $iReadError = 0, $sHash = 0, $iToRead = 1024 * 1024 * 8
    Local $hBuffer = DllStructCreate("byte[" & $iToRead & "]")
    Local $pBuffer = DllStructGetPtr($hBuffer)

    _Crypt_Startup()
    Do
        If Not _WinAPI_ReadFile($hSrc, $pBuffer, $iToRead, $iRead) Then
            $iReadError = 1
            ExitLoop
        EndIf
        If $iRead = 0 Then ExitLoop ; end of file, edge case if file is an exact multiple of the buffer size
        $sHash = _LFC_ChunkHash($sHash, $pBuffer, $iRead, $iAlg)
        If @error Then
            $iReadError = 1
            ExitLoop
        EndIf
    Until $iRead < $iToRead
    _WinAPI_CloseHandle($hSrc)
    $sHash = _LFC_ChunkHashFinal($sHash)
    _Crypt_Shutdown()

    If $iReadError Then
        Return SetError(2, 0, "")
    Else
        Return $sHash
    EndIf
EndFunc   ;==>_LFC_HashFileInternal

Func _LFC_BitCompare($hDest, $pSrc, $pVerify, $iToVerify)
    ; if there are any errors at all, FAIL
    ; check memory ranges
    Local $ret = DllCall("kernel32.dll", "bool", "IsBadReadPtr", "ptr", $pSrc, "uint_ptr", $iToVerify)
    If @error Or $ret[0] Then Return SetError(1, 0, 0)
    $ret = DllCall("kernel32.dll", "bool", "IsBadReadPtr", "ptr", $pVerify, "uint_ptr", $iToVerify)
    If @error Or $ret[0] Then Return SetError(2, 0, 0)
    ; first move file pointer back by $iToVerify bytes
    $ret = DllCall("kernel32.dll", "bool", "SetFilePointerEx", "handle", $hDest, "int64", -$iToVerify, "ptr", 0, "dword", 1) ; FILE_CURRENT
    If @error Or Not $ret[0] Then Return SetError(3, 0, 0)
    ; read data just written to destination
    Local $iRead
    If Not _WinAPI_ReadFile($hDest, $pVerify, $iToVerify, $iRead) Or ($iRead <> $iToVerify) Then Return SetError(4, 0, 0)
    ; compare data
    $ret = DllCall("msvcrt.dll", "int:cdecl", "memcmp", "ptr", $pSrc, "ptr", $pVerify, "ulong_ptr", $iToVerify)
    If @error Or $ret[0] Then
        Return SetError(5, 0, 0)
    Else
        Return 1
    EndIf
EndFunc   ;==>_LFC_BitCompare

Func _LFC_SizeCompare($hFile1, $hFile2)
    Local $iSize1
    If IsPtr($hFile1) Then
        $iSize1 = DllCall("kernel32.dll", "bool", "GetFileSizeEx", "handle", $hFile1, "int64*", 0)
        If @error Or Not $iSize1[0] Then Return SetError(1, 0, 0)
        $iSize1 = $iSize1[2]
    Else
        ; for _LargeRawCopy
        $iSize1 = $hFile1
    EndIf
    Local $iSize2 = DllCall("kernel32.dll", "bool", "GetFileSizeEx", "handle", $hFile2, "int64*", 0)
    If @error Or Not $iSize2[0] Then Return SetError(2, 0, 0)
    ; compare size
    If $iSize1 = $iSize2[2] Then
        Return 1
    Else
        Return SetError(3, 0, 0)
    EndIf
EndFunc   ;==>_LFC_SizeCompare

Func _LFC_CreateFile($sPath, $iAccess, $iShareMode, $iCreation, $iFlags)
    ; open the file with existing HIDDEN or SYSTEM attributes to avoid failure when using CREATE_ALWAYS
    If $iCreation = $CREATE_ALWAYS Then
        Local $sAttrib = FileGetAttrib($sPath)
        If StringInStr($sAttrib, "H") Then $iFlags = BitOR($iFlags, $FILE_ATTRIBUTE_HIDDEN)
        If StringInStr($sAttrib, "S") Then $iFlags = BitOR($iFlags, $FILE_ATTRIBUTE_SYSTEM)
    EndIf
    Local $hFile = DllCall("kernel32.dll", "handle", "CreateFileW", "wstr", $sPath, "dword", $iAccess, "dword", $iShareMode, "ptr", 0, _
            "dword", $iCreation, "dword", $iFlags, "ptr", 0)
    If @error Or ($hFile[0] = Ptr(-1)) Then Return SetError(1, 0, 0)
    Return $hFile[0]
EndFunc   ;==>_LFC_CreateFile

Func _LFC_FixPath(ByRef $sPath)
    ; fix possible forward /
    $sPath = StringRegExpReplace($sPath, "/", "\\")
    If Not StringInStr($sPath, ":") Then
        ; not a full path
        ; check for bare, relative, or UNC paths
        If StringLeft($sPath, 1) = "\" Then
            ; check for UNC path
            If StringLeft($sPath, 2) <> "\\" Then
                ; not a UNC path
                $sPath = "." & $sPath
                ; else, probably a UNC path, leave it alone
            EndIf
        Else
            ; check for bare or relative path
            If StringLeft($sPath, 1) <> "." Then
                ; bare path
                $sPath = ".\" & $sPath
                ; else, probably relative path, leave it alone
            EndIf
        EndIf
    EndIf
EndFunc   ;==>_LFC_FixPath

Func _LFC_FixPaths(ByRef $sSrc, ByRef $sDest)
    ; remove trailing \'s from source only
    $sSrc = StringRegExpReplace($sSrc, "\\+$", "")
    ; check for relative paths in source and dest
    _LFC_FixPath($sSrc)
    _LFC_FixPath($sDest)
EndFunc   ;==>_LFC_FixPaths

Func _LFC_GetDiskClusterSize($sPath)
    Local $aRet = DllCall("kernel32.dll", "bool", "GetDiskFreeSpaceW", "wstr", _LFC_PathGetDrive($sPath), "dword*", 0, "dword*", 0, "dword*", 0, "dword*", 0)
    If @error Or (Not $aRet[0]) Then Return SetError(1, 0, 0)
    Return $aRet[3]
EndFunc   ;==>_LFC_GetDiskClusterSize

Func _LFC_memcpy($dest, $src, $size)
    Local $ret = DllCall("msvcrt.dll", "ptr:cdecl", "memcpy", "ptr", $dest, "ptr", $src, "ulong_ptr", $size)
    Return $ret[0]
EndFunc   ;==>_LFC_memcpy

Func _LFC_memset($dest, $c, $size)
    Local $ret = DllCall("msvcrt.dll", "ptr:cdecl", "memset", "ptr", $dest, "int", $c, "ulong_ptr", $size)
    Return $ret[0]
EndFunc   ;==>_LFC_memset

Func _LFC_PathGetDrive($sPath)
    If StringInStr($sPath, ":") Then
        ; full or UNC path
        Return StringRegExpReplace($sPath, "^.*([[:alpha:]]:).*$", "${1}\\")
    Else
        ; relative path, use current drive
        Return StringRegExpReplace(@WorkingDir, "^([[:alpha:]]:).*$", "${1}\\")
    EndIf
EndFunc   ;==>_LFC_PathGetDrive
#EndRegion INTERNAL FUNCTIONS