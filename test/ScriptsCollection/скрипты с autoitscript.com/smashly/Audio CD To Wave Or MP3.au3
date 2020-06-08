#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <WinAPI.au3>
#include <GuiListView.au3>
#include <SliderConstants.au3>

Opt("MustDeclareVars", 1)

Global Const $tag_BE_CONFIG = _ ;   {
        "DWORD  dwConfig;" & _ ;            // BE_CONFIG_LAME
        "DWORD  dwStructVersion;" & _ ;    // LAME header version 1
        "DWORD  dwStructSize;" & _ ;       // Size of this structure (332 in autoit, should be 331)
        "DWORD  dwSampleRate;" & _ ;        // SAMPLERATE OF INPUT FILE
        "DWORD  dwReSampleRate;" & _ ;  // DOWNSAMPLERATE, 0=ENCODER DECIDES
        "LONG   nMode;" & _ ;               // BE_MP3_MODE_STEREO, BE_MP3_MODE_DUALCHANNEL, BE_MP3_MODE_MONO
        "DWORD  dwBitrate;" & _ ;           // CBR bitrate, VBR min bitrate
        "DWORD  dwMaxBitrate;" & _ ;        // CBR ignored, VBR Max bitrate
        "LONG   nPreset;" & _ ;         // Quality preset, use one of the settings of the LAME_QUALITY_PRESET enum
        "DWORD  dwMpegVersion;" & _ ;       // FUTURE USE, MPEG-1 OR MPEG-2
        "DWORD  dwPsyModel;" & _ ;          // FUTURE USE, SET TO 0
        "DWORD  dwEmphasis;" & _ ;          // FUTURE USE, SET TO 0
        "BOOL   bPrivate;" & _ ;            // Set Private Bit (TRUE/FALSE)
        "BOOL   bCRC;" & _ ;                // Insert CRC (TRUE/FALSE)
        "BOOL   bCopyright;" & _ ;          // Set Copyright Bit (TRUE/FALSE)
        "BOOL   bOriginal;" & _ ;           // Set Original Bit (TRUE/FALSE)
        "BOOL   bWriteVBRHeader;" & _ ; // WRITE XING VBR HEADER (TRUE/FALSE)
        "BOOL   bEnableVBR;" & _ ;          // USE VBR ENCODING (TRUE/FALSE)
        "INT    nVBRQuality;" & _ ;     // VBR QUALITY 0..9
        "DWORD  dwVbrAbr_bps;" & _ ;        // Use ABR in stead of nVBRQuality
        "UINT   nVbrMethod;" & _ ;
        "BOOL   bNoRes; " & _ ;         // Disable Bit resorvoir (TRUE/FALSE)
        "BOOL   bStrictIso;" & _ ;          // Use strict ISO encoding rules (TRUE/FALSE)
        "WORD   nQuality;" & _ ;            // Quality Setting, HIGH BYTE should be NOT LOW byte, otherwhise quality=5
        "BYTE   btReserved[" & 255 - 4 * 4 - 2 & "]"

Global Const $tag_WAV_HEADER = _
        "BYTE RIFF[4];" & _
        "BYTE HdrDataLen[4];" & _
        "BYTE WAVEfmt[8];" & _
        "BYTE FmtChkLen[4];" & _
        "BYTE FmtType[2];" & _
        "BYTE ChanCount[2];" & _
        "BYTE SampRate[4];" & _
        "BYTE BytesPerSec[4];" & _
        "BYTE BytesPerSamp[2];" & _
        "BYTE BitsPerChan[2];" & _
        "BYTE data[4];" & _
        "BYTE DataLen[4]"

Global $h_LameEncDLL = -1
Global $sLameEncDll = "lame_enc.dll"

Global $sDrivesTmp, $aCDInfo
Global $hGui, $iCombo, $iInput, $iBrowse, $iLV, $iInv, $iAll, $iLBR, $iBitrate, $iWAV, $iMP3, $iRip
Global $iProgTrack, $iProgTrackLabel, $iProgTotal, $iProgTotalLabel, $iFlag = 0, $iFormat = 1
Global $aExt[2] = [".mp3", ".wav"]
Global $sOutPath = @ScriptDir & "\CDToWavOrMP3"
Global $aBR = StringSplit("32|40|48|56|64|80|96|112|128|160|192|224|256|320", "|", 2)
Global $iBR = 8

$hGui = GUICreate("Audio CD To Wav Or MP3", 355, 525)
GUICtrlCreateGroup("Select Drive:", 5, 5, 345, 55)
$iCombo = GUICtrlCreateCombo("", 15, 25, 325, 20, $CBS_DROPDOWNLIST)
GUICtrlCreateGroup("Save To...", 5, 65, 345, 55)
$iInput = GUICtrlCreateInput($sOutPath, 15, 85, 300, 20, BitOR($ES_READONLY, $ES_AUTOHSCROLL))
GUICtrlSetBkColor(-1, 0xffffff)
$iBrowse = GUICtrlCreateButton("...", 320, 85, 20, 20)
GUICtrlSetTip(-1, "Browse for save directory.")
GUICtrlCreateGroup("Track Selection:", 5, 125, 345, 280)
$iLV = GUICtrlCreateListView("Track|Size|Time|LBA", 15, 145, 325, 220, -1, $LVS_EX_CHECKBOXES)
$iInv = GUICtrlCreateButton("Invert Selected", 15, 375, 160, 20)
$iAll = GUICtrlCreateButton("Select All", 180, 375, 160, 20)

$iLBR = GUICtrlCreateGroup("Bitrate: " & $aBR[$iBR] & " Kbps", 5, 410, 200, 50)
$iBitrate = GUICtrlCreateSlider(15, 425, 180, 25, BitOR($TBS_BOTH, $TBS_NOTICKS))
GUICtrlSetLimit(-1, 13, 0)
GUICtrlSetData(-1, $iBR)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateGroup("Format", 210, 410, 140, 50)
$iMP3 = GUICtrlCreateRadio("MP3", 230, 430, 50, 20)
If Not FileExists($sLameEncDll) Then GUICtrlSetState(-1, $GUI_DISABLE)
$iWAV = GUICtrlCreateRadio("WAV", 290, 430, 50, 20)
GUICtrlSetState(-1, $GUI_CHECKED)
$iRip = GUICtrlCreateButton("Rip Tracks", 300, 468, 50, 50, $BS_MULTILINE)
$iProgTrack = GUICtrlCreateProgress(5, 470, 290, 20)
$iProgTrackLabel = GUICtrlCreateLabel("Track Progress", 5, 472, 290, 20, $SS_CENTER)
GUICtrlSetBkColor(-1, -2)
GUICtrlSetFont(-1, 9, 700, 0, "Arial")
$iProgTotal = GUICtrlCreateProgress(5, 495, 290, 20)
$iProgTotalLabel = GUICtrlCreateLabel("Total Progress", 5, 497, 290, 20, $SS_CENTER)
GUICtrlSetBkColor(-1, -2)
GUICtrlSetFont(-1, 9, 700, 0, "Arial")
_GetDrives()
GUISetState(@SW_SHOW, $hGui)

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
AdlibRegister("_GetDrives", 1000)

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $iCombo
            _LoadTracksToLV()
        Case $iBrowse
            _Browse()
        Case $iInv
            For $i = 0 To _GUICtrlListView_GetItemCount($iLV) - 1
                If _GUICtrlListView_GetItemChecked($iLV, $i) Then
                    _GUICtrlListView_SetItemChecked($iLV, $i, False)
                Else
                    _GUICtrlListView_SetItemChecked($iLV, $i)
                EndIf
            Next
            $iFlag = 1
        Case $iAll
            For $i = 0 To _GUICtrlListView_GetItemCount($iLV) - 1
                If Not _GUICtrlListView_GetItemChecked($iLV, $i) Then _GUICtrlListView_SetItemChecked($iLV, $i)
            Next
            $iFlag = 1
        Case $iMP3, $iWAV
            If BitAND(GUICtrlRead($iMP3), $GUI_UNCHECKED) Then
                $iFormat = 1
                GUICtrlSetState($iBitrate, $GUI_DISABLE)
            Else
                $iFormat = 0
                GUICtrlSetState($iBitrate, $GUI_ENABLE)
            EndIf
        Case $iRip
            _RipTracks()
        Case Else
            If $iFlag Then _EnableDisableRip()
            If $iBR <> GUICtrlRead($iBitrate) Then
                $iBR = GUICtrlRead($iBitrate)
                GUICtrlSetData($iLBR, "Bitrate: " & $aBR[$iBR] & " Kbps")
            EndIf
    EndSwitch
WEnd



Func _Browse()
    Local $sFSF
    $sFSF = FileSelectFolder("Select a folder to save wave files in.", "", 1, "", $hGui)
    If Not @error Then
        $sOutPath = $sFSF
        GUICtrlSetData($iInput, $sOutPath)
    EndIf
EndFunc   ;==>_Browse

Func _GetDrives()
    Local $sTmp, $aDrives, $sDrives, $aCD
    $sTmp = GUICtrlRead($iCombo)
    $aDrives = DriveGetDrive("CDROM")
    Dim $aCDInfo[$aDrives[0] + 1]
    For $i = 1 To $aDrives[0]
        $aCD = _GetAudioCDInfo($aDrives[$i])
        If IsArray($aCD) Then
            $aCDInfo[$i] = $aCD
            $sDrives &= StringUpper($aDrives[$i]) & StringFormat(' [Audio CD, %s Tracks, %.2f MB Used Disc Space]', $aCD[0][0], ($aCD[0][1] * 2352) / 1024 / 1024) & "|"
        Else
            $aCDInfo[$i] = 0
            $sDrives &= StringUpper($aDrives[$i]) & " [Audio CD Not Detected]" & "|"
        EndIf
    Next
    $sDrives = StringTrimRight($sDrives, 1)
    If $sDrivesTmp <> $sDrives Then
        GUICtrlSetData($iCombo, "")
        $sDrivesTmp = $sDrives
        If $sTmp <> "" And StringInStr($sDrivesTmp, $sTmp) Then
            GUICtrlSetData($iCombo, $sDrivesTmp, $sTmp)
        Else
            GUICtrlSetData($iCombo, $sDrivesTmp, StringLeft($sDrivesTmp, StringInStr($sDrivesTmp, "|") - 1))
        EndIf
        _LoadTracksToLV()
    EndIf
EndFunc   ;==>_GetDrives

Func _LoadTracksToLV()
    Local $sDrv, $aDrv, $aCD, $iTrkSector, $iTrkMS, $sFmt = "Track%02d|%d KB|%02d:%02d|%d"
    $sDrv = StringLeft(GUICtrlRead($iCombo), 2)
    $aDrv = StringSplit($sDrivesTmp, "|")
    For $i = 1 To $aDrv[0]
        If $sDrv = StringLeft($aDrv[$i], 2) Then $aCD = $aCDInfo[$i]
    Next
    _GUICtrlListView_DeleteAllItems($iLV)
    If Not IsArray($aCD) Then
        GUICtrlSetState($iInv, $GUI_DISABLE)
        GUICtrlSetState($iAll, $GUI_DISABLE)
        $iFlag = 1
        Return 0
    EndIf
    For $i = 1 To $aCD[0][0]
        $iTrkSector = $aCD[$i][1] - $aCD[$i][0]
        $iTrkMS = ($iTrkSector / 75) * 1000
        GUICtrlCreateListViewItem(StringFormat($sFmt, $i, Ceiling(($iTrkSector * 2352) / 1024), Mod($iTrkMS / 1000, 6000) / 60, Mod(Mod($iTrkMS / 1000, 3600), 60), $aCD[$i][0]), $iLV)
        GUICtrlSetState(-1, $GUI_CHECKED)
    Next
    For $i = 0 To 3
        _GUICtrlListView_SetColumnWidth($iLV, $i, $LVSCW_AUTOSIZE)
    Next
    GUICtrlSetState($iInv, $GUI_ENABLE)
    GUICtrlSetState($iAll, $GUI_ENABLE)
    $iFlag = 1
EndFunc   ;==>_LoadTracksToLV

Func _GetAudioCDInfo($sDrive)
    Local Const $IOCTL_CDROM_READ_TOC = 0x00024000
    Local Const $IOCTL_CDROM_DISK_TYPE = 0x00020040
    Local $hCD, $tDiscType, $iReturn, $tCDTOC, $iTrkLast, $bData, $iRead
    $hCD = _WinAPI_CreateFile("\\.\" & $sDrive, 2, 6, 6)
    If Not $hCD Then Return SetError(-1, 0, 0)
    $tDiscType = DllStructCreate("ULONG DiskData")
    $iReturn = _WinAPI_DeviceIoControl($hCD, $IOCTL_CDROM_DISK_TYPE, 0, 0, DllStructGetPtr($tDiscType), DllStructGetSize($tDiscType), $iRead)
    If Not $iReturn Or (DllStructGetData($tDiscType, "DiskData") <> 1) Then
        _WinAPI_CloseHandle($hCD)
        Return SetError(1, 0, 0)
    EndIf
    $tCDTOC = DllStructCreate("BYTE Length[2];BYTE FirstTrack;BYTE LastTrack;BYTE TrackData[800]")
    DllStructSetData($tCDTOC, "Length", DllStructGetSize($tCDTOC))
    If Not _WinAPI_DeviceIoControl($hCD, $IOCTL_CDROM_READ_TOC, 0, 0, DllStructGetPtr($tCDTOC), DllStructGetSize($tCDTOC), $iRead) Then
        _WinAPI_CloseHandle($hCD)
        Return SetError(2, 0, 0)
    EndIf
    $iTrkLast = DllStructGetData($tCDTOC, "LastTrack")
    If Not $iTrkLast Then Return SetError(2, 0, 0)
    $bData = DllStructGetData($tCDTOC, "TrackData")
    Dim $aTrk[$iTrkLast + 1][3]
    $aTrk[0][0] = $iTrkLast
    $aTrk[0][1] = BinaryMid($bData, 8 * $iTrkLast + 6, 3)
    $aTrk[0][1] = Int(BinaryMid($aTrk[0][1], 1, 1)) * 75 * 60 + Int(BinaryMid($aTrk[0][1], 2, 1)) * 75 + Int(BinaryMid($aTrk[0][1], 3, 1)) - 150
    If $aTrk[0][1] <= 300 Then ; Minimum Sectors to Audio CD 300 Sectors = 4 Seconds (the first track starts after 2 secs = 150 sectors)
        _WinAPI_CloseHandle($hCD)
        $tCDTOC = 0
        Return SetError(3, 0, 0)
    EndIf
    Dim $aMSF[4] = [$bData, 6, 7, 8]
    For $i = 1 To $aTrk[0][0]
        $aTrk[$i][0] = (Int(BinaryMid($aMSF[0], $aMSF[1], 1)) * 75 * 60) + (Int(BinaryMid($aMSF[0], $aMSF[2], 1)) * 75) + Int(BinaryMid($aMSF[0], $aMSF[3], 1)) - 150
        For $j = 1 To 3
            $aMSF[$j] += 8
        Next
        $aTrk[$i][1] = (Int(BinaryMid($aMSF[0], $aMSF[1], 1)) * 75 * 60) + (Int(BinaryMid($aMSF[0], $aMSF[2], 1)) * 75) + Int(BinaryMid($aMSF[0], $aMSF[3], 1)) - 150
        $aTrk[$i][2] = 1
    Next
    _WinAPI_CloseHandle($hCD)
    Return SetError(0, 0, $aTrk)
EndFunc   ;==>_GetAudioCDInfo

Func _RipTracks()
    Local $sDrv, $aDrv, $aCD, $iOverwrite, $hCD, $tINF, $tWavHdr, $tWavBuf, $tMP3Buf, $tCfg
    Local $sCurTrack, $hWriteOut, $hStream, $iReturn, $iSamples, $iMP3Buffer, $iOutput, $iWritten
    Local $iTS = 0, $iTSS = 0, $iTSD = 0, $aTCL[2], $iTP = 0, $iTPD = 0, $aPCL[2], $iStep = 288

    AdlibUnRegister("_GetDrives")
    _EnableDisableAll($GUI_DISABLE)
    GUICtrlSetData($iRip, "Abort")
    $sDrv = StringLeft(GUICtrlRead($iCombo), 2)
    $aDrv = StringSplit($sDrivesTmp, "|")
    For $i = 1 To $aDrv[0]
        If $sDrv = StringLeft($aDrv[$i], 2) Then $aCD = $aCDInfo[$i]
    Next
    For $i = 1 To _GUICtrlListView_GetItemCount($iLV)
        If _GUICtrlListView_GetItemChecked($iLV, $i - 1) Then
            $iTP += ($aCD[$i][1] - $aCD[$i][0])
            If FileExists($sOutPath & StringFormat("\Track%02d" & $aExt[$iFormat], $i)) Then $iOverwrite = 1
        EndIf
    Next
    If $iOverwrite Then
        Switch MsgBox(35, 'Overwite Warning', 'You are about to overwrite already existing tracks.' & @LF & _
                'Would you like to rip these tracks to a different directory?' & @LF & @LF & _
                'Click "Yes" to browse for a different save directory.' & @LF & _
                'Click "No" to overwrite existing tracks.' & @LF & _
                'Click "Cancel" to Abort ripping tracks.')
            Case 2
                Return _StopRip($hCD, $tINF, $tWavHdr, $tWavBuf, $tMP3Buf, $tCfg, $hWriteOut, $hStream, "", 15)
            Case 6
                _Browse()
        EndSwitch
    EndIf
    If Not FileExists($sOutPath) Then DirCreate($sOutPath)
    ; Open CD drive
    $hCD = _WinAPI_CreateFile("\\.\" & $sDrv, 2, 6, 6)
    If Not $hCD Then Return _StopRip($hCD, $tINF, $tWavHdr, $tWavBuf, $tMP3Buf, $tCfg, $hWriteOut, $hStream, "", -1)

    ; Structure that we use to specify track offset and sectors we want ripped.
    $tINF = DllStructCreate("int64 DiskOffset;ULONG SectorCount;ULONG TrackMode")

    ; Set $tInfo struct to CDDA mode
    DllStructSetData($tINF, "TrackMode", 2)

    ; Create In, Out buffers, wav header, encoder settings as needed.
    If $iFormat Then ; Set up for wave rip.

        ; Set the wav buffer the CD will dump it's data into.
        $tWavBuf = DllStructCreate("BYTE[" & (2352 * $iStep) & "]")

        ; Create a wave header stuct to write to wav file (header is 44 bytes in length)
        $tWavHdr = DllStructCreate($tag_WAV_HEADER)
        DllStructSetData($tWavHdr, "RIFF", "RIFF")
        DllStructSetData($tWavHdr, "WAVEfmt", "WAVEfmt ")
        DllStructSetData($tWavHdr, "FmtChkLen", 16)
        DllStructSetData($tWavHdr, "FmtType", 1)
        DllStructSetData($tWavHdr, "ChanCount", 2)
        DllStructSetData($tWavHdr, "SampRate", 44100)
        DllStructSetData($tWavHdr, "BytesPerSec", 176400)
        DllStructSetData($tWavHdr, "BytesPerSamp", 4)
        DllStructSetData($tWavHdr, "BitsPerChan", 16)
        DllStructSetData($tWavHdr, "data", "data")
    Else ; Set up for mp3 rip.

        ; Create lame settings struct and fill it with some basic settings.
        $tCfg = DllStructCreate($tag_BE_CONFIG)
        DllStructSetData($tCfg, "dwConfig", 256) ;// BE_CONFIG_LAME
        DllStructSetData($tCfg, "dwStructVersion", 1) ;// Struct version (LVH1)
        DllStructSetData($tCfg, "dwStructSize", DllStructGetSize($tCfg)); // Struct Size
        DllStructSetData($tCfg, "dwSampleRate", 44100);         // INPUT FREQUENCY
        DllStructSetData($tCfg, "nMode", 1) ;BE_MP3_MODE_JSTEREO;   // OUTPUT IN JOINT STEREO
        DllStructSetData($tCfg, "dwBitrate", $aBR[$iBR]);                   // MINIMUM BIT RATE
        DllStructSetData($tCfg, "nPreset", 12) ;LQP_CBR;        // QUALITY PRESET SETTING
        DllStructSetData($tCfg, "dwMpegVersion", 1);MPEG1;    // MPEG VERSION (I or II)
        DllStructSetData($tCfg, "bOriginal", 1);                    // SET ORIGINAL FLAG
        DllStructSetData($tCfg, "bWriteVBRHeader", 1) ;       // Write mp3 header, even on ABR or CBR mp3.

        ; Lame encoder expects signed 16bit 2 bytes so use a SHORT data type
        $tWavBuf = DllStructCreate("SHORT[" & (2352 * $iStep) / 2 & "]")

        ; Create MP3 buffer to receive the encoded mp3 data
        $tMP3Buf = DllStructCreate("BYTE[" & 1.25 * (2352 * $iStep / 2 / 2) + 7200 & "]")
    EndIf


    ; Loop through the list view, if the track is selected then process it.
    For $i = 1 To _GUICtrlListView_GetItemCount($iLV)
        If _GUICtrlListView_GetItemChecked($iLV, $i - 1) Then

            ; Current file name for output track
            $sCurTrack = $sOutPath & StringFormat("\Track%02d" & $aExt[$iFormat], $i)

            ; Create a wav or mp3 file to write the buffer to.
            $hWriteOut = _WinAPI_CreateFile($sCurTrack, 1, 4)
            If Not $hWriteOut Then Return _StopRip($hCD, $tINF, $tWavHdr, $tWavBuf, $tMP3Buf, $tCfg, $hWriteOut, $hStream, "", -2)

            ; Calculate how many sectors the track has.
            $iTS = $aCD[$i][1] - $aCD[$i][0]

            ; Make sure the track total sectors are evenly divded by $iStep, we'll catch any sector < $iStep later on.
            $iTSS = Floor($iTS / $iStep) * $iStep

            ; Tell $tINF struct how many sectors we want it to rip from the CD
            DllStructSetData($tINF, "SectorCount", $iStep)


            If $iFormat Then ; Set up for wave header.

                ;Set data in the wav header stuct.
                DllStructSetData($tWavHdr, "HdrDataLen", 36 + ($iTS * 2352))
                DllStructSetData($tWavHdr, "DataLen", $iTS * 2352)

                ; Write the header struct to the wav file
                _WinAPI_WriteFile($hWriteOut, DllStructGetPtr($tWavHdr), 44, $iWritten)

                If Not (44 = $iWritten) Then Return _StopRip($hCD, $tINF, $tWavHdr, $tWavBuf, $tMP3Buf, $tCfg, $hWriteOut, $hStream, $sCurTrack, 8)

            Else ;Set up for mp3 rip

                ; Open lame_enc.dll
                If Not _Open_LameEnc($sLameEncDll) Then Return _StopRip($hCD, $tINF, $tWavHdr, $tWavBuf, $tMP3Buf, $tCfg, $hWriteOut, $hStream, "", 1)

                ; Init the MP3 Stream
                If Not _beInitStream(DllStructGetPtr($tCfg), $iSamples, $iMP3Buffer, $hStream) Then Return _StopRip($hCD, $tINF, $tWavHdr, $tWavBuf, $tMP3Buf, $tCfg, $hWriteOut, $hStream, "", 2)
            EndIf


            ; Rip the track sectors.
            $iReturn = _RipSectors($hCD, $hWriteOut, $i, $aCD[$i][0], $aCD[$i][0] + $iTSS, $hStream, $tWavBuf, $tMP3Buf, $tINF, $iTSD, $iTS, $aTCL, $iTPD, $iTP, $aPCL)
            If $iReturn Then Return _StopRip($hCD, $tINF, $tWavHdr, $tWavBuf, $tMP3Buf, $tCfg, $hWriteOut, $hStream, $sCurTrack, $iReturn)

            ; Catch the sectors that are < $iStep and rip them.
            If $iTS > $iTSS Then

                ; Set $tINF amount of sectors to rip to the amount sectors left over.
                DllStructSetData($tINF, "SectorCount", $iTS - $iTSS)

                ; Rip the last sectors.
                $iReturn = _RipSectors($hCD, $hWriteOut, $i, $aCD[$i][0] + $iTSS, $aCD[$i][1], $hStream, $tWavBuf, $tMP3Buf, $tINF, $iTSD, $iTS, $aTCL, $iTPD, $iTP, $aPCL)
                If $iReturn Then Return _StopRip($hCD, $tINF, $tWavHdr, $tWavBuf, $tMP3Buf, $tCfg, $hWriteOut, $hStream, $sCurTrack, $iReturn)
            EndIf

            If $iFormat Then ; close wave file
                _WinAPI_CloseHandle($hWriteOut)

            Else ; finalize mp3

                ; Flush the encoder of any data that may be left.
                If Not _beDeinitStream($hStream, DllStructGetPtr($tMP3Buf), $iOutput) Then Return _StopRip($hCD, $tINF, $tWavHdr, $tWavBuf, $tMP3Buf, $tCfg, $hWriteOut, $hStream, $sCurTrack, 6)

                ; Write any data that was flushed from the encoder to the mp3 file.
                _WinAPI_WriteFile($hWriteOut, DllStructGetPtr($tMP3Buf), $iOutput, $iWritten)
                If Not ($iOutput = $iWritten) Then Return _StopRip($hCD, $tINF, $tWavHdr, $tWavBuf, $tMP3Buf, $tCfg, $hWriteOut, $hStream, $sCurTrack, 7)

                ; Close the stream.
                _beCloseStream($hStream)

                ; Close the mp3 file
                _WinAPI_CloseHandle($hWriteOut)

                ; Write a header to the mp3 file, can do this even for a CBR mp3
                _beWriteVBRHeader($sCurTrack)

                ; Close the encoder dll.
                _Close_LameEnc()
                $hStream = 0
            EndIf

            ; Reset the Total sectors Done for the track.
            $iTSD = 0
        EndIf
    Next
    Return _StopRip($hCD, $tINF, $tWavHdr, $tWavBuf, $tMP3Buf, $tCfg, $hWriteOut, $hStream, "", $iReturn)
EndFunc   ;==>_RipTracks

Func _RipSectors($hCD, $hWriteOut, $iTrk, $iStart, $iEnd, $hStream, $tWavBuf, $tMP3Buf, ByRef $tINF, ByRef $iTSD, ByRef $iTS, ByRef $aTCL, ByRef $iTPD, ByRef $iTP, ByRef $aPCL)
    Local Const $IOCTL_CDROM_RAW_READ = 0x0002403E
    Local $iStep, $iReturn, $iRead, $iOutput, $iWritten

    ; Get the step of how many sectors per loop we are ripping
    $iStep = DllStructGetData($tINF, "SectorCount")

    For $j = $iStart To $iEnd - 1 Step $iStep

        ;Set CD read offset in the $tINF struct to start reading sectors from.
        DllStructSetData($tINF, "DiskOffset", $j * 2048)

        ; Pass the $tINF struct and $tWavBuf struct to retieve the next buffer of data from the CD
        $iReturn = _WinAPI_DeviceIoControl($hCD, $IOCTL_CDROM_RAW_READ, DllStructGetPtr($tINF), DllStructGetSize($tINF), DllStructGetPtr($tWavBuf), DllStructGetSize($tWavBuf), $iRead)
        If Not $iReturn Or ($iRead <> (2352 * $iStep)) Then Return 3

        If $iFormat Then

            ; Write the bytes from the $tWavbuf to the wav file
            _WinAPI_WriteFile($hWriteOut, DllStructGetPtr($tWavBuf), $iRead, $iWritten)
            If Not ($iRead = $iWritten) Then Return 5

        Else
            ; Pass the Encoder the handle to the MP3 stream, how many samples to read from the $tWavBuf, $iOutput returns the amount of bytes that are in the $tMP3Buf.
            If Not _beEncodeChunk($hStream, $iRead / 2, DllStructGetPtr($tWavBuf), DllStructGetPtr($tMP3Buf), $iOutput) Then Return 4

            ; Write the bytes from the $tMP3buf to the mp3
            _WinAPI_WriteFile($hWriteOut, DllStructGetPtr($tMP3Buf), $iOutput, $iWritten)
            If Not ($iOutput = $iWritten) Then Return 5
        EndIf

        ; Update the Gui progress bars and labels.
        $iTSD += $iStep
        $aTCL[0] = Round(100 * $iTSD / $iTS)
        If $aTCL[0] <> $aTCL[1] Then
            $aTCL[1] = $aTCL[0]
            GUICtrlSetData($iProgTrack, $aTCL[1])
            GUICtrlSetData($iProgTrackLabel, StringFormat("Track%02d Progress %d%", $iTrk, $aTCL[1]))
        EndIf
        $iTPD += $iStep
        $aPCL[0] = Round(100 * $iTPD / $iTP)
        If $aPCL[0] <> $aPCL[1] Then
            $aPCL[1] = $aPCL[0]
            GUICtrlSetData($iProgTotal, $aPCL[1])
            GUICtrlSetData($iProgTotalLabel, "Total Progress " & $aPCL[1] & "%")
        EndIf

        ; Give the user a chance to bail out of encoding.
        If GUIGetMsg() = $iRip Then Return 15
    Next
    Return 0
EndFunc   ;==>_RipSectors

Func _StopRip($hCD, ByRef $t1, ByRef $t2, ByRef $t3, ByRef $t4, ByRef $t5, $hWriteOut = 0, $hStream = 0, $sTrack = "", $iError = 0)
    If $hCD Then _WinAPI_CloseHandle($hCD)
    $t1 = 0
    $t2 = 0
    $t3 = 0
    $t4 = 0
    $t5 = 0
    If $hWriteOut Then _WinAPI_CloseHandle($hWriteOut)
    If $h_LameEncDLL <> -1 Then
        If $hStream Then _beCloseStream($hStream)
        _Close_LameEnc()
    EndIf
    If $sTrack <> "" Then FileDelete($sTrack)
    Switch $iError
        Case 0
            If MsgBox(68, "Rip Completed", "Open the output directory?", 0, $hGui) = 6 Then ShellExecute($sOutPath)
        Case -1
            MsgBox(16, "Rip Failed", "Failed to open drive.", 0, $hGui)
        Case -2
            MsgBox(16, "Rip Failed", "Failed to open ouput file to write to.", 0, $hGui)
        Case 1
            MsgBox(16, "Rip Failed", "Unable to open lame_enc.dll", 0, $hGui)
        Case 2
            MsgBox(16, "Rip Failed", "Unable to create stream for MP3.", 0, $hGui)
        Case 3
            MsgBox(16, "Rip Failed", "Failed to copy sector from CD.", 0, $hGui)
        Case 4
            MsgBox(16, "Rip Failed", "Failed to encode CD buffer to MP3.", 0, $hGui)
        Case 5
            MsgBox(16, "Rip Failed", "Failed writing buffer to file.", 0, $hGui)
        Case 6
            MsgBox(16, "Rip Failed", "Failed to flush the encoder.", 0, $hGui)
        Case 7
            MsgBox(48, "Rip Aborted", "Failed to write flushed data to the mp3 file.", 0, $hGui)
        Case 8
            MsgBox(48, "Rip Aborted", "Failed to write wave header to file.", 0, $hGui)
        Case 15
            MsgBox(48, "Rip Aborted", "User Aborted Rip.", 0, $hGui)
    EndSwitch
    GUICtrlSetData($iRip, "Rip Tracks")
    GUICtrlSetData($iProgTrack, 0)
    GUICtrlSetData($iProgTrackLabel, "Track Progress")
    GUICtrlSetData($iProgTotal, 0)
    GUICtrlSetData($iProgTotalLabel, "Total Progress")
    _EnableDisableAll()
    AdlibRegister("_GetDrives", 1000)
EndFunc   ;==>_StopRip

Func _EnableDisableRip()
    Local $iTest = 0
    For $i = 0 To _GUICtrlListView_GetItemCount($iLV) - 1
        If _GUICtrlListView_GetItemChecked($iLV, $i) Then $iTest = 1
    Next
    If $iTest And BitAND(GUICtrlGetState($iRip), $GUI_DISABLE) Then
        GUICtrlSetState($iRip, $GUI_ENABLE)
    ElseIf Not $iTest And BitAND(GUICtrlGetState($iRip), $GUI_ENABLE) Then
        GUICtrlSetState($iRip, $GUI_DISABLE)
    EndIf
    $iFlag = 0
EndFunc   ;==>_EnableDisableRip

Func _EnableDisableAll($iState = $GUI_ENABLE)
    For $i = $iCombo To $iWAV
        If $i = $iBitrate And $iFormat And $iState = $GUI_ENABLE Then ContinueLoop
        If $i = $iMP3 And Not FileExists($sLameEncDll) And $iState = $GUI_ENABLE Then ContinueLoop
        GUICtrlSetState($i, $iState)
    Next
EndFunc   ;==>_EnableDisableAll

Func _WinAPI_DeviceIoControl($hFile, $iIoControlCode, $pInBuffer, $iInBufferSize, $pOutBuffer, $iOutBufferSize, ByRef $iRead, $pOverlapped = 0)
    Local $aReturn = DllCall('kernel32.dll', 'int', 'DeviceIoControl', 'ptr', $hFile, 'dword', $iIoControlCode, 'ptr', $pInBuffer, 'dword', $iInBufferSize, 'ptr', $pOutBuffer, 'dword', $iOutBufferSize, 'dword*', 0, 'ptr', $pOverlapped)
    If @error Then Return SetError(@error, @extended, 0)
    $iRead = $aReturn[7]
    Return SetError($aReturn[0] = 0, 0, $aReturn[0])
EndFunc   ;==>_WinAPI_DeviceIoControl

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    #forceref $hWnd, $iMsg, $iwParam
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hListView, $aHit
    $hListView = GUICtrlGetHandle($iLV)
    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $hListView
            Switch $iCode
                Case $NM_CLICK
                    $aHit = _GUICtrlListView_HitTest($hListView)
                    If $aHit[4] Then $iFlag = 1
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

; Some Lame Functions =================================================================================
Func _Open_LameEnc($sLameEncDll = "lame_enc.dll")
    $h_LameEncDLL = DllOpen($sLameEncDll)
    Return SetError($h_LameEncDLL = -1, 0, $h_LameEncDLL <> -1)
EndFunc   ;==>_Open_LameEnc

Func _beInitStream($pBeConfig, ByRef $iSamples, ByRef $iBufferSize, ByRef $hStream)
    Local $aReturn, $aResult[3]
    $aReturn = DllCall($h_LameEncDLL, "ulong:cdecl", "beInitStream", "ptr", $pBeConfig, "dword*", 0, "dword*", 0, "ptr*", 0)
    If @error Then Return SetError(-1, @error, @error = 0)
    $iSamples = $aReturn[2]
    $iBufferSize = $aReturn[3]
    $hStream = $aReturn[4]
    Return SetError($aReturn[0], 0, $aResult[0] = 0)
EndFunc   ;==>_beInitStream

Func _beEncodeChunk($hStream, $iSamples, $pWAVBuffer, $pMP3Buffer, ByRef $iOutput)
    Local $aReturn
    $aReturn = DllCall($h_LameEncDLL, "ulong:cdecl", "beEncodeChunk", "ptr", $hStream, "dword", $iSamples, "ptr", $pWAVBuffer, "ptr", $pMP3Buffer, "int*", 0)
    If @error Then Return SetError(-1, @error, @error = 0)
    $iOutput = $aReturn[5]
    Return SetError($aReturn[0], 0, $aReturn[0] = 0)
EndFunc   ;==>_beEncodeChunk

Func _beDeinitStream($hStream, $pMP3Buffer, ByRef $iOutput)
    Local $aReturn
    $aReturn = DllCall($h_LameEncDLL, "ulong:cdecl", "beDeinitStream", "ptr", $hStream, "ptr", $pMP3Buffer, "dword*", 0)
    If @error Then Return SetError(-1, 0, @error = 0)
    $iOutput = $aReturn[3]
    Return SetError($aReturn[0], $aReturn[3], $aReturn[0] = 0)
EndFunc   ;==>_beDeinitStream

Func _beCloseStream($hStream)
    Local $aReturn
    $aReturn = DllCall($h_LameEncDLL, "ulong:cdecl", "beCloseStream", "ptr", $hStream)
    If @error Then Return SetError(-1, 0, @error = 0)
    Return SetError($aReturn[0], 0, $aReturn[0] = 0)
EndFunc   ;==>_beCloseStream

Func _beWriteVBRHeader($sMp3File)
    Local $aReturn
    $aReturn = DllCall($h_LameEncDLL, "ulong:cdecl", "beWriteVBRHeader", "str", $sMp3File)
    If @error Then Return SetError(-1, 0, @error = 0)
    Return SetError($aReturn[0], 0, $aReturn[0] = 0)
EndFunc   ;==>_beWriteVBRHeader

Func _Close_LameEnc()
    DllClose($h_LameEncDLL)
    $h_LameEncDLL = -1
EndFunc   ;==>_Close_LameEnc

; =========================================================================================================