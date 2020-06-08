#include <GDIPlus.au3>

$Image = FileOpenDialog('Открыть', @ScriptDir, 'Рисунок (*.jpg;*.bmp;*.gif)', '', '', GUICreate(''))
If @error Then Exit
_ImageResize($Image, @ScriptDir & "\Копия.jpg", 333, 222)

Func _ImageResize($sImagePath, $sOutImage, $iW, $iH)
    Local $hWnd, $hDC, $hBMP, $hImage1, $hImage2, $hGraphic, $CLSID, $i = 0, $Ext, $TrOut
	
    ;Старт GDIPlus
    _GDIPlus_Startup()

    $hImage2 = _GDIPlus_ImageLoadFromFile ($sImagePath) ; загружаем файл рисунка
	$iWidth = _GDIPlus_ImageGetWidth($hImage2) ; получаем его размеры
	$iHeight = _GDIPlus_ImageGetHeight($hImage2)
	$aWH=_Coor($iW, $iH, $iWidth, $iHeight) ; возвращает пропорциональные координаты по наименьшему

    ; WinAPI для создания пустого bitmap с шириной и высотой, для вставки изменёного рисунка.
    $hWnd = _WinAPI_GetDesktopWindow()
    $hDC = _WinAPI_GetDC($hWnd)
    $hBMP = _WinAPI_CreateCompatibleBitmap($hDC, $iW, $iH)
    _WinAPI_ReleaseDC($hWnd, $hDC)

    ;Возвращает дескриптор пустого bitmap созданного ранее в виде изображения
    $hImage1 = _GDIPlus_BitmapCreateFromHBITMAP ($hBMP)

    ; Создаём графический контекст пустого bitmap
    $hGraphic = _GDIPlus_ImageGetGraphicsContext ($hImage1)

    ; Рисует загруженное изображение в пустом bitmap нужного размера
    _GDIPLus_GraphicsDrawImageRect($hGraphic, $hImage2, 0, 0, $aWH[0], $aWH[1])

    ; Расширение файла, чтобы получить CLSID декодера.
    $Ext = StringUpper(StringMid($sOutImage, StringInStr($sOutImage, ".", 0, -1) + 1))

    ; Возвращает декодер, чтобы сохранить изменённое изображение в нужном формате.
    $CLSID = _GDIPlus_EncodersGetCLSID($Ext)

	_FileName($sOutImage)
	
    ; Сохраняет изменённый рисунок.
	$TrOut=_GDIPlus_ImageSaveToFileEx($hImage1, $sOutImage, $CLSID)

    ; Очищает и закрывает GDIPlus.
    _GDIPlus_ImageDispose($hImage1)
    _GDIPlus_ImageDispose($hImage2)
    _GDIPlus_GraphicsDispose ($hGraphic)
    _WinAPI_DeleteObject($hBMP)
    _GDIPlus_Shutdown()
	Return $TrOut
EndFunc

Func _FileName(ByRef $sOutImage)
	Local $i, $sOF, $sOP

    ; Путь для использования в дальнейшем.
    Local $sOP = StringLeft($sOutImage, StringInStr($sOutImage, "\", 0, -1))

    ; Имя файла для использования в дальнейшем.
    Local $sOF = StringMid($sOutImage, StringInStr($sOutImage, "\", 0, -1) + 1)
	
    ; Генерирует номер для выходного файла, который не существует, чтобы не перезаписать существующие изображения.
    Do
        $i += 1
    Until (Not FileExists($sOP & $i & "_" & $sOF))

    ; Числовой префикс в начало выходного файла
    $sOutImage = $sOP & $i & "_" & $sOF
EndFunc

; Вычисление размера рисунка для пропорционального преобразования
Func _Coor($x1, $y1, $x2, $y2)
	Local $aXY[2] = [0,0], $kX=$x1/$x2, $kY=$y1/$y2
	If Abs($x1-$x2)<3 And Abs($y1-$y2)<3 Then ; если размер почти совпадает, то возврат родных координат, отказ от преобразования
		$aXY[0]=$x2
		$aXY[1]=$y2
		Return SetError(0, 1, $aXY)
	EndIf
	If $kX>$kY Then
		$aXY[0]=Round($x2*$kY)
		$aXY[1]=$y1
	Else
		$aXY[0]=$x1
		$aXY[1]=Round($y2*$kX)
	EndIf
	Return SetError(0, 0, $aXY)
EndFunc