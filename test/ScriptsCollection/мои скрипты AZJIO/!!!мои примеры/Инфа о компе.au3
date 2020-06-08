MsgBox(0,"Информация",'@OSLang:       ' & @OSLang& @CRLF & _
'@OSType:       ' & @OSType& @CRLF & _
'@OSVersion:       ' & @OSVersion& @CRLF & _
'@OSBuild:       ' & @OSBuild& @CRLF & _
'@OSServicePack:       ' & @OSServicePack& @CRLF & _
'@ComputerName:       ' & @ComputerName& @CRLF & _
'@UserName:       ' & @UserName& @CRLF & _
'@IPAddress1:       ' & @IPAddress1& @CRLF & _
'@IPAddress2:       ' & @IPAddress2& @CRLF & _
'@IPAddress3:       ' & @IPAddress3& @CRLF & _
'@IPAddress4:       ' & @IPAddress4& @CRLF & _
'Параметры экрана:       ' & @DesktopWidth&'x'&@DesktopHeight&', '&@DesktopDepth&', '&@DesktopRefresh)


#cs
Эти переменные можно указывать в условиях, например, если версия винды WIN_XP, то выполнить команды... или если имя пользователя Administrator, то выполнить команды...
#ce