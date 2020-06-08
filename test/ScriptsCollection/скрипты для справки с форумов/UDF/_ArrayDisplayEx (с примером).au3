#include <Array.au3>

Dim $a[10] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
Dim $b[1] = ["Is Test"]
Dim $c[1][2] = [["This!", $b]]

$a[7] = $c
$a[8] = DllStructCreate('int[2];')
$a[9] = ObjCreate("shell.application")
_ArrayDisplayEx($a, "Value of the array: $a")

Func _ArrayDisplayEx(Const ByRef $avArray, $sTitle = "Array: ListView Display", $iItemLimit = -1, $iTranspose = 0, $sSeparator = "", $sReplace = "|", $sHeader = "")
    If Not IsArray($avArray) Then Return SetError(1, 0, 0)
    ; Dimension checking
    Local $iDimension = UBound($avArray, 0), $iUBound = UBound($avArray, 1) - 1, $iSubMax = UBound($avArray, 2) - 1
    If $iDimension > 2 Then Return SetError(2, 0, 0)

    ; Separator handling
;~     If $sSeparator = "" Then $sSeparator = Chr(1)
    If $sSeparator = "" Then $sSeparator = Chr(124)

    ;  Check the separator to make sure it's not used literally in the array
    If _ArraySearch($avArray, $sSeparator, 0, 0, 0, 1) <> -1 Then
        For $x = 1 To 255
            If $x >= 32 And $x <= 127 Then ContinueLoop
            Local $sFind = _ArraySearch($avArray, Chr($x), 0, 0, 0, 1)
            If $sFind = -1 Then
                $sSeparator = Chr($x)
                ExitLoop
            EndIf
        Next
    EndIf

    ; Declare variables
    Local $vTmp, $iBuffer = 64
    Local $iColLimit = 250
    Local $iOnEventMode = Opt("GUIOnEventMode", 0), $sDataSeparatorChar = Opt("GUIDataSeparatorChar", $sSeparator)

    ; Swap dimensions if transposing
    If $iSubMax < 0 Then $iSubMax = 0
    If $iTranspose Then
        $vTmp = $iUBound
        $iUBound = $iSubMax
        $iSubMax = $vTmp
    EndIf

    ; Set limits for dimensions
    If $iSubMax > $iColLimit Then $iSubMax = $iColLimit
    If $iItemLimit < 1 Then $iItemLimit = $iUBound
    If $iUBound > $iItemLimit Then $iUBound = $iItemLimit

    ; Set header up
    If $sHeader = "" Then
        $sHeader = "Row  "  ; blanks added to adjust column size for big number of rows
        For $i = 0 To $iSubMax
            $sHeader &= $sSeparator & "Col " & $i
        Next
    EndIf

    ; Convert array into text for listview
    Local $avArrayText[$iUBound + 1]
    For $i = 0 To $iUBound
        $avArrayText[$i] = "[" & $i & "]"
        For $j = 0 To $iSubMax
            ; Get current item
            ; Visibility of an array or object in the list
            ; Editing: Garrett
            If $iDimension = 1 Then
                If $iTranspose Then                
                    $vTmp = $avArray[$j]                    
                Else                
                    $vTmp = $avArray[$i]                          
                EndIf
            Else
                If $iTranspose Then
                    $vTmp = $avArray[$j][$i]
                Else
                    $vTmp = $avArray[$i][$j]                          
                EndIf
            EndIf

            If IsArray($vTmp) Then
                $vTmp = '#Array(' & UBound($vTmp, 0) & '-D)'
            ElseIf IsObj($vTmp) Then
                $vTmp = '#Object(' & ObjName($vTmp) & ')'
            ElseIf IsDllStruct($vTmp) Then
                $vTmp = '#DllStruct(' & DllStructGetSize($vTmp) & ')'
            EndIf

            ; Add to text array
            $vTmp = StringReplace($vTmp, $sSeparator, $sReplace, 0, 1)
            $avArrayText[$i] &= $sSeparator & $vTmp

            ; Set max buffer size
            $vTmp = StringLen($vTmp)
            If $vTmp > $iBuffer Then $iBuffer = $vTmp
        Next
    Next

    ; GUI Constants
    Local Const $_ARRAYCONSTANT_GUI_DOCKBORDERS = 0x66
    Local Const $_ARRAYCONSTANT_GUI_DOCKBOTTOM = 0x40
    Local Const $_ARRAYCONSTANT_GUI_DOCKHEIGHT = 0x0200
    Local Const $_ARRAYCONSTANT_GUI_DOCKLEFT = 0x2
    Local Const $_ARRAYCONSTANT_GUI_DOCKRIGHT = 0x4
    Local Const $_ARRAYCONSTANT_GUI_DOCKSIZE = 768
    Local Const $_ARRAYCONSTANT_GUI_DOCKHCENTER = 8
    Local Const $_ARRAYCONSTANT_GUI_EVENT_CLOSE = -3
    Local Const $_ARRAYCONSTANT_LVIF_PARAM = 0x4
    Local Const $_ARRAYCONSTANT_LVIF_TEXT = 0x1
    Local Const $_ARRAYCONSTANT_LVM_GETCOLUMNWIDTH = (0x1000 + 29)
    Local Const $_ARRAYCONSTANT_LVM_GETITEMCOUNT = (0x1000 + 4)
    Local Const $_ARRAYCONSTANT_LVM_GETITEMSTATE = (0x1000 + 44)
    Local Const $_ARRAYCONSTANT_LVM_INSERTITEMW = (0x1000 + 77)
    Local Const $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE = (0x1000 + 54)
    Local Const $_ARRAYCONSTANT_LVM_SETITEMW = (0x1000 + 76)
    Local Const $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT = 0x20
    Local Const $_ARRAYCONSTANT_LVS_EX_GRIDLINES = 0x1
    Local Const $_ARRAYCONSTANT_LVS_SHOWSELALWAYS = 0x8
    Local Const $_ARRAYCONSTANT_WS_EX_CLIENTEDGE = 0x0200
    Local Const $_ARRAYCONSTANT_WS_MAXIMIZEBOX = 0x00010000
    Local Const $_ARRAYCONSTANT_WS_MINIMIZEBOX = 0x00020000
    Local Const $_ARRAYCONSTANT_WS_SIZEBOX = 0x00040000
    Local Const $_ARRAYCONSTANT_tagLVITEM = "int Mask;int Item;int SubItem;int State;int StateMask;ptr Text;int TextMax;int Image;int Param;int Indent;int GroupID;int Columns;ptr pColumns"

    Local $iAddMask = BitOR($_ARRAYCONSTANT_LVIF_TEXT, $_ARRAYCONSTANT_LVIF_PARAM)
    Local $tBuffer = DllStructCreate("wchar Text[" & $iBuffer & "]"), $pBuffer = DllStructGetPtr($tBuffer)
    Local $tItem = DllStructCreate($_ARRAYCONSTANT_tagLVITEM), $pItem = DllStructGetPtr($tItem)
    DllStructSetData($tItem, "Param", 0)
    DllStructSetData($tItem, "Text", $pBuffer)
    DllStructSetData($tItem, "TextMax", $iBuffer)

    ; Set interface up
    Local $iWidth = 640, $iHeight = 480
    Local $hGUI = GUICreate($sTitle, $iWidth, $iHeight, Default, Default, BitOR($_ARRAYCONSTANT_WS_SIZEBOX, $_ARRAYCONSTANT_WS_MINIMIZEBOX, $_ARRAYCONSTANT_WS_MAXIMIZEBOX))
    Local $aiGUISize = WinGetClientSize($hGUI)
    Local $hListView = GUICtrlCreateListView($sHeader, 0, 0, $aiGUISize[0], $aiGUISize[1] - 26, $_ARRAYCONSTANT_LVS_SHOWSELALWAYS)
    Local $hCopy = GUICtrlCreateButton("Copy Selected", ($aiGUISize[0] / 2) - 120, $aiGUISize[1] - 23, 100, 20)
    Local $hDisplay = GUICtrlCreateButton("Display SubArray", ($aiGUISize[0] / 2) + 20, $aiGUISize[1] - 23, 100, 20)
    GUICtrlSetResizing($hListView, $_ARRAYCONSTANT_GUI_DOCKBORDERS)
    GUICtrlSetResizing($hCopy, $_ARRAYCONSTANT_GUI_DOCKHCENTER + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKSIZE)
    GUICtrlSetResizing($hDisplay, $_ARRAYCONSTANT_GUI_DOCKHCENTER + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKSIZE)
    GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_GRIDLINES, $_ARRAYCONSTANT_LVS_EX_GRIDLINES)
    GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT)
    GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE)

    ; Fill listview
    Local $aItem
    For $i = 0 To $iUBound
        If GUICtrlCreateListViewItem($avArrayText[$i], $hListView) = 0 Then
            ; use GUICtrlSendMsg() to overcome AutoIt limitation
            $aItem = StringSplit($avArrayText[$i], $sSeparator)
            DllStructSetData($tBuffer, "Text", $aItem[1])

            ; Add listview item
            DllStructSetData($tItem, "Item", $i)
            DllStructSetData($tItem, "SubItem", 0)
            DllStructSetData($tItem, "Mask", $iAddMask)
            GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_INSERTITEMW, 0, $pItem)

            ; Set listview subitem text
            DllStructSetData($tItem, "Mask", $_ARRAYCONSTANT_LVIF_TEXT)
            For $j = 2 To $aItem[0]
                DllStructSetData($tBuffer, "Text", $aItem[$j])
                DllStructSetData($tItem, "SubItem", $j - 1)
                GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_SETITEMW, 0, $pItem)
            Next
        EndIf
    Next

    ; adjust window width
    $iWidth = 0
    For $i = 0 To $iSubMax + 1
        $iWidth += GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_GETCOLUMNWIDTH, $i, 0)
    Next
    If $iWidth < 250 Then $iWidth = 230
    $iWidth += 20

    If $iWidth > @DesktopWidth Then $iWidth = @DesktopWidth - 100

    WinMove($hGUI, "", (@DesktopWidth - $iWidth)/2, Default, $iWidth)

    ; Show dialog
    GUISetState(@SW_SHOW, $hGUI)

    While 1
        Switch GUIGetMsg()
            Case $_ARRAYCONSTANT_GUI_EVENT_CLOSE
                ExitLoop
            Case $hCopy
                Local $sClip = ""

                ; Get selected indices [ _GUICtrlListView_GetSelectedIndices($hListView, True) ]
                Local $aiCurItems[1] = [0]
               
                For $i = 0 To GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_GETITEMCOUNT, 0, 0)
                    If GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_GETITEMSTATE, $i, 0x2) Then
                        $aiCurItems[0] += 1
                        ReDim $aiCurItems[$aiCurItems[0] + 1]
                        $aiCurItems[$aiCurItems[0]] = $i
                    EndIf
                Next

                ; Generate clipboard text
                If Not $aiCurItems[0] Then
                    For $sItem In $avArrayText
                        $sClip &= $sItem & @CRLF
                    Next
                Else
                    For $i = 1 To UBound($aiCurItems) - 1
                        $sClip &= $avArrayText[$aiCurItems[$i]] & @CRLF
                    Next
                EndIf
               
                ClipPut($sClip)
            Case $hDisplay
                Local $iSelItem = -1
               
                For $i = 0 To GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_GETITEMCOUNT, 0, 0)
                    If GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_GETITEMSTATE, $i, 0x2) Then
                        $iSelItem = $i
                        ExitLoop
                    EndIf
                Next
               
                If $iSelItem <> -1 Then
                    GUISetState(@SW_DISABLE, $hGUI)
                   
                    If $iDimension = 1 Then
                        If IsArray($avArray[$iSelItem]) Then
                            _ArrayDisplayEx($avArray[$iSelItem], "SubArray[" & $iSelItem & "]")
                        EndIf
                    Else
                        For $j = 0 To $iSubMax
                            If IsArray($avArray[$iSelItem][$j]) Then
                                _ArrayDisplayEx($avArray[$iSelItem][$j], "SubArray[" & $iSelItem & "][" & $j & "]")
                            EndIf
                        Next
                    EndIf
                   
                    GUISetState(@SW_ENABLE, $hGUI)
                    WinActivate($hGUI)
                EndIf
        EndSwitch
    WEnd
   
    GUIDelete($hGUI)

    Opt("GUIOnEventMode", $iOnEventMode)
    Opt("GUIDataSeparatorChar", $sDataSeparatorChar)

    Return 1
EndFunc