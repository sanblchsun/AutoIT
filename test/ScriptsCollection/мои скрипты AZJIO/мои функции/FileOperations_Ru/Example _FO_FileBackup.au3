; AZJIO
; http://www.autoitscript.com/forum/topic/133224-filesearch-foldersearch/
#include <Array.au3> ; ��� _ArrayDisplay
#include <FileOperations.au3>

$Success = _FO_FileBackup(@ScriptDir & '\file.au3', 'Backup', 3, -1)
MsgBox(0, '����� ��������������', 'Success = ' & $Success & @CRLF & '@error = ' & @error)