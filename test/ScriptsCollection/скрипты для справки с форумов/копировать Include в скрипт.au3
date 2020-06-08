 
_AU3_MergeAllLibs(@ScriptDir & "\Test.au3") 
 
; =============================================================== 
; _AU3_MergeAllLibs($sScriptFile, $iIncludeComments=0, $iRemoveIncludes=1) 
; --------------------------------------------------------------- 
; Смешивает вложенные библиотеки в тело скрипта 
;  (таким образом преобразовывая один цельный скрипт со всеим функциями и переменными) 
; Использован AutoIT v3.2.12.1 
; 
; $sScriptFile       : AutoIT-скрипт для смешивания 
; $iIncludeComments  : Определяет, нужно ли обрабатывать строки комментариев 
; $iRemoveIncludes   : Определяет, нужно ли удалять строки #include'ов с исходного скрипта 
; 
; Автор              : G.Sandler (a.k.a CreatoR) 
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
; Возвращает массив всех загруженных UDF и библиотечных файлов 
; Использован AutoIT v3.2.12.0 
; 
; $sScript_Content       : текст AutoIT-скрипта 
; $aIncludes_Arr         : ссылка на переменную для выходного массива, 
;                 по выходу содержит двумерный массив: 
;                   $aIncludes_Arr[0][0]  - количество элементов в массиве 
;                   $aIncludes_Arr[$i][0] - тип библиотечного файла 
;                   $aIncludes_Arr[$i][1] - Полный путь библиотечного файла 
;                   $aIncludes_Arr[$i][2] - массив UDF, определенных в файле 
; 
; Функция рекурсивная, поэтому выход по ошибке не предусмотрен 
; 
; Автор                  : amel27 
; =============================================================== 
Func _AU3_GetAllLibUDF($sScript_Content, ByRef $aIncludes_Arr) 
    Local Const $rFile = '(?i)(?:^|[\n\r])[ \t]*#include[ \t]+((?:\<|")[^\n\r\"\>]+(?:\>|"))' 
    Local Const $rUDFs = '(?i)(?:^|[\n\r])[ \t]*Func[ \t]+([\w\d]+)' 
 
    ; Инициализация массива при первом входе / сохранение списка UDF 
    If UBound($aIncludes_Arr, 2) <> 3 Then Dim $aIncludes_Arr[2][3] = [[1, 0, 0], [0, "", 0]] 
    $aIncludes_Arr[$aIncludes_Arr[0][0]][2] = StringRegExp($sScript_Content, $rUDFs, 3) 
 
    ; Инициализация переменных / Получение списка библиотечных файлов 
    Local $sPath, $iType, $sName, $sText 
    Local $aFile = StringRegExp($sScript_Content, $rFile, 3) 
 
    ; Пофайловая обработка списка библиотек 
    If IsArray($aFile) Then 
        For $i = 0 To UBound($aFile)-1 
            $sPath = _AU3_LibIncToPath($aFile[$i])                      ; полное имя файла 
            If @error Then ContinueLoop                                 ; файл не найден 
 
            $iType = @extended                                          ; тип библиотеки 
            $sName = StringRegExpReplace($sPath, "(?:[^\\]+\\)+", "")   ; краткое имя файла 
 
            ; Исключение повторной обработки / Чтение файла 
            For $j = 1 To $aIncludes_Arr[0][0] 
                If $aIncludes_Arr[$j][0] == $iType And $aIncludes_Arr[$j][1] == $sName Then ContinueLoop 2 
            Next 
 
            $sText = FileRead($sPath) 
            If @error Then ContinueLoop 
 
            ; При успешном чтении добавляем файл в выходной массив 
            $aIncludes_Arr[0][0] +=1 
            ReDim $aIncludes_Arr[$aIncludes_Arr[0][0]+1][3] 
 
            $aIncludes_Arr[$aIncludes_Arr[0][0]][0] = $iType 
            $aIncludes_Arr[$aIncludes_Arr[0][0]][1] = $sPath ;$sName 
 
            ; Рекурсивный вызов на обработку текста библиотеки 
            _AU3_GetAllLibUDF($sText, $aIncludes_Arr) 
        Next 
    EndIf 
EndFunc ; ==> _AU3_GetAllLibUDF 
 
; =============================================================== 
; _AU3_LibIncToPath($sInclude) 
; --------------------------------------------------------------- 
; Возвращает полный путь к библиотечному файлу по строке загрузки 
; Использован AutoIT v3.2.12.0 
; 
; $sInclude   : строка загрузки в формате #include, примеры: 
;               '<array.au3>' 
;               '"array.au3"' 
;               '"c:\Program Files\AutoIT3\Include\array.au3"' 
; 
; При успехе  : возвращает полное имя файла, содержащее путь, 
;               макрос @extended указывает на тип библиотеки: 
;               1 - системная библиотека (каталог установки) 
;               2 - текущая библиотека (каталог скрипта) 
;               3 - пользовательская библиотека (путь из реестра) 
;               4 - путь к библиотеке явно указан при загрузке 
; 
; При неудаче : возвращает пустую строку и устанавливает @error: 
;               1 - ошибка формата строки 
;               2 - файл не найден 
; 
; Автор       : amel27 
; =============================================================== 
Func _AU3_LibIncToPath($sInclude) 
    Local $aRegExp = StringRegExp($sInclude, '^(<|")([^>"]+)(?:>|")$', 3) 
 
    ; Проверка на корректность формата строки 
    If Not IsArray($aRegExp) Then Return SetError(1, 0, "") 
    $sInclude = $aRegExp[1] 
 
    If StringInStr($sInclude, "\") = 0 Then 
        Local $sSYS, $sUDL, $aUDL, $sAU3 = @ScriptDir & "\" & $sInclude 
 
        ; Определение каталога системных библиотек 
        $sSYS = StringRegExpReplace(@AutoItExe, "\\[^\\]+$", "") 
        $sSYS &= "\Include\"& $sInclude 
 
        ; Чтение списка каталогов пользовательских библиотек 
        $sUDL = RegRead("HKCU\Software\AutoIt v3\AutoIt", "Include") 
        $aUDL = StringRegExp($sUDL, "([^;]+)(?:;|$)", 3) 
 
        ; Проверка типов 1 и 2 (до пользовательских библиотек) 
        If $aRegExp[0] == '<' Then 
            If FileExists($sSYS) Then Return SetError(0, 1, $sSYS) 
        ElseIf $aRegExp[0] == '"' Then 
            If FileExists($sAU3) Then Return SetError(0, 2, $sAU3) 
        EndIf 
 
        ; Проверка типа 3 (поиск среди пользовательских библиотек) 
        If IsArray($aUDL) Then 
            For $i = 0 To UBound($aUDL)-1 
                $aUDL[$i] &= "\" & $sInclude 
                If FileExists($aUDL[$i]) Then Return SetError(0, 3, $aUDL[$i]) 
            Next 
        EndIf 
 
        ; Проверка типов 1 и 2 (после пользовательских библиотек) 
        If $aRegExp[0] == '<' Then 
            If FileExists($sAU3) Then Return SetError(0, 2, $sAU3) 
        ElseIf $aRegExp[0] == '"' Then 
            If FileExists($sSYS) Then Return SetError(0, 1, $sSYS) 
        EndIf 
    Else 
        ; Проверка типа 4 (файл с указанием полного пути) 
        If FileExists($sInclude) Then Return SetError(0, 4, $sInclude) 
    EndIf 
 
    ; ОШИБКА: файл не найден 
    Return SetError(2, 0, "") 
EndFunc ; ==>  _AU3_LibIncToPath 