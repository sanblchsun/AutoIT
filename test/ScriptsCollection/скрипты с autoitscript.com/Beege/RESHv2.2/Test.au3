#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Comment=Comment
#AutoIt3Wrapper_Res_Description=Description
#AutoIt3Wrapper_Res_Fileversion=1.0.1.0
#AutoIt3Wrapper_Res_LegalCopyright=2012 You
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Add_Constants=n
#AutoIt3Wrapper_AU3Check_Parameters=-w 6
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/sci 0
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponlyincludes /sci 0
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****

#Region Global Variables and Constants
Global $var
#endregion Global Variables and Constants

#include-Once
#OnAutoItStartRegister "MyStartFunc"
;~ AutoIt Version: 4.3.2.1 (beta)
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#NoTrayIcon

;~ #include <oi_API.au3>
;~ #include <oi_DBG.au3>
;~ #include <oi_OBJ.au3>
;~ #include <oi_SRE.au3>

#include <Array.au3>
; hotkey 1
HotKeySet("!+^{F4}")
; hotkey 2 CTRL+ALT+SHIFT+F8
HotKeySet("!+^{F8}")

Static Global $ARRAY[3] = [0, "foo", 'bar']
Global $ARRAY2D[3][2] = [[0, 0],[1, "foo"],[2, 'bar']]
Global $BOOLEAN = True
Global $FLOAT = .234
Global $FLOAT1 = 1.234
Global $FLOAT2 = 1.234e21
Global $FLOAT3 = -1.234e21
Global $FLOAT4 = +1.234e21
Global $FLOAT5 = +1.234E-21
Global $FLOAT6 = -1.234E+21
Global $FLOAT7 = -1.234
Global $INTEGER = 1
Global $STRING = "FOO"
Global $DEFAULT = Default
Global $OBJECT = ObjCreate('WinHTTP.WinHTTPRequest.5.1')
Global Const $CONSTANT = 0x000001

ConsoleWrite('test send strings ^+{Break} and ^{end} or +{f1} hex 0xAGFD and Numbers 89766 ' & @CRLF)
ConsoleWrite('test hex 0xAGFD and Numbers 89766 and vars $test operators ) * & # and comments ;sdkfjsdl ' & @CRLF)

Global $var1, $var2 = 0, $var3 = "some string with ""quotes""; Let's test the parser on 'this' string.", $var4[1] = ["color: red;"] ; multiple declarations
Global $foo = "some string with ""quotes""; Let's test the parser" & _
		' on ' & _
		"'this' string.", $_bar___[3] = ["color: red;", '', .101] ; multiline and multiple declarations, don't forget the quotes
Global $sCheckQuotes = "lorem's; ipsum" ;  '
Global $sCheckQuotes2 = "lorem's; ""ipsum""" ;  '

Global $b_ ; This _ is not a continuation character, nor is the next one
Global $k_
Local $a[8][2] = [ _
		["Word", 4], _ ; but these are
		["Test", 3], _
		["pi", +3.14E-159], _ ; Associate the name with the value
		["e", 2.718281828465], _ ; Same here
		["test;1;2;3", 123], _
		[';', Asc(';')], _ ; This comment is removed, but the strings remain.
		["", 0] _
		]

;~ #cs - literal strings
Local $aQuotes, $aSBS[1000][2], $sCode = FileRead(@ScriptFullPath)

$aQuotes = StringRegExp($sCode, '[''"].*[''"]', 3)
For $i = 0 To UBound($aQuotes) - 1
	$aSBS[$i][0] = $aQuotes[$i]
Next
$aQuotes = StringRegExp($sCode, '"[^"\v]*"|''[^''\v]*''', 3)
For $i = 0 To UBound($aQuotes) - 1
	$aSBS[$i][1] = $aQuotes[$i]
Next

_ArrayDisplay($aSBS)
;~ #ce


While 1
	Sleep(100)
WEnd


;===============================================================================
;
; Function Name:   Foo
; Description:   This function does nothing
; Parameter(s): [boolean]
; Requirement(s):
; Return Value(s):
; Author(s):
;
;===============================================================================
;
Func Foo($sFoo, $aBar, $fBaz = Default)
	Return SetError(1, 0, False)
EndFunc   ;==>Foo

Func Bar($sFoo, _
		$aBar, _ ; comment here
		$fBaz = Default)
	Return SetError(1, 0, False)
EndFunc   ;==>Bar

Func Foobar _
		($ate42)
	Return SetError(1, 0, False)
EndFunc   ;==>Foobar

Func Baz($oFoo)
	Local Static $fBool = StringRegExp(Random(1, 9), "\x{034}\064")
	With $oFoo
		.bar
		.baz($fBool)
	EndWith
	SetError(1, 0, 0xDEADBEEF)
	Return
EndFunc   ;==>Baz

Func _Qux($WS = False)

	Local Const $CHARSET_CP1252_EX = '€‚ƒ„…††ˆ‰Š‹ŒŽ‘’“”•–—˜™Š›ŒžŸ¡¢£¤¥¦§¨©ª«¬­®¯°±´µ¶·¸º»¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ÷ØÙÚÛÜÝÞŸ'
	If $WS Then Return $CHARSET_CP1252_EX & Chr(0xA0)
	Return $CHARSET_CP1252_EX
EndFunc   ;==>_Qux

Func _Log2($x)
	Return Log($x) / Log(2) ; base 2 logarithm
EndFunc   ;==>_Log2

Func _DLLCallExample()
	Local $hwnd = WinGetHandle("[CLASS:Notepad]")
	$result = DllCall("user32.dll", "int", "GetWindowText", "hwnd", $hwnd, "str", "", "int", 32768)
	MsgBox(0, "", $result[0]) ; number of chars returned
	MsgBox(0, "", $result[2]) ; Text returned in param 2

	Local $sFileName = @SystemDir & '\shell32.dll'

	; Create a structure to store the icon index
	Local $stIcon = DllStructCreate("int")
	Local $stString = DllStructCreate("wchar[260]")
	Local $structsize = DllStructGetSize($stString) / 2
	DllStructSetData($stString, 1, $sFileName)

	; Run the PickIconDlg - '62' is the ordinal value for this function
	DllCall("shell32.dll", "none", 62, "hwnd", 0, "ptr", DllStructGetPtr($stString), "int", $structsize, "ptr", DllStructGetPtr($stIcon))

	$sFileName = DllStructGetData($stString, 1)
	Local $nIconIndex = DllStructGetData($stIcon, 1)

	; Show the new filename and icon index
	MsgBox(0, "Info", "Last selected file: " & $sFileName & @LF & "Icon-Index: " & $nIconIndex)
EndFunc   ;==>_DLLCallExample

Global Const $tagBITMAP = 'long bmType;long bmWidth;long bmHeight;long bmWidthBytes;ushort bmPlanes;ushort bmBitsPixel;ptr bmBits;'
Global Const $tagBITMAPINFOHEADER = 'dword biSize;long biWidth;long biHeight;ushort biPlanes;ushort biBitCount;dword biCompression;dword biSizeImage;long biXPelsPerMeter;long biYPelsPerMeter;dword biClrUsed;dword biClrImportant;'
Global Const $tagBITMAPV4HEADER = 'dword bV4Size;long bV4Width;long bV4Height;ushort bV4Planes;ushort bV4BitCount;dword bV4Compression;dword bV4SizeImage;long bV4XPelsPerMeter;long bV4YPelsPerMeter;dword bV4ClrUsed;dword bV4ClrImportant;dword bV4RedMask;dword bV4GreenMask;dword bV4BlueMask;dword bV4AlphaMask;dword bV4CSType;int bV4Endpoints[3];dword bV4GammaRed;dword bV4GammaGreen;dword bV4GammaBlue;'
Global Const $tagBITMAPV5HEADER = 'dword bV5Size;long bV5Width;long bV5Height;ushort bV5Planes;ushort bV5BitCount;dword bV5Compression;dword bV5SizeImage;long bV5XPelsPerMeter;long bV5YPelsPerMeter;dword bV5ClrUsed;dword bV5ClrImportant;dword bV5RedMask;dword bV5GreenMask;dword bV5BlueMask;dword bV5AlphaMask;dword bV5CSType;int bV5Endpoints[3];dword bV5GammaRed;dword bV5GammaGreen;dword bV5GammaBlue;dword bV5Intent;dword bV5ProfileData;dword bV5ProfileSize;dword bV5Reserved;'
;Global Const $tagBITMAPINFO = $tagBITMAPINFOHEADER & 'dword bmiColors[1];'
Global Const $tagDIBSECTION = $tagBITMAP & $tagBITMAPINFOHEADER & 'dword dsBitfields[3];ptr dshSection;dword dsOffset;'
Global Const $tagDISK_GEOMETRY = 'int64 Cylinders;dword MediaType;dword TracksPerCylinder;dword SectorsPerTrack;dword BytesPerSector;'
Global Const $tagDISK_GEOMETRY_EX = $tagDISK_GEOMETRY & 'int64 DiskSize;' ; & 'byte Data[n];'
Global Const $tagDTTOPTS = 'dword Size;dword Flags;dword clrText;dword clrBorder;dword clrShadow;int TextShadowType;' & $tagPOINT & ';int BorderSize;int FontPropId;int ColorPropId;int StateId;int ApplyOverlay;int GlowSize;ptr DrawTextCallback;lparam lParam;'
Global Const $tagENHMETAHEADER = 'dword Type;dword Size;long rcBounds[4];long rcFrame[4];dword Signature;dword Version;dword Bytes;dword Records;ushort Handles;ushort Reserved;dword Description;dword OffDescription;dword PalEntries;long Device[2];long Millimeters[2];dword PixelFormat;dword OffPixelFormat;dword OpenGL;long Micrometers[2];'
Global Const $tagEXTLOGPEN = 'dword PenStyle;dword Width;uint BrushStyle;dword Color;ulong_ptr Hatch;dword NumEntries' ; & 'dword StyleEntry[n];'
;Global Const $tagGUITHREADINFO = 'dword Size;dword Flags;hwnd hWndActive;hwnd hWndFocus;hwnd hWndCapture;hwnd hWndMenuOwner;hwnd hWndMoveSize;hwnd hWndCaret;long rcCaret[4];'
Global Const $tagHW_PROFILE_INFO = 'dword DockInfo;wchar ProfileGuid[39];wchar ProfileName[80];'
;Global Const $tagICONINFO = 'int Icon;dword xHotspot;dword yHotspot;ptr hMask;ptr hColor;'
Global Const $tagICONINFOEX = 'dword Size;int Icon;dword xHotspot;dword yHotspot;ptr hMask;ptr hColor;ushort ResID;wchar ModName[260];wchar ResName[260];'
Global Const $tagIO_COUNTERS = 'uint64 ReadOperationCount;uint64 WriteOperationCount;uint64 OtherOperationCount;uint64 ReadTransferCount;uint64 WriteTransferCount;uint64 OtherTransferCount;'
Global Const $tagJOBOBJECT_ASSOCIATE_COMPLETION_PORT = 'ulong_ptr CompletionKey;ptr CompletionPort;'
Global Const $tagJOBOBJECT_BASIC_ACCOUNTING_INFORMATION = 'int64 TotalUserTime;int64 TotalKernelTime;int64 ThisPeriodTotalUserTime;int64 ThisPeriodTotalKernelTime;dword TotalPageFaultCount;dword TotalProcesses;dword ActiveProcesses;dword TotalTerminatedProcesses;'
Global Const $tagJOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION = $tagJOBOBJECT_BASIC_ACCOUNTING_INFORMATION & $tagIO_COUNTERS
Global Const $tagJOBOBJECT_BASIC_LIMIT_INFORMATION = 'int64 PerProcessUserTimeLimit;int64 PerJobUserTimeLimit;dword LimitFlags;ulong_ptr MinimumWorkingSetSize;ulong_ptr MaximumWorkingSetSize;dword ActiveProcessLimit;ulong_ptr Affinity;dword PriorityClass;dword SchedulingClass;'
Global Const $tagJOBOBJECT_BASIC_PROCESS_ID_LIST = 'dword NumberOfAssignedProcesses;dword NumberOfProcessIdsInList' ; & 'ulong_ptr ProcessIdList[n];'
#cs
Global Const $tagJOBOBJECT_BASIC_UI_RESTRICTIONS = 'dword UIRestrictionsClass;'
Global Const $tagJOBOBJECT_END_OF_JOB_TIME_INFORMATION = 'dword EndOfJobTimeAction;'
Global Const $tagJOBOBJECT_EXTENDED_LIMIT_INFORMATION = $tagJOBOBJECT_BASIC_LIMIT_INFORMATION & $tagIO_COUNTERS & 'ulong_ptr ProcessMemoryLimit;ulong_ptr JobMemoryLimit;ulong_ptr PeakProcessMemoryUsed;ulong_ptr PeakJobMemoryUsed;'
Global Const $tagJOBOBJECT_GROUP_INFORMATION = '' ; & 'ushort ProcessorGroup[n];'
#ce

Global Const $tagJOBOBJECT_SECURITY_LIMIT_INFORMATION = 'dword SecurityLimitFlags;ptr JobToken;ptr SidsToDisable;ptr PrivilegesToDelete;ptr RestrictedSids;'
Global Const $tagLOGBRUSH = 'uint Style;dword Color;ulong_ptr Hatch;'

#comments-start
Global Const $tagLOGPEN = 'uint Style;dword Width;dword Color;'
Global Const $tagLUID = 'dword LowPart;long HighPart;'
#comments-end

Global Const $tagMSGBOXPARAMS = 'uint Size;hwnd hOwner;ptr hInstance;int_ptr Text;int_ptr Caption;dword Style;int_ptr Icon;dword_ptr ContextHelpId;ptr MsgBoxCallback;dword LanguageId;'

