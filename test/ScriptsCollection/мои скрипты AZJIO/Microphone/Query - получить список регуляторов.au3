#include "SoundGetSetQuery.au3"
#include <Array.au3>
$a=_SoundQuery1()
_ArrayDisplay( $a, "���������� � ����������� � �������" )

Func _SoundQuery1()
	SplashTextOn("�������", "����� �������� ���������� ������� �������...", 400, 50, -1, -1, 48)
	
	 Dim $aM[1][5]
	$st=0
	
	; ���� ������ ������������ �����������.
	Local $iMixer = 0
	While True
		_SoundGet($iMixer, "dSpeakers", 1, "Volume")
		If @error = 5 Then ExitLoop ; ������ ����������� �� ����������. ����� ������ ������ ��������� ��� ��������� ����������.

		; ��������� ��� � ������� ����������.
		Local $iComponentType = 0
		While $iComponentType < UBound($asComponentTypes)
			_SoundGet($iMixer, $asComponentTypes[$iComponentType], 1, "Volume")
			If @error = 6 Then
				; ���� ��� ���������� �� ���������� � ������ ����������.
				; ������� � ����� ��������, ����� ���������� �� ��������� ������������ ���.
				$iComponentType +=1
				ContinueLoop
			EndIf

			; ��������� instance � ������� ����.
			Local $iComponentInstance = 1
			While True
				_SoundGet($iMixer, $asComponentTypes[$iComponentType], $iComponentInstance, "Volume")
				If @error = 7 Then ExitLoop ; ��� ����� instances � ���� ���� ����������.

				; �������� ������� �������� ������� ������������ ����, ������� ���������� � ������ ������ ����� ����������.
				Local $iControlType = 0
				While $iControlType < UBound($asControlTypes)
					Local $iCurValue = _SoundGet($iMixer, $asComponentTypes[$iComponentType], $iComponentInstance, $asControlTypes[$iControlType])
					If @error Then
						$iControlType +=1
						ContinueLoop
					Else
						; $iMixer - 0,2 �����, ���.
						;asComponentTypes - sAnalog
						;iComponentInstance - ����� ���������� � ���������� 
						; asControlTypes - ��� (mute, volume) 
						; iCurValue - �������� / ���������
						$st+=1
						ReDim $aM[$st+1][5]
						$aM[$st][0]=$iMixer
						$aM[$st][1]=$asComponentTypes[$iComponentType]
						$aM[$st][2]=$iComponentInstance
						$aM[$st][3]=$asControlTypes[$iControlType]
						$aM[$st][4]=$iCurValue
					EndIf
					$iControlType +=1
				WEnd ; ��� ������� ������������ ����.

				$iComponentInstance +=1
			WEnd ; ��� ������� ���������� instance.

			$iComponentType +=1
		WEnd ; ��� ������� ���� ����������.

		$iMixer = $iMixer + 1
	WEnd ; ��� ������� ����������
	
	SplashOff()
	$aM[0][0]=$st
	Return $aM
EndFunc   ;==>_SoundQuery