Global $hSocket = -1
Global $sServer = "127.0.0.1"
Global $iServer = 33890

Global $sFileFrom = "d:\MyGame.ISO"          ; файл-источник на клиенте (ЧТО)
Global $sFileTo   = "c:\InBox\YourGame.ISO"  ; файл-приемник на сервере (КУДА)

TCPStartup()
_TCP_FileSend($sServer, $iServer, $sFileFrom, $sFileTo)
TCPShutdown()

Func _TCP_FileSend($server, $port, $FileFrom, $FileTo)
    Local $hSocket = TCPConnect($server, $port)
    If $hSocket = -1 Then Return SetError(1, 0, False)

    Local $hFile = FileOpen($FileFrom, 16)
    Local $zFile = FileGetSize($FileFrom), $bData, $zData
    If $hFile<0 Then Return SetError(3, 1, False)

    Local $tsCTR = DllStructCreate("char Path[256];uint64 Size")
    Local $izCTR = DllStructGetSize($tsCTR)
    Local $ipCTR = DllStructGetPtr ($tsCTR)
    Local $tbCTR = DllStructCreate("byte["& $izCTR &"]", $ipCTR)

    DllStructSetData($tsCTR, "Path", $sFileTo)
    DllStructSetData($tsCTR, "Size", $zFile)

    TCPSend($hSocket, DllStructGetData($tbCTR, 1))
    If @error Then Return SetError(2, 1, False)

    Local $iProgress = 0
    ProgressOn("Copy Progress", "Increments every 65536 bytes", "0 percent")

    While 1
        $bData = FileRead($hFile, 65536)
        If @error<0 Then ExitLoop
        If @error>0 Then Return SetError(3, 2, False)

        $zData += BinaryLen($bData)
        TCPSend($hSocket, $bData)
        If @error Then Return SetError(2, 2, False)

        $iProgress = $zData/$zFile*100
        ProgressSet($iProgress, StringFormat("Copied %-2i\% percent...", $iProgress))
    WEnd

    ProgressOff()
    FileClose($hFile)
    TCPCloseSocket($hSocket)
    Return True
EndFunc