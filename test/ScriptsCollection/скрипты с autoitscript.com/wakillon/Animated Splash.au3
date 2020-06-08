#include <GDIPlus.au3>
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>
Dim $_GuiDelete

$_PngUrl = 'http://www.uclouvain.be/cps/ucl/doc/adcp/images/Google_logo.png'
$_PngPath = @TempDir & "\temp1.png"
If Not FileExists ( $_PngPath ) Then InetGet ( $_PngUrl, $_PngPath, 1 )
_GDIPlus_Startup ( )
$_Image = _GDIPlus_ImageLoadFromFile ( $_PngPath )
$_Width = _GDIPlus_ImageGetWidth ( $_Image )
$_Height = _GDIPlus_ImageGetHeight ( $_Image )
$_Ratio = $_Width / $_Height

; example 1
For $_Width = 200 To @DesktopWidth/2 Step 10    
    $_Gui = GUICreate ( "gui", $_Width , $_Width / $_Ratio, -1, -1, -1, BitOR ( $WS_EX_LAYERED, $WS_EX_TOPMOST, $WS_EX_TOOLWINDOW ) )
    $_Image = _ImageResize ( $_PngPath, $_Width, $_Width / $_Ratio ) 
    _SetBitMap ( $_Gui, $_Image, 255, $_Width, $_Width / $_Ratio )
    GUISetState ( @SW_SHOW )
Next

Sleep ( 2000 )
_GDIPlus_GraphicsDispose ( $_Image )
_GDIPlus_Shutdown ( )
While Not $_GuiDelete
    $_GuiDelete= Not GUIDelete ( WinGetHandle ( "gui" ) )
WEnd
Sleep ( 2000 )

; example 2
$_PngUrl = 'http://www.pc-infopratique.com/images/banque/dell_logo_circle_2.png'
$_PngPath = @TempDir & "\temp2.png"
If Not FileExists ( $_PngPath ) Then InetGet ( $_PngUrl, $_PngPath, 1 )
_GDIPlus_Startup ( )
$_Image = _GDIPlus_ImageLoadFromFile ( $_PngPath )
$_Width = _GDIPlus_ImageGetWidth ( $_Image )
$_Height = _GDIPlus_ImageGetHeight ( $_Image )
$_Ratio = $_Width / $_Height

For $_Width = 50 To @DesktopWidth/2 Step 10 
    $_Gui = GUICreate ( "gui", $_Width , $_Width / $_Ratio, -1, -1, -1, BitOR ( $WS_EX_LAYERED, $WS_EX_TOPMOST, $WS_EX_TOOLWINDOW ) )
    $_Image = _ImageResize ( $_PngPath, $_Width, $_Height ) 
    _SetBitMap ( $_Gui, $_Image, 255, $_Width, $_Height )
    GUISetState ( @SW_SHOW )
Next

Sleep ( 2000 )
_GDIPlus_GraphicsDispose ( $_Image )
_GDIPlus_Shutdown ( )
$_GuiDelete= Not $_GuiDelete
While Not $_GuiDelete
    $_GuiDelete= Not GUIDelete ( WinGetHandle ( "gui" ) )
WEnd
Sleep ( 2000 )

; example 3
$_PngUrl = 'http://www.blogandcom.com/wp-content/uploads/2009/09/twitter_logo-1024x378.png'
$_PngPath = @TempDir & "\temp3.png"
If Not FileExists ( $_PngPath ) Then InetGet ( $_PngUrl, $_PngPath, 1 )
_GDIPlus_Startup ( )
$_Image = _GDIPlus_ImageLoadFromFile ( $_PngPath )
$_Width = _GDIPlus_ImageGetWidth ( $_Image )
$_Height = _GDIPlus_ImageGetHeight ( $_Image )
$_Ratio = $_Width / $_Height

For $_Width = 300 To @DesktopWidth/1.3 Step 10  
    $_Gui = GUICreate ( "", $_Width , $_Width / $_Ratio, -1, -1, -1, BitOR ( $WS_EX_LAYERED, $WS_EX_TOPMOST, $WS_EX_TOOLWINDOW ) )
    $_Image = _ImageResize ( $_PngPath, $_Width, $_Height ) 
    _SetBitMap ( $_Gui, $_Image, 255, $_Width, $_Width / $_Ratio )
    GUISetState ( @SW_SHOW )
Next

Sleep ( 2000 )
_GDIPlus_GraphicsDispose ( $_Image )
_GDIPlus_Shutdown ( )
$_GuiDelete= Not $_GuiDelete
While Not $_GuiDelete
    $_GuiDelete= Not GUIDelete ( WinGetHandle ( "gui" ) )
WEnd
Exit

Func _SetBitmap ( $hGUI, $hImage, $iOpacity, $n_width, $n_height )
    Local $hScrDC, $hMemDC, $hBitmap, $hOld, $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend
    $hScrDC = _WinAPI_GetDC ( 0 )
    $hMemDC = _WinAPI_CreateCompatibleDC ( $hScrDC )
    $hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap ( $hImage )
    $hOld = _WinAPI_SelectObject ( $hMemDC, $hBitmap )
    $tSize = DllStructCreate ( $tagSIZE )
    $pSize = DllStructGetPtr ( $tSize )
    DllStructSetData ( $tSize, "X", $n_width )
    DllStructSetData ( $tSize, "Y", $n_height )
    $tSource = DllStructCreate ( $tagPOINT )
    $pSource = DllStructGetPtr ( $tSource )
    $tBlend = DllStructCreate ( $tagBLENDFUNCTION )
    $pBlend = DllStructGetPtr ( $tBlend )
    DllStructSetData ( $tBlend, "Alpha", $iOpacity )
    DllStructSetData ( $tBlend, "Format", 1 )
    _WinAPI_UpdateLayeredWindow ( $hGUI, $hScrDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA )
    _WinAPI_ReleaseDC ( 0, $hScrDC )
    _WinAPI_SelectObject ( $hMemDC, $hOld )
    _WinAPI_DeleteObject ( $hBitmap )
    _WinAPI_DeleteDC ( $hMemDC )
EndFunc ;==> _SetBitmap ( )

Func _ImageResize ( $sInImage, $newW, $newH, $sOutImage = "" )
    Local $oldImage, $GC, $newBmp, $newGC
    If $sOutImage = "" Then _GDIPlus_Startup ( )
    $oldImage = _GDIPlus_ImageLoadFromFile ( $sInImage )
    $GC = _GDIPlus_ImageGetGraphicsContext ( $oldImage )
    $newBmp = _GDIPlus_BitmapCreateFromGraphics ( $newW, $newH, $GC )
    $newGC = _GDIPlus_ImageGetGraphicsContext ( $newBmp )
    _GDIPlus_GraphicsDrawImageRect ( $newGC, $oldImage, 0, 0, $newW, $newH )
    _GDIPlus_GraphicsDispose ( $GC )
    _GDIPlus_GraphicsDispose ( $newGC )
    _GDIPlus_ImageDispose ( $oldImage )
    If $sOutImage = "" Then
    Return $newBmp 
    Else
    _GDIPlus_ImageSaveToFile ( $newBmp, $sOutImage )
    _GDIPlus_BitmapDispose ( $newBmp )
    _GDIPlus_Shutdown ( )
    Return 1
    EndIf
EndFunc ;==> _ImageResize ( )
 