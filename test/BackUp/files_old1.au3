;
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/rel /tc n
;
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <resources.au3>
#include <GuiIPAddress.au3>
#include <GuiListView.au3>
#include <ListViewConstants.au3>
#include <EditConstants.au3>
#include <Date.au3>
#include <Misc.au3>
#include <ModernMenuRaw.au3>
#include <GuiTreeView.au3>
#include <GuiButton.au3>
;
Global $path_conf = @ScriptDir & "\config.cfg"
Global $stage
Global $stage_number
Global $stage_combo2
Global $type_color
Global $type_device
Global $sList
Global $numbers_stage
Global $sList1
Global $stage_Input
Global $Printers_forms
Global $location_dev_combo
Global $title = "Device base"
Global $aIcons ; для  подгрузки иконок
Global $aElement[2], $hActive, $iInput
Global $iExit, $iSaveChange
Global $sIcons_File = @AutoItExe
;
#Region ;проверка наличия файла бд в папке с программой. если файл существует,строка из конфига не читается
If FileExists(@ScriptDir & '\base.pdb') Then
    $path_db = @ScriptDir & '\base.pdb'
EndIf
If Not FileExists(@ScriptDir & '\base.pdb') Then
    $path_db = IniRead(@ScriptDir & "\config.cfg", 'db location', 'location', 0)
EndIf
#EndRegion ;проверка наличия файла бд в папке с программой. если файл существует,строка из конфига не читается
;
_Singleton($title) ; предотвращение повторного запуска
AutoItSetOption("TrayIconHide", 1) ; скрытие иконки в трее
Opt('GUICloseOnESC', 0) ; запрет закрытие окна по Esc
;
If Not FileExists($path_conf) Then
    MsgBox(8208, 'Ошибка запуска', 'Отсутсвует файл конфигурации.' & @CRLF & 'Дальнейшая работа программы не возможна!')
    Exit
EndIf
;
#Region  ### основной интерфейс ###
$Printers_forms = GUICreate($title, 698, 354)
$Label1 = GUICtrlCreateLabel("Выберите этаж", 16, 14, 82, 17)
$stage_combo = GUICtrlCreateCombo("", 16, 32, 145, 25, $CBS_DROPDOWNLIST + $WS_VSCROLL)
$iInput = GUICtrlCreateInput("", 0, 0, 0, 0)
GUICtrlSetState(-1, $GUI_HIDE)
;
$label2 = GUICtrlCreateLabel("Дата создания базы данных:", 174, 10, 150, 17)
$creat_db_label = GUICtrlCreateLabel("", 327, 10, 60, 17)
$label4 = GUICtrlCreateLabel("Последние изменения внесены:", 396, 10, 170, 17)
$change_db_label = GUICtrlCreateLabel("", 564, 10, 120, 17)
$label5 = GUICtrlCreateLabel("Расположение открытой базы данных:", 174, 46, 198, 17)
$locate_db_label = GUICtrlCreateLabel("", 374, 46, 250, 17)
GUICtrlSetState(-1, $GUI_HIDE)
;
$printers_list_view = GUICtrlCreateListView("Тип оборудования|Модель|Тип печати|Расположение|IP-адрес|Коментарий", 8, 64, 682, 226)
$hListView = GUICtrlGetHandle(-1); нужно для редактирования списка
_GUICtrlListView_SetExtendedListViewStyle($hListView, $LVS_EX_GRIDLINES, $LVS_EX_GRIDLINES); нужно для редактирования списка
_GUICtrlListView_SetExtendedListViewStyle($printers_list_view, BitOR($LVS_EX_FULLROWSELECT, $LVS_REPORT, $LVS_EX_GRIDLINES))
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 130)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 120)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 120)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 94)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 5, 100)
;
$refresh_btn = GUICtrlCreateButton("Обновить", 24, 298, 83, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$delete_btn = GUICtrlCreateButton("Удалить", 232, 298, 83, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$add_printer = GUICtrlCreateButton("Добавить", 384, 298, 83, 25)
$exit_btn = GUICtrlCreateButton("Закрыть", 592, 298, 83, 25)
;
$iSaveChange = GUICtrlCreateDummy();регистрация выполнения функции по требованию GUI
GUICtrlSetOnEvent(-1, "_SaveChange_list")
;
Global $AccelKeys[1][2] = [["{ENTER}", $iSaveChange]]
GUISetAccelerators($AccelKeys)
;
;регистрация событий _WM_NOTIFY для возможности редактирования listview
GUIRegisterMsg(0x4E, "_WM_NOTIFY")
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
GUISetState(@SW_SHOW)
#EndRegion  ### основной интерфейс ###
;
GUICtrlSetData($locate_db_label, $path_db)
;
$hImage = _GUIImageList_Create(16, 16, 5, 3)
_GUIImageList_AddIcon($hImage, $sIcons_File, 16)
_GUICtrlListView_SetImageList($printers_list_view, $hImage, 1)
;
_load_stages()
;
$hListViewHeader = _GUICtrlListView_GetHeader($printers_list_view); получение данных о listview для возможности его редактирования
;
While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
            ;
        Case $locate_db_label
            $open_folder = StringTrimRight($path_db, 9)
            ShellExecute(@WindowsDir & '\explorer', $open_folder)
            ;
            ;
        Case $stage_combo
            _check_db()
            ;
        Case $delete_btn
            _delete_device()
            ;
            ;
        Case $iSaveChange
            _SaveChange_list()
            ;
        Case $add_printer
            _add_device_dlg($Printers_forms)
            ;
        Case $refresh_btn
            $number = GUICtrlRead($stage_combo)
            _check_db()
            GUICtrlSetData($stage_combo, $stage_number)
            ;
        Case $exit_btn
            Exit
            ;
    EndSwitch
WEnd
;
Func _load_stages(); загрузка этажей
    $numbers_stage = IniRead($path_db, "Stage", "1", "0")
    For $i = 1 To $numbers_stage
        $sList &= $i & ' Этаж' & '|'
    Next
    GUICtrlSetData($stage_combo, "|")
    GUICtrlSetData($stage_combo, $sList, " ")
    $sList = ''
EndFunc   ;==>_load_stages
;
Func _db_changes(); отражение последнего сохранения базы
    $db_change_date = _DateTimeFormat(_NowCalc(), 2)
    $db_change_time = _DateTimeFormat(_NowCalc(), 5)
    IniWrite($path_db, "Last changes", "data_change_db", $db_change_date & ' г. в ' & $db_change_time)
EndFunc   ;==>_db_changes
;
Func _check_db(); проверка значения "этаж" и загрузка информации о базе данных
    ;
    $date_creat_conf = IniRead($path_db, "DB Creat", "data_creat_db", "Неизвестно")
    GUICtrlSetData($creat_db_label, $date_creat_conf)
    ;
    $date_change_conf = IniRead($path_db, "Last changes", "data_change_db", "Неизвестно")
    GUICtrlSetData($change_db_label, $date_change_conf)
    ;
    $stage_number = GUICtrlRead($stage_combo)
    $read_list_dev = IniReadSection($path_db, "Printers list " & $stage_number)
    ;
    If Not @error Then
        $date_change_conf = IniRead($path_db, "Last changes", "data_change_db", "Неизвестно")
        GUICtrlSetData($change_db_label, $date_change_conf)
        GUICtrlSetState($refresh_btn, $GUI_ENABLE)
        GUICtrlSetState($delete_btn, $GUI_ENABLE)
        GUICtrlSetState($locate_db_label, $GUI_SHOW)
        _open_db()
    Else
        _GUICtrlListView_DeleteAllItems($printers_list_view)
        GUICtrlSetState($change_db_label, $date_change_conf)
        GUICtrlSetState($refresh_btn, $GUI_DISABLE)
        GUICtrlSetState($delete_btn, $GUI_DISABLE)
        GUICtrlSetState($locate_db_label, $GUI_SHOW)
        ;MsgBox(0, '', 'Отсутствуют данные')
    EndIf
EndFunc   ;==>_check_db
;
Func _open_db(); чтение файла с данными
    Local $aRead_Ini = IniReadSection($path_db, "Printers list " & $stage_number)
    If Not @error Then
        _GUICtrlListView_DeleteAllItems($printers_list_view)
        For $i = 1 To $aRead_Ini[0][0]
            $aRead_Ini[$i][1] = StringTrimLeft($aRead_Ini[$i][1], 2)
            $iIndex = _open_db_Proc($aRead_Ini[$i][1])
            _GUICtrlListView_SetItemImage($printers_list_view, $iIndex, 0)
        Next
    Else
        _GUICtrlListView_DeleteAllItems($printers_list_view)
        MsgBox(0, '', 'Отсутствуют данные')
    EndIf
EndFunc   ;==>_open_db
;
Func _open_db_Proc($sItem = ""); добавление данных из прочитанного файла. подфункция _open_db
    Local $aItem = StringSplit($sItem, "|")
    ;
    Local $iCount = _GUICtrlListView_GetItemCount($printers_list_view)
    Local $iIndex = _GUICtrlListView_AddItem($printers_list_view, $aItem[1], $aIcons, $iCount + 9999)
    ;
    For $x = 0 To $aItem[0]
        _GUICtrlListView_AddSubItem($printers_list_view, $iIndex, $aItem[$x], $x - 1);, $aIcons[$x - 1] + $iPlus)
        ;
        If Mod($x, 2) Then
            _GUICtrlListView_SetItemBkColor($hListView, $x, 0xD3D3D3, 0) ; цвет нечетной строки
        Else
            _GUICtrlListView_SetItemBkColor($hListView, $x, 0xFFFFFF, 0) ; цвет четной строки
        EndIf
    Next
EndFunc   ;==>_open_db_Proc
;
Func _GUICtrlListView_SetItemBkColor($hWnd, $iItem, $iColor, $fRedraw = 0) ;изменение цвета строк в listview. события обрабатываются в функции WM_NOTIFY
    Local $_lv_ghLastWnd
    If _WinAPI_InProcess($hWnd, $_lv_ghLastWnd) Then
        If _GUICtrlListView_SetItemParam($hWnd, $iItem, BitOR(BitAND($iColor, 0x00FF00), BitShift(BitAND($iColor, 0x0000FF), -16), BitShift(BitAND($iColor, 0xFF0000), 16))) Then
            If $fRedraw Then
                _GUICtrlListView_RedrawItems($hWnd, $iItem, $iItem)
            EndIf
            Return 1
        EndIf
    EndIf
    Return 0
EndFunc   ;==>_GUICtrlListView_SetItemBkColor
;
Func _save_db(); сохранение базы данных
    Local $sItem = "", $sItemText
    Local $iItemCount = _GUICtrlListView_GetItemCount($printers_list_view)
    Local $iColsCount = _GUICtrlListView_GetColumnCount($printers_list_view)
    For $i = 0 To $iItemCount - 1
        $sItem = "0"
        For $j = 0 To $iColsCount - 1
            $sItemText = _GUICtrlListView_GetItemText($printers_list_view, $i, $j)
            $sItem &= "|" & StringReplace($sItemText, "|", ":")
            IniWrite($path_db, "Printers list " & $stage_number, $i, $sItem)
            _db_changes()
        Next
    Next
EndFunc   ;==>_save_db
;
Func _delete_device(); удаление выделеной позиции из списка
    Local $iIndex = _GUICtrlListView_GetSelectedIndices($printers_list_view)
    If $iIndex = "" Then
        Return
    EndIf
    If MsgBox(4 + 8240, 'Внимание!', 'Вы действительно хотите удалить устройство из списка?') = 6 Then
        _GUICtrlListView_DeleteItem($printers_list_view, Number($iIndex))
        IniDelete($path_db, "Printers list " & $stage_number)
        _save_db()
        _check_db()
    EndIf
EndFunc   ;==>_delete_device
;
Func _read_config(); функция загрузки информации
    ;
    ; загружается список этажей
    $numbers_stage1 = IniRead($path_db, "Stage", "1", "0")
    ;
    For $i = 1 To $numbers_stage1
        $sList1 &= $i & ' Этаж' & '|'
    Next
    ;
    GUICtrlSetData($stage_combo2, "|")
    GUICtrlSetData($stage_combo2, $sList1, " ")
    $sList1 = ''
    ;
    ;загружается данные по оборудованию
    $read_col_dev = IniReadSection($path_conf, "Color device list") ;
    ;
    If Not @error Then
        For $i = 1 To $read_col_dev[0][0]
            GUICtrlSetData($type_color, $read_col_dev[$i][1])
        Next
    EndIf
    ;
    $read_type_dev = IniReadSection($path_conf, "Type device list")
    ;
    If Not @error Then
        For $i = 1 To $read_type_dev[0][0]
            GUICtrlSetData($type_device, $read_type_dev[$i][1])
        Next
    EndIf
    $read_location_dev = IniReadSection($path_conf, "Location device list")
    ;
    If Not @error Then
        For $i = 1 To $read_location_dev[0][0]
            GUICtrlSetData($location_dev_combo, $read_location_dev[$i][1])
        Next
    EndIf
EndFunc   ;==>_read_config
;
Func _GUICtrlListView_EditItem($hWnd, $iIndex, $iSubItem); изменение пункта в listview
    ;funkey 19.02.2010
    If $iIndex < 0 Then Return
    Local $aPos, $aRect, $iSum = 0
    Local $x, $y, $w, $h
    For $i = 0 To $iSubItem - 1
        $iSum += _GUICtrlListView_GetColumnWidth($hWnd, $i)
    Next
    $aRect = _GUICtrlListView_GetItemRect($hWnd, $iIndex)
    $aPos = ControlGetPos($Printers_forms, "", $hWnd)
    $x = $iSum + $aPos[0] + $aRect[0]
    $y = $aPos[1] + $aRect[1]
    $w = _GUICtrlListView_GetColumnWidth($hWnd, $iSubItem)
    $h = $aRect[3] - $aRect[1]
    GUICtrlSetPos($iInput, $x + 2, $y + 1, $w + 1, $h + 1)
    GUICtrlSetData($iInput, _GUICtrlListView_GetItemText($hWnd, $iIndex, $iSubItem))
    GUICtrlSetState($iInput, $GUI_SHOW)
    GUICtrlSetState($iInput, $GUI_FOCUS)
    $aElement[0] = $iIndex
    $aElement[1] = $iSubItem
EndFunc   ;==>_GUICtrlListView_EditItem
;
Func _WM_NOTIFY($hWnd, $iMsg, $iwParam, $iParam) ;функция для возможности редактирования listview
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR
    $tNMHDR = DllStructCreate($tagNMHDR, $iParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $hListView
            Switch $iCode
                Case $NM_CUSTOMDRAW
                    Local $tNMLVCD = DllStructCreate($tagNMLVCUSTOMDRAW, $iParam)
                    Local $iDrawStage = DllStructGetData($tNMLVCD, 'dwDrawStage')
                    Switch $iDrawStage
                        Case $CDDS_PREPAINT
                            Return $CDRF_NOTIFYITEMDRAW
                        Case $CDDS_ITEMPREPAINT
                            Return $CDRF_NOTIFYSUBITEMDRAW
                        Case BitOR($CDDS_ITEMPREPAINT, $CDDS_SUBITEM)
                            DllStructSetData($tNMLVCD, 'clrTextBk', _GUICtrlListView_GetItemParam($hWndFrom, DllStructGetData($tNMLVCD, 'dwItemSpec')))
                            Return $CDRF_NEWFONT
                    EndSwitch
                Case $LVN_BEGINSCROLL ; прокрутка ListView
                    If $hActive Then
                        $hActive = 0
                        GUICtrlSetState($iInput, $GUI_HIDE)
                        GUICtrlSetData($iInput, '') ; Очищаем поле ввода
                    EndIf
                Case $NM_DBLCLK ; двойной клик - редактируем пункт ListView
                    Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $iParam)
                    $hActive = $hWndFrom
                    _GUICtrlListView_EditItem($hActive, DllStructGetData($tInfo, "Index"), DllStructGetData($tInfo, "SubItem"))
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>_WM_NOTIFY
;
Func WM_COMMAND($hWnd, $iMsg, $iwParam, $iParam);функция для возможности редактирования listview
    #forceref $hWnd, $iMsg
    Local $iIDFrom, $iCode
    $iIDFrom = BitAND($iwParam, 0xFFFF) ; младшее слово
    $iCode = BitShift($iwParam, 16) ; старшее слово
    Switch $iIDFrom
        Case $iInput
            Switch $iCode
                Case $EN_KILLFOCUS
                    GUICtrlSetState($iInput, $GUI_HIDE)
                    GUICtrlSetData($iInput, '') ; Очищаем поле ввода
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND
;
Func _SaveChange_list();Сохранение изменений в редактированом пункте
    Local $sText = GUICtrlRead($iInput)
    If StringInStr($sText, @CR) Or StringInStr($sText, @LF) Then
        If StringLeft($sText, 1) <> '"' And StringInStr(StringMid($sText, 2, StringLen($sText) - 2), '"') Then $sText = StringReplace($sText, '"', "'")
        $sText = '"' & StringReplace($sText, '"', '') & '"'
    EndIf
    _GUICtrlListView_BeginUpdate($hActive)
    _GUICtrlListView_SetItemText($hActive, $aElement[0], $sText, $aElement[1])
    GUICtrlSetState($iInput, $GUI_HIDE)
    $stage = GUICtrlRead($stage_combo)
    IniDelete($path_db, "Printers list " & $stage)
    _save_db()
    _check_db()
    _GUICtrlListView_EndUpdate($hActive)
    Return $sText ; возвращаем текст, если требуется его использовать после применения
EndFunc   ;==>_SaveChange_list
;
;
Func _add_device_dlg($hParent = 0); добавление устройства в список
    ;
    Local $add_device_forms, $iGOEM_Opt
    $iGOEM_Opt = Opt("GUIOnEventMode", 0)
    ;
    $add_device_forms = GUICreate("Добавление нового устройства", 490, 290, -1, -1, -1, -1, $hParent)
    $Group1 = GUICtrlCreateGroup(" Местонахождение оборудования   ", 8, 8, 473, 89)
    $Label1 = GUICtrlCreateLabel("Выберите этаж", 16, 32, 82, 15)
    $stage_combo2 = GUICtrlCreateCombo("", 16, 48, 145, 25, $CBS_DROPDOWNLIST + $WS_VSCROLL)
    $label2 = GUICtrlCreateLabel("Расположение устройства", 176, 32, 140, 15)
    $location_dev_combo = GUICtrlCreateCombo("", 176, 48, 161, 25, $CBS_DROPDOWNLIST + $WS_VSCROLL)
    $label3 = GUICtrlCreateLabel("Номер помещения", 352, 32, 100, 15)
    $room_Input = GUICtrlCreateInput("", 352, 48, 121, 21)
    GUICtrlCreateGroup("", -99, -99, 1, 1)
    ;
    $Group2 = GUICtrlCreateGroup(" Информация об оборудовании ", 8, 112, 473, 137)
    $label4 = GUICtrlCreateLabel("Модель устройства", 16, 136, 93, 15)
    $model_Input = GUICtrlCreateInput("", 16, 152, 209, 21)
    $label5 = GUICtrlCreateLabel("Тип устройства", 256, 136, 119, 15)
    $type_device = GUICtrlCreateCombo("", 256, 152, 217, 25, $CBS_DROPDOWNLIST + $WS_VSCROLL)
    $Label6 = GUICtrlCreateLabel("Тип печати", 72, 184, 66, 15)
    $type_color = GUICtrlCreateCombo("", 72, 200, 153, 25, $CBS_DROPDOWNLIST + $WS_VSCROLL)
    $Label7 = GUICtrlCreateLabel("IP-адрес устройства", 256, 184, 97, 17)
    $device_IP = _GUICtrlIpAddress_Create($add_device_forms, 256, 200, 153, 21)
    _GUICtrlIpAddress_Set($device_IP, "0.0.0.0")
    GUICtrlCreateGroup("", -99, -99, 1, 1)
    ;
    $add_printer_btn = GUICtrlCreateButton("Добавить", 67, 256, 80, 25)
    $exit_dlg_btn = GUICtrlCreateButton("Закрыть", 339, 256, 80, 25)
    ;
    GUISetState(@SW_DISABLE, $hParent)
    GUISetState(@SW_SHOW, $add_device_forms)
    _read_config()
    ;
    ;
    While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $GUI_EVENT_CLOSE
                ExitLoop
                ;
            Case $add_printer_btn
                $stage_add = GUICtrlRead($stage_combo2)
                $location_dev = GUICtrlRead($location_dev_combo)
                $room_add = GUICtrlRead($room_Input)
                $model_add = GUICtrlRead($model_Input)
                $type_dev_add = GUICtrlRead($type_device)
                $type_col_add = GUICtrlRead($type_color)
                $ip_add = _GUICtrlIpAddress_Get($device_IP)
                ;
                If $stage_add <> '' Then
                    If $location_dev <> '' Then
                        If $room_add <> '' Then ;And $location_dev <> 'Корридор' Or $location_dev <> 'Склад' Then
                            If $model_add <> '' Then
                                If $type_dev_add <> '' Then
                                    If $type_col_add <> '' Then
                                        If $ip_add <> '0.0.0.0' Then
                                            SplashTextOn('', "Добавление устройства в базу данных, подождите...", 400, 40, -1, -1, 1, "", 10)
                                            GUICtrlSetData($stage_combo, $stage_add)
                                            _check_db()
                                            GUICtrlCreateListViewItem($type_dev_add & "|" & $model_add & "|" & $type_col_add & "|" & $location_dev & " " & $room_add & "|" & $ip_add, $printers_list_view)
                                            Sleep(500)
                                            SplashOff()
                                            _save_db()
                                            _check_db()
                                            GUICtrlSetData($stage_combo2, '')
                                            GUICtrlSetData($location_dev_combo, '')
                                            GUICtrlSetData($room_Input, '')
                                            GUICtrlSetData($model_Input, '')
                                            GUICtrlSetData($type_device, '')
                                            GUICtrlSetData($type_color, '')
                                            _GUICtrlIpAddress_Set($device_IP, "0.0.0.0")
                                            _read_config()
                                        Else
                                            MsgBox(8208, 'Ошибка', 'Неверный IP-адрес')
                                        EndIf
                                    Else
                                        MsgBox(8208, 'Ошибка', 'Не указан тип печати ')
                                    EndIf
                                Else
                                    MsgBox(8208, 'Ошибка', 'Не выбран тип устройства')
                                EndIf
                            Else
                                MsgBox(8208, 'Ошибка', 'Не указанна модель устройства')
                            EndIf
                        Else
                            MsgBox(8208, 'Ошибка', 'Не указан номер помещения')
                        EndIf
                    Else
                        MsgBox(8208, 'Ошибка', 'Не указано размещение устройства (кабинет/принтерная зона)')
                    EndIf
                Else
                    MsgBox(8208, 'Ошибка', 'Не выбран этаж')
                EndIf
            Case $exit_dlg_btn
                ExitLoop
        EndSwitch
    WEnd
    ;
    Opt("GUIOnEventMode", $iGOEM_Opt)
    GUISetState(@SW_ENABLE, $hParent)
    GUIDelete($add_device_forms)
    WinActivate($hParent)
EndFunc   ;==>_add_device_dlg
;


