;  @AZJIO
#Include <File.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3> 
#include <Array.au3>
; AutoItSetOption("TrayIconHide", 1) ;скрыть в системной панели индикатор AutoIt
Global $Stack[50]
Global $Stack1[50]

;создание оболочки
GUICreate("Добавляем драйвера в LiveCD v0.2",508,228, -1, -1, -1, $WS_EX_ACCEPTFILES) ; размер окна
$tab=GUICtrlCreateTab (0,2, 508,204) ; размер вкладки

GUICtrlCreateLabel ("используйте drag-and-drop", 250,5,200,18)

$tab3=GUICtrlCreateTabitem ("Update Drv") ; имя вкладки

GUICtrlCreateLabel ("Путь к I386 или MiniNT", 20,40,400,20)
$inputi386z=GUICtrlCreateInput ("", 20,60,420,22)
GUICtrlSetState(-1,8)
$filewim=GUICtrlCreateButton ("...", 455,59,35,24)
GUICtrlSetData($inputi386z, @ScriptDir&'\I386')

GUICtrlCreateLabel ("Путь к папке с драйверами", 20,100,400,20)
$inputdrv=GUICtrlCreateInput ("", 20,120,420,22)
GUICtrlSetState(-1,8)
$filezip=GUICtrlCreateButton ("...", 455,119,35,24)
GUICtrlSetData($inputdrv, @ScriptDir&'\drivers')

$check=GUICtrlCreateCheckbox ("Разрешить копировать *.exe (для SCSIRAID)", 20,160,240,20)
GUICtrlSetTip(-1, "Для драйверов звука, видео, сеть *.exe-файлы не нужны")
GuiCtrlSetState($check, 1)

$Upd=GUICtrlCreateButton ("Выполнить", 390,160,100,26)
GUICtrlSetTip(-1, "Добавить драйвера в LiveCD")
$Label000=GUICtrlCreateLabel ('Строка состояния			AZJIO 2009.12.30', 10,210,380,20)

$tab4=GUICtrlCreateTabitem ("?") ; имя вкладки

GUICtrlCreateGroup("Сортировка файлов по каталогам", 11, 30, 200, 90)
GUICtrlCreateLabel ("*.sys > i386\system32\drivers\", 20,50,200,20)
GUICtrlCreateLabel ("*.dll, *.exe > i386\system32\", 20,70,200,20)
GUICtrlCreateLabel ("*.inf > i386\inf\", 20,90,200,20)

GUICtrlCreateGroup("Изменение TXTSETUP.SIF", 222, 30, 275, 90)
GUICtrlCreateLabel ("Секции SetValue, добавляют данные в txtsetup.sif", 231,50,260,20)
GUICtrlCreateLabel ("Секции DelLine, удаляют данные в txtsetup.sif", 231,70,260,20)
GUICtrlCreateLabel ("Драйвер должен быть в виде плага BartPE", 231,90,260,20)

GUICtrlCreateLabel ("Драйвер звука, видео, сеть можно добавлять любой, для них не происходит запись в txtsetup.sif, осуществляется обычная сортировка по каталогам.", 20,130,400,40)




GUICtrlCreateTabitem ("")   ; конец вкладок

GUISetState ()

While 1
   $msg = GUIGetMsg()
   Select
	  Case $msg = $Upd
		 $inputi386=GUICtrlRead ($inputi386z)
		 $inputzip0=GUICtrlRead ($inputdrv)
				If Not FileExists($inputi386) Then
					MsgBox(0, "Мелкая ошибка", 'Не указан каталог i386')
					ContinueLoop
				EndIf
				If Not FileExists($inputzip0) Then
					MsgBox(0, "Мелкая ошибка", 'Не указан каталог драйверов')
					ContinueLoop
				EndIf
		 $size=FileGetSize($inputi386&'\TXTSETUP.SIF')
		 $size /=1024
		 $size=Ceiling ($size)
		 GUICtrlSetData($Label000, 'Выполняется обновление...   TXTSETUP.SIF='&$size&'кб')

; поиск файлов
	If FileExists($inputzip0) Then
	  FileFindNextFirst($inputzip0)
   $filereg = FileOpen(@ScriptDir&'\drvlist.txt', 2)
   $fileinf = FileOpen(@ScriptDir&'\drvlist.inf', 2)
   FileWrite($fileinf, '[PEBuilder]'&@CRLF)
   FileWrite($fileinf, '[DelLine]'&@CRLF)
	; проверка открытия файла для записи строки
	If $filereg = -1 Then
	  MsgBox(0, "Ошибка", "Не возможно открыть файл.")
	  Exit
   EndIf
	  While 1 
		 $tempname = FileFindNext()
		 If $tempname = "" Then ExitLoop
		 ; отсеивание файлов *.sys, копирование в каталог drivers
		 $aPathwim = StringRegExp($tempname, "(^.*)\\(.*)$", 3)
		 If StringRight( $tempname, 3 )  = "sys" Then
			FileCopy($tempname, $inputi386&'\system32\drivers\', 9)
			FileWrite($filereg, 'i386\system32\drivers\'&$aPathwim[1]&@CRLF)
		 EndIf
		 ; отсеивание файлов *.dll, копирование в каталог system32
		 If StringRight( $tempname, 3 )  = "dll" Then
			FileCopy($tempname, $inputi386&'\system32\', 9)
			FileWrite($filereg, 'i386\system32\'&$aPathwim[1]&@CRLF)
		 EndIf
		 ; отсеивание файлов *.exe, копирование в каталог system32
		 If GUICtrlRead ($check)=1 And StringRight( $tempname, 3 )  = "exe" Then
			FileCopy($tempname, $inputi386&'\system32\', 9)
			FileWrite($filereg, 'i386\system32\'&$aPathwim[1]&@CRLF)
		 EndIf
		 
		 ; отсеивание файлов *.inf, копирование в каталог inf или если *.inf является плагом PEBuilder, то обработка текста
		 If StringRight( $tempname, 3 )  = "inf" Then
			$search1 = FileOpen($tempname, 0) ; Открывается и читаем файл
			$search2 = FileRead($search1)
			; Проверка вхождений PEBuilder
			If StringRegExp($search2, "\[PEBuilder\]", 0)<>0 Then
			   $aSetValue = StringRegExp($search2, '(?s)\[SetValue\]([^\[]*)', 3) ; регулярное выражение для вытаскивания секций SetValue в массив
			   _ArrayToClip( $aSetValue, 0 ) ; обьединение массива путем отправки в буфер обмена с разделителем перехода на новую строку
			   $aRecords = StringSplit(ClipGet(), @CRLF) ; теперь буфер обмена отправляется в массив разделяясь на элеменнты массива построчно
			   ;MsgBox(0, "Ошибка", $days[0])
			   
			   For $i=1 To $aRecords[0] ; читаем строки массива для записи их в файл txtsetup.sif
			   If StringLeft($aRecords[$i], 14)='"txtsetup.sif"' Then ; проверка вхождения "txtsetup.sif" в строке
				  ; при успешной предоперации делим строку на элементы (секция, параметр, значение)
				  $aSif = StringRegExp($aRecords[$i], '"(.*)", ?"(.*)", ?"(.*)", ?"(.*)"', 3)
				  If @Error=1 Then ExitLoop
				  ;MsgBox(0, "Ошибка", '1 '&$aSif[1]&@CRLF&'2 '&$aSif[2]&@CRLF&'3 '&$aSif[3])
				  ; Интерпретируем двойные кавычки как одинарные
				  ;StringRegExpReplace($aSif3, '""', '"')
				  $aSif3 = StringReplace($aSif[3], '""', '"')

				  ;MsgBox(0, "Ошибка", '11 '&$aSif1&@CRLF&'22 '&$aSif2&@CRLF&'33 '&$aSif3)
				  ; запись параметров в txtsetup.sif по принципу ini-файла
				  IniWrite($inputi386&'\txtsetup.sif', $aSif[1], $aSif[2], $aSif3)
				  FileWrite($fileinf, '"'&$aSif[0]&'","'&$aSif[1]&'","'&$aSif[2]&'"'&@CRLF) ; создание строк на удаление, для выполнения обратной операции
			   EndIf
			   Next
;=================================================================
			   ; обработка секций на удаление строк
			   
			   If StringRegExp($search2, "\[DelLine\]", 0)<>0 Then
			   $aSetValue1 = StringRegExp($search2, '(?s)\[DelLine\]([^\[]*)', 3)
			   _ArrayToClip( $aSetValue1, 0 )
			   $aRecords = StringSplit(ClipGet(), @CRLF)
			   For $i=1 To $aRecords[0]
				  If StringLeft($aRecords[$i], 14)='"txtsetup.sif"' Then
					 $aSif = StringRegExp($aRecords[$i], '"(.*)", ?"(.*)", ?"(.*)"', 3)
					 IniDelete($inputi386&'\txtsetup.sif', $aSif[1], $aSif[2])
			   EndIf
			   Next
			   EndIf
;=================================================================
			Else
			   ; иначе отправка  *.inf в папку inf
			   FileClose($tempname)
			   FileCopy($tempname, $inputi386&'\inf\', 9)
			   FileWrite($filereg, 'i386\inf\'&$aPathwim[1]&@CRLF)
			EndIf
		 EndIf
	  WEnd
	  FileClose($filereg)
	  FileClose($fileinf)
   EndIf
		 $size1=FileGetSize($inputi386&'\TXTSETUP.SIF')
		 $size1 /=1024
		 $size1=Ceiling ($size1)
   GUICtrlSetData($Label000, 'Выполнено !!!                 TXTSETUP.SIF='&$size&'кб > '&$size1&'кб')
   ;GUICtrlSetData($Label000, 'Выполняется обновление...   TXTSETUP.SIF='&$size)

		; кнопки "Обзор"
	  Case $msg = $filewim
		$tmpwim = FileSelectFolder ( "Указать папку i386 или MiniNT",'','3',@WorkingDir & '')
		GUICtrlSetData($inputi386z, $tmpwim)
	  Case $msg = $filezip
		$tmpzip = FileSelectFolder ( "Указать папку с драйверами",'','3',@WorkingDir & '')
		GUICtrlSetData($inputdrv, $tmpzip)
	  Case $msg = $GUI_EVENT_CLOSE
		ExitLoop
   EndSelect
WEnd
	
;======================================================================================================
; функция поиска всех файлов в каталоге (NIKZZZZ)
Func FileFindNextFirst($FindCat) 
  $Stack[0] = 1 
  $Stack1[1] = $FindCat 
  $Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*") 
  Return $Stack[$Stack[0]] 
EndFunc   ;==>FileFindNextFirst 
 
Func FileFindNext() 
  While 1 
    $file = FileFindNextFile($Stack[$Stack[0]]) 
    If @error Then 
      FileClose($Stack[$Stack[0]]) 
      If $Stack[0] = 1 Then 
        Return "" 
      Else 
        $Stack[0] -= 1 
        ContinueLoop 
      EndIf 
    Else 
      If StringInStr(FileGetAttrib($Stack1[$Stack[0]] & "\" & $file), "D") > 0 Then 
        $Stack[0] += 1 
        $Stack1[$Stack[0]] = $Stack1[$Stack[0] - 1] & "\" & $file 
        $Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*") 
        ContinueLoop 
      Else 
        Return $Stack1[$Stack[0]] & "\" & $file 
      EndIf 
    EndIf 
  WEnd 
EndFunc   ;==>FileFindNext