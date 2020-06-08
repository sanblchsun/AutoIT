; http://www.autoitscript.com/forum/topic/100439-text-to-speech-udf/

#include <TTS.au3>

$Default = _StartTTS()
If Not IsObj($Default) Then
    MsgBox(0, 'Error', 'Failed create object')
    Exit
EndIf
_Speak($Default, 'Hello my name is Sam. I am the default voice. Here are the other voices you have to choose from.')
MsgBox(0, 'Voices installed', StringReplace(_GetVoices($Default, False), '|', @CRLF))

$aVoiceSelection = _GetVoices($Default)

$Mike = _StartTTS()
_SetVoice($Mike, 'Microsoft Mike')
If @error Then
    _Speak($Default, 'Mike is Not installed.')
    $Mike = False
EndIf

$Mary = _StartTTS()
; _SetVoice($Mary, $aVoiceSelection[1])
_SetVoice($Mary, $aVoiceSelection)
If @error Then
    _Speak($Default, 'Mary is Not installed.')
    $Mary = False
EndIf

If IsObj($Mike) Then _Speak($Mike, 'Hello my name is Mike.')
If IsObj($Mary) Then _Speak($Mary, 'Hello my name is Mary.')

_SetRate($Default, 5)
_Speak($Default, 'This is Sam talking really really fast.')
_SetRate($Default, -5)
_Speak($Default, 'This is Sam talking slow.')