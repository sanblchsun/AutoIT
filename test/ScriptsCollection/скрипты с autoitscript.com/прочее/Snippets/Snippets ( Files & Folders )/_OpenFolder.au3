#cs
    These have been declared in Global scope as you may wish to use them elsewhere in your script.
#ce
Global $ALTSTARTUP = 0x1d
Global $APPDATA = 0x1a
Global $BITBUCKET = 0x0a
Global $COMMONALTSTARTUP = 0x1e
Global $COMMONAPPDATA = 0x23
Global $COMMONDESKTOPDIR = 0x19
Global $COMMONFAVORITES = 0x1f
Global $COMMONPROGRAMS = 0x17
Global $COMMONSTARTMENU = 0x16
Global $COMMONSTARTUP = 0x18
Global $CONTROLS = 0x03
Global $COOKIES = 0x21
Global $DESKTOP = 0x00
Global $DESKTOPDIRECTORY = 0x10
Global $DRIVES = 0x11
Global $FAVORITES = 0x06
Global $FONTS = 0x14
Global $HISTORY = 0x22
Global $INTERNETCACHE = 0x20
Global $LOCALAPPDATA = 0x1c
Global $MYPICTURES = 0x27
Global $NETHOOD = 0x13
Global $NETWORK = 0x12
Global $PERSONAL = 0x05
Global $PRINTERS = 0x04
Global $PRINTHOOD = 0x1b
Global $PROFILE = 0x28
Global $PROGRAMFILES = 0x26
Global $PROGRAMFILESx86 = 0x30
Global $PROGRAMS = 0x02
Global $RECENT = 0x08
Global $SENDTO = 0x09
Global $STARTMENU = 0x0b
Global $STARTUP = 0x07
Global $SYSTEM = 0x25
Global $SYSTEMx86 = 0x29
Global $TEMPLATES = 0x15
Global $WINDOWS = 0x24
 
ConsoleWrite(_OpenFolder(@ScriptDir) & @CRLF)
ConsoleWrite(_OpenFolder($PRINTERS) & @CRLF)
 
; Open a folder or special folder variable, similar to using ShellExecute.
Func _OpenFolder($sFolderPath)
    Local $oShell = ObjCreate('shell.application')
    If @error Then
        Return SetError(1, 0, 0)
    EndIf
    $oShell.Open($sFolderPath)
    Return 1
EndFunc   ;==>_OpenFolder