#include <Array.au3>
#include <EditConstants.au3>
#include <File.au3>
#include <GUIConstantsEx.au3>
#Include <GuiListView.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Math.au3>

Opt('GUIResizeMode', 802) 
Global Const $WIDTH = 200, $HEIGHT = 300, $B = 10 
Global Const $EXTRA_HEIGHT = 150  
$n = 28
Global $chordData[$n][5] = [['A major', '1.2|1.3|1.4', 'xo|||o' , '_Amajor' , ''] , ['A major 7', '1.2|1.4', 'xo|o|o' , '_Amajor7', ''], _
['A suspend 2', '1.2|1.3', 'xo||oo' , '_Asus2', ''], ['A suspend 4', '1.2|1.3|2.4', 'xo|||o' , '_Asus4', ''], ['A minor', '1.2|1.3|0.4', 'xo|||o', '_Aminor', ''], _ 
['B flat minor', '0.0|0.1|0.2|0.3|0.4|0.5|2.2|2.3|1.4', '||||||' , '_Bflatminor', '']  , ['B flat major', '0.0|0.1|0.2|0.3|0.4|0.5|2.2|2.3|2.4', '||||||' , '_Bflatmajor', ''], _ 
['B major', '1.0|1.1|1.2|1.3|1.4|1.5|3.2|3.3|3.4', '||||||' , '_Bmajor', ''] , ['B major 7', '1.1|0.2|1.3|1.5', 'x|||o|', '_Bmajor7', ''] , ['C major', '2.1|1.2|0.4', 'x||o|o' , '_Cmajor', ''], _ 
['C major 7', '2.1|1.2|2.3|0.4', 'x||||o' , '_Cmajor7', ''],  ['C minor', '2.0|2.1|2.2|2.3|2.4|2.5|4.2|4.3|3.4', '||||||' , '_Cminor', ''], _ 
['D major', '1.3|2.4|1.5', 'xxo|||' , '_Dmajor', ''],  ['D major 7', '1.3|0.4|1.5', 'xxo|||' , '_Dmajor7', ''],  ['D minor', '1.3|2.4|0.5', 'xxo|||' , '_Dminor', ''], _ 
['D suspend 2', '1.3|2.4', 'xxo||o' , '_Dsus2', ''],  ['D suspend 4', '1.3|2.4|3.5', 'xxo|||', '_Dsus4', ''], ['E major', '1.1|1.2|0.3', 'o||||oo' , '_Emajor', ''], _ 
['E7', '1.1|0.3', 'o|o||oo' , '_Emajor7', ''], ['E minor', '1.1|1.2', 'o||ooo' , '_Eminor', ''], ['E suspend 4', '1.1|1.2|1.3', 'o|||oo' , '_Esus4', ''], _ 
['F major 7', '2.2|1.3|0.4', 'xx|||o' , '_Fmajor7', ''] ,  ['G major', '2.0|1.1|2.4|2.5', '||oo||' , '_Gmajor', ''], _
['G major Barre', '2.0|2.1|2.2|2.3|2.4|2.5|4.1|4.2|3.3', '||||||' , '_GmajorBarre', ''] , ['G minor Barre', '2.0|2.1|2.2|2.3|2.4|2.5|4.1|4.2', '||||||' , '_GminorBarre', ''] , _ 
['G major 7', '2.0|1.1|0.5', '||ooo|' , '_Gmajor7', ''],  ['D sharp minor', '2.0|2.1|2.2|2.3|2.4|2.5|4.2|4.3|3.4', '||||||' , '_Dsharpminor', '4'], _
['D sharp major', '2.0|2.1|2.2|2.3|2.4|2.5|4.2|4.3|4.4', '||||||' , '_Dsharpmajor', '4']]



Global $listview = -1 
Global $checkedList[UBound($chordData)]     
For $i = 0 to UBound($chordData) - 1         
    $checkedList[$i] = 1     
Next 
Global $currentIndex = -1 
$gui = GUICreate('Chord Practice', $WIDTH + $B * 2, $HEIGHT + $B * 8) 
$chordPic = '56]'  
Global $xOffset = 5 
$chordName = GUICtrlCreateLabel('', $B * 2, $B * 2.5, $WIDTH - $B * 2, 32, $SS_CENTER)
GUICtrlSetFont(-1, 20)   
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)    
GUICtrlSetFont(-1, 20, 500, -1, 'Tahoma') 
Global $lblStrum[6]
For $i = 0 to UBound($lblStrum) - 1    
$lblStrum[$i] = GUICtrlCreateLabel('', 31 - $xOffset + 30 * $i, 53, 20, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))        
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)        
GUICtrlSetFont(-1, 16, 500, -1, 'Tahoma')
Next 
$txtInterval = GUICtrlCreateInput('2', $B, $HEIGHT + $B * 2, 40, 20, $ES_NUMBER) 
GUICtrlCreateUpdown($txtInterval)
GUICtrlCreateLabel('Interval (seconds)', $B + 45, $HEIGHT + $B * 2 +3, 90) 
$startStop = GUICtrlCreateButton('Start', $WIDTH - 40, $HEIGHT + $B * 2, 50, 20)
$btnExpand = GUICtrlCreateButton('>>>', $B, $HEIGHT + $B * 5, $WIDTH, 20) 
$expanded = False 
GUISetState() 

Global $Object = ObjCreate("SAPI.SpVoice")




While 1     
    GUIRegisterMsg($WM_NOTIFY, 'WM_NOTIFY')
GUISetState()
    Switch GUIGetMsg()        
    Case $GUI_EVENT_CLOSE            
        Exit        
    Case $startStop             
        If GUICtrlRead($startStop) = 'Start' then                
            $int = GUICtrlRead($txtInterval)                
            If $int < 1 then                    
                $int = 1                   
                GUICtrlSetData($txtInterval, $int)            
            EndIf               
            AdlibRegister('_ChangeChordPic', $int * 2000)            
         
            GUICtrlSetState($txtInterval, $GUI_DISABLE)         
            GUICtrlSetState($btnExpand, $GUI_DISABLE)     
            _UpdateCheckedList() 
            
            
            $string = 0
            
            For $i = 0 To UBound($checkedlist) - 1
    $string += $checkedlist[$i]
Next



        If $string < 1 Then  
GUIDelete ($gui)
msgbox (0, '', 'please open again and select 1 or more items')
exit
endif
            If $expanded then
                _Contract() 
                EndIf
GUICtrlSetData($startStop, 'Stop')
                _ChangeChordPic()  
                            Else             
                AdlibUnRegister('_ChangeChordPic')          
            GUICtrlSetData($startStop, 'Start')        
            GUICtrlSetState($txtInterval, $GUI_ENABLE)        
            GUICtrlSetState($btnExpand, $GUI_ENABLE)    
     For $i = 0 to _GUICtrlListView_GetItemCount($listview) - 1    
        $checkedList[$i] = 1
If $checkedList[$i] = 1 then         
                _GUICtrlListView_SetItemChecked($listview, $i, True)         
            EndIf
next
         
Endif        
    Case $btnExpand         
        If $expanded then     
            _Contract()        
        Else               
            _Expand()         
        EndIf   
    EndSwitch
WEnd 

Func _ChangeChordPic()   
    Local $index = -1    
    Do        
        $index = Random(0, UBound($checkedlist) - 1, 1)   
    Until $index - 1 <> $currentIndex and $checkedList[$index] = 1  
    $currentIndex = $index
    _SetChord()
    $saychord = StringReplace ($chorddata[$index][0], "A" , "eigh" , 0 , 1)
    $saychord1 = StringReplace ($saychord, "flat" , "phlat")
    $Object.Speak($saychord1, 0)
    call ($chorddata[$index][3])
EndFunc

Func _UpdateCheckedList()  
    For $i = 0 to _GUICtrlListView_GetItemCount($listview) - 1       
        If _GUICtrlListView_GetItemChecked($listview, $i)  then         
            $checkedList[$i] = 1   
        Else            
            $checkedList[$i] = 0       
        EndIf    
    Next
EndFunc 

Func _Contract()  
    GUICtrlSetState($listview, $GUI_HIDE)   
    $pos = WinGetPos($gui)   
    WinMove($gui, '', $pos[0], $pos[1], $pos[2], $pos[3] - $EXTRA_HEIGHT)    
    GUICtrlSetPos($btnExpand, $B, $HEIGHT + $B * 5, $WIDTH, 20)   
    $expanded = False    
    GUICtrlSetData($btnExpand, '>>>')
EndFunc 

Func _Expand()  
    msgbox (0, '' , 'you must select 1 or more items, otherwise program will exit')
    $pos = WinGetPos($gui)  
    WinMove($gui, '', $pos[0], $pos[1], $pos[2], $pos[3] + $EXTRA_HEIGHT)   
    If $listview <> -1 then         
        GUICtrlSetState($listview, $GUI_SHOW)  
    Else      
        $listview = GUICtrlCreateListView('Chord', $B, $HEIGHT + $B * 5, $WIDTH, $EXTRA_HEIGHT)      
        _GUICtrlListView_SetExtendedListViewStyle($listview, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES, $LVS_EX_GRIDLINES ))   ;$LVS_EX_ONECLICKACTIVATE
        _GUICtrlListView_SetColumnWidth($listview, 0, $WIDTH - 30)        
        For $i = 0 to UBound($chordData) - 1    
            _GUICtrlListView_AddItem($listview, $chordData[$i][0])      
            If $checkedList[$i] = 1 then         
                _GUICtrlListView_SetItemChecked($listview, $i, True)         
            EndIf      
        Next   
    EndIf    
    GUICtrlSetPos($btnExpand, $B, $HEIGHT + $B * 5 + $EXTRA_HEIGHT + 5, $WIDTH, 20)  
    $expanded = True   
    GUICtrlSetData($btnExpand, '<<<')
    GUICtrlSetState(-1 , $GUI_ENABLE)
EndFunc 

Func _SetChord()   
    GUICtrlDelete($chordPic)   
    $chordPic = GUICtrlCreateGraphic($B, $B, $WIDTH, $HEIGHT)       
    GUICtrlSetBkColor(-1, 0xFFFFFF)      
    GUICtrlSetColor(-1, 0)   
    GUICtrlSetData($chordName, $chordData[$currentIndex][0])    
    $strum = StringSplit($chordData[$currentIndex][2], '')   
    For $i = 0 to UBound($lblStrum) - 1      
        If $strum[$i + 1] = '|' then $strum[$i + 1] = ''      
            GUICtrlSetData($lblStrum[$i], $strum[$i + 1])    
        Next    
        For $i = 1 to 6      
            GUICtrlSetGraphic($chordPic, $GUI_GR_RECT, $i * 30 - $xOffset, 65, 2, 184)   
        Next    
        GUICtrlSetGraphic($chordPic, $GUI_GR_RECT, 30 - $xOffset, 65, 150, 2)  
        For $i = 0 to 5      
            GUICtrlSetGraphic($chordPic, $GUI_GR_RECT, 30 - $xOffset, 72 + $i * 35, 150, 2) 
        Next        
        $pos = StringSplit($chordData[$currentIndex][1], '|')   
        GUICtrlSetGraphic($chordPic, $GUI_GR_COLOR, 0, 0)  
        GUICtrlCreateLabel ( $chorddata[$currentindex][4], 20 - $xOffset, 88, 10, 13 )
    GUICtrlSetBkColor(-1, 0xFFFFFF)      
    GUICtrlSetColor(-1, 0) 
    GUICtrlSetFont (-1 , '' , 600)
        For $i = 0 to UBound($pos) - 2       
            $stringSplit = StringSplit($pos[$i + 1], '.')      
            GUICtrlSetGraphic($chordPic, $GUI_GR_ELLIPSE, ($stringSplit[2] + 1) * 30 - 15, ($stringSplit[1]) * 35 + 63 + 35/2, 22, 22)   
        Next   
        GUICtrlSetGraphic($chordPic, $GUI_GR_REFRESH)
    EndFunc
    
    Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    #forceref $hWnd, $iMsg, $iwParam
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo
    $hWndListView = $listview
    If Not IsHWnd($listview) Then $hWndListView = GUICtrlGetHandle($listview)
    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $hWndListView
            Switch $iCode
            Case $NM_DblClk 
                $currentindex = -1
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
                        $CurrentIndex =  _GUICtrlListView_GetHotItem ($hWndlistview)
                        If $CurrentIndex   = -1 Then
                        $CurrentIndex = 0
                    Else
                    If _GUICtrlListView_GetItemChecked($hWndlistview, $CurrentIndex) then
                        _GUICtrlListView_SetItemChecked($hWndlistview, $CurrentIndex, False)
                    Else
                        _GUICtrlListView_SetItemChecked($hWndlistview, $CurrentIndex)
                    endif
                EndIf
                _setchord()
                Case $NM_RCLICK 
                    
                For $i = 0 to _GUICtrlListView_GetItemCount($hWndlistview) - 1   
            If $checkedList[$i] = 1 then         
                _GUICtrlListView_SetItemChecked($listview, $i, False) 
            
            EndIf      
        Next   
                        
                    Case $NM_RDBLCLK 
                        
                        For $i = 0 to $n -1
                        If $checkedlist[$i] = 1 then
                _GUICtrlListView_SetItemChecked($listview, $i, True) 
                Endif
            Next
            
            
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
 
    
Func _Beep($iNote,$iOctave=4,$iDuration=200,$iPause=0)
        Global $nTempo=0.8
Global $iTone=-1
    $iFrequency=440*2^(($iNote+$iTone)/12+$iOctave+1/6-4)
    Beep($iFrequency, $iDuration/$nTempo)
    If $iPause<>0 Then Sleep($iPause/$nTempo)
    EndFunc

Func _Amajor()
_Beep(1,2,300)
_Beep(8,2,300)
_Beep(1,3,300)
_Beep(5,3,300)
_Beep(8,3,300)
Endfunc

Func _Amajor7()
_Beep(1,2,300)
_Beep(8,2,300)
_Beep(11,2,300)
_Beep(5,3,300)
_Beep(8,3,300)
Endfunc

Func _Asus2()
_Beep(1,2,300)
_Beep(8,2,300)
_Beep(1,3,300)
_Beep(3,3,300)
_Beep(8,3,300)
Endfunc

Func _Asus4()
_Beep(1,2,300)
_Beep(8,2,300)
_Beep(1,3,300)
_Beep(7,3,300)
_Beep(8,3,300)
Endfunc

Func _Aminor()
_Beep(1,2,300)
_Beep(8,2,300)
_Beep(1,3,300)
_Beep(4,3,300)
_Beep(8,3,300)
Endfunc

Func _Bflatminor()
_Beep(9,1,300)
_Beep(2,2,300)
_Beep(9,2,300)
_Beep(2,3,300)
_Beep(5,3,300)
_Beep(9,3,300)
Endfunc

Func _Bflatmajor()
_Beep(9,1,300)
_Beep(2,2,300)
_Beep(9,2,300)
_Beep(2,3,300)
_Beep(6,3,300)
_Beep(9,3,300)
Endfunc

Func _Bmajor()
_Beep(10,1,300)
_Beep(3,2,300)
_Beep(10,2,300)
_Beep(3,3,300)
_Beep(7,3,300)
_Beep(9,3,300)
Endfunc

Func _Bmajor7()
_Beep(3,2,300)
_Beep(7,2,300)
_Beep(1,3,300)
_Beep(3,3,300)
_Beep(10,3,300)
Endfunc

Func _Cmajor()
_Beep(4,2,300)
_Beep(8,2,300)
_Beep(11,2,300)
_Beep(4,3,300)
_Beep(8,3,300)
Endfunc

Func _Cmajor7()
_Beep(4,2,300)
_Beep(8,2,300)
_Beep(2,3,300)
_Beep(4,3,300)
_Beep(8,3,300)
Endfunc

Func _Cminor()
_Beep(11,1,300)
_Beep(4,2,300)
_Beep(11,2,300)
_Beep(4,3,300)
_Beep(7,3,300)
_Beep(11,3,300)
Endfunc

Func _Dmajor()
_Beep(6,2,300)
_Beep(1,3,300)
_Beep(6,3,300)
_Beep(10,3,300)
Endfunc

Func _Dmajor7()
_Beep(6,2,300)
_Beep(1,3,300)
_Beep(4,3,300)
_Beep(10,3,300)
Endfunc

Func _Dminor()
_Beep(6,2,300)
_Beep(1,3,300)
_Beep(4,3,300)
_Beep(9,3,300)
Endfunc

Func _Dsus2()
_Beep(6,2,300)
_Beep(1,3,300)
_Beep(6,3,300)
_Beep(8,3,300)
Endfunc

Func _Dsus4()
_Beep(6,2,300)
_Beep(1,3,300)
_Beep(6,3,300)
_Beep(12,3,300)
Endfunc

Func _Emajor()
_Beep(8,1,300)
_Beep(3,2,300)
_Beep(8,2,300)
_Beep(12,2,300)
_Beep(3,3,300)
_Beep(8,3,300)
Endfunc

Func _Emajor7()
_Beep(8,1,300)
_Beep(3,2,300)
_Beep(6,2,300)
_Beep(12,2,300)
_Beep(3,3,300)
_Beep(8,3,300)
Endfunc

Func _Eminor()
_Beep(8,1,300)
_Beep(3,2,300)
_Beep(8,2,300)
_Beep(11,2,300)
_Beep(3,3,300)
_Beep(8,3,300)
Endfunc

Func _Esus4()
_Beep(8,1,300)
_Beep(3,2,300)
_Beep(8,2,300)
_Beep(1,3,300)
_Beep(3,3,300)
_Beep(8,3,300)
Endfunc

Func _Fmajor7()
_Beep(9,2,300)
_Beep(1,3,300)
_Beep(4,3,300)
_Beep(8,3,300)
Endfunc

Func _Gmajor()
_Beep(11,1,300)
_Beep(3,2,300)
_Beep(6,2,300)
_Beep(11,2,300)
_Beep(6,3,300)
_Beep(11,3,300)
Endfunc

Func _Gmajor7()
_Beep(11,1,300)
_Beep(3,2,300)
_Beep(6,2,300)
_Beep(11,2,300)
_Beep(3,3,300)
_Beep(9,3,300)
Endfunc

Func _Dsharpminor()
_Beep(2,2,300)
_Beep(7,2,300)
_Beep(12,2,300)
_Beep(5,3,300)
_Beep(8,3,300)
_Beep(2,4,300)
Endfunc

Func _Dsharpmajor()
_Beep(2,2,300)
_Beep(7,2,300)
_Beep(12,2,300)
_Beep(5,3,300)
_Beep(9,3,300)
_Beep(2,4,300)
Endfunc

Func _GmajorBarre()
_Beep(11,1,300)
_Beep(6,2,300)
_Beep(11,2,300)
_Beep(3,3,300)
_Beep(6,3,300)
_Beep(11,3,300)
Endfunc

Func _GminorBarre()
_Beep(11,1,300)
_Beep(6,2,300)
_Beep(11,2,300)
_Beep(2,3,300)
_Beep(6,3,300)
_Beep(11,3,300)
Endfunc

;A=1
;A#=2
;B=3
;C=4
;C#=5
;D=6
;Eb=7
;E=8
;F=9
;F#=10
;G=11
;G#=12
                
 