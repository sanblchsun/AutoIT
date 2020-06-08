$oShell = ObjCreate("shell.application")
$oShellWindows=$oShell.windows

if Isobj($oShellWindows) then
  $string=""

  for $Window in $oShellWindows
    $String = $String & $Window.LocationName & @CRLF
  next

  msgbox(0,"","You have the following windows open:" & @CRLF & $String)
else

  msgbox(0,"","you have no open shell windows.")
endif