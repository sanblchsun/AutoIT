Exit

; если скрипт не скомпилирован, то иконку назначаем. Строка вставляется после функции GUICreate
If Not @compiled Then GUISetIcon(@ScriptDir&'\icon.ico', 0)

; Не показывать иконку в трее
#NoTrayIcon