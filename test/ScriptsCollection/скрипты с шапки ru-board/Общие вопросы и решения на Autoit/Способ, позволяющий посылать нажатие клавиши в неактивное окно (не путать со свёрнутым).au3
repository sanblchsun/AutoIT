#Include <WinAPI.au3>

$hWnd = WinGetHandle("RF Online")
_SendMessage($hWnd, 0x6, 0x1)
ControlSend($hWnd, "", "", "{F1}")
_SendMessage($hWnd, 0x6, 0x1)