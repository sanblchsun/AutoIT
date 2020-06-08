#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Patch_SETUPLDR.exe
#AutoIt3Wrapper_icon=Patch_SETUPLDR.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Patch_SETUPLDR.exe
#AutoIt3Wrapper_Res_Fileversion=1.1.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 16.05.2010
#NoTrayIcon

Global $gaDropFiles, $chars, $chars1, $chars2, $chars3, $chars4, $PathFiles, $charstext, $gaDropFiles1, $namefiles, $z, $chars000

$Gui = GUICreate("Patch SETUPLDR.BIN", 340, 140, -1, -1, -1,0x00000010)
GUICtrlCreateLabel("", -1, -1, 350, 140)
GUICtrlSetState(-1, 136)
$Label001=GUICtrlCreateLabel("Кинь сюда SETUPLDR.BIN, чтобы увидеть его параметры", 5, 3, 330, 20)
$readme=GUICtrlCreateButton ("readme", 154, 97, 48, 22)

; элементы первоначально создаются за пределами окна этой утилиты
$Label1=GUICtrlCreateLabel ('', 5,25,75,20)
$Label2=GUICtrlCreateLabel ('', 5,50,75,20)
$Label3=GUICtrlCreateLabel ('', 5,75,75,20)
$Label4=GUICtrlCreateLabel ('', 5,100,145,20)
$byfer1=GUICtrlCreateButton ("в буфер", 370,20,55,22)
$byfer2=GUICtrlCreateButton ("в буфер", 370,45,55,22)
$byfer3=GUICtrlCreateButton ("в буфер", 370,70,55,22)
$replace1=GUICtrlCreateButton ("заменить на", 370,20,75,72)
GUICtrlSetTip(-1, "Замена выполняется только"&@CRLF&"для заполненых полей ввода"&@CRLF&"и отмеченных чекбоксов")
$reinp1=GUICtrlCreateCombo ("", 370,20,105,22)
$reinp2=GUICtrlCreateCombo ("", 370,45,105,22)
GUICtrlSetData(-1,'|WINNT.SIF|WINNT.TXT|WINPE.SIF|256MB.SIF|I586\WN.S|BOOT\WN.S', '')
$reinp3=GUICtrlCreateCombo ("", 370,70,105,22)
GUICtrlSetData(-1,'|TXTSETUP.SIF|TXTSETNS.SIF|TXTSETAM.SIF', '')

$Label11=GUICtrlCreateLabel ('', 330,25,25,20)
GUICtrlSetTip(-1, "Количество замен")
$Label12=GUICtrlCreateLabel ('', 330,50,25,20)
GUICtrlSetTip(-1, "Количество замен")
$Label13=GUICtrlCreateLabel ('', 330,75,25,20)
GUICtrlSetTip(-1, "Количество замен")
$check1= GUICtrlCreateCheckbox("", 370,100,115,20)
$Label5=GUICtrlCreateLabel ('					AZJIO 12.02.2010', 5,120,330,20)

GUISetState()

While 1
	$msg = GUIGetMsg()
	Select
        Case $msg = $byfer1
            ClipPut($chars1)
            GUICtrlSetData($Label5, 'Скопировано в буфер '&$chars1)
        Case $msg = $byfer2
            ClipPut($chars2)
            GUICtrlSetData($Label5, 'Скопировано в буфер '&$chars2)
        Case $msg = $byfer3
            ClipPut($chars3)
            GUICtrlSetData($Label5, 'Скопировано в буфер '&$chars3)

; Выполнить замену
; ========================================================
        Case $msg = $replace1
			$reinp0=GUICtrlRead($reinp1)
			$reinp02=GUICtrlRead($reinp2)
			$reinp03=GUICtrlRead($reinp3)
				$err=''
				
			If StringLen($chars1)=4 Then
			
; условие для i386
			If $reinp0<>'' Then
			If StringLen($reinp0)=4 Then
				$reinp0 = StringTrimLeft(StringToBinary($reinp0), 2)
				$chars000=$chars1
				_regex()
				$chars = StringRegExpReplace($chars, $z&"(?=5C(53|73|6E|4E))", $reinp0)
				GUICtrlSetData($Label11, @extended)
				$err=0
			Else
				MsgBox(0, "Сообщение", $reinp0&@CRLF&"Требуется ввести 4 символа")
				$err=1
			EndIf
			EndIf
			
			Else
			
; условие для minint
			If $reinp0<>'' Then
			If StringLen($reinp0)=6 Then
				$reinp0 = StringTrimLeft(StringToBinary($reinp0), 2)
				$chars000=$chars1
				_regex()
				$chars = StringRegExpReplace($chars, $z&"(?=5C)", $reinp0)
				GUICtrlSetData($Label11, @extended)
				$err=0
			Else
				MsgBox(0, "Сообщение", $reinp0&@CRLF&"Требуется ввести 6 символов")
				$err=1
			EndIf
			EndIf
			
			EndIf

; условие для winnt.sif
			If $reinp02<>'' Then
			If StringLen($reinp02)=9 Then
				$reinp0 = StringTrimLeft(StringToBinary($reinp02), 2)
				$chars000=$chars2
				_regex()
				$chars = StringRegExpReplace($chars, $z, $reinp0)
				GUICtrlSetData($Label12, @extended)
				$err=0
			Else
				MsgBox(0, "Сообщение", $reinp02&@CRLF&"Требуется ввести 9 символов")
				$err=1
			EndIf
			EndIf

; условие для txtsetup.sif
			If $reinp03<>'' Then
			If StringLen($reinp03)=12 Then
				$reinp0 = StringTrimLeft(StringToBinary($reinp03), 2)
				$chars000=$chars3
				_regex()
				$chars = StringRegExpReplace($chars, $z, $reinp0)
				GUICtrlSetData($Label13, @extended)
				$err=0
			Else
				MsgBox(0, "Сообщение", $reinp03&@CRLF&"Требуется ввести 12 символов")
				$err=1
			EndIf
			EndIf

; условие для контроля оригинала EB1A 7403
			If $chars4='0xEB1A' and GUICtrlRead($check1)=1 Then $chars = StringRegExpReplace($chars, "EB1A(?=E9080039)", "7403")
			If $chars4='0x7403' and GUICtrlRead($check1)=1 Then $chars = StringRegExpReplace($chars, "7403(?=E9080039)", "EB1A")
			
; ========================================================
			If $err<>1 Then
; генерируем имя нового файла с приставкой new и номером копии на случай если файл существует
			For $i=1 To 200
			   If Not FileExists($namefiles[0]&'\new'&$i&'_'&$namefiles[1]) Then
			      $newfile=$namefiles[0]&'\new'&$i&'_'&$namefiles[1]
			      ExitLoop
			   EndIf
			Next
; Открываем файл в бинарном виде, записываем данные, закрываем с сохранением.
			$file1 = FileOpen($newfile,18)
			FileWrite($file1,  $chars)
			FileClose($file1)
			EndIf

            $newfileL=StringRegExp($newfile, "(^.*)\\(.*)$", 3)
            GUICtrlSetData($Label5, 'Проверте "'&$newfileL[1]&'", перетащив в это окно')
        Case $msg = -13
                AddDropedFiles(@GUI_DRAGFILE)
        Case $msg = $readme
                MsgBox(0, "Readme", 'Поддерживаемые загрузчики:'&@CRLF&'247024 (241кб) SP1 многоядерность на флешке'&@CRLF&'261376 (255кб) SP2 одноядерный (например Alkid)'&@CRLF&'298096 (291кб) IMG-одноядерный'&@CRLF&'302192 (295кб) IMG многоядерный'&@CRLF&'314480 (307кб) WIM'&@CRLF&'318576 (311кб) WIM-мультиядерный'&@CRLF&'322672 (315кб) WIM-мультиядер, мультитом'&@CRLF&'366172 (357кб) WIM-мультиядер, мультитом с NTDETECT.COM'&@CRLF&@CRLF&'282112 (275кб) IMG-мультиядерный, для сети (PXELDR)'&@CRLF&'298496 (291кб) WIM-мультиядерный, для сети (PXELDR)'&@CRLF&'346092 (337кб) WIM-мультиядерный, для сети (PXELDR)'&@CRLF&@CRLF&'7403 > EB1A - избавиться от сообщения "NTLDR corrupt"')
        Case $msg = -3
            Exit
	EndSelect
WEnd

; функция для файлов брошенных в окно программы
;=============================================================
Func AddDropedFiles($gaDropFiles)
$PathFiles=$gaDropFiles
$namefiles=StringRegExp($gaDropFiles, "(^.*)\\(.*)$", 3)
$gaDropFiles1=FileGetSize ( $gaDropFiles )
If $gaDropFiles1 > 1000000 Then
    MsgBox(0, "Ошибка", "Файл великоват для загрузчика.")
    Return
EndIf

GUICtrlSetData($Label5, '')
; условие для зарегистрированных загрузчиков с известными размерами
If $gaDropFiles1=298096 Or $gaDropFiles1=302192 Or $gaDropFiles1=314480 Or $gaDropFiles1=318576 Or $gaDropFiles1=261376 Or $gaDropFiles1=247024 Or $gaDropFiles1=366172 Or $gaDropFiles1=322672 Or $gaDropFiles1=346092 Or $gaDropFiles1=298496 Or $gaDropFiles1=282112 Then
$file = FileOpen($gaDropFiles,16)

If $file = -1 Then
    MsgBox(0, "Ошибка", "Невозможно открыть файл.")
    Exit
 EndIf

$chars = FileRead($file)
If @error = -1 Then
    MsgBox(0, "Ошибка", "Невозможно прочитать файл.")
    Exit
 EndIf

; взависимости от размера, файлы группируются по типам и для разных типов разное смещение патернов (образцов текста)
If $gaDropFiles1=298096 Or $gaDropFiles1=302192 Or $gaDropFiles1=314480 Or $gaDropFiles1=318576 Or $gaDropFiles1=366172 Or $gaDropFiles1=322672 Then
	   $chars1 = BinaryToString(BinaryMid($chars, 191850, 4))
	   $chars2 = BinaryToString(BinaryMid($chars, 172887, 9))
	   $chars3 = BinaryToString(BinaryMid($chars, 173315, 12))
	   GUICtrlSetData($reinp1,'|I386|A386|B386|L386|N386|R386|S386|X386|I486|I586|VAPE|LVCD|BOOT', '')
	   $chars4 = BinaryMid($chars, 8289, 2)
EndIf
If $gaDropFiles1=261376 Then
	   $chars1 = BinaryToString(BinaryMid($chars, 140924, 6))
	   $chars2 = BinaryToString(BinaryMid($chars, 140643, 9))
	   $chars3 = BinaryToString(BinaryMid($chars, 140903, 12))
	   GUICtrlSetData($reinp1,'|MININT|MININ_|MININ1|MININ2|MININ3|MININ4|MININ5', '')
	   $chars4 = ''
EndIf
If $gaDropFiles1=247024 Then
	   $chars1 = BinaryToString(BinaryMid($chars, 132812, 6))
	   $chars2 = BinaryToString(BinaryMid($chars, 132531, 9))
	   $chars3 = BinaryToString(BinaryMid($chars, 132791, 12))
	   GUICtrlSetData($reinp1,'|MININT|MININ_|MININ1|MININ2|MININ3|MININ4|MININ5', '')
	   $chars4 = ''
EndIf
If $gaDropFiles1=346092 Or $gaDropFiles1=298496 Or $gaDropFiles1=282112 Then
	   $chars1 = BinaryToString(BinaryMid($chars, 171770, 4))
	   $chars2 = BinaryToString(BinaryMid($chars, 152807, 9))
	   $chars3 = BinaryToString(BinaryMid($chars, 153235, 12))
	   GUICtrlSetData($reinp1,'|I386|A386|B386|L386|N386|R386|S386|X386|I486|I586|VAPE|LVCD|BOOT', '')
	   $chars4 = ''
EndIf

FileClose($file)
_butcr()

Else
    $answer = MsgBox(4, "Сообщение", 'Неизвестный утилите файл. '&@CRLF&'Прочитать его как для WIM?'&@CRLF&'Если имена будут валидными'&@CRLF&'то патчить допустимо.')
	If $answer = "6" Then
	$file = FileOpen($gaDropFiles,16)

If $file = -1 Then
    MsgBox(0, "Ошибка", "Невозможно открыть файл.")
    Exit
 EndIf

$chars = FileRead($file)
If @error = -1 Then
    MsgBox(0, "Ошибка", "Невозможно прочитать файл.")
    Exit
 EndIf
 
	   $chars1 = BinaryToString(BinaryMid($chars, 191850, 4))
	   $chars2 = BinaryToString(BinaryMid($chars, 172887, 9))
	   $chars3 = BinaryToString(BinaryMid($chars, 173315, 12))
	   GUICtrlSetData($reinp1,'|I386|A386|B386|L386|N386|R386|S386|X386|I486|I586|VAPE|LVCD|BOOT', '')
	   $chars4 = BinaryMid($chars, 8289, 2)
FileClose($file)
	   _butcr()
	EndIf
EndIf
EndFunc

; Функция создания шаблона для регулярного выражения
;=============================================================
Func _regex()
$a = StringSplit(StringLower($chars000), "")
$B = StringSplit(StringUpper($chars000), "")
$z = ''
; создаём шаблон ($z) для регулярного выражения
			For $i=1 To $a[0]
			   If $a[$i]==$B[$i] Then
				$z&=Hex(Asc($a[$i]), 2)
			  Else
				$z&='('&Hex(Asc($a[$i]), 2)&'|'&Hex(Asc($B[$i]), 2)&')'
			  EndIf
			Next
EndFunc

; Функция создания кнопок
;=============================================================
Func _butcr()
; отобразим все элементы (кнопки, раскрывающиеся списки, тексты) при получении файла
GUICtrlSetData($Label1, $chars1)
GUICtrlSetData($Label2, $chars2)
GUICtrlSetData($Label3, $chars3)
GUICtrlSetData($Label4, 'Размер: '&$gaDropFiles1&' байт, '&Round($gaDropFiles1/1024, 0)&'кб')
GUICtrlSetPos($byfer1, 80,20)
GUICtrlSetPos($byfer2, 80,45)
GUICtrlSetPos($byfer3, 80,70)
GUICtrlSetPos($replace1, 140,20)
GUICtrlSetPos($reinp1, 220,20)
GUICtrlSetPos($reinp2, 220,45)
GUICtrlSetPos($reinp3, 220,70)
GUICtrlSetData($Label001, 'Файл "'&$namefiles[1]&'" получен.')
GUICtrlSetData($Label11, '0')
GUICtrlSetData($Label12, '0')
GUICtrlSetData($Label13, '0')


If $chars4='0xEB1A' Then
GUICtrlSetPos($check1, 220,100)
GUICtrlSetData($check1, "Прописать 74 03")
GUICtrlSetState($check1, 4)
GUICtrlSetTip($check1, "Не рекомендуется")
EndIf

If $chars4='0x7403' Then
GUICtrlSetPos($check1, 220,100)
GUICtrlSetData($check1, "Прописать EB 1A")
GUICtrlSetState($check1, 1)
GUICtrlSetTip($check1, "Рекомендуется")
EndIf

If $chars4<>'0x7403' and $chars4<>'0xEB1A' Then GUICtrlSetPos($check1, 370,100)

EndFunc
