Dim $MobList[6][4] = [ _   ;
['����' ,0x491812, 1, 6 ], _
['���',0x97BC93, 1, 6], _
['���',0xD0F732, 1, 1], _
['���',0xD0F732, 1, 2], _
['���',0xD0F732, 1, 4], _
['���',0x682D31, 2, 8]]


GUICreate('My Program', 250, 260)

$tmp=''
For $i = 0 to UBound($MobList)-1
    If $MobList[$i][3]<3 Then $tmp&=$MobList[$i][0]&' - '&$MobList[$i][1]&'|'
Next
$tmp=StringTrimRight($tmp, 1)

GUICtrlCreateCombo('', 10, 10, 150)
; GUICtrlSetData(-1, $tmp, StringRegExpReplace($tmp&'|', '^(.*?)\|.*', '\1'))
GuiCtrlSetData(-1, $tmp, StringLeft($tmp, StringInStr($tmp&'|', '|')-1)) ; �������� ������� �������

GUISetState ()
Do
Until GUIGetMsg() = -3