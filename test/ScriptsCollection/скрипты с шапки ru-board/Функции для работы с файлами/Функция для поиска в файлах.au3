#cs --------------------------------------------------------------------------------------------------------------------
Author:  Function _FindTextInFile() was modified by G.Sandler a.k.a CreatoR (originaly by Sanja Alone)
Script Function: Find Text in file (matching whole word)
#ce --------------------------------------------------------------------------------------------------------------------

#include <Array.au3>

$File = "Test.txt|My File.ini"
$Text = "Some text"

$FindVar = _FileFindText($File, $Text, 0, 1)

If Not @error Then
    For $i = 1 To $FindVar[0][0]
        MsgBox(262144+64, "Found ¹" & $i, _
        "The Text <" & $Text & "> was found [" & $FindVar[0][0] & "] times totaly in file(s)..." & @LF & _
        "Current search results (" & $i & " from " & $FindVar[0][0] & ") for file: " & @LF & _
        "<" & $FindVar[$i][0] & ">" & @LF & @LF & _
        "This line include the needed text: <" & $FindVar[$i][1] & ">" & @LF & _
        "The ¹ of line is: <" & $FindVar[$i][2] & ">" & @LF & _
        "The position of founded text in line is: <" & $FindVar[$i][3] & ">")
    Next
ElseIf @error = 1 Then
    MsgBox(262144+16, "Error", "Unable to locate the File:" & @LF & "[" & $File & "]")
ElseIf @error > 0 Then
    MsgBox(262144+48, "Error", "The Text [" & $Text & "] was not found in file(s):" & @LF & "[" & $File & "]")
EndIf

;===============================================================================
; Description:      Find text in file.
; Parameter(s):     $iFile - File name to search in, $Text - text to find.
;                   $MatchWholeWordFlag - flag that defines if serch will match whole word, or search all occurrences.
;                   $CaseSense - Defines if the search will be case sensitive.
; Requirement(s):   AutoIt 3.2.2.0.
; Return Value(s):  On seccess - Returns 2-d array, that include fallowing elements:
;                      $RetArr[$n][0] = The actualy whole line that include $Text.
;                      $RetArr[$n][1] = The number of line that $text was found in.
;                      $RetArr[$n][2] = The position in line that $Text was found in.
;                   On failure - If given file not exists, set @error to 1 and return -1...
;                   If the $Text was non found, then returns 0 (zero) and set @error on 2.
;
; Author(s):        G.Sandler a.k.a CreatoR
;===============================================================================
Func _FileFindText($sFile, $sFindText, $MatchWholeWordFlag = 0, $iCaseSense = 0)
    If Not StringInStr($sFile, "|") And Not FileExists($sFile) Then Return SetError(1, 0, -1)

    Local $aFilesArr = StringSplit($sFile, "|"), $hFile
    Local $iCount = 0, $iLineN = 0, $sCurrentLine, $iMatch = 1, $iStrPos, $aRetArr[1][1]

    For $i = 1 To UBound($aFilesArr)-1
        If FileExists($aFilesArr[$i]) Then
            $hFile = FileOpen($aFilesArr[$i], 0)
            While 1
                $sCurrentLine = FileReadLine($hFile)
                If @error = -1 Then ExitLoop
                $iLineN += 1
                If StringIsASCII($sFindText) Then
                    $iStrPos = StringInStr($sCurrentLine, $sFindText)
                Else
                    $sCurrentLine = StringLower($sCurrentLine)
                    $iStrPos = StringInStr($sCurrentLine, StringLower($sFindText))
                    $sFindText = StringLower($sFindText)
                EndIf
                If StringInStr($sCurrentLine, $sFindText, $iCaseSense) Then
                    If $MatchWholeWordFlag = 1 Then
                        If StringStripWS(StringMid($sCurrentLine, $iStrPos - 1, 1), 2) = "" And _
                            StringStripWS(StringMid($sCurrentLine, $iStrPos + StringLen($sFindText), 1), 2) = "" Then
                            $iMatch = 1
                        Else
                            $iMatch = 0
                        EndIf
                    EndIf
                    If $iMatch = 1 Then
                        $aRetArr[0][0] += 1
                        ReDim $aRetArr[$aRetArr[0][0]+1][4]
                        $aRetArr[$aRetArr[0][0]][0] = $aFilesArr[$i]
                        $aRetArr[$aRetArr[0][0]][1] = $sCurrentLine
                        $aRetArr[$aRetArr[0][0]][2] = $iLineN
                        $aRetArr[$aRetArr[0][0]][3] = $iStrPos
                    EndIf
                EndIf
            WEnd
            FileClose($hFile)
        EndIf
    Next
    If UBound($aRetArr) <= 1 Then Return SetError(2, 0, 0)
    Return $aRetArr
EndFunc