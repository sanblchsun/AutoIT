#NoTrayIcon
#AutoIt3Wrapper_Outfile=TextReplace.exe
#AutoIt3Wrapper_Icon=icons\TextReplace.ico
#AutoIt3Wrapper_Compression=n
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=TextReplace.exe
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Icon_Add=icons\1.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\2.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\3.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\4.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\5.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\6.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\7.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\8.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\9.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\10.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\11.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\12.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\13.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\14.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\15.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\16.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\17.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\18.ico
#AutoIt3Wrapper_Res_Field=Version|1.0.0.0
#AutoIt3Wrapper_Res_Field=Build|2012.11.24
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\upx\upx.exe -7 --compress-icons=0 "%out%"
Global Const $WS_MINIMIZEBOX = 0x00020000
Global Const $WS_SYSMENU = 0x00080000
Global Const $WS_HSCROLL = 0x00100000
Global Const $WS_VSCROLL = 0x00200000
Global Const $WS_BORDER = 0x00800000
Global Const $WS_CAPTION = 0x00C00000
Global Const $WS_OVERLAPPEDWINDOW = 0x00CF0000
Global Const $WS_CLIPCHILDREN = 0x02000000
Global Const $WS_POPUP = 0x80000000
Global Const $WS_EX_ACCEPTFILES = 0x00000010
Global Const $WM_INPUTLANGCHANGEREQUEST = 0x0050
Global Const $GUI_SS_DEFAULT_GUI = BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU)
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_EVENT_RESTORE = -5
Global Const $GUI_EVENT_MAXIMIZE = -6
Global Const $GUI_EVENT_RESIZED = -12
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
Global Const $GUI_SHOW = 16
Global Const $GUI_HIDE = 32
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128
Global Const $GUI_FOCUS = 256
Global Const $BS_PUSHLIKE = 0x1000
Global Const $BS_ICON = 0x0040
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
Func _ArrayUnique($aArray, $iDimension = 1, $iBase = 0, $iCase = 0, $vDelim = "|")
Local $iUboundDim
If $vDelim = "|" Then $vDelim = Chr(01)
If Not IsArray($aArray) Then Return SetError(1, 0, 0)
If Not $iDimension > 0 Then
Return SetError(3, 0, 0)
Else
$iUboundDim = UBound($aArray, 1)
If @error Then Return SetError(3, 0, 0)
If $iDimension > 1 Then
Local $aArrayTmp[1]
For $i = 0 To $iUboundDim - 1
_ArrayAdd($aArrayTmp, $aArray[$i][$iDimension - 1])
Next
_ArrayDelete($aArrayTmp, 0)
Else
If UBound($aArray, 0) = 1 Then
Dim $aArrayTmp[1]
For $i = 0 To $iUboundDim - 1
_ArrayAdd($aArrayTmp, $aArray[$i])
Next
_ArrayDelete($aArrayTmp, 0)
Else
Dim $aArrayTmp[1]
For $i = 0 To $iUboundDim - 1
_ArrayAdd($aArrayTmp, $aArray[$i][$iDimension - 1])
Next
_ArrayDelete($aArrayTmp, 0)
EndIf
EndIf
EndIf
Local $sHold
For $iCC = $iBase To UBound($aArrayTmp) - 1
If Not StringInStr($vDelim & $sHold, $vDelim & $aArrayTmp[$iCC] & $vDelim, $iCase) Then _
$sHold &= $aArrayTmp[$iCC] & $vDelim
Next
If $sHold Then
$aArrayTmp = StringSplit(StringTrimRight($sHold, StringLen($vDelim)), $vDelim, 1)
Return $aArrayTmp
EndIf
Return SetError(2, 0, 0)
EndFunc
Global Const $LBS_NOTIFY = 0x00000001
Global Const $LBS_SORT = 0x00000002
Global Const $LBS_USETABSTOPS = 0x00000080
Global Const $LBS_NOINTEGRALHEIGHT = 0x00000100
Global Const $LB_GETCURSEL = 0x0188
Global Const $__LISTBOXCONSTANT_WS_BORDER = 0x00800000
Global Const $__LISTBOXCONSTANT_WS_VSCROLL = 0x00200000
Global Const $GUI_SS_DEFAULT_LIST = BitOR($LBS_SORT, $__LISTBOXCONSTANT_WS_BORDER, $__LISTBOXCONSTANT_WS_VSCROLL, $LBS_NOTIFY)
Global Const $SS_RIGHT = 0x2
Global Const $CBS_AUTOHSCROLL = 0x40
Global Const $CBS_DROPDOWN = 0x2
Global Const $CBS_DROPDOWNLIST = 0x3
Global Const $CB_GETCOMBOBOXINFO = 0x164
Global Const $CB_SETEDITSEL = 0x142
Global Const $__COMBOBOXCONSTANT_WS_VSCROLL = 0x00200000
Global Const $GUI_SS_DEFAULT_COMBO = BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $__COMBOBOXCONSTANT_WS_VSCROLL)
Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lresult")
Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
If @error Then Return SetError(@error, @extended, "")
If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
Return $aResult
EndFunc
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
Func _WinAPI_GetSystemMetrics($iIndex)
Local $aResult = DllCall("user32.dll", "int", "GetSystemMetrics", "int", $iIndex)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetWindowThreadProcessId($hWnd, ByRef $iPID)
Local $aResult = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hWnd, "dword*", 0)
If @error Then Return SetError(@error, @extended, 0)
$iPID = $aResult[2]
Return $aResult[0]
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
Func _WinAPI_InvalidateRect($hWnd, $tRect = 0, $fErase = True)
Local $pRect = 0
If IsDllStruct($tRect) Then $pRect = DllStructGetPtr($tRect)
Local $aResult = DllCall("user32.dll", "bool", "InvalidateRect", "hwnd", $hWnd, "ptr", $pRect, "bool", $fErase)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_MakeLong($iLo, $iHi)
Return BitOR(BitShift($iHi, -16), BitAND($iLo, 0xFFFF))
EndFunc
Func _WinAPI_MoveWindow($hWnd, $iX, $iY, $iWidth, $iHeight, $fRepaint = True)
Local $aResult = DllCall("user32.dll", "bool", "MoveWindow", "hwnd", $hWnd, "int", $iX, "int", $iY, "int", $iWidth, "int", $iHeight, "bool", $fRepaint)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_SetFocus($hWnd)
Local $aResult = DllCall("user32.dll", "hwnd", "SetFocus", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Global Const $_UDF_GlobalIDs_OFFSET = 2
Global Const $_UDF_GlobalID_MAX_WIN = 16
Global Const $_UDF_STARTID = 10000
Global Const $_UDF_GlobalID_MAX_IDS = 55535
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
Global $Debug_CB = False
Global Const $__COMBOBOXCONSTANT_ClassName = "ComboBox"
Global Const $__COMBOBOXCONSTANT_EM_REPLACESEL = 0xC2
Global Const $tagCOMBOBOXINFO = "dword Size;long EditLeft;long EditTop;long EditRight;long EditBottom;long BtnLeft;long BtnTop;" & "long BtnRight;long BtnBottom;dword BtnState;hwnd hCombo;hwnd hEdit;hwnd hList"
Func _GUICtrlComboBox_GetComboBoxInfo($hWnd, ByRef $tInfo)
If $Debug_CB Then __UDF_ValidateClassName($hWnd, $__COMBOBOXCONSTANT_ClassName)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
$tInfo = DllStructCreate($tagCOMBOBOXINFO)
Local $pInfo = DllStructGetPtr($tInfo)
Local $iInfo = DllStructGetSize($tInfo)
DllStructSetData($tInfo, "Size", $iInfo)
Return _SendMessage($hWnd, $CB_GETCOMBOBOXINFO, 0, $pInfo, 0, "wparam", "ptr") <> 0
EndFunc
Func _GUICtrlComboBox_ReplaceEditSel($hWnd, $sText)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Local $tInfo
If _GUICtrlComboBox_GetComboBoxInfo($hWnd, $tInfo) Then
Local $hEdit = DllStructGetData($tInfo, "hEdit")
_SendMessage($hEdit, $__COMBOBOXCONSTANT_EM_REPLACESEL, True, $sText, 0, "wparam", "wstr")
EndIf
EndFunc
Func _GUICtrlComboBox_SetEditSel($hWnd, $iStart, $iStop)
If $Debug_CB Then __UDF_ValidateClassName($hWnd, $__COMBOBOXCONSTANT_ClassName)
If Not HWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Return _SendMessage($hWnd, $CB_SETEDITSEL, 0, _WinAPI_MakeLong($iStart, $iStop)) <> -1
EndFunc
Func _GUICtrlComboBox_SetEditText($hWnd, $sText)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
_GUICtrlComboBox_SetEditSel($hWnd, 0, -1)
_GUICtrlComboBox_ReplaceEditSel($hWnd, $sText)
EndFunc
Func _ClipBoard_RegisterFormat($sFormat)
Local $aResult = DllCall("user32.dll", "uint", "RegisterClipboardFormatW", "wstr", $sFormat)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Global Const $__RICHEDITCONSTANT_WM_USER = 0x400
Global Const $EM_EXGETSEL = $__RICHEDITCONSTANT_WM_USER + 52
Global Const $EM_EXLIMITTEXT = $__RICHEDITCONSTANT_WM_USER + 53
Global Const $EM_FINDTEXTW = $__RICHEDITCONSTANT_WM_USER + 123
Global Const $EM_GETTEXTLENGTHEX = $__RICHEDITCONSTANT_WM_USER + 95
Global Const $EM_HIDESELECTION = $__RICHEDITCONSTANT_WM_USER + 63
Global Const $EM_SETOLECALLBACK = $__RICHEDITCONSTANT_WM_USER + 70
Global Const $EM_SETTEXTEX = $__RICHEDITCONSTANT_WM_USER + 97
Global Const $ST_DEFAULT = 0
Global Const $ST_SELECTION = 2
Global Const $GTL_CLOSE = 4
Global Const $GTL_DEFAULT = 0
Global Const $GTL_NUMBYTES = 16
Global Const $GTL_PRECISE = 2
Global Const $GTL_USECRLF = 1
Global Const $CP_ACP = 0
Global Const $CP_UNICODE = 1200
Global Const $FR_DOWN = 0x1
Global Const $FR_MATCHALEFHAMZA = 0x80000000
Global Const $FR_MATCHCASE = 0x4
Global Const $FR_MATCHDIAC = 0x20000000
Global Const $FR_MATCHKASHIDA = 0x40000000
Global Const $FR_WHOLEWORD = 0x2
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
Global Const $ES_MULTILINE = 4
Global Const $ES_AUTOVSCROLL = 64
Global Const $ES_AUTOHSCROLL = 128
Global Const $ES_NOHIDESEL = 256
Global Const $ES_READONLY = 2048
Global Const $ES_WANTRETURN = 4096
Global Const $EM_LINESCROLL = 0xB6
Global Const $EM_SCROLLCARET = 0x00B7
Global Const $EM_SETSEL = 0xB1
Global Const $__EDITCONSTANT_WS_VSCROLL = 0x00200000
Global Const $__EDITCONSTANT_WS_HSCROLL = 0x00100000
Global Const $GUI_SS_DEFAULT_EDIT = BitOR($ES_WANTRETURN, $__EDITCONSTANT_WS_VSCROLL, $__EDITCONSTANT_WS_HSCROLL, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL)
Func _Iif($fTest, $vTrueVal, $vFalseVal)
If $fTest Then
Return $vTrueVal
Else
Return $vFalseVal
EndIf
EndFunc
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
Global Const $__RICHEDITCONSTANT_WM_SETREDRAW = 0x000B
Global Const $_GCR_S_OK = 0
Global Const $_GCR_E_NOTIMPL = 0x80004001
Global Const $tagCHARRANGE = "long cpMin;long cpMax"
Global Const $tagFINDTEXT = $tagCHARRANGE & ";ptr lpstrText"
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
Func _GUICtrlRichEdit_FindText($hWnd, $sText, $fForward = True, $fMatchCase = False, $fWholeWord = False, $iBehavior = 0)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, -1)
If $sText = "" Then Return SetError(102, 0, -1)
If Not IsBool($fForward) Then Return SetError(103, 0, -1)
If Not IsBool($fMatchCase) Then Return SetError(104, 0, -1)
If Not IsBool($fWholeWord) Then Return SetError(105, 0, -1)
If Not __GCR_IsNumeric($iBehavior) Then Return SetError(1061, 0, -1)
If BitAND($iBehavior, BitNOT(BitOR($FR_MATCHALEFHAMZA, $FR_MATCHDIAC, $FR_MATCHKASHIDA))) <> 0 Then Return SetError(1062, 0, -1)
Local $iLen = StringLen($sText) + 3
Local $tText = DllStructCreate("wchar[" & $iLen & "]")
DllStructSetData($tText, 1, $sText)
Local $tFindtext = DllStructCreate($tagFINDTEXT)
Local $aiAnchorActive
Local $fSel = _GUICtrlRichEdit_IsTextSelected($hWnd)
If $fSel Then
$aiAnchorActive = _GUICtrlRichEdit_GetSelAA($hWnd)
Else
$aiAnchorActive = _GUICtrlRichEdit_GetSel($hWnd)
EndIf
DllStructSetData($tFindtext, 1, $aiAnchorActive[0])
DllStructSetData($tFindtext, 2, _Iif($fForward, -1, 0))
DllStructSetData($tFindtext, 3, DllStructGetPtr($tText))
Local $iWparam = 0
If $fForward Then $iWparam = $FR_DOWN
If $fWholeWord Then $iWparam = BitOR($iWparam, $FR_WHOLEWORD)
If $fMatchCase Then $iWparam = BitOR($iWparam, $FR_MATCHCASE)
$iWparam = BitOR($iWparam, $iBehavior)
Return _SendMessage($hWnd, $EM_FINDTEXTW, $iWparam, DllStructGetPtr($tFindtext), "wparam", "ptr")
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
Func _GUICtrlRichEdit_GetSel($hWnd)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, 0)
Local $tCharRange = DllStructCreate($tagCHARRANGE)
_SendMessage($hWnd, $EM_EXGETSEL, 0, DllStructGetPtr($tCharRange))
Local $aRet[2]
$aRet[0] = DllStructGetData($tCharRange, 1)
$aRet[1] = DllStructGetData($tCharRange, 2)
Return $aRet
EndFunc
Func _GUICtrlRichEdit_GetSelAA($hWnd)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, 0)
Local $aiLowHigh = _GUICtrlRichEdit_GetSel($hWnd)
If $aiLowHigh[0] = $aiLowHigh[1] Then Return SetError(-1, 0, 0)
_SendMessage($hWnd, $EM_SETSEL, -1, 0)
Local $aiNoSel = _GUICtrlRichEdit_GetSel($hWnd)
Local $aRet[2]
If $aiLowHigh[0] = $aiNoSel[0] Then
$aRet[0] = $aiLowHigh[1]
$aRet[1] = $aiLowHigh[0]
Else
$aRet = $aiLowHigh
EndIf
_SendMessage($hWnd, $EM_SETSEL, $aiLowHigh[0], $aiLowHigh[1])
_WinAPI_SetFocus($hWnd)
Return $aRet
EndFunc
Func _GUICtrlRichEdit_GotoCharPos($hWnd, $iCharPos)
_GUICtrlRichEdit_SetSel($hWnd, $iCharPos, $iCharPos)
If @error Then Return SetError(@error, 0, False)
Return True
EndFunc
Func _GUICtrlRichEdit_IsTextSelected($hWnd)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
Local $tCharRange = DllStructCreate($tagCHARRANGE)
_SendMessage($hWnd, $EM_EXGETSEL, 0, DllStructGetPtr($tCharRange))
Return DllStructGetData($tCharRange, 2) <> DllStructGetData($tCharRange, 1)
EndFunc
Func _GUICtrlRichEdit_PauseRedraw($hWnd)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
_SendMessage($hWnd, $__RICHEDITCONSTANT_WM_SETREDRAW, False, 0)
EndFunc
Func _GUICtrlRichEdit_ResumeRedraw($hWnd)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
_SendMessage($hWnd, $__RICHEDITCONSTANT_WM_SETREDRAW, True, 0)
Return _WinAPI_InvalidateRect($hWnd)
EndFunc
Func _GUICtrlRichEdit_ScrollLines($hWnd, $iQlines)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
If Not __GCR_IsNumeric($iQlines) Then SetError(102, 0, False)
Local $iRet = _SendMessage($hWnd, $EM_LINESCROLL, 0, $iQlines)
If $iRet = 0 Then Return SetError(700, 0, False)
Return True
EndFunc
Func _GUICtrlRichEdit_ScrollToCaret($hWnd)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
_SendMessage($hWnd, $EM_SCROLLCARET, 0, 0)
Return True
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
Func _GUICtrlRichEdit_SetText($hWnd, $sText)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
Local $tSetText = DllStructCreate($tagSETTEXTEX)
DllStructSetData($tSetText, 1, $ST_DEFAULT)
DllStructSetData($tSetText, 2, $CP_ACP)
Local $iRet
If StringLeft($sText, 5) <> "{\rtf" And StringLeft($sText, 5) <> "{urtf" Then
DllStructSetData($tSetText, 2, $CP_UNICODE)
$iRet = _SendMessage($hWnd, $EM_SETTEXTEX, DllStructGetPtr($tSetText), $sText, 0, "ptr", "wstr")
Else
$iRet = _SendMessage($hWnd, $EM_SETTEXTEX, DllStructGetPtr($tSetText), $sText, 0, "ptr", "STR")
EndIf
If Not $iRet Then Return SetError(700, 0, False)
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
Func _FO_FileSearch($sPath, $sMask = '*', $fInclude = True, $iDepth = 125, $iFull = 1, $iArray = 1, $iTypeMask = 1, $sLocale = 0)
Local $vFileList
If $sMask = '|' Then Return SetError(2, 0, '')
If StringRight($sPath, 1) <> '\' Then $sPath &= '\'
If Not FileExists($sPath) Then Return SetError(1, 0, '')
If $sMask = '*' Or $sMask = '' Then
__FO_FileSearchAll($vFileList, $sPath, $iDepth)
$vFileList = StringTrimRight($vFileList, 2)
Else
Switch $iTypeMask
Case 0
If StringInStr($sMask, '*') Or StringInStr($sMask, '?') Or StringInStr($sMask, '.') Then
__FO_GetListMask($sPath, $sMask, $fInclude, $iDepth, $vFileList, $sLocale)
Else
__FO_FileSearchType($vFileList, $sPath, '|' & $sMask & '|', $fInclude, $iDepth)
$vFileList = StringTrimRight($vFileList, 2)
EndIf
Case 1
__FO_GetListMask($sPath, $sMask, $fInclude, $iDepth, $vFileList, $sLocale)
Case Else
If StringInStr($sMask, '*') Or StringInStr($sMask, '?') Or StringInStr($sMask, '.') Then Return SetError(2, 0, '')
__FO_FileSearchType($vFileList, $sPath, '|' & $sMask & '|', $fInclude, $iDepth)
$vFileList = StringTrimRight($vFileList, 2)
EndSwitch
EndIf
If Not $vFileList Then Return SetError(3, 0, '')
Switch $iFull
Case 0
$vFileList = StringRegExpReplace($vFileList, '(?m)^(?:.{' & StringLen($sPath) & '})(.*)$', '\1')
Case 2
$vFileList = StringRegExpReplace($vFileList, '(?m)^(?:.*\\)(.*)$', '\1')
Case 3
$vFileList = StringRegExpReplace($vFileList, '(?m)^(?:.*\\)([^\\]*?)(?:\.[^.]+)?$', '\1' & @CR)
$vFileList = StringTrimRight($vFileList, 1)
EndSwitch
Switch $iArray
Case 1
$vFileList = StringSplit($vFileList, @CRLF, 1)
Case 2
$vFileList = StringSplit($vFileList, @CRLF, 3)
EndSwitch
Return $vFileList
EndFunc
Func __FO_GetListMask($sPath, $sMask, $fInclude, $iDepth, ByRef $sFileList, $sLocale)
Local $aFileList, $i, $rgex
__FO_FileSearchMask($sFileList, $sPath, $iDepth)
$sFileList = StringTrimRight($sFileList, 2)
$sMask = StringReplace(StringReplace(StringRegExpReplace($sMask, '[][$^.{}()+]', '\\$0'), '?', '.'), '*', '.*?')
If Not $sLocale Then
$rgex = 'i'
ElseIf Not($sLocale == '1') Then
$rgex = 'i'
$sMask = __FO_UserLocale($sMask, $sLocale)
EndIf
If $fInclude Then
$aFileList = StringRegExp($sFileList, '(?m' & $rgex & ')^(.+\|(?:' & $sMask & '))(?:\r|\z)', 3)
$sFileList = ''
For $i = 0 To UBound($aFileList) - 1
$sFileList &= $aFileList[$i] & @CRLF
Next
Else
$sFileList = StringRegExpReplace($sFileList & @CRLF, '(?m' & $rgex & ')^.+\|(' & $sMask & ')\r\n', '')
EndIf
$sFileList = StringReplace(StringTrimRight($sFileList, 2), '|', '')
EndFunc
Func __FO_UserLocale($sMask, $sLocale)
Local $i, $s, $tmp
$sLocale=StringRegExpReplace($sMask,'[^'&$sLocale&']', '')
$tmp = StringLen($sLocale)
For $i = 1 To $tmp
$s = StringMid($sLocale, $i, 1)
If $s Then
If StringInStr($sLocale, $s, 0, 2, $i) Then
$sLocale = $s&StringReplace($sLocale, $s, '')
EndIf
Else
ExitLoop
EndIf
Next
If $sLocale Then
$tmp = StringSplit($sLocale, '')
For $i = 1 To $tmp[0]
$sMask = StringReplace($sMask, $tmp[$i], '['&StringUpper($tmp[$i])&StringLower($tmp[$i])&']')
Next
EndIf
Return $sMask
EndFunc
Func __FO_FileSearchType(ByRef $sFileList, $sPath, $sMask, $fInclude, $iDepth, $iCurD = 0)
Local $iPos, $sFile, $s = FileFindFirstFile($sPath & '*')
If $s = -1 Then Return
While 1
$sFile = FileFindNextFile($s)
If @error Then ExitLoop
If @extended Then
If $iCurD >= $iDepth Then ContinueLoop
__FO_FileSearchType($sFileList, $sPath & $sFile & '\', $sMask, $fInclude, $iDepth, $iCurD + 1)
Else
$iPos = StringInStr($sFile, ".", 0, -1)
If $iPos And StringInStr($sMask, '|' & StringTrimLeft($sFile, $iPos) & '|') = $fInclude Then
$sFileList &= $sPath & $sFile & @CRLF
ElseIf Not $iPos And Not $fInclude Then
$sFileList &= $sPath & $sFile & @CRLF
EndIf
EndIf
WEnd
FileClose($s)
EndFunc
Func __FO_FileSearchMask(ByRef $sFileList, $sPath, $iDepth, $iCurD = 0)
Local $sFile, $s = FileFindFirstFile($sPath & '*')
If $s = -1 Then Return
While 1
$sFile = FileFindNextFile($s)
If @error Then ExitLoop
If @extended Then
If $iCurD >= $iDepth Then ContinueLoop
__FO_FileSearchMask($sFileList, $sPath & $sFile & '\', $iDepth, $iCurD + 1)
Else
$sFileList &= $sPath & '|' & $sFile & @CRLF
EndIf
WEnd
FileClose($s)
EndFunc
Func __FO_FileSearchAll(ByRef $sFileList, $sPath, $iDepth, $iCurD = 0)
Local $sFile, $s = FileFindFirstFile($sPath & '*')
If $s = -1 Then Return
While 1
$sFile = FileFindNextFile($s)
If @error Then ExitLoop
If @extended Then
If $iCurD >= $iDepth Then ContinueLoop
__FO_FileSearchAll($sFileList, $sPath & $sFile & '\', $iDepth, $iCurD + 1)
Else
$sFileList &= $sPath & $sFile & @CRLF
EndIf
WEnd
FileClose($s)
EndFunc
Func _FO_CorrectMask($sMask)
If StringRegExp($sMask, '[\\/:"<>]') Then Return SetError(2, 0, '|')
If StringInStr($sMask, '**') Then $sMask = StringRegExpReplace($sMask, '\*+', '*')
If StringRegExp($sMask & '|', '[\s|.]\|') Then $sMask = StringRegExpReplace($sMask & '|', '[\s|.]+\|', '|')
If StringInStr('|' & $sMask & '|', '|*|') Then Return '*'
If $sMask = '|' Then Return SetError(2, 0, '|')
If StringRight($sMask, 1) = '|' Then $sMask = StringTrimRight($sMask, 1)
If StringLeft($sMask, 1) = '|' Then $sMask = StringTrimLeft($sMask, 1)
__FO_MaskUnique($sMask)
Return $sMask
EndFunc
Func __FO_MaskUnique(ByRef $sMask)
	Local $t = StringReplace($sMask, '[', Chr(1)), $a = StringSplit($t, '|'), $k = 0, $i
	Assign('/', '', 1)
	For $i = 1 To $a[0]
		If Not IsDeclared($a[$i] & '/') Then
			$k += 1
			$a[$k] = $a[$i]
		EndIf
		Assign($a[$i] & '/', '', 1)
	Next
	If $k <> $a[0] Then
		$sMask = ''
		For $i = 1 To $k
			$sMask &= $a[$i] & '|'
		Next
		$sMask = StringReplace(StringTrimRight($sMask, 1), Chr(1), '[')
	EndIf
EndFunc   
Func _FO_PathSplit($sPath)
Local $i, $aPath[3]
$i = StringInStr($sPath, '\', 0, -1)
$aPath[1] = StringTrimLeft($sPath, $i)
$aPath[0] = StringLeft($sPath, $i)
If StringInStr($aPath[1], '.') Then
$i = StringInStr($aPath[1], '.', 0, -1) - 1
$aPath[2] = StringTrimLeft($aPath[1], $i)
$aPath[1] = StringLeft($aPath[1], $i)
Else
$aPath[2] = ''
EndIf
Return $aPath
EndFunc
Func _FO_IsDir($sTmp)
$sTmp = FileGetAttrib($sTmp)
Return SetError(@error, 0, StringInStr($sTmp, 'D', 2) > 0)
EndFunc
Func _SetCoor(ByRef $WHXY, $d=0)
Local $Xtmp, $Ytmp, $aWA
$Frm=_WinAPI_GetSystemMetrics(32)*2
$CpT=_WinAPI_GetSystemMetrics(4) + _WinAPI_GetSystemMetrics(33)*2
$WHXY[0] = $WHXY[0] + $Frm
$WHXY[1] = $WHXY[1] + $CpT - $d
$aWA = _WinAPI_GetWorkingArea()
ReDim $aWA[6]
$aWA[4] = $aWA[2]-$aWA[0]
$aWA[5] = $aWA[3]-$aWA[1]
$Xtmp=Number($WHXY[2])
$Ytmp=Number($WHXY[3])
If $Xtmp < 0 And $Xtmp <>-1 Then $Xtmp=0
If $WHXY[0] >= $aWA[4] Then
$WHXY[0] = $aWA[4]
$Xtmp=0
EndIf
If $Xtmp > $aWA[4]-$WHXY[0] Then $Xtmp=$aWA[4]-$WHXY[0]
If $WHXY[2]='' Then $Xtmp=-1
If $Ytmp < 0 And $Ytmp <>-1 Then $Ytmp=0
If $WHXY[1] >= $aWA[5] Then
$WHXY[1] = $aWA[5]
$Ytmp=0
EndIf
If $Ytmp > $aWA[5]-$WHXY[1] Then $Ytmp=$aWA[5]-$WHXY[1]
If $WHXY[3]='' Then $Ytmp=-1
$WHXY[0] = $WHXY[0] - $Frm
$WHXY[1] = $WHXY[1] - $CpT + $d
$WHXY[2]=$Xtmp+$aWA[0]
$WHXY[3]=$Ytmp+$aWA[1]
EndFunc
Func _CRLF($CRLF, ByRef $Search, ByRef $Replace)
Switch StringLen($CRLF)
Case 1
$Search=StringReplace($Search, $CRLF, @CRLF)
$Replace=StringReplace($Replace, $CRLF, @CRLF)
Case 2 To 255
$CRLF = StringSplit($CRLF, '')
If $CRLF[1] = $CRLF[2] Then
$Search=StringReplace($Search, $CRLF[1], @CRLF)
$Replace=StringReplace($Replace, $CRLF[1], @CRLF)
Else
$Search=StringReplace($Search, $CRLF[1], @CR)
$Search=StringReplace($Search, $CRLF[2], @LF)
$Replace=StringReplace($Replace, $CRLF[1], @CR)
$Replace=StringReplace($Replace, $CRLF[2], @LF)
EndIf
EndSwitch
EndFunc
Func _restart()
Local $sAutoIt_File = @TempDir & "\~Au3_ScriptRestart_TempFile.au3"
Local $sRunLine, $sScript_Content, $hFile
$sRunLine = @ScriptFullPath
If Not @Compiled Then $sRunLine = @AutoItExe & ' /AutoIt3ExecuteScript ""' & $sRunLine & '""'
If $CmdLine[0] > 0 Then $sRunLine &= ' ' & $CmdLineRaw
$sScript_Content &= '#NoTrayIcon' & @CRLF & _
'While ProcessExists(' & @AutoItPID & ')' & @CRLF & _
'   Sleep(10)' & @CRLF & _
'WEnd' & @CRLF & _
'Run("' & $sRunLine & '")' & @CRLF & _
'FileDelete(@ScriptFullPath)' & @CRLF
$hFile = FileOpen($sAutoIt_File, 2)
FileWrite($hFile, $sScript_Content)
FileClose($hFile)
Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sAutoIt_File & '"', @ScriptDir, @SW_HIDE)
Sleep(1000)
Exit
EndFunc
Func _FileAssociation($sExt)
Local $aCall = DllCall("shlwapi.dll", "int", "AssocQueryStringW", _
"dword", 0x00000040, _
"dword", 2, _
"wstr", $sExt, _
"ptr", 0, _
"wstr", "", _
"dword*", 65536)
If @error Then Return SetError(1, 0, "")
If Not $aCall[0] Then
Return SetError(0, 0, $aCall[5])
ElseIf $aCall[0] = 0x80070002 Then
Return SetError(1, 0, "{unknown}")
ElseIf $aCall[0] = 0x80004005 Then
Return SetError(1, 0, "{fail}")
Else
Return SetError(2, $aCall[0], "")
EndIf
EndFunc
Func _ConvertFileSize($iBytes)
Local Const $iConst = 0.0000234375
Switch $iBytes
Case 110154232090684 To 1125323453007766
$iBytes = Round($iBytes /(1099511627776 + $iBytes * $iConst)) & ' TB'
Case 1098948684577 To 110154232090683
$iBytes = Round($iBytes /(1099511627776 + $iBytes * $iConst), 1) & ' TB'
Case 107572492277 To 1098948684576
$iBytes = Round($iBytes /(1073741824 + $iBytes * $iConst)) & ' GB'
Case 1073192075 To 107572492276
$iBytes = Round($iBytes /(1073741824 + $iBytes * $iConst), 1) & ' GB'
Case 105156613 To 1073192074
$iBytes = Round($iBytes /(1048576 + $iBytes * $iConst)) & ' MB'
Case 1048040 To 105156612
$iBytes = Round($iBytes /(1048576 + $iBytes * $iConst), 1) & ' MB'
Case 102693 To 1048039
$iBytes = Round($iBytes /(1024 + $iBytes * $iConst)) & ' KB'
Case 1024 To 102692
$iBytes = Round($iBytes /(1024 + $iBytes * $iConst), 1) & ' KB'
Case 0 To 1023
$iBytes = Int($iBytes / 1.024)
EndSwitch
Return $iBytes
EndFunc
Func _ProcessGetPath($PID)
If IsString($PID) Then $PID = ProcessExists($PID)
$Path = DllStructCreate('char[1000]')
$dll = DllOpen('Kernel32.dll')
$handle1 = DllCall($dll, 'int', 'OpenProcess', 'dword', 0x0400 + 0x0010, 'int', 0, 'dword', $PID)
$ret = DllCall('Psapi.dll', 'long', 'GetModuleFileNameEx', 'long', $handle1[0], 'int', 0, 'ptr', DllStructGetPtr($Path), 'long', DllStructGetSize($Path))
$ret = DllCall($dll, 'int', 'CloseHandle', 'hwnd', $handle1[0])
DllClose($dll)
Return DllStructGetData($Path, 1)
EndFunc
Func _WinAPI_LoadKeyboardLayout($sLayoutID, $hWnd = 0)
Local Const $WM_INPUTLANGCHANGEREQUEST = 0x50
Local $aRet = DllCall("user32.dll", "long", "LoadKeyboardLayoutW", "wstr", Hex($sLayoutID, 8), "int", 0)
If Not @error And $aRet[0] Then
If $hWnd = 0 Then
$hWnd = WinGetHandle(AutoItWinGetTitle())
EndIf
DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hWnd, "int", $WM_INPUTLANGCHANGEREQUEST, "int", 1, "int", $aRet[0])
Return 1
EndIf
Return SetError(1)
EndFunc
Func _ChildCoor($Gui, $w, $h, $c=0, $d=0)
Local $aWA = _WinAPI_GetWorkingArea(), _
$GP = WinGetPos($Gui), _
$wgcs=WinGetClientSize($Gui), _
$dLeft=($GP[2]-$wgcs[0])/2, _
$dTor=$GP[3]-$wgcs[1]-$dLeft
If $c = 0 Then
$GP[0]=$GP[0]+($GP[2]-$w)/2-$dLeft
$GP[1]=$GP[1]+($GP[3]-$h-$dLeft-$dTor)/2
EndIf
If $d>($aWA[2]-$aWA[0]-$w-$dLeft*2)/2 Or $d>($aWA[3]-$aWA[1]-$h-$dLeft+$dTor)/2 Then $d=0
If $GP[0]+$w+$dLeft*2+$d>$aWA[2] Then $GP[0]=$aWA[2]-$w-$d-$dLeft*2
If $GP[1]+$h+$dLeft+$dTor+$d>$aWA[3] Then $GP[1]=$aWA[3]-$h-$dLeft-$dTor-$d
If $GP[0]<=$aWA[0]+$d Then $GP[0]=$aWA[0]+$d
If $GP[1]<=$aWA[1]+$d Then $GP[1]=$aWA[1]+$d
$GP[2]=$w
$GP[3]=$h
Return $GP
EndFunc
Func _WinAPI_GetWorkingArea()
Local Const $SPI_GETWORKAREA = 48
Local $stRECT = DllStructCreate("long; long; long; long")
Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
If @error Then Return 0
If $SPIRet[0] = 0 Then Return 0
Local $sLeftArea = DllStructGetData($stRECT, 1)
Local $sTopArea = DllStructGetData($stRECT, 2)
Local $sRightArea = DllStructGetData($stRECT, 3)
Local $sBottomArea = DllStructGetData($stRECT, 4)
Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
Return $aRet
EndFunc
Global $sLocale = 0
If $CmdLine[0] > 2 Then _RunCMD()
Opt("GUIOnEventMode", 1)
Opt("GUIResizeMode", 0x0322) 
Global $sep = Chr(1)
Opt("GUIDataSeparatorChar", $sep)
Global $iScroll_Pos, $Gui, $Gui1, $nLAbt, $hAbt, $wAbtBt, $TrAbt1, $TrAbt2, $tabAbt1, $StopPlay, $vk1, $BkCol2, $tabAbt0, $BkCol1
Global $ScrStart, $ScrPath, $aTextScr = '', $aScenario = '', $TrStop = 0
Global $aTypInp0[1], $iniAa = 0, $inisub = 0, $iniOutRes = 0, $restext = '', $SeaInp0, $RepInp0, $TypInp0, $PatInp0, $Out0, $WHXY[5], $RichPos[5], $lng, $iniSep = '}—•—{'
Global $TrEx = 0, $TrScr = 0, $MinSizeH, $MaxSizeH
Global $iniSea, $iniRep, $iniMask, $iniDef = '*' & $sep & '*.inf' & $sep & '*.bat|*.cmd' & $sep & '*.htm*' & $sep & '*.reg' & $sep & '*.txt' & $sep & '*.au3', $iniPath, $iniAa = 0, $inisub = 0, $iniBAK = 0, $iniREx = 0, $iniExc = 0, $ReData = 0, $ChData
Global $Ini = @ScriptDir & '\TextReplace.ini'
Global $LangPath, $ComboLang, $iniLimitFile, $iniLimitSize, $InpLimitFile, $InpLimitSize, $InpErrSize, $iniErrSize = 180 * 1024 * 1024, $iniPathBackup, $InpPathBackup, $LbPathBackup, $LbLimitFile, $LbLimitSize, $InpHst, $LbHst, $KolStr, $atrR, $atrA, $atrH, $atrS, $ExcldAttrib = '', $IgnGr, $CharSet, $CharSetAuto, $ComboChar, $LbChS, $LbErrSize
$BackUpPath = ''
Global $aSearch[1][2] = [[0]], $Tr_ViewT = -1, $Tr_View = True, $Tr_Sea = 0
Global $EditBoxSea, $EditBoxRep
Global $Btn_Next, $Btn_Back, $Combo_Jump, $hRichEdit
$hf = ''
$lng_hf = RegRead("HKCU\Keyboard Layout\Preload", 1)
If $lng_hf = 00000419 Then $hf = 'а'
If $lng_hf = 00000409 Then $hf = 'f'
If Not FileExists($Ini) Then
$file = FileOpen($Ini, 2)
FileWrite($file, _
'[Set]' & @CRLF & _
'Search=Text1' & $iniSep & 'Text2' & @CRLF & _
'Replace=Text11' & $iniSep & 'Text22' & @CRLF & _
'Mask=' & StringReplace($iniDef, $sep, $iniSep) & @CRLF & _
'DefaultMask=' & StringReplace($iniDef, $sep, $iniSep) & @CRLF & _
'Path=C:\WINDOWS\inf' & $iniSep & 'C:\Program Files\Notepad++' & @CRLF & _
'Aa=0' & @CRLF & _
'sub=1' & @CRLF & _
'REx=0' & @CRLF & _
'BAK=0' & @CRLF & _
'OutRes=0' & @CRLF & _
'ExceptMask=0' & @CRLF & _
'LimitFile=20000' & @CRLF & _
'LimitSize=100' & @CRLF & _
'ErrSize=' & $iniErrSize & @CRLF & _
'History=10' & @CRLF & _
'PathBackup=' & @CRLF & _
'CharSet=Auto' & @CRLF & _
'PosL=30' & @CRLF & _
'PosT=30' & @CRLF & _
'PosW=361' & @CRLF & _
'PosH=480' & @CRLF & _
'PosMax=0' & @CRLF & _
'RichW=790' & @CRLF & _
'RichH=500' & @CRLF & _
'RichL=' & @CRLF & _
'RichT=' & @CRLF & _
'RichMax=0' & @CRLF & _
'Lang=')
FileClose($file)
EndIf
$LngScrollAbt = 'The tool is designed' & @CRLF & _
'to find and replace text in any files. The program supports scenarios replace, regular expressions, command line.' & @CRLF & @CRLF & _
'All parameters of the script commands are unique and do not depend on the current program settings. ' & _
'The button is designed to create backup copies of changed files in the specified directory or the default program directory. ' & @CRLF & @CRLF & _
'The utility is written in AutoIt3' & @CRLF & _
'autoitscript.com'
Global $aLng0[97][2] = [[ 96, 0],[ 'Title', 'TextReplace'],[ 'About', 'About'],[ 'Ver', 'Version'],[ 'Site', 'Site'],[ 'Copy', 'Copy'],[ 'Sb1', 'StatusBar		( drag-and-drop )'],[ 'AaH1', 'Current:' & @CRLF & 'not case sensitive'],[ 'AaH2', 'Current:' & @CRLF & 'case sensitive'],[ 'RExH1', 'Current:' & @CRLF & 'Do not use regular expression'],[ 'RExH2', 'Current:' & @CRLF & 'Use regular expression'],[ 'SubH1', 'Current:' & @CRLF & 'Search only in the root directory'],[ 'SubH2', 'Current:' & @CRLF & 'Search in subfolders'],[ 'BAKH1', 'Current:' & @CRLF & 'Do not backup'],[ 'BAKH2', 'Current:' & @CRLF & 'Do backup'],[ 'OutRH1', 'Current:' & @CRLF & 'Results not show'],[ 'OutRH2', 'Current:' & @CRLF & 'Results show of searching for'],[ 'RBrH', 'Viewing search results'],[ 'CRLF', 'Symbol CRLF'],[ 'CRLFH', 'Select symbol CRLF'],[ 'PSmb', 'Add'],[ 'Sea', 'Find'],[ 'Rep', 'Replace'],[ 'OScr', 'Open *.srt'],[ 'AScr', 'Add in *.srt'],[ 'Cr', 'Clear'],[ 'Msk', 'Mask'],[ 'Def', 'Default'],[ 'Pth', 'Path'],[ 'Ed', 'Editor'],[ 'EdH', 'Open in editor (txt)'],[ 'St', 'Execute'],[ 'StH', 'Start'],[ 'Sp', 'Esc - Stop'],[ 'Err', 'Error'],[ 'MB1', 'Path is not specified or does not exist'],[ 'MB2', 'Not a text of searching'],[ 'MB3', 'Lines of searching for and change alike or not a text of searching'],[ 'MB4', 'It Is Required open *.srt'],[ 'MB5', 'no data'],[ 'MB6', 'Such already there is in list'],[ 'Sb2', 'Searching / count of the files ...'],[ 'Sb3', 'Nothing be not found, for'],[ 'Sb4', '(total / checked / found), for'],[ 'SbS', 'sec'],[ 'Sb5', 'Searching / Replace ...'],[ 'SVD', 'Select/Create file'],[ 'SVD1', 'file'],[ 'OD', 'Select'],[ 'OD1', 'Any'],[ 'OF', 'Select'],[ 'G1T', 'List'],[ 'LV1', 'Find'],[ 'LV2', 'Replace'],[ 'US', 'Use'],[ 'USH', 'Use all'],[ 'Sl', 'Choose file'],[ 'Rest', 'Restart TextReplace'],[ 'EdF', 'Editor+F'],[ 'EdFH', 'Open in editor (txt) and find'],[ 'Epr', 'Explorer'],[ 'MLineSH', 'Searching for multiline text'],[ 'MLineRH', 'Searching and replace for multiline text'],[ 'bSet', 'Setting'],[ 'SzFl', 'Warn volume files over, MB'],[ 'MFile', 'Warn if number of files over'],[ 'SzEr', 'Maximum file size, KB' & @CRLF & 'with more than ~190 MB get the error memory'],[ 'BakPh', 'The path to the backup folder'],[ 'Hst', 'Number of items in the ComboBox'],[ 'MB7', 'The number of files ('],[ 'MB8', ') exceeds the limit specified in the settings ('],[ 'MB9', '). Continue processing?'],[ 'MB10', 'Volume occupied by the file ('],[ 'MB11', 'MB) exceeds the limit specified in the settings ('],[ 'MB12', 'MB). Continue processing?'],[ 'MB13', 'The specified volume occupied by the file is not a positive number '],[ 'MB14', 'Specified number of files is not a positive integer'], ['MB15', 'Specified number of points of history is not a number from 1 to 50'],['MB16', 'The specified path is invalid for the backup and can not be created. Enter the correct path otherwise the backups will be created in the program folder.'],[ 'ExcH1', 'Current:' & @CRLF & 'The mask specifies the files'],[ 'ExcH2', 'Current:' & @CRLF & 'No files specified in the mask'],[ 'MB17', 'Disk backup is not available for copying or path is not valid. Want to continue without backup?'],[ 'MB18', 'Cancel operation. Specified in the script path does not exist'],[ 'MB19', 'Number of characters in a string search and replace must be an even'],[ 'MB20', 'Turn on the display of detailed results and next do a search.'],[ 'IgnGr', 'Ignore files with attributes'],[ 'AtrR', 'read-only'],[ 'AtrA', 'archival'],[ 'AtrH', 'hidden'],[ 'AtrS', 'System'],[ 'Data', 'Do not change the modification date of files'],[ 'ChS', 'CharSet'],[ 'Nxt', 'Next'],[ 'Bck', 'Back'],[ 'TTp', 'Close'],['Lst', 'To clipboard'],[ 'Cnl', 'Cancel']]


If @OSLang = 0419 Then
$sLocale = 'А-яЁё'
$LngScrollAbt = 'Утилита предназначена' & @CRLF & _
'для поиска и замены текста в любых файлах. Поддержка сценариев замены, регулярных выражений, ком-строки.' & @CRLF & @CRLF & _
'Символ переноса строк - простой способ выполнить поиск и замену многострочного текста. В качестве переноса строк выбирается подстановочный символ, которого нет в тексте поиска и замены, и используем этот символ в полях ввода поиска и замены. ' & _
'Сценарий замены можно создать средствами TextReplace, или открыть в блокноте и вручную править и добавлять комментарии. ' & _
'Все параметры команды сценария являются индивидуальными и не зависят от текущих настроек программы. ' & _
'Кнопка резервирования включает операцию создания копий изменяемых файлов в указанном каталоге или по умолчанию в каталоге программы. ' & @CRLF & @CRLF & _
'Утилита написана на AutoIt3' & @CRLF & _
'autoitscript.com'
Dim $aLng0[97][2] = [[96, 0],['Title', 'TextReplace'],['About', 'О программе'],['Ver', 'Версия'],['Site', 'Сайт'],['Copy', 'Копировать'],['Sb1', 'Строка состояния		( используйте drag-and-drop )'],['AaH1', 'Текущее состояние:\r\nне учитывать регистр букв'],['AaH2', 'Текущее состояние:\r\nучитывать регистр букв'],['RExH1', 'Текущее состояние:\r\nНе использовать регулярное выражение\r\nРекомендуется'],['RExH2', 'Текущее состояние:\r\nИспользовать регулярное выражение\r\nНе рекомендуется'],['SubH1', 'Текущее состояние:\r\nпоиск только в корневой папке'],['SubH2', 'Текущее состояние:\r\nпоиск во вложенных папках'],['BAKH1', 'Текущее состояние:\r\nНе бэкапировать изменяемые файлы'],['BAKH2', 'Текущее состояние:\r\nБэкапировать изменяемые файлы'],['OutRH1', 'Текущее состояние:\r\nНе выводить результаты поиска'],['OutRH2', 'Текущее состояние:\r\nВыводить результаты поиска'],['RBrH', 'Просмотр результатов поиска'],['CRLF', 'Символ переноса строк'],['CRLFH', 'Выберите подстановочный знак для переноса строки\r\nи используйте его в полях ввода поиска и замены'],['PSmb', 'Добавить'],['Sea', 'Найти текст'],['Rep', 'Заменить текст на ...'],['OScr', 'Открыть сценарий замены'],['AScr', 'Добавить образцы в сценарий'],['Cr', 'Очистить поле ввода'],['Msk', 'Маска'],['Def', 'Сброс раскрывающегося списка\r\nмаски по умолчанию'],['Pth', 'Путь, где искать'],['Ed', 'Редактор'],['EdH', 'Открыть в редакторе'&@CRLF&'ассоциированным с txt'],['St', 'Выполнить'],['StH', 'Запуск в ассоциированной программе'],['Sp', 'Esc - Отмена'],['Err', 'Сообщение'],['MB1', 'Путь не указан или не существует'],['MB2', 'Не указан текст поиска'],['MB3', 'Строки поиска и замены одинаковы или не указан текст поиска'],['MB4', 'Требуется открыть сценарий'],['MB5', 'нет данных'],['MB6', 'Такой уже есть в списке'],['Sb2', 'Поиск / подсчёт файлов и объёма ...'],['Sb3', 'Ничего не найдено, за'],['Sb4', '(всего / проверено / найдено), за'],['SbS', 'сек'],['Sb5', 'Поиск и замена ...'],['SVD', 'Указать/Создать файл'],['SVD1', 'Сценарий'],['OD', 'Указать файл'],['OD1', 'Любой'],['OF', 'Указать папку'],['G1T', 'Список замен'],['LV1', 'найти'], _
['LV2', 'заменить'],['US', 'Использовать сценарий'],['USH', 'Для последовательной замены по текущему списку'],['Sl', 'Выбрать файл'],['Rest', 'Перезапуск утилиты'],['EdF', 'Редактор+F'],['EdFH', 'Открыть в редакторе ассоциированным'&@CRLF&'с txt-файлами и выполнить поиск'],['Epr', 'В проводнике'],['MLineSH', 'Поиск многострочного текста'],['MLineRH', 'Поиск и замена для многострочного текста'],['bSet', 'Настройки'],['SzFl', 'Предупреждать, если объём файлов более, МБ'],['MFile', 'Предупреждать, если количество файлов более'],['SzEr', 'Максимальный размер файлов, КБ'&@CRLF&'при более ~190 МБ получим ошибку памяти'],['BakPh', 'Путь к резервной папке'],['Hst', 'Количество пунктов в раскрывающемся списке'],['MB7', 'Количество файлов ('],['MB8', ') превышает указанный в настройках лимит ('],['MB9', '). Продолжить обработку?'],['MB10', 'Объём файлов ('],['MB11', 'МБ) превышает указанный в настройках лимит ('],['MB12', 'МБ). Продолжить обработку?'],['MB13', 'Указанный объём файлов не является положительным числом'],['MB14', 'Указанное количество файлов не является положительным целым числом'],['MB15', 'Указанное количество пунктов истории не является числом от 1 до 50'],['MB16', 'Указанный путь для резервных копий невалидный и не может быть создан. Укажите правильно путь иначе резервные копии будут созданы в папке программы.'],['ExcH1', 'Текущее состояние:'&@CRLF&'Файлы определяемые маской'],['ExcH2', 'Текущее состояние:'&@CRLF&'Кроме файлов определяемых маской'],['MB17', 'Диск резервирования не доступен для копирования'&@CRLF&'или неверно указан путь. Хотите продолжить без  резервирования?'],['MB18', 'Отмена операции. Указанные в сценарии пути не существуют'],['MB19', 'Количество символов в строке поиска и замены должно быть чётное'],['MB20', 'Включите режим вывода подробных результатов и далее сделайте поиск.'],['IgnGr', 'Игнорировать файлы с атрибутами'],['AtrR', 'Только чтение'],['AtrA', 'Архивный'],['AtrH', 'Скрытый'],['AtrS', 'Системный'],['Data', 'Дату изменения файлов отставлять прежней'],['ChS', 'Кодировка'],['Nxt', 'Далее'],['Bck', 'Назад'],['TTp', 'Закрыть'],['Lst', 'В буфер обмена'],['Cnl', 'Отмена']]
EndIf
For $i = 1 To $aLng0[0][0]
If StringInStr($aLng0[$i][1], '\r\n') Then $aLng0[$i][1] = StringReplace($aLng0[$i][1], '\r\n', @CRLF)
Assign('Lng' & $aLng0[$i][0], $aLng0[$i][1])
Next
$LangPath = IniRead($Ini, 'Set', 'Lang', 'none')
If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then
$aLng = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng')
If Not @error Then
For $i = 1 To $aLng[0][0]
If StringInStr($aLng[$i][1], '\r\n') Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\r\n', @CRLF)
If IsDeclared('Lng' & $aLng[$i][0]) Then Assign('Lng' & $aLng[$i][0], $aLng[$i][1])
Next
EndIf
EndIf
$iniSea = StringReplace(IniRead($Ini, 'Set', 'Search', ''), $iniSep, $sep)
$iniRep = StringReplace(IniRead($Ini, 'Set', 'Replace', ''), $iniSep, $sep)
$iniDef = StringReplace(IniRead($Ini, 'Set', 'DefaultMask', $iniDef), $iniSep, $sep)
$iniMask = StringReplace(IniRead($Ini, 'Set', 'Mask', $iniDef), $iniSep, $sep)
$iniPath = StringReplace(IniRead($Ini, 'Set', 'Path', ''), $iniSep, $sep)
$iniAa = Number(IniRead($Ini, 'Set', 'Aa', '0'))
$inisub = Number(IniRead($Ini, 'Set', 'sub', '0'))
$iniREx = Number(IniRead($Ini, 'Set', 'REx', '0'))
$iniBAK = Number(IniRead($Ini, 'Set', 'BAK', '0'))
$iniOutRes = Number(IniRead($Ini, 'Set', 'OutRes', '0'))
$iniExc = Number(IniRead($Ini, 'Set', 'ExceptMask', '0'))
$WHXY[0] = Number(IniRead($Ini, 'Set', 'PosW', '361'))
$WHXY[1] = Number(IniRead($Ini, 'Set', 'PosH', '480'))
$WHXY[2] = IniRead($Ini, 'Set', 'PosL', '30')
$WHXY[3] = IniRead($Ini, 'Set', 'PosT', '30')
$WHXY[4] = Number(IniRead($Ini, 'Set', 'PosMax', ''))
$iniPathBackup = IniRead($Ini, 'Set', 'PathBackup', '')
$iniLimitFile = Int(IniRead($Ini, 'Set', 'LimitFile', '20000'))
If $iniLimitFile < 1 Then $iniLimitFile = 20000
$iniLimitSize = Number(IniRead($Ini, 'Set', 'LimitSize', '100'))
If $iniLimitSize <= 0 Then $iniLimitSize = 100
$iniErrSize = Number(IniRead($Ini, 'Set', 'ErrSize', 188000000))
If $iniErrSize <= 0 Then $iniErrSize = 180 * 1024 * 1024
$KolStr = Int(IniRead($Ini, 'Set', 'History', '10'))
If $KolStr < 1 Or $KolStr > 50 Then $KolStr = 10
$CharSet = _CharNameToNum(IniRead($Ini, 'Set', 'CharSet', 'Auto'))
If $WHXY[0] < 361 Then $WHXY[0] = 361 
If $WHXY[1] < 360 Then $WHXY[1] = 360 
_SetCoor($WHXY, 35)
$Editor = _FileAssociation('.txt') 
If @error Then $Editor = @SystemDir & '\notepad.exe'
$Gui = GUICreate($LngTitle, $WHXY[0], 250, $WHXY[2], $WHXY[3], BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPCHILDREN), $WS_EX_ACCEPTFILES)
Global $aPosH2 = WinGetPos($Gui)
$MinSizeH = $aPosH2[3]
$MaxSizeH = $aPosH2[3]
GUISetOnEvent($GUI_EVENT_CLOSE, "_Quit")
GUISetOnEvent($GUI_EVENT_RESIZED, "_Resized")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "_Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "_Restore")
If @Compiled Then
$AutoItExe = @AutoItExe
Else
$AutoItExe = @ScriptDir & '\TextReplace.dll'
GUISetIcon($AutoItExe, 1)
If Not FileExists($AutoItExe) Then GUISetIcon("shell32.dll", -23)
EndIf
$StatusBar = GUICtrlCreateLabel($LngSb1, 5, 233, $WHXY[0] - 10, 15, 0xC)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)
$About = GUICtrlCreateButton("@", $WHXY[0] - 235, 2, 18, 20)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetTip(-1, $LngAbout)
GUICtrlSetOnEvent(-1, "_About")
$restart = GUICtrlCreateButton("R", $WHXY[0] - 215, 2, 18, 20)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetTip(-1, $LngRest)
GUICtrlSetOnEvent(-1, "_restart")
$AaBut = GUICtrlCreateCheckbox("--", 5, 5, 24, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 206, 0)
GUICtrlSetOnEvent(-1, "_AaBut")
If $iniAa Then
GUICtrlSetTip(-1, $LngAaH2)
GUICtrlSetState(-1, 1)
Else
GUICtrlSetTip(-1, $LngAaH1)
EndIf
$RExBut = GUICtrlCreateCheckbox("--", 35, 5, 24, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 207, 0)
GUICtrlSetOnEvent(-1, "_RExBut")
If $iniREx Then
GUICtrlSetTip($RExBut, $LngRExH2)
GUICtrlSetState(-1, 1)
GUICtrlSetState($AaBut, $GUI_DISABLE)
Else
GUICtrlSetTip($RExBut, $LngRExH1)
GUICtrlSetState($AaBut, $GUI_ENABLE)
EndIf
$BAKBut = GUICtrlCreateCheckbox("--", 65, 5, 24, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 209, 0)
GUICtrlSetOnEvent(-1, "_BAKBut")
If $iniBAK Then
GUICtrlSetTip($BAKBut, $LngBAKH2)
GUICtrlSetState(-1, 1)
Else
GUICtrlSetTip($BAKBut, $LngBAKH1)
EndIf
GUICtrlCreateButton('Set', 95, 5, 24, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 210, 0)
GUICtrlSetTip(-1, $LngbSet)
GUICtrlSetOnEvent(-1, "_Setting")
$SubBut = GUICtrlCreateCheckbox("--", 120, 180, 24, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 208, 0)
GUICtrlSetOnEvent(-1, "_SubBut")
If $inisub Then
GUICtrlSetTip(-1, $LngSubH2)
GUICtrlSetState(-1, 1)
Else
GUICtrlSetTip(-1, $LngSubH1)
EndIf
$TypClear = GUICtrlCreateButton("X", 120, 130, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngCr)
GUICtrlSetImage(-1, $AutoItExe, 203, 0)
GUICtrlSetOnEvent(-1, "_Clear")
$ExcBut = GUICtrlCreateCheckbox("--", 150, 130, 24, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 211, 0)
GUICtrlSetOnEvent(-1, "_ExcBut")
If $iniExc Then
GUICtrlSetTip($ExcBut, $LngExcH2)
GUICtrlSetState(-1, 1)
Else
GUICtrlSetTip($ExcBut, $LngExcH1)
EndIf
$TypDef = GUICtrlCreateButton("Def", 180, 130, 26, 24)
GUICtrlSetTip(-1, $LngDef)
GUICtrlSetOnEvent(-1, "_DefaultMask")
$SeaClear = GUICtrlCreateButton("X", 120, 30, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngCr)
GUICtrlSetImage(-1, $AutoItExe, 203, 0)
GUICtrlSetOnEvent(-1, "_Clear")
$MLineS = GUICtrlCreateButton("SM", 150, 30, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngMLineSH)
GUICtrlSetImage(-1, $AutoItExe, 217, 0)
GUICtrlSetOnEvent(-1, "_EditBox")
$OutRBut = GUICtrlCreateCheckbox("swr", 180, 30, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 212, 0)
GUICtrlSetOnEvent(-1, "_OutRBut")
If $iniOutRes Then
GUICtrlSetTip(-1, $LngOutRH2)
GUICtrlSetState(-1, 1)
Else
GUICtrlSetTip(-1, $LngOutRH1)
EndIf
$RBrBut = GUICtrlCreateButton("--", 210, 30, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 213, 0)
GUICtrlSetOnEvent(-1, "_Res_Byfer")
GUICtrlSetTip(-1, $LngRBrH)
$RepClear = GUICtrlCreateButton("X", 120, 80, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngCr)
GUICtrlSetImage(-1, $AutoItExe, 203, 0)
GUICtrlSetOnEvent(-1, "_Clear")
$MLineR = GUICtrlCreateButton("RM", 150, 80, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngMLineRH)
GUICtrlSetImage(-1, $AutoItExe, 217, 0)
GUICtrlSetOnEvent(-1, "_EditBoxM")
$ScrRep = GUICtrlCreateButton("Scr", 180, 80, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngOScr)
GUICtrlSetImage(-1, $AutoItExe, 205, 0)
GUICtrlSetOnEvent(-1, "_ScrRep")
$AddRep = GUICtrlCreateButton("Add", 210, 80, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngAScr)
GUICtrlSetImage(-1, $AutoItExe, 204, 0)
GUICtrlSetOnEvent(-1, "_AddRep")
$specsymbol = $sep & ChrW(0x00A9) & $sep & ChrW(0x00AE) & $sep & ChrW(0x00AB) & $sep & ChrW(0x00BB) & $sep & ChrW(0x2030) & $sep & ChrW(0x00A7) & $sep & ChrW(0x00B5) & $sep & ChrW(0x20AC) & $sep & ChrW(0x2122)
$CRLF = GUICtrlCreateCombo("", $WHXY[0] - 65, 2, 54)
GUICtrlSetData(-1, $sep & $sep & '~' & $sep & '@' & $sep & '%' & $sep & '&' & $sep & '*' & $sep & '^' & $sep & '#' & $sep & '\' & $sep & '/' & $sep & '+' & $sep & '-' & $sep & '_' & $sep & '{' & $sep & '}' & $sep & '[' & $sep & ']' & $sep & '`' & $sep & '<' & $sep & '>' & $specsymbol, '')
GUICtrlSetTip(-1, $LngCRLFH)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
$CRLFLab = GUICtrlCreateLabel($LngCRLF, $WHXY[0] - 192, 5, 125, 15, $SS_RIGHT)
GUICtrlSetTip(-1, $LngCRLFH)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
$spec = GUICtrlCreateCombo("", $WHXY[0] - 55, 28, 44, 23, $CBS_DROPDOWNLIST + $WS_VSCROLL)
GUICtrlSetData(-1, $sep & $sep & ChrW(0x9) & $specsymbol, '')
GUICtrlSetTip(-1, $LngPSmb)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_Spec")
$specLab = GUICtrlCreateLabel($LngPSmb, $WHXY[0] - 122, 32, 65, 15, $SS_RIGHT)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
$SeaBut = GUICtrlCreateButton("S", $WHXY[0] - 34, 53, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngSea)
GUICtrlSetImage(-1, $AutoItExe, 99, 0)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_Search")
$SeaLab = GUICtrlCreateLabel($LngSea, 7, 40, 86, 15)
$SeaInp = GUICtrlCreateCombo("", 5, 55, $WHXY[0] - 45)
GUICtrlSetData(-1, $iniSea, StringRegExpReplace($iniSea, '(^.*?)(?:' & $sep & '.*)$', '\1'))
GUICtrlSetResizing(-1, 7 + 32 + 512)
$RepBut = GUICtrlCreateButton("R", $WHXY[0] - 34, 103, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngRep)
GUICtrlSetImage(-1, $AutoItExe, 201, 0)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_ReplaceOnce")
$RepLab = GUICtrlCreateLabel($LngRep, 7, 90, 110, 15)
$RepInp = GUICtrlCreateCombo("", 5, 105, $WHXY[0] - 45)
GUICtrlSetData(-1, $iniRep, StringRegExpReplace($iniRep, '(^.*?)(?:' & $sep & '.*)$', '\1'))
GUICtrlSetResizing(-1, 7 + 32 + 512)
$TypLab = GUICtrlCreateLabel($LngMsk, 7, 140, 110, 15)
$TypInp = GUICtrlCreateCombo("", 5, 155, $WHXY[0] - 45)
GUICtrlSetData(-1, $iniMask, StringRegExpReplace($iniMask, '(^.*?)(?:' & $sep & '.*)$', '\1'))
GUICtrlSetResizing(-1, 7 + 32 + 512)
$Folder1 = GUICtrlCreateButton("...", $WHXY[0] - 34, 153, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 202, 0)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_Folder1")
$PatLab = GUICtrlCreateLabel($LngPth, 7, 190, 110, 15)
$PatInp = GUICtrlCreateCombo("", 5, 205, $WHXY[0] - 45)
GUICtrlSetData(-1, $iniPath, StringRegExpReplace($iniPath, '(^.*?)(?:' & $sep & '.*)$', '\1'))
GUICtrlSetResizing(-1, 7 + 32 + 512)
$Folder2 = GUICtrlCreateButton("...", $WHXY[0] - 34, 203, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 202, 0)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_Folder2")
$Out = GUICtrlCreateList("", 5, 250, $WHXY[0] - 10, 10, BitOR($WS_BORDER, $WS_VSCROLL, $LBS_USETABSTOPS, $LBS_NOINTEGRALHEIGHT))
GUICtrlSetOnEvent(-1, "_ListBox")
GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
GUICtrlSetState(-1, $GUI_HIDE)
$EditBut = GUICtrlCreateButton($LngEd, 10, 250 - 28, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngEdH)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 2)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetOnEvent(-1, "_EditBut")
GUICtrlSetImage(-1, $AutoItExe, 214, 0)
$EditFBut = GUICtrlCreateButton($LngEdF, 40, 250 - 28, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngEdFH)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 2)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetOnEvent(-1, "_EditFBut")
GUICtrlSetImage(-1, $AutoItExe, 215, 0)
$StrBut = GUICtrlCreateButton($LngSt, 70, 250 - 28, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngStH)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 2)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetOnEvent(-1, "_StrBut")
GUICtrlSetImage(-1, $AutoItExe, 216, 0)
$EprBut = GUICtrlCreateButton('-', 100, 250 - 28, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngEpr)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 2)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetOnEvent(-1, "_OpenExpr")
GUICtrlSetImage(-1, $AutoItExe, 202, 0)
$LstBut = GUICtrlCreateButton('-', 130, 250 - 28, 26, 24, $BS_PUSHLIKE + $BS_ICON)
GUICtrlSetTip(-1, $LngLst)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 2)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetOnEvent(-1, "_ListBox_GetText")
GUICtrlSetImage(-1, $AutoItExe, 218, 0)
$StopBut = GUICtrlCreateLabel($LngSp, -20, -20, 1, 1, 0xC)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_StopBut")
GUICtrlSetFont(-1, Default, 700)
GUICtrlSetColor(-1, 0xff0000)
$OutContext = GUICtrlCreateContextMenu($Out)
$Cont1 = GUICtrlCreateMenuItem($LngEd, $OutContext)
GUICtrlSetOnEvent(-1, "_EditBut")
$Cont3 = GUICtrlCreateMenuItem($LngEdF, $OutContext)
GUICtrlSetOnEvent(-1, "_EditFBut")
$Cont2 = GUICtrlCreateMenuItem($LngSt, $OutContext)
GUICtrlSetOnEvent(-1, "_StrBut")
$Cont4 = GUICtrlCreateMenuItem($LngEpr, $OutContext)
GUICtrlSetOnEvent(-1, "_OpenExpr")
$HelpCHM = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_HelpCHM")
$insCRLF = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_CRLFins")
$ClearTTip = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_ClearTTip")
Dim $AccelKeys[5][2] = [["{F1}", $HelpCHM],["!e", $EprBut],["!s", $SeaBut],["^{Enter}", $insCRLF],["{F4}", $ClearTTip]] 
$tmp = 0
$KeyLayout = RegRead("HKCU\Keyboard Layout\Preload", 1)
If Not @error And $KeyLayout <> 00000409 Then
_WinAPI_LoadKeyboardLayout(0x0409)
$tmp = 1
EndIf
GUISetAccelerators($AccelKeys)
If $tmp = 1 Then _WinAPI_LoadKeyboardLayout(Dec($KeyLayout)) 
GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")
GUIRegisterMsg(0x0216, "WM_MOVING")
GUIRegisterMsg(0x0233, "WM_DROPFILES")
OnAutoItExitRegister('_Exit')
GUISetState(@SW_SHOW, $Gui)
If $WHXY[4] Then GUISetState(@SW_MAXIMIZE, $Gui)
While 1
Sleep(1000000)
WEnd
Func _ClearTTip()
$Tr_View = False
ToolTip('')
EndFunc   
Func _HelpCHM()
If FileExists(@ScriptDir & '\TextReplace.chm') Then
ShellExecute('"' & @ScriptDir & '\TextReplace.chm"')
Else
Return _About()
EndIf
EndFunc   
Func _CRLFins()
$CRLF0 = GUICtrlRead($CRLF)
$SeaInp0 = GUICtrlRead($SeaInp)
If Not $CRLF0 Then
$CRLF0 = _CRLF_Define($SeaInp0)
If @error Then Return
GUICtrlSetData($CRLF, $CRLF0)
EndIf
_GUICtrlComboBox_SetEditText($SeaInp, $SeaInp0 & $CRLF0)
EndFunc   
Func WM_DROPFILES($hwnd, $msg, $wParam, $lParam)
Local $aRet = DllCall("shell32.dll", "int", "DragQueryFile", "int", $wParam, "int", -1, "ptr", 0, "int", 0)
If @error Then Return SetError(1, 0, 0)
Local $sDroppedFiles, $tBuffer = DllStructCreate("char[256]")
DllCall("shell32.dll", "int", "DragQueryFile", "int", $wParam, "int", 0, "ptr", DllStructGetPtr($tBuffer), "int", DllStructGetSize($tBuffer))
$sDroppedFiles = DllStructGetData($tBuffer, 1)
DllCall("shell32.dll", "none", "DragFinish", "int", $wParam)
$tBuffer = 0
If _FO_IsDir($sDroppedFiles) Then
_ComboBox_InsertPath($sDroppedFiles, $iniPath, $PatInp)
Else
If StringRight($sDroppedFiles, 4) = '.srt' Then
$ScrPath = $sDroppedFiles
_Disp()
Else
_mask($sDroppedFiles)
EndIf
EndIf
Return "GUI_RUNDEFMSG"
EndFunc   
Func _AaBut()
If GUICtrlRead($AaBut) = 4 Then
$iniAa = 0
GUICtrlSetTip($AaBut, $LngAaH1)
Else
$iniAa = 1
GUICtrlSetTip($AaBut, $LngAaH2)
EndIf
EndFunc   
Func _SubBut()
If GUICtrlRead($SubBut) = 4 Then
$inisub = 0
GUICtrlSetTip($SubBut, $LngSubH1)
Else
$inisub = 1
GUICtrlSetTip($SubBut, $LngSubH2)
EndIf
EndFunc   
Func _OutRBut()
If GUICtrlRead($OutRBut) = 4 Then
$iniOutRes = 0
GUICtrlSetTip($OutRBut, $LngOutRH1)
ToolTip('')
Else
$iniOutRes = 1
GUICtrlSetTip($OutRBut, $LngOutRH2)
EndIf
EndFunc   
Func _RExBut()
If GUICtrlRead($RExBut) = 4 Then
$iniREx = 0
GUICtrlSetTip($RExBut, $LngRExH1)
GUICtrlSetState($AaBut, $GUI_ENABLE)
Else
$iniREx = 1
GUICtrlSetTip($RExBut, $LngRExH2)
GUICtrlSetState($AaBut, $GUI_DISABLE)
EndIf
EndFunc   
Func _BAKBut()
If GUICtrlRead($BAKBut) = 4 Then
$iniBAK = 0
GUICtrlSetTip($BAKBut, $LngBAKH1)
Else
$iniBAK = 1
GUICtrlSetTip($BAKBut, $LngBAKH2)
EndIf
EndFunc   
Func _ExcBut()
If GUICtrlRead($ExcBut) = 4 Then
$iniExc = 0
GUICtrlSetTip($ExcBut, $LngExcH1)
Else
$iniExc = 1
GUICtrlSetTip($ExcBut, $LngExcH2)
EndIf
EndFunc   
Func _Spec()
Local $spec0 = GUICtrlRead($spec), $SeaInp0 = GUICtrlRead($SeaInp)
_GUICtrlComboBox_SetEditText($SeaInp, $SeaInp0 & $spec0)
EndFunc   
Func _Clear()
Switch @GUI_CtrlId
Case $SeaClear
GUICtrlSetData($SeaInp, '')
GUICtrlSetData($SeaInp, $iniSea, '')
GUICtrlSetState($SeaInp, $GUI_FOCUS)
Case $RepClear
GUICtrlSetData($RepInp, '')
GUICtrlSetData($RepInp, $iniRep, '')
GUICtrlSetState($RepInp, $GUI_FOCUS)
Case $TypClear
GUICtrlSetData($TypInp, '')
GUICtrlSetData($TypInp, $iniMask, '')
GUICtrlSetState($TypInp, $GUI_FOCUS)
EndSwitch
EndFunc   
Func _DefaultMask()
GUICtrlSetData($TypInp, '')
$iniMask = $iniDef
GUICtrlSetData($TypInp, $iniMask, '') 
EndFunc   
Func _StopBut()
$TrStop = 1
EndFunc   
Func _Search()
Local $aExcAttrib, $i, $j, $file, $seatext
$restext = ''
ToolTip('')
GUICtrlSetState($SeaBut, $GUI_DISABLE)
GUICtrlSetState($RepBut, $GUI_DISABLE)
GUICtrlSetData($StatusBar, '')
$SeaInp0 = GUICtrlRead($SeaInp)
$TypInp0 = GUICtrlRead($TypInp)
$PatInp0 = GUICtrlRead($PatInp)
$CRLF0 = GUICtrlRead($CRLF)
If $CharSet = -1 Then
$CharSetAuto = 1
Else
$CharSetAuto = 0
EndIf
If $PatInp0 = '' Or Not FileExists($PatInp0) Then
MsgBox(0, $LngErr, $LngMB1, 0, $Gui)
_Enable()
Return
EndIf
If $SeaInp0 = '' Then
MsgBox(0, $LngErr, $LngMB2, 0, $Gui)
_Enable()
Return
EndIf
GUICtrlSetData($StatusBar, $LngSb2)
_saveini(0)
_ComboBox_InsertPath($PatInp0, $iniPath, $PatInp)
If $CRLF0 Then
If StringLen($CRLF0) = 2 Then
$CRLF0 = StringSplit($CRLF0, '')
If $CRLF0[1] = $CRLF0[2] Then
$SeaInp0 = StringReplace($SeaInp0, $CRLF0[1], @CRLF)
Else
$SeaInp0 = StringReplace($SeaInp0, $CRLF0[1], @CR)
$SeaInp0 = StringReplace($SeaInp0, $CRLF0[2], @LF)
EndIf
Else
$SeaInp0 = StringReplace($SeaInp0, $CRLF0, @CRLF)
EndIf
EndIf
$timer = TimerInit() 
$Depth = 0
If $inisub = 1 Then $Depth = 125
If $iniExc Then
$Include = False
Else
$Include = True
EndIf
$FileList = _FO_FileSearch($PatInp0, _FO_CorrectMask($TypInp0), $Include, $Depth, 1, 1, 1, $sLocale) 
If @error Then
GUICtrlSetData($StatusBar, $LngSb3 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
_stat(0)
_Enable()
Return
EndIf
If $FileList[0] > $iniLimitFile And MsgBox(4, $LngErr, $LngMB7 & $FileList[0] & $LngMB8 & $iniLimitFile & $LngMB9, 0, $Gui) = 7 Then
GUICtrlSetData($StatusBar, $LngCnl)
_stat(0)
_Enable()
Return
EndIf
Local $FileSize[$FileList[0] + 1] = [$FileList[0]] 
$Size = 0
For $i = 1 To $FileList[0]
$FileSize[$i] = FileGetSize($FileList[$i])
$Size += $FileSize[$i]
Next
If $Size > $iniLimitSize * 1048576 And MsgBox(4, $LngErr, $LngMB10 & Round($Size / 1048576, 2) & $LngMB11 & $iniLimitSize & $LngMB12, 0, $Gui) = 7 Then
GUICtrlSetData($StatusBar, $LngCnl)
_stat(0)
_Enable()
Return
EndIf
$SizeText = _ConvertFileSize($Size)
$GuiPos = WinGetPos($Gui)
$ProgressBar = GUICtrlCreateProgress($GuiPos[2] - 110, 233, 100, 16)
GUICtrlSetColor(-1, 32250)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetPos($StopBut, $GuiPos[2] - 90, 185, 80, 17)
GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 120, 15)
If StringRight($PatInp0, 1) <> '\' Then $PatInp0 &= '\'
$LenPath = StringLen($PatInp0)
$Size1 = 0
$kol = 0
$ExcldAttrib = StringRegExpReplace($ExcldAttrib, '(?i)[^RASHNOT]', '') 
$aExcAttrib = StringSplit($ExcldAttrib, '')
HotKeySet("{ESC}", "_StopBut")
Dim $aSearch[1][2] = [[$PatInp0]]
If $iniOutRes Then
$p = ' *'
Else
$p = ' *p'
EndIf
For $i = 1 To $FileList[0]
If $TrStop Then
GUICtrlSetData($StatusBar, $LngCnl)
GUICtrlDelete($ProgressBar)
GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 10, 15)
GUICtrlSetPos($StopBut, -20, -20, 1, 1)
_stat(0)
$TrStop = 0
_Enable()
Return
EndIf
$Size1 += $FileSize[$i]
If $FileSize[$i] > $iniErrSize Then ContinueLoop
$seafile = StringTrimLeft($FileList[$i], $LenPath)
GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' / ' & $i & ' / ' & $kol & ' / ' & $seafile)
$FileAttrib = FileGetAttrib($FileList[$i])
For $j = 1 To $aExcAttrib[0]
If StringInStr($FileAttrib, $aExcAttrib[$j]) Then ContinueLoop 2 
Next
If $CharSetAuto Then
$CharSet = FileGetEncoding($FileList[$i])
Else
If $CharSet <> 16 And $CharSet <> FileGetEncoding($FileList[$i]) Then ContinueLoop
EndIf
$file = FileOpen($FileList[$i], $CharSet)
If $file = -1 Then ContinueLoop
$seatext = FileRead($file)
FileClose($file)
If $iniOutRes Then
If $iniREx Then
$s0 = _StringInStrMultiR($seatext, $SeaInp0, $seafile)
Else
$s0 = _StringInStrMulti($seatext, $SeaInp0, $iniAa, $seafile)
EndIf
Else
If $iniREx Then
$s0 = StringRegExp($seatext, $SeaInp0)
Else
$s0 = StringInStr($seatext, $SeaInp0, $iniAa)
EndIf
EndIf
If $s0 Then
$kol += 1
$restext &= $seafile & $p & $s0 & $sep
EndIf
GUICtrlSetData($ProgressBar, Ceiling($Size1 / $Size * 100))
Next
HotKeySet("{ESC}")
GUICtrlDelete($ProgressBar)
GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 10, 15)
If $restext = '' Then
GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' / ' & $FileList[0] & ' / ' & $kol & '   ' & $LngSb3 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
GUICtrlSetData($Out, '')
_stat(0)
Else
GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' / ' & $FileList[0] & ' / ' & $kol & '   ' & $LngSb4 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
GUICtrlSetData($Out, '')
GUICtrlSetData($Out, $restext)
_stat(1)
ControlFocus($Gui, '', $Out)
EndIf
If $CharSetAuto Then $CharSet = -1
$Tr_Sea = 1
$Tr_ViewT = 1000 
GUICtrlSetPos($StopBut, -20, -20, 1, 1)
_Enable()
EndFunc   
Func _StringInStrMulti($seatext, $SeaInp0, $iniAa, $file)
Local $s0 = 0, $i, $re = '', $sep = Chr(0) & Chr(1) & Chr(0)
$long = StringLen($SeaInp0)
$pos = 1 - $long
While 1
$pos = StringInStr($seatext, $SeaInp0, $iniAa, 1, $pos + $long)
If $pos = 0 Then ExitLoop
$s0 += 1
$str = StringInStr($seatext, @LF, 0, -1, $pos) 
$str2 = StringInStr($seatext, @CR, 0, -1, $pos)
If $str < $str2 Then $str = $str2
$end = StringInStr($seatext, @CR, 0, 1, $pos + $long)
$end2 = StringInStr($seatext, @LF, 0, 1, $pos + $long)
If $end = 0 Then $end = $end2 
If $end2 = 0 Then $end2 = $end
If $end > $end2 Then $end = $end2
If $end < $pos Or $end - $pos - $long > 40 Then $end = $pos + $long + 40
If $pos - $str > 40 Then $str = $pos - 40
$FindBlok = StringMid($seatext, $str + 1, $end - $str - 1)
$re &= $FindBlok & $sep
WEnd
If $s0 Then
$i = UBound($aSearch)
ReDim $aSearch[$i + 1][2]
$aSearch[$i][0] = $file & ' - ' & $s0
$aSearch[$i][1] = StringTrimRight($re, 3)
EndIf
Return $s0
EndFunc   
Func _StringInStrMultiR($seatext, $SeaInp0, $file)
Local $s0 = 0, $i
$aR = StringRegExp($seatext, $SeaInp0, 3)
If @error Then Return 0
$s0 = UBound($aR)
Local $re[$s0][3]
$pos = 0
For $i = 0 To $s0 - 1
$pos = StringInStr($seatext, $aR[$i], 1, 1, $pos + 1)
If $pos = 0 Then ContinueLoop
$long = StringLen($aR[$i])
$str = StringInStr($seatext, @LF, 0, -1, $pos)
$str2 = StringInStr($seatext, @CR, 0, -1, $pos)
If $str < $str2 Then $str = $str2
$end = StringInStr($seatext, @CR, 0, 1, $pos + $long)
$end2 = StringInStr($seatext, @LF, 0, 1, $pos + $long)
If $end = 0 Then $end = $end2
If $end2 = 0 Then $end2 = $end
If $end > $end2 Then $end = $end2
If $end < $pos Or $end - $pos - $long > 40 Then $end = $pos + $long + 40
If $pos - $str > 40 Then $str = $pos - 40
$FindBlok = StringMid($seatext, $str + 1, $end - $str - 1)
If $long > 30 Then
$re[$i][0] = $pos
$re[$i][1] = $aR[$i]
Else
$re[$i][0] = $pos
$re[$i][1] = $aR[$i]
$re[$i][2] = $FindBlok
EndIf
Next
If $s0 Then
$i = UBound($aSearch)
ReDim $aSearch[$i + 1][2]
$aSearch[$i][0] = $file & ' - ' & $s0
$aSearch[$i][1] = $re
EndIf
Return $s0
EndFunc   
Func _ListBox()
Local $i, $j, $kol, $sep, $txtres, $re
If $Tr_Sea And $iniOutRes And UBound($aSearch) > 1 Then
$i = GUICtrlSendMsg($Out, $LB_GETCURSEL, 0, 0)
If $Tr_ViewT = $i And $i <> -1 Then
If $Tr_View = True Then
$Tr_View = False
ToolTip('')
Else
$Tr_View = True
EndIf
EndIf
If $Tr_View = True And $i <> -1 Then
$sep = Chr(0) & Chr(1) & Chr(0)
$kol = 0
If $iniREx Then
$txtres &= $aSearch[$i + 1][0] & @CRLF & @CRLF
$kol += 1
$re = $aSearch[$i + 1][1]
For $j = 0 To UBound($re) - 1
If $re[$j][2] Then
$txtres &= $j + 1 & ' ---| ' & $re[$j][1] & @CRLF & ' -->| ' & $re[$j][2] & @CRLF
Else
$txtres &= $j + 1 & ' -->| ' & $re[$j][1] & @CRLF
EndIf
$kol += 1
If $kol > 70 Then ExitLoop
Next
Else
$txtres &= $aSearch[$i + 1][0] & @CRLF & @CRLF
$kol += 1
$re = StringSplit($aSearch[$i + 1][1], $sep, 1)
For $j = 1 To $re[0]
$txtres &= $j & ' -->| ' & $re[$j] & @CRLF
$kol += 1
If $kol > 70 Then ExitLoop 
Next
EndIf
$kol = Number(StringTrimLeft($aSearch[$i + 1][0], StringInStr($aSearch[$i + 1][0], ' - ') + 2))
If $kol > 70 Then $txtres = StringLeft($txtres, StringInStr($txtres, @CRLF, 0, 70) - 1) & @CRLF & '...'
$kol = StringLen($txtres)
If $kol > 10000 Then $txtres = StringLeft($txtres, 10000) 
$txtres = StringRegExpReplace($txtres, '[\000-\007\010\016\017\020-\027\030-\037\177]', ChrW('0x25A1'))
ToolTip($txtres, -1, -1, StringTrimLeft($aSearch[$i + 1][0], StringInStr($aSearch[$i + 1][0], '\', 0, -1)) & '   (F4 - ' & $LngTTp & ')')
EndIf
$Tr_ViewT = $i
EndIf
EndFunc   
Func _Res_Byfer()
Local $aRicheditTags, $Combo_Jump0, $ComboData, $EditBut, $Find, $i, $j, $msg, $pos = 0, $re, $Rsep, $sRTFCode = '', $StrBut, $tmp, $pos
If Not ($Tr_Sea And UBound($aSearch) > 1) Then
MsgBox(0, $LngErr, $LngMB20)
Return
EndIf
$Rsep = Chr(0) & Chr(1) & Chr(0)
Opt("GUIOnEventMode", 0)
GUISetState(@SW_DISABLE, $Gui)
If Not $RichPos[0] Then
$RichPos[4] = Number(IniRead($Ini, 'Set', 'RichMax', ''))
$RichPos[0] = Number(IniRead($Ini, 'Set', 'RichW', '790'))
$RichPos[1] = Number(IniRead($Ini, 'Set', 'RichH', '500'))
$RichPos[2] = IniRead($Ini, 'Set', 'RichL', '')
$RichPos[3] = IniRead($Ini, 'Set', 'RichT', '')
If $RichPos[0] < 200 Then $RichPos[0] = 200
If $RichPos[1] < 200 Then $RichPos[1] = 200
_SetCoor($RichPos)
EndIf
$Gui1 = GUICreate($aSearch[0][0], $RichPos[0], $RichPos[1], $RichPos[2], $RichPos[3], BitOR($WS_OVERLAPPEDWINDOW, $WS_POPUP, $WS_CLIPCHILDREN), -1, $Gui)
If Not @Compiled Then GUISetIcon($AutoItExe, 1)
$hRichEdit = _GUICtrlRichEdit_Create($Gui1, "", 5, 5, $RichPos[0] - 10, $RichPos[1] - 40, BitOR($ES_MULTILINE, $WS_VSCROLL, $WS_HSCROLL, $ES_AUTOVSCROLL))
_GUICtrlRichEdit_PauseRedraw($hRichEdit) 
$aRicheditTags = StringRegExp($sRTFCode, '\\+par|\\+tab|\\+cf\d+', 3)
If Not @error Then
$aRicheditTags = _ArrayRemoveDuplicates($aRicheditTags)
For $i = 0 To UBound($aRicheditTags) - 1
$sRTFCode = StringReplace($sRTFCode, $aRicheditTags[$i], StringReplace($aRicheditTags[$i], '\', '#', 0, 2), 0, 2)
Next
EndIf
If $Tr_Sea And UBound($aSearch) > 1 Then
If $iniREx Then 
For $i = 1 To UBound($aSearch) - 1
$ComboData &= $sep & $i & '. ' & $aSearch[$i][0] 
$sRTFCode &= @CRLF & Chr(1) & 'cf2 ' & $i & '. ' & $aSearch[$i][0] & Chr(1) & 'cf0 ' & @CRLF
$re = $aSearch[$i][1]
For $j = 0 To UBound($re) - 1
If $re[$j][2] Then
$sRTFCode &= Chr(1) & 'cf3 ' & $j + 1 & ' -->| ' & Chr(1) & 'cf0 ' & StringReplace($re[$j][2], $re[$j][1], Chr(1) & 'cf1 ' & $re[$j][1] & Chr(1) & 'cf0 ') & @CRLF
Else
$sRTFCode &= Chr(1) & 'cf3 ' & $j + 1 & ' -->| ' & Chr(1) & 'cf0 ' & Chr(1) & 'cf1 ' & $re[$j][1] & Chr(1) & 'cf0 ' & @CRLF
EndIf
Next
Next
Else 
For $i = 1 To UBound($aSearch) - 1
$ComboData &= $sep & $i & '. ' & $aSearch[$i][0]
$sRTFCode &= @CRLF & Chr(1) & 'cf2 ' & $i & '. ' & $aSearch[$i][0] & Chr(1) & 'cf0 ' & @CRLF
$re = StringReplace($aSearch[$i][1], $SeaInp0, Chr(1) & 'cf1 ' & $SeaInp0 & Chr(1) & 'cf0 ')
$re = StringSplit($re, $Rsep, 1)
For $j = 1 To $re[0]
$sRTFCode &= Chr(1) & 'cf3 ' & $j & ' -->| ' & Chr(1) & 'cf0 ' & $re[$j] & @CRLF
Next
Next
EndIf
EndIf
$sRTFCode = StringTrimRight($sRTFCode, 2)
$sRTFCode = StringReplace($sRTFCode, '\', '\\', 0, 2)
$sRTFCode = StringReplace($sRTFCode, '{', '\{', 0, 2)
$sRTFCode = StringReplace($sRTFCode, '}', '\}', 0, 2)
$sRTFCode = StringReplace($sRTFCode, @CR, '\par ' & @CRLF, 0, 2)
$sRTFCode = StringReplace($sRTFCode, @TAB, '\tab ', 0, 2)
$sRTFCode = StringReplace($sRTFCode, Chr(1), '\', 0, 2)
$sRTFCode = StringRegExpReplace($sRTFCode, '[\000-\007\010\016\017\020-\027\030-\037\177]', ChrW('0x25A1'))
__RESH_HeaderFooter($sRTFCode) 
_GUICtrlRichEdit_SetLimitOnText($hRichEdit, StringLen($sRTFCode)) 
_GUICtrlRichEdit_SetText($hRichEdit, $sRTFCode) 
_GUICtrlRichEdit_ResumeRedraw($hRichEdit) 
$Find = _GUICtrlRichEdit_FindText($hRichEdit, @CR & '1 -->| ')
If Not @error And $Find <> -1 Then _GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find + 3) 
$Btn_Back = GUICtrlCreateButton($LngBck, 10, $RichPos[1] - 30, 120, 24)
$Btn_Next = GUICtrlCreateButton($LngNxt, 140, $RichPos[1] - 30, 120, 24)
$Combo_Jump = GUICtrlCreateCombo('', 270, $RichPos[1] - 28, 510, -1, $CBS_DROPDOWNLIST + $WS_VSCROLL) 
GUICtrlSetData($Combo_Jump, $ComboData, '')
GUISetState(@SW_SHOW, $Gui1)
GUIRegisterMsg(0x05, "_WM_SIZE_RichEdit")
If $RichPos[4] Then GUISetState(@SW_MAXIMIZE, $Gui1)
While 1
Switch GUIGetMsg()
Case $GUI_EVENT_MAXIMIZE
$RichPos[4] = 1
Case $GUI_EVENT_RESTORE
$RichPos[4] = 0
Case $GUI_EVENT_RESIZED
$ClientSz = WinGetClientSize($Gui)
$RichPos[0] = $ClientSz[0]
$RichPos[1] = $ClientSz[1]
Case $Combo_Jump
$Combo_Jump0 = GUICtrlRead($Combo_Jump)
If $Combo_Jump0 Then
_GUICtrlRichEdit_GotoCharPos($hRichEdit, -1)
$Find = _GUICtrlRichEdit_FindText($hRichEdit, $Combo_Jump0, False)
If Not @error And $Find <> -1 Then
_GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find)
$Find = _GUICtrlRichEdit_FindText($hRichEdit, @CR & '1 -->| ')
If Not @error And $Find <> -1 Then
_GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find + 3)
_GUICtrlRichEdit_ScrollToCaret($hRichEdit)
EndIf
EndIf
EndIf
Case $Btn_Next
$Find = _GUICtrlRichEdit_FindText($hRichEdit, @CR & '1 -->| ')
If Not @error And $Find <> -1 Then
_GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find + 3) 
_GUICtrlRichEdit_ScrollToCaret($hRichEdit) 
ElseIf $Find = -1 Then
_GUICtrlRichEdit_GotoCharPos($hRichEdit, 0) 
$Find = _GUICtrlRichEdit_FindText($hRichEdit, @CR & '1 -->| ')
If Not @error And $Find <> -1 Then
_GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find + 3)
_GUICtrlRichEdit_ScrollToCaret($hRichEdit) 
EndIf
EndIf
Case $Btn_Back
$Find = _GUICtrlRichEdit_FindText($hRichEdit, @CR & '1 -->| ', False)
If Not @error And $Find <> -1 Then
_GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find + 3) 
_GUICtrlRichEdit_ScrollToCaret($hRichEdit) 
_GUICtrlRichEdit_ScrollLines($hRichEdit, -3)
ElseIf $Find = -1 Then
_GUICtrlRichEdit_GotoCharPos($hRichEdit, -1) 
$Find = _GUICtrlRichEdit_FindText($hRichEdit, @CR & '1 -->| ', False)
If Not @error And $Find <> -1 Then
_GUICtrlRichEdit_GotoCharPos($hRichEdit, $Find + 3)
_GUICtrlRichEdit_ScrollToCaret($hRichEdit) 
EndIf
EndIf
Case -3
ExitLoop
EndSwitch
WEnd
_GUICtrlRichEdit_Destroy($hRichEdit)
GUIRegisterMsg(0x05, '')
If Not $RichPos[4] Then
$ClientSz = WinGetClientSize($Gui1)
If $ClientSz[0] > 180 And $ClientSz[1] > 150 Then
$RichPos[0] = $ClientSz[0]
$RichPos[1] = $ClientSz[1]
$aGuiPos = WinGetPos($Gui1)
$RichPos[2] = $aGuiPos[0]
$RichPos[3] = $aGuiPos[1]
EndIf
EndIf
GUISetState(@SW_ENABLE, $Gui)
GUIDelete($Gui1)
Opt("GUIOnEventMode", 1)
EndFunc   
Func _WM_SIZE_RichEdit($hwnd, $msg, $wParam, $lParam)
$w = BitAND($lParam, 0xFFFF) 
$h = BitShift($lParam, 16) 
_WinAPI_MoveWindow($hRichEdit, 5, 5, $w - 10, $h - 40)
GUICtrlSetPos($Btn_Back, 10, $h - 30)
GUICtrlSetPos($Btn_Next, 140, $h - 30)
GUICtrlSetPos($Combo_Jump, 270, $h - 28, $w - 280)
Return 0
EndFunc   
Func __RESH_HeaderFooter(ByRef $sCode)
Local $g_RESH_sColorTable = _
'\red255\green0\blue0;' & _ 
'\red0\green0\blue255;' & _ 
'\red99\green99\blue99;' 
$sCode = "{\rtf\ansi\ansicpg1251\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}}" & _ 
"{\colortbl;" & $g_RESH_sColorTable & "}{\*\generator Msftedit 5.41.21.2510;}\viewkind4\uc1\pard\f0\fs18" & _ 
StringStripWS($sCode, 2) & '}'
EndFunc   
Func _ArrayRemoveDuplicates(Const ByRef $aArray)
If Not IsArray($aArray) Then Return SetError(1, 0, 0)
Local $oSD = ObjCreate("Scripting.Dictionary")
For $i In $aArray
$oSD.Item($i)
Next
Return $oSD.Keys()
EndFunc   
Func _ReplaceOnce()
Local $tmpData, $TrR, $TrH, $TrS, $aExcAttrib, $i, $j, $file, $Size2
$restext = ''
ToolTip('')
GUICtrlSetState($SeaBut, $GUI_DISABLE)
GUICtrlSetState($RepBut, $GUI_DISABLE)
GUICtrlSetData($StatusBar, '')
$SeaInp0 = GUICtrlRead($SeaInp)
$RepInp0 = GUICtrlRead($RepInp)
$TypInp0 = GUICtrlRead($TypInp)
$PatInp0 = GUICtrlRead($PatInp)
$CRLF0 = GUICtrlRead($CRLF)
If $CharSet = -1 Then
$CharSetAuto = 1
Else
$CharSetAuto = 0
EndIf
If $SeaInp0 == $RepInp0 And (StringRight($RepInp0, 4) <> '.srt' Or Not FileExists($RepInp0)) Then
MsgBox(0, $LngErr, $LngMB3, 0, $Gui)
_Enable()
Return
EndIf
If $SeaInp0 = $RepInp0 And StringRight($RepInp0, 4) = '.srt' And FileExists($RepInp0) And $aTextScr <> '' Then
Return _ReplaceLoop($RepInp0)
Else
$TrScr = 0
EndIf
If $SeaInp0 = $RepInp0 And StringRight($RepInp0, 4) = '.srt' And FileExists($RepInp0) And $TrScr = 0 Then
MsgBox(0, $LngErr, $LngMB4, 0, $Gui)
_Enable()
Return
EndIf
If $PatInp0 = '' Or Not FileExists($PatInp0) Then
MsgBox(0, $LngErr, $LngMB1, 0, $Gui)
_Enable()
Return
EndIf
If $SeaInp0 = '' Then
MsgBox(0, $LngErr, $LngMB2, 0, $Gui)
_Enable()
Return
EndIf
If $CharSet = 16 And Not $iniREx Then
$SeaInp0 = StringUpper($SeaInp0)
If Mod(StringLen($SeaInp0), 2) <> Mod(StringLen($RepInp0), 2) Then
MsgBox(0, $LngErr, $LngMB19, 0, $Gui)
_Enable()
Return
EndIf
EndIf
GUICtrlSetData($StatusBar, $LngSb5)
_saveini(0)
_ComboBox_InsertPath($PatInp0, $iniPath, $PatInp)
If $CRLF0 Then _CRLF($CRLF0, $SeaInp0, $RepInp0)
If StringRight($PatInp0, 1) <> '\' Then $PatInp0 &= '\'
If $iniBAK = 1 Then
If $iniPathBackup = '' Then
$tmp = @ScriptDir & '\Backup\'
Else
$tmp = $iniPathBackup
EndIf
If StringRegExp($tmp, '(?i)^[a-z]:[^/:*?"<>|]*$') And StringInStr('|Removable|Fixed|', '|' & DriveGetType(StringLeft($tmp, 1) & ':\') & '|') And Not StringInStr($tmp, '\\') Then
If $iniPathBackup And StringRight($iniPathBackup, 1) <> '\' Then $iniPathBackup &= '\'
$BackUpPath = $tmp
Else
If MsgBox(4, $LngErr, $LngMB17, 0, $Gui) = 7 Then
_Enable()
Return
EndIf
EndIf
$BackUpPath &= @YEAR & "." & @MON & "." & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & "_" & StringRegExpReplace($PatInp0, '^(.*\\)(.*?\\)$', '\2')
EndIf
$timer = TimerInit()
$Depth = 0
If $inisub = 1 Then $Depth = 125
If $iniExc Then
$Include = False
Else
$Include = True
EndIf
$FileList = _FO_FileSearch($PatInp0, _FO_CorrectMask($TypInp0), $Include, $Depth, 1, 1, 1, $sLocale) 
If @error Then
GUICtrlSetData($StatusBar, $LngSb3 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
_stat(0)
_Enable()
Return
EndIf
If $FileList[0] > $iniLimitFile And MsgBox(4, $LngErr, $LngMB7 & $FileList[0] & $LngMB8 & $iniLimitFile & $LngMB9, 0, $Gui) = 7 Then
GUICtrlSetData($StatusBar, $LngCnl)
_stat(0)
_Enable()
Return
EndIf
Local $FileSize[$FileList[0] + 1] = [$FileList[0]] 
$Size = 0
For $i = 1 To $FileList[0]
$FileSize[$i] = FileGetSize($FileList[$i])
$Size += $FileSize[$i]
Next
If $Size > $iniLimitSize * 1048576 And MsgBox(4, $LngErr, $LngMB10 & Round($Size / 1048576, 2) & $LngMB11 & $iniLimitSize & $LngMB12, 0, $Gui) = 7 Then
GUICtrlSetData($StatusBar, $LngCnl)
_stat(0)
_Enable()
Return
EndIf
$SizeText = _ConvertFileSize($Size)
$GuiPos = WinGetPos($Gui)
$ProgressBar = GUICtrlCreateProgress($GuiPos[2] - 110, 233, 100, 16)
GUICtrlSetColor(-1, 32250)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetPos($StopBut, $GuiPos[2] - 90, 185, 80, 17)
$LenPath = StringLen($PatInp0)
$Size1 = 0
$kol = 0
$ExcldAttrib = StringRegExpReplace($ExcldAttrib, '(?i)[^RASHNOT]', '') 
$aExcAttrib = StringSplit($ExcldAttrib, '')
HotKeySet("{ESC}", "_StopBut")
For $i = 1 To $FileList[0]
If $TrStop Then
GUICtrlSetData($StatusBar, $LngCnl)
GUICtrlDelete($ProgressBar)
GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 10, 15)
GUICtrlSetPos($StopBut, -20, -20, 1, 1)
_stat(0)
$TrStop = 0
_Enable()
Return
EndIf
$Size1 += $FileSize[$i]
If $FileSize[$i] > $iniErrSize Then ContinueLoop
$seafile = StringTrimLeft($FileList[$i], $LenPath)
GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' / ' & $i & ' / ' & $kol & ' / ' & $seafile)
$FileAttrib = FileGetAttrib($FileList[$i])
For $j = 1 To $aExcAttrib[0]
If StringInStr($FileAttrib, $aExcAttrib[$j]) Then ContinueLoop 2
Next
If $CharSetAuto Then
$CharSet = FileGetEncoding($FileList[$i])
Else
If $CharSet <> 16 And $CharSet <> FileGetEncoding($FileList[$i]) Then ContinueLoop
EndIf
$file = FileOpen($FileList[$i], $CharSet)
If $file = -1 Then ContinueLoop
$seatext = FileRead($file)
FileClose($file)
If $TrScr = 0 Then
If $iniREx Then
$seatext = StringRegExpReplace($seatext, $SeaInp0, $RepInp0)
$s0 = @extended
Else
$seatext = StringReplace($seatext, $SeaInp0, $RepInp0, 0, $iniAa)
$s0 = @extended
EndIf
Else
$s0 = 0
For $m = 1 To $aTextScr[0]
$aTmp = StringSplit($aTextScr[$m], $iniSep, 1)
If $aTmp[0] > 3 Then ContinueLoop
If $iniREx Then
$seatext = StringRegExpReplace($seatext, $aTmp[1], $aTmp[2])
$s0 += @extended
Else
$seatext = StringReplace($seatext, $aTmp[1], $aTmp[2], 0, $iniAa)
$s0 += @extended
EndIf
Next
EndIf
If $s0 <> 0 Then
$kol += 1
If $iniBAK = 1 Then FileCopy($FileList[$i], $BackUpPath & $seafile, 8)
If $ReData Then $tmpData = FileGetTime($FileList[$i], 0, 1)
$TrR = StringInStr($FileAttrib, 'R')
$TrH = StringInStr($FileAttrib, 'H')
$TrS = StringInStr($FileAttrib, 'S')
If $TrR Then FileSetAttrib($FileList[$i], '-R')
If $TrH Then FileSetAttrib($FileList[$i], '-H')
If $TrS Then FileSetAttrib($FileList[$i], '-S')
$file = FileOpen($FileList[$i], $CharSet + 2)
If Not FileWrite($file, $seatext) Then $s0 = 0
FileClose($file)
If $TrR Then FileSetAttrib($FileList[$i], '+R')
If $TrH Then FileSetAttrib($FileList[$i], '+H')
If $TrS Then FileSetAttrib($FileList[$i], '+S')
If $ReData Then FileSetTime($FileList[$i], $tmpData)
$restext &= $seafile & ' *' & $s0 & $sep
EndIf
GUICtrlSetData($ProgressBar, Ceiling($Size1 / $Size * 100))
Next
HotKeySet("{ESC}")
GUICtrlDelete($ProgressBar)
If $restext = '' Then
GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' / ' & $FileList[0] & ' / ' & $kol & '   ' & $LngSb3 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
GUICtrlSetData($Out, '')
_stat(0)
Else
GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' / ' & $FileList[0] & ' / ' & $kol & '   ' & $LngSb4 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
GUICtrlSetData($Out, '')
GUICtrlSetData($Out, $restext)
_stat(1)
ControlFocus($Gui, '', $Out)
EndIf
If $CharSetAuto Then $CharSet = -1
$aTextScr = ''
$TrScr = 0
$Tr_Sea = 0
GUICtrlSetPos($StopBut, -20, -20, 1, 1)
_Enable()
EndFunc   
Func _BackUp(ByRef $BackUp)
Local $BackUpPath
If StringRegExp($BackUp, '(?i)^[a-z]:[^/:*?"<>|]*$') And Not StringInStr($BackUp, '\\') Then
If StringRight($BackUp, 1) <> '\' Then $BackUp &= '\'
$BackUpPath = $BackUp
Else
$BackUpPath = @ScriptDir & '\Backup\'
EndIf
If Not StringInStr('|Removable|Fixed|', '|' & DriveGetType(StringLeft($BackUpPath, 1) & ':\') & '|') Then Return SetError(1, 0, '')
$BackUp = 1
$BackUpPath &= @YEAR & "." & @MON & "." & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & "_"
Return $BackUpPath
EndFunc   
Func _ReplaceLoop($RepInp0)
Local $PathListErr, $s
ToolTip('')
_ReadScenario($RepInp0)
$s = UBound($aScenario)
$PathListErr = ''
For $i = 0 To $s - 1
If Not FileExists($aScenario[$i][6]) Then $PathListErr &= $aScenario[$i][6] & @CRLF
If $aScenario[$i][12] = 'Bin' And $aScenario[$i][3] = '0' Then
$aScenario[$i][0] = StringUpper($aScenario[$i][0])
If Mod(StringLen($aScenario[$i][0]), 2) <> Mod(StringLen($aScenario[$i][1]), 2) Then
MsgBox(0, $LngErr, $LngMB19 & @CRLF & $aScenario[$i][0] & @CRLF & $aScenario[$i][1], 0, $Gui)
_Enable()
Return
EndIf
EndIf
Next
If $PathListErr <> '' Then
MsgBox(0, $LngErr, $LngMB18 & @CRLF & $PathListErr)
_stat(0)
_Enable()
Return
EndIf
Local $ch[$s]
For $i = 0 To $s - 1
$ch[$i] = $aScenario[$i][6] & $aScenario[$i][7] & $aScenario[$i][8] & $aScenario[$i][9] & $aScenario[$i][11] & $aScenario[$i][12]
Next
$aUni = _ArrayUnique($ch)
If Not @error And $aUni[0] = 1 Then
For $i = 0 To $s - 1
If $aScenario[$i][5] Then
$aScenario[0][5] = $aScenario[$i][5] 
ExitLoop
EndIf
Next
_ReplaceEconom($aScenario)
Else
For $i = 0 To $s - 1
_ReplaceFull($aScenario[$i][0], $aScenario[$i][1], $aScenario[$i][2], $aScenario[$i][3], $aScenario[$i][4], $aScenario[$i][5], $aScenario[$i][6], $aScenario[$i][7], $aScenario[$i][8], $aScenario[$i][9], $aScenario[$i][10], $aScenario[$i][11], _CharNameToNum($aScenario[$i][12]), '(' & $s & ' \ ' & $i & ')')
If @error Then Return
Next
EndIf
EndFunc   
Func _ReplaceEconom($aScenario)
$restext = ''
Local $BackUpPath, $file, $FileList, $i, $j, $LenPath, $seatext, $tmpData, $TrR, $TrH, $TrS, $aExcAttrib, $Size2
Local $BackUp, $Path, $Mask, $Include, $Depth, $ReData, $ExcldAttrib, $CharSet
$BackUp = $aScenario[0][5]
$Path = $aScenario[0][6]
$Mask = $aScenario[0][7]
$Include = $aScenario[0][8]
$Depth = $aScenario[0][9]
$ReData = $aScenario[0][10]
$ExcldAttrib = $aScenario[0][11]
$CharSet = _CharNameToNum($aScenario[0][12])
If $CharSet = -1 Then
$CharSetAuto = 1
Else
$CharSetAuto = 0
EndIf
If StringRight($Path, 1) <> '\' Then $Path &= '\'
If $BackUp Then
$BackUpPath = _BackUp($BackUp) & StringRegExpReplace($Path, '^(.*\\)(.*?\\)$', '\2')
If @error Then Return SetError(1, 0, '')
EndIf
$timer = TimerInit()
$Depth = 0
If $inisub = 1 Then $Depth = 125
If $Include Then
$Include = True
Else
$Include = False
EndIf
$FileList = _FO_FileSearch($Path, _FO_CorrectMask($Mask), $Include, $Depth, 1, 1, 1, $sLocale) 
If @error Then
GUICtrlSetData($StatusBar, $LngSb3 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
_stat(0)
_Enable()
Return SetError(1, 0, '')
EndIf
If $FileList[0] > $iniLimitFile And MsgBox(4, $LngErr, $LngMB7 & $FileList[0] & $LngMB8 & $iniLimitFile & $LngMB9, 0, $Gui) = 7 Then
GUICtrlSetData($StatusBar, $LngCnl)
_stat(0)
_Enable()
Return SetError(1, 0, '')
EndIf
Local $FileSize[$FileList[0] + 1] = [$FileList[0]] 
$Size = 0
For $i = 1 To $FileList[0]
$FileSize[$i] = FileGetSize($FileList[$i])
$Size += $FileSize[$i]
Next
If $Size > $iniLimitSize * 1048576 And MsgBox(4, $LngErr, $LngMB10 & Round($Size / 1048576, 2) & $LngMB11 & $iniLimitSize & $LngMB12, 0, $Gui) = 7 Then
GUICtrlSetData($StatusBar, $LngCnl)
_stat(0)
_Enable()
Return SetError(1, 0, '')
EndIf
$SizeText = _ConvertFileSize($Size)
$GuiPos = WinGetPos($Gui)
$ProgressBar = GUICtrlCreateProgress($GuiPos[2] - 110, 233, 100, 16)
GUICtrlSetColor(-1, 32250)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetPos($StopBut, $GuiPos[2] - 90, 185, 80, 17)
$LenPath = StringLen($Path)
$Size1 = 0
$kol = 0
$ExcldAttrib = StringRegExpReplace($ExcldAttrib, '(?i)[^RASHNOT]', '') 
$aExcAttrib = StringSplit($ExcldAttrib, '')
HotKeySet("{ESC}", "_StopBut")
For $i = 1 To $FileList[0]
If $TrStop Then
GUICtrlSetData($StatusBar, $LngCnl)
GUICtrlDelete($ProgressBar)
GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 10, 15)
GUICtrlSetPos($StopBut, -20, -20, 1, 1)
_stat(0)
$TrStop = 0
_Enable()
Return SetError(1, 0, '')
EndIf
$Size1 += $FileSize[$i]
If $FileSize[$i] > $iniErrSize Then ContinueLoop
$seafile = StringTrimLeft($FileList[$i], $LenPath)
GUICtrlSetData($StatusBar, 'Econ (' & $SizeText & ') ' & $FileList[0] & ' / ' & $i & ' / ' & $kol & ' / ' & $seafile)
$FileAttrib = FileGetAttrib($FileList[$i])
For $j = 1 To $aExcAttrib[0]
If StringInStr($FileAttrib, $aExcAttrib[$j]) Then ContinueLoop 2
Next
If $CharSetAuto Then
$CharSet = FileGetEncoding($FileList[$i])
Else
If $CharSet <> 16 And $CharSet <> FileGetEncoding($FileList[$i]) Then ContinueLoop
EndIf
$file = FileOpen($FileList[$i], $CharSet)
If $file = -1 Then ContinueLoop
$seatext = FileRead($file)
FileClose($file)
$s0 = 0
For $m = 0 To UBound($aScenario) - 1
If $aScenario[$m][4] Then _CRLF($aScenario[$m][4], $aScenario[$m][0], $aScenario[$m][1])
If $aScenario[$m][3] Then
$seatext = StringRegExpReplace($seatext, $aScenario[$m][0], $aScenario[$m][1])
$s0 += @extended
Else
$seatext = StringReplace($seatext, $aScenario[$m][0], $aScenario[$m][1], 0, $aScenario[$m][2])
$s0 += @extended
EndIf
Next
If $s0 <> 0 Then
$kol += 1
If $BackUp = 1 Then FileCopy($FileList[$i], $BackUpPath & $seafile, 8)
If $ReData = 1 Then $tmpData = FileGetTime($FileList[$i], 0, 1)
$TrR = StringInStr($FileAttrib, 'R')
$TrH = StringInStr($FileAttrib, 'H')
$TrS = StringInStr($FileAttrib, 'S')
If $TrR Then FileSetAttrib($FileList[$i], '-R')
If $TrH Then FileSetAttrib($FileList[$i], '-H')
If $TrS Then FileSetAttrib($FileList[$i], '-S')
$file = FileOpen($FileList[$i], $CharSet + 2)
If Not FileWrite($file, $seatext) Then $s0 = 0
FileClose($file)
If $TrR Then FileSetAttrib($FileList[$i], '+R')
If $TrH Then FileSetAttrib($FileList[$i], '+H')
If $TrS Then FileSetAttrib($FileList[$i], '+S')
If $ReData = 1 Then FileSetTime($FileList[$i], $tmpData)
$restext &= $seafile & ' *' & $s0 & $sep
EndIf
GUICtrlSetData($ProgressBar, Ceiling($Size1 / $Size * 100))
Next
HotKeySet("{ESC}")
GUICtrlDelete($ProgressBar)
If $restext = '' Then
GUICtrlSetData($StatusBar, 'Econ (' & $SizeText & ') ' & $FileList[0] & ' / ' & $FileList[0] & ' / ' & $kol & '   ' & $LngSb3 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
GUICtrlSetData($Out, '')
_stat(0)
Else
GUICtrlSetData($StatusBar, 'Econ (' & $SizeText & ') ' & $FileList[0] & ' / ' & $FileList[0] & ' / ' & $kol & '   ' & $LngSb4 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
GUICtrlSetData($Out, '')
GUICtrlSetData($Out, $restext)
_stat(1)
ControlFocus($Gui, '', $Out)
EndIf
If $CharSetAuto Then $CharSet = -1
$aTextScr = ''
$TrScr = 0
$Tr_Sea = 0
GUICtrlSetPos($StopBut, -20, -20, 1, 1)
_Enable()
EndFunc   
Func _ReplaceFull($Search, $Replace, $Casesense, $RegExp, $CRLF, $BackUp, $Path, $Mask, $Include, $Depth, $ReData, $ExcldAttrib, $CharSet, $stat)
$restext = ''
Local $BackUpPath, $file, $FileList, $i, $j, $LenPath, $seatext, $tmpData, $TrR, $TrH, $TrS, $aExcAttrib, $Size2
If $CharSet = -1 Then
$CharSetAuto = 1
Else
$CharSetAuto = 0
EndIf
If $CRLF Then _CRLF($CRLF, $Search, $Replace)
If StringRight($Path, 1) <> '\' Then $Path &= '\'
If $BackUp Then
$BackUpPath = _BackUp($BackUp) & StringRegExpReplace($Path, '^(.*\\)(.*?\\)$', '\2')
If @error Then Return SetError(1, 0, '')
EndIf
$timer = TimerInit()
$Depth = 0
If $inisub = 1 Then $Depth = 125
If $Include Then
$Include = True
Else
$Include = False
EndIf
$FileList = _FO_FileSearch($Path, _FO_CorrectMask($Mask), $Include, $Depth, 1, 1, 1, $sLocale) 
If @error Then
GUICtrlSetData($StatusBar, $LngSb3 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
_stat(0)
_Enable()
Return SetError(1, 0, '')
EndIf
If $FileList[0] > $iniLimitFile And MsgBox(4, $LngErr, $LngMB7 & $FileList[0] & $LngMB8 & $iniLimitFile & $LngMB9, 0, $Gui) = 7 Then
GUICtrlSetData($StatusBar, $LngCnl)
_stat(0)
_Enable()
Return SetError(1, 0, '')
EndIf
Local $FileSize[$FileList[0] + 1] = [$FileList[0]] 
$Size = 0
For $i = 1 To $FileList[0]
$FileSize[$i] = FileGetSize($FileList[$i])
$Size += $FileSize[$i]
Next
If $Size > $iniLimitSize * 1048576 And MsgBox(4, $LngErr, $LngMB10 & Round($Size / 1048576, 2) & $LngMB11 & $iniLimitSize & $LngMB12, 0, $Gui) = 7 Then
GUICtrlSetData($StatusBar, $LngCnl)
_stat(0)
_Enable()
Return SetError(1, 0, '')
EndIf
$SizeText = _ConvertFileSize($Size)
$GuiPos = WinGetPos($Gui)
$ProgressBar = GUICtrlCreateProgress($GuiPos[2] - 110, 233, 100, 16)
GUICtrlSetColor(-1, 32250)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetPos($StopBut, $GuiPos[2] - 90, 185, 80, 17)
$LenPath = StringLen($Path)
$Size1 = 0
$kol = 0
$ExcldAttrib = StringRegExpReplace($ExcldAttrib, '(?i)[^RASHNOT]', '') 
$aExcAttrib = StringSplit($ExcldAttrib, '')
HotKeySet("{ESC}", "_StopBut")
For $i = 1 To $FileList[0]
If $TrStop Then
GUICtrlSetData($StatusBar, $LngCnl)
GUICtrlDelete($ProgressBar)
GUICtrlSetPos($StatusBar, 5, 233, $GuiPos[2] - 10, 15)
GUICtrlSetPos($StopBut, -20, -20, 1, 1)
_stat(0)
$TrStop = 0
_Enable()
Return SetError(1, 0, '')
EndIf
$Size1 += $FileSize[$i]
If $FileSize[$i] > $iniErrSize Then ContinueLoop
$seafile = StringTrimLeft($FileList[$i], $LenPath)
GUICtrlSetData($StatusBar, $stat & ' (' & $SizeText & ') ' & $FileList[0] & ' / ' & $i & ' / ' & $kol & ' / ' & $seafile)
$FileAttrib = FileGetAttrib($FileList[$i])
For $j = 1 To $aExcAttrib[0]
If StringInStr($FileAttrib, $aExcAttrib[$j]) Then ContinueLoop 2
Next
If $CharSetAuto Then
$CharSet = FileGetEncoding($FileList[$i])
Else
If $CharSet <> 16 And $CharSet <> FileGetEncoding($FileList[$i]) Then ContinueLoop
EndIf
$file = FileOpen($FileList[$i], $CharSet)
If $file = -1 Then ContinueLoop
$seatext = FileRead($file)
FileClose($file)
If $RegExp Then
$seatext = StringRegExpReplace($seatext, $Search, $Replace)
$s0 = @extended
Else
$seatext = StringReplace($seatext, $Search, $Replace, 0, $Casesense)
$s0 = @extended
EndIf
If $s0 <> 0 Then
$kol += 1
If $BackUp = 1 Then FileCopy($FileList[$i], $BackUpPath & $seafile, 8)
If $ReData = 1 Then $tmpData = FileGetTime($FileList[$i], 0, 1)
$TrR = StringInStr($FileAttrib, 'R')
$TrH = StringInStr($FileAttrib, 'H')
$TrS = StringInStr($FileAttrib, 'S')
If $TrR Then FileSetAttrib($FileList[$i], '-R')
If $TrH Then FileSetAttrib($FileList[$i], '-H')
If $TrS Then FileSetAttrib($FileList[$i], '-S')
$file = FileOpen($FileList[$i], $CharSet + 2)
If Not FileWrite($file, $seatext) Then $s0 = 0
FileClose($file)
If $TrR Then FileSetAttrib($FileList[$i], '+R')
If $TrH Then FileSetAttrib($FileList[$i], '+H')
If $TrS Then FileSetAttrib($FileList[$i], '+S')
If $ReData = 1 Then FileSetTime($FileList[$i], $tmpData)
$restext &= $seafile & ' *' & $s0 & $sep
EndIf
GUICtrlSetData($ProgressBar, Ceiling($Size1 / $Size * 100))
Next
HotKeySet("{ESC}")
GUICtrlDelete($ProgressBar)
If $restext = '' Then
GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' / ' & $FileList[0] & ' / ' & $kol & '   ' & $LngSb3 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
GUICtrlSetData($Out, '')
_stat(0)
Else
GUICtrlSetData($StatusBar, '(' & $SizeText & ') ' & $FileList[0] & ' / ' & $FileList[0] & ' / ' & $kol & '   ' & $LngSb4 & ' ' & Ceiling(TimerDiff($timer) / 1000) & ' ' & $LngSbS)
GUICtrlSetData($Out, '')
GUICtrlSetData($Out, $restext)
_stat(1)
ControlFocus($Gui, '', $Out)
EndIf
If $CharSetAuto Then $CharSet = -1
$aTextScr = ''
$TrScr = 0
$Tr_Sea = 0
GUICtrlSetPos($StopBut, -20, -20, 1, 1)
_Enable()
EndFunc   
Func _AddRep()
$tmpPath = FileSaveDialog($LngSVD, @WorkingDir & "", $LngSVD1 & " (*.srt)", 0, '', $Gui)
If @error Then Return
If StringRight($tmpPath, 4) <> '.srt' Then $tmpPath &= '.srt'
$SeaInp0 = GUICtrlRead($SeaInp)
$RepInp0 = GUICtrlRead($RepInp)
$ReData = 0
$ExcldAttrib = 0
If $iniBAK Then
If $iniPathBackup Then
$tmpPathBackup = $iniPathBackup
Else
$tmpPathBackup = 1
EndIf
Else
$tmpPathBackup = 0
EndIf
If $SeaInp0 <> $RepInp0 And $SeaInp0 <> '' Then
$text = '-->|' & $SeaInp0 & $iniSep & $RepInp0 & $iniSep & $iniAa & $iniSep & $iniREx & $iniSep & GUICtrlRead($CRLF) & $iniSep & $tmpPathBackup & $iniSep & GUICtrlRead($PatInp) & $iniSep & GUICtrlRead($TypInp) & $iniSep & $iniExc & $iniSep & $inisub & $iniSep & $ReData & $iniSep & $ExcldAttrib & $iniSep & _CharNumToName($CharSet) & '|<--'
$file = FileOpen($tmpPath, 1 + 8)
If FileGetSize($tmpPath) = 0 Then
FileWrite($file, $text)
Else
FileWrite($file, @CRLF & $text)
EndIf
FileClose($file)
Else
MsgBox(0, $LngErr, $LngMB3, 0, $Gui)
Return
EndIf
EndFunc   
Func _Enable()
GUICtrlSetState($SeaBut, $GUI_ENABLE)
GUICtrlSetState($RepBut, $GUI_ENABLE)
EndFunc   
Func _ScrRep()
$tmpPath = FileOpenDialog($LngOD, @WorkingDir & "", $LngSVD1 & " (*.srt)", 1 + 4, '', $Gui)
If @error Then Return
$ScrPath = $tmpPath
_Disp()
EndFunc   
Func _EditBut()
$Out0 = GUICtrlRead($Out)
If Not $Out0 Then Return 
$Out0 = StringLeft($Out0, StringInStr($Out0, '*') - 2)
Run($Editor & ' ' & $PatInp0 & $Out0)
EndFunc   
Func _OpenExpr()
$Out0 = GUICtrlRead($Out)
If Not $Out0 Then Return 
$Out0 = StringLeft($Out0, StringInStr($Out0, '*') - 2)
Run('Explorer.exe /select,"' & $PatInp0 & $Out0 & '"')
EndFunc   
Func _ListBox_GetText()
If MsgBox(4, '?', 'Only name?') = 6 Then
ClipPut(StringTrimRight(StringRegExpReplace($restext, '\s+\*[p\d]+\001', @CRLF), 2))
Else
ClipPut(StringTrimRight(StringReplace($restext, $sep, @CRLF), 2))
EndIf
EndFunc
Func _StrBut()
$Out0 = GUICtrlRead($Out)
If Not $Out0 Then Return 
$Out0 = StringLeft($Out0, StringInStr($Out0, '*') - 2)
ShellExecute($PatInp0 & $Out0)
EndFunc   
Func _EditFBut()
$Out0 = GUICtrlRead($Out)
If Not $Out0 Then Return 
$Out0 = StringLeft($Out0, StringInStr($Out0, '*') - 2)
Run($Editor & ' ' & $PatInp0 & $Out0)
If $hf <> '' Then
Sleep(100)
$nameEditor = StringRegExpReplace($Editor, '(^.*)\\(.*)$', '\2')
$AllWindows = WinList()
For $i = 1 To $AllWindows[0][0]
If $AllWindows[$i][0] And BitAND(WinGetState($AllWindows[$i][1]), 2) And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][1])), StringLen($nameEditor) + 1) = '\' & $nameEditor Then
WinActivate($AllWindows[$i][1])
If WinWaitActive($AllWindows[$i][1], '', 3) Then 
Sleep(30)
Send('^{' & $hf & '}')
Sleep(30)
ClipPut($SeaInp0)
Sleep(30)
If WinWaitNotActive($AllWindows[$i][1], "", 1) And StringRight(_ProcessGetPath(WinGetProcess('[ACTIVE]')), StringLen($nameEditor) + 1) = '\' & $nameEditor Then 
Send('+{INS}')
Sleep(30)
Send('{Enter}')
EndIf
ExitLoop
EndIf
EndIf
Next
EndIf
EndFunc   
Func _Folder1()
$tmpPath = FileOpenDialog($LngOD, @WorkingDir, $LngOD1 & " (*.*)", 1 + 4, "", $Gui)
If @error Then Return
_mask($tmpPath)
EndFunc   
Func _Folder2()
$PatInp0 = GUICtrlRead($PatInp)
While Not FileExists($PatInp0)
$PatInp0 = StringRegExpReplace($PatInp0, '(^.*)\\(.*)$', '\1')
If Not @extended Then ExitLoop
WEnd
If Not FileExists($PatInp0) Then $PatInp0 = @WorkingDir
$tmpPath = FileSelectFolder($LngOF, '', 2, $PatInp0, $Gui)
If @error Then Return
_ComboBox_InsertPath($tmpPath, $iniPath, $PatInp)
EndFunc   
Func _ComboBox_InsertPath($item, ByRef $iniList, $ctrlID)
$iniList = StringReplace($sep & $iniList & $sep, $sep & $item & $sep, $sep)
$iniList = StringReplace($iniList, $sep & $item & '\' & $sep, $sep)
$iniList = $item & StringTrimRight($iniList, 1)
$tmp = StringInStr($iniList, $sep, 0, $KolStr)
If $tmp Then $iniList = StringLeft($iniList, $tmp - 1)
GUICtrlSetData($ctrlID, $sep & $iniList, $item)
EndFunc   
Func _mask($tmp)
$tmp = _FO_PathSplit($tmp)
$tmp = $tmp[2]
If $tmp Then
$tmp = '*' & $tmp
Else
Return
EndIf
$TypInp0 = GUICtrlRead($TypInp)
If StringInStr('|' & $TypInp0 & '|', '|' & $tmp & '|') Then
MsgBox(0, $LngErr, $LngMB6, 0, $Gui)
Return
EndIf
If $TypInp0 = '' Or $TypInp0 = '*' Then
GUICtrlSetData($TypInp, $tmp)
GUICtrlSetData($TypInp, $tmp)
Else
GUICtrlSetData($TypInp, $TypInp0 & '|' & $tmp)
GUICtrlSetData($TypInp, $TypInp0 & '|' & $tmp)
EndIf
EndFunc   
Func _EditBox() 
$GP = _ChildCoor($Gui, 340, 330)
GUISetState(@SW_DISABLE, $Gui)
$Gui1 = GUICreate($LngMLineSH, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_OVERLAPPEDWINDOW, $WS_POPUP), -1, $Gui)
If Not @Compiled Then GUISetIcon($AutoItExe, 99)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
$EditBoxSea = GUICtrlCreateEdit('', 5, 5, 330, 285, $ES_AUTOVSCROLL + $WS_VSCROLL + $ES_NOHIDESEL + $ES_WANTRETURN)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
$CRLF0 = GUICtrlRead($CRLF)
$SeaInp0 = GUICtrlRead($SeaInp)
If $CRLF0 Then _CRLF($CRLF0, $SeaInp0, '')
GUICtrlSetData($EditBoxSea, $SeaInp0)
$OK = GUICtrlCreateButton("OK", 140, $GP[3] - 35, 60, 30)
GUICtrlSetOnEvent(-1, "_EditBox_OK")
GUICtrlSetResizing(-1, 256 + 512 + 64 + 128)
GUISetState(@SW_SHOW, $Gui1)
EndFunc   
Func _EditBox_OK()
$EditBoxSea0 = GUICtrlRead($EditBoxSea)
$CRLF0 = GUICtrlRead($CRLF)
If Not (StringInStr($EditBoxSea0, @CR) Or StringInStr($EditBoxSea0, @LF)) Then
_GUICtrlComboBox_SetEditText($CRLF, '')
_GUICtrlComboBox_SetEditText($SeaInp, $EditBoxSea0)
Return _Exit1()
EndIf
$tmp = StringReplace($EditBoxSea0, @CRLF, '')
If Not (StringInStr($tmp, @CR) Or StringInStr($tmp, @LF)) Then 
$CRLF0 = _CRLF_Define($EditBoxSea0) 
If @error Then Return _Exit1()
Else
$CRLF0 = _CRLF_Define($EditBoxSea0)
If @error Then Return _Exit1()
$CRLF0 &= _CRLF_Define($EditBoxSea0 & $CRLF0)
If @error Then Return _Exit1()
EndIf
_GUICtrlComboBox_SetEditText($CRLF, $CRLF0)
$tmp = StringLen($CRLF0)
If $tmp = 1 Then
_GUICtrlComboBox_SetEditText($SeaInp, StringReplace($EditBoxSea0, @CRLF, $CRLF0))
ElseIf $tmp = 2 Then
_GUICtrlComboBox_SetEditText($SeaInp, StringReplace(StringReplace($EditBoxSea0, @CR, StringLeft($CRLF0, 1)), @LF, StringRight($CRLF0, 1)))
EndIf
_Exit1()
EndFunc   
Func _EditBoxM() 
$GP = _ChildCoor($Gui, 340, 330)
GUISetState(@SW_DISABLE, $Gui)
$Gui1 = GUICreate($LngMLineRH, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_OVERLAPPEDWINDOW, $WS_POPUP), -1, $Gui)
If Not @Compiled Then GUISetIcon($AutoItExe, 99)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
$CRLF0 = GUICtrlRead($CRLF)
$SeaInp0 = GUICtrlRead($SeaInp)
$RepInp0 = GUICtrlRead($RepInp)
If $CRLF0 Then _CRLF($CRLF0, $SeaInp0, $RepInp0)
$EditBoxSea = GUICtrlCreateEdit('', 5, 5, 330, 140, $ES_AUTOVSCROLL + $WS_VSCROLL + $ES_NOHIDESEL + $ES_WANTRETURN)
GUICtrlSetData($EditBoxSea, $SeaInp0)
GUICtrlSetResizing(-1, 1)
$EditBoxRep = GUICtrlCreateEdit('', 5, 150, 330, 140, $ES_AUTOVSCROLL + $WS_VSCROLL + $ES_NOHIDESEL + $ES_WANTRETURN)
GUICtrlSetData($EditBoxRep, $RepInp0)
GUICtrlSetResizing(-1, 1)
$OK = GUICtrlCreateButton("OK", 140, $GP[3] - 35, 60, 30)
GUICtrlSetOnEvent(-1, "_EditBoxM_OK")
GUICtrlSetResizing(-1, 1)
GUISetState(@SW_SHOW, $Gui1)
EndFunc   
Func _EditBoxM_OK()
$EditBoxSea0 = GUICtrlRead($EditBoxSea)
$EditBoxRep0 = GUICtrlRead($EditBoxRep)
$CRLF0 = GUICtrlRead($CRLF)
$total = $EditBoxSea0 & $EditBoxRep0
If Not (StringInStr($total, @CR) Or StringInStr($total, @LF)) Then
_GUICtrlComboBox_SetEditText($CRLF, '')
_GUICtrlComboBox_SetEditText($SeaInp, $EditBoxSea0)
_GUICtrlComboBox_SetEditText($RepInp, $EditBoxRep0)
Return _Exit1()
EndIf
$tmp = StringReplace($total, @CRLF, '')
If Not (StringInStr($tmp, @CR) Or StringInStr($tmp, @LF)) Then 
$CRLF0 = _CRLF_Define($total) 
If @error Then Return _Exit1()
Else
$CRLF0 = _CRLF_Define($total)
If @error Then Return _Exit1()
$CRLF0 &= _CRLF_Define($total & $CRLF0)
If @error Then Return _Exit1()
EndIf
_GUICtrlComboBox_SetEditText($CRLF, $CRLF0)
$tmp = StringLen($CRLF0)
If $tmp = 1 Then
_GUICtrlComboBox_SetEditText($SeaInp, StringReplace($EditBoxSea0, @CRLF, $CRLF0))
_GUICtrlComboBox_SetEditText($RepInp, StringReplace($EditBoxRep0, @CRLF, $CRLF0))
ElseIf $tmp = 2 Then
_GUICtrlComboBox_SetEditText($SeaInp, StringReplace(StringReplace($EditBoxSea0, @CR, StringLeft($CRLF0, 1)), @LF, StringRight($CRLF0, 1)))
_GUICtrlComboBox_SetEditText($RepInp, StringReplace(StringReplace($EditBoxRep0, @CR, StringLeft($CRLF0, 1)), @LF, StringRight($CRLF0, 1)))
EndIf
_Exit1()
EndFunc   
Func _CRLF_Define($text)
Local $i, $a = ChrW(0x00A9) & ChrW(0x00AE) & ChrW(0x00AB) & ChrW(0x00BB) & ChrW(0x2030) & ChrW(0x00A7) & ChrW(0x00B5) & ChrW(0x20AC) & ChrW(0x2122)
$a = StringSplit('~@%&*^#\/+-_{}[]`<>' & $a, '')
For $i = 1 To $a[0]
If Not StringInStr($text, $a[$i]) Then Return $a[$i]
Next
Return SetError(1, 0, '')
EndFunc   
Func _Setting()
$GP = _ChildCoor($Gui, 340, 360)
GUISetState(@SW_DISABLE, $Gui)
$Gui1 = GUICreate($LngbSet, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
If Not @Compiled Then GUISetIcon($AutoItExe, 99)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
$LbLimitSize = GUICtrlCreateLabel($LngSzFl, 10, 10, 245, 17)
$InpLimitSize = GUICtrlCreateInput($iniLimitSize, 260, 6, 50, 22)
$LbLimitFile = GUICtrlCreateLabel($LngMFile, 10, 32, 245, 17)
$InpLimitFile = GUICtrlCreateInput($iniLimitFile, 260, 30, 50, 22)
$LbPathBackup = GUICtrlCreateLabel($LngBakPh, 10, 53, 260, 17)
$InpPathBackup = GUICtrlCreateInput($iniPathBackup, 10, 70, 320, 22)
$Search = FileFindFirstFile(@ScriptDir & '\Lang\*.lng')
If $Search <> -1 Then
$LangList = 'none'
While 1
$file = FileFindNextFile($Search)
If @error Then ExitLoop
$LangList &= $sep & $file
WEnd
GUICtrlCreateLabel('Language', 10, 103, 65, 17)
$ComboLang = GUICtrlCreateCombo('', 75, 100, 80, 22, $CBS_DROPDOWNLIST + $WS_VSCROLL)
GUICtrlSetData(-1, $LangList, $LangPath)
GUICtrlSetOnEvent(-1, "_SetLang")
EndIf
FileClose($Search)
$LbHst = GUICtrlCreateLabel($LngHst, 10, 130, 250, 17)
$InpHst = GUICtrlCreateInput($KolStr, 260, 127, 50, 22)
$IgnGr = GUICtrlCreateGroup($LngIgnGr, 10, 155, 320, 56)
$atrR = GUICtrlCreateCheckbox($LngAtrR & ' (R)', 20, 170, 130, 17)
If StringInStr($ExcldAttrib, 'R') Then GUICtrlSetState(-1, 1)
$atrA = GUICtrlCreateCheckbox($LngAtrA & ' (A)', 20, 190, 130, 17)
If StringInStr($ExcldAttrib, 'A') Then GUICtrlSetState(-1, 1)
$atrH = GUICtrlCreateCheckbox($LngAtrH & ' (H)', 150, 170, 130, 17)
If StringInStr($ExcldAttrib, 'H') Then GUICtrlSetState(-1, 1)
$atrS = GUICtrlCreateCheckbox($LngAtrS & ' (S)', 150, 190, 130, 17)
If StringInStr($ExcldAttrib, 'S') Then GUICtrlSetState(-1, 1)
$ChData = GUICtrlCreateCheckbox($LngData, 10, 220, 300, 17)
If $ReData = 1 Then GUICtrlSetState(-1, 1)
$LbChS = GUICtrlCreateLabel($LngChS, 10, 247, 65, 17)
$ComboChar = GUICtrlCreateCombo('', 75, 245, 140, 22, $CBS_DROPDOWNLIST + $WS_VSCROLL)
GUICtrlSetData($ComboChar, 'Auto' & $sep & 'ANSI' & $sep & 'Bin' & $sep & 'UTF16 Little Endian' & $sep & 'UTF16 Big Endian' & $sep & 'UTF8 (+ BOM)' & $sep & 'UTF8 (- BOM)', _CharNumToName($CharSet))
$LbErrSize = GUICtrlCreateLabel($LngSzEr, 10, 273, 245, 34)
$InpErrSize = GUICtrlCreateInput(Int($iniErrSize / 1024), 260, 276, 50, 22)
$OK = GUICtrlCreateButton("OK", 140, $GP[3] - 48, 60, 30)
GUICtrlSetOnEvent(-1, "_Setting_OK")
GUISetState(@SW_SHOW, $Gui1)
EndFunc   
Func _Setting_OK()
$CharSet = _CharNameToNum(GUICtrlRead($ComboChar))
$tmp = StringReplace(GUICtrlRead($InpLimitSize), ',', '.')
If StringRegExp($tmp, '^\d+(.\d+)?$') And $tmp <> '0' Then
$iniLimitSize = Number($tmp)
Else
MsgBox(0, $LngErr, $LngMB13)
EndIf
$tmp = GUICtrlRead($InpErrSize)
If Not StringIsDigit($tmp) Or $tmp = '0' Then
MsgBox(0, $LngErr, $LngMB13)
Else
$iniErrSize = Number($tmp) * 1024
EndIf
$tmp = GUICtrlRead($InpLimitFile)
If Not StringIsDigit($tmp) Or $tmp = '0' Then
MsgBox(0, $LngErr, $LngMB14)
Else
$iniLimitFile = Number($tmp)
EndIf
$tmp = Int(GUICtrlRead($InpHst))
If $tmp < 1 Or $tmp > 50 Then
MsgBox(0, $LngErr, $LngMB15)
Else
$KolStr = $tmp
EndIf
$ExcldAttrib = ''
If GUICtrlRead($atrR) = 1 Then $ExcldAttrib &= 'R'
If GUICtrlRead($atrA) = 1 Then $ExcldAttrib &= 'A'
If GUICtrlRead($atrH) = 1 Then $ExcldAttrib &= 'H'
If GUICtrlRead($atrS) = 1 Then $ExcldAttrib &= 'S'
If GUICtrlRead($ChData) = 1 Then
$ReData = 1
Else
$ReData = 0
EndIf
$iniPathBackup = GUICtrlRead($InpPathBackup)
If $iniPathBackup And Not (StringRegExp($iniPathBackup, '(?i)^[a-z]:[^/:*?"<>|]*$') And StringInStr('|Removable|Fixed|', '|' & DriveGetType(StringLeft($iniPathBackup, 1) & ':\') & '|') And Not StringInStr($iniPathBackup, '\\')) Then
MsgBox(0, $LngErr, $LngMB16)
$iniPathBackup = ''
EndIf
_Exit1()
EndFunc   
Func _CharNumToName($i)
If $CharSetAuto Then Return 'Auto'
Switch $i
Case 0
$i = 'ANSI'
Case 16
$i = 'Bin'
Case 32
$i = 'UTF16 Little Endian'
Case 64
$i = 'UTF16 Big Endian'
Case 128
$i = 'UTF8 (+ BOM)'
Case 256
$i = 'UTF8 (- BOM)'
Case Else
$i = 'Auto'
EndSwitch
Return $i
EndFunc   
Func _CharNameToNum($i)
If $i = 'Auto' Then
$CharSetAuto = 1
Else
$CharSetAuto = 0
EndIf
Switch $i
Case 'Auto'
$i = -1
Case 'ANSI'
$i = 0
Case 'Bin'
$i = 16
Case 'UTF16 Little Endian'
$i = 32
Case 'UTF16 Big Endian'
$i = 64
Case 'UTF8 (+ BOM)'
$i = 128
Case 'UTF8 (- BOM)'
$i = 256
Case Else
$i = -1
EndSwitch
Return $i
EndFunc   
Func _SetLang()
Local $aLng
$LangPath = GUICtrlRead($ComboLang)
If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then
$aLng = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng')
If Not @error Then
For $i = 1 To $aLng[0][0]
If StringInStr($aLng[$i][1], '\r\n') Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\r\n', @CRLF)
If IsDeclared('Lng' & $aLng[$i][0]) Then Assign('Lng' & $aLng[$i][0], $aLng[$i][1])
Next
_SetLang2()
IniWrite($Ini, 'Set', 'Lang', $LangPath)
EndIf
Else
For $i = 1 To $aLng0[0][0]
If StringInStr($aLng0[$i][1], '\r\n') Then $aLng0[$i][1] = StringReplace($aLng0[$i][1], '\r\n', @CRLF)
Assign('Lng' & $aLng0[$i][0], $aLng0[$i][1])
Next
_SetLang2()
IniWrite($Ini, 'Set', 'Lang', 'none')
EndIf
EndFunc   
Func _SetLang2()
WinSetTitle($Gui1, '', $LngbSet)
GUICtrlSetTip($About, $LngAbout)
GUICtrlSetTip($restart, $LngRest)
If $iniBAK Then
GUICtrlSetTip($BAKBut, $LngBAKH2)
Else
GUICtrlSetTip($BAKBut, $LngBAKH1)
EndIf
If $iniREx Then
GUICtrlSetTip($RExBut, $LngRExH2)
Else
GUICtrlSetTip($RExBut, $LngRExH1)
EndIf
If $iniAa Then
GUICtrlSetTip($AaBut, $LngAaH2)
Else
GUICtrlSetTip($AaBut, $LngAaH1)
EndIf
If $iniOutRes Then
GUICtrlSetTip($OutRBut, $LngOutRH2)
Else
GUICtrlSetTip($OutRBut, $LngOutRH1)
EndIf
If $inisub Then
GUICtrlSetTip($SubBut, $LngSubH2)
Else
GUICtrlSetTip($SubBut, $LngSubH1)
EndIf
If $iniExc Then
GUICtrlSetTip($ExcBut, $LngExcH2)
Else
GUICtrlSetTip($ExcBut, $LngExcH1)
EndIf
GUICtrlSetTip($CRLF, $LngCRLFH)
GUICtrlSetTip($CRLFLab, $LngCRLFH)
GUICtrlSetTip($spec, $LngPSmb)
GUICtrlSetTip($SeaBut, $LngSea)
GUICtrlSetTip($SeaClear, $LngCr)
GUICtrlSetTip($RepBut, $LngRep)
GUICtrlSetTip($RepClear, $LngCr)
GUICtrlSetTip($ScrRep, $LngOScr)
GUICtrlSetTip($AddRep, $LngAScr)
GUICtrlSetTip($TypClear, $LngCr)
GUICtrlSetTip($TypDef, $LngDef)
GUICtrlSetTip($EditBut, $LngEdH)
GUICtrlSetTip($EditFBut, $LngEdFH)
GUICtrlSetTip($StrBut, $LngStH)
GUICtrlSetTip($RBrBut, $LngRBrH)
GUICtrlSetTip($EprBut, $LngEpr)
GUICtrlSetTip($LstBut, $LngLst)
GUICtrlSetTip($MLineS, $LngMLineSH)
GUICtrlSetTip($MLineR, $LngMLineRH)
GUICtrlSetData($CRLFLab, $LngCRLF)
GUICtrlSetData($specLab, $LngPSmb)
GUICtrlSetData($SeaLab, $LngSea)
GUICtrlSetData($RepLab, $LngRep)
GUICtrlSetData($TypLab, $LngMsk)
GUICtrlSetData($PatLab, $LngPth)
GUICtrlSetData($StatusBar, $LngSb1)
GUICtrlSetData($EditBut, $LngEd)
GUICtrlSetData($EditFBut, $LngEdF)
GUICtrlSetData($StrBut, $LngSt)
GUICtrlSetData($StopBut, $LngSp)
GUICtrlSetData($Cont1, $LngEd)
GUICtrlSetData($Cont3, $LngEdF)
GUICtrlSetData($Cont2, $LngSt)
GUICtrlSetData($Cont4, $LngEpr)
GUICtrlSetData($LbLimitSize, $LngSzFl)
GUICtrlSetData($LbLimitFile, $LngMFile)
GUICtrlSetData($LbPathBackup, $LngBakPh)
GUICtrlSetData($LbHst, $LngHst)
GUICtrlSetData($IgnGr, $LngIgnGr)
GUICtrlSetData($atrR, $LngAtrR)
GUICtrlSetData($atrA, $LngAtrA)
GUICtrlSetData($atrH, $LngAtrH)
GUICtrlSetData($atrS, $LngAtrS)
GUICtrlSetData($ChData, $LngData)
GUICtrlSetData($LbChS, $LngChS)
GUICtrlSetData($LbErrSize, $LngSzEr)
EndFunc   
Func _ReadScenario($ScrPath)
Local $m, $sTmp, $tmp, $i
$tmp = StringReplace(FileRead($ScrPath), $iniSep, $sep)
$tmp = StringRegExp($tmp, '(?m)^-->\|(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)' & $sep & '(.*?)\|<--', 3)
If @error Then Return SetError(1)
$sTmp = UBound($tmp)
Dim $aScenario[$sTmp / 13][13]
$m = 0
For $i = 0 To $sTmp - 1 Step 13
$aScenario[$m][0] = $tmp[$i]
$aScenario[$m][1] = $tmp[$i + 1]
$aScenario[$m][2] = $tmp[$i + 2]
$aScenario[$m][3] = $tmp[$i + 3]
$aScenario[$m][4] = $tmp[$i + 4]
$aScenario[$m][5] = $tmp[$i + 5]
$aScenario[$m][6] = $tmp[$i + 6]
$aScenario[$m][7] = $tmp[$i + 7]
$aScenario[$m][8] = $tmp[$i + 8]
$aScenario[$m][9] = $tmp[$i + 9]
$aScenario[$m][10] = $tmp[$i + 10]
$aScenario[$m][11] = $tmp[$i + 11]
$aScenario[$m][12] = $tmp[$i + 12]
$m += 1
Next
EndFunc   
Func _Disp()
Local $GP, $i, $LVSR, $x
_ReadScenario($ScrPath)
If @error Then Return
$x = @DesktopWidth - 20
If $x > 1120 Then $x = 1100
$GP = _ChildCoor($Gui, $x, 420)
GUISetState(@SW_DISABLE, $Gui)
$Gui1 = GUICreate($LngG1T, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_OVERLAPPEDWINDOW, $WS_POPUP), -1, $Gui)
If Not @Compiled Then GUISetIcon($AutoItExe, 205)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
$LVSR = GUICtrlCreateListView($LngLV1 & $sep & $LngLV2 & $sep & 'Aa' & $sep & 'REx' & $sep & 'CRLF' & $sep & 'BAK' & $sep & 'Path' & $sep & 'Mask' & $sep & 'Exc' & $sep & 'Sub' & $sep & 'Data' & $sep & 'Attrib' & $sep & 'Char', 5, 5, $x - 10, 380, -1, 0x00000001)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
GUICtrlSendMsg(-1, 0x1000 + 30, 0, 203) 
GUICtrlSendMsg(-1, 0x1000 + 30, 1, 203)
For $i = 0 To UBound($aScenario) - 1
GUICtrlCreateListViewItem($aScenario[$i][0] & $sep & $aScenario[$i][1] & $sep & $aScenario[$i][2] & $sep & $aScenario[$i][3] & $sep & $aScenario[$i][4] & $sep & $aScenario[$i][5] & $sep & $aScenario[$i][6] & $sep & $aScenario[$i][7] & $sep & $aScenario[$i][8] & $sep & $aScenario[$i][9] & $sep & $aScenario[$i][10] & $sep & $aScenario[$i][11] & $sep & $aScenario[$i][12], $LVSR)
Next
$ScrStart = GUICtrlCreateButton($LngUS, $x / 2 - 70, 390, 140, 25)
GUICtrlSetTip(-1, $LngUSH)
GUICtrlSetResizing(-1, 8 + 64 + 256 + 512)
GUICtrlSetOnEvent(-1, "_ScrStart")
GUISetState(@SW_SHOW, $Gui1)
EndFunc   
Func _ScrStart()
$TrScr = 1
_Exit1()
$aTextScr = $aScenario
GUICtrlSetData($SeaInp, $ScrPath)
GUICtrlSetData($SeaInp, $ScrPath)
GUICtrlSetData($RepInp, $ScrPath)
GUICtrlSetData($RepInp, $ScrPath)
EndFunc   
Func _Exit()
_saveini(1)
GUIDelete($Gui)
GUIDelete($Gui1)
EndFunc   
Func _Quit()
Exit
EndFunc   
Func _saveini($ty = 1)
Local $iState
$SeaInp0 = GUICtrlRead($SeaInp)
$RepInp0 = GUICtrlRead($RepInp)
$TypInp0 = GUICtrlRead($TypInp)
If Not ($SeaInp0 = $RepInp0 And StringRight($RepInp0, 4) = '.srt' And FileExists($RepInp0)) Then
$iniSea = StringReplace($sep & $iniSea & $sep, $sep & $SeaInp0 & $sep, $sep)
$iniSea = $SeaInp0 & StringTrimRight($iniSea, 1)
$tmp = StringInStr($iniSea, $sep, 0, $KolStr)
If $tmp Then $iniSea = StringLeft($iniSea, $tmp - 1)
GUICtrlSetData($SeaInp, $sep & $iniSea, $SeaInp0)
$iniRep = StringReplace($sep & $iniRep & $sep, $sep & $RepInp0 & $sep, $sep)
$iniRep = $RepInp0 & StringTrimRight($iniRep, 1)
$tmp = StringInStr($iniRep, $sep, 0, $KolStr)
If $tmp Then $iniRep = StringLeft($iniRep, $tmp - 1)
GUICtrlSetData($RepInp, $sep & $iniRep, $RepInp0)
EndIf
If $TypInp0 Then
$iniMask = StringReplace($sep & $iniMask & $sep, $sep & $TypInp0 & $sep, $sep)
$iniMask = $TypInp0 & StringTrimRight($iniMask, 1)
$tmp = StringInStr($iniMask, $sep, 0, $KolStr)
If $tmp Then $iniMask = StringLeft($iniMask, $tmp - 1)
GUICtrlSetData($TypInp, $sep & $iniMask, $TypInp0)
EndIf
If $ty = 1 Then
IniWrite($Ini, 'Set', 'Search', StringReplace(StringReplace('"' & $iniSea & '"', $sep & $sep, $sep), $sep, $iniSep))
IniWrite($Ini, 'Set', 'Replace', StringReplace(StringReplace('"' & $iniRep & '"', $sep & $sep, $sep), $sep, $iniSep))
IniWrite($Ini, 'Set', 'Mask', StringReplace('"' & $iniMask & '"', $sep, $iniSep))
IniWrite($Ini, 'Set', 'Path', StringReplace($iniPath, $sep, $iniSep))
IniWrite($Ini, 'Set', 'Aa', $iniAa)
IniWrite($Ini, 'Set', 'sub', $inisub)
IniWrite($Ini, 'Set', 'REx', $iniREx)
IniWrite($Ini, 'Set', 'BAK', $iniBAK)
IniWrite($Ini, 'Set', 'OutRes', $iniOutRes)
IniWrite($Ini, 'Set', 'ExceptMask', $iniExc)
IniWrite($Ini, 'Set', 'Lang', $LangPath)
IniWrite($Ini, 'Set', 'PathBackup', $iniPathBackup)
IniWrite($Ini, 'Set', 'LimitSize', $iniLimitSize)
IniWrite($Ini, 'Set', 'LimitFile', $iniLimitFile)
IniWrite($Ini, 'Set', 'ErrSize', $iniErrSize)
IniWrite($Ini, 'Set', 'History', $KolStr)
Switch $CharSet
Case 0
$tmp = 'ANSI'
Case 16
$tmp = 'Bin'
Case 32
$tmp = 'UTF16 Little Endian'
Case 64
$tmp = 'UTF16 Big Endian'
Case 128
$tmp = 'UTF8 (+ BOM)'
Case 256
$tmp = 'UTF8 (- BOM)'
Case Else
$tmp = 'Auto'
EndSwitch
IniWrite($Ini, 'Set', 'CharSet', $tmp)
IniWrite($Ini, 'Set', 'PosW', $WHXY[0])
IniWrite($Ini, 'Set', 'PosL', $WHXY[2])
IniWrite($Ini, 'Set', 'PosT', $WHXY[3])
IniWrite($Ini, 'Set', 'PosH', $WHXY[1])
IniWrite($Ini, 'Set', 'PosMax', $WHXY[4]) 
If $RichPos[0] Then 
IniWrite($Ini, 'Set', 'RichW', $RichPos[0])
IniWrite($Ini, 'Set', 'RichH', $RichPos[1])
IniWrite($Ini, 'Set', 'RichL', $RichPos[2])
IniWrite($Ini, 'Set', 'RichT', $RichPos[3])
IniWrite($Ini, 'Set', 'RichMax', $RichPos[4])
EndIf
EndIf
EndFunc   
Func _stat($stat)
Switch $TrEx & $stat
Case 01
$MinSizeH = 360
$MaxSizeH = @DesktopHeight
WinMove($Gui, "", Default, Default, Default, $WHXY[1])
$ClientSz = WinGetClientSize($Gui) 
$TrEx = 1 
GUICtrlSetPos($Out, 5, 250, $ClientSz[0] - 10, $ClientSz[1] - 283)
GUICtrlSetState($Out, $GUI_SHOW)
GUICtrlSetState($EditBut, $GUI_SHOW)
GUICtrlSetState($EditFBut, $GUI_SHOW)
GUICtrlSetState($StrBut, $GUI_SHOW)
GUICtrlSetState($EprBut, $GUI_SHOW)
GUICtrlSetState($LstBut, $GUI_SHOW)
Case 10
$MinSizeH = $aPosH2[3]
$MaxSizeH = $aPosH2[3]
WinMove($Gui, "", Default, Default, Default, 250)
$TrEx = 0
GUICtrlSetState($Out, $GUI_HIDE)
GUICtrlSetState($EditBut, $GUI_HIDE)
GUICtrlSetState($EditFBut, $GUI_HIDE)
GUICtrlSetState($StrBut, $GUI_HIDE)
GUICtrlSetState($EprBut, $GUI_HIDE)
GUICtrlSetState($LstBut, $GUI_HIDE)
EndSwitch
EndFunc   
Func _Resized() 
$GuiPos = WinGetPos($Gui)
$WHXY[2] = $GuiPos[0]
$WHXY[3] = $GuiPos[1]
$ClientSz = WinGetClientSize($Gui) 
$WHXY[0] = $ClientSz[0]
If $TrEx And $ClientSz[1] > 270 Then $WHXY[1] = $GuiPos[3]
EndFunc   
Func _Maximize() 
$WHXY[4] = 1
EndFunc   
Func _Restore() 
$WHXY[4] = 0
EndFunc   
Func WM_MOVING($hwnd, $msg, $wParam, $lParam)
Local $sRect = DllStructCreate("Int[4]", $lParam)
Switch $hwnd 
Case $Gui
$WHXY[2] = DllStructGetData($sRect, 1, 1)
$WHXY[3] = DllStructGetData($sRect, 1, 2)
EndSwitch
Return $GUI_RUNDEFMSG
EndFunc   
Func WM_GETMINMAXINFO($hwnd, $iMsg, $wParam, $lParam)
#forceref $iMsg, $wParam
Switch $hwnd 
Case $Gui
Local $tMINMAXINFO = DllStructCreate("int;int;" & _
"int MaximSizeW; int MaximSizeH;" & _
"int MaxPositionX;int MaxPositionY;" & _
"int MinSizeW; int MinSizeH;" & _
"int MaxSizeW; int MaxSizeH", _
$lParam)
DllStructSetData($tMINMAXINFO, "MinSizeW", 367) 
DllStructSetData($tMINMAXINFO, "MinSizeH", $MinSizeH) 
If Not $TrEx Then DllStructSetData($tMINMAXINFO, "MaxSizeH", $MaxSizeH) 
Case $Gui1
Local $tMINMAXINFO = DllStructCreate("int;int;" & _
"int MaximSizeW; int MaximSizeH;" & _
"int MaxPositionX;int MaxPositionY;" & _
"int MinSizeW; int MinSizeH;" & _
"int MaxSizeW; int MaxSizeH", _
$lParam)
DllStructSetData($tMINMAXINFO, "MinSizeW", 200) 
DllStructSetData($tMINMAXINFO, "MinSizeH", 200) 
EndSwitch
EndFunc   
Func _RunCMD()
Local $aTmp, $BackUp, $Casesense, $CRLF, $Include, $Depth, $Mask, $ParamLine, $Path, $RegExp, $Replace, $Search, $spr, $ReData, $ExcldAttrib
$spr = Chr(6) & Chr(1) & Chr(6) 
$ParamLine = $spr & _ArrayToString($CmdLine, $spr, 1) & $spr
$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]s(.+?)' & $spr, 3)
If Not @error And UBound($aTmp) = 1 Then
$Search = $aTmp[0]
Else
Exit 1
EndIf
$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]r(.+?)' & $spr, 3)
If Not @error And UBound($aTmp) = 1 Then
$Replace = $aTmp[0]
Else
Exit 2
EndIf
If $Search == $Replace Then Exit 6
$Casesense = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]a' & $spr)
$RegExp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]e' & $spr)
$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]w(.{1,2}?)' & $spr, 3)
If Not @error And UBound($aTmp) = 1 Then
$CRLF = $aTmp[0]
Else
$CRLF = ''
EndIf
$BackUp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]b' & $spr)
$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]b(.*?)' & $spr, 3)
If Not @error And UBound($aTmp) > 0 Then
$BackUp = $aTmp[0]
If $BackUp = '' Then $BackUp = 1
Else
$BackUp = 0
EndIf
$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]p(.+?)' & $spr, 3)
If Not @error And UBound($aTmp) = 1 Then
$Path = $aTmp[0]
Else
Exit 3
EndIf
$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]m(.*?)' & $spr, 3)
If Not @error And UBound($aTmp) = 1 Then
$Mask = $aTmp[0]
If $Mask = '' Then $Mask = '*'
Else
$Mask = '*'
EndIf
If StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]i' & $spr) Then
$Include = False
Else
$Include = True
EndIf
$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]l(\d+?)' & $spr, 3)
If Not @error And UBound($aTmp) = 1 Then
$Depth = $aTmp[0]
Else
$Depth = 125
EndIf
$ReData = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]d' & $spr)
$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]t(.+?)' & $spr, 3)
If Not @error And UBound($aTmp) = 1 Then
$ExcldAttrib = $aTmp[0]
Else
$ExcldAttrib = ''
EndIf
$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]f(.{2,4}?)' & $spr, 3)
If Not @error And UBound($aTmp) = 1 Then
Select
Case $aTmp[0] = 'ANSI'
$CharSet = 0
Case $aTmp[0] = 'Bin'
$CharSet = 16
Case $aTmp[0] = 'U16L'
$CharSet = 32
Case $aTmp[0] = 'U16B'
$CharSet = 64
Case $aTmp[0] = 'U8'
$CharSet = 128
Case $aTmp[0] = 'U8-B'
$CharSet = 256
Case Else
$CharSet = -1 
EndSelect
Else
$CharSet = 0
EndIf
$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]z(\d+?)' & $spr, 3)
If Not @error And UBound($aTmp) = 1 Then
$ErrSize = $aTmp[0]
Else
$ErrSize = 180 * 1024 * 1024
EndIf
_ReplaceCMD($Search, $Replace, $Casesense, $RegExp, $CRLF, $BackUp, $Path, $Mask, $Include, $Depth, $ReData, $ExcldAttrib, $CharSet, $ErrSize)
Exit
EndFunc   
Func _ReplaceCMD($Search, $Replace, $Casesense, $RegExp, $CRLF, $BackUp, $Path, $Mask, $Include, $Depth, $ReData, $ExcldAttrib, $CharSet, $ErrSize)
Local $BackUpPath, $file, $FileList, $i, $j, $LenPath, $TextReplace, $tmpData, $TrR, $TrH, $TrS, $aExcAttrib, $CharSetAuto
If StringRight($Path, 1) <> '\' Then $Path &= '\'
If $CharSet = -1 Then
$CharSetAuto = 1
Else
$CharSetAuto = 0
EndIf
If $CRLF Then _CRLF($CRLF, $Search, $Replace)
If $BackUp Then
$BackUpPath = _BackUp($BackUp) & StringRegExpReplace($Path, '^(.*\\)(.*?\\)$', '\2')
If @error Then Exit 4
EndIf
$FileList = _FO_FileSearch($Path, _FO_CorrectMask($Mask), $Include, $Depth, 1, 1, 1, $sLocale)
If @error Then Exit 5
$LenPath = StringLen($Path)
$ExcldAttrib = StringRegExpReplace($ExcldAttrib, '(?i)[^RASHNOT]', '') 
$aExcAttrib = StringSplit($ExcldAttrib, '')
For $i = 1 To $FileList[0]
If FileGetSize($FileList[$i]) > $ErrSize Then ContinueLoop
$FileAttrib = FileGetAttrib($FileList[$i])
For $j = 1 To $aExcAttrib[0]
If StringInStr($FileAttrib, $aExcAttrib[$j]) Then ContinueLoop 2
Next
If $CharSetAuto Then
$CharSet = FileGetEncoding($FileList[$i])
Else
If $CharSet <> 16 And $CharSet <> FileGetEncoding($FileList[$i]) Then ContinueLoop
EndIf
$file = FileOpen($FileList[$i], $CharSet)
If $file = -1 Then ContinueLoop
$TextReplace = FileRead($file)
FileClose($file)
If $RegExp Then
$TextReplace = StringRegExpReplace($TextReplace, $Search, $Replace)
Else
$TextReplace = StringReplace($TextReplace, $Search, $Replace, 0, $Casesense)
EndIf
If @extended Then 
If $BackUp Then FileCopy($FileList[$i], $BackUpPath & StringTrimLeft($FileList[$i], $LenPath), 8)
If $ReData = 1 Then $tmpData = FileGetTime($FileList[$i], 0, 1)
$TrR = StringInStr($FileAttrib, 'R')
$TrH = StringInStr($FileAttrib, 'H')
$TrS = StringInStr($FileAttrib, 'S')
If $TrR Then FileSetAttrib($FileList[$i], '-R')
If $TrH Then FileSetAttrib($FileList[$i], '-H')
If $TrS Then FileSetAttrib($FileList[$i], '-S')
$file = FileOpen($FileList[$i], $CharSet + 2)
FileWrite($file, $TextReplace)
FileClose($file)
If $TrR Then FileSetAttrib($FileList[$i], '+R')
If $TrH Then FileSetAttrib($FileList[$i], '+H')
If $TrS Then FileSetAttrib($FileList[$i], '+S')
If $ReData = 1 Then FileSetTime($FileList[$i], $tmpData)
EndIf
Next
EndFunc   
Func _About()
$wAbt = 270
$hAbt = 180
$GP = _ChildCoor($Gui, $wAbt, $hAbt)
$wAbtBt = 20
$wA = $wAbt / 2 - 80
$wB = $hAbt / 3 * 2
$iScroll_Pos = -$hAbt
$TrAbt1 = 0
$TrAbt2 = 0
$BkCol1 = 0xE1E3E7
$BkCol2 = 0
$GuiPos = WinGetPos($Gui)
GUISetState(@SW_DISABLE, $Gui)
$font = "Arial"
$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
GUISetBkColor($BkCol1)
If Not @Compiled Then GUISetIcon($AutoItExe, 1)
GUISetFont(-1, -1, -1, $font)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
$vk1 = GUICtrlCreateButton(ChrW('0x25BC'), 0, $hAbt - 20, $wAbtBt, 20)
GUICtrlSetOnEvent(-1, "_About_vk1")
GUICtrlCreateTab($wAbtBt, 0, $wAbt - $wAbtBt, $hAbt + 35, 0x0100 + 0x0004 + 0x0002)
$tabAbt0 = GUICtrlCreateTabItem("0")
GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt - $wAbtBt, $hAbt)
GUICtrlSetState(-1, 128)
GUICtrlSetBkColor(-1, $BkCol1)
GUICtrlCreateLabel($LngTitle, 0, 0, $wAbt, $hAbt / 3, 0x01 + 0x0200)
GUICtrlSetFont(-1, 15, 600, -1, $font)
GUICtrlSetColor(-1, 0x3a6a7e)
GUICtrlSetBkColor(-1, 0xF1F1EF)
GUICtrlCreateLabel("-", 1, $hAbt / 3, $wAbt - 2, 1, 0x10)
GUISetFont(9, 600, -1, $font)
GUICtrlCreateLabel($LngVer & ' 1.0  24.11.2012', $wA, $wB - 36, 210, 17)
GUICtrlCreateLabel($LngSite & ':', $wA, $wB - 17, 40, 17)
$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', $wA + 39, $wB - 17, 170, 17)
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 0x0000ff)
GUICtrlSetOnEvent(-1, "_About_url")
GUICtrlCreateLabel('WebMoney:', $wA, $wB + 2, 85, 17)
$WbMn = GUICtrlCreateLabel('R939163939152', $wA + 75, $wB + 2, 125, 17)
GUICtrlSetColor(-1, 0x3a6a7e)
GUICtrlSetTip(-1, $LngCopy)
GUICtrlSetCursor(-1, 0)
GUICtrlSetOnEvent(-1, "_About_WbMn")
GUICtrlCreateLabel('Copyright AZJIO © 2010-2012', $wA, $wB + 21, 210, 17)
$tabAbt1 = GUICtrlCreateTabItem("1")
GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt - $wAbtBt, $hAbt)
GUICtrlSetState(-1, 128)
GUICtrlSetBkColor(-1, 0x000000)
$StopPlay = GUICtrlCreateButton(ChrW('0x25A0'), 0, $hAbt - 41, $wAbtBt, 20)
GUICtrlSetState(-1, 32)
GUICtrlSetOnEvent(-1, "_About_StopPlay")
$nLAbt = GUICtrlCreateLabel($LngScrollAbt, $wAbtBt, $hAbt, $wAbt - $wAbtBt, 360, 0x1) 
GUICtrlSetFont(-1, 9, 400, 2, $font)
GUICtrlSetColor(-1, 0x99A1C0)
GUICtrlSetBkColor(-1, -2) 
GUICtrlCreateTabItem('')
GUISetState(@SW_SHOW, $Gui1)
EndFunc   
Func _Exit1()
AdlibUnRegister('_ScrollAbtText')
GUISetState(@SW_ENABLE, $Gui)
GUIDelete($Gui1)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Quit")
EndFunc   
Func _About_url()
ShellExecute('http://azjio.ucoz.ru')
EndFunc   
Func _About_WbMn()
ClipPut('R939163939152')
EndFunc   
Func _About_StopPlay()
If $TrAbt2 = 0 Then
AdlibUnRegister('_ScrollAbtText')
GUICtrlSetData($StopPlay, ChrW('0x25BA'))
$TrAbt2 = 1
Else
AdlibRegister('_ScrollAbtText', 40)
GUICtrlSetData($StopPlay, ChrW('0x25A0'))
$TrAbt2 = 0
EndIf
EndFunc   
Func _About_vk1()
If $TrAbt1 = 0 Then
GUICtrlSetState($tabAbt1, 16)
GUICtrlSetState($nLAbt, 16)
GUICtrlSetState($StopPlay, 16)
GUICtrlSetData($vk1, ChrW('0x25B2'))
GUISetBkColor($BkCol2)
If $TrAbt2 = 0 Then AdlibRegister('_ScrollAbtText', 40)
$TrAbt1 = 1
Else
GUICtrlSetState($tabAbt0, 16)
GUICtrlSetState($nLAbt, 32)
GUICtrlSetState($StopPlay, 32)
GUICtrlSetData($vk1, ChrW('0x25BC'))
GUISetBkColor($BkCol1)
AdlibUnRegister('_ScrollAbtText')
$TrAbt1 = 0
EndIf
EndFunc   
Func _ScrollAbtText()
$iScroll_Pos += 1
ControlMove($Gui1, "", $nLAbt, $wAbtBt, -$iScroll_Pos)
If $iScroll_Pos > 360 Then $iScroll_Pos = -$hAbt
EndFunc   
