#include <File.au3>
#include <Array.au3>
#include <Zip_UDF.au3>
;

; Parameters for test
$LogFile = @ScriptDir & "\ZipTestLog.log"
$SrcFile = @ScriptFullPath
$SrcFolder = @ScriptDir & "\ZipTestSrc"
$ZipFile = @ScriptDir & "\ZipTest.zip"
$DestFolder = @ScriptDir & "\ZipTestDest"

$UseExternalZipApp = True

; Run the test
_FileWriteLog($LogFile, "Starting test.............")

; Create zip file
$RetCode = _ZipCreate($ZipFile)
_FileWriteLog($LogFile, "Return code from _ZipCreate($ZipFile) = " & $RetCode & " and @Error = " & @error)

; Add a single file
$RetCode = _ZipAdd($ZipFile, $SrcFile)
_FileWriteLog($LogFile, "Return code from _ZipAdd($ZipFile, $SrcFile) = " & $RetCode & " and @Error = " & @error)

; Add a folder
$RetCode = _ZipAdd($ZipFile, $SrcFolder)
_FileWriteLog($LogFile, "Return code from _ZipAdd($ZipFile, $SrcFolder) = " & $RetCode & " and @Error = " & @error)

; List the contents of the zip file
$aList = _ZipList($ZipFile)
_FileWriteLog($LogFile, "List returned from _ZipList($ZipFile) with @Error = " & @error)
_ArrayDisplay($aList, "Results for: _ZipList($ZipFile)")

; Unzip to a new location
$RetCode = _UnZip($ZipFile, $DestFolder)
_FileWriteLog($LogFile, "Return code from _UnZip($ZipFile, $DestFolder) = " & $RetCode & " and @Error = " & @error)
