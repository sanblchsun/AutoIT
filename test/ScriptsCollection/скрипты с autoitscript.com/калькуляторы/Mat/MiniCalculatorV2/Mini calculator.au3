#NoTrayIcon

Opt ("GUIOnEventMode", 1)

Global Const $Pi = 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679821480865132851
Global $aOps[27] = ["asin", "acos", "atan", "sin", "cos", "tan", "bitand", "bitnot", "bitor", "bitrotate", "bitshift", "fact", _
   "bitxor", "ceiling", "exp", "floor", "log", "srandom", "round", "sqrt", "random", "abs", "rad", "deg", "tobase", "frombase"]

   Global $nBool = IniRead (@ScriptDir & "\settings.ini", "Settings", "AllowBool", 1)
   Global $iAdv = IniRead (@ScriptDir & "\settings.ini", "Settings", "Advanced", 1)
   Global $nRndVal = IniRead (@ScriptDir & "\settings.ini", "Settings", "RoundVal", 2)
   Global $x = IniRead (@ScriptDir & "\settings.ini", "Settings", "x", -1)
   Global $y = IniRead (@ScriptDir & "\settings.ini", "Settings", "y", -1)
   Global $sDefAng = IniRead (@ScriptDir & "\settings.ini", "Settings", "DefAng", "deg")
      If $sDefAng = "rad" Then $sDefAng = ""

If Not FileExists (@ScriptDir & "\settings.ini") Then
   $hFile = FileOpen (@ScriptDir & "\settings.ini", 2)
      FileWrite ($hFile, "[Settings]" & @CRLF & "AllowBool=1" & @CRLF & "Advanced=1" & @CRLF &  "RoundVal=2" & @CRLF & "x=-1" & _
         @CRLF & "y=-1" & @CRLF & "DefAng=deg")
   FileFlush ($hFile)
EndIf

_MiniMode ()

Func _MiniMode ()
   Global $hMiniUI = GUICreate ("MDiesel's Calculator!!", 205, 20, $x, $y, 0x80000000, 0x00000008 + 0x00000080)
      GUISetBkColor (0xDDE7FF)
      GUICtrlSetDefBkColor (-2)
      AdlibRegister ("_EmptyWorkingSet", 1000)

   GUICtrlCreateicon ("Shell32.dll", 28, 188, 1, 16, 17, 0x0100)
      GUICtrlSetCursor (-1, "IDC_HAND")
      GUICtrlSetOnEvent (-1, "_EventClose")

   GUICtrlCreateLabel ("|" & @CRLF & "||" & @CRLF & "|||" & @CRLF & "|||" & @CRLF & "|||" & @CRLF & "|||" & @CRLF & "|||" & @CRLF & "||" & @CRLF & "|", 0, 0, 5, 20, -1, 0x00100000)
      GUICtrlSetFont (-1, 2)
      GUICtrlSetCursor (-1, 9)

   Global $qInp = GUICtrlCreateInput ("", 7, 2, 100, 17, 2 + 16 + 128)
      Global $qVal = ""
   GUICtrlCreateLabel ("=", 109, 2, 5, 17, 0x0100)
      GUICtrlSetOnEvent (-1, "_Settings")
   Global $aInp = GUICtrlCreateInput ("", 116, 2, 70, 17, 2048)
      GUICtrlSetBkColor (-1, 0xFFFFFF)

   GUISetState (@SW_SHOW, $hMiniUI)

   $aPos = WinGetPos ($hMiniUI, "")
   Global $hSetUI = GUICreate ("Settings", 205, 172, $aPos[0], $aPos[1] + 20, 0x80880000, 0x00000088)
      GUIRegisterMsg (0x0047, "_Moved")
      GUIRegisterMsg (0x0111, "_Event")
      GUISetBkColor (0xDDE7FF)
      GUICtrlSetDefBkColor (-2)
      GUICtrlCreateicon ("Shell32.dll", 255, 186, 3, 16, 17, 0x0100)
         GUICtrlSetCursor (-1, "IDC_HAND")
         GUICtrlSetOnEvent (-1, "_Settings")
      GUICtrlCreateButton ("DirectEdit", 2, 2, 180, 20)
         GUICtrlSetOnEvent (-1, "_EventSettingsEdit")
      GUICtrlCreateGroup ("Allow Boolean Results?", 2, 24, 196, 35)
         GUICtrlCreateRadio ("Yes", 8, 36, 80, 20)
            GUICtrlSetState (-1, 1)
         GUICtrlCreateRadio ("No", 93, 36, 80, 20)
            If $nBool = 0 Then GUICtrlSetState (-1, 1)
      GUICtrlCreateGroup ("Allow advanced Functions?", 2, 60, 196, 35)
         GUICtrlCreateRadio ("Yes", 8, 72, 80, 20)
            GUICtrlSetState (-1, 1)
         GUICtrlCreateRadio ("No", 93, 72, 80, 20)
            If $iAdv = 0 Then GUICtrlSetState (-1, 1)
      GUICtrlCreateGroup ("Round to: ", 2, 96, 196, 35)
         Global $hDec = GUICtrlCreateInput ($nRndVal, 8, 108, 80, 17)
            GUICtrlSetLimit (-1, 2)
            GUICtrlCreateUpDown ($hDec)
               GUICtrlSetLimit (-1, 99)
         GUICtrlCreateLabel ("Decimal Places.", 93, 110, 80, 20)
      GUICtrlCreateGroup ("Default Angle measurement", 2, 132, 196, 35)
         GUICtrlCreateRadio ("Deg", 8, 144, 80, 20)
            GUICtrlSetState (-1, 1)
         GUICtrlCreateRadio ("Rad", 93, 144, 80, 20)
            If $sDefAng = "rad" Then GUICtrlSetState (-1, 1)


   While 1
      Sleep (5000)
   WEnd
EndFunc ; ==> Minimode

Func _Calculate ($sCalc)
   $sCalc = StringStripWS ($sCalc, 8)
   $sCalc = StringReplace ($sCalc, "!=", "<>")
   $sCalc = StringReplace ($sCalc, "++", "+1")
   $sCalc = StringReplace ($sCalc, "--", "-1")
   $sCalc = StringReplace ($sCalc, "==", "=")
   If $iAdv Then
      $sCalc = StringRegExpReplace ($sCalc, "sqrt\(([^\)]*)\)", "\(\1\^0\.5\)")
      $sCalc = StringRegExpReplace ($sCalc, "([0-9]*)!", "fact\(\1\)")
      $sCalc = StringRegExpReplace ($sCalc, "([0-9]*)%([0-9]*)", "\(mod\(\1\,\2\)\)")
      $sCalc = StringRegExpReplace ($sCalc, "([0-9]*)b>([0-9]*)", "\(tobase\(\1\,\2\)\)")
      $sCalc = StringRegExpReplace ($sCalc, "([0-9]*)b([0-9]*)", "\(tobase\(\1\,\2\)\)")
      $sCalc = StringRegExpReplace ($sCalc, "([0-9]*)b<([0-9]*)", "\(frombase\(\1\,\2\)\)")
      $sCalc = StringRegExpReplace ($sCalc, "(sin\([^\)]*\))", $sDefAng & "\(\1\)")
      $sCalc = StringRegExpReplace ($sCalc, "(asin\([^\)]*\))", $sDefAng & "\(\1\)")
      $sCalc = StringRegExpReplace ($sCalc, "(cos\([^\)]*\))", $sDefAng & "\(\1\)")
      $sCalc = StringRegExpReplace ($sCalc, "(acos\([^\)]*\))", $sDefAng & "\(\1\)")
      $sCalc = StringRegExpReplace ($sCalc, "(tan\([^\)]*\))", $sDefAng & "\(\1\)")
      $sCalc = StringRegExpReplace ($sCalc, "(atan\([^\)]*\))", $sDefAng & "\(\1\)")
      For $i = 0 to UBound ($aOps) - 1
         If StringRegExp ($sCalc, $aOps[$i]) <> 0 Then
            $n = StringRegExp ($sCalc, $aOps[$i] & "\(([^\)]*)\)", 3)
            For $x = 0 to UBound ($n, 1) - 1
               If StringInStr ($n[$x], ",") Then
                  $nSplit = StringSplit ($n[$x], ",")
                  For $s = 1 to $nSplit[0]
                     $n[$x] &= Execute ($nSplit[$s])
                  Next
               Else
                  $n[$x] = Execute ($n[$x])
               EndIf
               $sCalc = StringReplace ($sCalc, $aOps[$i] & "(" & $n[$x] & ")", Execute ($aOps[$i] & "(" & $n[$x] & ")"))
            Next
            ExitLoop
         EndIf
      Next
      If StringInStr ($sCalc, "mod") Then
         $n = StringRegExp ($sCalc, $aOps[$i] & "\(([^\)]*)\)", 3)
         For $i = 0 to UBound ($n, 1) - 1
            $sCalc = StringReplace ($sCalc, $aOps[$i] & "(" & $n[$i] & ")", Execute ($aOps[$i]) & (Execute ($n[$i])))
         Next
      EndIf
      $sCalc = StringReplace ($sCalc, "pi", $Pi)
      If StringRegExp ($sCalc, "[:alpha:]*\([^\)]*\)") Then Return SetError (1, 0, "Unknown Function")
   EndIf
   If StringinStr ($sCalc, "=") Or StringRegExp ($sCalc, "[^b][<;>]") = 1 Then ; operator used, return bool
      $sCalc = Execute ($sCalc)
      If $sCalc = 1 Then Return SetExtended (1, "True")
      Return SetExtended (1, "False")
   EndIf
   Return Round (Execute ($sCalc), $nRndVal)
EndFunc ; ==> _Calculate

Func _Event ($hWnd, $msgId, $lParam, $wParam)
   If $hWnd = $hMiniUI Then
      If $msgId = 273 And $lParam = 0x04000005 Then
         If StringRegExp (StringRight (GUICtrlRead ($qInp), 1), "[^0-9;\);i;!]") Then Return "GUI_RunDefMsg"
         If StringLen (StringRegExpReplace (GUICtrlRead ($qInp), "[^\(]", "")) <> StringLen (StringRegExpReplace (GUICtrlRead ($qInp), "[^\)]", "")) Then Return "GUI_RunDefMsg"
         $qVal = GUICtrlRead ($qInp)
         $aVal = _Calculate ($qVal)
         If @Error <> 0 Then
             MsgBox (16, "Error - " & @Error, $aVal)
         ElseIf @Extended <> 0 Then
            If $nBool Then
               $aVal = "BOOL: " & $aVal
            Else
               GUISetState (@SW_HIDE, $hMiniUI)
               GUISetState (@SW_HIDE, $hSetUI)
               MsgBox (16, "Error - 42", "Incorrect input value: input contained =, < or >.")
               GUICtrlSetData ($qInp, "")
               GUICtrlSetData ($aInp, "")
               GUISetState (@SW_SHOW, $hMiniUI)
               GUISetState (@SW_SHOW, $hSetUI)
            EndIf
         EndIf
         GUICtrlSetData ($aInp, $aVal)
      EndIf
   Else
      Switch $lParam
         Case 0x0000000B ; bool yes
            $nBool = 1
         Case 0x0000000C ; bool no
            $nBool = 0
         Case 0x0000000E ; adv yes
            $iAdv = 1
         Case 0x0000000F ; adv no
            $iAdv = 0
         Case 0x02000011 ; dec
            $nRndVal = GUICtrlRead ($hDec)
         Case 0x00000015 ; deg
            $sDefAng = "deg"
         Case 0x00000016 ; rad
            $sDefAng = ""
      EndSwitch
   EndIf
   Return "GUI_RunDefMsg"
EndFunc ; ==> _Event

Func _EventClose ()
   $aPos = WinGetPos ("MDiesel's Calculator!!", "")
   $hFile = FileOpen (@ScriptDir & "\settings.ini", 2)
      FileWrite ($hFile, "[Settings]" & @CRLF & "AllowBool=" & $nBool & @CRLF & "Advanced=" & $iAdv & @CRLF &  "RoundVal=" & _
         $nRndVal & @CRLF & "x=" & $aPos[0] & @CRLF & "y=" & $aPos[1] & @CRLF & "DefAng=" & $sDefAng)
   FileFlush ($hFile)
   Exit
EndFunc ; ==> _EventClose

Func _Settings ()
   If BitAnd (WinGetState ($hSetUI, ""), 2) Then
      GUISetState (@SW_HIDE, $hSetUI)
   Else
      GUISetState (@SW_SHOW, $hSetUI)
   EndIf
EndFunc ; ==> _Settings

Func _EventSettingsEdit ()
   $aPos = WinGetPos ("MDiesel's Calculator!!", "")
   $hFile = FileOpen (@ScriptDir & "\settings.ini", 2)
      FileWrite ($hFile, "[Settings]" & @CRLF & "AllowBool=" & $nBool & @CRLF & "Advanced=" & $iAdv & @CRLF & "RoundVal=" & _
         $nRndVal & @CRLF & "x=" & $aPos[0] & @CRLF & "y=" & $aPos[1] & @CRLF & "DefAng=" & $sDefAng)
   FileFlush ($hFile)
   ShellExecute (@ScriptDir & "\settings.ini")
EndFunc ; ==> _EventSettingsEdit

Func fact ($iNum)
   $x = 1
   For $i = 1 to $inum
      $x *= $i
   Next
   Return $x
EndFunc ; ==> fact

Func rad ($iDeg)
   Return $iDeg / ($pi/180)
EndFunc ; ==> rad

Func deg ($iRad)
   Return $iRad * ($pi/180)
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

Func _Moved ($hWnd, $msgID, $lParam, $wParam)
   $aPos = WinGetPos ("MDiesel's Calculator!!", "")
   If $aPos[1] > @DesktopHeight - 220 Then $aPos[1] = $aPos[1] - 193
   WinMove ($hSetUI, "", $aPos[0], $aPos[1] + 20)
EndFunc ; ==> _Moved

Func _EmptyWorkingSet ()
    DllCall ("psapi.dll", "int", "EmptyWorkingSet", "long", -1)
EndFunc ; ==> _EmptyWorkingSet