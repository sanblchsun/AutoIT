Const $pi = 4*atan(1) , $pifactor = $pi/180  ; $PI = 3.141592653589793 
Global $stringtocalc,$splitcalc,$pp
While 1
    $string= InputBox('enter the calculation to make','allowed operators and functions' _
            &  @LF  & ' *,  /, +, pi, sin(degrees), cos(degrees), tan(degrees), arcsin(degrees), ' _
            & @CR & 'arccos(degrees), arctan(degrees), ^,  (,  ) ' _
            & @CR & 'Greatest Common Denominatot gcd( $a, $b), Return Factors or is Prime Prim($a) ' _
            & @CR & ', multiplicative inverse of a Modulo m Multinv($a, $m), Mod($a, $m) ' _
            & @CR & @CR & ' Eg ((45- 3^2.6)/17)*cos(23.7)*Mod(12^4,5)',"","",450,200)   
            
    If $string = '' Then Exit
    $string = StringStripWS($string,8)
    If StringRight($string,1) = '=' Then
        $string = StringMid($string,1,StringLen($string)-1)
    EndIf
   
    MsgBox(0,$string & ' = ',calculate($string))
    ;MsgBox(0,antilog(Log($String)),Exp(Log($string)))
WEnd

;rest of script is the calculator function
;return the calculation result of  $stringin
;very little error checking, just a sample to show a way to make a calculator
Func calculate($stringin)
    $stringin = StringUpper($stringin)
    $stringin = StringReplace($stringin,'^','**')
    ;$stringin = StringReplace($stringin,'#','+')   
    $stringtocalc = $stringin & '='
    $splitcalc = StringSplit($stringtocalc,"")
    $pp = 1   
    Return compute(0)   
EndFunc


func compute($rank);
    Local  $mtt,$tem1,$tem2,$pnum2,$bracketset, $opcomma 
consolewrite(' @start rank= ' & $rank &  '    $tem1 =' &  $tem1 & '  $tem2 =' &  $tem2 & '  $pp ' & $pp &  @CRLF)
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
                    $tem2 = compute( 0)
                    $pp += 1
                    $pnum2 = $pp;
                    while( $splitcalc[$pp] = '.') or StringIsDigit($splitcalc[$pp]);2nd number after comma must be digits or decimal only
                        $pp += 1;
                    WEnd
                    $tem1 = StringMid($stringtocalc,$pnum2,$pp-$pnum2)
                    $tem1 = gcd($tem1, $tem2);
                EndIf
                
            Case 'M'  ;Mod
                ConsoleWrite('got the g for gcd' &@CRLF)
                If StringMid($stringtocalc,$pp - 1,3) = "MOD" then
                    $pp += 2
                    $tem2 = compute( 0)
                    $pp += 1
                    $pnum2 = $pp;
                    while( $splitcalc[$pp] = '.') or StringIsDigit($splitcalc[$pp]);2nd number after comma must be digits or decimal only
                        $pp += 1;
                    WEnd
                    $tem1 = StringMid($stringtocalc,$pnum2,$pp-$pnum2)
                    $tem1 = Mod($tem2, $tem1)
                ElseIf StringMid($stringtocalc,$pp - 1,7) = "MULTINV" then                      
                    $pp += 6
                    $tem2 = compute( 0)
                    $pp += 1
                    $pnum2 = $pp;
                    while( $splitcalc[$pp] = '.') or StringIsDigit($splitcalc[$pp]);2nd number after comma must be digits or decimal only
                        $pp += 1;
                    WEnd
                    $tem1 = StringMid($stringtocalc,$pnum2,$pp-$pnum2)
                    $tem1 = Multinv($tem2, $tem1)
                EndIf   
                
             Case 'P'  ;Prim                
                If StringMid($stringtocalc,$pp - 1,4) = "PRIM" then
                    ConsoleWrite('got the p for Prim' &@CRLF)
                    $pp += 3                   
                    $tem2 = compute( 3);
                    $tem1 = Prim($tem2 );
                    If  $tem2 = number( $tem1) Then
                        $tem1 = "The number " &$tem1 & " is a prime number"
                    Else
                        $tem1 = "The factors of " & $tem2 & " are " & $tem1
                    EndIf
                ElseIf ($splitcalc[$pp] = 'I') then 
                    $tem1 = $PI;
                    $pp += 1;
                EndIf   
                
            Case 'S'  ;sin?
                ConsoleWrite('got the s for sin' &@CRLF)
                If StringMid($stringtocalc,$pp - 1,3) = "SIN" then
                    $pp += 2                   
                    $tem1 = sin($pifactor * compute( 3));
                EndIf
               
            Case 'T';tan?
                If StringMid($stringtocalc,$pp - 1,3) = "TAN" then
                    $pp += 2
                    $tem1 = Tan($pifactor * compute( 3));
                EndIf
                If $pp < $splitcalc[0] Then
                    while( $splitcalc[$pp] = '.') or StringIsDigit($splitcalc[$pp])
                        $pp += 1;
                    WEnd
                EndIf
               
            Case 'A'
                If StringMid($stringtocalc,$pp - 1,6) = "ARCTAN" then
                    $pp += 5;
                    $tem1 = atan(compute( 3))/$pifactor;
                elseif  StringMid($stringtocalc,$pp - 1,6) = 'ARCSIN' then                   
                    $pp += 4;
                    ConsoleWrite('at arcsin pp = ' & $splitcalc[$pp] & @CRLF)                   
                    $mtt = compute( 3);
                    ConsoleWrite('$mtt = ' & $mtt & @CRLF)
                    $tem1 = ASin($mtt)/$pifactor;
                elseif (StringMid($stringtocalc,$pp - 1,6) = 'ARCCOS')  then
                    $pp += 5
                    $tem1 = ACos(compute( 3))/$pifactor;
                EndIf
                If $pp < $splitcalc[0] Then
                    while( $splitcalc[$pp] = '.') or StringIsDigit($splitcalc[$pp+1])
                        $pp += 1; {get past the Add bit}
                    WEnd
                EndIf
               
            
            Case 'C';cos?               
                if  StringMid($stringtocalc,$pp - 1,3) = 'COS' then
                    $pp += 2
                    $tem1 = cos($pifactor * compute( 3));
                EndIf
                
            Case '('
                consolewrite(' ( rank= ' & $rank & '$tem =' &  $tem1 & '  $tem2 =' &  $tem2 & '  $pp ' & $pp &  @CRLF)
                $bracketset = 1;
                $tem1 = compute( 0);
                
            Case ')'
                consolewrite(' ) rank= ' & $rank & '$tem =' &  $tem1 & '  $tem2 =' &  $tem2 & '  $pp ' & $pp &  @CRLF)
                if ($bracketset = 1) then
                    $bracketset = 0
                else
                    $pp -= 1;
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
                    if ($tem2 = 0) then
                        MsgBox(0,'Error','divide by 0!');
                        $divzero = True;
                        $result = 0;
                        Return $result;
                    else
                        $tem1 = $tem1/$tem2;
                    EndIf
                EndIf
            
           Case '*'               
                if $splitcalc[$pp] = '*' then
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
                    $tem1 = Power($tem1,$tem2);
                    ;Return $tem1
                else   
                    if ($rank >= 3) then
                        $pp -= 1;
                        $result = $tem1;
                        Return $result;
                    else
                        $mtt = compute(3);
                        $tem1 = $tem1 * $mtt;
                    EndIf;
                EndIf;
           
            Case '+'
                if ($rank >= 1) then
                    $pp -= 1;
                    $result = $tem1;
                consolewrite(' + rank= ' & $rank & '$tem =' &  $tem1 & '  $tem2 =' &  $tem2 & '  $pp ' & $pp &  @CRLF)
                    Return $result
                else
                consolewrite(' 2nd +  rank= ' & $rank & '$tem =' &  $tem1 & '  $tem2 =' &  $tem2 & '  $pp ' & $pp &  @CRLF)
                    $tem1 = $tem1 + compute( 1);
                consolewrite(' 3rd +  rank= ' & $rank & '$tem =' &  $tem1 & '  $tem2 =' &  $tem2 & '  $pp ' & $pp &  @CRLF)
                EndIf;
               
            Case '-';
                consolewrite(' - rank= ' & $rank & '$tem =' &  $tem1 & '  $tem2 =' &  $tem2 & '  $pp ' & $pp &  @CRLF)
                if ($rank >= 1) then
                    $pp -= 1
                    $result = - $tem1;
                    Return $result
                else
                    $tem1 = $tem1 - compute( 1);
                EndIf;  
                
            Case '=' ;{CR LF NULL}
                $pp -= 1;{set back to end of line or compute will go crashing through the comments}
                $result = $tem1;
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

EndFunc;

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

;Finds Greatest Common Denominator of input 2 numbers
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