#include-once

#include <WinAPI.au3>
#include "WimConstants.au3"

; #INDEX# =======================================================================================================================
; Title .........: Wimgapi v3 (9/19/2011)
; AutoIt Version : 3.3.6.1
; Description ...: Functions for creating and manipulating WIM images.
; Author(s) .....: Jonathan Holmgren (Homes32)
; Dll ...........: wimgapi.dll
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $gsWimDLL = @SystemDir & "\wimgapi.dll" ; full path to wimgapi.dll - feel free to overide inside your script.
Global $ghwimgapi = 0 ; initialized by _WIM_Startup() and contains the handle to DllOpen($gsWimDLL)
Global $giWIMRef = 0 ; reference var. Value is >= 1 if $gsWimDLL is loaded.
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
; none
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; 	_WIM_ApplyImage
;	_WIM_CaptureImage
; 	_WIM_CloseHandle
; 	_WIM_CreateFile
;   _WIM_DeleteImage
;   _WIM_DeleteImageMounts
;   _WIM_ExportImage
;	_WIM_ExtractImagePath
;   _WIM_GetImageAttributes
;   _WIM_GetImageCount
; 	_WIM_GetImageInformation
;	_WIM_LoadImage
;   _WIM_MountImage
;   _WIM_RegisterLogFile
;   _WIM_RegisterMessageCallback
;   _WIM_RemountImage
;   _WIM_SetBootImage
;	_WIM_SetImageInformation
;   _WIM_SetReferenceFile
;	_WIM_SetTemporaryPath
;	_WIM_Shutdown
;	_WIM_Startup
;   _WIM_UnMountImage
;   _WIM_UnRegisterLogFile
;   _WIM_UnregisterMessageCallback
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_ApplyImage
; Description ...: Applies an image to a directory path from a Windows image (.wim) file.
; Syntax.........: _WIM_ApplyImage($hImage, $sPath, [$dwApplyFlags = $WIM_FLAG_INDEX])
; Parameters ....: $$hImage      - A handle to a volume image returned by the _WIM_LoadImage or _WIM_CaptureImage functions.
;				   $sPath        - A string containing the root drive or the directory path where the image data will be applied.
;				   $dwApplyFlags - Specifies the features to use during the capture.
;								   For this parameter you can use any combination of the following values:
;								   | 0                    - No features.
;								   | $WIM_FLAG_VERIFY     - Verified that files match original data.
;								   | $WIM_FLAG_INDEX      - Specifies that the image is to be sequentially read for caching or performance purposes.
;								   | $WIM_FLAG_NO_APPLY   - Applies the image without physically creating directories or files. Useful for obtaining a list of files and directories in the image.
;								   | $WIM_FLAG_FILEINFO   - Sends a WIM_MSG_FILEINFO message during the apply operation.
;								   | $WIM_FLAG_NO_RP_FIX  - Disables automatic path fixups for junctions and symbolic links.
;								   | $WIM_FLAG_NO_DIRACL  - Disables restoring security information for directories.
;								   | $WIM_FLAG_NO_FILEACL - Disables restoring security information for files
; Return values .: Success - Returns nonzero.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: To obtain information during an image apply, see the _WIM_RegisterMessageCallback function.
;				   To obtain the list of files in an image without actually applying the image, specify the $WIM_FLAG_NO_APPLY flag
;                  and register a callback that handles the $WIM_MSG_PROCESS message. To obtain additional file information from the
;				   $WIM_MSG_FILEINFO message, specify the $WIM_FLAG_FILEINFO.
; Related .......: _WIM_LoadImage, _WIM_RegisterMessageCallback
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_ApplyImage($hImage, $sPath, $dwApplyFlags = $WIM_FLAG_INDEX)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMApplyImage", _
			"handle", $hImage, _
			"wstr", $sPath, _
			"dword", $dwApplyFlags)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_ApplyImage

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_CaptureImage
; Description ...: Captures an image from a directory path and stores it in an image file.
; Syntax.........: _WIM_CaptureImage($hWIM, $sPath, [$dwCaptureFlags = $WIM_FLAG_VERIFY])
; Parameters ....: $hWim           - The handle to a .wim file returned by _WIM_CreateFile
;				   $sPath          - A string containing the root drive or directory path from where the image data is captured.
;				   $dwCaptureFlags - Specifies the features to use during the capture.
;									 For this parameter you can use any combination of the following values:
;									 | 0                    - No features.
;									 | $WIM_FLAG_VERIFY     - Capture verifies single-instance files byte by byte.
;									 | $WIM_FLAG_NO_RP_FIX  - Disables automatic path fixups for junctions and symbolic links.
;									 | $WIM_FLAG_NO_DIRACL  - Disables capturing security information for directories.
;									 | $WIM_FLAG_NO_FILEACL - Disables capturing security information for files.
; Return values .: Success - Returns an open handle to an object representing the volume image.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: To obtain information during an image capture, see the _WIM_RegisterMessageCallback function.
; Related .......: _WIM_RegisterMessageCallback
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_CaptureImage($hWIM, $sPath, $dwCaptureFlags = $WIM_FLAG_VERIFY)

	Local $aResult = DllCall($ghwimgapi, "handle", "WIMCaptureImage", _
			"handle", $hWIM, _
			"wstr", $sPath, _
			"dword", $dwCaptureFlags)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_CaptureImage

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_CloseHandle
; Description ...: Closes an open Windows imaging (.wim) file or image handle.
; Syntax.........: _WIM_CloseHandle($hObject)
; Parameters ....: $hObject - The handle to an open, image-based object.
; Return values .: Success - Returns Nonzero.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: The WIMCloseHandle function closes handles to the following objects:
;				   - A .wim file
;				   - A volume image
;				   If there are any open volume image handles, closing a .wim file fails.
;				   Use the WIMCloseHandle function to close handles returned by calls to the _WIM_CreateFile, _WIM_LoadImage, and _WIM_CaptureImage functions.
; Related .......: _WIM_CreateFile, _WIM_LoadImage, _WIM_CaptureImage
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_CloseHandle($hObject)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMCloseHandle", _
			"handle", $hObject)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_CloseHandle

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_CreateFile
; Description ...: Makes a new image file or opens an existing image file.
; Syntax.........: _WIM_CreateFile($sWimPath,[$dwDesiredAccess],[$dwCreationDisposition],[$dwFlagsAndAttributes],[$dwCompressionType],[$pdwCreationResult])
; Parameters ....: $sWimPath              - The name of the file to create or to open.
;				   $dwDesiredAccess       - Specifies the type of access to the object.
;										    An application can obtain read access, write access, read/write access, or device query access.
;									        For this parameter you can use any combination of the following values:
;											| 0                  - Specifies query access to the file. An application can query image information without accessing the images.
;											| $WIM_GENERIC_READ  - Specifies read-only access to the image file. Enables images to be applied from the file. Combine with $WIM_GENERIC_WRITE for read/write (append) access.
;											| $WIM_GENERIC_WRITE - Specifies write access to the image file. Enables images to be captured to the file. Includes $WIM_GENERIC_READ access to enable apply and append operations with existing images.
;											| $WIM_GENERIC_MOUNT - Specifies mount access to the image file. Enables images to be mounted with _WIM_MountImageHandle.
;			       $dwCreationDisposition - Specifies which action to take on files that exist, and which action to take when files do not exist.
;											For this parameteryou must use one of the following values:
;											| $WIM_CREATE_NEW    - Makes a new image file. If the specified file already exists, the function fails.
;											| $WIM_CREATE_ALWAYS - Makes a new image file. If the file exists, the function overwrites the file.
;											| $WIM_OPEN_EXISTING - Opens the image file. If the file does not exist, the function fails.
;											| $WIM_OPEN_ALWAYS   - Opens the image file if it exists. If the file does not exist and the caller requests $WIM_GENERIC_WRITE access, the function makes the file.
;				   $dwFlagsAndAttributes  - Specifies special actions to be taken for the specified file.
;											| $WIM_FLAG_VERIFY      - Generates data integrity information for new files. Verifies and updates existing files.
;											| $WIM_FLAG_SHARE_WRITE - Opens the .wim file in a mode that enables simultaneous reading and writing.
;                  $dwCompressionType     - Specifies the compression mode to be used for a newly created image file. If the file already exists, then this value is ignored.
;									        For this parameter, you must use one of the following values:
;											| $WIM_COMPRESS_NONE   - Capture does not use file compression.
;											| $WIM_COMPRESS_XPRESS - Capture uses XPRESS file compression. (fast)
;											| $WIM_COMPRESS_LZX    - Capture uses LZX file compression. (max)
;				   $pdwCreationResult     - A pointer to a variable that receives one of the following creation-result values. If this information is not required, specify 0.
;											| $WIM_CREATED_NEW     - The file did not exist and was created.
;											| $WIM_OPENED_EXISTING - The file existed and was opened for access.
; Return values .: Success - Returns an open handle to the specified image file.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: Use the _WIM_CloseHandle function to close the handle returned by the WIMCreateFile function.
; Related .......: _WIM_CloseHandle
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_CreateFile($sWimPath, $dwDesiredAccess = $WIM_GENERIC_READ, $dwCreationDisposition = $WIM_OPEN_ALWAYS, _
		$dwFlagsAndAttributes = $WIM_FLAG_SHARE_WRITE, $dwCompressionType = $WIM_COMPRESS_XPRESS, $pdwCreationResult = 0)

	Local $aResult = DllCall($ghwimgapi, "handle", "WIMCreateFile", _
			"wstr", $sWimPath, _
			"dword", $dwDesiredAccess, _
			"dword", $dwCreationDisposition, _
			"dword", $dwFlagsAndAttributes, _
			"dword", $dwCompressionType, _
			"int*", $pdwCreationResult)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_CreateFile

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_DeleteImage
; Description ...: Removes an image from within a .wim (Windows image) file so it cannot be accessed.
;				   However, the file resources are still available for use by the _WIM_SetReferenceFile function.
; Syntax.........: _WIM_DeleteImage($hWim, $dwImageIndex)
; Parameters ....: $hWim         - The handle to a .wim file returned by the WIMCreateFile function.
;					               This handle must have $WIM_GENERIC_WRITE access to delete the image. Split .wim files are not supported
;						           and the .wim file cannot have any open images.
;				   $dwImageIndex - Specifies the one-based index of the image to delete.
; Return values .: Success - Returns Nonzero.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
;				   If there is only one image in the specified .wim file, then the _WIM_DeleteImage function will fail and set the LastError to ERROR_ACCESS_DENIED (0x5).
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: You must call the _WIM_SetTemporaryPath function before calling the _WIM_DeleteImage function so the image metadata
;				   for the image can be extracted and processed from the temporary location.
; Related .......: _WIM_CreateFile, _WIM_SetReferenceFile, _WIM_SetTemporaryPath
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_DeleteImage($hWIM, $dwImageIndex)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMDeleteImage", _
			"handle", $hWIM, _
			"dword", $dwImageIndex)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_DeleteImage

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_DeleteImageMounts
; Description ...: Removes images from all directories where they have been previously mounted.
; Syntax.........: _WIM_DeleteImageMounts($dwDeleteFlags)
; Parameters ....: $dwDeleteFlags - Specifies which types of images are to be removed.
;				   | 0 - Removes only images that are not actively mounted.
;				   | WIM_DELETE_MOUNTS_ALL - Removes all mounted images, whether actively mounted or not.
; Return values .: Success - Returns Nonzero.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......:
; Related .......: _WIM_MountImage, _WIM_MountImageHandle, _WIM_UnmountImage, _WIM_UnmountImageHandle
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_DeleteImageMounts($dwDeleteFlags)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMDeleteImageMounts", _
			"dword", $dwDeleteFlags)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_DeleteImageMounts

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_ExportImage
; Description ...: Transfers the data of an image from one Windows image (.wim) file to another.
; Syntax.........: _WIM_ExportImage($hImage, $hWim, $dwFlags)
; Parameters ....: $hImage  - A handle to an image opened by the _WIM_LoadImage function.
;				   $hWim    - A handle to a .wim file returned by the _WIM_CreateFile function.
;							  This handle must have $WIM_GENERIC_WRITE access to accept the exported image. Split .wim files are not supported.
;				   $dwFlags - Specifies how the image will be exported to the destination .wim file.
;							  | 0                            - No flags
;							  | $WIM_EXPORT_ALLOW_DUPLICATES - The image will be exported to the destination .wim file even if it is already stored in that .wim file.
;							  | $WIM_EXPORT_ONLY_RESOURCES   - File resources will be exported to the destination .wim file and no image resources or XML information will be included.
;							  | $WIM_EXPORT_ONLY_METADATA    - Image resources and XML information are exported to the destination .wim file and no supporting file resources are included.
; Return values .: Success - Returns Nonzero.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: You must call the _WIM_SetTemporaryPath function for both the source and the destination .wim files
;				   before calling the _WIM_ExportImage function.
;				   If zero is passed in for the dwFlags parameter and the image is already stored in the destination,
;				   the function will return FALSE and set the LastError to ERROR_ALREADY_EXISTS (0xB7).
; Related .......: _WIM_CreateFile, _WIM_LoadImage, _WIM_SetTemporaryPath
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_ExportImage($hImage, $hWIM, $dwFlags)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMExportImage", _
			"handle", $hImage, _
			"handle", $hWIM, _
			"dword", $dwFlags)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_ExportImage

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_ExtractImagePath
; Description ...: Extracts a file from within a Windows® image (.wim) file to a specified location.
; Syntax.........: _WIM_ExtractImagePath($hImage, $sImagePath, $sDestinationPath, $dwExtractFlags)
; Parameters ....: $hImage           - A handle to an image opened by the _WIM_LoadImage function.
;				   $sImagePath       - A file path inside the image.
;				   $sDestinationPath - The full file path of the directory where the image path is to be extracted.
;				   $dwExtractFlags   - Reserved. Must be zero.
; Return values .: Success - Returns nonzero.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......:
; Related .......: _WIM_CreateFile, _WIM_LoadImage
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_ExtractImagePath($hImage, $sImagePath, $sDestinationPath, $dwExtractFlags = 0)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMExtractImagePath", _
			"handle", $hImage, _
			"wstr", $sImagePath, _
			"wstr", $sDestinationPath, _
			"dword", $dwExtractFlags)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_ExtractImagePath

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_GetAttributes
; Description ...: Returns the number of volume images stored in an image file.
; Syntax.........: _WIM_GetAttributes($hWim)
; Parameters ....: $hWim   - The handle to a .wim file returned by WIMCreateFile.
; Return values .: Success - Returns an array where:
;				   |$aReturn[0] - 1 (DllCall success)
;				   |$aReturn[1] - WimPath
;				   |$aReturn[2] - GUID
;				   |$aReturn[3] - Image Count
;				   |$aReturn[4] - Compression Type
;				   |$aReturn[5] - Part Number
;				   |$aReturn[6] - Total Parts
;				   |$aReturn[7] - Boot Index
;				   |$aReturn[8] - Wim Attributes
;				   |$aReturn[9] - Wim Flags and Attributes
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......:
; Related .......: _WIM_CreateFile
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_GetImageAttributes($hWIM)

	Local $aReturn[10] ; array to hold the return data
	Local $pWimInfo = DllStructCreate($tagWIM_INFO)

	$aResult = DllCall($ghwimgapi, "bool", "WIMGetAttributes", _
			"handle", $hWIM, _
			"ptr", DllStructGetPtr($pWimInfo), _
			"dword", DllStructGetSize($pWimInfo))
	If @error Then Return SetError(@error, @extended, 0)

	; lets make the GUID pretty
	Local $tguid = DllStructCreate($tagGUID)
	DllStructSetData($tguid, 1, BinaryMid(DllStructGetData($pWimInfo, "Guid"), 1, 4)) ; Data1 - 4 bytes
	DllStructSetData($tguid, 2, BinaryMid(DllStructGetData($pWimInfo, "Guid"), 5, 2)) ; Data2 - 2 bytes
	DllStructSetData($tguid, 3, BinaryMid(DllStructGetData($pWimInfo, "Guid"), 7, 2)) ; Data3 - 2 bytes
	DllStructSetData($tguid, 4, BinaryMid(DllStructGetData($pWimInfo, "Guid"), 9, 8)) ; Data4 - 8 bytes

	; build our return array and fill it with all the attributes
	$aReturn[0] = $aResult[0]
	$aReturn[1] = DllStructGetData($pWimInfo, "WimPath")
	$aReturn[2] = _WinAPI_StringFromGUID(DllStructGetPtr($tguid))
	$aReturn[3] = DllStructGetData($pWimInfo, "ImageCount")
	$aReturn[4] = DllStructGetData($pWimInfo, "CompressionType")
	$aReturn[5] = DllStructGetData($pWimInfo, "PartNumber")
	$aReturn[6] = DllStructGetData($pWimInfo, "TotalParts")
	$aReturn[7] = DllStructGetData($pWimInfo, "BootIndex")
	$aReturn[8] = DllStructGetData($pWimInfo, "WimAttributes")
	$aReturn[9] = DllStructGetData($pWimInfo, "WimFlagsAndAttr")

	Return SetError(@error, _WinAPI_GetLastError(), $aReturn)
EndFunc   ;==>_WIM_GetImageAttributes

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_GetImageCount
; Description ...: Returns the number of volume images stored in a Windows image (.wim) file.
; Syntax.........: _WIM_GetImageCount($hIWim)
; Parameters ....: $hWim   - The handle to a .wim file returned by WIMCreateFile.
; Return values .: Success - Returns the number of images in the .wim file. If this value is zero, then the image file is invalid
;							 or does not contain any images that can be applied.
;                  Failure - Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......:
; Related .......: _WIM_CreateFile
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_GetImageCount($hWIM)

	Local $aResult = DllCall($ghwimgapi, "dword", "WIMGetImageCount", _
			"handle", $hWIM)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_GetImageCount

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_GetImageInformation
; Description ...: Returns information about an image within the .wim (Windows image) file.
; Syntax.........: _WIM_GetImageInformation($hImage)
; Parameters ....: $hImage - A handle returned by the WIMCreateFile, WIMLoadImage, or WIMCaptureImage function.
; Return values .: Success - Returns an array where:
;				   |$aReturn[0] - 1 (DllCall success)
;				   |$aReturn[1] - A string containing the XML data for the image.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32), JFX
; Modified.......:
; Remarks .......: When the function succeeds, then the data describing the image is in Unicode XML format.
; Related .......: _WIM_CreateFile, _WIM_LoadImage, _WIM_CaptureImage
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_GetImageInformation($hImage)

	Local $aReturn[2] ; array to hold the return data
	Local $ppvImageInfo = DllStructCreate("ptr") ; Buffer for XML Data
	Local $pcbImageInfo = DllStructCreate("int") ; Size of buffer in bytes

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMGetImageInformation", _
			"handle", $hImage, _
			"ptr", DllStructGetPtr($ppvImageInfo), _
			"ptr", DllStructGetPtr($pcbImageInfo))
	If @error Then Return SetError(@error, @extended, 0)

    ; create a struct so we have access to the buffer where the XML data is stored
	; reading data as normally as wchar is causing random hard crashes with DllStructGetData()
	; by reading the data as byte and converting BinaryToString we prevent the crash.
	; Thanks to JFX for helping with the solution.
    Local $xml = DllStructCreate("byte [" & DllStructGetData($pcbImageInfo, 1) & "]", DllStructGetData($ppvImageInfo, 1))
    $aReturn[0] = $aResult[0]
    $aReturn[1] = BinaryToString(DllStructGetData($xml, 1), 2)
	_WinAPI_LocalFree($ppvImageInfo)
	_WinAPI_LocalFree($xml)
    Return SetError(@error, _WinAPI_GetLastError(), $aReturn)
EndFunc   ;==>_WIM_GetImageInformation

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_LoadImage
; Description ...: Loads a volume image from a Windows image (.wim) file.
; Syntax.........: _WIM_CaptureImage($hWIM, $dwImageIndex)
; Parameters ....: $hWim           - The handle to a .wim file returned by _WIM_CreateFile
;				   $dwImageIndex   - Specifies the one-based index of the image to load. An image file may store multiple images.
; Return values .: Success - Returns an open handle to an object representing the volume image.
;                  Failure - Returns NULL and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: You must call the WIMSetTemporaryPath function before calling the WIMLoadImage function so the image metadata
;				   can be extracted and processed from the temporary location.
;				   Use the WIMCloseHandle function to unload the volume image.
; Related .......: _WIM_CreateFile, _WIM_CloseHandle, _WIM_SetTemporaryPath
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_LoadImage($hWIM, $dwImageIndex)

	Local $aResult = DllCall($ghwimgapi, "handle", "WIMLoadImage", _
			"handle", $hWIM, _
			"dword", $dwImageIndex)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_LoadImage

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_MountImage
; Description ...: Mounts a WIM image to the specified directory.
; Syntax.........: _WIM_MountImage($sMountPath,$sWimFileName,$dwImageIndex,[$sTempPath])
; Parameters ....: $sMountPath   - The full file path of the directory to which the .wim file has to be mounted.
;				   $sWimFileName - The full file name of the .wim file that has to be mounted.
;			       $dwImageIndex - An index of the image in the .wim file that has to be mounted.
;				   $sTempPath    - The full file path to the temporary directory in which changes to the .wim file can be tracked.
;								   If this parameter is NULL, the image will not be mounted for edits.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: The WIMMountImage function maps the contents of the given image in a .wim file to the specified mount directory.
;				   After the successful completion of this operation, users or applications can access the contents of the image mapped
;				   under the mount directory.
;				   Use the WIMUnmountImage function to unmount the image from the mount directory.
; Related .......: _WIM_UnMountImage
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_MountImage($sMountPath, $sWimFileName, $dwImageIndex, $sTempPath = 0)

	If IsString($sTempPath) Then
		Local $aResult = DllCall($ghwimgapi, "bool", "WIMMountImage", _
				"wstr", $sMountPath, _
				"wstr", $sWimFileName, _
				"dword", $dwImageIndex, _
				"wstr", $sTempPath)
	Else
		; Workaround for using Vista AIK wimgapi.dll
		; wimgapi.dll < 6.1 doesn't accept NULL for the temp folder in the mount command.
		; More Info: http://galapo.net/gena/forum/index.php?topic=101.msg1648#msg1648
		Local $aResult = DllCall($ghwimgapi, "bool", "WIMMountImage", _
				"wstr", $sMountPath, _
				"wstr", $sWimFileName, _
				"dword", $dwImageIndex, _
				"int", 0)
	EndIf

	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_MountImage

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_RegisterLogFile
; Description ...: Registers a log file for debugging or tracing purposes into the current WIMGAPI session.
; Syntax.........: _WIM_RegisterLogFile($sLogFile, $dwFlags = 0)
; Parameters ....: $hLogFile - A handle to the file returned by FileOpen to receive debug or tracing information.
;				   $dwFlags  - Reserved. Must be zero.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......:
; Related .......: _WIM_UnRegisterLogFile
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_RegisterLogFile($hLogFile, $dwFlags = 0)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMRegisterLogFile", _
			"wstr", $hLogFile, _
			"dword", $dwFlags)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_RegisterLogFile

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_RegisterMessageCallback
; Description ...: Registers a function to be called with imaging-specific data. For information about the messages that can be
;				   handled, see the Microsoft Imaging APIs Documentation.
; Syntax.........: _WIM_RegisterMessageCallback($hWIM, $fpMessageProc, [$pvUserData = 0])
; Parameters ....: $hWim          - The handle to a .wim file returned by WIMCreateFile.
;				   $fpMessageProc - A pointer to an application-defined callback function. For more information, see the _WIM_MessageCallback function.
;				   $pvUserData    - A pointer that specifies an application-defined value to be passed to the callback function.
; Return values .: Success - Returns the zero-based index of the callback.
;                  Failure - Returns INVALID_CALLBACK_VALUE (0xFFFFFFFF) and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: If a WIM handle is specified, the callback function receives messages for only that WIM file.
;				   If no handle is specified, then the callback function receives messages for all image handles.
;				   Call the _WIM_UnregisterMessageCallback function when the callback function is no longer required.
; Related .......: _WIM_MessageCallback, _WIM_UnregisterMessageCallback
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_RegisterMessageCallback($hWIM, $fpMessageProc, $pvUserData = 0)

	Local $aResult = DllCall($ghwimgapi, "dword", "WIMRegisterMessageCallback", _
			"handle", $hWIM, _
			"ptr", $fpMessageProc, _
			"ptr", $pvUserData)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_RegisterMessageCallback

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_RemountImage
; Description ...: Reactivates a mounted image that was previously mounted to the specified directory.
; Syntax.........: _WIM_RemountImage($sMountPath, $dwFlags)
; Parameters ....: $sMountPath - The full file path of the directory to which the .wim file must be remounted.
;				   $$dwFlags   - Reserved. Must be zero.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: The WIMRemountImage function maps the contents of the given image in a .wim file to the specified mount directory.
;				   After the successful completion of this operation, users or applications can access the contents of the image mapped under the mount directory.
;				   Use the _WIM_UnmountImage function to unmount the image from the mount directory.
; Related .......: _WIM_MountImage, _WIM_UnmountImage
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_RemountImage($sMountPath, $dwFlags = 0)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMSetBootImage", _
			"wstr", $sMountPath, _
			"dword", $dwFlags)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_RemountImage

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_SetBootImage
; Description ...: Marks the image with the given image index as bootable.
; Syntax.........: _WIM_SetBootImage($hWim, $dwImageIndex)
; Parameters ....: $hWim        - A handle to a Windows image (.wim) file returned by the _WIM_CreateFile function.
;				   $dwImgeIndex - The one-based index of the image to load. An image file can store multiple images.
; Return values .: Success - Returns Nonzero.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: If the input value for the dwImageIndex is zero, then none of the images in the .wim file are marked for boot.
;				   At any time, only one image in a .wim file can be set to be bootable.
; Related .......: _WIM_CreateFile
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_SetBootImage($hWIM, $dwImageIndex)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMSetBootImage", _
			"handle", $hWIM, _
			"dword", $dwImageIndex)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_SetBootImage

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_SetImageInformation
; Description ...: Stores information about an image in the Windows image (.wim) file.
; Syntax.........: _WIM_SetImageInformation($hImage, $sXML)
; Parameters ....: $hImage - A handle returned by the _WIM_CreateFile, _WIM_LoadImage, or _WIM_CaptureImage functions.
;				   $sXML   - A string representing a Unicode XML file that contains information about the volume image.
; Return values .: Success - Returns Nonzero.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: The string being passed into the function must be the memory representation of a Unicode XML file.
;				  Calling this function replaces any customized image data, so, to preserve existing XML information,
;				  call the _WIM_GetImageInformation function and append or edit the data.
;				  If the input handle is from the _WIM_CreateFile function, then the XML data must be enclosed by <WIM></WIM> tags.
;				  If the input handle is from the _WIM_LoadImage or _WIM_CaptureImage functions, then the XML data must be enclosed by <IMAGE></IMAGE> tags.
; Related .......: _WIM_CreateFile, _WIM_LoadImage, _WIM_CaptureImage, _WIM_GetImageInformation
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_SetImageInformation($hImage, $sXML)

	; store our unicode XML string into a buffer that WIMSetImageInformation can read
	Local $pvImageInfo = DllStructCreate("wchar[" & StringLen($sXML) * 4 & "]") ; Buffer for XML Data - Unicode chars are 4bytes
	DllStructSetData($pvImageInfo, 1, $sXML) ; load the data into the buffer

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMSetImageInformation", _
			"handle", $hImage, _
			"ptr", DllStructGetPtr($pvImageInfo), _ ; ptr to buffer
			"dword", DllStructGetSize($pvImageInfo)) ; buffer size in bytes
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_SetImageInformation

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_SetReferenceFile
; Description ...: Enables the WIMApplyImage and WIMCaptureImage functions to use alternate .wim files for file resources.
;				   This can enable optimization of storage when multiple images are captured with similar data.
; Syntax.........: _WIM_SetReferenceFile($hWim, $sPath, [$dwFlags = $WIM_REFERENCE_APPEND])
; Parameters ....: $$hWim   - A handle to a wim file returned by the _WIM_CreateFile function.
;				   $sPath   - A string containing the path of the .wim file to be added to the reference list.
;				   $dwFlags - Specifies how the .wim file is added to the reference list.
;							  This parameter must include one of the following two values:
;							  | $WIM_REFERENCE_APPEND  - The specified .wim file is appended to the current list.
;							  | $WIM_REFERENCE_REPLACE - The specified .wim file becomes the only item in the list.
;                             This parameter can also include any combination of the following flags.
;							  | $WIM_FLAG_VERIFY      - Data integrity information is generated for new files, verified, and updated for existing files.
;							  | $WIM_FLAG_SHARE_WRITE - The .wim file is opened in a mode that enables simultaneous reading and writing.
; Return values .: Success - Returns nonzero.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: If 0 is passed in for the $sPath parameter and $WIM_REFERENCE_REPLACE is passed for the $dwFlags parameter,
;				   then the reference list is completely cleared, and no file resources are extracted during the _WIM_ApplyImage function.
; Related .......: _WIM_ApplyImage
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_SetReferenceFile($hWIM, $sPath, $dwFlags = $WIM_REFERENCE_APPEND)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMSetReferenceFile", _
			"handle", $hWIM, _
			"wstr", $sPath, _
			"dword", $dwFlags)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_SetReferenceFile

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_SetTemporaryPath
; Description ...: Sets the location where temporary imaging files are to be stored.
; Syntax.........: _WIM_SetTemporaryPath($hWIM, $sPath)
; Parameters ....: $hWIM  - A handle to a .wim file returned by the _WIM_CreateFile function.
;				   $sPath - A string indicating the path where temporary image (.wim) files are to be stored during capture or application.
;				            This is the directory where the image is captured or applied.
; Return values .: Success - Returns Nonzero.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......:
; Related .......: _WIM_CreateFile
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_SetTemporaryPath($hWIM, $sPath)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMSetTemporaryPath", _
			"handle", $hWIM, _
			"wstr", $sPath)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_SetTemporaryPath

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_Shutdown
; Description ...: Unload wimgapi.dll
; Syntax.........: _WIM_Shutdown()
; Parameters ....:
; Return values .: Success - 1
;                  Failure - 0 if handle is already closed
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: Use this function to free resouces when you are done using WIM functions.
; Related .......: _WIM_Startup
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_Shutdown()
	If $ghwimgapi = 0 Then Return SetError(-1, -1, False) ; handle is already closed.

	$giWIMRef -= 1
	If $giWIMRef = 0 Then
		DllClose($ghwimgapi)
		$ghwimgapi = 0
	EndIf
	Return True
EndFunc   ;==>_WIM_Shutdown

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_Startup
; Description ...: Load wimgapi.dll
; Syntax.........: _WIM_Startup()
; Parameters ....:
; Return values .: Success - Returns 0 and sets $ghwimgapi and Sets @Extended to $ghwimgapi
;                  Failure - Returns -1 and Sets @Error:
;                  |0 - No DLLCall error.
;                  |1 - Error in DLLOpen
;				   |2 - File does not exist
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: This function needs to be called once before any other WIM functions can be used.
;				   Use the _WIM_Shutdown function to free resouces when you are done.
; Related .......: _WIM_Shutdown
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_Startup()
	$giWIMRef += 1
	If $giWIMRef > 1 Then Return SetExtended($ghwimgapi, 0) ; dll already loaded

	If Not FileExists($gsWimDLL) Then Return SetError(2, 0, -1) ; $gsWimDLL does not exist

	$ghwimgapi = DllOpen($gsWimDLL) ; remember $ghwimgapi is Global
	If $ghwimgapi = -1 Then Return SetError(1, 0, -1) ; Error opening dll
	Return SetExtended($ghwimgapi, 0) ; success!
EndFunc   ;==>_WIM_Startup

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_UnMountImage
; Description ...: UnMounts a WIM image.
; Syntax.........: _WIM_UnMountImage($sMountPath,[$sWimFileName = 0],[$dwImageIndex = 0],[$iCommitChanges = 0])
; Parameters ....: $sMountPath     - The full file path of the directory to which the .wim file was mounted.
;				   $sWimFileName   - The full file name of the .wim file that must be unmounted.
;			       $dwImageIndex   - Specifies the index of the image in the .wim file that must be unmounted.
;				   $iCommitChanges - A flag that indicates whether changes (if any) to the .wim file must be committed before
;				   |				 unmounting the .wim file. This flag has no effect if the .wim file was mounted not to enable edits.
;                  | 0 - Don't Commit Changes
;                  | 1 - Commit Changes
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......: The WIMUnmountImage function unmaps the contents of the given image in the .wim file from the specified mount
;				   directory. After the successful completion of this operation, users or applications will not be able to access
;				   the contents of the image previously mapped under the mount directory.
; Related .......: _WIM_MountImage
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_UnMountImage($sMountPath, $sWimFileName = 0, $dwImageIndex = 0, $iCommitChanges = 0)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMUnmountImage", _
			"wstr", $sMountPath, _
			"wstr", $sWimFileName, _ ; not used in unmount
			"dword", $dwImageIndex, _ ; not used in unmount
			"bool", $iCommitChanges)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_UnMountImage

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_UnRegisterLogFile
; Description ...: Unregisters a log file for debugging or tracing purposes from the current WIMGAPI session.
; Syntax.........: _WIM_UnRegisterLogFile($sLogFile)
; Parameters ....: $sLogFile - The full file path of the file to receive debug or tracing information. This parameter is required and cannot be NULL.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......:
; Related .......: _WIM_RegisterLogFile
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_UnRegisterLogFile($sLogFile)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMUnregisterLogFile", _
			"wstr", $sLogFile)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_UnRegisterLogFile

; #FUNCTION# ====================================================================================================================
; Name...........: _WIM_UnregisterMessageCallback
; Description ...: Unregisters a function from being called with imaging-specific data.
; Syntax.........: _WIM_UnregisterMessageCallback($hWIM, $fpMessageProc)
; Parameters ....: $hWim          - The handle to a .wim file returned by WIMCreateFile.
;				   $fpMessageProc - A pointer to the application-defined callback function to unregister. Specify 0 to unregister all callback functions.
; Return values .: Success - Returns Nonzero.
;                  Failure - Returns 0 and Sets @Error:
;                  |0 - No DLLCall error.
; 				   |1 - Unable to use the DLL file
; 				   |2 - Unknown "return type"
; 				   |3 - "function" not found in the DLL file
;				   |4 - Bad number of parameters.
;				   Both - Sets @Extended to _WinAPI_GetLastError()
; Author(s) .....: Jonathan Holmgren (Homes32)
; Modified.......:
; Remarks .......:
; Related .......: WIMCreateFile, _WIM_RegisterMessageCallback
; Link ..........;
; Example .......;
;
; ===============================================================================================================================
Func _WIM_UnregisterMessageCallback($hWIM, $fpMessageProc)

	Local $aResult = DllCall($ghwimgapi, "bool", "WIMUnregisterMessageCallback", _
			"handle", $hWIM, _
			"ptr", $fpMessageProc)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended(_WinAPI_GetLastError(), $aResult[0])
EndFunc   ;==>_WIM_UnregisterMessageCallback
;EOF