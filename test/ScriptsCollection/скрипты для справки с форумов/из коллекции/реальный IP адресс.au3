$xPage = InetRead("http://www.whatismyip.ru")
Local $nBytesRead = @extended
ConsoleWrite($nBytesRead & @CRLF)
$sPage = BinaryToString($xPage)
$IP_pat = '(?s).+\<font\scolor\=blue\>\<h1\>���\sip\s�����:\<br\>\n(\d+\.\d+\.\d+\.\d+)\n\</h1\>\</font\>.+'
$sIP = StringRegExpReplace($sPage, $IP_pat, '\1')
MsgBox(0, '', $sIP)
