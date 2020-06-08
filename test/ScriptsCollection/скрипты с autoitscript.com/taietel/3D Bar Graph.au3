#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <Array.au3>

Global $arNames[12]
Global $arValues[12]
Example1()

Func Example1()
    Local $gui = GUICreate("Example 1: 3D Bar Graph", 550, 550)
    GUISetBkColor(0xffffff)
    $arNames=StringSplit("January|February|March|April|May|June|July|August|September|October|November|December","|",2)
    For $i=0 To 11
        $arValues[$i]=Random(0,200,1)
    Next
    _CreateBarChart("3D Bar Chart","Example 1",-1,-1,500,500)
    GUISetState()
    While 1
        Sleep(10)
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                GUIDelete($gui)
                Example2()
        EndSwitch
    WEnd
EndFunc

Func Example2()
    Local $gui = GUICreate("Example 2: 3D Bar Graph", 450, 350)
    GUISetBkColor(0xffffff)
    For $i=0 To 11
        $arNames[$i]=$i+1
    Next
    For $i=0 To 11
        $arValues[$i]=Random(0,200,1)
    Next
    _CreateBarChart("3D Bar Chart","Example 2",20,20,400,300)
    GUISetState()
    While 1
    Sleep(10)
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                GUIDelete($gui)
                Example3()
                ;Exit
        EndSwitch
    WEnd
EndFunc

Func Example3()
    Local $gui = GUICreate("Example 3: 3D Bar Graph", 850, 400)
    GUISetBkColor(0xffffff)
    For $i=0 To 11
        $arNames[$i]=$i+1
    Next
    For $i=0 To 11
        $arValues[$i]=Random(0,200,1)
    Next
    _CreateBarChart("3D Bar Chart","Example 3 - without legend",-1,-1,400,300)
    $arNames=StringSplit("January|February|March|April|May|June|July|August|September|October|November|December","|",2)
    _CreateBarChart("3D Bar Chart","Example 3 - with legend",430,-1,400,350)
    GUISetState()
    While 1
    Sleep(10)
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                GUIDelete($gui)
                ;Example3()
                Exit
        EndSwitch
    WEnd
EndFunc


; #FUNCTION# ====================================================================================================
; Name...........:  _CreateBarChart
; Description....:  Create 3D bar graph with native AutoIt functions
; Syntax.........:  _CreateBarChart($sTitle1="",$sTitle2="",$iX=20,$iY=20,$iW=400,$iH=400)
; Parameters.....:  $sTitle1 - Title of the graph, [Optional]
;                   $sTitle2 - Subtitle of the graph, [Optional]
;                   $iX - left margin, [Optional]
;                   $iY - top margin, [Optional]
;                   $iW - width of the graph, [Optional]
;                   $iH - height of the graph, [Optional]
;
; Return values..:  none
;
; Author.........:  Mihai Iancu (taietel at yahoo dot com)
; Remarks........:  $array = ["name",value]
;                    - one with numbers/names (try to uncoment/coment them)
;                    - one with values
; ===============================================================================================================
Func _CreateBarChart($sTitle1="",$sTitle2="",$iX=20,$iY=20,$iW=400,$iH=400)
    Local $max=_ArrayMax($arValues,1);compare numerically
    ;Local $values = UBound($arValues)
    Local $arColours[UBound($arNames)]
    Local $color
    For $i=0 To UBound($arValues)-1
        $color = (Random(100, 255, 1) * 0x10000) + (Random(100, 255, 1) * 0x100) + Random(100, 255, 1)
        $arColours[$i]=$color
    Next
    ;set default values for the frame
    If $iX=-1 Then $iX=20
    If $iY=-1 Then $iY=20
    If $iW=-1 Then $iW=400
    If $iH=-1 Then $iH=400
    ;create frame for the chart
    $grp = GUICtrlCreateGroup("", $iX, $iY, $iW, $iH)
    ;title
    GUICtrlCreateLabel($sTitle1,$iX+15, $iY+10,$iW-30,-1,$SS_CENTER)
    GUICtrlSetColor(-1,0x002244)
    GUICtrlSetFont(-1, 9, 800, 0, "Arial")
    GUICtrlSetBkColor(-1,$GUI_BKCOLOR_TRANSPARENT)
    GUICtrlCreateLabel($sTitle2,$iX+15, $iY+25,$iW-30,-1,$SS_CENTER)
    GUICtrlSetColor(-1,0x002244)
    GUICtrlSetFont(-1, 8, 800, 0, "Arial")
    GUICtrlSetBkColor(-1,$GUI_BKCOLOR_TRANSPARENT)
    Local $Canvas
    If IsString($arNames[1]) Then
        $Canvas = _CreateBarCanvas($iX+15, $iY+15, $iW-110, $iH-60)
        GUICtrlCreateGroup("Legend", $Canvas[0]+$Canvas[2]+10, $Canvas[1]-5, ($iW-$Canvas[2])/2-10, $Canvas[3]+$Canvas[4]+5)
        For $i=0 To UBound($arNames)-1
            GUICtrlCreateLabel($arNames[$i],$Canvas[0]+$Canvas[2]+20, $Canvas[1]+10+(($Canvas[3]+$Canvas[4]-15)/UBound($arNames))*$i,($iW-$Canvas[2])/2-30,13,$SS_CENTER)
            GUICtrlSetColor(-1,$arColours[$i]-0x444444)
            GUICtrlSetFont(-1, 8, 800, 0, "Arial")
            GUICtrlSetBkColor(-1,$arColours[$i])
        Next
        GUICtrlCreateGroup("", -99, -99, 1, 1)
    Else
        $Canvas = _CreateBarCanvas($iX+15, $iY+15, $iW-50, $iH-60)
        For $i=0 To UBound($arNames)-1
            GUICtrlCreateLabel($arNames[$i],$iX+52+(($Canvas[2]/UBound($arNames)))*$i+5, $iY+$iH-30)
            GUICtrlSetColor(-1,0x990000)
            GUICtrlSetFont(-1, 8, 800, 0, "Arial")
            GUICtrlSetBkColor(-1,$GUI_BKCOLOR_TRANSPARENT)
        Next
    EndIf
    ;draw the bars
    GUICtrlCreateGraphic($Canvas[0]-0.5*$Canvas[4], $Canvas[1]+0.5*$Canvas[4], $Canvas[2], $Canvas[3],0)
    For $i=0 To UBound($arValues)-1
        For $j=$Canvas[4]/2.5 To 0 Step -0.5
            GUICtrlSetGraphic(-1, $GUI_GR_COLOR, $arColours[$i]-0x333333, $arColours[$i])
            GUICtrlSetGraphic(-1, $GUI_GR_RECT, 5+($Canvas[2]/UBound($arValues))*$i+$j, -2+$Canvas[3]-$j, 0.5*($Canvas[2]/UBound($arValues)), -($Canvas[3]/_RoundUp($max))*$arValues[$i])
        Next
    Next
    GUICtrlSetGraphic(-1,$GUI_GR_REFRESH)
    For $i=0 To UBound($arValues)-1
        ;values from the top of the bars
        GUICtrlCreateLabel($arValues[$i],$Canvas[0]+($Canvas[2]/UBound($arValues))*$i, $iH-$Canvas[1]+$Canvas[4]-10-(($Canvas[3]/_RoundUp($max))*$arValues[$i]))
        GUICtrlSetColor(-1,0x002244)
        GUICtrlSetFont(-1, 7, 800, 0, "Arial")
        GUICtrlSetBkColor(-1,$GUI_BKCOLOR_TRANSPARENT)
    Next
    ;Y Axis
    For $i=0 To $Canvas[3] Step $Canvas[3]/5
        GUICtrlCreateLabel(($i/$Canvas[3])*_RoundUp($max),$Canvas[0]-65,$Canvas[1]+$Canvas[3]+$Canvas[4]-$i,30,-1,$SS_RIGHT)
        GUICtrlSetColor(-1,0x990000)
        GUICtrlSetFont(-1, 8, 800, 0, "Arial")
        GUICtrlSetBkColor(-1,$GUI_BKCOLOR_TRANSPARENT)
    Next
    GUICtrlCreateGroup("", -99, -99, 1, 1)
EndFunc
#Region INTERNAL USE ONLY
Func _RoundUp($m)
    Local $rv = Round(Ceiling($m/10)*10,-1)
    ;ConsoleWrite($rv&@CRLF)
    Return $rv
EndFunc

Func _CreateBarCanvas($iX=0, $iY=0, $iW=400, $iH=400, $iDepthCanvas=30, $BgColor=0xEEEEEE)
    Local $iXCanvas=$iX+$iDepthCanvas
    Local $iYCanvas=$iY+10+2*$iDepthCanvas
    Local $iWCanvas=$iW-2*$iDepthCanvas
    Local $iHCanvas=$iH-2*$iDepthCanvas
    Local $BgColor2 = $BgColor - 0x333333
    ;create bg for the bars
    For $i=0 To $iDepthCanvas; Step 0.5
        GUICtrlCreateGraphic($iXCanvas+$i, $iYCanvas-$i, $iWCanvas, $iHCanvas, 0)
        GUICtrlSetBkColor(-1, $BgColor)
        GUICtrlSetColor(-1, $BgColor2)
    Next
    GUICtrlSetGraphic(-1, $GUI_GR_MOVE, 0, $iHCanvas)
    GUICtrlSetGraphic(-1, $GUI_GR_COLOR, $BgColor)
    GUICtrlSetGraphic(-1, $GUI_GR_LINE, -$iDepthCanvas-1, $iHCanvas+$iDepthCanvas+1)
    ;horizontal grid
    For $i=0 To $iHCanvas Step $iHCanvas/5
        GUICtrlSetGraphic(-1, $GUI_GR_MOVE, 0, $i)
        GUICtrlSetGraphic(-1, $GUI_GR_COLOR, $BgColor2)
        GUICtrlSetGraphic(-1, $GUI_GR_LINE, $iWCanvas, $i)

        GUICtrlSetGraphic(-1, $GUI_GR_MOVE, 0, $i)
        GUICtrlSetGraphic(-1, $GUI_GR_COLOR, $BgColor)
        GUICtrlSetGraphic(-1, $GUI_GR_LINE, -$iDepthCanvas, $i+$iDepthCanvas)
    Next
    Local $Canvas = StringSplit($iXCanvas+$iDepthCanvas &"|"& $iYCanvas-$iDepthCanvas&"|"&$iWCanvas&"|"&$iHCanvas&"|"&$iDepthCanvas,"|",2)
    ;ConsoleWrite($iXCanvas+$iDepthCanvas &"|"& $iYCanvas-$iDepthCanvas&"|"&$iWCanvas&"|"&$iHCanvas&@CRLF)
    Return $Canvas
EndFunc
#EndRegion INTERNAL USE ONLY