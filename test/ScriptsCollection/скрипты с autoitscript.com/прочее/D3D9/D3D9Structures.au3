#include-once

Global $tagIUnknown = "QueryInterface;AddRef;Release;"

Global $tagIDirect3D9 = $tagIUnknown & _
	"RegisterSoftwareDevice;" & _
	"GetAdapterCount;" & _
	"GetAdapterIdentifier;" & _
	"GetAdapterModeCount;" & _
	"EnumAdapterModes;" & _
	"GetAdapterDisplayMode;" & _
	"CheckDeviceType;" & _
	"CheckDeviceFormat;" & _
	"CheckDeviceMultiSampleType;" & _
	"CheckDepthStencilMatch;" & _
	"CheckDeviceFormatConversion;" & _
	"GetDeviceCaps;" & _
	"GetAdapterMonitor;" & _
	"CreateDevice;"

Global $tagID3DDevice9Interface = $tagIUnknown & _
	"TestCooperativeLevel;" & _
	"GetAvailableTextureMem;" & _
	"EvictManagedResources;" & _
	"GetDirect3D;" & _
	"GetDeviceCaps;" & _
	"GetDisplayMode;" & _
	"GetCreationParameters;" & _
	"SetCursorProperties;" & _
	"SetCursorPosition;" & _
	"ShowCursor;" & _
	"CreateAdditionalSwapChain;" & _
	"GetSwapChain;" & _
	"GetNumberOfSwapChains;" & _
	"Reset;" & _
	"Present;" & _
	"GetBackBuffer;" & _
	"GetRasterStatus;" & _
	"SetDialogBoxMode;" & _
	"SetGammaRamp;" & _
	"GetGammaRamp;" & _
	"CreateTexture;" & _
	"CreateVolumeTexture;" & _
	"CreateCubeTexture;" & _
	"CreateVertexBuffer;" & _
	"CreateIndexBuffer;" & _
	"CreateRenderTarget;" & _
	"CreateDepthStencilSurface;" & _
	"UpdateSurface;" & _
	"UpdateTexture;" & _
	"GetRenderTargetData;" & _
	"GetFrontBufferData;" & _
	"StretchRect;" & _
	"ColorFill;" & _
	"CreateOffscreenPlainSurface;" & _
	"SetRenderTarget;" & _
	"GetRenderTarget;" & _
	"SetDepthStencilSurface;" & _
	"GetDepthStencilSurface;" & _
	"BeginScene;" & _
	"EndScene;" & _
	"Clear;" & _
	"SetTransform;" & _
	"GetTransform;" & _
	"MultiplyTransform;" & _
	"SetViewport;" & _
	"GetViewport;" & _
	"SetMaterial;" & _
	"GetMaterial;" & _
	"SetLight;" & _
	"GetLight;" & _
	"LightEnable;" & _
	"GetLightEnable;" & _
	"SetClipPlane;" & _
	"GetClipPlane;" & _
	"SetRenderState;" & _
	"GetRenderState;" & _
	"CreateStateBlock;" & _
	"BeginStateBlock;" & _
	"EndStateBlock;" & _
	"SetClipStatus;" & _
	"GetClipStatus;" & _
	"GetTexture;" & _
	"SetTexture;" & _
	"GetTextureStageState;" & _
	"SetTextureStageState;" & _
	"GetSamplerState;" & _
	"SetSamplerState;" & _
	"ValidateDevice;" & _
	"SetPaletteEntries;" & _
	"GetPaletteEntries;" & _
	"SetCurrentTexturePalette;" & _
	"GetCurrentTexturePalette;" & _
	"SetScissorRect;" & _
	"GetScissorRect;" & _
	"SetSoftwareVertexProcessing;" & _
	"GetSoftwareVertexProcessing;" & _
	"SetNPatchMode;" & _
	"GetNPatchMode;" & _
	"DrawPrimitive;" & _
	"DrawIndexedPrimitive;" & _
	"DrawPrimitiveUP;" & _
	"DrawIndexedPrimitiveUP;" & _
	"ProcessVertices;" & _
	"CreateVertexDeclaration;" & _
	"SetVertexDeclaration;" & _
	"GetVertexDeclaration;" & _
	"SetFVF;" & _
	"GetFVF;" & _
	"CreateVertexShader;" & _
	"SetVertexShader;" & _
	"GetVertexShader;" & _
	"SetVertexShaderConstantF;" & _
	"GetVertexShaderConstantF;" & _
	"SetVertexShaderConstantI;" & _
	"GetVertexShaderConstantI;" & _
	"SetVertexShaderConstantB;" & _
	"GetVertexShaderConstantB;" & _
	"SetStreamSource;" & _
	"GetStreamSource;" & _
	"SetStreamSourceFreq;" & _
	"GetStreamSourceFreq;" & _
	"SetIndices;" & _
	"GetIndices;" & _
	"CreatePixelShader;" & _
	"SetPixelShader;" & _
	"GetPixelShader;" & _
	"SetPixelShaderConstantF;" & _
	"GetPixelShaderConstantF;" & _
	"SetPixelShaderConstantI;" & _
	"GetPixelShaderConstantI;" & _
	"SetPixelShaderConstantB;" & _
	"GetPixelShaderConstantB;" & _
	"DrawRectPatch;" & _
	"DrawTriPatch;" & _
	"DeletePatch;" & _
	"CreateQuery;"

Global $tagID3DXBaseMesh = $tagIUnknown & _
    "DrawSubset;" & _
    "GetNumFaces;" & _
    "GetNumVertices;" & _
    "GetFVF;" & _
    "GetDeclaration;" & _
    "GetNumBytesPerVertex;" & _
    "GetOptions;" & _
    "GetDevice;" & _
    "CloneMeshFVF;" & _
    "CloneMesh;" & _
    "GetVertexBuffer;" & _
    "GetIndexBuffer;" & _
    "LockVertexBuffer;" & _
    "UnlockVertexBuffer;" & _
    "LockIndexBuffer;" & _
    "UnlockIndexBuffer;" & _
    "GetAttributeTable;" & _
    "ConvertPointRepsToAdjacency;" & _
    "ConvertAdjacencyToPointReps;" & _
    "GenerateAdjacency;" & _
    "UpdateSemantics;"

Global $tagID3DXMesh = $tagID3DXBaseMesh & _
    "LockAttributeBuffer;" & _
    "UnlockAttributeBuffer;" & _
    "Optimize;" & _
    "OptimizeInplace;" & _
    "SetAttributeTable;"

Global $tagIDirect3DResource9 = $tagIUnknown & _
	"GetDevice;" & _
	"SetPrivateData;" & _
	"GetPrivateData;" & _
	"FreePrivateData;" & _
	"SetPriority;" & _
	"GetPriority;" & _
	"PreLoad;" & _
	"GetType;"

Global $tagIDirect3DVertexBuffer9 = $tagIDirect3DResource9 & _
	"Lock;" & _
	"Unlock;" & _
	"GetDesc;"

Global $tagIDirect3DSurface9 = $tagIDirect3DResource9 & _
	"GetContainer;" & _
	"GetDesc;" & _
	"LockRect;" & _
	"UnlockRect;" & _
	"GetDC;" & _
	"ReleaseDC;"

Global $tagIDirect3DBaseTexture9 = $tagIDirect3DResource9 & _
	"SetLOD;" & _
	"GetLOD;" & _
	"GetLevelCount;" & _
	"SetAutoGenFilterType;" & _
	"GetAutoGenFilterType;" & _
	"GenerateMipSubLevels;"

Global $tagIDirect3DTexture9 = $tagIDirect3DBaseTexture9 & _
	"GetLevelDesc;" & _
	"GetSurfaceLevel;" & _
	"LockRect;" & _
	"UnlockRect;" & _
	"AddDirtyRect;"

Global $tagID3DXSprite = $tagIUnknown & _
	"GetDevice;" & _
	"GetTransform;" & _
	"SetTransform;" & _
	"SetWorldViewRH;" & _
	"SetWorldViewLH;" & _
	"Begin;" & _
	"Draw;" & _
	"Flush;" & _
	"End;" & _
	"OnLostDevice;" & _
	"OnResetDevice;"

Global Const $tagD3DCAPS9 = _
	"int DeviceType;" & _
    "uint AdapterOrdinal;" & _
    "uint Caps;" & _
    "uint Caps2;" & _
    "uint Caps3;" & _
    "uint PresentationIntervals;" & _
    "uint CursorCaps;" & _
    "uint DevCaps;" & _
    "uint PrimitiveMiscCaps;" & _
    "uint RasterCaps;" & _
    "uint ZCmpCaps;" & _
    "uint SrcBlendCaps;" & _
    "uint DestBlendCaps;" & _
    "uint AlphaCmpCaps;" & _
    "uint ShadeCaps;" & _
    "uint TextureCaps;" & _
    "uint TextureFilterCaps;" & _
    "uint CubeTextureFilterCaps;" & _
    "uint VolumeTextureFilterCaps;" & _
    "uint TextureAddressCaps;" & _
    "uint VolumeTextureAddressCaps;" & _
    "uint LineCaps;" & _
    "uint MaxTextureWidth;" & _
	"uint MaxTextureHeight;" & _
    "uint MaxVolumeExtent;" & _
    "uint MaxTextureRepeat;" & _
    "uint MaxTextureAspectRatio;" & _
    "uint MaxAnisotropy;" & _
    "float MaxVertexW;" & _
    "float GuardBandLeft;" & _
    "float GuardBandTop;" & _
    "float GuardBandRight;" & _
    "float GuardBandBottom;" & _
    "float ExtentsAdjust;" & _
    "uint StencilCaps;" & _
    "uint FVFCaps;" & _
    "uint TextureOpCaps;" & _
    "uint MaxTextureBlendStages;" & _
    "uint MaxSimultaneousTextures;" & _
    "uint VertexProcessingCaps;" & _
    "uint MaxActiveLights;" & _
    "uint MaxUserClipPlanes;" & _
    "uint MaxVertexBlendMatrices;" & _
    "uint MaxVertexBlendMatrixIndex;" & _
    "float MaxPointSize;" & _
    "uint MaxPrimitiveCount;" & _
    "uint MaxVertexIndex;" & _
    "uint MaxStreams;" & _
    "uint MaxStreamStride;" & _
    "uint VertexShaderVersion;" & _
    "uint MaxVertexShaderConst;" & _
    "uint PixelShaderVersion;" & _
    "float PixelShader1xMaxValue;" & _
    "uint DevCaps2;" & _
    "float MaxNpatchTessellationLevel;" & _
    "uint Reserved5;" & _
    "uint MasterAdapterOrdinal;" & _
    "uint AdapterOrdinalInGroup;" & _
    "uint NumberOfAdaptersInGroup;" & _
    "uint DeclTypes;" & _
    "uint NumSimultaneousRTs;" & _
    "uint StretchRectFilterCaps;" & _
    "uint VS20CapsCaps;" & _
	"int VS20CapsDynamicFlowControlDepth;" & _
	"int VS20CapsNumTemps;" & _
	"int VS20CapsStaticFlowControlDepth;" & _
	"uint PS20CapsCaps;" & _
    "int PS20CapsDynamicFlowControlDepth;" & _
    "int PS20CapsNumTemps;" & _
    "int PS20CapsStaticFlowControlDepth;" & _
    "int PS20CapsNumInstructionSlots;" & _
    "uint VertexTextureFilterCaps;" & _
    "uint MaxVShaderInstructionsExecuted;" & _
    "uint MaxPShaderInstructionsExecuted;" & _
    "uint MaxVertexShader30InstructionSlots;" & _
    "uint MaxPixelShader30InstructionSlots;"

Global Const $tagD3DPRESENT_PARAMETERS = _
    "uint BackBufferWidth;" & _
    "uint BackBufferHeight;" & _
    "int BackBufferFormat;" & _
    "uint BackBufferCount;" & _
    "int MultiSampleType;" & _
    "uint MultiSampleQuality;" & _
    "int SwapEffect;" & _
    "hwnd hDeviceWindow;" & _
    "bool Windowed;" & _
    "bool EnableAutoDepthStencil;" & _
    "int AutoDepthStencilFormat;" & _
    "uint Flags;" & _
    "uint FullScreen_RefreshRateInHz;" & _
    "uint PresentationInterval;"

Global Const $tagD3DLIGHT9 = _
	"int Type;" & _ 		 	; Type of light source
	"float Diffuse[4];" & _  	; Diffuse color of light
	"float Specular[4];" & _ 	; Specular color of light
	"float Ambient[4];" & _  	; Ambient color of light
	"float Position[3];" & _ 	; Position in world space
	"float Direction[3];" & _ 	; Direction in world space
	"float Range;" & _ 			; Cutoff range
	"float Falloff;" & _ 		; Falloff
	"float Attenuation0;" & _ 	; Constant attenuation
	"float Attenuation1;" & _ 	; Linear attenuation
	"float Attenuation2;" & _ 	; Quadratic attenuation
	"float Theta;" & _ 			; Inner angle of spotlight cone
	"float Phi;"				; Outer angle of spotlight cone

Global Const $tagD3DMATERIAL9 = _
    "float Diffuse[4];" & _ 	; Diffuse color RGBA
    "float Ambient[4];" & _ 	; Ambient color RGB
    "float Specular[4];" & _ 	; Specular 'shininess'
    "float Emissive[4];" & _ 	; Emissive color RGB
    "float Power;"				; Sharpness if specular highlight

Global Const $tagD3DVECTOR3 = "float x;float y;float z;"
Global Const $tagD3DMATRIX = "float m[16];"