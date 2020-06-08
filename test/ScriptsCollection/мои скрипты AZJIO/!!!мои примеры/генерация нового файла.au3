
MsgBox(0, "Сообщение", 'только для чтения внутри скрипта')
Exit; только для чтения
; генерируем имя нового файла с номером копии на случай если файл существует

; новый вариант, в котором используется рандом, здесь имя не несёт смысла, главное отсутствие копии файла.
Local $name, $i = 0
Do
    $i+=1
	$name=@TempDir&'\d8r0m4d'&$i&'z'&Random(1,1000,1)&'.au3'
Until Not FileExists($name)

;вариант1
; генерируем имя нового файла с номером копии на случай если файл существует
; у этого примера установлено ограничение 200, значит если существует двести файлов, то скрипт не назначит имена файлам.
For $i=1 To 200
	If Not FileExists($aRegfileS1[1]&'_BAK'&$i&'.reg') and Not FileExists($aRegfileS1[1]&'_DEL'&$i&'.reg') Then
		$filename=$aRegfileS1[1]&'_BAK'&$i&'.reg'
		$delname=$aRegfileS1[1]&'_DEL'&$i&'.reg'
		ExitLoop
	EndIf
Next

;вариант2
; если условие после Until совпадает, то выход из цикла Do-Until
$i = 0
Do
    $i+=1
Until Not FileExists($aRegfileS1[1]&'_BAK'&$i&'.reg') and Not FileExists($aRegfileS1[1]&'_DEL'&$i&'.reg')
$filename=$aRegfileS1[1]&'_BAK'&$i&'.reg'
$delname=$aRegfileS1[1]&'_DEL'&$i&'.reg'

;вариант3
; смысл строки While: если условие верно, то выполнить цикл, иначе не выполнять.
$i = 0
While FileExists($aRegfileS1[1]&'_BAK'&$i&'.reg') or FileExists($aRegfileS1[1]&'_DEL'&$i&'.reg')
    $i+=1
WEnd
$filename=$aRegfileS1[1]&'_BAK'&$i&'.reg'
$delname=$aRegfileS1[1]&'_DEL'&$i&'.reg'

