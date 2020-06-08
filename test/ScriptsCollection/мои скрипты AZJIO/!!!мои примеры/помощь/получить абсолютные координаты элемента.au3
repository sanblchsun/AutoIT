; ѕервый вариант
Run('calc.exe') ; «апуск калькул€тора
$hWnd = WinWait('[CLASS:SciCalc]', '', 5) ; ожидаем по€вление окна
If $hWnd Then ; если дескриптор пулечен, то
	WinMove($hWnd, '', 100, 100)
	$wgp = WinGetPos($hWnd) ; получаем координаты окна
	$wgcs = WinGetClientSize($hWnd) ; получаем размер клиенской области
	$d1 = ($wgp[2] - $wgcs[0]) / 2 ; получаем поправку толщины границы окна справа
	$d2 = $wgp[3] - $wgcs[1] - $d1 ; получаем поправку толщины заголовка окна
	$cgp = ControlGetPos($hWnd, '', '[CLASS:Button; INSTANCE:14]') ; получаем координаты элемента в клиенской области (кнопка 6)
	$X = $wgp[0] + $d1 + $cgp[0] ; собственно координаты определ€ютс€ сложением
	$Y = $wgp[1] + $d2 + $cgp[1]
	MsgBox(0, '»деально', _
	$wgp[0] & '+' & $d1 & '+' & $cgp[0] & '=' & $X & @CRLF & _
	$wgp[1] & '+' & $d2 & '+' & $cgp[1] & '=' & $Y)
	; MsgBox(0, 'Message', 'x= ' & $X & @CRLF & 'y= ' & $Y)
	WinClose($hWnd)
EndIf

; ¬торой вариант - проблема с окнами имеющими главное меню, высоту которого нужно добавить
#include <WinAPI.au3>
; определение ширины и высоты границ окна
$w = _WinAPI_GetSystemMetrics(32) ; ширина вертикальной границы
$h = _WinAPI_GetSystemMetrics(4) + _WinAPI_GetSystemMetrics(33) ; заголовок + высота горизонтальной границы
Run('calc.exe') ; «апуск калькул€тора
$hWnd = WinWait('[CLASS:SciCalc]', '', 5) ; ожидаем по€вление окна
If $hWnd Then ; если дескриптор получен, то
	WinMove($hWnd, '', 100, 100)
	$wgp = WinGetPos($hWnd) ; получаем координаты окна
	$cgp = ControlGetPos($hWnd, '', '[CLASS:Button; INSTANCE:14]') ; получаем координаты элемента в клиенской области (кнопка 6)
	$X = $wgp[0] + $w + $cgp[0] ; собственно координаты определ€ютс€ сложением
	$Y = $wgp[1] + $h + $cgp[1]
	MsgBox(0, '«десь проблема высоты меню', _
	$wgp[0] & '+' & $w & '+' & $cgp[0] & '=' & $X & @CRLF & _
	$wgp[1] & '+' & $h & '+' & $cgp[1] & '=' & $Y)
	; MsgBox(0, 'Message', 'x= ' & $X & @CRLF & 'y= ' & $Y)
	WinClose($hWnd)
EndIf