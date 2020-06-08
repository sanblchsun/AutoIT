Global Const $FO_MOVE = 0x0001
Global Const $FO_COPY = 0x0002
Global Const $FO_DELETE = 0x0003
Global Const $FO_RENAME = 0x0004

Global Const $FOF_MULTIDESTFILES = 0x0001
Global Const $FOF_CONFIRMMOUSE = 0x0002
Global Const $FOF_SILENT = 0x0004
Global Const $FOF_RENAMEONCOLLISION = 0x0008
Global Const $FOF_NOCONFIRMATION = 0x0010
Global Const $FOF_WANTMAPPINGHANDLE = 0x0020
Global Const $FOF_ALLOWUNDO = 0x0040
Global Const $FOF_FILESONLY = 0x0080
Global Const $FOF_SIMPLEPROGRESS = 0x0100
Global Const $FOF_NOCONFIRMMKDIR = 0x0200
Global Const $FOF_NOERRORUI = 0x0400
Global Const $FOF_NOCOPYSECURITYATTRIBS = 0x0800
Global Const $FOF_NORECURSION = 0x1000
Global Const $FOF_NO_CONNECTED_ELEMENTS = 0x2000
Global Const $FOF_WANTNUKEWARNING = 0x4000
Global Const $FOF_NORECURSEREPARSE = 0x8000

Func _CopyWithProgress($sFrom, $sTo)
	Local $SHFILEOPSTRUCT, $pFrom, $pTo, $aDllRet, $i, $nError = 0
	$SHFILEOPSTRUCT = DllStructCreate("hwnd hwnd;uint wFunc;ptr pFrom;ptr pTo;int fFlags;int fAnyOperationsAborted;ptr hNameMappings;ptr lpszProgressTitle")
	DllStructSetData($SHFILEOPSTRUCT, "hwnd", 0)
	DllStructSetData($SHFILEOPSTRUCT, "wFunc", $FO_COPY)
	$pFrom = DllStructCreate("char[" & StringLen($sFrom) + 2 & "]")
	DllStructSetData($pFrom, 1, $sFrom)
	For $i = 1 To StringLen($sFrom) + 2
		If DllStructGetData($pFrom, 1, $i) = Chr(10) Then DllStructSetData($pFrom, 1, Chr(0), $i)
	Next
	DllStructSetData($pFrom, 1, Chr(0), StringLen($sFrom) + 2) ; second null at the end
	DllStructSetData($SHFILEOPSTRUCT, "pFrom", DllStructGetPtr($pFrom))
	$pTo = DllStructCreate("char[" & StringLen($sTo) + 2 & "]")
	DllStructSetData($pTo, 1, $sTo)
	DllStructSetData($pTo, 1, Chr(0), StringLen($sTo) + 2) ; second null at the end
	DllStructSetData($SHFILEOPSTRUCT, "pTo", DllStructGetPtr($pTo))
	DllStructSetData($SHFILEOPSTRUCT, "fFlags", BitOR($FOF_NOCONFIRMMKDIR, $FOF_NOCONFIRMATION, $FOF_NOERRORUI))
	DllStructSetData($SHFILEOPSTRUCT, "fAnyOperationsAborted", 0)
	DllStructSetData($SHFILEOPSTRUCT, "hNameMappings", 0)
	DllStructSetData($SHFILEOPSTRUCT, "lpszProgressTitle", 0)
	$aDllRet = DllCall("shell32.dll", "int", "SHFileOperation", "ptr", DllStructGetPtr($SHFILEOPSTRUCT))
	If @error Or $aDllRet[0] <> 0 Then
		$aDllRet = DllCall("kernel32.dll", "long", "GetLastError")
		If Not @error Then $nError = $aDllRet[0]
	EndIf
	; test if button Abort was pressed
	If DllStructGetData($SHFILEOPSTRUCT, "fAnyOperationsAborted") Then $nError = -1

	$pFrom = 0
	$pTo = 0
	$SHFILEOPSTRUCT = 0
	If $nError <> 0 Then
		SetError($nError)
		Return False
	EndIf
	Return True
EndFunc