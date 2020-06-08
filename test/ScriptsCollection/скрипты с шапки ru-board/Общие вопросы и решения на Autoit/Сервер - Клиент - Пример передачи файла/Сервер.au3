Global $iSocket = 33890
Global $hSocket = -1

TCPStartup()
$MainSocket = TCPListen("127.0.0.1", $iSocket, 1)
If $MainSocket<0 Then Exit MsgBox(16, "TCP Error", "Unable to intialize socket.")

$tsCTR = DllStructCreate("char Path[256];uint64 Size") ; управляющая структура копирования файла
$izCTR = DllStructGetSize($tsCTR)                      ; размер структуры
$ipCTR = DllStructGetPtr ($tsCTR)                      ; указатель
$tbCTR = DllStructCreate("byte["& $izCTR &"]", $ipCTR) ; сериализованная структура (в бинарном виде)

While 1
    If $hSocket<0 Then
        $hSocket = TCPAccept($MainSocket)
        If $hSocket<0 Then ContinueLoop
        ; Получаем инфу о файле - назначение и размер
        $bData = Binary("")
        Do
            $bData &= TCPRecv($hSocket, 1, 1)
            If @error Then
                TCPCloseSocket($hSocket)
                $hSocket=-1
                ConsoleWrite("Ошибка получения параметров файла! Операция отменена." &@CRLF)
                ContinueLoop 2
            EndIf
        Until BinaryLen($bData)=$izCTR
        ; Считываем параметры
        DllStructSetData($tbCTR, 1, $bData)
        $sFile = DllStructGetData($tsCTR, "Path")
        $iFile = DllStructGetData($tsCTR, "Size")
        ; Создание файла
        $hFile = FileOpen($sFile, 2+16)
        If $hFile<0 Then
            TCPCloseSocket($hSocket)
            $hSocket=-1
            ConsoleWrite("Ошибка создания файла! Операция отменена." &@CRLF)
            ContinueLoop
        EndIf
        ; Процесс копирования данных
        $bData = Binary("")
        $zData = 0
        While $zData<$iFile
            $bData = TCPRecv($hSocket, 65536, 1)
            If @error Then
                TCPCloseSocket($hSocket)
                FileClose($hFile)
                ConsoleWrite("Соединение прервано! Операция отменена." &@CRLF)
                ContinueLoop 2
            EndIf
            $zData += BinaryLen($bData)
            If FileWrite($hFile, $bData)=0 Or $zData>$iFile Then
                TCPCloseSocket($hSocket)
                FileClose($hFile)
                ConsoleWrite("Неустранимая ошибка при копировании! Операция отменена." &@CRLF)
                ContinueLoop 2
            EndIf
        WEnd

        FileClose($hFile)
        ConsoleWrite("Файл успешно скопирован! ("& $sFile &")" &@CRLF)
    EndIf
WEnd