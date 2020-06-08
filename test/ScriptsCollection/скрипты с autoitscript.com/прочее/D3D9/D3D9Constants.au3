#include-once

; SDK version number
Global Const $D3D_SDK_VERSION = 32

; Caps
Global Const $D3DCAPS_OVERLAY				= 0x00000800
Global Const $D3DCAPS_READ_SCANLINE			= 0x00020000

; Caps2
Global Const $D3DCAPS2_FULLSCREENGAMMA		= 0x00020000
Global Const $D3DCAPS2_CANCALIBRATEGAMMA	= 0x00100000
Global Const $D3DCAPS2_RESERVED				= 0x02000000
Global Const $D3DCAPS2_CANMANAGERESOURCE	= 0x10000000
Global Const $D3DCAPS2_DYNAMICTEXTURES		= 0x20000000
Global Const $D3DCAPS2_CANAUTOGENMIPMAP		= 0x40000000
Global Const $D3DCAPS2_CANSHARERESOURCE		= 0x80000000

; Caps3
Global Const $D3DCAPS3_RESERVED				= 0x8000001f

; Indicates that the device can respect the ALPHABLENDENABLE render state
; when fullscreen while using the FLIP or DISCARD swap effect.
; COPY and COPYVSYNC swap effects work whether or not this flag is set.
Global Const $D3DCAPS3_ALPHA_FULLSCREEN_FLIP_OR_DISCARD = 0x00000020

; Indicates that the device can perform a gamma correction from
; a windowed back buffer containing linear content to the sRGB desktop.
Global Const $D3DCAPS3_LINEAR_TO_SRGB_PRESENTATION = 0x00000080

Global Const $D3DCAPS3_COPY_TO_VIDMEM		= 0x00000100 ; Device can acclerate copies from sysmem to local vidmem
Global Const $D3DCAPS3_COPY_TO_SYSTEMMEM	= 0x00000200 ; Device can acclerate copies from local vidmem to sysmem
Global Const $D3DCAPS3_DXVAHD				= 0x00000400

; CursorCaps
Global Const $D3DCURSORCAPS_COLOR  = 0x00000001 ; Driver supports HW color cursor in at least hi-res modes(height >=400)
Global Const $D3DCURSORCAPS_LOWRES = 0x00000002 ; Driver supports HW cursor also in low-res modes(height < 400)

; DeviceCaps
Global Const $D3DDEVCAPS_EXECUTESYSTEMMEMORY = 0x00000010 		; Device can use execute buffers from system memory
Global Const $D3DDEVCAPS_EXECUTEVIDEOMEMORY = 0x00000020 		; Device can use execute buffers from video memory
Global Const $D3DDEVCAPS_TLVERTEXSYSTEMMEMORY = 0x00000040 		; Device can use TL buffers from system memory
Global Const $D3DDEVCAPS_TLVERTEXVIDEOMEMORY = 0x00000080 		; Device can use TL buffers from video memory
Global Const $D3DDEVCAPS_TEXTURESYSTEMMEMORY = 0x00000100 		; Device can texture from system memory
Global Const $D3DDEVCAPS_TEXTUREVIDEOMEMORY = 0x00000200 		; Device can texture from device memory
Global Const $D3DDEVCAPS_DRAWPRIMTLVERTEX = 0x00000400 			; Device can draw TLVERTEX primitives
Global Const $D3DDEVCAPS_CANRENDERAFTERFLIP = 0x00000800 		; Device can render without waiting for flip to complete
Global Const $D3DDEVCAPS_TEXTURENONLOCALVIDMEM = 0x00001000 	; Device can texture from nonlocal video memory
Global Const $D3DDEVCAPS_DRAWPRIMITIVES2 = 0x00002000 			; Device can support DrawPrimitives2
Global Const $D3DDEVCAPS_SEPARATETEXTUREMEMORIES = 0x00004000 	; Device is texturing from separate memory pools
Global Const $D3DDEVCAPS_DRAWPRIMITIVES2EX = 0x00008000 		; Device can support Extended DrawPrimitives2 i.e. DX7 compliant driver
Global Const $D3DDEVCAPS_HWTRANSFORMANDLIGHT = 0x00010000 		; Device can support transformation and lighting in hardware and DRAWPRIMITIVES2EX must be also
Global Const $D3DDEVCAPS_CANBLTSYSTONONLOCAL = 0x00020000 		; Device supports a Tex Blt from system memory to non-local vidmem
Global Const $D3DDEVCAPS_HWRASTERIZATION = 0x00080000 			; Device has HW acceleration for rasterization
Global Const $D3DDEVCAPS_PUREDEVICE = 0x00100000 				; Device supports D3DCREATE_PUREDEVICE
Global Const $D3DDEVCAPS_QUINTICRTPATCHES = 0x00200000 			; Device supports quintic Beziers and BSplines
Global Const $D3DDEVCAPS_RTPATCHES = 0x00400000 				; Device supports Rect and Tri patches
Global Const $D3DDEVCAPS_RTPATCHHANDLEZERO = 0x00800000 		; Indicates that RT Patches may be drawn efficiently using handle 0
Global Const $D3DDEVCAPS_NPATCHES = 0x01000000 					; Device supports N-Patches

; PrimitiveMiscCaps
Global Const $D3DPMISCCAPS_MASKZ						= 0x00000002
Global Const $D3DPMISCCAPS_CULLNONE						= 0x00000010
Global Const $D3DPMISCCAPS_CULLCW						= 0x00000020
Global Const $D3DPMISCCAPS_CULLCCW						= 0x00000040
Global Const $D3DPMISCCAPS_COLORWRITEENABLE				= 0x00000080
Global Const $D3DPMISCCAPS_CLIPPLANESCALEDPOINTS		= 0x00000100 ; Device correctly clips scaled points to clip planes
Global Const $D3DPMISCCAPS_CLIPTLVERTS					= 0x00000200 ; device will clip post-transformed vertex primitives
Global Const $D3DPMISCCAPS_TSSARGTEMP					= 0x00000400 ; device supports D3DTA_TEMP for temporary register
Global Const $D3DPMISCCAPS_BLENDOP						= 0x00000800 ; device supports D3DRS_BLENDOP
Global Const $D3DPMISCCAPS_NULLREFERENCE				= 0x00001000 ; Reference Device that doesnt render
Global Const $D3DPMISCCAPS_INDEPENDENTWRITEMASKS		= 0x00004000 ; Device supports independent write masks for MET or MRT
Global Const $D3DPMISCCAPS_PERSTAGECONSTANT				= 0x00008000 ; Device supports per-stage constants
Global Const $D3DPMISCCAPS_FOGANDSPECULARALPHA			= 0x00010000 ; Device supports separate fog and specular alpha (many devices use the specular alpha channel to store fog factor)
Global Const $D3DPMISCCAPS_SEPARATEALPHABLEND			= 0x00020000 ; Device supports separate blend settings for the alpha channel
Global Const $D3DPMISCCAPS_MRTINDEPENDENTBITDEPTHS		= 0x00040000 ; Device supports different bit depths for MRT
Global Const $D3DPMISCCAPS_MRTPOSTPIXELSHADERBLENDING	= 0x00080000 ; Device supports post-pixel shader operations for MRT
Global Const $D3DPMISCCAPS_FOGVERTEXCLAMPED				= 0x00100000 ; Device clamps fog blend factor per vertex
Global Const $D3DPMISCCAPS_POSTBLENDSRGBCONVERT			= 0x00200000 ; Indicates device can perform conversion to sRGB after blending.

; LineCaps
Global Const $D3DLINECAPS_TEXTURE	= 0x00000001
Global Const $D3DLINECAPS_ZTEST		= 0x00000002
Global Const $D3DLINECAPS_BLEND		= 0x00000004
Global Const $D3DLINECAPS_ALPHACMP	= 0x00000008
Global Const $D3DLINECAPS_FOG		= 0x00000010
Global Const $D3DLINECAPS_ANTIALIAS	= 0x00000020

; RasterCaps
Global Const $D3DPRASTERCAPS_DITHER					= 0x00000001
Global Const $D3DPRASTERCAPS_ZTEST					= 0x00000010
Global Const $D3DPRASTERCAPS_FOGVERTEX				= 0x00000080
Global Const $D3DPRASTERCAPS_FOGTABLE				= 0x00000100
Global Const $D3DPRASTERCAPS_MIPMAPLODBIAS			= 0x00002000
Global Const $D3DPRASTERCAPS_ZBUFFERLESSHSR			= 0x00008000
Global Const $D3DPRASTERCAPS_FOGRANGE				= 0x00010000
Global Const $D3DPRASTERCAPS_ANISOTROPY				= 0x00020000
Global Const $D3DPRASTERCAPS_WBUFFER				= 0x00040000
Global Const $D3DPRASTERCAPS_WFOG					= 0x00100000
Global Const $D3DPRASTERCAPS_ZFOG					= 0x00200000
Global Const $D3DPRASTERCAPS_COLORPERSPECTIVE		= 0x00400000 ; Device iterates colors perspective correct
Global Const $D3DPRASTERCAPS_SCISSORTEST			= 0x01000000
Global Const $D3DPRASTERCAPS_SLOPESCALEDEPTHBIAS	= 0x02000000
Global Const $D3DPRASTERCAPS_DEPTHBIAS				= 0x04000000
Global Const $D3DPRASTERCAPS_MULTISAMPLE_TOGGLE		= 0x08000000

; ZCmpCaps, AlphaCmpCaps
Global Const $D3DPCMPCAPS_NEVER			= 0x00000001
Global Const $D3DPCMPCAPS_LESS			= 0x00000002
Global Const $D3DPCMPCAPS_EQUAL			= 0x00000004
Global Const $D3DPCMPCAPS_LESSEQUAL		= 0x00000008
Global Const $D3DPCMPCAPS_GREATER		= 0x00000010
Global Const $D3DPCMPCAPS_NOTEQUAL		= 0x00000020
Global Const $D3DPCMPCAPS_GREATEREQUAL	= 0x00000040
Global Const $D3DPCMPCAPS_ALWAYS		= 0x00000080

; SourceBlendCaps, DestBlendCaps
Global Const $D3DPBLENDCAPS_ZERO			= 0x00000001
Global Const $D3DPBLENDCAPS_ONE				= 0x00000002
Global Const $D3DPBLENDCAPS_SRCCOLOR		= 0x00000004
Global Const $D3DPBLENDCAPS_INVSRCCOLOR		= 0x00000008
Global Const $D3DPBLENDCAPS_SRCALPHA		= 0x00000010
Global Const $D3DPBLENDCAPS_INVSRCALPHA		= 0x00000020
Global Const $D3DPBLENDCAPS_DESTALPHA		= 0x00000040
Global Const $D3DPBLENDCAPS_INVDESTALPHA	= 0x00000080
Global Const $D3DPBLENDCAPS_DESTCOLOR		= 0x00000100
Global Const $D3DPBLENDCAPS_INVDESTCOLOR	= 0x00000200
Global Const $D3DPBLENDCAPS_SRCALPHASAT		= 0x00000400
Global Const $D3DPBLENDCAPS_BOTHSRCALPHA	= 0x00000800
Global Const $D3DPBLENDCAPS_BOTHINVSRCALPHA	= 0x00001000
Global Const $D3DPBLENDCAPS_BLENDFACTOR		= 0x00002000 ; Supports both D3DBLEND_BLENDFACTOR and D3DBLEND_INVBLENDFACTOR
Global Const $D3DPBLENDCAPS_SRCCOLOR2		= 0x00004000
Global Const $D3DPBLENDCAPS_INVSRCCOLOR2	= 0x00008000

; ShadeCaps
Global Const $D3DPSHADECAPS_COLORGOURAUDRGB		= 0x00000008
Global Const $D3DPSHADECAPS_SPECULARGOURAUDRGB	= 0x00000200
Global Const $D3DPSHADECAPS_ALPHAGOURAUDBLEND	= 0x00004000
Global Const $D3DPSHADECAPS_FOGGOURAUD			= 0x00080000

; TextureCaps
Global Const $D3DPTEXTURECAPS_PERSPECTIVE				= 0x00000001 ; Perspective-correct texturing is supported
Global Const $D3DPTEXTURECAPS_POW2						= 0x00000002 ; Power-of-2 texture dimensions are required - applies to non-Cube/Volume textures only.
Global Const $D3DPTEXTURECAPS_ALPHA						= 0x00000004 ; Alpha in texture pixels is supported
Global Const $D3DPTEXTURECAPS_SQUAREONLY				= 0x00000020 ; Only square textures are supported
Global Const $D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE	= 0x00000040 ; Texture indices are not scaled by the texture size prior to interpolation
Global Const $D3DPTEXTURECAPS_ALPHAPALETTE				= 0x00000080 ; Device can draw alpha from texture palettes
; Device can use non-POW2 textures if:
;  1) D3DTEXTURE_ADDRESS is set to CLAMP for this texture's stage
;  2) D3DRS_WRAP(N) is zero for this texture's coordinates
;  3) mip mapping is not enabled (use magnification filter only)
Global Const $D3DPTEXTURECAPS_NONPOW2CONDITIONAL = 0x00000100
Global Const $D3DPTEXTURECAPS_PROJECTED			 = 0x00000400 ; Device can do D3DTTFF_PROJECTED
Global Const $D3DPTEXTURECAPS_CUBEMAP			 = 0x00000800 ; Device can do cubemap textures
Global Const $D3DPTEXTURECAPS_VOLUMEMAP			 = 0x00002000 ; Device can do volume textures
Global Const $D3DPTEXTURECAPS_MIPMAP			 = 0x00004000 ; Device can do mipmapped textures
Global Const $D3DPTEXTURECAPS_MIPVOLUMEMAP		 = 0x00008000 ; Device can do mipmapped volume textures
Global Const $D3DPTEXTURECAPS_MIPCUBEMAP		 = 0x00010000 ; Device can do mipmapped cube maps
Global Const $D3DPTEXTURECAPS_CUBEMAP_POW2		 = 0x00020000 ; Device requires that cubemaps be power-of-2 dimension
Global Const $D3DPTEXTURECAPS_VOLUMEMAP_POW2	 = 0x00040000 ; Device requires that volume maps be power-of-2 dimension
Global Const $D3DPTEXTURECAPS_NOPROJECTEDBUMPENV = 0x00200000 ; Device does not support projected bump env lookup operation in programmable and fixed function pixel shaders

; TextureFilterCaps, StretchRectFilterCaps
Global Const $D3DPTFILTERCAPS_MINFPOINT			 = 0x00000100 ; Min Filter
Global Const $D3DPTFILTERCAPS_MINFLINEAR		 = 0x00000200
Global Const $D3DPTFILTERCAPS_MINFANISOTROPIC	 = 0x00000400
Global Const $D3DPTFILTERCAPS_MINFPYRAMIDALQUAD	 = 0x00000800
Global Const $D3DPTFILTERCAPS_MINFGAUSSIANQUAD	 = 0x00001000
Global Const $D3DPTFILTERCAPS_MIPFPOINT			 = 0x00010000 ; Mip Filter
Global Const $D3DPTFILTERCAPS_MIPFLINEAR		 = 0x00020000
Global Const $D3DPTFILTERCAPS_CONVOLUTIONMONO	 = 0x00040000 ; Min and Mag for the convolution mono filter
Global Const $D3DPTFILTERCAPS_MAGFPOINT			 = 0x01000000 ; Mag Filter
Global Const $D3DPTFILTERCAPS_MAGFLINEAR		 = 0x02000000
Global Const $D3DPTFILTERCAPS_MAGFANISOTROPIC	 = 0x04000000
Global Const $D3DPTFILTERCAPS_MAGFPYRAMIDALQUAD	 = 0x08000000
Global Const $D3DPTFILTERCAPS_MAGFGAUSSIANQUAD	 = 0x10000000

; TextureAddressCaps
Global Const $D3DPTADDRESSCAPS_WRAP				= 0x00000001
Global Const $D3DPTADDRESSCAPS_MIRROR			= 0x00000002
Global Const $D3DPTADDRESSCAPS_CLAMP			= 0x00000004
Global Const $D3DPTADDRESSCAPS_BORDER			= 0x00000008
Global Const $D3DPTADDRESSCAPS_INDEPENDENTUV	= 0x00000010
Global Const $D3DPTADDRESSCAPS_MIRRORONCE		= 0x00000020

; StencilCaps
Global Const $D3DSTENCILCAPS_KEEP		= 0x00000001
Global Const $D3DSTENCILCAPS_ZERO		= 0x00000002
Global Const $D3DSTENCILCAPS_REPLACE	= 0x00000004
Global Const $D3DSTENCILCAPS_INCRSAT	= 0x00000008
Global Const $D3DSTENCILCAPS_DECRSAT	= 0x00000010
Global Const $D3DSTENCILCAPS_INVERT		= 0x00000020
Global Const $D3DSTENCILCAPS_INCR		= 0x00000040
Global Const $D3DSTENCILCAPS_DECR		= 0x00000080
Global Const $D3DSTENCILCAPS_TWOSIDED	= 0x00000100

; TextureOpCaps
Global Const $D3DTEXOPCAPS_DISABLE					 = 0x00000001
Global Const $D3DTEXOPCAPS_SELECTARG1				 = 0x00000002
Global Const $D3DTEXOPCAPS_SELECTARG2				 = 0x00000004
Global Const $D3DTEXOPCAPS_MODULATE					 = 0x00000008
Global Const $D3DTEXOPCAPS_MODULATE2X				 = 0x00000010
Global Const $D3DTEXOPCAPS_MODULATE4X				 = 0x00000020
Global Const $D3DTEXOPCAPS_ADD						 = 0x00000040
Global Const $D3DTEXOPCAPS_ADDSIGNED				 = 0x00000080
Global Const $D3DTEXOPCAPS_ADDSIGNED2X				 = 0x00000100
Global Const $D3DTEXOPCAPS_SUBTRACT					 = 0x00000200
Global Const $D3DTEXOPCAPS_ADDSMOOTH				 = 0x00000400
Global Const $D3DTEXOPCAPS_BLENDDIFFUSEALPHA		 = 0x00000800
Global Const $D3DTEXOPCAPS_BLENDTEXTUREALPHA		 = 0x00001000
Global Const $D3DTEXOPCAPS_BLENDFACTORALPHA			 = 0x00002000
Global Const $D3DTEXOPCAPS_BLENDTEXTUREALPHAPM		 = 0x00004000
Global Const $D3DTEXOPCAPS_BLENDCURRENTALPHA		 = 0x00008000
Global Const $D3DTEXOPCAPS_PREMODULATE				 = 0x00010000
Global Const $D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR	 = 0x00020000
Global Const $D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA	 = 0x00040000
Global Const $D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR = 0x00080000
Global Const $D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA = 0x00100000
Global Const $D3DTEXOPCAPS_BUMPENVMAP				 = 0x00200000
Global Const $D3DTEXOPCAPS_BUMPENVMAPLUMINANCE		 = 0x00400000
Global Const $D3DTEXOPCAPS_DOTPRODUCT3				 = 0x00800000
Global Const $D3DTEXOPCAPS_MULTIPLYADD				 = 0x01000000
Global Const $D3DTEXOPCAPS_LERP						 = 0x02000000

; FVFCaps
Global Const $D3DFVFCAPS_TEXCOORDCOUNTMASK	= 0x0000ffff ; mask for texture coordinate count field
Global Const $D3DFVFCAPS_DONOTSTRIPELEMENTS	= 0x00080000 ; Device prefers that vertex elements not be stripped
Global Const $D3DFVFCAPS_PSIZE				= 0x00100000 ; Device can receive point size

; VertexProcessingCaps
Global Const $D3DVTXPCAPS_TEXGEN					= 0x00000001 ; device can do texgen
Global Const $D3DVTXPCAPS_MATERIALSOURCE7			= 0x00000002 ; device can do DX7-level colormaterialsource ops
Global Const $D3DVTXPCAPS_DIRECTIONALLIGHTS			= 0x00000008 ; device can do directional lights
Global Const $D3DVTXPCAPS_POSITIONALLIGHTS			= 0x00000010 ; device can do positional lights (includes point and spot)
Global Const $D3DVTXPCAPS_LOCALVIEWER				= 0x00000020 ; device can do local viewer
Global Const $D3DVTXPCAPS_TWEENING					= 0x00000040 ; device can do vertex tweening
Global Const $D3DVTXPCAPS_TEXGEN_SPHEREMAP			= 0x00000100 ; device supports D3DTSS_TCI_SPHEREMAP
Global Const $D3DVTXPCAPS_NO_TEXGEN_NONLOCALVIEWER	= 0x00000200 ; device does not support TexGen in non-local viewer mode

; DevCaps2
Global Const $D3DDEVCAPS2_STREAMOFFSET						 = 0x00000001 ; Device supports offsets in streams. Must be set by DX9 drivers
Global Const $D3DDEVCAPS2_DMAPNPATCH						 = 0x00000002 ; Device supports displacement maps for N-Patches
Global Const $D3DDEVCAPS2_ADAPTIVETESSRTPATCH				 = 0x00000004 ; Device supports adaptive tesselation of RT-patches
Global Const $D3DDEVCAPS2_ADAPTIVETESSNPATCH				 = 0x00000008 ; Device supports adaptive tesselation of N-patches
Global Const $D3DDEVCAPS2_CAN_STRETCHRECT_FROM_TEXTURES		 = 0x00000010 ; Device supports StretchRect calls with a texture as the source
Global Const $D3DDEVCAPS2_PRESAMPLEDDMAPNPATCH				 = 0x00000020 ; Device supports presampled displacement maps for N-Patches
Global Const $D3DDEVCAPS2_VERTEXELEMENTSCANSHARESTREAMOFFSET = 0x00000040 ; Vertex elements in a vertex declaration can share the same stream offset

; DeclTypes
Global Const $D3DDTCAPS_UBYTE4	  = 0x00000001
Global Const $D3DDTCAPS_UBYTE4N	  = 0x00000002
Global Const $D3DDTCAPS_SHORT2N	  = 0x00000004
Global Const $D3DDTCAPS_SHORT4N	  = 0x00000008
Global Const $D3DDTCAPS_USHORT2N  = 0x00000010
Global Const $D3DDTCAPS_USHORT4N  = 0x00000020
Global Const $D3DDTCAPS_UDEC3 	  = 0x00000040
Global Const $D3DDTCAPS_DEC3N	  = 0x00000080
Global Const $D3DDTCAPS_FLOAT16_2 = 0x00000100
Global Const $D3DDTCAPS_FLOAT16_4 = 0x00000200

; CreateDevice behavior flags
Global Const $D3DCREATE_FPU_PRESERVE = 0x00000002
Global Const $D3DCREATE_MULTITHREADED = 0x00000004
Global Const $D3DCREATE_PUREDEVICE = 0x00000010
Global Const $D3DCREATE_SOFTWARE_VERTEXPROCESSING = 0x00000020
Global Const $D3DCREATE_HARDWARE_VERTEXPROCESSING = 0x00000040
Global Const $D3DCREATE_MIXED_VERTEXPROCESSING = 0x00000080
Global Const $D3DCREATE_DISABLE_DRIVER_MANAGEMENT = 0x00000100
Global Const $D3DCREATE_ADAPTERGROUP_DEVICE = 0x00000200
Global Const $D3DCREATE_DISABLE_DRIVER_MANAGEMENT_EX = 0x00000400
Global Const $D3DCREATE_NOWINDOWCHANGES = 0x00000800
Global Const $D3DCREATE_DISABLE_PSGP_THREADING = 0x00002000 	; Disable multithreading for software vertex processing
Global Const $D3DCREATE_ENABLE_PRESENTSTATS = 0x00004000 		; This flag enables present statistics on device.
Global Const $D3DCREATE_DISABLE_PRINTSCREEN = 0x00008000 		; This flag disables printscreen support in the runtime for this device
Global Const $D3DCREATE_SCREENSAVER = 0x10000000

; Device.Clear flags
Global Const $D3DCLEAR_TARGET = 0x00000001	; Clear target surface
Global Const $D3DCLEAR_ZBUFFER = 0x00000002	; Clear target z buffer
Global Const $D3DCLEAR_STENCIL = 0x00000004	; Clear stencil planes

; Presentation intervals
Global Const $D3DPRESENT_INTERVAL_DEFAULT = 0
Global Const $D3DPRESENT_INTERVAL_ONE = 1
Global Const $D3DPRESENT_INTERVAL_TWO = 2
Global Const $D3DPRESENT_INTERVAL_THREE = 4
Global Const $D3DPRESENT_INTERVAL_FOUR = 8
Global Const $D3DPRESENT_INTERVAL_IMMEDIATE = 0x80000000

; Refresh rate (predefined)
Global Const $D3DPRESENT_RATE_DEFAULT = 0

; Device adapter (predefined)
Global Const $D3DADAPTER_DEFAULT = 0

; Buffer swap effects
Global Const $D3DSWAPEFFECT_DISCARD = 1
Global Const $D3DSWAPEFFECT_FLIP = 2
Global Const $D3DSWAPEFFECT_COPY = 3
Global Const $D3DSWAPEFFECT_OVERLAY = 4
Global Const $D3DSWAPEFFECT_FLIPEX = 5
Global Const $D3DSWAPEFFECT_FORCE_DWORD = 0x7fffffff

; Device types
Global Const $D3DDEVTYPE_HAL = 1
Global Const $D3DDEVTYPE_REF = 2
Global Const $D3DDEVTYPE_SW = 3
Global Const $D3DDEVTYPE_NULLREF = 4
Global Const $D3DDEVTYPE_FORCE_DWORD = 0x7fffffff

; Multi-Sample buffer types
Global Const $D3DMULTISAMPLE_NONE            =  0
Global Const $D3DMULTISAMPLE_NONMASKABLE     =  1
Global Const $D3DMULTISAMPLE_2_SAMPLES       =  2
Global Const $D3DMULTISAMPLE_3_SAMPLES       =  3
Global Const $D3DMULTISAMPLE_4_SAMPLES       =  4
Global Const $D3DMULTISAMPLE_5_SAMPLES       =  5
Global Const $D3DMULTISAMPLE_6_SAMPLES       =  6
Global Const $D3DMULTISAMPLE_7_SAMPLES       =  7
Global Const $D3DMULTISAMPLE_8_SAMPLES       =  8
Global Const $D3DMULTISAMPLE_9_SAMPLES       =  9
Global Const $D3DMULTISAMPLE_10_SAMPLES      = 10
Global Const $D3DMULTISAMPLE_11_SAMPLES      = 11
Global Const $D3DMULTISAMPLE_12_SAMPLES      = 12
Global Const $D3DMULTISAMPLE_13_SAMPLES      = 13
Global Const $D3DMULTISAMPLE_14_SAMPLES      = 14
Global Const $D3DMULTISAMPLE_15_SAMPLES      = 15
Global Const $D3DMULTISAMPLE_16_SAMPLES      = 16
Global Const $D3DMULTISAMPLE_FORCE_DWORD     = 0x7fffffff

; Usages for Vertex/Index buffers
Global Const $D3DUSAGE_WRITEONLY			= 0x00000008
Global Const $D3DUSAGE_SOFTWAREPROCESSING	= 0x00000010
Global Const $D3DUSAGE_DONOTCLIP          	= 0x00000020
Global Const $D3DUSAGE_POINTS             	= 0x00000040
Global Const $D3DUSAGE_RTPATCHES          	= 0x00000080
Global Const $D3DUSAGE_NPATCHES           	= 0x00000100

; Pool types
Global Const $D3DPOOL_DEFAULT		= 0
Global Const $D3DPOOL_MANAGED		= 1
Global Const $D3DPOOL_SYSTEMMEM		= 2
Global Const $D3DPOOL_SCRATCH		= 3
Global Const $D3DPOOL_FORCE_DWORD	= 0x7fffffff

; Color, depth, etc.. formats
Global Const $D3DFMT_UNKNOWN =  0
Global Const $D3DFMT_R8G8B8 = 20
Global Const $D3DFMT_A8R8G8B8 = 21
Global Const $D3DFMT_X8R8G8B8 = 22
Global Const $D3DFMT_R5G6B5 = 23
Global Const $D3DFMT_X1R5G5B5 = 24
Global Const $D3DFMT_A1R5G5B5 = 25
Global Const $D3DFMT_A4R4G4B4 = 26
Global Const $D3DFMT_R3G3B2 = 27
Global Const $D3DFMT_A8 = 28
Global Const $D3DFMT_A8R3G3B2 = 29
Global Const $D3DFMT_X4R4G4B4 = 30
Global Const $D3DFMT_A2B10G10R10 = 31
Global Const $D3DFMT_A8B8G8R8 = 32
Global Const $D3DFMT_X8B8G8R8 = 33
Global Const $D3DFMT_G16R16 = 34
Global Const $D3DFMT_A2R10G10B10 = 35
Global Const $D3DFMT_A16B16G16R16 = 36
Global Const $D3DFMT_A8P8 = 40
Global Const $D3DFMT_P8 = 41
Global Const $D3DFMT_L8 = 50
Global Const $D3DFMT_A8L8 = 51
Global Const $D3DFMT_A4L4 = 52
Global Const $D3DFMT_V8U8 = 60
Global Const $D3DFMT_L6V5U5 = 61
Global Const $D3DFMT_X8L8V8U8 = 62
Global Const $D3DFMT_Q8W8V8U8 = 63
Global Const $D3DFMT_V16U16 = 64
Global Const $D3DFMT_A2W10V10U10 = 67
Global Const $D3DFMT_UYVY = _MAKEFOURCC('U', 'Y', 'V', 'Y')
Global Const $D3DFMT_R8G8_B8G8 = _MAKEFOURCC('R', 'G', 'B', 'G')
Global Const $D3DFMT_YUY2 = _MAKEFOURCC('Y', 'U', 'Y', '2')
Global Const $D3DFMT_G8R8_G8B8 = _MAKEFOURCC('G', 'R', 'G', 'B')
Global Const $D3DFMT_DXT1 = _MAKEFOURCC('D', 'X', 'T', '1')
Global Const $D3DFMT_DXT2 = _MAKEFOURCC('D', 'X', 'T', '2')
Global Const $D3DFMT_DXT3 = _MAKEFOURCC('D', 'X', 'T', '3')
Global Const $D3DFMT_DXT4 = _MAKEFOURCC('D', 'X', 'T', '4')
Global Const $D3DFMT_DXT5 = _MAKEFOURCC('D', 'X', 'T', '5')
Global Const $D3DFMT_D16_LOCKABLE = 70
Global Const $D3DFMT_D32 = 71
Global Const $D3DFMT_D15S1 = 73
Global Const $D3DFMT_D24S8 = 75
Global Const $D3DFMT_D24X8 = 77
Global Const $D3DFMT_D24X4S4 = 79
Global Const $D3DFMT_D16 = 80
Global Const $D3DFMT_L16 = 81
Global Const $D3DFMT_D32F_LOCKABLE = 82
Global Const $D3DFMT_D24FS8 = 83
Global Const $D3DFMT_D32_LOCKABLE = 84
Global Const $D3DFMT_S8_LOCKABLE = 85
Global Const $D3DFMT_VERTEXDATA =100
Global Const $D3DFMT_INDEX16 =101
Global Const $D3DFMT_INDEX32 =102
Global Const $D3DFMT_Q16W16V16U16 =110
Global Const $D3DFMT_MULTI2_ARGB8 = _MAKEFOURCC('M','E','T','1')
Global Const $D3DFMT_R16F = 111
Global Const $D3DFMT_G16R16F = 112
Global Const $D3DFMT_A16B16G16R16F = 113
Global Const $D3DFMT_R32F = 114
Global Const $D3DFMT_G32R32F = 115
Global Const $D3DFMT_A32B32G32R32F = 116
Global Const $D3DFMT_CxV8U8 = 117
Global Const $D3DFMT_A1 = 118
Global Const $D3DFMT_A2B10G10R10_XR_BIAS = 119
Global Const $D3DFMT_BINARYBUFFER = 199
Global Const $D3DFMT_FORCE_DWORD = 0x7fffffff

; Flexible Vertex Formats
Global Const $D3DFVF_RESERVED0 = 0x001
Global Const $D3DFVF_POSITION_MASK = 0x400E
Global Const $D3DFVF_XYZ = 0x002
Global Const $D3DFVF_XYZRHW = 0x004
Global Const $D3DFVF_XYZB1 = 0x006
Global Const $D3DFVF_XYZB2 = 0x008
Global Const $D3DFVF_XYZB3 = 0x00a
Global Const $D3DFVF_XYZB4 = 0x00c
Global Const $D3DFVF_XYZB5 = 0x00e
Global Const $D3DFVF_XYZW = 0x4002
Global Const $D3DFVF_NORMAL = 0x010
Global Const $D3DFVF_PSIZE = 0x020
Global Const $D3DFVF_DIFFUSE = 0x040
Global Const $D3DFVF_SPECULAR = 0x080
Global Const $D3DFVF_TEXCOUNT_MASK = 0xf00
Global Const $D3DFVF_TEXCOUNT_SHIFT = 8
Global Const $D3DFVF_TEX0 = 0x000
Global Const $D3DFVF_TEX1 = 0x100
Global Const $D3DFVF_TEX2 = 0x200
Global Const $D3DFVF_TEX3 = 0x300
Global Const $D3DFVF_TEX4 = 0x400
Global Const $D3DFVF_TEX5 = 0x500
Global Const $D3DFVF_TEX6 = 0x600
Global Const $D3DFVF_TEX7 = 0x700
Global Const $D3DFVF_TEX8 = 0x800
Global Const $D3DFVF_LASTBETA_UBYTE4 = 0x1000
Global Const $D3DFVF_LASTBETA_D3DCOLOR = 0x8000
Global Const $D3DFVF_RESERVED2 = 0x6000

; A bunch of rendering states (used by SetRenderState)
Global Const $D3DRS_ZENABLE = 7    ; D3DZBUFFERTYPE (or TRUE/FALSE for legacy)
Global Const $D3DRS_FILLMODE = 8    ; D3DFILLMODE
Global Const $D3DRS_SHADEMODE = 9    ; D3DSHADEMODE
Global Const $D3DRS_ZWRITEENABLE = 14   ; TRUE to enable z writes
Global Const $D3DRS_ALPHATESTENABLE = 15   ; TRUE to enable alpha tests
Global Const $D3DRS_LASTPIXEL = 16   ; TRUE for last-pixel on lines
Global Const $D3DRS_SRCBLEND = 19   ; D3DBLEND
Global Const $D3DRS_DESTBLEND = 20   ; D3DBLEND
Global Const $D3DRS_CULLMODE = 22   ; D3DCULL
Global Const $D3DRS_ZFUNC = 23  ; D3DCMPFUNC
Global Const $D3DRS_ALPHAREF = 24   ; D3DFIXED
Global Const $D3DRS_ALPHAFUNC = 25   ; D3DCMPFUNC
Global Const $D3DRS_DITHERENABLE = 26   ; TRUE to enable dithering
Global Const $D3DRS_ALPHABLENDENABLE = 27   ; TRUE to enable alpha blending
Global Const $D3DRS_FOGENABLE = 28   ; TRUE to enable fog blending
Global Const $D3DRS_SPECULARENABLE = 29   ; TRUE to enable specular
Global Const $D3DRS_FOGCOLOR = 34   ; D3DCOLOR
Global Const $D3DRS_FOGTABLEMODE = 35   ; D3DFOGMODE
Global Const $D3DRS_FOGSTART = 36   ; Fog start (for both vertex and pixel fog)
Global Const $D3DRS_FOGEND = 37   ; Fog end
Global Const $D3DRS_FOGDENSITY = 38   ; Fog density
Global Const $D3DRS_RANGEFOGENABLE = 48   ; Enables range-based fog
Global Const $D3DRS_STENCILENABLE = 52   ; BOOL enable/disable stenciling
Global Const $D3DRS_STENCILFAIL = 53   ; D3DSTENCILOP to do if stencil test fails
Global Const $D3DRS_STENCILZFAIL = 54   ; D3DSTENCILOP to do if stencil test passes and Z test fails
Global Const $D3DRS_STENCILPASS = 55   ; D3DSTENCILOP to do if both stencil and Z tests pass
Global Const $D3DRS_STENCILFUNC = 56   ; D3DCMPFUNC fn.  Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true
Global Const $D3DRS_STENCILREF = 57   ; Reference value used in stencil test
Global Const $D3DRS_STENCILMASK = 58   ; Mask value used in stencil test
Global Const $D3DRS_STENCILWRITEMASK = 59   ; Write mask applied to values written to stencil buffer
Global Const $D3DRS_TEXTUREFACTOR = 60   ; D3DCOLOR used for multi-texture blend
Global Const $D3DRS_WRAP0 = 128  ; wrap for 1st texture coord. set
Global Const $D3DRS_WRAP1 = 129  ; wrap for 2nd texture coord. set
Global Const $D3DRS_WRAP2 = 130  ; wrap for 3rd texture coord. set
Global Const $D3DRS_WRAP3 = 131  ; wrap for 4th texture coord. set
Global Const $D3DRS_WRAP4 = 132  ; wrap for 5th texture coord. set
Global Const $D3DRS_WRAP5 = 133  ; wrap for 6th texture coord. set
Global Const $D3DRS_WRAP6 = 134  ; wrap for 7th texture coord. set
Global Const $D3DRS_WRAP7 = 135  ; wrap for 8th texture coord. set
Global Const $D3DRS_CLIPPING = 136
Global Const $D3DRS_LIGHTING = 137
Global Const $D3DRS_AMBIENT = 139
Global Const $D3DRS_FOGVERTEXMODE = 140
Global Const $D3DRS_COLORVERTEX = 141
Global Const $D3DRS_LOCALVIEWER = 142
Global Const $D3DRS_NORMALIZENORMALS = 143
Global Const $D3DRS_DIFFUSEMATERIALSOURCE = 145
Global Const $D3DRS_SPECULARMATERIALSOURCE = 146
Global Const $D3DRS_AMBIENTMATERIALSOURCE = 147
Global Const $D3DRS_EMISSIVEMATERIALSOURCE = 148
Global Const $D3DRS_VERTEXBLEND = 151
Global Const $D3DRS_CLIPPLANEENABLE = 152
Global Const $D3DRS_POINTSIZE = 154   ; float point size
Global Const $D3DRS_POINTSIZE_MIN = 155   ; float point size min threshold
Global Const $D3DRS_POINTSPRITEENABLE = 156   ; BOOL point texture coord control
Global Const $D3DRS_POINTSCALEENABLE = 157   ; BOOL point size scale enable
Global Const $D3DRS_POINTSCALE_A = 158   ; float point attenuation A value
Global Const $D3DRS_POINTSCALE_B = 159   ; float point attenuation B value
Global Const $D3DRS_POINTSCALE_C = 160   ; float point attenuation C value
Global Const $D3DRS_MULTISAMPLEANTIALIAS = 161  ; BOOL - set to do FSAA with multisample buffer
Global Const $D3DRS_MULTISAMPLEMASK = 162  ; DWORD - per-sample enable/disable
Global Const $D3DRS_PATCHEDGESTYLE = 163  ; Sets whether patch edges will use float style tessellation
Global Const $D3DRS_DEBUGMONITORTOKEN = 165  ; DEBUG ONLY - token to debug monitor
Global Const $D3DRS_POINTSIZE_MAX = 166   ; float point size max threshold
Global Const $D3DRS_INDEXEDVERTEXBLENDENABLE = 167
Global Const $D3DRS_COLORWRITEENABLE = 168  ; per-channel write enable
Global Const $D3DRS_TWEENFACTOR = 170   ; float tween factor
Global Const $D3DRS_BLENDOP = 171   ; D3DBLENDOP setting
Global Const $D3DRS_POSITIONDEGREE = 172   ; NPatch position interpolation degree. D3DDEGREE_LINEAR or D3DDEGREE_CUBIC (default)
Global Const $D3DRS_NORMALDEGREE = 173   ; NPatch normal interpolation degree. D3DDEGREE_LINEAR (default) or D3DDEGREE_QUADRATIC
Global Const $D3DRS_SCISSORTESTENABLE = 174
Global Const $D3DRS_SLOPESCALEDEPTHBIAS = 175
Global Const $D3DRS_ANTIALIASEDLINEENABLE = 176
Global Const $D3DRS_MINTESSELLATIONLEVEL = 178
Global Const $D3DRS_MAXTESSELLATIONLEVEL = 179
Global Const $D3DRS_ADAPTIVETESS_X = 180
Global Const $D3DRS_ADAPTIVETESS_Y = 181
Global Const $D3DRS_ADAPTIVETESS_Z = 182
Global Const $D3DRS_ADAPTIVETESS_W = 183
Global Const $D3DRS_ENABLEADAPTIVETESSELLATION = 184
Global Const $D3DRS_TWOSIDEDSTENCILMODE = 185   ; BOOL enable/disable 2 sided stenciling
Global Const $D3DRS_CCW_STENCILFAIL = 186   ; D3DSTENCILOP to do if ccw stencil test fails
Global Const $D3DRS_CCW_STENCILZFAIL = 187   ; D3DSTENCILOP to do if ccw stencil test passes and Z test fails
Global Const $D3DRS_CCW_STENCILPASS = 188   ; D3DSTENCILOP to do if both ccw stencil and Z tests pass
Global Const $D3DRS_CCW_STENCILFUNC = 189   ; D3DCMPFUNC fn.  ccw Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true
Global Const $D3DRS_COLORWRITEENABLE1 = 190   ; Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS
Global Const $D3DRS_COLORWRITEENABLE2 = 191   ; Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS
Global Const $D3DRS_COLORWRITEENABLE3 = 192   ; Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS
Global Const $D3DRS_BLENDFACTOR = 193   ; D3DCOLOR used for a constant blend factor during alpha blending for devices that support D3DPBLENDCAPS_BLENDFACTOR
Global Const $D3DRS_SRGBWRITEENABLE = 194   ; Enable rendertarget writes to be DE-linearized to SRGB (for formats that expose D3DUSAGE_QUERY_SRGBWRITE)
Global Const $D3DRS_DEPTHBIAS = 195
Global Const $D3DRS_WRAP8 = 198   ; Additional wrap states for vs_3_0+ attributes with D3DDECLUSAGE_TEXCOORD
Global Const $D3DRS_WRAP9 = 199
Global Const $D3DRS_WRAP10 = 200
Global Const $D3DRS_WRAP11 = 201
Global Const $D3DRS_WRAP12 = 202
Global Const $D3DRS_WRAP13 = 203
Global Const $D3DRS_WRAP14 = 204
Global Const $D3DRS_WRAP15 = 205
Global Const $D3DRS_SEPARATEALPHABLENDENABLE = 206  ; TRUE to enable a separate blending function for the alpha channel
Global Const $D3DRS_SRCBLENDALPHA = 207  ; SRC blend factor for the alpha channel when Global Const $D3DRS_SEPARATEDESTALPHAENABLE is TRUE
Global Const $D3DRS_DESTBLENDALPHA = 208  ; DST blend factor for the alpha channel when Global Const $D3DRS_SEPARATEDESTALPHAENABLE is TRUE
Global Const $D3DRS_BLENDOPALPHA = 209  ; Blending operation for the alpha channel when Global Const $D3DRS_SEPARATEDESTALPHAENABLE is TRUE
Global Const $D3DRS_FORCE_DWORD               = 0x7fffffff

; The following defines the rendering states
Global Const $D3DSHADE_FLAT				= 1
Global Const $D3DSHADE_GOURAUD			= 2
Global Const $D3DSHADE_PHONG			= 3
Global Const $D3DSHADE_FORCE_DWORD		= 0x7fffffff

Global Const $D3DFILL_POINT				= 1
Global Const $D3DFILL_WIREFRAME			= 2
Global Const $D3DFILL_SOLID				= 3
Global Const $D3DFILL_FORCE_DWORD		= 0x7fffffff

Global Const $D3DBLEND_ZERO				= 1
Global Const $D3DBLEND_ONE				= 2
Global Const $D3DBLEND_SRCCOLOR			= 3
Global Const $D3DBLEND_INVSRCCOLOR		= 4
Global Const $D3DBLEND_SRCALPHA			= 5
Global Const $D3DBLEND_INVSRCALPHA		= 6
Global Const $D3DBLEND_DESTALPHA		= 7
Global Const $D3DBLEND_INVDESTALPHA		= 8
Global Const $D3DBLEND_DESTCOLOR		= 9
Global Const $D3DBLEND_INVDESTCOLOR		= 10
Global Const $D3DBLEND_SRCALPHASAT		= 11
Global Const $D3DBLEND_BOTHSRCALPHA		= 12
Global Const $D3DBLEND_BOTHINVSRCALPHA	= 13
Global Const $D3DBLEND_BLENDFACTOR		= 14 ; Only supported if D3DPBLENDCAPS_BLENDFACTOR is on
Global Const $D3DBLEND_INVBLENDFACTOR	= 15 ; Only supported if D3DPBLENDCAPS_BLENDFACTOR is on
Global Const $D3DBLEND_SRCCOLOR2		= 16
Global Const $D3DBLEND_INVSRCCOLOR2		= 17
Global Const $D3DBLEND_FORCE_DWORD		= 0x7fffffff

Global Const $D3DBLENDOP_ADD			= 1
Global Const $D3DBLENDOP_SUBTRACT		= 2
Global Const $D3DBLENDOP_REVSUBTRACT	= 3
Global Const $D3DBLENDOP_MIN			= 4
Global Const $D3DBLENDOP_MAX			= 5
Global Const $D3DBLENDOP_FORCE_DWORD	= 0x7fffffff

Global Const $D3DTADDRESS_WRAP			= 1
Global Const $D3DTADDRESS_MIRROR		= 2
Global Const $D3DTADDRESS_CLAMP			= 3
Global Const $D3DTADDRESS_BORDER		= 4
Global Const $D3DTADDRESS_MIRRORONCE	= 5
Global Const $D3DTADDRESS_FORCE_DWORD	= 0x7fffffff

Global Const $D3DCULL_NONE			= 1
Global Const $D3DCULL_CW			= 2
Global Const $D3DCULL_CCW			= 3
Global Const $D3DCULL_FORCE_DWORD	= 0x7fffffff

Global Const $D3DCMP_NEVER			= 1
Global Const $D3DCMP_LESS			= 2
Global Const $D3DCMP_EQUAL			= 3
Global Const $D3DCMP_LESSEQUAL		= 4
Global Const $D3DCMP_GREATER		= 5
Global Const $D3DCMP_NOTEQUAL		= 6
Global Const $D3DCMP_GREATEREQUAL	= 7
Global Const $D3DCMP_ALWAYS			= 8
Global Const $D3DCMP_FORCE_DWORD	= 0x7fffffff

Global Const $D3DSTENCILOP_KEEP           = 1
Global Const $D3DSTENCILOP_ZERO           = 2
Global Const $D3DSTENCILOP_REPLACE        = 3
Global Const $D3DSTENCILOP_INCRSAT        = 4
Global Const $D3DSTENCILOP_DECRSAT        = 5
Global Const $D3DSTENCILOP_INVERT         = 6
Global Const $D3DSTENCILOP_INCR           = 7
Global Const $D3DSTENCILOP_DECR           = 8
Global Const $D3DSTENCILOP_FORCE_DWORD    = 0x7fffffff

Global Const $D3DFOG_NONE			= 0
Global Const $D3DFOG_EXP			= 1
Global Const $D3DFOG_EXP2			= 2
Global Const $D3DFOG_LINEAR			= 3
Global Const $D3DFOG_FORCE_DWORD	= 0x7fffffff

Global Const $D3DZB_FALSE			= 0
Global Const $D3DZB_TRUE			= 1 ; Z buffering
Global Const $D3DZB_USEW			= 2 ; W buffering
Global Const $D3DZB_FORCE_DWORD		= 0x7fffffff

; Primitives supported by draw-primitive API
Global Const $D3DPT_POINTLIST		= 1
Global Const $D3DPT_LINELIST		= 2
Global Const $D3DPT_LINESTRIP		= 3
Global Const $D3DPT_TRIANGLELIST	= 4
Global Const $D3DPT_TRIANGLESTRIP	= 5
Global Const $D3DPT_TRIANGLEFAN		= 6
Global Const $D3DPT_FORCE_DWORD		= 0x7fffffff

; Transform states
Global Const $D3DTS_VIEW          = 2
Global Const $D3DTS_PROJECTION    = 3
Global Const $D3DTS_TEXTURE0      = 16
Global Const $D3DTS_TEXTURE1      = 17
Global Const $D3DTS_TEXTURE2      = 18
Global Const $D3DTS_TEXTURE3      = 19
Global Const $D3DTS_TEXTURE4      = 20
Global Const $D3DTS_TEXTURE5      = 21
Global Const $D3DTS_TEXTURE6      = 22
Global Const $D3DTS_TEXTURE7      = 23
Global Const $D3DTS_WORLD  		  = 256
Global Const $D3DTS_WORLD1  	  = 257
Global Const $D3DTS_WORLD2		  = 258
Global Const $D3DTS_WORLD3		  = 259
Global Const $D3DTS_FORCE_DWORD   = 0x7fffffff

; Sampler states (used by SetSamplerState)
Global Const $D3DSAMP_ADDRESSU = 1  ; D3DTEXTUREADDRESS for U coordinate
Global Const $D3DSAMP_ADDRESSV = 2  ; D3DTEXTUREADDRESS for V coordinate
Global Const $D3DSAMP_ADDRESSW = 3  ; D3DTEXTUREADDRESS for W coordinate
Global Const $D3DSAMP_BORDERCOLOR = 4  ; D3DCOLOR
Global Const $D3DSAMP_MAGFILTER = 5  ; D3DTEXTUREFILTER filter to use for magnification
Global Const $D3DSAMP_MINFILTER = 6  ; D3DTEXTUREFILTER filter to use for minification
Global Const $D3DSAMP_MIPFILTER = 7  ; D3DTEXTUREFILTER filter to use between mipmaps during minification
Global Const $D3DSAMP_MIPMAPLODBIAS = 8  ; float Mipmap LOD bias
Global Const $D3DSAMP_MAXMIPLEVEL = 9  ; DWORD 0..(n-1) LOD index of largest map to use (0 == largest)
Global Const $D3DSAMP_MAXANISOTROPY = 10 ; DWORD maximum anisotropy
Global Const $D3DSAMP_SRGBTEXTURE = 11 ; Default = 0 (which means Gamma 1.0, no correction required.) else correct for Gamma = 2.2
Global Const $D3DSAMP_ELEMENTINDEX = 12 ; When multi-element texture is assigned to sampler, this indicates which element index to use.  Default = 0.
Global Const $D3DSAMP_DMAPOFFSET = 13 ; Offset in vertices in the pre-sampled displacement map. Only valid for D3DDMAPSAMPLER sampler
Global Const $D3DSAMP_FORCE_DWORD = 0x7fffffff

; Texture stage states (used by SetTextureStageState)
Global Const $D3DTSS_COLOROP        =  1 ; D3DTEXTUREOP - per-stage blending controls for color channels
Global Const $D3DTSS_COLORARG1      =  2 ; D3DTA_* (texture arg)
Global Const $D3DTSS_COLORARG2      =  3 ; D3DTA_* (texture arg)
Global Const $D3DTSS_ALPHAOP        =  4 ; D3DTEXTUREOP - per-stage blending controls for alpha channel
Global Const $D3DTSS_ALPHAARG1      =  5 ; D3DTA_* (texture arg)
Global Const $D3DTSS_ALPHAARG2      =  6 ; D3DTA_* (texture arg)
Global Const $D3DTSS_BUMPENVMAT00   =  7 ; float (bump mapping matrix)
Global Const $D3DTSS_BUMPENVMAT01   =  8 ; float (bump mapping matrix)
Global Const $D3DTSS_BUMPENVMAT10   =  9 ; float (bump mapping matrix)
Global Const $D3DTSS_BUMPENVMAT11   = 10 ; float (bump mapping matrix)
Global Const $D3DTSS_TEXCOORDINDEX  = 11 ; identifies which set of texture coordinates index this texture
Global Const $D3DTSS_BUMPENVLSCALE  = 22 ; float scale for bump map luminance
Global Const $D3DTSS_BUMPENVLOFFSET = 23 ; float offset for bump map luminance
Global Const $D3DTSS_TEXTURETRANSFORMFLAGS = 24 ; D3DTEXTURETRANSFORMFLAGS controls texture transform
Global Const $D3DTSS_COLORARG0      = 26 ; D3DTA_* third arg for triadic ops
Global Const $D3DTSS_ALPHAARG0      = 27 ; D3DTA_* third arg for triadic ops
Global Const $D3DTSS_RESULTARG      = 28 ; D3DTA_* arg for result (CURRENT or TEMP)
Global Const $D3DTSS_CONSTANT       = 32 ; Per-stage constant D3DTA_CONSTANT
Global Const $D3DTSS_FORCE_DWORD    = 0x7fffffff ; force 32-bit size enum

; texture blending operations set in texture processing stage
Global Const $D3DTA_SELECTMASK		= 0x0000000f  ; mask for arg selector
Global Const $D3DTA_DIFFUSE			= 0x00000000  ; select diffuse color (read only)
Global Const $D3DTA_CURRENT			= 0x00000001  ; select stage destination register (read/write)
Global Const $D3DTA_TEXTURE			= 0x00000002  ; select texture color (read only)
Global Const $D3DTA_TFACTOR			= 0x00000003  ; select D3DRS_TEXTUREFACTOR (read only)
Global Const $D3DTA_SPECULAR		= 0x00000004  ; select specular color (read only)
Global Const $D3DTA_TEMP			= 0x00000005  ; select temporary register color (read/write)
Global Const $D3DTA_CONSTANT		= 0x00000006  ; select texture stage constant
Global Const $D3DTA_COMPLEMENT		= 0x00000010  ; take 1.0 - x (read modifier)
Global Const $D3DTA_ALPHAREPLICATE	= 0x00000020  ; replicate alpha to color components (read modifier)

; texture blending operations set in texture processing stage
Global Const $D3DTOP_DISABLE              	   = 1  ; disables stage
Global Const $D3DTOP_SELECTARG1           	   = 2  ; the default
Global Const $D3DTOP_SELECTARG2           	   = 3
Global Const $D3DTOP_MODULATE             	   = 4  ; multiply args together
Global Const $D3DTOP_MODULATE2X           	   = 5  ; multiply and  1 bit
Global Const $D3DTOP_MODULATE4X           	   = 6  ; multiply and  2 bits
Global Const $D3DTOP_ADD                  	   =  7 ;  add arguments together
Global Const $D3DTOP_ADDSIGNED            	   =  8 ;  add with -0.5 bias
Global Const $D3DTOP_ADDSIGNED2X          	   =  9 ;  as above but left  1 bit
Global Const $D3DTOP_SUBTRACT             	   = 10 ;  Arg1 - Arg2, with no saturation
Global Const $D3DTOP_ADDSMOOTH           	   = 11 ;  add 2 args, subtract product.  Arg1 + Arg2 - Arg1*Arg2  = Arg1 + (1-Arg1)*Arg2
; Linear alpha blend: Arg1*(Alpha) + Arg2*(1-Alpha)
Global Const $D3DTOP_BLENDDIFFUSEALPHA    	   = 12 ; iterated alpha
Global Const $D3DTOP_BLENDTEXTUREALPHA   	   = 13 ; texture alpha
Global Const $D3DTOP_BLENDFACTORALPHA     	   = 14 ; alpha from D3DRS_TEXTUREFACTOR
; Linear alpha blend with pre-multiplied arg1 input: Arg1 + Arg2*(1-Alpha)
Global Const $D3DTOP_BLENDTEXTUREALPHAPM  	   = 15 ; texture alpha
Global Const $D3DTOP_BLENDCURRENTALPHA    	   = 16 ; by alpha of current color
Global Const $D3DTOP_PREMODULATE               = 17 ; modulate with next texture before use
Global Const $D3DTOP_MODULATEALPHA_ADDCOLOR    = 18 ; Arg1.RGB + Arg1.A*Arg2.RGB
Global Const $D3DTOP_MODULATECOLOR_ADDALPHA    = 19 ; Arg1.RGB*Arg2.RGB + Arg1.A
Global Const $D3DTOP_MODULATEINVALPHA_ADDCOLOR = 20 ; (1-Arg1.A)*Arg2.RGB + Arg1.RGB
Global Const $D3DTOP_MODULATEINVCOLOR_ADDALPHA = 21 ; (1-Arg1.RGB)*Arg2.RGB + Arg1.A
Global Const $D3DTOP_BUMPENVMAP          	   = 22 ; per pixel env map perturbation
Global Const $D3DTOP_BUMPENVMAPLUMINANCE  	   = 23 ; with luminance channel
Global Const $D3DTOP_DOTPRODUCT3          	   = 24
Global Const $D3DTOP_MULTIPLYADD          	   = 25 ; Arg0 + Arg1*Arg2
Global Const $D3DTOP_LERP                 	   = 26 ; (Arg0)*Arg1 + (1-Arg0)*Arg2
Global Const $D3DTOP_FORCE_DWORD 		  	   = 0x7fffffff

; Values for D3DSAMP_***FILTER texture stage states
Global Const $D3DTEXF_NONE            = 0	; filtering disabled (valid for mip filter only)
Global Const $D3DTEXF_POINT           = 1	; nearest
Global Const $D3DTEXF_LINEAR          = 2	; linear interpolation
Global Const $D3DTEXF_ANISOTROPIC     = 3	; anisotropic
Global Const $D3DTEXF_PYRAMIDALQUAD   = 6	; 4-sample tent
Global Const $D3DTEXF_GAUSSIANQUAD    = 7	; 4-sample gaussian

; Light types
Global Const $D3DLIGHT_POINT = 1
Global Const $D3DLIGHT_SPOT = 2
Global Const $D3DLIGHT_DIRECTIONAL = 3
Global Const $D3DLIGHT_FORCE_DWORD = 0x7fffffff

; Sprite flags
Global Const $D3DXSPRITE_DONOTSAVESTATE = 1
Global Const $D3DXSPRITE_DONOTMODIFY_RENDERSTATE = 2
Global Const $D3DXSPRITE_OBJECTSPACE = 4
Global Const $D3DXSPRITE_BILLBOARD = 8
Global Const $D3DXSPRITE_ALPHABLEND = 16
Global Const $D3DXSPRITE_SORT_TEXTURE = 32
Global Const $D3DXSPRITE_SORT_DEPTH_FRONTTOBACK = 64
Global Const $D3DXSPRITE_SORT_DEPTH_BACKTOFRONT = 128
Global Const $D3DXSPRITE_DO_NOT_ADDREF_TEXTURE = 256

Global Const $D3DX_FILTER_NONE				= 1
Global Const $D3DX_FILTER_POINT				= 2
Global Const $D3DX_FILTER_LINEAR			= 3
Global Const $D3DX_FILTER_TRIANGLE			= 4
Global Const $D3DX_FILTER_BOX				= 5

Global Const $D3DX_FILTER_MIRROR_U			= 0x00010000
Global Const $D3DX_FILTER_MIRROR_V			= 0x00020000
Global Const $D3DX_FILTER_MIRROR_W			= 0x00040000
Global Const $D3DX_FILTER_MIRROR			= 0x00070000
Global Const $D3DX_FILTER_DITHER			= 0x00080000
Global Const $D3DX_FILTER_DITHER_DIFFUSION	= 0x00100000
Global Const $D3DX_FILTER_SRGB_IN			= 0x00200000
Global Const $D3DX_FILTER_SRGB_OUT			= 0x00400000
Global Const $D3DX_FILTER_SRGB				= 0x00600000

Global Const $D3DX_DEFAULT			= -1
Global Const $D3DX_DEFAULT_NONPOW2	= -2
Global Const $D3DX_DEFAULT_FLOAT	= 3.402823466e+38
Global Const $D3DX_FROM_FILE		= -3
Global Const $D3DFMT_FROM_FILE		= -3

Func _MAKEFOURCC($ch0, $ch1, $ch2, $ch3)
    Return BitOR(Asc($ch0), BitShift(Asc($ch1), -8), BitShift(Asc($ch2), -16), BitShift(Asc($ch3), -24))
EndFunc