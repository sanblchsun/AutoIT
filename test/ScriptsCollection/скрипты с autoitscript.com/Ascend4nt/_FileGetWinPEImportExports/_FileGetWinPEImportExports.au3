#include-once
#include <WinAPI.au3>
; ===============================================================================================================================
; <_FileGetWinPEImportExports.au3>
;
; Functions to gather Import or Export info from a Windows PE32/32+ format file.
;
; Function:
;	_FileGetWinPEImports()		; Returns Function Import information for .EXE and .DLL files
;	_FileGetWinPEExports()		; Returns Function Export information for .DLL files
;
; WinApi Additional Functions:
;	_WinAPI_UndecorateName()	; 'Undecorates'/unmangles a C++ function name (or leaves the original intact if not 'decorated')
;	_WinAPI_CreateFileMapping()	; Creates file mapping object [Close with CloseHandle after Map/UnMap]
;	_WinAPI_MapViewOfFile()		; 'Maps' a file into memory, from a file mapping object [Must be UnMapped!]
;	_WinAPI_UnMapViewOfFile()	; 'UnMaps' a file from memory
;
; Additional Helper Function:
;	_MemoryGetNullTermStringA()	; pulled from another UDF - just grabs a NULL-terminated string from memory
;
; Internal Functions (do NOT use):
;	__FileGetWinPEImExports()	; base function used by both _FileGetWinPEImports() and _FileGetWinPEExports()
;	__FGWPEIHelper()				; Simple helper function for the above 3 functions
;
; See also:
;	<_FileCheckWinPEFormat.au3>		; Returns information about the EXE/DLL file
;	<_FileGetExecutableFormat.au3>	; Returns .EXE, .COM, or .PIF executable type (one API call)
;	<_WinAPI_GetOSVersionInfo.au3>	; Returns advanced version info (compare to Version info returned from function)
;	<_IsExecutable.au3>
;	<_FilePathFunctions.au3>
;
; Reference:
;	Microsoft Portable Executable and Common Object File Format Specification
;	  @ http://www.microsoft.com/whdc/system/platform/firmware/pecoff.mspx
;	HTML version @ http://kishorekumar.net/pecoff_v8.1.htm
;	Portable Executable - Wikipedia
;	  @ http://en.wikipedia.org/wiki/Portable_Executable
;	Name Mangling/Undecorating Function names:
;		http://weseetips.com/tag/name-mangling/
;	Microsoft Visual C++ name mangling - Wikipedia:
;		http://en.wikipedia.org/wiki/Microsoft_Visual_C%2B%2B_Name_Mangling
;	Name Mangling - Wikipedia:
;		http://en.wikipedia.org/wiki/Name_mangling
;
; Author: Ascend4nt
; ===============================================================================================================================


; ===================================================================================================================
;	--------------------	EXTRA FUNCTIONS		--------------------
; ===================================================================================================================


; ===================================================================================================================
; Func _WinAPI_UndecorateName($sFunc)
;
; Undecorates/unmangles a C++ function name (typically beginning with ? or @?)
;
; $sFunc = Function name, decorated or not.
;
; Returns:
;	Success: Undecorated string, with @error=0
;	Failure: Original string as it was passed, with @error set:
;		@error = 1 = invalid parameter
;		@error = 2 = DLLCall error, @extended = DLLCall @error code (see AutoIT help)
;		@error = 3 = Failure Returned from API call (call GetLastError for info)
;
; Author: Ascend4nt
; ===================================================================================================================

Func _WinAPI_UndecorateName($sFunc)
	If Not IsString($sFunc) Or $sFunc="" Then Return SetError(1,0,"")
	Local $aRet=DllCall("dbghelp.dll","dword","UnDecorateSymbolName","str",$sFunc,"str","","dword",65536,"dword",0)
	If @error Then Return SetError(2,@error,$sFunc)
	If $aRet[0]=0 Then Return SetError(3,@error,$sFunc)
	Return SetExtended($aRet[0],$aRet[2])
EndFunc


; ===================================================================================================================
; Func _WinAPI_CreateFileMapping($hFile)
;
; Creates File Mapping Object to be used in MapViewOfFile/UnMapViewOfFile.
;	*MUST* be closed with _WinAPI_CloseHandle() after Map/UnMap operations complete.
;
; $hFile = File handle as returned from _WinAPI_CreateFile()
;
; Returns:
;	Success: Handle to the File Mapping Object, @error=0
;	Failure: 0, with @error set:
;		@error = 1 = invalid parameter
;		@error = 2 = DLLCall error, @extended = DLLCall @error code (see AutoIT help)
;		@error = 3 = Failure Returned from API call (call GetLastError for info)
;
; Author: Ascend4nt
; ===================================================================================================================

Func _WinAPI_CreateFileMapping($hFile)
	If Not IsPtr($hFile) Or $hFile=0 Then Return SetError(1,0,0)
	; PAGE_READONLY = 2
	Local $aRet=DllCall("kernel32.dll","handle","CreateFileMappingW","handle",$hFile,"ptr",0,"dword",2,"dword",0,"dword",0,"ptr",0)
	If @error Then Return SetError(2,@error,0)
	If $aRet[0]=0 Then Return SetError(3,0,0)
	ConsoleWrite("CreateFileMapping call a success"&@CRLF)
	Return $aRet[0]
EndFunc


; ===================================================================================================================
; Func _WinAPI_MapViewOfFile($hFileMapObj)
;
; Maps File into Memory using a File Mapping Object from _WinAPI_CreateFileMapping()
;	*MUST* be UnMapped after done using this.
;
; $hFileMapObj = FileMappingObject handle as returned from _WinAPI_CreateFileMapping()
;
; Returns:
;	Success: Pointer to 'Mapped' File (file in memory), @error=0
;	Failure: 0, with @error set:
;		@error = 1 = invalid parameter
;		@error = 2 = DLLCall error, @extended = DLLCall @error code (see AutoIT help)
;		@error = 3 = Failure Returned from API call (call GetLastError for info)
;
; Author: Ascend4nt
; ===================================================================================================================

Func _WinAPI_MapViewOfFile($hFileMapObj)
	If Not IsPtr($hFileMapObj) Then Return SetError(1,0,0)
	; FILE_MAP_READ = 4
	Local $aRet=DllCall("kernel32.dll","ptr","MapViewOfFile","handle",$hFileMapObj,"dword",4,"dword",0,"dword",0,"ulong_ptr",0)
	If @error Then Return SetError(2,@error,0)
	If $aRet[0]=0 Then Return SetError(3,0,0)
	ConsoleWrite("MapViewOfFile call a success, return:"&$aRet[0]&@CRLF)
	Return $aRet[0]
EndFunc


; ===================================================================================================================
; Func _WinAPI_UnMapViewOfFile(ByRef $pFileInMem)
;
; Unmaps File that was Mapped using _WinAPI_MapViewOfFile(). Also invalidates passed parameter (sets to 0)
;	_WinAPI_CloseHandle() can be used on the File Mapping Object after this is completed.
;
; $pFileInMem = Pointer to 'Mapped' File (file in memory) as returned from _WinAPI_MapViewOfFile()
;
; Returns:
;	Success: True, with $pFileInMem invalidated (set to 0)
;	Failure: False, with @error set:
;		@error = 1 = invalid parameter
;		@error = 2 = DLLCall error, @extended = DLLCall @error code (see AutoIT help)
;		@error = 3 = Failure Returned from API call (call GetLastError for info)
;
; Author: Ascend4nt
; ===================================================================================================================

Func _WinAPI_UnMapViewOfFile(ByRef $pFileInMem)
	If Not IsPtr($pFileInMem) Then Return SetError(1,0,False)
	Local $aRet=DllCall("kernel32.dll","bool","UnmapViewOfFile","ptr",$pFileInMem)
	If @error Then Return SetError(2,@error,False)
	If Not $aRet[0] Then Return SetError(3,0,False)
	ConsoleWrite("UnmapViewOfFile call a success"&@CRLF)
	Return True
EndFunc


; ===============================================================================================================================
; Func _MemoryGetNullTermStringA($pStringPtr)
;
; Function to grab a null-terminated ANSI/ASCII string from a memory location where the string size and
;	end-of-buffer are undefined. This is the ANSI/ASCII version of the same function (without the appended 'A')
;	This avoids a few problems:
;	 1. Trying to grab *too* much memory (possibly resulting in access violations)
;	 2. Converting from a 'ubyte' buffer to a 'wchar' one (of the right size).
;	 3. Getting an offset to the data *after* the string.
;		Either use:
;			'(@extended+1)*2 for # of bytes including null-term. ([stringlen+1(null-term)*2 (*2 for Unicode two-byte size)])
;			 or if alternate function used, '(StringLen($sRet)+1)*2' (stringlen+1(null-term)*2)
;		 NOTE: if indexing into a Struct, add 1 (after *2) since the above is 0-index based and Structs are 1-index based
;
; NOTE: While listed on MSDN as requiring Windows XP/2003+, these function(s) are in fact available on Windows 2000 (no SP).
;
; $pStringPtr = pointer to a memory location where the null-terminated string starts
;
; Returns:
;	Success: String or "" if string-length=0, @error=0, @extended=string-length
;	Failure: "", with @error set:
;		@error = 1 = invalid parameter or pointer is 0
;		@error = 2 = DLLCall error (see @extended for DLLCall @error code)
;
; Author: Ascend4nt
; ===============================================================================================================================

Func _MemoryGetNullTermStringA($pStringPtr)
	If Not IsPtr($pStringPtr) Then Return SetError(1,0,"")

	; Get length of null-terminated string
	Local $aRet=DllCall("kernel32.dll","int","lstrlenA","ptr",$pStringPtr)
	If @error Then Return SetError(2,@error,"")
	If $aRet[0]=0 Then Return ""	; not an error, just a zero-length string
	; Set buffer size to string size and use pointer so that we can extract it into a variable
	Local $stString=DllStructCreate("char["&$aRet[0]&"]",$pStringPtr)
	Return SetExtended($aRet[0],DllStructGetData($stString,1))
EndFunc


; ===================================================================================================================
;	--------------------	INTERNAL-ONLY FUNCTION		--------------------
; ===================================================================================================================


;	--------------------	HELPER FUNCTION		--------------------


; ===================================================================================================================
; Func __FGWPEIHelper($pFileInMem,$hFileMapObj,$iErr=0)
;
; Unmaps file and closes required handle before returning an optional error code
;
; Author: Ascend4nt
; ===================================================================================================================

Func __FGWPEIHelper($pFileInMem,$hFileMapObj,$iErr=0)
	_WinAPI_UnMapViewOfFile($pFileInMem)
	If IsPtr($hFileMapObj) Then _WinAPI_CloseHandle($hFileMapObj)
	Return $iErr
EndFunc


; ===================================================================================================================
; Func __FileGetWinPEImExports($sPEFile,$iType)
;
; *INTERNAL-ONLY* function - used by both _FileGetWinPEImports() and _FileGetWinPEExports()
;	due to the common features required of both.  Returns and array only they can use.
;
; $sPEFile = .DLL or .EXE filename to gather information from (extension is ignored)
; $iType = 0 for Imports, 1 for Exports
;
; Returns:
;	Success: 6 element array with info on the PE file (and handles/pointers), @error=0:
;		[0]=$pFileInMem (Pointer to Mapped file in memory)
;		[1]=$hFileMapObj (File-Mapping Object Handle)
;		[2]=PE Type: PE(32) = False, PE32+ (x64) = True
;		[3]=RVA (Relative Virtual Address) Calculation
;		[4]=Offset of Import or Export Directory Table [without RVA calculation]
;		[5]=Size of Import or Export Directory Table (mainly for use with Exports)
;	Failure: "" with @error set:
;		@error = -1 = Could not open file
;		@error =  1 = File does not exist
;		@error =  4 = 'MZ' signature could not be found (not a PE file)
;		@error =  5 = 'PE' signature could not be found (not a PE file)
;		@error =  6 = Machine Target not 32bit, x86-64, or IA64
;		@error =  7 = 'Magic' number not recognized (not PE32, PE32+, could be 'ROM (0x107), or unk.) @extended=number
;		@error =  8 = No Import/Export data table found
;		@error =  9 = Import/Export data table exists, but could not locate
;		@error = 10 = Import tables exist, but function names missing (typical in compressed files)
;
; Author: Ascend4nt
; ===================================================================================================================

Func __FileGetWinPEImExports($sPEFile,$iType)
	If Not FileExists($sPEFile) Then Return SetError(1,0,"")
	Local $hFile,$hFileMapObj,$pFileInMem,$stTemp,$iTemp,$iErr,$iExt,$iPESigOffset,$iNumSections
	Local $iVirtAdd,$iRVACalc,$iImExportOffset,$iImExportSize,$iSectionOffset,$bPE32Plus,$aLoadedPEData

	$hFile=_WinAPI_CreateFile($sPEFile,2,2,2+4)
	If $hFile=0 Then Return SetError(-1,0,"")
	$hFileMapObj=_WinAPI_CreateFileMapping($hFile)
	If Not @error Then $pFileInMem=_WinAPI_MapViewOfFile($hFileMapObj)
	$iErr=@error
	$iExt=@extended
	_WinAPI_CloseHandle($hFile)	; okay, safe to close file handle
	If $iErr Then Return SetError(__FGWPEIHelper($pFileInMem,$hFileMapObj,$iErr),$iExt,"")

	; Check for 'MZ' signature
	$stTemp=DllStructCreate("char[2]",$pFileInMem)
	If DllStructGetData($stTemp,1)<>"MZ" Then Return SetError(__FGWPEIHelper($pFileInMem,$hFileMapObj,4),$iExt,"")

; Read Windows PE Signature Offset location (offset 0x3c, decimal 60)
	$stTemp=DllStructCreate("dword",$pFileInMem+0x3c)
	$iPESigOffset=DllStructGetData($stTemp,1)

	; "PE"&Chr(0)&Chr(0)
	$stTemp=DllStructCreate("char[2];ushort",$pFileInMem+$iPESigOffset)
	If DllStructGetData($stTemp,1)<>"PE" Or DllStructGetData($stTemp,2)<>0 Then Return SetError(__FGWPEIHelper($pFileInMem,$hFileMapObj,5),0,"")

	; Machine Target & Num Sections
	$stTemp=DllStructCreate("ushort[2]",$pFileInMem+$iPESigOffset+4)
	$iTemp=DllStructGetData($stTemp,1,1)
	$iNumSections=DllStructGetData($stTemp,1,2)
	ConsoleWrite("Machine Target:"&Hex($iTemp)&", Number of Sections:"&$iNumSections&@CRLF)

	; Not 32bit, x86-64, or IA64 Machine Target?
	If $iTemp<>0x14C And $iTemp<>0x8664 And $iTemp<>0x0200 Then Return SetError(__FGWPEIHelper($pFileInMem,$hFileMapObj,6),$iTemp,"")

; Optional Header Fields
	; 'Magic' number
	$stTemp=DllStructCreate("ushort",$pFileInMem+$iPESigOffset+24)
	$iTemp=DllStructGetData($stTemp,1)

	; Magic Number check (0x10B = PE32, 0x107 = ROM image, 0x20B = PE32+ (x64)
	If $iTemp<>0x10B And $iTemp<>0x20B Then Return SetError(__FGWPEIHelper($pFileInMem,$hFileMapObj,7),$iTemp,"")
#cs
	; ------------------------------------------------------------------------------------------------------
	; Set Offset of Export/Import Table info in IMAGE_DATA_DIRECTORY array based on PE type (32 or 32+ [x64])
	;	(This is actually the 1st of 16 of these structures.)
	; What follows the IMAGE_DATA_DIRECTORY structs is the IMAGE_SECTION_HEADER structs (* $iNumSections),
	;	which we place the offset of into $iSectionOffset
	; ------------------------------------------------------------------------------------------------------
#ce
	If $iTemp=0x10B Then
		$iImExportOffset=120	; 96+20+4	; PE(32)  (Export Offset) [Import is 8 after at 104/128]
		$iSectionOffset=248		; 224+20+4
		$bPE32Plus=False
	Else
		$iImExportOffset=136	; 112+20+4	; PE32+ (x64) (Export Offset) [Import is 8 after at 120/144]
		$iSectionOffset=264		; 240+20+4
		$bPE32Plus=True
	EndIf
	; Final Adjustment 0 (Import): add 8 (Import IMAGE_DATA_DIRECTORY is 8 after Export (both PE32/PE32+))
	If $iType=0 Then $iImExportOffset+=8

	ConsoleWrite("PE Sig Offset:"&$iPESigOffset&", Im/Export Table info in IMAGE_DATA_DIRECTORY Offset:"&$iImExportOffset&@CRLF)

; IMAGE_DATA_DIRECTORY structures (16 total) - we just look at Import or Exports for now

	; RVA Address of Im/Export Table, Size of Im/Export Table
	$stTemp=DllStructCreate("dword;dword",$pFileInMem+$iPESigOffset+$iImExportOffset)
	$iImExportSize=DllStructGetData($stTemp,2)		; Size - useful for figuring out Import 'Forwarders'
	$iImExportOffset=DllStructGetData($stTemp,1)	; Now it points to Export Directory Table

	ConsoleWrite("Im/Export Size:"&$iImExportSize&", Im/Export RVA Addresss: "&$iImExportOffset&@CRLF)

	If $iImExportOffset=0 Then Return SetError(__FGWPEIHelper($pFileInMem,$hFileMapObj,8),0,"")

; IMAGE_SECTION_HEADERS structures ($iNumSections total)
	; Loop through to 'find' the section that contains the exports or imports
	;	(Normally the exports is in the 1st section, but the imports section isn't always..)
 	For $i=1 To $iNumSections

;~ 		$stTemp=DllStructCreate("char[8];dword;dword;dword;dword;dword;dword;ushort;ushort;dword",$pFileInMem+$iPESigOffset+$iSectionOffset)
;~ 		_DLLStructDisplay($stTemp,"char[8] Name;dword VirtualSize;dword VirtualAdress;dword SizeOfRawData;dword PointerToRawData;dword PointerToRelocations;dword PointerToLineNumbers;ushort NumberOfRelocations;ushort NumberOfLineNumbers;dword Characteristics")

		; Virtual Address, Size of Raw Data, Pointer To Raw Data
		$stTemp=DllStructCreate("dword[3]",$pFileInMem+$iPESigOffset+$iSectionOffset+12)
		$iVirtAdd=DllStructGetData($stTemp,1,1)
		; Does it fall within the address range?
		If $iVirtAdd<=$iImExportOffset And $iVirtAdd+DllStructGetData($stTemp,1,2)>$iImExportOffset Then
			$iRawPtr=DllStructGetData($stTemp,1,3)
			ConsoleWrite("Found RVA for:"&$iImExportOffset&", section #"&$i&", VirtAdd:"&$iVirtAdd&", RawPtr:"&$iRawPtr&@CRLF)
;~ 			ConsoleWrite("Raw Data Size:"&DllStructGetData($stTemp,1,2)&@CRLF)
			; Calculations are necessary to get from RVA (Relative Virtual Address) to File Offset:
			$iRVACalc= -$iVirtAdd+$iRawPtr
			ConsoleWrite(" Result of calculation (-$iVirtAdd+$iRawPtr)="&$iImExportOffset+$iRVACalc&@CRLF)
			ExitLoop
		EndIf
		$iSectionOffset+=40		; Next IMAGE_SECTION_HEADER
	Next
	; Nothing found in any of the sections?
	If $i>$iNumSections Then Return SetError(__FGWPEIHelper($pFileInMem,$hFileMapObj,9),0,"")
	; Set the needed data for the calling functions and return
	Dim $aLoadedPEData[6]=[$pFileInMem,$hFileMapObj,$bPE32Plus,$iRVACalc,$iImExportOffset,$iImExportSize]
	Return $aLoadedPEData
EndFunc



; ===================================================================================================================
;	--------------------	MAIN FUNCTION	--------------------
; ===================================================================================================================


; ===================================================================================================================
; Func _FileGetWinPEImports($sPEFile,$bUnMangle=False)
;
; Function to return Import function info for a Windows PE file (.DLL,.EXE files). Ignores extension.
;	*NOTE: Compressed executables will report Import information that is used for the *Decompress* part
;	  of the executable.  The actual Compressed executable Imports will need to be decompressed first
;	  in order to get the proper Imports info.  The Virtual Offset of Thunk can be ignored in these cases.
;
; $sPEFile = .DLL or .EXE filename to gather information from (extension is ignored)
; $bUnMangle = If True, C++ function names will be Undecorated/Unmangled. If False, they appear as they do
;		in the Imports section
;
; Returns:
;	Success: Array of Import Information, @error=0:
;		[0][0]  = Count of Imported Functions
;		[$i][0] = DLL Importing From
;		[$i][1] = Function name, or Ordinal #
;		[$i][2] = Hint # (if Function name is present) - These sometimes correspond to a DLL's export ordinal #'s
;		[$i][3] = Virtual Offset of Thunk (Offset in *loaded* Module that will contain the DLL function Address)
;				  NOTE: This won't be applicable for Compressed executables.
;				    Additionally, the Imports for Compressed executables are for the DeCompressor (see above*)
;	Failure: "" with @error set:
;		@error = -1 = Could not open file
;		@error =  1 = File does not exist
;		@error =  4 = 'MZ' signature could not be found (not a PE file)
;		@error =  5 = 'PE' signature could not be found (not a PE file)
;		@error =  6 = Machine Target not 32bit, x86-64, or IA64
;		@error =  7 = 'Magic' number not recognized (not PE32, PE32+, could be 'ROM (0x107), or unk.) @extended=number
;		@error =  8 = No Import data table found
;		@error =  9 = Import data table exists, but could not locate
;		@error = 10 = Import tables exist, but function names missing (typical in compressed files)
;
; Author: Ascend4nt
; ===================================================================================================================

Func _FileGetWinPEImports($sPEFile,$bUnMangle=False)
	Local $i,$iThunk,$iTemp,$sFunc,$sTemp,$iArrSz,$iArrOffset,$iTotal,$iRVACalc,$pFileInMem,$aLoadedPEData
	Local $iImportAdd,$sImportType,$stTemp

	$aLoadedPEData=__FileGetWinPEImExports($sPEFile,0)
	If @error Then Return SetError(@error,@extended,"")

	$iArrSz=500
	Dim $aImports[$iArrSz+1][4]

	If $aLoadedPEData[2] Then	; True = PE32+ (x64)
		$iImportAdd=8
		$sImportType="int64"	; must be signed
	Else
		$iImportAdd=4
		$sImportType="long"		; must be signed
	EndIf
#cs
	; --------------------------------------------------
	; $aLoadedPEData Array
	; --------------------------------------------------
	; [0]=$pFileInMem
	; [1]=$hFileMapObj
	; [2]=PE(32) = False, PE32+ (x64) = True
	; [3]=RVA (Relative Virtual Address) Calculation
	; [4]=RVA Offset of Import Directory Table
	; [5]=Size of Import Directory Table
	; --------------------------------------------------
#ce
	$pFileInMem=$aLoadedPEData[0]
	$iRVACalc=$aLoadedPEData[3]

; IMPORT DIRECTORY TABLE array (last in array has all 0's).  We must perform the RVA calc.
	$iArrOffset=$aLoadedPEData[4]+$iRVACalc
;~ 	$stTemp=DllStructCreate("dword;dword;dword;dword;dword",$pFileInMem+$iArrOffset)
;~ 	_DLLStructDisplay($stTemp,"dword ImportLookupTableRVA;dword TimeDateStamp;dword ForwarderChain;dword RVAModuleName;dword RVAImportAddressThunkTable")
	$iTotal=0
	While 1
		$stTemp=DllStructCreate("dword[5]",$pFileInMem+$iArrOffset)
		$iTemp=DllStructGetData($stTemp,1,4)
		If $iTemp=0 Then ExitLoop		; Found the last IMPORT_DIRECTORY_TABLE? (0 for Module Name is a good indication)

		$sTemp=_MemoryGetNullTermStringA($pFileInMem+$iTemp+$iRVACalc)
		ConsoleWrite("DLL Module found:"&$sTemp&@CRLF)

		; Offset of 'Thunk' replacements (these are altered to real function addresses upon loading)
		$iThunk=DllStructGetData($stTemp,1,5)	; (RVACalc isn't added because this will be a *loaded* address offset)
		$i=DllStructGetData($stTemp,1,1)		; Get ImportLookupTableRVA (but don't add RVACalc yet)

		; On Borland TLINK32 executables, the ImportLookupTableRVA will be set to 0
		If $i=0 Then
			; If the Thunk offset is 0 also, there's some other odd error
			If $iThunk=0 Then Return SetError(__FGWPEIHelper($pFileInMem,$aLoadedPEData[1],10),0,"")
			; Use the ImportAddressTableRVAThunk (+$iRVACalc) instead for $i.
			;  We can use this on files because *before* runtime loading, these 'arrays' point to the same data
			$i=$iThunk
		EndIf
		; Okay to add the $iRVACalc offset now ($iThunk remains fixed)
		$i+=$iRVACalc

		; Loop through all the function name/ordinals for the given module:
		While 1
			$stTemp=DllStructCreate($sImportType,$pFileInMem+$i)
			$iTemp=DllStructGetData($stTemp,1)
			If $iTemp=0 Then ExitLoop			; Last function RVA will be 0

			$iTotal+=1
			If $iTotal>$iArrSz Then				; Array needs resizing, ReDim
				$iArrSz+=50
				ReDim $aImports[$iArrSz+1][4]
			EndIf
			$aImports[$iTotal][0]=$sTemp		; Set the Module Name

			If $iTemp<0 Then					; Ordinal #? (top bit set)
				If $iImportAdd=8 Then			; x64 (PE32+)
					$iTemp+=(-9223372036854775807-1)	; 64-bit sign-removal Operation
				Else
					$iTemp=BitAND($iTemp,0x7FFFFFFF)
				EndIf
				$aImports[$iTotal][1]=$iTemp	; Set the Ordinal #
			Else
				$iTemp=$iTemp+$iRVACalc
				$stTemp=DllStructCreate("ushort",$pFileInMem+$iTemp)
				; Grab the Hint #
				$aImports[$iTotal][2]=DllStructGetData($stTemp,1)
				; Grab the Function name
				$sFunc=_MemoryGetNullTermStringA($pFileInMem+$iTemp+2)
				; Unmangle it if asked (C++ 'decorated'/mangled names start with a ? or @? usually)
				If $bUnMangle And StringInStr($sFunc,'?',1) Then $sFunc=_WinAPI_UndecorateName($sFunc)
				; And store it
				$aImports[$iTotal][1]=$sFunc
			EndIf
			$aImports[$iTotal][3]=Ptr($iThunk)
			$i+=$iImportAdd		; +4 for PE32, +8 for PE32+ (x64) [Next FunctionName/Ordinal RVA]
			$iThunk+=$iImportAdd
		WEnd
		$iArrOffset+=20		; Next IMPORT_DIRECTORY_TABLE entry
	WEnd
	ReDim $aImports[$iTotal+1][4]
	$aImports[0][0]=$iTotal
	__FGWPEIHelper($pFileInMem,$aLoadedPEData[1])
	Return $aImports
EndFunc


; ===================================================================================================================
; Func _FileGetWinPEExports($sPEFile,$bUnMangle=False)
;
; Function to return Export function info for a Windows PE file (.DLL files). Ignores extension.
;
;	*NOTE that Forwarder Strings are inserted where applicable in place of the Function Address Offsets,
;	 so *CHECK* with IsString() to determine if it is a Forwarder function string.
;
;	 Any time a 'Forwarder' string is encountered, it means the API function is redirected to another
;	 API function in another DLL module.  The format is as follows:
;	   DLLNAMENOEXTENSION.FunctionName
;	 Example: 'NTDLL.RtlFreeHeap' (found for function HeapFree in Kernel32.dll)
;	  What this means is the 'real' location of the function is in NTDLL.DLL,
;	   under the exported function name 'RtlFreeHeap'.  [which could be further forwarded, but is unlikely!]
;
; $sPEFile = .DLL filename to gather information from (extension is ignored)
; $bUnMangle = If True, C++ function names will be Undecorated/Unmangled. If False, they appear as they do
;		in the Exports section
;
; Returns:
;	Success: Array of Export Information, @error=0:
;		[0][0]  = Count of Exported Functions
;		[0][1]  = Original DLL Name (useless most of the time..)
;		[$i][0] = Exported Function Name
;		[$i][1] = Relative Function Address Offset or Forwarder String (check with IsString()) *see above for more
;		[$i][2] = Ordinal #
;	Failure: "" with @error set:
;		@error = -1 = Could not open file
;		@error =  1 = File does not exist
;		@error =  4 = 'MZ' signature could not be found (not a PE file)
;		@error =  5 = 'PE' signature could not be found (not a PE file)
;		@error =  6 = Machine Target not 32bit, x86-64, or IA64
;		@error =  7 = 'Magic' number not recognized (not PE32, PE32+, could be 'ROM (0x107), or unk.) @extended=number
;		@error =  8 = No Export data table found
;		@error =  9 = Export data table exists, but could not locate
;
; Author: Ascend4nt
; ===================================================================================================================

Func _FileGetWinPEExports($sPEFile,$bUnMangle=False)
	Local $i,$iTemp,$sFunc,$iArrOffset,$iBase,$iNameTotal,$iAddTotal,$iRVACalc,$pFileInMem,$aLoadedPEData
	Local $stTemp,$stFuncPtrs,$stNamePtrs,$stOrdinals

	$aLoadedPEData=__FileGetWinPEImExports($sPEFile,1)
	If @error Then Return SetError(@error,@extended,"")

#cs
	; ------------------------------------------------
	; $aLoadedPEData Array
	; ------------------------------------------------
	; [0]=$pFileInMem
	; [1]=$hFileMapObj
	; [2]=PE(32) = False, PE32+ (x64) = True
	; [3]=RVA (Relative Virtual Address) Calculation
	; [4]=RVA Offset of Export Directory Table
	; [5]=Size of Export Directory Table
	; --------------------------------------------------
#ce
	$pFileInMem=$aLoadedPEData[0]
	$iRVACalc=$aLoadedPEData[3]

; EXPORT DIRECTORY TABLE

;~ 	$stTemp=DllStructCreate("ulong;ulong;ushort;ushort;ulong;ulong;ulong;ulong;ulong;ulong;ulong",$pFileInMem+$aLoadedPEData[4]+$iRVACalc)
;~ 	_DLLStructDisplay($stTemp,"ulong Characteristics;ulong TimeDateStamp;ushort MajorVersion;ushort MinorVersion;ulong DLLName;ulong OrdinalBase;ulong NumberOfFunctions;ulong NumberOfNames;ulong RVAAddressOfFunctions;ulong RVAAddressOfNames;ulong RVAAddressOfNameOrdinals")

	; DLLName, OrdinalBase (# to add), TotalFunctions, TotalNames,
	;	RVA Address of Functions, RVA Address of Names, RVA Address of Ordinals
	$stTemp=DllStructCreate("dword[7]",$pFileInMem+$aLoadedPEData[4]+$iRVACalc+12)
	$iBase=DllStructGetData($stTemp,1,2)	; # to add to ordinal #'s to get external Ordinal #
	$iAddTotal=DllStructGetData($stTemp,1,3)	; Function Addresses total (can be >= Names total)
	$iNameTotal=DllStructGetData($stTemp,1,4)

	; All RVA Addresses must be converted
	; NOTE Here that the # of Function addresses can be > than # of Function names, and ordinal #'s
	;	are what is used to look INTO these Function pointer addresses
	$stFuncPtrs=DllStructCreate("dword["&$iAddTotal&"]",$pFileInMem+DllStructGetData($stTemp,1,5)+$iRVACalc)
	; Note that the NamePtrs are an array of RVA Addresses that ALSO need converting (see loop below)
	$stNamePtrs=DllStructCreate("dword["&$iNameTotal&"]",$pFileInMem+DllStructGetData($stTemp,1,6)+$iRVACalc)
	$stOrdinals=DllStructCreate("ushort["&$iNameTotal&"]",$pFileInMem+DllStructGetData($stTemp,1,7)+$iRVACalc)

	Dim $aExports[$iNameTotal+1][3]
	$aExports[0][0]=$iNameTotal
	; Original DLL Name (pointless perhaps, but well - its there)
	$aExports[0][1]=_MemoryGetNullTermStringA($pFileInMem+DllStructGetData($stTemp,1,1)+$iRVACalc)

	; Loop through and grab all Exports (names are pointed to using RVA Addresses and need the RVA calculation)
	For $i=1 To $iNameTotal
		$sFunc=_MemoryGetNullTermStringA($pFileInMem+DllStructGetData($stNamePtrs,1,$i)+$iRVACalc)	; Grab Function name
		; Unmangle it if asked (C++ 'decorated'/mangled names start with a ? or @? usually)
		If $bUnMangle And StringInStr($sFunc,'?',1) Then $sFunc=_WinAPI_UndecorateName($sFunc)
		$aExports[$i][0]=$sFunc		; And store it
		$iTemp=DllStructGetData($stOrdinals,1,$i)	; Get ordinal # for this function
		$aExports[$i][2]=$iTemp+$iBase		; Add the Ordinal Base # (usually 1, though not always! [comctl32.dll])
		; The function pointer is looked up by ordinal # (without Base added) (+1 is for 1-based Struct indexing)
		$iTemp=DllStructGetData($stFuncPtrs,1,$iTemp+1)
		; Check if the 'Function Pointer Offset' is really a 'Forwarder' RVA
		If $iTemp>=$aLoadedPEData[4] And $iTemp<$aLoadedPEData[4]+$aLoadedPEData[5] Then
			; If it fell within the Export section (start -> end), its a Forwarder RVA
			$aExports[$i][1]=_MemoryGetNullTermStringA($pFileInMem+$iTemp+$iRVACalc)
		Else
			$aExports[$i][1]=Ptr($iTemp)	; It was outside of bounds -> its an actual Function Pointer Offset
		EndIf
	Next
	__FGWPEIHelper($pFileInMem,$aLoadedPEData[1])
	Return $aExports
EndFunc
