#include <GuiConstants.au3>
#Include <date.au3>
#Include <WindowsConstants.au3>

$waste = 0
$diffmetal = 0
$diffcrystal = 0
$diffdeut = 0
$divmetal = 0
$divcrystal = 0
$divdeut = 0
$metalneed = 0
$crystalneed = 0
$deutneed = 0
$result = ""
$total = 0
$in1 = 0
$in2 = 0
$in3 = 0
$in7 = 0
$in8 = 0
$in9 = 0
$timeround1 = 0
$mneed = 0
$cneed = 0
$dneed = 0
$usedhourmetal = 0
$usedhourcrystal = 0
$usedhourdeut = 0
$BInput_20 = 0
$BInput_21 = 0
$BInput_22 = 0
$BInput_23 = 0
$BInput_24 = 0
$BInput_25 = 0
$BInput_26 = 0
$BInput_27 = 0
$BInput_28 = 0
$BInput_29 = 0
$BInput_30 = 0
$BInput_31 = 0
$BInput_32 = 0
$BInput_33 = 0
$BInput_34 = 0
$BInput_35 = 0
$BInput_36 = 0
$BInput_37 = 0
$BInput_38 = 0
$BInput_39 = 0
$BInput_40 = 0
$BInput_41 = 0
$BInput_42 = 0
$BInput_43 = 0
$BInput_44 = 0
$BInput_45 = 0
$BInput_46 = 0
$BInput_47 = 0
$BInput_48 = 0
$BInput_49 = 0
$BInput_50 = 0
$BInput_51 = 0
$BInput_52 = 0
$BInput_53 = 0
$BInput_54 = 0
$BInput_55 = 0
$BInput_56 = 0
$BInput_57 = 0
$BInput_58 = 0
$BInput_59 = 0
$BInput_60 = 0
$BInput_61 = 0
$BInput_62 = 0
$BInput_63 = 0
$BInput_64 = 0
$BInput_65 = 0
$BInput_66 = 0
$BInput_67 = 0
$BInput_68 = 0
$BInput_69 = 0
$BInput_70 = 0
$BInput_71 = 0
$BInput_72 = 0
$BInput_73 = 0

;If program was used before it will remember the last per hour numbers used.
$BInput_20 = IniRead("last.ini", "section2", "key1", "")
$BInput_21 = IniRead("last.ini", "section2", "key2", "")
$BInput_22 = IniRead("last.ini", "section2", "key3", "")
$BInput_23 = IniRead("last.ini", "section2", "key4", "")
$BInput_24 = IniRead("last.ini", "section2", "key5", "")
$BInput_25 = IniRead("last.ini", "section2", "key6", "")
$BInput_26 = IniRead("last.ini", "section2", "key7", "")
$BInput_27 = IniRead("last.ini", "section2", "key8", "")
$BInput_28 = IniRead("last.ini", "section2", "key9", "")

$BInput_29 = IniRead("last.ini", "section2", "key10", "")
$BInput_30 = IniRead("last.ini", "section2", "key11", "")
$BInput_31 = IniRead("last.ini", "section2", "key12", "")
$BInput_32 = IniRead("last.ini", "section2", "key13", "")
$BInput_33 = IniRead("last.ini", "section2", "key14", "")
$BInput_34 = IniRead("last.ini", "section2", "key15", "")
$BInput_35 = IniRead("last.ini", "section2", "key16", "")
$BInput_36 = IniRead("last.ini", "section2", "key17", "")
$BInput_37 = IniRead("last.ini", "section2", "key18", "")

$BInput_38 = IniRead("last.ini", "section2", "key19", "")
$BInput_39 = IniRead("last.ini", "section2", "key20", "")
$BInput_40 = IniRead("last.ini", "section2", "key21", "")
$BInput_41 = IniRead("last.ini", "section2", "key22", "")
$BInput_42 = IniRead("last.ini", "section2", "key23", "")
$BInput_43 = IniRead("last.ini", "section2", "key24", "")
$BInput_44 = IniRead("last.ini", "section2", "key25", "")
$BInput_45 = IniRead("last.ini", "section2", "key26", "")
$BInput_46 = IniRead("last.ini", "section2", "key27", "")

$BInput_47 = IniRead("last.ini", "section3", "key28", "")
$BInput_48 = IniRead("last.ini", "section3", "key29", "")
$BInput_49 = IniRead("last.ini", "section3", "key30", "")
$BInput_50 = IniRead("last.ini", "section3", "key31", "")
$BInput_51 = IniRead("last.ini", "section3", "key32", "")
$BInput_52 = IniRead("last.ini", "section3", "key33", "")
$BInput_53 = IniRead("last.ini", "section3", "key34", "")
$BInput_54 = IniRead("last.ini", "section3", "key35", "")
$BInput_55 = IniRead("last.ini", "section3", "key36", "")

$BInput_56 = IniRead("last.ini", "section3", "key37", "")
$BInput_57 = IniRead("last.ini", "section3", "key38", "")
$BInput_58 = IniRead("last.ini", "section3", "key39", "")
$BInput_59 = IniRead("last.ini", "section3", "key40", "")
$BInput_60 = IniRead("last.ini", "section3", "key41", "")
$BInput_61 = IniRead("last.ini", "section3", "key42", "")
$BInput_62 = IniRead("last.ini", "section3", "key43", "")
$BInput_63 = IniRead("last.ini", "section3", "key44", "")
$BInput_64 = IniRead("last.ini", "section3", "key45", "")

$BInput_65 = IniRead("last.ini", "section3", "key46", "")
$BInput_66 = IniRead("last.ini", "section3", "key47", "")
$BInput_67 = IniRead("last.ini", "section3", "key48", "")
$BInput_68 = IniRead("last.ini", "section3", "key49", "")
$BInput_69 = IniRead("last.ini", "section3", "key50", "")
$BInput_70 = IniRead("last.ini", "section3", "key51", "")
$BInput_71 = IniRead("last.ini", "section3", "key52", "")
$BInput_72 = IniRead("last.ini", "section3", "key53", "")
$BInput_73 = IniRead("last.ini", "section3", "key54", "")

GuiCreate("How Much Longer?  V3.5.2", 1000, 360,(@DesktopWidth-1000)/2, (@DesktopHeight-360)/2 , $WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS)

$Label_98 = GuiCtrlCreateLabel("www.MundenIsGod.com", 875, 1, 120, 20)

$Label_1 = GuiCtrlCreateLabel("How Much Longer V 3.5.2" & @CRLF & @CRLF & "    by Munden", 10, 10, 160, 50)
$Label_2 = GuiCtrlCreateLabel("--RESULTS--" & @CRLF & "-------------------", 10, 70, 160, 40)
$Label_3 = GuiCtrlCreateLabel("", 10, 120, 160, 220)
$Label_4 = GuiCtrlCreateLabel("  - Current Metal -" & @CRLF & "--------------------------------", 220, 10, 100, 40)
$Label_5 = GuiCtrlCreateLabel("  - Current Crystal -" & @CRLF & "--------------------------------", 330, 10, 100, 40)
$Label_6 = GuiCtrlCreateLabel("- Current Deuterium -" & @CRLF & "--------------------------------", 440, 10, 100, 40)
$Label_7 = GuiCtrlCreateLabel("  -Metal Per Hour-" & @CRLF & "--------------------------------", 550, 10, 100, 40)
$Label_8 = GuiCtrlCreateLabel(" -Crystal Per Hour-" & @CRLF & "--------------------------------", 660, 10, 100, 40)
$Label_9 = GuiCtrlCreateLabel("-Deuterium Per Hour-" & @CRLF & "--------------------------------", 770, 10, 100, 40)
$Label_10 = GuiCtrlCreateLabel("Planets" & @CRLF & "-------------", 170, 20, 50, 30)
$Label_11 = GuiCtrlCreateLabel("  # 1", 170, 60, 50, 20)
$Label_12 = GuiCtrlCreateLabel("  # 2", 170, 90, 50, 20)
$Label_13 = GuiCtrlCreateLabel("  # 3", 170, 120, 50, 20)
$Label_14 = GuiCtrlCreateLabel("  # 4", 170, 150, 50, 20)
$Label_15 = GuiCtrlCreateLabel("  # 5", 170, 180, 50, 20)
$Label_16 = GuiCtrlCreateLabel("  # 6", 170, 210, 50, 20)
$Label_17 = GuiCtrlCreateLabel("  # 7", 170, 240, 50, 20)
$Label_18 = GuiCtrlCreateLabel("  # 8", 170, 270, 50, 20)
$Label_19 = GuiCtrlCreateLabel("  # 9", 170, 300, 50, 20)

$Input_20 = GuiCtrlCreateInput($BInput_20, 220, 60, 100, 20)
$Input_29 = GuiCtrlCreateInput($BInput_29, 330, 60, 100, 20)
$Input_38 = GuiCtrlCreateInput($BInput_38, 440, 60, 100, 20)
$Input_47 = GuiCtrlCreateInput($BInput_47, 550, 60, 100, 20)
$Input_56 = GuiCtrlCreateInput($BInput_56, 660, 60, 100, 20)
$Input_65 = GuiCtrlCreateInput($BInput_65, 770, 60, 100, 20)

$Input_21 = GuiCtrlCreateInput($BInput_21, 220, 90, 100, 20)
$Input_30 = GuiCtrlCreateInput($BInput_30, 330, 90, 100, 20)
$Input_39 = GuiCtrlCreateInput($BInput_39, 440, 90, 100, 20)
$Input_48 = GuiCtrlCreateInput($BInput_48, 550, 90, 100, 20)
$Input_57 = GuiCtrlCreateInput($BInput_57, 660, 90, 100, 20)
$Input_66 = GuiCtrlCreateInput($BInput_66, 770, 90, 100, 20)

$Input_22 = GuiCtrlCreateInput($BInput_22, 220, 120, 100, 20)
$Input_31 = GuiCtrlCreateInput($BInput_31, 330, 120, 100, 20)
$Input_40 = GuiCtrlCreateInput($BInput_40, 440, 120, 100, 20)
$Input_49 = GuiCtrlCreateInput($BInput_49, 550, 120, 100, 20)
$Input_58 = GuiCtrlCreateInput($BInput_58, 660, 120, 100, 20)
$Input_67 = GuiCtrlCreateInput($BInput_67, 770, 120, 100, 20)

$Input_23 = GuiCtrlCreateInput($BInput_23, 220, 150, 100, 20)
$Input_32 = GuiCtrlCreateInput($BInput_32, 330, 150, 100, 20)
$Input_41 = GuiCtrlCreateInput($BInput_41, 440, 150, 100, 20)
$Input_50 = GuiCtrlCreateInput($BInput_50, 550, 150, 100, 20)
$Input_59 = GuiCtrlCreateInput($BInput_59, 660, 150, 100, 20)
$Input_68 = GuiCtrlCreateInput($BInput_68, 770, 150, 100, 20)

$Input_24 = GuiCtrlCreateInput($BInput_24, 220, 180, 100, 20)
$Input_33 = GuiCtrlCreateInput($BInput_33, 330, 180, 100, 20)
$Input_42 = GuiCtrlCreateInput($BInput_42, 440, 180, 100, 20)
$Input_51 = GuiCtrlCreateInput($BInput_51, 550, 180, 100, 20)
$Input_60 = GuiCtrlCreateInput($BInput_60, 660, 180, 100, 20)
$Input_69 = GuiCtrlCreateInput($BInput_69, 770, 180, 100, 20)

$Input_25 = GuiCtrlCreateInput($BInput_25, 220, 210, 100, 20)
$Input_34 = GuiCtrlCreateInput($BInput_34, 330, 210, 100, 20)
$Input_43 = GuiCtrlCreateInput($BInput_43, 440, 210, 100, 20)
$Input_52 = GuiCtrlCreateInput($BInput_52, 550, 210, 100, 20)
$Input_61 = GuiCtrlCreateInput($BInput_61, 660, 210, 100, 20)
$Input_70 = GuiCtrlCreateInput($BInput_70, 770, 210, 100, 20)

$Input_26 = GuiCtrlCreateInput($BInput_26, 220, 240, 100, 20)
$Input_35 = GuiCtrlCreateInput($BInput_35, 330, 240, 100, 20)
$Input_44 = GuiCtrlCreateInput($BInput_44, 440, 240, 100, 20)
$Input_53 = GuiCtrlCreateInput($BInput_53, 550, 240, 100, 20)
$Input_62 = GuiCtrlCreateInput($BInput_62, 660, 240, 100, 20)
$Input_71 = GuiCtrlCreateInput($BInput_71, 770, 240, 100, 20)

$Input_27 = GuiCtrlCreateInput($BInput_27, 220, 270, 100, 20)
$Input_36 = GuiCtrlCreateInput($BInput_36, 330, 270, 100, 20)
$Input_45 = GuiCtrlCreateInput($BInput_45, 440, 270, 100, 20)
$Input_54 = GuiCtrlCreateInput($BInput_54, 550, 270, 100, 20)
$Input_63 = GuiCtrlCreateInput($BInput_63, 660, 270, 100, 20)
$Input_72 = GuiCtrlCreateInput($BInput_72, 770, 270, 100, 20)

$Input_28 = GuiCtrlCreateInput($BInput_28, 220, 300, 100, 20)
$Input_37 = GuiCtrlCreateInput($BInput_37, 330, 300, 100, 20)
$Input_46 = GuiCtrlCreateInput($BInput_46, 440, 300, 100, 20)
$Input_55 = GuiCtrlCreateInput($BInput_55, 550, 300, 100, 20)
$Input_64 = GuiCtrlCreateInput($BInput_64, 660, 300, 100, 20)
$Input_73 = GuiCtrlCreateInput($BInput_73, 770, 300, 100, 20)

$metalneed = GuiCtrlCreateInput($mneed, 890, 80, 100, 20)
$crystalneed = GuiCtrlCreateInput($cneed, 890, 170, 100, 20)
$deutneed = GuiCtrlCreateInput($dneed, 890, 260, 100, 20)
$Button_77 = GuiCtrlCreateButton("  HOW LONG?!  ", 890, 300, 100, 50)
$Label_79 = GuiCtrlCreateLabel("" & @CRLF & @CRLF & "  -Metal Needed-  " & @CRLF & "-------------------------------", 890, 20, 100, 50)
$Label_80 = GuiCtrlCreateLabel("" & @CRLF & @CRLF & " -Crystal Needed- " & @CRLF & "-------------------------------", 890, 110, 100, 50)
$Label_81 = GuiCtrlCreateLabel("" & @CRLF & @CRLF & "-Deuterium Needed-" & @CRLF & "-------------------------------", 890, 200, 100, 50)

GuiSetState()
While 1

;If program was used before it will remember the last per hour numbers used.
$BInput_20 = IniRead("last.ini", "section2", "key1", "")
$BInput_21 = IniRead("last.ini", "section2", "key2", "")
$BInput_22 = IniRead("last.ini", "section2", "key3", "")
$BInput_23 = IniRead("last.ini", "section2", "key4", "")
$BInput_24 = IniRead("last.ini", "section2", "key5", "")
$BInput_25 = IniRead("last.ini", "section2", "key6", "")
$BInput_26 = IniRead("last.ini", "section2", "key7", "")
$BInput_27 = IniRead("last.ini", "section2", "key8", "")
$BInput_28 = IniRead("last.ini", "section2", "key9", "")

$BInput_29 = IniRead("last.ini", "section2", "key10", "")
$BInput_30 = IniRead("last.ini", "section2", "key11", "")
$BInput_31 = IniRead("last.ini", "section2", "key12", "")
$BInput_32 = IniRead("last.ini", "section2", "key13", "")
$BInput_33 = IniRead("last.ini", "section2", "key14", "")
$BInput_34 = IniRead("last.ini", "section2", "key15", "")
$BInput_35 = IniRead("last.ini", "section2", "key16", "")
$BInput_36 = IniRead("last.ini", "section2", "key17", "")
$BInput_37 = IniRead("last.ini", "section2", "key18", "")

$BInput_38 = IniRead("last.ini", "section2", "key19", "")
$BInput_39 = IniRead("last.ini", "section2", "key20", "")
$BInput_40 = IniRead("last.ini", "section2", "key21", "")
$BInput_41 = IniRead("last.ini", "section2", "key22", "")
$BInput_42 = IniRead("last.ini", "section2", "key23", "")
$BInput_43 = IniRead("last.ini", "section2", "key24", "")
$BInput_44 = IniRead("last.ini", "section2", "key25", "")
$BInput_45 = IniRead("last.ini", "section2", "key26", "")
$BInput_46 = IniRead("last.ini", "section2", "key27", "")

$BInput_47 = IniRead("last.ini", "section3", "key28", "")
$BInput_48 = IniRead("last.ini", "section3", "key29", "")
$BInput_49 = IniRead("last.ini", "section3", "key30", "")
$BInput_50 = IniRead("last.ini", "section3", "key31", "")
$BInput_51 = IniRead("last.ini", "section3", "key32", "")
$BInput_52 = IniRead("last.ini", "section3", "key33", "")
$BInput_53 = IniRead("last.ini", "section3", "key34", "")
$BInput_54 = IniRead("last.ini", "section3", "key35", "")
$BInput_55 = IniRead("last.ini", "section3", "key36", "")

$BInput_56 = IniRead("last.ini", "section3", "key37", "")
$BInput_57 = IniRead("last.ini", "section3", "key38", "")
$BInput_58 = IniRead("last.ini", "section3", "key39", "")
$BInput_59 = IniRead("last.ini", "section3", "key40", "")
$BInput_60 = IniRead("last.ini", "section3", "key41", "")
$BInput_61 = IniRead("last.ini", "section3", "key42", "")
$BInput_62 = IniRead("last.ini", "section3", "key43", "")
$BInput_63 = IniRead("last.ini", "section3", "key44", "")
$BInput_64 = IniRead("last.ini", "section3", "key45", "")

$BInput_65 = IniRead("last.ini", "section3", "key46", "")
$BInput_66 = IniRead("last.ini", "section3", "key47", "")
$BInput_67 = IniRead("last.ini", "section3", "key48", "")
$BInput_68 = IniRead("last.ini", "section3", "key49", "")
$BInput_69 = IniRead("last.ini", "section3", "key50", "")
$BInput_70 = IniRead("last.ini", "section3", "key51", "")
$BInput_71 = IniRead("last.ini", "section3", "key52", "")
$BInput_72 = IniRead("last.ini", "section3", "key53", "")
$BInput_73 = IniRead("last.ini", "section3", "key54", "")

    $msg = GuiGetMsg()
    Select
    Case $msg = $Button_77
        
    $curmetal = ($BInput_20+$BInput_21+$BInput_22+$BInput_23+$BInput_24+$BInput_25+$BInput_26+$BInput_27+$BInput_28)
    $curcrystal = ($BInput_29+$BInput_30+$BInput_31+$BInput_32+$BInput_33+$BInput_34+$BInput_35+$BInput_36+$BInput_37)
    $curdeut = ($BInput_38+$BInput_39+$BInput_40+$BInput_41+$BInput_42+$BInput_43+$BInput_44+$BInput_45+$BInput_46)
    $usedhourmetal = ($BInput_47+$BInput_48+$BInput_49+$BInput_50+$BInput_51+$BInput_52+$BInput_53+$BInput_54+$BInput_55)
    $usedhourcrystal = ($BInput_56+$BInput_57+$BInput_58+$BInput_59+$BInput_60+$BInput_61+$BInput_62+$BInput_63+$BInput_64)
    $usedhourdeut = ($BInput_65+$BInput_66+$BInput_67+$BInput_68+$BInput_69+$BInput_70+$BInput_71+$BInput_72+$BInput_73)
    
;Subtracting current materials from what is going to be built
    $diffmetal = GUICtrlRead($metalneed)-($curmetal)
    $diffcrystal = GUICtrlRead($crystalneed)-($curcrystal)
    $diffdeut = GUICtrlRead($deutneed)-($curdeut)

;Dividing subtracted totals from rates per hour
    $divmetal = ($diffmetal / $usedhourmetal)
    $divcrystal = ($diffcrystal / $usedhourcrystal)
    $divdeut = ($diffdeut / $usedhourdeut)
    
;If you have more materials than is needed to build it will
;return a negative.  The next 3 if statements will change
;that negative to a 0.
    If $divmetal < 0 Then
    $divmetal = 0
EndIf

    If $divcrystal < 0 Then
    $divcrystal = 0
EndIf

    If $divdeut < 0 Then
    $divdeut = 0
EndIf

;Testing metal for largest value
If $divmetal > $divcrystal Then
    $waste = 1
EndIf

If $waste = 1 Then
    If $divmetal > $divdeut Then
        $total = $divmetal
        EndIf
EndIf

;Testing crystal for largest value
If $divcrystal > $divmetal Then
    $waste = 2
EndIf

If $waste = 2 Then
    If $divcrystal > $divdeut Then
        $total = $divcrystal
        EndIf
EndIf

;Testing Deuterium for largest value
If $divdeut > $divmetal Then
    $waste = 3
EndIf

If $waste = 3 Then
    If $divdeut > $divcrystal Then
        $total = $divdeut
        EndIf
EndIf

;If two totals are equal these three if statements will choose a total
If $total = 666 Then
    $total = $divmetal
EndIf

If $total = 0 Then
    $total = $divcrystal
EndIf

If $total = 0 Then
    $total = $divdeut
EndIf

$timeround1 = Round((Round($total,3) - Round($total, 0)) * 60,0)

If $timeround1 < 0 Then
    $total = $total - 1
    $timeround1 = $timeround1 + 60
EndIf

$timeround2 = Round((Round($divmetal,3) - Round($divmetal, 0)) * 60,0)

If $timeround2 < 0 Then
    $divmetal = $divmetal - 1
    $timeround2 = $timeround2 + 60
EndIf

$timeround3 = Round((Round($divcrystal,3) - Round($divcrystal, 0)) * 60,0)

If $timeround3 < 0 Then
    $divcrystal = $divcrystal - 1
    $timeround3 = $timeround3 + 60
EndIf

$timeround4 = Round((Round($divdeut,3) - Round($divdeut, 0)) * 60,0)

If $timeround4 < 0 Then
    $divdeut = $divdeut - 1
    $timeround4 = $timeround4 + 60
EndIf

$extrametal = 0
$extracrystal = 0
$extradeut = 0

$extrametal = $total - $divmetal
$extracrystal = $total - $divcrystal
$extradeut = $total - $divdeut


If $diffmetal < 0 Then
    $diffmetal = ($diffmetal * -1)
EndIf
        
If $diffcrystal < 0 Then
    $diffcrystal = ($diffcrystal * -1)
EndIf

If $diffdeut < 0 Then
    $diffdeut = ($diffdeut * -1)
EndIf

If $divmetal = $total Then
    $diffmetal = 0
EndIf

If $divcrystal = $total Then
    $diffcrystal = 0
EndIf

If $divdeut = $total Then
    $diffdeut = 0
EndIf

$Label_3 = GuiCtrlCreateLabel("Hours Until Enough Materials" & @CRLF & "" & @CRLF & "Metal :          " & Round($divmetal,0) & " hours " & $timeround2 & " min." & @CRLF & "" & @CRLF & "Crystal :      " & Round($divcrystal,0) & " hours " & $timeround3 & " min." & @CRLF & "" & @CRLF & "Deuterium :   " & Round($divdeut,0) & " hours " & $timeround4 & " min." & @CRLF & "" & @CRLF & "" & @CRLF & "Total Time :  "& Round($total,0) & " hours " & $timeround1 & " min." & @CRLF & "------------------------------------------" & @CRLF & @CRLF, 10, 100, 160, 350)

$Label_99 = GuiCtrlCreateLabel("Totals - ", 155, 335, 80, 20)
$Label_100 = GuiCtrlCreateLabel($curmetal, 225, 335, 80, 20)
$Label_101 = GuiCtrlCreateLabel($curcrystal, 335, 335, 80, 20)
$Label_102 = GuiCtrlCreateLabel($curdeut, 445, 335, 80, 20)
$Label_103 = GuiCtrlCreateLabel($usedhourmetal, 555, 335, 80, 20)
$Label_104 = GuiCtrlCreateLabel($usedhourcrystal, 665, 335, 80, 20)
$Label_105 = GuiCtrlCreateLabel($usedhourdeut, 775, 335, 80, 20)

$total = 0

Case $msg = $GUI_EVENT_CLOSE
        ExitLoop
Case Else
    ;;;
EndSelect

;Writes the three per hour material gained for next use.
IniWrite("last.ini", "section2", "key1", GUICtrlRead($Input_20))
IniWrite("last.ini", "section2", "key2", GUICtrlRead($Input_21))
IniWrite("last.ini", "section2", "key3", GUICtrlRead($Input_22))
IniWrite("last.ini", "section2", "key4", GUICtrlRead($Input_23))
IniWrite("last.ini", "section2", "key5", GUICtrlRead($Input_24))
IniWrite("last.ini", "section2", "key6", GUICtrlRead($Input_25))
IniWrite("last.ini", "section2", "key7", GUICtrlRead($Input_26))
IniWrite("last.ini", "section2", "key8", GUICtrlRead($Input_27))
IniWrite("last.ini", "section2", "key9", GUICtrlRead($Input_28))
IniWrite("last.ini", "section2", "key10", GUICtrlRead($Input_29))
IniWrite("last.ini", "section2", "key11", GUICtrlRead($Input_30))
IniWrite("last.ini", "section2", "key12", GUICtrlRead($Input_31))
IniWrite("last.ini", "section2", "key13", GUICtrlRead($Input_32))
IniWrite("last.ini", "section2", "key14", GUICtrlRead($Input_33))
IniWrite("last.ini", "section2", "key15", GUICtrlRead($Input_34))
IniWrite("last.ini", "section2", "key16", GUICtrlRead($Input_35))
IniWrite("last.ini", "section2", "key17", GUICtrlRead($Input_36))
IniWrite("last.ini", "section2", "key18", GUICtrlRead($Input_37))
IniWrite("last.ini", "section2", "key19", GUICtrlRead($Input_38))
IniWrite("last.ini", "section2", "key20", GUICtrlRead($Input_39))
IniWrite("last.ini", "section2", "key21", GUICtrlRead($Input_40))
IniWrite("last.ini", "section2", "key22", GUICtrlRead($Input_41))
IniWrite("last.ini", "section2", "key23", GUICtrlRead($Input_42))
IniWrite("last.ini", "section2", "key24", GUICtrlRead($Input_43))
IniWrite("last.ini", "section2", "key25", GUICtrlRead($Input_44))
IniWrite("last.ini", "section2", "key26", GUICtrlRead($Input_45))
IniWrite("last.ini", "section2", "key27", GUICtrlRead($Input_46))
IniWrite("last.ini", "section3", "key28", GUICtrlRead($Input_47))
IniWrite("last.ini", "section3", "key29", GUICtrlRead($Input_48))
IniWrite("last.ini", "section3", "key30", GUICtrlRead($Input_49))
IniWrite("last.ini", "section3", "key31", GUICtrlRead($Input_50))
IniWrite("last.ini", "section3", "key32", GUICtrlRead($Input_51))
IniWrite("last.ini", "section3", "key33", GUICtrlRead($Input_52))
IniWrite("last.ini", "section3", "key34", GUICtrlRead($Input_53))
IniWrite("last.ini", "section3", "key35", GUICtrlRead($Input_54))
IniWrite("last.ini", "section3", "key36", GUICtrlRead($Input_55))
IniWrite("last.ini", "section3", "key37", GUICtrlRead($Input_56))
IniWrite("last.ini", "section3", "key38", GUICtrlRead($Input_57))
IniWrite("last.ini", "section3", "key39", GUICtrlRead($Input_58))
IniWrite("last.ini", "section3", "key40", GUICtrlRead($Input_59))
IniWrite("last.ini", "section3", "key41", GUICtrlRead($Input_60))
IniWrite("last.ini", "section3", "key42", GUICtrlRead($Input_61))
IniWrite("last.ini", "section3", "key43", GUICtrlRead($Input_62))
IniWrite("last.ini", "section3", "key44", GUICtrlRead($Input_63))
IniWrite("last.ini", "section3", "key45", GUICtrlRead($Input_64))
IniWrite("last.ini", "section3", "key46", GUICtrlRead($Input_65))
IniWrite("last.ini", "section3", "key47", GUICtrlRead($Input_66))
IniWrite("last.ini", "section3", "key48", GUICtrlRead($Input_67))
IniWrite("last.ini", "section3", "key49", GUICtrlRead($Input_68))
IniWrite("last.ini", "section3", "key50", GUICtrlRead($Input_69))
IniWrite("last.ini", "section3", "key51", GUICtrlRead($Input_70))
IniWrite("last.ini", "section3", "key52", GUICtrlRead($Input_71))
IniWrite("last.ini", "section3", "key53", GUICtrlRead($Input_72))
IniWrite("last.ini", "section3", "key54", GUICtrlRead($Input_73))

WEnd
Exit