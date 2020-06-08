
#include <Display_library_functions.au3>

; #include <Array.au3>
; $Array=_MonitorAndDesktopInfo()
; _ArrayDisplay($Array, 'Array')


_SaveDesktopIcons()
MsgBox(0, 'Сообщение', 'Теперь переместите ярлык. Выполнение следующей функции восстановить позицию ярлыка')
_RestoreDesktopIcons()