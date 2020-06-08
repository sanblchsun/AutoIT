#include <_FileGetWinPEImportExports.au3>
#include <Array.au3>
; ===============================================================================================================================
; <TestImportExportsList.au3>
;
;	Test of <_FileGetWinPEImportExports.au3> module.
;
; Author: Ascend4nt
; ===============================================================================================================================

Local $sFile,$sLastDir=@SystemDir,$sLastFile="",$aExports,$aImports,$iTimer
Local $iImportErr,$iImportExt,$iExportErr,$iExportExt
While 1
	$sFile=FileOpenDialog("Select program to report Import/Export info on",$sLastDir,"PE Files (*.exe;*.dll;*.cpl)|All Files (*.*)",3,$sLastFile)
	If @error Or $sFile="" Then Exit
	$sLastFile=StringMid($sFile,StringInStr($sFile,'\',1,-1)+1)
	$sLastDir=StringLeft($sFile,StringInStr($sFile,'\',1,-1)-1)

	$iTimer=TimerInit()
	$aExports=_FileGetWinPEExports($sFile,True)
	$iExportErr=@error
	$iExportExt=@extended
	ConsoleWrite("_FileGetWinPEExports called, @error="&@error&",@extended="&@extended&", Function time:"&TimerDiff($iTimer)&" ms"&@CRLF)

	$iTimer=TimerInit()
	$aImports=_FileGetWinPEImports($sFile,True)
	$iImportErr=@error
	$iImportExt=@extended
	ConsoleWrite("_FileGetWinPEImports called, @error="&@error&",@extended="&@extended&", Function time:"&TimerDiff($iTimer)&" ms"&@CRLF)

	If IsArray($aExports) Then
		ConsoleWrite("Original DLL Name as listed inside file: "&$aExports[0][1]&@CRLF)
		$aExports[0][0]="Exported Function Name"
		$aExports[0][1]="Function Offset or Forwarder String"
		$aExports[0][2]="Ordinal #"
		_ArrayDisplay($aExports,"Exports for '"&$sLastFile&"'")
	Else
		MsgBox(0,"No Exports found","_FileGetWinPEExports did not find Exports"&@CRLF& _
			"Errors from function: @error="&$iExportErr&", @extended="&$iExportExt)
	EndIf
	If IsArray($aImports) Then
		$aImports[0][0]="DLL Importing From"
		$aImports[0][1]="Function name or Ordinal #"
		$aImports[0][2]="Hint # [if Function name present]"
		$aImports[0][3]="Virtual Offset of Thunk"	; (Address Offset in loaded Module that will contain the DLL function Address)
		_ArrayDisplay($aImports,"Imports for '"&$sLastFile&"'")
	Else
		MsgBox(0,"No Imports found","_FileGetWinPEImports did not find Imports"&@CRLF& _
			"Errors from function: @error="&$iImportErr&", @extended="&$iImportExt)
	EndIf
WEnd
