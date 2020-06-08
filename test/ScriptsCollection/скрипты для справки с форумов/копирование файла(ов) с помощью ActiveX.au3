; Windows - Copy with progress
; Author - JdeB

;~ 4 Do not display a progress dialog box.
;~ 8 Give the file being operated on a new name in a move, copy, or rename operation if a file with the target name already exists.
;~ 16 Respond with 'Yes to All' for any dialog box that is displayed.
;~ 64 Preserve undo information, if possible.
;~ 128 Perform the operation on files only if a wildcard file name (*.*) is specified.
;~ 256 Display a progress dialog box but do not show the file names.
;~ 512 Do not confirm the creation of a new directory if the operation requires one to be created.
;~ 1024 Do not display a user interface if an error occurs.
;~ 2048 Version 4.71. Do not copy the security attributes of the file.
;~ 4096 Only operate in the local directory. Don't operate recursively into subdirectories.
;~ 8192 Version 5.0. Do not copy connected files as a group. Only copy the specified files.

_FileCopy('C:\Program Files\Common Files', 'C:\')

Func _FileCopy($sFileFrom, $sFileTo)

    Local Const $FOF_RESPOND_YES = 16
    Local Const $FOF_SIMPLEPROGRESS = 256

    $oShell = ObjCreate('Shell.Application')
    $oShell.NameSpace($sFileTo).CopyHere($sFileFrom, $FOF_RESPOND_YES)
EndFunc   ;==>_FileCopy