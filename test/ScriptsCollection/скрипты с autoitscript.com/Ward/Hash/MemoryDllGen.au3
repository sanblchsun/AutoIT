$DllName = FileOpenDialog("Open dll file", @ScriptDir, "DLL file (*.*)")
If $DllName = "" Then Exit

$Handle = FileOpen($DllName, 16)
$DllBinary = FileRead($Handle)
FileClose($Handle)

$LineLen = 2050
$DllString = String($DllBinary)

$Script = "Global" & @Tab & "$__HashDllCode = '" & StringLeft($DllString, $LineLen) & "'" & @CRLF
$DllString = StringTrimLeft($DllString, $LineLen)

While StringLen($DllString) > $LineLen
	$Script &= @Tab & "$__HashDllCode &= '" & StringLeft($DllString, $LineLen) & "'" & @CRLF
	$DllString = StringTrimLeft($DllString, $LineLen)
WEnd

If StringLen($DllString) <> 0 Then $Script &= @Tab & "$__HashDllCode &= '" & $DllString & "'" & @CRLF
ClipPut($Script)


MsgBox(64, 'MemoryDll Generator', 'The result is in the clipboard, you can paste it to your script.')
Exit