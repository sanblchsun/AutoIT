#include "_RunWithReducedPrivileges.au3"
; ===============================================================================================================================
; <ReducedPrivilegesTest.au3>
;
; Test for _RunWithReducedPrivileges UDF
;
; Author: Ascend4nt
; ===============================================================================================================================
#RequireAdmin

$iAdminRet=Run(@ComSpec&' /k title Admin prompt')
; Note the command is the 2nd parameter, instead of being embedded with the first as it is in 'Run*()'
$iNonAdminRet=_RunWithReducedPrivileges(@ComSpec,' /k title Non-Admin prompt')
$iErr=@error
$iExt=@extended
MsgBox(0,"Run Info","Regular Admin Run Return:"&$iAdminRet&@CRLF&"Non-Admin Return:"&$iNonAdminRet&", @error="&$iErr&", @extended="&$iExt&@CRLF)
