#include <array.au3>; Only used for _ArrayDisplay
#include <_FileListToArrayEx.au3>
;Return all files/folders
$timer = TimerInit()
$hFilesFolders = _FileListToArrayEx(@WindowsDir)
$timer = Round(TimerDiff($timer) / 1000, 2) & ' сек'
_ArrayDisplay($hFilesFolders, $timer&' - Files and Folders')

$timer = TimerInit()
;Return all .exe and .txt files
$hFilesFolders = _FileListToArrayEx(@WindowsDir, '*.exe; *.txt')
$timer = Round(TimerDiff($timer) / 1000, 2) & ' сек'
_ArrayDisplay($hFilesFolders, $timer&' - Exe and Txt')

$timer = TimerInit()
;Return all files/folders that start with P
$hFilesFolders = _FileListToArrayEx(@WindowsDir, 'P*.*')
$timer = Round(TimerDiff($timer) / 1000, 2) & ' сек'
_ArrayDisplay($hFilesFolders, $timer&' - Files and Folders')

$timer = TimerInit()
;Return all files that start with M
$hFilesFolders = _FileListToArrayEx(@WindowsDir, 'M*.*', 1);May have none for this example
$timer = Round(TimerDiff($timer) / 1000, 2) & ' сек'
_ArrayDisplay($hFilesFolders, $timer&' - Files')

$timer = TimerInit()
;Return all folders that start with M
$hFilesFolders = _FileListToArrayEx(@WindowsDir, 'M*.*', 2)
$timer = Round(TimerDiff($timer) / 1000, 2) & ' сек'
_ArrayDisplay($hFilesFolders, $timer&' - Folders')

$timer = TimerInit()
;Return all files and folders unless they start with M
$hFilesFolders = _FileListToArrayEx(@WindowsDir, Default, Default, 'M*')
$timer = Round(TimerDiff($timer) / 1000, 2) & ' сек'
_ArrayDisplay($hFilesFolders, $timer&' - Files and Folders')

$timer = TimerInit()
;Return all files unless they start with M
$hFilesFolders = _FileListToArrayEx(@WindowsDir, -1, 1, 'M*');May have none for this example
$timer = Round(TimerDiff($timer) / 1000, 2) & ' сек'
_ArrayDisplay($hFilesFolders, $timer&' - Files')

$timer = TimerInit()
;Return all folders unless they start with M
$hFilesFolders = _FileListToArrayEx(@WindowsDir, -1, 2, 'M*')
$timer = Round(TimerDiff($timer) / 1000, 2) & ' сек'
_ArrayDisplay($hFilesFolders, $timer&' - Folders')