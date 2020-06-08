#include <Encoding.au3>

; ‘ункцию _CyrillicTo1251 используем когда кодировка строки заранее неизвестна.  онвертит строки следующих 5 кодировок: KOI8-R, IBM-866, ISO-8859-5, HEX, UTF8

ConsoleWrite(@CRLF & "=========== _Encoding_CyrillicTo1251 ")

_Output("_Encoding_CyrillicTo1251", _ ; latin
	_Encoding_CyrillicTo1251("The only fun remained to me - put fingers in the mouth and whistle merrily"))
_Output("_Encoding_CyrillicTo1251", _ ; win
	_Encoding_CyrillicTo1251("ћне осталась одна забава: пальцы в рот - и веселый свист."))
_Output("_Encoding_CyrillicTo1251", _ ; dos
	_Encoding_CyrillicTo1251("ПаЃ™†в®Ђ†бм §га≠†п бЂ†Ґ†, звЃ ѓЃе†°≠®™ п ® б™†≠§†Ђ®бв."))
_Output("_Encoding_CyrillicTo1251", _ ; koi
	_Encoding_CyrillicTo1251("б»! ЋЅЋЅ— ”Ќ≈џќЅ— –ѕ‘≈“—! нќѕ«ѕ „ ÷…Џќ… ”Ќ≈џќў» –ѕ‘≈“Ў."))
_Output("_Encoding_CyrillicTo1251", _ ; iso
	_Encoding_CyrillicTo1251("Ѕвл‘Ёё №Ё’, звё п “ ±ё”– Ё’ “’аЎџ. ≥ёамЏё №Ё’, звё Ё’ “’ао в’я’ам."))
_Output("_Encoding_CyrillicTo1251", _ ; utf8
	_Encoding_CyrillicTo1251("пїњ–Ч–Њ–ї–Њ—В—Л–µ –і–∞–ї—С–Ї–Є–µ –і–∞–ї–Є! –Т—Б—С —Б–ґ–Є–≥–∞–µ—В –ґ–Є—В–µ–є—Б–Ї–∞—П –Љ—А–µ—В—М."))
_Output("_Encoding_CyrillicTo1251", _ ; hex
	_Encoding_CyrillicTo1251("=E9 =D0=CF=C8=C1=C2=CE=C9=DE=C1=CC =D1 =C9 =D3=CB=C1=CE=C4=C1=CC=C9=CC =C4=CC=D1 =D4=CF=C7=CF=2C =DE=D4=CF=C2=D9 =D1=D2=DE=C5 =C7=CF=D2=C5=D4=D8=2E"))
	
ConsoleWrite(@CRLF & "=========== _Encoding_XToY ")

; Ќижеследующие функции используем когда кодировка известна
_Output("_Encoding_866To1251", _ ; dos
	_Encoding_866To1251("Д†а ѓЃнв† - Ђ†б™†вм ® ™†ап°†вм, аЃ™ЃҐ†п ≠† ≠•ђ ѓ•з†вм."))
_Output("_Encoding_KOI8To1251", _ ; koi
	_Encoding_KOI8To1251("тѕЏ’ ¬≈ћ’ј ” ё≈“ќѕ  ÷Ѕ¬ѕ  — »ѕ‘≈ћ ќЅ Џ≈Ќћ≈ –ѕ„≈ќёЅ‘Ў."))
_Output("_Encoding_ISO8859To1251", _ ; iso
	_Encoding_ISO8859To1251("њгбвм Ё’ бџ–‘ЎџЎбм, ягбвм Ё’ б—лџЎбм нвЎ яё№лбџл аё„ё“ле ‘Ё’ў."))
_Output("_Encoding_HexSymbolsToANSI", _ ; hex
	_Encoding_HexSymbolsToANSI("=CD=EE =EA=EE=EB=FC =F7=E5=F0=F2=E8 =E2 =E4=F3=F8=E5 =E3=ED=E5=E7=E4=E8=EB=E8=F1=FC =2D =C7=ED=E0=F7=E8=F2=2C =E0=ED=E3=E5=EB=FB =E6=E8=EB=E8 =E2 =ED=E5=E9=2E"))

ConsoleWrite(@CRLF & "=========== _Encoding_GetCyrillicANSIEncoding ")

; ‘ункци€ _Encoding_GetCyrillicANSIEncoding определ€ет ANSI кодировки: KOI8-R, WINDOWS-1251, IBM-866, ISO-8859-5. “ребует не менее 3-4 осмысленых русских слов дл€ уверенного определени€
_Output("_Encoding_GetCyrillicANSIEncoding", _ ; koi
	_Encoding_GetCyrillicANSIEncoding("оѕ ЋѕћЎ ё≈“‘… „ ƒ’џ≈ «ќ≈Џƒ…ћ…”Ў - ЏќЅё…‘, Ѕќ«≈ћў ÷…ћ… „ ќ≈ ."))
_Output("_Encoding_GetCyrillicANSIEncoding", _ ; win
	_Encoding_GetCyrillicANSIEncoding("¬от за это веселие мути, отправл€€сь с ней в край иной,"))
_Output("_Encoding_GetCyrillicANSIEncoding", _ ; iso
	_Encoding_GetCyrillicANSIEncoding("ѕ еёзг яаЎ яёбџ’‘Ё’ў №ЎЁгв’ њёяаёбЎвм в’е, Џвё —г‘’в бё №Ёёў, -"))
_Output("_Encoding_GetCyrillicANSIEncoding", _ ; dos
	_Encoding_GetCyrillicANSIEncoding("ЧвЃ° І† Ґб• І† £а•е® ђЃ® вп¶™®•, І† ≠•Ґ•а®• Ґ °Ђ†£Ѓ§†вм"))

Func _Output($sFunction, $sData)
	ConsoleWrite("===========" & @CRLF & $sFunction & ": " & $sData & @CRLF)
EndFunc
