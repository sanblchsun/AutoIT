#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Sound.au3>

;Global $ElecPiano2Bt, $Harpsi2Bt, $PipeBt, $TrumpetBt, $TromboneBt, $SynBass1Bt, $SynBass2Bt, $PianoBt, $BrightPianoBt
;Global $ShakBt, $BassonBt, $BassonBt, $KalimbaBt
Global $msg, $Sound, $Piano, $BrightPiano, $ElectGrand, $HonkyTonk, $ElecPiano1, $ElecPiano2, $Clav,$Harpsi, $Dulc
Global $Drawbar, $Percuss, $Rock, $Pipe, $Reed, $Accord, $Harm, $Band, $SynthBass1, $SynthBass2, $Ahh, $Doo, $SynVoice
Global $Trumpet, $Trombone, $Tuba, $MuteTrmp, $FrenchHrn, $BrassSec, $NewAge, $Warm,  $PolySyn, $Choir, $Bowed
Global $Metallic, $Halo ,$Sweep, $Rain, $SoundTrack, $Crystal, $Atmos, $Bright, $Goblins, $Echo, $SciFi, $Metallic
Global $Square, $Saw, $Calli, $Chiff, $Char, $Voice, $Bass, $Piccolo, $Flute, $Recorder, $PanFlute, $Bottle, $Shak
Global $Ocarina, $Whistle, $Piccolo, $SopSax, $AltoSax, $TenorSax, $BariSax, $Oboe, $EngHorn, $Bassoon, $Clarinet
Global $BagPipe, $Shanai, $PIzzStrings, $Harp, $Sitar, $Banjo, $Shamisen, $Koto, $Sitar, $Kalimba, $Upright, $Finger
Global $Pick, $Fretless, $Slap1, $Slap2, $Contra, $Breath, $SeaShore, $Tweet, $Telephone, $Applause, $Helicopter, $Gun
Global $Fiddle, $Violin, $Viola, $Cello, $Strings1, $Strings2, $Trem, $SynString1, $SynString2, $OrchHit, $Tinkle
Global $Agogo, $SteelDrm, $WdBlock, $MelTom, $RevCymbal,  $Taiko,  $Celesta,  $Glocken,  $MusBox,  $Vibra, $Marimba
Global $Nylon, $Steel, $Jazz, $Clean, $Mute, $OverDrive, $Distortion, $Harmonics, $Fret
Global $Tymp, $Bells, $Xylo, $Kalimba, $SynthDrum, $RevCymbal, $Stop


$MidiTest_1 = GUICreate("Midi Instrument Test", 635, 595, 75, 100)

;Piano Buttons
$PianoGroup = GUICtrlCreateGroup(" Piano ", 6, 6, 115, 185, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$PianoBt = GUICtrlCreateButton(" Piano", 				24, 22, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$BrightPianoBt = GUICtrlCreateButton("BrightPiano", 	24, 40, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ElectGrandBt = GUICtrlCreateButton("ElectGrand", 		24, 58, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$HonkyTonkBt = GUICtrlCreateButton("HonkyTonk", 		24, 76, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ElecPiano1Bt = GUICtrlCreateButton("Elect Piano1", 	24, 94, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ClavBt = GUICtrlCreateButton("Clav", 					24, 148, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$HarpsiBt = GUICtrlCreateButton("Harpsicord", 			24, 130, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ElectPiano2Bt = GUICtrlCreateButton("Elect Piano2", 	24, 112, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$DulcBt = GUICtrlCreateButton("Dulc", 					24, 166, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label1 = GUICtrlCreateLabel("1", 14, 24, 10, 17)
$Label2 = GUICtrlCreateLabel("2", 14, 42, 10, 17)
$Label3 = GUICtrlCreateLabel("3", 14, 60, 10, 17)
$Label4 = GUICtrlCreateLabel("4", 14, 78, 10, 17)
$Label5 = GUICtrlCreateLabel("5", 14, 96, 10, 17)
$Label6 = GUICtrlCreateLabel("6", 14, 114, 10, 17)
$Label7 = GUICtrlCreateLabel("7", 14, 132, 10, 17)
$Label8 = GUICtrlCreateLabel("8", 14, 150, 10, 17)
$Label16 = GUICtrlCreateLabel("16", 8, 168, 16, 17)

;Organ Buttons
$OrganGroup = GUICtrlCreateGroup(" Organ ", 6, 204, 115, 167, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$DrawbarBt = GUICtrlCreateButton("DrawBar", 24, 220, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$PercussBt = GUICtrlCreateButton("Percussive", 24, 238, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$RockBt = GUICtrlCreateButton("Rock", 24, 256, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$PipeBt = GUICtrlCreateButton("Pipe", 24, 274, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ReedBt = GUICtrlCreateButton("Reed", 24, 292, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$AccordBt = GUICtrlCreateButton("Accordian", 24, 310, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$HarmBt = GUICtrlCreateButton("Harmonica", 24, 328, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$BandBt = GUICtrlCreateButton("Bandoneon", 24, 346, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label17 = GUICtrlCreateLabel("17", 8, 220, 16, 17)
$Label18 = GUICtrlCreateLabel("18", 8, 238, 16, 17)
$Label19 = GUICtrlCreateLabel("19", 8, 256, 16, 17)
$Label20 = GUICtrlCreateLabel("20", 8, 274, 16, 17)
$Label21 = GUICtrlCreateLabel("21", 8, 292, 16, 17)
$Label22 = GUICtrlCreateLabel("22", 8, 310, 16, 17)
$Label23 = GUICtrlCreateLabel("23", 8, 328, 16, 17)
$Label24 = GUICtrlCreateLabel("24", 8, 346, 16, 17)

;Brass
$BrassGroup = GUICtrlCreateGroup(" Brass ", 6, 384, 115, 167, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$BrassSecBt = GUICtrlCreateButton("Brass Section", 		24, 402, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$FrenchHrnBt = GUICtrlCreateButton("French Horn", 		24, 420, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$MuteTrmptBt = GUICtrlCreateButton("Mute Trumpet", 		24, 438, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SyBrass1Bt = GUICtrlCreateButton("Synth Brass 1", 		24, 456, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SynBrass2Bt = GUICtrlCreateButton("Synth Brass 2", 	24, 474, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$TrombBt = GUICtrlCreateButton("Trombone", 				24, 492, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$TrumpBt = GUICtrlCreateButton("Trumpet", 				24, 510, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$TubaBt = GUICtrlCreateButton("Tuba", 					24, 528, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label57 = GUICtrlCreateLabel("57", 8, 403, 16, 17)
$Label58 = GUICtrlCreateLabel("58", 8, 421, 16, 17)
$Label59 = GUICtrlCreateLabel("59", 8, 440, 16, 17)
$Label60 = GUICtrlCreateLabel("60", 8, 458, 16, 17)
$Label61 = GUICtrlCreateLabel("61", 8, 476, 16, 17)
$Label62 = GUICtrlCreateLabel("62", 8, 494, 16, 17)
$Label63 = GUICtrlCreateLabel("63", 8, 512, 16, 17)
$Label64 = GUICtrlCreateLabel("64", 8, 530, 16, 17)

;Pads
$PadsGroup = GUICtrlCreateGroup(" Pads ", 125, 6, 124, 365, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$HaloBt = GUICtrlCreateButton("Halo", 				152, 184, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SweepBt = GUICtrlCreateButton("Sweep", 				152, 202, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$RainBt = GUICtrlCreateButton("Rain", 				152, 220, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SoundTrackBt = GUICtrlCreateButton("SoundTrack", 	152, 238, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$CrystalBt = GUICtrlCreateButton("Crystal", 			152, 256, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$GoblinsBt = GUICtrlCreateButton("Goblins", 			152, 310, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$BrightBt = GUICtrlCreateButton("Brightness", 		152, 292, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$AtmosBt = GUICtrlCreateButton("Atmosphere", 			152, 274, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$EchoBt = GUICtrlCreateButton("Echos", 				152, 328, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$AhhBt = GUICtrlCreateButton("Ahhs", 					152, 22, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$OooBt = GUICtrlCreateButton("Ooo", 					152, 40, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SynVoiceBt = GUICtrlCreateButton("Synth Voice", 		152, 58, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$NewAgeBt = GUICtrlCreateButton("NewAge", 			152, 76, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$WarmBt = GUICtrlCreateButton("Warm", 				152, 94, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$BowedBt = GUICtrlCreateButton("Bowed Glass", 		152, 148, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ChoirBt = GUICtrlCreateButton("Choir", 				152, 130, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$PolySynBt = GUICtrlCreateButton("PolySynth", 		152, 112, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$MetallicBt = GUICtrlCreateButton("Metallic", 		152, 166, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ScFiBt = GUICtrlCreateButton("Sc Fi", 				152, 346, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label_53 = GUICtrlCreateLabel("53", 134, 24, 16, 17)
$Label89 = GUICtrlCreateLabel("89", 134, 78, 16, 17)
$Label54 = GUICtrlCreateLabel("54", 134, 42, 16, 17)
$Label55 = GUICtrlCreateLabel("55", 134, 60, 16, 17)
$Label90 = GUICtrlCreateLabel("90", 134, 96, 16, 17)
$Label99 = GUICtrlCreateLabel("99", 134, 256, 16, 17)
$Label98 = GUICtrlCreateLabel("98", 134, 238, 16, 17)
$Label97 = GUICtrlCreateLabel("97", 134, 220, 16, 17)
$Label96 = GUICtrlCreateLabel("96", 134, 203, 16, 17)
$Label95 = GUICtrlCreateLabel("95", 134, 186, 16, 17)
$Label94 = GUICtrlCreateLabel("94", 134, 168, 16, 17)
$Label93 = GUICtrlCreateLabel("93", 134, 150, 16, 17)
$Label92 = GUICtrlCreateLabel("92", 134, 132, 16, 17)
$Label91 = GUICtrlCreateLabel("91", 134, 114, 16, 17)
$Label100 = GUICtrlCreateLabel("100", 128, 274, 22, 17)
$Label101 = GUICtrlCreateLabel("101", 128, 292, 22, 17)
$Label104 = GUICtrlCreateLabel("104", 128, 346, 22, 17)
$Label102 = GUICtrlCreateLabel("102", 128, 310, 22, 17)
$Label103 = GUICtrlCreateLabel("103", 128, 328, 22, 17)

;Pipe Buttons
$PipeGroup = GUICtrlCreateGroup(" Pipe ", 125, 384, 124, 167, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$PiccoloBt = GUICtrlCreateButton("Piccolo", 		152, 402, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$FluteBt = GUICtrlCreateButton("Flute", 			152, 420, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$RecorderBt = GUICtrlCreateButton("Recorder", 		152, 438, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$PanFluteBt = GUICtrlCreateButton("Pan Flute", 		152, 456, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$BottleBt = GUICtrlCreateButton("Bottle", 			152, 474, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ShakBt = GUICtrlCreateButton("Shakuhachi", 		152, 492, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$WhistleBt = GUICtrlCreateButton("Whistle", 		152, 510, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$OcarinaBt = GUICtrlCreateButton("Ocarina", 		152, 528, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label80 = GUICtrlCreateLabel("80", 134, 530, 16, 17)
$Label77 = GUICtrlCreateLabel("77", 134, 476, 16, 17)
$Label76 = GUICtrlCreateLabel("76", 134, 458, 16, 17)
$Label75 = GUICtrlCreateLabel("75", 134, 440, 16, 17)
$Label74 = GUICtrlCreateLabel("74", 134, 421, 16, 17)
$Label73 = GUICtrlCreateLabel("73", 134, 403, 16, 17)
$Label79 = GUICtrlCreateLabel("79", 134, 512, 16, 17)
$Label78 = GUICtrlCreateLabel("78", 134, 494, 16, 17)

;Synth Lead Buttons
$LeadGroup = GUICtrlCreateGroup(" Synth Lead ", 255, 6, 118, 163, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$CalliBt = GUICtrlCreateButton("Calliope", 		280, 22, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ChiffBt = GUICtrlCreateButton("Chiff", 		280, 40, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SawBt = GUICtrlCreateButton("Saw", 			280, 58, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SquareBt = GUICtrlCreateButton("Square", 		280, 76, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$BassBt = GUICtrlCreateButton("Bass + Lead", 	280, 94, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$FifthBt = GUICtrlCreateButton("Fifth", 		280, 112, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$VoiceBt = GUICtrlCreateButton("Voice", 		280, 130, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$CharBt = GUICtrlCreateButton("Charang", 		280, 148, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label88 = GUICtrlCreateLabel("88", 264, 150, 16, 17)
$Label85 = GUICtrlCreateLabel("85", 264, 96, 16, 17)
$Label84 = GUICtrlCreateLabel("84", 264, 78, 16, 17)
$Label82 = GUICtrlCreateLabel("82", 264, 42, 16, 17)
$Label83 = GUICtrlCreateLabel("83", 264, 59, 16, 17)
$Label81 = GUICtrlCreateLabel("81", 264, 23, 16, 17)
$Label87 = GUICtrlCreateLabel("87", 264, 132, 16, 17)
$Label86 = GUICtrlCreateLabel("86", 264, 114, 16, 17)

;Reed Buttons
$ReedGroup = GUICtrlCreateGroup(" Reed ", 255, 169, 118, 202, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$SopSaxBt = GUICtrlCreateButton("Soprano Sax", 		280, 184, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$AltoSaxBt = GUICtrlCreateButton("Alto Sax", 		280, 202, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$TenorSaxBt = GUICtrlCreateButton("Tenor Sax", 		280, 220, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$BariSaxBt = GUICtrlCreateButton("Bari Sax", 		280, 238, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$OboeBt = GUICtrlCreateButton("Oboe", 				280, 256, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ClarinetBt = GUICtrlCreateButton("Clarinet", 		280, 310, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$BassoonBt = GUICtrlCreateButton("Bassoon", 			280, 292, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$EngHornBt = GUICtrlCreateButton("English Horn", 	280, 274, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$BagPipeBt = GUICtrlCreateButton("BagPipe", 		280, 328, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ShanaiBt = GUICtrlCreateButton("Shanai", 		280, 346, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label72 = GUICtrlCreateLabel("72", 264, 310, 16, 17)
$Label69 = GUICtrlCreateLabel("69", 264, 256, 16, 17)
$Label68 = GUICtrlCreateLabel("68", 264, 238, 16, 17)
$Label67 = GUICtrlCreateLabel("67", 264, 220, 16, 17)
$Label66 = GUICtrlCreateLabel("66", 264, 203, 16, 17)
$Label65 = GUICtrlCreateLabel("65", 264, 186, 16, 17)
$Label71 = GUICtrlCreateLabel("71", 264, 292, 16, 17)
$Label70 = GUICtrlCreateLabel("70", 264, 274, 16, 17)
$Label110 = GUICtrlCreateLabel("110", 258, 328, 22, 17)
$Label112 = GUICtrlCreateLabel("112", 258, 346, 22, 17)

;Plucked Buttons
$PluckedGroup = GUICtrlCreateGroup(" Plucked ", 255, 421, 120, 129, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$PIzzStringsBt = GUICtrlCreateButton("PIzz Strings", 			280, 438, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$HarpBt = GUICtrlCreateButton("Harp", 							280, 456, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SitarBt = GUICtrlCreateButton("Sitar", 						280, 474, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$BanjoBt = GUICtrlCreateButton("Banjo", 						280, 492, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ShamisenBt = GUICtrlCreateButton("Shamisen", 					280, 510, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$KotoBt = GUICtrlCreateButton("Koto", 							280, 528, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label107 = GUICtrlCreateLabel("107", 258, 512, 22, 17)
$Label106 = GUICtrlCreateLabel("106", 258, 494, 22, 17)
$Label105 = GUICtrlCreateLabel("105", 258, 476, 22, 17)
$Label47 = GUICtrlCreateLabel("47", 264, 458, 16, 17)
$Label_46 = GUICtrlCreateLabel("46", 264, 439, 16, 17)
$Label108 = GUICtrlCreateLabel("108", 258, 530, 22, 17)

;Guitar Buttons
$GuitarGroup = GUICtrlCreateGroup("  Guitar ", 382, 6, 118, 181, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$NylonBt = GUICtrlCreateButton("Nylon", 			404, 22, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SteelBt = GUICtrlCreateButton("Steel", 			404, 40, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$JazzBt = GUICtrlCreateButton("Jazz", 				404, 58, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$CleanBt = GUICtrlCreateButton("Clean", 			404, 76, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$MuteBt = GUICtrlCreateButton("Mute", 				404, 94, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$OverDriveBt = GUICtrlCreateButton("OverDrive", 	404, 112, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$DistortionBt = GUICtrlCreateButton("Distortion", 	404, 130, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$HarmonicsBt = GUICtrlCreateButton("Harmonics", 	404, 148, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$FretBt = GUICtrlCreateButton("Fret Noise", 		404, 166, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label_88 = GUICtrlCreateLabel("88", 388, 150, 16, 17)
$Label29 = GUICtrlCreateLabel("29", 388, 96, 16, 17)
$Label28 = GUICtrlCreateLabel("28", 388, 78, 16, 17)
$Label27 = GUICtrlCreateLabel("27", 388, 59, 16, 17)
$Label26 = GUICtrlCreateLabel("26", 388, 42, 16, 17)
$Label25 = GUICtrlCreateLabel("25", 388, 23, 16, 17)
$Label_87 = GUICtrlCreateLabel("87", 388, 132, 16, 17)
$Label30 = GUICtrlCreateLabel("30", 388, 114, 16, 17)
$Label121 = GUICtrlCreateLabel("121", 384, 168, 22, 17)

;Bass Buttons
$BassGroup = GUICtrlCreateGroup(" Bass ", 383, 187, 118, 184, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$UprightBt = GUICtrlCreateButton("UpRight", 			406, 202, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$FingerBt = GUICtrlCreateButton("Finger", 				406, 220, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$PickBt = GUICtrlCreateButton("Pick", 					406, 238, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$FretlessBt = GUICtrlCreateButton("FrettLess", 		406, 256, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Slap1Bt = GUICtrlCreateButton("Slap 1", 				406, 274, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Slap2Bt = GUICtrlCreateButton("Slap 2", 				406, 292, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SynthBass1Bt = GUICtrlCreateButton("Synth Bass 1", 	406, 310, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SynthBass2Bt = GUICtrlCreateButton("Synth Bass 2", 	406, 328, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ContraBt = GUICtrlCreateButton("Contra Bass", 			406, 346, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label40 = GUICtrlCreateLabel("40", 389, 331, 16, 17)
$Label37 = GUICtrlCreateLabel("37", 389, 277, 16, 17)
$Label36 = GUICtrlCreateLabel("36", 389, 259, 16, 17)
$Label35 = GUICtrlCreateLabel("35", 389, 240, 16, 17)
$Label34 = GUICtrlCreateLabel("34", 389, 223, 16, 17)
$Label33 = GUICtrlCreateLabel("33", 389, 204, 16, 17)
$Label39 = GUICtrlCreateLabel("39", 389, 313, 16, 17)
$Label38 = GUICtrlCreateLabel("38", 389, 295, 16, 17)
$Label44 = GUICtrlCreateLabel("44", 389, 347, 16, 17)

;Effects Buttons
$EffectsGroup = GUICtrlCreateGroup(" Effects ", 381, 401, 122, 149, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$BreathBt = GUICtrlCreateButton("Breath", 				407, 420, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SeaShoreBt = GUICtrlCreateButton("SeaShore", 			407, 438, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$TweetBt = GUICtrlCreateButton("Bird Tweet", 			407, 456, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$TelBt = GUICtrlCreateButton("Telephone", 				407, 474, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ApplauseBt = GUICtrlCreateButton("Applause", 			407, 510, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$HeliBt = GUICtrlCreateButton("Helicopter", 			407, 492, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$GunBt = GUICtrlCreateButton("GunShot", 				407, 528, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label126 = GUICtrlCreateLabel("126", 383, 494, 22, 17)
$Label125 = GUICtrlCreateLabel("125", 383, 476, 22, 17)
$Label124 = GUICtrlCreateLabel("124", 383, 458, 22, 17)
$Label123 = GUICtrlCreateLabel("123", 383, 440, 22, 17)
$Label122 = GUICtrlCreateLabel("122", 383, 422, 22, 17)
$Label128 = GUICtrlCreateLabel("128", 383, 530, 22, 17)
$Label127 = GUICtrlCreateLabel("127", 383, 512, 22, 17)

;Bowed Buttons
$BowedGroup = GUICtrlCreateGroup("  Bowed ", 507, 6, 120, 201, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$FiddleBt = GUICtrlCreateButton("Fiddle", 					531, 21, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ViolinBt = GUICtrlCreateButton("Violin", 					531, 39, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$ViolaBt = GUICtrlCreateButton("Viola", 					531, 57, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$CelloBt = GUICtrlCreateButton("Cello", 					531, 75, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Strings2Bt = GUICtrlCreateButton("Strings2", 				531, 129, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Strings1Bt = GUICtrlCreateButton("Strings1", 				531, 111, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$TremBt = GUICtrlCreateButton("Tremolo Str", 				531, 93, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SynString1Bt = GUICtrlCreateButton("Synth Strings1", 		531, 147, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SynString2Bt = GUICtrlCreateButton("Synth Strings2", 		531, 165, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$OrchHitBt = GUICtrlCreateButton("Orchestra Hit", 			531, 183, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label50 = GUICtrlCreateLabel("50", 514, 130, 16, 17)
$Label43 = GUICtrlCreateLabel("43", 514, 76, 16, 17)
$Label42 = GUICtrlCreateLabel("42", 514, 57, 16, 17)
$Label41 = GUICtrlCreateLabel("41", 514, 40, 16, 17)
$Label111 = GUICtrlCreateLabel("111", 510, 21, 22, 17)
$Label49 = GUICtrlCreateLabel("49", 514, 112, 16, 17)
$Label45 = GUICtrlCreateLabel("45", 514, 94, 16, 17)
$Label51 = GUICtrlCreateLabel("51", 514, 148, 16, 17)
$Label52 = GUICtrlCreateLabel("52", 514, 166, 16, 17)
$Label53 = GUICtrlCreateLabel("53", 514, 184, 16, 17)

;Percussion Buttons
$PercussionGroup = GUICtrlCreateGroup("  Percussion ", 507, 224, 120, 326, BitOR($BS_CENTER,$BS_FLAT))
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

$TinkleBt = GUICtrlCreateButton("Tinkle Bell", 				533, 402, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$AgogoBt = GUICtrlCreateButton("Agogo", 					533, 420, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SteelDrmBt = GUICtrlCreateButton("Steel Drum", 			533, 438, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$WdBlockBt = GUICtrlCreateButton("Wood Block", 				533, 456, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$MelTomBt = GUICtrlCreateButton("Melodic Tom", 				533, 492, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$RevCymbalBt = GUICtrlCreateButton("Rev Cymbal", 			533, 528, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$TaikoBt = GUICtrlCreateButton("Taiko", 					533, 474, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$CelestaBt = GUICtrlCreateButton("Celesta", 				533, 240, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$GlockenBt = GUICtrlCreateButton("Glocken", 				533, 258, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$MusBoxBt = GUICtrlCreateButton("Music Box", 				533, 276, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$VibraBt = GUICtrlCreateButton("Vibraphone", 				533, 294, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$MarimbaBt = GUICtrlCreateButton("Marimba", 				533, 312, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$TympBt = GUICtrlCreateButton("Tympani", 					533, 366, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$BellsBt = GUICtrlCreateButton("Tubular Bells", 			533, 348, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$XyloBt = GUICtrlCreateButton("XyloPhone", 					533, 330, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$KalimbaBt = GUICtrlCreateButton("Kalimba", 				533, 384, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$SynthDrumBt = GUICtrlCreateButton("Synth Drum", 			533, 510, 89, 17, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$StopBt = GUICtrlCreateButton("Stop", 12, 560, 611, 29, $WS_GROUP)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$Label9 = GUICtrlCreateLabel("9", 522, 241, 10, 17)
$Label10 = GUICtrlCreateLabel("10", 516, 259, 16, 17)
$Label11 = GUICtrlCreateLabel("11", 516, 279, 16, 17)
$Label12 = GUICtrlCreateLabel("12", 516, 295, 16, 17)
$Label13 = GUICtrlCreateLabel("13", 516, 313, 16, 17)
$Label117 = GUICtrlCreateLabel("117", 510, 475, 22, 17)
$Label116 = GUICtrlCreateLabel("116", 510, 455, 22, 17)
$Label115 = GUICtrlCreateLabel("115", 510, 437, 22, 17)
$Label114 = GUICtrlCreateLabel("114", 510, 420, 22, 17)
$Label113 = GUICtrlCreateLabel("113", 510, 403, 22, 17)
$Label_109 = GUICtrlCreateLabel("109", 510, 385, 22, 17)
$Label48 = GUICtrlCreateLabel("48", 516, 367, 16, 17)
$Label15 = GUICtrlCreateLabel("15", 516, 349, 16, 17)
$Label14 = GUICtrlCreateLabel("14", 516, 331, 16, 17)
$Label118 = GUICtrlCreateLabel("118", 510, 493, 22, 17)
$Label120 = GUICtrlCreateLabel("120", 510, 529, 22, 17)
$Label119 = GUICtrlCreateLabel("119", 510, 511, 22, 17)


GUISetState(@SW_SHOW)

	$Piano = _SoundOpen(@ScriptDir &"\PIANO\1 Piano.mid")
	$Sound = $Piano

While 1
	$Msg = GUIGetMsg()
		Select
;Piano Sounds
			Case $msg = $PianoBt
				If $Sound <> $Piano then _SoundClose($Sound)
				$Piano = _SoundOpen(@ScriptDir &"\PIANO\1 Piano.mid")
				$Sound = $Piano
				_SoundPlay($sound, 0)
				
			Case $msg = $BrightPianoBt
				If $Sound <> $BrightPiano then _SoundClose($Sound)		
				$BrightPiano = _SoundOpen(@ScriptDir &"\PIANO\2 BrtPiano.mid")
				$Sound = $BrightPiano
				_SoundPlay($sound, 0)
		
			Case $msg = $ElectGrandBt
				If $Sound <> $ElectGrand then _SoundClose($Sound)				
				$ElectGrand = _SoundOpen(@ScriptDir &"\PIANO\3 ElecGrand.mid")
				$Sound = $ElectGrand	
				_SoundPlay($Sound, 0)			
				
			Case $msg = $HonkyTonkBt
				If $Sound <> $HonkyTonk then _SoundClose($Sound)				
				$HonkyTonk = _SoundOpen(@ScriptDir &"\PIANO\4 HonkyTonk.mid")
				$Sound = $HonkyTonk				
				_SoundPlay($Sound, 0 )			
	
			Case $msg = $ElecPiano1Bt
				If $Sound <> $ElecPiano1 then _SoundClose($Sound)							
				$ElecPiano1 = _SoundOpen(@ScriptDir &"\PIANO\5 EPiano1.mid")
				$Sound = $ElecPiano1				
				_SoundPlay($Sound, 0 )	

			Case $msg = $ElectPiano2Bt
				If $Sound <> $ElecPiano2 then _SoundClose($Sound)				
				$ElecPiano2 = _SoundOpen(@ScriptDir &"\PIANO\6 EPiano2.mid")
				$Sound = $ElecPiano2
				_SoundPlay($Sound, 0 )

			Case $msg = $HarpsiBt
				If $Sound <> $Harpsi then _SoundClose($Sound)				
				$Harpsi = _SoundOpen(@ScriptDir &"\PIANO\7 Harpsi.mid")
				$Sound = $Harpsi				
				_SoundPlay($Sound, 0 )			
	
			Case $msg = $ClavBt
				If $Sound <> $Clav then _SoundClose($Sound)			
				$Clav = _SoundOpen(@ScriptDir &"\PIANO\8 Clav.mid")
				$Sound = $Clav		
				_SoundPlay($Sound, 0 )		
				
			Case $msg = $DulcBt
				If $Sound <> $Dulc then _SoundClose($Sound)			
				$Dulc = _SoundOpen(@ScriptDir &"\PIANO\16 Dulc.mid")
				$Sound = $Dulc
				_SoundPlay($Sound, 0 )		

;Organ Sounds
			Case $msg = $DrawbarBt
				If $Sound <> $Drawbar then _SoundClose($Sound)
				$Drawbar = _SoundOpen(@ScriptDir &"\Organ\17 Drawbar.mid")
				$Sound = $Drawbar
				_SoundPlay($sound, 0)
				
			Case $msg = $PercussBt
				If $Sound <> $Percuss then _SoundClose($Sound)
				$Percuss = _SoundOpen(@ScriptDir &"\Organ\18 Percuss.mid")
				$Sound = $Percuss
				_SoundPlay($sound, 0)	

			Case $msg = $RockBt
				If $Sound <> $Rock then _SoundClose($Sound)
				$Rock = _SoundOpen(@ScriptDir &"\Organ\19 Rock.mid")
				$Sound = $Rock
				_SoundPlay($sound, 0)	
				
			Case $msg = $PipeBt
				If $Sound <> $Pipe then _SoundClose($Sound)
				$Pipe = _SoundOpen(@ScriptDir &"\Organ\20 Pipe.mid")
				$Sound = $Pipe
				_SoundPlay($sound, 0)

			Case $msg = $ReedBt
				If $Sound <> $Reed then _SoundClose($Sound)
				$Reed = _SoundOpen(@ScriptDir &"\Organ\21 Reed.mid")
				$Sound = $Reed
				_SoundPlay($sound, 0)	
				
			Case $msg = $AccordBt
				If $Sound <> $Accord then _SoundClose($Sound)
				$Accord = _SoundOpen(@ScriptDir &"\Organ\22 Accord.mid")
				$Sound = $Accord
				_SoundPlay($sound, 0)					

			Case $msg = $HarmBt
				If $Sound <> $Harm then _SoundClose($Sound)
				$Harm = _SoundOpen(@ScriptDir &"\Organ\23 Harmonica.mid")
				$Sound = $Harm
				_SoundPlay($sound, 0)

			Case $msg = $BandBt
				If $Sound <> $Band then _SoundClose($Sound)
				$Band = _SoundOpen(@ScriptDir &"\Organ\24 Bandoneon.mid")
				$Sound = $Band
				_SoundPlay($sound, 0)

;Brass Sounds
			Case $msg = $TrumpBt
				If $Sound <> $Trumpet then _SoundClose($Sound)
				$Trumpet = _SoundOpen(@ScriptDir &"\Brass\57 Trumpet.mid")
				$Sound = $Trumpet
				_SoundPlay($sound, 0)	
			
			Case $msg = $TrombBt
				If $Sound <> $Trombone then _SoundClose($Sound)
				$Trombone = _SoundOpen(@ScriptDir &"\Brass\58 Trombone.mid")
				$Sound = $Trombone
				_SoundPlay($sound, 0)		
	
			Case $msg = $TubaBt
				If $Sound <> $Tuba then _SoundClose($Sound)
				$Tuba = _SoundOpen(@ScriptDir &"\Brass\59 Tuba.mid")
				$Sound = $Tuba
				_SoundPlay($sound, 0)	
			
			Case $msg = $MuteTrmptBt
				If $Sound <> $MuteTrmp then _SoundClose($Sound)
				$MuteTrmp = _SoundOpen(@ScriptDir &"\Brass\60 MuteTpt.mid")
				$Sound = $MuteTrmp
				_SoundPlay($sound, 0)				

			Case $msg = $FrenchHrnBt
				If $Sound <> $FrenchHrn then _SoundClose($Sound)
				$FrenchHrn = _SoundOpen(@ScriptDir &"\Brass\61 FrenchHrn.mid")
				$Sound = $FrenchHrn
				_SoundPlay($sound, 0)

			Case $msg = $BrassSecBt
				If $Sound <> $BrassSec then _SoundClose($Sound)
				$BrassSec = _SoundOpen(@ScriptDir &"\Brass\62 BrassSec.mid")
				$Sound = $BrassSec
				_SoundPlay($sound, 0)	

			Case $msg = $SyBrass1Bt
				If $Sound <> $SynthBass1 then _SoundClose($Sound)
				$SynthBass1 = _SoundOpen(@ScriptDir &"\Brass\63 SynBass1.mid")
				$Sound = $SynthBass1
				_SoundPlay($sound, 0)
				
			Case $msg = $SynBrass2Bt
				If $Sound <> $SynthBass2 then _SoundClose($Sound)
				$SynthBass2 = _SoundOpen(@ScriptDir &"\Brass\64 SynBass2.mid")
				$Sound = $SynthBass2
				_SoundPlay($sound, 0)

;Pad Sounds

			Case $msg = $AhhBt
				If $Sound <> $Ahh then _SoundClose($Sound)
				$Ahh = _SoundOpen(@ScriptDir &"\Pads\53 Ahhs.mid")
				$Sound = $Ahh
				_SoundPlay($sound, 0)
				
			Case $msg = $OooBt
				If $Sound <> $Doo then _SoundClose($Sound)
				$Doo = _SoundOpen(@ScriptDir &"\Pads\54 Doo.mid")
				$Sound = $Doo
				_SoundPlay($sound, 0)

			Case $msg = $SynVoiceBt
				If $Sound <> $SynVoice then _SoundClose($Sound)
				$SynVoice = _SoundOpen(@ScriptDir &"\Pads\55 SynVoice.mid")
				$Sound = $SynVoice
				_SoundPlay($sound, 0)		

			Case $msg = $NewAgeBt
				If $Sound <> $NewAge then _SoundClose($Sound)
				$NewAge = _SoundOpen(@ScriptDir &"\Pads\89 NewAge.mid")
				$Sound = $NewAge
				_SoundPlay($sound, 0)
				
			Case $msg = $WarmBt
				If $Sound <> $Warm then _SoundClose($Sound)
				$Warm = _SoundOpen(@ScriptDir &"\Pads\90 Warm.mid")
				$Sound = $Warm
				_SoundPlay($sound, 0)	

			Case $msg = $PolySynBt
				If $Sound <> $PolySyn then _SoundClose($Sound)
				$PolySyn = _SoundOpen(@ScriptDir &"\Pads\91 PolySynth.mid")
				$Sound = $PolySyn
				_SoundPlay($sound, 0)

			Case $msg = $ChoirBt
				If $Sound <> $Choir then _SoundClose($Sound)
				$Choir = _SoundOpen(@ScriptDir &"\Pads\92 Choir.mid")
				$Sound = $Choir
				_SoundPlay($sound, 0)	
				
			Case $msg = $BowedBt
				If $Sound <> $Bowed then _SoundClose($Sound)
				$Bowed = _SoundOpen(@ScriptDir &"\Pads\93 BowedGlass.mid")
				$Sound = $Bowed
				_SoundPlay($sound, 0)	

			Case $msg = $MetallicBt
				If $Sound <> $Metallic then _SoundClose($Sound)
				$Metallic = _SoundOpen(@ScriptDir &"\Pads\94 Metallic.mid")
				$Sound = $Metallic
				_SoundPlay($sound, 0)
				
			Case $msg = $HaloBt
				If $Sound <> $Halo then _SoundClose($Sound)
				$Halo = _SoundOpen(@ScriptDir &"\Pads\95 Halo.mid")
				$Sound = $Halo
				_SoundPlay($sound, 0)

			Case $msg = $SweepBt
				If $Sound <> $Sweep then _SoundClose($Sound)
				$Sweep = _SoundOpen(@ScriptDir &"\Pads\96 Sweep.mid")
				$Sound = $Sweep
				_SoundPlay($sound, 0)

			Case $msg = $RainBt
				If $Sound <> $Rain then _SoundClose($Sound)
				$Rain = _SoundOpen(@ScriptDir &"\Pads\97 Rain.mid")
				$Sound = $Rain
				_SoundPlay($sound, 0)
				
			Case $msg = $SoundTrackBt
				If $Sound <> $SoundTrack then _SoundClose($Sound)
				$SoundTrack = _SoundOpen(@ScriptDir &"\Pads\98 SoundTrack.mid")
				$Sound = $SoundTrack
				_SoundPlay($sound, 0)

			Case $msg = $CrystalBt
				If $Sound <> $Crystal then _SoundClose($Sound)
				$Crystal = _SoundOpen(@ScriptDir &"\Pads\99 Crystal.mid")
				$Sound = $Crystal
				_SoundPlay($sound, 0)
				
			Case $msg = $AtmosBt
				If $Sound <> $Atmos then _SoundClose($Sound)
				$Atmos = _SoundOpen(@ScriptDir &"\Pads\100 Atmosphere.mid")
				$Sound = $Atmos
				_SoundPlay($sound, 0)

			Case $msg = $BrightBt
				If $Sound <> $Bright then _SoundClose($Sound)
				$Bright = _SoundOpen(@ScriptDir &"\Pads\101 Brightness.mid")
				$Sound = $Bright
				_SoundPlay($sound, 0)	
				
			Case $msg = $GoblinsBt
				If $Sound <> $Goblins then _SoundClose($Sound)
				$Goblins = _SoundOpen(@ScriptDir &"\Pads\102 Goblins.mid")
				$Sound = $Goblins
				_SoundPlay($sound, 0)	

			Case $msg = $EchoBt
				If $Sound <> $Echo then _SoundClose($Sound)
				$Echo = _SoundOpen(@ScriptDir &"\Pads\103 Echos.mid")
				$Sound = $Echo
				_SoundPlay($sound, 0)

			Case $msg = $ScFiBt
				If $Sound <> $SciFi then _SoundClose($Sound)
				$SciFi = _SoundOpen(@ScriptDir &"\Pads\104 SciFi.mid")
				$Sound = $SciFi
				_SoundPlay($sound, 0)	

; Synth Lead Sounds
			Case $msg = $SquareBt
				If $Sound <> $Square then _SoundClose($Sound)
				$Square  = _SoundOpen(@ScriptDir &"\SynthLead\81 Square.mid")
				$Sound = $Square 
				_SoundPlay($sound, 0)	

			Case $msg = $SawBt
				If $Sound <> $Saw then _SoundClose($Sound)
				$Saw  = _SoundOpen(@ScriptDir &"\SynthLead\82 Saw.mid")
				$Sound = $Saw
				_SoundPlay($sound, 0)	

			Case $msg = $CalliBt
				If $Sound <> $Calli then _SoundClose($Sound)
				$Calli  = _SoundOpen(@ScriptDir &"\SynthLead\83 Calliope.mid")
				$Sound = $Calli
				_SoundPlay($sound, 0)	

			Case $msg = $ChiffBt
				If $Sound <> $Chiff then _SoundClose($Sound)
				$Chiff  = _SoundOpen(@ScriptDir &"\SynthLead\84 Chiff.mid")
				$Sound = $Chiff
				_SoundPlay($sound, 0)	

			Case $msg = $CharBt
				If $Sound <> $Char then _SoundClose($Sound)
				$Char  = _SoundOpen(@ScriptDir &"\SynthLead\85 Charang.mid")
				$Sound = $Char
				_SoundPlay($sound, 0)

			Case $msg = $VoiceBt
				If $Sound <> $Voice then _SoundClose($Sound)
				$Voice  = _SoundOpen(@ScriptDir &"\SynthLead\86 Voice.mid")
				$Sound = $Voice
				_SoundPlay($sound, 0)
				
			Case $msg = $FifthBt
				If $Sound <> $Voice then _SoundClose($Sound)
				$Fifth  = _SoundOpen(@ScriptDir &"\SynthLead\87 Fifth.mid")
				$Sound = $Fifth
				_SoundPlay($sound, 0)		

			Case $msg = $BassBt
				If $Sound <> $Bass then _SoundClose($Sound)
				$Bass  = _SoundOpen(@ScriptDir &"\SynthLead\88 Bass.mid")
				$Sound = $Bass 
				_SoundPlay($sound, 0)				

;Pipe Sounds
			Case $msg = $PiccoloBt
				If $Sound <> $Piccolo then _SoundClose($Sound)
				$Piccolo  = _SoundOpen(@ScriptDir &"\Pipe\73 Piccolo.mid")
				$Sound = $Piccolo
				_SoundPlay($sound, 0)	
				
			Case $msg = $FluteBt
				If $Sound <> $Flute then _SoundClose($Sound)
				$Flute  = _SoundOpen(@ScriptDir &"\Pipe\74 Flute.mid")
				$Sound = $Flute 
				_SoundPlay($sound, 0)	

			Case $msg = $RecorderBt
				If $Sound <> $Recorder then _SoundClose($Sound)
				$Recorder  = _SoundOpen(@ScriptDir &"\Pipe\75 Recorder.mid")
				$Sound = $Recorder 
				_SoundPlay($sound, 0)	
		
			Case $msg = $PanFluteBt
				If $Sound <> $PanFlute then _SoundClose($Sound)
				$PanFlute  = _SoundOpen(@ScriptDir &"\Pipe\76 PanFlute.mid")
				$Sound = $PanFlute 
				_SoundPlay($sound, 0)	

			Case $msg = $BottleBt
				If $Sound <> $Bottle then _SoundClose($Sound)
				$Bottle = _SoundOpen(@ScriptDir &"\Pipe\77 Bottle.mid")
				$Sound = $Bottle 
				_SoundPlay($sound, 0)	

			Case $msg = $ShakBt
				If $Sound <> $Shak then _SoundClose($Sound)
				$Shak  = _SoundOpen(@ScriptDir &"\Pipe\78 Shak.mid")
				$Sound = $Shak
				_SoundPlay($sound, 0)

			Case $msg = $WhistleBt
				If $Sound <> $Whistle then _SoundClose($Sound)
				$Whistle = _SoundOpen(@ScriptDir &"\Pipe\79 Whistle.mid")
				$Sound = $Whistle
				_SoundPlay($sound, 0)	
	
			Case $msg = $OcarinaBt
				If $Sound <> $Ocarina then _SoundClose($Sound)
				$Ocarina = _SoundOpen(@ScriptDir &"\Pipe\80 Ocarina.mid")
				$Sound = $Ocarina
				_SoundPlay($sound, 0)				

;Reed Sounds
			Case $msg = $SopSaxBt
				If $Sound <> $SopSax then _SoundClose($Sound)
				$SopSax = _SoundOpen(@ScriptDir &"\Reed\65 SopranoSax.mid")
				$Sound = $SopSax
				_SoundPlay($sound, 0)	
			
			Case $msg = $AltoSaxBt
				If $Sound <> $AltoSax then _SoundClose($Sound)
				$AltoSax = _SoundOpen(@ScriptDir &"\Reed\66 AltoSax.mid")
				$Sound = $AltoSax
				_SoundPlay($sound, 0)					
				
			Case $msg = $TenorSaxBt
				If $Sound <> $TenorSax then _SoundClose($Sound)
				$TenorSax = _SoundOpen(@ScriptDir &"\Reed\67 TenorSax.mid")
				$Sound = $TenorSax
				_SoundPlay($sound, 0)	

			Case $msg = $BariSaxBt
				If $Sound <> $BariSax then _SoundClose($Sound)
				$BariSax = _SoundOpen(@ScriptDir &"\Reed\68 BariSax.mid")
				$Sound = $BariSax
				_SoundPlay($sound, 0)	
			
			Case $msg = $OboeBt
				If $Sound <> $Oboe then _SoundClose($Sound)
				$Oboe = _SoundOpen(@ScriptDir &"\Reed\69 Oboe.mid")
				$Sound = $Oboe
				_SoundPlay($sound, 0)					
				
			Case $msg = $EngHornBt
				If $Sound <> $EngHorn then _SoundClose($Sound)
				$EngHorn = _SoundOpen(@ScriptDir &"\Reed\70 EngHorn.mid")
				$Sound = $EngHorn
				_SoundPlay($sound, 0)		
		
			Case $msg = $BassoonBt
				If $Sound <> $Bassoon then _SoundClose($Sound)
				$Bassoon = _SoundOpen(@ScriptDir &"\Reed\71 Bassoon.mid")
				$Sound = $Bassoon
				_SoundPlay($sound, 0)
		
			Case $msg = $ClarinetBt
				If $Sound <> $Clarinet then _SoundClose($Sound)
				$Clarinet = _SoundOpen(@ScriptDir &"\Reed\72 Clarinet.mid")
				$Sound = $Clarinet
				_SoundPlay($sound, 0)
				
			Case $msg = $BagPipeBt
				If $Sound <> $BagPipe then _SoundClose($Sound)
				$BagPipe = _SoundOpen(@ScriptDir &"\Reed\110 BagPipe.mid")
				$Sound = $BagPipe
				_SoundPlay($sound, 0)
				
			Case $msg = $ShanaiBt
				If $Sound <> $Shanai then _SoundClose($Sound)
				$Shanai = _SoundOpen(@ScriptDir &"\Reed\112 Shanai.mid")
				$Sound = $Shanai
				_SoundPlay($sound, 0)				

;Plucked Sound
				Case $msg = $PIzzStringsBt
				If $Sound <> $PIzzStrings then _SoundClose($Sound)
				$PIzzStrings = _SoundOpen(@ScriptDir &"\Plucked\46 Pizzicato.mid")
				$Sound = $PIzzStrings
				_SoundPlay($sound, 0)	
			
				Case $msg = $HarpBt
				If $Sound <> $Harp then _SoundClose($Sound)
				$Harp = _SoundOpen(@ScriptDir &"\Plucked\47 Harp.mid")
				$Sound = $Harp
				_SoundPlay($sound, 0)	

				Case $msg = $SitarBt
				If $Sound <> $Sitar then _SoundClose($Sound)
				$Harp = _SoundOpen(@ScriptDir &"\Plucked\105 Sitar.mid")
				$Sound = $Harp
				_SoundPlay($sound, 0)	
				
				Case $msg = $BanjoBt
				If $Sound <> $Banjo then _SoundClose($Sound)
				$Banjo = _SoundOpen(@ScriptDir &"\Plucked\106 Banjo.mid")
				$Sound = $Banjo
				_SoundPlay($sound, 0)	

				Case $msg = $ShamisenBt
				If $Sound <> $Shamisen then _SoundClose($Sound)
				$Shamisen = _SoundOpen(@ScriptDir &"\Plucked\107 Shamisen.mid")
				$Sound = $Shamisen
				_SoundPlay($sound, 0)	
			
				Case $msg = $KotoBt
				If $Sound <> $Koto then _SoundClose($Sound)
				$Koto = _SoundOpen(@ScriptDir &"\Plucked\108 Koto.mid")
				$Sound = $Koto
				_SoundPlay($sound, 0)	
	
				Case $msg = $KalimbaBt
				If $Sound <> $Kalimba then _SoundClose($Sound)
				$Kalimba = _SoundOpen(@ScriptDir &"\Plucked\109 Kalimba.mid")
				$Sound = $Kalimba
				_SoundPlay($sound, 0)	

;Guitar Sounds
				Case $msg = $NylonBt
				If $Sound <> $Nylon then _SoundClose($Sound)
				$Nylon = _SoundOpen(@ScriptDir &"\Guitar\25 Nylon.mid")
				$Sound = $Nylon
				_SoundPlay($sound, 0)	
				
				Case $msg = $SteelBt
				If $Sound <> $Steel then _SoundClose($Sound)
				$Steel = _SoundOpen(@ScriptDir &"\Guitar\26 Steel.mid")
				$Sound = $Steel
				_SoundPlay($sound, 0)

				Case $msg = $JazzBt
				If $Sound <> $Jazz then _SoundClose($Sound)
				$Jazz = _SoundOpen(@ScriptDir &"\Guitar\27 Jazz.mid")
				$Sound = $Jazz
				_SoundPlay($sound, 0)

				Case $msg = $CleanBt
				If $Sound <> $Clean then _SoundClose($Sound)
				$Clean = _SoundOpen(@ScriptDir &"\Guitar\28 Clean.mid")
				$Sound = $Clean
				_SoundPlay($sound, 0)
				
				Case $msg = $MuteBt
				If $Sound <> $Mute then _SoundClose($Sound)
				$Mute = _SoundOpen(@ScriptDir &"\Guitar\29 Mute.mid")
				$Sound = $Mute
				_SoundPlay($sound, 0)
				
				Case $msg = $OverDriveBt
				If $Sound <> $OverDrive then _SoundClose($Sound)
				$OverDrive = _SoundOpen(@ScriptDir &"\Guitar\30 OverDrive.mid")
				$Sound = $OverDrive
				_SoundPlay($sound, 0)

				Case $msg = $DistortionBt
				If $Sound <> $Distortion then _SoundClose($Sound)
				$Distortion = _SoundOpen(@ScriptDir &"\Guitar\31 Distortion.mid")
				$Sound = $Distortion
				_SoundPlay($sound, 0)	
				
				Case $msg = $HarmonicsBt
				If $Sound <> $Harmonics then _SoundClose($Sound)
				$Harmonics = _SoundOpen(@ScriptDir &"\Guitar\32 Harmonics.mid")
				$Sound = $Harmonics
				_SoundPlay($sound, 0)	

				Case $msg = $FretBt
				If $Sound <> $Fret then _SoundClose($Sound)
				$Fret = _SoundOpen(@ScriptDir &"\Guitar\121 Fretnoise.mid")
				$Sound = $Fret
				_SoundPlay($sound, 0)	
				
;Bass Sounds
				Case $msg = $UprightBt
				If $Sound <> $Upright then _SoundClose($Sound)
				$Upright = _SoundOpen(@ScriptDir &"\Bass\33 Upright.mid")
				$Sound = $Upright
				_SoundPlay($sound, 0)	
				
				Case $msg = $FingerBt
				If $Sound <> $Finger then _SoundClose($Sound)
				$Finger = _SoundOpen(@ScriptDir &"\Bass\34 Finger.mid")
				$Sound = $Finger
				_SoundPlay($sound, 0)	

				Case $msg = $PickBt
				If $Sound <> $Pick then _SoundClose($Sound)
				$Pick = _SoundOpen(@ScriptDir &"\Bass\35 Pick.mid")
				$Sound = $Pick
				_SoundPlay($sound, 0)

				Case $msg = $FretlessBt
				If $Sound <> $Fretless then _SoundClose($Sound)
				$Fretless = _SoundOpen(@ScriptDir &"\Bass\36 Fretless.mid")
				$Sound = $Fretless
				_SoundPlay($sound, 0)

				Case $msg = $Slap1Bt
				If $Sound <> $Slap1 then _SoundClose($Sound)
				$Slap1 = _SoundOpen(@ScriptDir &"\Bass\37 Slap1.mid")
				$Sound = $Slap1
				_SoundPlay($sound, 0)

				Case $msg = $Slap2Bt
				If $Sound <> $Slap2 then _SoundClose($Sound)
				$Slap2 = _SoundOpen(@ScriptDir &"\Bass\38 Slap2.mid")
				$Sound = $Slap2
				_SoundPlay($sound, 0)
				
				Case $msg = $SynthBass1Bt
				If $Sound <> $SynthBass1 then _SoundClose($Sound)
				$SynthBass1 = _SoundOpen(@ScriptDir &"\Bass\39 SynthBass1.mid")
				$Sound = $SynthBass1
				_SoundPlay($sound, 0)		

				Case $msg = $SynthBass2Bt
				If $Sound <> $SynthBass2 then _SoundClose($Sound)
				$SynthBass2 = _SoundOpen(@ScriptDir &"\Bass\40 SynthBass2.mid")
				$Sound = $SynthBass2
				_SoundPlay($sound, 0)	
				
				Case $msg = $ContraBt
				If $Sound <> $Contra then _SoundClose($Sound)
				$Contra = _SoundOpen(@ScriptDir &"\Bass\41 Contra.mid")
				$Sound = $Contra
				_SoundPlay($sound, 0)					

;Effects Sound
				Case $msg = $BreathBt
				If $Sound <> $Breath then _SoundClose($Sound)
				$Breath = _SoundOpen(@ScriptDir &"\Effects\122 Breath.mid")
				$Sound = $Breath
				_SoundPlay($sound, 0)	
				
				Case $msg = $SeaShoreBt
				If $Sound <> $SeaShore then _SoundClose($Sound)
				$SeaShore = _SoundOpen(@ScriptDir &"\Effects\123 SeaShore.mid")
				$Sound = $SeaShore
				_SoundPlay($sound, 0)	
				
				Case $msg = $TweetBt
				If $Sound <> $Tweet then _SoundClose($Sound)
				$Tweet = _SoundOpen(@ScriptDir &"\Effects\124 Tweet.mid")
				$Sound = $Tweet
				_SoundPlay($sound, 0)					

				Case $msg = $TelBt
				If $Sound <> $Telephone then _SoundClose($Sound)
				$Telephone = _SoundOpen(@ScriptDir &"\Effects\125 Telephone.mid")
				$Sound = $Telephone
				_SoundPlay($sound, 0)	

				Case $msg = $HeliBt
				If $Sound <> $Helicopter then _SoundClose($Sound)
				$Helicopter = _SoundOpen(@ScriptDir &"\Effects\126 Helicopter.mid")
				$Sound = $Helicopter
				_SoundPlay($sound, 0)	

				Case $msg = $ApplauseBt
				If $Sound <> $Applause then _SoundClose($Sound)
				$Applause = _SoundOpen(@ScriptDir &"\Effects\127 Applause.mid")
				$Sound = $Applause
				_SoundPlay($sound, 0)	
				
				Case $msg = $GunBt
				If $Sound <> $Gun then _SoundClose($Sound)
				$Gun = _SoundOpen(@ScriptDir &"\Effects\128 Gunshot.mid")
				$Sound = $Gun
				_SoundPlay($sound, 0)					

;Bowed Sounds
				Case $msg = $FiddleBt
				If $Sound <> $Fiddle then _SoundClose($Sound)
				$Fiddle = _SoundOpen(@ScriptDir &"\Bowed\111 Fiddle.mid")
				$Sound = $Fiddle
				_SoundPlay($sound, 0)

				Case $msg = $ViolinBt
				If $Sound <> $Violin then _SoundClose($Sound)
				$Violin = _SoundOpen(@ScriptDir &"\Bowed\41 Violin.mid")
				$Sound = $Violin
				_SoundPlay($sound, 0)	
				
				Case $msg = $ViolaBt
				If $Sound <> $Viola then _SoundClose($Sound)
				$Viola = _SoundOpen(@ScriptDir &"\Bowed\42 Viola.mid")
				$Sound = $Viola
				_SoundPlay($sound, 0)			

				Case $msg = $CelloBt
				If $Sound <> $Cello then _SoundClose($Sound)
				$Cello = _SoundOpen(@ScriptDir &"\Bowed\43 Cello.mid")
				$Sound = $Cello
				_SoundPlay($sound, 0)	

				Case $msg = $TremBt
				If $Sound <> $Trem then _SoundClose($Sound)
				$Trem = _SoundOpen(@ScriptDir &"\Bowed\45 TremoloStr.mid")
				$Sound = $Trem
				_SoundPlay($sound, 0)	

				Case $msg = $Strings1Bt
				If $Sound <> $Strings1 then _SoundClose($Sound)
				$Strings1 = _SoundOpen(@ScriptDir &"\Bowed\49 Strings1.mid")
				$Sound = $Strings1
				_SoundPlay($sound, 0)	
				
				Case $msg = $Strings2Bt
				If $Sound <> $Strings2 then _SoundClose($Sound)
				$Strings2 = _SoundOpen(@ScriptDir &"\Bowed\50 Strings2.mid")
				$Sound = $Strings2
				_SoundPlay($sound, 0)					

				Case $msg = $SynString1Bt
				If $Sound <> $SynString1 then _SoundClose($Sound)
				$SynString1 = _SoundOpen(@ScriptDir &"\Bowed\51 SynStr1.mid")
				$Sound = $SynString1
				_SoundPlay($sound, 0)

				Case $msg = $SynString2Bt
				If $Sound <> $SynString2 then _SoundClose($Sound)
				$SynString2 = _SoundOpen(@ScriptDir &"\Bowed\52 SynStr2.mid")
				$Sound = $SynString2
				_SoundPlay($sound, 0)	
				
				Case $msg = $OrchHitBt
				If $Sound <> $OrchHit then _SoundClose($Sound)
				$OrchHit = _SoundOpen(@ScriptDir &"\Bowed\56 OrchHit.mid")
				$Sound = $OrchHit
				_SoundPlay($sound, 0)					

;Percussion Sounds
				Case $msg = $CelestaBt 
				If $Sound <> $Celesta then _SoundClose($Sound)
				$Celesta = _SoundOpen(@ScriptDir &"\Percussion\9 Celesta.mid")
				$Sound = $Celesta
				_SoundPlay($sound, 0)	
				
				Case $msg = $GlockenBt  
				If $Sound <> $Glocken then _SoundClose($Sound)
				$Glocken = _SoundOpen(@ScriptDir &"\Percussion\10 Glocken.mid")
				$Sound = $Glocken
				_SoundPlay($sound, 0)		

				Case $msg = $MusBoxBt  
				If $Sound <> $MusBox then _SoundClose($Sound)
				$MusBox = _SoundOpen(@ScriptDir &"\Percussion\11 MusicBox.mid")
				$Sound = $MusBox
				_SoundPlay($sound, 0)

				Case $msg = $VibraBt  
				If $Sound <> $Vibra then _SoundClose($Sound)
				$Vibra = _SoundOpen(@ScriptDir &"\Percussion\12 Vibraphone.mid")
				$Sound = $Vibra
				_SoundPlay($sound, 0)

				Case $msg = $MarimbaBt 
				If $Sound <> $Marimba then _SoundClose($Sound)
				$Marimba = _SoundOpen(@ScriptDir &"\Percussion\13 Marimba.mid")
				$Sound = $Marimba
				_SoundPlay($sound, 0)	

				Case $msg = $XyloBt
				If $Sound <> $Xylo then _SoundClose($Sound)
				$Xylo = _SoundOpen(@ScriptDir &"\Percussion\14 Xylophone.mid")
				$Sound = $Xylo
				_SoundPlay($sound, 0)

				Case $msg = $BellsBt
				If $Sound <> $Bells then _SoundClose($Sound)
				$Bells = _SoundOpen(@ScriptDir &"\Percussion\15 TubularBell.mid")
				$Sound = $Bells
				_SoundPlay($sound, 0)

				Case $msg = $TympBt
				If $Sound <> $Tymp then _SoundClose($Sound)
				$Tymp = _SoundOpen(@ScriptDir &"\Percussion\48 Tympani.mid")
				$Sound = $Tymp
				_SoundPlay($sound, 0)

				Case $msg = $KalimbaBt
				If $Sound <> $Kalimba then _SoundClose($Sound)
				$Kalimba = _SoundOpen(@ScriptDir &"\Percussion\109 Kalimba.mid")
				$Sound = $Kalimba
				_SoundPlay($sound, 0)

				Case $msg = $TinkleBt
				If $Sound <> $Tinkle then _SoundClose($Sound)
				$Tinkle = _SoundOpen(@ScriptDir &"\Percussion\113 Tinklebell.mid")
				$Sound = $Tinkle
				_SoundPlay($sound, 0)

				Case $msg = $AgogoBt
				If $Sound <> $Agogo then _SoundClose($Sound)
				$Agogo = _SoundOpen(@ScriptDir &"\Percussion\114 Agogo.mid")
				$Sound = $Agogo
				_SoundPlay($sound, 0)

				Case $msg = $SteelDrmBt
				If $Sound <> $SteelDrm then _SoundClose($Sound)
				$SteelDrm = _SoundOpen(@ScriptDir &"\Percussion\115 SteelDrum.mid")
				$Sound = $SteelDrm
				_SoundPlay($sound, 0)
 
				Case $msg = $WdBlockBt
				If $Sound <> $WdBlock then _SoundClose($Sound)
				$WdBloc = _SoundOpen(@ScriptDir &"\Percussion\116 WoodBlock.mid")
				$Sound = $WdBloc
				_SoundPlay($sound, 0)

				Case $msg = $TaikoBt
				If $Sound <> $Taiko then _SoundClose($Sound)
				$Taiko = _SoundOpen(@ScriptDir &"\Percussion\117 Taiko.mid")
				$Sound = $Taiko 
				_SoundPlay($sound, 0)

				Case $msg = $MelTomBt
				If $Sound <> $MelTom then _SoundClose($Sound)
				$MelTom = _SoundOpen(@ScriptDir &"\Percussion\118 Melodic.mid")
				$Sound = $MelTom
				_SoundPlay($sound, 0)
				
				Case $msg = $SynthDrumBt
				If $Sound <> $SynthDrum then _SoundClose($Sound)
				$SynthDrum  = _SoundOpen(@ScriptDir &"\Percussion\119 SynDrum.mid")
				$Sound = $SynthDrum 
				_SoundPlay($sound, 0)				

				Case $msg = $RevCymbalBt 
				If $Sound <> $RevCymbal then _SoundClose($Sound)
				$RevCymbal = _SoundOpen(@ScriptDir &"\Percussion\120 RevCymbal.mid")
				$Sound = $RevCymbal
				_SoundPlay($sound, 0)

			Case $msg = $StopBt
					_SoundClose($Sound)
					
		Case $msg = $GUI_EVENT_CLOSE
			_SoundClose($Sound)
      ExitLoop
  EndSelect
	
WEnd
	
Func ErrorCheck() 
	If @error = 2 Then
    MsgBox(0, "Error", "The file does not exist")
    Exit
ElseIf @error = 3 Then
    MsgBox(0, "Error", "The alias was invalid")
    Exit
ElseIf @extended <> 0 Then
    $extended = @extended ;assign because @extended will be set after DllCall
    $stText = DllStructCreate("char[128]")
    $errorstring = DllCall("winmm.dll", "short", "mciGetErrorStringA", "str", $extended, "ptr", DllStructGetPtr($stText), "int", 128)
    MsgBox(0, "Error", "The open failed." & @CRLF & "Error Number: " & $extended & @CRLF & "Error Description: " & DllStructGetData($stText, 1) & @CRLF & "Please Note: The sound may still play correctly.")
Else
    MsgBox(0, "Success", "The file opened successfully")
EndIf	
EndFunc

