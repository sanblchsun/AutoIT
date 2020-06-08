; ---------------------------------------------------
; AutoIt Version: 3.3.0.0
; Author: ynbIpb
; Script name: RarJpeg v.0.1
; Script Function: ��������� ��� �������� �����������
; ��� ����� ���������: http://lurkmore.ru/Rarjpeg
; ----------------------------------------------------
#NoTrayIcon
#include <GUIConstants.au3>
#include <EditConstants.au3> ; ��� ����� $ES_READONLY �������� Input
#include <StaticConstants.au3>; ��� ����� $SS_CENTER �������� Label
; ��������� ����������
$JpgFile = ""
$RarFile = ""
; ������ ���
$Form1 = GUICreate("RarJpeg", 152, 100)
; Input �� ������: ������ ��� ������, ��������� �� ������ ����, �������������
$Input1 = GUICtrlCreateInput("", 4, 4, 121, 21, BitOR($ES_READONLY, $ES_LEFT, $ES_AUTOHSCROLL))
$Input2 = GUICtrlCreateInput("", 4, 30, 121, 21, BitOR($ES_READONLY, $ES_LEFT, $ES_AUTOHSCROLL))
$Button1 = GUICtrlCreateButton("...", 128, 4, 21, 21, 0)
$Button2 = GUICtrlCreateButton("...", 128, 30, 21, 21, 0)
$Button3 = GUICtrlCreateButton("��������� �����", 4, 55, 145, 21, 0)
; Label �� ������: ��������� �� ������
$Label1 = GUICtrlCreateLabel("�������� �����...", 4, 80, 144, 15, $SS_CENTER)
$Progress1 = GUICtrlCreateProgress(4, 80, 144, 15)
GUICtrlSetState($Progress1, $GUI_HIDE); Progress ���� ��������.
GUISetState(@SW_SHOW)

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $Button1
            $JpgFile = FileOpenDialog("�������� jpg ����..", @ScriptDir, "Images (*.jpg;*.jpeg)", 1)
            ; �������� �� ���� ��� �����
            $JpgName = StringMid($JpgFile, StringInStr($JpgFile, "\", 0, -1) + 1)
            ; � ������� ��� � Input
            GUICtrlSetData($Input1, $JpgName)
        Case $Button2
            $RarFile = FileOpenDialog("�������� rar ����..", @ScriptDir, "Arhives (*.rar)", 1)
            $RarName = StringMid($RarFile, StringInStr($RarFile, "\", 0, -1) + 1)
            GUICtrlSetData($Input2, $RarName)
        Case $Button3
            joinfiles() ; �������� ������ ���������� ������
    EndSwitch
WEnd

; ���� �� ���������� �������� ���� �����, ���� ������� ���������� ������� � �������
Func joinfiles()
    If $JpgFile = "" Then ; ���� �� ������ 1 ����: ������� ������ � ����������c� �� �������
        GUICtrlSetData($Label1, "������: ��� *.jpg �����!")
        Return
    EndIf
    If $RarFile = "" Then ; ���� �� ������ 2 ����: ������� ������ � ����������c� �� �������
        GUICtrlSetData($Label1, "������: ��� *.rar �����!")
        Return
    EndIf
    GUICtrlSetState($Label1, $GUI_HIDE); ������ �������� Label, ���� �� ����� Progress'�
    GUICtrlSetState($Progress1, $GUI_SHOW); ���������� Progress
    ; jpg ���� �������� �����, ��� ��� �� ��� � ������ ���� �������
    FileCopy($JpgFile, @ScriptDir & "\Rarjpeg_" & $RarName & ".jpg")
    $orig_files_size = FileGetSize($JpgFile)
    $orig_files_size += FileGetSize($RarFile); ������� ��������� ������ �������� ������
    $file2 = FileOpen($RarFile, 16); ��������� rar � �������� ������ ��� ������
    ; �������� ���� ��������� � �������� ������ �� ������ ������ � ����� �����
    $file3 = FileOpen(@ScriptDir & "\Rarjpeg_" & $RarName & ".jpg", 17)
    While 1 ; ���� ������\������ �������� ����� �� ������
        $Buf = FileRead($file2, 1024 * 1024) ; �� 1 Mb � �����
        If @error = -1 Then ExitLoop
        FileWrite($file3, $Buf)
        ; ��������� ������ ��������� ����� � ����������� ������� ��� Progress'�
        $new_file_size = FileGetSize(@ScriptDir & "\Rarjpeg_" & $RarName & ".jpg")
        $Percent = $new_file_size * 100 / $orig_files_size
        $Percent = Ceiling($Percent)
        GUICtrlSetData($Progress1, $Percent)
    WEnd
    FileClose($file2)
    FileClose($file3)
    GUICtrlSetState($Progress1, $GUI_HIDE)
    GUICtrlSetData($Label1, "������!")
    GUICtrlSetState($Label1, $GUI_SHOW)
EndFunc
 