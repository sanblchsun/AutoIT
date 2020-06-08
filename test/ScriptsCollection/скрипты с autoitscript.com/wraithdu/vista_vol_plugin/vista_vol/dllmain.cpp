// dllmain.cpp : Defines the entry point for the DLL application.
#include "stdafx.h"

static IAudioEndpointVolume *endpointVolume = NULL;

/****************************************************************************
* Function List
*
* This is where you define the functions available to AutoIt.  Including
* the function name (Must be the same case as your exported DLL name), the
* minimum and maximum number of parameters that the function takes.
*
****************************************************************************/

/* "FunctionName", min_params, max_params */
AU3_PLUGIN_FUNC g_AU3_Funcs[] = 
{
	{"_GetMasterVolume_Vista", 0, 0},
	{"_GetMasterVolumeScalar_Vista", 0, 0},
	{"_SetMasterVolume_Vista", 1, 1},
	{"_SetMasterVolumeScalar_Vista", 1, 1},
	{"_GetVolumeRange_Vista", 1, 1},
	{"_IsMute_Vista", 0, 0},
	{"_SetMute_Vista", 1, 1},
	{"_GetVolumeStepInfo_Vista", 1, 1},
	{"_VolumeStepUp_Vista", 0, 0},
	{"_VolumeStepDown_Vista", 0, 0}
};


/****************************************************************************
* AU3_GetPluginDetails()
*
* This function is called by AutoIt when the plugin dll is first loaded to
* query the plugin about what functions it supports.  DO NOT MODIFY.
*
****************************************************************************/

AU3_PLUGINAPI int AU3_GetPluginDetails(int *n_AU3_NumFuncs, AU3_PLUGIN_FUNC **p_AU3_Func)
{
	/* Pass back the number of functions that this DLL supports */
	*n_AU3_NumFuncs	= sizeof(g_AU3_Funcs)/sizeof(AU3_PLUGIN_FUNC);

	/* Pack back the address of the global function table */
	*p_AU3_Func = g_AU3_Funcs;

	return AU3_PLUGIN_OK;
}

int _Initialize(void)
{
	int err = 1;

	if (SUCCEEDED(CoInitialize(NULL)))
	{
		err = 2;
		IMMDeviceEnumerator *deviceEnumerator = NULL;
		if (SUCCEEDED(CoCreateInstance(__uuidof(MMDeviceEnumerator), NULL, CLSCTX_INPROC_SERVER, __uuidof(IMMDeviceEnumerator), (LPVOID *)&deviceEnumerator)))
		{
			err = 3;
			IMMDevice *defaultDevice = NULL;

			if (SUCCEEDED(deviceEnumerator->GetDefaultAudioEndpoint(eRender, eConsole, &defaultDevice)))
			{
				err = 4;
				deviceEnumerator->Release();
				deviceEnumerator = NULL;

				if (SUCCEEDED(defaultDevice->Activate(__uuidof(IAudioEndpointVolume), CLSCTX_INPROC_SERVER, NULL, (LPVOID *)&endpointVolume)))
				{
					defaultDevice->Release();
					defaultDevice = NULL;
					return 0;
				}
			}
		}
	}
	return err;
}


/****************************************************************************
* DllMain()
*
* This function is called when the DLL is loaded and unloaded.  Do not 
* modify it unless you understand what it does...
*
****************************************************************************/

BOOL WINAPI DllMain(HANDLE hInst, ULONG ul_reason_for_call, LPVOID lpReserved)
{
	int err;
	char buff [33];
	char szerr[60] = "Plugin failed to initialize properly!\n\nError: ";

	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
		err = _Initialize();
		if (err)
		{
			_itoa(err, buff, 10);
			strcat_s(szerr, 60, buff);
			MessageBoxA(NULL, szerr, "Error", MB_OK | MB_ICONSTOP | MB_TOPMOST);
		}
		break;
	case DLL_THREAD_ATTACH:
		break;
	case DLL_THREAD_DETACH:
		break;
	case DLL_PROCESS_DETACH:
		if (endpointVolume)
			endpointVolume->Release();
		CoUninitialize();
		break;
	}
	return TRUE;
}


/****************************************************************************
* _GetMasterVolume_Vista()
*
* Returns master volume level in decibels.
****************************************************************************/

AU3_PLUGIN_DEFINE(_GetMasterVolume_Vista)
{
	/* The inputs to a plugin function are:
	*		n_AU3_NumParams		- The number of parameters being passed
	*		p_AU3_Params		- An array of variant like variables used by AutoIt
	*
	* The outputs of a plugin function are:
	*		p_AU3_Result		- A pointer to a variant variable for the result
	*		n_AU3_ErrorCode		- The value for @Error
	*		n_AU3_ExtCode		- The value for @Extended
	*/

	AU3_PLUGIN_VAR	*pMyResult;
	float currentVolume = 0;

	/* Allocate and build the return variable */
	pMyResult = AU3_AllocVar();
	AU3_SetInt32(pMyResult, 0);
	*n_AU3_ErrorCode = 1;

	if (SUCCEEDED(endpointVolume->GetMasterVolumeLevel(&currentVolume)))
	{
		AU3_SetDouble(pMyResult, (double)currentVolume);
		*n_AU3_ErrorCode = 0;
	}

	/* Pass back the result, error code and extended code.
	* Note: AutoIt is responsible for freeing the memory used in p_AU3_Result
	*/
	*p_AU3_Result		= pMyResult;
	*n_AU3_ExtCode		= 0;

	return AU3_PLUGIN_OK;
}

/****************************************************************************
* _GetMasterVolumeScalar_Vista()
*
* Returns master volume level as a scalar value from 0 to 100.
****************************************************************************/

AU3_PLUGIN_DEFINE(_GetMasterVolumeScalar_Vista)
{
	AU3_PLUGIN_VAR	*pMyResult;
	float currentVolume = 0;

	/* Allocate and build the return variable */
	pMyResult = AU3_AllocVar();
	AU3_SetInt32(pMyResult, -1);
	*n_AU3_ErrorCode = 1;

	if (SUCCEEDED(endpointVolume->GetMasterVolumeLevelScalar(&currentVolume)))
	{
		AU3_SetDouble(pMyResult, (double)(currentVolume * 100));
		*n_AU3_ErrorCode = 0;
	}

	// Pass back the result, error code and extended code.
	*p_AU3_Result		= pMyResult;
	*n_AU3_ExtCode		= 0;

	return AU3_PLUGIN_OK;
}

/****************************************************************************
* _SetMasterVolume_Vista()
*
* Sets master volume in decibels.
****************************************************************************/

AU3_PLUGIN_DEFINE(_SetMasterVolume_Vista)
{
	AU3_PLUGIN_VAR	*pMyResult;
	float newVolume = 0;

	/* Allocate and build the return variable */
	pMyResult = AU3_AllocVar();
	AU3_SetInt32(pMyResult, -1);
	*n_AU3_ErrorCode = 1;

	/* Get passed volume */
	newVolume = (float)AU3_GetDouble(&p_AU3_Params[0]);

	if (SUCCEEDED(endpointVolume->SetMasterVolumeLevel(newVolume, NULL)))
	{
		AU3_SetInt32(pMyResult, 0);
		*n_AU3_ErrorCode = 0;
	}

	// Pass back the result, error code and extended code.
	*p_AU3_Result		= pMyResult;
	*n_AU3_ExtCode		= 0;

	return AU3_PLUGIN_OK;
}

/****************************************************************************
* _SetMasterVolumeScalar_Vista()
*
* Sets master volume level as a scalar value from 0 to 100.
****************************************************************************/

AU3_PLUGIN_DEFINE(_SetMasterVolumeScalar_Vista)
{
	AU3_PLUGIN_VAR	*pMyResult;
	float newVolume = 0;

	/* Allocate and build the return variable */
	pMyResult = AU3_AllocVar();
	AU3_SetInt32(pMyResult, -1);
	*n_AU3_ErrorCode = 1;

	/* Get passed volume */
	newVolume = (float)(AU3_GetDouble(&p_AU3_Params[0]) / 100);

	if (SUCCEEDED(endpointVolume->SetMasterVolumeLevelScalar(newVolume, NULL)))
	{
		AU3_SetInt32(pMyResult, 0);
		*n_AU3_ErrorCode = 0;
	}

	// Pass back the result, error code and extended code.
	*p_AU3_Result		= pMyResult;
	*n_AU3_ExtCode		= 0;

	return AU3_PLUGIN_OK;
}

/****************************************************************************
* _GetVolumeRange_Vista()
*
* Gets volume decibel range information:
* LevelMinDB = minimum decibel value
* LevelMaxDB = maximum decibel value
* VolumeIncrementDB = decibel increment value
****************************************************************************/

AU3_PLUGIN_DEFINE(_GetVolumeRange_Vista)
{
	AU3_PLUGIN_VAR	*pMyResult;
	typedef struct tagRANGEINFO
	{
		float LevelMinDB;
		float LevelMaxDB;
		float VolumeIncrementDB;
	} RANGEINFO;

	/* Allocate and build the return variable */
	pMyResult = AU3_AllocVar();
	AU3_SetInt32(pMyResult, -1);
	*n_AU3_ErrorCode = 1;

	/* Get Struct Pointer */
	RANGEINFO *aRange = (RANGEINFO *)AU3_GetInt32(&p_AU3_Params[0]);

	if (SUCCEEDED(endpointVolume->GetVolumeRange(&aRange->LevelMinDB, &aRange->LevelMaxDB, &aRange->VolumeIncrementDB)))
	{
		AU3_SetInt32(pMyResult, 0);
		*n_AU3_ErrorCode = 0;
	}

	// Pass back the result, error code and extended code.
	*p_AU3_Result		= pMyResult;
	*n_AU3_ExtCode		= 0;

	return AU3_PLUGIN_OK;
}

/****************************************************************************
* _IsMute_Vista()
*
* Gets the mute state.
****************************************************************************/

AU3_PLUGIN_DEFINE(_IsMute_Vista)
{
	AU3_PLUGIN_VAR	*pMyResult;
	BOOL isMute = false;

	/* Allocate and build the return variable */
	pMyResult = AU3_AllocVar();
	AU3_SetInt32(pMyResult, -1);
	*n_AU3_ErrorCode = 1;

	if (SUCCEEDED(endpointVolume->GetMute(&isMute)))
	{
		AU3_SetInt32(pMyResult, (int)isMute);
		*n_AU3_ErrorCode = 0;
	}

	// Pass back the result, error code and extended code.
	*p_AU3_Result		= pMyResult;
	*n_AU3_ExtCode		= 0;

	return AU3_PLUGIN_OK;
}

/****************************************************************************
* _SetMute_Vista()
*
* Sets the mute state.
****************************************************************************/

AU3_PLUGIN_DEFINE(_SetMute_Vista)
{
	AU3_PLUGIN_VAR	*pMyResult;
	BOOL setMute = false;

	/* Allocate and build the return variable */
	pMyResult = AU3_AllocVar();
	AU3_SetInt32(pMyResult, -1);
	*n_AU3_ErrorCode = 1;

	/* Get Mute State */
	setMute = (BOOL)AU3_GetInt32(&p_AU3_Params[0]);

	if (SUCCEEDED(endpointVolume->SetMute(setMute, NULL)))
	{
		AU3_SetInt32(pMyResult, 0);
		*n_AU3_ErrorCode = 0;
	}

	// Pass back the result, error code and extended code.
	*p_AU3_Result		= pMyResult;
	*n_AU3_ExtCode		= 0;

	return AU3_PLUGIN_OK;
}

/****************************************************************************
* _GetVolumeStepInfo_Vista()
*
* Gets volume step information:
* nStep = current volume step
* nStepCount = step range; from 0 to nStepCount - 1
****************************************************************************/

AU3_PLUGIN_DEFINE(_GetVolumeStepInfo_Vista)
{
	AU3_PLUGIN_VAR	*pMyResult;
	typedef struct tagSTEPINFO
	{
		UINT nStep;
		UINT nStepCount;
	} STEPINFO;

	/* Allocate and build the return variable */
	pMyResult = AU3_AllocVar();
	AU3_SetInt32(pMyResult, -1);
	*n_AU3_ErrorCode = 1;

	/* Get Struct Pointer */
	STEPINFO *aStep = (STEPINFO *)AU3_GetInt32(&p_AU3_Params[0]);

	if (SUCCEEDED(endpointVolume->GetVolumeStepInfo(&aStep->nStep, &aStep->nStepCount)))
	{
		AU3_SetInt32(pMyResult, 0);
		*n_AU3_ErrorCode = 0;
	}

	// Pass back the result, error code and extended code.
	*p_AU3_Result		= pMyResult;
	*n_AU3_ExtCode		= 0;

	return AU3_PLUGIN_OK;
}

/****************************************************************************
* _VolumeStepUp_Vista()
*
* Increases the volume by 1 step.
****************************************************************************/

AU3_PLUGIN_DEFINE(_VolumeStepUp_Vista)
{
	AU3_PLUGIN_VAR	*pMyResult;

	/* Allocate and build the return variable */
	pMyResult = AU3_AllocVar();
	AU3_SetInt32(pMyResult, -1);
	*n_AU3_ErrorCode = 1;

	if (SUCCEEDED(endpointVolume->VolumeStepUp(NULL)))
	{
		AU3_SetInt32(pMyResult, 0);
		*n_AU3_ErrorCode = 0;
	}

	// Pass back the result, error code and extended code.
	*p_AU3_Result		= pMyResult;
	*n_AU3_ExtCode		= 0;

	return AU3_PLUGIN_OK;
}

/****************************************************************************
* _VolumeStepDown_Vista()
*
* Decreases the volume by 1 step.
****************************************************************************/

AU3_PLUGIN_DEFINE(_VolumeStepDown_Vista)
{
	AU3_PLUGIN_VAR	*pMyResult;

	/* Allocate and build the return variable */
	pMyResult = AU3_AllocVar();
	AU3_SetInt32(pMyResult, -1);
	*n_AU3_ErrorCode = 1;

	if (SUCCEEDED(endpointVolume->VolumeStepDown(NULL)))
	{
		AU3_SetInt32(pMyResult, 0);
		*n_AU3_ErrorCode = 0;
	}

	// Pass back the result, error code and extended code.
	*p_AU3_Result		= pMyResult;
	*n_AU3_ExtCode		= 0;

	return AU3_PLUGIN_OK;
}