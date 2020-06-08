#include-once

Global Const $HASH_MD5			= "MD5"
Global Const $HASH_SHA1      	= "SHA1"
Global Const $HASH_SHA224    	= "SHA224"
Global Const $HASH_SHA256    	= "SHA256"
Global Const $HASH_SHA384    	= "SHA384"
Global Const $HASH_SHA512    	= "SHA512"
Global Const $HASH_CRC16     	= "CRC16"
Global Const $HASH_CRC32     	= "CRC32"
Global Const $HASH_ADLER32   	= "ADLER32"

Global $__HashDll = "Hash9.dll"

Func _Hash($Type, $Data)
	Local $Buffer = DllStructCreate('byte[' & BinaryLen($Data) & ']')
	DllStructSetData($Buffer, 1, $Data)

	Local $Ret = DllCall($__HashDll, "str", "hash", "str", $Type, "ptr", DllStructGetPtr($Buffer), "uint", BinaryLen($Data))
	Return $Ret[0]
EndFunc

Func _HashFile($Type, $File)
	Local $Ret = DllCall($__HashDll, "str", "hashfile", "str", $Type, "str", $File)
	Return $Ret[0]
EndFunc
