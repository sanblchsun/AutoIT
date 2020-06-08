#include <GUIConstants.au3> 
#include <WindowsConstants.au3> 
#include <GUITreeView.au3> 
; 

Global $sTxtColor = 0xFF8800, $sExtColor = 0xCC00FF, $aItems[4000], $aNames[4000], $sStartDir = @MyDocumentsDir 

Global $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, _ 
$TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES, $TVS_TRACKSELECT) 

$hMain_GUI = GUICreate("_TreeView_BuildList", 500, 430, -1, -1) 
$TreeView = GUICtrlCreateTreeView(24 + 32, 4, 400, 422, $iStyle, $WS_EX_STATICEDGE) 

$TreeView_SubItem = GUICtrlCreateTreeViewItem($sStartDir, $TreeView) 

_TreeView_BuildList($sStartDir, $TreeView_SubItem, 0) 
_TreeView_BuildList($sStartDir, $TreeView_SubItem, 1) 

ReDim $aItems[$aItems[0] + 1] 
ReDim $aNames[$aNames[0] + 1] 

GUISetState() 

While 1 
$nMsg = GUIGetMsg() 

Switch $nMsg 
Case $GUI_EVENT_CLOSE 
Exit 
EndSwitch 
WEnd 

Func _TreeView_BuildList($sDir, $TreeViewOfprograms, $iMode = 0) 
FileChangeDir($sDir) 
Local $hSearch = FileFindFirstFile("*.*") 

While 1 
$sNextFile = FileFindNextFile($hSearch) 
If @error Then ExitLoop 

$sExt = _FileGetExt($sDir & "\" & $sNextFile) 

If $aItems[0] > 3998 Then ExitLoop 

If $sExt <> "Folder" And $iMode = 1 And $sExt <> "ini" Then 
$aItems[0] += 1 
$aNames[0] += 1 

$aItems[$aItems[0]] = GUICtrlCreateTreeViewItem($sNextFile, $TreeViewOfprograms) 
$aNames[$aNames[0]] = $sNextFile 

GUICtrlSetColor($aItems[$aItems[0]], $sTxtColor) 
ElseIf $sExt = "Folder" And $iMode = 0 Then 
$iCurrent_TV_Item = GUICtrlCreateTreeViewItem($sNextFile, $TreeViewOfprograms) 

$aItems[0] += 1 
$aNames[0] += 1 

$aItems[$aItems[0]] = $iCurrent_TV_Item 
$aNames[$aNames[0]] = $sNextFile 

GUICtrlSetColor($aItems[$aItems[0]], $sExtColor) 

_TreeView_BuildList($sDir & "\" & $sNextFile, $iCurrent_TV_Item, 0) 
_TreeView_BuildList($sDir & "\" & $sNextFile, $iCurrent_TV_Item, 1) 
EndIf 
WEnd 

FileClose($hSearch) 
EndFunc 

Func _FileGetExt($sFile) 
If StringInStr(FileGetAttrib($sFile), "D") Then Return "Folder" 
Return StringUpper(StringTrimLeft($sFile, StringInStr($sFile, ".", 0, -1))) ;return only extension 
EndFunc 