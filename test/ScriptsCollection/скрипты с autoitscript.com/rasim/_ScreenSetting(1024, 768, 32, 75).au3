_ScreenSetting(1024, 768, 32, 75)

;====================================================================================
;
;Function Name:     _ScreenSetting()
;Description:       Changes the screen resolution, color dept and refresh rate
;Version:           1.0
;Parameters:        $iWidth   - Width of the desktop screen in pixels. (horizontal resolution)
;                   $iHeight  - Height of the desktop screen in pixels. (vertical resolution)
;                   $iDepth   - Depth of the desktop screen in bits per pixel.
;                   $iRefresh - Refresh rate of the desktop screen in hertz.
;Return Value(s):   On Success - Screen is adjusted
;                   On failure - Message with error description
;Requirement(s):    Tested on AutoIt 3.2.10.0
;Autor(s):          R.Gilman (a.k.a rasim); special thanks to amel27
;
;====================================================================================
Func _ScreenSetting($iWidth = @DesktopWidth, $iHeight = @DesktopHeight, $iDepth = @DesktopDepth, $iRefresh = @DesktopRefresh)
    Local Const $DISP_CHANGE_SUCCESSFUL = 0
    Local Const $DISP_CHANGE_RESTART    = 1
    Local Const $DISP_CHANGE_FAILED     = -1
    Local Const $DISP_CHANGE_BADMODE    = -2
    Local Const $DISP_CHANGE_NOTUPDATED = -3
    Local Const $DISP_CHANGE_BADFLAGS   = -4
    Local Const $DISP_CHANGE_BADPARAM   = -5
    
    Local Const $CDS_TEST           = 0x4
    Local Const $CDS_UPDATEREGISTRY = 0x1
    
    Local Const $DM_PELSWIDTH        = 0x80000
    Local Const $DM_PELSHEIGHT       = 0x100000
    Local Const $DM_BITSPERPEL       = 0x40000
    Local Const $DM_DISPLAYFREQUENCY = 0x400000
    
    Local Const $ENUM_CURRENT_SETTINGS   = -1
    Local Const $WM_DISPLAYCHANGE        = 0x007E
    Local Const $HWND_BROADCAST          = 0xFFFF
    Local Const $SPI_SETNONCLIENTMETRICS = 0x2A
    
    Local $DEVMODE, $DllRet
    
    $DEVMODE = DllStructCreate("char dmDeviceName[32];ushort dmSpecVersion;ushort dmDriverVersion;short dmSize;" & _
                               "ushort dmDriverExtra;dword dmFields;short dmOrientation;short dmPaperSize;short dmPaperLength;" & _
                               "short dmPaperWidth;short dmScale;short dmCopies;short dmDefaultSource;short dmPrintQuality;" & _
                               "short dmColor;short dmDuplex;short dmYResolution;short dmTTOption;short dmCollate;" & _
                               "byte dmFormName[32];dword dmBitsPerPel;int dmPelsWidth;dword dmPelsHeight;" & _
                               "dword dmDisplayFlags;dword dmDisplayFrequency")
                               
    $DllRet = DllCall("user32.dll", "int", "EnumDisplaySettings", "ptr", 0, "dword", $ENUM_CURRENT_SETTINGS, _
                      "ptr", DllStructGetPtr($DEVMODE))
    $DllRet = $DllRet[0]
    
    If $DllRet = 0 Then
        MsgBox(16, "Error", "Unable to get graphic mode")
        Return False
    EndIf
    
    $VGA_MAP_KEY = RegRead("HKLM\HARDWARE\DEVICEMAP\VIDEO", "\Device\Video0")
    $VGA_KEY = StringReplace($VGA_MAP_KEY, "\Registry\Machine", "HKLM")
    
    RegWrite($VGA_KEY, "PruningMode", "REG_DWORD", 0)
    
    DllStructSetData($DEVMODE, "dmSize", DllStructGetSize($DEVMODE))
    DllStructSetData($DEVMODE, "dmPelsWidth", $iWidth)
    DllStructSetData($DEVMODE, "dmPelsHeight", $iHeight)
    DllStructSetData($DEVMODE, "dmBitsPerPel", $iDepth)
    DllStructSetData($DEVMODE, "dmDisplayFrequency", $iRefresh)
    DllStructSetData($DEVMODE, "dmFields", BitOR($DM_PELSWIDTH, $DM_PELSHEIGHT, $DM_BITSPERPEL, $DM_DISPLAYFREQUENCY))

    $DllRet = DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_TEST)
    $DllRet = $DllRet[0]
    
    If $DllRet <> $DISP_CHANGE_SUCCESSFUL Then
        Switch $DllRet
            Case $DISP_CHANGE_RESTART
                MsgBox(48, "Warning", "Restart your computer for change display settings")
            Case $DISP_CHANGE_FAILED
                MsgBox(16, "Error", "The video driver not set a new mode")
                Return False
            Case $DISP_CHANGE_BADMODE
                MsgBox(16, "Error", "Video mode not supported")
                Return False
            Case $DISP_CHANGE_NOTUPDATED
                MsgBox(16, "Error", "Unable to write in registry")
                Return False
            Case $DISP_CHANGE_BADFLAGS
                MsgBox(16, "Error", "Bad flags")
                Return False
            Case $DISP_CHANGE_BADPARAM
                MsgBox(16, "Error", "Bad parameters")
                Return False
        EndSwitch
    EndIf

    $DllRet = DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_UPDATEREGISTRY)
    $DllRet = $DllRet[0]

    DllCall("user32.dll", "int", "SendMessage", "hwnd", $HWND_BROADCAST, "int", $WM_DISPLAYCHANGE, _
            "int", $SPI_SETNONCLIENTMETRICS, "int", 0)

    RegWrite($VGA_KEY, "PruningMode", "REG_DWORD", 1)

    $DEVMODE = ""
    $DllRet  = ""
EndFunc