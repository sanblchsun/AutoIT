
; EverNote
; http://forum.ru-board.com/topic.cgi?forum=35&topic=27438&glp

; CintaNotes - ������� ����������� ������
; http://forum.ru-board.com/topic.cgi?forum=5&topic=32648&glp

; Flashnote
; http://freealt.net/2007/11/05/flashnote-mechta-sbyilas/

; � ������ �����������
; http://forum.ru-board.com/topic.cgi?forum=5&topic=19482&glp

; ���������� ���������
; http://forum.ru-board.com/topic.cgi?forum=5&topic=29240&start=2540#3


;  @AZJIO
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>
#Include <File.au3>
#NoTrayIcon
Opt("TrayMenuMode", 1)
Global $Paused, $filetxt, $namefile, $filesize, $file ; ����������� ���������� ��� ������ ������� "proverka()"

; ������ �������� � �������
$HKSC = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey1")
$HKSE = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey2")
$HKSB = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey3")
$HKSN = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey4")
$HKSP = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey5")
$namefile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "namefile")
$filesize = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "Size")
$razdelitel = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "razdelitel")
$nCheck0 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "backup")
; ���� ������ ������� ����������, �� �������� �� ���������
If $HKSC='' Then
    $HKSC='{F9}' ;������� F9 - ���������� ���������� �����
    $HKSE='{ESC}' ;������� ESC - ����� �� ���������, ����� �������� �� Alt+ESC - "!{ESC}"
    $HKSB='^{F12}' ;Ctrl+F12 - �������� ����� ������, ����� ��������� ������ ���������.
    $HKSN='^{F11}' ;Ctrl+F11 - ������� ���� ��� ��������� ���������� �����.
    $HKSP='{PAUSE}' ;������� Pause-Breake - ���������� ������ ������� � ��������� ������� �������
    $namefile='Select' ; ��� ����� ���������� �����, ������� �� ��������� �������� �������
    $filesize='500000'
    $razdelitel='========================================' ; ������������� ����������� � ������
    $nCheck0 = 1
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey1", "REG_SZ", $HKSC)
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey2", "REG_SZ", $HKSE)
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey3", "REG_SZ", $HKSB)
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey4", "REG_SZ", $HKSN)
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey5", "REG_SZ", $HKSP)
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "namefile", "REG_SZ", $namefile)
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "Size", "REG_SZ", $filesize)
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "razdelitel", "REG_SZ", $razdelitel)
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "backup", "REG_SZ", $nCheck0)
EndIf

proverka()

; ������������ ��� ������
$aPathname = StringRegExp($filetxt, "(^.*)\.(.*)$", 3)
If $nCheck0=1 And FileExists($filetxt) Then FileCopy($filetxt, $aPathname[0]&"."&@YEAR&"."&@MON&"."&@MDAY&"."&@HOUR&"."&@MIN&"."&@SEC&'.txt')

HotKeySet($HKSP, "TogglePause")
HotKeySet($HKSC, "Copy")
HotKeySet($HKSE, "vixod")
HotKeySet($HKSB, "byfer")
HotKeySet($HKSN, "Notepad")
HotKeySet("!{F2}", "_restart") ; �� Alt+F2 ��������� ������� ���������, � ���� ����� ����� ��� � ��������������, ���� ��� ��������.

$nMain = GUICreate("��������� ���������", 282, 320, -1, -1, $WS_SIZEBOX, $WS_EX_CONTEXTHELP)
GUISetIcon('shell32.dll', -138)
GUISetBkColor (0xF9F9F9)

GUICtrlCreateGroup("��������� ������� ������", 5, 3, 270, 105)
GUICtrlCreateLabel("���������� � �����:", 15, 20, 150, 15)
GUICtrlCreateLabel("����� �� ���������:", 15, 50, 150, 15)
GUICtrlCreateLabel("�����:", 15, 80, 150, 15)

$nBtn3 = GUICtrlCreateButton ("���������", 190, 261, 80, 24)
$restart = GUICtrlCreateButton ("����������", 100, 261, 80, 24)
GUICtrlSetTip(-1, "��������� ��������� ���������"&@CRLF&"����� ����� ����� � ������� ����� �����,"&@CRLF&"���� �������� ����� ������� �����")
$readme = GUICtrlCreateButton ("Readme", 10, 261, 80, 24)

; ������������� ������� ������ ��� ������
Switch $HKSC
Case $HKSC="{F8}"
    $HKSC00 = "F8"
Case $HKSC="{F9}"
    $HKSC00 = "F9"
Case $HKSC="{F10}"
    $HKSC00 = "F10"
Case $HKSC="{F11}"
    $HKSC00 = "F11"
Case $HKSC="{F12}"
    $HKSC00 = "F12"
Case Else
    $HKSC00 = "F9"
EndSwitch
$Hotkey1 = GUICtrlCreateCombo("", 175, 17, 85)
GUICtrlSetData(-1, "F8|F9|F10|F11|F12", $HKSC00)

; ������������� ������� ������ ��� ������
Switch $HKSE
Case $HKSE="{ESC}"
    $HKSE00 = "ESC"
Case $HKSE="!{ESC}"
    $HKSE00 = "Alt+ESC"
Case $HKSE="None"
    $HKSE00 = "None"
Case Else
    $HKSE00 = "{ESC}"
EndSwitch
$Hotkey2 = GUICtrlCreateCombo("", 175, 47, 85)
GUICtrlSetData(-1, "ESC|Alt+ESC|None", $HKSE00)

; ������������� ������� ������ ��� ������
Switch $HKSP
Case $HKSP="{PAUSE}"
    $HKSP00 = "Pause-Breake"
Case $HKSP="!{F1}"
    $HKSP00 = "Alt+F1"
Case $HKSP="None"
    $HKSP00 = "None"
Case Else
    $HKSP00 = "{PAUSE}"
EndSwitch
$Hotkey5 = GUICtrlCreateCombo("", 175, 77, 85)
GUICtrlSetData(-1, "Pause-Breake|Alt+F1|None", $HKSP00)

$nCheck1 = GUICtrlCreateCheckbox("������������� ��� ������", 10, 120, 170, 15)
If $nCheck0=1 Then
	GuiCtrlSetState($nCheck1, 1)
Else
	GuiCtrlSetState($nCheck1, 4)
EndIf


GUICtrlCreateLabel("��������������, ����", 10, 160, 135, 15)
GUICtrlSetTip(-1, "��� ���������������  ����� �����"&@CRLF&"� ���������� �������� ���������")
$ARinput=GUICtrlCreateInput ($filesize, 140, 160,130,22)


GUICtrlCreateLabel("��� ����� (�������):", 10, 190, 130, 15)
GUICtrlSetTip(-1, "��������� ���������� ���������")
$fileinput=GUICtrlCreateInput ($namefile, 140, 190,130,22)

GUICtrlCreateLabel("����������� �����:", 10, 220, 130, 15)
GUICtrlSetTip(-1, "���� ����� �������� ������")
$razdelitel0=GUICtrlCreateInput ($razdelitel, 140, 220,130,22)

TraySetIcon('shell32.dll', -138)
$nSettings = TrayCreateItem("���������")
$restart1 = TrayCreateItem("����������")
$nExit = TrayCreateItem("�����")

TraySetState()
While 1
    $msg = TrayGetMsg()
    Select
        Case $msg = 0
            ContinueLoop
        Case $msg = $nSettings
            _GUI()
            ContinueLoop
        Case $msg = $restart1
            _restart()
        Case $msg = $nExit
            Exit
    EndSelect
WEnd

Func _GUI() ; ����� ���� ���������
Opt("TrayIconHide", 1) ; �������� ������ � ����
HotKeySet($HKSP) ; ��������� �����
$msg = $nMain
GUISetState()
While 1
    $msg = GUIGetMsg()
    Select
        Case $msg = $nBtn3 ; ������ "���������"
			Opt("TrayIconHide", 0)
            setting()
            GUISetState(@SW_HIDE, $nMain) ; ������ ���� ��������
            ExitLoop ; ����� �� ����� ��� ����������� ������� � ���� � ����
        Case $msg = $restart
            setting()
            _restart()
        Case $msg = $readme
            MsgBox(0, "Readme", "�������� �� ������� ������� �������� ���������� ����� � ����� ���������� �����. ����� ��������� � ���������� ������� ������ ���� ���:"&@CRLF&"Ctrl+F12 - �������� ����� ������"&@CRLF&"Ctrl+F11 - ������� ���� �����"&@CRLF&"Alt+F2 - ���������� ��������� � �������������, ���� ��������"&@CRLF&"�����, ���� �� ���������� ������� �������� �����, �� ������ ������������� �������� ������������ � ������ ����.")
        Case $msg = -3
			Opt("TrayIconHide", 0)
            GUISetState(@SW_HIDE, $nMain)
			HotKeySet($HKSP, "TogglePause")
            ExitLoop
    EndSelect
WEnd
EndFunc


While 1
    Sleep(100)
WEnd

Func Copy()
    sleep(100)
    Send("^{insert}")
    $byfer=ClipGet()
    $file=FileOpen($filetxt, 9)
    If $file = -1 Then
        MsgBox(0, "������", "���������� ������� ����.")
        Exit
    EndIf
		FileWrite($file,$byfer&@CRLF&$razdelitel&@CRLF)
    FileClose($file)
EndFunc

Func TogglePause()
    $Paused = NOT $Paused
        ;TrayTip('','����� ���������',1, 16)
        TraySetIcon('shell32.dll', -138+28)
        GUISetIcon('shell32.dll', -138+28)
        HotKeySet($HKSC)
        HotKeySet($HKSE)
        HotKeySet($HKSB)
        HotKeySet($HKSN)
    While $Paused
        Sleep(200)
    WEnd
    ;TrayTip('','�������� ��������',1, 16)
    TraySetIcon('shell32.dll', -138)
    GUISetIcon('shell32.dll', -138)
    ClipPut("")
    HotKeySet($HKSC, "Copy")
    HotKeySet($HKSE, "vixod")
    HotKeySet($HKSB, "byfer")
    HotKeySet($HKSN, "Notepad")
EndFunc

Func Notepad()
    ShellExecute($filetxt)
EndFunc

Func vixod()
    Exit 0
EndFunc

Func byfer()
    MsgBox(0,"���������� ������",ClipGet())

    ; ������� ��������� � ������� ����� ����, ��������� �� 2 ���.
    ;ToolTip(ClipGet(),10,10)
    ;Sleep(2000)
    ;ToolTip("")

    ; ������� ��������� � ����, ������������ 10 ������, ���� �� ���������.
    ;TrayTip("���������� ������", ClipGet(), 1, 1)
EndFunc

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
EndFunc

Func setting() ; ������� ���������� ��������
    HotKeySet($HKSC) ;������ ������� �������
$Hotkey01 = GUICtrlRead($Hotkey1)
; ������������� ������� ������ � ���������� �������� � ������
Switch $HKSC
Case $Hotkey01="F8"
    $HKSC = "{F8}"
Case $Hotkey01="F9"
    $HKSC = "{F9}"
Case $Hotkey01="F10"
    $HKSC = "{F10}"
Case $Hotkey01="F11"
    $HKSC = "{F11}"
Case $Hotkey01="F12"
    $HKSC = "{F12}"
Case Else
    $HKSC00 = "{F9}"
EndSwitch
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey1", "REG_SZ", $HKSC)
    HotKeySet($HKSC, "Copy") ; ��������� ����� ������� �������


    HotKeySet($HKSE) ;������ ������� �������
$Hotkey02 = GUICtrlRead($Hotkey2)
; ������������� ������� ������ � ���������� �������� � ������
Switch $HKSE
Case $Hotkey02="ESC"
    $HKSE = "{ESC}"
Case $Hotkey02="Alt+ESC"
    $HKSE = "!{ESC}"
Case $Hotkey02="None"
    $HKSE = "None"
Case Else
    $HKSE = "{ESC}"
EndSwitch
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey2", "REG_SZ", $HKSE)
    HotKeySet($HKSE, "vixod") ; ��������� ����� ������� �������


    HotKeySet($HKSP) ;������ ������� �������
$Hotkey05 = GUICtrlRead($HotKey5)
; ������������� ������� ������ � ���������� �������� � ������
Switch $HKSP
Case $Hotkey05="Pause-Breake"
    $HKSP = "{PAUSE}"
Case $Hotkey05="Alt+F1"
    $HKSP = "!{F1}"
Case $Hotkey05="None"
    $HKSP = "None"
Case Else
    $HKSP = "{PAUSE}"
EndSwitch
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "HotKey5", "REG_SZ", $HKSP)
    HotKeySet($HKSP, "TogglePause") ; ��������� ����� ������� �������

    $namefile = GUICtrlRead($fileinput)
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "namefile", "REG_SZ", $namefile)

    $razdelitel = GUICtrlRead($razdelitel0)
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "razdelitel", "REG_SZ", $razdelitel)

    $filesize = GUICtrlRead($ARinput)
    RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "Size", "REG_SZ", $filesize)

    If GUICtrlRead ($nCheck1)=1 Then
    	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "backup", "REG_SZ", "1")
    Else
    	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Quoting", "backup", "REG_SZ", "0")
    EndIf
    proverka()
EndFunc

Func proverka()
$filetxt=@ScriptDir&'\'&$namefile&'1.txt'

; �������� ����� �� ���������� �������������� �������, ���� ���������, ������� ����� ������������������ ��������� ������ (�� 200).
If FileExists($filetxt) Then
For $i=1 To 200
	If FileGetSize(@ScriptDir&'\'&$namefile&$i&'.txt')<$filesize Then
        $filetxt=@ScriptDir&'\'&$namefile&$i&'.txt'
        ExitLoop
	EndIf
Next
EndIf
; ��������>>�������� ����� ��� ��� ��������, ���� �� �������� ������ �� ������� Ctrl+F11, ��� ��������� �����
$file=FileOpen($filetxt, 9)
If $file = -1 Then
    MsgBox(0, "������", "���������� ������� ����.")
    Exit
EndIf
FileClose($file)
EndFunc