#include <windowsconstants.au3>
#include <WinAPI.au3>
#include <Memory.au3>


Global Const $WM_TRAYNOTIFY = $WM_USER + 1
Global Const $NIN_BALLOONSHOW = $WM_USER + 2
Global Const $NIN_BALLOONHIDE = $WM_USER + 3
Global Const $NIN_BALLOONUSERCLICK = $WM_USER + 5
Global Const $NIN_BALLOONTIMEOUT = $WM_USER + 4

Global Const $__gpTrayNotifySubclassProc = __TrayNotify_CreateSubclassProc()
Func __TrayNotify_CreateSubclassProc()
    ; ASM by ProgAndy
    Local $aCall = DllCall("kernel32.dll", "ptr", "GetProcAddress", "handle", _WinAPI_GetModuleHandle("user32.dll"), "str", "PostMessageW")
    Local $pPostMessageW = $aCall[0]
    $aCall = DllCall("kernel32.dll", "ptr", "GetProcAddress", "handle", _WinAPI_GetModuleHandle("Comctl32.dll"), "str", "DefSubclassProc")
    Local $pDefSubclassProc = $aCall[0]

    ; dwRefData (parameter #6) will be target window
    If @AutoItX64 Then; x64
    #cs
        use64
            push rbp
            mov  rbp, rsp
            sub rsp, 32 ; shadow space for api calls
            CMP RDX, 401h ; WM_TRAYNOTIFY
            jnz after_notify
        notify:
            mov  [rbp+10h], RCX ; save registers to own shadow space
            mov  [rbp+18h], RDX
            mov  [rbp+20h], R8
            mov  [rbp+28h], R9
            mov rcx, [rbp+38h] ; hWndRedirect
            mov rax, 22FF22FF22FF22FFh ; DUMMY 2
            call rax ; call PostMessageW
            mov R9, qword[ebp+28h] ; lparam ; restore registers for next call
            mov R8, qword[ebp+20h] ; wparam
            mov RDX, qword[ebp+18h] ; uMsg
            mov RCX, qword[ebp+10h] ; hWnd
        after_notify:
            mov rax, 33FF33FF33FF33FFh ; DUMMY 3
            call rax ; call DefSubclassProc
            add rsp, 32
            pop rbp
        ret ; x64 MS-FASTCALL
    #ce
        Local $b = Binary("0x554889e54883ec204881fa01040000753448894d10488955184c8945204c894d28488b4d3848b8")&Binary($pPostMessageW)&Binary("0xffd0674c8b4d28674c8b452067488b551867488b4d1048b8")&Binary($pDefSubclassProc)&Binary("0xffd04883c4205dc3")
    Else; x86
    #cs
        use32
            push ebp
            mov  ebp, esp
            CMP dword[ebp+12], 401h ; WM_TRAYNOTIFY
            jnz after_notify
        notify:    push dword[ebp+20] ; lparam
            push dword[ebp+16] ; wparam
            push dword[ebp+12] ; uMsg
            push dword[ebp+28] ; hWndRedirect
            mov eax, 22FF22FFh ; DUMMY 2
            call eax ; call PostMessageW
        after_notify: push dword[ebp+20] ; lparam
            push dword[ebp+16] ; wparam
            push dword[ebp+12] ; uMsg
            push dword[ebp+8] ; hWnd
            mov eax, 33FF33FFh ; DUMMY 3
            call eax ; call DefSubclassProc
            pop ebp
        ret 24 ; 6 parameters stdcall
    #ce
        Local $b = Binary("0x5589e5817d0c010400007513ff7514ff7510ff750cff751cb8")&Binary($pPostMessageW)&Binary("0xffd0ff7514ff7510ff750cff7508b8")&Binary($pDefSubclassProc)&Binary("0xffd05dc21800")
    EndIf
    Local $pMem = _MemVirtualAlloc(0, BinaryLen($b), $MEM_COMMIT, $PAGE_EXECUTE_READWRITE)
    Local $t = DllStructCreate("byte[" & BinaryLen($b) & "]", $pMem)
    DllStructSetData($t, 1, $b)
    Return $pMem
EndFunc

Func _TrayNotify_Redirect($hWndRedirect)
    DllCall("comctl32.dll", "bool", "SetWindowSubclass", "hwnd", __TrayNotify_AutoItWinGetHandle(), "ptr", $__gpTrayNotifySubclassProc, "uint_ptr", $hWndRedirect, "dword_ptr", $hWndRedirect)
EndFunc
Func _TrayNotify_RemoveRedirect($hWndRedirect)
    DllCall("comctl32.dll", "bool", "RemoveWindowSubclass", "hwnd", __TrayNotify_AutoItWinGetHandle(), "ptr", $__gpTrayNotifySubclassProc, "uint_ptr", $hWndRedirect)
EndFunc

Func __TrayNotify_AutoItWinGetHandle()
    Local Static $h
    If IsHWnd($h) Then Return $h
    Local $t = AutoItWinGetTitle()
    AutoItWinSetTitle("096c7d2e-4d24-4103-9503-66748fa96cc7#" & @AutoItPID)
    $h = WinGetHandle("096c7d2e-4d24-4103-9503-66748fa96cc7#" & @AutoItPID)
    AutoItWinSetTitle($t)
    Return $h
EndFunc

Opt('TrayAutoPause', 0)
Opt('WinTitleMatchMode', 3)
Opt('WinWaitDelay', 0)
Opt('TrayMenuMode', 3)

Global $iTip = 2
Global $hForm = GUICreate('')
DllOpen("comctrl32.dll")

_TrayNotify_Redirect($hForm)
GUIRegisterMsg($WM_TRAYNOTIFY, 'WM_TRAYNOTIFY')

Global $iShow = TrayCreateItem("Show New Tip")
TrayCreateItem("")
Global $iExit = TrayCreateItem("Exit")

TrayTip('Tip', 'This is a tray tip, click here.', 10, 1)

While 1
    Switch TrayGetMsg()
        Case $iShow
            TrayTip('Tip', 'This is a tray tip, click here. [ ' & $iTip & ' ]', 10, 1)
            $iTip += 1
        Case $iExit
            ExitLoop
    EndSwitch
WEnd
_TrayNotify_RemoveRedirect($hForm)

Func WM_TRAYNOTIFY($hWnd, $iMsg, $wParam, $lParam)
    Switch $hWnd
        Case $hForm
            Switch $lParam
                Case $NIN_BALLOONSHOW
                    ConsoleWrite('Balloon tip show.' & @CR)
                Case $NIN_BALLOONHIDE
                    ConsoleWrite('Balloon tip hide.' & @CR)
                Case $NIN_BALLOONUSERCLICK
                    ConsoleWrite('Balloon tip click.' & @CR)
                Case $NIN_BALLOONTIMEOUT
                    ConsoleWrite('Balloon tip close.' & @CR)
            EndSwitch
    EndSwitch
EndFunc   ;==>WM_TRAYNOTIFY