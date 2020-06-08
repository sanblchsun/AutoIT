#include-once

; #INDEX# =======================================================================================================================
; Title .........: WIM_Constants
; AutoIt Version : 3.3.6.1
; Description ...: Constants for WIM functions.
; Author(s) .....: Nikzzzz, Jonathan Holmgren (Homes32)
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
#region ### START $WIM Constants ###

; WIMCreateFile:
;

Global Const $WIM_GENERIC_READ = 0x80000000 ; GENERIC_READ
Global Const $WIM_GENERIC_WRITE = 0x40000000 ; GENERIC_WRITE
Global Const $WIM_GENERIC_MOUNT = 0x20000000 ; GENERIC_EXECUTE

Global Const $WIM_CREATE_NEW = 0x00000001 ; CREATE_NEW
Global Const $WIM_CREATE_ALWAYS = 0x00000002 ; CREATE_ALWAYS
Global Const $WIM_OPEN_EXISTING = 0x00000003 ; OPEN_EXISTING
Global Const $WIM_OPEN_ALWAYS = 0x00000004 ;OPEN_ALWAYS

Global Const $WIM_COMPRESS_NONE = 0x00000000 ; ImageX "/none"
Global Const $WIM_COMPRESS_XPRESS = 0x00000001 ; ImageX "/fast"
Global Const $WIM_COMPRESS_LZX = 0x00000002 ; ImageX "/max"

Global Const $WIM_CREATED_NEW = 0x00000000
Global Const $WIM_OPENED_EXISTING = 0x00000001

; WIMCreateFile, WIMCaptureImage, WIMApplyImage, WIMMountImageHandle flags:
;
Global Const $WIM_FLAG_RESERVED = 0x00000001
Global Const $WIM_FLAG_VERIFY = 0x00000002
Global Const $WIM_FLAG_INDEX = 0x00000004
Global Const $WIM_FLAG_NO_APPLY = 0x00000008
Global Const $WIM_FLAG_NO_DIRACL = 0x00000010
Global Const $WIM_FLAG_NO_FILEACL = 0x00000020
Global Const $WIM_FLAG_SHARE_WRITE = 0x00000040
Global Const $WIM_FLAG_FILEINFO = 0x00000080
Global Const $WIM_FLAG_NO_RP_FIX = 0x00000100
Global Const $WIM_FLAG_MOUNT_READONLY = 0x00000200

; WIMGetMountedImageList flags
;
Global Const $WIM_MOUNT_FLAG_MOUNTED = 0x00000001
Global Const $WIM_MOUNT_FLAG_MOUNTING = 0x00000002
Global Const $WIM_MOUNT_FLAG_REMOUNTABLE = 0x00000004
Global Const $WIM_MOUNT_FLAG_INVALID = 0x00000008
Global Const $WIM_MOUNT_FLAG_NO_WIM = 0x00000010
Global Const $WIM_MOUNT_FLAG_NO_MOUNTDIR = 0x00000020
Global Const $WIM_MOUNT_FLAG_MOUNTDIR_REPLACED = 0x00000040
Global Const $WIM_MOUNT_FLAG_READWRITE = 0x00000100

; WIMCommitImageHandle flags
;
Global Const $WIM_COMMIT_FLAG_APPEND = 0x00000001

; WIMSetReferenceFile
;
Global Const $WIM_REFERENCE_APPEND = 0x00010000
Global Const $WIM_REFERENCE_REPLACE = 0x00020000

; WIMExportImage
;
Global Const $WIM_EXPORT_ALLOW_DUPLICATES = 0x00000001
Global Const $WIM_EXPORT_ONLY_RESOURCES = 0x00000002
Global Const $WIM_EXPORT_ONLY_METADATA = 0x00000004

; WIMRegisterMessageCallback:
;
Global Const $INVALID_CALLBACK_VALUE = 0xFFFFFFFF

; WIMCopyFile
;
Global Const $WIM_COPY_FILE_RETRY = 0x01000000

; WIMDeleteImageMounts
;
Global Const $WIM_DELETE_MOUNTS_ALL = 0x00000001

; WIMMessageCallback Notifications:
;
Global Const $WIM_MSG_TEXT = 38007
Global Const $WIM_MSG_PROGRESS = 38008
Global Const $WIM_MSG_PROCESS = 38009
Global Const $WIM_MSG_SCANNING = 38010
Global Const $WIM_MSG_SETRANGE = 38011
Global Const $WIM_MSG_SETPOS = 38012
Global Const $WIM_MSG_STEPIT = 38013
Global Const $WIM_MSG_COMPRESS = 38014
Global Const $WIM_MSG_ERROR = 38015
Global Const $WIM_MSG_ALIGNMENT = 38016
Global Const $WIM_MSG_RETRY = 38017
Global Const $WIM_MSG_SPLIT = 38018
Global Const $WIM_MSG_FILEINFO = 38019
Global Const $WIM_MSG_INFO = 38020
Global Const $WIM_MSG_WARNING = 38021
Global Const $WIM_MSG_CHK_PROCESS = 38022
Global Const $WIM_MSG_WARNING_OBJECTID = 38023
Global Const $WIM_MSG_STALE_MOUNT_DIR = 38024
Global Const $WIM_MSG_STALE_MOUNT_FILE = 38025
Global Const $WIM_MSG_MOUNT_CLEANUP_PROGRESS = 38026
Global Const $WIM_MSG_CLEANUP_SCANNING_DRIVE = 38027
Global Const $WIM_MSG_IMAGE_ALREADY_MOUNTED = 38028
Global Const $WIM_MSG_CLEANUP_UNMOUNTING_IMAGE = 38029
Global Const $WIM_MSG_QUERY_ABORT = 38030

; WIMMessageCallback Return codes:
;
Global Const $WIM_MSG_SUCCESS = 0x00000000
Global Const $WIM_MSG_DONE = 0xFFFFFFF0
Global Const $WIM_MSG_SKIP_ERROR = 0xFFFFFFFE
Global Const $WIM_MSG_ABORT_IMAGE = 0xFFFFFFFF

; WIM_INFO dwFlags values:
;
Global Const $WIM_ATTRIBUTE_NORMAL = 0x00000000
Global Const $WIM_ATTRIBUTE_RESOURCE_ONLY = 0x00000001
Global Const $WIM_ATTRIBUTE_METADATA_ONLY = 0x00000002
Global Const $WIM_ATTRIBUTE_VERIFY_DATA = 0x00000004
Global Const $WIM_ATTRIBUTE_RP_FIX = 0x00000008
Global Const $WIM_ATTRIBUTE_SPANNED = 0x00000010
Global Const $WIM_ATTRIBUTE_READONLY = 0x00000020

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagWIM_INFO
; Description ...: The WIM_INFO structure contains information retrieved by the WIMGetAttributes function.
; Fields ........: WimPath         - Specifies the full path to the .wim file.
;                  GUID            - Specifies a GUID structure containing the unique identifier for the Windows image (.wim) file.
;                  ImageCount      - Specifies the number of images contained in the .wim file. This value is also returned by the WIMGetImageCount function.
;                  CompressionType - Specifies the method of compression used to compress resources in the .wim file.
;									   | $WIM_COMPRESS_NONE   - Wim does not use file compression.
;									   | $WIM_COMPRESS_XPRESS - Wim uses XPRESS file compression. (fast)
;									   | $WIM_COMPRESS_LZX    - Wim uses LZX file compression. (max)
;                  PartNumber      - Specifies the part number of the current .wim file in a spanned set.
;									 This value should be one, unless the data of the .wim file was originally split by the _WIM_SplitFile function.
;                  TotalParts      - Specifies the total number of .wim file parts in a spanned set.
;									 This value must be one, unless the data of the .wim file was originally split via the _WIM_SplitFile function.
;                  BootIndex       - Specifies the index of the bootable image in the .wim file. If this value is zero, then there are no bootable images available.
;									 To set a bootable image, call the _WIM_SetBootImage function.
;                  WimAttributes   - Specifies how the file is treated and what features will be used.
;								   	   | $WIM_ATTRIBUTE_NORMAL        - The .wim file does not have any other attributes set.
;									   | $WIM_ATTRIBUTE_RESOURCE_ONLY - The .wim file only contains file resources and no images or metadata.
;									   | $WIM_ATTRIBUTE_METADATA_ONLY - The .wim file only contains image resources and XML information.
;									   | $WIM_ATTRIBUTE_VERIFY_DATA   - The .wim file contains integrity data that can be used by the _WIM_CopyFile or _WIM_CreateFile function.
;									   | $WIM_ATTRIBUTE_RP_FIX        - The .wim file contains one or more images where symbolic link or junction path fixup is enabled.
;									   | $WIM_ATTRIBUTE_SPANNED       - The .wim file has been split into multiple pieces via _WIM_SplitFile.
;									   | $WIM_ATTRIBUTE_READONLY      - The .wim file is locked and cannot be modified.
;				   WimFlagsAndAttr - Specifies the flags used during a _WIM_CreateFile function.
;									   | $WIM_FLAG_VERIFY      - Generates data integrity information for new files. Verifies and updates existing files.
;									   | $WIM_FLAG_SHARE_WRITE - Opens the .wim file in a mode that enables simultaneous reading and writing.
; Author ........: Jonathan Holmgren (Homes32)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagWIM_INFO = "wchar WimPath[260];byte Guid[16];dword ImageCount;dword CompressionType;ushort PartNumber;" & _
						 "ushort TotalParts;dword BootIndex;dword WimAttributes;dword WimFlagsAndAttr"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagWIM_MOUNT_LIST
; Description ...: Contains information retrieved by the WIMGetMountedImages function.
; Fields ........: WimPath      - Specifies the full path to the .wim file.
;                  MountPath    - Specifies the full path to the directory where the image is mounted.
;                  ImageIndex   - Specifies the image index within the .wim file specified in WimPath.
;                  MountedForRW - Specifies if the image was mounted with support for saving changes.
; Author ........: Jonathan Holmgren (Homes32)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagWIM_MOUNT_LIST = "WCHAR WimPath[260];WCHAR MountPath[260];DWORD ImageIndex;BOOL MountedForRW"

; #STRUCTURE# ===================================================================================================================
; Name...........: $tagWIM_MOUNT_INFO_LEVEL1
; Description ...: Contains information retrieved by the _WIM_GetMountedImageList function.
; Fields ........: WimPath    - Specifies the full path to the .wim file.
;                  MountPath  - Specifies the full path to the directory where the image is mounted.
;                  ImageIndex - Specifies the image index within the .wim file specified in WimPath.
;                  MountFlags - Specifies the current state of the mount point.
;				   		   	      | $WIM_MOUNT_FLAG_MOUNTED           - The image is actively mounted.
;								  | $WIM_MOUNT_FLAG_MOUNTING          - The image is in the process of mounting.
;								  | $WIM_MOUNT_FLAG_REMOUNTABLE       - The image is not mounted, but is capable of being remounted.
;								  | $WIM_MOUNT_FLAG_INVALID           - The image mount point is no longer valid.
;								  | $WIM_MOUNT_FLAG_NO_WIM            - TThe WIM file backing the mount point is missing or inaccessible.
;								  | $WIM_MOUNT_FLAG_NO_MOUNTDIR       - The image mount point has been removed or replaced.
;								  | $WIM_MOUNT_FLAG_MOUNTDIR_REPLACED - The mount point has been replaced with by a different mounted image.
;								  | $WIM_MOUNT_FLAG_READWRITE         - The image has been mounted with read-write access.
; Author ........: Jonathan Holmgren (Homes32)
; Remarks .......:
; ===============================================================================================================================
Global Const $tagWIM_MOUNT_INFO_LEVEL1 = "WCHAR WimPath[260];WCHAR MountPath[260];DWORD ImageIndex;DWORD MountFlags"


; Define _MOUNTED_IMAGE_INFO_LEVELS for WIMGetMountedImageInfo to determine structure to use...
;
Global Const $MountedImageInfoLevel0 = 0x00000001
Global Const $MountedImageInfoLevel1 = 0x00000002
Global Const $MountedImageInfoLevelInvalid = 0x00000003

#endregion ### END WIM Constants ###
; ===============================================================================================================================