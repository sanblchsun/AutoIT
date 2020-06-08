;If IsAdmin() Then MsgBox(0, "", "ты админ")


$test = 'копируем это в код программы, вставляем сюда переменную.'

If IsBinary($test) Then MsgBox(0, 'Сообщение', "бинарные")
if isBool($test) then Msgbox(0, 'Сообщение', "логическое (true, false)")
if IsDllStruct($test) Then MsgBox(0, 'Сообщение', "DLL-структура")
if IsFloat($test) Then MsgBox(0, 'Сообщение', "С плавающей запятой")
if IsHWnd($test) Then MsgBox(0, 'Сообщение', "тип HWnd")
if IsNumber($test) Then MsgBox(0, 'Сообщение', "это число")
if IsInt($test) Then MsgBox(0, 'Сообщение', "целое число")
if IsKeyword($test) Then MsgBox(0, 'Сообщение', "Ключевое слово")
if IsObj($test) Then MsgBox(0, 'Сообщение', "объект")
if IsString($test) Then MsgBox(0, 'Сообщение', "текст")
; шаблон if ($test) Then MsgBox(0, 'Сообщение', "")





; проверка с помощью VarGetType
Dim $Var[11][2] = [ _
['Array','Массив'&@CRLF&'Array'], _
['Binary','Бинарные'&@CRLF&'Binary'], _
['Bool','Логическое (true, false)'&@CRLF&'Bool'], _
['DLLStruct','DLL-структура'&@CRLF&'DLLStruct'], _
['Double','С плавающей запятой'&@CRLF&'Double'], _
['Ptr','HWnd - Хэндл, Дескриптор'&@CRLF&'Ptr'], _
['-','-'], _
['Int32','Целое число'&@CRLF&'Int32'], _
['Keyword','Ключевое слово'&@CRLF&'Keyword'], _
['Object','Объект'&@CRLF&'Object'], _
['String','Текст'&@CRLF&'String'] _
]

$Var1=VarGetType($test)
For $i = 0 to 10
	If $Var1 = $Var[$i][0] Then
		$Var1 = $Var[$i][1]
		ExitLoop
	EndIf
Next

MsgBox(0, 'VarGetType', $Var1)