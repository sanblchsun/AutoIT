;  @AZJIO
#include <WindowsConstants.au3>
#include <GUIConstants.au3>

AutoItSetOption("TrayIconHide", 1) ;скрыть в системной панели индикатор AutoIt


Global $aDelfile
Global $aDeldir

GUICreate("форматирование версии для печати",440,130, -1, -1, -1, $WS_EX_ACCEPTFILES) ; размер окна

GUICtrlCreateLabel ("Путь к файлу (используйте drag-and-drop)", 20,10,400,18)
$inputhtm=GUICtrlCreateInput ("", 20,30,400,22)
GUICtrlSetState(-1,8)


GUICtrlCreateGroup("", 20, 57, 390, 36)
GUICtrlCreateLabel ("цвет имени:", 40,70,70,20)
$colorname=GUICtrlCreateCombo ("", 110,67,80,24)
GUICtrlSetData(-1,'красный|синий|зелёный|чёрный', 'красный')

GUICtrlCreateLabel ("фон поста:", 240,70,60,20)
$colorbg=GUICtrlCreateCombo ("", 300,67,90,24)
GUICtrlSetData(-1,'св.красный|св.синий|св.зелёный|св.серый|св.жёлтый', 'св.зелёный')

GUICtrlCreateGroup("", 20, 95, 140, 30)
$Label000=GUICtrlCreateLabel ('Строка состояния', 40,105,100,18)
$Readme=GUICtrlCreateButton ("Readme", 220,100,90,22)


$Replace=GUICtrlCreateButton ("Выполнить", 330,100,90,22)


GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
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
				
				
						   $SR1 = StringReplace($filehtm0, '<br><b>Автор:</b> ', '<br>Автор:<FONT color=#'&$colorname00&'><b> ')
						   $SR1 = StringReplace($SR1, ', <b>Отправлено:</b>', '</b></FONT>, Отправлено: ')
						   $SR1 = StringReplace($SR1, '<img width=100% height=1 src="1px.gif" alt="">', "")
						   $SR1 = StringReplace($SR1, '<tr bgcolor=#FFFFFF>', '<tr bgcolor=#'&$colorbg00&'>')
				  
				  $filehtmnew = FileOpen($aPathname[0]&"\new_"&$aPathname[1], 2)
				  FileWrite($filehtmnew, $SR1)
				  FileClose($filehtm)
				  FileClose($filehtmnew)
				  GUICtrlSetData($Label000, 'Готово...')
			Case $msg = $Readme
				  MsgBox(0, "Readme", 'На руборде удобно сохранять страничку как "версия для печати", даже поиск по форуму не даст таких результатов, как поиск по старничке. Но сохраняемая страничка нечитабельна, имена авторов и их посты сливаются в единый текст - чёрное на белом. Для исправления недостатка сохраняем страничку и кидаем *.htm в поле программы, выбираем цвета, выполняем замену в тегах кнопкой "Выполнить", открываем страничку в браузере и читаем в удобном виде.')
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd

