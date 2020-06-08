#include <WindowsConstants.au3>
#include <Array.au3>
#include <EditConstants.au3>
#include <ListboxConstants.au3>
Opt('GUIResizeMode', 802)

HotKeySet('!{ESC}', '_Reset')

Dim $aStyle[8][3] = [ _
[7, 0, 0], _
['�����','$GuiStyles[0]', '$GuiStyles[1]'], _
['� ��������','BitOr($WS_BORDER, $WS_POPUP, $WS_SYSMENU)', '0'], _
['������������ ����','$WS_OVERLAPPEDWINDOW', '0'], _
['�������������� �� ���������� �������', '0', '$WS_EX_CONTROLPARENT'], _
['���������������� ��������', '$GUI_SS_DEFAULT_GUI', '$WS_EX_TOOLWINDOW'], _
['�����������','BitOr($GUI_SS_DEFAULT_GUI, $WS_DISABLED)', '0'], _
['��������� ���� �������', 'BitOr($WS_SYSMENU,$WS_CAPTION)', '$WS_EX_CONTEXTHELP']]

$Gui=GUICreate('��������� ����� ����', 500, 520)
$GuiStyles = GUIGetStyle($Gui)

; ������ ����������� ������
$LStyle=''
For $i = 1 to $aStyle[0][0]
	$LStyle&=$aStyle[$i][0]&'|'
Next
$LStyle=StringTrimRight($LStyle, 1)

$List=GUICtrlCreateList('', 5, 5, 240, 420, $LBS_NOINTEGRALHEIGHT)
GUICtrlSetData(-1, $LStyle, $aStyle[1][0])
$Combo=GUICtrlCreateCombo('', 5, 430, 240)
GUICtrlSetData(-1, $LStyle, $aStyle[1][0])
$Input_Styles=GUICtrlCreateEdit('����� ����� �����', 5, 460, 460, 50, $ES_AUTOVSCROLL)

GUISetState ()
While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $List
			$n=_Style(GUICtrlRead($List))
			GUICtrlSetData($Combo, $aStyle[$n][0])
		Case $Combo
			$n=_Style(GUICtrlRead($Combo))
			GUICtrlSetData($List, $aStyle[$n][0])
		Case -3
			 Exit
	EndSwitch
WEnd

Func _Style($Tmp)
	$n=_ArraySearch($aStyle, $Tmp)
	GUISetStyle(1, 1) 
	GUISetStyle(Execute($aStyle[$n][1]), Execute($aStyle[$n][2]))
	If $Tmp='�����' Then
		GUICtrlSetData($Input_Styles, 'GUICreate(''������'', 300, 220)')
	Else
		If $aStyle[$n][2] = '0' Then
			GUICtrlSetData($Input_Styles, 'GUICreate(''������'', 300, 220, -1, -1, '&$aStyle[$n][1]&')')
		Else
			GUICtrlSetData($Input_Styles, 'GUICreate(''������'', 300, 220, -1, -1, '&$aStyle[$n][1]&', '&$aStyle[$n][2]&')')
		EndIf
	EndIf
	If $Tmp='�����������' Then _Enable()
	If $Tmp='��������' Then
		WinMove($Gui, '', Default, Default, Default, 521)
		WinMove($Gui, '', Default, Default, Default, 520)
	EndIf
	Return $n
EndFunc

Func _Reset()
	GUISetStyle($GuiStyles[0], $GuiStyles[1])
EndFunc

Func _Enable()
	GUICtrlSetBkColor($List, 0xffd7d7)
	Sleep(2000)
	GUISetStyle($GuiStyles[0], $GuiStyles[1])
	GUICtrlSetBkColor($List, 0xffffff)
EndFunc