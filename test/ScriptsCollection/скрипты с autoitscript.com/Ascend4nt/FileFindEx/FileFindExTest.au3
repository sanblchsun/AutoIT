#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_outfile=FileFindExTest.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/om /cn=0 /cs=0 /sf=1 /sv=1
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <_FileFindEx.au3>
#include <_LinkedOutputDisplay.au3>	; For a side-by-side comparison
; ===============================================================================================================================
; <FileFindExTest.au3>
;
;	Test/Comparison of <_FileFindEx.au3> functions vs. the built-in
;		FileFindFirst/NextFile,FileGetAttrib, & FileGetTime functions
;
; Author: Ascend4nt
; ===============================================================================================================================

; ===============================================================================================================================
; --	TEST	--
; ===============================================================================================================================

; ===============================================================================================================================
; Func _FileGetShortFilename($sPath)
;
; Simple function to return short filename from a full FileGetShortName() path, if one exists.
; NOTE one difference: It will return "" if shortname matches longname (matching _FileFindEx results)
; ===============================================================================================================================

Func _FileGetShortFilename($sPath)
	Local $sShortFilename,$sCurrentFilename=StringMid($sPath,StringInStr($sPath,'\',1,-1)+1)
	$sPath=FileGetShortName($sPath)
	$sShortFilename=StringMid($sPath,StringInStr($sPath,'\',1,-1)+1)
	If $sCurrentFilename=$sShortFilename Then Return ""
	Return $sShortFilename
EndFunc

; ===============================================================================================================================
; - START -
; ===============================================================================================================================

; NOTE that successive file-searches will yield faster results, so it's better to compare 1 and then the other
;	with a clean boot between to get more accurate results.

;	ALSO: un-comment out the lines that get extra file information to see the change in time

Global $aFileFindArray,$iTotalCount,$iFolderCount,$iTimer,$sFilename,$sAttrib,$hFindFileHandle
Global $sFolder=@SystemDir&'\'	; @UserProfileDir&'\'	; (the latter results in some REPARSE Points)
Global $sSearchWildCard="*.*"
Global $s_FileFindExStats="",$sFileFindFileStats="",$bDuplicateResults=True,$bShowStats=True,$iIsFolder

ConsoleWrite("Doing test on folder: "&$sFolder&@LF)
;~ MsgBox(0,"Commencing Tests..","Press OK to Start")

; Switch the order here after a reboot:

FFEXTest()
FileFindTest()

_LinkedOutputDisplay($sFileFindFileStats,$s_FileFindExStats,"Comparison of FindFile Results")

; -------------- _FileFindEx Test ------------

Func FFEXTest()
	; Test _FileFindExFirst/NextFile Loop

	$iTotalCount=0
	$iFolderCount=0
	$iTimer=TimerInit()
	$aFileFindArray=_FileFindExFirstFile($sFolder & $sSearchWildCard)
	If $aFileFindArray=-1 Then Exit

	Do
		; Check if it is a folder
		If BitAND($aFileFindArray[2],16) Then
			; Necessary test with _FindFirst\NextFile() functions. Relative 'folders' need to be ignored:
			If $aFileFindArray[0]='.' Or $aFileFindArray[0]='..' Then ContinueLoop
			; Increase found-folder count
			$iFolderCount+=1
		EndIf
		; Total file+folder count
		$iTotalCount+=1
		; 'Long' Filename: $aFileFindArray[0]
		; Attributes: $aFileFindArray[2]

;~ #cs
		If $bShowStats Then
			$s_FileFindExStats &= "Reported Filename:" & $aFileFindArray[0] & @CRLF & _
			"	8.3 short name:" & $aFileFindArray[1] & _
			", Attributes:" & $aFileFindArray[2] & _
			", File Size:" & $aFileFindArray[3] & @CRLF & _
			"[Times] Creation Time:" & _FileFindExTimeConvert($aFileFindArray,1,1) & _
			", Last Access Time:" & _FileFindExTimeConvert($aFileFindArray,2,1) & _
			", Last Write Time:" & _FileFindExTimeConvert($aFileFindArray,0,1) & @CRLF
		ElseIf $bDuplicateResults Then
			; 8.3 Short Name [If A) exists and B) different from filename]
			; 	$aFileFindArray[1]
			; File-Size:
			;	$aFileFindArray[3]
			; Creation Time:
			_FileFindExTimeConvert($aFileFindArray,1,1)
			; Last-Access Time
			_FileFindExTimeConvert($aFileFindArray,2,1)
			; Last-Write Time
			_FileFindExTimeConvert($aFileFindArray,0,1)
		EndIf
;~ #ce
	Until Not _FileFindExNextFile($aFileFindArray)
	_FileFindExClose($aFileFindArray)

;~ #cs
	$s_FileFindExStats="_FileFindEx Stats:" & @CRLF & _
		"Total File count:" & $iTotalCount-$iFolderCount & ", Total Folder count:" & $iFolderCount & _
		", Time elapsed:" & TimerDiff($iTimer) & " ms" & @CRLF & $s_FileFindExStats
;~ #ce

	ConsoleWrite("_FileFindEx Stats:" & @CRLF & _
		"Total File count:" & $iTotalCount-$iFolderCount & ", Total Folder count:" & $iFolderCount & _
		", Time elapsed:" & TimerDiff($iTimer) & " ms" & @CRLF)
EndFunc

; ------------ FileFindTest --------------

Func FileFindTest()
	; Test Regular FileFindFirst/NextFile Loop

	$iTotalCount=0
	$iFolderCount=0
	$iTimer=TimerInit()
	$hFindFileHandle=FileFindFirstFile($sFolder & $sSearchWildCard)
	While 1
		$sFilename=FileFindNextFile($hFindFileHandle)
		$iIsFolder=@extended
		If @error Then ExitLoop

		$sAttrib=FileGetAttrib($sFolder & $sFilename)

		; Check if file is a folder. If so, increase found-folder count:
		; Older way (pre- v3.3.2.0)
		; If StringInStr($sAttrib,"D",0) Then $iFolderCount+=1
		If $iIsFolder Then $iFolderCount+=1

		; Total file+folder count
		$iTotalCount+=1

;~ #cs
		If $bShowStats Then
			$sFileFindFileStats&="Reported Filename:" & $sFilename & @CRLF & _
			"	8.3 short name:" & _FileGetShortFilename($sFolder & $sFilename) & _
			", Attributes:" & $sAttrib & _
			", File Size:" & FileGetSize($sFolder & $sFilename) & @CRLF & _
			"[Times] Creation Time:" & FileGetTime($sFolder & $sFilename,1,1) & _
			", Last Access Time:" & FileGetTime($sFolder & $sFilename,2,1) & _
			", Last Write Time:" & FileGetTime($sFolder & $sFilename,0,1) & @CRLF
		ElseIf $bDuplicateResults Then
			; 8.3 Short Name [If A) exists and B) different from filename]
			_FileGetShortFilename($sFolder & $sFilename)
			; File-Size
			FileGetSize($sFolder & $sFilename)
			; Creation Time:
			FileGetTime($sFolder & $sFilename,1,1)
			; Last-Access Time
			FileGetTime($sFolder & $sFilename,2,1)
			; Last-Write Time
			FileGetTime($sFolder & $sFilename,0,1)
		EndIf
;~ #ce
	WEnd
	FileClose($hFindFileHandle)
;~ #cs
	$sFileFindFileStats="FileFindFile Stats:" & @CRLF & _
		"Total File count:" & $iTotalCount-$iFolderCount & ", Total Folder count:" & $iFolderCount & _
		", Time elapsed:" & TimerDiff($iTimer) & " ms" & @CRLF & $sFileFindFileStats
;~ #ce

	ConsoleWrite("FileFindFile Stats:" & @CRLF & _
		"Total File count:" & $iTotalCount-$iFolderCount & ", Total Folder count:" & $iFolderCount & _
		", Time elapsed:" & TimerDiff($iTimer) & " ms" & @CRLF)
EndFunc

