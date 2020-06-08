#include <GUIConstants.au3>
#include <GuiEdit.au3>
#include <ButtonConstants.au3>
#include <WindowsConstants.au3>

; http://www.autoitscript.com/forum/index.ph...st&p=474934
;======= From matrixUDF.au3 file @ bottom ============
Global  $iDF = 0 ; use to calculate determinantand used in Upper Triangle calculations. sign of submatrices
Global $setdecplac, $decplInput1, $decplaceval = 0
;================================================

Global Const $WM_LBUTTONDOWN = 0x0201  ; Drag Window 1 of 3 addin
Dim $matrix1, $newm1, $RandMat1, $menu1, $openf1, $saveas1, $separator1, $filexit1, $Matname1 = "Untitled"            ;Gui matrix1
Dim $matrix2, $newm2, $RandMat2, $menu2, $openf2, $saveas2, $filexit2, $Matname2 = "Untitled"                         ;Gui matrix2
Dim $matrix3, $newm3, $RandMat3, $menu3, $openf3, $saveas3, $filexit3, $Matname3 = "Untitled"                          ;Gui matrix3
Dim $Run1[1072],$Run2[630],$Run3[630], $opos = 0, $matrix1, $matrix2, $matrix3    ; dispmat func variables
Dim $filename,$w2, $h3
Dim $m1[5][5] = [[ 3, 2, -1, 3, 4], [1, 6, 3, 3, 1], [2, -4, 0, 3, 9 ],[2, 3, 9, 12, 3],[4, 2, 8, 5, 1]] ;Gui matrix1 
Dim $m2[3][3] = [[ 3, 2, -1], [1, 6, 3], [2, -4, 0]]  ;Gui matrix2
Dim $m3[3][3] = [[ 0, 0, 0], [0, 0, 0], [0, 0, 0]] ;Gui matrix3

Const $pi = 4*atan(1) , $pifactor = $pi/180                                              ;  Command line varables
Global $stringtocalc,$splitcalc,$pp, $temg, $tempm, $mf = 0, $mr = 0  ;  Command line varables
Dim  $string, $linButok, $linButcan, $commandInput, $mainfrm , $lineEdit     ;  Command line varables

Opt("GUIResizeMode", 802)  ; Very important to get the right size GUICtrlCreateInput
Opt("PixelCoordMode", 2)
Opt("WinTitleMatchMode", 3)
HotKeySet("{Enter}", "enterkey")
matrix1gui()
matrix2gui()
matrix3gui()
Commandline()
    

GuiRegisterMsg($WM_LBUTTONDOWN, "_WinMove")    ; Drag Window 2 of 3 addin

While 1
    If GetHoveredHwnd() = $matrix1 Then
        ToolTip("Matrix1 is "& $Matname1)
    ElseIf GetHoveredHwnd() = $matrix2 Then
        ToolTip("Matrix2 is "& $Matname2)
    ElseIf GetHoveredHwnd() = $matrix3 Then
        ToolTip("Matrix3 is "& $Matname3)   
    Else
        ToolTip("")
    EndIf
    
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE,  $filexit1, $filexit2, $filexit3, $linButcan    
            $no = MsgBox(4, "Exit Matrix Manipulation?", " If you wish to continue and save matrix (matrices), press No " & @CRLF & @CRLF & " To Exit, press Yes.")  
            if $no = 6 then ExitLoop    
        ;-------------------------------- Matrix 1 Menu -------------      
        ;Case $loadcal1, $loadcal2, $loadcal3          ;Calculator
        ;   ShellExecute("Calc.exe")
        Case $newm1   
            $n = NewMatrix("Matrix 1")
            if $n <> 1 then
                $m1 = $n
                ;MsgBox(0,"",$m1[0][0] & "   " & $m1[0][1])
                dispmat("Matrix 1", $m1)             
                $Matname1 = $filename
            EndIf   
        Case $openf1                
            $n = fileop()
            if $n <> 1 then     
                $m1 = $n
                dispmat("Matrix 1", $m1)
                $Matname1 = $filename
            EndIf   
        Case $saveas1
            $m1 = refreshmat($m1, "Matrix 1")
            $n = savemat("Matrix 1", $m1)
            if $n <>1 then
                $Matname1 = $filename
            EndIf   
        Case $RandMat1
            ;$oldfname = $Matname1
            $m1 = refreshmat($m1, "Matrix 1")
            $m1 = RandomizeMatrixData($m1)
            dispmat("Matrix 1", $m1)
            $Matname1 = "Untitled"        
        ;--------------------------> End of  Matrix 1 Menu -------------    
        Case $newm2   
            $n = NewMatrix("Matrix 2")
            if $n <> 1 then
                $m2 = $n
                ;MsgBox(0,"",$m2[0][0] & "   " & $m2[0][2])
                dispmat("Matrix 2", $m2)             
                $Matname2 = $filename
            EndIf   
        Case $openf2                
            $n = fileop()
            if $n <> 1 then     
                $m2 = $n
                dispmat("Matrix 2", $m2)
                $Matname2 = $filename
            EndIf   
        Case $saveas2
            $m2 = refreshmat($m2, "Matrix 2")
            $n = savemat("Matrix 2", $m2)
            if $n <>2 then
                $Matname2 = $filename
            EndIf   
        Case $RandMat2
            ;$oldfname = $Matname2
            $m2 = refreshmat($m2, "Matrix 2")
            $m2 = RandomizeMatrixData($m2)
            dispmat("Matrix 2", $m2)
            $Matname2 = "Untitled"    
        ;-----------------------------> End of  Matrix 2 Menu ------------- 
        Case $newm3   
            $n = NewMatrix("Matrix 3")
            if $n <> 1 then
                $m3 = $n
                ;MsgBox(0,"",$m3[0][0] & "   " & $m3[0][3])
                dispmat("Matrix 3", $m3)             
                $Matname3 = $filename
            EndIf   
        Case $openf3                
            $n = fileop()
            if $n <> 1 then     
                $m3 = $n
                dispmat("Matrix 3", $m3)
                $Matname3 = $filename
            EndIf   
        Case $saveas3
            $m3 = refreshmat($m3, "Matrix 3")
            $n = savemat("Matrix 3", $m3)
            if $n <>3 then
                $Matname3 = $filename
            EndIf   
        Case $RandMat3
            ;$oldfname = $Matname3
            $m3 = refreshmat($m3, "Matrix 3")
            $m3 = RandomizeMatrixData($m3)
            dispmat("Matrix 3", $m3)
            $Matname3 = "Untitled"  
        ;---------------------------------> End of  Matrix 3 Menu ------------- 
        
        Case $linButok
            $string = GUICtrlRead ($commandInput)
            ;If $string = '' Then Exit
            $string = StringStripWS($string,8)
            $string = StringUpper($string)
            consolewrite(' @start $string =' & $string & "   str lngth- 2 =  "& (StringLen($string)-2) & @CR)
            if StringInStr ($string,"=") = (StringLen($string)-2)  Then
                $mr = StringRight($string,2)                
                $string = StringMid($string,1,StringLen($string)-3)
                consolewrite(' @start2nd $string =' & $string & ' $mr =' & expandabbrev($mr) & @CR)
            EndIf
            If StringRight($string,1) = '=' Then
                $string = StringMid($string,1,StringLen($string)-1)
            EndIf
            $m1 = refreshmat($m1, "Matrix 1")
            $m2 = refreshmat($m2, "Matrix 2")
            $m3 = refreshmat($m3, "Matrix 3")            
            consolewrite(' sent $string =' & $string & @CR)
            $answ = calculate($string)
            consolewrite('IsArray($answ) =' & IsArray($answ) & '   ($answ) =' & ($answ) & @CR)        
            If IsArray($answ) then
               If $mr = "" then $mr = SelMatRslt()
               If $mr <> "0" then                               
                    If $mf = 2 Then $decplaceval = 8                
                    if $mf >= 1 Then
                        If expandabbrev($mr) = "Matrix 1" Then 
                            $m1 = $answ   ;$tempm  
                            dispmat(expandabbrev($mr),$m1)
                        ElseIf expandabbrev($mr) = "Matrix 2" Then 
                            $m2 = $answ   ;$tempm  
                            dispmat(expandabbrev($mr),$m2)
                        ElseIf expandabbrev($mr) = "Matrix 3" Then 
                            $m3 = $answ   ;$tempm   
                            dispmat(expandabbrev($mr),$m3)  
                        EndIf
                    EndIf
                EndIf   
            else
                MsgBox(0,$string & ' = ',$answ)
            EndIf
            If $mf = 2 Then $decplaceval = 0
            GUICtrlSetData ( $commandInput, "")
            $string = ""
            $tempm = ""
            $mr = ""
            $mf = 0
            GUICtrlSetState ($lineEdit, $GUI_FOCUS)
    EndSwitch
WEnd            
        
; ========== Martix 1 GUI window ==========
Func matrix1gui()
    $matrix1 =  GuiCreate( "Matrix1",540, 200, @DesktopWidth * 0.1, 20, Default, Default)   ;, $WS_EX_TOOLWINDOW )
    GUISetBkColor(0xA6CAF0)
    
    ;==== Matrix1 Menu
    $menu1 = GUICtrlCreateMenu("Menu")
    $newm1 = GUICtrlCreateMenuItem("New Matrix", $menu1)
    $openf1 = GUICtrlCreateMenuItem("Open Matrix", $menu1)
    $saveas1 = GUICtrlCreateMenuItem("Save As", $menu1)
    $RandMat1 = GUICtrlCreateMenuItem("Randomize Data in Matrix", $menu1)
    $separator1 = GUICtrlCreateMenuitem ("",$menu1,6)   ; create a separator line
    $filexit1 = GUICtrlCreateMenuItem("Exit", $menu1)      
    ;====> End of Matrix1 Menu
    dispmat("Matrix 1", $m1)
    GUISetState()
EndFunc

; ========== Martix 2 GUI window ==========
Func matrix2gui()
$matrix2 =  GuiCreate( "Matrix2", $w2, 200, @DesktopWidth - $w2 - 5, 40, Default)  ;, $WS_EX_TOOLWINDOW )
    GUISetBkColor( 0xF4F6B4 )
    
    ;==== Matrix2 Menu
    $menu2 = GUICtrlCreateMenu("Menu")
    $newm2 = GUICtrlCreateMenuItem("New Matrix", $menu2)
    $openf2 = GUICtrlCreateMenuItem("Open Matrix", $menu2)
    $saveas2 = GUICtrlCreateMenuItem("Save As", $menu2)
    $RandMat2 = GUICtrlCreateMenuItem("Randomize Data in Matrix", $menu2)
    ;$loadcal2 = GUICtrlCreateMenuItem("Calculator", $menu2)
    $separator1 = GUICtrlCreateMenuitem ("",$menu2,6)   ; create a separator line
    $filexit2 = GUICtrlCreateMenuItem("Exit", $menu2)      
    ;====> End of Matrix2 Menu  
    dispmat("Matrix 2", $m2)        
    GUISetState()
EndFunc
    
; ========== Martix 3 GUI window ========== 
Func matrix3gui()
    $matrix3 = GuiCreate( "Matrix3", 540, $h3, 40, @DesktopHeight - $h3 - 186, Default)  ;, $WS_EX_TOOLWINDOW )
    GUISetBkColor( 0xff0000 )
    
        ;==== Matrix3 Menu
    $menu3 = GUICtrlCreateMenu("Menu")
    $newm3 = GUICtrlCreateMenuItem("New Matrix", $menu3)
    $openf3 = GUICtrlCreateMenuItem("Open Matrix", $menu3)
    $saveas3 = GUICtrlCreateMenuItem("Save As", $menu3)
    $RandMat3 = GUICtrlCreateMenuItem("Randomize Data in Matrix", $menu3)
    ;$loadcal3 = GUICtrlCreateMenuItem("Calculator", $menu3)
    $separator1 = GUICtrlCreateMenuitem ("",$menu3,6)   ; create a separator line
    $filexit3 = GUICtrlCreateMenuItem("Exit", $menu3)      
    ;====> End of Matrix3 Menu  
    dispmat("Matrix 3", $m3)    
    GUISetState()
EndFunc






;================== dispmat =============================
;Formats the input boxes in the resized Gui, and, displays the 2d array data (matrix).
; input -> $mainfrm = "Matrix 1" or "Matrix 2" or "Matrix 3";   $m = 2d array to be displayed.
;
Func dispmat($mainfrm, $m = 0)  
    If $m = 0 Then $m = NewMatrix($mainfrm)
    GUISetState (@SW_ENABLE,namerethndl($mainfrm))  
    dim $w2 = 0, $h3 = 0    
    ;====== for tooltips to work correctly individual inputbox handles are needed, and,
    ;        previous inputbox handles need to be deleted. 
    if $mainfrm = "Matrix 1" Then
                $xx = 0
                while $Run1[$xx] <> "" 
                    ;MsgBox(0,"",$Run1[$xx]& "   " & $xx)               
                    GUICtrlDelete($Run1[$xx])
                        
                    $xx += 1
                WEnd
    ElseIf $mainfrm = "Matrix 2" Then
                $xx = 0
                while $Run2[$xx] <> ""
                    GUICtrlDelete($Run2[$xx])
                    $xx += 1
                WEnd
    ElseIf $mainfrm = "Matrix 3" Then
                $xx = 0
                while $Run3[$xx] <> "" 
                    GUICtrlDelete($Run3[$xx])
                    $xx += 1
                WEnd            
    EndIf
    ; ===> End of previous inputbox handles deletion.   
    ; 
        Dim $Counter = 0, $WidthPos1 = -60, $HeightPos1 = 5, $r = UBound($m), $c = UBound($m, 2), $inputwidth = 60, $inputht = 20   
        ; --- set deciminal places ------
        If $decplaceval <> 0 and $opos <> 10 and $opos <> 11 Then         
            for $x = 0 to $r -1
                for $y = 0 to $c -1
                    If IsNumber($m[$x][$y]) Then $m[$x][$y] = Round($m[$x][$y], $decplaceval)
                Next            
            Next
        EndIf
        ;-------> end of set deciminal places------  
        ;MsgBox(0,"",$m[0][0] & "   " & $m[0][1] & "    row=" & $r)
        GUISetFont(9, 400, 0, "Tahoma") 
        for $x = 0 to $r -1
            for $y = 0 to $c -1
                $WidthPos1 += 65
                ;GUISetState (@SW_ENABLE,$mainfrm )
                if $mainfrm = "Matrix 1" Then            
                    $Run1[$Counter] = GUICtrlCreateInput( $m[$x][$y], $WidthPos1, $HeightPos1, 60, 20) ; , $inputwidth, $inputht)
                    ;MsgBox(0,"",$Run1[$Counter]& "   " & $Counter & "     data)] "& GUICtrlRead($Run1[$Counter] ));GUICtrlSetPos (-1, $WidthPos1, $HeightPos1, 60, 20)
                    GUICtrlSetTip(-1,"Row "& $x +1 & "   Column " & $y +1 & "   [Data: " & GUICtrlRead($Run1[$Counter], 0) & "]  Cell No. " & $counter+1 )
                ElseIf $mainfrm = "Matrix 2" Then
                    $Run2[$Counter] = GUICtrlCreateInput($m[$x][$y], $WidthPos1 , $HeightPos1, 60, 20)
                    GUICtrlSetTip(-1,"Row "& $x +1 & "   Column " & $y +1 & "   [Data: " & GUICtrlRead($Run2[$Counter], 0) & "]  Cell No. " & $counter+1 )
                ElseIf $mainfrm = "Matrix 3" Then
                    $Run3[$Counter] = GUICtrlCreateInput($m[$x][$y], $WidthPos1 , $HeightPos1, 60, 20)
                    GUICtrlSetTip(-1,"Row "& $x +1 & "   Column " & $y +1 & "   [Data: " & GUICtrlRead($Run3[$Counter], 0) & "]  Cell No. " & $counter+1 )
                EndIf   
                ;GUICtrlSetFont(-1, 9, 400, 0, "Tahoma")    
                $Counter += 1   
                If Mod($Counter, $c) = 0 Then            
                    $WidthPos1 -= 65 * $c
                    $HeightPos1 += 25            
                EndIf
            Next            
        Next
;MsgBox(0,"",$WidthPos1 & "=    $WidthPos1  "&  $HeightPos1 & "= $HeightPos1  " & Mod($Counter, $c) & "= Mod($Counter, $c)  "&$m[0][0] & "   " & $m[0][1] & "    row=" & $r) 
            
        if $mainfrm = "Matrix 1" then WinMove($matrix1, "", @DesktopWidth * 0.03, @DesktopHeight * 0.02, 65*($c)+11, $HeightPos1 + 46)
        if $mainfrm = "Matrix 2" then 
            $w2 = 65*($c)+11
            WinMove($matrix2, "", @DesktopWidth - $w2 - 5, @DesktopHeight * 0.04, 65*($c)+11, $HeightPos1+ 46)    
        EndIf   
        if $mainfrm = "Matrix 3" then 
            $h3 =  $HeightPos1 +46
            WinMove($matrix3, "", 20, @DesktopHeight - $h3 - 160, 65*($c)+11, $h3)    
        EndIf         
    EndFunc
    
Func NewMatrix($mainfrm)
    GUISetState (@SW_ENABLE,namerethndl($mainfrm ))
    $Notident = 0
    #Region ### START Koda GUI section ### Form=
    $Form1 = GUICreate("Auto-Fill Matrix", 396, 462, 193, 115)
    GUISetBkColor(0xECE9D8)
    $Input1 = GUICtrlCreateInput("1", 39, 157, 57, 28)
        GUICtrlSetTip($Input1, "e.g. enter 9 in Start No. and 7 in Last No."& @CRLF &"will genetate 9 8 7 9 8 7 9 ...until the matrix is filled. ")
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    $Input2 = GUICtrlCreateInput("2", 131, 157, 57, 28)
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    $Label1 = GUICtrlCreateLabel("Start No.", 32, 134, 96, 24)
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    $Label2 = GUICtrlCreateLabel("Last No.", 128, 134, 96, 24)
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    $Label3 = GUICtrlCreateLabel("Inclusive", 197, 156, 74, 24)
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    $Label4 = GUICtrlCreateLabel("OR", 98, 192, 30, 24)
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    $Checkbox1 = GUICtrlCreateCheckbox("Identity Matrix", 48, 224, 145, 17)
        GUICtrlSetTip($Checkbox1, "Enabled only if a square matrix "& @CRLF &"i.e. No. of Rows equals No. of Columns")
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    $Label5 = GUICtrlCreateLabel("Must be a square matrix", 48, 248, 168, 20)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    $but1gm = GUICtrlCreateButton("Generate Matrix", 248, 288, 124, 38, $BS_FLAT)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    GUICtrlSetBkColor(-1, 0xFF00FF)
    $Label6 = GUICtrlCreateLabel("OR", 101, 287, 30, 24)
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    $Checkbox2 = GUICtrlCreateCheckbox("Blank Matrix", 51, 319, 145, 17)
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    $Checkbox3 = GUICtrlCreateCheckbox("Matrix All Zeros", 51, 396, 145, 17)
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    $Label8 = GUICtrlCreateLabel("OR", 101, 364, 30, 24)
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    $Group1 = GUICtrlCreateGroup("New Matrix Size", 32, 8, 281, 113)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    $Label9 = GUICtrlCreateLabel("No. of Columns", 175, 52, 108, 20)
    $Label7 = GUICtrlCreateLabel("No. of Rows", 62, 50, 87, 20)
    $Input3 = GUICtrlCreateInput(0, 78, 71, 49, 28)
        GUICtrlSetTip($Input3, " Maximium size of matrix is No. of Rows multiplied by No. of Columns = 626")
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    $Input4 = GUICtrlCreateInput(0, 202, 71, 49, 28)
        GUICtrlSetTip($Input4, "Press Enter, Tab, Or click on another input box to enter data")
    GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
    GUICtrlCreateGroup("", -99, -99, 1, 1)
    GUISetState(@SW_SHOW)
    #EndRegion ### END Koda GUI section ###

    While 1
    $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $GUI_EVENT_CLOSE
                $m = 1
                ExitLoop

            Case $Input1
                ;ControlClick ( "Auto-Fill Matrix", "", $Input2) 
                
            Case $Input2
                ;ControlClick ( "Auto-Fill Matrix", "", $Input1) 
                
            Case $Checkbox1
                if GUICtrlRead  ( $Checkbox1) = $GUI_CHECKED then
                    GUICtrlSetState ($Checkbox3, $GUI_DISABLE)
                    GUICtrlSetState ($Checkbox2, $GUI_DISABLE)
                    GUICtrlSetState ($Input1, $GUI_DISABLE)
                    GUICtrlSetState ($Input2, $GUI_DISABLE)
                    
                Else
                    GUICtrlSetState ($Checkbox3, $GUI_ENABLE)
                    GUICtrlSetState ($Checkbox2, $GUI_ENABLE)
                    GUICtrlSetState ($Input1, $GUI_ENABLE)
                    GUICtrlSetState ($Input2, $GUI_ENABLE)          
                EndIf         
            
            Case $but1gm
                if IsInt ($Input3) and IsInt ($Input4) and GUICtrlRead  ($Input3)  > 0 and  GUICtrlRead  ($Input4) > 0 Then
                    $m = MatCreate(GUICtrlRead($Input3),  GUICtrlRead  ($Input4))
                    If GUICtrlGetState ($Input1) = 80 then 
                        if GUICtrlRead ($Input1) > 0 And GUICtrlRead ($Input2) > 0  Then
                            $counter = GUICtrlRead  ($Input1)
                            $min = $counter 
                            $max = GUICtrlRead  ($Input2)
                            $increm = 1
                            if $min > $max then $increm = -1
                        EndIf
                    EndIf      
                    for $x = 0 to GUICtrlRead  ($Input3) -1
                        for $y = 0 to GUICtrlRead  ($Input4) -1
                            If GUICtrlGetState ($Input1) = 80 then 
                                ;MsgBox(0,"",$counter & " $max" & $max) 
                                if GUICtrlRead ($Input1) >0 And GUICtrlRead ($Input2) > 0 Then                      
                                    $m[$x][$y] = $counter 
                                    if $counter = $max Then
                                        $counter = $min
                                    Else
                                        $counter = $counter + $increm
                                        ;MsgBox(0,"",$counter & "   " & $increm)
                                    EndIf
                                EndIf   
                            EndIf   
                            If GUICtrlRead ($Checkbox3) = $GUI_CHECKED then $m[$x][$y] = 0              
                            If GUICtrlRead ($Checkbox2) = $GUI_CHECKED then $m[$x][$y] = ""
                            If GUICtrlRead ($Checkbox1) = $GUI_CHECKED then 
                                If $x = $y Then
                                    $m[$x][$y] = 1
                                Else
                                    $m[$x][$y] = 0
                                EndIf
                            EndIf                        
                        Next
                    Next    
                    $filename = "Untitled"
                    ExitLoop
                EndIf            
            
            Case $Checkbox2    
                if GUICtrlRead  ( $Checkbox2) = $GUI_CHECKED then
                    GUICtrlSetState ($Checkbox3, $GUI_DISABLE)
                    GUICtrlSetState ($Checkbox1, $GUI_DISABLE)
                    GUICtrlSetState ($Input1, $GUI_DISABLE)
                    GUICtrlSetState ($Input2, $GUI_DISABLE)     
                Else
                    GUICtrlSetState ($Checkbox3, $GUI_ENABLE)
                    if $Notident = 0 then GUICtrlSetState ($Checkbox1, $GUI_ENABLE)
                    GUICtrlSetState ($Input1, $GUI_ENABLE)
                    GUICtrlSetState ($Input2, $GUI_ENABLE)          
                EndIf
                
            Case $Checkbox3
                if GUICtrlRead  ( $Checkbox3) = $GUI_CHECKED then
                    GUICtrlSetState ($Checkbox1, $GUI_DISABLE)
                    GUICtrlSetState ($Checkbox2, $GUI_DISABLE)
                    GUICtrlSetState ($Input1, $GUI_DISABLE)
                    GUICtrlSetState ($Input2, $GUI_DISABLE)     
                Else
                    if $Notident = 0 then GUICtrlSetState ($Checkbox1, $GUI_ENABLE)
                    GUICtrlSetState ($Checkbox2, $GUI_ENABLE)
                    GUICtrlSetState ($Input1, $GUI_ENABLE)
                    GUICtrlSetState ($Input2, $GUI_ENABLE)          
                EndIf            
            
            Case $Input3
                ;ControlClick ( "Auto-Fill Matrix", "", $Input3)                
                if GUICtrlRead  ($Input3) = GUICtrlRead  ($Input4) Then
                    GUICtrlSetState ($Checkbox1, $GUI_ENABLE)
                    $Notident = 0
                else 
                    GUICtrlSetState ($Checkbox1, $GUI_DISABLE)
                    $Notident = 1
                EndIf
                if IsInt ($Input3) and IsInt ($Input4) and GUICtrlRead  ($Input3) > 0 and  GUICtrlRead  ($Input4) > 0 Then
                    GUICtrlSetData($Input1, 1)
                    GUICtrlSetData($Input2, GUICtrlRead  ($Input3) * GUICtrlRead  ($Input4))
                EndIf
                ;ControlClick ( "Auto-Fill Matrix", "", $Input4)
                
            Case $Input4                
                if GUICtrlRead  ($Input3) = GUICtrlRead  ($Input4) Then
                    GUICtrlSetState ($Checkbox1, $GUI_ENABLE)
                    $Notident = 0
                else 
                    GUICtrlSetState ($Checkbox1, $GUI_DISABLE)
                    $Notident = 1
                EndIf
                if IsInt ($Input3) and IsInt ($Input4) and GUICtrlRead  ($Input3) > 0 and  GUICtrlRead  ($Input4) > 0 Then
                    GUICtrlSetData($Input1, 1)
                    GUICtrlSetData($Input2, GUICtrlRead  ($Input3) * GUICtrlRead  ($Input4))
                EndIf   
                ;ControlClick ( "Auto-Fill Matrix", "", $Input3)
                
        EndSwitch
    WEnd    
    DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $Form1, "int", 10, "long", 0x00090000);fade-out   
    
    return  $m
    ;GUIDelete($Form1);    ; will return 1
EndFunc 

Func expandabbrev($mainfrm)
    Local $n
    If StringLeft($mainfrm,1) & StringRight($mainfrm,1) = "M1" Then $n = "Matrix 1"
    If StringLeft($mainfrm,1) & StringRight($mainfrm,1) = "M2" Then $n = "Matrix 2"
    If StringLeft($mainfrm,1) & StringRight($mainfrm,1) = "M3" Then $n = "Matrix 3"
    return $n
EndFunc 

; Name variable return Handle
Func namerethndl($mainfrm)
    Local $n
    If $mainfrm = "Matrix 1" Then $n = $matrix1
    If $mainfrm = "Matrix 2" Then $n = $matrix2
    If $mainfrm = "Matrix 3" Then $n = $matrix3
    return $n
EndFunc 

Func mxretmat($mainfrm)
    Local $n
    If StringLeft($mainfrm,1) & StringRight($mainfrm,1) = "M1" Then $n = $m1
    If StringLeft($mainfrm,1) & StringRight($mainfrm,1) = "M2" Then $n = $m2
    If StringLeft($mainfrm,1) & StringRight($mainfrm,1) = "M3" Then $n = $m3
    If $mainfrm = $tempm Then
        Return $tempm
    Else
        return $n
    EndIf
EndFunc 

; Save matrix to disk. csv file extension
Func savemat($mainfrm, $m)
    GUISetState (@SW_ENABLE,$mainfrm )
    $Pathfile = FileSaveDialog( "Choose a name.",@WorkingDir,"Comma-Separated Variables files (*.csv)|All (*.*)",8) 
    If @error Then
        ;MsgBox(4096,"","No File(s) chosen") 
        $p = 1
        return $p
        ;MsgBox(0,"return -1", $p)
    EndIf
    dim $r = UBound($m), $c = UBound($m, 2)
    
    if StringRight($Pathfile,4) <> ".csv" then $Pathfile = $Pathfile & ".csv"
        $filename = StringTrimLeft($Pathfile,StringLen(@WorkingDir)+1)  
        $hfile = FileOpen($Pathfile, 2)
        $Line = ""
        $Counter = 0
        for $x = 0 to $r -1
            for $y = 0 to $c -1
                if $mainfrm = "Matrix 1" Then 
                    $COMMALESS = StringReplace (GUICtrlRead($run1[$Counter]),",","{COMMA}")     
                    $Line = $Line & $COMMALESS & ","
                EndIf
                if $mainfrm = "Matrix 2" Then 
                    $COMMALESS = StringReplace (GUICtrlRead($run2[$Counter]),",","{COMMA}")     
                    $Line = $Line & $COMMALESS & ","
                EndIf   
                if $mainfrm = "Matrix 3" Then 
                    $COMMALESS = StringReplace (GUICtrlRead($run3[$Counter]),",","{COMMA}")     
                    $Line = $Line & $COMMALESS & ","
                EndIf                  
                $Counter += 1
            Next
            FileWriteLine($hfile, StringTrimRight($Line,1) & @CRLF)
            $Line = ""
        next                
        FileClose($hfile)
        $p = 0
        ;MsgBox(0,"End", $p)
        Return $p      
EndFunc
    
; Open file stored on disk.  csv file extension
;  $Pathfile - path and name of file to be opened
; If $Pathfile not supplied, FileOpenDialog will allow the choosing a file to be open.
Func fileop($Pathfile = "") 
    If $Pathfile = "" Then    
        $Pathfile = FileOpenDialog( "Choose a name.",@WorkingDir,"Comma-Separated Variables files (*.csv)|All (*.*)",8)
    EndIf      
    If @error Then
        ;MsgBox(4096,"","No File(s) chosen") 
        $m = 1
        return $m
    EndIf
    $filename = StringTrimLeft($Pathfile,StringLen(@WorkingDir)+1)
    $hfile = FileOpen($Pathfile, 0)
    $colcount = 1
    $line = FileReadLine($hfile)
    for $ch = 1 to StringLen($line)
        if StringMid($line, $ch,1) = "," then $colcount += 1    
            ;MsgBox(0,"","rowcount "& $rowcount & "      colcount " & $colcount)            
    next
    $rowcount = 1
    While 1 
        $line = FileReadLine($hfile)
        If @error = -1 Then ExitLoop    
        $rowcount += 1
    Wend
    ;MsgBox(0,"","rowcount "& $rowcount & "      colcount " & $colcount)
    FileClose($hfile)
    $m = MatCreate($rowcount, $colcount)
    ;MsgBox(0,"","$rowcount=" & $rowcount & "  $colcount="  & $colcount)
    $hfile = FileOpen($Pathfile, 0)
    for $x = 0 to $rowcount - 1
        $line = StringSplit (FileReadLine($hfile),",")
        for $y = 0 to $colcount - 1 
            $m[$x][$y] = StringReplace ($line[$y+1],"{COMMA}",",")      
          ;MsgBox(0,"","$x=" & $x & "  $y="  & $y &  "  $m[$x][$y]=" & $m[$x][$y] )            
        Next        
    next    
    FileClose($hfile)
     return $m
 EndFunc
 
 
;Randomize existing data in in array (matrix)   
Func RandomizeMatrixData($m)
    ; Shuffle
    Dim $irow= UBound($m), $icol = UBound($m, 2)    
        for $loop5 = 1 to 5
        For $x = 0 To $irow - 1 
           for $y = 0 to $icol -1
                $c = $m[$x][$y]                   ; swap
                $rx = Random (0,($irow -1),1)     ; Random x index
                $ry = Random (0,($icol -1),1)     ; Random y index
                $m[$x][$y] = $m[$rx][$ry]         ; swap
                $m[$rx][$ry] = $c                 ; final swap            
            Next
        Next    
        next
    return $m
EndFunc
 
;==== What is seen on screen are the numbers used in the maths operations. Refresh Array  (refresh matrix)  
Func refreshmat($m, $mainfrm)
    GUISetState (@SW_ENABLE,$mainfrm )  
    dim $r = UBound($m), $c = UBound($m, 2) 
    consolewrite( 'refresh  $r ' & $r & '   $C =' &  $c & '  $mainfrm =' & $mainfrm &@CRLF)
    Dim $n[$r][$c]
    $Counter = 0
    for $x = 0 to $r -1
        for $y = 0 to $c -1
            if $mainfrm = "Matrix 1" Then         
                $n[$x][$y]  = GUICtrlRead($run1[$Counter])  
                if $n[$x][$y] <> $m[$x][$y] then $Matname1 = "Untitled"
            EndIf
            if $mainfrm = "Matrix 2" Then         
                $n[$x][$y]  = GUICtrlRead($run2[$Counter])  
                if $n[$x][$y] <> $m[$x][$y] then $Matname2 = "Untitled"
            EndIf   
            if $mainfrm = "Matrix 3" Then         
                $n[$x][$y]  = GUICtrlRead($run3[$Counter])  
                if $n[$x][$y] <> $m[$x][$y] then $Matname3 = "Untitled"
            EndIf   
            $Counter += 1
        Next        
    next    
    Return $n      
EndFunc

;====================================================
; Returns the Handle of GUI the mouse is over.
;http://www.autoitscript.com/forum/index.php?s=&showtopic=19370&view=findpost&p=444962
;   
Func GetHoveredHwnd()
    Local $iRet = DllCall("user32.dll", "int", "WindowFromPoint", "long", MouseGetPos(0), "long", MouseGetPos(1))
    If IsArray($iRet) Then 
        ;MsgBox(0,"",$iRet[0] & "    " & $iRet[1] & "    " & $iRet[2] & "    " & HWnd($iRet[0] ))
        Return  HWnd($iRet[0])
    else
        Return SetError(1, 0, 0)
    EndIf
EndFunc

;chkisnum(input variable )  check if number allows "-" and "." and not an array  Output 0 if not a number or 1 is number
func chkisnum($a)
    dim $fL = 1
    if  not(IsArray($a)) then
        for $cpos = 1 to StringLen($a)
            If StringIsDigit(StringMid ( $a, $cpos  ,1 )) Or StringMid ( $a, $cpos  ,1 ) = "." or StringMid ( $a, $cpos  ,1 ) = "-" Then
                ;consolewrite('$cpos =' & $cpos  & '    chkisnum= ' & StringMid ( $a, $cpos  ,1 ) &  @CRLF)
                ;$fL  = 1
            Else
                ;consolewrite('$cpos =' & $cpos  & '    chkisnum= ' & StringMid ( $a, $cpos  ,1 ) &  @CRLF)
                $fL  = 0
            EndIf
        next
    Else
        $fL  = 0
    EndIf
    Return $fL  
EndFunc
;======================================================

; Will allow left mouse button drag on the gui. Also, when the gui height is greater than the screen
;  left clicking on the gui raises the gui to view bottom cells. 
 ; Drag Window 3 of 3 addin
Func _WinMove($HWnd, $Command, $wParam, $lParam)
     If BitAND(WinGetState($HWnd), 32) Then Return $GUI_RUNDEFMSG
    ;DllCall("user32.dll", "long", "SendMessage", "hwnd", $HWnd, "int", @DesktopWidth_SYSCOMMAND, "int", 0xF009, "int", 0)
    dllcall("user32.dll","int","SendMessage","hWnd", $HWnd, "int",$WM_LBUTTONDOWN,"int", $HTCAPTION,"int", 0)
    $pos = WinGetPos($HWnd)
    if @DesktopHeight - $pos[3] < 0   Then WinMove ( $HWnd, "", $pos[0],  $pos[1] + (-50 * (((@DesktopHeight - $pos[1] - $pos[3]-50) <= 0) And ($pos[1] <= 0))))

EndFunc

Func enterkey()
$nMsg = $linButok
;MsgBox(0,"","enter")
EndFunc 

 ;=============== Basic Command line  ===================================
 ;rest of script is the calculator function
;return the calculation result of  $stringin
;very little error checking, just a sample to show a way to make a calculator
Func calculate($stringin)    
    $stringin = StringReplace($stringin,'^','**')
    ;$stringin = StringReplace($stringin,'#','+')   
    $stringtocalc = $stringin & '='
    $splitcalc = StringSplit($stringtocalc,"")
    $pp = 1   
    Return compute(0)   
EndFunc 

Func  Commandline()
    $linecalcgui = GUICreate("Line Calculator", 523, 200, 347, 263, BitOR($WS_MAXIMIZEBOX,$WS_MINIMIZEBOX,$WS_SYSMENU,$WS_CAPTION,$WS_POPUP,$WS_POPUPWINDOW,$WS_GROUP,$WS_TABSTOP,$WS_BORDER,$WS_CLIPSIBLINGS))
GUISetIcon("D:\003.ico")
$linButok = GUICtrlCreateButton("&OK", 79, 171, 75, 25, 0)
$linButcan = GUICtrlCreateButton("&Cancel", 306, 169, 75, 25, 0)
$lineEdit = GUICtrlCreateEdit("", -2, -2, 525, 141,  BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL,$WS_BORDER))
GUICtrlSetData(-1, ' Enter the line calculation below, ( Copy/Paste examples further down)'  &  @CRLF &  @CRLF ) 
_GUICtrlEdit_AppendText ($lineEdit , ' Allowed operators and functions :-, ' &  @CRLF &  @CRLF  )
_GUICtrlEdit_AppendText ($lineEdit , ' Common operators :-, ' &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit , '  * ,  / , + , - , ^ , ( ,  ) . mod(num, modulus)' &  @CRLF &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit , ' Trigonometry operators :-' &  @CRLF  )
_GUICtrlEdit_AppendText ($lineEdit , ' sin(degrees), cos(degrees), tan(degrees),  ' &  @CRLF  )
_GUICtrlEdit_AppendText ($lineEdit , ' asin(degrees), acos(degrees), atan(degrees), pi ' &  @CRLF &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit ,' Matrices operators :-' &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit ,' All common operators work on the Matrices m1, m2, m3,' &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit ,' trn(matrix)  Transpose a matrix - rows and columns swap,  ' &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit ,' ^e  all elements of a matrix to the power of  ' &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit ,' det(matrix) Determinant, ' &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit ,' utr(matrix) Upper Triangle, ' &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit ,' minv(matrix or number, m) multiplicative inverse of a,  Modulus m.  '  &  @CRLF  &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' Other :- ' &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit ,' gcd( $a, $b) Greatest Common Denominator,' &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit ,' Prim($a) Return Factors or is Prime' &  @CRLF &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' Examples (Can be copy/paste to command line) :- ' &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit ,' ((45- 3^2.6)/17)*cos(23.7)*Mod(12^4,5) '  &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,'  m1*m1=m2   To display a matrix result enter =m1 ,=m2, or, =m3 ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' 1/m1=m2  or  m1^-1=m3  Inverse of matrix     ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' m1/m1=m2  or  m1*m1^-1=m3  Identity matrix is the result ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,'      The inverse of a matrix = (1/determinant) * adjoint    ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,'       So, the adjoint = the inverse * determinant     ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' m1^-1*det(m1)=m3    is the Adjoint      ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' (2+m1)/4=m2 and 2+m1/4=m3 give different results.   ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' m1-trn(m1)=m3   A matrix minus the transpose of the matrix.  ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' utr(m1)=m2  Upper Triangle      ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' trn(utr(m1))=m3  Upper Triangle transposed    ' &  @CRLF &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' m1^e2.5=m2  Each element in m1 to the 2.5 power. Note :- If an     ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,'    element cotains a negative number and the power has a deciminal  ' &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit ,'    part, the answer is a complex number for that element. ' &  @CRLF )
_GUICtrlEdit_AppendText ($lineEdit ,' m1^4=m2  Same as m1*m1*m1*m1  Power must be an integer only.  ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' mod(m2,97)=m2  Matrix m2 mod 97  ' &  @CRLF &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' Encrypt m2 Which contains whole, positive numbers, say ASCII values.      ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' m1 contains whole, positive random numbers, but must be square, the key.      ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' The modulus should be a prime number. 97 is used in this formula.    ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' mod(m1*m2,97)=m3  Encrypted m2 is displayed in m3     ' &  @CRLF &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' To decrypt the code in m3 matrix use      ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' mod((minv(m1,97)*m3),97)=m3  Now, m3 contains decryption to compare to m2   ' &  @CRLF &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' mod((m1*minv(m1,97)),97)=m2  Shows that the mod of a matrix multiplied       ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,'   by its multiplicative inverse (with same modulus) = an identity matrix' &  @CRLF &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' (sin(40))^2 + (cos(40))^2    This result should = 1 ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' cos(60)/sin(30)            This result should = 1' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' asin(sin(30))    acos(cos(40))   atan(tan(50))   pi ' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,' (3^2+4^2)^0.5   Hypotenuse, other 2 sides are 3 and 4.' &  @CRLF)
_GUICtrlEdit_AppendText ($lineEdit ,'     ' &  @CRLF)

GUICtrlSetColor(-1, 0x000080)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xA6CAF0)
$commandInput = GUICtrlCreateInput("M2 * 2 + 1 = M3", 8, 142, 507, 24, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUISetState(@SW_SHOW)

    ;MsgBox(0,antilog(Log($String)),Exp(Log($string)))
    GUISetState(@SW_SHOW)
EndFunc


func compute($rank);
    Local  $mtt,$tem1,$tem2,$tem3,$pnum2,$bracketset
consolewrite('@start compute rank= ' & $rank &  '    $tem1 =' &  $tem1 & '  $tem2 =' &  $tem2  & '  $mtt =' &  $mtt & '  $pp =' & $pp & " of " & $splitcalc[0] &  @CRLF)
    $tem1=0;
    ;$tem2=0;
    $bracketset=0

    while(True)
        $pp += 1;
        Switch $splitcalc[$pp-1]
            Case ' '
                ;ignore
                
            Case 'G'  ;gcd?
                ConsoleWrite('got the g for gcd' &@CRLF)
                If StringMid($stringtocalc,$pp - 1,3) = "GCD" then
                    $pp += 2
                    $temg = compute( 3)
                    $pp += 1
                    $tem1 = compute( 3)                    
                    If not(IsArray($tem1)) And not(IsArray($temg)) Then $tem1 = gcd($temg, $tem1);
                    $temg = ""
                EndIf
                $pp += 1
                
            Case 'M'  ;Mod
                
                If StringMid($stringtocalc,$pp - 1,3) = "MOD" then
                    $pp += 2
                    $temg = compute( 3)
                    $pp += 1
                    $tem1 = compute( 3)
                    consolewrite( ' mod StringLeft ($tem1,1) =' & StringLeft ($tem1,1) & '  StringLeft ($temg,1)) =' &  StringLeft ($temg,1) &'   chkisnum($tem1) ' & chkisnum($tem1) & '  chkisnum($temg) =' &  chkisnum($temg) & @CRLF)
                    If chkisnum($tem1) And chkisnum($temg) Then 
                        $tem1 = Mod($temg, $tem1)
                    ElseIf IsArray($tem1) Then  
                        consolewrite( '3*  $temg ' & $temg & '$tem1 =' &  $tem1 & @CRLF)
                        $tem1 = " Modulus can not be an array"
                        $mf = 0 
                    elseIf  IsArray($temg) and chkisnum($tem1) Then              
                        consolewrite( ' 7*  $temg ' & $temg & '$tem1 =' &  $tem1 &  @CRLF)  
                        $decplaceval = 8
                        $tem1 = _arraymod($temg, $tem1)
                        $decplaceval = 0
                        $mf = 2  
                    EndIf
                    $pp += 1
                ElseIf StringMid($stringtocalc,$pp - 1,4) = "MINV" then      
                    $pp += 3
                     $temg = compute( 3)
                    $pp += 1
                    $tem1 = compute( 3)
                     consolewrite( ' minv StringLeft ($tem1,1) =' & StringLeft ($tem1,1) & '  StringLeft ($temg,1)) =' &  StringLeft ($temg,1) &'   chkisnum($tem1) ' & chkisnum($tem1) & '  chkisnum($temg) =' &  chkisnum($temg) & @CRLF)     
                    If chkisnum($tem1) And chkisnum($temg) Then  
                        $tem1 = Multinv($temg, $tem1)
                    elseIf  IsArray($temg) and chkisnum($tem1) Then              
                        consolewrite( ' minv2  $temg ' & $temg & '$tem1 =' &  $tem1 &  @CRLF)   
                        $tem1 = matrixInv($temg, $tem1)
                        $mf = 2  
                    EndIf   
                    $pp += 1
                    $temg = ""
                ElseIf StringMid($stringtocalc,$pp - 1,2) = "M1" then   
                    ConsoleWrite('got the M1' &@CRLF)
                    $pp += 1
                    $tem1 = $m1     
                ElseIf StringMid($stringtocalc,$pp - 1,2) = "M2" then   
                    ConsoleWrite('got the M2' &@CRLF)
                    $pp += 1
                    $tem1 = $m2 
                ElseIf StringMid($stringtocalc,$pp - 1,2) = "M3" then   
                    ConsoleWrite('got the M3' &@CRLF)
                    $pp += 1
                    $tem1 = $m3      
                EndIf   
                 If $pp < $splitcalc[0] Then
                    while( $splitcalc[$pp] = '.') or StringIsDigit($splitcalc[$pp])
                        $pp += 1;
                    WEnd
                EndIf
                
             Case 'P'  ;Prim                
                If StringMid($stringtocalc,$pp - 1,4) = "PRIM" then
                    ConsoleWrite('got the p for Prim' &@CRLF)
                    $pp += 3                   
                    $tem2 = compute( 3);
                    If not(IsArray($tem1)) Or not(IsArray($temg)) Then
                        $tem1 = Prim($tem2 );
                        If  $tem2 = number( $tem1) Then
                            $tem1 = "The number " &$tem1 & " is a prime number"
                        Else
                            $tem1 = "The factors of " & $tem2 & " are " & $tem1
                        EndIf
                    EndIf
                ElseIf ($splitcalc[$pp] = 'I') then 
                    $tem1 = $PI;
                    $pp += 1;
                EndIf   
                
            Case 'S'  ;sin?
                ConsoleWrite('got the s for sin' &@CRLF)
                If StringMid($stringtocalc,$pp - 1,3) = "SIN" then
                    $pp += 2                   
                    If not(IsArray($tem1))  Then $tem1 = sin($pifactor * compute( 3));
                EndIf
                    
            Case 'D'; Determinant?
                If StringMid($stringtocalc,$pp - 1,3) = "DET" then ; Determinant
                    $pp += 2
                    $tem3 = compute(3)  
                    consolewrite(' Determinant rank= ' & $rank & '$tem1 =' &  $tem1 & '  $tem3 =' &  $tem3 & '  $pp ' & $pp & "   char = " &  $splitcalc[$pp] &  @CRLF)
                    If IsArray($tem3)  Then 
                        $tem1 = Round(_DetMatrix($tem3 ),10)
                        $mf = 0 
                    EndIf      
                EndIf
                
            Case 'U'; Upper Triangle?
                If StringMid($stringtocalc,$pp - 1,3) = "UTR" then ; Upper Triangle
                    $pp += 2
                    $tem3 = compute(3)  
                    consolewrite('  Upper Triangle = ' & $rank & '$tem1 =' &  $tem1 & '  $tem3 =' &  $tem3 & '  $pp ' & $pp & "   char = " &  $splitcalc[$pp] &  @CRLF)
                    If IsArray($tem3)  Then 
                        $tem1 = upperTriangle($tem3 )
                        $tem1 = upperTriangle($tem1 )
                        $mf = 1 
                    EndIf      
                EndIf   
                
               
           Case 'T'; Transpose,  tan?
                If StringMid($stringtocalc,$pp - 1,3) = "TRN" then ; Transpose
                    $pp += 2
                    $tem3 = compute(3)  
                    consolewrite(' Transpose rank= ' & $rank & '$tem1 =' &  $tem1 & '  $tem3 =' &  $tem3 & '  $pp ' & $pp & "   char = " &  $splitcalc[$pp] &  @CRLF)
                    If IsArray($tem3)  Then 
                        $tem1 = matrixTranspose($tem3 )
                        If $mf = 0 Then $mf = 1
                    EndIf
                ElseIf StringMid($stringtocalc,$pp - 1,3) = "TAN" then
                    $pp += 2
                    If not(IsArray($tem1)) Then $tem1 = Tan($pifactor * compute( 3));
                EndIf
                If $pp < $splitcalc[0] Then
                    while( $splitcalc[$pp] = '.') or StringIsDigit($splitcalc[$pp])
                        $pp += 1;
                    WEnd
                EndIf
               
            Case 'A'
                If StringMid($stringtocalc,$pp - 1,4) = "ATAN" then
                    $pp += 3;
                    If not(IsArray($tem1)) Then $tem1 = atan(compute( 3))/$pifactor;
                elseif  StringMid($stringtocalc,$pp - 1,4) = 'ASIN' then                   
                    $pp += 3;
                    ConsoleWrite('at arcsin pp = ' & $splitcalc[$pp] & @CRLF)   
                    If not(IsArray($tem1))  Then $tem1 = ASin(compute( 3))/$pifactor;
                elseif (StringMid($stringtocalc,$pp - 1,4) = 'ACOS')  then
                    $pp += 3
                    If not(IsArray($tem1)) Then $tem1 = ACos(compute( 2))/$pifactor;
                EndIf
                If $pp < $splitcalc[0] Then
                    while( $splitcalc[$pp] = '.') or StringIsDigit($splitcalc[$pp+1])
                        $pp += 1; {get past the Add bit}
                    WEnd
                EndIf
               
            
            Case 'C';cos?               
                if  StringMid($stringtocalc,$pp - 1,3) = 'COS' then
                    $pp += 2
                    If not(IsArray($tem1)) Then $tem1 = cos($pifactor * compute( 2));
                EndIf
                
            Case '('
                consolewrite(' ( rank= ' & $rank & '$tem =' &  $tem1 & '  $tem2 =' &  $tem2 & '  $pp ' & $pp &  @CRLF)
                $bracketset = 1;
                $tem1 = compute( 0);
                
            Case ')'
                consolewrite(' )1 rank= ' & $rank & '$tem1 =' &  $tem1 & '  $tem2 =' &  $tem2 & '  $pp ' & $pp & "   char = " &  $splitcalc[$pp] &  @CRLF)
                if ($bracketset = 1) then
                    $bracketset = 0
                else
                    consolewrite(' )2 rank= ' & $rank & '$tem1 =' &  $tem1 & '  $tem2 =' &  $tem2 & '  $pp ' & $pp & "   char = " &  $splitcalc[$pp] &  @CRLF)
                    $pp -= 1
                    $result = $tem1;
                    Return $result                
                EndIf
                
            Case '/'
                if ($rank >= 2) then
                    $pp -= 1;
                    $result = $tem1;
                    Return $result
                else
                    $tem2 = compute( 2);
                    if $tem2 = "0" then
                        MsgBox(0,'Error','divide by 0!');
                        $divzero = True;
                        $result = 0;
                        Return $result;
                    else
                        consolewrite( ' / StringLeft ($tem1,1) =' & StringLeft ($tem1,1) & '  StringLeft ($tem2,1)) =' &  StringLeft ($tem2,1) &'   chkisnum($tem1) ' & chkisnum($tem1) & '  chkisnum($tem2) =' &  chkisnum($tem2) & @CRLF)
                        If chkisnum($tem1) And chkisnum($tem2) Then 
                            $tem1 = $tem1 / $tem2;
                        ElseIf IsArray($tem1) And IsArray($tem2) Then   
                            consolewrite( '3*  $tem2 ' & $tem2 & '$tem1 =' &  $tem1 & @CRLF)
                            $tem1 = ArrayProduct($tem1,matrixInv($tem2))
                            If $mf = 0 Then $mf = 1
                        elseIf  IsArray($tem1) and chkisnum($tem2)  Then       
                            consolewrite( '5*  $tem2 ' & $tem2 & '$tem1 =' &  $tem1 &  @CRLF)   
                            $tem1 = _arrayScalarProduct($tem1, 1/$tem2) 
                            $mf = 1
                        elseIf  IsArray($tem2) and chkisnum ($tem1) Then       
                            consolewrite( ' 7*  $tem2 ' & $tem2 & '$tem1 =' &  $tem1 &  @CRLF)  
                            $tem1 = _arrayScalarProduct(matrixInv($tem2), $tem1)
                            If $mf = 0 Then $mf = 1    
                        EndIf
                        ;$pp += 1
                    EndIf
                EndIf
                
            Case '*'   
                consolewrite( ' * start  $pp ' & $pp & '$tem1 =' &  $tem1 &  @CRLF) 
                If StringMid($stringtocalc,$pp - 1,3) = "**E" then  ;^E each element in matrix to power
                     $pp += 2;point to exp
                    If $splitcalc[$pp] = '-'  Then
                        $pp += 1
                        $tem2 = -compute(4)      
                    ElseIf $splitcalc[$pp] = '+'  Then
                        $pp += 1
                        $tem2 = compute(4)
                    Else
                        $tem2 = compute(4);
                    EndIf
                    ;If StringIsDigit ($tem1) And StringIsDigit ($tem2) Then 
                    ConsoleWrite(' powerE  $tem1 =' & $tem1 & '        $tem2 =' &  $tem2 &' $pp= ' & $splitcalc[$pp] & @CRLF)
                    If chkisnum($tem1) Then 
                        $tem1 = "the ^e operand only works on a matrix"
                        $mf = 0
                        ;$tem1 = Power($tem1,$tem2)
                    ElseIf IsArray($tem2) Then  
                        $tem1 = "To the power of a matrix is not allowed."
                        $mf = 0     
                    elseIf  IsArray($tem1) and chkisnum($tem2)  Then       
                        consolewrite( 'm s powerE  $tem2 ' & $tem2 & '$tem1 =' &  $tem1 &  @CRLF)                     
                        $tem1 = matrixelementpower($tem1, $tem2)    
                        If $mf = 0 Then $mf = 1  
                    EndIf   
                
                ElseIf $splitcalc[$pp] = '*' then ; ^ the matrix as a whole to the power of (an integer)
                    ;exponent required
                    $pp += 1;point to exp
                    ConsoleWrite('actual for power = ' & $splitcalc[$pp] & @CRLF)
                    If $splitcalc[$pp] = '-'  Then
                        $pp += 1
                        $tem2 = -compute(4)      
                    ElseIf $splitcalc[$pp] = '+'  Then
                        $pp += 1
                        $tem2 = compute(4)
                    Else
                        $tem2 = compute(4);
                    EndIf
                    ;If StringIsDigit ($tem1) And StringIsDigit ($tem2) Then 
                    ConsoleWrite(' power  $tem1 =' & $tem1 & '        $tem2 =' &  $tem2 &' $pp= ' & $splitcalc[$pp] & @CRLF)
                    If chkisnum($tem1) And chkisnum($tem2) Then 
                        $tem1 = Power($tem1,$tem2)
                    ElseIf IsArray($tem2) Then  
                        $tem1 = "To the power of a matrix is not allowed."
                        $mf = 0     
                    elseIf  IsArray($tem1) and chkisnum($tem2)  Then       
                        consolewrite( 'm s power  $tem2 ' & $tem2 & '$tem1 =' &  $tem1 &  @CRLF)    
                        If $tem2 -int($tem2) = 0 Then
                            $tem1 = matrixpower($tem1, $tem2)   
                            $mf = 1
                        Else
                            $tem1 = "For a matrix the power must be an integer only."
                            $mf = 0
                        EndIf         
                    EndIf   
                    
                else     
                    if ($rank >= 3) then
                        $pp -= 1;
                        $result = $tem1;
                        Return $result;                    
                    else
                        $mtt = compute( 3);    
                        consolewrite( '* StringLeft ($tem1,1) =' & StringLeft ($tem1,1) & '  StringLeft ($mtt,1)) =' &  StringLeft ($mtt,1) &'   chkisnum($tem1) ' & chkisnum($tem1) & '  chkisnum($mtt) =' &  chkisnum($mtt) & @CRLF)
                        If chkisnum($tem1) And chkisnum($mtt) Then 
                            $tem1 = $tem1 * $mtt;
                        ElseIf IsArray($tem1) And IsArray($mtt) Then    
                            consolewrite( '3*  $mtt ' & $mtt & '$tem1 =' &  $tem1 & @CRLF)
                            $tem1 = ArrayProduct($tem1,$mtt)
                            $mf = 1
                        elseIf  IsArray($tem1) and chkisnum($mtt)  Then              
                            consolewrite( '5*  $mtt ' & $mtt & '$tem1 =' &  $tem1 &  @CRLF) 
                            $tem1 = _arrayScalarProduct($tem1, $mtt)    
                            $mf = 1
                        elseIf  IsArray($mtt) and chkisnum($tem1) Then                     
                            consolewrite( ' 7*  $mtt ' & $mtt & '$tem1 =' &  $tem1 &  @CRLF)    
                            $tem1 = _arrayScalarProduct($mtt, $tem1)
                            $mf = 1  
                        EndIf
                    EndIf
                EndIf   
           
            Case '+'
                if ($rank >= 1) then
                    $pp -= 1;
                    $result = $tem1;
                    Return $result
                else
                    $mtt = compute(1);        
                    consolewrite( ' + StringLeft ($tem1,1) =' & StringLeft ($tem1,1) & '  StringLeft ($mtt,1)) =' &  StringLeft ($mtt,1) &'   chkisnum($tem1) ' & chkisnum($tem1) & '  chkisnum($mtt) =' &  chkisnum($mtt) & @CRLF)
                    If chkisnum($tem1) And chkisnum($mtt) Then 
                        $tem1 = $tem1 + $mtt;
                    ElseIf IsArray($tem1) And IsArray($mtt) Then    
                        consolewrite( '3*  $mtt ' & $mtt & '$tem1 =' &  $tem1 & @CRLF)
                        $tem1 = matrixplusmatrix($tem1, $mtt)
                        $mf = 1
                    elseIf  IsArray($tem1) and chkisnum($mtt)  Then              
                        consolewrite( '5*  $mtt ' & $mtt & '$tem1 =' &  $tem1 &  @CRLF) 
                        $tem1 = arrayplusScalar($tem1, $mtt)    
                        $mf = 1
                    elseIf  IsArray($mtt) and chkisnum($tem1) Then                     
                        consolewrite( ' 7*  $mtt ' & $mtt & '$tem1 =' &  $tem1 &  @CRLF)    
                    $tem1 = arrayplusScalar($mtt, $tem1)
                        $mf = 1  
                    EndIf
                EndIf;
               
            Case '-';
                consolewrite(' - rank= ' & $rank & '$tem =' &  $tem1 & '  $tem2 =' &  $tem2 & '  $pp ' & $pp &  @CRLF)
                if ($rank >= 1) then
                    $pp -= 1
                    $result =  $tem1;
                    Return $result
                else
                    $mtt = compute(1);        
                    consolewrite( ' - StringLeft ($tem1,1) =' & StringLeft ($tem1,1) & '  StringLeft ($mtt,1)) =' &  StringLeft ($mtt,1) &'   chkisnum($tem1) ' & chkisnum($tem1) & '  chkisnum($mtt) =' &  chkisnum($mtt) & @CRLF)
                    If chkisnum($tem1) And chkisnum($mtt) Then 
                        $tem1 = $tem1 - $mtt;
                    ElseIf IsArray($tem1) And IsArray($mtt) Then    
                        consolewrite( '3*  $mtt ' & $mtt & '$tem1 =' &  $tem1 & @CRLF)
                        $tem1 = matrixminusmatrix($tem1,$mtt)
                        $mf = 1
                    elseIf  IsArray($tem1) and chkisnum($mtt)  Then              
                        consolewrite( '5*  $mtt ' & $mtt & '$tem1 =' &  $tem1 &  @CRLF) 
                        $tem1 = arrayplusScalar($tem1, -$mtt)   
                        $mf = 1
                    elseIf  IsArray($mtt) and chkisnum($tem1) Then                     
                        consolewrite( ' 7*  $mtt ' & $mtt & '$tem1 =' &  $tem1 &  @CRLF)    
                    $tem1 = arrayplusScalar($mtt, -$tem1)
                        $mf = 1  
                    EndIf
                EndIf;  
                
            Case '=' ;{CR LF NULL}
                $pp -= 1;{set back to end of line or compute will go crashing through the comments}
                $result = $tem1;
                consolewrite( 'case =  $mtt ' & $mtt & '$tem1 =' &  $tem1 & @CRLF)
                if ($bracketset = 1)then
                    MsgBox(0,'ERROR','Unmatched brackets')
                EndIf;
                Return $result
                
            Case  '0' To '9';
                $pp -= 1;
                $pnum2 = $pp;
                while( $splitcalc[$pp] = '.') or StringIsDigit($splitcalc[$pp])
                    $pp += 1;
                WEnd
                $tem1 = StringMid($stringtocalc,$pnum2,$pp-$pnum2)
                
            Case '.' ;
                $pp -= 1;
                $pnum2 = $pp;
                while( $splitcalc[$pp] = '.') or StringIsDigit($splitcalc[$pp])
                    $pp += 1;
                WEnd
                $tem1 = StringMid($stringtocalc,$pnum2,$pp-$pnum2)
                
            Case ',';this bit doesn't work yet
                $pp -= 1;
                $result = $tem1;
                Return $result

        EndSwitch;
    wend;

EndFunc

; Select Matrix to Display Result 
Func SelMatRslt()
    dim $ret
    $Form2 = GUICreate("Select a result matrix", 400, 119, 341, 254)
    GUISetIcon("D:\002.ico")
    $Button1 = GUICtrlCreateButton("Matrix 1", 36, 76, 75, 25, 0)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    GUICtrlSetBkColor(-1, 0xA6CAF0)
    $Button2 = GUICtrlCreateButton("Matrix 2", 115, 76, 75, 25, 0)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    GUICtrlSetBkColor(-1, 0xFFFFE1)
    $Button3 = GUICtrlCreateButton("Matrix 3", 195, 76, 75, 25, 0)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    GUICtrlSetBkColor(-1, 0xFF0000)
    $Button4 = GUICtrlCreateButton("Cancel", 300, 76, 75, 25, 0)
    $Label1 = GUICtrlCreateLabel("Result is a matrix, and, a result matrix is not selected.", 14, 8, 369, 20)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    $Label2 = GUICtrlCreateLabel("Please select a matrix to display the results.", 16, 39, 308, 20)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    GUISetState(@SW_SHOW)

    While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $GUI_EVENT_CLOSE, $Button4
                $ret = "0"
                ExitLoop
            Case $Button1
                $ret = "M1"
                ExitLoop
            Case $Button2
                $ret = "M2"
                ExitLoop
            Case $Button3
                $ret = "M3"
                ExitLoop
            
        EndSwitch
    WEnd
    GUISetState(@SW_HIDE)
    return $ret
EndFunc

#cs
Func Max($a,$b)
    ConsoleWrite('a,b = ' & $a & ', ' & $b & @CRLF)
    If $a > $b Then Return $a
    Return $b
EndFunc

Func Min($a,$b)
    ConsoleWrite('a,b = ' & $a & ', ' & $b & @CRLF)
    If $a < $b Then Return $a
    Return $b
EndFunc
#ce

;===============> End of Basic Command line calcs ===================================



;=============== Start of matrixUDF.au3 file ===================================
;matrixUDF.au3 file 

;Global  $iDF = 0 ; use to calculate determinantand used in Upper Triangle calculations. sign of submatrices
;Global $setdecplac, $decplInput1, $decplaceval = 0
;==========================================================================
; Function:    ArrayProduct (modified mod added)
; Purpose:   Calculate the ordinary matrix product of two matricies, as described at:
;           en.wikipedia.org/wiki/Matrix_multiplication#Ordinary_matrix_product
; Call with:    _ArrayProduct( $avA, $avB )
;   Where:       $avA and $avB are 2D arrays of numbers where the
;           row count (depth) of $avA matches the column count of $avB
; On success:   Returns a 2D array (product matrix)
; On failure:   Returns 0 and sets @error and @extended for invalid inputs
;==========================================================================
Func ArrayProduct($avA, $avB, $m = 0)
    ; Check for parameter errors.
    If IsArray($avA) = 0 Or IsArray($avB) = 0 Then Return SetError(1, 1, 0) ; both must be arrays
    If UBound($avA, 0) <> 2 Or UBound($avB, 0) <> 2 Then Return SetError(1, 2, 0) ; both must be 2D arrays
    If UBound($avA, 2) <> UBound($avB) Then Return SetError(1, 3, 0) ; depth must match
   
    ; Create return array
    Local $iRows = UBound($avA), $iCols = UBound($avB, 2), $iDepth = UBound($avA, 2)
    Local $avRET[$iRows][$iCols]
   
    ; Calculate values
    For $r = 0 To $iRows - 1
        For $c = 0 To $iCols - 1
            $x = 0
            For $z = 0 To $iDepth - 1
                $x += ($avA[$r][$z] * $avB[$z][$c])
                if $x < 10^-11 and $x > -10^-11 then $x = Int ($x); Rounded at 11 decimal places
                
            Next
            ;============== Mod
            if $m = 0 Then
                $avRET[$r][$c] = $x
            Else
                if IsNumber($m) then 
                ;   If $decplaceval <> 0 Then $x = round($x,$decplaceval)         
                    $avRET[$r][$c] = mod($x, $m) 
                EndIf
            EndIf
            ;===============> End of Mod Section
        Next
    Next
   
    Return $avRET
EndFunc   ;==>_ArrayProduct

;Matrix $a multiplied by a Scalar (number) $k 
func _arrayScalarProduct($a, $k)
    ; Check for parameter errors.
    If IsArray($a) = 0  Then Return SetError(1, 1, 0) ; must be array
    
    Local $iRows = UBound($a), $iCols = UBound($a, 2)
    Local $aRET[$iRows][$iCols]
    For $r = 0 To $iRows - 1
        For $c = 0 To $iCols - 1
            $aRET[$r][$c] = $a[$r][$c] * $k
        Next
    Next
    Return $aRET
EndFunc

;Matrix $a plus a Scalar (number) $k 
func arrayplusScalar($a, $k)
    If IsArray($a) = 0  Then Return SetError(1, 1, 0) ; must be array    
    Local $iRows = UBound($a), $iCols = UBound($a, 2)
    Local $aRET[$iRows][$iCols]
    For $r = 0 To $iRows - 1
        For $c = 0 To $iCols - 1
            $aRET[$r][$c] = $a[$r][$c] + $k
        Next
    Next
    Return $aRET
EndFunc


; Transpose a matrix columns become rows and rows become columns.
Func  matrixTranspose($a)
    Local $tms = UBound($a), $cols = UBound($a, 2)
    $m = MatCreate($cols, $tms) 
    for $i = 0 to $tms -1
        for $j = 0 to $cols -1
            $m[$j][$i] = $a[$i][$j]
        Next
    Next
    Return $m
EndFunc

; create matrix $a rows and  $b columns
Func MatCreate($a, $b)
    Dim $m[$a][$b]
    for $i =0 to $a-1
        for $j = 0 to $b -1
            $m[$i][$j] = 0
        Next
    Next
    return $m      
EndFunc 


Func upperTriangle($a)  
    If UBound($a, 2) <> UBound($a) Then Return SetError(1, 3, 0) ; depth must match
    Dim $tms = UBound($a), $f1 = 0, $temp = 0, $v = 1, $mc = $a, $stopLoop = 0
    ;MsgBox(0,"",UBound($a) & "   " & UBound($a, 2) )
    $iDF = 1
    ;MsgBox(0,"iNFO"," Matrix must be square uPPER TRI.  L223 ROW = "& UBound($a) & "   COLUMN = "&UBound($a, 2) )
     For $col = 0 To $tms -1
             For $row =  $col +1   To  $tms -1
                 $v= 1
                 $stopLoop = 0
                 While $mc[$col][$col] = 0 and $stopLoop = 0
                      
                     if $col + $v >= $tms  then
                         $iDF = 0
                         $stopLoop = 1
                     Else
                         For $c = 0 to $tms 
                             If $col < $tms and $c < $tms Then 
                                 $temp = $mc[$col][$c]
                                 $mc[$col][$c] = $mc[$col + $v][$c]
                                 $mc[$col +$v][$c] = $temp 
                             EndIf
                         Next
                    EndIf    
                        $v = $v + 1
                         $iDF  = $iDF * (-1)                     
                 WEnd            
                if $mc[$col][$col] <> 0 then
                    $f1 = (-1)* $mc[$row][$col] / $mc[$col][$col] 
                        for $i = $col to $tms - 1               
                            $mc[$row][$i] = $f1 * $mc[$col][$i] + $mc[$row][$i]        
                             ;MsgBox(0,"Prim", $col & "  " & $mc[$row][$i])
                         Next
                 EndIf
                  $v = 1
            Next
    Next
    Return $mc
EndFunc

; matrix $matr1 minus matrix $matr2
Func matrixminusmatrix($matr1, $matr2)
    If UBound($matr1, 2) <> UBound($matr2) and  UBound($matr2, 2) <> UBound($matr1) Then
        SetError(0)
        Return -1
    EndIf   
    Local $r = UBound($matr1), $cols = UBound($matr1, 2)
    $m = MatCreate($r, $cols)   
    for $i = 0 to $r -1
        for $j = 0 to $cols -1
            $m[$i][$j] = $matr1[$i][$j] - $matr2[$i][$j]
        Next
    Next
    Return $m
EndFunc

; matrix $matr1 plus matrix $matr2
Func matrixplusmatrix($matr1, $matr2)
    If UBound($matr1, 2) <> UBound($matr2) and  UBound($matr2, 2) <> UBound($matr1) Then
        SetError(0)
        Return -1
    EndIf   
    Local $r = UBound($matr1), $cols = UBound($matr1, 2)
    $m = MatCreate($r, $cols)   
    for $i = 0 to $r -1
        for $j = 0 to $cols -1
            $m[$i][$j] = $matr1[$i][$j] + $matr2[$i][$j]
        Next
    Next
    Return $m
EndFunc

;Determines the reciprocal or multiplicative inverse of, a Modulo m
; provide a and m have no common factors.  
;$a and $m are numbers
Func Multinv($a, $m)
    dim $minu = 0
    if $a < 0 then 
        $a = $a *-1
        $minu = 1 ;flag for negative value
    EndIf
    dim $p = 0
    Do
         $p = $p + 1
     Until Mod(($p * $a), $m) = 1 Or $p = $m    
    if $minu = 1 then 
        $p = $m - $p        
    EndIf
    ;If $decplaceval <> 0 Then $p = Round($p, $decplaceval)  
    Return $p
EndFunc


;_arraymod($a, $m) Returns the the molulo of array $a to modulus $m
;convert negative mod result no. to positive no.
; e.g (-17 Mod 47 ) = (30 Mod 47 )
; i.e. 47 + (-17) = 30
func _arraymod($a, $m)
    ; Check for parameter errors.
    If IsArray($a) = 0  Then Return SetError(1, 1, 0) ; must be array
    
    Local $iRows = UBound($a), $iCols = UBound($a, 2), $iDepth = UBound($a, 2)
    Local $aRET[$iRows][$iCols]
    For $r = 0 To $iRows - 1
        For $c = 0 To $iCols - 1
            ;If $decplaceval <> 0 Then 
            ;   $aRET[$r][$c] = round(mod($a[$r][$c],$m),$decplaceval)
            ;Else
                $aRET[$r][$c] = mod($a[$r][$c],$m)   
            ;EndIf
            if $m > 0 then
                If $aRET[$r][$c] < 0 then $aRET[$r][$c] = $m + $aRET[$r][$c] ;convert negative mod result no. to positive no.
            EndIf
        Next
    Next
    ; --- set deciminal places ------
        If $decplaceval <> 0 Then         
            for $x = 0 to $r -1
                for $y = 0 to $c -1
                    $aRET[$x][$y] = Mod(Round($aRET[$x][$y], $decplaceval),$m)
                Next            
            Next
        EndIf
    Return $aRET                  
EndFunc
    
; Calculates and returns the determinant of matrix $a
Func _DetMatrix($a)
    If UBound($a) <> UBound($a, 2)  Then 
        MsgBox(0,"Error"," Matrix must be square to determine Determinant. ROW = "& UBound($a) & "   COLUMN = "&UBound($a, 2) )
    else
        Dim $bt, $det = 1
        Local $iRows = UBound($a)
        $temp = upperTriangle($a)
        $bt = upperTriangle($temp)
        For $r = 0 To $iRows - 1
            $det = $det * $bt[$r][$r]
            ;MsgBox(0,"det", $iRows & "  " &$r & "  " & $det)
        Next    
        $det = $det * $iDF
    EndIf
    ;If $decplaceval <> 0 Then $det = Round($det, $decplaceval)
    return $det
EndFunc


; Calculates and returns the matrix which is the adjoint of matrix $a
Func matrixAdjoint($a)   
     Local $tms = UBound($a), $ii = 0, $temp = 0, $jj = 0, $ia = 0, $ja = 0, $det = 0, $m = $a
     ;MsgBox(0,"",$tms)
     For $i = 0 To $tms -1
             For $j =  0 To  $tms - 1
                 $ia = 0
                 $ja = 0
                 $ap = MatCreate($tms-1 ,$tms-1 )
                 $tmsp = UBound($ap)
                 for $ii = 0 to $tms - 1
                     for $jj = 0 to $tms - 1
                         if $ii <> $i and $jj <> $j Then
                             $ap[$ia][$ja] = $a[$ii][$jj]
                             $ja = $ja + 1
                             ;MsgBox(0,"Prim", $ja & "  " & $a[$ia][$ja])
                         EndIf
                     Next
                     if $ii <> $i and $jj <> $j then $ia = $ia + 1
                     $ja = 0
                 Next
                 $det = _DetMatrix($ap)     
                 $m[$i][$j] = ((-1)^($i + $j)) * $det 
             Next
    Next
    $m = matrixTranspose($m)
     Return $m
 EndFunc
 
 ;===============================
;  matrixInv($a) gives the inverse of Matrix $a
;  matrixInv($a, $m) gives the Mudulo inverse of Matrix $a Mudulus $m
func matrixInv($a, $m = 0)  
    If UBound($a, 2) <> UBound($a) Then
        SetError(0)
        Return -1
    EndIf   
    $det = _DetMatrix($a)
    If $det = 0 Then
        MsgBox(0,"","Determinant is zero. The inverse of this matrix can not be calculated.")
        $avRET = 0
    Else
        $ajnt = matrixAdjoint($a)
        if $m = 0 Then                      
            $avRET = _arrayScalarProduct($ajnt, 1/$det)
        Else
    ;============== Mod   
            if $m > 0 then 
                $mul = Multinv(mod($det,$m), $m)
                ;If $decplaceval <> 0 Then $mul = Round($mul, $decplaceval)
                ;MsgBox(0,"",$mul)
                $avRET = _arrayScalarProduct($ajnt, $mul)
                $avRET = _arraymod($avRET,$m)            
            EndIf
        EndIf
    EndIf      
    ;===============> End of Mod Section    
    Return $avRET   
EndFunc

;
Func matrixpower($mat, $pow)
     $ret = $mat
    If $pow = 0 Then 
        $ret = ArrayProduct($mat, matrixInv($mat))
    ElseIf $pow > 0 Then
        for $x = 1 to $pow -1
            $ret = ArrayProduct($ret, $mat)
        next
    ElseIf $pow < 0 Then
        $ret =  matrixInv($mat)
        for $x = 1 to abs($pow) -1
            $ret = ArrayProduct($ret, matrixInv($mat))
        next
    EndIf   
    return $ret
EndFunc

;each element in Matrix ($mat) to the power of $pow
func matrixelementpower($mat, $pow)
    If IsArray($mat) = 0  Then Return SetError(1, 1, 0) ; must be array    
    Local $iRows = UBound($mat), $iCols = UBound($mat, 2)
    Local $aRET[$iRows][$iCols]
    For $r = 0 To $iRows - 1
        For $c = 0 To $iCols - 1
            $aRET[$r][$c] = power($mat[$r][$c], $pow)
        Next
    Next
    Return $aRET
EndFunc

; Two numbers $a^$b     $a to the power of $b
Func power($a,$b)
    ConsoleWrite('1st  power(a,b = ' & $a & ', ' & $b &@CRLF)
    ;returns $a to the power of $b
    If $b = 0 Then  Return 1 
    If $a < 0 Then             ; Check for root of a negative number
        If ($b - int($b)) = 0  Then  ;The decimal part of the power is taking the root  e.g.  4^(2.5) = 4^2 * 4^(0.5) = 16 * 2 = 32
            If Mod($b,2) = 0 Then  ; (-$a)*(-$a) = (+$a^2)  but  (-$a)*(-$a)*(-$a) = (-$a^3) i.e. odd power = neg.result where $a < 0
                $a = Abs($a)
                ConsoleWrite('2nd  power(a,b = ' & $a & ', ' & $b &@CRLF)
                Return abs($a^$b)
            Else
                ConsoleWrite('3rd  power(a,b = ' & $a & ', ' & $b &@CRLF)
                Return - abs((Abs($a)^$b))    ; odd = neg.
            EndIf         
        else          
            return "The result is a complex number"  
        EndIf
    EndIf
    ConsoleWrite('4th  power(a,b = ' & $a & ', ' & $b &@CRLF)
    return  ($a^$b)    
EndFunc

    ;Greatest Common Denominator - Euclid's algorithm.
    ;(Sarah Flannery, "In Code",Profile Books Ltd,p249-250.)
Func gcd($a, $m)
    Dim $p = 0, $r = 0
    $p =  Mod($a,$m)
    ;MsgBox(0,"Prim",  $a)
    If $p = 0 Then    
       $a = $r 
    Else
        $r = $m
        Do
            $b =  Mod($r,$p)
            $r = $p   
            $p = $b
        Until $b = 0
        ;MsgBox(0,"Prim",  $r)       
    EndIf
    Return $r
EndFunc

; Given a Number $a returns the factors of that number
Func Prim($a)
    $factors = ""
    Dim $b, $c 
    If $a > 0 Then
        If $a <> 0 Then
            $a = Int($a)
            While $a / 2 - Int($a / 2) = 0
                $a = $a / 2
                $factors = $factors & "2 "
            WEnd
            $b = 3
            $c = ($a)*($a) + 1
            Do 
                If $a / $b - Int($a / $b) = 0 Then
                    If $a / $b * $b - $a = 0 Then 
                        $factors = $factors & $b & " "
                        $a = $a / $b
                    EndIf
                EndIf
                If $a / $b - Int($a / $b) <> 0 Then $b = $b + 2
                $c = ($a)*($a) + 1            
            Until $b > $c Or $b = $c
            
            If $a <> 1 Then $factors = $factors & $a & " "
        EndIf
    EndIf
    ;MsgBox(0,"Prim",  $factors)
    Return $factors
EndFunc
;===============> End of matrixUDF.au3 file ===================================