#NoTrayIcon
$sTarget = StringTrimLeft($CmdLineRaw, StringLen('"' & @ScriptName & '" '))
    $aLnk = FileGetShortcut($sTarget)
    If @error Then Exit
$aPath = StringRegExp($aLnk[0], "(^.*\\(.*))\\(.*)$", 3)
	If $aPath[1]='i386' Or $aPath[1]='System32' Or $aPath[1]='Program Files' Or $aPath[1]='Programs' Or $aPath[1]='Windows' Then Exit
DirCopy($aPath[0], "B:\lnk_"&$aPath[1], 1)
	If $aLnk[3]<>'' Then
        $DSC=$aLnk[3]
    Else
        $DSC=''
    EndIf
	If $aLnk[2]<>'' Then
        $ARG=$aLnk[2]
    Else
        $ARG=''
    EndIf
	If $aLnk[4]<>'' Then
        $ICO=$aLnk[4]
    Else
        $ICO=''
    EndIf
ShellExecute('B:\lnk_'&$aPath[1]&'\'&$aPath[2],$ARG,'','', @SW_HIDE )
FileCreateShortcut('B:\lnk_'&$aPath[1]&'\'&$aPath[2],@UserProfileDir&'\Рабочий стол\'&$aPath[1]&'.lnk','B:\lnk_'&$aPath[1],$ARG,$DSC,$ICO)