; -----------------------------------------------------------------------------
; FastLZ Compression Machine Code UDF
; Purpose: Provide The Machine Code Version of FastLZ Algorithm In AutoIt
; Author: Ward
; FastLZ Copyright (C) 2005-2008 Ariya Hidayat (ariya@kde.org)
; -----------------------------------------------------------------------------

#Include-once
#Include <Memory.au3>

Global $_FLZ_CodeBuffer, $_FLZ_CodeBufferMemory
Global $_FLZ_Compress, $_FLZ_CompressLevel, $_FLZ_Decompress

Func _FLZ_Exit()
	$_FLZ_CodeBuffer = 0
	_MemVirtualFree($_FLZ_CodeBufferMemory, 0, $MEM_RELEASE)
EndFunc

Func _FLZ_Startup()
	If Not IsDllStruct($_FLZ_CodeBuffer) Then
		If @AutoItX64 Then
			Local $Code = '3wwAAIkOwOmeCBw7u9uoXgd+yUSuQTNVuAwBPA5UAVdWU+h9DIAkSGPqg/oDHkyJxnm+zwCNXCn+D45o/70vnLwkN1WDgcc4Dv+ZcxcilBiJZ+AGCOODwAAIOdB19MYGHwEPtgFMjUQp7wMKTgNBugJwShuIRgEq30xKwf25Fp7rKPEcE0SdCCkDOOp0csuJqEGDwnQBG4gRSUBgDvogD4Ss2G2s6Uk+OcgbhmXIhltsWYeEjX5pwGDaweIICWfCpQIvjtS/TuwDYOAIRAnYOjHQ8/ODJMwl/x8GZEyLHMSEFAzHQYoUJP+NDNg9/it2YIZqEeuRRcwMa446cG0odYYLRQKKuoV31jl1Y8DEUQM0GFXpDM/TOkoA/3YeQTpLA3VQGJ3DGQTrCRgL7Q2iF8yDswJFd+5FhdKFsPMhpInRQ73qOyr3hkWIFAmQKGr9wcHy4YH5BoY7D4f1DYGdwkCv6giD2SYgpRfC4QWO915BRo0UEUVM/wKp6VUX6sAUjfhtpUQH6k0hEurLBOtg0DHIzb5NWN3YTesB5yzEiHFdApwBpB41UB0fJCBNRPXV8e0nHmNc0EWb0qroTB4DiSTEQcYB1ufrImUKh5v+/RRI159B2XYH6y2EDstyKJVwJ5nNSQemuRSdKHXjORRFMNIRYlFz2EYCQw0j0DvFEL7IKfCYL0zEYIBbXl9dQXJc6MPEqGkDk2ME6ThrJGfA2+0l9EgFvECujP0SBi8QI5w/RAeLxAiKovB/aT9JjfTELwhFHyBUcylJ/SKaEjhNStFiEZQKEIgCEVKm/VNC9BDFBD7a91M1HZwgRiV9Kuvh03kgaun4qRICWaUOSSILFAPpTm4S/3yiEqQTPkiJwlVlQvf9mRz4CVj1RQSNWuCB6ckMm4wZYJeV/RBSS0kigXfi6eSJbzHAEU7FinGNQoG1sCaWVJKOFN93D6EgB3/H/AagGevs2UTEmwhXs8UWVhPOccm0CAj6hkDDzrKQWTnJEDIEiLTkxn4jAx9cYkJLiENz3Akrk2QsCCHIFOC0JvUCbytBCcw0L8swoZA+ifmYZ1jLzCJmwK06Qf90Sc0Q6JkktVGy13R5mqaQ2ZG6IK7PBs1p6oa7MR6QvZOxhUiLFInPQTcp1mDSbgb/gf37H5YxdoCZ645LSWV07RBMsT9h+yzB5Qa/1VfwOcU3daQy/JztoYfAjFJQ/8d2WCDNARQkdAjrGEQIxNZR+rY6xGNFd+1pQVgY2WUChPMZ3iYRklhQ2yDRUemGYlVMPTQTR8zUQsUTie+N1mGo38sIo/ksEgnXTOZqkjlQCphS75RB55Muz1um1Jf8NL7Q5Okx+bChsCz1ZtAZFMxjAprQSnOoMDVoy0fXJ+jB+jH4MVACy9DOykMUSXdNzYjLEZp9qc5M9cFizU3hTM27aVG7zdoCFQWACyCI0NiPunjt5cM0AmKUTxYnHDUsms/SglJnIvH9AUGB/iIlQPpimENzv4h2KcZFZwIibXdNKpFMy1yHN2aH+6YCvB/UXUM5t/w87UqUBDmPLEacZBAQ01gCUauUSGMR4VQklddREqICBD95ldMtEqbZVhsSiAURCeIGAvf9NkAH5bHeqAhNTEt3fdivnJTHHpIJmOCiE3dzaA2B7ZGpP3rrNQ1hJDL7Pv93TQgjLgNNkQI/BBHc/c2gE0XtlG+XPm8MIEI5y0EBhCL+iDoWuEBq/xGzu9IWhnfqr9Sb1IMC6ZNogX1zSCnSYi4dPw/pZfcowfmFCE/85ARWYpMCMkRYLogDlUj/F8Ylko2MCRJmkhLZ/Zc6uWPm5qRM0DYMwnQbFgLqB9qOLII1w01jRyguwQsa6UT7VBYPKXD3OQ+B+hWoFX4JFRAg+5kTUqw94FIMJvQ5Bon4wOgFEOtXkz98/JeE1VteEiDWDEtaKHK9cB+UDI7STWLJIf1iWWK/ZAPn6B9P9hyQwlCJlMfj+eAkw4Zp00+Hkewl7gmPw4H55B/B5mODp3rGO8sByeJIKdPl/kfqltrKXBPDyhlGJMmBy0wpyoBEo9Iz'
				$Code &= 'AwKJ89AxeRiwSAnbD4J5LFUcWu2WGtgPkWyxeWLKyhQDgT0pQby4i1FDcWuceNgoFgYbhfaIGA51Gl1YKzpaaw4vAWUDdIUvlvBWfsKwDPgoUASD2EtEZ6eEiKWthoXwdew4JFwruQyF5JjHii3eUZHuLReNVQw90pIcUxCWEOP+lARkGtIJ1pvs5YZm0d2OGHHmEHQ/KoNJtjLaBvBCKwvbKH9klYhxUPHIJ3XuLxSyG+oG1ogZ8nZcQi6ZdE4gjCMT3T+izgp07enVYZQT2ELJbrpNUJLPFaaEVJdVV5TDMNCLiBo9BV31VcJCLDPQv2hJ64IpwOkykrOAv4PnH0ns8arJscD/vRySNDBUwFQq0PLw/RXB7QW7QPoGzsAp+SPqVIrwhVRMEJoUOdbsf5mVBIn6ScWOk2vJ1LBogefCaBpJKW3SigZExQmOSomM6ArA/YRFwSiwIVy9SbDy1y2/qGI7QEwDkonNHQoORBUdFnQTgoQoREmYD7LoJ1QqAoXaRE5L8SJMidAEtk0suISB1EwitiEwEFfGLBDgUO69LYSRui0PkqsgmnGZBoXrUv+2LiwrKraIxFQ40uIrIkVsOTg9Saj7o2H5jNlzS1TVBELritWOMFHFBulIyK/KUtbqsHFaCO2EkIDrJrDG6To3SUSohIr8pe3XhFS/NPIbBbJZAWSpkkcbS3L00lf7qdeITM2GGOnOSbBseOQpqf4IFPE0abTA4uD4FkFbSU51PQwQmnJ7GSiB6gmYlUgKgygtCoQZJHfnvRTCFS9MgwVTwwAA'
		Else
			Local $Code = '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'
				$Code &= 'QDMxEcNQOsdRZg4CIX2NkP55wVD223RoFeOStDbwAfnNKANAzzk6BPJ+GijX0bZ6+7ScJDcPdmHK3/cspqS2Crcc4h3v32Y73R09XPXdEnzUCgSE6wgGhOshtQDp/wR3MM+La417+7gkZQKo/aHkwpPl2jyGhVQP8gE9weIf99rAXBP8hdt06jEx0pCCDBC6gCYXMqKWJXXwKXGIiM0avnWvWvXZFoesJdscWvJUOUjQD4JQaxAUSRYXMggaXsYz+oU97Y1NO0HLMTpBNHQXsbQoTBa6IjoQXF6N1bLwLCSYVrhrGAh2ZjYrjX1z+qCRiG+J+yl/hktkl40UAnTc6U+lFQoVr0MciAiaSKhDGUDHolKSkNnOxQMI0yl19bs8uhxVvs1Cojm7nIkEMOm/1LuLOdJnNqJ+AWw5RTIhNiUxVAaWLL5ieSONTGMJK/gX9hp1kUlaxhYoTdJYHCnOgtaNVv9sHmlXPUMb6nxkIXiphBAvg8exOfCVpDUWaWIiBo1OwaYQVOuMJFaEid50viVlEk4Q0INIFuLWNkPeyO5fkP6icwTuSPVkdEg0/kIWyESQwA6o/v8wos4+9vyERhc+SMJ9iV8KnaHahDVMjekgGnuBnAIfcWgEBul5s2RqtBEgnJMAZGgqVPzpY1MrgfmElOuCBTWRkVYkYQ5Kv1NaUpsJWgIRuNdxDzAROLLvNekSRyejCL6UWP4NsyoLNVGJ4QOhCD2GJXRyKIHpCDiDCSEtH+uMKcEZiXLgLsyL6gdABP+cAA=='
 		EndIf
		Local $Opcode = String(_FastLZ_CodeDecompress($Code))
		$_FLZ_Compress = (StringInStr($Opcode, "89C0") - 3) / 2
		$_FLZ_CompressLevel = (StringInStr($Opcode, "89DB") - 3) / 2
		$_FLZ_Decompress = (StringInStr($Opcode, "89C9") - 3) / 2
		$Opcode = Binary($Opcode)

		$_FLZ_CodeBufferMemory = _MemVirtualAlloc(0, BinaryLen($Opcode), $MEM_COMMIT, $PAGE_EXECUTE_READWRITE)
		$_FLZ_CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]", $_FLZ_CodeBufferMemory)
		DllStructSetData($_FLZ_CodeBuffer, 1, $Opcode)
		OnAutoItExitRegister("_FLZ_Exit")
	EndIf
EndFunc

#cs
	Compress a block of data in the input buffer and returns the size of
	compressed block. The size of input buffer is specified by length. The
	minimum input buffer size is 16.

	The output buffer must be at least 5% larger than the input buffer
	and can not be smaller than 66 bytes.

	If the input is not compressible, the return value might be larger than
	length (input buffer size).
#ce
Func _FastLZ_Compress_Core($Data, $Level = Default)
	If Not IsDllStruct($_FLZ_CodeBuffer) Then _FLZ_Startup()

	$Data = Binary($Data)
	Local $InputLen = BinaryLen($Data)
	Local $Input = DllStructCreate("byte[" & $InputLen & "]")
	DllStructSetData($Input, 1, $Data)

	Local $OutputLen = Ceiling($InputLen * 1.06) + 66
	Local $Output = DllStructCreate("byte[" & $OutputLen & "]")

	If IsKeyword($Level) Then
		Local $Ret = DllCall("user32.dll", "uint", "CallWindowProc", "ptr", DllStructGetPtr($_FLZ_CodeBuffer) + $_FLZ_Compress, _
														"ptr", DllStructGetPtr($Input), _
														"uint", $InputLen, _
														"ptr", DllStructGetPtr($Output), _
														"int", 0)
	Else
		If $Level <> 1 Then $Level = 2
		Local $Ret = DllCall("user32.dll", "uint", "CallWindowProc", "ptr", DllStructGetPtr($_FLZ_CodeBuffer) + $_FLZ_CompressLevel, _
														"uint", $Level, _
														"ptr", DllStructGetPtr($Input), _
														"uint", $InputLen, _
														"ptr", DllStructGetPtr($Output))
	EndIf

	Return BinaryMid(DllStructGetData($Output, 1), 1, $Ret[0])
EndFunc

#cs
	Decompress a block of compressed data and returns the size of the
	decompressed block. If error occurs, e.g. the compressed data is
	corrupted or the output buffer is not large enough, then 0 (zero)
	will be returned instead.

	Decompression is memory safe and guaranteed not to write the output buffer
	more than what is specified in maxout.
#ce
Func _FastLZ_Decompress_Core($Data, $MaxBuffer)
	If Not IsDllStruct($_FLZ_CodeBuffer) Then _FLZ_Startup()

	$Data = Binary($Data)
	Local $InputLen = BinaryLen($Data)
	Local $Input = DllStructCreate("byte[" & $InputLen & "]")
	DllStructSetData($Input, 1, $Data)

	Local $Output = DllStructCreate("byte[" & $MaxBuffer & "]")

	$Ret = DllCall("user32.dll", "uint", "CallWindowProc", "ptr", DllStructGetPtr($_FLZ_CodeBuffer) + $_FLZ_Decompress, _
													"ptr", DllStructGetPtr($Input), _
													"uint", $InputLen, _
													"ptr", DllStructGetPtr($Output), _
													"uint", $MaxBuffer)

	Return BinaryMid(DllStructGetData($Output, 1), 1, $Ret[0])
EndFunc

Func _FastLZ_Compress($Data, $Level = Default)
	If Not IsDllStruct($_FLZ_CodeBuffer) Then _FLZ_Startup()

	$Data = Binary($Data)
	Local $InputLen = BinaryLen($Data)
	Return BinaryMid(Binary($InputLen), 1, 4) & _FastLZ_Compress_Core($Data, $Level)
EndFunc

Func _FastLZ_Decompress($Data)
	If Not IsDllStruct($_FLZ_CodeBuffer) Then _FLZ_Startup()

	$Data = Binary($Data)
	Local $OutputLen = Int(BinaryMid($Data, 1, 4))
	Return _FastLZ_Decompress_Core(BinaryMid($Data, 5), $OutputLen)
EndFunc

Func _FastLZ_CodeDecompress($Code)
	If @AutoItX64 Then
		Local $Opcode = '0x89C04150535657524889CE4889D7FCB28031DBA4B302E87500000073F631C9E86C000000731D31C0E8630000007324B302FFC1B010E85600000010C073F77544AAEBD3E85600000029D97510E84B000000EB2CACD1E8745711C9EB1D91FFC8C1E008ACE8340000003D007D0000730A80FC05730783F87F7704FFC1FFC141904489C0B301564889FE4829C6F3A45EEB8600D275078A1648FFC610D2C331C9FFC1E8EBFFFFFF11C9E8E4FFFFFF72F2C35A4829D7975F5E5B4158C389D24883EC08C70100000000C64104004883C408C389F64156415541544D89CC555756534C89C34883EC20410FB64104418800418B3183FE010F84AB00000073434863D24D89C54889CE488D3C114839FE0F84A50100000FB62E4883C601E8C601000083ED2B4080FD5077E2480FBEED0FB6042884C00FBED078D3C1E20241885500EB7383FE020F841C01000031C083FE03740F4883C4205B5E5F5D415C415D415EC34863D24D89C54889CE488D3C114839FE0F84CA0000000FB62E4883C601E86401000083ED2B4080FD5077E2480FBEED0FB6042884C078D683E03F410845004983C501E964FFFFFF4863D24D89C54889CE488D3C114839FE0F84E00000000FB62E4883C601E81D01000083ED2B4080FD5077E2480FBEED0FB6042884C00FBED078D389D04D8D7501C1E20483E03041885501C1F804410845004839FE747B0FB62E4883C601E8DD00000083ED2B4080FD5077E6480FBEED0FB6042884C00FBED078D789D0C1E2064D8D6E0183E03C41885601C1F8024108064839FE0F8536FFFFFF41C7042403000000410FB6450041884424044489E84883C42029D85B5E5F5D415C415D415EC34863D24889CE4D89C6488D3C114839FE758541C7042402000000410FB60641884424044489F04883C42029D85B5E5F5D415C415D415EC341C7042401000000410FB6450041884424044489E829D8E998FEFFFF41C7042400000000410FB6450041884424044489E829D8E97CFEFFFF56574889CF4889D64C89C1FCF3A45F5EC3E8500000003EFFFFFF3F3435363738393A3B3C3DFFFFFFFEFFFFFF000102030405060708090A0B0C0D0E0F10111213141516171819FFFFFFFFFFFF1A1B1C1D1E1F202122232425262728292A2B2C2D2E2F3031323358C3'
	Else
		Local $Opcode = '0x89C0608B7424248B7C2428FCB28031DBA4B302E86D00000073F631C9E864000000731C31C0E85B0000007323B30241B010E84F00000010C073F7753FAAEBD4E84D00000029D97510E842000000EB28ACD1E8744D11C9EB1C9148C1E008ACE82C0000003D007D0000730A80FC05730683F87F770241419589E8B3015689FE29C6F3A45EEB8E00D275058A164610D2C331C941E8EEFFFFFF11C9E8E7FFFFFF72F2C32B7C2428897C241C61C389D28B442404C70000000000C6400400C2100089F65557565383EC1C8B6C243C8B5424388B5C24308B7424340FB6450488028B550083FA010F84A1000000733F8B5424388D34338954240C39F30F848B0100000FB63B83C301E8CD0100008D57D580FA5077E50FBED20FB6041084C00FBED078D78B44240CC1E2028810EB6B83FA020F841201000031C083FA03740A83C41C5B5E5F5DC210008B4C24388D3433894C240C39F30F84CD0000000FB63B83C301E8740100008D57D580FA5077E50FBED20FB6041084C078DA8B54240C83E03F080283C2018954240CE96CFFFFFF8B4424388D34338944240C39F30F84D00000000FB63B83C301E82E0100008D57D580FA5077E50FBED20FB6141084D20FBEC278D78B4C240C89C283E230C1FA04C1E004081189CF83C70188410139F374750FB60383C3018844240CE8EC0000000FB654240C83EA2B80FA5077E00FBED20FB6141084D20FBEC278D289C283E23CC1FA02C1E006081739F38D57018954240C8847010F8533FFFFFFC74500030000008B4C240C0FB60188450489C82B44243883C41C5B5E5F5DC210008D34338B7C243839F3758BC74500020000000FB60788450489F82B44243883C41C5B5E5F5DC210008B54240CC74500010000000FB60288450489D02B442438E9B1FEFFFFC7450000000000EB9956578B7C240C8B7424108B4C241485C9742FFC83F9087227F7C7010000007402A449F7C702000000740566A583E90289CAC1E902F3A589D183E103F3A4EB02F3A45F5EC3E8500000003EFFFFFF3F3435363738393A3B3C3DFFFFFFFEFFFFFF000102030405060708090A0B0C0D0E0F10111213141516171819FFFFFFFFFFFF1A1B1C1D1E1F202122232425262728292A2B2C2D2E2F3031323358C3'
	EndIf
	Local $AP_Decompress = (StringInStr($Opcode, "89C0") - 3) / 2
	Local $B64D_Init = (StringInStr($Opcode, "89D2") - 3) / 2
	Local $B64D_DecodeData = (StringInStr($Opcode, "89F6") - 3) / 2
	$Opcode = Binary($Opcode)

	Local $CodeBufferMemory = _MemVirtualAlloc(0, BinaryLen($Opcode), $MEM_COMMIT, $PAGE_EXECUTE_READWRITE)
	Local $CodeBuffer = DllStructCreate("byte[" & BinaryLen($Opcode) & "]", $CodeBufferMemory)
	DllStructSetData($CodeBuffer, 1, $Opcode)

	Local $B64D_State = DllStructCreate("byte[16]")
	Local $Length = StringLen($Code)
	Local $Output = DllStructCreate("byte[" & $Length & "]")

	DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer) + $B64D_Init, _
													"ptr", DllStructGetPtr($B64D_State), _
													"int", 0, _
													"int", 0, _
													"int", 0)

	DllCall("user32.dll", "int", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer) + $B64D_DecodeData, _
													"str", $Code, _
													"uint", $Length, _
													"ptr", DllStructGetPtr($Output), _
													"ptr", DllStructGetPtr($B64D_State))

	Local $ResultLen = DllStructGetData(DllStructCreate("uint", DllStructGetPtr($Output)), 1)
	Local $Result = DllStructCreate("byte[" & ($ResultLen + 16) & "]")

	Local $Ret = DllCall("user32.dll", "uint", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer) + $AP_Decompress, _
													"ptr", DllStructGetPtr($Output) + 4, _
													"ptr", DllStructGetPtr($Result), _
													"int", 0, _
													"int", 0)


	_MemVirtualFree($CodeBufferMemory, 0, $MEM_RELEASE)
	Return BinaryMid(DllStructGetData($Result, 1), 1, $Ret[0])
EndFunc
