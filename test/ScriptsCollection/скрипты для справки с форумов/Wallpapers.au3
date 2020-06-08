#include <GDIPlus.au3> 
 
$sFile = "C:\WINDOWS\Web\Wallpaper\Wallpaper.jpg" 
 
_ChangeWallpaper($sFile, 3) 
 
; Changes the wallpaper to $sFilename using $iType as: 
; 1 Tiled 
; 2 Centered 
; 3 Stretched 
; any other value (usually 0) unchanged 
; 
; Returns 
; 1 if everything is allright. 
; -1 if $sFile does not exist. @error is set to 1 
Func _ChangeWallpaper($sFile, $iType) 
    If Not FileExists($sFile) Then Return SetError(1, 0, -1) 
 
    Local Const $SPIF_UPDATEINIFILE = 0x0001 
    Local Const $SPIF_SENDCHANGE = 0x0002 
    Local Const $SPI_SETDESKWALLPAPER = 0x0014 
    Local $sTemp_File = @AppDataDir & "\Microsoft\Wallpaper1.bmp" 
    Local $hImage, $sCLSID, $tBuffer 
 
    ;Convert image to BMP format 
    If StringRegExpReplace($sFile, "^.*\.", "") <> 'bmp' Then 
        _GDIPlus_Startup() 
 
        $hImage = _GDIPlus_ImageLoadFromFile($sFile) 
        $sCLSID = _GDIPlus_EncodersGetCLSID("bmp") 
        _GDIPlus_ImageSaveToFileEx($hImage, $sTemp_File, $sCLSID) 
        _GDIPlus_Shutdown() 
    Else 
        FileCopy($sFile, $sTemp_File, 1) 
    EndIf 
 
    $sFile = $sTemp_File 
 
    Switch $iType 
        Case 1 
            RegWrite('HKCU\Control Panel\Desktop', 'TileWallpaper', 'REG_SZ', '1') 
            RegWrite('HKCU\Control Panel\Desktop', 'WallpaperStyle', 'REG_SZ', '0') 
        Case 2 
            RegWrite('HKCU\Control Panel\Desktop', 'TileWallpaper', 'REG_SZ', '0') 
            RegWrite('HKCU\Control Panel\Desktop', 'WallpaperStyle', 'REG_SZ', '0') 
        Case 3 
            RegWrite('HKCU\Control Panel\Desktop', 'TileWallpaper', 'REG_SZ', '0') 
            RegWrite('HKCU\Control Panel\Desktop', 'WallpaperStyle', 'REG_SZ', '2') 
    EndSwitch 
 
    $tBuffer = DllStructCreate("char Text[" & StringLen($sFile) + 1 & "]") 
    DllStructSetData($tBuffer, "Text", $sFile) 
 
    RegWrite('HKCU\Control Panel\Desktop', 'Wallpaper', 'REG_SZ', $sFile) 
    DllCall("User32.dll", "int", "SystemParametersInfo", "int", $SPI_SETDESKWALLPAPER, "int", 0, _ 
        "ptr", DllStructGetPtr($tBuffer), "int", BitOR($SPIF_UPDATEINIFILE, $SPIF_SENDCHANGE)) 
 
    Return 1 
EndFunc 