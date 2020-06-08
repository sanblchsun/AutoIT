; for X86
Opt('MustDeclareVars', 1)

Global Const $SHCNE_ASSOCCHANGED = 0x8000000
Global Const $SHCNF_FLUSH = 0x1000
Global Const $SHCNF_IDLIST = 0x0

Global $file, $title

$file = FileOpen(@TempDir & "\test\test.exmp", 10)
FileClose($file)
ShellExecute(@TempDir & "\test")
Sleep(4000)
$title = WinGetTitle("[active]")
RegWrite("HKEY_CLASSES_ROOT\.exmp", "", "REG_SZ", "exmpfile")
RegWrite("HKEY_CLASSES_ROOT\exmpfile\DefaultIcon", "", "REG_SZ", "shell32.dll,27")

_WinAPI_SHChangeNotify($SHCNE_ASSOCCHANGED, BitOR($SHCNF_IDLIST, $SHCNF_FLUSH)); update shell icons

Sleep(4000)
RegDelete("HKEY_CLASSES_ROOT\.exmp")
RegDelete("HKEY_CLASSES_ROOT\exmpfile")

_WinAPI_SHChangeNotify($SHCNE_ASSOCCHANGED, BitOR($SHCNF_IDLIST, $SHCNF_FLUSH)); update shell icons

Sleep(2000)
If WinExists($title) Then WinClose($title)
DirRemove(@TempDir & "\test", 1)

Func _WinAPI_SHChangeNotify($wEventId, $uFlags, $dwItem1 = 0, $dwItem2 = 0)
    DllCall("shell32.dll", "none", "SHChangeNotify", _
            "long", $wEventId, _
            "uint", $uFlags, _
            "ptr", $dwItem1, _
            "ptr", $dwItem2 _
            )
EndFunc
 