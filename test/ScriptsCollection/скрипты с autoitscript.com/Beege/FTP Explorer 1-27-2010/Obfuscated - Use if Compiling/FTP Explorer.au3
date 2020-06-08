#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=3
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;Change to script directory
;************************************************************************************************************
;************************************************************************************************************
FileInstall('YOUR SCRIPT DIRECTORY \FTP Worker.a3x', @ScriptDir & '\FTP Worker.a3x', 1)
;************************************************************************************************************
;************************************************************************************************************

; #######  Start Include source C:\Program Files\AutoIt3\include\ComboConstants.au3
Global Const $CBS_AUTOHSCROLL = 0x40
Global Const $CBS_DROPDOWN = 0x2
Global Const $CBN_KILLFOCUS = 4
Global Const $CBN_SELCHANGE = 1
Global Const $CBN_SETFOCUS = 3
Global Const $__COMBOBOXCONSTANT_WS_VSCROLL = 0x00200000
Global Const $GUI_SS_DEFAULT_COMBO = BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $__COMBOBOXCONSTANT_WS_VSCROLL)
; #######  End Include source C:\Program Files\AutoIt3\include\ComboConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\GuiRichEdit.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\Clipboard.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\Memory.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\MemoryConstants.au3
Global Const $MEM_COMMIT = 0x00001000
Global Const $MEM_RESERVE = 0x00002000
Global Const $PAGE_READWRITE = 0x00000004
Global Const $MEM_RELEASE = 0x00008000
; #######  End Include source C:\Program Files\AutoIt3\include\MemoryConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\StructureConstants.au3
Global Const $tagPOINT = "long X;long Y"
Global Const $tagRECT = "long Left;long Top;long Right;long Bottom"
Global Const $tagFILETIME = "dword Lo;dword Hi"
Global Const $tagSYSTEMTIME = "word Year;word Month;word Dow;word Day;word Hour;word Minute;word Second;word MSeconds"
Global Const $tagNMHDR = "hwnd hWndFrom;uint_ptr IDFrom;INT Code"
Global Const $tagLVFINDINFO = "uint Flags;ptr Text;lparam Param;" & $tagPOINT & ";uint Direction"
Global Const $tagLVITEM = "uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns"
Global Const $tagNMITEMACTIVATE = $tagNMHDR & ";int Index;int SubItem;uint NewState;uint OldState;uint Changed;" & $tagPOINT & ";lparam lParam;uint KeyFlags"
Global Const $tagNMLVKEYDOWN = $tagNMHDR & ";align 1;word VKey;uint Flags"
Global Const $tagTOKEN_PRIVILEGES = "dword Count;int64 LUID;dword Attributes"
Global Const $tagMENUINFO = "dword Size;INT Mask;dword Style;uint YMax;handle hBack;dword ContextHelpID;ulong_ptr MenuData"
Global Const $tagMENUITEMINFO = "uint Size;uint Mask;uint Type;uint State;uint ID;handle SubMenu;handle BmpChecked;handle BmpUnchecked;" & "ulong_ptr ItemData;ptr TypeData;uint CCH;handle BmpItem"
Global Const $tagSECURITY_ATTRIBUTES = "dword Length;ptr Descriptor;bool InheritHandle"
Global Const $tagWIN32_FIND_DATA = "dword dwFileAttributes; dword ftCreationTime[2]; dword ftLastAccessTime[2]; dword ftLastWriteTime[2]; dword nFileSizeHigh; dword nFileSizeLow; dword dwReserved0; dword dwReserved1; wchar cFileName[260]; wchar cAlternateFileName[14]"
; #######  End Include source C:\Program Files\AutoIt3\include\StructureConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\ProcessConstants.au3
Global Const $PROCESS_VM_OPERATION = 0x00000008
Global Const $PROCESS_VM_READ = 0x00000010
Global Const $PROCESS_VM_WRITE = 0x00000020
; #######  End Include source C:\Program Files\AutoIt3\include\ProcessConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\Security.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\SecurityConstants.au3
Global Const $ERROR_NO_TOKEN = 1008
Global Const $SE_PRIVILEGE_ENABLED = 0x00000002
Global Const $TOKEN_QUERY = 0x00000008
Global Const $TOKEN_ADJUST_PRIVILEGES = 0x00000020
; #######  End Include source C:\Program Files\AutoIt3\include\SecurityConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\WinAPIError.au3
Func _WinAPI_GetLastError($curErr=@error, $curExt=@extended)
Local $aResult = DllCall("kernel32.dll", "dword", "GetLastError")
Return SetError($curErr, $curExt, $aResult[0])
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\WinAPIError.au3
Func _Security__AdjustTokenPrivileges($hToken, $fDisableAll, $pNewState, $iBufferLen, $pPrevState = 0, $pRequired = 0)
Local $aResult = DllCall("advapi32.dll", "bool", "AdjustTokenPrivileges", "handle", $hToken, "bool", $fDisableAll, "ptr", $pNewState, _
"dword", $iBufferLen, "ptr", $pPrevState, "ptr", $pRequired)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _Security__ImpersonateSelf($iLevel = 2)
Local $aResult = DllCall("advapi32.dll", "bool", "ImpersonateSelf", "int", $iLevel)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _Security__LookupPrivilegeValue($sSystem, $sName)
Local $aResult = DllCall("advapi32.dll", "int", "LookupPrivilegeValueW", "wstr", $sSystem, "wstr", $sName, "int64*", 0)
If @error Then Return SetError(@error, @extended, 0)
Return SetError(0, $aResult[0], $aResult[3])
EndFunc
Func _Security__OpenThreadToken($iAccess, $hThread = 0, $fOpenAsSelf = False)
If $hThread = 0 Then $hThread = DllCall("kernel32.dll", "handle", "GetCurrentThread")
If @error Then Return SetError(@error, @extended, 0)
Local $aResult = DllCall("advapi32.dll", "bool", "OpenThreadToken", "handle", $hThread[0], "dword", $iAccess, "int", $fOpenAsSelf, "ptr*", 0)
If @error Then Return SetError(@error, @extended, 0)
Return SetError(0, $aResult[0], $aResult[4])
EndFunc
Func _Security__OpenThreadTokenEx($iAccess, $hThread = 0, $fOpenAsSelf = False)
Local $hToken = _Security__OpenThreadToken($iAccess, $hThread, $fOpenAsSelf)
If $hToken = 0 Then
If _WinAPI_GetLastError() <> $ERROR_NO_TOKEN Then Return SetError(-3, _WinAPI_GetLastError(), 0)
If Not _Security__ImpersonateSelf() Then Return SetError(-1, _WinAPI_GetLastError(), 0)
$hToken = _Security__OpenThreadToken($iAccess, $hThread, $fOpenAsSelf)
If $hToken = 0 Then Return SetError(-2, _WinAPI_GetLastError(), 0)
EndIf
Return $hToken
EndFunc
Func _Security__SetPrivilege($hToken, $sPrivilege, $fEnable)
Local $iLUID = _Security__LookupPrivilegeValue("", $sPrivilege)
If $iLUID = 0 Then Return SetError(-1, 0, False)
Local $tCurrState = DllStructCreate($tagTOKEN_PRIVILEGES)
Local $pCurrState = DllStructGetPtr($tCurrState)
Local $iCurrState = DllStructGetSize($tCurrState)
Local $tPrevState = DllStructCreate($tagTOKEN_PRIVILEGES)
Local $pPrevState = DllStructGetPtr($tPrevState)
Local $iPrevState = DllStructGetSize($tPrevState)
Local $tRequired = DllStructCreate("int Data")
Local $pRequired = DllStructGetPtr($tRequired)
DllStructSetData($tCurrState, "Count", 1)
DllStructSetData($tCurrState, "LUID", $iLUID)
If Not _Security__AdjustTokenPrivileges($hToken, False, $pCurrState, $iCurrState, $pPrevState, $pRequired) Then  _
Return SetError(-2, @error, False)
DllStructSetData($tPrevState, "Count", 1)
DllStructSetData($tPrevState, "LUID", $iLUID)
Local $iAttributes = DllStructGetData($tPrevState, "Attributes")
If $fEnable Then
$iAttributes = BitOR($iAttributes, $SE_PRIVILEGE_ENABLED)
Else
$iAttributes = BitAND($iAttributes, BitNOT($SE_PRIVILEGE_ENABLED))
EndIf
DllStructSetData($tPrevState, "Attributes", $iAttributes)
If Not _Security__AdjustTokenPrivileges($hToken, False, $pPrevState, $iPrevState, $pCurrState, $pRequired) Then _
Return SetError(-3, @error, False)
Return True
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\Security.au3
Global Const $tagMEMMAP = "handle hProc;ulong_ptr Size;ptr Mem"
Func _MemFree(ByRef $tMemMap)
Local $pMemory = DllStructGetData($tMemMap, "Mem")
Local $hProcess = DllStructGetData($tMemMap, "hProc")
Local $bResult = _MemVirtualFreeEx($hProcess, $pMemory, 0, $MEM_RELEASE)
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hProcess)
If @error Then Return SetError(@error, @extended, False)
Return $bResult
EndFunc
Func _MemInit($hWnd, $iSize, ByRef $tMemMap)
Local $aResult = DllCall("User32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hWnd, "dword*", 0)
If @error Then Return SetError(@error, @extended, 0)
Local $iProcessID = $aResult[2]
If $iProcessID = 0 Then Return SetError(1, 0, 0)
Local $iAccess = BitOR($PROCESS_VM_OPERATION, $PROCESS_VM_READ, $PROCESS_VM_WRITE)
Local $hProcess = __Mem_OpenProcess($iAccess, False, $iProcessID, True)
Local $iAlloc = BitOR($MEM_RESERVE, $MEM_COMMIT)
Local $pMemory = _MemVirtualAllocEx($hProcess, 0, $iSize, $iAlloc, $PAGE_READWRITE)
If $pMemory = 0 Then Return SetError(2, 0, 0)
$tMemMap = DllStructCreate($tagMEMMAP)
DllStructSetData($tMemMap, "hProc", $hProcess)
DllStructSetData($tMemMap, "Size", $iSize)
DllStructSetData($tMemMap, "Mem", $pMemory)
Return $pMemory
EndFunc
Func _MemRead(ByRef $tMemMap, $pSrce, $pDest, $iSize)
Local $aResult = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", DllStructGetData($tMemMap, "hProc"), _
"ptr", $pSrce, "ptr", $pDest, "ulong_ptr", $iSize, "ulong_ptr*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _MemWrite(ByRef $tMemMap, $pSrce, $pDest = 0, $iSize = 0, $sSrce = "ptr")
If $pDest = 0 Then $pDest = DllStructGetData($tMemMap, "Mem")
If $iSize = 0 Then $iSize = DllStructGetData($tMemMap, "Size")
Local $aResult = DllCall("kernel32.dll", "bool", "WriteProcessMemory", "handle", DllStructGetData($tMemMap, "hProc"), _
"ptr", $pDest, $sSrce, $pSrce, "ulong_ptr", $iSize, "ulong_ptr*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _MemVirtualAllocEx($hProcess, $pAddress, $iSize, $iAllocation, $iProtect)
Local $aResult = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "handle", $hProcess, "ptr", $pAddress, "ulong_ptr", $iSize, "dword", $iAllocation, "dword", $iProtect)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _MemVirtualFreeEx($hProcess, $pAddress, $iSize, $iFreeType)
Local $aResult = DllCall("kernel32.dll", "bool", "VirtualFreeEx", "handle", $hProcess, "ptr", $pAddress, "ulong_ptr", $iSize, "dword", $iFreeType)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func __Mem_OpenProcess($iAccess, $fInherit, $iProcessID, $fDebugPriv=False)
Local $aResult = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $iAccess, "bool", $fInherit, "dword", $iProcessID)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return $aResult[0]
If Not $fDebugPriv Then Return 0
Local $hToken = _Security__OpenThreadTokenEx(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
If @error Then Return SetError(@error, @extended, 0)
_Security__SetPrivilege($hToken, "SeDebugPrivilege", True)
Local $iError = @error
Local $iLastError = @extended
Local $iRet = 0
If Not @error Then
$aResult = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $iAccess, "bool", $fInherit, "dword", $iProcessID)
$iError = @error
$iLastError = @extended
If $aResult[0] Then $iRet = $aResult[0]
_Security__SetPrivilege($hToken, "SeDebugPrivilege", False)
If @error Then
$iError = @error
$iLastError = @extended
EndIf
EndIf
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hToken)
Return SetError($iError, $iLastError, $iRet)
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\Memory.au3
Func _ClipBoard_RegisterFormat($sFormat)
Local $aResult = DllCall("user32.dll", "uint", "RegisterClipboardFormatW", "wstr", $sFormat)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\Clipboard.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\RichEditConstants.au3
Global Const $__RICHEDITCONSTANT_WM_USER = 0x400
Global Const $EM_EXGETSEL = $__RICHEDITCONSTANT_WM_USER + 52
Global Const $EM_EXLIMITTEXT = $__RICHEDITCONSTANT_WM_USER + 53
Global Const $EM_GETTEXTLENGTHEX = $__RICHEDITCONSTANT_WM_USER + 95
Global Const $EM_HIDESELECTION = $__RICHEDITCONSTANT_WM_USER + 63
Global Const $EM_SETCHARFORMAT = $__RICHEDITCONSTANT_WM_USER + 68
Global Const $EM_SETOLECALLBACK = $__RICHEDITCONSTANT_WM_USER + 70
Global Const $EM_SETTEXTEX = $__RICHEDITCONSTANT_WM_USER + 97
Global Const $ST_SELECTION = 2
Global Const $GTL_CLOSE = 4
Global Const $GTL_DEFAULT = 0
Global Const $GTL_NUMBYTES = 16
Global Const $GTL_PRECISE = 2
Global Const $GTL_USECRLF = 1
Global Const $CP_ACP = 0
Global Const $CP_UNICODE = 1200
Global Const $CFM_COLOR = 0x40000000
Global Const $CFE_AUTOCOLOR = $CFM_COLOR
Global Const $SCF_SELECTION = 0x1
Global Const $SCF_ALL = 0x4
Global Const $PFM_RTLPARA = 0x10000
Global Const $PFM_KEEP = 0x20000
Global Const $PFM_KEEPNEXT = 0x40000
Global Const $PFM_PAGEBREAKBEFORE = 0x80000
Global Const $PFM_NOLINENUMBER = 0x100000
Global Const $PFM_NOWIDOWCONTROL = 0x200000
Global Const $PFM_DONOTHYPHEN = 0x400000
Global Const $PFM_SIDEBYSIDE = 0x800000
Global Const $PFE_RTLPARA = BitShift($PFM_RTLPARA, 16)
Global Const $PFE_KEEP = BitShift($PFM_KEEP, 16)
Global Const $PFE_KEEPNEXT = BitShift($PFM_KEEPNEXT, 16)
Global Const $PFE_PAGEBREAKBEFORE = BitShift($PFM_PAGEBREAKBEFORE, 16)
Global Const $PFE_NOLINENUMBER = BitShift($PFM_NOLINENUMBER, 16)
Global Const $PFE_NOWIDOWCONTROL = BitShift($PFM_NOWIDOWCONTROL, 16)
Global Const $PFE_DONOTHYPHEN = BitShift($PFM_DONOTHYPHEN, 16)
Global Const $PFE_SIDEBYSIDE = BitShift($PFM_SIDEBYSIDE, 16)
; #######  End Include source C:\Program Files\AutoIt3\include\RichEditConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\EditConstants.au3
Global Const $ES_MULTILINE = 4
Global Const $ES_PASSWORD = 32
Global Const $ES_AUTOVSCROLL = 64
Global Const $ES_AUTOHSCROLL = 128
Global Const $ES_READONLY = 2048
Global Const $ES_WANTRETURN = 4096
Global Const $EM_LINEINDEX = 0xBB
Global Const $EM_REPLACESEL = 0xC2
Global Const $EM_SETSEL = 0xB1
Global Const $__EDITCONSTANT_WS_VSCROLL = 0x00200000
Global Const $__EDITCONSTANT_WS_HSCROLL = 0x00100000
Global Const $GUI_SS_DEFAULT_EDIT = BitOR($ES_WANTRETURN, $__EDITCONSTANT_WS_VSCROLL, $__EDITCONSTANT_WS_HSCROLL, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL)
; #######  End Include source C:\Program Files\AutoIt3\include\EditConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\Misc.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\FontConstants.au3
; #######  End Include source C:\Program Files\AutoIt3\include\FontConstants.au3
Func _Iif($fTest, $vTrueVal, $vFalseVal)
If $fTest Then
Return $vTrueVal
Else
Return $vFalseVal
EndIf
EndFunc
Func _Singleton($sOccurenceName, $iFlag = 0)
Local Const $ERROR_ALREADY_EXISTS = 183
Local Const $SECURITY_DESCRIPTOR_REVISION = 1
Local $pSecurityAttributes = 0
If BitAND($iFlag, 2) Then
Local $tSecurityDescriptor = DllStructCreate("dword[5]")
Local $pSecurityDescriptor = DllStructGetPtr($tSecurityDescriptor)
Local $aRet = DllCall("advapi32.dll", "bool", "InitializeSecurityDescriptor", _
"ptr", $pSecurityDescriptor, "dword", $SECURITY_DESCRIPTOR_REVISION)
If @error Then Return SetError(@error, @extended, 0)
If $aRet[0] Then
$aRet = DllCall("advapi32.dll", "bool", "SetSecurityDescriptorDacl", _
"ptr", $pSecurityDescriptor, "bool", 1, "ptr", 0, "bool", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aRet[0] Then
Local $structSecurityAttributes = DllStructCreate($tagSECURITY_ATTRIBUTES)
DllStructSetData($structSecurityAttributes, 1, DllStructGetSize($structSecurityAttributes))
DllStructSetData($structSecurityAttributes, 2, $pSecurityDescriptor)
DllStructSetData($structSecurityAttributes, 3, 0)
$pSecurityAttributes = DllStructGetPtr($structSecurityAttributes)
EndIf
EndIf
EndIf
Local $handle = DllCall("kernel32.dll", "handle", "CreateMutexW", "ptr", $pSecurityAttributes, "bool", 1, "wstr", $sOccurenceName)
If @error Then Return SetError(@error, @extended, 0)
Local $lastError = DllCall("kernel32.dll", "dword", "GetLastError")
If @error Then Return SetError(@error, @extended, 0)
If $lastError[0] = $ERROR_ALREADY_EXISTS Then
If BitAND($iFlag, 1) Then
Return SetError($lastError[0], $lastError[0], 0)
Else
Exit -1
EndIf
EndIf
Return $handle[0]
EndFunc
Func _IsPressed($sHexKey, $vDLL = 'user32.dll')
Local $a_R = DllCall($vDLL, "short", "GetAsyncKeyState", "int", '0x' & $sHexKey)
If @error Then Return SetError(@error, @extended, False)
Return BitAND($a_R[0], 0x8000) <> 0
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\Misc.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\UDFGlobalID.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\WinAPI.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\FileConstants.au3
Global Const $FO_OVERWRITE = 2
Global Const $FILE_ATTRIBUTE_DIRECTORY = 0x00000010
Global Const $FILE_ATTRIBUTE_NORMAL = 0x00000080
Global Const $GENERIC_READ = 0x80000000
; #######  End Include source C:\Program Files\AutoIt3\include\FileConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\SendMessage.au3
Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lresult")
Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
If @error Then Return SetError(@error, @extended, "")
If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
Return $aResult
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\SendMessage.au3
Global $__gaInProcess_WinAPI[64][2] = [[0, 0]]
Global Const $HGDI_ERROR = Ptr(-1)
Global Const $INVALID_HANDLE_VALUE = Ptr(-1)
Global Const $DEFAULT_GUI_FONT = 17
Global Const $KF_EXTENDED = 0x0100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Func _WinAPI_CreateWindowEx($iExStyle, $sClass, $sName, $iStyle, $iX, $iY, $iWidth, $iHeight, $hParent, $hMenu = 0, $hInstance = 0, $pParam = 0)
If $hInstance = 0 Then $hInstance = _WinAPI_GetModuleHandle("")
Local $aResult = DllCall("user32.dll", "hwnd", "CreateWindowExW", "dword", $iExStyle, "wstr", $sClass, "wstr", $sName, "dword", $iStyle, "int", $iX, _
"int", $iY, "int", $iWidth, "int", $iHeight, "hwnd", $hParent, "handle", $hMenu, "handle", $hInstance, "ptr", $pParam)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_DestroyWindow($hWnd)
Local $aResult = DllCall("user32.dll", "bool", "DestroyWindow", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_GetClassName($hWnd)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Local $aResult = DllCall("user32.dll", "int", "GetClassNameW", "hwnd", $hWnd, "wstr", "", "int", 4096)
If @error Then Return SetError(@error, @extended, False)
Return SetExtended($aResult[0], $aResult[2])
EndFunc
Func _WinAPI_GetDlgCtrlID($hWnd)
Local $aResult = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetModuleHandle($sModuleName)
Local $sModuleNameType = "wstr"
If $sModuleName = "" Then
$sModuleName = 0
$sModuleNameType = "ptr"
EndIf
Local $aResult = DllCall("kernel32.dll", "handle", "GetModuleHandleW", $sModuleNameType, $sModuleName)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetMousePos($fToClient = False, $hWnd = 0)
Local $iMode = Opt("MouseCoordMode", 1)
Local $aPos = MouseGetPos()
Opt("MouseCoordMode", $iMode)
Local $tPoint = DllStructCreate($tagPOINT)
DllStructSetData($tPoint, "X", $aPos[0])
DllStructSetData($tPoint, "Y", $aPos[1])
If $fToClient Then
_WinAPI_ScreenToClient($hWnd, $tPoint)
If @error Then Return SetError(@error, @extended, 0)
EndIf
Return $tPoint
EndFunc
Func _WinAPI_GetMousePosX($fToClient = False, $hWnd = 0)
Local $tPoint = _WinAPI_GetMousePos($fToClient, $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return DllStructGetData($tPoint, "X")
EndFunc
Func _WinAPI_GetMousePosY($fToClient = False, $hWnd = 0)
Local $tPoint = _WinAPI_GetMousePos($fToClient, $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return DllStructGetData($tPoint, "Y")
EndFunc
Func _WinAPI_GetParent($hWnd)
Local $aResult = DllCall("user32.dll", "hwnd", "GetParent", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetStockObject($iObject)
Local $aResult = DllCall("gdi32.dll", "handle", "GetStockObject", "int", $iObject)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetWindowHeight($hWnd)
Local $tRect = _WinAPI_GetWindowRect($hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return DllStructGetData($tRect, "Bottom") - DllStructGetData($tRect, "Top")
EndFunc
Func _WinAPI_GetWindowRect($hWnd)
Local $tRect = DllStructCreate($tagRECT)
DllCall("user32.dll", "bool", "GetWindowRect", "hwnd", $hWnd, "ptr", DllStructGetPtr($tRect))
If @error Then Return SetError(@error, @extended, 0)
Return $tRect
EndFunc
Func _WinAPI_GetWindowThreadProcessId($hWnd, ByRef $iPID)
Local $aResult = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hWnd, "dword*", 0)
If @error Then Return SetError(@error, @extended, 0)
$iPID = $aResult[2]
Return $aResult[0]
EndFunc
Func _WinAPI_GetWindowWidth($hWnd)
Local $tRect = _WinAPI_GetWindowRect($hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return DllStructGetData($tRect, "Right") - DllStructGetData($tRect, "Left")
EndFunc
Func _WinAPI_HiWord($iLong)
Return BitShift($iLong, 16)
EndFunc
Func _WinAPI_InProcess($hWnd, ByRef $hLastWnd)
If $hWnd = $hLastWnd Then Return True
For $iI = $__gaInProcess_WinAPI[0][0] To 1 Step -1
If $hWnd = $__gaInProcess_WinAPI[$iI][0] Then
If $__gaInProcess_WinAPI[$iI][1] Then
$hLastWnd = $hWnd
Return True
Else
Return False
EndIf
EndIf
Next
Local $iProcessID
_WinAPI_GetWindowThreadProcessId($hWnd, $iProcessID)
Local $iCount = $__gaInProcess_WinAPI[0][0] + 1
If $iCount >= 64 Then $iCount = 1
$__gaInProcess_WinAPI[0][0] = $iCount
$__gaInProcess_WinAPI[$iCount][0] = $hWnd
$__gaInProcess_WinAPI[$iCount][1] =($iProcessID = @AutoItPID)
Return $__gaInProcess_WinAPI[$iCount][1]
EndFunc
Func _WinAPI_IsClassName($hWnd, $sClassName)
Local $sSeparator = Opt("GUIDataSeparatorChar")
Local $aClassName = StringSplit($sClassName, $sSeparator)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Local $sClassCheck = _WinAPI_GetClassName($hWnd)
For $x = 1 To UBound($aClassName) - 1
If StringUpper(StringMid($sClassCheck, 1, StringLen($aClassName[$x]))) = StringUpper($aClassName[$x]) Then Return True
Next
Return False
EndFunc
Func _WinAPI_LoWord($iLong)
Return BitAND($iLong, 0xFFFF)
EndFunc
Func _WinAPI_MakeQWord($LoDWORD, $HiDWORD)
Local $tInt64 = DllStructCreate("uint64")
Local $tDwords = DllStructCreate("dword;dword", DllStructGetPtr($tInt64))
DllStructSetData($tDwords, 1, $LoDWORD)
DllStructSetData($tDwords, 2, $HiDWORD)
Return DllStructGetData($tInt64, 1)
EndFunc
Func _WinAPI_MoveWindow($hWnd, $iX, $iY, $iWidth, $iHeight, $fRepaint = True)
Local $aResult = DllCall("user32.dll", "bool", "MoveWindow", "hwnd", $hWnd, "int", $iX, "int", $iY, "int", $iWidth, "int", $iHeight, "bool", $fRepaint)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_ScreenToClient($hWnd, ByRef $tPoint)
Local $aResult = DllCall("user32.dll", "bool", "ScreenToClient", "hwnd", $hWnd, "ptr", DllStructGetPtr($tPoint))
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_SetFocus($hWnd)
Local $aResult = DllCall("user32.dll", "hwnd", "SetFocus", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_SetParent($hWndChild, $hWndParent)
Local $aResult = DllCall("user32.dll", "hwnd", "SetParent", "hwnd", $hWndChild, "hwnd", $hWndParent)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_SetWindowPos($hWnd, $hAfter, $iX, $iY, $iCX, $iCY, $iFlags)
Local $aResult = DllCall("user32.dll", "bool", "SetWindowPos", "hwnd", $hWnd, "hwnd", $hAfter, "int", $iX, "int", $iY, "int", $iCX, _
"int", $iCY, "uint", $iFlags)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\WinAPI.au3
Global Const $_UDF_GlobalIDs_OFFSET = 2
Global Const $_UDF_GlobalID_MAX_WIN = 16
Global Const $_UDF_STARTID = 10000
Global Const $_UDF_GlobalID_MAX_IDS = 55535
Global Const $__UDFGUICONSTANT_WS_VISIBLE = 0x10000000
Global Const $__UDFGUICONSTANT_WS_CHILD = 0x40000000
Global $_UDF_GlobalIDs_Used[$_UDF_GlobalID_MAX_WIN][$_UDF_GlobalID_MAX_IDS + $_UDF_GlobalIDs_OFFSET + 1]
Func __UDF_GetNextGlobalID($hWnd)
Local $nCtrlID, $iUsedIndex = -1, $fAllUsed = True
If Not WinExists($hWnd) Then Return SetError(-1, -1, 0)
For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
If $_UDF_GlobalIDs_Used[$iIndex][0] <> 0 Then
If Not WinExists($_UDF_GlobalIDs_Used[$iIndex][0]) Then
For $x = 0 To UBound($_UDF_GlobalIDs_Used, 2) - 1
$_UDF_GlobalIDs_Used[$iIndex][$x] = 0
Next
$_UDF_GlobalIDs_Used[$iIndex][1] = $_UDF_STARTID
$fAllUsed = False
EndIf
EndIf
Next
For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
If $_UDF_GlobalIDs_Used[$iIndex][0] = $hWnd Then
$iUsedIndex = $iIndex
ExitLoop
EndIf
Next
If $iUsedIndex = -1 Then
For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
If $_UDF_GlobalIDs_Used[$iIndex][0] = 0 Then
$_UDF_GlobalIDs_Used[$iIndex][0] = $hWnd
$_UDF_GlobalIDs_Used[$iIndex][1] = $_UDF_STARTID
$fAllUsed = False
$iUsedIndex = $iIndex
ExitLoop
EndIf
Next
EndIf
If $iUsedIndex = -1 And $fAllUsed Then Return SetError(16, 0, 0)
If $_UDF_GlobalIDs_Used[$iUsedIndex][1] = $_UDF_STARTID + $_UDF_GlobalID_MAX_IDS Then
For $iIDIndex = $_UDF_GlobalIDs_OFFSET To UBound($_UDF_GlobalIDs_Used, 2) - 1
If $_UDF_GlobalIDs_Used[$iUsedIndex][$iIDIndex] = 0 Then
$nCtrlID =($iIDIndex - $_UDF_GlobalIDs_OFFSET) + 10000
$_UDF_GlobalIDs_Used[$iUsedIndex][$iIDIndex] = $nCtrlID
Return $nCtrlID
EndIf
Next
Return SetError(-1, $_UDF_GlobalID_MAX_IDS, 0)
EndIf
$nCtrlID = $_UDF_GlobalIDs_Used[$iUsedIndex][1]
$_UDF_GlobalIDs_Used[$iUsedIndex][1] += 1
$_UDF_GlobalIDs_Used[$iUsedIndex][($nCtrlID - 10000) + $_UDF_GlobalIDs_OFFSET] = $nCtrlID
Return $nCtrlID
EndFunc
Func __UDF_FreeGlobalID($hWnd, $iGlobalID)
If $iGlobalID - $_UDF_STARTID < 0 Or $iGlobalID - $_UDF_STARTID > $_UDF_GlobalID_MAX_IDS Then Return SetError(-1, 0, False)
For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
If $_UDF_GlobalIDs_Used[$iIndex][0] = $hWnd Then
For $x = $_UDF_GlobalIDs_OFFSET To UBound($_UDF_GlobalIDs_Used, 2) - 1
If $_UDF_GlobalIDs_Used[$iIndex][$x] = $iGlobalID Then
$_UDF_GlobalIDs_Used[$iIndex][$x] = 0
Return True
EndIf
Next
Return SetError(-3, 0, False)
EndIf
Next
Return SetError(-2, 0, False)
EndFunc
Func __UDF_DebugPrint($sText, $iLine = @ScriptLineNumber, $err=@error, $ext=@extended)
ConsoleWrite( _
"!===========================================================" & @CRLF & _
"+======================================================" & @CRLF & _
"-->Line(" & StringFormat("%04d", $iLine) & "):" & @TAB & $sText & @CRLF & _
"+======================================================" & @CRLF)
Return SetError($err, $ext, 1)
EndFunc
Func __UDF_ValidateClassName($hWnd, $sClassNames)
__UDF_DebugPrint("This is for debugging only, set the debug variable to false before submitting")
If _WinAPI_IsClassName($hWnd, $sClassNames) Then Return True
Local $sSeparator = Opt("GUIDataSeparatorChar")
$sClassNames = StringReplace($sClassNames, $sSeparator, ",")
__UDF_DebugPrint("Invalid Class Type(s):" & @LF & @TAB & "Expecting Type(s): " & $sClassNames & @LF & @TAB & "Received Type : " & _WinAPI_GetClassName($hWnd))
Exit
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\UDFGlobalID.au3
Global $Debug_RE = False
Global $_GRE_sRTFClassName, $h_GUICtrlRTF_lib, $_GRE_Version, $_GRE_TwipsPeSpaceUnit = 1440
Global $_GRE_hUser32dll, $_GRE_CF_RTF, $_GRE_CF_RETEXTOBJ
Global $_GRC_StreamFromFileCallback = DllCallbackRegister("__GCR_StreamFromFileCallback", "dword", "long_ptr;ptr;long;ptr")
Global $_GRC_StreamFromVarCallback = DllCallbackRegister("__GCR_StreamFromVarCallback", "dword", "long_ptr;ptr;long;ptr")
Global $_GRC_StreamToFileCallback = DllCallbackRegister("__GCR_StreamToFileCallback", "dword", "long_ptr;ptr;long;ptr")
Global $_GRC_StreamToVarCallback = DllCallbackRegister("__GCR_StreamToVarCallback", "dword", "long_ptr;ptr;long;ptr")
Global $_GRC_sStreamVar
Global $gh_RELastWnd
Global $pObj_RichComObject = DllStructCreate("ptr pIntf; dword  Refcount")
Global $pCall_RichCom, $pObj_RichCom
Global $hLib_RichCom_OLE32 = DllOpen("OLE32.DLL")
Global $__RichCom_Object_QueryInterface = DllCallbackRegister("__RichCom_Object_QueryInterface", "long", "ptr;dword;dword")
Global $__RichCom_Object_AddRef = DllCallbackRegister("__RichCom_Object_AddRef", "long", "ptr")
Global $__RichCom_Object_Release = DllCallbackRegister("__RichCom_Object_Release", "long", "ptr")
Global $__RichCom_Object_GetNewStorage = DllCallbackRegister("__RichCom_Object_GetNewStorage", "long", "ptr;ptr")
Global $__RichCom_Object_GetInPlaceContext = DllCallbackRegister("__RichCom_Object_GetInPlaceContext", "long", "ptr;dword;dword;dword")
Global $__RichCom_Object_ShowContainerUI = DllCallbackRegister("__RichCom_Object_ShowContainerUI", "long", "ptr;long")
Global $__RichCom_Object_QueryInsertObject = DllCallbackRegister("__RichCom_Object_QueryInsertObject", "long", "ptr;dword;ptr;long")
Global $__RichCom_Object_DeleteObject = DllCallbackRegister("__RichCom_Object_DeleteObject", "long", "ptr;ptr")
Global $__RichCom_Object_QueryAcceptData = DllCallbackRegister("__RichCom_Object_QueryAcceptData", "long", "ptr;ptr;dword;dword;dword;ptr")
Global $__RichCom_Object_ContextSensitiveHelp = DllCallbackRegister("__RichCom_Object_ContextSensitiveHelp", "long", "ptr;long")
Global $__RichCom_Object_GetClipboardData = DllCallbackRegister("__RichCom_Object_GetClipboardData", "long", "ptr;ptr;dword;ptr")
Global $__RichCom_Object_GetDragDropEffect = DllCallbackRegister("__RichCom_Object_GetDragDropEffect", "long", "ptr;dword;dword;dword")
Global $__RichCom_Object_GetContextMenu = DllCallbackRegister("__RichCom_Object_GetContextMenu", "long", "ptr;short;ptr;ptr;ptr")
Global Const $__RICHEDITCONSTANT_WS_VISIBLE = 0x10000000
Global Const $__RICHEDITCONSTANT_WS_CHILD = 0x40000000
Global Const $__RICHEDITCONSTANT_WS_TABSTOP = 0x00010000
Global Const $__RICHEDITCONSTANT_WM_SETFONT = 0x0030
Global Const $_GCR_S_OK = 0
Global Const $_GCR_E_NOTIMPL = 0x80004001
Global Const $tagCHARFORMAT = "uint cbSize;dword dwMask;dword dwEffects;long yHeight;long yOffset;dword crCharColor;byte bCharSet;byte bPitchAndFamily;wchar szFaceName[32]"
Global Const $tagCHARRANGE = "long cpMin;long cpMax"
Global Const $tagGETTEXTLENGTHEX = "dword flags;uint codepage"
Global Const $tagSETTEXTEX = "dword flags;uint codepage"
Func _GUICtrlRichEdit_AppendText($hWnd, $sText)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
Local $iLength = _GUICtrlRichEdit_GetTextLength($hWnd)
_GUICtrlRichEdit_SetSel($hWnd, $iLength, $iLength)
Local $tSetText = DllStructCreate($tagSETTEXTEX)
DllStructSetData($tSetText, 1, $ST_SELECTION)
Local $iRet
If StringLeft($sText, 5) <> "{\rtf" And StringLeft($sText, 5) <> "{urtf" Then
DllStructSetData($tSetText, 2, $CP_UNICODE)
$iRet = _SendMessage($hWnd, $EM_SETTEXTEX, DllStructGetPtr($tSetText), $sText, 0, "ptr", "wstr")
Else
DllStructSetData($tSetText, 2, $CP_ACP)
$iRet = _SendMessage($hWnd, $EM_SETTEXTEX, DllStructGetPtr($tSetText), $sText, 0, "ptr", "STR")
EndIf
If Not $iRet Then Return SetError(700, 0, False)
Return True
EndFunc
Func _GUICtrlRichEdit_Create($hWnd, $sText, $iLeft, $iTop, $iWidth = 150, $iHeight = 150, $iStyle = -1, $iExStyle = -1)
If Not IsHWnd($hWnd) Then Return SetError(1, 0, 0)
If Not IsString($sText) Then Return SetError(2, 0, 0)
If Not __GCR_IsNumeric($iLeft, ">=0") Then Return SetError(103, 0, 0)
If Not __GCR_IsNumeric($iTop, ">=0") Then Return SetError(104, 0, 0)
If Not __GCR_IsNumeric($iWidth, ">0,-1") Then Return SetError(105, 0, 0)
If Not __GCR_IsNumeric($iHeight, ">0,-1") Then Return SetError(106, 0, 0)
If Not __GCR_IsNumeric($iStyle, ">=0,-1") Then Return SetError(107, 0, 0)
If Not __GCR_IsNumeric($iExStyle, ">=0,-1") Then Return SetError(108, 0, 0)
If $iWidth = -1 Then $iWidth = 150
If $iHeight = -1 Then $iHeight = 150
If $iStyle = -1 Then $iStyle = BitOR($ES_WANTRETURN, $ES_MULTILINE)
If BitAND($iStyle, $ES_MULTILINE) <> 0 Then $iStyle = BitOR($iStyle, $ES_WANTRETURN)
If $iExStyle = -1 Then $iExStyle = 0x200
$iStyle = BitOR($iStyle, $__RICHEDITCONSTANT_WS_CHILD, $__RICHEDITCONSTANT_WS_VISIBLE)
If BitAND($iStyle, $ES_READONLY) = 0 Then $iStyle = BitOR($iStyle, $__RICHEDITCONSTANT_WS_TABSTOP)
Local $nCtrlID = __UDF_GetNextGlobalID($hWnd)
If @error Then Return SetError(@error, @extended, 0)
__GCR_Init()
Local $hRichEdit = _WinAPI_CreateWindowEx($iExStyle, $_GRE_sRTFClassName, "", $iStyle, $iLeft, $iTop, $iWidth, _
$iHeight, $hWnd, $nCtrlID)
If $hRichEdit = 0 Then Return SetError(700, 0, False)
__GCR_SetOLECallback($hRichEdit)
_SendMessage($hRichEdit, $__RICHEDITCONSTANT_WM_SETFONT, _WinAPI_GetStockObject($DEFAULT_GUI_FONT), True)
_GUICtrlRichEdit_AppendText($hRichEdit, $sText)
Return $hRichEdit
EndFunc
Func _GUICtrlRichEdit_Destroy(ByRef $hWnd)
If $Debug_RE Then __UDF_ValidateClassName($hWnd, $_GRE_sRTFClassName)
If Not _WinAPI_IsClassName($hWnd, $_GRE_sRTFClassName) Then Return SetError(2, 2, False)
Local $Destroyed = 0
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $gh_RELastWnd) Then
Local $nCtrlID = _WinAPI_GetDlgCtrlID($hWnd)
Local $hParent = _WinAPI_GetParent($hWnd)
$Destroyed = _WinAPI_DestroyWindow($hWnd)
Local $iRet = __UDF_FreeGlobalID($hParent, $nCtrlID)
If Not $iRet Then
EndIf
Else
Return SetError(1, 1, False)
EndIf
Else
$Destroyed = GUICtrlDelete($hWnd)
EndIf
If $Destroyed Then $hWnd = 0
Return $Destroyed <> 0
EndFunc
Func _GUICtrlRichEdit_GetTextLength($hWnd, $fExact = True, $fChars = False)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, 0)
If Not IsBool($fExact) Then Return SetError(102, 0, 0)
If Not IsBool($fChars) Then Return SetError(103, 0, 0)
Local $tGetTextLen = DllStructCreate($tagGETTEXTLENGTHEX)
Local $iFlags = BitOR($GTL_USECRLF, _Iif($fExact, $GTL_PRECISE, $GTL_CLOSE))
$iFlags = BitOR($iFlags, _Iif($fChars, $GTL_DEFAULT, $GTL_NUMBYTES))
DllStructSetData($tGetTextLen, 1, $iFlags)
DllStructSetData($tGetTextLen, 2, _Iif($fChars, $CP_ACP, $CP_UNICODE))
Local $iRet = _SendMessage($hWnd, $EM_GETTEXTLENGTHEX, DllStructGetPtr($tGetTextLen), 0)
Return $iRet
EndFunc
Func _GUICtrlRichEdit_GetFirstCharPosOnLine($hWnd, $iLine = -1)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, 0)
If Not __GCR_IsNumeric($iLine, ">0,-1") Then Return SetError(1021, 0, 0)
If $iLine <> -1 Then $iLine -= 1
Local $iRet = _SendMessage($hWnd, $EM_LINEINDEX, $iLine)
If $iRet = -1 Then Return SetError(1022, 0, 0)
Return $iRet
EndFunc
Func _GUICtrlRichEdit_GetSel($hWnd)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, 0)
Local $tCharRange = DllStructCreate($tagCHARRANGE)
_SendMessage($hWnd, $EM_EXGETSEL, 0, DllStructGetPtr($tCharRange))
Local $aRet[2]
$aRet[0] = DllStructGetData($tCharRange, 1)
$aRet[1] = DllStructGetData($tCharRange, 2)
Return $aRet
EndFunc
Func _GUICtrlRichEdit_IsTextSelected($hWnd)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
Local $tCharRange = DllStructCreate($tagCHARRANGE)
_SendMessage($hWnd, $EM_EXGETSEL, 0, DllStructGetPtr($tCharRange))
Return DllStructGetData($tCharRange, 2) <> DllStructGetData($tCharRange, 1)
EndFunc
Func _GUICtrlRichEdit_ReplaceText($hWnd, $sText, $fCanUndo = True)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
If Not IsBool($fCanUndo) Then Return SetError(103, 0, False)
If Not _GUICtrlRichEdit_IsTextSelected($hWnd) Then Return SetError(-1, 0, False)
Local $tText = DllStructCreate("wchar Text[" & StringLen($sText) + 1 & "]")
DllStructSetData($tText, "Text", $sText)
Local $ptrBuf = DllStructGetPtr($tText)
If _WinAPI_InProcess($hWnd, $gh_RELastWnd) Then
_SendMessage($hWnd, $EM_REPLACESEL, $fCanUndo, $ptrBuf, 0, "wparam", "ptr")
Else
Local $iText = DllStructGetSize($tText)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iText, $tMemMap)
_MemWrite($tMemMap, $ptrBuf)
_SendMessage($hWnd, $EM_REPLACESEL, $fCanUndo, $pMemory, 0, "wparam", "ptr")
_MemFree($tMemMap)
EndIf
Return True
EndFunc
Func _GUICtrlRichEdit_SetCharColor($hWnd, $iColor = Default)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
Local $tCharFormat = DllStructCreate($tagCHARFORMAT)
DllStructSetData($tCharFormat, 1, DllStructGetSize($tCharFormat))
If IsKeyword($iColor) Then
DllStructSetData($tCharFormat, 3, $CFE_AUTOCOLOR)
$iColor = 0
Else
If BitAnd($iColor, 0xff000000) Then Return SetError(1022, 0, False)
EndIf
DllStructSetData($tCharFormat, 2, $CFM_COLOR)
DllStructSetData($tCharFormat, 6, $iColor)
Local $ai = _GUICtrlRichEdit_GetSel($hWnd)
If $ai[0] = $ai[1] Then
Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $SCF_ALL, DllStructGetPtr($tCharFormat)) <> 0
Else
Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $SCF_SELECTION, DllStructGetPtr($tCharFormat)) <> 0
EndIf
EndFunc
Func _GUICtrlRichEdit_SetLimitOnText($hWnd, $iNewLimit)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
If Not __GCR_IsNumeric($iNewLimit, ">=0") Then Return SetError(102, 0, False)
If $iNewLimit < 65535 Then $iNewLimit = 0
_SendMessage($hWnd, $EM_EXLIMITTEXT, 0, $iNewLimit)
Return True
EndFunc
Func _GUICtrlRichEdit_SetSel($hWnd, $iAnchor, $iActive, $fHideSel = False)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
If Not __GCR_IsNumeric($iAnchor, ">=0,-1") Then Return SetError(102, 0, False)
If Not __GCR_IsNumeric($iActive, ">=0,-1") Then Return SetError(103, 0, False)
If Not IsBool($fHideSel) Then Return SetError(104, 0, False)
_SendMessage($hWnd, $EM_SETSEL, $iAnchor, $iActive)
If $fHideSel Then _SendMessage($hWnd, $EM_HIDESELECTION, $fHideSel)
_WinAPI_SetFocus($hWnd)
Return True
EndFunc
Func __GCR_Init()
$h_GUICtrlRTF_lib = DllCall("kernel32.dll", "ptr", "LoadLibraryW", "wstr", "MSFTEDIT.DLL")
If $h_GUICtrlRTF_lib[0] <> 0 Then
$_GRE_sRTFClassName = "RichEdit50W"
$_GRE_Version = 4.1
Else
$h_GUICtrlRTF_lib = DllCall("kernel32.dll", "ptr", "LoadLibraryW", "wstr", "RICHED20.DLL")
$_GRE_Version = FileGetVersion(@SystemDir & "\riched20.dll", "ProductVersion")
Switch $_GRE_Version
Case 3.0
$_GRE_sRTFClassName = "RichEdit20W"
Case 5.0
$_GRE_sRTFClassName = "RichEdit50W"
Case 6.0
$_GRE_sRTFClassName = "RichEdit60W"
EndSwitch
EndIf
$_GRE_CF_RTF = _ClipBoard_RegisterFormat("Rich Text Format")
$_GRE_CF_RETEXTOBJ = _ClipBoard_RegisterFormat("Rich Text Format with Objects")
EndFunc
Func __GCR_StreamFromFileCallback($hFile, $pBuf, $iBuflen, $ptrQbytes)
Local $tQbytes = DllStructCreate("long", $ptrQbytes)
DllStructSetData($tQbytes, 1, 0)
Local $tBuf = DllStructCreate("char[" & $iBuflen & "]", $pBuf)
Local $buf = FileRead($hFile, $iBuflen - 1)
If @error <> 0 Then Return 1
DllStructSetData($tBuf, 1, $buf)
DllStructSetData($tQbytes, 1, StringLen($buf))
Return 0
EndFunc
Func __GCR_StreamFromVarCallback($dwCookie, $pBuf, $iBuflen, $ptrQbytes)
#forceref $dwCookie
Local $tQbytes = DllStructCreate("long", $ptrQbytes)
DllStructSetData($tQbytes, 1, 0)
Local $tCtl = DllStructCreate("char[" & $iBuflen & "]", $pBuf)
Local $sCtl = StringLeft($_GRC_sStreamVar, $iBuflen - 1)
If $sCtl = "" Then Return 1
DllStructSetData($tCtl, 1, $sCtl)
Local $iLen = StringLen($sCtl)
DllStructSetData($tQbytes, 1, $iLen)
$_GRC_sStreamVar = StringMid($_GRC_sStreamVar, $iLen + 1)
Return 0
EndFunc
Func __GCR_StreamToFileCallback($hFile, $pBuf, $iBuflen, $ptrQbytes)
Local $tQbytes = DllStructCreate("long", $ptrQbytes)
DllStructSetData($tQbytes, 1, 0)
Local $tBuf = DllStructCreate("char[" & $iBuflen & "]", $pBuf)
Local $s = DllStructGetData($tBuf, 1)
FileWrite($hFile, $s)
DllStructSetData($tQbytes, 1, StringLen($s))
Return 0
EndFunc
Func __GCR_StreamToVarCallback($dwCookie, $pBuf, $iBuflen, $ptrQbytes)
$dwCookie = $dwCookie
Local $tQbytes = DllStructCreate("long", $ptrQbytes)
DllStructSetData($tQbytes, 1, 0)
Local $tBuf = DllStructCreate("char[" & $iBuflen & "]", $pBuf)
Local $s = DllStructGetData($tBuf, 1)
$_GRC_sStreamVar &= $s
Return 0
EndFunc
Func __GCR_IsNumeric($vN, $sRange = "")
If Not(IsNumber($vN) Or StringIsInt($vN) Or StringIsFloat($vN)) Then Return False
Switch $sRange
Case ">0"
If $vN <= 0 Then Return False
Case ">=0"
If $vN < 0 Then Return False
Case ">0,-1"
If Not($vN > 0 Or $vN = -1) Then Return False
Case ">=0,-1"
If Not($vN >= 0 Or $vN = -1) Then Return False
EndSwitch
Return True
EndFunc
Func __GCR_SetOLECallback($hWnd)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
If Not $pObj_RichCom Then
$pCall_RichCom = DllStructCreate("ptr[20]")
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_QueryInterface), 1)
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_AddRef), 2)
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_Release), 3)
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_GetNewStorage), 4)
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_GetInPlaceContext), 5)
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_ShowContainerUI), 6)
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_QueryInsertObject), 7)
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_DeleteObject), 8)
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_QueryAcceptData), 9)
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_ContextSensitiveHelp), 10)
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_GetClipboardData), 11)
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_GetDragDropEffect), 12)
DllStructSetData($pCall_RichCom, 1, DllCallbackGetPtr($__RichCom_Object_GetContextMenu), 13)
DllStructSetData($pObj_RichComObject, 1, DllStructGetPtr($pCall_RichCom))
DllStructSetData($pObj_RichComObject, 2, 1)
$pObj_RichCom = DllStructGetPtr($pObj_RichComObject)
EndIf
Local Const $EM_SETOLECALLBACK = 0x400 + 70
If _SendMessage($hWnd, $EM_SETOLECALLBACK, 0, $pObj_RichCom) = 0 Then Return SetError(700, 0, False)
Return True
EndFunc
Func __RichCom_Object_QueryInterface($pObject, $REFIID, $ppvObj)
#forceref $pObject, $REFIID, $ppvObj
Return $_GCR_S_OK
EndFunc
Func __RichCom_Object_AddRef($pObject)
Local $data = DllStructCreate("ptr;dword", $pObject)
DllStructSetData($data, 2, DllStructGetData($data, 2) + 1)
Return DllStructGetData($data, 2)
EndFunc
Func __RichCom_Object_Release($pObject)
Local $data = DllStructCreate("ptr;dword", $pObject)
If DllStructGetData($data, 2) > 0 Then
DllStructSetData($data, 2, DllStructGetData($data, 2) - 1)
Return DllStructGetData($data, 2)
EndIf
EndFunc
Func __RichCom_Object_GetInPlaceContext($pObject, $lplpFrame, $lplpDoc, $lpFrameInfo)
#forceref $pObject, $lplpFrame, $lplpDoc, $lpFrameInfo
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_ShowContainerUI($pObject, $fShow)
#forceref $pObject, $fShow
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_QueryInsertObject($pObject, $lpclsid, $lpstg, $cp)
#forceref $pObject, $lpclsid, $lpstg, $cp
Return $_GCR_S_OK
EndFunc
Func __RichCom_Object_DeleteObject($pObject, $lpoleobj)
#forceref $pObject, $lpoleobj
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_QueryAcceptData($pObject, $lpdataobj, $lpcfFormat, $reco, $fReally, $hMetaPict)
#forceref $pObject, $lpdataobj, $lpcfFormat, $reco, $fReally, $hMetaPict
Return $_GCR_S_OK
EndFunc
Func __RichCom_Object_ContextSensitiveHelp($pObject, $fEnterMode)
#forceref $pObject, $fEnterMode
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_GetClipboardData($pObject, $lpchrg, $reco, $lplpdataobj)
#forceref $pObject, $lpchrg, $reco, $lplpdataobj
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_GetDragDropEffect($pObject, $fDrag, $grfKeyState, $pdwEffect)
#forceref $pObject, $fDrag, $grfKeyState, $pdwEffect
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_GetContextMenu($pObject, $seltype, $lpoleobj, $lpchrg, $lphmenu)
#forceref $pObject, $seltype, $lpoleobj, $lpchrg, $lphmenu
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_GetNewStorage($pObject, $lplpstg)
#forceref $pObject
Local $sc = DllCall($hLib_RichCom_OLE32, "dword", "CreateILockBytesOnHGlobal", "hwnd", 0, "int", 1, "ptr*", 0)
Local $lpLockBytes = $sc[3]
$sc = $sc[0]
If $sc Then Return $sc
$sc = DllCall($hLib_RichCom_OLE32, "dword", "StgCreateDocfileOnILockBytes", "ptr", $lpLockBytes, "dword", BitOR(0x10, 2, 0x1000), "dword", 0, "ptr*", 0)
Local $lpstg = DllStructCreate("ptr", $lplpstg)
DllStructSetData($lpstg, 1, $sc[4])
$sc = $sc[0]
If $sc Then
Local $obj = DllStructCreate("ptr", $lpLockBytes)
Local $iUnknownFuncTable = DllStructCreate("ptr[3]", DllStructGetData($obj, 1))
Local $lpReleaseFunc = DllStructGetData($iUnknownFuncTable, 3)
Call("MemoryFuncCall" & "", "long", $lpReleaseFunc, "ptr", $lpLockBytes)
If @error = 1 Then ConsoleWrite("!> Needs MemoryDLL.au3 for correct release of ILockBytes" & @CRLF)
EndIf
Return $sc
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\GuiRichEdit.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\ButtonConstants.au3
Global Const $BS_ICON = 0x0040
; #######  End Include source C:\Program Files\AutoIt3\include\ButtonConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\StaticConstants.au3
Global Const $SS_CENTER = 0x1
Global Const $SS_ETCHEDFRAME = 0x12
Global Const $SS_CENTERIMAGE = 0x0200
; #######  End Include source C:\Program Files\AutoIt3\include\StaticConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\WindowsConstants.au3
Global Const $WS_MAXIMIZEBOX = 0x00010000
Global Const $WS_MINIMIZEBOX = 0x00020000
Global Const $WS_TABSTOP = 0x00010000
Global Const $WS_GROUP = 0x00020000
Global Const $WS_SYSMENU = 0x00080000
Global Const $WS_HSCROLL = 0x00100000
Global Const $WS_VSCROLL = 0x00200000
Global Const $WS_BORDER = 0x00800000
Global Const $WS_CAPTION = 0x00C00000
Global Const $WS_CLIPSIBLINGS = 0x04000000
Global Const $WS_POPUP = 0x80000000
Global Const $WS_POPUPWINDOW = 0x80880000
Global Const $WM_SIZE = 0x05
Global Const $WM_NOTIFY = 0x004E
Global Const $WM_COMMAND = 0x0111
Global Const $NM_FIRST = 0
Global Const $NM_DBLCLK = $NM_FIRST - 3
Global Const $NM_RCLICK = $NM_FIRST - 5
Global Const $GUI_SS_DEFAULT_GUI = BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU)
; #######  End Include source C:\Program Files\AutoIt3\include\WindowsConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\GUIConstantsEx.au3
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_EVENT_RESTORE = -5
Global Const $GUI_EVENT_MAXIMIZE = -6
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128
; #######  End Include source C:\Program Files\AutoIt3\include\GUIConstantsEx.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\GUIComboBox.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\DirConstants.au3
; #######  End Include source C:\Program Files\AutoIt3\include\DirConstants.au3
; #######  End Include source C:\Program Files\AutoIt3\include\GUIComboBox.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\array.au3
Func _ArrayAdd(ByRef $avArray, $vValue)
If Not IsArray($avArray) Then Return SetError(1, 0, -1)
If UBound($avArray, 0) <> 1 Then Return SetError(2, 0, -1)
Local $iUBound = UBound($avArray)
ReDim $avArray[$iUBound + 1]
$avArray[$iUBound] = $vValue
Return $iUBound
EndFunc
Func _ArrayDelete(ByRef $avArray, $iElement)
If Not IsArray($avArray) Then Return SetError(1, 0, 0)
Local $iUBound = UBound($avArray, 1) - 1
If Not $iUBound Then
$avArray = ""
Return 0
EndIf
If $iElement < 0 Then $iElement = 0
If $iElement > $iUBound Then $iElement = $iUBound
Switch UBound($avArray, 0)
Case 1
For $i = $iElement To $iUBound - 1
$avArray[$i] = $avArray[$i + 1]
Next
ReDim $avArray[$iUBound]
Case 2
Local $iSubMax = UBound($avArray, 2) - 1
For $i = $iElement To $iUBound - 1
For $j = 0 To $iSubMax
$avArray[$i][$j] = $avArray[$i + 1][$j]
Next
Next
ReDim $avArray[$iUBound][$iSubMax + 1]
Case Else
Return SetError(3, 0, 0)
EndSwitch
Return $iUBound
EndFunc
Func _ArraySearch(Const ByRef $avArray, $vValue, $iStart = 0, $iEnd = 0, $iCase = 0, $iPartial = 0, $iForward = 1, $iSubItem = -1)
If Not IsArray($avArray) Then Return SetError(1, 0, -1)
If UBound($avArray, 0) > 2 Or UBound($avArray, 0) < 1 Then Return SetError(2, 0, -1)
Local $iUBound = UBound($avArray) - 1
If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(4, 0, -1)
Local $iStep = 1
If Not $iForward Then
Local $iTmp = $iStart
$iStart = $iEnd
$iEnd = $iTmp
$iStep = -1
EndIf
Switch UBound($avArray, 0)
Case 1
If Not $iPartial Then
If Not $iCase Then
For $i = $iStart To $iEnd Step $iStep
If $avArray[$i] = $vValue Then Return $i
Next
Else
For $i = $iStart To $iEnd Step $iStep
If $avArray[$i] == $vValue Then Return $i
Next
EndIf
Else
For $i = $iStart To $iEnd Step $iStep
If StringInStr($avArray[$i], $vValue, $iCase) > 0 Then Return $i
Next
EndIf
Case 2
Local $iUBoundSub = UBound($avArray, 2) - 1
If $iSubItem > $iUBoundSub Then $iSubItem = $iUBoundSub
If $iSubItem < 0 Then
$iSubItem = 0
Else
$iUBoundSub = $iSubItem
EndIf
For $j = $iSubItem To $iUBoundSub
If Not $iPartial Then
If Not $iCase Then
For $i = $iStart To $iEnd Step $iStep
If $avArray[$i][$j] = $vValue Then Return $i
Next
Else
For $i = $iStart To $iEnd Step $iStep
If $avArray[$i][$j] == $vValue Then Return $i
Next
EndIf
Else
For $i = $iStart To $iEnd Step $iStep
If StringInStr($avArray[$i][$j], $vValue, $iCase) > 0 Then Return $i
Next
EndIf
Next
Case Else
Return SetError(7, 0, -1)
EndSwitch
Return SetError(6, 0, -1)
EndFunc
Func _ArrayToString(Const ByRef $avArray, $sDelim = "|", $iStart = 0, $iEnd = 0)
If Not IsArray($avArray) Then Return SetError(1, 0, "")
If UBound($avArray, 0) <> 1 Then Return SetError(3, 0, "")
Local $sResult, $iUBound = UBound($avArray) - 1
If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(2, 0, "")
For $i = $iStart To $iEnd
$sResult &= $avArray[$i] & $sDelim
Next
Return StringTrimRight($sResult, StringLen($sDelim))
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\array.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\file.au3
Func _FileCreate($sFilePath)
Local $hOpenFile = FileOpen($sFilePath, $FO_OVERWRITE)
If $hOpenFile = -1 Then Return SetError(1, 0, 0 )
Local $hWriteFile = FileWrite($hOpenFile, "")
FileClose($hOpenFile)
If $hWriteFile = -1 Then Return SetError(2, 0, 0 )
Return 1
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\file.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\GUIListView.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\ListViewConstants.au3
Global Const $LVS_SHOWSELALWAYS = 0x0008
Global Const $LV_ERR = -1
Global Const $LVCF_ALLDATA = 0X0000003F
Global Const $LVCF_FMT = 0x0001
Global Const $LVCF_IMAGE = 0x0010
Global Const $LVCFMT_JUSTIFYMASK = 0x0003
Global Const $LVCF_TEXT = 0x0004
Global Const $LVCF_WIDTH = 0x0002
Global Const $LVCFMT_BITMAP_ON_RIGHT = 0x1000
Global Const $LVCFMT_CENTER = 0x0002
Global Const $LVCFMT_COL_HAS_IMAGES = 0x8000
Global Const $LVCFMT_IMAGE = 0x0800
Global Const $LVCFMT_LEFT = 0x0000
Global Const $LVCFMT_RIGHT = 0x0001
Global Const $LVFI_STRING = 0x0002
Global Const $LVHT_ONITEMICON = 0x00000002
Global Const $LVHT_ONITEMLABEL = 0x00000004
Global Const $LVHT_ONITEMSTATEICON = 0x00000008
Global Const $LVHT_ONITEM = BitOR($LVHT_ONITEMICON, $LVHT_ONITEMLABEL, $LVHT_ONITEMSTATEICON)
Global Const $LVIF_GROUPID = 0x00000100
Global Const $LVIF_IMAGE = 0x00000002
Global Const $LVIF_INDENT = 0x00000010
Global Const $LVIF_PARAM = 0x00000004
Global Const $LVIF_STATE = 0x00000008
Global Const $LVIF_TEXT = 0x00000001
Global Const $LVIS_CUT = 0x0004
Global Const $LVIS_DROPHILITED = 0x0008
Global Const $LVIS_FOCUSED = 0x0001
Global Const $LVIS_OVERLAYMASK = 0x0F00
Global Const $LVIS_SELECTED = 0x0002
Global Const $LVIS_STATEIMAGEMASK = 0xF000
Global Const $LVM_FIRST = 0x1000
Global Const $LVM_DELETEALLITEMS =($LVM_FIRST + 9)
Global Const $LVM_DELETECOLUMN =($LVM_FIRST + 28)
Global Const $LVM_DELETEITEM =($LVM_FIRST + 8)
Global Const $LVM_FINDITEM =($LVM_FIRST + 13)
Global Const $LVM_GETCOLUMNA =($LVM_FIRST + 25)
Global Const $LVM_GETCOLUMNW =($LVM_FIRST + 95)
Global Const $LVM_GETHEADER =($LVM_FIRST + 31)
Global Const $LVM_GETITEMA =($LVM_FIRST + 5)
Global Const $LVM_GETITEMW =($LVM_FIRST + 75)
Global Const $LVM_GETITEMCOUNT =($LVM_FIRST + 4)
Global Const $LVM_GETITEMSTATE =($LVM_FIRST + 44)
Global Const $LVM_GETITEMTEXTA =($LVM_FIRST + 45)
Global Const $LVM_GETITEMTEXTW =($LVM_FIRST + 115)
Global Const $LVM_GETSELECTEDCOUNT =($LVM_FIRST + 50)
Global Const $LVM_GETUNICODEFORMAT = 0x2000 + 6
Global Const $LVM_INSERTCOLUMNA =($LVM_FIRST + 27)
Global Const $LVM_INSERTCOLUMNW =($LVM_FIRST + 97)
Global Const $LVM_INSERTITEMA =($LVM_FIRST + 7)
Global Const $LVM_INSERTITEMW =($LVM_FIRST + 77)
Global Const $LVM_SETCOLUMNA =($LVM_FIRST + 26)
Global Const $LVM_SETCOLUMNW =($LVM_FIRST + 96)
Global Const $LVM_SETCOLUMNWIDTH =($LVM_FIRST + 30)
Global Const $LVM_SETIMAGELIST =($LVM_FIRST + 3)
Global Const $LVM_SETITEMA =($LVM_FIRST + 6)
Global Const $LVM_SETITEMW =($LVM_FIRST + 76)
Global Const $LVM_SETITEMSTATE =($LVM_FIRST + 43)
Global Const $LVN_FIRST = -100
Global Const $LVN_KEYDOWN =($LVN_FIRST - 55)
Global Const $LVSIL_NORMAL = 0
Global Const $LVSIL_SMALL = 1
Global Const $LVSIL_STATE = 2
; #######  End Include source C:\Program Files\AutoIt3\include\ListViewConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\GuiHeader.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\HeaderConstants.au3
; #######  End Include source C:\Program Files\AutoIt3\include\HeaderConstants.au3
; #######  End Include source C:\Program Files\AutoIt3\include\GuiHeader.au3
Global $_lv_ghLastWnd
Global $Debug_LV = False
Global Const $__LISTVIEWCONSTANT_ClassName = "SysListView32"
Global Const $__LISTVIEWCONSTANT_WM_SETREDRAW = 0x000B
Global Const $tagLVCOLUMN = "uint Mask;int Fmt;int CX;ptr Text;int TextMax;int SubItem;int Image;int Order"
Func _GUICtrlListView_AddColumn($hWnd, $sText, $iWidth = 50, $iAlign = -1, $iImage = -1, $fOnRight = False)
Return _GUICtrlListView_InsertColumn($hWnd, _GUICtrlListView_GetColumnCount($hWnd), $sText, $iWidth, $iAlign, $iImage, $fOnRight)
EndFunc
Func _GUICtrlListView_AddItem($hWnd, $sText, $iImage = -1, $iParam = 0)
Return _GUICtrlListView_InsertItem($hWnd, $sText, -1, $iImage, $iParam)
EndFunc
Func _GUICtrlListView_AddSubItem($hWnd, $iIndex, $sText, $iSubItem, $iImage = -1)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $fUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $iBuffer = StringLen($sText) + 1
Local $tBuffer
If $fUnicode Then
$tBuffer = DllStructCreate("wchar Text[" & $iBuffer & "]")
$iBuffer *= 2
Else
$tBuffer = DllStructCreate("char Text[" & $iBuffer & "]")
EndIf
Local $pBuffer = DllStructGetPtr($tBuffer)
Local $tItem = DllStructCreate($tagLVITEM)
Local $pItem = DllStructGetPtr($tItem)
Local $iMask = $LVIF_TEXT
If $iImage <> -1 Then $iMask = BitOR($iMask, $LVIF_IMAGE)
DllStructSetData($tBuffer, "Text", $sText)
DllStructSetData($tItem, "Mask", $iMask)
DllStructSetData($tItem, "Item", $iIndex)
DllStructSetData($tItem, "SubItem", $iSubItem)
DllStructSetData($tItem, "Image", $iImage)
Local $iRet
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $_lv_ghLastWnd) Then
DllStructSetData($tItem, "Text", $pBuffer)
$iRet = _SendMessage($hWnd, $LVM_SETITEMW, 0, $pItem, 0, "wparam", "ptr")
Else
Local $iItem = DllStructGetSize($tItem)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iItem + $iBuffer, $tMemMap)
Local $pText = $pMemory + $iItem
DllStructSetData($tItem, "Text", $pText)
_MemWrite($tMemMap, $pItem, $pMemory, $iItem)
_MemWrite($tMemMap, $pBuffer, $pText, $iBuffer)
If $fUnicode Then
$iRet = _SendMessage($hWnd, $LVM_SETITEMW, 0, $pMemory, 0, "wparam", "ptr")
Else
$iRet = _SendMessage($hWnd, $LVM_SETITEMA, 0, $pMemory, 0, "wparam", "ptr")
EndIf
_MemFree($tMemMap)
EndIf
Else
DllStructSetData($tItem, "Text", $pBuffer)
If $fUnicode Then
$iRet = GUICtrlSendMsg($hWnd, $LVM_SETITEMW, 0, $pItem)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_SETITEMA, 0, $pItem)
EndIf
EndIf
Return $iRet <> 0
EndFunc
Func _GUICtrlListView_BeginUpdate($hWnd)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Return _SendMessage($hWnd, $__LISTVIEWCONSTANT_WM_SETREDRAW) = 0
EndFunc
Func _GUICtrlListView_DeleteAllItems($hWnd)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
If _GUICtrlListView_GetItemCount($hWnd) == 0 Then Return True
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_DELETEALLITEMS) <> 0
Else
Local $ctrlID
For $index = _GUICtrlListView_GetItemCount($hWnd) - 1 To 0 Step -1
$ctrlID = _GUICtrlListView_GetItemParam($hWnd, $index)
If $ctrlID Then GUICtrlDelete($ctrlID)
Next
If _GUICtrlListView_GetItemCount($hWnd) == 0 Then Return True
EndIf
Return False
EndFunc
Func _GUICtrlListView_DeleteColumn($hWnd, $iCol)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_DELETECOLUMN, $iCol) <> 0
Else
Return GUICtrlSendMsg($hWnd, $LVM_DELETECOLUMN, $iCol, 0) <> 0
EndIf
EndFunc
Func _GUICtrlListView_DeleteItem($hWnd, $iIndex)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_DELETEITEM, $iIndex) <> 0
Else
Local $ctrlID = _GUICtrlListView_GetItemParam($hWnd, $iIndex)
If $ctrlID Then Return GUICtrlDelete($ctrlID) <> 0
EndIf
Return False
EndFunc
Func _GUICtrlListView_DeleteItemsSelected($hWnd)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $ItemCount = _GUICtrlListView_GetItemCount($hWnd)
If(_GUICtrlListView_GetSelectedCount($hWnd) == $ItemCount) Then
Return _GUICtrlListView_DeleteAllItems($hWnd)
Else
Local $items = _GUICtrlListView_GetSelectedIndices($hWnd, 1)
If Not IsArray($items) Then Return SetError($LV_ERR, $LV_ERR, 0)
_GUICtrlListView_SetItemSelected($hWnd, -1, False)
For $i = $items[0] To 1 Step -1
If Not _GUICtrlListView_DeleteItem($hWnd, $items[$i]) Then Return False
Next
Return True
EndIf
EndFunc
Func _GUICtrlListView_EndUpdate($hWnd)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Return _SendMessage($hWnd, $__LISTVIEWCONSTANT_WM_SETREDRAW, 1) = 0
EndFunc
Func _GUICtrlListView_FindItem($hWnd, $iStart, ByRef $tFindInfo, $sText = "")
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $iBuffer = StringLen($sText) + 1
Local $tBuffer = DllStructCreate("char Text[" & $iBuffer & "]")
Local $pBuffer = DllStructGetPtr($tBuffer)
Local $pFindInfo = DllStructGetPtr($tFindInfo)
DllStructSetData($tBuffer, "Text", $sText)
Local $iRet
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $_lv_ghLastWnd) Then
DllStructSetData($tFindInfo, "Text", $pBuffer)
$iRet = _SendMessage($hWnd, $LVM_FINDITEM, $iStart, $pFindInfo, 0, "wparam", "ptr")
Else
Local $iFindInfo = DllStructGetSize($tFindInfo)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iFindInfo + $iBuffer, $tMemMap)
Local $pText = $pMemory + $iFindInfo
DllStructSetData($tFindInfo, "Text", $pText)
_MemWrite($tMemMap, $pFindInfo, $pMemory, $iFindInfo)
_MemWrite($tMemMap, $pBuffer, $pText, $iBuffer)
$iRet = _SendMessage($hWnd, $LVM_FINDITEM, $iStart, $pMemory, 0, "wparam", "ptr")
_MemFree($tMemMap)
EndIf
Else
DllStructSetData($tFindInfo, "Text", $pBuffer)
$iRet = GUICtrlSendMsg($hWnd, $LVM_FINDITEM, $iStart, $pFindInfo)
EndIf
Return $iRet
EndFunc
Func _GUICtrlListView_GetColumn($hWnd, $iIndex)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $fUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $tBuffer
If $fUnicode Then
$tBuffer = DllStructCreate("wchar Text[4096]")
Else
$tBuffer = DllStructCreate("char Text[4096]")
EndIf
Local $pBuffer = DllStructGetPtr($tBuffer)
Local $tColumn = DllStructCreate($tagLVCOLUMN)
Local $pColumn = DllStructGetPtr($tColumn)
DllStructSetData($tColumn, "Mask", $LVCF_ALLDATA)
DllStructSetData($tColumn, "TextMax", 4096)
Local $iRet
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $_lv_ghLastWnd) Then
DllStructSetData($tColumn, "Text", $pBuffer)
$iRet = _SendMessage($hWnd, $LVM_GETCOLUMNW, $iIndex, $pColumn, 0, "wparam", "ptr")
Else
Local $iBuffer = DllStructGetSize($tBuffer)
Local $iColumn = DllStructGetSize($tColumn)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iColumn + $iBuffer, $tMemMap)
Local $pText = $pMemory + $iColumn
DllStructSetData($tColumn, "Text", $pText)
_MemWrite($tMemMap, $pColumn, $pMemory, $iColumn)
If $fUnicode Then
$iRet = _SendMessage($hWnd, $LVM_GETCOLUMNW, $iIndex, $pMemory, 0, "wparam", "ptr")
Else
$iRet = _SendMessage($hWnd, $LVM_GETCOLUMNA, $iIndex, $pMemory, 0, "wparam", "ptr")
EndIf
_MemRead($tMemMap, $pMemory, $pColumn, $iColumn)
_MemRead($tMemMap, $pText, $pBuffer, $iBuffer)
_MemFree($tMemMap)
EndIf
Else
DllStructSetData($tColumn, "Text", $pBuffer)
If $fUnicode Then
$iRet = GUICtrlSendMsg($hWnd, $LVM_GETCOLUMNW, $iIndex, $pColumn)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_GETCOLUMNA, $iIndex, $pColumn)
EndIf
EndIf
Local $aColumn[9]
Switch BitAND(DllStructGetData($tColumn, "Fmt"), $LVCFMT_JUSTIFYMASK)
Case $LVCFMT_RIGHT
$aColumn[0] = 1
Case $LVCFMT_CENTER
$aColumn[0] = 2
Case Else
$aColumn[0] = 0
EndSwitch
$aColumn[1] = BitAND(DllStructGetData($tColumn, "Fmt"), $LVCFMT_IMAGE) <> 0
$aColumn[2] = BitAND(DllStructGetData($tColumn, "Fmt"), $LVCFMT_BITMAP_ON_RIGHT) <> 0
$aColumn[3] = BitAND(DllStructGetData($tColumn, "Fmt"), $LVCFMT_COL_HAS_IMAGES) <> 0
$aColumn[4] = DllStructGetData($tColumn, "CX")
$aColumn[5] = DllStructGetData($tBuffer, "Text")
$aColumn[6] = DllStructGetData($tColumn, "SubItem")
$aColumn[7] = DllStructGetData($tColumn, "Image")
$aColumn[8] = DllStructGetData($tColumn, "Order")
Return SetError($iRet = 0, 0, $aColumn)
EndFunc
Func _GUICtrlListView_GetColumnCount($hWnd)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Return _SendMessage(_GUICtrlListView_GetHeader($hWnd), 0x1200)
EndFunc
Func _GUICtrlListView_GetHeader($hWnd)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_GETHEADER)
Else
Return GUICtrlSendMsg($hWnd, $LVM_GETHEADER, 0, 0)
EndIf
EndFunc
Func _GUICtrlListView_GetItem($hWnd, $iIndex, $iSubItem = 0)
Local $aItem[8]
Local $tItem = DllStructCreate($tagLVITEM)
DllStructSetData($tItem, "Mask", BitOR($LVIF_GROUPID, $LVIF_IMAGE, $LVIF_INDENT, $LVIF_PARAM, $LVIF_STATE))
DllStructSetData($tItem, "Item", $iIndex)
DllStructSetData($tItem, "SubItem", $iSubItem)
DllStructSetData($tItem, "StateMask", -1)
_GUICtrlListView_GetItemEx($hWnd, $tItem)
Local $iState = DllStructGetData($tItem, "State")
If BitAND($iState, $LVIS_CUT) <> 0 Then $aItem[0] = BitOR($aItem[0], 1)
If BitAND($iState, $LVIS_DROPHILITED) <> 0 Then $aItem[0] = BitOR($aItem[0], 2)
If BitAND($iState, $LVIS_FOCUSED) <> 0 Then $aItem[0] = BitOR($aItem[0], 4)
If BitAND($iState, $LVIS_SELECTED) <> 0 Then $aItem[0] = BitOR($aItem[0], 8)
$aItem[1] = __GUICtrlListView_OverlayImageMaskToIndex($iState)
$aItem[2] = __GUICtrlListView_StateImageMaskToIndex($iState)
$aItem[3] = _GUICtrlListView_GetItemText($hWnd, $iIndex, $iSubItem)
$aItem[4] = DllStructGetData($tItem, "Image")
$aItem[5] = DllStructGetData($tItem, "Param")
$aItem[6] = DllStructGetData($tItem, "Indent")
$aItem[7] = DllStructGetData($tItem, "GroupID")
Return $aItem
EndFunc
Func _GUICtrlListView_GetItemCount($hWnd)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_GETITEMCOUNT)
Else
Return GUICtrlSendMsg($hWnd, $LVM_GETITEMCOUNT, 0, 0)
EndIf
EndFunc
Func _GUICtrlListView_GetItemEx($hWnd, ByRef $tItem)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $fUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $pItem = DllStructGetPtr($tItem)
Local $iRet
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $_lv_ghLastWnd) Then
$iRet = _SendMessage($hWnd, $LVM_GETITEMW, 0, $pItem, 0, "wparam", "ptr")
Else
Local $iItem = DllStructGetSize($tItem)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iItem, $tMemMap)
_MemWrite($tMemMap, $pItem)
If $fUnicode Then
_SendMessage($hWnd, $LVM_GETITEMW, 0, $pMemory, 0, "wparam", "ptr")
Else
_SendMessage($hWnd, $LVM_GETITEMA, 0, $pMemory, 0, "wparam", "ptr")
EndIf
_MemRead($tMemMap, $pMemory, $pItem, $iItem)
_MemFree($tMemMap)
EndIf
Else
If $fUnicode Then
$iRet = GUICtrlSendMsg($hWnd, $LVM_GETITEMW, 0, $pItem)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_GETITEMA, 0, $pItem)
EndIf
EndIf
Return $iRet <> 0
EndFunc
Func _GUICtrlListView_GetItemImage($hWnd, $iIndex, $iSubItem = 0)
Local $tItem = DllStructCreate($tagLVITEM)
DllStructSetData($tItem, "Mask", $LVIF_IMAGE)
DllStructSetData($tItem, "Item", $iIndex)
DllStructSetData($tItem, "SubItem", $iSubItem)
_GUICtrlListView_GetItemEx($hWnd, $tItem)
Return DllStructGetData($tItem, "Image")
EndFunc
Func _GUICtrlListView_GetItemParam($hWnd, $iIndex)
Local $tItem = DllStructCreate($tagLVITEM)
DllStructSetData($tItem, "Mask", $LVIF_PARAM)
DllStructSetData($tItem, "Item", $iIndex)
_GUICtrlListView_GetItemEx($hWnd, $tItem)
Return DllStructGetData($tItem, "Param")
EndFunc
Func _GUICtrlListView_GetItemText($hWnd, $iIndex, $iSubItem = 0)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $fUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $tBuffer
If $fUnicode Then
$tBuffer = DllStructCreate("wchar Text[4096]")
Else
$tBuffer = DllStructCreate("char Text[4096]")
EndIf
Local $pBuffer = DllStructGetPtr($tBuffer)
Local $tItem = DllStructCreate($tagLVITEM)
Local $pItem = DllStructGetPtr($tItem)
DllStructSetData($tItem, "SubItem", $iSubItem)
DllStructSetData($tItem, "TextMax", 4096)
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $_lv_ghLastWnd) Then
DllStructSetData($tItem, "Text", $pBuffer)
_SendMessage($hWnd, $LVM_GETITEMTEXTW, $iIndex, $pItem, 0, "wparam", "ptr")
Else
Local $iItem = DllStructGetSize($tItem)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iItem + 4096, $tMemMap)
Local $pText = $pMemory + $iItem
DllStructSetData($tItem, "Text", $pText)
_MemWrite($tMemMap, $pItem, $pMemory, $iItem)
If $fUnicode Then
_SendMessage($hWnd, $LVM_GETITEMTEXTW, $iIndex, $pMemory, 0, "wparam", "ptr")
Else
_SendMessage($hWnd, $LVM_GETITEMTEXTA, $iIndex, $pMemory, 0, "wparam", "ptr")
EndIf
_MemRead($tMemMap, $pText, $pBuffer, 4096)
_MemFree($tMemMap)
EndIf
Else
DllStructSetData($tItem, "Text", $pBuffer)
If $fUnicode Then
GUICtrlSendMsg($hWnd, $LVM_GETITEMTEXTW, $iIndex, $pItem)
Else
GUICtrlSendMsg($hWnd, $LVM_GETITEMTEXTA, $iIndex, $pItem)
EndIf
EndIf
Return DllStructGetData($tBuffer, "Text")
EndFunc
Func _GUICtrlListView_GetSelectedCount($hWnd)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_GETSELECTEDCOUNT)
Else
Return GUICtrlSendMsg($hWnd, $LVM_GETSELECTEDCOUNT, 0, 0)
EndIf
EndFunc
Func _GUICtrlListView_GetSelectedIndices($hWnd, $fArray = False)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $sIndices, $aIndices[1] = [0]
Local $iRet, $iCount = _GUICtrlListView_GetItemCount($hWnd)
For $iItem = 0 To $iCount
If IsHWnd($hWnd) Then
$iRet = _SendMessage($hWnd, $LVM_GETITEMSTATE, $iItem, $LVIS_SELECTED)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_GETITEMSTATE, $iItem, $LVIS_SELECTED)
EndIf
If $iRet Then
If(Not $fArray) Then
If StringLen($sIndices) Then
$sIndices &= "|" & $iItem
Else
$sIndices = $iItem
EndIf
Else
ReDim $aIndices[UBound($aIndices) + 1]
$aIndices[0] = UBound($aIndices) - 1
$aIndices[UBound($aIndices) - 1] = $iItem
EndIf
EndIf
Next
If(Not $fArray) Then
Return String($sIndices)
Else
Return $aIndices
EndIf
EndFunc
Func _GUICtrlListView_GetUnicodeFormat($hWnd)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_GETUNICODEFORMAT) <> 0
Else
Return GUICtrlSendMsg($hWnd, $LVM_GETUNICODEFORMAT, 0, 0) <> 0
EndIf
EndFunc
Func _GUICtrlListView_InsertColumn($hWnd, $iIndex, $sText, $iWidth = 50, $iAlign = -1, $iImage = -1, $fOnRight = False)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $aAlign[3] = [$LVCFMT_LEFT, $LVCFMT_RIGHT, $LVCFMT_CENTER]
Local $fUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $iBuffer = StringLen($sText) + 1
Local $tBuffer
If $fUnicode Then
$tBuffer = DllStructCreate("wchar Text[" & $iBuffer & "]")
$iBuffer *= 2
Else
$tBuffer = DllStructCreate("char Text[" & $iBuffer & "]")
EndIf
Local $pBuffer = DllStructGetPtr($tBuffer)
Local $tColumn = DllStructCreate($tagLVCOLUMN)
Local $pColumn = DllStructGetPtr($tColumn)
Local $iMask = BitOR($LVCF_FMT, $LVCF_WIDTH, $LVCF_TEXT)
If $iAlign < 0 Or $iAlign > 2 Then $iAlign = 0
Local $iFmt = $aAlign[$iAlign]
If $iImage <> -1 Then
$iMask = BitOR($iMask, $LVCF_IMAGE)
$iFmt = BitOR($iFmt, $LVCFMT_COL_HAS_IMAGES, $LVCFMT_IMAGE)
EndIf
If $fOnRight Then $iFmt = BitOR($iFmt, $LVCFMT_BITMAP_ON_RIGHT)
DllStructSetData($tBuffer, "Text", $sText)
DllStructSetData($tColumn, "Mask", $iMask)
DllStructSetData($tColumn, "Fmt", $iFmt)
DllStructSetData($tColumn, "CX", $iWidth)
DllStructSetData($tColumn, "TextMax", $iBuffer)
DllStructSetData($tColumn, "Image", $iImage)
Local $iRet
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $_lv_ghLastWnd) Then
DllStructSetData($tColumn, "Text", $pBuffer)
$iRet = _SendMessage($hWnd, $LVM_INSERTCOLUMNW, $iIndex, $pColumn, 0, "wparam", "ptr")
Else
Local $iColumn = DllStructGetSize($tColumn)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iColumn + $iBuffer, $tMemMap)
Local $pText = $pMemory + $iColumn
DllStructSetData($tColumn, "Text", $pText)
_MemWrite($tMemMap, $pColumn, $pMemory, $iColumn)
_MemWrite($tMemMap, $pBuffer, $pText, $iBuffer)
If $fUnicode Then
$iRet = _SendMessage($hWnd, $LVM_INSERTCOLUMNW, $iIndex, $pMemory, 0, "wparam", "ptr")
Else
$iRet = _SendMessage($hWnd, $LVM_INSERTCOLUMNA, $iIndex, $pMemory, 0, "wparam", "ptr")
EndIf
_MemFree($tMemMap)
EndIf
Else
DllStructSetData($tColumn, "Text", $pBuffer)
If $fUnicode Then
$iRet = GUICtrlSendMsg($hWnd, $LVM_INSERTCOLUMNW, $iIndex, $pColumn)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_INSERTCOLUMNA, $iIndex, $pColumn)
EndIf
EndIf
If $iAlign > 0 Then _GUICtrlListView_SetColumn($hWnd, $iRet, $sText, $iWidth, $iAlign, $iImage, $fOnRight)
Return $iRet
EndFunc
Func _GUICtrlListView_InsertItem($hWnd, $sText, $iIndex = -1, $iImage = -1, $iParam = 0)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $fUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $iBuffer, $pBuffer, $tBuffer, $iRet
If $iIndex = -1 Then $iIndex = 999999999
Local $tItem = DllStructCreate($tagLVITEM)
Local $pItem = DllStructGetPtr($tItem)
DllStructSetData($tItem, "Param", $iParam)
If $sText <> -1 Then
$iBuffer = StringLen($sText) + 1
If $fUnicode Then
$tBuffer = DllStructCreate("wchar Text[" & $iBuffer & "]")
$iBuffer *= 2
Else
$tBuffer = DllStructCreate("char Text[" & $iBuffer & "]")
EndIf
$pBuffer = DllStructGetPtr($tBuffer)
DllStructSetData($tBuffer, "Text", $sText)
DllStructSetData($tItem, "Text", $pBuffer)
DllStructSetData($tItem, "TextMax", $iBuffer)
Else
DllStructSetData($tItem, "Text", -1)
EndIf
Local $iMask = BitOR($LVIF_TEXT, $LVIF_PARAM)
If $iImage >= 0 Then $iMask = BitOR($iMask, $LVIF_IMAGE)
DllStructSetData($tItem, "Mask", $iMask)
DllStructSetData($tItem, "Item", $iIndex)
DllStructSetData($tItem, "Image", $iImage)
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $_lv_ghLastWnd) Or($sText = -1) Then
$iRet = _SendMessage($hWnd, $LVM_INSERTITEMW, 0, $pItem, 0, "wparam", "ptr")
Else
Local $iItem = DllStructGetSize($tItem)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iItem + $iBuffer, $tMemMap)
Local $pText = $pMemory + $iItem
DllStructSetData($tItem, "Text", $pText)
_MemWrite($tMemMap, $pItem, $pMemory, $iItem)
_MemWrite($tMemMap, $pBuffer, $pText, $iBuffer)
If $fUnicode Then
$iRet = _SendMessage($hWnd, $LVM_INSERTITEMW, 0, $pMemory, 0, "wparam", "ptr")
Else
$iRet = _SendMessage($hWnd, $LVM_INSERTITEMA, 0, $pMemory, 0, "wparam", "ptr")
EndIf
_MemFree($tMemMap)
EndIf
Else
If $fUnicode Then
$iRet = GUICtrlSendMsg($hWnd, $LVM_INSERTITEMW, 0, $pItem)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_INSERTITEMA, 0, $pItem)
EndIf
EndIf
Return $iRet
EndFunc
Func __GUICtrlListView_OverlayImageMaskToIndex($iMask)
Return BitShift(BitAND($LVIS_OVERLAYMASK, $iMask), 8)
EndFunc
Func _GUICtrlListView_SetColumn($hWnd, $iIndex, $sText, $iWidth = -1, $iAlign = -1, $iImage = -1, $fOnRight = False)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $fUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
Local $aAlign[3] = [$LVCFMT_LEFT, $LVCFMT_RIGHT, $LVCFMT_CENTER]
Local $iBuffer = StringLen($sText) + 1
Local $tBuffer
If $fUnicode Then
$tBuffer = DllStructCreate("wchar Text[" & $iBuffer & "]")
$iBuffer *= 2
Else
$tBuffer = DllStructCreate("char Text[" & $iBuffer & "]")
EndIf
Local $pBuffer = DllStructGetPtr($tBuffer)
Local $tColumn = DllStructCreate($tagLVCOLUMN)
Local $pColumn = DllStructGetPtr($tColumn)
Local $iMask = $LVCF_TEXT
If $iAlign < 0 Or $iAlign > 2 Then $iAlign = 0
$iMask = BitOR($iMask, $LVCF_FMT)
Local $iFmt = $aAlign[$iAlign]
If $iWidth <> -1 Then $iMask = BitOR($iMask, $LVCF_WIDTH)
If $iImage <> -1 Then
$iMask = BitOR($iMask, $LVCF_IMAGE)
$iFmt = BitOR($iFmt, $LVCFMT_COL_HAS_IMAGES, $LVCFMT_IMAGE)
Else
$iImage = 0
EndIf
If $fOnRight Then $iFmt = BitOR($iFmt, $LVCFMT_BITMAP_ON_RIGHT)
DllStructSetData($tBuffer, "Text", $sText)
DllStructSetData($tColumn, "Mask", $iMask)
DllStructSetData($tColumn, "Fmt", $iFmt)
DllStructSetData($tColumn, "CX", $iWidth)
DllStructSetData($tColumn, "TextMax", $iBuffer)
DllStructSetData($tColumn, "Image", $iImage)
Local $iRet
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $_lv_ghLastWnd) Then
DllStructSetData($tColumn, "Text", $pBuffer)
$iRet = _SendMessage($hWnd, $LVM_SETCOLUMNW, $iIndex, $pColumn, 0, "wparam", "ptr")
Else
Local $iColumn = DllStructGetSize($tColumn)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iColumn + $iBuffer, $tMemMap)
Local $pText = $pMemory + $iColumn
DllStructSetData($tColumn, "Text", $pText)
_MemWrite($tMemMap, $pColumn, $pMemory, $iColumn)
_MemWrite($tMemMap, $pBuffer, $pText, $iBuffer)
If $fUnicode Then
$iRet = _SendMessage($hWnd, $LVM_SETCOLUMNW, $iIndex, $pMemory, 0, "wparam", "ptr")
Else
$iRet = _SendMessage($hWnd, $LVM_SETCOLUMNA, $iIndex, $pMemory, 0, "wparam", "ptr")
EndIf
_MemFree($tMemMap)
EndIf
Else
DllStructSetData($tColumn, "Text", $pBuffer)
If $fUnicode Then
$iRet = GUICtrlSendMsg($hWnd, $LVM_SETCOLUMNW, $iIndex, $pColumn)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_SETCOLUMNA, $iIndex, $pColumn)
EndIf
EndIf
Return $iRet <> 0
EndFunc
Func _GUICtrlListView_SetColumnWidth($hWnd, $iCol, $iWidth)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_SETCOLUMNWIDTH, $iCol, $iWidth)
Else
Return GUICtrlSendMsg($hWnd, $LVM_SETCOLUMNWIDTH, $iCol, $iWidth)
EndIf
EndFunc
Func _GUICtrlListView_SetImageList($hWnd, $hHandle, $iType = 0)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $aType[3] = [$LVSIL_NORMAL, $LVSIL_SMALL, $LVSIL_STATE]
If IsHWnd($hWnd) Then
Return _SendMessage($hWnd, $LVM_SETIMAGELIST, $aType[$iType], $hHandle, 0, "wparam", "hwnd", "hwnd")
Else
Return GUICtrlSendMsg($hWnd, $LVM_SETIMAGELIST, $aType[$iType], $hHandle)
EndIf
EndFunc
Func _GUICtrlListView_SetItemSelected($hWnd, $iIndex, $fSelected = True, $fFocused = False)
If $Debug_LV Then __UDF_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
Local $tstruct = DllStructCreate($tagLVITEM)
Local $pItem = DllStructGetPtr($tstruct)
Local $iRet, $iSelected = 0, $iFocused = 0, $iSize, $tMemMap, $pMemory
If($fSelected = True) Then $iSelected = $LVIS_SELECTED
If($fFocused = True And $iIndex <> -1) Then $iFocused = $LVIS_FOCUSED
DllStructSetData($tstruct, "Mask", $LVIF_STATE)
DllStructSetData($tstruct, "Item", $iIndex)
DllStructSetData($tstruct, "State", BitOR($iSelected, $iFocused))
DllStructSetData($tstruct, "StateMask", BitOR($LVIS_SELECTED, $iFocused))
$iSize = DllStructGetSize($tstruct)
If IsHWnd($hWnd) Then
$pMemory = _MemInit($hWnd, $iSize, $tMemMap)
_MemWrite($tMemMap, $pItem, $pMemory, $iSize)
$iRet = _SendMessage($hWnd, $LVM_SETITEMSTATE, $iIndex, $pMemory)
_MemFree($tMemMap)
Else
$iRet = GUICtrlSendMsg($hWnd, $LVM_SETITEMSTATE, $iIndex, $pItem)
EndIf
Return $iRet <> 0
EndFunc
Func __GUICtrlListView_StateImageMaskToIndex($iMask)
Return BitShift(BitAND($iMask, $LVIS_STATEIMAGEMASK), 12)
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\GUIListView.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\FTPEx.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\Date.au3
Func _TicksToTime($iTicks, ByRef $iHours, ByRef $iMins, ByRef $iSecs)
If Number($iTicks) > 0 Then
$iTicks = Int($iTicks / 1000)
$iHours = Int($iTicks / 3600)
$iTicks = Mod($iTicks, 3600)
$iMins = Int($iTicks / 60)
$iSecs = Mod($iTicks, 60)
Return 1
ElseIf Number($iTicks) = 0 Then
$iHours = 0
$iTicks = 0
$iMins = 0
$iSecs = 0
Return 1
Else
Return SetError(1,0,0)
EndIf
EndFunc
Func _Date_Time_FileTimeToArray(ByRef $tFileTime)
If((DllStructGetData($tFileTime, 1) + DllStructGetData($tFileTime, 2)) = 0) Then Return SetError(1, 0, 0)
Local $tSystemTime = _Date_Time_FileTimeToSystemTime(DllStructGetPtr($tFileTime))
If @error Then Return SetError(@error, @extended, 0)
Return _Date_Time_SystemTimeToArray($tSystemTime)
EndFunc
Func _Date_Time_FileTimeToStr(ByRef $tFileTime, $bFmt = 0)
Local $aDate = _Date_Time_FileTimeToArray($tFileTime)
If @error Then Return SetError(@error, @extended, "")
If $bFmt Then
Return StringFormat("%04d/%02d/%02d %02d:%02d:%02d", $aDate[2], $aDate[1], $aDate[0], $aDate[3], $aDate[4], $aDate[5])
Else
Return StringFormat("%02d/%02d/%04d %02d:%02d:%02d", $aDate[0], $aDate[1], $aDate[2], $aDate[3], $aDate[4], $aDate[5])
EndIf
EndFunc
Func _Date_Time_FileTimeToSystemTime($pFileTime)
Local $tSystTime = DllStructCreate($tagSYSTEMTIME)
Local $aResult = DllCall("kernel32.dll", "bool", "FileTimeToSystemTime", "ptr", $pFileTime, "ptr", DllStructGetPtr($tSystTime))
If @error Then Return SetError(@error, @extended, 0)
Return SetExtended($aResult[0], $tSystTime)
EndFunc
Func _Date_Time_SystemTimeToArray(ByRef $tSystemTime)
Local $aInfo[8]
$aInfo[0] = DllStructGetData($tSystemTime, "Month")
$aInfo[1] = DllStructGetData($tSystemTime, "Day")
$aInfo[2] = DllStructGetData($tSystemTime, "Year")
$aInfo[3] = DllStructGetData($tSystemTime, "Hour")
$aInfo[4] = DllStructGetData($tSystemTime, "Minute")
$aInfo[5] = DllStructGetData($tSystemTime, "Second")
$aInfo[6] = DllStructGetData($tSystemTime, "MSeconds")
$aInfo[7] = DllStructGetData($tSystemTime, "DOW")
Return $aInfo
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\Date.au3
Global $__ghWinInet_FTP = -1
Global $__ghCallback_FTP, $__gbCallback_Set = False
Global Const $INTERNET_OPEN_TYPE_DIRECT = 1
Global Const $FTP_TRANSFER_TYPE_BINARY = 2
Global Const $INTERNET_FLAG_PASSIVE = 0x08000000
Global Const $INTERNET_FLAG_TRANSFER_BINARY = $FTP_TRANSFER_TYPE_BINARY
Global Const $INTERNET_SERVICE_FTP = 1
Global Const $INTERNET_FLAG_HYPERLINK = 0x00000400
Global Const $INTERNET_FLAG_NO_CACHE_WRITE = 0x04000000
Global Const $INTERNET_FLAG_RELOAD = 0x80000000
Global Const $INTERNET_STATUS_CLOSING_CONNECTION = 50
Global Const $INTERNET_STATUS_CONNECTION_CLOSED = 51
Global Const $INTERNET_STATUS_CONNECTING_TO_SERVER = 20
Global Const $INTERNET_STATUS_CONNECTED_TO_SERVER = 21
Global Const $INTERNET_STATUS_RESOLVING_NAME = 10
Global Const $INTERNET_STATUS_NAME_RESOLVED = 11
Func _FTP_Close($l_InternetSession)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_InternetCloseHandle = DllCall($__ghWinInet_FTP, 'bool', 'InternetCloseHandle', 'handle', $l_InternetSession)
If @error Or $ai_InternetCloseHandle[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), 0)
If $__gbCallback_Set = True Then DllCallbackFree($__ghCallback_FTP)
Return $ai_InternetCloseHandle[0]
EndFunc
Func _FTP_Connect($l_InternetSession, $s_ServerName, $s_Username, $s_Password, $i_Passive = 0, $i_ServerPort = 0, $l_Service = $INTERNET_SERVICE_FTP, $l_Flags = 0, $l_Context = 0)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
If $i_Passive == 1 Then $l_Flags = BitOR($l_Flags, $INTERNET_FLAG_PASSIVE)
Local $ai_InternetConnect = DllCall($__ghWinInet_FTP, 'hwnd', 'InternetConnectW', 'handle', $l_InternetSession, 'wstr', $s_ServerName, 'ushort', $i_ServerPort, 'wstr', $s_Username, 'wstr', $s_Password, 'dword', $l_Service, 'dword', $l_Flags, 'dword_ptr', $l_Context)
If @error Or $ai_InternetConnect[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError() ,0)
Return $ai_InternetConnect[0]
EndFunc
Func _FTP_DirCreate($l_FTPSession, $s_Remote)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_FTPMakeDir = DllCall($__ghWinInet_FTP, 'bool', 'FtpCreateDirectoryW', 'handle', $l_FTPSession, 'wstr', $s_Remote)
If @error Or $ai_FTPMakeDir[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), 0)
Return $ai_FTPMakeDir[0]
EndFunc
Func _FTP_DirDelete($l_FTPSession, $s_Remote)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_FTPDelDir = DllCall($__ghWinInet_FTP, 'bool', 'FtpRemoveDirectoryW', 'handle', $l_FTPSession, 'wstr', $s_Remote)
If @error Or $ai_FTPDelDir[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), 0)
Return $ai_FTPDelDir[0]
EndFunc
Func _FTP_DirGetCurrent($l_FTPSession)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_FTPGetCurrentDir = DllCall($__ghWinInet_FTP, 'bool', 'FtpGetCurrentDirectoryW', 'handle', $l_FTPSession, 'wstr', "", 'dword*', 260)
If @error Or $ai_FTPGetCurrentDir[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), 0)
Return $ai_FTPGetCurrentDir[2]
EndFunc
Func _FTP_DirSetCurrent($l_FTPSession, $s_Remote)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_FTPSetCurrentDir = DllCall($__ghWinInet_FTP, 'bool', 'FtpSetCurrentDirectoryW', 'handle', $l_FTPSession, 'wstr', $s_Remote)
If @error Or $ai_FTPSetCurrentDir[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), 0)
Return $ai_FTPSetCurrentDir[0]
EndFunc
Func _FTP_FileDelete($l_FTPSession, $s_RemoteFile)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_FTPPutFile = DllCall($__ghWinInet_FTP, 'bool', 'FtpDeleteFileW', 'handle', $l_FTPSession, 'wstr', $s_RemoteFile)
If @error Or $ai_FTPPutFile[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), 0)
Return $ai_FTPPutFile[0]
EndFunc
Func _FTP_FileGetSize($l_FTPSession, $s_FileName)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_FTPGetSizeHandle = DllCall($__ghWinInet_FTP, 'handle', 'FtpOpenFileW', 'handle', $l_FTPSession, 'wstr', $s_FileName, 'dword', $GENERIC_READ, 'dword', $INTERNET_FLAG_NO_CACHE_WRITE + $INTERNET_FLAG_TRANSFER_BINARY, 'dword_ptr', 0)
If @error Or $ai_FTPGetSizeHandle[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), 0)
Local $ai_FTPGetFileSize = DllCall($__ghWinInet_FTP, 'dword', 'FtpGetFileSize', 'handle', $ai_FTPGetSizeHandle[0], 'dword*', 0)
If @error Or $ai_FTPGetFileSize[0] = 0 Then
Local $lasterror = _WinAPI_GetLastError()
DllCall($__ghWinInet_FTP, 'bool', 'InternetCloseHandle', 'handle', $ai_FTPGetSizeHandle[0])
Return SetError(-1, $lasterror, 0)
EndIf
DllCall($__ghWinInet_FTP, 'bool', 'InternetCloseHandle', 'handle', $ai_FTPGetSizeHandle[0])
Return _WinAPI_MakeQWord($ai_FTPGetFileSize[0], $ai_FTPGetFileSize[2])
EndFunc
Func _FTP_FileRename($l_FTPSession, $s_Existing, $s_New)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_FTPRenameFile = DllCall($__ghWinInet_FTP, 'bool', 'FtpRenameFileW', 'handle', $l_FTPSession, 'wstr', $s_Existing, 'wstr', $s_New)
If @error Or $ai_FTPRenameFile[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), 0)
Return $ai_FTPRenameFile[0]
EndFunc
Func _FTP_FindFileClose($h_Handle)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_FTPPutFile = DllCall($__ghWinInet_FTP, 'bool', 'InternetCloseHandle', 'handle', $h_Handle)
If @error Or $ai_FTPPutFile[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), "")
Return $ai_FTPPutFile[0]
EndFunc
Func _FTP_FindFileFirst($l_FTPSession, $s_RemotePath, ByRef $h_Handle, $l_Flags = 0, $l_Context = 0)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $l_DllStruct = DllStructCreate($tagWIN32_FIND_DATA)
If @error Then Return SetError(-3, 0, "")
Local $a_FTPFileList[1]
$a_FTPFileList[0] = 0
Local $ai_FTPFirstFile = DllCall($__ghWinInet_FTP, 'handle', 'FtpFindFirstFileW', 'handle', $l_FTPSession, 'wstr', $s_RemotePath, 'ptr', DllStructGetPtr($l_DllStruct), 'dword', $l_Flags, 'dword_ptr', $l_Context)
If @error Or $ai_FTPFirstFile[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), $ai_FTPFirstFile)
$h_Handle = $ai_FTPFirstFile[0]
Local $a_FTPFileList[12]
$a_FTPFileList[0] = 11
$a_FTPFileList[1] = DllStructGetData($l_DllStruct, "dwFileAttributes")
$a_FTPFileList[2] = DllStructGetData($l_DllStruct, "ftCreationTime", 1)
$a_FTPFileList[3] = DllStructGetData($l_DllStruct, "ftCreationTime", 2)
$a_FTPFileList[4] = DllStructGetData($l_DllStruct, "ftLastAccessTime", 1)
$a_FTPFileList[5] = DllStructGetData($l_DllStruct, "ftLastAccessTime", 2)
$a_FTPFileList[6] = DllStructGetData($l_DllStruct, "ftLastWriteTime", 1)
$a_FTPFileList[7] = DllStructGetData($l_DllStruct, "ftLastWriteTime", 2)
$a_FTPFileList[8] = DllStructGetData($l_DllStruct, "nFileSizeHigh")
$a_FTPFileList[9] = DllStructGetData($l_DllStruct, "nFileSizeLow")
$a_FTPFileList[10] = DllStructGetData($l_DllStruct, "cFileName")
$a_FTPFileList[11] = DllStructGetData($l_DllStruct, "cAlternateFileName")
Return $a_FTPFileList
EndFunc
Func _FTP_FindFileNext($h_Handle)
Local $l_DllStruct = DllStructCreate($tagWIN32_FIND_DATA)
Local $a_FTPFileList[1]
$a_FTPFileList[0] = 0
Local $ai_FTPPutFile = DllCall($__ghWinInet_FTP, 'bool', 'InternetFindNextFileW', 'handle', $h_Handle, 'ptr', DllStructGetPtr($l_DllStruct))
If @error Or $ai_FTPPutFile[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), $a_FTPFileList)
Local $a_FTPFileList[12]
$a_FTPFileList[0] = 11
$a_FTPFileList[1] = DllStructGetData($l_DllStruct, "dwFileAttributes")
$a_FTPFileList[2] = DllStructGetData($l_DllStruct, "ftCreationTime", 1)
$a_FTPFileList[3] = DllStructGetData($l_DllStruct, "ftCreationTime", 2)
$a_FTPFileList[4] = DllStructGetData($l_DllStruct, "ftLastAccessTime", 1)
$a_FTPFileList[5] = DllStructGetData($l_DllStruct, "ftLastAccessTime", 2)
$a_FTPFileList[6] = DllStructGetData($l_DllStruct, "ftLastWriteTime", 1)
$a_FTPFileList[7] = DllStructGetData($l_DllStruct, "ftLastWriteTime", 2)
$a_FTPFileList[8] = DllStructGetData($l_DllStruct, "nFileSizeHigh")
$a_FTPFileList[9] = DllStructGetData($l_DllStruct, "nFileSizeLow")
$a_FTPFileList[10] = DllStructGetData($l_DllStruct, "cFileName")
$a_FTPFileList[11] = DllStructGetData($l_DllStruct, "cAlternateFileName")
Return $a_FTPFileList
EndFunc
Func _FTP_ListToArrayEx($l_FTPSession, $Return_Type = 0, $l_Flags = 0, $b_Fmt = 1, $l_Context = 0)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Return __FTP_ListToArray($l_FTPSession, $Return_Type, $l_Flags, $b_Fmt, 6, $l_Context)
EndFunc
Func _FTP_Open($s_Agent, $l_AccessType = $INTERNET_OPEN_TYPE_DIRECT, $s_ProxyName = '', $s_ProxyBypass = '', $l_Flags = 0)
If $__ghWinInet_FTP = -1 Then __FTP_Init()
Local $ai_InternetOpen = DllCall($__ghWinInet_FTP, 'handle', 'InternetOpenW', 'wstr', $s_Agent, 'dword', $l_AccessType, _
'wstr', $s_ProxyName, 'wstr', $s_ProxyBypass, 'dword', $l_Flags)
If @error Or $ai_InternetOpen[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), 0)
Return $ai_InternetOpen[0]
EndFunc
Func _FTP_SetStatusCallback($l_InternetSession, $sFunctionName)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $CallBack_Register = DllCallbackRegister($sFunctionName, "none", "ptr;ptr;dword;ptr;dword")
If Not $CallBack_Register Then Return SetError(-1, 0, 0)
Local $ah_CallBackFunction = DllCall('wininet.dll', "ptr", "InternetSetStatusCallback", "ptr", $l_InternetSession, "ulong_ptr", DllCallbackGetPtr($CallBack_Register))
If @error Then Return SetError(-3, 0, 0)
If $ah_CallBackFunction[0] = Ptr(-1) Then Return SetError(-4, 0, 0)
$__gbCallback_Set = True
$__ghCallback_FTP = $CallBack_Register
Return $ah_CallBackFunction[1]
EndFunc
Func __FTP_ListToArray($l_FTPSession, $Return_Type = 0, $l_Flags = 0, $bFmt = 1, $ArrayCount = 6, $l_Context = 0)
Local $tWIN32_FIND_DATA, $tFileTime, $IsDir, $callFindNext
Local $DirectoryIndex = 0, $FileIndex = 0
If $ArrayCount = 1 Then
Local $FileArray[1], $DirectoryArray[1]
Else
Local $FileArray[1][$ArrayCount], $DirectoryArray[1][$ArrayCount]
EndIf
If $Return_Type < 0 Or $Return_Type > 2 Then Return SetError(1, 0, $FileArray)
$tWIN32_FIND_DATA = DllStructCreate($tagWIN32_FIND_DATA)
Local $callFindFirst = DllCall($__ghWinInet_FTP, 'handle', 'FtpFindFirstFileW', 'handle', $l_FTPSession, 'wstr', "", 'ptr', DllStructGetPtr($tWIN32_FIND_DATA), 'dword', $l_Flags, 'dword_ptr', $l_Context)
If @error Or Not $callFindFirst[0] Then Return SetError(1, _WinAPI_GetLastError(), 0)
Do
$IsDir = BitAND(DllStructGetData($tWIN32_FIND_DATA, "dwFileAttributes"), $FILE_ATTRIBUTE_DIRECTORY) = $FILE_ATTRIBUTE_DIRECTORY
If $IsDir And($Return_Type <> 2) Then
$DirectoryIndex += 1
If $ArrayCount = 1 Then
ReDim $DirectoryArray[$DirectoryIndex + 1]
$DirectoryArray[$DirectoryIndex] = DllStructGetData($tWIN32_FIND_DATA, "cFileName")
Else
ReDim $DirectoryArray[$DirectoryIndex + 1][$ArrayCount]
$DirectoryArray[$DirectoryIndex][0] = DllStructGetData($tWIN32_FIND_DATA, "cFileName")
$DirectoryArray[$DirectoryIndex][1] = _WinAPI_MakeQWord(DllStructGetData($tWIN32_FIND_DATA, "nFileSizeLow"), DllStructGetData($tWIN32_FIND_DATA, "nFileSizeHigh"))
If $ArrayCount = 6 Then
$DirectoryArray[$DirectoryIndex][2] = DllStructGetData($tWIN32_FIND_DATA, "dwFileAttributes")
$tFileTime = DllStructCreate($tagFILETIME, DllStructGetPtr($tWIN32_FIND_DATA, "ftLastWriteTime"))
$DirectoryArray[$DirectoryIndex][3] = _Date_Time_FileTimeToStr( $tFileTime ,$bFmt)
$tFileTime = DllStructCreate($tagFILETIME, DllStructGetPtr($tWIN32_FIND_DATA, "ftCreationTime"))
$DirectoryArray[$DirectoryIndex][4] = _Date_Time_FileTimeToStr( $tFileTime ,$bFmt)
$tFileTime = DllStructCreate($tagFILETIME, DllStructGetPtr($tWIN32_FIND_DATA, "ftLastAccessTime"))
$DirectoryArray[$DirectoryIndex][5] = _Date_Time_FileTimeToStr( $tFileTime ,$bFmt)
EndIf
EndIf
ElseIf Not $IsDir And $Return_Type <> 1 Then
$FileIndex += 1
If $ArrayCount = 1 Then
ReDim $FileArray[$FileIndex + 1]
$FileArray[$FileIndex] = DllStructGetData($tWIN32_FIND_DATA, "cFileName")
Else
ReDim $FileArray[$FileIndex + 1][$ArrayCount]
$FileArray[$FileIndex][0] = DllStructGetData($tWIN32_FIND_DATA, "cFileName")
$FileArray[$FileIndex][1] = _WinAPI_MakeQWord(DllStructGetData($tWIN32_FIND_DATA, "nFileSizeLow"), DllStructGetData($tWIN32_FIND_DATA, "nFileSizeHigh"))
If $ArrayCount = 6 Then
$FileArray[$FileIndex][2] = DllStructGetData($tWIN32_FIND_DATA, "dwFileAttributes")
$tFileTime = DllStructCreate($tagFILETIME, DllStructGetPtr($tWIN32_FIND_DATA, "ftLastWriteTime"))
$FileArray[$FileIndex][3] = _Date_Time_FileTimeToStr( $tFileTime ,$bFmt)
$tFileTime = DllStructCreate($tagFILETIME, DllStructGetPtr($tWIN32_FIND_DATA, "ftCreationTime"))
$FileArray[$FileIndex][4] = _Date_Time_FileTimeToStr( $tFileTime ,$bFmt)
$tFileTime = DllStructCreate($tagFILETIME, DllStructGetPtr($tWIN32_FIND_DATA, "ftLastAccessTime"))
$FileArray[$FileIndex][5] = _Date_Time_FileTimeToStr( $tFileTime ,$bFmt)
EndIf
EndIf
EndIf
$callFindNext = DllCall($__ghWinInet_FTP, 'bool', 'InternetFindNextFileW', 'handle', $callFindFirst[0], 'ptr', DllStructGetPtr($tWIN32_FIND_DATA))
If @error Then Return SetError(2, _WinAPI_GetLastError(), 0)
Until Not $callFindNext[0]
DllCall($__ghWinInet_FTP, 'bool', 'InternetCloseHandle', 'handle', $callFindFirst[0])
If $ArrayCount = 1 Then
$DirectoryArray[0] = $DirectoryIndex
$FileArray[0] = $FileIndex
Else
$DirectoryArray[0][0] = $DirectoryIndex
$FileArray[0][0] = $FileIndex
EndIf
Switch $Return_Type
Case 0
If $ArrayCount = 1 Then
ReDim $DirectoryArray[$DirectoryArray[0] + $FileArray[0] + 1]
For $i = 1 To $FileIndex
$DirectoryArray[$DirectoryArray[0] + $i] = $FileArray[$i]
Next
$DirectoryArray[0] += $FileArray[0]
Else
ReDim $DirectoryArray[$DirectoryArray[0][0] + $FileArray[0][0] + 1][$ArrayCount]
For $i = 1 To $FileIndex
For $j = 0 To $ArrayCount-1
$DirectoryArray[$DirectoryArray[0][0] + $i][$j] = $FileArray[$i][$j]
Next
Next
$DirectoryArray[0][0] += $FileArray[0][0]
EndIf
Return $DirectoryArray
Case 1
Return $DirectoryArray
Case 2
Return $FileArray
EndSwitch
EndFunc
Func __FTP_Init()
$__ghWinInet_FTP = DllOpen('wininet.dll')
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\FTPEx.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\GuiMenu.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\MenuConstants.au3
Global Const $MF_CHECKED = 0x00000008
Global Const $MF_SEPARATOR = 0x00000800
Global Const $MFS_CHECKED = $MF_CHECKED
Global Const $MFT_SEPARATOR = $MF_SEPARATOR
Global Const $MIIM_STATE = 0x00000001
Global Const $MIIM_ID = 0x00000002
Global Const $MIIM_SUBMENU = 0x00000004
Global Const $MIIM_DATAMASK = 0x0000003F
Global Const $MIIM_STRING = 0x00000040
Global Const $MIIM_FTYPE = 0x00000100
Global Const $MIM_STYLE = 0x00000010
Global Const $TPM_LEFTBUTTON = 0x0
Global Const $TPM_LEFTALIGN = 0x0
Global Const $TPM_TOPALIGN = 0x0
Global Const $TPM_RIGHTBUTTON = 0x00000002
Global Const $TPM_CENTERALIGN = 0x00000004
Global Const $TPM_RIGHTALIGN = 0x00000008
Global Const $TPM_VCENTERALIGN = 0x00000010
Global Const $TPM_BOTTOMALIGN = 0x00000020
Global Const $TPM_NONOTIFY = 0x00000080
Global Const $TPM_RETURNCMD = 0x00000100
; #######  End Include source C:\Program Files\AutoIt3\include\MenuConstants.au3
Func _GUICtrlMenu_AddMenuItem($hMenu, $sText, $iCmdID = 0, $hSubMenu = 0)
Local $iIndex = _GUICtrlMenu_GetItemCount($hMenu)
Local $tMenu = DllStructCreate($tagMENUITEMINFO)
Local $pMenu = DllStructGetPtr($tMenu)
DllStructSetData($tMenu, "Size", DllStructGetSize($tMenu))
DllStructSetData($tMenu, "Mask", BitOR($MIIM_ID, $MIIM_STRING, $MIIM_SUBMENU))
DllStructSetData($tMenu, "ID", $iCmdID)
DllStructSetData($tMenu, "SubMenu", $hSubMenu)
If $sText = "" Then
DllStructSetData($tMenu, "Mask", $MIIM_FTYPE)
DllStructSetData($tMenu, "Type", $MFT_SEPARATOR)
Else
DllStructSetData($tMenu, "Mask", BitOR($MIIM_ID, $MIIM_STRING, $MIIM_SUBMENU))
Local $tText = DllStructCreate("wchar Text[" & StringLen($sText) + 1 & "]")
DllStructSetData($tText, "Text", $sText)
DllStructSetData($tMenu, "TypeData", DllStructGetPtr($tText))
EndIf
Local $aResult = DllCall("User32.dll", "bool", "InsertMenuItemW", "handle", $hMenu, "uint", $iIndex, "bool", True, "ptr", $pMenu)
If @error Then Return SetError(@error, @extended, -1)
Return SetExtended($aResult[0], $iIndex)
EndFunc
Func _GUICtrlMenu_CreatePopup($iStyle = 8)
Local $aResult = DllCall("User32.dll", "handle", "CreatePopupMenu")
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] = 0 Then Return SetError(10, 0, 0)
_GUICtrlMenu_SetMenuStyle($aResult[0], $iStyle)
Return $aResult[0]
EndFunc
Func _GUICtrlMenu_DestroyMenu($hMenu)
Local $aResult = DllCall("User32.dll", "bool", "DestroyMenu", "handle", $hMenu)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _GUICtrlMenu_GetItemCount($hMenu)
Local $aResult = DllCall("User32.dll", "int", "GetMenuItemCount", "handle", $hMenu)
If @error Then Return SetError(@error, @extended, -1)
Return $aResult[0]
EndFunc
Func _GUICtrlMenu_GetItemInfo($hMenu, $iItem, $fByPos = True)
Local $tInfo = DllStructCreate($tagMENUITEMINFO)
DllStructSetData($tInfo, "Size", DllStructGetSize($tInfo))
DllStructSetData($tInfo, "Mask", $MIIM_DATAMASK)
Local $aResult = DllCall("User32.dll", "bool", "GetMenuItemInfo", "handle", $hMenu, "uint", $iItem, "bool", $fByPos, "ptr", DllStructGetPtr($tInfo))
If @error Then Return SetError(@error, @extended, 0)
Return SetExtended($aResult[0], $tInfo)
EndFunc
Func _GUICtrlMenu_GetItemStateEx($hMenu, $iItem, $fByPos = True)
Local $tInfo = _GUICtrlMenu_GetItemInfo($hMenu, $iItem, $fByPos)
Return DllStructGetData($tInfo, "State")
EndFunc
Func _GUICtrlMenu_SetItemChecked($hMenu, $iItem, $fState = True, $fByPos = True)
Return _GUICtrlMenu_SetItemState($hMenu, $iItem, $MFS_CHECKED, $fState, $fByPos)
EndFunc
Func _GUICtrlMenu_SetItemInfo($hMenu, $iItem, ByRef $tInfo, $fByPos = True)
DllStructSetData($tInfo, "Size", DllStructGetSize($tInfo))
Local $aResult = DllCall("User32.dll", "bool", "SetMenuItemInfoW", "handle", $hMenu, "uint", $iItem, "bool", $fByPos, "ptr", DllStructGetPtr($tInfo))
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _GUICtrlMenu_SetItemState($hMenu, $iItem, $iState, $fState = True, $fByPos = True)
Local $iFlag = _GUICtrlMenu_GetItemStateEx($hMenu, $iItem, $fByPos)
If $fState Then
$iState = BitOR($iFlag, $iState)
Else
$iState = BitAND($iFlag, BitNOT($iState))
EndIf
Local $tInfo = DllStructCreate($tagMENUITEMINFO)
DllStructSetData($tInfo, "Size", DllStructGetSize($tInfo))
DllStructSetData($tInfo, "Mask", $MIIM_STATE)
DllStructSetData($tInfo, "State", $iState)
Return _GUICtrlMenu_SetItemInfo($hMenu, $iItem, $tInfo, $fByPos)
EndFunc
Func _GUICtrlMenu_SetMenuInfo($hMenu, ByRef $tInfo)
DllStructSetData($tInfo, "Size", DllStructGetSize($tInfo))
Local $aResult = DllCall("User32.dll", "bool", "SetMenuInfo", "handle", $hMenu, "ptr", DllStructGetPtr($tInfo))
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _GUICtrlMenu_SetMenuStyle($hMenu, $iStyle)
Local $tInfo = DllStructCreate($tagMENUINFO)
DllStructSetData($tInfo, "Mask", $MIM_STYLE)
DllStructSetData($tInfo, "Style", $iStyle)
Return _GUICtrlMenu_SetMenuInfo($hMenu, $tInfo)
EndFunc
Func _GUICtrlMenu_TrackPopupMenu($hMenu, $hWnd, $iX = -1, $iY = -1, $iAlignX = 1, $iAlignY = 1, $iNotify = 0, $iButtons = 0)
If $iX = -1 Then $iX = _WinAPI_GetMousePosX()
If $iY = -1 Then $iY = _WinAPI_GetMousePosY()
Local $iFlags = 0
Switch $iAlignX
Case 1
$iFlags = BitOR($iFlags, $TPM_LEFTALIGN)
Case 2
$iFlags = BitOR($iFlags, $TPM_RIGHTALIGN)
Case Else
$iFlags = BitOR($iFlags, $TPM_CENTERALIGN)
EndSwitch
Switch $iAlignY
Case 1
$iFlags = BitOR($iFlags, $TPM_TOPALIGN)
Case 2
$iFlags = BitOR($iFlags, $TPM_VCENTERALIGN)
Case Else
$iFlags = BitOR($iFlags, $TPM_BOTTOMALIGN)
EndSwitch
If BitAND($iNotify, 1) <> 0 Then $iFlags = BitOR($iFlags, $TPM_NONOTIFY)
If BitAND($iNotify, 2) <> 0 Then $iFlags = BitOR($iFlags, $TPM_RETURNCMD)
Switch $iButtons
Case 1
$iFlags = BitOR($iFlags, $TPM_RIGHTBUTTON)
Case Else
$iFlags = BitOR($iFlags, $TPM_LEFTBUTTON)
EndSwitch
Local $aResult = DllCall("User32.dll", "bool", "TrackPopupMenu", "handle", $hMenu, "uint", $iFlags, "int", $iX, "int", $iY, "int", 0, "hwnd", $hWnd, "ptr", 0)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\GuiMenu.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\Guiedit.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\GuiStatusBar.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\StatusBarConstants.au3
Global Const $__STATUSBARCONSTANT_WM_USER = 0X400
Global Const $SB_GETBORDERS =($__STATUSBARCONSTANT_WM_USER + 7)
Global Const $SB_GETRECT =($__STATUSBARCONSTANT_WM_USER + 10)
Global Const $SB_GETUNICODEFORMAT = 0x2000 + 6
Global Const $SB_ISSIMPLE =($__STATUSBARCONSTANT_WM_USER + 14)
Global Const $SB_SETMINHEIGHT =($__STATUSBARCONSTANT_WM_USER + 8)
Global Const $SB_SETPARTS =($__STATUSBARCONSTANT_WM_USER + 4)
Global Const $SB_SETTEXTA =($__STATUSBARCONSTANT_WM_USER + 1)
Global Const $SB_SETTEXTW =($__STATUSBARCONSTANT_WM_USER + 11)
Global Const $SB_SETTEXT = $SB_SETTEXTA
Global Const $SB_SIMPLEID = 0xff
; #######  End Include source C:\Program Files\AutoIt3\include\StatusBarConstants.au3
Global $__ghSBLastWnd
Global $Debug_SB = False
Global Const $__STATUSBARCONSTANT_ClassName = "msctls_statusbar32"
Global Const $__STATUSBARCONSTANT_WM_SIZE = 0x05
Global Const $tagBORDERS = "int BX;int BY;int RX"
Func _GUICtrlStatusBar_Create($hWnd, $vPartEdge = -1, $vPartText = "", $iStyles = -1, $iExStyles = -1)
If Not IsHWnd($hWnd) Then Return SetError(1, 0, 0)
Local $iStyle = BitOR($__UDFGUICONSTANT_WS_CHILD, $__UDFGUICONSTANT_WS_VISIBLE)
If $iStyles = -1 Then $iStyles = 0x00000000
If $iExStyles = -1 Then $iExStyles= 0x00000000
Local $aPartWidth[1], $aPartText[1]
If @NumParams > 1 Then
If IsArray($vPartEdge) Then
$aPartWidth = $vPartEdge
Else
$aPartWidth[0] = $vPartEdge
EndIf
If @NumParams = 2 Then
ReDim $aPartText[UBound($aPartWidth)]
Else
If IsArray($vPartText) Then
$aPartText = $vPartText
Else
$aPartText[0] = $vPartText
EndIf
If UBound($aPartWidth) <> UBound($aPartText) Then
Local $iLast
If UBound($aPartWidth) > UBound($aPartText) Then
$iLast = UBound($aPartText)
ReDim $aPartText[UBound($aPartWidth)]
For $x = $iLast To UBound($aPartText) - 1
$aPartWidth[$x] = ""
Next
Else
$iLast = UBound($aPartWidth)
ReDim $aPartWidth[UBound($aPartText)]
For $x = $iLast To UBound($aPartWidth) - 1
$aPartWidth[$x] = $aPartWidth[$x - 1] + 75
Next
$aPartWidth[UBound($aPartText) - 1] = -1
EndIf
EndIf
EndIf
If Not IsHWnd($hWnd) Then $hWnd = HWnd($hWnd)
If @NumParams > 3 Then $iStyle = BitOR($iStyle, $iStyles)
EndIf
Local $nCtrlID = __UDF_GetNextGlobalID($hWnd)
If @error Then Return SetError(@error, @extended, 0)
Local $hWndSBar = _WinAPI_CreateWindowEx($iExStyles, $__STATUSBARCONSTANT_ClassName, "", $iStyle, 0, 0, 0, 0, $hWnd, $nCtrlID)
If @error Then Return SetError(@error, @extended, 0)
If @NumParams > 1 Then
_GUICtrlStatusBar_SetParts($hWndSBar, UBound($aPartWidth), $aPartWidth)
For $x = 0 To UBound($aPartText) - 1
_GUICtrlStatusBar_SetText($hWndSBar, $aPartText[$x], $x)
Next
EndIf
Return $hWndSBar
EndFunc
Func _GUICtrlStatusBar_Destroy(ByRef $hWnd)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
If Not _WinAPI_IsClassName($hWnd, $__STATUSBARCONSTANT_ClassName) Then Return SetError(2, 2, False)
Local $Destroyed = 0
If IsHWnd($hWnd) Then
If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
Local $nCtrlID = _WinAPI_GetDlgCtrlID($hWnd)
Local $hParent = _WinAPI_GetParent($hWnd)
$Destroyed = _WinAPI_DestroyWindow($hWnd)
Local $iRet = __UDF_FreeGlobalID($hParent, $nCtrlID)
If Not $iRet Then
EndIf
Else
Return SetError(1, 1, False)
EndIf
EndIf
If $Destroyed Then $hWnd = 0
Return $Destroyed <> 0
EndFunc
Func _GUICtrlStatusBar_EmbedControl($hWnd, $iPart, $hControl, $iFit = 4)
Local $aRect = _GUICtrlStatusBar_GetRect($hWnd, $iPart)
Local $iBarX = $aRect[0]
Local $iBarY = $aRect[1]
Local $iBarW = $aRect[2] - $iBarX
Local $iBarH = $aRect[3] - $iBarY
Local $iConX = $iBarX
Local $iConY = $iBarY
Local $iConW = _WinAPI_GetWindowWidth($hControl)
Local $iConH = _WinAPI_GetWindowHeight($hControl)
If $iConW > $iBarW Then $iConW = $iBarW
If $iConH > $iBarH Then $iConH = $iBarH
Local $iPadX =($iBarW - $iConW) / 2
Local $iPadY =($iBarH - $iConH) / 2
If $iPadX < 0 Then $iPadX = 0
If $iPadY < 0 Then $iPadY = 0
If BitAND($iFit, 1) = 1 Then $iConX = $iBarX + $iPadX
If BitAND($iFit, 2) = 2 Then $iConY = $iBarY + $iPadY
If BitAND($iFit, 4) = 4 Then
$iPadX = _GUICtrlStatusBar_GetBordersRect($hWnd)
$iPadY = _GUICtrlStatusBar_GetBordersVert($hWnd)
$iConX = $iBarX
If _GUICtrlStatusBar_IsSimple($hWnd) Then $iConX += $iPadX
$iConY = $iBarY + $iPadY
$iConW = $iBarW -($iPadX * 2)
$iConH = $iBarH -($iPadY * 2)
EndIf
_WinAPI_SetParent($hControl, $hWnd)
_WinAPI_MoveWindow($hControl, $iConX, $iConY, $iConW, $iConH)
EndFunc
Func _GUICtrlStatusBar_GetBorders($hWnd)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
Local $tBorders = DllStructCreate($tagBORDERS)
Local $pBorders = DllStructGetPtr($tBorders)
Local $iRet
If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
$iRet = _SendMessage($hWnd, $SB_GETBORDERS, 0, $pBorders, 0, "wparam", "ptr")
Else
Local $iSize = DllStructGetSize($tBorders)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iSize, $tMemMap)
$iRet = _SendMessage($hWnd, $SB_GETBORDERS, 0, $pMemory, 0, "wparam", "ptr")
_MemRead($tMemMap, $pMemory, $pBorders, $iSize)
_MemFree($tMemMap)
EndIf
Local $aBorders[3]
If $iRet = 0 Then Return SetError(-1, -1, $aBorders)
$aBorders[0] = DllStructGetData($tBorders, "BX")
$aBorders[1] = DllStructGetData($tBorders, "BY")
$aBorders[2] = DllStructGetData($tBorders, "RX")
Return $aBorders
EndFunc
Func _GUICtrlStatusBar_GetBordersRect($hWnd)
Local $aBorders = _GUICtrlStatusBar_GetBorders($hWnd)
Return SetError(@error, @extended, $aBorders[2])
EndFunc
Func _GUICtrlStatusBar_GetBordersVert($hWnd)
Local $aBorders = _GUICtrlStatusBar_GetBorders($hWnd)
Return SetError(@error, @extended, $aBorders[1])
EndFunc
Func _GUICtrlStatusBar_GetRect($hWnd, $iPart)
Local $tRect = _GUICtrlStatusBar_GetRectEx($hWnd, $iPart)
If @error Then Return SetError(@error, 0, 0)
Local $aRect[4]
$aRect[0] = DllStructGetData($tRect, "Left")
$aRect[1] = DllStructGetData($tRect, "Top")
$aRect[2] = DllStructGetData($tRect, "Right")
$aRect[3] = DllStructGetData($tRect, "Bottom")
Return $aRect
EndFunc
Func _GUICtrlStatusBar_GetRectEx($hWnd, $iPart)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
Local $tRect = DllStructCreate($tagRECT)
Local $pRect = DllStructGetPtr($tRect)
Local $iRet
If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
$iRet = _SendMessage($hWnd, $SB_GETRECT, $iPart, $pRect, 0, "wparam", "ptr")
Else
Local $iRect = DllStructGetSize($tRect)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iRect, $tMemMap)
$iRet = _SendMessage($hWnd, $SB_GETRECT, $iPart, $pMemory, 0, "wparam", "ptr")
_MemRead($tMemMap, $pMemory, $pRect, $iRect)
_MemFree($tMemMap)
EndIf
Return SetError($iRet=0, 0, $tRect)
EndFunc
Func _GUICtrlStatusBar_GetUnicodeFormat($hWnd)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
Return _SendMessage($hWnd, $SB_GETUNICODEFORMAT) <> 0
EndFunc
Func _GUICtrlStatusBar_IsSimple($hWnd)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
Return _SendMessage($hWnd, $SB_ISSIMPLE) <> 0
EndFunc
Func _GUICtrlStatusBar_Resize($hWnd)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
_SendMessage($hWnd, $__STATUSBARCONSTANT_WM_SIZE)
EndFunc
Func _GUICtrlStatusBar_SetMinHeight($hWnd, $iMinHeight)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
_SendMessage($hWnd, $SB_SETMINHEIGHT, $iMinHeight)
_GUICtrlStatusBar_Resize($hWnd)
EndFunc
Func _GUICtrlStatusBar_SetParts($hWnd, $iaParts = -1, $iaPartWidth = 25)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
Local $tParts, $iParts = 1
If IsArray($iaParts) <> 0 Then
$iaParts[UBound($iaParts) - 1] = -1
$iParts = UBound($iaParts)
$tParts = DllStructCreate("int[" & $iParts & "]")
For $x = 0 To $iParts - 2
DllStructSetData($tParts, 1, $iaParts[$x], $x + 1)
Next
DllStructSetData($tParts, 1, -1, $iParts)
ElseIf IsArray($iaPartWidth) <> 0 Then
$iParts = UBound($iaPartWidth)
$tParts = DllStructCreate("int[" & $iParts & "]")
For $x = 0 To $iParts - 2
DllStructSetData($tParts, 1, $iaPartWidth[$x], $x + 1)
Next
DllStructSetData($tParts, 1, -1, $iParts)
ElseIf $iaParts > 1 Then
$iParts = $iaParts
$tParts = DllStructCreate("int[" & $iParts & "]")
For $x = 1 To $iParts - 1
DllStructSetData($tParts, 1, $iaPartWidth * $x, $x)
Next
DllStructSetData($tParts, 1, -1, $iParts)
Else
$tParts = DllStructCreate("int")
DllStructSetData($tParts, $iParts, -1)
EndIf
Local $pParts = DllStructGetPtr($tParts)
If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
_SendMessage($hWnd, $SB_SETPARTS, $iParts, $pParts, 0, "wparam", "ptr")
Else
Local $iSize = DllStructGetSize($tParts)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iSize, $tMemMap)
_MemWrite($tMemMap, $pParts)
_SendMessage($hWnd, $SB_SETPARTS, $iParts, $pMemory, 0, "wparam", "ptr")
_MemFree($tMemMap)
EndIf
_GUICtrlStatusBar_Resize($hWnd)
Return True
EndFunc
Func _GUICtrlStatusBar_SetText($hWnd, $sText = "", $iPart = 0, $iUFlag = 0)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
Local $fUnicode = _GUICtrlStatusBar_GetUnicodeFormat($hWnd)
Local $iBuffer = StringLen($sText) + 1
Local $tText
If $fUnicode Then
$tText = DllStructCreate("wchar Text[" & $iBuffer & "]")
$iBuffer *= 2
Else
$tText = DllStructCreate("char Text[" & $iBuffer & "]")
EndIf
Local $pBuffer = DllStructGetPtr($tText)
DllStructSetData($tText, "Text", $sText)
If _GUICtrlStatusBar_IsSimple($hWnd) Then $iPart = $SB_SIMPLEID
Local $iRet
If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
$iRet = _SendMessage($hWnd, $SB_SETTEXTW, BitOR($iPart, $iUFlag), $pBuffer, 0, "wparam", "ptr")
Else
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iBuffer, $tMemMap)
_MemWrite($tMemMap, $pBuffer)
If $fUnicode Then
$iRet = _SendMessage($hWnd, $SB_SETTEXTW, BitOR($iPart, $iUFlag), $pMemory, 0, "wparam", "ptr")
Else
$iRet = _SendMessage($hWnd, $SB_SETTEXT, BitOR($iPart, $iUFlag), $pMemory, 0, "wparam", "ptr")
EndIf
_MemFree($tMemMap)
EndIf
Return $iRet <> 0
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\GuiStatusBar.au3
; #######  End Include source C:\Program Files\AutoIt3\include\Guiedit.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\ProgressConstants.au3
Global Const $PBS_SMOOTH = 1
; #######  End Include source C:\Program Files\AutoIt3\include\ProgressConstants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\Timers.au3
Global $_Timers_aTimerIDs[1][3]
Func _Timer_KillAllTimers($hWnd)
Local $iNumTimers = $_Timers_aTimerIDs[0][0]
If $iNumTimers = 0 Then Return False
Local $aResult, $hCallBack = 0
For $x = $iNumTimers To 1 Step -1
If IsHWnd($hWnd) Then
$aResult = DllCall("user32.dll", "bool", "KillTimer", "hwnd", $hWnd, "uint_ptr", $_Timers_aTimerIDs[$x][1])
Else
$aResult = DllCall("user32.dll", "bool", "KillTimer", "hwnd", $hWnd, "uint_ptr", $_Timers_aTimerIDs[$x][0])
EndIf
If @error Or $aResult[0] = 0 Then Return SetError(@error, @extended, False)
$hCallBack = $_Timers_aTimerIDs[$x][2]
If $hCallBack <> 0 Then DllCallbackFree($hCallBack)
$_Timers_aTimerIDs[0][0] -= 1
Next
ReDim $_Timers_aTimerIDs[1][3]
Return True
EndFunc
Func _Timer_KillTimer($hWnd, $iTimerID)
Local $aResult[1] = [0], $hCallBack = 0, $iUBound = UBound($_Timers_aTimerIDs) - 1
For $x = 1 To $iUBound
If $_Timers_aTimerIDs[$x][0] = $iTimerID Then
If IsHWnd($hWnd) Then
$aResult = DllCall("user32.dll", "bool", "KillTimer", "hwnd", $hWnd, "uint_ptr", $_Timers_aTimerIDs[$x][1])
Else
$aResult = DllCall("user32.dll", "bool", "KillTimer", "hwnd", $hWnd, "uint_ptr", $_Timers_aTimerIDs[$x][0])
EndIf
If @error Or $aResult[0] = 0 Then Return SetError(@error, @extended, False)
$hCallBack = $_Timers_aTimerIDs[$x][2]
If $hCallBack <> 0 Then DllCallbackFree($hCallBack)
For $i = $x To $iUBound - 1
$_Timers_aTimerIDs[$i][0] = $_Timers_aTimerIDs[$i + 1][0]
$_Timers_aTimerIDs[$i][1] = $_Timers_aTimerIDs[$i + 1][1]
$_Timers_aTimerIDs[$i][2] = $_Timers_aTimerIDs[$i + 1][2]
Next
ReDim $_Timers_aTimerIDs[UBound($_Timers_aTimerIDs - 1)][3]
$_Timers_aTimerIDs[0][0] -= 1
ExitLoop
EndIf
Next
Return $aResult[0] <> 0
EndFunc
Func _Timer_SetTimer($hWnd, $iElapse = 250, $sTimerFunc = "", $iTimerID = -1)
Local $aResult[1] = [0], $pTimerFunc = 0, $hCallBack = 0, $iIndex = $_Timers_aTimerIDs[0][0] + 1
If $iTimerID = -1 Then
ReDim $_Timers_aTimerIDs[$iIndex + 1][3]
$_Timers_aTimerIDs[0][0] = $iIndex
$iTimerID = $iIndex + 1000
For $x = 1 To $iIndex
If $_Timers_aTimerIDs[$x][0] = $iTimerID Then
$iTimerID = $iTimerID + 1
$x = 0
EndIf
Next
If $sTimerFunc <> "" Then
$hCallBack = DllCallbackRegister($sTimerFunc, "none", "hwnd;int;uint_ptr;dword")
If $hCallBack = 0 Then Return SetError(-1, -1, 0)
$pTimerFunc = DllCallbackGetPtr($hCallBack)
If $pTimerFunc = 0 Then Return SetError(-1, -1, 0)
EndIf
$aResult = DllCall("user32.dll", "uint_ptr", "SetTimer", "hwnd", $hWnd, "uint_ptr", $iTimerID, "uint", $iElapse, "ptr", $pTimerFunc)
If @error Or $aResult[0] = 0 Then Return SetError(@error, @extended, 0)
$_Timers_aTimerIDs[$iIndex][0] = $aResult[0]
$_Timers_aTimerIDs[$iIndex][1] = $iTimerID
$_Timers_aTimerIDs[$iIndex][2] = $hCallBack
Else
For $x = 1 To $iIndex - 1
If $_Timers_aTimerIDs[$x][0] = $iTimerID Then
If IsHWnd($hWnd) Then $iTimerID = $_Timers_aTimerIDs[$x][1]
$hCallBack = $_Timers_aTimerIDs[$x][2]
If $hCallBack <> 0 Then
$pTimerFunc = DllCallbackGetPtr($hCallBack)
If $pTimerFunc = 0 Then Return SetError(-1, -1, 0)
EndIf
$aResult = DllCall("user32.dll", "uint_ptr", "SetTimer", "hwnd", $hWnd, "uint_ptr", $iTimerID, "int", $iElapse, "ptr", $pTimerFunc)
If @error Or $aResult[0] = 0 Then Return SetError(@error, @extended, 0)
ExitLoop
EndIf
Next
EndIf
Return $aResult[0]
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\Timers.au3
; #######  Start Include source D:\FTP Explorer Project\FTP Explorer 1-27-10\Messages.au3
Dim $msgId[1][6] = [[0, 0, 100, DllCallbackRegister('_queue', 'none', ''), 0, 'lib10rsZd']]
Dim $msgQueue[1][2] = [[0]]
Const $MSG_WM_COPYDATA = 0x004A
OnAutoItExitRegister('OnMessagesExit')
Local $wmInt = 0
Local $qeInt = 0
Func _MsgRegister($sIdentifier, $sFunction)
Local $ID, $Title
Local $i, $j = 0, $k, $l, $b, $t
If(Not IsString($sIdentifier)) Or(Not IsString($sFunction)) Or($msgId[0][3] = 0) Or(StringStripWS($sIdentifier, 8) = '') Then Return SetError(1, 0, 0)
$sFunction = StringStripWS($sFunction, 3)
$t = StringLower($sIdentifier)
For $i = 1 To $msgId[0][0]
If StringLower($msgId[$i][1]) = $t Then
$j = $i
ExitLoop
EndIf
Next
If $j = 0 Then
$Title = $sIdentifier & $msgId[0][5]
If($sFunction = '') Or(IsHWnd(_winhandle($Title))) Then Return SetError(0, 0, 1)
$ID = 1
Do
$b = 1
For $i = 1 To $msgId[0][0]
If $msgId[$i][0] = $ID Then
$ID += 1
$b = 0
ExitLoop
EndIf
Next
Until $b
If $msgId[0][0] = 0 Then
_start()
If @error Then Return 0
EndIf
ReDim $msgId[$msgId[0][0] + 2][6]
$msgId[$msgId[0][0] + 1][0] = $ID
$msgId[$msgId[0][0] + 1][1] = $sIdentifier
$msgId[$msgId[0][0] + 1][2] = $sFunction
$msgId[$msgId[0][0] + 1][3] = GUICreate($Title)
$msgId[$msgId[0][0] + 1][4] = 0
$msgId[$msgId[0][0] + 1][5] = 0
$msgId[0][0] += 1
If $msgId[0][0] = 1 Then GUIRegisterMsg($MSG_WM_COPYDATA, '_WM_COPYDATA')
Return SetError(0, 0, $ID)
EndIf
If $sFunction > '' Then
$msgId[$j][2] = $sFunction
$ID = $msgId[$j][0]
Else
$wmInt = 1
$k = 1
$t = StringLower($msgId[$j][2])
While $k <= $msgQueue[0][0]
If StringLower($msgQueue[$k][0]) = $t Then
For $i = $k To $msgQueue[0][0] - 1
For $l = 0 To 1
$msgQueue[$i][$l] = $msgQueue[$i + 1][$l]
Next
Next
ReDim $msgQueue[$msgQueue[0][0]][2]
$msgQueue[0][0] -= 1
ContinueLoop
EndIf
$k += 1
WEnd
If $msgId[0][0] = 1 Then
GUIRegisterMsg($MSG_WM_COPYDATA, '')
_stop()
EndIf
GUIDelete($msgId[$j][3])
For $i = $j To $msgId[0][0] - 1
For $l = 0 To 5
$msgId[$i][$l] = $msgId[$i + 1][$l]
Next
Next
ReDim $msgId[$msgId[0][0]][6]
$msgId[0][0] -= 1
$ID = 0
$wmInt = 0
EndIf
Return SetError(0, 0, $ID)
EndFunc
Func _MsgSend($sIdentifier, $sMessage)
Local $hWnd, $SendErr = False, $aRet, $tMessage, $tCOPYDATA
If(Not IsString($sIdentifier)) Or(Not IsString($sMessage)) Or(StringStripWS($sIdentifier, 8) = '') Then Return SetError(1, 0, 0)
$hWnd = _winhandle($sIdentifier & $msgId[0][5])
If $hWnd = 0 Then Return SetError(1, 2, 0)
$tMessage = DllStructCreate('char[' & StringLen($sMessage) + 1 & ']')
DllStructSetData($tMessage, 1, $sMessage)
$tCOPYDATA = DllStructCreate('dword;dword;ptr')
DllStructSetData($tCOPYDATA, 2, StringLen($sMessage) + 1)
DllStructSetData($tCOPYDATA, 3, DllStructGetPtr($tMessage))
$aRet = DllCall('user32.dll', 'lparam', 'SendMessage', 'hwnd', $hWnd, 'int', $MSG_WM_COPYDATA, 'wparam', 0, 'lparam', DllStructGetPtr($tCOPYDATA))
If @error Then $SendErr = 1
$tCOPYDATA = 0
$tMessage = 0
If $SendErr Then Return SetError(1, 0, 0)
If $aRet[0] = -1 Then Return SetError(1, -1, 0)
Return SetError(0, 0, 1)
EndFunc
Func _IsReceiver($sIdentifier)
If(Not IsString($sIdentifier)) Or(_winhandle($sIdentifier & $msgId[0][5]) = 0) Then Return 0
Return 1
EndFunc
Func _function($hWnd)
For $i = 0 To $msgId[0][0]
If $msgId[$i][3] = $hWnd Then Return $msgId[$i][2]
Next
Return 0
EndFunc
Func _message($sFunction, $sMessage)
ReDim $msgQueue[$msgQueue[0][0] + 2][2]
$msgQueue[$msgQueue[0][0] + 1][0] = $sFunction
$msgQueue[$msgQueue[0][0] + 1][1] = $sMessage
$msgQueue[0][0] += 1
EndFunc
Func _queue()
If($wmInt = 1) Or($qeInt = 1) Or($msgQueue[0][0] = 0) Then Return
$qeInt = 1
Local $Ret = Call($msgQueue[1][0], $msgQueue[1][1])
If(@error <> 0xDEAD) And(@extended <> 0xBEEF) Then
Local $Lenght = $msgQueue[0][0] - 1
Switch $Ret
Case 0
For $i = 1 To $Lenght
For $j = 0 To 1
$msgQueue[$i][$j] = $msgQueue[$i + 1][$j]
Next
Next
ReDim $msgQueue[$Lenght + 1][2]
$msgQueue[0][0] = $Lenght
Case Else
If $Lenght > 1 Then _swap(1, 2)
EndSwitch
EndIf
$qeInt = 0
EndFunc
Func _start()
If $msgId[0][4] = 0 Then
Local $aRet = DllCall('user32.dll', 'int', 'SetTimer', 'hwnd', 0, 'int', 0, 'int', $msgId[0][2], 'ptr', DllCallbackGetPtr($msgId[0][3]))
If(@error) Or($aRet[0] = 0) Then Return SetError(1, 0, 0)
$msgId[0][4] = $aRet[0]
EndIf
Return SetError(0, 0, 1)
EndFunc
Func _stop()
If $msgId[0][4] > 0 Then
Local $aRet = DllCall('user32.dll', 'int', 'KillTimer', 'hwnd', 0, 'int', $msgId[0][4])
If(@error) Or($aRet[0] = 0) Then Return SetError(1, 0, 0)
$msgId[0][4] = 0
EndIf
Return SetError(0, 0, 1)
EndFunc
Func _swap($Index1, $Index2)
Local $tmp
For $i = 0 To 1
$tmp = $msgQueue[$Index1][$i]
$msgQueue[$Index1][$i] = $msgQueue[$Index2][$i]
$msgQueue[$Index2][$i] = $tmp
Next
EndFunc
Func _winhandle($sTitle)
Local $wList = WinList()
$sTitle = StringLower($sTitle)
For $i = 1 To $wList[0][0]
If StringLower($wList[$i][0]) = $sTitle Then Return $wList[$i][1]
Next
Return 0
EndFunc
Func _WM_COPYDATA($hWnd, $msgId, $wParam, $lParam)
If($wmInt = 1) Then Return -1
Local $Function = _function($hWnd)
If $Function > '' Then
Local $tCOPYDATA = DllStructCreate('dword;dword;ptr', $lParam)
Local $tMsg = DllStructCreate('char[' & DllStructGetData($tCOPYDATA, 2) & ']', DllStructGetData($tCOPYDATA, 3))
_message($Function, DllStructGetData($tMsg, 1))
Return 0
EndIf
Return 'GUI_RUNDEFMSG'
EndFunc
Func OnMessagesExit()
GUIRegisterMsg($MSG_WM_COPYDATA, '')
_stop()
DllCallbackFree($msgId[0][3])
EndFunc
; #######  End Include source D:\FTP Explorer Project\FTP Explorer 1-27-10\Messages.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\String.au3
Func _StringEncrypt($i_Encrypt, $s_EncryptText, $s_EncryptPassword, $i_EncryptLevel = 1)
If $i_Encrypt <> 0 And $i_Encrypt <> 1 Then
SetError(1, 0, '')
ElseIf $s_EncryptText = '' Or $s_EncryptPassword = '' Then
SetError(1, 0, '')
Else
If Number($i_EncryptLevel) <= 0 Or Int($i_EncryptLevel) <> $i_EncryptLevel Then $i_EncryptLevel = 1
Local $v_EncryptModified
Local $i_EncryptCountH
Local $i_EncryptCountG
Local $v_EncryptSwap
Local $av_EncryptBox[256][2]
Local $i_EncryptCountA
Local $i_EncryptCountB
Local $i_EncryptCountC
Local $i_EncryptCountD
Local $i_EncryptCountE
Local $v_EncryptCipher
Local $v_EncryptCipherBy
If $i_Encrypt = 1 Then
For $i_EncryptCountF = 0 To $i_EncryptLevel Step 1
$i_EncryptCountG = ''
$i_EncryptCountH = ''
$v_EncryptModified = ''
For $i_EncryptCountG = 1 To StringLen($s_EncryptText)
If $i_EncryptCountH = StringLen($s_EncryptPassword) Then
$i_EncryptCountH = 1
Else
$i_EncryptCountH += 1
EndIf
$v_EncryptModified = $v_EncryptModified & Chr(BitXOR(Asc(StringMid($s_EncryptText, $i_EncryptCountG, 1)), Asc(StringMid($s_EncryptPassword, $i_EncryptCountH, 1)), 255))
Next
$s_EncryptText = $v_EncryptModified
$i_EncryptCountA = ''
$i_EncryptCountB = 0
$i_EncryptCountC = ''
$i_EncryptCountD = ''
$i_EncryptCountE = ''
$v_EncryptCipherBy = ''
$v_EncryptCipher = ''
$v_EncryptSwap = ''
$av_EncryptBox = ''
Local $av_EncryptBox[256][2]
For $i_EncryptCountA = 0 To 255
$av_EncryptBox[$i_EncryptCountA][1] = Asc(StringMid($s_EncryptPassword, Mod($i_EncryptCountA, StringLen($s_EncryptPassword)) + 1, 1))
$av_EncryptBox[$i_EncryptCountA][0] = $i_EncryptCountA
Next
For $i_EncryptCountA = 0 To 255
$i_EncryptCountB = Mod(($i_EncryptCountB + $av_EncryptBox[$i_EncryptCountA][0] + $av_EncryptBox[$i_EncryptCountA][1]), 256)
$v_EncryptSwap = $av_EncryptBox[$i_EncryptCountA][0]
$av_EncryptBox[$i_EncryptCountA][0] = $av_EncryptBox[$i_EncryptCountB][0]
$av_EncryptBox[$i_EncryptCountB][0] = $v_EncryptSwap
Next
For $i_EncryptCountA = 1 To StringLen($s_EncryptText)
$i_EncryptCountC = Mod(($i_EncryptCountC + 1), 256)
$i_EncryptCountD = Mod(($i_EncryptCountD + $av_EncryptBox[$i_EncryptCountC][0]), 256)
$i_EncryptCountE = $av_EncryptBox[Mod(($av_EncryptBox[$i_EncryptCountC][0] + $av_EncryptBox[$i_EncryptCountD][0]), 256)][0]
$v_EncryptCipherBy = BitXOR(Asc(StringMid($s_EncryptText, $i_EncryptCountA, 1)), $i_EncryptCountE)
$v_EncryptCipher &= Hex($v_EncryptCipherBy, 2)
Next
$s_EncryptText = $v_EncryptCipher
Next
Else
For $i_EncryptCountF = 0 To $i_EncryptLevel Step 1
$i_EncryptCountB = 0
$i_EncryptCountC = ''
$i_EncryptCountD = ''
$i_EncryptCountE = ''
$v_EncryptCipherBy = ''
$v_EncryptCipher = ''
$v_EncryptSwap = ''
$av_EncryptBox = ''
Local $av_EncryptBox[256][2]
For $i_EncryptCountA = 0 To 255
$av_EncryptBox[$i_EncryptCountA][1] = Asc(StringMid($s_EncryptPassword, Mod($i_EncryptCountA, StringLen($s_EncryptPassword)) + 1, 1))
$av_EncryptBox[$i_EncryptCountA][0] = $i_EncryptCountA
Next
For $i_EncryptCountA = 0 To 255
$i_EncryptCountB = Mod(($i_EncryptCountB + $av_EncryptBox[$i_EncryptCountA][0] + $av_EncryptBox[$i_EncryptCountA][1]), 256)
$v_EncryptSwap = $av_EncryptBox[$i_EncryptCountA][0]
$av_EncryptBox[$i_EncryptCountA][0] = $av_EncryptBox[$i_EncryptCountB][0]
$av_EncryptBox[$i_EncryptCountB][0] = $v_EncryptSwap
Next
For $i_EncryptCountA = 1 To StringLen($s_EncryptText) Step 2
$i_EncryptCountC = Mod(($i_EncryptCountC + 1), 256)
$i_EncryptCountD = Mod(($i_EncryptCountD + $av_EncryptBox[$i_EncryptCountC][0]), 256)
$i_EncryptCountE = $av_EncryptBox[Mod(($av_EncryptBox[$i_EncryptCountC][0] + $av_EncryptBox[$i_EncryptCountD][0]), 256)][0]
$v_EncryptCipherBy = BitXOR(Dec(StringMid($s_EncryptText, $i_EncryptCountA, 2)), $i_EncryptCountE)
$v_EncryptCipher = $v_EncryptCipher & Chr($v_EncryptCipherBy)
Next
$s_EncryptText = $v_EncryptCipher
$i_EncryptCountG = ''
$i_EncryptCountH = ''
$v_EncryptModified = ''
For $i_EncryptCountG = 1 To StringLen($s_EncryptText)
If $i_EncryptCountH = StringLen($s_EncryptPassword) Then
$i_EncryptCountH = 1
Else
$i_EncryptCountH += 1
EndIf
$v_EncryptModified &= Chr(BitXOR(Asc(StringMid($s_EncryptText, $i_EncryptCountG, 1)), Asc(StringMid($s_EncryptPassword, $i_EncryptCountH, 1)), 255))
Next
$s_EncryptText = $v_EncryptModified
Next
EndIf
Return $s_EncryptText
EndIf
EndFunc
; #######  End Include source C:\Program Files\AutoIt3\include\String.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\Constants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\ColorConstants.au3
; #######  End Include source C:\Program Files\AutoIt3\include\ColorConstants.au3
Global Const $IDABORT = 3
Global Const $SWP_SHOWWINDOW = 0x0040
; #######  End Include source C:\Program Files\AutoIt3\include\Constants.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\GuiToolbar.au3
; #######  Start Include source C:\Program Files\AutoIt3\include\ToolbarConstants.au3
; #######  End Include source C:\Program Files\AutoIt3\include\ToolbarConstants.au3
; #######  End Include source C:\Program Files\AutoIt3\include\GuiToolbar.au3


FileSetAttrib(@ScriptDir & '\FTP Worker.a3x', 'H')

Opt("MustDeclareVars", 1)
_Singleton("FTPPPP", 0)
Global $PSAPI = DllOpen(@SystemDir & "\psapi.dll")
Global $User32 = DllOpen("user32.dll")
Global $Kernel32 = DllOpen('kernel32.dll')
Global $Shell32 = DllOpen('shell32.dll')
Global $gsWorkerCMDLINE = @AutoItExe & ' /AutoIt3ExecuteScript "' & @ScriptDir & '\FTP Worker.a3x"'
_StartCommunications()
#Region GUI...........................................................
Global $gl_sTitle = "FTP Explorer"
Global $gl_iGUIWidth = 880
Global $GUI = GUICreate($gl_sTitle, $gl_iGUIWidth, 541)
GUISetStyle(BitOR($WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SYSMENU, $WS_CAPTION, $WS_POPUP, $WS_POPUPWINDOW, $WS_GROUP, $WS_TABSTOP, $WS_BORDER, $WS_CLIPSIBLINGS), -1, $GUI)
Local $MenuItem2 = GUICtrlCreateMenu("&File")
Local $MenuItem1 = GUICtrlCreateMenuItem("Connect", $MenuItem2)
Local $MenuItem3 = GUICtrlCreateMenuItem("Disconnect", $MenuItem2)
Local $MenuItem4 = GUICtrlCreateMenuItem("Exit", $MenuItem2)
Local $Help = GUICtrlCreateMenu("&Help")
Local $MenuItem5 = GUICtrlCreateMenuItem("How To Use", $Help)
Local $MenuItem6 = GUICtrlCreateMenuItem("About", $Help)
Global $Local_List = GUICtrlCreateListView("File", 4, 22, 429, 250, $LVS_SHOWSELALWAYS)
Global $FTP_List = GUICtrlCreateListView("File", 444, 22, 429, 250, $LVS_SHOWSELALWAYS)
Global $Queue_List = GUICtrlCreateListView("Name|Target", 4, 291, 429, 201, $LVS_SHOWSELALWAYS)
Global $Status_List = _GUICtrlRichEdit_Create($GUI, "FTP Explorer V2" & @CRLF, 444, 291, 429, 201, BitOR($ES_MULTILINE, $WS_VSCROLL, $WS_HSCROLL, $ES_READONLY))
_GUICtrlRichEdit_SetCharColor($Status_List, '65280')
Global $FTP_Count = GUICtrlCreateLabel("", 444, 272, 428, 17, BitOR($SS_CENTER, $SS_CENTERIMAGE))
Global $Local_Count = GUICtrlCreateLabel("", 5, 272, 428, 17, BitOR($SS_CENTER, $SS_CENTERIMAGE))
Global $FTP_Combo = GUICtrlCreateCombo("", 470, 0, 403, 25)
Local $bFTP_Back = GUICtrlCreateButton("Button1", 444, 0, 25, 21, BitOR($BS_ICON, $WS_GROUP))
GUICtrlSetImage(-1, @SystemDir & "\shell32.dll", -147, 0)
Global $Local_Combo = GUICtrlCreateCombo("", 30, 0, 403, 25)
Local $bLocal_Back = GUICtrlCreateButton("Button1", 4, 0, 25, 21, BitOR($BS_ICON, $WS_GROUP))
GUICtrlSetImage(-1, @SystemDir & "\shell32.dll", -147, 0)
Global $StatusBar, $g_ProgressBar
_Statusbar(1)
Local $GUI_AccelTable[1][2] = [["!+h", $MenuItem4]]
GUISetAccelerators($GUI_AccelTable)
_GUICtrlListView_SetImageList($Local_List, _GUIImageList_GetSystemImageList(), 1)
_GUICtrlListView_SetImageList($FTP_List, _GUIImageList_GetSystemImageList(), 1)
_GUICtrlListView_SetImageList($Queue_List, _GUIImageList_GetSystemImageList(), 1)
_GUICtrlListView_SetColumnWidth($Queue_List, 0, 217)
_GUICtrlListView_SetColumnWidth($Queue_List, 1, 208)
_GUICtrlRichEdit_SetLimitOnText($Status_List, 100000)
#EndRegion ### END Koda GUI section ###
#Region Global Vars, Constants and Handles............................
;Constants
Global Const $tagINTERNET_PROXY_INFO = 'dword AccessType;ptr Proxy;ptr ProxyBypass;';internet options
Global Const $INTERNET_OPTION_RECEIVE_TIMEOUT = 6;internet options
Global Const $cRed = '255', $cGreen = '65280', $cBlue = '16711680';colors
Global Const $cPink = '16711935', $cYellow = '65535', $cTeal = '16776960', $cPurp = '16711830';colors
Global Const $FOLDER_ICON_INDEX = _GUIImageList_GetFileIconIndex(@SystemDir, 0, 1)
;FTP Connection Status Vars
Global Enum $giUploading, $giDownloading, $giIdle, $giFinished; If you change these you must change the ones in FTP_Worker to be the same
Global $FTP_State = $giIdle, $gbFTP_Connected = False, $gbFTP_NOReconnet = False
Global $ghFTPOpen, $ghFTPConnect, $gsServer_Name, $gsServer_IP, $gaConnectionInfo[4], $ghFTPCallBack, $gaQueue[1]
Global $sComboFTP, $sComboLocal
Global $gtIdle_Clock, $CPU
Global $gsLocalCurrent, $gaLocalHistory[20], $gaFTPHistory[20]
Global $CPU_Register, $Transfer_Register, $IdleClock_Register = False;, $Checker_Register
;FTP Connect GUI vars
Global $inIP, $inPort, $inUser, $inPass
Global $hinIP, $ini_Servers, $sINI_History = @ScriptDir & '\History.ini'
;Handles
Global $hQueue_list = GUICtrlGetHandle($Queue_List)
Global $hLocal_List = GUICtrlGetHandle($Local_List)
Global $hFTP_List = GUICtrlGetHandle($FTP_List)
Global $hLocal_Combo = GUICtrlGetHandle($Local_Combo)
Global $hFTP_Combo = GUICtrlGetHandle($FTP_Combo)
Global $hFTP_List_Header = HWnd(_GUICtrlListView_GetHeader($hFTP_List))
Global $hLocal_List_Header = HWnd(_GUICtrlListView_GetHeader($hLocal_List))
#EndRegion Global Vars, Constants and Handles............................

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
GUIRegisterMsg($WM_SIZE, "WM_SIZE")
OnAutoItExitRegister('_ExitTime')
_Check_INI_File()
_Columns($hFTP_List, 'FTPColumns', True)
_Columns($hLocal_List, 'LocalColumns', True)
$CPU_Register = _Timer_SetTimer($GUI, 1000, "_CPU_IdleClock_Update")
_MyComputer()
GUISetState(@SW_SHOW, $GUI)
_FTP_Connect_GUI()
If $PSAPI <> -1 Then AdlibRegister('_ReduceMemory', 60000)
_ReduceMemory()
While 1
Switch GUIGetMsg()
Case $GUI_EVENT_CLOSE, $MenuItem4
If $FTP_State <> $giIdle Then
If MsgBox(36 + 262144, 'Transfer in Progress!', 'Are you sure you want to abort current transfer and quit?') = 7 Then
ContinueLoop
Else
IniWrite($sINI_History, 'Abort', 'Abort', 3); 3 means exit
EndIf
Else
_MsgSend('Worker', 3 & ';');tell worker to disconnect and exit
EndIf
_FTP_Disconnect()
Do
Sleep(100)
Until Not _IsReceiver('Worker')
;~ 			If StringRight(@ScriptFullPath, 3) = 'exe' Then FileDelete(@ScriptDir & '\FTP Worker.a3x')
Exit
;~ 		Case $GUI_EVENT_MAXIMIZE
;~ 			_Resize_Rich_Edit()
Case $GUI_EVENT_RESTORE, $GUI_EVENT_MAXIMIZE
If $FTP_State <> $giIdle Then
Local $FileNameLen
If ($gl_iGUIWidth / 2) > 480 Then
$FileNameLen = ($gl_iGUIWidth / 2)
Else
$FileNameLen = $gl_iGUIWidth - 580 ; ;[75, ?,  80,  80,  80, 140, 200]
EndIf
Local $StatusBar_PartsWidth[7] = [75, $FileNameLen, $FileNameLen + 80, $FileNameLen + 160, $FileNameLen + 240, $FileNameLen + 380, -1]
_GUICtrlStatusBar_SetParts($StatusBar, $StatusBar_PartsWidth)
_GUICtrlStatusBar_EmbedControl($StatusBar, 6, GUICtrlGetHandle($g_ProgressBar), 4)
Else
Local $StatusBar_PartsWidth[4] = [200, ($gl_iGUIWidth / 2), ($gl_iGUIWidth - 80), -1]
_GUICtrlStatusBar_SetParts($StatusBar, $StatusBar_PartsWidth)
EndIf
_Resize_Rich_Edit()
Case $MenuItem1 ;connect
_FTP_Connect_GUI()
Case $MenuItem3 ;disconnect
If $FTP_State <> $giIdle Then
If MsgBox(36 + 262144, 'Transfer in Progress!', 'Are you sure you want to abort current transfer and disconnet?') = 7 Then
ContinueLoop
Else
;~ 					$gbFTP_NOReconnet = True
IniWrite($sINI_History, 'Abort', 'Abort', 2);This will make the call to _FTP_Disconnect
EndIf
Else
_MsgSend('Worker', 2 & ';')
_FTP_Disconnect()
EndIf
GUICtrlSetState($MenuItem1, $GUI_ENABLE)
;~ 			_GUICtrlEdit_AppendText($hStatus_List, 'Disconnected.. ' & @CRLF)
Case $bFTP_Back
_FTPBack()
Case $bLocal_Back
_LocalBack()
;~ 		Case $MenuItem5
Case $MenuItem6
_About("About Info", "FTP Explorer", "Copyright © " & @YEAR & " Brian J Christy. All rights reserved.", "v2.2", "", "http://www.autoitscript.com", _
'Contact Me', "mailto:FreeFTPExplorer@gmail.com", "Written with AutoIT", "http://www.autoitscript.com/", @AutoItExe, 0x0000FF, 0xFFFFFF, -1, -1, -1, -1, $GUI)
EndSwitch
WEnd

#Region Transfer and Queue Functions..................................
Func _Transfer($hWnd, $Msg, $iIDTimer, $dwTime)

If $FTP_State = $giUploading Or $FTP_State = $giDownloading Then Return

If $FTP_State = $giFinished Then ; Set by FTP worker
_ArrayDelete($gaQueue, 1)
_GUICtrlListView_DeleteItem($hQueue_list, 0)
EndIf

Static $Up = False, $down = False
If (UBound($gaQueue) - 1) > 0 Then
Local $aSplit = StringSplit($gaQueue[1], ';')
Else
$FTP_State = $giIdle
_Timer_KillTimer($GUI, $Transfer_Register)
If $Up Then _FtpRefresh($INTERNET_FLAG_RELOAD)
If $down Then _LocalGo($gsLocalCurrent)
$Up = False
$down = False
_Statusbar(2)
Return
EndIf

Select
Case $aSplit[1] = 'upload'
_GUICtrlStatusBar_SetText($StatusBar, 'Uploading', 0)
If $aSplit[2] = 'DIR' Then
_MsgSend('Worker', 6 & ';' & $aSplit[3] & $aSplit[4] & ';' & $aSplit[5] & $aSplit[4])
Else
_GUICtrlStatusBar_SetText($StatusBar, $aSplit[4], 1)
_MsgSend('Worker', 4 & ';' & $aSplit[3] & ';' & $aSplit[4] & ';' & $aSplit[5])
EndIf
$Up = True
Case $aSplit[1] = 'download'
_GUICtrlStatusBar_SetText($StatusBar, 'Downloading', 0)
If $aSplit[2] = 'DIR' Then
_MsgSend('Worker', 7 & ';' & $aSplit[5] & ';' & $aSplit[4] & ';' & $aSplit[3])
Else
_GUICtrlStatusBar_SetText($StatusBar, $aSplit[4], 1)
_MsgSend('Worker', 5 & ';' & $aSplit[3] & ';' & $aSplit[4] & ';' & $aSplit[5] & ';' & $aSplit[6])
EndIf
$down = True
EndSelect

EndFunc   ;==>_Transfer
Func _QueueItems($hList)

Local $aSelected, $i, $sFileName, $sItem, $sQueueItem
Local $iIcon, $sType, $hOtherList, $iDup, $tInfo, $sSource, $sDest

If $hList = $hFTP_List Then
$hOtherList = $hLocal_List
Else
$hOtherList = $hFTP_List
EndIf

$tInfo = DllStructCreate($tagLVFINDINFO)
DllStructSetData($tInfo, "Flags", $LVFI_STRING)

Local $sCurrentFTP = StringReplace(_FTP_DirGetCurrent($ghFTPConnect) & '/', '//', '/')
Local $sCurrentLocal = StringReplace($gsLocalCurrent & '\', '\\', '\')

$aSelected = _GUICtrlListView_GetSelectedIndices($hList, True)
For $i = 1 To $aSelected[0]
$sFileName = _GUICtrlListView_GetItemText($hList, $aSelected[$i], 0)
$iIcon = _GUICtrlListView_GetItemImage($hList, $aSelected[$i])
$iDup = _GUICtrlListView_FindItem($hOtherList, -1, $tInfo, $sFileName)
If $iDup > 0 Then
If MsgBox(36, 'Confirm Overwrite', $sFileName & ' is already in the location you wish to send it to. Are you sure you want to replace it?') = 7 Then ContinueLoop
EndIf
If $iIcon = $FOLDER_ICON_INDEX Then
$sType = 'DIR'
Else
$sType = 'file'
EndIf
If $hList = $hFTP_List Then
$sQueueItem = 'download;' & $sType & ';' & $sCurrentLocal & ';' & $sFileName & ';' & $sCurrentFTP & ';' & _FTP_FileGetSize($ghFTPConnect, $sFileName)
$sSource = $sCurrentFTP & $sFileName
$sDest = $sCurrentLocal
Else
$sQueueItem = 'upload' & ';' & $sType & ';' & $sCurrentLocal & ';' & $sFileName & ';' & $sCurrentFTP
$sSource = $sCurrentLocal & $sFileName
$sDest = $sCurrentFTP
EndIf
$sItem = _GUICtrlListView_AddItem($Queue_List, $sSource, $iIcon)
_GUICtrlListView_AddSubItem($Queue_List, $sItem, $sDest, 1)
_ArrayAdd($gaQueue, $sQueueItem)
Next
EndFunc   ;==>_QueueItems
#EndRegion Transfer and Queue Functions..................................
#Region Script Communication Functions................................
Func _StartCommunications()
_MsgRegister('Boss', '_Receiver')
Run($gsWorkerCMDLINE)
Do
Sleep(100)
Until _IsReceiver('Worker')
EndFunc   ;==>_StartCommunications
Func _Receiver($Msg)
Local $aMsg = StringSplit($Msg, ';', 2)
Switch $aMsg[0]
Case 1;Set State
$FTP_State = $aMsg[1]
Case 2; Update StatusBar transfer values
Static $Time = 0, $speed = 0, $bytes_transfer = 0

If $aMsg[4] <> $Time Then
If $aMsg[4] < 3600 Then;Time
_GUICtrlStatusBar_SetText($StatusBar, "Time (" & StringFormat("%02i:%02i", Int($aMsg[4] / 60), Mod($aMsg[4], 60)) & ")", 3)
Else
Local $iTicks = Mod($aMsg[4], 3600)
_GUICtrlStatusBar_SetText($StatusBar, "Time (" & StringFormat("%02i:%02i:%02i", Int($aMsg[4] / 3600), Int($iTicks / 60), Mod($iTicks, 60)) & ")", 3)
EndIf
$aMsg[4] = $Time
EndIf

If $aMsg[3] <> $bytes_transfer Then
_GUICtrlStatusBar_SetText($StatusBar, $aMsg[3], 5); bytes transferd
$bytes_transfer = $aMsg[3]
EndIf
If $aMsg[2] <> $speed Then
_GUICtrlStatusBar_SetText($StatusBar, $aMsg[2], 4);speed
$aMsg[2] = $speed
EndIf

GUICtrlSetData($g_ProgressBar, $aMsg[1])
Case 3; Update StatusBar filename - used when transfering directorys
_GUICtrlStatusBar_SetText($StatusBar, $aMsg[1], 1)
_RichEdit_Append('Starting Transfer:' & $aMsg[1], $cBlue)
Case 4; Transfer of file finshed
_RichEdit_Append('Transfered: ' & $aMsg[1] & ' ' & _bytes($aMsg[2]) & ' in ' & _Format_Time($aMsg[3]) & _
' (' & _Speed($aMsg[2], $aMsg[3]) & ')', $cBlue)
Case 5;console message
ConsoleWrite('>>>>>>>WORKER MESSAGE: ' & $aMsg[1] & @CRLF)
Case 6
_Timer_KillTimer($GUI, $Transfer_Register)
_RichEdit_Append('Transfer Aborted!', $cRed)
$FTP_State = $giIdle
Do
Sleep(100)
Until Not _IsReceiver('Worker')
Local $iDelete = False
If Int($aMsg[2]) = 1 Then
_FTP_FileDelete($ghFTPConnect, $aMsg[3])
If Not @error Then $iDelete = True
Else
If FileDelete($aMsg[3]) Then $iDelete = True
EndIf
If $iDelete Then
_RichEdit_Append($aMsg[3] & ' partial file has been deleted.', $cRed)
Else
_RichEdit_Append($aMsg[3] & ' partial file removal failed.', $cRed)
EndIf
If $aMsg[1] <> '3' Then ;disconnet or abort transfer
Run($gsWorkerCMDLINE)
Do
Sleep(100)
Until _IsReceiver('Worker')
If $aMsg[1] = '2' Then _FTP_Disconnect()
EndIf
If $aMsg[1] = '1' Then; just abort transfer so reconnect worker
_MsgSend('Worker', 1 & ';' & $gaConnectionInfo[0] & ';' & $gaConnectionInfo[1] & ';' & $gaConnectionInfo[2] & ';' & $gaConnectionInfo[3])
_Statusbar(2)
EndIf
Case 7
;~ 			$pMemoryAddress = ptr($aMsg[1])
EndSwitch
EndFunc   ;==>_Receiver
#EndRegion Script Communication Functions................................
#Region Local Navigation Functions....................................
Func _MyComputer()
Local $drives, $attributes, $item, $Time, $iIndex = 1
$gsLocalCurrent = 'My Computer'
_GUICtrlListView_DeleteAllItems($hLocal_List)
$drives = DriveGetDrive("ALL")
Local $Columns = IniReadSection($sINI_History, 'LocalColumns')
For $i = 1 To 5
$Columns[$i][1] = Int($Columns[$i][1])
Next
For $i = 1 To $drives[0]
$item = _GUICtrlListView_AddItem($hLocal_List, DriveGetLabel($drives[$i] & '\') & ' (' & StringUpper($drives[$i]) & ')', _GUIImageList_GetFileIconIndex($drives[$i] & '\'))
;~ 		$item = _GUICtrlListView_AddItem($Local_List, $drives[$i] & '\', _GUIImageList_GetFileIconIndex($drives[$i] & '\'))
If $Columns[1][1] Then ;size
_GUICtrlListView_AddSubItem($Local_List, $item, 'DIR', $iIndex)
$iIndex += 1
EndIf
If $Columns[2][1] Then $iIndex += 1;Modified
If $Columns[3][1] Then;Attributes
$attributes = FileGetAttrib($drives[$i] & '\')
_GUICtrlListView_AddSubItem($Local_List, $item, $attributes, $iIndex)
EndIf
$iIndex = 1
Next
GUICtrlSetData($Local_Count, $drives[0] & ' Drives')
_ComboHistoryAdd($Local_Combo, $sComboLocal, 'My Computer')
EndFunc   ;==>_MyComputer
Func _LocalDirSwitch($index)
Local $sChangeDir
Select
Case _GUICtrlListView_GetItemText($Local_List, $index) = '[..]'
_LocalParent()
Return
Case $gsLocalCurrent = 'My Computer';
Local $sItem = _GUICtrlListView_GetItemText($Local_List, $index)
$sChangeDir = StringMid($sItem, StringInStr($sItem, '(') + 1, 2) & '\'
Case Else
$sChangeDir = StringReplace($gsLocalCurrent & '\' & _GUICtrlListView_GetItemText($Local_List, $index), '\\', '\')
If StringInStr(FileGetAttrib($sChangeDir), 'D') = 0 Then Return
EndSelect
_Push_History($gsLocalCurrent, $gaLocalHistory)
_LocalGo($sChangeDir)
EndFunc   ;==>_LocalDirSwitch
Func _LocalParent()
Local $aDirSplit, $sChangeDir
$aDirSplit = StringSplit($gsLocalCurrent, '\')
If $aDirSplit[0] = 2 Then
If $aDirSplit[2] = '' Then
$sChangeDir = 'My Computer'
Else
$sChangeDir = $aDirSplit[1] & '\'
EndIf
Else
For $i = 1 To $aDirSplit[0] - 1
$sChangeDir &= $aDirSplit[$i] & '\'
Next
$sChangeDir = StringTrimRight($sChangeDir, 1)
EndIf
_Push_History($gsLocalCurrent, $gaLocalHistory)
_LocalGo($sChangeDir)
EndFunc   ;==>_LocalParent
Func _LocalGo($sDirectory)
If $sDirectory = 'My Computer' Then
_MyComputer()
Return
EndIf
Local $item, $iIcon, $iDirs = 0, $iFiles = 0, $iSize = 0
Local $iIndex, $sSize, $iIndex = 1, $IsDir, $sFile, $attributes, $Time
_GUICtrlListView_DeleteAllItems($hLocal_List)
Local $Columns = IniReadSection($sINI_History, 'LocalColumns')
For $i = 1 To 5
$Columns[$i][1] = Int($Columns[$i][1])
Next
Local $aList = _FileListToArray_mod($sDirectory)
_GUICtrlListView_BeginUpdate($hLocal_List)
_GUICtrlListView_AddItem($Local_List, "[..]", 1)
If IsArray($aList) Then
For $i = 1 To $aList[0]
$sFile = $sDirectory & '\' & $aList[$i]
$attributes = FileGetAttrib($sFile)
If StringInStr($attributes, 'D') > 0 Then
$IsDir = True
$sSize = 'DIR'
$iIcon = $FOLDER_ICON_INDEX
$iDirs += 1
Else
$IsDir = False
$sSize = FileGetSize($sFile)
$iSize += $sSize
$iIcon = _GUIImageList_GetFileIconIndex($aList[$i])
$iFiles += 1
EndIf
$item = _GUICtrlListView_AddItem($Local_List, $aList[$i], $iIcon)
If $Columns[1][1] Then ;size
If $IsDir Then
_GUICtrlListView_AddSubItem($Local_List, $item, 'DIR', $iIndex)
Else
_GUICtrlListView_AddSubItem($Local_List, $item, _bytes($sSize), $iIndex)
EndIf
$iIndex += 1
EndIf
If $Columns[2][1] Then;Modified
$Time = FileGetTime($sFile, 0)
_GUICtrlListView_AddSubItem($Local_List, $item, $Time[0] & '/' & $Time[1] & '/' & $Time[2] & ' ' & $Time[3] & ':' & $Time[4] & ':' & $Time[5], $iIndex)
$iIndex += 1
EndIf
If $Columns[3][1] Then;Attributes
_GUICtrlListView_AddSubItem($Local_List, $item, $attributes, $iIndex)
$iIndex += 1
EndIf
If $Columns[4][1] Then;Creation
$Time = FileGetTime($sFile, 1)
_GUICtrlListView_AddSubItem($Local_List, $item, $Time[0] & '/' & $Time[1] & '/' & $Time[2] & ' ' & $Time[3] & ':' & $Time[4] & ':' & $Time[5], $iIndex)
$iIndex += 1
EndIf
If $Columns[5][1] Then;Accessed
$Time = FileGetTime($sFile, 2)
_GUICtrlListView_AddSubItem($Local_List, $item, $Time[0] & '/' & $Time[1] & '/' & $Time[2] & ' ' & $Time[3] & ':' & $Time[4] & ':' & $Time[5], $iIndex)
$iIndex += 1
EndIf
$iIndex = 1
Next
EndIf
_GUICtrlListView_EndUpdate($hLocal_List)
If $iFiles = 0 Then
GUICtrlSetData($Local_Count, $iDirs & ' Directorys, ' & $iFiles & ' Files ')
Else
GUICtrlSetData($Local_Count, $iDirs & ' Directorys, ' & $iFiles & ' Files ' & '[' & _bytes($iSize) & ']')
EndIf
_ComboHistoryAdd($Local_Combo, $sComboLocal, $sDirectory)
$gsLocalCurrent = $sDirectory
EndFunc   ;==>_LocalGo
Func _LocalBack()
If $gaLocalHistory[0] = '' Then Return
_LocalGo(_Pop_History($gaLocalHistory))
EndFunc   ;==>_LocalBack
Func _Localcreatefolder()
Local $sName = InputBox('Create New Directory', 'Enter Directory Name', '', " M", Default, 130)
DirCreate(StringReplace($gsLocalCurrent & '\' & $sName, '\\', '\'))
_LocalGo($gsLocalCurrent);refresh
EndFunc   ;==>_Localcreatefolder
Func _LocalDelete()
If MsgBox(36, 'Confirm File Delete', 'Are you sure you want to delete selected files?') = 7 Then Return
Local $i, $sFileName, $aLocalSelected
$aLocalSelected = _GUICtrlListView_GetSelectedIndices($hLocal_List, True)
For $i = 1 To $aLocalSelected[0]
$sFileName = StringReplace($gsLocalCurrent & '\' & _GUICtrlListView_GetItemText($Local_List, $aLocalSelected[$i], 0), '\\', '\')
If StringInStr(FileGetAttrib($sFileName), 'D') = 0 Then
FileDelete($sFileName)
Else
DirRemove($sFileName, 1)
EndIf
Next
_GUICtrlListView_DeleteItemsSelected($hLocal_List)
_LocalGo($gsLocalCurrent);refresh
EndFunc   ;==>_LocalDelete
#EndRegion Local Navigation Functions....................................

;
#Region Ftp Navigation Functions......................................
Func _FTPDirSwitch($index)
Local $sCurrentFTPDir, $sChangeDir, $aItem
$sCurrentFTPDir = _FTP_DirGetCurrent($ghFTPConnect)
If _GUICtrlListView_GetItemText($FTP_List, $index, 0) = '[..]' Then
$sChangeDir = _FTPParent($sCurrentFTPDir)
Else
$aItem = _GUICtrlListView_GetItem($FTP_List, $index)
If $aItem[4] = $FOLDER_ICON_INDEX Then
If $sCurrentFTPDir = '/' Then
$sChangeDir = '/' & _GUICtrlListView_GetItemText($FTP_List, $index)
Else
$sChangeDir = $sCurrentFTPDir & '/' & _GUICtrlListView_GetItemText($FTP_List, $index)
EndIf
Else
Return
EndIf
EndIf
_FTPGo($sChangeDir)
ControlFocus($gl_sTitle, '', $FTP_List);RichEdit keeps stealing Focus
EndFunc   ;==>_FTPDirSwitch
Func _FTPGo($sChangeDir, $iInternet_Flag = $INTERNET_FLAG_HYPERLINK)
Local $sFTPCurrent = _FTP_DirGetCurrent($ghFTPConnect)
If $sChangeDir = $sFTPCurrent Then Return
_RichEdit_Append('Changing Directories...', $cPurp)
_Push_History($sFTPCurrent, $gaFTPHistory)
_FTP_DirSetCurrent($ghFTPConnect, $sChangeDir)
If @error Then
_RichEdit_Append('ERROR: FTP Directory Change to ' & $sChangeDir & ' Failed...', $cRed)
_Pop_History($gaFTPHistory)
Return
EndIf
_ComboHistoryAdd($FTP_Combo, $sComboFTP, $sChangeDir)
_FtpRefresh($iInternet_Flag)
_RichEdit_Append('Change Successful.' & '"' & $sChangeDir & '"' & ' is the Current Directory', $cPurp)
EndFunc   ;==>_FTPGo
Func _FTPParent($sCurrentDir)
Local $pos = StringInStr($sCurrentDir, '/', 0, -1)
If $pos = 1 Then Return '/'
Return StringLeft($sCurrentDir, $pos - 1)
EndFunc   ;==>_FTPParent
Func _FTPBack()
If $gaFTPHistory[0] = '' Then Return
Local $Back = _Pop_History($gaFTPHistory)
_FTP_DirSetCurrent($ghFTPConnect, $Back)
If @error Then
_RichEdit_Append('ERROR: FTP Directory Change to ' & $Back & ' Failed...', $cRed)
Return
EndIf
_ComboHistoryAdd($FTP_Combo, $sComboFTP, $Back)
_FtpRefresh()
EndFunc   ;==>_FTPBack
Func _FtpRefresh($iFlag = $INTERNET_FLAG_RELOAD)
Local $aFile, $i, $item, $IsDir, $iIcon, $sCurrent, $iDirs = 0, $iFiles = 0, $iSize = 0, $iIndex = 1
_GUICtrlListView_DeleteAllItems($hFTP_List)
$sCurrent = _FTP_DirGetCurrent($ghFTPConnect)
If $sCurrent <> '/' Then _GUICtrlListView_AddItem($FTP_List, "[..]", 1)
$aFile = _FTP_ListToArrayEx($ghFTPConnect, 0, $iFlag, 1, $ghFTPCallBack)
If IsArray($aFile) Then
Local $Columns = IniReadSection($sINI_History, 'FTPColumns')
For $i = 1 To 5
$Columns[$i][1] = Int($Columns[$i][1])
Next
_GUICtrlListView_BeginUpdate($hFTP_List)
For $i = 1 To $aFile[0][0]
$IsDir = BitAND($aFile[$i][2], $FILE_ATTRIBUTE_DIRECTORY) = $FILE_ATTRIBUTE_DIRECTORY
If $IsDir Then
$iIcon = $FOLDER_ICON_INDEX
$iDirs += 1
Else
$iFiles += 1
$iSize += $aFile[$i][1]
$iIcon = _GUIImageList_GetFileIconIndex('c:\blank.' & StringRight($aFile[$i][0], 3))
EndIf
$item = _GUICtrlListView_AddItem($hFTP_List, $aFile[$i][0], $iIcon)
;~ 				Local $aColumns[5][2] = [["Size", '75'],["Modified", '0'],["Attributes", '0'],["Creation", '0'],["Accessed", '0']]
If $Columns[1][1] Then ;size
If $IsDir Then
_GUICtrlListView_AddSubItem($FTP_List, $item, 'DIR', $iIndex)
Else
_GUICtrlListView_AddSubItem($FTP_List, $item, _bytes($aFile[$i][1]), $iIndex)
EndIf
$iIndex += 1
EndIf
If $Columns[2][1] Then;Modified
_GUICtrlListView_AddSubItem($FTP_List, $item, $aFile[$i][3], $iIndex)
$iIndex += 1
EndIf
If $Columns[3][1] Then;Attributes
_GUICtrlListView_AddSubItem($FTP_List, $item, $aFile[$i][2], $iIndex)
$iIndex += 1
EndIf
If $Columns[4][1] Then;Creation
_GUICtrlListView_AddSubItem($FTP_List, $item, $aFile[$i][4], $iIndex)
$iIndex += 1
EndIf
If $Columns[5][1] Then;Accessed
_GUICtrlListView_AddSubItem($FTP_List, $item, $aFile[$i][5], $iIndex)
$iIndex += 1
EndIf
$iIndex = 1
Next
_GUICtrlListView_EndUpdate($hFTP_List)
EndIf
GUICtrlSetData($FTP_Count, $iDirs & ' Directorys, ' & $iFiles & ' Files ' & '[' & _bytes($iSize) & ']')
EndFunc   ;==>_FtpRefresh
#EndRegion Ftp Navigation Functions......................................
#Region FTP Functions.................................................
Func _FTP_Connect_GUI()
Local $GUI_Connect, $butConnect, $address, $taddress
Local $server_History, $sLastIP

$sLastIP = IniRead($sINI_History, 'Last', 'IP', '')
$ini_Servers = IniReadSectionNames($sINI_History)
For $i = 1 To $ini_Servers[0]
Switch $ini_Servers[$i]
Case 'Abort', 'Last', $sLastIP, 'FTPColumns', 'LocalColumns', 'Queue'
Case Else
$server_History &= $ini_Servers[$i] & '|'
EndSwitch
Next
$server_History = StringTrimRight($server_History, 1)
$GUI_Connect = GUICreate("FTP Connect", 323, 140, Default, Default, Default, Default, $GUI)
GUISwitch($GUI_Connect)
$inIP = GUICtrlCreateCombo(IniRead($sINI_History, 'Last', 'IP', ''), 80, 15, 166, 21)
$hinIP = GUICtrlGetHandle($inIP)
GUICtrlCreateLabel("Server or Url:", 10, 20, 66, 17)
$inPort = GUICtrlCreateInput(IniRead($sINI_History, 'Last', 'Port', ''), 285, 15, 26, 21)
GUICtrlCreateLabel("Port:", 255, 20, 26, 17)
$inUser = GUICtrlCreateInput(IniRead($sINI_History, 'Last', 'User', ''), 80, 45, 231, 21)
GUICtrlCreateLabel("User Name:", 10, 50, 60, 17)
Local $Decrypt_Pass = IniRead($sINI_History, 'Last', 'Pass', '')
If $Decrypt_Pass <> '' Then $Decrypt_Pass = _StringEncrypt(0, $Decrypt_Pass, 'autoitrocks')
$inPass = GUICtrlCreateInput($Decrypt_Pass, 80, 75, 231, 21, $ES_PASSWORD)
GUICtrlCreateLabel("Password:", 10, 80, 53, 17)
$butConnect = GUICtrlCreateButton("Connect", 100, 105, 106, 26, 0)
If $server_History <> '' Then GUICtrlSetData($inIP, $server_History)
GUISetState(@SW_SHOW, $GUI_Connect)
While 1

Switch GUIGetMsg()
Case $GUI_EVENT_CLOSE
GUIDelete($GUI_Connect)
$address = ''
Return $address
Case $butConnect
Local $tIP = GUICtrlRead($inIP)
If $tIP = '' Then
MsgBox(0, 'ERROR', 'Must Enter Server or Url.', 5)
ContinueLoop
EndIf
$taddress = _CheckIP($tIP)
Local $tPass = GUICtrlRead($inPass), $tUser = GUICtrlRead($inUser), $tPort = GUICtrlRead($inPort)
Local $aSearch = _ArraySearch($ini_Servers, $tIP)
If @error Then;if not found then save address. If its not an array than history file is empty
If $tPass <> '' Then $tPass = _StringEncrypt(1, $tPass, 'autoitrocks')
Local $aData[5][2] = [["User", $tUser],["Pass", $tPass],["Port", $tPort],["DIR_History", ''],['Queue', '']]
IniWriteSection($sINI_History, $tIP, $aData, 0)
Else;verify that data is still the same.
If $tPass <> '' Then $tPass = _StringEncrypt(1, $tPass, 'autoitrocks')
If $tUser <> IniRead($sINI_History, $tIP, 'User', '') Then IniWrite($sINI_History, $tIP, 'User', $tUser)
If $tPass <> IniRead($sINI_History, $tIP, 'Pass', '') Then IniWrite($sINI_History, $tIP, 'Pass', $tPass)
If $tPort <> IniRead($sINI_History, $tIP, 'Port', '') Then IniWrite($sINI_History, $tIP, 'Port', $tPort)
Local $DirHistory = IniRead($sINI_History, $tIP, 'DIR_History', '')
GUICtrlSetData($FTP_Combo, $DirHistory)
Local $sQueueHistory = IniRead($sINI_History, $tIP, 'Queue', '')
If $sQueueHistory <> '' Then
_LoadQueue($sQueueHistory)
IniWrite($sINI_History, $tIP, 'Queue', '')
EndIf
$sComboFTP = $DirHistory
EndIf
Local $aLast[4][2] = [["User", $tUser],["Pass", $tPass],["Port", $tPort],["IP", $tIP]]
IniWriteSection($sINI_History, 'Last', $aLast, 0)
GUISetState(@SW_HIDE, $GUI_Connect)
_connect($taddress, $tUser, GUICtrlRead($inPass), $tPass)
If @error = -3 Then
_RichEdit_Append('Failed to Connect to Server..', $cRed)
GUISetState(@SW_SHOW, $GUI_Connect)
ContinueLoop
EndIf
GUIDelete($GUI_Connect)
GUISwitch($GUI)
Return
EndSwitch
WEnd
EndFunc   ;==>_FTP_Connect_GUI
Func _LoadQueue($sQueue)
Local $aQueueSplit, $aItemsplit, $i, $iIcon, $sSource, $sDest, $sItem
$aQueueSplit = StringSplit($sQueue, '|')
_ArraytoConsole($aQueueSplit)
For $i = 1 To $aQueueSplit[0]
$aItemsplit = StringSplit($aQueueSplit[$i], ';')
If $aItemsplit[2] = 'DIR' Then
$iIcon = $FOLDER_ICON_INDEX
Else
$iIcon = _GUIImageList_GetFileIconIndex($aItemsplit[4])
EndIf

If $aItemsplit[1] = 'download' Then
$sSource = $aItemsplit[5] & $aItemsplit[4]
$sDest = $aItemsplit[3]
Else
$sSource = $aItemsplit[3] & $aItemsplit[4]
$sDest = $aItemsplit[5]
EndIf

$sItem = _GUICtrlListView_AddItem($Queue_List, $sSource, $iIcon)
_GUICtrlListView_AddSubItem($Queue_List, $sItem, $sDest, 1)
_ArrayAdd($gaQueue, $aQueueSplit[$i])
Next
EndFunc   ;==>_LoadQueue
Func _CheckIP($ip) ; Verifys corrent IP format or converts URL to IP. Needs to be rewrote.
Local $ipcheck, $newip
$ipcheck = StringReplace($ip, '.', '')
If StringIsDigit($ipcheck) Then
$gsServer_IP = $ip
$gsServer_Name = ''
Return $ip
EndIf
$gsServer_Name = $ip;
$ip = StringReplace($ip, 'ftp://', '')
$ip = StringReplace($ip, 'ftp:/', '')
If StringRight($ip, 1) = '/' Then $ip = StringTrimRight($ip, 1)
TCPStartup()
$newip = TCPNameToIP($ip)
TCPShutdown()
If $newip = '' Then
MsgBox(0, 'ERROR', 'Problem with Server address.')
Return 0
EndIf
$gsServer_IP = $newip
Return $newip
EndFunc   ;==>_CheckIP
Func _connect($sFTP_IPAddress, $sUser, $sPass, $iPort, $sSession = 'session');;;;
Local $iDirs = 0, $iFiles = 0, $iSize = 0
$ghFTPOpen = _FTP_Open($sSession)
_InternetSetOption($ghFTPOpen, $INTERNET_OPTION_RECEIVE_TIMEOUT, 6000)
$ghFTPCallBack = _FTP_SetStatusCallback($ghFTPOpen, '_FTP_StatusHandler')
$ghFTPConnect = _FTP_Connect($ghFTPOpen, $sFTP_IPAddress, $sUser, $sPass, 1, $iPort, 1, 0, $ghFTPCallBack)
If @error = -1 Then
$gsServer_IP = ''
$gsServer_Name = ''
SetError(-3)
Return
EndIf
$gbFTP_NOReconnet = False
$gsServer_IP = $sFTP_IPAddress
$gaConnectionInfo[0] = $sFTP_IPAddress
$gaConnectionInfo[1] = $sUser
$gaConnectionInfo[2] = $sPass
$gaConnectionInfo[3] = $iPort
_MsgSend('Worker', 1 & ';' & $gaConnectionInfo[0] & ';' & $gaConnectionInfo[1] & ';' & $gaConnectionInfo[2] & ';' & $gaConnectionInfo[3])
GUICtrlSetState($MenuItem1, $GUI_DISABLE)
_Statusbar(2)
_FtpRefresh()
_ComboHistoryAdd($FTP_Combo, $sComboFTP, '/')
GUICtrlSetData($FTP_Count, $iDirs & ' Directorys, ' & $iFiles & ' Files ' & '[' & _bytes($iSize) & ']')
EndFunc   ;==>_connect
Func _FTP_Disconnect()
If $gbFTP_Connected Then
If $gsServer_Name <> '' Then
IniWrite($sINI_History, $gsServer_Name, 'DIR_History', $sComboFTP)
Else
IniWrite($sINI_History, $gsServer_IP, 'DIR_History', $sComboFTP)
EndIf
If (UBound($gaQueue) - 1) > 0 Then
Local $sQueue = StringTrimLeft(_ArrayToString($gaQueue, '|'), 1)
If $gsServer_Name <> '' Then
IniWrite($sINI_History, $gsServer_Name, 'Queue', $sQueue)
Else
IniWrite($sINI_History, $gsServer_IP, 'Queue', $sQueue)
EndIf
EndIf
Global $gaQueue[1]
_GUICtrlListView_DeleteAllItems($hQueue_list)
_GUICtrlListView_DeleteAllItems($hFTP_List)
$gsServer_IP = ''
$gsServer_Name = ''
$sComboFTP = ''
GUICtrlSetData($FTP_Combo, '', '')
$FTP_State = $giIdle
$IdleClock_Register = False
_GUICtrlStatusBar_Destroy($StatusBar)
Local $StatusBar_PartsWidth[4] = [200, ($gl_iGUIWidth / 2), ($gl_iGUIWidth - 80), -1]
Local $StatusBar_PartsText[4] = ["Not Connected", "", "", $CPU]
$StatusBar = _GUICtrlStatusBar_Create($GUI, $StatusBar_PartsWidth, $StatusBar_PartsText)
_GUICtrlStatusBar_SetMinHeight($StatusBar, 21)
;~ 		_Timer_KillTimer($GUI, $IdleClock_Register)
_FTP_Close($ghFTPOpen)
EndIf
EndFunc   ;==>_FTP_Disconnect
Func _FTPRemovedir($sFTPDirectory)
Local $aFile, $hSearch, $sWorkingdir, $sFolderList, $i, $bFirst, $aFolderStack[2] = [1, $sFTPDirectory]
While $aFolderStack[0] > 0
$sWorkingdir = $aFolderStack[$aFolderStack[0]]
$aFolderStack[0] -= 1
$aFile = _FTP_FindFileFirst($ghFTPConnect, $sWorkingdir & '/*', $hSearch, $INTERNET_FLAG_RELOAD)
If Not @error Then
$bFirst = True
While 1
If Not $bFirst Then
$aFile = _FTP_FindFileNext($hSearch)
If @error Then ExitLoop
EndIf
If $aFile[1] = 16 Then
$aFolderStack[0] += 1
If UBound($aFolderStack) <= $aFolderStack[0] Then ReDim $aFolderStack[UBound($aFolderStack) * 2]
$aFolderStack[$aFolderStack[0]] = $sWorkingdir & "/" & $aFile[10]
$sFolderList &= $sWorkingdir & "/" & $aFile[10] & ';'
Else
_FTP_FileDelete($ghFTPConnect, $sWorkingdir & "/" & $aFile[10])
_RichEdit_Append('File "' & $sWorkingdir & "/" & $aFile[10] & '" was Deleted', $cRed)
EndIf
$bFirst = False
WEnd
EndIf
_FTP_FindFileClose($hSearch)
WEnd
$aFolderStack = StringSplit(StringTrimRight($sFolderList, 1), ';')
For $i = $aFolderStack[0] To 1 Step -1
_FTP_DirDelete($ghFTPConnect, $aFolderStack[$i])
_RichEdit_Append('Directory "' & $aFolderStack[$i] & '" was Deleted', $cRed)
Next
EndFunc   ;==>_FTPRemovedir
Func _FTP_Delete()
Local $aFTPSelected, $sCurrentFTP, $sFileName, $sFileType, $i
If MsgBox(36 + 262144, 'Confirm File Delete', 'Are you sure you want to delete selected files?') = 7 Then Return
$aFTPSelected = _GUICtrlListView_GetSelectedIndices($hFTP_List, True)
$sCurrentFTP = _FTP_DirGetCurrent($ghFTPConnect)
For $i = 1 To $aFTPSelected[0]
$sFileName = _GUICtrlListView_GetItemText($FTP_List, $aFTPSelected[$i], 0)
$sFileType = _GUICtrlListView_GetItemText($FTP_List, $aFTPSelected[$i], 1)
If $sFileType = 'DIR' Then
_FTPRemovedir($sCurrentFTP & '/' & $sFileName)
_FTP_DirSetCurrent($ghFTPConnect, $sCurrentFTP)
If _FTP_DirDelete($ghFTPConnect, $sFileName) Then
_RichEdit_Append('Directory "' & $sCurrentFTP & '/' & $sFileName & '" was Deleted', $cRed)
EndIf
Else
If _FTP_FileDelete($ghFTPConnect, $sFileName) Then
_RichEdit_Append('File "' & $sCurrentFTP & '/' & $sFileName & '" was Deleted', $cRed)
EndIf
EndIf
Next
_GUICtrlListView_DeleteItemsSelected($hFTP_List)
_FtpRefresh($INTERNET_FLAG_RELOAD)
EndFunc   ;==>_FTP_Delete
Func _FTP_StatusHandler($hInternet, $dwContent, $dwInternetStatus, $lpvStatusInformation, $dwStatusInformationLength)
Switch $dwInternetStatus
Case $INTERNET_STATUS_RESOLVING_NAME
_RichEdit_Append('Resolving Name...', $cBlue)
Case $INTERNET_STATUS_NAME_RESOLVED
_RichEdit_Append('Name Resolved', $cBlue)
Case $INTERNET_STATUS_CONNECTING_TO_SERVER
_RichEdit_Append('Connecting to Server: ' & $gsServer_Name & ' (' & $gsServer_IP & ')', $cBlue)
Case $INTERNET_STATUS_CONNECTED_TO_SERVER
_RichEdit_Append('Connected!', $cBlue)
$gbFTP_Connected = True
Case $INTERNET_STATUS_CONNECTION_CLOSED
_RichEdit_Append('Connection Closed.', $cBlue)
$gbFTP_Connected = False
Case $INTERNET_STATUS_CLOSING_CONNECTION
_RichEdit_Append('Closing Connection...', $cBlue)
Case Else
$gtIdle_Clock = TimerInit()
EndSwitch

EndFunc   ;==>_FTP_StatusHandler
#EndRegion FTP Functions.................................................
#Region Column Functions..............................................
Func _Columns($hList, $sSection, $bStartup = False)
Local $iColumnCount = _GUICtrlListView_GetColumnCount($hList)
Local $Columns = IniReadSection($sINI_History, $sSection)

If Not $bStartup Then
For $i = 1 To $iColumnCount
_GUICtrlListView_DeleteColumn($hList, 1)
Next
Else
_GUICtrlListView_SetColumnWidth($hList, 0, Int(IniRead($sINI_History, $sSection, 'File', 350)))
EndIf

For $i = 1 To 5
If Int($Columns[$i][1]) > 0 Then _GUICtrlListView_AddColumn($hList, $Columns[$i][0], $Columns[$i][1])
Next

If $hList = $hFTP_List Then
_FtpRefresh()
Else
_LocalGo($gsLocalCurrent);refresh
EndIf
EndFunc   ;==>_Columns
Func _SaveColumns($hList, $sSection)
Local $i, $iCount, $aColunm

$iCount = _GUICtrlListView_GetColumnCount($hList)

For $i = 0 To $iCount - 1
$aColunm = _GUICtrlListView_GetColumn($hList, $i)
IniWrite($sINI_History, $sSection, $aColunm[5], $aColunm[4])
Next
EndFunc   ;==>_SaveColumns
#EndRegion Column Functions..............................................
#Region GUI Notification Functions....................................
Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
Local $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
Local $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
Local $iCode = DllStructGetData($tNMHDR, "Code")

Switch $iCode
;~ 		Case $LVN_COLUMNCLICK
;~ 			Local $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
;~ 			Local $subitem = DllStructGetData($tInfo, "SubItem")
;~ 			_GUICtrlListView_SortItems($hWndFrom, $subitem)
;~ 			Return $__LISTVIEWCONSTANT_GUI_RUNDEFMSG
Case $LVN_KEYDOWN ; A key has been pressed
Local $tInfo = DllStructCreate($tagNMLVKEYDOWN, $ilParam)
Switch DllStructGetData($tInfo, "VKey")
Case 46;22216750 ;Delete Key
Switch $hWndFrom
Case $hLocal_List
_LocalDelete()
Case $hFTP_List
If $gbFTP_Connected Then _FTP_Delete()
Case $hQueue_list
_Queue_Delete_items()
EndSwitch
Case 8;917512;Backspace key
Switch $hWndFrom
Case $hLocal_List
_LocalBack()
Case $hFTP_List
If $gbFTP_Connected Then _FTPBack()
EndSwitch
Case 113; F2 Key
Local $iTotalSelected = _GUICtrlListView_GetSelectedCount($hWndFrom)
If $iTotalSelected <> 1 Then Return $GUI_RUNDEFMSG
Switch $hWndFrom
Case $hLocal_List
If $gsLocalCurrent = 'My Computer' Then Return $GUI_RUNDEFMSG
_Rename($hLocal_List)
Case $hFTP_List
If Not $gbFTP_Connected Or _FTP_DirGetCurrent($ghFTPConnect) = '/' Then Return $GUI_RUNDEFMSG
_Rename($hFTP_List)
EndSwitch
;~ 					ConsoleWrite(DllStructGetData($tInfo, "VKey") & @CRLF)
EndSwitch
Case $NM_DBLCLK ; Sent by a list-view control when the user double-clicks an item with the left mouse button
Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
Switch $hWndFrom
Case $hLocal_List
_LocalDirSwitch(DllStructGetData($tInfo, "Index"))
Case $hFTP_List
_FTPDirSwitch(DllStructGetData($tInfo, "Index"))
EndSwitch
Case $NM_RCLICK
Switch $hWndFrom
Case $hQueue_list
_QueueListView_RClick()
Case $hLocal_List
_LocalListView_RClick()
Case $hFTP_List
_FTPListView_RClick()
Case $hFTP_List_Header
_RClick_Attributes($hFTP_List, 'FTPColumns')
Case $hLocal_List_Header
_RClick_Attributes($hLocal_List, 'LocalColumns')
EndSwitch
;~ 		Case $NM_KILLFOCUS
;~ 		Case $NM_SETFOCUS
EndSwitch
Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
Func WM_COMMAND($hWnd, $iMsg, $iwParam, $hWndFrom)
#forceref $hWnd, $iMsg
Local $iIDFrom, $iCode;, $hWndEdit
$iIDFrom = _WinAPI_LoWord($iwParam)
$iCode = _WinAPI_HiWord($iwParam)
Switch $hWndFrom
Case $hFTP_Combo
Switch $iCode
Case $CBN_KILLFOCUS ; Sent when a combo box loses the keyboard focus
AdlibUnRegister('_ComboFTP_Monitor_EnterKey')
Case $CBN_SELCHANGE ; Sent when the user changes the current selection in the list box of a combo box
_FTPGo(GUICtrlRead($FTP_Combo))
Case $CBN_SETFOCUS ; Sent when a combo box receives the keyboard focus
AdlibRegister('_ComboFTP_Monitor_EnterKey', 75)
EndSwitch
Case $hLocal_Combo
Switch $iCode
Case $CBN_KILLFOCUS ; Sent when a combo box loses the keyboard focus
AdlibUnRegister('_ComboLocal_Monitor_EnterKey')
Case $CBN_SELCHANGE ; Sent when the user changes the current selection in the list box of a combo box
_Push_History($gsLocalCurrent, $gaLocalHistory)
_LocalGo(GUICtrlRead($Local_Combo))
Case $CBN_SETFOCUS ; Sent when a combo box receives the keyboard focus
AdlibRegister('_ComboLocal_Monitor_EnterKey', 75)
EndSwitch
Case $hinIP
If $iCode = $CBN_SELCHANGE Then; Sent when the user changes the current selection in the list box of a combo box
Local $sIPRead = GUICtrlRead($inIP)
Local $Decrypt_Pass = IniRead($sINI_History, $sIPRead, 'Pass', '')
If $Decrypt_Pass <> '' Then $Decrypt_Pass = _StringEncrypt(0, $Decrypt_Pass, 'autoitrocks')
GUICtrlSetData($inPass, $Decrypt_Pass)
GUICtrlSetData($inUser, IniRead($sINI_History, $sIPRead, 'User', ''))
GUICtrlSetData($inPort, IniRead($sINI_History, $sIPRead, 'Port', ''))
;~ 				ConsoleWrite($hWndFrom & @CRLF & $iCode & @CRLF)
EndIf
EndSwitch
Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND
Func WM_SIZE($hWnd, $iMsg, $iwParam, $ilParam)
$gl_iGUIWidth = _WinAPI_LoWord($ilParam)
;$iHeight = _WinAPI_HiWord($ilParam)
_GUICtrlStatusBar_Resize($StatusBar)
Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE
#EndRegion GUI Notification Functions....................................
#Region Right Click Menues............................................
Func _FTPListView_RClick()
Local Enum $idQueue = 1000, $idTransfer, $idDelete, $idRename, $idRefresh, $idFolder, $idAbort, $idConnect
Local $hMenu = _GUICtrlMenu_CreatePopup()
Local $iTotalSelected = _GUICtrlListView_GetSelectedCount($hFTP_List)

If $gbFTP_Connected Then
If $FTP_State <> $giIdle Then _GUICtrlMenu_AddMenuItem($hMenu, "ABORT Transfer", $idAbort)
If $iTotalSelected Then
If $gsLocalCurrent <> 'My Computer' Then _GUICtrlMenu_AddMenuItem($hMenu, "Queue", $idQueue)
If $FTP_State = $giIdle And $gsLocalCurrent <> 'My Computer' Then _GUICtrlMenu_AddMenuItem($hMenu, "Transfer", $idTransfer)
_GUICtrlMenu_AddMenuItem($hMenu, "Delete", $idDelete)
EndIf
If $iTotalSelected = 1 Then _GUICtrlMenu_AddMenuItem($hMenu, "Rename", $idRename)
_GUICtrlMenu_AddMenuItem($hMenu, "Refresh", $idRefresh)
_GUICtrlMenu_AddMenuItem($hMenu, "Create Folder", $idFolder)
Else
_GUICtrlMenu_AddMenuItem($hMenu, "Connect", $idConnect)
EndIf

Switch _GUICtrlMenu_TrackPopupMenu($hMenu, $hFTP_List, -1, -1, 1, 1, 2)
Case $idConnect
_FTP_Connect_GUI()
Case $idQueue
_QueueItems($hFTP_List)
Case $idTransfer
_QueueItems($hFTP_List)
If (UBound($gaQueue) - 1) > 0 Then
_Statusbar(3);Transfer function will change status bar back when finished
$Transfer_Register = _Timer_SetTimer($GUI, 500, "_Transfer")
EndIf
Case $idRename
_Rename($hFTP_List)
Case $idRefresh
_FtpRefresh($INTERNET_FLAG_RELOAD)
Case $idDelete
_FTP_Delete()
Case $idFolder
_FTP_DirCreate($ghFTPConnect, InputBox('Create New Directory', 'Enter Directory Name', '', " M", Default, 130))
_FtpRefresh($INTERNET_FLAG_RELOAD)
Case $idAbort
IniWrite($sINI_History, 'Abort', 'Abort', 1)
Case Else
EndSwitch
_GUICtrlMenu_DestroyMenu($hMenu)
EndFunc   ;==>_FTPListView_RClick
Func _LocalListView_RClick()
Local Enum $idQueue = 1000, $idTransfer, $idDelete, $idRefresh, $idFolder, $idRename, $idAbort, $idConnect
Local $hMenu = _GUICtrlMenu_CreatePopup()
Local $iTotalSelected = _GUICtrlListView_GetSelectedCount($hLocal_List)

If $gbFTP_Connected Then
If $FTP_State <> $giIdle Then _GUICtrlMenu_AddMenuItem($hMenu, "ABORT Transfer", $idAbort)
If $iTotalSelected Then
If $FTP_State = $giIdle Then _GUICtrlMenu_AddMenuItem($hMenu, "Transfer", $idTransfer)
_GUICtrlMenu_AddMenuItem($hMenu, "Queue", $idQueue)
EndIf
Else
_GUICtrlMenu_AddMenuItem($hMenu, "Connect", $idConnect)
EndIf
If $iTotalSelected Then _GUICtrlMenu_AddMenuItem($hMenu, "Delete", $idDelete)
If $iTotalSelected = 1 Then _GUICtrlMenu_AddMenuItem($hMenu, "Rename", $idRename)
_GUICtrlMenu_AddMenuItem($hMenu, "Refresh", $idRefresh)
If $gsLocalCurrent <> 'My Computer' Then _GUICtrlMenu_AddMenuItem($hMenu, "Create Folder", $idFolder)

Switch _GUICtrlMenu_TrackPopupMenu($hMenu, $hLocal_List, -1, -1, 1, 1, 2)
Case $idQueue
_QueueItems($hLocal_List)
Case $idTransfer
_QueueItems($hLocal_List)
If (UBound($gaQueue) - 1) > 0 Then
_Statusbar(3);Transfer function will change status bar back when finished
$Transfer_Register = _Timer_SetTimer($GUI, 500, "_Transfer")
EndIf
Case $idFolder
_Localcreatefolder()
Case $idDelete
_LocalDelete()
Case $idRefresh
If $gsLocalCurrent = 'My Computer' Then
_MyComputer()
Else
_LocalGo($gsLocalCurrent)
EndIf
Case $idRename
_Rename($hLocal_List)
Case $idAbort
IniWrite($sINI_History, 'Abort', 'Abort', 1)
EndSwitch
_GUICtrlMenu_DestroyMenu($hMenu)
EndFunc   ;==>_LocalListView_RClick
Func _QueueListView_RClick()
Local Enum $idTransferQueue = 4564, $idClear, $idDelete, $idAbort; $idBack;,$idFolder,$idRename
Local $hMenu = _GUICtrlMenu_CreatePopup()
Local $iTotalSelected = _GUICtrlListView_GetSelectedCount($hQueue_list)
Local $iCount = _GUICtrlListView_GetItemCount($hQueue_list)

If $gbFTP_Connected Then
If $FTP_State = $giIdle And $iCount Then _GUICtrlMenu_AddMenuItem($hMenu, "Transfter Queue", $idTransferQueue)
If $FTP_State <> $giIdle Then _GUICtrlMenu_AddMenuItem($hMenu, "ABORT Transfer", $idAbort)
EndIf
If $iCount Then _GUICtrlMenu_AddMenuItem($hMenu, "Clear Queue", $idClear)
If $iTotalSelected Then _GUICtrlMenu_AddMenuItem($hMenu, "Delete", $idDelete)

Switch _GUICtrlMenu_TrackPopupMenu($hMenu, $hLocal_List, -1, -1, 1, 1, 2)
Case $idTransferQueue
_Statusbar(3)
$Transfer_Register = _Timer_SetTimer($GUI, 500, "_Transfer")
Case $idClear
Global $gaQueue[1]
_GUICtrlListView_DeleteAllItems($hQueue_list)
Case $idDelete
_Queue_Delete_items()
Case $idAbort
IniWrite($sINI_History, 'Abort', 'Abort', 1)
EndSwitch
_GUICtrlMenu_DestroyMenu($hMenu)
EndFunc   ;==>_QueueListView_RClick
Func _RClick_Attributes($hList, $sSection)
Local Enum $iSize = 1, $iModified, $iAttrubute, $iCreation, $iAccess
Local $i, $bChecked, $sKey, $hMenu = _GUICtrlMenu_CreatePopup(2)
Local $Columns = IniReadSection($sINI_History, $sSection)

_GUICtrlMenu_AddMenuItem($hMenu, "Size", $iSize)
_GUICtrlMenu_AddMenuItem($hMenu, "Modifed", $iModified)
_GUICtrlMenu_AddMenuItem($hMenu, "Attrubutes", $iAttrubute)
_GUICtrlMenu_AddMenuItem($hMenu, "Creation", $iCreation)
_GUICtrlMenu_AddMenuItem($hMenu, "Accessed", $iAccess)

For $i = $iSize To $iAccess
$bChecked = Int($Columns[$i][1]) <> 0
_GUICtrlMenu_SetItemChecked($hMenu, $i, $bChecked, False)
Next

Local $mitem = _GUICtrlMenu_TrackPopupMenu($hMenu, $hList, -1, -1, 1, 1, 2)
_GUICtrlMenu_DestroyMenu($hMenu)
Switch $mitem
Case $iSize
$sKey = 'Size'
Case $iModified
$sKey = 'Modified'
Case $iAttrubute
$sKey = 'Attributes'
Case $iCreation
$sKey = 'Creation'
Case $iAccess
$sKey = 'Accessed'
Case Else
Return
EndSwitch

_SaveColumns($hList, $sSection)

If Int($Columns[$mitem][1]) > 0 Then
IniWrite($sINI_History, $sSection, $sKey, 0)
Else
IniWrite($sINI_History, $sSection, $sKey, 75)
EndIf

_Columns($hList, $sSection)

EndFunc   ;==>_RClick_Attributes
Func _Queue_Delete_items()
If MsgBox(36, 'Confirm Remove Items', 'Are you sure you want remove selected items from queue?') = 7 Then Return
Local $aSelectedQueue = _GUICtrlListView_GetSelectedIndices($hQueue_list, True)
For $i = 1 To $aSelectedQueue[0]
$gaQueue[$aSelectedQueue[$i] + 1] = 0
Next
$i = 1
Do
If Not $gaQueue[$i] Then
_ArrayDelete($gaQueue, $i)
$i -= 1
EndIf
$i += 1
Until $i = UBound($gaQueue)
_GUICtrlListView_DeleteItemsSelected($hQueue_list)
EndFunc   ;==>_Queue_Delete_items
#EndRegion Right Click Menues............................................

#Region Combobox Address Functions....................................
Func _ComboHistoryAdd(ByRef $gui_combo, ByRef $sCombo, $item)
Local $split = StringSplit($sCombo, '|')
_ArraySearch($split, $item)
If Not @error Then; item is already in list
GUICtrlSetData($gui_combo, $item, $item)
Return
EndIf
If $split[0] > 9 Then
_ArrayDelete($split, 1)
$sCombo = _ArrayToString($split, '|', 1) & '|' & $item
GUICtrlSetData($gui_combo, '', $item)
GUICtrlSetData($gui_combo, $sCombo, $item)
Else
$sCombo &= '|' & $item
GUICtrlSetData($gui_combo, $item, $item)
EndIf
EndFunc   ;==>_ComboHistoryAdd
Func _ComboFTP_Monitor_EnterKey()
If _IsPressed("0D", $User32) Then _FTPGo(GUICtrlRead($FTP_Combo))
EndFunc   ;==>_ComboFTP_Monitor_EnterKey
Func _ComboLocal_Monitor_EnterKey()
If _IsPressed("0D", $User32) Then
Local $combo = GUICtrlRead($Local_Combo)
If FileExists($combo) Then
_Push_History($gsLocalCurrent, $gaLocalHistory)
_LocalGo($combo)
EndIf
EndIf
EndFunc   ;==>_ComboLocal_Monitor_EnterKey
#EndRegion Combobox Address Functions....................................

#Region Statusbar Functions...........................................
Func _Statusbar($state)
Switch $state
Case 1;startup
Local $StatusBar_PartsWidth[4] = [200, ($gl_iGUIWidth / 2), ($gl_iGUIWidth - 80), -1]
Local $StatusBar_PartsText[4] = ["Not Connected", "", "", "CPU: 0.0%"]
$StatusBar = _GUICtrlStatusBar_Create($GUI, $StatusBar_PartsWidth, $StatusBar_PartsText)
_GUICtrlStatusBar_SetMinHeight($StatusBar, 21)
Case 2;connected
_GUICtrlStatusBar_Destroy($StatusBar)
Local $StatusBar_PartsWidth[4] = [200, ($gl_iGUIWidth / 2), ($gl_iGUIWidth - 80), -1]
Local $StatusBar_PartsText[4] = ['Connected IP : ' & $gsServer_IP, $gsServer_Name, "Idle (00:00)", $CPU]
$StatusBar = _GUICtrlStatusBar_Create($GUI, $StatusBar_PartsWidth, $StatusBar_PartsText);Connection, idle, messeges?
_GUICtrlStatusBar_SetMinHeight($StatusBar, 21)
$gtIdle_Clock = TimerInit()
;~ 			$IdleClock_Register = _Timer_SetTimer($GUI, 1000, "_IdleClock_Update") ; create timer
$IdleClock_Register = True
Case 3;Transfer
Local $FileNameLen
;~ 			_Timer_KillTimer($GUI, $IdleClock_Register)
$IdleClock_Register = False
_GUICtrlStatusBar_Destroy($StatusBar)
If ($gl_iGUIWidth / 2) > 480 Then
$FileNameLen = ($gl_iGUIWidth / 2)
Else
$FileNameLen = $gl_iGUIWidth - 580 ; ;[75, ?,  80,  80,  80, 140, 200]
EndIf
Local $StatusBar_PartsWidth[7] = [75, $FileNameLen, $FileNameLen + 80, $FileNameLen + 160, $FileNameLen + 240, $FileNameLen + 380, -1]
Local $StatusBar_PartsText[7] = ["Idle:", 'FileName', $CPU, 'Time (00:00)', '', '', '']
$StatusBar = _GUICtrlStatusBar_Create($GUI, $StatusBar_PartsWidth, $StatusBar_PartsText);Uploading or Downloading, filename, speed, Estimated Time
_GUICtrlStatusBar_SetMinHeight($StatusBar, 21)
$g_ProgressBar = GUICtrlCreateProgress(0, 0, -1, -1, $PBS_SMOOTH)
_GUICtrlStatusBar_EmbedControl($StatusBar, 6, GUICtrlGetHandle($g_ProgressBar), 4)
EndSwitch
EndFunc   ;==>_Statusbar
Func _CPU_IdleClock_Update($hWnd, $Msg, $iIDTimer, $dwTime)
Static $StartTimes[2], $EndTimes[2], $bFirstRun = True
Static $CPU_Kernel = DllStructCreate($tagFileTime), $CPU_User = DllStructCreate($tagFileTime), $CPU_Idle = DllStructCreate($tagFileTime)
Static $pCPU_Kernel = DllStructGetPtr($CPU_Kernel), $pCPU_User = DllStructGetPtr($CPU_User), $pCPU_Idle = DllStructGetPtr($CPU_Idle)

DllCall($Kernel32, "int", "GetSystemTimes", "ptr", $pCPU_Idle, "ptr", $pCPU_Kernel, "ptr", $pCPU_User)
$EndTimes[0] = (DllStructGetData($CPU_Kernel, 1) + DllStructGetData($CPU_User, 1)); Kerneltime + UserTime
$EndTimes[1] = DllStructGetData($CPU_Idle, 1);IdleTime

If $bFirstRun Then
$StartTimes = $EndTimes
$bFirstRun = False
Return
EndIf

Local $Idle_Time = $EndTimes[1] - $StartTimes[1]
If $Idle_Time > 0 Then ; Every once in a while idle time will be negative because the 32bit value gets to high and goes back to zero causing starttime to be bigger then endtime
Local $Total_Time = $EndTimes[0] - $StartTimes[0]
Local $CPU_Percent = (($Total_Time - $Idle_Time) / $Total_Time) * 100
$CPU_Percent = StringFormat('CPU: %.1f%%', $CPU_Percent)
If $CPU <> $CPU_Percent Then
If $FTP_State = $giIdle Then
_GUICtrlStatusBar_SetText($StatusBar, $CPU_Percent, 3)
Else
_GUICtrlStatusBar_SetText($StatusBar, $CPU_Percent, 2)
EndIf
$CPU = $CPU_Percent
EndIf
EndIf
$StartTimes = $EndTimes

If $IdleClock_Register Then
Local $Hour, $Mins, $Secs
_TicksToTime(Int(TimerDiff($gtIdle_Clock)), $Hour, $Mins, $Secs)
If Not $Hour Then
_GUICtrlStatusBar_SetText($StatusBar, StringFormat("Idle (%02i:%02i)", $Mins, $Secs), 2)
Else
_GUICtrlStatusBar_SetText($StatusBar, StringFormat("Idle (%02i:%02i:%02i)", $Hour, $Mins, $Secs), 2)
EndIf
EndIf

EndFunc   ;==>_CPU_IdleClock_Update
#EndRegion Statusbar Functions...........................................
#Region History Stack Functions.......................................
Func _Push_History($item, ByRef $aHistory)
If $aHistory[0] = $item Then Return
For $i = 19 To 1 Step -1
$aHistory[$i] = $aHistory[$i - 1]
Next
$aHistory[0] = $item
EndFunc   ;==>_Push_History
Func _Pop_History(ByRef $aHistory)
Local $pop = $aHistory[0]
For $i = 0 To 18
$aHistory[$i] = $aHistory[$i + 1]
Next
$aHistory[19] = ''
Return $pop
EndFunc   ;==>_Pop_History
#EndRegion History Stack Functions.......................................
#Region Other Functions...............................................
Func _ExitTime()
_SaveColumns($hFTP_List, 'FTPColumns')
_SaveColumns($hLocal_List, 'LocalColumns')
_GUICtrlRichEdit_Destroy($Status_List)
IniWrite($sINI_History, "Abort", "Abort", 0)
_Timer_KillAllTimers($GUI)
DllClose($Kernel32)
DllClose($User32)
DllClose($Shell32)
If StringRight(@ScriptFullPath, 3) = 'exe' Then FileDelete(@ScriptDir & '\FTP Worker.a3x')
EndFunc   ;==>_ExitTime
Func _bytes($iBytes)
Switch $iBytes
Case 0 To 1023
Return $iBytes & " Bytes"
Case 1024 To 1048575
Return Round($iBytes / 1024, 2) & " KB"
Case 1048576 To 1073741823
Return Round($iBytes / 1048576, 2) & " MB"
Case Else
Return Round($iBytes / 1073741824, 2) & " GB"
EndSwitch
EndFunc   ;==>_Bytes
Func _ArraytoConsole($array, $name = '')
Local $i, $string = $name & @CRLF
For $i = 0 To UBound($array) - 1
$string &= '[' & $i & ']' & $array[$i] & @CRLF
Next
ConsoleWrite($string)
;~ 	MsgBox(0, 'Array to Console', 'OK to continue?')
EndFunc   ;==>_ArraytoConsole
Func _RichEdit_Append($sMsg, $cColor)
_CheckLen()
_GUICtrlRichEdit_AppendText($Status_List, @CRLF & $sMsg)
_GUICtrlRichEdit_SetSel($Status_List, _GUICtrlRichEdit_GetFirstCharPosOnLine($Status_List), -1, True)
_GUICtrlRichEdit_SetCharColor($Status_List, $cColor)
EndFunc   ;==>_RichEdit_Append
Func _CheckLen()
Static $iCount
$iCount += 1
If $iCount >= 50 Then
If _GUICtrlRichEdit_GetTextLength($Status_List, False, True) > 90000 Then
_GUICtrlRichEdit_SetSel($Status_List, 0, 30000)
_GUICtrlRichEdit_ReplaceText($Status_List, "")
EndIf
$iCount = 0
EndIf
EndFunc   ;==>_CheckLen
Func _Resize_Rich_Edit()
;pretty cheap, but it works:)
Local $FTP_POS = ControlGetPos($gl_sTitle, '', $FTP_List)
Local $Queue_POS = ControlGetPos($gl_sTitle, '', $Queue_List)
_WinAPI_SetWindowPos($Status_List, 0, $FTP_POS[0], $Queue_POS[1], $Queue_POS[2], $Queue_POS[3], $SWP_SHOWWINDOW)
EndFunc   ;==>_Resize_Rich_Edit
Func _Speed($size, $millsec)
Local $speed = $size / ($millsec / 1000)
If $speed >= 1048576 Then
Return Round($speed / 1048576, 2) & " mB/sec"
Else
Return Round($speed / 1024, 2) & " kB/sec"
EndIf
EndFunc   ;==>_Speed
Func _Format_Time($iMillseconds)
$iMillseconds = Int($iMillseconds)
If $iMillseconds < 60000 Then Return Round($iMillseconds / 1000, 2)
Local $Hour, $Mins, $Secs
If $iMillseconds < 3600000 Then
_TicksToTime($iMillseconds, $Hour, $Mins, $Secs)
Return StringFormat("%02i:%02i", $Mins, $Secs)
Else
_TicksToTime($iMillseconds, $Hour, $Mins, $Secs)
Return StringFormat("%02i:%02i:%02i", $Hour, $Mins, $Secs)
EndIf
EndFunc   ;==>_Format_Time
Func _FileListToArray_mod($sPath, $sFilter = "*", $iFlag = 0)
Local $hSearch, $sFile, $sFileList, $sFolderList, $sDelim = "|"
$sPath = StringRegExpReplace($sPath, "[\\/]+\z", "") & "\" ; ensure single trailing backslash
If Not FileExists($sPath) Then Return SetError(1, 1, "")
If StringRegExp($sFilter, "[\\/:><\|]|(?s)\A\s*\z") Then Return SetError(2, 2, "")
If Not ($iFlag = 0 Or $iFlag = 1 Or $iFlag = 2) Then Return SetError(3, 3, "")
$hSearch = FileFindFirstFile($sPath & $sFilter)
If @error Then Return SetError(4, 4, "")
While 1
$sFile = FileFindNextFile($hSearch)
If @error Then ExitLoop
If @extended Then
$sFolderList &= $sDelim & $sFile
Else
$sFileList &= $sDelim & $sFile
EndIf
WEnd
FileClose($hSearch)
$sFileList = $sFolderList & $sFileList
If Not $sFileList Then Return SetError(4, 4, "")
Return StringSplit(StringTrimLeft($sFileList, 1), "|")
EndFunc   ;==>_FileListToArray_mod
Func _Rename($hHandle)
Local $aSelected = _GUICtrlListView_GetSelectedIndices($hHandle, True)
Local $sFileName = _GUICtrlListView_GetItemText($hHandle, $aSelected[1], 0)
Local $sNewName = InputBox("Rename File", "Enter New File Name:", $sFileName, " M", Default, 130)
If @error Then Return
Switch $hHandle
Case $hFTP_List
_FTP_FileRename($ghFTPConnect, $sFileName, $sNewName)
_FtpRefresh($INTERNET_FLAG_RELOAD)
Case $hLocal_List
FileMove($gsLocalCurrent & '\' & $sFileName, $gsLocalCurrent & '\' & $sNewName)
_LocalGo($gsLocalCurrent);refresh
EndSwitch
EndFunc   ;==>_Rename
Func _Check_INI_File()
If Not FileExists($sINI_History) Then
_FileCreate($sINI_History)
IniWrite($sINI_History, "Abort", "Abort", 0)
Local $aLast[4][2] = [["User", ''],["Pass", ''],["Port", '21'],["IP", '']]
IniWriteSection($sINI_History, 'Last', $aLast, 0)
Local $aColumns[6][2] = [["Size", '75'],["Modified", '0'],["Attributes", '0'],["Creation", '0'],["Accessed", '0'],["File", '350']]
IniWriteSection($sINI_History, 'FTPColumns', $aColumns, 0)
IniWriteSection($sINI_History, 'LocalColumns', $aColumns, 0)
EndIf
EndFunc   ;==>_Check_INI_File
Func _ReduceMemory()
If $FTP_State = $giIdle Then
Local $call = DllCall($PSAPI, 'int', 'EmptyWorkingSet', 'long', -1)
If @error Then ConsoleWrite('error code = ' & @error & @CRLF)
EndIf
EndFunc   ;==>_ReduceMemory
#EndRegion Other Functions...............................................
#Region Functions not written by me...................................
;Prog@ndy Icon Functions...................................
Func _GUIImageList_GetSystemImageList($bLargeIcons = False)
Local $SHGFI_USEFILEATTRIBUTES = 0x10, $SHGFI_SYSICONINDEX = 0x4000, $SHGFI_SMALLICON = 0x1;, $SHGFI_LARGEICON = 0x0;,$FILE_ATTRIBUTE_NORMAL = 0x80
Local $FileInfo = DllStructCreate("dword hIcon; int iIcon; DWORD dwAttributes; CHAR szDisplayName[255]; CHAR szTypeName[80];")
Local $dwFlags = BitOR($SHGFI_USEFILEATTRIBUTES, $SHGFI_SYSICONINDEX)
If Not ($bLargeIcons) Then $dwFlags = BitOR($dwFlags, $SHGFI_SMALLICON)
Local $hIml = _WinAPI_SHGetFileInfo(".txt", $FILE_ATTRIBUTE_NORMAL, DllStructGetPtr($FileInfo), DllStructGetSize($FileInfo), $dwFlags)
Return $hIml
EndFunc   ;==>_GUIImageList_GetSystemImageList
Func _GUIImageList_GetFileIconIndex($sFileSpec, $bLargeIcons = False, $bForceLoadFromDisk = False);modified
Static $FileInfo = DllStructCreate("dword hIcon; int iIcon; DWORD dwAttributes; CHAR szDisplayName[255]; CHAR szTypeName[80];")
Local $dwFlags = BitOR(0x4000, 0x1)
If Not $bForceLoadFromDisk Then $dwFlags = BitOR($dwFlags, 0x10)
DllCall($Shell32, "DWORD*", "SHGetFileInfo", "str", $sFileSpec, "DWORD", $FILE_ATTRIBUTE_NORMAL, "ptr", DllStructGetPtr($FileInfo), _
"UINT", DllStructGetSize($FileInfo), "UINT", $dwFlags)
If @error Then Return SetError(1, 0, -1)
Return DllStructGetData($FileInfo, "iIcon")
EndFunc   ;==>_GUIImageList_GetFileIconIndex
Func _WinAPI_SHGetFileInfo($pszPath, $dwFileAttributes, $psfi, $cbFileInfo, $uFlags)
Local $return = DllCall($Shell32, "DWORD*", "SHGetFileInfo", "str", $pszPath, "DWORD", $dwFileAttributes, "ptr", $psfi, "UINT", $cbFileInfo, "UINT", $uFlags)
If @error Then Return SetError(@error, 0, 0)
Return $return[0]
EndFunc   ;==>_WinAPI_SHGetFileInfo

; #FUNCTION# ===============================
; Author(s):		Yashied
;====================================================================================================================================
Func _InternetSetOption($hInternet, $lOption, $lValue)
Local $Ret, $Back, $tBuffer
Switch $lOption
Case 2, 3, 5, 6, 12, 13
If IsInt($lValue) Then
$tBuffer = DllStructCreate('int')
EndIf
Case 28, 29, 41
If IsString($lValue) Then
$tBuffer = DllStructCreate('char[' & StringLen($lValue) + 1 & ']')
EndIf
Case 38
If IsDllStruct($lValue) Then
$tBuffer = DllStructCreate($tagINTERNET_PROXY_INFO, DllStructGetPtr($lValue))
EndIf
Case 45
If IsPtr($lValue) Then
$tBuffer = DllStructCreate('ptr')
EndIf
Case Else
Return SetError(1, 0, 0)
EndSwitch
If Not ($lOption = 38) Then
DllStructSetData($tBuffer, 1, $lValue)
EndIf
$Back = _InternetGetOption($hInternet, $lOption)
If (@error) Then
Return SetError(1, @extended, 0)
EndIf
$Ret = DllCall('wininet.dll', 'int', 'InternetSetOption', 'hwnd', $hInternet, 'dword', $lOption, 'ptr', DllStructGetPtr($tBuffer), 'dword', DllStructGetSize($tBuffer))
If (@error) Or ($Ret[0] = 0) Then
Return SetError(1, _WinAPI_GetLastError(), 0)
EndIf
Return SetError(0, 0, $Back)
EndFunc   ;==>_InternetSetOption
Func _InternetGetOption($hInternet, $lOption)
Local $Ret, $tBuffer
Switch $lOption
Case 2, 3, 5, 6, 12, 13
$tBuffer = DllStructCreate('int')
Case 28, 29, 41
$tBuffer = DllStructCreate('char[1024]')
Case 38
$tBuffer = DllStructCreate($tagINTERNET_PROXY_INFO)
Case 45
$tBuffer = DllStructCreate('ptr')
Case Else
Return SetError(1, 0, 0)
EndSwitch
$Ret = DllCall('wininet.dll', 'int', 'InternetQueryOption', 'hwnd', $hInternet, 'dword', $lOption, 'ptr', DllStructGetPtr($tBuffer), 'dword*', DllStructGetSize($tBuffer))
If (@error) Or ($Ret[0] = 0) Then
Return SetError(1, _WinAPI_GetLastError(), 0)
EndIf
Switch $lOption
Case 38
Return SetError(0, 0, $tBuffer)
Case Else
Return SetError(0, 0, DllStructGetData($tBuffer, 1))
EndSwitch
EndFunc   ;==>_InternetGetOption
Func _About($Title, $MainLabel, $CopyRLabel, $VerLabel, $NameURL1, $URL1, $NameURL2, $URL2, $NameURL3, $URL3, $IconFile = "", $LinkColor = 0x0000FF, $BkColor = 0xFFFFFF, $Left = -1, $Top = -1, $Style = -1, $ExStyle = -1, $Parent = 0)
;~     Local $OldEventOpt = Opt("GUIOnEventMode", 0)
Local $GUI_About, $LinkTop = 120, $Msg, $CurIsOnCtrlArr[1]
Local $LinkVisitedColor[4] = [3, $LinkColor, $LinkColor, $LinkColor], $LinkLabel[4]
WinSetState($Parent, "", @SW_DISABLE)

If $ExStyle = -1 Then $ExStyle = ""
$GUI_About = GUICreate($Title, 320, 240, $Left, $Top, $Style, 0x00000080 + $ExStyle, $Parent)
GUISwitch($GUI_About)
GUISetBkColor($BkColor)
GUICtrlCreateLabel($MainLabel, 40, 20, 280, 25, 1)
GUICtrlSetFont(-1, 16)
GUICtrlCreateIcon($IconFile, 0, 10, 20)
GUICtrlCreateGraphic(5, 75, 310, 3, $SS_ETCHEDFRAME)
For $i = 1 To 3
$LinkLabel[$i] = GUICtrlCreateLabel(Eval("NameURL" & $i), 150, $LinkTop, 145, 15, 1)
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, $LinkColor)
GUICtrlSetFont(-1, 9, 400, 0)
$LinkTop += 30
Next
GUICtrlCreateLabel("Program version: " & @LF & $VerLabel, 10, 130, 150, 35, 1)
GUICtrlSetFont(-1, 10, 600, 0, "Tahoma")
GUICtrlCreateLabel($CopyRLabel, 0, 220, 320, -1, 1)
GUISetState(@SW_SHOW, $GUI_About)

While 1
$Msg = GUIGetMsg()
If $Msg = -3 Then ExitLoop
For $i = 1 To 3
If $Msg = $LinkLabel[$i] Then
$LinkVisitedColor[$i] = 0xAC00A9
GUICtrlSetColor($LinkLabel[$i], $LinkVisitedColor[$i])
ShellExecute(Eval("URL" & $i))
EndIf
Next
If WinActive($GUI) Then
For $i = 1 To 3
ControlHover($GUI_About, $LinkLabel[$i], $i, $CurIsOnCtrlArr, 0xFF0000, $LinkVisitedColor[$i])
Next
EndIf
WEnd
WinSetState($Parent, "", @SW_ENABLE)
GUIDelete($GUI_About)
GUISwitch($GUI)
;~     Opt("GUIOnEventMode", $OldEventOpt)
;~     Opt("RunErrorsFatal", $OldRunErrOpt)
EndFunc   ;==>_About
Func ControlHover($hWnd, $CtrlID, $CtrlNum, ByRef $CurIsOnCtrlArr, $HoverColor = 0xFF0000, $LinkColor = 0x0000FF)
Local $CursorCtrl = GUIGetCursorInfo($hWnd)
ReDim $CurIsOnCtrlArr[UBound($CurIsOnCtrlArr) + 1]
If $CursorCtrl[4] = $CtrlID And $CurIsOnCtrlArr[$CtrlNum] = 1 Then
GUICtrlSetFont($CtrlID, 9, 400, 6)
GUICtrlSetColor($CtrlID, $HoverColor)
$CurIsOnCtrlArr[$CtrlNum] = 0
ElseIf $CursorCtrl[4] <> $CtrlID And $CurIsOnCtrlArr[$CtrlNum] = 0 Then
GUICtrlSetFont($CtrlID, 9, 400, 0)
GUICtrlSetColor($CtrlID, $LinkColor)
$CurIsOnCtrlArr[$CtrlNum] = 1
EndIf
EndFunc   ;==>ControlHover
#EndRegion Functions not written by me...................................
