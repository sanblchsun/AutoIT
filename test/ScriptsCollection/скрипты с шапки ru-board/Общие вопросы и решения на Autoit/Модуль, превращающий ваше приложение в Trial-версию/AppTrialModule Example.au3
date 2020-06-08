#include <AppTrialModule.au3>

$n_APPTRIAL_EXPIRED_VALUE 	= 24
$n_APPTRIAL_MODE 			= 3 ;>= 1 seconds, >= 2 Minutes, >= 3 Hours, >= 4 Days.

$s_APPTRIAL_TITLE 			= "My Software" ;This will be used in Registry entry and other places
$s_APPTRIAL_MSG 			= "Your trial period (%s hours) has been expired."
$s_GET_PRODUCT_KEY_URL 		= "http://my-web-site.com/app_registration.html"

;We set AppTrial Module on 24 hours
_SetAppTrial_Module()

Switch @extended
	Case 0
		MsgBox(48, $s_APPTRIAL_TITLE & " - Trial Version", _
			StringFormat("You still can use this program, you have left <%s> hours :) ", _
				$n_APPTRIAL_EXPIRED_VALUE - Round($n_APPTRIAL_OVERTIME, 1)))
	Case 1
		MsgBox(64, $s_APPTRIAL_TITLE & " - Full Version", "This is full version, thank you for buying our software.")
EndSwitch

MsgBox(64, $s_APPTRIAL_TITLE, "The program working (for now? :) )...")