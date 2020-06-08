#include-once

Global Const $HASH_HAVAL128_3	= "HAVAL128_3"
Global Const $HASH_HAVAL128_4	= "HAVAL128_4"
Global Const $HASH_HAVAL128_5	= "HAVAL128_5"
Global Const $HASH_HAVAL160_3	= "HAVAL160_3"
Global Const $HASH_HAVAL160_4	= "HAVAL160_4"
Global Const $HASH_HAVAL160_5	= "HAVAL160_5"
Global Const $HASH_HAVAL192_3	= "HAVAL192_3"
Global Const $HASH_HAVAL192_4	= "HAVAL192_4"
Global Const $HASH_HAVAL192_5	= "HAVAL192_5"
Global Const $HASH_HAVAL224_3	= "HAVAL224_3"
Global Const $HASH_HAVAL224_4	= "HAVAL224_4"
Global Const $HASH_HAVAL224_5	= "HAVAL224_5"
Global Const $HASH_HAVAL256_3	= "HAVAL256_3"
Global Const $HASH_HAVAL256_4	= "HAVAL256_4"
Global Const $HASH_HAVAL256_5	= "HAVAL256_5"
Global Const $HASH_MD2			= "MD2"
Global Const $HASH_MD4			= "MD4"
Global Const $HASH_MD5			= "MD5"
Global Const $HASH_ED2K			= "ED2K"
Global Const $HASH_PANAMA    	= "PANAMA"
Global Const $HASH_RIPEMD128 	= "RIPEMD128"
Global Const $HASH_RIPEMD160 	= "RIPEMD160"
Global Const $HASH_RIPEMD256 	= "RIPEMD256"
Global Const $HASH_RIPEMD320 	= "RIPEMD320"
Global Const $HASH_SHA0      	= "SHA0"
Global Const $HASH_SHA1      	= "SHA1"
Global Const $HASH_SHA224    	= "SHA224"
Global Const $HASH_SHA256    	= "SHA256"
Global Const $HASH_SHA384    	= "SHA384"
Global Const $HASH_SHA512    	= "SHA512"
Global Const $HASH_TIGER     	= "TIGER"
Global Const $HASH_TIGER2    	= "TIGER2"
Global Const $HASH_WHIRLPOOL 	= "WHIRLPOOL"
Global Const $HASH_WHIRLPOOL0	= "WHIRLPOOL0"
Global Const $HASH_WHIRLPOOL1	= "WHIRLPOOL1"
Global Const $HASH_GOST     	= "GOST"
Global Const $HASH_CRC16     	= "CRC16"
Global Const $HASH_CRC32     	= "CRC32"
Global Const $HASH_ADLER32   	= "ADLER32"

Global $__HashDll = "Hash39.dll"

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
