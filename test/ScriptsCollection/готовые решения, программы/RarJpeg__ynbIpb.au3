; ---------------------------------------------------
; AutoIt Version: 3.3.0.0
; Author: ynbIpb
; Script name: RarJpeg v.0.1
; Script Function: Программа для создания Рарджипегов
; Что такое РарДжипег: http://lurkmore.ru/Rarjpeg
; ----------------------------------------------------
#NoTrayIcon
#include <GUIConstants.au3>
#include <EditConstants.au3> ; для стиля $ES_READONLY элемента Input
#include <StaticConstants.au3>; для стиля $SS_CENTER элемента Label
; объявляем переменные
$JpgFile = ""
$RarFile = ""
; рисуем ГУИ
$Form1 = GUICreate("RarJpeg", 152, 100)
; Input со стилем: только для чтения, выровнять по левому краю, автопрокрутка
$Input1 = GUICtrlCreateInput("", 4, 4, 121, 21, BitOR($ES_READONLY, $ES_LEFT, $ES_AUTOHSCROLL))
$Input2 = GUICtrlCreateInput("", 4, 30, 121, 21, BitOR($ES_READONLY, $ES_LEFT, $ES_AUTOHSCROLL))
$Button1 = GUICtrlCreateButton("...", 128, 4, 21, 21, 0)
$Button2 = GUICtrlCreateButton("...", 128, 30, 21, 21, 0)
$Button3 = GUICtrlCreateButton("Соединить Файлы", 4, 55, 145, 21, 0)
; Label со стилем: выровнять по центру
$Label1 = GUICtrlCreateLabel("Выберите файлы...", 4, 80, 144, 15, $SS_CENTER)
$Progress1 = GUICtrlCreateProgress(4, 80, 144, 15)
GUICtrlSetState($Progress1, $GUI_HIDE); Progress пока скрываем.
GUISetState(@SW_SHOW)

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $Button1
            $JpgFile = FileOpenDialog("Выберите jpg файл..", @ScriptDir, "Images (*.jpg;*.jpeg)", 1)
            ; отделяем от пути имя файла
            $JpgName = StringMid($JpgFile, StringInStr($JpgFile, "\", 0, -1) + 1)
            ; и заносим его в Input
            GUICtrlSetData($Input1, $JpgName)
        Case $Button2
            $RarFile = FileOpenDialog("Выберите rar файл..", @ScriptDir, "Arhives (*.rar)", 1)
            $RarName = StringMid($RarFile, StringInStr($RarFile, "\", 0, -1) + 1)
            GUICtrlSetData($Input2, $RarName)
        Case $Button3
            joinfiles() ; пытаемся начать соединение файлов
    EndSwitch
WEnd

; дабы не захламлять основной цикл кодом, весь процесс склеивания вынесен в функцию
Func joinfiles()
    If $JpgFile = "" Then ; если не выбран 1 файл: выводим ошибку и возвращаемcя из функции
        GUICtrlSetData($Label1, "Ошибка: Нет *.jpg файла!")
        Return
    EndIf
    If $RarFile = "" Then ; если не выбран 2 файл: выводим ошибку и возвращаемcя из функции
        GUICtrlSetData($Label1, "Ошибка: Нет *.rar файла!")
        Return
    EndIf
    GUICtrlSetState($Label1, $GUI_HIDE); теперь скрываем Label, чтоб не мешал Progress'у
    GUICtrlSetState($Progress1, $GUI_SHOW); отображаем Progress
    ; jpg файл копируем сразу, так как он мал и должен быть вначале
    FileCopy($JpgFile, @ScriptDir & "\Rarjpeg_" & $RarName & ".jpg")
    $orig_files_size = FileGetSize($JpgFile)
    $orig_files_size += FileGetSize($RarFile); считаем суммарный размер исходных файлов
    $file2 = FileOpen($RarFile, 16); открываем rar в бинарном режиме для чтения
    ; выходной файл открываем в бинарном режиме на запись только в конец файла
    $file3 = FileOpen(@ScriptDir & "\Rarjpeg_" & $RarName & ".jpg", 17)
    While 1 ; цикл чтения\записи большого файла по кускам
        $Buf = FileRead($file2, 1024 * 1024) ; по 1 Mb в буфер
        If @error = -1 Then ExitLoop
        FileWrite($file3, $Buf)
        ; проверяем размер выходного файла и высчитываем процент для Progress'а
        $new_file_size = FileGetSize(@ScriptDir & "\Rarjpeg_" & $RarName & ".jpg")
        $Percent = $new_file_size * 100 / $orig_files_size
        $Percent = Ceiling($Percent)
        GUICtrlSetData($Progress1, $Percent)
    WEnd
    FileClose($file2)
    FileClose($file3)
    GUICtrlSetState($Progress1, $GUI_HIDE)
    GUICtrlSetData($Label1, "Готово!")
    GUICtrlSetState($Label1, $GUI_SHOW)
EndFunc
 