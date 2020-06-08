AutoItSetOption("TrayIconHide", 1)
;раскомментируйте ниже три строчки и в переменную $nameThemes впишите имя вашей темы, то есть заменить имя SilverAS на имя вашей темы.
;$nameThemes = 'SilverAS'
;RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","Skinset","REG_SZ",@ScriptDir&'\'&$nameThemes&'\'&$nameThemes&'.uis')
;RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","Skinset2","REG_SZ",$nameThemes)
ShellExecute(@ScriptDir&'\wbload.exe','','','', @SW_HIDE )