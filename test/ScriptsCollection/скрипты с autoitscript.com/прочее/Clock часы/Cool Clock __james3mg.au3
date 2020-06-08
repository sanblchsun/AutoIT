; james3mg
; http://www.autoitscript.com/forum/topic/110647-cool-clock
#include <GUIConstantsEx.au3>
Global $iGUIHeight=600
Global $hGUI=GUICreate("Scrolling Clock",280,$iGUIHeight)
GUICtrlSetDefColor(0xFFFFFF)
GUICtrlSetDefBkColor(0x77AADD)
Global $a_hSeconds[60]
Global $a_hMinutes[60]
Global $a_hHours[24]
Global $a_hWDay[7]
Global $a_hMDay[31]
Global $a_hMon[12]
Global $a_hYear[7]

$a_hWDay[0]=GUICtrlCreateButton("Sun",0,0*($iGUIHeight/3.5),40,$iGUIHeight/3.5)
$a_hWDay[1]=GUICtrlCreateButton("Mon",0,1*($iGUIHeight/3.5),40,$iGUIHeight/3.5)
$a_hWDay[2]=GUICtrlCreateButton("Tue",0,2*($iGUIHeight/3.5),40,$iGUIHeight/3.5)
$a_hWDay[3]=GUICtrlCreateButton("Wed",0,3*($iGUIHeight/3.5),40,$iGUIHeight/3.5)
$a_hWDay[4]=GUICtrlCreateButton("Thu",0,4*($iGUIHeight/3.5),40,$iGUIHeight/3.5)
$a_hWDay[5]=GUICtrlCreateButton("Fri",0,5*($iGUIHeight/3.5),40,$iGUIHeight/3.5)
$a_hWDay[6]=GUICtrlCreateButton("Sat",0,6*($iGUIHeight/3.5),40,$iGUIHeight/3.5)
For $i=0 To 23
    $a_hHours[$i]=GUICtrlCreateButton($i,40,$i*($iGUIHeight/12),40,$iGUIHeight/12)
Next
For $i=0 To 59
    $a_hMinutes[$i]=GUICtrlCreateButton($i,80,$i*($iGUIHeight/30),40,$iGUIHeight/30)
    $a_hSeconds[$i]=GUICtrlCreateButton($i,120,$i*($iGUIHeight/30),40,$iGUIHeight/30)
Next
For $i=0 To 30
    $a_hMDay[$i]=GUICtrlCreateButton($i+1,160,$i*($iGUIHeight/15),40,$iGUIHeight/15)
Next
$a_hMon[0]=GUICtrlCreateButton("Jan",200,0*($iGUIHeight/6),40,$iGUIHeight/6)
$a_hMon[1]=GUICtrlCreateButton("Feb",200,1*($iGUIHeight/6),40,$iGUIHeight/6)
$a_hMon[2]=GUICtrlCreateButton("Mar",200,2*($iGUIHeight/6),40,$iGUIHeight/6)
$a_hMon[3]=GUICtrlCreateButton("Apr",200,3*($iGUIHeight/6),40,$iGUIHeight/6)
$a_hMon[4]=GUICtrlCreateButton("May",200,4*($iGUIHeight/6),40,$iGUIHeight/6)
$a_hMon[5]=GUICtrlCreateButton("Jun",200,5*($iGUIHeight/6),40,$iGUIHeight/6)
$a_hMon[6]=GUICtrlCreateButton("Jul",200,6*($iGUIHeight/6),40,$iGUIHeight/6)
$a_hMon[7]=GUICtrlCreateButton("Aug",200,7*($iGUIHeight/6),40,$iGUIHeight/6)
$a_hMon[8]=GUICtrlCreateButton("Sep",200,8*($iGUIHeight/6),40,$iGUIHeight/6)
$a_hMon[9]=GUICtrlCreateButton("Oct",200,9*($iGUIHeight/6),40,$iGUIHeight/6)
$a_hMon[10]=GUICtrlCreateButton("Nov",200,10*($iGUIHeight/6),40,$iGUIHeight/6)
$a_hMon[11]=GUICtrlCreateButton("Dec",200,11*($iGUIHeight/6),40,$iGUIHeight/6)
For $i=-3 To 3
    $a_hYear[$i+3]=GUICtrlCreateButton(@Year+$i,240,($i+3)*($iGUIHeight/5),40,$iGUIHeight/5)
Next

Global $iWDayPos=0
Global $iHourPos=0
Global $iMinPos=0
Global $iSecPos=0
Global $iMDayPos=0
Global $iMonPos=0
Global $iYearPos=0

AdlibRegister("AdvanceClock",100)
GUICtrlCreateLabel("",0,$iGUIHeight/2,280,1)
GUICtrlSetBkColor(-1,0x009900)
GUICtrlSetState(-1,$GUI_FOCUS)
GUISetState()

Do
    $msg=GUIGetMsg()
    If $msg>0 Then
        GUICtrlSetState($msg,$GUI_DISABLE);send the clicked button below the label again
        GUICtrlSetState(-1,$GUI_FOCUS);get focus off the clicked button
        GUICtrlSetState($msg,$GUI_ENABLE)
    EndIf
Until $msg=-3

Func AdvanceClock()
    Local $iNextSecPos=($iGUIHeight/2)*-1
    $iNextSecPos-=Round((@MSEC/1000)*($iGUIHeight/30))
    If $iNextSecPos <> $iSecPos Then
        $iSecPos=$iNextSecPos
        Local $iSecStart=@Sec-30
        If $iSecStart<0 Then $iSecStart+=60
        For $i=$iSecStart To 59
            GUICtrlSetPos($a_hSeconds[$i],120,$iNextSecPos)
            $iNextSecPos+=$iGUIHeight/30
        Next
        For $i=0 To $iSecStart-1
            GUICtrlSetPos($a_hSeconds[$i],120,$iNextSecPos)
            $iNextSecPos+=$iGUIHeight/30
        Next
    EndIf

    Local $iNextMinPos=($iGUIHeight/2)*-1
    $iNextMinPos-=Round((@SEC/60)*($iGUIHeight/30))
    If $iNextMinPos <> $iMinPos Then
        $iMinPos=$iNextMinPos
        Local $iMinStart=@MIN-30
        If $iMinStart<0 Then $iMinStart+=60
        For $i=$iMinStart To 59
            GUICtrlSetPos($a_hMinutes[$i],80,$iNextMinPos)
            $iNextMinPos+=$iGUIHeight/30
        Next
        For $i=0 To $iMinStart-1
            GUICtrlSetPos($a_hMinutes[$i],80,$iNextMinPos)
            $iNextMinPos+=$iGUIHeight/30
        Next
    EndIf

    Local $iNextHourPos=($iGUIHeight/2)*-1
    $iNextHourPos-=Round((@MIN/60)*($iGUIHeight/12))
    If $iNextHourPos <> $iHourPos Then
        $iHourPos=$iNextHourPos
        Local $iHourStart=@Hour-12
        If $iHourStart<0 Then $iHourStart+=24
        For $i=$iHourStart To 23
            GUICtrlSetPos($a_hHours[$i],40,$iNextHourPos)
            $iNextHourPos+=$iGUIHeight/12
        Next
        For $i=0 To $iHourStart-1
            GUICtrlSetPos($a_hHours[$i],40,$iNextHourPos)
            $iNextHourPos+=$iGUIHeight/12
        Next
    EndIf

    Local $iNextMDayPos=($iGUIHeight/2)*-1
    $iNextMDayPos-=Round(((@HOUR*60+@MIN)/1440)*($iGUIHeight/15))
    If $iNextMDayPos <> $iMDayPos Then
        $iMDayPos = $iNextMDayPos
        Local $iMDayStart=@MDAY-15
        If $iMDayStart<1 Then $iMDayStart+=31
        For $i=$iMDayStart To 31
            GUICtrlSetPos($a_hMDay[$i-1],160,$iNextMDayPos)
            $iNextMDayPos+=$iGUIHeight/15
        Next
        For $i=1 To $iMDayStart-1
            GUICtrlSetPos($a_hMDay[$i-1],160,$iNextMDayPos)
            $iNextMDayPos+=$iGUIHeight/15
        Next
    EndIf

    Local $iNextWDayPos=($iGUIHeight/2)*-1
    $iNextWDayPos-=Round(((@HOUR*60+@MIN)/1440)*($iGUIHeight/3.5)-(.5*($iGUIHeight/3.5)))
    If $iNextWDayPos <> $iWDayPos Then
        $iWDayPos = $iNextWDayPos
        Local $iWDayStart=@WDAY-3
        If $iWDayStart<1 Then $iWDayStart+=7
        For $i=$iWDayStart To 7
            GUICtrlSetPos($a_hWDay[$i-1],0,$iNextWDayPos)
            $iNextWDayPos+=$iGUIHeight/3.5
        Next
        For $i=1 To $iWDayStart-1
            GUICtrlSetPos($a_hWDay[$i-1],0,$iNextWDayPos)
            $iNextWDayPos+=$iGUIHeight/3.5
        Next
    EndIf

    Local $iNextMonPos=($iGUIHeight/2)*-1
    $iNextMonPos-=Round(((@MDAY*24+@HOUR)/744)*($iGUIHeight/6))
    If $iNextMonPos <> $iMonPos Then
        $iMonPos = $iNextMonPos
        Local $iMonStart=@MON-6
        If $iMonStart<1 Then $iMonStart+=12
        For $i=$iMonStart To 12
            GUICtrlSetPos($a_hMon[$i-1],200,$iNextMonPos)
            $iNextMonPos+=$iGUIHeight/6
        Next
        For $i=1 To $iMonStart-1
            GUICtrlSetPos($a_hMon[$i-1],200,$iNextMonPos)
            $iNextMonPos+=$iGUIHeight/6
        Next
    EndIf

    Local $iNextYearPos=Round(((($iGUIHeight/5)*.5)*-1)-((Number(@YDAY)/366)*($iGUIHeight/5)))
    If $iNextYearPos <> $iYearPos Then
        $iYearPos=$iNextYearPos
        For $i=0 To 6
            GUICtrlSetData($a_hYear[$i],(@YEAR-3)+$i)
            GUICtrlSetPos($a_hYear[$i],240,$iNextYearPos)
            $iNextYearPos+=$iGUIHeight/5
        Next
    EndIf
EndFunc