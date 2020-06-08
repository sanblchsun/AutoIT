#include "Hash39DLL.au3" ; 36 Hash algorithm in normal DLL Version
;#include "Hash9DLL.au3"	 ;  8 Hash algorithm in normal DLL Version
;#include "Hash39.au3"	 ; 36 Hash algorithm in Pure Script Version With MemoryDll.au3
;#include "Hash9.au3"	 ;  8 Hash algorithm in Pure Script Version With MemoryDll.au3

Dim $TestString = "The quick brown fox jumps over the lazy dog"
Dim $HashList = "CRC16,CRC32,ADLER32,HAVAL128_3,HAVAL128_4,HAVAL128_5,HAVAL160_3,HAVAL160_4,HAVAL160_5,HAVAL192_3,HAVAL192_4,HAVAL192_5,HAVAL224_3,HAVAL224_4,HAVAL224_5,HAVAL256_3,HAVAL256_4,HAVAL256_5,MD2,MD4,MD5,ED2K,PANAMA,RIPEMD128,RIPEMD160,RIPEMD256,RIPEMD320,SHA0,SHA1,SHA224,SHA256,SHA384,SHA512,TIGER2,TIGER,WHIRLPOOL0,WHIRLPOOL1,WHIRLPOOL,GOST"
$HashList = StringSplit($HashList, ",")

Dim $Timer, $Hash, $i

For $i = 1 To $HashList[0]
	$Hash = _Hash($HashList[$i], $TestString)
	ConsoleWrite($HashList[$i] & ": " & $Hash & @CRLF)
Next

For $i = 1 To $HashList[0]
	$Hash = _HashFile($HashList[$i], @ScriptFullPath)
	ConsoleWrite($HashList[$i] & ": " & $Hash & @CRLF)
Next

