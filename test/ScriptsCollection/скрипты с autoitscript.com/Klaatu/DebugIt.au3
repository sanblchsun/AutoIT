#NoTrayIcon
Opt('MustDeclareVars', 1)
Opt('GUIOnEventMode', 1)
Opt("WinTitleMatchMode", 4)
;debugit
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <File.au3>
#include <WindowsConstants.au3>
#cs

   DebugIt.au3

   Run an AutoIt script, outputing each line executed to a window.

   Syntax 1:
   AutoIt3 DebugIt.au3 yourscript.au3 params
   Syntax 2:
   DebugIt.exe yourscript.au3 params

   (If using Syntax 2, note that there may be issues with include files; see
   comments in AutoIt's helpfile regarding switch /AutoIt3ExecuteScript.)

   Run DebugIt - choose a file - the script will then write out a file called
   filename_DebugIt.au3 This file should be identical to your script except that
   before every line of code there is an instruction to write out the original
   script line to a control in a window we create.
   If the script crashes out - or whatever - you just look at the the last line
   written out to indicate where the script crashed.

   Following the executed line is code to send the names and values of all variables
   used in said executed line to the edit control in the debug window.

   You can prevent any particular section of code (such as an AdLib function)
   from having debug code added by placing a line with just ';debugit' before and
   after the section.

   NOTE: Requires AutoIt 3.2.12+!!!

   Revision History:

   Version 1.5.1
   * changed: because of the script-breaking changes made in v3.2.12 of AutoIt,
   our include list needed to be updated to the new "standard". If you're using
   an earlier version of AutoIt, note that this script should work with earlier
   versions, however the include list will probably need to be changed.

   Version 1.5
   * fixed: try to reactivate the previously active window if the 'Pause' button
   was used and later the 'Resume' button. Should prevent Send commands in the
   script immediately following resuming from being sent to our debug window.
   * changed: extra characters added to window title changed from brackets to
   braces so we don't use the same character AutoIt does for title matching.

   Version 1.4
   * changed: if user does not have write permissions on the folder containing
   the script, run script in passthru mode instead of failing.
   * changed: exit gracefully if we prompt the user for a file to debug and no
   file was given.
   * added: set focus to Exit button so we can be dismissed with an enter or
   spacebar key.
   * changed: unnecessary StringFormat commands changed to literal strings.

   Version 1.3
   * changed: activate previous window after opening our GUI, in case the
   script we're debugging relies or acts on the active window. Also,
   re-activate our debug window when and if the script we're debugging
   exits.
   * changed: change our debug window title slightly to reduce the possibility
   of our window's title interferring with window title matching in the
   script we're debugging.
   * added: include builtin variables (@'s) in variable outout.

   Version 1.2
   * changed: comment to control debugging changed from ';debug' to ';debugit'.
   * changed: font in edit control from 'Lucidia Console' to 'Courier New'.
   * added: outputs variable names and their values after the executed line.
   * other small changes, such as 'Passthru' mode described in the code.

   Version 1.1
   * changed: calls a single function to do the work, and add said function
   at the bottom of the script. Similar to what Stumpii does in his
   debugger; after all, a good idea deserves stealing.
   * changed: event driven GUI rather than loop mode.
   * changed: font in Edit control is now fixed pitch.
   * added: pause/resume and stop/exit buttons.

   Version 1.0 - initial release

#ce
Global Const $bOutputVars = True ; change to false if you don't want variables output
Global Const $bPassthru = False ; change to true when you don't want to debug but
;                                 don't want to change the command line that starts
;                                 your script
Global Const $sEditFont = 'Courier New'
Global $sDebugFile, $sRandom = '', $sTitle
Local $sFileToDebug, $fhFileToDebug, $fhDebugFile
Local $iLineNumber, $sCurrentLine, $sModifiedLine, $bDebugging
Local $sIndent, $x, $sAutoItExe, $sArgs = ''
Local $sDrive, $sDir, $sFName, $iSavedLine, $aVars, $PID

$sAutoItExe = '"' & @AutoItExe & '"'
If @compiled Then
   $sAutoItExe &= ' /AutoIt3ExecuteScript'
EndIf

If $CmdLine[0] = 0 Then
   $sFileToDebug = FileOpenDialog('Choose script to debug', @WorkingDir, '(*.au3)', 1)
   If $sFileToDebug = '' Then Exit (1)
Else
   $sFileToDebug = $CmdLine[1]
   For $x = 2 To $CmdLine[0]
      $sArgs &= ' "' & $CmdLine[$x] & '"'
   Next
EndIf
If Not FileExists($sFileToDebug) Then
   MsgBox(0, @ScriptName, 'File "' & $sFileToDebug & '" not found')
   Exit (1)
EndIf

; You can have all your shortcuts or command lines include this debug script in
; your command line that starts your own scripts. When you want to turn debugging on
; or off you just edit this script, change $bPassthru to True to turn it on and
; change to False to turn it off. With $bPassthru set to True it's as if this
; script were not even there.
;
If $bPassthru Then
   Run($sAutoItExe & ' "' & $sFileToDebug & '"' & $sArgs, @WorkingDir)
   Exit
EndIf

_PathSplit($sFileToDebug, $sDrive, $sDir, $sFName, $x)
; The title of our debug window will be the filename portion only, but with '_DebugIt' added.
$sTitle = $sFName & '_DebugIt'
; Our temporary script will use this title for its name. We also make sure to create the
; temporary script in the same folder as the original, in case it relies on other things
; being found relative to where it is. Placing this temporary file in the temp folder may
; screw some things up, so we don't do that.
$sDebugFile = _PathMake($sDrive, $sDir, $sTitle, $x)
; We use a Random 8 character string for 2 purposes:
;   1) to almost guarantee that the function we add to the script doesn't conflict
;      with the script's own functions, and
;   2) to make sure we're communicating with one and only one debug window, as we
;      look for this random string to be text in the window we want to communicate with.
While StringLen($sRandom) < 8
   $sRandom &= Chr(Round(Random(97, 122), 0))
WEnd
; Change title slightly to reduce possibility of our Debug window's title interferring
; with window title matching in the script we're debugging.
$sTitle = '{' & $sTitle & '}'

$fhFileToDebug = FileOpen($sFileToDebug, 0)
If $fhFileToDebug = -1 Then
   MsgBox(0, @ScriptName, 'File "' & $sFileToDebug & '" could not be opened')
   Exit (2)
EndIf
$fhDebugFile = FileOpen($sDebugFile, 2)
If $fhDebugFile = -1 Then
   ; Instead of failing if we can't debug, run the program in passthru mode
   ; Useful if the person/account running the script doesn't have write access
   ; to the folder containing the script.
   FileClose($fhFileToDebug)
   Run($sAutoItExe & ' "' & $sFileToDebug & '"' & $sArgs, @WorkingDir)
   Exit
EndIf

;debugit
$iLineNumber = 1
$bDebugging = True
While True
   $iSavedLine = $iLineNumber
   $sCurrentLine = FileReadLine($fhFileToDebug) ; , $iLineNumber)
   If @error = -1 Then ExitLoop
   ; look for lines that tell us whether to stop or start adding debugging to the script
   ; there's no special code to watch for #cs/#ce blocks, as it actually doesn't matter;
   ; debug code will be added to these blocks, but so what?
   If StringStripWS($sCurrentLine, 8) = ';debugit'  Then
      $bDebugging = Not $bDebugging
      $iLineNumber += 1
      FileWriteLine($fhDebugFile, $sCurrentLine)
      ContinueLoop
   EndIf

   StripComment($sCurrentLine) ; Get rid of any comment so it doesn't mess us up
   While StringRight($sCurrentLine, 2) = ' _'
      $sCurrentLine = StringTrimRight($sCurrentLine, 1)
      $iLineNumber += 1
      $sCurrentLine &= StringStripWS(FileReadLine($fhFileToDebug), 1) ; , $iLineNumber), 1)
      If @error = -1 Then ExitLoop
      StripComment($sCurrentLine)
   WEnd
   If $bDebugging Then
      ; Turn all double quotes into single quotes so we can use double quotes to delimit the
      ; line when adding it to the debugging script.
      $sModifiedLine = StringReplace($sCurrentLine, '"', "'")
      If StringStripWS($sCurrentLine, 3) <> '' Then
         ; Proper indenting is not really needed, but it makes the temporary script
         ; look a hell of a lot better if someone needs to look at it for some reason.
         ; debugit
         $sIndent = ''
         While StringIsSpace(StringLeft($sCurrentLine, StringLen($sIndent) + 1))
            $sIndent = StringLeft($sCurrentLine, StringLen($sIndent) + 1)
            If $sIndent = $sCurrentLine Then ExitLoop
         WEnd
         ; debugit
         FileWriteLine($fhDebugFile, StringFormat('%s%s(%u, "%s", @Error, @Extended)', $sIndent, $sRandom, $iSavedLine, $sModifiedLine))
      EndIf
   EndIf
   FileWriteLine($fhDebugFile, $sCurrentLine)
   If $bDebugging And $bOutputVars Then
      $aVars = ScanForVars($sCurrentLine)
      For $x = 2 To $aVars[0]
         FileWriteLine($fhDebugFile, StringFormat('%s%s_v("%s%", %s, @Error, @Extended, "%s")', $sIndent, $sRandom, $aVars[$x], $aVars[$x], $sIndent))
      Next
   EndIf
   $iLineNumber += 1
WEnd
FileClose($fhFileToDebug)
FileWriteLine($fhDebugFile, $sCurrentLine)

; Create our functions at the very end of the script. They do a few things for us:
;    1) Updates the edit control in our window with the script line that is about to execute.
;    2) Sets the two variables @Error and @Extended back to what they were before this
;       function was called. This guarantees that the original script's code that relies
;       on these values will continue to execute as intended.
;    3) Eliminates the need to add global variables to the script.
;    4) Watches the debugging form for changes to its controls and either pauses or exits
;       if told to do so.
;    5) Output the name and contents of variables following the just executed script line.

FileWriteLine($fhDebugFile, '')
FileWriteLine($fhDebugFile, 'Func ' & $sRandom & '($l, $t, $e, $x)')
FileWriteLine($fhDebugFile, '   Local $o = Opt("WinTitleMatchMode", 4)')
FileWriteLine($fhDebugFile, StringFormat('   Local $h = WinGetHandle("[TITLE:%s]", "%s"', $sTitle, $sRandom) & '), $w = WinGetHandle("[ACTIVE]")')
FileWriteLine($fhDebugFile, '   Global $' & $sRandom & '_w')
FileWriteLine($fhDebugFile, '   If $w <> $h Then $' & $sRandom & '_w = $w')
FileWriteLine($fhDebugFile, '   ControlCommand($h, "", "[CLASSNN:Edit1]", "EditPaste", StringFormat("%04u: %s", $l, $t) & @CRLF)')
FileWriteLine($fhDebugFile, '   If ControlCommand($h, "", "[TEXT:Pause]", "IsChecked","") Then')
FileWriteLine($fhDebugFile, '      While ControlCommand($h, "", "[TEXT:Pause]", "IsChecked","")')
FileWriteLine($fhDebugFile, '         Sleep(500)')
FileWriteLine($fhDebugFile, '      Wend')
FileWriteLine($fhDebugFile, '      If IsHwnd($' & $sRandom & '_w) Then WinActivate($' & $sRandom & '_w)')
FileWriteLine($fhDebugFile, '   EndIf')
FileWriteLine($fhDebugFile, '   If ControlCommand($h, "", "[TEXT:Stop]", "IsChecked","") Then Exit')
FileWriteLine($fhDebugFile, '   Opt("WinTitleMatchMode", $o)')
FileWriteLine($fhDebugFile, '   SetError($e, $x)')
FileWriteLine($fhDebugFile, 'EndFunc')
FileWriteLine($fhDebugFile, '')
FileWriteLine($fhDebugFile, 'Func ' & $sRandom & '_v($n, $v, $e, $x, $i)')
FileWriteLine($fhDebugFile, '   Local $j, $a = "", $u')
FileWriteLine($fhDebugFile, '   If IsArray($v) Then')
FileWriteLine($fhDebugFile, '      If UBound($v, 0) = 1 Then')
FileWriteLine($fhDebugFile, '         $u = UBound($v) - 1')
FileWriteLine($fhDebugFile, '         If $u > 10 Then $u = 10')
FileWriteLine($fhDebugFile, '         For $j = 0 to $u')
FileWriteLine($fhDebugFile, '            If IsString($v[$j]) Then $v[$j] = "''" & $v[$j] & "''"')
FileWriteLine($fhDebugFile, '            $a &= ", " & $v[$j]')
FileWriteLine($fhDebugFile, '         Next')
FileWriteLine($fhDebugFile, '         $v = "[" & StringTrimLeft($a, 2) & "]"')
FileWriteLine($fhDebugFile, '      Else')
FileWriteLine($fhDebugFile, '         $v = "<multi-dimension-array>"')
FileWriteLine($fhDebugFile, '      EndIf')
FileWriteLine($fhDebugFile, '   Else')
FileWriteLine($fhDebugFile, '      If IsString($v) Then $v = "''" & $v & "''"')
FileWriteLine($fhDebugFile, '   EndIf')
FileWriteLine($fhDebugFile, StringFormat('   ControlCommand("[TITLE:%s]", "%s"', $sTitle, $sRandom) & ', "[CLASSNN:Edit1]", "EditPaste", StringFormat("    : %s... %s = %s", $i, $n, String($v)) & @CRLF)')
FileWriteLine($fhDebugFile, '   SetError($e, $x)')
FileWriteLine($fhDebugFile, 'EndFunc')
FileWriteLine($fhDebugFile, '')
FileClose($fhDebugFile)

; Save the handle of the currently active window. After our GUI is shown we make it
; active again in case something in the script we're debugging relies or works on it.
$x = WinGetHandle('[ACTIVE]')
; We create our form, giving it a single label containing our random string so our
; debug script will have a unique window to communicate with. We also add one Edit
; control that gets updated by the debug script as it executes.
#Region ### START Koda GUI section ### Form=g:\programs\autoit3\koda\forms\dbgform2.kxf
Global $frmMain = GUICreate($sTitle, 876, 429, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, 'frmMainClose')
Global $GroupBox1 = GUICtrlCreateGroup('', 8, 1, 857, 377)
Global $edtCode = GUICtrlCreateEdit('DebugIt V1.5.1 by Klaatu' & @CRLF, 16, 16, 841, 353, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_READONLY, $ES_WANTRETURN, $WS_HSCROLL, $WS_VSCROLL))
GUICtrlSetData(-1, '')
GUICtrlSetFont(-1, 10, 400, 0, $sEditFont)
GUICtrlSetLimit(-1, 0x7FFFFFFF)
GUICtrlCreateGroup('', -99, -99, 1, 1)
Global $btnPause = GUICtrlCreateButton('Pa&use', 313, 387, 75, 25, 0)
GUICtrlSetOnEvent(-1, 'btnPause_Click')
Global $btnStop = GUICtrlCreateButton('St&op', 410, 387, 75, 25, 0)
GUICtrlSetOnEvent(-1, 'btnStop_Click')
Global $lblRandom = GUICtrlCreateLabel($sRandom, 56, -100, 65, 17)
Global $cbPause = GUICtrlCreateCheckbox('Pause', 176, -100, 105, 17)
Global $cbStop = GUICtrlCreateCheckbox('Stop', 560, -100, 121, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
WinActivate($x)

; We're ready to start executing the debug script.
$PID = Run($sAutoItExe & ' "' & $sDebugFile & '"' & $sArgs, @WorkingDir)

While True
   Sleep(100)
   If BitAND(GUICtrlRead($cbStop, 0), $GUI_UNCHECKED) = $GUI_UNCHECKED Then
      If Not ProcessExists($PID) Then
         WinActivate($sTitle, $sRandom)
         GUICtrlSetState($cbStop, $GUI_CHECKED)
         GUICtrlSetState($btnPause, $GUI_DISABLE)
         GUICtrlSetState($btnStop, $GUI_DEFBUTTON + $GUI_FOCUS)
         GUICtrlSetData($btnStop, 'E&xit')
      EndIf
   EndIf
WEnd
Exit

Func frmMainClose()
   Cleanup()
   Exit
EndFunc   ;==>frmMainClose

Func btnPause_Click()
   If BitAND(GUICtrlRead($cbPause, 0), $GUI_CHECKED) = $GUI_CHECKED Then
      GUICtrlSetState($cbPause, $GUI_UNCHECKED)
      GUICtrlSetData($btnPause, 'Pa&use')
   Else
      GUICtrlSetState($cbPause, $GUI_CHECKED)
      GUICtrlSetData($btnPause, 'Res&ume')
   EndIf
EndFunc   ;==>btnPause_Click

Func btnStop_Click()
   If BitAND(GUICtrlRead($cbStop, 0), $GUI_CHECKED) = $GUI_CHECKED Then
      frmMainClose()
   Else
      If BitAND(GUICtrlRead($cbPause, 0), $GUI_CHECKED) = $GUI_CHECKED Then
         GUICtrlSetState($cbPause, $GUI_UNCHECKED)
         GUICtrlSetState($btnPause, $GUI_DISABLE)
      EndIf
      GUICtrlSetState($cbStop, $GUI_CHECKED)
      GUICtrlSetState($btnStop, $GUI_DEFBUTTON + $GUI_FOCUS)
      GUICtrlSetData($btnStop, 'E&xit')
   EndIf
EndFunc   ;==>btnStop_Click

Func Cleanup()
   FileDelete($sDebugFile)
EndFunc   ;==>Cleanup

;debugit
Func ScanForVars($sLine)
   ; Look for all variables in the line and return an array of those variable names.
   ; Make sure we ignore everything within quotes.
   ; Assumes comments have already been stripped.
   Local $iPos = 1, $sQuote = '', $sChar, $sVar = '', $sVarList = ''
   Local Const $sValidVarChars = 'abcdefghijklmnopqrstuvwxyz1234567890_'

   $sLine = StringStripWS($sLine, 7) & ';'
   While $iPos <= StringLen($sLine)
      $sChar = StringMid($sLine, $iPos, 1)
      If $sQuote = '' Then
         If $sVar <> '' Then
            If StringInStr($sValidVarChars, StringMid($sLine, $iPos + 1, 1)) = 0 Then
               $sVar &= $sChar
               ; Add the variable name to our list only if one just like it is not
               ; already there
               If StringInStr($sVarList & '|', $sVar & '|') = 0 Then
                  $sVarList &= '|' & $sVar
               EndIf
               $sVar = ''
            Else
               $sVar &= $sChar
            EndIf
         ElseIf $sChar = '$'  Or $sChar = '@'  Then
            $sVar = $sChar
         ElseIf $sChar = '"'  Or $sChar = "'"  Then
            $sQuote = $sChar
         EndIf
      ElseIf $sChar = $sQuote Then
         $sQuote = ''
      EndIf
      $iPos += 1
   WEnd
   ; Assert($sVar = '')
   Return StringSplit($sVarList, '|')
EndFunc   ;==>ScanForVars

Func StripComment(ByRef $sLine)
   ; Look for the first semicolon outside of quotes.
   ; Return everything before it (except trailing whitespace).
   Local $iPos = 1, $sQuote = '', $sChar

   While $iPos <= StringLen($sLine)
      $sChar = StringMid($sLine, $iPos, 1)
      If $sQuote = '' Then
         If $sChar = ';'  Then
            $sLine = StringLeft($sLine, $iPos - 1)
            ExitLoop
         ElseIf $sChar = '"'  Or $sChar = "'"  Then
            $sQuote = $sChar
         EndIf
      ElseIf $sChar = $sQuote Then
         $sQuote = ''
      EndIf
      $iPos += 1
   WEnd
   $sLine = StringStripWS($sLine, 2)
EndFunc   ;==>StripComment
;debugit
