; ----------------------------------------------------------------------------
; AutoIt Version: 3.3.6.1
; Author: ynbIpb
; ScriptName: SelfTest v.0.1
; Script Function: Самотестирование скомпилированного скрипта
; ----------------------------------------------------------------------------
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <SelfTest_UDF.au3>
#NoTrayIcon

Global $sSelectedFile = "" ; переменная для хранения пути к выбранному файлу

$Form1 = GUICreate("SfTest", 200, 116)
$Input1 = GUICtrlCreateInput("", 4, 4, 163, 21, BitOR($ES_READONLY, $ES_LEFT, $ES_AUTOHSCROLL)) ; поле для отображения имени файла
$Button1 = GUICtrlCreateButton("...", 171, 3, 25, 24) ; кнопка выбора файла
$Label1 = GUICtrlCreateLabel("Password:", 4, 35, 52, 17)
$Input2 = GUICtrlCreateInput("", 60, 33, 136, 21) ; поле ввода пароля шифрования алгоритмом XXTEA
$Button2 = GUICtrlCreateButton("Start", 4, 62, 192, 25) ; кнопка начала процедуры пропатчивания
$Label2 = GUICtrlCreateLabel("Welcome to SelfTest v.0.1", 4, 95, 192, 17)
;GUICtrlSetBkColor ($Label2, 0x00FF00)
GUISetState(@SW_SHOW)

While 1 ; основной цикл GUI
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button1 ; если нажата кнопка "..." то
			_SelectFile () ; запускаем функцию выбора файла
		Case $Button2 ; если нажата кнопка "Start" то
			_PatchFile () ; запускаем функцию пропатчивания выбранного файла
	EndSwitch
WEnd

; Функция выбора файла для пропатчивания
Func _SelectFile () 
	$sSelectedFile = "" ; очищаем переменную
	GUICtrlSetData ( $Input1, ""); очищаем инпут 
	GUICtrlSetData ($Label2, ""); очищаем лейбл
	$sSelectedFile = FileOpenDialog("Please select file...", @ScriptDir, "All (*.*)",1); отображаем диалог выбора файла
	If @error = 1 Then ; если ничего не выбрано, то отображаем сообщение
		GUICtrlSetData ($Label2, "No file seleced!")
		Return ; и возвращаемся из функции
	EndIf
	$sSelectedFileName = StringMid($sSelectedFile, StringInStr($sSelectedFile, "\", 0, -1) + 1) ; отделяем имя файла
	GUICtrlSetData ( $Input1, $sSelectedFileName); и заносим его в Input
	GUICtrlSetData ($Label2, "File seleced!")
EndFunc ;==> _SelectFile

; Функция пропатчивания файла
Func _PatchFile ()
	$sPass = GUICtrlRead ($Input2); читаем введённый пароль
	If $sSelectedFile = "" Or $sPass = "" Then ; если нет файла или пароля, 
		GUICtrlSetData ($Label2, "Error!"); то выдаём ошибку 
		Return ; и выход из функции
	EndIf
	$hSelectedFile = FileOpen ($sSelectedFile, 16) ; сначала открываем файл для чтения в бинарном режиме
	$bSelectedFile = FileRead ($hSelectedFile)
	FileClose ($hSelectedFile)
	$bSignature = Binary ("0x004D4435") ; это сигнатура 6 байт с которой будет начинаться блок с зашифрованным хэшем ("MD5")
	$bMd5file =  _MD5($bSelectedFile) ; получаем MD5 хэш файла
	$bMd5Encrypted = _XXTEA_Encrypt($bMd5file, $sPass) ; шифруем этот хэш алгоритмом XXTEA c паролем, корорый ввели в поле Edit
	$hSelectedFile = FileOpen ($sSelectedFile, 1+16) ; теперь открываем файл для записи в бинарном режиме в конец файла
	$iWriteResult = FileWrite ($hSelectedFile, $bSignature & $bMd5Encrypted) ; дописываем в конец файла сигнатуру и зашифтрованный хэш
	FileClose ($hSelectedFile)
	If $iWriteResult = 0 Then ; если запись неудачна то
		GUICtrlSetData ($Label2, "Error writng!"); то выдаём ошибку
		Return
	EndIf
	GUICtrlSetData ($Label2, "Done!"); сообщем, что всё прошло удачно
	EndFunc ;==> _PatchFile