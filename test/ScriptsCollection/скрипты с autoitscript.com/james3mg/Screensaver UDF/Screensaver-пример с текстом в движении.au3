#include <_SS_UDF.au3>
$MySSWin=_SS_GUICreate()
$MyLabel=GUICtrlCreateLabel("Hello, World!",5,5,100,20)
GUICtrlSetColor(-1,0xFFFFFF)
_SS_SetMainLoop("MyMainLoop")
Global $Xpos=1
Global $Ypos=1
Global $Xdir=1
Global $Ydir=1

_SS_Start()

Func MyMainLoop()
    Do
        GUICtrlSetPos($MyLabel,$Xpos,$Ypos)
        $Xpos+=$Xdir
        $Ypos+=$Ydir
        If $YPos=0 Or ($YPos=$_SS_WinHeight-20 AND $YDir=1) Then $YDir=$YDir*-1
        If $XPos=0 Or ($XPos=$_SS_WinWidth-100 AND $XDir=1) Then $XDir=$XDir*-1
        Sleep(15)
    Until _SS_ShouldExit()
EndFunc
