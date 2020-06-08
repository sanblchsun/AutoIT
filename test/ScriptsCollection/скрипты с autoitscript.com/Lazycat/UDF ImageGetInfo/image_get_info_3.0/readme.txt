This is an UDF for reading info from JPEG, TIFF, BMP, PNG and GIF - size, color depth, resolution etc. For TIFF files supported retrieve almost every meaningful info, for JPEG files retrieved Exif/GPS information.

History
-------
Version 3.0 (2010-11-11)
* Rewritten TIFF/Exif parser
* Some speedup in complex parsers
* Changed date format (to standard one) for PNG
* Semi-bringed to UDF standards
- Bunch small fixes discovered while revisiting code

Version 2.8 (2010-10-08)
Fixed handling of tEXt block for PNG (thanks KaFu) 

Version 2.7 (2010-04-29)
Fixed _ImageGetParam function (thanks wolfbartels) 

Version 2.6 (2010-01-21)
Fixed deprecated struct types 

Version 2.5 (2008-01-25)
Fix for JPEG size bug, caused by newly added struct aligning feature (thanks NeoFoX) 

Version 2.4 (2007-05-22)
With new Autoit version script become unworkable, fixed, thanks Tweaky and someone on German forum 

Version 2.3 (2006-05-25)
Fix of bug, caused by binary string changes (thanks odklizec)

Version 2.2 (2006-04-03)
Fixed JPEG dimensions for certain files (thanks billmez)

Version 2.1 (2006-02-19)
Updated to current beta (no DllStructDelete anymore)

Version 2.01 (2005-10-17)
Tiny fixes, underscores prevent run script in latest betas.

Version 2.0 (2005-07-01)
Initial version.