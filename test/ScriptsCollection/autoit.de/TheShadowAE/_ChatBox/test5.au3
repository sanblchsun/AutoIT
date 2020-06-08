#include "_ChatBox.au3"



$data="[s]Hallo,[/s] [b][i]wie[/i] [u]gehts[/u]?[/b]"&@CRLF& _
	  "[c=#00FF00]Grün"&@CRLF&"![/c]"&@CRLF& _
	  "[c=#00FF00]Moinsen,[/c] schwarz"&@CRLF& _
	  "[c=#FF0000]Moinsen,[/c] schwarz"&@CRLF


$Form1 = GUICreate("__A__",588,413)
$Edit1 = _ChatBoxCreate($Form1,"",8,8,572,397,"0x99FFFF")
GUISetState()

_ChatBoxAdd($Edit1,$data)



While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			ExitLoop
	EndSwitch
	Sleep(10)
WEnd


_ChatBoxDestroy($Edit1)


