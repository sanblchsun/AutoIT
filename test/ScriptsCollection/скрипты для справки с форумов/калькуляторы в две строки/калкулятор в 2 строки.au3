Do
Until Not Assign('sString', Eval('sString')) Or Not Assign('sString', InputBox('Calc', $sString & " = " & Execute($sString), $sString)) Or $sString = ''