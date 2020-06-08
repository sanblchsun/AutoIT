;  @AZJIO
#NoTrayIcon ; скрыть иконку в трее
Opt("GUICloseOnESC", 1) ; выход по ESC

$Gui = GUICreate("EXE2Bin.au3",  300, 94, -1, -1, -1, 0x00000010)

$filemenu = GUICtrlCreateMenu ("Файл")
$folder1 = GUICtrlCreateMenuitem ("Открыть",$filemenu)
$Readme = GUICtrlCreateMenuitem ("О программе",$filemenu)
$Quit = GUICtrlCreateMenuitem ("Выход",$filemenu)

$Input1 = GUICtrlCreateLabel('', 0, 0, 300, 94)
GUICtrlSetState(-1, 136) ; скрыть поле
GUICtrlCreateLabel ("Кинь сюда файл для конвертации в тело скрипта", 10,2,280,17)
$StatusBar=GUICtrlCreateLabel (@CRLF&@CRLF&'Строка состояния', 10,23,280,57)

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = -13
				$filename=StringRegExp(@GUI_DRAGFILE,'(^.*)\\(.*)\.(.*)$',3)
				GUICtrlSetData($StatusBar, 'Файл '&$filename[1]&'.'&$filename[2]&' принят'&@CRLF&'чтение...')
				$ScrBin='$sData  = ''0x'''&@CRLF
				$file = FileOpen(@GUI_DRAGFILE, 16)
				While 1
					$Bin = FileRead($file, 2040)
					If @error = -1 Then ExitLoop
					$ScrBin&='$sData  &= '''&StringTrimLeft($Bin,2)&''''&@CRLF
					Sleep(1)
				WEnd
				FileClose($file)
				GUICtrlSetData($StatusBar, 'Файл '&$filename[1]&'.'&$filename[2]&' принят'&@CRLF&'запись...')
				
				; генерируем имя нового файла с номером копии на случай если файл существует
				$Output = $filename[0]& '\Bin_'
				$i = 1
				While FileExists($Output & $i & '_'&$filename[1]&'.au3')
					$i += 1
				WEnd
				$Output = $Output & $i & '_'&$filename[1]&'.au3'
				
				; сохраняем бинарные данные в файл
				$file = FileOpen($Output,2)
				FileWrite($file, $ScrBin&@CRLF& _
				'$sData=Binary($sData)'&@CRLF& _
				'$file = FileOpen(@ScriptDir&''\Copy_'&$filename[1]&'.'&$filename[2]&''',18)'&@CRLF& _
				'FileWrite($file, $sData)'&@CRLF& _
				'FileClose($file)')
				FileClose($file)
				GUICtrlSetData($StatusBar, 'Файл '&$filename[1]&'.'&$filename[2]&' принят'&@CRLF&'Скрипт-файл Bin_'& $i & '_'&$filename[1]&'.au3 создан.')
				
			; Case $msg = $folder1
				; $folder01 = FileOpenDialog("Указать файл", @WorkingDir & "", "Все файлы (*.*)", 1 + 4 )
				; If @error Then ContinueLoop
				; GUICtrlSetData($Input1, $folder01)
				
			Case $msg = $Readme
				MsgBox(0, 'Readme', '     Утилитка предназначена для внедрения любого файла в тело скрипта. При использовании генерируется скрипт в той же папке где и сам принимаемый файл, в котором в бинарном виде находится принимаемый файл. При старте полученного скрипта, получаем копию этого файла, но уже сохранённого из скрипта, что является примером использования.'&@CRLF&'     Это может пригодится при использовании небольших exe-файлов работающих с ком-строкой. Например сохранить файл в %Temp%, запустить с ком-строкой, после выполнения удалить. Или для создания временного файла-скрипта, создание которого в текстовом виде имеет проблемы с синтаксисом.')
			Case $msg = -3 Or $msg = $Quit
				Exit
		EndSelect
	WEnd
