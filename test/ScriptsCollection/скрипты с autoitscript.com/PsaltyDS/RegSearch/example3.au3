#include <_RegSearch.au3>
#include <Array.au3>

Global $sUninstallKey = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
Global $sValName = "UninstallString"

; Get array of all "UninstallString" values
$aUninstallKeys = _RegSearch($sUninstallKey, $sValName, 2, True) ; 2 = Match on Value Names only, True = return array

; Create 2D array for data
Global $aUninstallStrings[UBound($aUninstallKeys)][2] = [[$aUninstallKeys[0], ""]]

; Populate 2D array with value location and data
For $n = 1 To $aUninstallKeys[0]
    $aUninstallStrings[$n][0] = $aUninstallKeys[$n]
    $aUninstallStrings[$n][1] = RegRead(StringTrimRight($aUninstallStrings[$n][0], StringLen($sValName)), $sValName)
Next

; Display results
_ArrayDisplay($aUninstallStrings)