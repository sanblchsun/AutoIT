;CONSTANTS
Global Const $AW_FADE_IN = 0x00080000;fade-in
Global Const $AW_FADE_OUT = 0x00090000;fade-out
Global Const $AW_SLIDE_IN_LEFT = 0x00040001;slide in from left
Global Const $AW_SLIDE_OUT_LEFT = 0x00050002;slide out to left
Global Const $AW_SLIDE_IN_RIGHT = 0x00040002;slide in from right
Global Const $AW_SLIDE_OUT_RIGHT = 0x00050001;slide out to right
Global Const $AW_SLIDE_IN_TOP = 0x00040004;slide-in from top
Global Const $AW_SLIDE_OUT_TOP = 0x00050008;slide-out to top
Global Const $AW_SLIDE_IN_BOTTOM = 0x00040008;slide-in from bottom
Global Const $AW_SLIDE_OUT_BOTTOM = 0x00050004;slide-out to bottom
Global Const $AW_DIAG_SLIDE_IN_TOPLEFT = 0x00040005;diag slide-in from Top-left
Global Const $AW_DIAG_SLIDE_OUT_TOPLEFT = 0x0005000a;diag slide-out to Top-left
Global Const $AW_DIAG_SLIDE_IN_TOPRIGHT = 0x00040006;diag slide-in from Top-Right
Global Const $AW_DIAG_SLIDE_OUT_TOPRIGHT = 0x00050009;diag slide-out to Top-Right
Global Const $AW_DIAG_SLIDE_IN_BOTTOMLEFT = 0x00040009;diag slide-in from Bottom-left
Global Const $AW_DIAG_SLIDE_OUT_BOTTOMLEFT = 0x00050006;diag slide-out to Bottom-left
Global Const $AW_DIAG_SLIDE_IN_BOTTOMRIGHT = 0x0004000a;diag slide-in from Bottom-right
Global Const $AW_DIAG_SLIDE_OUT_BOTTOMRIGHT = 0x00050005;diag slide-out to Bottom-right
Global Const $AW_EXPLODE = 0x00040010;explode
Global Const $AW_IMPLODE = 0x00050010;implode

Func _WinAnimate($v_gui, $i_mode, $i_duration = 1000)
    If @OSVersion = "WIN_XP" OR @OSVersion = "WIN_2000" Then
        DllCall("user32.dll", "int", "AnimateWindow", "hwnd", WinGetHandle($v_gui), "int", $i_duration, "long", $i_mode)
        Local $ai_gle = DllCall('kernel32.dll', 'int', 'GetLastError')
        If $ai_gle[0] <> 0 Then
            SetError(1)
            Return 0
        EndIf
        Return 1
    EndIf
EndFunc;==> _WinAnimate()

; пример анимации, используется функция выше
; данную фичу нашёл в CSnippet, который поставляется с полной версии SciTE

; #include 'Includes\WinAnimate.au3'
$Split=StringSplit( _
$AW_FADE_IN&'|'& _
$AW_FADE_OUT&'|'& _
$AW_SLIDE_IN_LEFT&'|'& _
$AW_SLIDE_OUT_LEFT&'|'& _
$AW_SLIDE_IN_RIGHT&'|'& _
$AW_SLIDE_OUT_RIGHT&'|'& _
$AW_SLIDE_IN_TOP&'|'& _
$AW_SLIDE_OUT_TOP&'|'& _
$AW_SLIDE_IN_BOTTOM&'|'& _
$AW_SLIDE_OUT_BOTTOM&'|'& _
$AW_DIAG_SLIDE_IN_TOPLEFT&'|'& _
$AW_DIAG_SLIDE_OUT_TOPLEFT&'|'& _
$AW_DIAG_SLIDE_IN_TOPRIGHT&'|'& _
$AW_DIAG_SLIDE_OUT_TOPRIGHT&'|'& _
$AW_DIAG_SLIDE_IN_BOTTOMLEFT&'|'& _
$AW_DIAG_SLIDE_OUT_BOTTOMLEFT&'|'& _
$AW_DIAG_SLIDE_IN_BOTTOMRIGHT&'|'& _
$AW_DIAG_SLIDE_OUT_BOTTOMRIGHT&'|'& _
$AW_EXPLODE&'|'& _
$AW_IMPLODE, '|')

$GUI=GUICreate("user32.dll - AnimateWindow", 330, 260)
$Button1=GUICtrlCreateButton('Запуск анимации', 30, 70, 120, 30)
GUISetState ()
While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = $Button1
			For $i = $Split[0] to 1 Step -1
				_WinAnimate ($GUI, $Split[$i], 800)
				Sleep(500)
				_WinAnimate ($GUI, $Split[$i], 800)
			Next
       Case $msg = -3
           Exit
   EndSelect
WEnd