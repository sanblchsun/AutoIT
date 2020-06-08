#Include <String.au3>

$TypeLib = ObjCreate("Scriptlet.TypeLib")
$strGUID = $TypeLib.Guid


$PassManAu3 = FileRead(@ScriptDir & '\PasswordManager_V5.1.au3')


$loc = StringInStr($PassManAu3, "$EncryptionPassword", 1)
$PassManAu3 = StringReplace($PassManAu3, $loc + 23, $strGUID, 1)


$TypeLib = ObjCreate("Scriptlet.TypeLib")
$strGUID = $TypeLib.Guid

$loc = StringInStr($PassManAu3, "$LIU", 1)
$PassManAu3 = StringReplace($PassManAu3, $loc + 8, $strGUID, 1)



$TypeLib = ObjCreate("Scriptlet.TypeLib")
$strGUID = $TypeLib.Guid

$loc = StringInStr($PassManAu3, "$LIP", 1)
$PassManAu3 = StringReplace($PassManAu3, $loc + 8, $strGUID, 1)


$input = InputBox("User", "One account will have the permission to retrieve the compiled passwords. Please enter in that account here (Case In-sensitive):", @UserName)
if $input = "" or @error = 1 Then Exit


$loc = StringInStr($PassManAu3, "$PrimaryUserAccount", 1)
$S1 = StringMid($PassManAu3, $loc + 22, 20)
$split = StringSplit($S1, '"')
$PassManAu3 = StringReplace($PassManAu3, $split[2], $input, 1)

$input = InputBox("Pass", "This account will require a password when trying to get the passwords (Case Sensitive!):")
if $input = "" or @error = 1 Then Exit

$loc = StringInStr($PassManAu3, "$SavePasswordsPassword", 1)
$S1 = StringMid($PassManAu3, $loc + 25, 20)
$split = StringSplit($S1, '"')
$PassManAu3 = StringReplace($PassManAu3, $split[2], $input , 1)

FileDelete(@ScriptDir & '\PasswordManager_V5.1_Ready.au3')
FileWrite(@ScriptDir & '\PasswordManager_V5.1_Ready.au3', $PassManAu3)
;MsgBox(0, "", @AppDataDir)