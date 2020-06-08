#include <Array.au3>
#include <FileOperations.au3>

$timer = TimerInit() ; таймер для скорости поиска
$aFolderList = _FO_SearchEmptyFolders(@WindowsDir) ; путь для примера поиска, НЕ СЛЕДУЕТ УДАЛЯТЬ в нём пустые папки
If @error Then Exit
_ArrayDisplay($aFolderList, 'Время : ' & Round(TimerDiff($timer) / 1000, 2) & ' сек', -1, 0, '', '|', '№|Пустые папки') ; просмотр найденных пустыых папок

If MsgBox(4 + 262144, 'Сообщения', 'Удалить пустые папки ?') = 6 Then ; если ответ равен 6, что значить "Да", тогда
	$err = '' ; переменная для лога ошибок
	For $i = 1 To $aFolderList[0] ; цикл удаления папок
		If Not FileRecycle($aFolderList[$i]) Then ; если не удалось переместить в корзину, тогда
			If Not (FileSetAttrib($aFolderList[$i], '-RST') And FileRecycle($aFolderList[$i])) Then ; если не удалось снять атрибуты и переместить в корзину, тогда
				$err &= $aFolderList[$i] & @CRLF ; пишем лог
			EndIf
		EndIf
	Next
	If $err Then MsgBox(0, 'Лог ошибок', $err) ; если лог ошибок не пустой, то смотрим его
EndIf

; FileRecycle($aFolderList[$i], 1) ; удаление в корзину
; DirRemove($aFolderList[$i], 1) ; удаление навсегда