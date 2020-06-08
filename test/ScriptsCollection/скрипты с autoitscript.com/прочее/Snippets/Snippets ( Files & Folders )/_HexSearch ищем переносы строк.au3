;Author-MKISH, _HexSearch function (originally written by Zinthose, modified by MKISH)
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7

;Checks the number of lines in a file (useful for larger files as well)

#include <WinAPI.au3>
$FILE = "C:\sources\boot.wim"
$COUNT = 0
$start = default
While 1
$res = _HexSearch($FILE, StringToBinary("" & @crlf), $start)
$start = $res + 2
$COUNT = $COUNT + 1
If $res = -1 then exitloop
Wend
msgbox(64, "", "Lines count: " & $COUNT)

Func _HexSearch($FilePath, $BinaryValue, $StartOffset = Default)
        Local $Buffer, $ptr, $hFile, $Result, $Read, $SearchValue, $Pos, $BufferSize = 2048
            If $StartOffset = Default     Then $StartOffset = 0
            If Not FileExists($FilePath)    Then    Return SetError(1, @error, 0)
            $fLen = FileGetSize($FilePath)
            If $StartOffset > $fLen   Then   Return SetError(2, @error, 0)
            If Not IsBinary($BinaryValue)   Then    Return SetError(3, @error, 0)
            If Not IsNumber($StartOffset)   Then    Return SetError(4, @error, 0)
            $SearchValue = BinaryToString($BinaryValue)
            $Buffer = DllStructCreate("byte[" & $BufferSize & "]")
            $ptr = DllStructGetPtr($Buffer)
                $hFile = _WinAPI_CreateFile($FilePath, 2, 2, 1)
                If $hFile = 0 Then Return SetError(5, @error, 0)
            $Result = _WinAPI_SetFilePointer($hFile, $StartOffset)
            $err = @error
            If $Result = 0xFFFFFFFF Then
                _WinAPI_CloseHandle($hFile)
                Return SetError(5, $err, 0)
            EndIf
            $Pos = $StartOffset
            While True
                    $Read = 0
                    $Result = _WinAPI_ReadFile($hFile, $ptr, $BufferSize, $Read)
                    $err = @error
                    If Not $Result Then
                        _WinAPI_CloseHandle($hFile)
                        Return SetError(6, $err, 0)
                    EndIf
                    $Result = DllStructGetData($Buffer, 1)
                    $Result = BinaryToString($Result)
                    $Result = StringInStr($Result, $SearchValue)
                    If $Result > 0 Then ExitLoop
                    If $Read < $BufferSize Then
                        _WinAPI_CloseHandle($hFile)
                        Return -1
                    EndIf
                    $Pos += $Read
                
            WEnd
            _WinAPI_CloseHandle($hFile)
            If Not $Result Then Return SetError(7, @error, 0)
            $Result = $Pos + $Result - 1
            Return $Result
    EndFunc; ==> _HexSearch