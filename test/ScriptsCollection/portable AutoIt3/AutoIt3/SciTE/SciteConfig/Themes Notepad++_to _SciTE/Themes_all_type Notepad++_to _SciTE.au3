If FileExists(@ProgramFilesDir&'\Notepad++\themes') Then
	$WorkingDir=@ProgramFilesDir&'\Notepad++\themes'
Else
	$WorkingDir=@WorkingDir
EndIf

$OpenFile = FileOpenDialog('Открыть', $WorkingDir , "Themes (*.xml)")
If @error Then Exit

$file = FileOpen($OpenFile, 0)
$text1 = FileRead($file)
FileClose($file)

$aLexerType_name=StringRegExp($text1, '(?s)(?:<LexerType name=")(.*?)(?=")', 3)

$Out=''

For $i = 0 to UBound($aLexerType_name)-1

	If StringInStr('|actionscript|asp|c|cobol|cs|gui4cli|haskell|java|javascript|nfo|objc|php|postscript|powershell|scheme|searchResult|', '|'&$aLexerType_name[$i]&'|') Then ContinueLoop
	
	$text=StringRegExpReplace($text1,'(?s)(^.*)(name="'&$aLexerType_name[$i]&'".*?</LexerType)(.*)$','\2')
	If StringLen($text)>5000 Then ContinueLoop
	$aWordsStyle_name=StringRegExp($text, '(?s)(?:<WordsStyle name=")(.*?)(?=")', 3)
	$Out&=@CRLF
	
Switch $aLexerType_name[$i]
	Case 'html'
 	   $aLexerType_name[$i]='hypertext'
	Case 'autoit'
 	   $aLexerType_name[$i]='au3'
	Case 'ini'
 	   $aLexerType_name[$i]='props'
	Case 'r'
 	   $aLexerType_name[$i]='rebol'
EndSwitch

	For $d = 0 to UBound($aWordsStyle_name)-1
		Assign('_Tmp', StringRegExpReplace($text,'(?s)(.*?"'&$aWordsStyle_name[$d]&'".*?fgColor=")(\w{6})(.*)','\2'))
		Assign('id_Tmp', StringRegExpReplace($text,'(?s)(.*?"'&$aWordsStyle_name[$d]&'".*?styleID=")(\d+)(".*)','\2'))
		If StringLen(Eval('_Tmp'))>6 Then Eval('_Tmp')=0
		If StringLen(Eval('id_Tmp'))>2 Then ContinueLoop
		$Out&='style.'&$aLexerType_name[$i]&'.'&Eval('id_Tmp')&'=fore:#'&Eval('_Tmp')&@CRLF
	Next
Next

$file = FileOpen($WorkingDir&'\'&StringRegExpReplace($OpenFile, '(^.*)\\(.*)\.(.*)$', '\2')&'.txt', 2)
FileWrite($file, $Out)
FileClose($file)