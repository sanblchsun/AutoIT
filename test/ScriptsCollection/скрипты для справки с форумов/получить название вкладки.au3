$GUI = GUICreate("ControlTab Demo") 

GUICtrlCreateTab(10, 20) 
$Tab_1 = GUICtrlCreateTabItem("Tab 1") 
$Tab_2 = GUICtrlCreateTabItem("Tab 2") 
$Tab_3 = GUICtrlCreateTabItem("More Tab") 

GUISetState() 

For $i = 0 To ControlTab($GUI, "", "GetTabsCount")-1 
MsgBox(0, "", "Zero-Based tab number [" & $i & "]: " & @LF & ControlTab($GUI, "", "GetItemText", $i)) 
ControlTab($GUI, "", "TabRight") 
Next 

Func ControlTab($hWnd, $sText, $iCommand, $iParam1="", $iParam2="", $iParam3="") 
Local Const $TCM_FIRST = 0x1300 
Local $hTab = ControlGetHandle($hWnd, $sText, "SysTabControl321") 

Switch $iCommand 
Case "GetItemState", "GetItemText", "GetItemImage" 
Local Const $TagTCITEM = "int Mask;int State;int StateMask;ptr Text;int TextMax;int Image;int Param" 
Local Const $TCIF_ALLDATA = 0x0000001B 
Local Const $TCM_GETITEM = $TCM_FIRST + 5 

Local $tBuffer = DllStructCreate("char Text[4096]") 
Local $pBuffer = DllStructGetPtr($tBuffer) 
Local $tItem = DllStructCreate($tagTCITEM) 
Local $pItem = DllStructGetPtr($tItem) 

DllStructSetData($tItem, "Mask", $TCIF_ALLDATA) 
DllStructSetData($tItem, "TextMax", 4096) 
DllStructSetData($tItem, "Text", $pBuffer) 

If $iParam1 = -1 Then $iParam1 = ControlTab($hWnd, $sText, "CurrentTab") 
DllCall("user32.dll", "long", "SendMessage", "hwnd", $hTab, "int", $TCM_GETITEM, "int", $iParam1, "int", $pItem) 

If @error Then Return SetError(1, 0, "") 
If $iCommand = "GetItemState" Then Return DllStructGetData($tItem, "State") 
If $iCommand = "GetItemText" Then Return DllStructGetData($tBuffer, "Text") 
If $iCommand = "GetItemImage" Then Return DllStructGetData($tItem, "Image") 
Case "CurrentTab", "TabRight", "TabLeft" 
Local $iRet = ControlCommand($hWnd, $sText, "SysTabControl321", $iCommand, "") 
If @error Then Return SetError(1, 0, -1) 
Return $iRet - 1 
Case "GetTabsCount" 
Local Const $TCM_GETITEMCOUNT = $TCM_FIRST + 4 
Local $iRet = DllCall("user32.dll", "long", "SendMessage", "hwnd", $hTab, "int", $TCM_GETITEMCOUNT, "int", 0, "int", 0) 
If @error Then Return SetError(1, 0, -1) 
Return $iRet[0] 
Case "FindTab" 
If Not IsNumber($iParam2) Or $iParam2 < 0 Then $iParam2 = 0 
Local $sTabText 

For $i = $iParam2 To ControlTab($hWnd, $sText, "GetTabsCount") 
$sTabText = ControlTab($hWnd, $sText, "GetItemText", $i) 
If $iParam3 = True And StringInStr($sTabText, $iParam1) Then Return $i 
If $sTabText = $iParam1 Then Return $i 
Next 
Return -1 
Case Else 
Return SetError(2, 0, "") 
EndSwitch 
EndFunc 