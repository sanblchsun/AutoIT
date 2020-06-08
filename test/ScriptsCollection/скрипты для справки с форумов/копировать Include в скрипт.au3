 
_AU3_MergeAllLibs(@ScriptDir & "\Test.au3") 
 
; =============================================================== 
; _AU3_MergeAllLibs($sScriptFile, $iIncludeComments=0, $iRemoveIncludes=1) 
; --------------------------------------------------------------- 
; ��������� ��������� ���������� � ���� ������� 
;  (����� ������� �������������� ���� ������� ������ �� ����� ��������� � �����������) 
; ����������� AutoIT v3.2.12.1 
; 
; $sScriptFile       : AutoIT-������ ��� ���������� 
; $iIncludeComments  : ����������, ����� �� ������������ ������ ������������ 
; $iRemoveIncludes   : ����������, ����� �� ������� ������ #include'�� � ��������� ������� 
; 
; �����              : G.Sandler (a.k.a CreatoR) 
; =============================================================== 
Func _AU3_MergeAllLibs($sScriptFile, $iIncludeComments=0, $iRemoveIncludes=1) 
    Local $aGetAllLibs, $aScript_Content, $sRead_SrcScript, $sHeader_Content, $hFOpen, $iIsFuncBody = 0 
    $sRead_SrcScript = FileRead($sScriptFile) 
 
    _AU3_GetAllLibUDF($sRead_SrcScript, $aGetAllLibs) 
 
    If $iRemoveIncludes Then $sRead_SrcScript = StringRegExpReplace($sRead_SrcScript, "(?i)(?s)#include.*?[\r\n]+", "") 
 
    For $i = 1 To $aGetAllLibs[0][0] 
        $iIsFuncBody = 0 
        $aScript_Content = StringSplit(StringStripCR(StringStripWS(FileRead($aGetAllLibs[$i][1]), 3)), @LF) 
 
        For $j = 1 To $aScript_Content[0] 
            If $aScript_Content[$j] = "" Then ContinueLoop ;We don't need the empty lines, right? 
 
            If StringLeft($aScript_Content[$j], 8) = "#include" Then ContinueLoop ;We don't need the #includes, right? 
            If Not $iIncludeComments And StringLeft($aScript_Content[$j], 1) = ";" Then ContinueLoop 
 
            If StringLeft($aScript_Content[$j], 4) = "Func" Then 
                $sRead_SrcScript &= @CRLF 
                $iIsFuncBody = 1 
            ElseIf StringLeft($aScript_Content[$j], 7) = "EndFunc" Then 
                $sRead_SrcScript &= $aScript_Content[$j] & @CRLF 
                $iIsFuncBody = 0 
 
                ContinueLoop 
            EndIf 
 
            If Not $iIsFuncBody Then ;Write to the Begining of file (Collecting the variables/constants Header) 
                $sHeader_Content &= $aScript_Content[$j] & @CRLF 
            Else ;Write to the End of file (UDF functions) 
                $sRead_SrcScript &= $aScript_Content[$j] & @CRLF 
            EndIf 
        Next 
    Next 
 
    If $sHeader_Content <> "" Then $sRead_SrcScript = $sHeader_Content & @CRLF & $sRead_SrcScript 
 
    $hFOpen = FileOpen($sScriptFile, 2) 
    FileWrite($hFOpen, $sRead_SrcScript) 
    FileClose($hFOpen) 
EndFunc ; ==> _AU3_MergeAllLibs 
 
; =============================================================== 
; _AU3_GetAllLibUDF($sScript_Content, $aIncludes_Arr) 
; --------------------------------------------------------------- 
; ���������� ������ ���� ����������� UDF � ������������ ������ 
; ����������� AutoIT v3.2.12.0 
; 
; $sScript_Content       : ����� AutoIT-������� 
; $aIncludes_Arr         : ������ �� ���������� ��� ��������� �������, 
;                 �� ������ �������� ��������� ������: 
;                   $aIncludes_Arr[0][0]  - ���������� ��������� � ������� 
;                   $aIncludes_Arr[$i][0] - ��� ������������� ����� 
;                   $aIncludes_Arr[$i][1] - ������ ���� ������������� ����� 
;                   $aIncludes_Arr[$i][2] - ������ UDF, ������������ � ����� 
; 
; ������� �����������, ������� ����� �� ������ �� ������������ 
; 
; �����                  : amel27 
; =============================================================== 
Func _AU3_GetAllLibUDF($sScript_Content, ByRef $aIncludes_Arr) 
    Local Const $rFile = '(?i)(?:^|[\n\r])[ \t]*#include[ \t]+((?:\<|")[^\n\r\"\>]+(?:\>|"))' 
    Local Const $rUDFs = '(?i)(?:^|[\n\r])[ \t]*Func[ \t]+([\w\d]+)' 
 
    ; ������������� ������� ��� ������ ����� / ���������� ������ UDF 
    If UBound($aIncludes_Arr, 2) <> 3 Then Dim $aIncludes_Arr[2][3] = [[1, 0, 0], [0, "", 0]] 
    $aIncludes_Arr[$aIncludes_Arr[0][0]][2] = StringRegExp($sScript_Content, $rUDFs, 3) 
 
    ; ������������� ���������� / ��������� ������ ������������ ������ 
    Local $sPath, $iType, $sName, $sText 
    Local $aFile = StringRegExp($sScript_Content, $rFile, 3) 
 
    ; ���������� ��������� ������ ��������� 
    If IsArray($aFile) Then 
        For $i = 0 To UBound($aFile)-1 
            $sPath = _AU3_LibIncToPath($aFile[$i])                      ; ������ ��� ����� 
            If @error Then ContinueLoop                                 ; ���� �� ������ 
 
            $iType = @extended                                          ; ��� ���������� 
            $sName = StringRegExpReplace($sPath, "(?:[^\\]+\\)+", "")   ; ������� ��� ����� 
 
            ; ���������� ��������� ��������� / ������ ����� 
            For $j = 1 To $aIncludes_Arr[0][0] 
                If $aIncludes_Arr[$j][0] == $iType And $aIncludes_Arr[$j][1] == $sName Then ContinueLoop 2 
            Next 
 
            $sText = FileRead($sPath) 
            If @error Then ContinueLoop 
 
            ; ��� �������� ������ ��������� ���� � �������� ������ 
            $aIncludes_Arr[0][0] +=1 
            ReDim $aIncludes_Arr[$aIncludes_Arr[0][0]+1][3] 
 
            $aIncludes_Arr[$aIncludes_Arr[0][0]][0] = $iType 
            $aIncludes_Arr[$aIncludes_Arr[0][0]][1] = $sPath ;$sName 
 
            ; ����������� ����� �� ��������� ������ ���������� 
            _AU3_GetAllLibUDF($sText, $aIncludes_Arr) 
        Next 
    EndIf 
EndFunc ; ==> _AU3_GetAllLibUDF 
 
; =============================================================== 
; _AU3_LibIncToPath($sInclude) 
; --------------------------------------------------------------- 
; ���������� ������ ���� � ������������� ����� �� ������ �������� 
; ����������� AutoIT v3.2.12.0 
; 
; $sInclude   : ������ �������� � ������� #include, �������: 
;               '<array.au3>' 
;               '"array.au3"' 
;               '"c:\Program Files\AutoIT3\Include\array.au3"' 
; 
; ��� ������  : ���������� ������ ��� �����, ���������� ����, 
;               ������ @extended ��������� �� ��� ����������: 
;               1 - ��������� ���������� (������� ���������) 
;               2 - ������� ���������� (������� �������) 
;               3 - ���������������� ���������� (���� �� �������) 
;               4 - ���� � ���������� ���� ������ ��� �������� 
; 
; ��� ������� : ���������� ������ ������ � ������������� @error: 
;               1 - ������ ������� ������ 
;               2 - ���� �� ������ 
; 
; �����       : amel27 
; =============================================================== 
Func _AU3_LibIncToPath($sInclude) 
    Local $aRegExp = StringRegExp($sInclude, '^(<|")([^>"]+)(?:>|")$', 3) 
 
    ; �������� �� ������������ ������� ������ 
    If Not IsArray($aRegExp) Then Return SetError(1, 0, "") 
    $sInclude = $aRegExp[1] 
 
    If StringInStr($sInclude, "\") = 0 Then 
        Local $sSYS, $sUDL, $aUDL, $sAU3 = @ScriptDir & "\" & $sInclude 
 
        ; ����������� �������� ��������� ��������� 
        $sSYS = StringRegExpReplace(@AutoItExe, "\\[^\\]+$", "") 
        $sSYS &= "\Include\"& $sInclude 
 
        ; ������ ������ ��������� ���������������� ��������� 
        $sUDL = RegRead("HKCU\Software\AutoIt v3\AutoIt", "Include") 
        $aUDL = StringRegExp($sUDL, "([^;]+)(?:;|$)", 3) 
 
        ; �������� ����� 1 � 2 (�� ���������������� ���������) 
        If $aRegExp[0] == '<' Then 
            If FileExists($sSYS) Then Return SetError(0, 1, $sSYS) 
        ElseIf $aRegExp[0] == '"' Then 
            If FileExists($sAU3) Then Return SetError(0, 2, $sAU3) 
        EndIf 
 
        ; �������� ���� 3 (����� ����� ���������������� ���������) 
        If IsArray($aUDL) Then 
            For $i = 0 To UBound($aUDL)-1 
                $aUDL[$i] &= "\" & $sInclude 
                If FileExists($aUDL[$i]) Then Return SetError(0, 3, $aUDL[$i]) 
            Next 
        EndIf 
 
        ; �������� ����� 1 � 2 (����� ���������������� ���������) 
        If $aRegExp[0] == '<' Then 
            If FileExists($sAU3) Then Return SetError(0, 2, $sAU3) 
        ElseIf $aRegExp[0] == '"' Then 
            If FileExists($sSYS) Then Return SetError(0, 1, $sSYS) 
        EndIf 
    Else 
        ; �������� ���� 4 (���� � ��������� ������� ����) 
        If FileExists($sInclude) Then Return SetError(0, 4, $sInclude) 
    EndIf 
 
    ; ������: ���� �� ������ 
    Return SetError(2, 0, "") 
EndFunc ; ==>  _AU3_LibIncToPath 