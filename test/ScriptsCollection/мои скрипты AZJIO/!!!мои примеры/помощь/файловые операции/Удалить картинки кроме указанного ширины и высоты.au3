#include <FileOperations.au3>
#include <GDIPlus.au3>
#include <Array.au3>

$sPath = @SystemDir
$aFileList = _FO_FileSearch($sPath, '*.png|*.jpg|*.gif')
If @error Then Exit
$k = 0
_GDIPlus_Startup()
For $i = 1 To $aFileList[0]
	$hImage = _GDIPlus_ImageLoadFromFile($aFileList[$i])
	If Not (_GDIPlus_ImageGetWidth($hImage) = 1280 And _GDIPlus_ImageGetHeight($hImage) = 720) Then
		$k += 1
		$aFileList[$k] = $aFileList[$i] ; переписываем массив соотетственными картинками
	EndIf
	_GDIPlus_ImageDispose($hImage)
Next
_GDIPlus_Shutdown()
ReDim $aFileList[$k + 1]
$aFileList[0] = $k

_ArrayDisplay($aFileList, 'Просмотр файлов')

If MsgBox(4, 'Сообщение', 'Удалить ?') = 6 Then
	$err = ''
	For $i = 1 To $aFileList[0]
		If Not FileDelete($aFileList[$i]) Then
			If Not (FileSetAttrib($aFileList[$i], '-RST') And FileDelete($aFileList[$i])) Then
				$err &= $aFileList[$i] & @CRLF
			EndIf
		EndIf
	Next
	If $err Then MsgBox(0, 'Error', $err)
EndIf