#include <GDIPlus.au3>

$Image = FileOpenDialog('Открыть', @ScriptDir, 'Рисунок (*.jpg;*.bmp;*.gif)', '', '', GUICreate(''))
If @error Then Exit
_ImageResize($Image, @ScriptDir & "\Копия.jpg", 370, 250)


Func _ImageResize($sImagePath, $sOutImage, $iW, $iH)
    Local $hWnd, $hDC, $hBMP, $hImage1, $hImage2, $hGraphic, $CLSID, $i = 0
	
    ;Старт GDIPlus
    _GDIPlus_Startup()

    $hImage2 = _GDIPlus_ImageLoadFromFile ($sImagePath) ; загружаем файл рисунка
	$iWidth = _GDIPlus_ImageGetWidth($hImage2) ; получаем его размеры
	$iHeight = _GDIPlus_ImageGetHeight($hImage2)
	$aWH=_Coor($iW, $iH, $iWidth, $iHeight) ; возвращает пропорциональные координаты по наименьшему

    ; WinAPI для создания пустого bitmap с шириной и высотой, для вставки изменёного рисунка.
    $hWnd = _WinAPI_GetDesktopWindow()
    $hDC = _WinAPI_GetDC($hWnd)
    $hBMP = _WinAPI_CreateCompatibleBitmap($hDC, $aWH[0], $aWH[1])
    _WinAPI_ReleaseDC($hWnd, $hDC)

    ;Возвращает дескриптор пустого bitmap созданного ранее в виде изображения
    $hImage1 = _GDIPlus_BitmapCreateFromHBITMAP ($hBMP)

    ; Создаём графический контекст пустого bitmap
    $hGraphic = _GDIPlus_ImageGetGraphicsContext ($hImage1)

    ; Рисует загруженное изображение в пустом bitmap нужного размера
    _GDIPLus_GraphicsDrawImageRect($hGraphic, $hImage2, 0, 0, $aWH[0], $aWH[1])

    ; Расширение файла для использования в дальнейшем.
    Local $Ext = StringUpper(StringMid($sOutImage, StringInStr($sOutImage, ".", 0, -1) + 1))

    ; Возвращает декодер, чтобы сохранить изменённое изображение в нужном формате.
    $CLSID = _GDIPlus_EncodersGetCLSID($Ext)

	_FileName($sOutImage)

    ; Сохраняет изменённый рисунок.
    _GDIPlus_ImageSaveToFileEx($hImage1, $sOutImage, $CLSID)

    ; Очищает и закрывает GDIPlus.
    _GDIPlus_ImageDispose($hImage1)
    _GDIPlus_ImageDispose($hImage2)
    _GDIPlus_GraphicsDispose ($hGraphic)
    _WinAPI_DeleteObject($hBMP)
    _GDIPlus_Shutdown()
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

; $w1, $h1 - размер квадрата в который картинка должна поместитьcя
; $w2, $h2 - реальный размер картинки
Func _Coor($w1, $h1, $w2, $h2)
	Local $aXY[2] = [0,0], $kX=$w1/$w2, $kY=$h1/$h2
	If $kX>$kY Then
		$aXY[0]=Round($w2*$kY)
		$aXY[1]=$h1
	Else
		$aXY[0]=$w1
		$aXY[1]=Round($h2*$kX)
	EndIf
	Return $aXY
EndFunc