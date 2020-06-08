; ==============================================================================================
; Func _ZoneId_ADSStreamDelete($sFilename)
;
; Simple function to delete the Zone.Identifier stream that is added to downloaded files
;
; Alternatives:
; Use Group Policy Editor (gpedit.msc) and follow the instructions at
; "SaveZoneInformation Revisited", post #2 - link below
;
; Also, adding the following key & value to the registry works:
;  "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"
;   with the following DWORD value
;    "SaveZoneInformation"
;   set to 1
;
; References:
; "SaveZoneInformation Revisited"
; http://www.msfn.org/board/topic/123163-savezoneinformation-revisited/page__p__958516#entry958516
;  - Using Group Policy Editor
;
; “This file came from another computer…” ... Response by user61000
; http://superuser.com/a/227624
;  - Also other useful information, links and resources
;
; See also:
; "Alternate Data Streams" - Jerry Dixon's Blog
; https://blogs.msdn.com/b/jerrydixon/archive/2007/09/20/alternate-data-streams.aspx
;  - Simple command-line way to add and read specific streams
;    (i.e. "echo nonsense > file:ADSStuff", or  "more < file:Zone.Identifier")
;
; "StrmExt.dll on x64 Windows"
; http://www.boredomsoft.org/strmext.dll-on-x64-windows.bs
;  - Stream Page extension for File Properties [x86 version is linked there as well]
;
;
; Author: Ascend4nt
; ==============================================================================================

Func _ZoneId_ADSStreamDelete($sFilename)
    Local $aRet, $sZoneIDFileName

    ; Streams are assembled as "filename" + ":" + "Stream_ID"
    $sZoneIDFileName = $sFilename & ":Zone.Identifier"

    ; Make sure the stream exists
    If FileExists($sZoneIDFileName) Then
        ; While FileExists() works, FileDelete() doesn't, probably due to some internal sanity checks
        $aRet = DllCall("kernel32.dll", "bool", "DeleteFileW", "wstr", $sZoneIDFileName)
        If @error Then Return SetError(2, @error,0)
        Return $aRet[0]
    EndIf
    Return 0
EndFunc

; Example

$sFilename = FileOpenDialog("Filename", @DesktopDir, "All (*.*)", 1)
If @error Then Exit
MsgBox(0, "Results of ADS Zone Removal", "_ZoneId_ADSStreamDelete Return [0/1] =" &_ZoneId_ADSStreamDelete($sFilename))