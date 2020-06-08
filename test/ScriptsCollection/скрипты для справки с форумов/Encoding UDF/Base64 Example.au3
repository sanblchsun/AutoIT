#include <Encoding.au3>

String_Example()
Image_Example()

Func Image_Example()
	$sFile = FileOpenDialog("Select file", "C:\", "Images (*.png;*.gif;*.bmp;*.jpg)")
	If @error Then Return
	
	$hFile = FileOpen($sFile, 16)
	$sBinary_Read = FileRead($hFile)
	FileClose($hFile)
	
	$sBase64_Encode = _Encoding_Base64Encode($sBinary_Read)
	
	;Not sure why, but IE(8) doesn't open a "data:" protocol.
	ShellExecute(@ProgramFilesDir & "\Mozilla Firefox\firefox.exe", "data:image/" & StringRight($sFile, 3) & ";base64," & $sBase64_Encode)
EndFunc

Func String_Example()
	$sEncode = _Encoding_Base64Encode("My String")
	$sDecode = _Encoding_Base64Decode($sEncode)
	
	MsgBox(64, "Results", StringFormat("_StringBase64Encode: %s\n_StringBase64Decode: %s", $sEncode, $sDecode))
EndFunc
