;
;
; Backup firefox and thunderbird user profile with 7zip = http://www.7-zip.org/
;
; author nobbe 
; december 2009
;

;%APPDATA%\Mozilla\Profiles\[profile name]\[random string].slt\

#include <GUIConstants.au3>

; get full path to firefox profiles
$ff_dir = @AppDataDir & "\Mozilla\Firefox\*.*"
; get full path to thunderbird
$th_dir = @AppDataDir & "\Thunderbird\*.*"

; change these to your need
$7z_dir="c:\Program Files\7-Zip\";
$7z_dir="c:\Program Files (x86)\7-Zip\";

$backup_to_dir="c:\temp\"

#Region ### START Koda GUI section ### 
$FFBACK = GUICreate("Backup Firefox&Thunderbird Profile", 200, 150, 193, 115)
$btn_backup = GUICtrlCreateButton("Backup", 30, 20, 75, 25, 0)

GUISetState(@SW_SHOW)
#EndRegion 

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg

        Case $btn_backup
            ; do firefox
            
            $c= '"' & $7z_dir & "7z.exe " & '"' &  " a -r " & $backup_to_dir & "backup_firefox_" & @YEAR & "_" & @MON & "_" & @MDAY & ".7z " & $ff_dir & " -x!*.sqlite";
            ConsoleWrite($c & @crlf)
            
            runwait($c);

            ; do thunderbird

            $c= '"' & $7z_dir & "7z.exe " & '"' &  " a -r " & $backup_to_dir & "backup_thunderbird_" & @YEAR & "_" & @MON & "_" & @MDAY & ".7z " & $th_dir & " -x!*.sqlite";
            ConsoleWrite($c & @crlf)
            
            runwait($c);


        Case $GUI_EVENT_CLOSE
            Exit

    EndSwitch
WEnd


 
