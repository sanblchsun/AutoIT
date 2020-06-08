#AutoIt3Wrapper_au3check_parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

$Debug_LV = False
$help='������ ���������� ����������� ��������� ����������/�������� ������� ��������� ������� ������������ � ������ ����� ����'
$help2='��� ������� ListView ����� ��������� ��� ���������, ������� ������������ � ������ "Case $hWndListView". ������ ���� �� ������� UDFs _GUICtrlListView_ClickItem'

Global $hListView

GUICreate("�������� �� ��������� � ListView, ������� F2", 720, 225)
$hLabel = GUICtrlCreateLabel($help, 5, 95, 195, 125)
$hListView = GUICtrlCreateListView("���1  |���2|���3  ", 2, 2, 199, 88, $LVS_EDITLABELS)
$item1 = GUICtrlCreateListViewItem("����� 1|1111|1 � ��� 3", $hListView)
$item2 = GUICtrlCreateListViewItem("����� 2|2222|2 � ��� 3", $hListView)
$item3 = GUICtrlCreateListViewItem("����� 3|3333|3 � ��� 3", $hListView)

$hEdit = GUICtrlCreateEdit($help& @CRLF& @CRLF&$help2, 205, 2, 510, 218, $ES_MULTILINE)
GUISetState()

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")


Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
GUIDelete()

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    #forceref $hWnd, $iMsg, $iwParam
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo
    $hWndListView = $hListView
    If Not IsHWnd($hListView) Then $hWndListView = GUICtrlGetHandle($hListView)

    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $hWndListView
            Switch $iCode
				Case $LVN_KEYDOWN ; ������� �������
					Local $tInfo = DllStructCreate($tagNMLVKEYDOWN, $ilParam)
					GUICtrlSetData($hEdit, '������ ������� �: '&DllStructGetData($tInfo, "VKey"))
					Switch DllStructGetData($tInfo, "VKey")
						Case 113; F2
							$Tmp = _GUICtrlListView_GetSelectedIndices($hListView, True)
							If $Tmp[0]>0 Then
								_GUICtrlListView_EditLabel($hListView, $Tmp[1])
								GUICtrlSetData($hEdit, '������ ������� F2'&@CRLF&'�������������� ������ '&$Tmp[1])
								$tInfo = DllStructCreate($tagNMLVDISPINFO, $ilParam)
								Return False
							Else
								GUICtrlSetData($hEdit, '����� �������� �����')
							EndIf
					EndSwitch
				Case $LVN_ENDLABELEDITA, $LVN_ENDLABELEDITW ; The end of label editing for an item
                    $tInfo = DllStructCreate($tagNMLVDISPINFO, $ilParam)
                    Local $tBuffer = DllStructCreate("char Text[" & DllStructGetData($tInfo, "TextMax") & "]", DllStructGetData($tInfo, "Text"))
					If StringLen(DllStructGetData($tBuffer, "Text")) Then Return True
                Case $NM_CLICK ; Sent by a list-view control when the user clicks an item with the left mouse button
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
                    GUICtrlSetData($hEdit, "$NM_CLICK" & @TAB &"��������� ���� ����� ������� ����" & @CRLF & "����������:" & @TAB & $hWndFrom & @CRLF & _
                            "�������������:" & @TAB & $iIDFrom& @TAB& "(���������� ����� �������� � ���)" & @CRLF & _
                            "��� �����:" & @TAB & $iCode& @TAB& "(���������� ������ ��� �����, ������� ��� ��������� ���� ����)" & @CRLF & _
                            "� ������:" & @TAB & DllStructGetData($tInfo, "Index")& @TAB& "(����� ������, ������ �� 0, -1 ������ ������������)" & @CRLF & _
                            "� �������:" & @TAB & DllStructGetData($tInfo, "SubItem")& @TAB& "(������ �� 0)" & @CRLF & _
                            "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
                            "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
                            "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
                            "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
                            "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
                            "-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @CRLF & _
                            "�����. �������:" & @TAB & DllStructGetData($tInfo, "KeyFlags") & @TAB& "(0 - ������; 1 - Alt; 2 - Ctrl; 4 - Shift; 5,6,7 - ����������)")
                    ; No return value
                Case $NM_DBLCLK ; Sent by a list-view control when the user double-clicks an item with the left mouse button
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
                    GUICtrlSetData($hEdit, "$NM_DBLCLK" & @TAB &"������� ���� ����� ������� ����" & @CRLF & "����������:" & @TAB & $hWndFrom & @CRLF & _
                            "�������������:" & @TAB & $iIDFrom& @TAB& "(���������� ����� �������� � ���)" & @CRLF & _
                            "��� �����:" & @TAB & $iCode& @TAB& "(���������� ������ ��� �����, ������� ��� ��������� ���� ����)" & @CRLF & _
                            "� ������:" & @TAB & DllStructGetData($tInfo, "Index")& @TAB& "(����� ������, ������ �� 0, -1 ������ ������������)" & @CRLF & _
                            "� �������:" & @TAB & DllStructGetData($tInfo, "SubItem")& @TAB& "(������ �� 0)" & @CRLF & _
                            "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
                            "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
                            "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
                            "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
                            "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
                            "-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @CRLF & _
                            "�����. �������:" & @TAB & DllStructGetData($tInfo, "KeyFlags") & @TAB& "(0 - ������; 1 - Alt; 2 - Ctrl; 4 - Shift; 5,6,7 - ����������)")
                    ; No return value
                Case $NM_RCLICK ; Sent by a list-view control when the user clicks an item with the right mouse button
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
                    GUICtrlSetData($hEdit, "$NM_RCLICK" & @TAB &"��������� ���� ������ ������� ����" & @CRLF & "����������:" & @TAB & $hWndFrom & @CRLF & _
                            "�������������:" & @TAB & $iIDFrom& @TAB& "(���������� ����� �������� � ���)" & @CRLF & _
                            "��� �����:" & @TAB & $iCode& @TAB& "(���������� ������ ��� �����, ������� ��� ��������� ���� ����)" & @CRLF & _
                            "� ������:" & @TAB & DllStructGetData($tInfo, "Index")& @TAB& "(����� ������, ������ �� 0, -1 ������ ������������)" & @CRLF & _
                            "� �������:" & @TAB & DllStructGetData($tInfo, "SubItem")& @TAB& "(������ �� 0)" & @CRLF & _
                            "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
                            "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
                            "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
                            "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
                            "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
                            "-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @CRLF & _
                            "�����. �������:" & @TAB & DllStructGetData($tInfo, "KeyFlags") & @TAB& "(0 - ������; 1 - Alt; 2 - Ctrl; 4 - Shift; 5,6,7 - ����������)")
                    ;Return 1 ; not to allow the default processing
                    Return 0 ; allow the default processing
                Case $NM_RDBLCLK ; Sent by a list-view control when the user double-clicks an item with the right mouse button
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
                    GUICtrlSetData($hEdit, "$NM_RDBLCLK" & @TAB &"������� ���� ������ ������� ����" & @CRLF & "����������:" & @TAB & $hWndFrom & @CRLF & _
                            "�������������:" & @TAB & $iIDFrom& @TAB& "(���������� ����� �������� � ���)" & @CRLF & _
                            "��� �����:" & @TAB & $iCode& @TAB& "(���������� ������ ��� �����, ������� ��� ��������� ���� ����)" & @CRLF & _
                            "� ������:" & @TAB & DllStructGetData($tInfo, "Index")& @TAB& "(����� ������, ������ �� 0, -1 ������ ������������)" & @CRLF & _
                            "� �������:" & @TAB & DllStructGetData($tInfo, "SubItem")& @TAB& "(������ �� 0)" & @CRLF & _
                            "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
                            "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
                            "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
                            "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
                            "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
                            "-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @CRLF & _
                            "�����. �������:" & @TAB & DllStructGetData($tInfo, "KeyFlags") & @TAB& "(0 - ������; 1 - Alt; 2 - Ctrl; 4 - Shift; 5,6,7 - ����������)")
                    ; No return value
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY