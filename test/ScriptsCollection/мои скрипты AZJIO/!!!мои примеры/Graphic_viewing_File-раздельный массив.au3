; ������� ���������� �������������

#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
Global $Stack[50], $Stack1[50], $a[600], $BL, $List='', $k ;, $a1[600][2]

GUICreate("����������� �������� ��������", 380, 410, -1, -1, -1, 0x00000010)
$StatusBar = GUICtrlCreateLabel('������ ���������            AZJIO 2010.06.16', 5, 415 - 20, 370, 15, $SS_LEFTNOWORDWRAP)
$CatchDrop = GUICtrlCreateLabel("    ���� ���� �������", 0, 0, 380, 17, $SS_SUNKEN)
GUICtrlSetState(-1, 8)
$CatchDrop1 = GUICtrlCreateLabel("", 0, 20, 380, 360)
GUICtrlSetState(-1, 136)
$BL=GUICtrlCreateButton ("L", 360 ,24,18,18)
GUICtrlSetTip(-1, '������ ������')
$RE=GUICtrlCreateButton ("R", 340 ,24,18,18)
GUICtrlSetTip(-1, '���������� �������')

GUISetState()

While 1
    $msg = GUIGetMsg()
    Select
        Case $msg = -13
            If StringInStr(FileGetAttrib(@GUI_DragFile), "D") = 0 Then
                MsgBox(0, "������ ������", '�������������� �������, � �� ����.')
                ContinueLoop
            Else
                GUICtrlDelete($CatchDrop1)
                ;GUICtrlDelete($BL)
				For $i = 1 to $k+1
					GUICtrlDelete($a[$i])
				Next
                GUICtrlDelete($a)
                _Create()
            EndIf
			If $k = 0 Then
				$CatchDrop1 = GUICtrlCreateLabel("", 0, 20, 380, 360)
				GUICtrlSetState(-1, 136)
            EndIf
        Case $msg = $RE
            _restart()
        Case $msg = $BL
			If $k <50 Then
				MsgBox(0, '������ ������', $List)
			Else
				If MsgBox(4, '������ ������', '������� �����, ����� 50,'&@CRLF&' ������ ��������� ������ � �����?')=6 Then ClipPut($List)
			EndIf
            
        Case $msg = -3
            Exit
    EndSelect
WEnd

Func _Create()
    GUICtrlSetData($CatchDrop, @GUI_DragFile)
    FileFindNextFirst(@GUI_DragFile)
    $SizeTot=DirGetSize(@GUI_DragFile,2) ; ������ ��������, ������� ������ ������� ������
    $SizeMin = $SizeTot / 360  ; ���������� ����������� ������ ������������� �����, �� ������ �������, ���������� ���� ������������ �� ���� ������
	$Zdiff=0
	
    ;�������� �������
    $nach = 0
    $List=''
	$k=0
	$kT=0
	$SizeTmp0=0
	;$SizeTotal=0
	
    While 1
        $tempname = FileFindNext('', 0, 1)
        If $tempname = "" Then ExitLoop
        $List&=StringRegExpReplace($tempname, '(^.*)\\(.*)$', '\2')&@CRLF
        $SizeTmp= FileGetSize($tempname)
		$kT+=1
		;$SizeTotal+=$SizeTmp
        If $SizeTmp<$SizeMin Then
			$SizeTmp0+=$SizeTmp
			ContinueLoop
		EndIf
		$Zdiff+=Mod($SizeTmp,$SizeMin) ; ���������� ������� �� ������� � ����� �����
		If $Zdiff/$SizeMin >= 1 Then
			$Zdiff-=$SizeMin
			$SizeTmp+=$SizeMin
		EndIf
		
        $grad=Int($SizeTmp/$SizeMin) ; ������ ����� � ��������, ���� ����� (������ �������)

		$k+=1
		$a[$k] = GUICtrlCreateGraphic(10, 20, 360, 360)
        GUICtrlSetGraphic($a[$k], $GUI_GR_COLOR, 0, Dec(Random(50, 99, 1) & Random(50, 99, 1) & Random(50, 99, 1))) ; ���� �������, ���������
        GUICtrlSetGraphic($a[$k], $GUI_GR_PIE, 180, 180, 180, $nach, $grad) ; �������� �������
        GUICtrlSetState(-1, 8)
		; $a1[$k][0] = GUICtrlCreateContextMenu($a[$k])
		; $a1[$k][1] = GUICtrlCreateMenuitem($tempname,$a1[$k][0])


		;MsgBox(0, '���', $nach&' ������ �������' &@CRLF& $grad& ' - ������ �������')
		 ; ������� ������� ������ ��� ������
        ; If $k<7 Then
            ; GUICtrlCreateLabel($k, (90+$k*14)*cos($nach)+190, (90+$k*14)*sin($nach)+200, 10, 14)
            ; GUICtrlSetTip(-1, $tempname)
        ; EndIf
        $nach += $grad ; ��������� ���� ������� (��������, �����)
    WEnd
		If $k = 0 Then Return $k
		
		
		; ����� �������, ������ ���� ������ �� ��������� ������ ���� � �������� ���������, ��� ��� �� ����� �������.
		$grad=Int($SizeTmp0/$SizeMin)
		$k+=1
		If $nach+$grad >= 359 Then $grad+=360-$nach-$grad
		$a[$k] = GUICtrlCreateGraphic(10, 20, 360, 360)
        GUICtrlSetGraphic($a[$k], $GUI_GR_COLOR, 0, 0xe9de12) ; ���� �������, �����
        GUICtrlSetGraphic($a[$k], $GUI_GR_PIE, 180, 180, 180, $nach, $grad) ; �������� �������
        GUICtrlSetState(-1, 8)
		;$nach += $grad
		
		;���� �� ������
		$a[$k+1] = GUICtrlCreateGraphic(10, 20, 360, 360)
        ;GUICtrlSetGraphic($a[$k+1], $GUI_GR_COLOR, 0, Dec(Random(50, 99, 1) & Random(50, 99, 1) & Random(50, 99, 1))) ; ���� �������, ���������
        GUICtrlSetGraphic($a[$k+1], $GUI_GR_COLOR, 0, 0xe0dfe3)
		GUICtrlSetGraphic($a[$k+1], $GUI_GR_ELLIPSE, 135, 135, 90, 90)
		GUICtrlSetGraphic($a[$k+1], $GUI_GR_REFRESH)
	
	
		;MsgBox(0, '���������', $nach)
	;MsgBox(0, '���', $SizeTot&' ������ � ������' &@CRLF& $SizeTot/1024/1024& ' - ������ � ����������'&@CRLF& $SizeTotal& ' - ������ � ������ �� ������'&@CRLF& $SizeTotal/1024/1024& ' - ������ � ���������� �� ������')
    GUICtrlSetData($StatusBar, '������ ' & Round($SizeTot / 1024 / 1024,1) & ' ��    ����� ' & $kT & '     ���� ' & @GUI_DragFile)
    If $k <50 Then
		GUICtrlSetTip($CatchDrop,$List)
	Else
		GUICtrlSetTip($CatchDrop,'������� ����� ������, ����� 50')
	EndIf
EndFunc   ;==>_Create


;========================================
; ������� ������ ���� ������ � �������� (NIKZZZZ+���_AZJIO)

Func FileFindNextFirst($FindCat)
    $Stack[0] = 1
    $Stack1[1] = $FindCat
    $Stack[1] = FileFindFirstFile($FindCat & "\*.*")
    Return $Stack[1]
EndFunc   ;==>FileFindNextFirst

Func FileFindNext($type = 'log', $mode = 0, $Level = 49)
    While 1
        $file = FileFindNextFile($Stack[$Stack[0]])
        If @error Then
            FileClose($Stack[$Stack[0]])
            If $Stack[0] = 1 Then
                Return ""
            Else
                $Stack[0] -= 1
                ContinueLoop
            EndIf
        Else
            If StringInStr(FileGetAttrib($Stack1[$Stack[0]] & "\" & $file), "D") > 0 Then
                If $Stack[0] = $Level Then ContinueLoop
                $Stack[0] += 1
                $Stack1[$Stack[0]] = $Stack1[$Stack[0] - 1] & "\" & $file
                $Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*")
                If $mode = 2 Then
                    Return $Stack1[$Stack[0]]
                Else
                    ContinueLoop
                EndIf
            Else
                If $mode = 2 Then ContinueLoop
                If $mode = 1 Then
                    If StringInStr(';' & $type & ';', ';' & StringRight($Stack1[$Stack[0]] & "\" & $file, 3) & ';') = 0 Then
                        ContinueLoop
                    Else
                        Return $Stack1[$Stack[0]] & "\" & $file
                    EndIf
                Else
                    Return $Stack1[$Stack[0]] & "\" & $file
                EndIf
            EndIf
        EndIf
    WEnd
EndFunc   ;==>FileFindNext


Func _restart()
	Local $sAutoIt_File = @TempDir & "\~Au3_ScriptRestart_TempFile.au3"
	Local $sRunLine, $sScript_Content, $hFile

	$sRunLine = @ScriptFullPath
	If Not @Compiled Then $sRunLine = @AutoItExe & ' /AutoIt3ExecuteScript ""' & $sRunLine & '""'
	If $CmdLine[0] > 0 Then $sRunLine &= ' ' & $CmdLineRaw

	$sScript_Content &= '#NoTrayIcon' & @CRLF & _
			'While ProcessExists(' & @AutoItPID & ')' & @CRLF & _
			'   Sleep(10)' & @CRLF & _
			'WEnd' & @CRLF & _
			'Run("' & $sRunLine & '")' & @CRLF & _
			'FileDelete(@ScriptFullPath)' & @CRLF

	$hFile = FileOpen($sAutoIt_File, 2)
	FileWrite($hFile, $sScript_Content)
	FileClose($hFile)

	Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sAutoIt_File & '"', @ScriptDir, @SW_HIDE)
	Sleep(1000)
	Exit
EndFunc   ;==>_restart