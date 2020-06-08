
; десонстраци€€ чтени€ вывода информации в консоль на примере справки дл€ reg.exe (оставл€ю свой вариант, который стабильно работал в реальном скрипте, а не только в примерах.

$potok = Run(@ComSpec & " /c reg.exe -?", @SystemDir, @SW_HIDE, 6) ; по какой то причине параметр 2 в этой строке не сработал в реальном скрипте
$line1=''
While 1
    $line = StdoutRead($potok)
    If @error Then ExitLoop
	$line1 &= $line ; и почему то без второй строки не сработал
Wend

MsgBox(0, "—ообщение", $line1)


; демонстраци€ чтени€ сетевой конфигурации (с ru-board)
$sLog = ''
$hRun = Run(@ComSpec & " /C ipconfig -all", "", @SW_HIDE, 2)
While 1
    $sLog &= StdoutRead($hRun)
    If @error Then ExitLoop
    Sleep(10)
WEnd
$sLog = StringRegExpReplace(@CRLF&$sLog, "(\r\n)+", '') ; удаление переходов строк
MsgBox(0, "", $sLog)
;ClipPut($sLog ) ; отправить в буфер