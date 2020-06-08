#NoTrayIcon

Opt ("GUICloseOnEsc", 0)
Opt ("GUIOnEventMode", 1)
Opt ("GUIResizeMode", 802)
OnAutoItExitRegister ("_EventClose")

   $sIni = @ScriptDir & "\settings.ini"

   Global Const $Pi = 3.14159265358979
   Global $ans = IniRead ($sIni, "Startup", "ans", "")

   If Not FileExists ($sIni) Then
      $hFile = FileOpen ($sIni, 2)
         FileWrite ($hFile, "[Settings]" & @CRLF & "RoundVal=2" & @CRLF & _
            "x=-1" & @CRLF & "y=-1" & @CRLF & "DefAng=deg" & @CRLF & "HelpTips=1" & @CRLF & "SnapTo=1")
      FileClose ($hFile)
   EndIf

      Global $nRndVal     = IniRead ($sIni, "Settings", "RoundVal"   , 2)
      Global $sDefAng     = IniRead ($sIni, "Settings", "DefAng"     , "deg")
      Global $bHelpTips   = IniRead ($sIni, "Settings", "HelpTips"   , 1)
      Global $bSnapTo     = IniRead ($sIni, "Settings", "SnapTo"     , 1)

   $sIni = ""
   $hFile = ""

   Global $aOps = StringSplit ("asin|acos|atan|sin|cos|tan|bitand|bitnot|bitor|bitrotate|bitshift|bitxor|round|floor|ceiling|" & _
      "int|abs|exp|log|rand|srand|random|srandom|sqrt|root|fact|rad|deg|tobase|frombase", "|")

_CreateMini ()
GUISetState (@SW_SHOW, $hMiniUI)
If $bSnapTo = 1 Then GUIRegisterMsg (0x0047, "_EventMoved")

While 1
   Sleep (1000)
WEnd

Func _CreateMini ()
   Global $hMiniUI = GUICreate ("MDiesel's Calculator!!", 205, 20, IniRead (@ScriptDir & "\settings.ini", "Settings", "x", -1), _
      IniRead (@ScriptDir & "\settings.ini", "Settings", "y", -1), 0x80000000, 0x00000008 + 0x00000080)
      GUICtrlSetDefBkColor (-2)
      GUISetBkColor (0xB0B0B0)
      GUISetOnEvent (-3, "_EventExit")

   $nGraph = GuiCtrlCreateGraphic (0, 0, 205, 20)
   For $i = 0 To 20
      GUICtrlSetGraphic (-1, 8, "0x" & StringFormat("%02X%02X%02X", 255 - 3.95 * $i, 255 - 3.95 * $i, 255 - 3.95 * $i), 0xffffff)
      GUICtrlSetGraphic (-1, 6, 0, $i)
      GUICtrlSetGraphic (-1, 2, 205, $i)
   Next
   GUICtrlSetState($nGraph, 128)

   $hMenu = GUICtrlCreateicon (@AutoitExe, 0, 2, 2, 16, 16, 0x0100)
      GUICtrlSetCursor (-1, "IDC_HAND")
      GUICtrlSetOnEvent (-1, "_EventContext")
         $hRoot = GUICtrlCreateContextMenu ($hMenu)

            GUICtrlCreateMenuItem ("&Calculate" & @TAB & "{Enter}", $hRoot)
               GUICtrlSetOnEvent (-1, "_EventMini")
            GUICtrlCreateMenuItem ("C&lear", $hRoot)
               GUICtrlSetOnEvent (-1, "_EventClear")
            GUICtrlCreateMenuItem ("", $hRoot)

            $hMenu = GUICtrlCreateMenu ("&Variables", $hRoot)
               GUICtrlCreateMenuItem ("&Pi" & @TAB & "3.141...", $hMenu)
                  GUICtrlSetOnEvent (-1, "_EventInsertVar")
               GUICtrlCreateMenuItem ("&Ans", $hMenu)
                  GUICtrlSetOnEvent (-1, "_EventInsertVar")

            $hMenu = GUICtrlCreateMenu ("&Functions", $hRoot)
               $hSub = GUICtrlCreateMenu ("&Trigonometry", $hMenu)
                  For $i = 1 to 6
                     GUICtrlCreateMenuItem ($aOps[$i], $hSub)
                        GUICtrlSetOnEvent (-1, "_EventInsertFunction")
                  Next
               $hSub = GUICtrlCreateMenu ("&Bit functions", $hMenu)
                  For $i = 7 to 12
                     GUICtrlCreateMenuItem ($aOps[$i], $hSub)
                        GUICtrlSetOnEvent (-1, "_EventInsertFunction")
                  Next
               $hSub = GUICtrlCreateMenu ("&Rounding", $hMenu)
                  For $i = 13 to 17
                     GUICtrlCreateMenuItem ($aOps[$i], $hSub)
                        GUICtrlSetOnEvent (-1, "_EventInsertFunction")
                  Next
               $hSub = GUICtrlCreateMenu ("&Logarithm", $hMenu)
                  For $i = 18 to 19
                     GUICtrlCreateMenuItem ($aOps[$i], $hSub)
                        GUICtrlSetOnEvent (-1, "_EventInsertFunction")
                  Next
               $hSub = GUICtrlCreateMenu ("&Random", $hMenu)
                  For $i = 20 to 23
                     GUICtrlCreateMenuItem ($aOps[$i], $hSub)
                        GUICtrlSetOnEvent (-1, "_EventInsertFunction")
                  Next
               $hSub = GUICtrlCreateMenu ("&Number", $hMenu)
                  For $i = 24 to 26
                     GUICtrlCreateMenuItem ($aOps[$i], $hSub)
                        GUICtrlSetOnEvent (-1, "_EventInsertFunction")
                  Next
               $hSub = GUICtrlCreateMenu ("&Conversions", $hMenu)
                  $hMenu = GUICtrlCreateMenu ("Angles", $hSub)
                     For $i = 27 to 28
                        GUICtrlCreateMenuItem ($aOps[$i], $hMenu)
                           GUICtrlSetOnEvent (-1, "_EventInsertFunction")
                     Next
                  $hMenu = GUICtrlCreateMenu ("B&ases", $hSub)
                     For $i = 29 to 30
                        GUICtrlCreateMenuItem ($aOps[$i], $hMenu)
                           GUICtrlSetOnEvent (-1, "_EventInsertFunction")
                     Next
                  $hMenu = GUICtrlCreateMenu ("&Distance", $hSub)
                     $hMenu2 = GUICtrlCreateMenu ("mi&limetres" & @TAB & "mm", $hMenu)
                        GUICtrlCreateMenuItem ("&Centimetres" & @TAB & "[mm:cm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Metres" & @TAB & "[mm:m]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Kilometres" & @TAB & "[mm:km]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&Inches" & @TAB & "[mm:in]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Feet" & @TAB & "[mm:ft]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Yards" & @TAB & "[mm:yd]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("Mil&es" & @TAB & "[mm:mi]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&CentiMetres" & @TAB & "cm", $hMenu)
                        GUICtrlCreateMenuItem ("Mi&llimetres" & @TAB & "[cm:mm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Metres" & @TAB & "[cm:m]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Kilometres" & @TAB & "[cm:km]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUIctrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&Inches" & @TAB & "[cm:in]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Feet" & @TAB & "[cm:ft]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Yards" & @TAB & "[cm:yd]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("Mil&es" & @TAB & "[cm:mi]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Metres" & @TAB & "m", $hMenu)
                        GUICtrlCreateMenuItem ("Mi&limetres" & @TAB & "[m:mm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Centimetres" & @TAB & "[m:cm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Kilometres" & @TAB & "[m:km]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUIctrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&Inches" & @TAB & "[m:in]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Feet" & @TAB & "[m:ft]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Yards" & @TAB & "[m:yd]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("Mil&es" & @TAB & "[m:mi]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&KiloMetres" & @TAB & "km", $hMenu)
                        GUICtrlCreateMenuItem ("Mi&limetres" & @TAB & "[km:mm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Centimetres" & @TAB & "[km:cm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Metres" & @TAB & "[km:m]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUIctrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&Inches" & @TAB & "[km:in]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Feet" & @TAB & "[km:ft]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Yards" & @TAB & "[km:yd]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("Mil&es" & @TAB & "[km:mi]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     GUICtrlCreateMenuItem ("", $hMenu)
                     $hMenu2 = GUICtrlCreateMenu ("&Inches" & @TAB & "in", $hMenu)
                        GUICtrlCreateMenuItem ("Mi&limetres" & @TAB & "[in:mm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Centimetres" & @TAB & "[in:cm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Metres" & @TAB & "[in:m]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&KiloMetres" & @TAB & "[in:km]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUIctrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&Feet" & @TAB & "[in:ft]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Yards" & @TAB & "[in:yd]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("Mil&es" & @TAB & "[in:mi]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Feet" & @TAB & "ft", $hMenu)
                        GUICtrlCreateMenuItem ("Mi&limetres" & @TAB & "[ft:mm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Centimetres" & @TAB & "[ft:cm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Metres" & @TAB & "[ft:m]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&KiloMetres" & @TAB & "[ft:km]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUIctrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&Inches" & @TAB & "[ft:in]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Yards" & @TAB & "[ft:yd]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("Mil&es" & @TAB & "[ft:mi]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Yards" & @TAB & "yd", $hMenu)
                        GUICtrlCreateMenuItem ("Mi&limetres" & @TAB & "[yd:mm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Centimetres" & @TAB & "[yd:cm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Metres" & @TAB & "[yd:m]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&KiloMetres" & @TAB & "[yd:km]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUIctrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&Inches" & @TAB & "[yd:in]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Feet" & @TAB & "[yd:ft]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("Mil&es" & @TAB & "[yd:mi]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("Mil&es" & @TAB & "mi", $hMenu)
                        GUICtrlCreateMenuItem ("Mi&limetres" & @TAB & "[mi:mm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Centimetres" & @TAB & "[mi:cm]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Metres" & @TAB & "[mi:m]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&KiloMetres" & @TAB & "[mi:km]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUIctrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&Inches" & @TAB & "[mi:in]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Feet" & @TAB & "[mi:ft]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Yards" & @TAB & "[mi:yd]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                  $hMenu = GUICtrlCreateMenu ("&Time", $hSub)
                     $hMenu2 = GUICtrlCreateMenu ("&Seconds" & @TAB & "s", $hMenu)
                        GUICtrlCreateMenuItem ("&Minutes" & @TAB & "[s:min]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Hours" & @TAB & "[s:h]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Days" & @TAB & "[s:day]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Weeks" & @TAB & "[s:we]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Years" & @TAB & "[s:yr]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Minutes" & @TAB & "min", $hMenu)
                        GUICtrlCreateMenuItem ("&Seconds" & @TAB & "[min:s]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Hours" & @TAB & "[min:h]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Days" & @TAB & "[min:day]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Weeks" & @TAB & "[min:we]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Years" & @TAB & "[min:yr]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Hours" & @TAB & "h", $hMenu)
                        GUICtrlCreateMenuItem ("&Seconds" & @TAB & "[h:s]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Minutes" & @TAB & "[h:min]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Days" & @TAB & "[h:day]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Weeks" & @TAB & "[h:we]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Years" & @TAB & "[h:yr]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Days" & @TAB & "day", $hMenu)
                        GUICtrlCreateMenuItem ("&Seconds" & @TAB & "[day:s]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Minutes" & @TAB & "[day:min]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Hours" & @TAB & "[day:h]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Weeks" & @TAB & "[day:we]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Years" & @TAB & "[day:yr]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Weeks" & @TAB & "we", $hMenu)
                        GUICtrlCreateMenuItem ("&Seconds" & @TAB & "[we:s]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Minutes" & @TAB & "[we:min]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Hours" & @TAB & "[we:h]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Days" & @TAB & "[we:day]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Years" & @TAB & "[we:yr]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Years" & @TAB & "yr", $hMenu)
                        GUICtrlCreateMenuItem ("&Seconds" & @TAB & "[yr:s]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Minutes" & @TAB & "[yr:min]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Hours" & @TAB & "[yr:h]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Days" & @TAB & "[yr:day]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Weeks" & @TAB & "[yr:we]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                  $hMenu = GUICtrlCreateMenu ("&Mass", $hSub)
                     $hMenu2 = GUICtrlCreateMenu ("&Ounces" & @TAB & "oz", $hMenu)
                        GUICtrlCreateMenuItem ("&Pounds" & @TAB & "[oz:lb]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Tonnes" & @TAB & "[oz:tonne]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&MilliGrams" & @TAB & "[oz:mg]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Grams" & @TAB & "[oz:g]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&KiloGrams" & @TAB & "[oz:kg]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Tons" & @TAB & "[oz:ton]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Pounds" & @TAB & "lb", $hMenu)
                        GUICtrlCreateMenuItem ("&Ounces" & @TAB & "[lb:oz]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Tonnes" & @TAB & "[lb:tonne]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&MilliGrams" & @TAB & "[lb:mg]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Grams" & @TAB & "[lb:g]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&KiloGrams" & @TAB & "[lb:kg]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Tons" & @TAB & "[lb:ton]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&tonnes" & @TAB & "tonne", $hMenu)
                        GUICtrlCreateMenuItem ("&Ounces" & @TAB & "[tonne:oz]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Pounds" & @TAB & "[tonne:lb]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&MilliGrams" & @TAB & "[tonne:mg]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Grams" & @TAB & "[tonne:g]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&KiloGrams" & @TAB & "[tonne:kg]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Tons" & @TAB & "[tonne:ton]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     GUICtrlCreateMenuItem ("", $hMenu)
                     $hMenu2 = GUICtrlCreateMenu ("&MilliGrams" & @TAB & "mg", $hMenu)
                        GUICtrlCreateMenuItem ("&Ounces" & @TAB & "[mg:oz]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Pounds" & @TAB & "[mg:lb]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Tonnes" & @TAB & "[mg:tonne]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&Grams" & @TAB & "[mg:g]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&KiloGrams" & @TAB & "[mg:kg]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Tons" & @TAB & "[mg:ton]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Grams" & @TAB & "g", $hMenu)
                        GUICtrlCreateMenuItem ("&Ounces" & @TAB & "[g:oz]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Pounds" & @TAB & "[g:lb]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Tonnes" & @TAB & "[g:tonne]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&MilliGrams" & @TAB & "[g:mg]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&KiloGrams" & @TAB & "[g:kg]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Tons" & @TAB & "[g:ton]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&KiloGrams" & @TAB & "kg", $hMenu)
                        GUICtrlCreateMenuItem ("&Ounces" & @TAB & "[kg:oz]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Pounds" & @TAB & "[kg:lb]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Tonnes" & @TAB & "[kg:tonne]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&MilliGrams" & @TAB & "[kg:mg]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Grams" & @TAB & "[kg:g]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Tons" & @TAB & "[kg:ton]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Tons" & @TAB & "ton", $hMenu)
                        GUICtrlCreateMenuItem ("&Ounces" & @TAB & "[ton:oz]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Pounds" & @TAB & "[ton:lb]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Tonnes" & @TAB & "[ton:tonne]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("", $hMenu2)
                        GUICtrlCreateMenuItem ("&MilliGrams" & @TAB & "[ton:mg]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Grams" & @TAB & "[ton:g]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&KiloGrams" & @TAB & "[ton:kg]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                  $hMenu = GUICtrlCreateMenu ("T&emperature", $hSub)
                     $hMenu2 = GUICtrlCreateMenu ("&Celsius" & @TAB & "c", $hMenu)
                        GUICtrlCreateMenuItem ("&FarenHeit" & @TAB & "[c:f]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Kelvin" & @TAB & "[c:k]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Farenheit" & @TAB & "f", $hMenu)
                        GUICtrlCreateMenuItem ("&Celsius" & @TAB & "[f:c]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Kelvin" & @TAB & "[f:k]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                     $hMenu2 = GUICtrlCreateMenu ("&Kelvin" & @TAB & "k", $hMenu)
                        GUICtrlCreateMenuItem ("&Celsius" & @TAB & "[k:c]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")
                        GUICtrlCreateMenuItem ("&Farenheit" & @TAB & "[k:f]", $hMenu2)
                           GUICtrlSetOnEvent (-1, "_EventInsertConv")

            $hMenu = GUICtrlCreateMenu ("&Settings...", $hRoot)
               $hMenu2 = GUICtrlCreateMenu ("&Angle measurement", $hMenu)
                  GUICtrlCreateMenuItem ("&Degrees", $hMenu2, 0, 1)
                     GUICtrlSetOnEvent (-1, "_EventDefAngle")
                     GUICtrlSetState (-1, 1)
                  GUICtrlCreateMenuItem ("&Radians", $hMenu2, 1, 1)
                     GUICtrlSetOnEvent (-1, "_EventDefAngle")
                     If $sDefAng = "rad" Then GUICtrlSetState (-1, 1)
               GUICtrlCreateMenuItem ("Show &Help Tips", $hMenu)
                  If $bHelpTips = 1 Then GUICtrlSetData (-1, "Hide &Help Tips")
                  GUICtrlSetOnEvent (-1, "_EventHelpTips")
               GUICtrlCreateMenuItem ("&Rounding..." & @TAB & $nRndVal, $hMenu)
                  GUICtrlSetOnEvent (-1, "_EventRounding")
               GUICtrlCreateMenuItem ("&Snap to edges off", $hMenu)
                  If $bSnapTo = 0 Then GUICtrlSetData (-1, "&Snap to edges on")
                  GUICtrlSetOnEvent (-1, "_EventSnapTo")
               GUICtrlCreateMenuItem ("", $hMenu)
               GUICtrlCreateMenuItem ("&Direct Edit", $hMenu)
                  GUICtrlSetOnEvent (-1, "_EventSettingsEdit")
            GUICtrlCreateMenuItem ("", $hRoot)
               GUICtrlCreateMenuItem ("&Help" & @TAB & "F1", $hRoot)
                  GUICtrlSetOnEvent (-1, "_EventHelp")
               GUICtrlCreateMenuItem ("E&xit" & @TAB & "Alt-F4", $hRoot)
                  GUICtrlSetOnEvent (-1, "_EventExit")

            $hRoot = ""
            $aOps = ""
            $hMenu = ""
            $hMenu2 = ""
            $hSub = ""

   Global $qInp = GUICtrlCreateInput (IniRead ($sIni, "Startup", "QstInp", ""), 19, 4, 95, 14, 2 + 16 + 128, 0)
   GUICtrlCreateButton ("=", 116, 2, 10, 17, 0x0001)
      GUICtrlSetFont (-1, 12, 700)
      GUICtrlSetOnEvent (-1, "_EventMini")
   Global $aInp = GUICtrlCreateInput (IniRead ($sIni, "Startup", "AnsInp", ""), 128, 4, 70, 14, 2048, 0)
      GUICtrlSetBkColor (-1, 0xFFFFFF)

   GUICtrlCreateLabel ("|" & @CRLF & "||" & @CRLF & "|||" & @CRLF & "|||" & @CRLF & "|||" & @CRLF & "|||" & @CRLF & "|||" & _
      @CRLF & "||" & @CRLF & "|", 199, 0, 5, 20, 0x0002, 0x00100000)
      GUICtrlSetFont (-1, 2)
      GUICtrlSetCursor (-1, 9)
EndFunc ; ==> _CreateMini

Func _EventMini ()
   If StringLen (StringRegExpReplace (GUICtrlRead ($qInp), "[^\(]", "")) <> _
      StringLen (StringRegExpReplace (GUICtrlRead ($qInp), "[^\)]", "")) Then Return 0
   If GUICtrlRead ($qInp) = "" Then
      $aVal = ""
   Else
      $aVal = _Calculate (GUICtrlRead ($qInp))
   EndIf
   If @Error <> 0 Then
      Return GUICtrlSetData ($aInp, "ERR#" & @ERROR)
   ElseIf @Extended <> 0 Then
      If Execute ($aVal) = 1 Then Return GUICtrlSetData ($aInp, "True")
      Return GUICtrlSetData ($aInp, "False")
   ElseIf (StringRight ($aVal, 4) = "#IND") Then
      $aVal = 0
      Return GUICtrlSetData ($aInp, "ERR#IND")
   ElseIf (StringLeft (StringRight ($aVal, 4), 1) = "#") Then
      GUICtrlSetData ($aInp, "ERR#" & StringRight ($aVal, 3)
      $aVal = 0
      Return
   EndIf
   $ans = $aVal
   GUICtrlSetData ($aInp, $aVal)
EndFunc ; ==> _EventMini

Func _EventHelp ()
   ShellExecute (@ScriptDir & "\help.chm")
EndFunc ; ==> _EventHelp

Func _EventClear ()
   GUICtrlSetData ($aInp, "")
   GUICtrlSetData ($qInp, "")
   $ans = ""
EndFunc ; ==> _EventClear

Func _EventDefAngle ()
   $sDefAng = StringLeft (StringTrimLeft (GUICtrlRead (@GUI_CTRLID, 1), 1), 3)
EndFunc ; ==> _EventDefAngle

Func _EventMoved ($hWnd, $msgID, $lParam, $wParam)
   $aPos = WinGetPos ($hMiniUI, "")
   If $aPos[0] < 15 Then $aPos[0] = 0
   If $aPos[0] > @DeskTopWidth - 220 Then $aPos[0] = @DesktopWidth - 205
   If $aPos[1] < 15 Then $aPos[1] = 0
   If $aPos[1] > @DesktopHeight - 45 - $aPos[3] Then $aPos[1] = @DesktopHeight - 30 - $aPos[3]
   WinMove ($hMiniUI, "", $aPos[0], $aPos[1])
EndFunc ; ==> _EventMoved

Func _EventContext ()
   DllCall("user32.dll", "ptr", "SendMessage", "hwnd", ControlGetHandle (@GUI_WINHANDLE, "", @GUI_CTRLID), "int", 0x007B, "int", _
      @GUI_CTRLID, "int", 0)
EndFunc ; ==> _EventContext

Func _EventSettingsEdit ()
   $aPos = WinGetPos ($hMiniUI, "")
   $sString = "[Settings]" & @CRLF & "RoundVal=" & _
         $nRndVal & @CRLF & "x=" & $aPos[0] & @CRLF & "y=" & $aPos[1] & @CRLF & "DefAng=" & $sDefAng
   $hFile = FileOpen (@ScriptDir & "\settings.ini", 2)
      FileWrite ($hFile, $sString)
   FileClose ($hFile)

   ShellExecute (@ScriptDir & "\settings.ini")
EndFunc ; ==> _EventSettingsEdit

Func _EventInsertFunction ()
   Local $p = DllStructCreate ("int;int")

   $Msg = GUICtrlSendMsg ($qInp, 0xB0, DllStructGetPtr ($p, 1), DllStructGetPtr ($p, 2))
   $hData = GUICtrlRead ($qInp)
   GUICtrlSendMsg ($qInp, 0xC2, True, GUICtrlRead (@GUI_CTRLID, 1) & "(" & _
      StringTrimRight (StringTrimLeft ($hData, DllStructGetData ($p, 1)), DllStructGetdata ($p, 2) - StringLen ($hData)) & ")")

   $anPos = WinGetPos ($hMiniUI, "")
   If Not $bHelpTips Then Return
   ToolTip ("A function was just added to the field." & @CR & @CR & _
      "For Example: ""sin(30)"" is calling the sin function with a single parameter of 5." & @CR & _
      "To call multiple parameters, seperate them with a comma - "","" eg. ""ToBase(42,2)""", _
      $anPos[0] + 160, $anPos[1] + 20, "Mini Calculator Help", 1, 7)
   AdlibEnable ("_TooltipsOff", 4000)
EndFunc ; ==> _EventInsertFunction

Func _EventInsertVar ()
   GUICtrlSetData ($qInp, StringRegExpReplace (StringReplace (GUICtrlRead (@GUI_CTRLID, 1), "&", ""), @TAB & ".*", ""), 1)

   If Not $bHelpTips Then Return
   $anPos = WinGetPos ($hMiniUI, "")
   ToolTip ("A Variable was just added to the field." & @CR & @CR & _
      "For Example: ""pi"" Will be replaced with the value of pi: 3.141....", _
      $anPos[0] + 160, $anPos[1] + 20, "Mini Calculator Help", 1, 7)
   AdlibEnable ("_TooltipsOff", 4000)
EndFunc ; ==> _EventInsertVar

Func _EventInsertConv ()
   GUICtrlSetData ($qInp, StringRegExpReplace (StringReplace (GUICtrlRead (@GUI_CTRLID, 1), "&", ""), ".*" & @TAB, ""), 1)

   If Not $bHelpTips Then Return
   $anPos = WinGetPos ($hMiniUI, "")
   ToolTip ("A Post unary Operator was just added to the field." & @CR & @CR & _
      "For Example: ""146[cm:m]"" Will convert 146cm to m, giving you 1.46", _
      $anPos[0] + 160, $anPos[1] + 20, "Mini Calculator Help", 1, 7)
   AdlibEnable ("_TooltipsOff", 4000)
EndFunc ; ==> _EventInsertVar

Func _EventHelpTips ()
   If $bHelpTips = 1 Then
      $bHelpTips = 0
      GUICtrlSetData (@GUI_CTRLID, "Show &Help Tips")
      _ToolTipsOff ()
   Else
      $bHelpTips = 1
      GUICtrlSetData (@GUI_CTRLID, "Hide &Help Tips")
   EndIf
EndFunc ; ==> _EventHelpTips

Func _EventSnapTo ()
   If $bSnapTo = 0 Then
      $bSnapTo = 1
      GUIRegisterMsg (0x0047, "_EventMoved")
   Else
      $bSnapTo = 0
      GUIRegisterMsg (0x0047, "")
   EndIf
EndFunc ; ==> _EventSnapTo

Func _EventRounding ()
   GUISetState (@SW_DISABLE)
   GUICreate ("Rounding...", 168, 48, -1, -1, 0x00000080 + 0x00080000 + 0x00C00000, 0x00000001)
   GUICtrlCreateLabel ("Rounding Value:", 2, 4, 80, 20, 0x0002)
   $inp = GUICtrlCreateInput ($nRndVal, 84, 2, 40, 20)
      GUICtrlCreateUpDown ($inp)
         GUICtrlSetLimit (-1, 15, -15)
   GUICtrlCreateLabel ("Max. 15", 126, 4, 40, 20)
   $hDone = GUICtrlCreateButton ("OK", 84, 24, 80, 20)
   $hCanc = GUICtrlCreateButton ("Cancel", 2, 24, 80, 20)
   GUISetState ()
   Opt ("GUIOnEventMode", 0)
   While 1
      $Msg = GUIGetMsg (1)
      Select
         Case $msg[0] = $hCanc
            ExitLoop
         Case $msg[0] = -3
            If $msg[1] = $hMiniUI Then
               Exit
            Else
               ExitLoop
            Endif
         Case $msg[0] = $hDone
            $nRndVal = GUICtrlRead ($inp)
            ExitLoop
      EndSelect
   WEnd
   GUIDelete ()
   GUISetState (@SW_ENABLE, $hMiniUI)
   Opt ("GUIOnEventMode", 1)
EndFunc ; ==> _EventRounding

Func _Calculate ($sCalc)
   $sCalc = StringStripWS ($sCalc, 8)
   ;$sCalc = StringReplace ($sCalc, "!=", "<>") colliding with factorial... eg: 4!=24 could be true or false
   ;$sCalc = StringReplace ($sCalc, "++", "+1")
   ;$sCalc = StringReplace ($sCalc, "--", "-1")
   $sCalc = StringReplace ($sCalc, "==", "=")
   $sCalc = StringReplace ($sCalc, "pi", $Pi)
   $sCalc = StringReplace ($sCalc, "ans", $Ans)
      $sCalc = StringRegExpReplace ($sCalc, "sqrt\(([^\)]*)\)", "\(\1\^0\.5\)")
      $sCalc = StringRegExpReplace ($sCalc, "([0-9]*)!", "fact\(\1\)")
      $sCalc = StringRegExpReplace ($sCalc, "([0-9]*)%([0-9]*)", "\(mod\(\1\,\2\)\)")
      $sCalc = StringRegExpReplace ($sCalc, "([0-9]*)b>([0-9]*)", "\(tobase\(\1\,\2\)\)")
      $sCalc = StringRegExpReplace ($sCalc, "([0-9]*)b([0-9]*)", "\(tobase\(\1\,\2\)\)")
      $sCalc = StringRegExpReplace ($sCalc, "([0-9]*)b<([0-9]*)", "\(frombase\(\1\,\2\)\)")
      $sCalc = StringRegExpReplace ($sCalc, "([0-9]*\[.*?\])", "_Conversion\(""\1""\)")
      $sCalc = StringReplace ($sCalc, "sin" , "_sin" )
      $sCalc = StringReplace ($sCalc, "asin", "_asin")
      $sCalc = StringReplace ($sCalc, "cos" , "_cos" )
      $sCalc = StringReplace ($sCalc, "acos", "_acos")
      $sCalc = StringReplace ($sCalc, "tan" , "_tan" )
      $sCalc = StringReplace ($sCalc, "atan", "_atan")
   If StringinStr ($sCalc, "=") Or StringRegExp ($sCalc, "[^b][<;>]") = 1 Then Return SetExtended (1, $sCalc)
   $sCalc = Execute ($sCalc)
   Return SetError (@ERROR, @EXTENDED, Round ($sCalc, $nRndVal))
EndFunc ; ==> _Calculate

Func _EventExit ()
   Global $aPos = WinGetPos ($hMiniUI, "")
   Exit
EndFunc ; ==> _EventExit

Func _EventClose ()
   GUISetState ($hMiniUI, @SW_HIDE)
   GUIRegisterMsg (0x0111, "")
   $sString = "[Settings]" & @CRLF & "RoundVal=" & _
         $nRndVal & @CRLF & "x=" & $aPos[0] & @CRLF & "y=" & $aPos[1] & @CRLF & "DefAng=" & $sDefAng & @CRLF & _
         "SnapTo=" & $bSnapTo & @CRLF & @CRLF & "[StartUp]" & @CRLF & "ans=" & $ans & @CRLF & "AnsInp=" & _
         GUICtrlRead ($aInp) & @CRLF & "QstInp=" & GUICtrlRead ($qInp)
   $hFile = FileOpen (@ScriptDir & "\settings.ini", 2)
      FileWrite ($hFile, $sString)
   FileClose ($hFile)
EndFunc ; ==> _EventClose

Func _TooltipsOff ()
   Tooltip ("")
EndFunc ; ==> _TooltipsOff

Func fact ($iNum)
   $x = 1
   For $i = 1 to $inum
      $x *= $i
   Next
   Return $x
EndFunc ; ==> fact

Func rad ($iDeg)
   Return $iDeg * ($pi/180)
EndFunc ; ==> rad

Func deg ($iRad)
   Return $iRad / ($pi/180)
EndFunc ; ==> deg

Func tobase ($iNumber, $iBase, $iPad = 1)
   If $iBase < 2 And $iBase > 36 Then Return 0
   Local $sRet = "", $iDigit
   Do
      $iDigit = Mod ($iNumber, $iBase)
      $sRet = Chr (48 + $iDigit + 7 * ($iDigit > 9)) & $sRet
      $iNumber = Int ($iNumber / $iBase)
   Until ($iNumber = 0) And (StringLen ($sRet) >= $iPad)
   Return $sRet
EndFunc ; ==> tobase

Func frombase ($sNumber, $iBase)
   Local $iRet = 0, $sChar
   Do
      $iRet *= $iBase
      $sChar = StringLeft ($sNumber, 1)
      $iRet += Asc ($sChar) + 7 * (Asc($sChar) < 58) - 55
      $sNumber = StringMid ($sNumber, 2)
   Until $sNumber = ""
   Return $iRet
EndFunc ; ==> frombase

Func root($fNum, $nExp = 3)
   Local $bNeg = False, $fRet = 0
   If $nExp < 0 Then Return SetError (1, 0, $fNum)

   If $fNum < 0 Then ; is negative
      If Mod($nExp, 2) Then ; nExp is odd, so negative IS possible.
         $bNeg = True
         $fNum *= -1
      Else
         Return SetError(1, 0, $fNum & "i") ; Imaginary number.
      EndIf
   EndIf

   $fRet = $fNum ^ (1 / $nExp)
   If $bNeg Then $fRet *= -1
   Return $fRet
EndFunc ; ==> root

Func _sin ($nIn)
   If $sDefAng = "deg" Then $nIn = rad ($nIn)
   $nIn = sin ($nIn)
   If $sDefAng = "rad" Then $nIn = rad ($nIn)
   Return $nIn
EndFunc ; ==> _sin

Func _asin ($nIn)
   If $sDefAng = "deg" Then $nIn = rad ($nIn)
   $nIn = asin ($nIn)
   If $sDefAng = "rad" Then $nIn = rad ($nIn)
   Return $nIn
EndFunc ; ==> _asin

Func _cos ($nIn)
   If $sDefAng = "deg" Then $nIn = rad ($nIn)
   $nIn = cos ($nIn)
   If $sDefAng = "rad" Then $nIn = rad ($nIn)
   Return $nIn
EndFunc ; ==> _cos

Func _acos ($nIn)
   If $sDefAng = "deg" Then $nIn = rad ($nIn)
   $nIn = acos ($nIn)
   If $sDefAng = "rad" Then $nIn = rad ($nIn)
   Return $nIn
EndFunc ; ==> _acos

Func _tan ($nIn)
   If $sDefAng = "deg" Then $nIn = rad ($nIn)
   $nIn = tan ($nIn)
   If $sDefAng = "rad" Then $nIn = rad ($nIn)
   Return $nIn
EndFunc ; ==> _tan

Func _atan ($nIn)
   If $sDefAng = "deg" Then $nIn = rad ($nIn)
   $nIn = atan ($nIn)
   If $sDefAng = "rad" Then $nIn = rad ($nIn)
   Return $nIn
EndFunc ; ==> _atan

Func min ($nNum1, $nNum2)
   If $nNum1 < $nNum2 Then Return $nNum1
   Return $nNum2
EndFunc ; ==> min

Func max ($nNum1, $nNum2)
   If $nNum1 > $nNum2 Then Return $nNum1
   Return $nNum2
EndFunc ; ==> max

Func _Conversion ($sString)
   $nVal = StringRegExpReplace ($sString, "\[.*", "")
   $sFrom = StringRegExpReplace ($sString, ".*\[(.*):.*\]", "\1")
   $sTo = StringRegExpReplace ($sString, ".*\[.*:(.*)\]", "\1")
   Switch $sFrom
      Case "mm"
         Switch $sTo
            Case "cm"
               Return $nVal / 10
            Case "m"
               Return $nVal / 1000
            Case "km"
               Return $nVal / 1000000
            Case "in"
               Return $nVal * 0.0393700787401575
            Case "ft"
               Return $nVal * 0.00328083989501312
            Case "yd"
               Return $nVal * 0.00109361329833771
            Case "mi"
               Return $nVal * 6.21371192237334 / 10000000
            Case Else
               Return 0
         EndSwitch
      Case "cm"
         Switch $sTo
            Case "mm"
               Return $nVal * 10
            Case "m"
               Return $nVal / 100
            Case "km"
               Return $nVal / 100000
            Case "in"
               Return $nVal * 0.393700787401575
            Case "ft"
               Return $nVal * 0.0328083989501312
            Case "yd"
               Return $nVal * 0.0109361329833771
            Case "mi"
               Return $nVal * 6.21371192237334 / 1000000
            Case Else
               Return 0
         EndSwitch
      Case "m"
         Switch $sTo
            Case "mm"
               Return $nVal * 1000
            Case "cm"
               Return $nVal * 100
            Case "km"
               Return $nVal / 1000
            Case "in"
               Return $nVal * 39.3700787401575
            Case "ft"
               Return $nVal * 3.28083989501312
            Case "yd"
               Return $nVal * 1.09361329833771
            Case "mi"
               Return $nVal * 0.000621371192237334
            Case Else
               Return 0
         EndSwitch
      Case "km"
         Switch $sTo
            Case "mm"
               Return $nVal * 1000000
            Case "cm"
               Return $nVal * 100000
            Case "m"
               Return $nVal * 1000
            Case "in"
               Return $nVal * 39370.0787401575
            Case "ft"
               Return $nVal * 3280.83989501312
            Case "yd"
               Return $nVal * 1093.61329833771
            Case "mi"
               Return $nVal * 0.621371192237334
            Case Else
               Return 0
         EndSwitch
      Case "in"
         Switch $sTo
            Case "mm"
               Return $nVal * 25.4
            Case "cm"
               Return $nVal * 2.54
            Case "m"
               Return $nVal * 0.0254
            Case "km"
               Return $nVal * 2.54 / 100000
            Case "ft"
               Return $nVal / 12
            Case "yd"
               Return $nVal / 36
            Case "mi"
               Return $nVal * 1.57828282828283 / 100000
            Case Else
               Return 0
         EndSwitch
      Case "ft"
         Switch $sTo
            Case "mm"
               Return $nVal * 304.8
            Case "cm"
               Return $nVal * 30.48
            Case "m"
               Return $nVal * 0.3048
            Case "km"
               Return $nVal * 0.0003048
            Case "in"
               Return $nVal * 12
            Case "yd"
               Return $nVal * 3
            Case "mi"
               Return $nVal / 5280
            Case Else
               Return 0
         EndSwitch
      Case "yd"
         Switch $sTo
            Case "mm"
               Return $nVal * 914.4
            Case "cm"
               Return $nVal * 91.44
            Case "m"
               Return $nVal * 914.4
            Case "km"
               Return $nVal * 0.0009144
            Case "in"
               Return $nVal * 36
            Case "ft"
               Return $nVal * 3
            Case "mi"
               Return $nVal / 1760
            Case Else
               Return 0
         EndSwitch
      Case "mi"
         Switch $sTo
            Case "mm"
               Return $nVal * 1609344
            Case "cm"
               Return $nVal * 160934.4
            Case "m"
               Return $nVal * 1609.344
            Case "km"
               Return $nVal * 1.609344
            Case "in"
               Return $nVal * 63360
            Case "ft"
               Return $nVal * 5280
            Case "yd"
               Return $nVal * 1760
            Case Else
               Return 0
         EndSwitch
      Case "s"
         Switch $sTo
            Case "min"
               Return $nVal / 60
            Case "h"
               Return $nVal / 360
            Case "day"
               Return $nVal / 8640
            Case "we"
               Return $nVal / 60480
            Case "yr"
               Return $nVal / 22090320
            Case Else
               Return 0
         EndSwitch
      Case "min"
         Switch $sTo
            Case "s"
               Return $nVal * 60
            Case "h"
               Return $nVal / 60
            Case "day"
               Return $nVal / 1440
            Case "we"
               Return $nVal / 10080
            Case "yr"
               Return $nVal / 3681720
            Case Else
               Return 0
         EndSwitch
      Case "h"
         Switch $sTo
            Case "s"
               Return $nVal * 360
            Case "min"
               Return $nVal * 60
            Case "day"
               Return $nVal / 24
            Case "we"
               Return $nVal / 168
            Case "yr"
               Return $nVal / 61362
            Case Else
               Return 0
         EndSwitch
      Case "day"
         Switch $sTo
            Case "s"
               Return $nVal * 4320
            Case "min"
               Return $nVal * 1440
            Case "h"
               Return $nVal * 24
            Case "we"
               Return $nVal / 7
            Case "yr"
               Return $nVal / 365.25
            Case Else
               Return 0
         EndSwitch
      Case "we"
         Switch $sTo
            Case "s"
               Return $nVal * 604800
            Case "min"
               Return $nVal * 10080
            Case "h"
               Return $nVal * 168
            Case "day"
               Return $nVal * 7
            Case "yr"
               Return $nVal / 52
            Case Else
               Return 0
         EndSwitch
      Case "yr"
         Switch $sTo
            Case "s"
               Return $nVal * 22090320
            Case "min"
               Return $nVal * 525960
            Case "h"
               Return $nVal * 8766
            Case "day"
               Return $nVal * 365.25
            Case "we"
               Return $nVal * 52
            Case Else
               Return 0
         EndSwitch
      Case "oz"
         Switch $sTo
            Case "lb"
               Return $nVal * 6.25 * (10^2)
            Case "tonne"
               Return $nVal * 2.83495231 * (10^-5)
            Case "mg"
               Return $nVal * 2.8349523125 * (10^4)
            Case "g"
               Return $nVal * 2.8349523125 * (10^1)
            Case "kg"
               Return $nVal * 2.8349523125 * (10^-1)
            Case "ton"
               Return $nVal * 3.125 * (10^-5)
            Case Else
               Return 0
         EndSwitch
      Case "lb"
         Switch $sTo
            Case "oz"
               Return $nVal * 16
            Case "ton"
               Return $nVal * 5 * (10^-4)
            Case "mg"
               Return $nVal * 45359237 * (10^5)
            Case "g"
               Return $nVal * 4.5359237 * (10^2)
            Case "kg"
               Return $nVal * 4.5359237 * (10^-1)
            Case "tonne"
               Return $nVal * 4.5359237 * (10^-4)
            Case Else
               Return 0
         EndSwitch
      Case "ton"
         Switch $sTo
            Case "oz"
               Return $nVal * 32000
            Case "lb"
               Return $nVal * 2000
            Case "mg"
               Return $nVal * 907184740
            Case "g"
               Return $nVal * 907184.74
            Case "kg"
               Return $nVal * 907.18474
            Case "tonne"
               Return $nVal * 0.90718474
            Case Else
               Return 0
         EndSwitch
      Case "mg"
         Switch $sTo
            Case "oz"
               Return $nVal * 3.52739619495804 / 100000
            Case "lb"
               Return $nVal * 2.20462262184878 / 1000000
            Case "ton"
               Return $nVal * 1.10231131092439 / 1000000000
            Case "g"
               Return $nVal / 1000
            Case "kg"
               Return $nVal / 1000000
            Case "tonne"
               Return $nVal / 1000000000
            Case Else
               Return 0
         EndSwitch
      Case "g"
         Switch $sTo
            Case "oz"
               Return $nVal * 0.03527396194958
            Case "lb"
               Return $nVal * 0.00220462262184
            Case "ton"
               Return $nVal * 1.10231131092439 / 1000000
            Case "mg"
               Return $nVal * 1000
            Case "kg"
               Return $nVal / 1000
            Case "tonne"
               Return $nVal / 1000000
            Case Else
               Return 0
         EndSwitch
      Case "kg"
         Switch $sTo
            Case "oz"
               Return $nVal * 35.2739619495804
            Case "lb"
               Return $nVal * 2.20462262184878
            Case "ton"
               Return $nVal * 0.001102311310924
            Case "mg"
               Return $nVal * 1000000
            Case "g"
               Return $nVal * 1000
            Case "tonne"
               Return $nVal / 1000
            Case Else
               Return 0
         EndSwitch
      Case "tonne"
         Switch $sTo
            Case "oz"
               Return $nVal * 35273.9619
            Case "lb"
               Return $nVal * 2204.62262
            Case "ton"
               Return $nVal * 1.10231131
            Case "mg"
               Return $nVal * 1000000000
            Case "g"
               Return $nVal * 1000000
            Case "kg"
               Return $nVal * 1000
            Case Else
               Return 0
         EndSwitch
      Case "c"
         Switch $sTo
            Case "f"
               Return ($nVal + 32) * (9 / 5)
            Case "k"
               Return $nVal + 273
            Case Else
               Return 0
         EndSwitch
      Case "f"
         Switch $sTo
            Case "c"
               Return ($nVal - 32) * (5 / 9)
            Case "k"
               Return ($nVal - 32) * (5 / 9) + 273
            Case Else
               Return 0
         EndSwitch
      Case "k"
         Switch $sTo
            Case "c"
               Return $nVal - 273
            Case "f"
               Return ($nVal - 273) * (9 / 5) + 32
            Case Else
               Return 0
         EndSwitch
      Case Else
         Return 0
   EndSwitch
EndFunc ; ==> _Conversion