#include <GetOpt.au3>
#include <Array.au3> ; For demo purposes only.

If 0 = $CmdLine[0] Then
    ; Create our own example command line.
    Run(FileGetShortName(@AutoItExe) & ' ' & FileGetShortName(@ScriptFullPath) & ' -a=no -b=42 -c=0.5 /Windows:' & @OSVersion & ' -z --required -s=foo,bar=quux,baz +p /-M -- -w=ignored Hello World!')
    Exit
EndIf

_GetOpt_Demo()

Func _GetOpt_Demo()
    Local $sMsg = @ScriptName & ' for GetOpt v' & $GETOPT_VERSION & '.' & @CRLF & 'Parsing: ' & _ArrayToString($CmdLine, ' ', 1) & @CRLF & @CRLF; Message.
    Local $sOpt, $sSubOpt, $sOper
    ; Options array, entries have the format [short, long, default value]
    Local $aOpts[9][3] = [ _
        ['-a', '--a-option', True], _
        ['-b', '--b-option', False], _
        ['-c', '--c-option', 'c option argument'], _
        ['/W', '/Windows', 'windows style argument'], _ ; For demo purposes styles are mixed.
        ['-r', '--required', $GETOPT_REQUIRED_ARGUMENT], _ ; This option requires an argument.
        ['-s', '--suboption', $GETOPT_REQUIRED_ARGUMENT], _ ; option with suboptions.
        ['-p', '--plus', Default], _
        ['/M', '/Minus', Default], _
        ['-h', '--help', True] _
    ]
    ; Suboptions array, entries have the format [suboption, default value]
    Local $aSubOpts[2][2] = [ _
        ['foo', 47], _
        ['bar', True] _
    ]
    _GetOpt_Set($aOpts) ; Set options.
    If 0 < $GetOpt_Opts[0] Then ; If there are any options...
        While 1 ; ...loop through them one by one.
            ; Get the next option passing a string with valid options.
            $sOpt = _GetOpt('abcwr:s:pmh') ; r: means -r option requires an argument.
            If Not $sOpt Then ExitLoop ; No options or end of loop.
            ; Check @extended above if you want better error handling.
            ; The current option is stored in $GetOpt_Opt, it's index (in $GetOpt_Opts)
            ; in $GetOpt_Ind and it's value in $GetOpt_Arg.
            Switch $sOpt ; What is the current option?
                Case '?' ; Unknown options come here. @extended is set to $E_GETOPT_UNKNOWN_OPTION
                    $sMsg &= 'Unknown option: ' & $GetOpt_Ind & ': ' & $GetOpt_Opt
                    $sMsg &= ' with value "' & $GetOpt_Arg & '" (' & VarGetType($GetOpt_Arg) & ').' & @CRLF
                Case ':' ; Options with missing required arguments come here. @extended is set to $E_GETOPT_MISSING_ARGUMENT
                    $sMsg &= 'Missing required argument for option: ' & $GetOpt_Ind & ': ' & $GetOpt_Opt & @CRLF
                Case 'a', 'b', 'c', 'w', 'p', 'm'
                    $sMsg &= 'Option ' & $GetOpt_Ind & ': ' & $GetOpt_Opt
                    $sMsg &= ' with value "' & $GetOpt_Arg & '" (' & VarGetType($GetOpt_Arg) & ')'
                    If $GETOPT_MOD_PLUS = $GetOpt_Mod Then
                        $sMsg &= ' and invoked with plus modifier (+' & $GetOpt_Opt & ')'
                    ElseIf $GETOPT_MOD_MINUS = $GetOpt_Mod Then
                        $sMsg &= ' and invoked with minus modifier (/-' & $GetOpt_Opt & ')'
                    EndIf
                    $sMsg &= '.' & @CRLF
                Case 'r'
                    $sMsg &= 'Option ' & $GetOpt_Ind & ': ' & $GetOpt_Opt
                    $sMsg &= ' with required value "' & $GetOpt_Arg & '" (' & VarGetType($GetOpt_Arg) & ')'
                    If $GETOPT_MOD_PLUS = $GetOpt_Mod Then
                        $sMsg &= ' and invoked with plus modifier (+' & $GetOpt_Opt & ')'
                    ElseIf $GETOPT_MOD_MINUS = $GetOpt_Mod Then
                        $sMsg &= ' and invoked with minus modifier (/-' & $GetOpt_Opt & ')'
                    EndIf
                    $sMsg &= '.' & @CRLF
                Case 's'
                    $sMsg &= 'Option ' & $GetOpt_Ind & ': ' & $GetOpt_Opt
                    $sMsg &= ' with required suboptions:' & @CRLF
                    While 1 ; Loop through suboptions.
                        $sSubOpt = _GetOpt_Sub($GetOpt_Arg, $aSubOpts)
                        If Not $sSubOpt Then ExitLoop ; No suboptions or end of loop.
                        ; Check @extended above if you want better error handling.
                        ; The current suboption is stored in $GetOpt_SubOpt, it's index (in $GetOpt_SubOpts)
                        ; in $GetOpt_SubInd and it's value in $GetOpt_SubArg.
                        Switch $sSubOpt ; What is the current suboption?
                            Case '?'
                                $sMsg &= '    Unknown suboption ' & $GetOpt_SubInd & ': ' & $GetOpt_SubOpt
                                $sMsg &= ' with value "' & $GetOpt_SubArg & '" (' & VarGetType($GetOpt_SubArg) & ').' & @CRLF
                            Case 'foo', 'bar'
                                $sMsg &= '    Suboption ' & $GetOpt_SubInd & ': ' & $GetOpt_SubOpt
                                $sMsg &= ' with value "' & $GetOpt_SubArg & '" (' & VarGetType($GetOpt_SubArg) & ').' & @CRLF
                        EndSwitch
                    WEnd
                    If $GETOPT_MOD_PLUS = $GetOpt_Mod Then
                        $sMsg &= 'And invoked with plus modifier (+' & $GetOpt_Opt & ').'
                    ElseIf $GETOPT_MOD_MINUS = $GetOpt_Mod Then
                        $sMsg &= ' and invoked with minus modifier (/-' & $GetOpt_Opt & ')'
                    EndIf
                Case 'h'
                    MsgBox(0, 'GetOpt.au3', 'GetOpt.au3 example.' & @CRLF & _
                            'Just try out some options and find out what happens!')
                    Exit
            EndSwitch
        WEnd
    Else
        $sMsg &= 'No options passed.' & @CRLF
    EndIf
    $sMsg &= @CRLF
    If 0 < $GetOpt_Opers[0] Then ; If there are any operands...
        While 1 ; ...loop through them one by one.
            $sOper = _GetOpt_Oper() ; Get the next operand.
            If Not $sOper Then ExitLoop ; no operands or end of loop.
            ; Check @extended above if you want better error handling.
            $sMsg &= 'Operand ' & $GetOpt_OperInd & ': ' & $sOper & @CRLF
        WEnd
    Else
        $sMsg &= 'No operands passed.' & @CRLF
    EndIf
    MsgBox(0, @ScriptName, $sMsg) ; Let's see what we've got.
    _ArrayDisplay($GetOpt_Opts, '$GetOpt_Opts')
    _ArrayDisplay($GetOpt_Opers, '$GetOpt_Opers')
    _ArrayDisplay($GetOpt_ArgV, '$GetOpt_ArgV')
    Exit
EndFunc