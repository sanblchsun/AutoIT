; Пример ExtMsgBox

#include <GUIConstantsEx.au3>
#include <Constants.au3>
#include <StaticConstants.au3>

#include "ExtMsgBox.au3"

; Устанавливает флаг повтора Test 5
$fTest5_Again = True

$hTest_GUI = GUICreate("EMB Тест", 200, 490, 100, 100)
$hButton1 = GUICtrlCreateButton("Тест 1", 20, 20, 60, 30)
$hButton2 = GUICtrlCreateButton("Тест 2", 120, 20, 60, 30)
$hButton3 = GUICtrlCreateButton("Тест 3", 20, 70, 60, 30)
$hButton4 = GUICtrlCreateButton("Тест 4", 120, 70, 60, 30)
$hButton5 = GUICtrlCreateButton("Тест 5", 20, 120, 60, 30)
$hButton6 = GUICtrlCreateButton("Тест 6", 120, 120, 60, 30)
$hButton7 = GUICtrlCreateButton("Exit", 70, 450, 60, 30)

$sMsg = "Перемещайте это окно по экрану, чтобы увидеть как центрируются дочерние окна вызываемые тестовыми кнопками." & @CRLF & @CRLF
$sMsg &= "Если вы поместите это окно слишком близко к краю экрана, то координаты дочерних окон будут скорректированы так, чтобы не быть скрытыми частично за край экрана."
If @Compiled = 0 Then $sMsg &= @CRLF & @CRLF & "Посмотрите в консоли SciTE, чтобы увидеть возвращаемые значения нажатых кнопок"

GUICtrlCreateLabel($sMsg, 10, 160, 180, 270, $SS_CENTER)
GUICtrlSetFont(-1, 10)
GUISetState(@SW_SHOW, $hTest_GUI)

While 1

	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $hButton7

			_ExtMsgBoxSet(1)
			$nTest = _ExtMsgBox(32, "Да|&Нет", "Подтверждение", "Вы уверены?", 0, $hTest_GUI)
			_ExtMsgBoxSet(Default)
			ConsoleWrite("The 'Exit' EMB returned: " & $nTest & @CRLF)
			If $nTest = 1 Then Exit

		Case $hButton1

			; Установка выравнивание по центру, размер шрифта, оставив цвет без изменений
			_ExtMsgBoxSet(2, $SS_CENTER, -1, -1, 9)

			$sMsg = "Это по центру родительского окна 'EMB Тест', с иконкой AutoIt, 4 кнопки, с выравниванием текста по центру, кнопка на панели задач и не установленый стиль 'поверх всех окон' (TOPMOST)" & @CRLF & @CRLF
			$sMsg &= "Ширина устанавливается максимально необходимая, чтобы вместить 4-х кнопки и текст будет переносится по строкам при необходимости чтобы уместиться" & @CRLF & @CRLF
			$sMsg &= "Кнопка 4 устанавливается по умолчанию и будет активирована при нажатии 'Enter' или 'Space' (пробел)" & @CRLF & @CRLF
			$sMsg &= "Время ожидания действия от пользователя не используется"
			$iRetValue = _ExtMsgBox(@AutoItExe, "1|2|3|&4", "Тест 1", $sMsg, 20, $hTest_GUI)
			ConsoleWrite("Тест 1 возвратил: " & $iRetValue & @CRLF)

			; Сброс по умолчанию
			_ExtMsgBoxSet(Default)

		Case $hButton2

			; Скрывает родительский GUI, чтобы показать диалоговое окно в центре экране
			GUISetState(@SW_HIDE, $hTest_GUI)

			; Изменяет шрифт и выравнивание, оставив цвет без изменений
			_ExtMsgBoxSet(1 + 4, $SS_LEFT, -1, -1, 12, "Arial")

			$sMsg = "Скрывает 'EMB Test', и появляется в центре экрана" & @CRLF & @CRLF
			$sMsg &= "Текущие установки:" & @CRLF
			$sMsg &= @TAB & "Иконка 'Информация'" & @CRLF
			$sMsg &= @TAB & "Одна смещённая кнопка" & @CRLF
			$sMsg &= @TAB & "Выравнивание по левому краю" & @CRLF
			$sMsg &= @TAB & "Default button text" & @CRLF
			$sMsg &= @TAB & "Отсутствует на панели задач" & @CRLF
			$sMsg &= @TAB & "Стиль 'поверх всех окон'" & @CRLF & @CRLF
			$sMsg &= "Ширина устанавливается по длине максимальной строки" & @CRLF & @CRLF
			$sMsg &= "(которая меньше чем максимальная ширина окна сообщения)" & @CRLF & @CRLF
			$sMsg &= "Время ожидания действия от пользователя 20 сек"

			; Использование констант $MB_... и установка таймаута
			$iRetValue = _ExtMsgBox($EMB_ICONINFO, "Шрифт умолч.", "Тест 2", $sMsg, 20, $hTest_GUI)
			ConsoleWrite("Тест 2 возвратил: " & $iRetValue & @CRLF)

			; Сброс по умолчанию
			_ExtMsgBoxSet(Default)

			; Показывает родительский GUI снова
			GUISetState(@SW_SHOW, $hTest_GUI)
			WinSetOnTop($hTest_GUI, "", 1)
			WinSetOnTop($hTest_GUI, "", 0)

		Case $hButton3

			; Устанавливает выравнивание по правому краю, цвет (жёлтый текст на иснеем фоне) и изменяет шрифт
			_ExtMsgBoxSet(1, 2, 0x004080, 0xFFFF00, 10, "Comic Sans MS")

			$sMsg = "Это диалоговое окно по центру родительского окна 'EMB Тест', с иконкой восклицательного знака, 2 кнопки, перенос строк, выравнивание цветного текста по правому краю, "
			$sMsg &= "на цветном фоне, отсутствует на панели задач, и установлен стиль 'поверх всех окон' (TOPMOST)" & @CRLF & @CRLF
			$sMsg &= "Обратите внимание, вы можете получить && в тексте кнопки" & @CRLF & @CRLF
			$sMsg &= "Время ожидания действия от пользователя не используется"

			; Использование констант $MB_...
			$iRetValue = _ExtMsgBox($EMB_ICONEXCLAM, "1 способ|&Да && Нет", "Тест 3", $sMsg, 0, $hTest_GUI)
			ConsoleWrite("Тест 3 возвратил: " & $iRetValue & @CRLF)

			; Сброс по умолчанию
			_ExtMsgBoxSet(Default)

		Case $hButton4

			; Единственная кнопка в центре
			_ExtMsgBoxSet(1, 4, -1, -1, 11)

			$sMsg = "Дескриптор родительского окна не передан, поэтому диалог по центру экрана" & @CRLF & @CRLF
			$sMsg &= "Иконка 'Стоп', одна кнопка по центру, текст выравнивается по левому краю, большой шрифт (?), отсутствует на панели задач, установлен стиль 'поверх всех окон' (TOPMOST)" & @CRLF & @CRLF
			$sMsg &= "Здесь несколько очень длинных строк, поэтому ширина окна сообщения установлена в максимальное по умолчанию и текст принудительно переносится на новую строку, так как строки слишком длинные, чтобы уместится" & @CRLF & @CRLF
			$sMsg &= "Время ожидания действия от пользователя 15 сек" & @CRLF & @CRLF & @CRLF & @CRLF & @CRLF & @CRLF & @CRLF & @CRLF
			$sMsg &= "Обратите внимание, что диалоговое окно автоматически подстраивается, чтобы отобразить необходимые строки, даже если они перенесены несколько раз!"

			$iRetValue = _ExtMsgBox($EMB_ICONSTOP, "OK", "Тест 4", $sMsg, 15)
			ConsoleWrite("Тест 4 возвратил: " & $iRetValue & @CRLF)

			; Сброс по умолчанию
			_ExtMsgBoxSet(Default)

		Case $hButton5

			; Запуск только если установлен флаг
			If $fTest5_Again Then

				; Устанавливает шрифт кнопки по умолчанию, "Not again" checkbox, no titlebar icon
				_ExtMsgBoxSet(4 + 16 + 32, 0, Default, Default, 14, "Consolas")

				$sMsg = "Здесь переданы координаты окна, а не дескриптор, "
				$sMsg &= "поэтому окно находится в координатах 200, 200." & @CRLF & @CRLF
				$sMsg &= "Иконка 'Вопрос', кнопка на панели задач, установлен стиль 'поверх всех окон' (TOPMOST) и используется шрифт по умолчанию" & @CRLF & @CRLF
				$sMsg &= "Время ожидания действия от пользователя не используется"

				$iRetValue = _ExtMsgBox($EMB_ICONQUERY, $MB_OK, "Тест 5", $sMsg, 0, 200, 200)
				ConsoleWrite("Тест 5 возвратил: " & $iRetValue & @CRLF)

				; Очищает флаг как чекбокс был кликнут
				If $iRetValue < 0 Then $fTest5_Again = False

				; Сброс по умолчанию
				_ExtMsgBoxSet(Default)

			Else

				ConsoleWrite("Test 5 will not run again" & @CRLF)

			EndIf

		Case $hButton6

			; Устанавливает выравнивание по правому краю, цвет (оранжевый текст на зелёном фоне) и изменяет шрифт
			; _ExtMsgBoxSet(3, 0, 0x008000, 0xFF8000, 12, "MS Sans Serif") ; оригинал
			; _ExtMsgBoxSet(3, 0, 0xf1f1ef, 0x3a6a7e, 12, "MS Sans Serif") ; блеклый
			; _ExtMsgBoxSet(3, 0, 0xfdf3ac, 0xa13d00, 12, "MS Sans Serif")
			_ExtMsgBoxSet(1 + 2 + 64, 0, 0x005a39, 0xffbf1e, 12, "MS Sans Serif")

			$sMsg = "Здесь переданы координаты окна, а не дескриптор, "
			$sMsg &= "поэтому окно находится в координатах 100, 500." & @CRLF & @CRLF
			$sMsg &= "Не имеет иконки, отсутствует на панели задач, не установлен стиль 'поверх всех окон' (TOPMOST), цветной текст и фон "
			$sMsg &= "Время ожидания действия от пользователя 20 сек"

			$iRetValue = _ExtMsgBox(128, " ", "Тест 6", $sMsg, 20, 100, 500)
			ConsoleWrite(@error & @CRLF)
			ConsoleWrite("Тест 6 возвратил: " & $iRetValue & @CRLF)

			; Сброс по умолчанию
			_ExtMsgBoxSet(Default)

	EndSwitch

WEnd