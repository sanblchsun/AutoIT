; Вытаскиваем разрешение экрана из потока данных
$rnim = Run(@ScriptDir&'\DumpEDID.exe', @SystemDir, @SW_HIDE, 2)
$param=''
While 1
    $param &= StdoutRead($rnim)
    If @error Then ExitLoop
Wend
   $resize = StringRegExpReplace($param, '(?s)(.*Maximum Resolution.*?)(\d{3,}) X (\d{3,}).*', '\2|\3')
If $resize='' Then Exit

$aResize=StringSplit($resize, '|')
; выход из скрипта, если в переменной окажутся разрешения экрана менее 800х600 или более 1600х1200
If $aResize[2]<600 Or $aResize[2]>1200 Or $aResize[1]<800 Or $aResize[1]>1600 Then Exit

; при согласии в мессаге проверяем наличие одной из утилит смены разрешения, стартуем её и выходим из скрипта.
If MsgBox(4, 'Сообщение', 'Установить это разрешение экрана?'&@CRLF&@CRLF&$aResize[1]&' x '&$aResize[2])= "6" Then
	If FileExists(@SystemDir&'\MultiRes.exe') Then
		Run(@SystemDir&'\MultiRes.exe /'&$aResize[1]&','&$aResize[2]&',32,75 /exit', @SystemDir, @SW_HIDE)
		Exit
	EndIf
	If FileExists(@SystemDir&'\setres.exe') Then
		Run(@SystemDir&'\setres.exe h'&$aResize[1]&' v'&$aResize[2]&' b32 f75', @SystemDir, @SW_HIDE)
		Exit
	EndIf
	If FileExists(@SystemDir&'\nircmd.exe') Then
		Run(@SystemDir&'\nircmd.exe setdisplay '&$aResize[1]&' '&$aResize[2]&' 32 75', @SystemDir, @SW_HIDE)
		Exit
	EndIf
	If FileExists(@SystemDir&'\qres.exe') Then
		Run(@SystemDir&'\qres.exe /x '&$aResize[1]&' /y '&$aResize[2]&' /c:32 /r:60', @SystemDir, @SW_HIDE)
		Exit
	EndIf
EndIf