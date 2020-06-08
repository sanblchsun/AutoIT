$Gui = GUICreate("Смотрим IP",  420, 100)

$Label2 = GUICtrlCreateLabel("Скопируй сюда линк", 10, 10, 186, 17)
$Input2 = GUICtrlCreateInput("", 10, 27, 400, 21)
$folder2 = GUICtrlCreateButton("Получить", 340, 55, 70, 23)
$info = GUICtrlCreateLabel ("", 10,60,320,34)


TCPStartUp()
GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg =  $folder2
			$adres=GUICtrlRead ($Input2)
			$adres1 = StringRegExpReplace($adres, "(?:http[s]?\:\/\/)*(?:www\.)*(.*?[^\/]*)(?:.*)", "\1")
			$IP=TCPNameToIP($adres1)
			GUICtrlSetData($info,$adres1&@CRLF&$IP &'   (Скопирован в буфер)')
			ClipPut($IP)
		Case $msg = -3
			ExitLoop
	EndSelect
WEnd
TCPShutdown() 
