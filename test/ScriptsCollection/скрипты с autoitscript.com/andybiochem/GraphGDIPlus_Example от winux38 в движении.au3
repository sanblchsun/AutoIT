#include <Array.au3>

#include "GraphGDIPlus.au3"

Opt("GUIOnEventMode", 1)
local $xsize,$ysize,$k
$xsize=1000
$ysize=600
Global $iMin=-15
Global $iMax=20

;----- Create random data table -----
local $XYval[1][3], $j=0
  For $i = -5 to 5 step 0.1
    redim $XYval[$j+1][3]
    $XYval[$j][0]=$i
    $XYval[$j][1]=Random($iMin, $iMax)
    $XYval[$j][2]=""
    if $XYval[$j][1] > ($iMin+(0.75*($iMax-$iMin))) then
        $XYval[$j][2]="B"
    ElseIf $XYval[$j][1] < ($iMin+(0.25*($iMax-$iMin))) then
        $XYval[$j][2]="S"
    EndIf

    $j+=1
next



;----- Create window for graph -----
$GUI = GUICreate("",$xsize,$ysize)
GUISetOnEvent(-3,"_Exit")
GUISetState()



;----- Create area for graph0 -----
local $graph=-1
$Graph = _GraphGDIPlus_Create($GUI,40,              30,        $xsize/3,$ysize/3,0xFF000000,0xFF88B3DD)
_GraphGDIPlus_Set_RangeX($Graph,-5,5,10,1)
_GraphGDIPlus_Set_RangeY($Graph,-25,25,10,1)


;----- Create area for graph1 -----
local $graph1=-1
$Graph1 = _GraphGDIPlus_Create($GUI,80+$xsize/3,    30,         $xsize/3,$ysize/3,0xFF000000,0xFF88B3DD)
_GraphGDIPlus_Set_RangeX($Graph1,-5,5,1,1)
_GraphGDIPlus_Set_RangeY($Graph1,-50,50,1,1)
;_GDIPlus_GraphicsSetSmoothingMode($Graph1, 1)
;----- Create area for graph2 -----
local $graph2=-1
#cs
$Graph2 = _GraphGDIPlus_Create($GUI,40,     60+$ysize/3,        $xsize/3,$ysize/3,0xFF00FF00,0xFF88B3DD)
_GraphGDIPlus_Set_RangeX($Graph2,-5,5,1,1)
_GraphGDIPlus_Set_RangeY($Graph2,-10,50,1,1)
#ce

local $firstloop=1
While 1
    Sleep(100)

    ;----- Setup for the graph0 -----
if $graph<>-1 Then
    _PrintGraph($graph,$XYval)
EndIf

    ;----- Setup for the graph1 -----
if  $graph1<>-1 Then
    _PrintGraph($graph1,$XYval)
EndIf

    ;----- Setup for the graph2 -----
if  $graph2<>-1 Then
    _PrintGraph($graph2,$XYval)
EndIf
if $firstloop=1 Then
    $firstloop=0
    _GraphGDIPlus_SaveImage(@ScriptDir & "\test.jpg", $GUI)
EndIf

;----- left shift of value array -----
For $i=0 to UBound($XYval,1)-2
    $XYval[$i][1]=$XYval[$i+1][1]
next
$XYval[$i][1]=Random($iMin,$iMax)
$XYval[$i][2]=""
if $XYval[$i][1] > ($iMin+(0.75*($iMax-$iMin))) then
    $XYval[$i][2]="B"
ElseIf $XYval[$i][1] < ($iMin+(0.25*($iMax-$iMin))) then
    $XYval[$i][2]="S"
EndIf

WEnd



Func _Draw_Graph()
    ;----- Set line color and size -----
    _GraphGDIPlus_Set_PenColor($Graph,0xFF325D87)
    _GraphGDIPlus_Set_PenSize($Graph,2)

    ;----- draw lines -----
    $First = True
    For $i = -5 to 5 step 0.1
        $y = _X2Function($i)
        If $First = True Then _GraphGDIPlus_Plot_Start($Graph,$i,$y)
        $First = False
        _GraphGDIPlus_Set_PenColor($Graph,0xFF325D87)
        _GraphGDIPlus_Plot_Line($Graph,$i,$y)
        _GraphGDIPlus_Refresh($Graph)
    Next
EndFunc

Func _Draw_Graph1(byref $lgraph, byref $xyval)
    ;----- Set line color and size -----
    local $pencolor[4]=[0xFFFF0000, 0xFF00FF00,0xFFFFFF00,0xFFFF00FF]
    local $colorindex=0

    ;----- draw lines -----
    $First = True
    For $i=0 to UBound($xyval,1)-1
        If $First = True Then
            _GraphGDIPlus_Plot_Start($lgraph,$xyval[$i][0],$xyval[$i][1])
            $First = False
        EndIf
        
        _GraphGDIPlus_Set_PenSize($lgraph,1)
        _GraphGDIPlus_Set_PenColor($lgraph,0xFF325D87)
       _GraphGDIPlus_Plot_Line($lgraph,$xyval[$i][0],$xyval[$i][1])
        
       if $xyval[$i][1] > $iMin+(0.75*($iMax-$iMin)) Then
            _GraphGDIPlus_Set_PenSize($lgraph,4)
            _GraphGDIPlus_Set_PenColor($lgraph,$pencolor[0])
            _GraphGDIPlus_Plot_Dot($lgraph,$xyval[$i][0],$xyval[$i][1])
        ElseIf $xyval[$i][1] < $iMin+(0.25*($iMax-$iMin)) Then
            _GraphGDIPlus_Set_PenSize($lgraph,4)
            _GraphGDIPlus_Set_PenColor($lgraph,$pencolor[1])
            _GraphGDIPlus_Plot_Dot($lgraph,$xyval[$i][0],$xyval[$i][1])
        EndIf
    
        $colorindex+=1
        $colorindex =BitAND($colorindex,0x00000003)
        _GraphGDIPlus_Refresh($lgraph)
Next
EndFunc

Func _X2Function($iZ)
    Return ($iZ*$iZ)
EndFunc

Func _X3Function($iZ)
    Return $iZ^3+2*$iZ^2-$iZ
EndFunc


Func _GammaFunction($iZ)
    $nProduct = ((2^$iZ) / (1 + $iZ))
    For $n = 2 to 1000
        $nProduct *= ((1 + (1/$n))^$iZ) / (1 + ($iZ / $n))
    Next
    Return (1/$iZ) * $nProduct
EndFunc

func _PrintGraph($lgraph,$lxyval)
    _GraphGDIPlus_Clear($lgraph)
    _GraphGDIPlus_Set_GridX($lgraph,1,0xFF6993BE)
    _GraphGDIPlus_Set_GridY($lgraph,5,0xFF6993BE)
    _Draw_Graph1($lgraph, $lxyval)
EndFunc


Func _Exit()
    ;----- close down GDI+ and clear graphic -----
    _GraphGDIPlus_Delete($GUI,$Graph)
    Exit
EndFunc