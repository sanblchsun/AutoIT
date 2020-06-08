; #Description# =================================================================================================================
; Title .........:  AudioGenie3.au3
; Description ...:  Allows easy reading and writing of tags to mp3 files.
; Author ........:  Gavin Campbell
; ===============================================================================================================================

; #Functions# ===================================================================================================================
;           _AudioGenie3_Start() - Initialise AudioGenie3
;           _AudioGenie3_Stop() - Stop AudioGenie3
;           _AudioGenie3_WriteID3Tag($File, $Tag, $Data) - Write an ID3 tag.
;           _AudioGenie3_ReadID3Tag($File, $Tag) - Read an ID3 tag.
; ===============================================================================================================================

; #Comments# ===================================================================================================================
;   This uses the AudioGenie3.dll (version "2.0.0.3") file.  You can download that from http://www.audiogenie.net/
;   This DLL will need to be placed in your script folder as that is where it is loaded from.
;   Due to laziness I have not yet implemented the Genre tags.
;   I have also not implemented all of the ID3V2 frames yet.  But it should be simple to add what you need.
;   Comment data for ID3V2 tags will need to be passed back and forth as a multie dimensional array as there can be more than
;       one comment in the ID3V2.
;       Each comment however must have a unique language and description or they will be replaced.
;       To pass the comment data create an array like Mycomments[x][3]
;       For each comment (x) you will need to specify 3 values
;           0 = language
;           1 = descripton
;           3 = comment
; ===============================================================================================================================

; #Version# =====================================================================================================================
;   0.1.0.0 - Initial version
; ===============================================================================================================================

;#include <array.au3>
#include <string.au3>

Local Const $_AudioGenie3DLL = @ScriptDir & "\AudioGenie3.dll" ; The AudioGenie3.dll file
Local Const $_AudioGenie3DLLCompatibleVersion = "2.0.0.3" ; The version of the AudioGenie3.dll filee that is compatible with this code
Global $_AudioGenie3DLLHandle = 0 ; Stores the handle of the open AudioGenie3.dll file.

Local Const $ID3V1TagStart = 1 ; Start of ID3V1 Tags
Global Const $ID3V1_Album = 1
Global Const $ID3V1_Artist = 2
Global Const $ID3V1_Comment = 3
Global Const $ID3V1_Genre = 4
Global Const $ID3V1_Title = 5
Global Const $ID3V1_Track = 6
Global Const $ID3V1_Year = 7
Local Const $ID3V1TagEnd = 7 ; End of ID3V1 Tags
Local Const $ID3V2TagStart = 8 ; Start of ID3V2 Tags
Global Const $ID3V2_Album = 8
Global Const $ID3V2_Artist = 9
Global Const $ID3V2_Comment = 10
Global Const $ID3V2_Genre = 11
Global Const $ID3V2_Title = 12
Global Const $ID3V2_Track = 13
Global Const $ID3V2_Year = 14
Global Const $ID3V2_BPM = 15
Local Const $ID3V2TagEnd = 15 ; End of ID3V2 Tags


; #FUNCTION# ====================================================================================================================
; Name...........:  _AudioGenie3_ReadID3Tag
; Description ...:  Will read the specified tag from the MP3 and return the value.
; Syntax.........:  _AudioGenie3_ReadID3Tag [FileName] [Tag Constant]
; Parameters ....:  $File - the file to read from
;                   $Tag - the tag constant to read, use the constants specified (ID3V1_*/ID3V2_*)
; Return values .:  For ID3V2_Comments an array will be returned as there can be more than one comment frame in the tag (*see comments*).
;                   All other tags will return a string value.
; ===============================================================================================================================
Func _AudioGenie3_ReadID3Tag($File, $Tag)
    Local $ReturnCode = ""
    Local $rc = 0

    $rc = DllCall($_AudioGenie3DLLHandle, "int", "AUDIOAnalyzeFileW", "wstr", $File) ; open the file and ensure its a mp3 (returns 1)
    ;MsgBox(0, "", "debug")
    If $rc[0] = 1 Then

        If $Tag >= $ID3V1TagStart And $Tag <= $ID3V1TagEnd Then ;ID3V1
            ; check if ID3V1 data exists (-1=yes)
            $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V1ExistsW")
            If $rc[0] = -1 Then
                ; File containes ID3V1 data
                ; Get the tag we want
                ;$rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V1GetVersionW")
                ;_ArrayDisplay($rc) ; just want to see what the version number is
                Switch $Tag
                    Case $ID3V1_Album
                        $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V1GetAlbumW")
                        $ReturnCode = $rc[0]
                    Case $ID3V1_Artist
                        $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V1GetArtistW")
                        $ReturnCode = $rc[0]
                    Case $ID3V1_Comment
                        $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V1GetCommentW")
                        $ReturnCode = $rc[0]
                        ;Case $ID3V1_Genre - how to implement
                    Case $ID3V1_Title
                        $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V1GetTitleW")
                        $ReturnCode = $rc[0]
                    Case $ID3V1_Track
                        $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V1GetTrackW")
                        $ReturnCode = $rc[0]
                    Case $ID3V1_Year
                        $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V1GetYearW")
                        $ReturnCode = $rc[0]
                    Case Else
                        $ReturnCode = ""
                EndSwitch
            Else
                ; File does not contain ID3V1 data
                $ReturnCode = ""
            EndIf
        ElseIf $Tag >= $ID3V2TagStart And $Tag <= $ID3V2TagEnd Then ;ID3V2
            ; check if ID3V2 data exists (-1=yes)
            $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V2ExistsW")
            If $rc[0] = -1 Then
                ; File containes ID3V1 data
                ; Get the tag we want
                ;$rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V2GetVersionW")
                ;_ArrayDisplay($rc) ; just want to see what the version number is
                #cs Other Tags to Read (left in for reference)
                    Global Const $ID3V2_AENC = &H41454E43 ; Audio Encryption
                    Global Const $ID3V2_APIC = &H41504943 ; Attaced Picture
                    Global Const $ID3V2_ASPI = &H41535049 ;
                    Global Const $ID3V2_CHAP = &H43484150
                    Global Const $ID3V2_COMR = &H434F4D52
                    Global Const $ID3V2_CTOC = &H43544F43
                    Global Const $ID3V2_ENCR = &H454E4352
                    Global Const $ID3V2_EQU2 = &H45515532
                    Global Const $ID3V2_EQUA = &H45515541
                    Global Const $ID3V2_ETCO = &H4554434F
                    Global Const $ID3V2_GEOB = &H47454F42
                    Global Const $ID3V2_GRID = &H47524944
                    Global Const $ID3V2_IPLS = &H49504C53
                    Global Const $ID3V2_LINK = &H4C494E4B
                    Global Const $ID3V2_MCDI = &H4D434449
                    Global Const $ID3V2_MLLT = &H4D4C4C54
                    Global Const $ID3V2_OWNE = &H4F574E45
                    Global Const $ID3V2_PCNT = &H50434E54
                    Global Const $ID3V2_POPM = &H504F504D
                    Global Const $ID3V2_POSS = &H504F5353
                    Global Const $ID3V2_PRIV = &H50524956
                    Global Const $ID3V2_RBUF = &H52425546
                    Global Const $ID3V2_RVA2 = &H52564132
                    Global Const $ID3V2_RVAD = &H52564144
                    Global Const $ID3V2_RVRB = &H52565242
                    Global Const $ID3V2_SEEK = &H5345454B
                    Global Const $ID3V2_SIGN = &H5349474E
                    Global Const $ID3V2_SYLT = &H53594C54
                    Global Const $ID3V2_SYTC = &H53595443
                    Global Const $ID3V2_TCMP = &H54434D50 ; ITUNES
                    Global Const $ID3V2_TCOM = &H54434F4D
                    Global Const $ID3V2_TCOP = &H54434F50
                    Global Const $ID3V2_TDAT = &H54444154
                    Global Const $ID3V2_TDEN = &H5444454E
                    Global Const $ID3V2_TDLY = &H54444C59
                    Global Const $ID3V2_TDOR = &H54444F52
                    Global Const $ID3V2_TDRC = &H54445243
                    Global Const $ID3V2_TDRL = &H5444524C
                    Global Const $ID3V2_TDTG = &H54445447
                    Global Const $ID3V2_TENC = &H54454E43
                    Global Const $ID3V2_TEXT = &H54455854
                    Global Const $ID3V2_TFLT = &H54464C54
                    Global Const $ID3V2_TIME = &H54494D45
                    Global Const $ID3V2_TIPL = &H5449504C
                    Global Const $ID3V2_TIT1 = &H54495431
                    Global Const $ID3V2_TIT3 = &H54495433
                    Global Const $ID3V2_TKEY = &H544B4559
                    Global Const $ID3V2_TLAN = &H544C414E
                    Global Const $ID3V2_TLEN = &H544C454E ; Length
                    Global Const $ID3V2_TMCL = &H544D434C
                    Global Const $ID3V2_TMED = &H544D4544
                    Global Const $ID3V2_TMOO = &H544D4F4F
                    Global Const $ID3V2_TOAL = &H544F414C
                    Global Const $ID3V2_TOFN = &H544F464E
                    Global Const $ID3V2_TOLY = &H544F4C59
                    Global Const $ID3V2_TOPE = &H544F5045
                    Global Const $ID3V2_TORY = &H544F5259
                    Global Const $ID3V2_TOWN = &H544F574E
                    Global Const $ID3V2_TPE2 = &H54504532
                    Global Const $ID3V2_TPE3 = &H54504533
                    Global Const $ID3V2_TPE4 = &H54504534
                    Global Const $ID3V2_TPOS = &H54504F53
                    Global Const $ID3V2_TPRO = &H5450524F
                    Global Const $ID3V2_TPUB = &H54505542
                    Global Const $ID3V2_TRDA = &H54524441
                    Global Const $ID3V2_TRSN = &H5452534E
                    Global Const $ID3V2_TRSO = &H5452534F
                    Global Const $ID3V2_TSIZ = &H5453495A
                    Global Const $ID3V2_TSO2 = &H54534F32 ; itunes
                    Global Const $ID3V2_TSOA = &H54534F41 ; itunes
                    Global Const $ID3V2_TSOC = &H54534F43 ; itunes
                    Global Const $ID3V2_TSOP = &H54534F50 ; itunes
                    Global Const $ID3V2_TSOT = &H54534F54 ; itunes
                    Global Const $ID3V2_TSRC = &H54535243
                    Global Const $ID3V2_TSSE = &H54535345
                    Global Const $ID3V2_TSST = &H54535354
                    Global Const $ID3V2_TXXX = &H54585858
                    Global Const $ID3V2_UFID = &H55464944
                    Global Const $ID3V2_USER = &H55534552
                    Global Const $ID3V2_USLT = &H55534C54
                    Global Const $ID3V2_WCOM = &H57434F4D
                    Global Const $ID3V2_WCOP = &H57434F50
                    Global Const $ID3V2_WOAF = &H574F4146
                    Global Const $ID3V2_WOAR = &H574F4152
                    Global Const $ID3V2_WOAS = &H574F4153
                    Global Const $ID3V2_WORS = &H574F5253
                    Global Const $ID3V2_WPAY = &H57504159
                    Global Const $ID3V2_WPUB = &H57505542
                    Global Const $ID3V2_WXXX = &H57585858
                #ce
                Switch $Tag
                    Case $ID3V2_Album
                        $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V2GetTextFrameW", "uint", String(Dec(_StringToHex("TALB"))))
                        $ReturnCode = $rc[0]
                    Case $ID3V2_Artist
                        $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V2GetTextFrameW", "uint", String(Dec(_StringToHex("TPE1"))))
                        $ReturnCode = $rc[0]
                    Case $ID3V2_Comment
                        ;Can be multiple comment frames.
                        ;Get the number of comment frames.
                        $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V2GetFrameCountW", "uint", String(Dec(_StringToHex("COMM"))))
                        ;_ArrayDisplay($rc)
                        $framecount = $rc[0]
                        Dim $AllComments[$framecount][3]
                        For $counter = 1 To $framecount
                            $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V2GetCommentLanguageW", "uint", String($counter))
                            $language = $rc[0]
                            $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V2GetCommentDescriptionW", "uint", String($counter))
                            $description = $rc[0]
                            $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V2GetCommentW", "uint", String($counter))
                            $comment = $rc[0]
                            $AllComments[$counter - 1][0] = $language
                            $AllComments[$counter - 1][1] = $description
                            $AllComments[$counter - 1][2] = $comment
                        Next
                        $ReturnCode = $AllComments

                        ;Case $ID3V1_Genre - how to implement
                        ;Global Const $ID3V2_TCON = &H54434F4E ; Genre
                    Case $ID3V2_Title
                        $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V2GetTextFrameW", "uint", String(Dec(_StringToHex("TIT2"))))
                        $ReturnCode = $rc[0]
                    Case $ID3V2_Track
                        $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V2GetTextFrameW", "uint", String(Dec(_StringToHex("TRCK"))))
                        $ReturnCode = $rc[0]
                    Case $ID3V2_Year
                        $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V2GetTextFrameW", "uint", String(Dec(_StringToHex("TYER"))))
                        $ReturnCode = $rc[0]
                    Case $ID3V2_BPM
                        $rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V2GetTextFrameW", "uint", String(Dec(_StringToHex("TBPM"))))
                        $ReturnCode = $rc[0]
                    Case Else
                        $ReturnCode = ""
                EndSwitch
            Else
                $ReturnCode = ""
            EndIf
        EndIf
    Else
        ; File is not an MP3
        $ReturnCode = ""
    EndIf

    Return $ReturnCode
EndFunc   ;==>_AudioGenie3_ReadID3Tag


; #FUNCTION# ====================================================================================================================
; Name...........:  _AudioGenie3_WriteID3Tag
; Description ...:  Will write the specified tag to the MP3.
; Syntax.........:  _AudioGenie3_WriteID3Tag [FileName] [Tag Constant] [Data to write]
; Parameters ....:  $File - the file to read from
;                   $Tag - the tag constant to read, use the constants specified (ID3V1_*/ID3V2_*)
;                   $Data - the data to write. (For ID3V2_Comment an array must be specified *see comments*)
; Return values .:  The result of the ID3V2SaveChangesW DLL call.
; ===============================================================================================================================
Func _AudioGenie3_WriteID3Tag($File, $Tag, $Data)
    Local $ReturnCode = ""
    Local $rc = 0

    $rc = DllCall($_AudioGenie3DLLHandle, "int", "AUDIOAnalyzeFileW", "wstr", $File) ; open the file and ensure its a mp3 (returns 1)
    If $rc[0] = 1 Then
        If $Tag >= $ID3V1TagStart And $Tag <= $ID3V1TagEnd Then ;ID3V1
            Switch $Tag
                Case $ID3V1_Album
                    DllCall($_AudioGenie3DLLHandle, "none", "ID3V1SetAlbumW", "wstr", $Data)
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V1SaveChangesW")
                    $ReturnCode = $rc[0]
                Case $ID3V1_Artist
                    DllCall($_AudioGenie3DLLHandle, "none", "ID3V1SetArtistW", "wstr", $Data)
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V1SaveChangesW")
                    $ReturnCode = $rc[0]
                Case $ID3V1_Comment
                    DllCall($_AudioGenie3DLLHandle, "none", "ID3V1SetCommentW", "wstr", $Data)
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V1SaveChangesW")
                    $ReturnCode = $rc[0]
                    ;Case $ID3V1_Genre - how to implement
                Case $ID3V1_Title
                    DllCall($_AudioGenie3DLLHandle, "none", "ID3V1SetTitleW", "wstr", $Data)
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V1SaveChangesW")
                    $ReturnCode = $rc[0]
                Case $ID3V1_Track
                    DllCall($_AudioGenie3DLLHandle, "none", "ID3V1SetTrackW", "wstr", $Data)
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V1SaveChangesW")
                    $ReturnCode = $rc[0]
                Case $ID3V1_Year
                    DllCall($_AudioGenie3DLLHandle, "none", "ID3V1SetYearW", "wstr", $Data)
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V1SaveChangesW")
                    $ReturnCode = $rc[0]
                Case Else
                    $ReturnCode = ""
            EndSwitch
        ElseIf $Tag >= $ID3V2TagStart And $Tag <= $ID3V2TagEnd Then ;ID3V2
            ;$rc = DllCall($_AudioGenie3DLLHandle, "wstr", "ID3V2GetVersionW")
            ;_ArrayDisplay($rc) ; just want to see what the version number is
            Switch $Tag
                Case $ID3V2_Album
                    DllCall($_AudioGenie3DLLHandle, "none", "ID3V2SetTextFrameW", "uint", String(Dec(_StringToHex("TALB"))), "wstr", $Data)
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V2SaveChangesW")
                    $ReturnCode = $rc[0]
                Case $ID3V2_Artist
                    DllCall($_AudioGenie3DLLHandle, "none", "ID3V2SetTextFrameW", "uint", String(Dec(_StringToHex("TPE1"))), "wstr", $Data)
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V2SaveChangesW")
                    $ReturnCode = $rc[0]
                Case $ID3V2_Comment
                    For $counter = 0 To UBound($Data) - 1
                        $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V2AddCommentW", "wstr", $Data[$counter][0], "wstr", $Data[$counter][1], "wstr", $Data[$counter][2])
                        ;MsgBox(0,"",$rc[0])
                        $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V2SaveChangesW")
                    Next
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V2SaveChangesW")
                    $ReturnCode = $rc[0]
                    ;Case $ID3V1_Genre - how to implement
                    ;Global Const $ID3V2_TCON = &H54434F4E ; Genre
                Case $ID3V2_Title
                    DllCall($_AudioGenie3DLLHandle, "none", "ID3V2SetTextFrameW", "uint", String(Dec(_StringToHex("TIT2"))), "wstr", $Data)
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V2SaveChangesW")
                    $ReturnCode = $rc[0]
                Case $ID3V2_Track
                    DllCall($_AudioGenie3DLLHandle, "none", "ID3V2SetTextFrameW", "uint", String(Dec(_StringToHex("TRCK"))), "wstr", $Data)
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V2SaveChangesW")
                    $ReturnCode = $rc[0]
                Case $ID3V2_Year
                    DllCall($_AudioGenie3DLLHandle, "none", "ID3V2SetTextFrameW", "uint", String(Dec(_StringToHex("TYER"))), "wstr", $Data)
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V2SaveChangesW")
                    $ReturnCode = $rc[0]
                Case $ID3V2_BPM
                    DllCall($_AudioGenie3DLLHandle, "none", "ID3V2SetTextFrameW", "uint", String(Dec(_StringToHex("TBPM"))), "wstr", $Data)
                    $rc = DllCall($_AudioGenie3DLLHandle, "int", "ID3V2SaveChangesW")
                    $ReturnCode = $rc[0]
                Case Else
                    $ReturnCode = ""
            EndSwitch
        EndIf
    Else
        ; File is not an MP3
        $ReturnCode = ""
    EndIf

    Return $ReturnCode
EndFunc   ;==>_AudioGenie3_WriteID3Tag

; #FUNCTION# ====================================================================================================================
; Name...........:  _AudioGenie3_Start
; Description ...:  Will load the AudioGenie3.dll
; Syntax.........:  _AudioGenie3_Start
; Parameters ....:
; Return values .:  -1 = failure
;                   0  = success
; ===============================================================================================================================
Func _AudioGenie3_Start()
    Local $ReturnCode = -1

    $_AudioGenie3DLLHandle = DllOpen($_AudioGenie3DLL)
    If $_AudioGenie3DLLHandle = -1 Then
        $ReturnCode = -1
    Else
        ; Check the version of the AudioGenie3.dll file to ensure it is compatible with our code
        $Version = DllCall($_AudioGenie3DLLHandle, "wstr", "GetAudioGenieVersionW")
        If $Version[0] <> $_AudioGenie3DLLCompatibleVersion Then
            $ReturnCode = -1 ; not compatible
            _AudioGenie3_Stop() ; close the dll
        Else
            $ReturnCode = 0
            ; Lets initialize the dll with a dummy call.
            DllCall($_AudioGenie3DLLHandle, "int", "AUDIOAnalyzeFileW", "wstr", "")
            DllCall($_AudioGenie3DLLHandle, "none", "SetLogFileW", "wstr", @ScriptDir & "\AudioGenie3.Log")
        EndIf
    EndIf

    Return $ReturnCode
EndFunc   ;==>_AudioGenie3_Start

; #FUNCTION# ====================================================================================================================
; Name...........:  _AudioGenie3_Stop
; Description ...:  Will unload the AudioGenie3.dll.
; Syntax.........:  _AudioGenie3_Stop
; Parameters ....:
; Return values .:
; ===============================================================================================================================
Func _AudioGenie3_Stop()
    DllClose($_AudioGenie3DLLHandle)
EndFunc   ;==>_AudioGenie3_Stop