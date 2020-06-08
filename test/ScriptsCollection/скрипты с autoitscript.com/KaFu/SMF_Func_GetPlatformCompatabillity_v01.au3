#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         KaFu

 Script Function:
	_GetPlatformCompatabillity
	If $PlatformCompatabillity < 3 Then ; XP
	If $PlatformCompatabillity > 2 Then ; Vista+

#ce ----------------------------------------------------------------------------

; http://www.autoitscript.com/forum/index.php?showtopic=107303&st=0&p=756879&hl=OSBuild&fromsearch=1&#entry756879
; NerdFencer
; #CONSTANTS# ===================================================================================================================
Global Const $Macro_SysNone = 0 ; Pre-Win2k
Global Const $Macro_Sys2000 = 1 ; Win2k line (Home Editions+server2000)
Global Const $Macro_Sys2003 = 2 ; WinXP line (Home Editions+server2003)
Global Const $Macro_Sys2008 = 3 ; WinVista line (Home Editions+server2008)
Global Const $Macro_Sys2010 = 4 ; Win7 line (Home Editions+server2008R2)

; @OSBuild
Global Const $MACRO_OSBUILD_NT31 = "528"
Global Const $MACRO_OSBUILD_NT35 = "807"
Global Const $MACRO_OSBUILD_NT351 = "1057"
Global Const $MACRO_OSBUILD_NT4 = "1381"
Global Const $MACRO_OSBUILD_NT5 = "2195"
Global Const $MACRO_OSBUILD_NT51 = "2600"
Global Const $MACRO_OSBUILD_NT52 = "3790"
Global Const $MACRO_OSBUILD_2000 = "2195"
Global Const $MACRO_OSBUILD_XP_ERA = "2600"
Global Const $MACRO_OSBUILD_XP_64_ERA = "3790"
Global Const $MACRO_OSBUILD_VISTA_ERA = "6000"
Global Const $MACRO_OSBUILD_VISTA_ERA_SP1 = "6001"
Global Const $MACRO_OSBUILD_VISTA_ERA_SP2 = "6002"
Global Const $MACRO_OSBUILD_7_ERA = "7600"
Global Const $MACRO_OSBUILD_XP = "2600"
Global Const $MACRO_OSBUILD_XP_64 = "3790"
Global Const $MACRO_OSBUILD_SERVER_2003 = "2600"
Global Const $MACRO_OSBUILD_SERVER_2003_SP2 = "2721"
Global Const $MACRO_OSBUILD_SERVER_2003_Beta2 = "2805"
Global Const $MACRO_OSBUILD_SERVER_2003_Latest = "3959"
Global Const $MACRO_OSBUILD_SERVER_2003_64 = "3790"
Global Const $MACRO_OSBUILD_SERVER_HOME = "3790"
Global Const $MACRO_OSBUILD_VISTA = "6000"
Global Const $MACRO_OSBUILD_VISTA_SP1 = "6001"
Global Const $MACRO_OSBUILD_VISTA_SP2 = "6002"
Global Const $MACRO_OSBUILD_SERVER_2008 = "6000"
Global Const $MACRO_OSBUILD_SERVER_2008_SP2 = "6002"
Global Const $MACRO_OSBUILD_7 = "7600"
Global Const $MACRO_OSBUILD_SERVER_2008_R2 = "7600"

; @OSVersion
Global Const $MACRO_OS_SERVER_2008_R2 = "WIN_2008R2"
Global Const $MACRO_OS_SERVER_2008 = "WIN_2008"
Global Const $MACRO_OS_7 = "WIN_7"
Global Const $MACRO_OS_VISTA = "WIN_VISTA"
Global Const $MACRO_OS_SERVER_2003 = "WIN_2003"
Global Const $MACRO_OS_XP = "WIN_XP"
Global Const $MACRO_OS_XPE = "WIN_XPe"
Global Const $MACRO_OS_2000 = "WIN_2000"
; #CONSTANTS# ===================================================================================================================

Global $PlatformCompatabillity = _Macro_GetPlatformCompatabillity()





; ===============================================================================================================================
; http://www.autoitscript.com/forum/index.php?showtopic=107303&st=0&p=756879&hl=OSBuild&fromsearch=1&#entry756879
; NerdFencer

; MsgBox(0,"",_Macro_GetPlatformCompatabillity())

; #FUNCTION# ====================================================================================================================
; Name...........: _Macro_GetPlatformCompatabillity
; Description ...: Returns a value describing the OS platform that is being run
; Syntax.........: _Macro_GetPlatformCompatabillity()
; Parameters ....: None.
; Return values .: Success      - $Macro_Sys2010, $Macro_Sys2008, $Macro_Sys2003, $Macro_Sys2000, or $Macro_SysNone
;                  Failure      - Error
; Author ........: Matthew McMullan (NerdFencer)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _Macro_GetPlatformCompatabillity()
	If @OSVersion == $MACRO_OS_SERVER_2008_R2 Or @OSVersion == $MACRO_OS_7 Then
		Return $Macro_Sys2010
	ElseIf @OSVersion == $MACRO_OS_SERVER_2008 Or @OSVersion == $MACRO_OS_VISTA Then
		Return $Macro_Sys2008
	ElseIf @OSBuild >= $MACRO_OSBUILD_XP And @OSBuild < $MACRO_OSBUILD_VISTA Then
		Return $Macro_Sys2003
	ElseIf @OSBuild >= $MACRO_OSBUILD_2000 Then
		Return $Macro_Sys2000
	EndIf
	Return $Macro_SysNone
EndFunc   ;==>_Macro_GetPlatformCompatabillity