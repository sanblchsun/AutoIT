;  @AZJIO
#NoTrayIcon

; начало создания окна, вкладок, кнопок.
GUICreate("Смена глобальных переменных",368,187) ; размер окна
$tab=GUICtrlCreateTab (0,2, 368,185) ; размер вкладки
GUICtrlCreateTabitem ("Environment") ; имя вкладки

$start1=GUICtrlCreateButton ("V", 8,31,25,25)
GUICtrlSetTip(-1, "Без ограничений, так как папка"&@CRLF&"Temp на жёстком диске.")
GUICtrlCreateLabel ("Temp=", 37,35,40,18)
GUICtrlSetTip(-1, "Без ограничений, так как папка"&@CRLF&"Temp на жёстком диске.")
$combo_env1=GUICtrlCreateCombo ("", 80,33,90,18)
GUICtrlSetData(-1,'C:\Temp|D:\Temp|E:\Temp|B:\Temp|B:', 'D:\Temp')
GUICtrlCreateLabel (" - TEMP без ограничений по объёму", 170,35,190,22)
GUICtrlSetTip(-1, "Без ограничений, так как папка"&@CRLF&"Temp на жёстком диске.")

$start2=GUICtrlCreateButton ("V", 8,61,25,25)
GUICtrlCreateLabel ("programfiles=", 37,65,70,22)
$combo_env2=GUICtrlCreateCombo ("", 110,63,110,18)
GUICtrlSetData(-1,'C:\PROGRAMS|D:\PROGRAMS|E:\PROGRAMS|B:\PROGRAMS|X:\PROGRAMS', 'C:\PROGRAMS')

$start3=GUICtrlCreateButton ("V", 8,91,25,25)
GUICtrlSetTip(-1, "Принудительно указать переменную"&@CRLF&"для использования программ"&@CRLF&"на указанном диске")
GUICtrlCreateLabel ("sys=", 37,95,30,18)
GUICtrlSetTip(-1, "Принудительно указать переменную"&@CRLF&"для использования программ"&@CRLF&"на указанном диске")
$combo_env3=GUICtrlCreateCombo ("", 80,93,160,18)
GUICtrlSetData(-1,'C:\SYS|D:\SYS|W:\Portable_soft_LiveDVD|X:\Portable_soft_LiveDVD', 'C:\SYS')


$start4=GUICtrlCreateButton ("V", 8,121,25,25)
GUICtrlSetTip(-1, "Переназначение затрагивает"&@CRLF&"ярлыки, записи реестра")
GUICtrlCreateLabel ("Ассоциировать программы на диск C: + SYS", 37,125,320,18)
GUICtrlSetTip(-1, "Переназначение затрагивает"&@CRLF&"ярлыки, записи реестра")

$start5=GUICtrlCreateButton ("V", 8,151,25,25)
GUICtrlSetTip(-1, "Ассоциировать программы PROGRAMS"&@CRLF&"на указанный диск.")
GUICtrlCreateLabel ("Ассоциировать программы на диск", 37,155,190,18)
GUICtrlSetTip(-1, "Ассоциировать программы PROGRAMS"&@CRLF&"на указанный диск.")
$combo_env5=GUICtrlCreateCombo ("", 230,151,45,18)
GUICtrlSetData(-1,'C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z', 'C')

GUICtrlCreateTabitem ("")   ; конец вкладок

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
            Case $msg = $start1
			   $combo_env01=GUICtrlRead ($combo_env1)
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\setenv.exe -m Temp '&$combo_env01, '', @SW_HIDE )
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\setenv.exe -m Tmp '&$combo_env01, '', @SW_HIDE )
            Case $msg = $start2
			   $combo_env02=GUICtrlRead ($combo_env2)
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\setenv.exe -m programs '&$combo_env02, '', @SW_HIDE )
            Case $msg = $start3
			   $combo_env03=GUICtrlRead ($combo_env3)
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\setenv.exe -m sys '&$combo_env03, '', @SW_HIDE )
            Case $msg = $start4
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\setenv.exe -m disksht C:', '', @SW_HIDE )
			   RunWait ( @Comspec & ' /C '&@WindowsDir&'\system32\regedit.exe /s '&@ScriptDir&'\c_sys.reg', '', @SW_HIDE )
			   RunWait ( @Comspec & ' /C '&@WindowsDir&'\system32\reico.exe -close', '', @SW_HIDE )
            Case $msg = $start5
			   $combo_env05=GUICtrlRead ($combo_env5)
			   RegWrite("HKLM\Software\Classes\psdfile\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\XnView\xnview.exe" "%1"')
			   RegWrite("HKLM\Software\Classes\dllfile\shell\Starti_ArtIcons\command","","REG_SZ",'"'&$combo_env05&':\Programs\ArtIcons Pro\ARTICONS.exe" "%1"')
			   RegWrite("HKLM\Software\Classes\exefile\shell\Starti_ArtIcons\command","","REG_SZ",'"'&$combo_env05&':\Programs\ArtIcons Pro\ARTICONS.exe" "%1"')
			   RegWrite("HKLM\Software\Classes\ghofile\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\Ghost32\Ghostexp.exe" "%1"')
			   RegWrite("HKLM\Software\Classes\icofile\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\ArtIcons Pro\ARTICONS.exe" "%1"')
			   RegWrite("HKLM\Software\Classes\isofile\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\UltraISO\UltraISO.exe" "%1"')
			   RegWrite("HKLM\Software\Classes\WinImage\shell\Extract\command","","REG_SZ",'"'&$combo_env05&':\Programs\winimage\winimage.exe"" /e" "%1"')
			   RegWrite("HKLM\Software\Classes\ASCII Art Studio\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\ASCII Art Studio\AsciiArtStudio.exe" "%1"')
			   RegWrite("HKLM\Software\Classes\Unknown\shell\Open_with_WinHex\command","","REG_SZ",'"'&$combo_env05&':\Programs\WinHex\WinHex.exe" "%1"')
			   RegWrite("HKLM\Software\Classes\pdffile\DefaultIcon","","REG_SZ",'"'&$combo_env05&':\Programs\Foxit Reader\Foxit Reader.exe,5')
			   RegWrite("HKLM\Software\Classes\pdffile\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\Foxit Reader\Foxit Reader.exe" "%1"')
			   RegWrite("HKLM\Software\Classes\CLSID\{14E8BBD8-1D1C-4D56-A4DA-D20B75EB814E}\DefaultIcon","","REG_SZ",$combo_env05&':\Programs\Foxit Reader.exe,0')
			   RegWrite("HKLM\Software\Classes\CLSID\{14E8BBD8-1D1C-4D56-A4DA-D20B75EB814E}\LocalServer32","","REG_SZ",'"'&$combo_env05&':\Programs\Foxit Reader.exe" "%1"')
			   RegWrite("HKLM\Software\Classes\FoxitReader.Document\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\Foxit Reader.exe" "%1"')
			   RegWrite("HKLM\Software\Classes\FoxitReader.Document\DefaultIcon","","REG_SZ",'"'&$combo_env05&':\Programs\Foxit Reader.exe,0"')
			   RegWrite("HKLM\Software\Classes\pdffile\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\Foxit Reader.exe" "%1"')
			   RegDelete("HKLM\Software\Classes\Excel.Sheet.8\shell\open\command")
			   RegDelete("HKLM\Software\Classes\Word.Document.8\shell\open\command")
			   RegWrite("HKLM\Software\Classes\Excel.Sheet.8\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\Office2k\Office\EXCEL.EXE" "%1"')
			   RegWrite("HKLM\Software\Classes\Word.Document.8\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\Office2k\Office\WINWORD.EXE" "%1"')
			   RegWrite("HKCR\Applications\xnview.exe\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\XnView\xnview.exe" "%1"')
			   RegWrite("HKCR\Applications\AsciiArtStudio.exe\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\ASCII Art Studio\AsciiArtStudio.exe" "%1"')
			   RegWrite("HKCR\Applications\notepad++.exe\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\Notepad++\notepad++.exe" "%1"')
			   RegWrite("HKCR\Applications\WINWORD.EXE\shell\open\command","","REG_SZ",'"'&$combo_env05&':\PROGRAMS\Office2k\Office\WINWORD.EXE" "%1"')
			   RegWrite("HKCR\Applications\EXCEL.EXE\shell\open\command","","REG_SZ",'"'&$combo_env05&':\PROGRAMS\Office2k\Office\EXCEL.EXE" "%1"')
			   RegWrite("HKCR\Applications\UltraISO.exe\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\UltraISO\UltraISO.exe" "%1"')
			   RegWrite("HKCR\Applications\Foxit Reader.exe\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\Foxit Reader\Foxit Reader.exe" "%1"')
			   RegWrite("HKCR\Applications\Ghostexp.exe\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\Ghost32\Ghostexp.exe" "%1"')
			   RegWrite("HKCR\Applications\ResHacker.exe\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\ResHacker\ResHacker.exe" "%1"')
			   RegWrite("HKCR\Applications\TCode.exe\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\TCode\TCode.exe" "%1"')
			   RegWrite("HKCR\Applications\WinHex.exe\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\WinHex\WinHex.exe" "%1"')
			   RegWrite("HKCR\Applications\WinImage.exe\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\WinImage\WinImage.exe" "%1"')
			   RegWrite("HKCR\Applications\WinRAR.exe\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\WinRAR\WinRAR.exe" "%1"')
			   RegWrite("HKCR\Applications\ArtIcons.exe\shell\open\command","","REG_SZ",'"'&$combo_env05&':\Programs\ArtIcons Pro\StartAI.bat" "%1"')
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\setenv.exe -m disksht '&$combo_env05&':', '', @SW_HIDE )
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\setenv.exe -m sys '&$combo_env05&':\Portable_soft_LiveDVD', '', @SW_HIDE )
			   RunWait ( @Comspec & ' /C '&@WindowsDir&'\system32\reico.exe -close', '', @SW_HIDE )
			Case $msg = -3
				ExitLoop
		EndSelect
	WEnd