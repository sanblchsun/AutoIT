#include <GUIConstants.au3>

GUICreate("My GUI Progressbar",250,200, 100,200) ; создаЄм окно с кнопками
$progress1 = GUICtrlCreateProgress (10,10,180,20) ; горизонтальный прогрессбар
$progress2 = GUICtrlCreateProgress (10,40,180,20, 0x00000008) ; бегунок
$progress3 = GUICtrlCreateProgress (220,10,20,150, 4) ; вертикальный
$Start = GUICtrlCreateButton ("—тарт",10,70,90,30)
$Stop= GUICtrlCreateButton ("—топ",110,70,90,30)
$Slider = GUICtrlCreateSlider(20, 110, 120, 30) ; регул€тор
GUICtrlSetData($Slider,80)
$Lab = GUICtrlCreateLabel("80", 150, 117, 25, 18)
GUISetState () ; отобразить окно после создани€ элементов (кнопок, чекбоксов и т.д.)

While 1
	$msg = GUIGetMsg() ; в цикле (While 1...WEnd) происходит опрос взаимодействи€ с GUI (нажати€ кнопок и других действий) 1000 раз в секунду
	Select ; ¬ыбор. ≈сли получен вызов от кнопки с переменной $Start, то выролнить последовательность кода до следующего Case
		Case $msg = $Start
			$i = 0
; пример цикла с использованием Do...Until
			Do
				$i += 1
				$t=100-GUICtrlRead($slider)
        		GUICtrlSetData ($Lab,100-$t)
        		GUICtrlSetData ($progress1,$i*4)
        		GUICtrlSetData ($progress2,$i) ;замедление
        		GUICtrlSetData ($progress3,$i*4)
        		Sleep($t+10)
        		If $i = 25 Then $i = 0
    		Until GUIGetMsg() = $Stop or GUIGetMsg() = $GUI_EVENT_CLOSE
#cs
; пример этого же цикла с использованием For...Next
			For $i = 0 To 25 Step 1
				$t=100-GUICtrlRead($slider)
        		GUICtrlSetData ($Lab,100-$t)
        		If GUIGetMsg() = $GUI_EVENT_CLOSE Then Exit
        		If GUIGetMsg() = $Stop Then ExitLoop
        		GUICtrlSetData ($progress1,$i*4)
        		GUICtrlSetData ($progress2,$i) ;замедление
        		GUICtrlSetData ($progress3,$i*4)
        		Sleep($t+10)
        		If $i = 25 Then $i = 0
    		Next
			
; пример этого же цикла с использованием While...WEnd
			While not GUIGetMsg() = $Stop or not GUIGetMsg() = $GUI_EVENT_CLOSE ; если не нажата кнопка $Stop или "«акрыть", то повторить выполнени€ цикла.
				$i += 1
				$t=100-GUICtrlRead($slider)
        		GUICtrlSetData ($Lab,100-$t)
        		GUICtrlSetData ($progress1,$i*4)
        		GUICtrlSetData ($progress2,$i) ;замедление
        		GUICtrlSetData ($progress3,$i*4)
        		Sleep($t+10)
        		If $i = 25 Then $i = 0
    		WEnd
#ce
		Case $msg = $GUI_EVENT_CLOSE
			ExitLoop
	EndSelect
WEnd
