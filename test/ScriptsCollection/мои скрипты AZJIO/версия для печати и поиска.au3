;  @AZJIO

AutoItSetOption("TrayIconHide", 1) ;скрыть в системной панели индикатор AutoIt

GUICreate("Версия для печати на Ru.Board",440,240, -1, -1, -1, 0x00000010) ; размер окна

GUICtrlCreateLabel ("Путь к  сохранённому html-файлу (используйте drag-and-drop)", 20,10,400,18)
$inputhtm=GUICtrlCreateInput ("", 20,30,370,22)
GUICtrlSetState(-1,8)
$folder1 = GUICtrlCreateButton("...",394, 30, 27, 22)
GUICtrlSetFont(-1, 14)
GUICtrlSetTip(-1, "Обзор...")

$Label000=GUICtrlCreateLabel ('Строка состояния', 5,222,430,15)

$tab=GUICtrlCreateTab (0,60, 440,160) ; размер вкладки

$tab0=GUICtrlCreateTabitem ("Поиск")

GUICtrlCreateLabel ("Текст поиска", 20,85,400,18)
$inputFind=GUICtrlCreateInput ("", 20,102,400,22)

GUICtrlCreateLabel ("Начало ссылки, например http://...topic=41713", 20,135,400,18)
$inputHTML=GUICtrlCreateInput ("", 20,152,300,22)
$LabelHTML=GUICtrlCreateLabel ('', 330,154,90,22)
GUICtrlSetColor (-1, 0x0000ff)

$LabelSrt=GUICtrlCreateLabel ('', 20,185,90,22)
$LabelCur=GUICtrlCreateLabel ('', 120,185,90,22)

$check=GUICtrlCreateCheckbox("без сообщений", 220,183,100,22)
GUICtrlSetState(-1, 1)

$Find=GUICtrlCreateButton ("Поиск", 330,180,90,28)
GUICtrlSetTip(-1, "Поиск текста по страничке")


$tab0=GUICtrlCreateTabitem ("Цвет")

GUICtrlCreateGroup("", 20, 87, 390, 36)
GUICtrlCreateLabel ("цвет имени:", 40,100,70,20)
$colorname=GUICtrlCreateCombo ("", 110,97,80,24)
GUICtrlSetData(-1,'красный|синий|зелёный|чёрный', 'красный')

GUICtrlCreateLabel ("фон поста:", 240,100,60,20)
$colorbg=GUICtrlCreateCombo ("", 300,97,90,24)
GUICtrlSetData(-1,'св.красный|св.синий|св.зелёный|св.серый|св.жёлтый', 'св.зелёный')

$Readme=GUICtrlCreateButton ("Readme", 220,133,90,22)
$Replace=GUICtrlCreateButton ("Выполнить", 330,133,90,22)

GUICtrlCreateTabitem ("")   ; конец вкладок
$nVx=1
$r=0
$nStr=0

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		
		$r+=1
		If $r=500 Then ; каждые 0,7 секунд проверка инпут
		$r=0
			If $nVx>1 And $inputFind0<>GUICtrlRead ($inputFind) Then
				GUICtrlSetData($Find,'Поиск')
				GUICtrlSetData($LabelSrt,'')
				GUICtrlSetData($LabelCur,'')
				$nVx=1
			EndIf
		EndIf
		Select
; Вкладка "Поиск" текста
			Case $msg = $LabelHTML
				$inputHTML0=GUICtrlRead ($inputHTML)
				If  $nStr<>0 And $inputHTML0<>'' Then
					ShellExecute ($inputHTML0&'&start='&$nPost&'#'&$octatok+2)
				Else
					ShellExecute ('http://azjio.ucoz.ru')
				EndIf
			Case $msg = $Find
				$inputhtm0=GUICtrlRead ($inputhtm)
				$inputFind0=GUICtrlRead ($inputFind)
				$inputHTML0=GUICtrlRead ($inputHTML)
				If Not FileExists($inputhtm0) Then
					MsgBox(0, "Мелкая ошибка", 'Отсутствует файл '&$inputhtm0)
					ContinueLoop
				EndIf
				
				$file = FileOpen($inputhtm0, 0)
				$text = FileRead($file)
				FileClose($file)
				
				If $nVx=1 Then
					$inputFind000=StringRegExpReplace($inputFind0, "[][{}()*+?.\\^$|=<>#]", "\\$0")
					$text000 = StringRegExpReplace($text, $inputFind000, "$0")
					GUICtrlSetData($LabelSrt,'Найдено: '&@Extended)
					$text000 = ''
				EndIf
				
				$pos = StringInStr ($text, $inputFind0, 0, $nVx)
				If $pos = 0 Then
					GUICtrlSetData($Label000,  'Ничего не найдено')
					ContinueLoop
				EndIf
				$text = StringMid($text, 1, $pos)
				$text = StringRegExpReplace($text, '\>Автор:\<', "$0") ; подсчёт постов с последующим формированием ссылки и номера страницы
				$kol=@Extended-1
				$octatok = mod($kol, 20)
				$nPost=$kol-$octatok
				$nStr=($nPost+20)/20
				If $nStr = 1 Then $octatok=$octatok-1
				ClipPut('&start='&$nPost&'#'&$octatok+2) ; ссылку в буфер
				GUICtrlSetData($LabelCur,'Текущий: '&$nVx)
				If $inputHTML0<> '' Then
					GUICtrlSetData($LabelHTML,'Ссылка'&$nVx)
					GUICtrlSetTip($LabelHTML, $inputHTML0&'&start='&$nPost&'#'&$octatok+2)
				Else
					GUICtrlSetTip($LabelHTML, 'http://azjio.ucoz.ru')
				EndIf
				$nVx+=1
				GUICtrlSetData($Label000,  'Страница: '&$nStr&',   ссылка: &&start='&$nPost&'#'&$octatok+2)
				If GUICtrlRead ($check)<> 1 Then MsgBox(0, 'Сообщение', 'Страница: '&$nStr&@CRLF&@CRLF&'Окончание ссылки отправлено в буфер'&@CRLF&'&start='&$nPost&'#'&$octatok+2)
				GUICtrlSetData($Find,'Далее')
				
; вкладка замена цвета
			Case $msg = $Replace
				$colorname0=GUICtrlRead ($colorname)
				Switch $colorname0
				Case $colorname0="красный"
				    $colorname00 = "ff0000"
				Case $colorname0="зелёный"
				    $colorname00 = "00bb00"
				Case $colorname0="синий"
				    $colorname00 = "0000ff"
				Case $colorname0="чёрный"
				    $colorname00 = "000000"
				Case Else
				    $colorname00 = "ff0000"
				EndSwitch
				
				
				$colorbg0=GUICtrlRead ($colorbg)
				Switch $colorbg0
				Case $colorbg0="св.красный"
				    $colorbg00 = "ffeeee"
				Case $colorbg0="св.зелёный"
				    $colorbg00 = "eeffee"
				Case $colorbg0="св.синий"
				    $colorbg00 = "eeeeff"
				Case $colorbg0="св.серый"
				    $colorbg00 = "eeeeee"
				Case $colorbg0="св.жёлтый"
				    $colorbg00 = "fffddb"
				Case Else
				    $colorbg00 = "eeffee"
				EndSwitch
				
				
				$inputhtm0=GUICtrlRead ($inputhtm)
				; проверяем существование, делаем бэкап и открываем файл для замены текста
				If Not FileExists($inputhtm0) Then
					MsgBox(0, "Мелкая ошибка", 'Отсутствует файл '&$inputhtm0)
					ContinueLoop
				EndIf
				$aPathname = StringRegExp($inputhtm0, "(^.*)\\(.*)$", 3)
				  $filehtm = FileOpen($inputhtm0, 0)
				; проверка открытия файла для записи строки
				If $filehtm = -1 Then
				  MsgBox(0, "Ошибка", "Не возможно открыть файл.")
				  Exit
				EndIf
				; читаем содержимое
				$filehtm0 = FileRead($filehtm)
				
				
				If StringInStr($filehtm0, "<br><b>Автор:</b> ") >0 Then
						   $SR1 = StringReplace($filehtm0, '<br><b>Автор:</b> ', '<br>Автор:<FONT color=#'&$colorname00&'><b> ')
						   $SR1 = StringReplace($SR1, ', <b>Отправлено:</b>', '</b></FONT>, Отправлено: ')
						   $SR1 = StringReplace($SR1, '<img width=100% height=1 src="1px.gif" alt="">', "")
						   $SR1 = StringReplace($SR1, '<tr bgcolor=#FFFFFF>', '<tr bgcolor=#'&$colorbg00&'>')
				Else
						   $SR1 = StringRegExpReplace ($filehtm0, '<br>Автор:<FONT color=.{7}><b> ', '<br>Автор:<FONT color=#'&$colorname00&'><b> ')
						   $SR1 = StringRegExpReplace ($SR1, '<tr bgcolor=.{7}>', '<tr bgcolor=#'&$colorbg00&'>')
				EndIf
				  
				  $filehtmnew = FileOpen($aPathname[0]&"\new_"&$aPathname[1], 2)
				  FileWrite($filehtmnew, $SR1)
				  FileClose($filehtm)
				  FileClose($filehtmnew)
				  GUICtrlSetData($Label000, 'Готово...')
			Case $msg = $Readme
				  MsgBox(0, "Readme", 'На руборде удобно сохранять страничку как "версия для печати", даже поиск по форуму не даст таких результатов, как поиск по старничке. Но сохраняемая страничка нечитабельна, имена авторов и их посты сливаются в единый текст - чёрное на белом. Для исправления недостатка сохраняем страничку и кидаем *.htm в поле программы, выбираем цвета, выполняем замену в тегах кнопкой "Выполнить", открываем страничку в браузере и читаем в удобном виде.')
				  
			Case $msg = $folder1
				$inputhtm0=GUICtrlRead ($inputhtm)
				If FileExists($inputhtm0) Then
					$WorkingDir=StringRegExpReplace($inputhtm0, '(.*)\\(?:.*)$', '\1')
				Else
					$WorkingDir=@WorkingDir
				EndIf
				$folder01 = FileOpenDialog("Указать HTML-файл", $WorkingDir & "", "HTML-файл (*.htm;*.html)", 1 + 4 )
				If @error Then ContinueLoop
				GUICtrlSetData($inputhtm, $folder01)
			Case $msg = -3
				ExitLoop
		EndSelect
	WEnd

