#include-once
#include <_ProcessUndocumented.au3>
; ===============================================================================================================================
; <_ProcessUndocumentedList.au3>
;
; 'Undocumented' (though 'suspiciously' documented-in-some-places) Process List function(s).  Uses NTQuery* function(s)
;
; Main Function(s):
;	_ProcessUDListEverything()	; Gets basically anything and everything for every running Process and it's threads
;								;  Big advantage of this is no special privileges or administrative mode required,
;								;   and works from 32->64 bit Processes.
;								; (inspired by Manko's _WinAPI_ThreadsnProcesses module)
;
; Dependencies:
;	<_ProcessFunctions.au3>			; main Process functions UDF
;	<_ProcessUndocumented.au3>		; 'Undocumented' main functions
;
; See also:
;	<_ProcessFunctions.au3>			; the main process functions
;	<_ProcessListFunctions.au3>		; Process List functions
;	<TestProcessFunctions.au3>		; GUI Interface allowing interaction with Process functions
;	<TestProcessFunctionsScratch.au3>	; Misc. tests of Process functions (a little experimental 'playground')
;	<_MemoryFunctionsEx.au3>		; Extended and 'undocumented' Memory Functions
;	<_MemoryScanning.au3>			; Advanced memory scan techniques using Assembly
;	<_ThreadFunctions.au3>			; Thread functions
;	<_ThreadRemote.au3>				; Functions for creating Remote Threads
;	<_ThreadContext.au3>			; Special Thread Context functions. ADVANCED and dangerous stuff here
;	<_ThreadUndocumented.au3>		; 'Undocumented' Thread functions - Mom warned you..
;	<_DLLFunctions.au3>				; DLL Load/Free Library and GetProcAddress functions
;	<_DLLInjection.au3>				; DLL Injection/UnInjection, using the same technique many others use
;	<_DLLStructInject.au3>			; Memory injection & manipulation of DLLStructs using functions in the _ProcessFunction UDF
;	<_ProcessCPUUsage.au3>			; Function for calculating CPU Usage..
;	<_WinTimeFunctions.au3>			; for use with _ProcessGetTimes()
;	<_WinAPI_GetPerformanceInfo.au3> ; Performance Info (Task-Manager type of stuff) [XP/2003+]
;	<_WinAPI_GetSystemInfo.au3>		; System Info - processor, memory info
;	<_NTQueryInfo.au3>				; my NT-undocumented playground. Lots of crazy stuff..
;
; Semi-related:
;	<_EnumChildWindows.au3>			; (really a _Win type of function though - might be renamed _WinListChildren)
;	<_GetPrivilege_SEDEBUG.au3>		; Adjust privileges for access to processes at higher privilege levels
;	<_PDHPerformanceCounters.au3>	; all kinds of performance, stats, and general info regarding processes (and much more).
;	<_WinWaitEx.au3>		; Waits on a window to 'exist' that matches a process ID. (for situations with same-titled windows)
;
; Various Resources ('Undocumented' and documented):
;
;	NTSTATUS codes - see 'ntstatus.h'
;
;  -----  DATATYPE Info Resources:  -----
;
;	Datatypes in WinAPI C/C++ headers:
;		WinNT.h, WinUser.h, WTypes.h, BaseTsd.h, wdm.h (DDK)
;
;	Fundamental Types (C++) @ MSDN [includes sizes]:
;		http://msdn.microsoft.com/en-us/library/cc953fe1%28VS.80%29.aspx
;	Windows Data Types (Windows) @ MSDN:
;		http://msdn.microsoft.com/en-us/library/aa383751%28VS.85%29.aspx
;
;  -----  UNDOCUMENTED Info Resources:  -----
;
;	Windows API Platform SDK Headers:
;	  winternl.h
;	Windows Driver Kit Headers (WDK or DDK):
;	  ntddk.h
;
;	Undocumented Functions by NTinternals (note: some internal links are broken, you should search the site using google):
;		http://undocumented.ntinternals.net/
;	Undocumented Windows API Structs - Process Hacker:
;		http://processhacker.sourceforge.net/hacking/structs.php
;	NirSoft Windows Vista Kernel Structures:
;		http://www.nirsoft.net/kernel_struct/vista/index.html
;	Win32 Thread Information Block:
;		http://en.wikipedia.org/wiki/Win32_Thread_Information_Block
;
;	UNDOCUMENTED Info Book (**GREAT RESOURCE**):
;		Windows 2000-XP Native API Reference
;
; Reference:
; 	See Manko's _WinAPI_ThreadsnProcesses
;	  @ http://www.autoitscript.com/forum/index.php?showtopic=88934
;
; Author: Ascend4nt, inspired by Manko's _WinAPI_ThreadsnProcesses
; ===============================================================================================================================


; ===================================================================================================================
;	--------------------	THREAD STATE VALUES	--------------------
; ===================================================================================================================

#cs
; -------------------------------------------------------------------------------------------------------------------
THREAD_STATE enum {
	StateInitialized,	; 0
	StateReady,			; 1
	StateRunning,		; 2
	StateStandby,		; 3
	StateTerminated,	; 4
	StateWait,			; 5
	StateTransition,	; 6
	StateUnknown		; 7
};
; -------------------------------------------------------------------------------------------------------------------
#ce
#cs
; -------------------------------------------------------------------------------------------------------------------
KWAIT_REASON enum {
	Executive,			; 0
	FreePage,			; 1
	PageIn,				; 2
	PoolAllocation,		; 3
	DelayExecution,		; 4
	Suspended,			; 5
	UserRequest,		; 6
	WrExecutive,		; 7
	WrFreePage,			; 8
	WrPageIn,			; 9
	WrPoolAllocation,	; 10
	WrDelayExecution,	; 11
	WrSuspended,		; 12
	WrUserRequest,		; 13
	WrEventPair,		; 14
	WrQueue,			; 15
	WrLpcReceive,		; 16
	WrLpcReply,			; 17
	WrVirtualMemory,	; 18
	WrPageOut,			; 19
	WrRendezvous,		; 20
	Spare2,				; 21
	Spare3,				; 22
	Spare4,				; 23
	Spare5,				; 24
	Spare6,				; 25
	WrKernel			; 26
};
; -------------------------------------------------------------------------------------------------------------------
#ce


; ===================================================================================================================
;	--------------------	GLOBAL STRUCTURE TAGS	--------------------
; ===================================================================================================================

#cs
; -------------------------------------------------------------------------------------------------------------------
; SYSTEM_THREADS:
; ThreadKernelTime, ThreadUserTime, ThreadCreateTime, ThreadWaitTime, ThreadAddress, ThreadProcessID, ThreadID, ThreadPriority,
;  ThreadBasePriority, ThreadContextSwitchCount, ThreadState, ThreadWaitReason
; -------------------------------------------------------------------------------------------------------------------
#ce
Dim $tag_SYS_THREAD_INFO="uint64;uint64;uint64;ulong;ptr;ulong_ptr;ulong_ptr;ulong;ulong;ulong;ulong;ulong;"
; IO_COUNTERS: Read/Write/Other Ops Count, Read/Write/Other Transfers
Dim $tag_IO_COUNTERS="uint64;uint64;uint64;uint64;uint64;uint64;"
#cs
; -------------------------------------------------------------------------------------------------------------------
; SYSTEM_PROCESSES (+ VM_COUNTERS):
; NextEntryOffset (in buffer), NumThreads, Reserved[3], CreateTime, UserTime, KernelTime, ImageNameLen, ImageNameMaxLen,
;  ImageName (unicode), BasePriority, ProcessID, ParentPID, HandleCount, SessionID, PageDirectoryBase/Reserved,
; [+ VM_COUNTERS]: PeakVirtualSz, VirtualSz, PageFaultCount, PeakWorkingSetSz, WorkingSetSz, QuotaPeakPagedPoolUsage,
;   QuotaPagedPoolUsage, QuotaPeakNonPagedPoolUsage, QuotaNonPagedPoolUsage, PagefileUsage, PeakPagefileUsage
; -------------------------------------------------------------------------------------------------------------------
#ce
Dim $tag_SYS_PROC_INFO="ulong;ulong;uint64[3];uint64;uint64;uint64;ushort;ushort;ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong;ulong;ulong;ulong_ptr;ulong_ptr;ulong;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;"
If @AutoItX64 Then $tag_SYS_PROC_INFO&="ulong UnkX64Var;"	; can set as ulong_ptr as well (located between 2 64-bit items)
$tag_SYS_PROC_INFO&=$tag_IO_COUNTERS 	; & $tag_SYS_THREAD_INFO [array of 'NumThreads' structures of this type]


; ===================================================================================================================
; Func _ProcessUDListEverything($vFilter=0,$iMatchMode=0,$bEnumThreads=True)
;
; Function to grab all Process and Thread information from the O/S.
;	Big advantage of this is no special privileges or administrative mode required, and works from 32->64 bit Processes.
;
; *NOTE: Process Creation Time is in UTC(GMT) FileTime
;	     Process Kernel & User Time are expressed in time in 100-nanosecond intervals. Milliseconds = time/1000
;
; $vFilter = (optional) Title or PID# to search for.
;	In title mode this can be direct match, a substring, or a PCRE (see $iMatchMode)
;	In PID# mode, this must be a number
; $iMatchMode = mode of matching title, PID# or Parent PID#:
;	0 = default match string (not case sensitive)
;	1 = match substring
;	2 = match regular expression
;	3 = match Process ID #
;	4 = match Parent Process ID #
; $bEnumThreads = If True (default), Threads are enumerated and embedded in the main Process List array
;				  If False, Threads aren't enumerated, and [27] will = ""
;
; Returns:
;	Success: Array of process info (with arrays of thread info embedded if $bEnumThreads=True)
;		[0][0] = Total # of Processes (0 = no matches found)
;		[0][1] = Total # of Threads (cumulative for all found processes)
;		[$i][0] = Process Name
;		[$i][1] = Process ID
;		[$i][2] = Parent PID
;		[$i][3] = Base Priority (8=normal)
;		[$i][4] = Creation Time (FileTime)
;		[$i][5] = User Time (ms)		[division is done in the function (by 1000)]
;		[$i][6] = Kernel Time (ms)	[division is done in the function (by 1000)]
;		[$i][7] = Handle Count
;		[$i][8] = Session ID
;		[$i][9] = Peak Virtual Size
;		[$i][10] = Virtual Size
;		[$i][11] = Page Fault Count
;		[$i][12] = Peak Working Set Size
;		[$i][13] = Working Set Size
;		[$i][14] = Quota Peak Paged Pool Usage
;		[$i][15] = Quota Paged Pool Usage
;		[$i][16] = Quota Peak Non-Paged Pool Usage
;		[$i][17] = Quota Non-Paged Pool Usage
;		[$i][18] = Pagefile Usage
;		[$i][19] = Peak Pagefile Usage
;		[$i][20] = Read Operations Count
;		[$i][21] = Write Operations Count
;		[$i][22] = Other Operations Count
;		[$i][23] = Read Transfers Count
;		[$i][24] = Write Transfers Count
;		[$i][25] = Other Transfers Count
;		[$i][26] = Number of Threads
;		[$i][27] = If $bEnumThreads, an embedded Threads Array (format follows). Otherwise it is set to ""
; -------------------- EMBEDDED THREADS ARRAY ----------------------------
;		[0][0] = # of Threads (0 = no matches found)
;		[$i][0] = Thread ID
;		[$i][1] = Process ID
;		[$i][2] = Thread Address ('ThreadStartAddress': in testing though, NOT the Thread Base Address [more like Thread current/'park' Address])
;		[$i][3] = Thread Base Priority
;		[$i][4] = Thread Priority
;		[$i][5] = Thread Creation Time (FileTime)
;		[$i][6] = Thread User Time (ms)		[division is done in the function (by 1000)]
;		[$i][7] = Thread Kernel Time (ms)	[division is done in the function (by 1000)]
;		[$i][8] = Thread Last Wait State Time (ticks)
;		[$i][9] = Thread Context Switch Count
;		[$i][10] = Thread State 		[see enumerations above]
;		[$i][11] = Thread Wait Reason	[see enumerations above]
;
;	Failure: "", with @error set
;		@error = 1 = invalid parameter
;		@error = 2 = DLLCall error (@extended = error code returned from DLLCall)
;		@error = 6 = Undocumented API call reported failure (not 'STATUS_SUCCESS'). NTSTATUS code will be returned in @extended
;		@error = 7 = NtQueryInformationProcess Size mismatch ($aRet[5]<>$iProcInfoSz)
;
; Typical @extended error codes:  STATUS_ACCESS_DENIED (0xC0000022), STATUS_INFO_LENGTH_MISMATCH (0xC0000004)
;
; Author: Ascend4nt, inspired by Manko's _WinAPI_ThreadsnProcesses
; ===================================================================================================================

Func _ProcessUDListEverything($vFilter=0,$iMatchMode=0,$bEnumThreads=True)
	Local $aRet,$aBigList,$aThreadList,$stBuffer,$stProcInfo,$stThreadInfo,$pBufPtr,$pThreadPtr
	Local $i,$iTemp,$iThreadOffset,$iThreadStSz,$iX64Offset=0,$iProcIndex=1
	Local $sTitle,$iPID,$iPPID,$bFilterOn=False,$bMatchMade=True
	Local $iNumThreads=0,$iTotalProcs=0,$iTotalThreads=0,$iAlloc=4096,$iProcListSz=100
	; x64: Adjust offset for IO Counters
	If @AutoItX64 Then $iX64Offset=1
	; Filter
	If (IsString($vFilter) And $vFilter<>"") Or (IsNumber($vFilter) And $iMatchMode>2) Then $bFilterOn=True

	; Loop up to a max of 256K buffer (probably better to limit it further)
	;	Note that only 2 passes should be required on XP+ (Win2000 doesn't return 'required buffer size' in $aRet[4])
	While $iAlloc<262144
		$stBuffer=DllStructCreate("ubyte["&$iAlloc&"]")
		; SystemProcessesAndThreadsInformation (class 5)
		$aRet=DllCall($_PUDhNTDLL,"long","NtQuerySystemInformation","int",5,"ptr",DllStructGetPtr($stBuffer),"ulong",$iAlloc,"ulong*",0)
		If @error Then Return SetError(2,@error,"")
		If $aRet[0]=0 Then ExitLoop		; STATUS_SUCCESS (0)

		; NTSTATUS error that is not 0xC0000004 (STATUS_INFO_LENGTH_MISMATCH)? Something unknown is wrong.
		If $aRet[0]<>0xC0000004 Then Return SetError(6,$aRet[0],"")
		If $aRet[4] Then
			$iAlloc=$aRet[4]
		Else
			$iAlloc*=2
		EndIf
	WEnd
	$pBufPtr=$aRet[2]	; (DllStructGetPtr($stBuffer))
	Dim $aBigList[$iProcListSz+1][28]
	; The two structure sizes below are needed for going through THREAD structures.
	;	Luckily, both are 64-bit aligned (divisible by 8), otherwise we'd need to do fixup math ($i+=8-(BitAnd($i,0x7))
	$iThreadOffset=DllStructGetSize(DllStructCreate($tag_SYS_PROC_INFO))	; x86= 184 bytes;  x64= 256 bytes
	$iThreadStSz=DllStructGetSize(DllStructCreate($tag_SYS_THREAD_INFO))	; x86= 64 bytes; x64= 80 bytes
	While 1
		; First/Next Process Info structure
		$stProcInfo=DllStructCreate($tag_SYS_PROC_INFO,$pBufPtr)

		; Get name.  Index 7 = ImageNameLen, 8 = ImageNameMaxLen, 9 = ImageNamePtr
		$sTitle=DllStructGetData(DllStructCreate("wchar["&DllStructGetData($stProcInfo,7)&"]",DllStructGetData($stProcInfo,9)),1)
		$iPID=DllStructGetData($stProcInfo,11)	; PID
		If $sTitle="" And $iPID=0 Then $sTitle="System Idle Process"	; special case - no string for System Idle process
		$iPPID=DllStructGetData($stProcInfo,12)	; Parent PID

		If $bFilterOn Then
			Switch $iMatchMode
				Case 0
					If $vFilter<>$sTitle Then $bMatchMade=False
				Case 1
					If StringInStr($sTitle,$vFilter)=0 Then $bMatchMade=False
				Case 2
					If Not StringRegExp($sTitle,$vFilter) Then $bMatchMade=False
				Case 3
					If $vFilter<>$iPID Then $bMatchMade=False
				Case Else
					If $vFilter<>$iPPID Then $bMatchMade=False
			EndSwitch
		EndIf
		If $bMatchMade Then
			$aBigList[$iProcIndex][0]=$sTitle
			$aBigList[$iProcIndex][1]=$iPID
			$aBigList[$iProcIndex][2]=$iPPID
			$aBigList[$iProcIndex][3]=DllStructGetData($stProcInfo,10)	; Base Priority
			$aBigList[$iProcIndex][4]=DllStructGetData($stProcInfo,4)	; Create Time (FileTime)
			$aBigList[$iProcIndex][5]=DllStructGetData($stProcInfo,5)/1000	; User Time (convert from 100-nanosecond interval to ms)
			$aBigList[$iProcIndex][6]=DllStructGetData($stProcInfo,6)/1000	; Kernel Time (convert from 100-nanosecond interval to ms)
			$aBigList[$iProcIndex][7]=DllStructGetData($stProcInfo,13)	; Handle Count
			$aBigList[$iProcIndex][8]=DllStructGetData($stProcInfo,14)	; Session ID
			; VM (Virtual Memory) Counters:
			; Peak Virtual Size, Virtual Size, Page Fault Count [#], Peak Working Set Size, Working Set Size, Quota Peak Paged Pool Usage,
			;  Quota Paged Pool Usage, Quota Peak Non-Paged Pool Usage, Quota Non-Paged Pool Usage, Pagefile Usage, Peak Pagefile Usage
			For $i=9 To 19
				$aBigList[$iProcIndex][$i]=DllStructGetData($stProcInfo,$i+7)	; 16 -> 26
			Next
			; IO (Input/Output or Read/Write) Counters:
			; Read,Write,Other Operations Count; Read,Write,Other Transfers Count
			For $i=20 To 25
				$aBigList[$iProcIndex][$i]=DllStructGetData($stProcInfo,$i+7+$iX64Offset)	; 27 -> 32 (note this is where x64 differs)
			Next
			; Thread counts for Process
			$iNumThreads=DllStructGetData($stProcInfo,2)	; # Threads
			$aBigList[$iProcIndex][26]=$iNumThreads
			$iTotalThreads+=$iNumThreads
	; Now to enumerate the threads
			If $bEnumThreads Then
				Dim $aThreadList[$iNumThreads+1][12]
				$pThreadPtr=$pBufPtr+$iThreadOffset

				For $i=1 To $iNumThreads
					$stThreadInfo=DllStructCreate($tag_SYS_THREAD_INFO,$pThreadPtr)
					$aThreadList[$i][0]=DllStructGetData($stThreadInfo,7)	; Thread ID
					$aThreadList[$i][1]=DllStructGetData($stThreadInfo,6)	; Thread's Process ID (kinda redundant [above], but..)
					$aThreadList[$i][2]=DllStructGetData($stThreadInfo,5)	; Thread Start Address [or 'park' address]
					$aThreadList[$i][3]=DllStructGetData($stThreadInfo,9)	; Thread Base Priority
					$aThreadList[$i][4]=DllStructGetData($stThreadInfo,8)	; Thread Priority
					$aThreadList[$i][5]=DllStructGetData($stThreadInfo,3)	; Thread Creation Time (FileTime)
					$aThreadList[$i][6]=DllStructGetData($stThreadInfo,2)/1000	; Thread User Time  (convert from 100-nanosecond interval to ms)
					$aThreadList[$i][7]=DllStructGetData($stThreadInfo,1)/1000	; Thread Kernel Time  (convert from 100-nanosecond interval to ms)
					$aThreadList[$i][8]=DllStructGetData($stThreadInfo,4)	; Thread Last Wait State Time (in clock ticks)
					$aThreadList[$i][9]=DllStructGetData($stThreadInfo,10)	; Thread Context Switch Count
					$aThreadList[$i][10]=DllStructGetData($stThreadInfo,11)	; Thread State
					$aThreadList[$i][11]=DllStructGetData($stThreadInfo,12)	; Thread Wait Reason
					; Next rotation
					$pThreadPtr+=$iThreadStSz
				Next
				$aThreadList[0][0]=$iNumThreads
				$aBigList[$iProcIndex][27]=$aThreadList		; Array *within* an array
			Else
				$aBigList[$iProcIndex][27]=""
			EndIf
	; Get ready for next rotation
			$iTotalProcs+=1
			$iProcIndex+=1
			If $iProcIndex>$iProcListSz Then
				$iProcListSz+=10
				ReDim $aBigList[$iProcListSz+1][28]
			EndIf

		EndIf
		$bMatchMade=True
		$iTemp=DllStructGetData($stProcInfo,1)	; next entry offset
		If $iTemp=0 Then ExitLoop
		$pBufPtr+=$iTemp
	WEnd
	ReDim $aBigList[$iTotalProcs+1][28]
	$aBigList[0][0]=$iTotalProcs
	$aBigList[0][1]=$iTotalThreads
	Return $aBigList
EndFunc
