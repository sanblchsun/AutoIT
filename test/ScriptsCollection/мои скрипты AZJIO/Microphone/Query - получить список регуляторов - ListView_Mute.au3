#include "SoundGetSetQuery.au3"
#include "ListViewConstants.au3"
#include <GuiListView.au3>
; #include <Array.au3>
$aM=_SoundQuery1()
; _ArrayDisplay( $a, "Информация о регуляторах в микшере" )
	GUICreate("SoundQuery Results", 300, 550)
$hListView = GUICtrlCreateListView("MixerID|ComponentType|CompInst", 10, 10, 280, 530, $LVS_NOCOLUMNHEADER, $LVS_EX_CHECKBOXES)
GUICtrlSendMsg($hListView, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_FULLROWSELECT, $LVS_EX_FULLROWSELECT)
GUICtrlSendMsg($hListView, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_TRACKSELECT, $LVS_EX_TRACKSELECT)
	
For $i = 1 to $aM[0][0]
	$aM[$i][3]=GUICtrlCreateListViewItem($aM[$i][0] & "|" & $aM[$i][1]  & "|" & $aM[$i][2], $hListView)
	If _SoundGetDeviceMute($aM[$i][0],$aM[$i][1],$aM[$i][2])=1 Then GUICtrlSetState(-1,1)
Next

GUISetState ()
While 1
   $msg = GUIGetMsg()
For $i = 1 to $aM[0][0]
	If $msg = $aM[$i][3] Then
		If _GUICtrlListView_GetItemChecked($hListView,ControlListView("SoundQuery Results", "", "SysListView321", "GetSelected"))=1 Then
			_GUICtrlListView_SetItemChecked($hListView,ControlListView("SoundQuery Results", "", "SysListView321", "GetSelected"), False)
			_SoundSetDeviceMute($aM[$i][0],$aM[$i][1],$aM[$i][2],0)
		Else
			_GUICtrlListView_SetItemChecked($hListView,ControlListView("SoundQuery Results", "", "SysListView321", "GetSelected"), True)
			_SoundSetDeviceMute($aM[$i][0],$aM[$i][1],$aM[$i][2],1)
		EndIf
	EndIf
Next
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func _SoundSetDeviceMute($1,$2,$3,$fMute)
	Local $iRet = SoundSetGet($1, $2, $3, "Mute", True, $fMute)
	SetError(@error) 
	Return $iRet
EndFunc

Func _SoundGetDeviceMute($1,$2,$3)
	Local $iRet = SoundSetGet($1, $2, $3, "Mute", False, 0)
	SetError(@error) 
	Return $iRet
EndFunc

Func _SoundQuery1()
	SplashTextOn("Процесс", "Опрос звуковых параметров микшера системы...", 400, 50, -1, -1, 48)
	
	 Local $aM[1][5]
	$st=0
	
	; Цикл поиска существующих регуляторов.
	Local $iMixer = 0
	While True
		_SoundGet($iMixer, "dSpeakers", 1, "Volume")
		If @error = 5 Then ExitLoop ; Больше регуляторов не существует. Любая другая ошибка указывает что регулятор существует.

		; Проверить тип в текущем регуляторе.
		Local $iComponentType = 0
		While $iComponentType < UBound($asComponentTypes)
			_SoundGet($iMixer, $asComponentTypes[$iComponentType], 1, "Volume")
			If @error = 6 Then
				; Этот тип компонента не существует в данном регуляторе.
				; Начните с новой итерации, чтобы переходить на следующий компонентный тип.
				$iComponentType +=1
				ContinueLoop
			EndIf

			; Проверить instance в текущем типе.
			Local $iComponentInstance = 1
			While True
				_SoundGet($iMixer, $asComponentTypes[$iComponentType], $iComponentInstance, "Volume")
				If @error = 7 Then ExitLoop ; Нет болше instances в этом типе компонента.

				; Получите текущую величину каждого управляющего типа, который существует в данном случае этого компонента.
				Local $iControlType = 0
				While $iControlType < UBound($asControlTypes)
					If $asControlTypes[$iControlType]<>'Mute' Then
						$iControlType +=1
						ContinueLoop
					Else
						; $iMixer - 0,2 инпут, аут.
						;asComponentTypes - sAnalog
						;iComponentInstance - номер регулятора в компоненте 
						$st+=1
						ReDim $aM[$st+1][5]
						$aM[$st][0]=$iMixer
						$aM[$st][1]=$asComponentTypes[$iComponentType]
						$aM[$st][2]=$iComponentInstance
					EndIf
					$iControlType +=1
				WEnd ; Для каждого управляющего типа.

				$iComponentInstance +=1
			WEnd ; Для каждого компонента instance.

			$iComponentType +=1
		WEnd ; Для каждого типа компонента.

		$iMixer = $iMixer + 1
	WEnd ; Для каждого регулятора
	
	SplashOff()
	$aM[0][0]=$st
	Return $aM
EndFunc   ;==>_SoundQuery