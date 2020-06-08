; Example 1
MsgBox(64,"Language ID - _GetLCID from @OSLang",@OSLang & @crlf & _GetLCID("0x" & @OSLang))

; Example 2
$DLL = DllOpen("kernel32.dll")
$LangID=DllCall ($DLL, "int", "GetUserDefaultLangID")
MsgBox(64,"Language ID - _GetLCID from GetUserDefaultLangID",hex($LangID[0],4) & @crlf & _GetLCID("0x" & hex($LangID[0],4)))


Func _GetLCID($iHex)
    Local $aArray = StringRegExp(_Locale_ID_LCID_Chart(), ";" & $iHex & "\|(.*?);", 3)
    If @error Then
        Return ""
    EndIf
    Return $aArray[0]
EndFunc   ;==>_GetLCID


Func _Locale_ID_LCID_Chart()
    ; http://msdn.microsoft.com/en-us/library/0h88fahh%28VS.85%29.aspx
    Local $sString = ";0x0436|1078,Afrikaans,af" & _
            ";0x041C|1052,Albanian,sq" & _
            ";0x3801|14337,Arabic - United Arab Emirates,ar-ae" & _
            ";0x3C01|15361,Arabic - Bahrain,ar-bh" & _
            ";0x1401|5121,Arabic - Algeria,ar-dz" & _
            ";0x0C01|3073,Arabic - Egypt,ar-eg" & _
            ";0x0801|2049,Arabic - Iraq,ar-iq" & _
            ";0x2C01|11265,Arabic - Jordan,ar-jo" & _
            ";0x3401|13313,Arabic - Kuwait,ar-kw" & _
            ";0x3001|12289,Arabic - Lebanon,ar-lb"
    $sString &= ";0x1001|4097,Arabic - Libya,ar-ly" & _
            ";0x1801|6145,Arabic - Morocco,ar-ma" & _
            ";0x2001|8193,Arabic - Oman,ar-om" & _
            ";0x4001|16385,Arabic - Qatar,ar-qa" & _
            ";0x0401|1025,Arabic - Saudi Arabia,ar-sa" & _
            ";0x2801|10241,Arabic - Syria,ar-sy" & _
            ";0x1C01|7169,Arabic - Tunisia,ar-tn" & _
            ";0x2401|9217,Arabic - Yemen,ar-ye" & _
            ";0x042B|1067,Armenian,hy" & _
            ";0x042C|1068,Azeri - Latin,az-az"
    $sString &= ";0x082C|2092,Azeri - Cyrillic,az-az" & _
            ";0x042D|1069,Basque,eu" & _
            ";0x0423|1059,Belarusian,be" & _
            ";0x0402|1026,Bulgarian,bg" & _
            ";0x0403|1027,Catalan,ca" & _
            ";0x0804|2052,Chinese - China,zh-cn" & _
            ";0x0C04|3076,Chinese - Hong Kong SAR,zh-hk" & _
            ";0x1404|5124,Chinese - Macau SAR,zh-mo" & _
            ";0x1004|4100,Chinese - Singapore,zh-sg" & _
            ";0x0404|1028,Chinese - Taiwan,zh-tw"
    $sString &= ";0x041A|1050,Croatian,hr" & _
            ";0x0405|1029,Czech,cs" & _
            ";0x0406|1030,Danish,da" & _
            ";0x0413|1043,Dutch - Netherlands,nl-nl" & _
            ";0x0813|2067,Dutch - Belgium,nl-be" & _
            ";0x0C09|3081,English - Australia,en-au" & _
            ";0x2809|10249,English - Belize,en-bz" & _
            ";0x1009|4105,English - Canada,en-ca" & _
            ";0x2409|9225,English - Caribbean,en-cb" & _
            ";0x1809|6153,English - Ireland,en-ie"
    $sString &= ";0x2009|8201,English - Jamaica,en-jm" & _
            ";0x1409|5129,English - New Zealand,en-nz" & _
            ";0x3409|13321,English - Phillippines,en-ph" & _
            ";0x1C09|7177,English - Southern Africa,en-za" & _
            ";0x2C09|11273,English - Trinidad,en-tt" & _
            ";0x0809|2057,English - Great Britain,en-gb" & _
            ";0x0409|1033,English - United States,en-us" & _
            ";0x0425|1061,Estonian,et" & _
            ";0x0429|1065,Farsi,fa" & _
            ";0x040B|1035,Finnish,fi"
    $sString &= ";0x0438|1080,Faroese,fo" & _
            ";0x040C|1036,French - France,fr-fr" & _
            ";0x080C|2060,French - Belgium,fr-be" & _
            ";0x0C0C|3084,French - Canada,fr-ca" & _
            ";0x140C|5132,French - Luxembourg,fr-lu" & _
            ";0x100C|4108,French - Switzerland,fr-ch" & _
            ";0x083C|2108,Gaelic - Ireland,gd-ie" & _
            ";0x043C|1084,Gaelic - Scotland,gd" & _
            ";0x0407|1031,German - Germany,de-de" & _
            ";0x0C07|3079,German - Austria,de-at"
    $sString &= ";0x1407|5127,German - Liechtenstein,de-li" & _
            ";0x1007|4103,German - Luxembourg,de-lu" & _
            ";0x0807|2055,German - Switzerland,de-ch" & _
            ";0x0408|1032,Greek,el" & _
            ";0x040D|1037,Hebrew,he" & _
            ";0x0439|1081,Hindi,hi" & _
            ";0x040E|1038,Hungarian,hu" & _
            ";0x040F|1039,Icelandic,is" & _
            ";0x0421|1057,Indonesian,id" & _
            ";0x0410|1040,Italian - Italy,it-it"
    $sString &= ";0x0810|2064,Italian - Switzerland,it-ch" & _
            ";0x0411|1041,Japanese,ja" & _
            ";0x0412|1042,Korean,ko" & _
            ";0x0426|1062,Latvian,lv" & _
            ";0x0427|1063,Lithuanian,lt" & _
            ";0x042F|1071,F.Y.R.O. Macedonia,mk" & _
            ";0x043E|1086,Malay - Malaysia,ms-my" & _
            ";0x083E|2110,Malay – Brunei,ms-bn" & _
            ";0x043A|1082,Maltese,mt" & _
            ";0x044E|1102,Marathi,mr"
    $sString &= ";0x0414|1044,Norwegian - Bokml,no-no" & _
            ";0x0814|2068,Norwegian - Nynorsk,no-no" & _
            ";0x0415|1045,Polish,pl" & _
            ";0x0816|2070,Portuguese - Portugal,pt-pt" & _
            ";0x0416|1046,Portuguese - Brazil,pt-br" & _
            ";0x0417|1047,Raeto-Romance,rm" & _
            ";0x0418|1048,Romanian - Romania,ro" & _
            ";0x0818|2072,Romanian - Republic of Moldova,ro-mo" & _
            ";0x0419|1049,Russian,ru" & _
            ";0x0819|2073,Russian - Republic of Moldova,ru-mo"
    $sString &= ";0x044F|1103,Sanskrit,sa" & _
            ";0x0C1A|3098,Serbian - Cyrillic,sr-sp" & _
            ";0x081A|2074,Serbian - Latin,sr-sp" & _
            ";0x0432|1074,Setsuana,tn" & _
            ";0x0424|1060,Slovenian,sl" & _
            ";0x041B|1051,Slovak,sk" & _
            ";0x042E|1070,Sorbian,sb" & _
            ";0x040A|1034,Spanish - Spain (Traditional),es-es" & _
            ";0x2C0A|11274,Spanish - Argentina,es-ar" & _
            ";0x400A|16394,Spanish - Bolivia,es-bo"
    $sString &= ";0x340A|13322,Spanish - Chile,es-cl" & _
            ";0x240A|9226,Spanish - Colombia,es-co" & _
            ";0x140A|5130,Spanish - Costa Rica,es-cr" & _
            ";0x1C0A|7178,Spanish - Dominican Republic,es-do" & _
            ";0x300A|12298,Spanish - Ecuador,es-ec" & _
            ";0x100A|4106,Spanish - Guatemala,es-gt" & _
            ";0x480A|18442,Spanish - Honduras,es-hn" & _
            ";0x080A|2058,Spanish - Mexico,es-mx" & _
            ";0x4C0A|19466,Spanish - Nicaragua,es-ni" & _
            ";0x180A|6154,Spanish - Panama,es-pa"
    $sString &= ";0x280A|10250,Spanish - Peru,es-pe" & _
            ";0x500A|20490,Spanish - Puerto Rico,es-pr" & _
            ";0x3C0A|15370,Spanish - Paraguay,es-py" & _
            ";0x440A|17418,Spanish - El Salvador,es-sv" & _
            ";0x380A|14346,Spanish - Uruguay,es-uy" & _
            ";0x200A|8202,Spanish - Venezuela,es-ve" & _
            ";0x0430|1072,Southern Sotho,st" & _
            ";0x0441|1089,Swahili,sw" & _
            ";0x041D|1053,Swedish - Sweden,sv-se" & _
            ";0x081D|2077,Swedish - Finland,sv-fi"
    $sString &= ";0x0449|1097,Tamil,ta" & _
            ";0X0444|1092,Tatar,tt" & _
            ";0x041E|1054,Thai,th" & _
            ";0x041F|1055,Turkish,tr" & _
            ";0x0431|1073,Tsonga,ts" & _
            ";0x0422|1058,Ukrainian,uk" & _
            ";0x0420|1056,Urdu,ur" & _
            ";0x0843|2115,Uzbek - Cyrillic,uz-uz" & _
            ";0x0443|1091,Uzbek – Latin,uz-uz" & _
            ";0x042A|1066,Vietnamese,vi"
    $sString &= ";0x0434|1076,Xhosa,xh" & _
            ";0x043D|1085,Yiddish,yi" & _
            ";0x0435|1077,Zulu,zu"

    Return $sString

EndFunc   ;==>_Locale_ID_LCID_Chart

 