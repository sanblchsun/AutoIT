;http://www.autoitscript.com/forum/index.php?showtopic=34152&st=0&p=248889&hl=_ProgressOff(&#036;prog)&fromsearch=1&entry248889
#include <Date.au3>
Global $TallyOrDo = "Tally" ; sets whether or not the Script should tally the function calls or actually execute them 
Global $FunctionCount = 0 ; initialise the tally
Global $DoneFunctions = 0 ; Everytime a Function is called upon to execute, it should increment $DoneFunctions
Global $StartTime = _NowCalc()

Func _MyFunction1()
If $TallyOrDo= "Tally" Then ; increment the function tally for use with the Progressbar
        $FunctionCount = $FunctionCount + 1
Else ; Execute the function
; Function code goes here of course
_ShowProgress("My message to the viewer...")
EndIf
EndFunc

Func _MyFunction2()
If $TallyOrDo= "Tally" Then ; increment the function tally for use with the Progressbar
        $FunctionCount = $FunctionCount + 1
Else ; Execute the function
; Function code goes here of course
_ShowProgress("My message to the viewer...")
EndIf
EndFunc

Func _MyScript()
_MyFunction1()
_MyFunction2()
EndFunc

Func _ShowProgress($msg)
    ; Requires Global Parameters: StartTime, CompletedFunctionCalls and FunctionCount
    
    Local $RunTimeSeconds = 0
    Local $RunTimeMinutes = 0
    Local $RunTimeHours = 0
    
    $DoneFunctions = $DoneFunctions + 1
    $i = Int(($DoneFunctions / $FunctionCount) * 100)
    
    $RunTimeSeconds =  _DateDiff("s", $StartTime, _NowCalc())
    
    If ($RunTimeSeconds > 59) Then
        While $RunTimeSeconds > 59
            $RunTimeSeconds = $RunTimeSeconds - 60
            $RunTimeMinutes = $RunTimeMinutes + 1
            If $RunTimeMinutes > 59 Then
                $RunTimeMinutes = $RunTimeMinutes - 60
                $RunTimeHours = $RunTimeHours + 1
            EndIf
        WEnd
    EndIf
    
    ProgressSet( $i, "Time is now " & _NowTime() & ". Elapsed time: " & $RunTimeHours & "h:" & $RunTimeMinutes & "m:" & $RunTimeSeconds & "s. " & @LF _
                & $i & " percent complete. Please be patient..." & @LF _
                & $msg)

EndFunc   ;==>_ShowProgress

;;;; Main Program here ;;;;
ProgressOn("My Script is running!", "Script started at " & _NowTime(), "0 percent", -1, -1, 16)

For $i = 1 to 2 ; Ensures the script will run all the functions twice. 
    ; First time will Tally them, second time will Do them. Important for calculating ProgressBar Percentage complete.
_MyScript()
$TallyOrDo = "Do"
Next

ProgressSet(100 , "Script completed at " & _NowTime(), "Thankyou for your patience...")
sleep(1000)
ProgressOff()
Exit
