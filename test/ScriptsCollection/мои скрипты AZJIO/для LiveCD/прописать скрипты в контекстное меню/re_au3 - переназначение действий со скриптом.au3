$au3 = RegRead("HKCR\au3file\Shell\Open", "")

; Старт
If $au3 = 'Открыть в редакторе' Then
RegWrite("HKCR\au3file\Shell\Open","","REG_SZ",'Выполнить скрипт')
RegWrite("HKCR\au3file\Shell\Open\Command","","REG_SZ",'"AutoIt3.exe" "%1" %*')
RegWrite("HKCR\au3file\Shell\Run","","REG_SZ",'Открыть в редакторе')
RegWrite("HKCR\au3file\Shell\Run\Command","","REG_SZ",'"X:\PROGRAMS\Notepad++\Notepad++.exe" "%1"')
RegWrite("HKCR\au3file\Shell\rx_re","","REG_SZ",'Переназначить au3 на Открытие')
RegWrite("HKCR\au3file\Shell\rx_re\Command","","REG_SZ",'"AutoIt3.exe" "X:\PROGRAMS\Update_Utilite\re_au3.au3" %*')
EndIf

; Открыть
If $au3 = 'Выполнить скрипт' Then
RegWrite("HKCR\au3file\Shell\Open","","REG_SZ",'Открыть в редакторе')
RegWrite("HKCR\au3file\Shell\Open\Command","","REG_SZ",'"X:\PROGRAMS\Notepad++\Notepad++.exe" "%1"')
RegWrite("HKCR\au3file\Shell\Run","","REG_SZ",'Выполнить скрипт')
RegWrite("HKCR\au3file\Shell\Run\Command","","REG_SZ",'"AutoIt3.exe" "%1" %*')
RegWrite("HKCR\au3file\Shell\rx_re","","REG_SZ",'Переназначить au3 на Выполнение')
RegWrite("HKCR\au3file\Shell\rx_re\Command","","REG_SZ",'"AutoIt3.exe" "X:\PROGRAMS\Update_Utilite\re_au3.au3" %*')
EndIf