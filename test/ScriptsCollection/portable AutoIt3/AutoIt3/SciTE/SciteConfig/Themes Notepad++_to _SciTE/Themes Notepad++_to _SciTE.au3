
$key=1 ; если 1, то тема копируется в папку пользователя и перезапуск скайта отобразит новую тему. Если 0 то тема создаётся в виде конфига в папке темы, который нужно переместить в папку конфигуратора тем скайта.

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
$text=StringRegExpReplace($text1,'(?s)(^.*)(e="autoit".*?</Le)(.*)$','\2')

$DEFAULT=StringRegExpReplace($text,'(?s)(.*?"DEFAULT".*?fgColor=")(\w{6})(.*)','\2')
$COMMENT_LINE=StringRegExpReplace($text,'(?s)(.*?"COMMENT LINE".*?fgColor=")(\w{6})(.*)','\2')
$COMMENT=StringRegExpReplace($text,'(?s)(.*?"COMMENT".*?fgColor=")(\w{6})(.*)','\2')
$NUMBER=StringRegExpReplace($text,'(?s)(.*?"NUMBER".*?fgColor=")(\w{6})(.*)','\2')
$FUNCTION=StringRegExpReplace($text,'(?s)(.*?"FUNCTION".*?fgColor=")(\w{6})(.*)','\2')
$INSTRUCTION_WORD=StringRegExpReplace($text,'(?s)(.*?"INSTRUCTION WORD".*?fgColor=")(\w{6})(.*)','\2')
$MACRO=StringRegExpReplace($text,'(?s)(.*?"MACRO".*?fgColor=")(\w{6})(.*)','\2')
$STRING=StringRegExpReplace($text,'(?s)(.*?"STRING".*?fgColor=")(\w{6})(.*)','\2')
$OPERATOR=StringRegExpReplace($text,'(?s)(.*?"OPERATOR".*?fgColor=")(\w{6})(.*)','\2')
$VARIABLE=StringRegExpReplace($text,'(?s)(.*?"VARIABLE".*?fgColor=")(\w{6})(.*)','\2')
$SENT=StringRegExpReplace($text,'(?s)(.*?"SENT".*?fgColor=")(\w{6})(.*)','\2')
$PREPROCESSOR=StringRegExpReplace($text,'(?s)(.*?"PREPROCESSOR".*?fgColor=")(\w{6})(.*)','\2')
$SPECIAL=StringRegExpReplace($text,'(?s)(.*?"SPECIAL".*?fgColor=")(\w{6})(.*)','\2')
$EXPAND=StringRegExpReplace($text,'(?s)(.*?"EXPAND".*?fgColor=")(\w{6})(.*)','\2')
$COMOBJ=StringRegExpReplace($text,'(?s)(.*?"COMOBJ".*?fgColor=")(\w{6})(.*)','\2')
$BG=StringRegExpReplace($text,'(?s)(.*?bgColor=")(\w{6})(.*)','\2')


If StringLen($DEFAULT)>6 Then $DEFAULT=0
If StringLen($COMMENT_LINE)>6 Then $COMMENT_LINE=0
If StringLen($COMMENT)>6 Then $COMMENT=0
If StringLen($NUMBER)>6 Then $NUMBER=0
If StringLen($FUNCTION)>6 Then $FUNCTION=0
If StringLen($INSTRUCTION_WORD)>6 Then $INSTRUCTION_WORD=0
If StringLen($MACRO)>6 Then $MACRO=0
If StringLen($STRING)>6 Then $STRING=0
If StringLen($OPERATOR)>6 Then $OPERATOR=0
If StringLen($VARIABLE)>6 Then $VARIABLE=0
If StringLen($SENT)>6 Then $SENT=0
If StringLen($PREPROCESSOR)>6 Then $PREPROCESSOR=0
If StringLen($SPECIAL)>6 Then $SPECIAL=0
If StringLen($EXPAND)>6 Then $EXPAND=0
If StringLen($COMOBJ)>6 Then $COMOBJ=0
If StringLen($BG)>6 Then $BG=0


$text=StringRegExpReplace($text1,'(?s)(^.*)(<GlobalStyles>.*?</GlobalStyles>)(.*)$','\2')

$Selected_text_colour=StringRegExpReplace($text,'(?s)(.*?"Selected text colour".*?fgColor=")(\w{6})(.*)','\2')
$Selected_text_colourBg=StringRegExpReplace($text,'(?s)(.*?"Selected text colour".*?bgColor=")(\w{6})(.*)','\2')
$Fold_marginBg=StringRegExpReplace($text,'(?s)(.*?"Fold margin".*?bgColor=")(\w{6})(.*)','\2')
$Fold_margin=StringRegExpReplace($text,'(?s)(.*?"Fold margin".*?fgColor=")(\w{6})(.*)','\2')
$Caret_colour=StringRegExpReplace($text,'(?s)(.*?"Caret colour".*?fgColor=")(\w{6})(.*)','\2')
$Line_number_margin=StringRegExpReplace($text,'(?s)(.*?"Line number margin".*?fgColor=")(\w{6})(.*)','\2')
$Line_number_marginBg=StringRegExpReplace($text,'(?s)(.*?"Line number margin".*?bgColor=")(\w{6})(.*)','\2')
$Current_line_background_colourBg=StringRegExpReplace($text,'(?s)(.*?"Current line background colour".*?bgColor=")(\w{6})(.*)','\2')
$Brace_highlight_style=StringRegExpReplace($text,'(?s)(.*?"Brace highlight style".*?fgColor=")(\w{6})(.*)','\2')
$Brace_highlight_styleBg=StringRegExpReplace($text,'(?s)(.*?"Brace highlight style".*?bgColor=")(\w{6})(.*)','\2')
$Global_overrideFN=StringRegExpReplace($text,'(?s)(.*?"Global override".*?fontName=")([0-9a-zA-Z_ ]+?)(".*)','\2')
$Global_overrideFS=StringRegExpReplace($text,'(?s)(.*?"Global override".*?fontSize=")(\d+)(".*)','\2')

If StringLen($Selected_text_colour)>6 Then $Selected_text_colour=0
If StringLen($Selected_text_colourBg)>6 Then $Selected_text_colourBg=0
If StringLen($Fold_marginBg)>6 Then $Fold_marginBg=0
If StringLen($Fold_margin)>6 Then $Fold_margin=0
If StringLen($Caret_colour)>6 Then $Caret_colour=0
If StringLen($Line_number_margin)>6 Then $Line_number_margin=0
If StringLen($Line_number_marginBg)>6 Then $Line_number_marginBg=0
If StringLen($Current_line_background_colourBg)>6 Then $Current_line_background_colourBg=0
If StringLen($Brace_highlight_style)>6 Then $Brace_highlight_style=0
If StringLen($Brace_highlight_styleBg)>6 Then $Brace_highlight_styleBg=0
If StringLen($Global_overrideFN)>30 Then $Global_overrideFN='Arial'
If StringLen($Global_overrideFS)>2 Then $Global_overrideFS=10


$text= _
'#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#' & @CRLF & _
'# START: DO NOT CHANGE ANYTHING AFTER THIS LINE     #-#-#-#-#' & @CRLF & _
'# Created by SciTEConfig' & @CRLF & _
'#------------------------------------------------------------' & @CRLF & _
'font.base=font:'&$Global_overrideFN&',size:'&$Global_overrideFS&',$(font.override)' & @CRLF & _
'font.monospace=font:'&$Global_overrideFN&',size:'&$Global_overrideFS & @CRLF & _
'proper.case=0' & @CRLF & _
'check.updates.scite4autoit3=0' & @CRLF & _
'use.tabs=1' & @CRLF & _
'indent.size=4' & @CRLF & _
'indent.size.*.au3=4' & @CRLF & _
'tabsize=4' & @CRLF & _
'#Background' & @CRLF & _
'style.au3.32=style.*.32=$(font.base),back:#'&$BG & @CRLF & _
'# Brace highlight' & @CRLF & _
'style.au3.34=fore:#'&$Brace_highlight_style&',back:#'&$Brace_highlight_styleBg&'' & @CRLF & _
'# Brace incomplete highlight' & @CRLF & _
'style.au3.35=fore:#'&$COMMENT_LINE&',italics,back:#'&$BG & @CRLF & _
@CRLF & _
'# Line Number Margin - колонка номеров строк' & @CRLF & _
'style.au3.33=fore:#'&$Line_number_margin&',back:#'&$Line_number_marginBg&',$(font.base)' & @CRLF & _
'style.au3.37=fore:#'&$Line_number_margin&',back:#'&$Line_number_marginBg&'' & @CRLF & _
'#line.margin.visible=1' & @CRLF & _
'line.margin.width=1+' & @CRLF & _
@CRLF & _
'# Колонка плюсиков для разворачивания блоков' & @CRLF & _
'fold.margin.colour=#'&$Fold_margin & @CRLF & _
'fold.margin.highlight.colour=#'&$Fold_marginBg & @CRLF & _
'#fold.compact=0' & @CRLF & _
@CRLF & _
'# Мигающий курсор' & @CRLF & _
'caret.fore=#'&$Caret_colour & @CRLF & _
'caret.line.back=#'&$Current_line_background_colourBg&'' & @CRLF & _
'#caret.width=2' & @CRLF & _
'#caret.line.back.alpha=100' & @CRLF & _
@CRLF & _
'# Выделенная область курсором' & @CRLF & _
'selection.fore=#'&$STRING & @CRLF & _
'selection.back=#'&$Selected_text_colourBg & @CRLF & _
'# selection.alpha=75' & @CRLF & _
@CRLF & _
'# Вертикальная линия справа, edge.mode=0 убирает эту линию, edge.column - отступ слева до линии' & @CRLF & _
'edge.colour=#'&$Line_number_margin & @CRLF & _
'edge.mode=0' & @CRLF & _
'#edge.column=500' & @CRLF & _
@CRLF & _
'#Console - запись в консоль при выполнении скрипта по F5' & @CRLF & _
'style.errorlist.32=back:#'&$BG&',$(font.monospace)' & @CRLF & _
'style.errorlist.0=fore:#'&$STRING & @CRLF & _
'style.errorlist.5=fore:#000000' & @CRLF & _
'style.errorlist.3=fore:#'&$OPERATOR & @CRLF & _
'style.errorlist.4=fore:#'&$FUNCTION & @CRLF & _
'style.errorlist.11=fore:#'&$COMMENT & @CRLF & _
'style.errorlist.12=fore:#'&$SENT & @CRLF & _
'error.marker.fore=fore:#ff0000,italics,back:#'&$BG & @CRLF & _
'colour.error=fore:#ff0000,back:#'&$OPERATOR

$text&= @CRLF & _
'#White space' & @CRLF & _
'style.au3.0=fore:#'&$DEFAULT&',back:#'&$BG & @CRLF & _
'#Comment line' & @CRLF & _
'style.au3.1=fore:#'&$COMMENT_LINE&',italics,back:#'&$BG & @CRLF & _
'#Comment block' & @CRLF & _
'style.au3.2=fore:#'&$COMMENT&',italics,back:#'&$BG & @CRLF & _
'#Number' & @CRLF & _
'style.au3.3=fore:#'&$NUMBER&',back:#'&$BG & @CRLF & _
'#Function' & @CRLF & _
'style.au3.4=fore:#'&$FUNCTION&',back:#'&$BG & @CRLF & _
'#Keyword' & @CRLF & _
'style.au3.5=fore:#'&$INSTRUCTION_WORD&',back:#'&$BG & @CRLF & _
'#Macro' & @CRLF & _
'style.au3.6=fore:#'&$MACRO&',back:#'&$BG & @CRLF & _
'#String' & @CRLF & _
'style.au3.7=fore:#'&$STRING&',back:#'&$BG & @CRLF & _
'#Operator' & @CRLF & _
'style.au3.8=fore:#'&$OPERATOR&',back:#'&$BG & @CRLF & _
'#Variable' & @CRLF & _
'style.au3.9=fore:#'&$VARIABLE&',back:#'&$BG & @CRLF & _
'#Sent keys' & @CRLF & _
'style.au3.10=fore:#'&$SENT&',bold,back:#'&$BG & @CRLF & _
'#Pre-Processor' & @CRLF & _
'style.au3.11=fore:#'&$PREPROCESSOR&',back:#'&$BG & @CRLF & _
'#Special' & @CRLF & _
'style.au3.12=fore:#'&$SPECIAL&',back:#'&$BG & @CRLF & _
'#Abbrev-Expand' & @CRLF & _
'style.au3.13=fore:#'&$EXPAND&',bold,back:#'&$BG & @CRLF & _
'#Com Objects' & @CRLF & _
'style.au3.14=fore:#'&$COMOBJ&',bold,back:#'&$BG & @CRLF & _
'#Standard UDF''s' & @CRLF & _
'style.au3.15=fore:#'&$DEFAULT&',back:#'&$BG

If $key Then
	$file = FileOpen(@UserProfileDir&'\SciTEUser.properties', 2)
	FileWrite($file, $text)
	FileClose($file)
Else
	$file = FileOpen($WorkingDir&'\'&StringRegExpReplace($OpenFile, '(^.*)\\(.*)\.(.*)$', '\2')&'.SciTEConfig', 2)
	FileWrite($file, $text)
	FileClose($file)
EndIf