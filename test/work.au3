#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#Include <GUIScrollMy.au3>
#include <StaticConstants.au3>
#include <MsgBoxConstants.au3>
#include <ComboConstants.au3>
#include <ButtonConstants.au3>
#include <Date.au3>
#include <GuiButton.au3>
#include <Array.au3>
#include "MouseOnEvent.au3"
#include "GUICtrlOnHover.au3"
#include <WinAPI.au3>
#include <Math.au3>

Opt("GUIResizeMode", 2 + 32 + 256 + 512) ; =802 - устанавливает стандартное поведение всех элементов в GUI, для которых не определёно поведение с помощью GUICtrlSetResizing.
Opt("PixelCoordMode",2)

$Hover_Color = 0xFF0000 ;0x7AC5D8
$Btn_Color = 0x7A9DD8
Global $nGap = 100
Global Const $SPI_GETWORKAREA = 0x30
Global $Button[0]
Global $CreatBoot = False
Global $aSquere[5]
Global $ScrollMax = 35*(UBound($Button)+1)
Global $x1 = $nGap + 1
Global $y
Global $WorkTrue = False
Local $sList1 = """C:\Program Files (x86)\1cv8\8.3.5.1517\bin\1cv8.exe"" CREATEINFOBASE File= ""C:\сборка\basePROF\demo"" /Out""C:\Accounting\log.txt"""
Local $FocusNext = False
Local $FocusNotNext = False
Local $ElementGUI
Local $GrupGUI = 0
Local $OptionsDelete[0], $OptionsEdit[0]

GUIRegisterMsg($WM_SIZE, "WM_SIZE")
_MouseSetOnEvent($MOUSE_WHEELSCROLLDOWN_EVENT, "_MouseWheel_Events")
_MouseSetOnEvent($MOUSE_WHEELSCROLLUP_EVENT, "_MouseWheel_Events")
GUIRegisterMsg($WM_WINDOWPOSCHANGING, "WM_WINDOWPOSCHANGING")
GUIRegisterMsg($WM_EXITSIZEMOVE, "WM_EXITSIZEMOVE")

Global $GUI = GUICreate("",1000,500, -1, -1)
Local $idTrackMenu = GUICtrlCreateContextMenu()
Local $iCreateCMD = GUICtrlCreateMenuItem("Создать коммандную строку", $idTrackMenu)
Local $iCreateCMD2 = GUICtrlCreateMenuItem("Удалить все настройки", $idTrackMenu)


$iBar = Scrollbar_Create($GUI, $SB_VERT, 0)
Scrollbar_Step(35, $GUI, $SB_VERT)
$n1 = GUICtrlCreatePic(@ScriptDir & "\CCC.jpg", 0, 0, 55, 30, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetState($n1, $GUI_HIDE)
$n2 = GUICtrlCreatePic(@ScriptDir & "\CCC1.jpg", 0, 0, 55, 30, -1, $GUI_WS_EX_PARENTDRAG)


GUISetState()



While 1
	$msg = GUIGetMsg()
	Switch $msg
        Case $GUI_EVENT_CLOSE
            Exit
		Case $iCreateCMD
			If IsArray($ElementGUI) Then
				MsgBox(0, "Ошибка", "В окне может быть только один элемент настойки")
			Else
				Local $ElementGUI[0]
				$GrupGUI = GUICtrlCreateGroup("Настрой и перетащи в левый ряд кнопок", 90, 60, 900, 100)
				_ArrayAdd($ElementGUI, $GrupGUI)
				_ArrayAdd($ElementGUI, GUICtrlCreateCombo("", 200, 120, 750, 150, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_NOINTEGRALHEIGHT)))
				GUICtrlSetData(-1, $sList1, "")
				_ArrayAdd($ElementGUI, GUICtrlCreateCombo("", 100, 120, 100, 150, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_NOINTEGRALHEIGHT)))
				GUICtrlSetData(-1, "start """" /wait|start """"", "start """" /wait")
				_ArrayAdd($ElementGUI, GUICtrlCreateButton("Выполнить",800,80,100,20))
				GUICtrlCreateGroup("", -99, -99, 1, 1) ; закрывает группу
			EndIf
		Case $iCreateCMD2
			For $i=0 To UBound($ElementGUI)-1
				GUICtrlDelete($ElementGUI[$i])
			Next
			$ElementGUI = 0
		Case $GUI_EVENT_PRIMARYDOWN
			; Если кнопка мыши нажата - получают информацию где
            $cInfo = GUIGetCursorInfo($GUI)
            $iControl = $cInfo[4]
			If $iControl Then
				Switch $iControl
					Case $GrupGUI
						Local $iSubtractX[0]
						Local $iSubtractY[0]
						; Получаем разницу между координатами элементов формы и позицией мыши
						For $i=0 To UBound($ElementGUI)-1
							$aPos = ControlGetPos($GUI, "", $ElementGUI[$i])
							_ArrayAdd($iSubtractX,$cInfo[0] - $aPos[0])
							_ArrayAdd($iSubtractY, $cInfo[1] - $aPos[1])
						Next
						; переместите управление, пока кнопка мыши не будет отпущена
						Do
							$cInfo = GUIGetCursorInfo($GUI)
							$GranX = $cInfo[0] - $iSubtractX[0]
							Switch True
								Case ($GranX)>50
									For $i=0 To UBound($ElementGUI)-1
										GUICtrlSetPos($ElementGUI[$i], $cInfo[0] - $iSubtractX[$i], $cInfo[1] - $iSubtractY[$i])
									Next
								Case $cInfo[0]<50 And $cInfo[1]>=45
									If Not $aSquere[1] Then
										$aSquere = _GUICtrlCreateSquere($cInfo[0], $cInfo[1], 30,30, 3, 0x00FF00)
									EndIf
									;Позиция мыши по координате Y, и передачи ее  в $aSquere
									$aSquerePos = $cInfo[1]-15
									Switch True
										;место для очередной кнопки
										Case Abs($aSquerePos-(35*(UBound($Button)+1)-(Scrollbar_GetPos($GUI, $SB_VERT))))<15
											If Not $FocusNext Then
												$FocusNext = True
												_GUICtrlSetPosSquere($aSquere, 0, 35*(UBound($Button)+1)-(Scrollbar_GetPos($GUI, $SB_VERT)), 30, 30, 3, 0x00FF00)
											EndIf
	;~ 									;место для между кнопок
										Case Mod($aSquerePos+15,35)<15 And ($aSquerePos)<35*(UBound($Button))-(Scrollbar_GetPos($GUI, $SB_VERT))
											If Not $FocusNotNext Then
												$FocusNotNext = True
												_GUICtrlSetPosSquere($aSquere, 0, 35*Ceiling($aSquerePos/35)-4, 50,5, 3, 0x00FF00)
											EndIf
										Case Else
											$FocusNotNext = False
											$FocusNext = False
											_GUICtrlSetPosSquere($aSquere, 10, $aSquerePos, 30, 30, 3, 0x00FF00)

									EndSwitch
							EndSwitch
						Until Not $cInfo[2]
						For $i=1 To UBound($aSquere)-1
							GUICtrlDelete($aSquere[$i])
							$aSquere[$i] = 0
						Next
						Switch True
							Case $FocusNotNext
								$FocusNotNext = False
								Local $aPos6 = Int($aSquerePos/35)+Int(Scrollbar_GetPos($GUI, $SB_VERT))/35

								For $y=1 To 7
									For	$ii=$aPos6 To UBound($Button)-1
										Local $aPos4 = ControlGetPos("","", $Button[$ii])
										GUICtrlSetPos($Button[$ii], $aPos4[0], $aPos4[1]+5)
										GUICtrlSetData($Button[$ii],$ii+2)
									Next
									Sleep(30)
								Next

								_ArrayInsert($Button, $aPos6, GUICtrlCreateButton($aPos6+1,0,35*(Ceiling($aSquerePos/35)),30,30))
								GUICtrlSetResizing(-1, $GUI_DOCKALL)
								_GUICtrl_OnHoverRegister(-1, "_Hover_Func", "_Leave_Hover_Func")
								GUICtrlSetBkColor(-1, $Btn_Color)
								GUICtrlSetFont(-1, 6)

								$OptionsContextButt = GUICtrlCreateContextMenu($Button[$aPos6])
								_ArrayInsert($OptionsDelete, $aPos6, GUICtrlCreateMenuItem("Удалить", $OptionsContextButt))
								_ArrayInsert($OptionsEdit, $aPos6, GUICtrlCreateMenuItem("Редактировать", $OptionsContextButt))

								Scrollbar_SetMax($GUI, $SB_VERT, 35*(UBound($Button)))
								_Effect1($ElementGUI)
							Case $FocusNext
								$FocusNext = False
								_ArrayAdd($Button,GUICtrlCreateButton(UBound($Button)+1,0,35*(UBound($Button)+1)-(Scrollbar_GetPos($GUI, $SB_VERT)),30,30))

								GUICtrlSetResizing(-1, $GUI_DOCKALL)
								_GUICtrl_OnHoverRegister(-1, "_Hover_Func", "_Leave_Hover_Func")
								GUICtrlSetBkColor(-1, $Btn_Color)
								GUICtrlSetFont(-1, 6)
								GUICtrlSetCursor(-1, 0)

								$OptionsContextButt = GUICtrlCreateContextMenu($Button[UBound($Button)-1])
								_ArrayAdd($OptionsDelete, GUICtrlCreateMenuItem("Удалить", $OptionsContextButt))
								_ArrayAdd($OptionsEdit, GUICtrlCreateMenuItem("Редактировать", $OptionsContextButt))

								Scrollbar_SetMax($GUI, $SB_VERT, 35*(UBound($Button)))
								_Effect1($ElementGUI)

						EndSwitch
				EndSwitch
			EndIf
	EndSwitch
	For $i=0 To UBound($Button)-1
		If $msg=$OptionsDelete[$i] Then
			ConsoleWrite("!!!" & @CRLF)
			GUICtrlDelete($Button[$i])
			_ArrayDelete($Button,$i)
			GUICtrlDelete($OptionsDelete[$i])
			_ArrayDelete($OptionsDelete,$i)
			GUICtrlDelete($OptionsEdit[$i])
			_ArrayDelete($OptionsEdit,$i)
			For $y=1 To 7
				For	$ii=$i To UBound($Button)-1
					Local $aPos5 = ControlGetPos("","", $Button[$ii])
					GUICtrlSetPos($Button[$ii], $aPos5[0], $aPos5[1]-5)
					GUICtrlSetData($Button[$ii],$ii+1)
				Next
				Sleep(30)
			Next

			ExitLoop
		EndIf

		If $msg=$OptionsEdit[$i] Then ConsoleWrite("+++" & @CRLF)
	Next
WEnd

Func _Effect1($ElementGUI_Func)
	For $i=0 To UBound($ElementGUI_Func)-1
		GUICtrlSetState($ElementGUI_Func[$i], $GUI_HIDE)
	Next
	Local $aPosTemp = ControlGetPos($GUI, "", $ElementGUI_Func[0])
	$Gr0 = GUICtrlCreateGroup("", $aPosTemp[0], $aPosTemp[1], $aPosTemp[2], $aPosTemp[3])
	While 1
		$aPosTemp[2]-=150
		$aPosTemp[3]-=10
		ControlMove($GUI, "",$Gr0,$aPosTemp[0], $aPosTemp[1], $aPosTemp[2], $aPosTemp[3])
		If $aPosTemp[2]<20 Or $aPosTemp[3]<20 Then
			GUICtrlDelete($Gr0)
			ExitLoop 1
		EndIf
		Sleep(50)
	WEnd
	For $i=0 To UBound($ElementGUI_Func)-1
		GUICtrlSetState($ElementGUI_Func[$i], $GUI_SHOW)
	Next
	Return
EndFunc




Func _GUICtrlCreateSquere($iLeft, $iTop, $iWidth, $iHeight, $iLineWidth=3, $sColor=0)
	Local $aControlIDArray[5]
	$aControlIDArray[0] = 4
	$aControlIDArray[1] = GUICtrlCreateLabel("", $iLeft, $iTop, $iWidth, $iLineWidth, $SS_SUNKEN)
	GUICtrlSetBkColor(-1, $sColor)
	$aControlIDArray[2] = GUICtrlCreateLabel("", $iLeft, $iTop, $iLineWidth, $iHeight, $SS_SUNKEN)
	GUICtrlSetBkColor(-1, $sColor)
	$aControlIDArray[3] = GUICtrlCreateLabel("", ($iLeft+$iWidth)-1, $iTop, $iLineWidth, $iHeight+2, $SS_SUNKEN)
	GUICtrlSetBkColor(-1, $sColor)
	$aControlIDArray[4] = GUICtrlCreateLabel("", $iLeft, ($iTop+$iHeight)-1, $iWidth+1, $iLineWidth, $SS_SUNKEN)
	GUICtrlSetBkColor(-1, $sColor)
	Return $aControlIDArray
EndFunc

Func _GUICtrlSetPosSquere($aControlIDArray, $iLeft, $iTop, $iWidth, $iHeight, $iLineWidth, $sColor)
	GUICtrlSetPos($aControlIDArray[1], $iLeft, $iTop, $iWidth, $iLineWidth)
	GUICtrlSetPos($aControlIDArray[2], $iLeft, $iTop, $iLineWidth, $iHeight)
	GUICtrlSetPos($aControlIDArray[3], ($iLeft+$iWidth)-1, $iTop, $iLineWidth, $iHeight+2)
	GUICtrlSetPos($aControlIDArray[4], $iLeft, ($iTop+$iHeight)-1, $iWidth+1, $iLineWidth)
	Return
EndFunc


Func _MouseWheel_Events($iEvent)
	If CheckPoint() Then
		Switch $iEvent
			Case $MOUSE_WHEELSCROLLDOWN_EVENT
				Scrollbar_Scroll($GUI, $SB_VERT, Scrollbar_GetPos($GUI, $SB_VERT)+35)
			Case $MOUSE_WHEELSCROLLUP_EVENT
				Scrollbar_Scroll($GUI, $SB_VERT, Scrollbar_GetPos($GUI, $SB_VERT)-35)
		EndSwitch
		Return 1
	EndIf
EndFunc

Func CheckPoint()
    If Not WinActive($GUI) Then Return False
    Local $tPoint = _WinAPI_GetMousePos(True, $GUI)
    If @error Then Return False
    Return $tPoint.X >= 0 And $tPoint.X <= 1000 And $tPoint.Y >= 0 And $tPoint.Y <= 500
EndFunc



Func _Hover_Func($iCtrlID)
    GUICtrlSetBkColor($iCtrlID, $Hover_Color)
    Beep(1000, 20)
EndFunc

Func _Leave_Hover_Func($iCtrlID)
    GUICtrlSetBkColor($iCtrlID, $Btn_Color)
EndFunc


Func WM_WINDOWPOSCHANGING($hWnd, $msg, $wParam, $lParam)
    Local $stRect = DllStructCreate("int;int;int;int")
    Local $stWinPos = DllStructCreate("uint;uint;int;int;int;int;uint", $lParam)
    DllCall("User32.dll", "int", "SystemParametersInfo", "int", $SPI_GETWORKAREA, "int", 0, "ptr", DllStructGetPtr($stRect), "int", 0)
	Local $nHeight = DllStructGetData($stRect, 4)
    $x1 = DllStructGetData($stWinPos, 3)
	$y = DllStructGetData($stWinPos, 4)
	If Abs($x1) <= $nGap Then
		Scrollbar_SetMax($GUI, $SB_VERT, 35*(UBound($Button)))
		DllStructSetData($stWinPos, 3, 0)
		DllStructSetData($stWinPos, 4, 0)
		DllStructSetData($stWinPos, 5, 80)
		DllStructSetData($stWinPos, 6, $nHeight)
		$WorkTrue = True
	EndIf
    Return 0
EndFunc

Func WM_EXITSIZEMOVE($hWnd, $msg, $wParam, $lParam)

	If Abs($x1) > $nGap Then
		If $WorkTrue==True Then
			$WorkTrue = False
			WinMove($hWnd, "", $x1, $y, 1000, 500)
		EndIf
		GUICtrlSetState($n1, $GUI_HIDE)
		GUICtrlSetState($n2, $GUI_SHOW)
	Else
		GUICtrlSetState($n2, $GUI_HIDE)
		GUICtrlSetState($n1, $GUI_SHOW)
	EndIf
    Return 0
EndFunc

Func WM_SIZE($hWnd, $Msg, $wParam, $lParam)
    #forceref $Msg, $wParam
    Local $index = -1, $yChar, $xChar, $xClientMax, $xClient, $yClient, $ivMax
    For $x = 0 To UBound($__g_aSB_WindowInfo) - 1
        If $__g_aSB_WindowInfo[$x][0] = $hWnd Then
            $index = $x
            $xClientMax = $__g_aSB_WindowInfo[$index][1]
            $xChar = $__g_aSB_WindowInfo[$index][2]
            $yChar = $__g_aSB_WindowInfo[$index][3]
            $ivMax = $__g_aSB_WindowInfo[$index][7]
            ExitLoop
        EndIf
    Next
    If $index = -1 Then Return 0

    Local $tSCROLLINFO = DllStructCreate($tagSCROLLINFO)

   ; Retrieve the dimensions of the client area.
    $xClient = BitAND($lParam, 0x0000FFFF)
    $yClient = BitShift($lParam, 16)
    $__g_aSB_WindowInfo[$index][4] = $xClient
    $__g_aSB_WindowInfo[$index][5] = $yClient

   ; Set the vertical scrolling range and page size
    DllStructSetData($tSCROLLINFO, "fMask", BitOR($SIF_RANGE, $SIF_PAGE))
    DllStructSetData($tSCROLLINFO, "nMin", 0)
    DllStructSetData($tSCROLLINFO, "nMax", $ivMax)
    DllStructSetData($tSCROLLINFO, "nPage", $yClient / $yChar)
    _GUIScrollBars_SetScrollInfo($hWnd, $SB_VERT, $tSCROLLINFO)

;~    ; Set the horizontal scrolling range and page size
;~     DllStructSetData($tSCROLLINFO, "fMask", BitOR($SIF_RANGE, $SIF_PAGE))
;~     DllStructSetData($tSCROLLINFO, "nMin", 0)
;~     DllStructSetData($tSCROLLINFO, "nMax", 2 + $xClientMax / $xChar)
;~     DllStructSetData($tSCROLLINFO, "nPage", $xClient / $xChar)
;~     _GUIScrollBars_SetScrollInfo($hWnd, $SB_HORZ, $tSCROLLINFO)

    Return $GUI_RUNDEFMSG
EndFunc  ;==>WM_SIZE
