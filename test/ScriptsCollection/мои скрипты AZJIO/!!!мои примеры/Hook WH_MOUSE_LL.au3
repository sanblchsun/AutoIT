#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $hHook, $hStub_KeyProc, $iEditLog, $Gui

; � AutoIt3 v3.3.6.1 � ���� ��� ��������� �� ����������
; Global Const $WM_MBUTTONDBLCLK = 0x0209
; Global Const $WM_RBUTTONDBLCLK = 0x0206
; Global Const $WM_MOUSEHWHEEL = 0x020E ???

_Main()

Func _Main()
	OnAutoItExitRegister("Cleanup")

	Local $hmod

	$hStub_KeyProc = DllCallbackRegister("_KeyProc", "long", "int;wparam;lparam")
	$hmod = _WinAPI_GetModuleHandle(0)
	$hHook = _WinAPI_SetWindowsHookEx($WH_MOUSE_LL, DllCallbackGetPtr($hStub_KeyProc), $hmod)

	; Esc - ��� �������� �������

	$Gui=GUICreate('������ ��������� � ������ ����', 700, 260, -1 , -1, $WS_OVERLAPPEDWINDOW)
	$iEdit = GUICtrlCreateEdit('', 5, 5, 290, 250)
	$iEditLog = GUICtrlCreateEdit('', 300, 5, 390, 250)
	GUISetState()

	Do
	Until GUIGetMsg()=-3
EndFunc
;===========================================================
; callback function
;===========================================================
Func _KeyProc($nCode, $wParam, $lParam)
	Local $tKEYHOOKS, $X, $Y, $tmp, $Delta
	If $nCode < 0 Then Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam) ; ������� � ��������� ������� ����� � ������� (�� �����������)
	$tKEYHOOKS = DllStructCreate($tagKBDLLHOOKSTRUCT, $lParam)
	; ���������� ���� X, Y
	$X = DllStructGetData($tKEYHOOKS, "vkCode")
	$Y = DllStructGetData($tKEYHOOKS, "scanCode")

Switch $wParam
	Case $WM_MOUSEWHEEL ; ���� ������ ���� ��������
        $Delta = BitShift(DllStructGetData($tKEYHOOKS, "flags"), 16) ; ���������� ���� ��� ����
		
        If $Delta > 0 Then
			$tmp= '������ ���� ���������� ����� ^'
        Else
			$tmp= '������ ���� ���������� ���� v'
        EndIf
		$tmp &= ' ('&$Delta&')'
		
	Case $WM_LBUTTONDOWN
		$tmp= '������� ����� ������� ����'
		
	Case $WM_LBUTTONUP
		$tmp= '������� ����� ������� ����'
		
	Case $WM_MBUTTONDOWN
		$tmp= '������� ������� ������� ����'
		
	Case $WM_MBUTTONUP
		$tmp= '������� ������� ������� ����'
		
	Case $WM_RBUTTONDOWN
		$tmp= '������� ������ ������� ����'
		
	Case $WM_RBUTTONUP
		$tmp= '������� ������ ������� ����'
		
	Case $WM_XBUTTONDOWN
		$tmp= '������� �������������� ������� ����'
		
	Case $WM_XBUTTONUP
		$tmp= '������� �������������� ������� ����'
		
#cs
; ��� ���� �� ��������
		
	Case $WM_LBUTTONDBLCLK ; �� ��������
		$tmp= '������� ���� ����� ������� ����'
		
	Case $WM_MBUTTONDBLCLK ; �� ��������
		$tmp= '������� ���� ������� ������� ����'
		
	Case $WM_RBUTTONDBLCLK ; �� ��������
		$tmp= '������� ���� ������ ������� ����'
		
	Case $WM_XBUTTONDBLCLK ; �� ��������
		$tmp= '������� ���� �������������� ������� ����'
		
	Case $WM_NCLBUTTONDBLCLK
		$tmp= '������� ���� ����� �� ���������'
		
	Case $WM_NCLBUTTONDOWN
		$tmp= '������� ����� �� ���������'
		
	Case $WM_NCLBUTTONUP
		$tmp= '������� ����� �� ���������'
		
	Case $WM_NCMBUTTONDBLCLK
		$tmp= '������� ���� ������� �� ���������'
		
	Case $WM_NCMBUTTONDOWN
		$tmp= '������� ������� �� ���������'
		
	Case $WM_NCMBUTTONUP
		$tmp= '������� ������� �� ���������'
		
	Case $WM_NCRBUTTONDBLCLK
		$tmp= '������� ���� ������ �� ���������'
		
	Case $WM_NCRBUTTONDOWN
		$tmp= '������� ������ �� ���������'
		
	Case $WM_NCRBUTTONUP
		$tmp= '������� ������ �� ���������'
		
	Case $WM_NCMOUSEMOVE
		$tmp= '����������� ���� � �� ���������� �������'
#ce
		
	; Case $WM_MOUSEMOVE ; ������� ����� ���� �����
		; $tmp= '����������� ���� � ���������� �������'
	Case Else
		$tmp = ""
		WinSetTitle($Gui, '', "X: "&$X&", Y: "&$Y)
		Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam) ; ������� � ��������� ������� ����� � �������
EndSwitch
GUICtrlSetData($iEditLog, $tmp& @CRLF, 1)
	; Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam) ; ������� � ��������� ������� ����� � �������
EndFunc

Func Cleanup()
	_WinAPI_UnhookWindowsHookEx($hHook)
	DllCallbackFree($hStub_KeyProc)
EndFunc