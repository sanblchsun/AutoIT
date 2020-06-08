;клавиши (разрешенные клавиши: 1,2,3,4,5,6,7,8,9,0,~,Ё - знак ударения)
$vrtkey='1,2,3'
;модификаторы клавиш (разрешены: '05' - Ctrl; '06' - Alt)
$keymod='05,05,06'
;коды языков (можете посмотреть в разделе "Appendix" руководства по AutoIt или в вышеприведенном примере)
$lang='0409,0419,0422'
;включаем возможность раздельного переключения языков (англ. - Ctrl+Shift+1; рус. - Ctrl+Shift+2; укр. - Alt+Shift+3)
_EnableLangSwitching($vrtkey,$keymod,$lang)
;----- пример кода -----
Run("notepad.exe")
Sleep(500)
;переключение на англ.
Send('^+1')
Send('Hello, World'&@LF)
;переключение на рус.
Send('^+2')
Send('Привет, Мир'&@LF)
;переключение на укр.
Send('!+3')
Send('Привўт, Свўте'&@LF)
;переключение на англ.
Send('^+1')
Send('Hello, New World'&@LF)
;------------------

;отключение возможности раздельного переключения языков (удаление из реестра внесенных туда веток);в кач-ве аргумента укажите к-во языков, заданное выше в переменной $lang (для данного примера. - 3)
_DisableLangSwitching(3)

Func _EnableLangSwitching($key,$mod,$lng)
$constpart="HKEY_CURRENT_USER\Control Panel\Input Method\Hot Keys\000001"
$akey=StringSplit($key,',',1)
$amod=StringSplit($mod,',',1)
$alng=StringSplit($lng,',',1)
If UBound($akey,1)=UBound($amod,1) and UBound($akey,1)=UBound($alng,1) Then
        For $i=1 To UBound($alng,1)-1
                RunWait('REG ADD "' & $constpart & StringFormat('%02s"',$i-1) & ' /v "Virtual Key" /t REG_BINARY /d ' & Hex(Asc($akey[$i]),2) & '000000 /f','',@SW_HIDE)
                RunWait('REG ADD "' & $constpart & StringFormat('%02s"',$i-1) & ' /v "Key Modifiers" /t REG_BINARY /d ' & $amod[$i] & 'c00000 /f','',@SW_HIDE)
                RunWait('REG ADD "' & $constpart & StringFormat('%02s"',$i-1) & ' /v "Target IME" /t REG_BINARY /d ' & StringRight($alng[$i],2)&StringLeft($alng[$i],2)&StringRight($alng[$i],2)&StringLeft($alng[$i],2) & ' /f','',@SW_HIDE)
        Next
        SetError(0)
        Return(1)
Else
        SetError(1)
        Return(0)
EndIf
EndFunc

Func _DisableLangSwitching($count)
$constpart="HKEY_CURRENT_USER\Control Panel\Input Method\Hot Keys\000001"
For $i=0 To $count-1
        RunWait('REG DELETE "' & $constpart & StringFormat('%02s"',$i) & ' /f','',@SW_HIDE)
Next
EndFunc