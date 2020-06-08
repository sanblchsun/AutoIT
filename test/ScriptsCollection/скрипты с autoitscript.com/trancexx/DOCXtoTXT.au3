Dim $file = FileOpenDialog("Choose .docx file", @DesktopDir, "Word docX file (*.docx)", 1)
If @error Then Exit

Dim $TxT = _ReadDocXContent($file)

MsgBox(0, "Extracted text", $TxT)



Func _ReadDocXContent($ReadLocation)

    Local $extension = StringSplit($ReadLocation, ".", 1)
    $extension = $extension[$extension[0]]
    
    Local $hwnd = FileOpen($ReadLocation, 16)
    Local $header = FileRead($hwnd, 2)
    FileClose($hwnd)
    
    If $header <> '0x504B' Or $extension <> 'docx' Then Return SetError(1) ; not .docx file
    
    Local $Name, $UnZipName, $TempZipName

    Local $i, $f_name = "~TempDoc"
    Do
        $i += 1
        $Name = @TempDir & "\" & $f_name & $i & ".zip"
    Until Not FileExists($Name)

    FileCopy($ReadLocation, $Name, 9)

    Local $j
    Do
        $j += 1
        $UnZipName = @TempDir & "\~DocXdoc" & $j
    Until Not FileExists($UnZipName)

    DirCreate($UnZipName)

    Local $k
    Do
        $k += 1
        $TempZipName = @TempDir & "\Temporary Directory " & $k & " for " & $f_name & $i & ".zip"
    Until Not FileExists($TempZipName)

    Local $oApp = ObjCreate("Shell.Application")
    
    If Not IsObj($oApp) Then Return SetError(2) ; highly unlikely but could happen
    
    $oApp.NameSpace($UnZipName).CopyHere($oApp.NameSpace($Name & '\word' ).ParseName("document.xml"), 4)

    Local $Text = FileRead($UnZipName & "\document.xml")

    DirRemove($UnZipName, 1)
    FileDelete($Name)
    DirRemove($TempZipName, 1)

    $Text = StringReplace($Text, @CRLF, "")
    $Text = StringRegExpReplace($Text, "<w:body>(.*?)</w:body>", '$1', 0)
    $Text = StringReplace($Text, "</w:p>", @CRLF)
    $Text = StringReplace($Text, "<w:cr/>", @CRLF)
    $Text = StringReplace($Text, "<w:br/>", @CRLF)
    $Text = StringReplace($Text, "<w:tab/>", @TAB)

    $Text = StringRegExpReplace($Text, "<(.*?)>", "")
    
    $Text = StringReplace($Text, "&lt;", "<")
    $Text = StringReplace($Text, "&gt;", ">")
    $Text = StringReplace($Text, "&amp;", "&")

    $Text = StringReplace($Text, Chr(226) & Chr(130) & Chr(172), Chr(128))
    $Text = StringReplace($Text, Chr(194) & Chr(129), Chr(129))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(154), Chr(130))
    $Text = StringReplace($Text, Chr(198) & Chr(146), Chr(131))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(158), Chr(132))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(166), Chr(133))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(160), Chr(134))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(161), Chr(135))
    $Text = StringReplace($Text, Chr(203) & Chr(134), Chr(136))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(176), Chr(137))
    $Text = StringReplace($Text, Chr(197) & Chr(160), Chr(138))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(185), Chr(139))
    $Text = StringReplace($Text, Chr(197) & Chr(146), Chr(140))
    $Text = StringReplace($Text, Chr(194) & Chr(141), Chr(141))
    $Text = StringReplace($Text, Chr(197) & Chr(189), Chr(142))
    $Text = StringReplace($Text, Chr(194) & Chr(143), Chr(143))
    $Text = StringReplace($Text, Chr(194) & Chr(144), Chr(144))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(152), Chr(145))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(153), Chr(146))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(156), Chr(147))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(157), Chr(148))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(162), Chr(149))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(147), Chr(150))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(148), Chr(151))
    $Text = StringReplace($Text, Chr(203) & Chr(156), Chr(152))
    $Text = StringReplace($Text, Chr(226) & Chr(132) & Chr(162), Chr(153))
    $Text = StringReplace($Text, Chr(197) & Chr(161), Chr(154))
    $Text = StringReplace($Text, Chr(226) & Chr(128) & Chr(186), Chr(155))
    $Text = StringReplace($Text, Chr(197) & Chr(147), Chr(156))
    $Text = StringReplace($Text, Chr(194) & Chr(157), Chr(157))
    $Text = StringReplace($Text, Chr(197) & Chr(190), Chr(158))
    $Text = StringReplace($Text, Chr(197) & Chr(184), Chr(159))

    For $x = 160 To 191
        $Text = StringReplace($Text, Chr(194) & Chr($x), Chr($x))
    Next

    For $x = 192 To 255
        $Text = StringReplace($Text, Chr(195) & Chr($x - 64), Chr($x))
    Next

    Return $Text

EndFunc