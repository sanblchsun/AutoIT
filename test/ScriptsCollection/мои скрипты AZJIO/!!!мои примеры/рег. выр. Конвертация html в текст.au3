
$OpenFile = FileOpenDialog('Открыть', @WorkingDir , "веб-страница (*.htm*)")
If @error Then Exit

$file = FileOpen($OpenFile, 0)
$text = FileRead($file)
FileClose($file)

;http://www.shtogrin.com/library/web/pcre/examples/convert_html2txt/
; в чётных строках текст поиска, в нечётных текст замены
Dim $search[17] = [16, _
'<script[^>]*?>.*?</script>', _
'', _
'<[\/\!]*?[^<>]*?>', _
@CRLF, _
; '', _  ; возможны два варианта либо @CRLF, либо ничего. По предпочтению.
'&(quot|#34);', _
'"', _
'&(amp|#38);', _
'&', _
'&(lt|#60);', _
'<', _
'&(gt|#62);', _
'>', _
'&(nbsp|#160);', _
' ', _
'([\r\n])[\s]+', _
@CRLF]


For $i = 1 to $search[0] Step 2
	$text = StringRegExpReplace($text,$search[$i],$search[$i+1])
Next


$file = FileOpen(@ScriptDir&'\Name.txt',2)
FileWrite($file, $text)
FileClose($file)