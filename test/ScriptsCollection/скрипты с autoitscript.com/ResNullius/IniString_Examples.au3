#include <Inet.au3>
#include <Array.au3>
#include "IniString.au3"

$sSource_Mem_Ini = _InetGetSource("http://www.autoitscript.com/autoit3/files/beta/update.dat")
;or
;$sSource_Mem_Ini = FileRead(@SCRIPTDIR & "\AutoIt.dat") ;read in ini from saved file


;============ _IniString_Read - Example ============
$sIniRead = _IniString_Read($sSource_Mem_Ini, "AutoIt", "FileSize", "NotFound")

MsgBox(4096 + 64, "_IniString_Read: [AutoIt] - filesize", _
	StringFormat("Sample of reading a key value from a section:\n\nFileSize=%s", $sIniRead))
;============ _IniString_Read - Example ============


;============ _IniString_ReadSectionNames - Example ============
MsgBox(4096 + 64, "_IniString_ReadSectionNames", "Sample of reading all section names into an array...")
$aReadSectionNames = _IniString_ReadSectionNames($sSource_Mem_Ini)

If @error Then
	MsgBox(4096 + 48, "_IniString_ReadSectionNames - Error", "Error occurred, probably no sections.")
Else
	_ArrayDisplay($aReadSectionNames, "Section Names - Results")
EndIf
;============ _IniString_ReadSectionNames - Example ============


;============ _IniString_ReadSection - Example ============
MsgBox(4096 + 64, "_IniString_ReadSection - [AutoitBeta]", "Sample of reading all key/value pairs from a section into an aray...")
$aReadSection = _IniString_ReadSection($sSource_Mem_Ini, "AutoItBeta")

If @error Then
	MsgBox(4096 + 48, "_IniString_ReadSection - Error", "Error occurred, probably no INI section.")
Else
	_ArrayDisplay($aReadSection, "Read Section - [AutoItBeta]")
EndIf
;============ _IniString_ReadSection - Example ============


;============ _IniString_RenameSection - Example ============
$sByRef_Mem_Ini = $sSource_Mem_Ini
If _IniString_RenameSection($sByRef_Mem_Ini, "AutoItBeta", "AutoIt_RC") then ; :)
	MsgBox(4096 + 64, "_IniString_RenameSection - Results", _
		StringFormat("Sample of renaming section.\nThe ''[AutoItBeta]'' section renamed..." & _
		"\n\nBEFORE:\n=======\n%s\n\nAFTER:\n======\n%s", $sSource_Mem_Ini, $sByRef_Mem_Ini))
Else
	MsgBox(4096 + 48, "_IniString_RenameSection - Error", "Error occurred, probably no INI section.")
EndIf
;============ _IniString_RenameSection - Example ============


;============ _IniString_Delete - Example ============
$sByRef_Mem_Ini = $sSource_Mem_Ini
_IniString_Delete($sByRef_Mem_Ini, "AutoIt", "index")

MsgBox(4096 + 64, "_IniString_Delete - Results", _
	StringFormat("Sample of deleting a key/value pair from a section.\n" & _
	"The ''index'' key has been deleted from the ''[AutoIt]'' section...\n\nBEFORE:\n=======\n%s\n\nAFTER:\n======\n%s", _
	$sSource_Mem_Ini, $sByRef_Mem_Ini))
;============ _IniString_Delete - Example ============


;============ _IniString_Delete (Section) - Example ============
$sByRef_Mem_Ini = $sSource_Mem_Ini
_IniString_Delete($sByRef_Mem_Ini, "AutoItBeta")

MsgBox(4096 + 64, "_IniString_Delete (Section) - Results", _
	StringFormat("Sample of deleting an entire section.\nThe ''[AutoitBeta]'' section has been deleted" & _
	"...\n\nBEFORE:\n=======\n%s\n\nAFTER:\n======\n%s", $sSource_Mem_Ini, $sByRef_Mem_Ini))
;============ _IniString_Delete (Section) - Example ============


;============ _IniString_Write - Example ============
$sByRef_Mem_Ini = $sSource_Mem_Ini
_IniString_Write($sByRef_Mem_Ini, "AutoIt","filetime","Some other time value ! ! ! !") ; rewrite existing key
_IniString_Write($sByRef_Mem_Ini, "AutoIt","downloads","2,145,637 ! ! ! !") ; write new key in existing section
_IniString_Write($sByRef_Mem_Ini, "AutoIt New", "KEY", "Some Value In <AutoIt New> Section ! ! ! !") ; write new key in new section

MsgBox(4096 + 64, "_IniString_Write - Results", _
	StringFormat("Sample of writing to keys/sections.\nThe ''filetime'' key is re-wriiten in the ''[AutoIt]'' section,\n" & _
		"a new ''downloads'' key is written to the ''[AutoIt]'' section,\n" & _
		"and a new key is written to the new ''[AutoIt New]'' section...\n\nBEFORE:\n=======\n%s\n\nAFTER:\n======\n%s", _
		$sSource_Mem_Ini, $sByRef_Mem_Ini))
;============ _IniString_Write - Example ============


;============ _IniString_WriteSection - (rewrite, with @LF delimited string) Example ============
$sByRef_Mem_Ini = $sSource_Mem_Ini
$sData = "Key1=Value1" & @LF & "Key2=Value2" & @LF & "Key3=Value3"

_IniString_WriteSection($sByRef_Mem_Ini, "AutoIT", $sData)
MsgBox(4096 + 64, "_IniString_WriteSection - Results", _
	StringFormat("Sample of writing whole section to existing section (overwite).\n" & _
	"The ''[AutoIt]'' section is overwritten using an @LF delimited list...\n\nBEFORE:\n" & _
	"=======\n%s\n\nAFTER:\n======\n%s", $sSource_Mem_Ini, $sByRef_Mem_Ini))
;============ _IniString_WriteSection - (rewrite, with @LF delimited string) Example ============


;============ _IniString_WriteSection - (new, with array) Example ============
$sByRef_Mem_Ini = $sSource_Mem_Ini
Dim $aData2[3][2] = [["FirstKey", "FirstValue"],["SecondKey", "SecondValue"],["ThirdKey", "ThirdValue"]]
; Since the array we made starts at element 0, we need to tell _IniString_WriteSection() to start writing from element 0.
_IniString_WriteSection($sByRef_Mem_Ini, "AutoIt 4", $aData2 ,0)

MsgBox(4096 + 64, "_IniString_WriteSection - Results", _
	StringFormat("Sample of writing whole new section.\nThe new ''[AutoIt 4]'' Using an 2D array as data passed to function..." & _
	"\n\nBEFORE:\n=======\n%s\n\nAFTER:\n======\n%s", $sSource_Mem_Ini, $sByRef_Mem_Ini))
;============ _IniString_WriteSection - (new, with array) Example ============
