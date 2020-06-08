
;получить путь ассоциированной программы. Например:
; 1. нужно ini-файл или cfg и т.д. открыть в текстовом редакторе, который ассоциирован с txt
; 2. нужно открыть каталог программы ассоциированный с указанным типом.
; Идеалный вариант - модификация trancexx - http://www.autoitscript.com/forum/topic/96988-winapi-findexecutable-replacement/page__view__findpost__p__697477

$Editor=_TypeGetPath('txt')
; $Editor=_TypeGetPath('bmp')
If @error Then $Editor=@SystemDir&'\notepad.exe'

MsgBox(0, 'Сообщение', $Editor)

Func _TypeGetPath($type)
	Local $aPath=''
	Local $typefile = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.'&$type, 'Progid')
	If @error Or  $typefile='' Then
		$typefile = RegRead('HKCR\.'&$type, '')
		If @error Then
			$aPath = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.'&$type&'\OpenWithList', 'a')
			If @error Or $aPath='' Then Return SetError(1)
		EndIf
	EndIf
	If $aPath='' Then
		Local $Open = RegRead('HKCR\' & $typefile & '\shell', '')
		If @error Or $Open='' Then $Open='open'
		$typefile = RegRead('HKCR\' & $typefile & '\shell\'&$Open&'\command', '')
		If @error Then
			$aPath = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.'&$type&'\OpenWithList', 'a')
			If @error Or $aPath='' Then
				Return SetError(1)
			Else
				$typefile=$aPath
			EndIf
		EndIf
	Else
		$typefile=$aPath
	EndIf
	Local $aPath=StringRegExp($typefile, '(?i)(^.*)(\.exe.*)$', 3)
	If @error Then Return SetError(1)
	$aPath = StringReplace($aPath[0], '"', '') & '.exe'
	Opt('ExpandEnvStrings', 1)
	If FileExists($aPath) Then
		$aPath=$aPath
		Opt('ExpandEnvStrings', 0)
		Return $aPath
	EndIf
	Opt('ExpandEnvStrings', 0)
	If FileExists(@SystemDir&'\'&$aPath) Then
		Return @SystemDir&'\'&$aPath
	ElseIf FileExists(@WindowsDir&'\'&$aPath) Then
		Return @WindowsDir&'\'&$aPath
	EndIf
	Return SetError(1)
EndFunc