Func _CopyDirWithProgress($sOriginalDir, $sDestDir)
  ;$sOriginalDir and $sDestDir are quite selfexplanatory...
  ;This func returns:
  ; -1 in case of critical error, bad original or destination dir
  ;  0 if everything went all right
  ; >0 is the number of file not copied and it makes a log file
  ;  if in the log appear as error message '0 file copied' it is a bug of some windows' copy command that does not redirect output... 
   
   If StringRight($sOriginalDir, 1) <> '\' Then $sOriginalDir = $sOriginalDir & '\'
   If StringRight($sDestDir, 1) <> '\' Then $sDestDir = $sDestDir & '\'
   If $sOriginalDir = $sDestDir Then Return -1
   
   ProgressOn('Copying...', 'Making list of files...' & @LF & @LF, '', -1, -1, 18)
   Local $aFileList = _FileSearch($sOriginalDir)
   If $aFileList[0] = 0 Then
      ProgressOff()
      SetError(1)
      Return -1
   EndIf
   
   If FileExists($sDestDir) Then
      If Not StringInStr(FileGetAttrib($sDestDir), 'd') Then
         ProgressOff()
         SetError(2)
         Return -1
      EndIf
   Else
      DirCreate($sDestDir)
      If Not FileExists($sDestDir) Then
         ProgressOff()
         SetError(2)
         Return -1
      EndIf
   EndIf
   
   Local $iDirSize, $iCopiedSize = 0, $fProgress = 0
   Local $c, $FileName, $iOutPut = 0, $sLost = '', $sError
   Local $Sl = StringLen($sOriginalDir)
  
   _Quick_Sort($aFileList, 1, $aFileList[0])
   
   $iDirSize = Int(DirGetSize($sOriginalDir) / 1024)

   ProgressSet(Int($fProgress * 100), $aFileList[$c], 'Coping file:')
   For $c = 1 To $aFileList[0]
      $FileName = StringTrimLeft($aFileList[$c], $Sl)
      ProgressSet(Int($fProgress * 100), $aFileList[$c] & ' -> '& $sDestDir & $FileName & @LF & 'Total KiB: ' & $iDirSize & @LF & 'Done KiB: ' & $iCopiedSize, 'Coping file:  ' & Round($fProgress * 100, 2) & ' %   ' & $c & '/' &$aFileList[0])
      
      If StringInStr(FileGetAttrib($aFileList[$c]), 'd') Then
         DirCreate($sDestDir & $FileName)
      Else
         If Not FileCopy($aFileList[$c], $sDestDir & $FileName, 1) Then
            If Not FileCopy($aFileList[$c], $sDestDir & $FileName, 1) Then;Tries a second time
               If RunWait(@ComSpec & ' /c copy /y "' & $aFileList[$c] & '" "' & $sDestDir & $FileName & '">' & @TempDir & '\o.tmp', '', @SW_HIDE)=1 Then;and a third time, but this time it takes the error message
                  $sError = FileReadLine(@TempDir & '\o.tmp',1)
                  $iOutPut = $iOutPut + 1
                  $sLost = $sLost & $aFileList[$c] & '  ' & $sError & @CRLF
               EndIf
               FileDelete(@TempDir & '\o.tmp')
            EndIf
         EndIf
         
         FileSetAttrib($sDestDir & $FileName, "+A-RSH");<- Comment this line if you do not want attribs reset.
         
         $iCopiedSize = $iCopiedSize + Int(FileGetSize($aFileList[$c]) / 1024)
         $fProgress = $iCopiedSize / $iDirSize
      EndIf
   Next
  
   ProgressOff()
   
   If $sLost <> '' Then;tries to write the log somewhere.
      If FileWrite($sDestDir & 'notcopied.txt',$sLost) = 0 Then
         If FileWrite($sOriginalDir & 'notcopied.txt',$sLost) = 0 Then
            FileWrite(@WorkingDir & '\notcopied.txt',$sLost)
         EndIf
      EndIf
   EndIf
   
   Return $iOutPut
EndFunc  ;==>_CopyDirWithProgress

Func _FileSearch($sIstr, $bSF = 1)
  ; $bSF = 1 means looking in subfolders
  ; $sSF = 0 means looking only in the current folder.
  ; An array is returned with the full path of all files found. The pos [0] keeps the number of elements.
   Local $sIstr, $bSF, $sCriteria, $sBuffer, $iH, $iH2, $sCS, $sCF, $sCF2, $sCP, $sFP, $sOutPut = '', $aNull[1]
   $sCP = StringLeft($sIstr, StringInStr($sIstr, '\', 0, -1))
   If $sCP = '' Then $sCP = @WorkingDir & '\'
   $sCriteria = StringTrimLeft($sIstr, StringInStr($sIstr, '\', 0, -1))
   If $sCriteria = '' Then $sCriteria = '*.*'
   
  ;To begin we seek in the starting path.
   $sCS = FileFindFirstFile($sCP & $sCriteria)
   If $sCS <> - 1 Then
      Do
         $sCF = FileFindNextFile($sCS)
         If @error Then
            FileClose($sCS)
            ExitLoop
         EndIf
         If $sCF = '.' Or $sCF = '..' Then ContinueLoop
         $sOutPut = $sOutPut & $sCP & $sCF & @LF
      Until 0
   EndIf
   
  ;And after, if needed, in the rest of the folders.
   If $bSF = 1 Then
      $sBuffer = @CR & $sCP & '*' & @LF;The buffer is set for keeping the given path plus a *.
      Do
         $sCS = StringTrimLeft(StringLeft($sBuffer, StringInStr($sBuffer, @LF, 0, 1) - 1), 1);current search.
         $sCP = StringLeft($sCS, StringInStr($sCS, '\', 0, -1));Current search path.
         $iH = FileFindFirstFile($sCS)
         If $iH <> - 1 Then
            Do
               $sCF = FileFindNextFile($iH)
               If @error Then
                  FileClose($iH)
                  ExitLoop
               EndIf
               If $sCF = '.' Or $sCF = '..' Then ContinueLoop
               If StringInStr(FileGetAttrib($sCP & $sCF), 'd') Then
                  $sBuffer = @CR & $sCP & $sCF & '\*' & @LF & $sBuffer;Every folder found is added in the begin of buffer
                  $sFP = $sCP & $sCF & '\';                               for future searches
                  $iH2 = FileFindFirstFile($sFP & $sCriteria);         and checked with the criteria.
                  If $iH2 <> - 1 Then
                     Do
                        $sCF2 = FileFindNextFile($iH2)
                        If @error Then
                           FileClose($iH2)
                           ExitLoop
                        EndIf
                        If $sCF2 = '.' Or $sCF2 = '..' Then ContinueLoop
                        $sOutPut = $sOutPut & $sFP & $sCF2 & @LF;Found items are put in the Output.
                     Until 0
                  EndIf
               EndIf
            Until 0
         EndIf
         $sBuffer = StringReplace($sBuffer, @CR & $sCS & @LF, '')
      Until $sBuffer = ''
   EndIf
   
   If $sOutPut = '' Then
      $aNull[0] = 0
      Return $aNull
   Else
      Return StringSplit(StringTrimRight($sOutPut, 1), @LF)
   EndIf
EndFunc  ;==>_FileSearch

Func _Quick_Sort(ByRef $SortArray, $First, $Last);Larry's code
   Dim $Low, $High
   Dim $Temp, $List_Separator
   
   $Low = $First
   $High = $Last
   $List_Separator = StringLen($SortArray[ ($First + $Last) / 2])
   Do
      While (StringLen($SortArray[$Low]) < $List_Separator)
         $Low = $Low + 1
      WEnd
      While (StringLen($SortArray[$High]) > $List_Separator)
         $High = $High - 1
      WEnd
      If ($Low <= $High) Then
         $Temp = $SortArray[$Low]
         $SortArray[$Low] = $SortArray[$High]
         $SortArray[$High] = $Temp
         $Low = $Low + 1
         $High = $High - 1
      EndIf
   Until $Low > $High
   If ($First < $High) Then _Quick_Sort($SortArray, $First, $High)
   If ($Low < $Last) Then _Quick_Sort($SortArray, $Low, $Last)
EndFunc  ;==>_Quick_Sort
  
