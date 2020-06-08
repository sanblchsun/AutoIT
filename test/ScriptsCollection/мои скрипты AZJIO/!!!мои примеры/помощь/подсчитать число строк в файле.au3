
; вариант позволяет определить количество строк не только в файле, но и в переменной, содержащей текст.
MsgBox(0, '', UBound(StringRegExp(FileRead(@ScriptDir&'\file.txt'), '(\r\n|\r|\n)', 3))+1)

; #include <file.au3>
; MsgBox(64, "", _FileCountLines("file.txt"))

; http://autoit-script.ru/index.php/topic,6931.msg47988.html#msg47988