#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=FixMegaFon.exe
#AutoIt3Wrapper_Icon=FixMegaFon.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=FixMegaFon.exe
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.1
#AutoIt3Wrapper_Res_Field=Build|2012.07.02
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; Скрипт автоматического подключения интернет-мегафона.
; Действия: при вставке брелка в USB запускаем скрипт, который ожидает автоопределения устройств системой, далее подключает и сворачивает в трей. Дополнительно восстанавливает галочку "Oтoбpaжaть coдepжимoe oкнa пpи пepeтacкивaнии", которую мегафоновская программа сбрасывает по непонятной причине.

; AZJIO 04.08.2012

Global $sPath = @ProgramFilesDir & '\MegaFon Internet\MegaFon Internet.exe'
Global $hMF_Inet, $title_MF_Inet = "МегаФон Интернет"
; TraySetIcon('shell32.dll', -149)
If @Compiled Then ; иконка сигнализирующая работу программы
	TraySetIcon('FixMegaFon.exe', 0)
Else
	TraySetIcon('FixMegaFon.ico', 0)
EndIf

If ProcessExists('MegaFon Internet.exe') Then
	$hMF_Inet = WinActivate($title_MF_Inet) ; активируем окно
	$hMF_Inet = WinWaitActive($title_MF_Inet, '', 2) ; ждём активации окна
	If $hMF_Inet Then ; если окно активировалось, то подключение
		_Connect1()
		_Connect2()
	Else
		; если окно не активировалось в течении 2 сек, то предлагаем перезапустить
		If MsgBox(4, 'Сообщение', 'Программа уже запущена и должна быть в трее' & @CRLF & 'Хотите перезапустить программу?') = 6 Then
			If Not WinClose($title_MF_Inet) Then
				ProcessClose('MegaFon Internet.exe')
				If Not ProcessWaitClose("MegaFon Internet.exe", 2) Then _Exit()
			EndIf
		Else
			_Exit() ; тут подключить
		EndIf
	EndIf
EndIf

; проверяем 12 раз с паузой в 3 секунды появление нечитаемого USB и CD-ROM-устройства
$iDrivesExists = 0
For $i = 1 To 12
	$iDrivesExists = _DrivesTrue()
	If $iDrivesExists Then ExitLoop
	TrayTip('Поиск устройств', 'Попытка ' & $i & ' (не найдено)', 3, 1)
	If $i = 12 Then _Exit() ; Выход если на 12 попытке цикл закончился без обнаружения устройств
	Sleep(3000)
Next
TrayTip('Поиск устройств', 'Устройства обнаружены', 3, 1)

; Запускаем и подключаем модем Мегафон
Run($sPath)
_Connect1() ; Функция подключает
_SetCheck() ; Восстановление галочки "Oтoбpaжaть coдepжимoe oкнa пpи пepeтacкивaнии", пока мегафон выполняет подключение
_Connect2() ; Функция если требуется выполняет повторное подкл. с 9 попыток и заканчивается выходом из скрипта

Func _Connect1()
	$hMF_Inet = WinWait($title_MF_Inet, '', 5) ; ожидаем окно
	If Not $hMF_Inet Then _Exit()
	Sleep(100)
	If ControlGetText($hMF_Inet, '', '[CLASS:Button; INSTANCE:5]') = 'Подключить' Then ; Если текст кнопки = 
		ControlClick($hMF_Inet, '', '[CLASS:Button; INSTANCE:5]') ; кликаем её
		TrayTip('Подключение', 'Выполняется...', 3, 1)
	EndIf
EndFunc

Func _Connect2()
	; Ожидаем закрытия окна подключения
	Local $hConnect, $i, $title_Connect = 'Подсказка сетевого подключения'
	For $i = 1 To 9
		$hConnect = WinWait($title_Connect, '', 1)
		If $hConnect Then ; если существует окно подключения
			; Если текст кнопки =, то кликаем её
			If ControlGetText($hConnect, '', '[CLASS:Button; INSTANCE:1]') = 'Повторный набор' Then ControlClick($hConnect, '', '[CLASS:Button; INSTANCE:1]')
			If $i = 9 Then _Exit() ; выход, если это была 9-ая попытка
			TrayTip('Подключение', 'Попытка ' & $i & ' (не подключено)', 3, 1)
			Sleep(400)
		Else
			ExitLoop
		EndIf
	Next
	; Если кнопка изменилась на "Отключить", то сворачиваем окно
	For $i = 1 To 5
		If ControlGetText($title_MF_Inet, '', '[CLASS:Button; INSTANCE:5]') = 'Отключить' Then
			WinSetState($title_MF_Inet, '', @SW_MINIMIZE) ; Сворачиваем
			TrayTip('Подключение', 'Готово', 3, 1)
			_Exit()
		EndIf
		Sleep(400)
	Next
EndFunc

Func _Exit()
	TraySetIcon('')
	Exit
EndFunc

Func _SetCheck()
	Local $hEffects, $hEkran, $title_Effects, $title_Ekran
	$title_Ekran = "Свойства: Экран"
	$title_Effects = "Эффекты"
	Run('rundll32 shell32.dll,Control_RunDLL desk.cpl,,2') ; открываем окно "Свойства: Экран" на вкладке "Оформление"
	$hEkran = WinWait($title_Ekran, '', 5) ; Ожидаем появление окна 5 сек
	If $hEkran Then
		Sleep(100) ; задержки требуются для нарисования окон
		ControlClick($hEkran, '', '[CLASS:Button; INSTANCE:1]') ; кликаем кнопку "Эффекты..."
		$hEffects = WinWait($title_Effects, '', 2) ; Ожидаем появление окна "Эффекты" 2 сек
		If $hEffects Then ; Если дождались окно, то
			Sleep(100)
			; ControlClick($hEffects, '', '[CLASS:Button; INSTANCE:5]') ; кликаем галочку "Отображать содержимое окна при перетаскивании"
			ControlCommand($hEffects, "", '[CLASS:Button; INSTANCE:5]', "Check") ; устанавливаем галочку "Отображать содержимое окна при перетаскивании"
			ControlClick($hEffects, '', '[CLASS:Button; INSTANCE:7]') ; кликаем ОК в окне "Эффекты"
			ControlClick($hEkran, '', '[CLASS:Button; INSTANCE:3]') ; кликаем ОК в окне"Свойства: Экран"
		Else
			WinWaitClose($hEkran, '', 5) ; если не дождались окно, то закрываем окно "Свойства: Экран" 
		EndIf	
	EndIf
EndFunc

; проверка появления/существования подключаемых устройств мегафона
Func _DrivesTrue()
	Local $iDrivesExists = 0, $i, $DrivesArr
	$DrivesArr = DriveGetDrive('REMOVABLE') ; запрашиваем все переносные устройства
	If @error Then Return SetError(1, 0, 0) ; если не найдено
	For $i = 1 To $DrivesArr[0]
		If DriveStatus($DrivesArr[$i]) = 'NOTREADY' Then $iDrivesExists += 1
	Next
	If Not $iDrivesExists Then Return SetError(1, 0, 0) ; если не найден нечитаемое устройство
	$DrivesArr = DriveGetDrive('CDROM') ; запрашиваем все CDROM
	If @error Then Return SetError(1, 0, 0) ; если не найдено
	For $i = 1 To $DrivesArr[0]
		; Если читаемый CD и на нём найден файл "MegaFon Internet", то возвратить 1
		If DriveStatus($DrivesArr[$i]) = 'READY' And FileExists($DrivesArr[$i] & '\MegaFon Internet') Then Return SetError(0, 0, 1)
	Next
EndFunc