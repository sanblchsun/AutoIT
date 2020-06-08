#include "SoundGetSetQuery.au3"
#include <Array.au3>
$a=_SoundQuery1()
_ArrayDisplay( $a, "Информация о регуляторах в микшере" )

Func _SoundQuery1()
	SplashTextOn("Процесс", "Опрос звуковых параметров микшера системы...", 400, 50, -1, -1, 48)
	
	 Dim $aM[1][5]
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
					Local $iCurValue = _SoundGet($iMixer, $asComponentTypes[$iComponentType], $iComponentInstance, $asControlTypes[$iControlType])
					If @error Then
						$iControlType +=1
						ContinueLoop
					Else
						; $iMixer - 0,2 инпут, аут.
						;asComponentTypes - sAnalog
						;iComponentInstance - номер регулятора в компоненте 
						; asControlTypes - тип (mute, volume) 
						; iCurValue - величина / состояние
						$st+=1
						ReDim $aM[$st+1][5]
						$aM[$st][0]=$iMixer
						$aM[$st][1]=$asComponentTypes[$iComponentType]
						$aM[$st][2]=$iComponentInstance
						$aM[$st][3]=$asControlTypes[$iControlType]
						$aM[$st][4]=$iCurValue
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