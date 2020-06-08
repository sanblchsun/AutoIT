;---------------------------------------------------------------------------------------------
; Пример работы с базой Access 4.0 через функции ODBC API в среде AutoIt3.
; Ведется прямая работа с базой данных, в обход источника данных.
;---------------------------------------------------------------------------------------------
; Language: AutoIt3
; ODBC 3.51 и выше
; Win 98/Me/XP
;---------------------------------------------------------------------------------------------

Global $INSTALLER
Global $MANAGER
;---------------------------------------------------------------------------------------------
Global Const $SQL_SUCCESS= 0
Global Const $SQL_CLOSE    = 0
Global Const $SQL_DROP    = 1
Global Const $SQL_UNBIND    = 2
Global Const $SQL_RESET_PARAMS = 3
Global Const $SQL_ACCESSIBLE_PROCEDURES = 20
Global Const $ODBC_ADD_SYS_DSN = 4
Global Const $SQL_DRIVER_NOPROMPT = 0
Global Const $SQL_C_CHAR    = 1
Global Const $SQL_FETCH_NEXT = 1
Global Const $SQL_NO_DATA_FOUND = 100

;[Тестовая функция демонстрирующая работу с БД]
;----------------------------------------------------------------------------------
Func AccessSample()

$INSTALLER = DllOpen("odbccp32.dll")    ;Открываем библиотеку установщика ODBC
$MANAGER = DllOpen("odbc32.dll")    ;Открываем библиотеку менеджера драйверов ODBC

Dim $InitData[2]
$dir=@ScriptDir

;[Создание файла базы данных в каталоге скрипта]
;----------------------------------------------------------------------------------
$InitData[0]    ="Microsoft Access Driver (*.mdb)"    ;Указатель на драйвер
$InitData[1]    ='CREATE_DB="' & $dir & '\access.mdb"'     ;Указатель на создаваемый файл

$result = DllCall($INSTALLER, _
 "short","SQLConfigDataSource", _
 "hwnd",0, _
 "long",$ODBC_ADD_SYS_DSN, _
 "str",    $InitData[0], _
 "str",    $InitData[1])

Select
 Case $result[0]<>1
MsgBox (262192,"Произошла ошибка", "Произошла ошибка:Создание файла базы. Возможно файл уже существует.")
 Case $result[0]=1
MsgBox (262192,"[Работала API SQLConfigDataSource]", _
          "[Создание файла базы Access]"    & @CR & _
          "[Результат]"    & @CR & $result[0]    & @CR & _
          "[Драйвер]"    & @CR & $InitData[0]    & @CR & _
          "[Строка инициализации]"  & @CR & $InitData[0])
EndSelect

;[Прямое подключение к базе данных]
;----------------------------------------------------------------------------------
;/Генерация дескриптора окружения/

$HANDLE_BUFFER  = DllStructCreate("udword")
$result=DllCall($MANAGER, _
      "short","SQLAllocEnv", _
      "long",DllStructGetPtr($HANDLE_BUFFER))
      ;-----------------------------------------
      If $result[0]<>$SQL_SUCCESS then
        MsgBox (262192,"Произошла ошибка", "Произошла ошибка: дескриптор окружения.")
        return -1
      EndIf
$HANDLE_ENV=DllStructGetData($HANDLE_BUFFER,1)
$HANDLE_BUFFER=0
;---------------------------------------------------------------------------------------------
;/Генерация дескриптора соединения/

$HANDLE_BUFFER  = DllStructCreate("udword")
$result=DllCall($MANAGER, _
      "short","SQLAllocConnect", _
      "long",$HANDLE_ENV, _
      "long",DllStructGetPtr($HANDLE_BUFFER))
      ;-----------------------------------------
      If $result[0]<>$SQL_SUCCESS then
        MsgBox (262192,"Произошла ошибка", "Произошла ошибка: дескриптор соединения.")
        return -1
      EndIf
$HANDLE_CONN=DllStructGetData($HANDLE_BUFFER,1)
$HANDLE_BUFFER=0
;Можно попробовать оставить один буфер на все дескрипторы
;---------------------------------------------------------------------------------------------
;/Строка подключения к драйверу/

$CONNECTION_STRING=  "Driver={Microsoft Access Driver (*.mdb)};" & _  ;Строка драйвера
    "DBQ=" & $dir & "\access.mdb;" & _    ;Путь к файлу базы(этих двух строк достаточно чтобы завести соединение)
    "DefaultDir=C:\TestAccess;" & _    ;Каталог по умолчанию
    "ExtendedAnsiSQL=0;" & _        ;Использовать расширенную грамматику SQL
    "FIL=MS Access;" & _        ;Тип файла источника
    "ImplicitCommitSync=Yes;" & _    ;Параметр ожидания завершения предыдущей внутренней транзакции
    "MaxBufferSize=4096;" & _        ;Размер буфера(kB) кратный 256
    "MaxScanRows=5;" & _        ;Строк сканирования
    "PageTimeout=5;"    & _        ;Время задержки данных в буфере до их сброса в базу(1/10 сек)
    "ReadOnly=0;" & _            ;Режим чтения
    "SafeTransactions=0;" & _        ;Защищенные транзакции
    "Threads=3;" & _            ;Потоков
    "UserCommitSync=Yes"        ;Параметр ожидания завершения предыдущей внешней транзакции
;---------------------------------------------------------------------------------------------
$CONNECTION_STRING_LEN  =StringLen($CONNECTION_STRING)
$SZ_BUFFER_SIZE = 1024    ;Размер буфера строки подключения которую возвращает драйвер(желательно кратно 1024)
$SZ_BUFFER = DllStructCreate("char[" & $SZ_BUFFER_SIZE & "]")
$LENGHT = DllStructCreate("udword")
;---------------------------------------------------------------------------------------------
;/Соединение с базой данных/

$result=DllCall($MANAGER,"short","SQLDriverConnectW", _
    "long",  $HANDLE_CONN, _
    "long",  0, _
    "wstr",  $CONNECTION_STRING, _
    "long",  $CONNECTION_STRING_LEN, _
    "wstr",  DllStructGetPtr($SZ_BUFFER), _
    "long",  $SZ_BUFFER_SIZE, _
    "long",  DllStructGetPtr($LENGHT), _
    "long",   $SQL_DRIVER_NOPROMPT)
    ;-----------------------------------------------------------------------------------------
    Select
    Case $result[0]<>$SQL_SUCCESS
        MsgBox (262192,"Произошла ошибка", "Произошла ошибка: Соединение.")
        return -1
    Case $result[0]=$SQL_SUCCESS
      $Str1=StringReplace($CONNECTION_STRING,";",";" & @CR)
      $Str2=StringReplace($result[5],";",";" & @CR)
        MsgBox (262192,"[Работала API SQLDriverConnectW]", _
          "[Прямое подключение к драйверу]" & @CR & _
          "[Результат]" & @CR & $result[0] & @CR & _
          "[Строка инициализации]" & @CR & $Str1  & @CR & _
          "[Строка подключения сгенерированная драйвером]" & @CR & $Str2 & @CR & _
          "[Дескриптор окружения]" & @CR & $HANDLE_ENV  & @CR & _
          "[Дескриптор соединения]"  & @CR & $HANDLE_CONN)
    EndSelect
    ;-----------------------------------------------------------------------------------------
    $CONNECTION_STRING=$result[5]
    $SZ_BUFFER=0
    $LENGHT=0

;[Функция SQLGetInfo позволяет получать разнообразную информацию ODBC технического плана]
;[Подробнее о запросах и возвращаемых значениях см.справку ODBC]
;---------------------------------------------------------------------------------------------
  $SZ_BUFFER_SIZE  =1024
  $SZ_BUFFER  = DllStructCreate("char[" & $SZ_BUFFER_SIZE & "]")
  $LENGHT    = DllStructCreate("long")
;---------------------------------------------------------------------------------------------
$result=DllCall($MANAGER, _
        "short","SQLGetInfo", _
        "long" ,$HANDLE_CONN, _
        "long" ,$SQL_ACCESSIBLE_PROCEDURES, _
        "long" ,DllStructGetPtr($SZ_BUFFER), _
        "long" ,$SZ_BUFFER_SIZE, _
        "long" ,DllStructGetPtr($LENGHT))
    ;----------------------------------------------------------------------------------------
    Select
    Case $result[0]<>$SQL_SUCCESS
      MsgBox (262192,"Произошла ошибка", "Произошла ошибка: Получение информации.")
    Case $result[0]=$SQL_SUCCESS
    ;----------------------------------------------------------------------------------------
      $DATA=DllStructGetData($SZ_BUFFER,1)
    ;-----------------------------------------------------------------------------------------
      MsgBox (262192,"[Работала API SQLGetInfo]", _
          "[Получение информации]"   & @CR & _
          "[Результат]"    & @CR & $result[0] & @CR & _
          "[Указатель запроса]"  & @CR & $result[2] & @CR & _
          "[Возвращенные данные]"  & @CR & $DATA)
    EndSelect
;---------------------------------------------------------------------------------------------
$HANDLE_STMT=GenerateStmt(0,0,1,$HANDLE_CONN,0)    ;Генерация операторного дескриптора
    If $HANDLE_STMT=-1 then return 0

;[Создание таблиц,добавление и чтение данных]
;---------------------------------------------------------------------------------------------
;/Создание таблицы/

$SQL_COMMAND="CREATE TABLE TESTTABLE(col1 varchar,col2 varchar)"
StaticSQLStatement($SQL_COMMAND,$HANDLE_STMT)
$HANDLE_STMT=GenerateStmt(1,$SQL_RESET_PARAMS,1,$HANDLE_CONN,$HANDLE_STMT)     ;регенерация операторного дескриптора
If $HANDLE_STMT=-1 then return 0
;---------------------------------------------------------------------------------------------
;/Добавление данных/

$SQL_COMMAND="INSERT INTO TESTTABLE VALUES('This Is Access 4.0',' database')"
StaticSQLStatement($SQL_COMMAND,$HANDLE_STMT)
$HANDLE_STMT=GenerateStmt(1,$SQL_RESET_PARAMS,1,$HANDLE_CONN,$HANDLE_STMT)     ;регенерация операторного дескриптора
If $HANDLE_STMT=-1 then return 0
;---------------------------------------------------------------------------------------------
;/Чтение данных/

$SQL_COMMAND="SELECT * FROM TESTTABLE"
StaticSQLStatement($SQL_COMMAND,$HANDLE_STMT)
$ColumnsCount=ColCount($HANDLE_STMT)
$DATA=QuerySQLStatement($ColumnsCount,$HANDLE_STMT)
$DATA=StringReplace($DATA,"^",";" & @CR)
MsgBox (262192,"[Выборка массива данных]","[Возвращенные данные]" & @CR & $DATA)
$HANDLE_STMT=GenerateStmt(1,$SQL_RESET_PARAMS,1,$HANDLE_CONN,$HANDLE_STMT)     ;регенерация операторного дескриптора


;[Освобождение ресурсов]
;---------------------------------------------------------------------------------------------
;/Освобождение операторного дескриптора/

$HANDLE_STMT=GenerateStmt(1,$SQL_DROP,0,0,$HANDLE_STMT)
;------------------------------------------------------------------------
;/Завершение сеанса подключения/

$result=DllCall($MANAGER,"short","SQLDisconnect", _
             "long",$HANDLE_CONN)
;------------------------------------------------------------------------
;/Освобождение дескриптора соединения/

$result=DllCall($MANAGER,"short","SQLFreeConnect", _
       "long",$HANDLE_CONN)
;------------------------------------------------------------------------
;/Освобождение дескриптора окружения/

$result=DllCall($MANAGER,"short","SQLFreeEnv", _
       "long",$HANDLE_ENV)
;---------------------------------------------------------------------------------------------
;Зарытие Dll
DllClose($MANAGER)
DllClose($INSTALLER)

MsgBox (262192,"[Завершено]", _
      "[Демонстрационный скрипт завершен]")
EndFunc

;[Генерация,обновление,освобождение операторного дескриптора]
;---------------------------------------------------------------------------------------------
Func GenerateStmt($Free, _      ;Освобождать операторный дескриптор
                $Method, _    ;Указатель на способ освобождения операторного дескриптора
                $Generate, _    ;Генерировать операторный дескриптор
                $ConnHnd, _    ;Дескриптор соединения
                $StmtHnd)    ;Операторный дескриптор предыдущего состояния.Предусмотрен в параметрах вызова на случай множественных подключений.

;Дескриптор требуется обновлять после каждого запроса
;---------------------------------------------------------------------------------------------
If $Free=True then
;Освобождение операторного дескриптора
$result=DllCall($MANAGER, _
    "short","SQLFreeStmt", _
    "long",$StmtHnd, _
    "long",$SQL_DROP)
EndIf
;---------------------------------------------------------------------------------------------
If $Generate=True then
;Генерация операторного дескриптора
$HANDLE_BUFFER  = DllStructCreate("udword")
$result=DllCall($MANAGER, _
      "short","SQLAllocStmt", _
      "long",$ConnHnd, _
      "long",DllStructGetPtr($HANDLE_BUFFER))
      ;-----------------------------------------
      If $result[0]<>$SQL_SUCCESS then
      MsgBox (16,"Произошла ошибка", "Произошла ошибка: генерация операторного дескриптора.")
        return -1
      EndIf
      ;-----------------------------------------
$HANDLE_STMT=DllStructGetData($HANDLE_BUFFER,1)
$HANDLE_BUFFER=0
return $HANDLE_STMT
EndIf
EndFunc

;[Выполнение статического запроса]
;---------------------------------------------------------------------------------------------
Func StaticSQLStatement($SQL_Command, _  ;Запрос
      $StmtHnd)  ;Операторный дескриптор.Предусмотрен в параметрах вызова на случай множественных подключении

$SQL_COMMAND_LEN=StringLen($SQL_Command)
$result=DllCall($MANAGER,"short","SQLExecDirectW", _
    "long"  ,$StmtHnd, _
    "wstr"  ,$SQL_COMMAND, _
    "long"  ,$SQL_COMMAND_LEN)

    ;-----------------------------------------------------------------------------------------
    Select
    Case $result[0]<>$SQL_SUCCESS
      MsgBox (262192,"Произошла ошибка", "Произошла ошибка: Выполнение статического запроса.")
    Case $result[0]=$SQL_SUCCESS
      MsgBox (262192,"[Работала API SQLExecDirectW]", _
            "[Выполнение статического запроса]" & @CR & _
            "[Результат]"  & @CR & $result[0] & @CR & _
            "[Запрос SQL]"  & @CR & $result[2])
    EndSelect
EndFunc


;[Получение данных набора записей]
;---------------------------------------------------------------------------------------------
Func QuerySQLStatement($ColCount,$StmtHnd)

$SZ_BUFFER_SIZE  = 255
$SZ_BUFFER = DllStructCreate("char[" & $SZ_BUFFER_SIZE & "]")
$LENGHT = DllStructCreate("long")
$D = ""

While 1
;---------------------------------------------------------------------------------------------
;Переход к следующей строке
$result=DllCall($MANAGER,"short","SQLFetchScroll", _
    "long",  $StmtHnd, _
    "short", $SQL_FETCH_NEXT, _
    "int",     0)

If $result[0]=$SQL_NO_DATA_FOUND then ExitLoop
;---------------------------------------------------------------------------------------------
;Получение значений набора записей
$DATA=""
For $i=1 to $ColCount
  $result=DllCall($MANAGER, _
      "short" ,"SQLGetData", _
      "long" ,$StmtHnd, _            ;Операторный дескриптор
      "long" ,$i, _                ;Номер столбца
      "long" ,$SQL_C_CHAR, _            ;Тип выбираемых данных
      "str" ,DllStructGetPtr($SZ_BUFFER), _    ;Указатель буфера данных
      "long" ,$SZ_BUFFER_SIZE, _        ;Предполагаемый размер строки
      "long" ,DllStructGetPtr($LENGHT))        ;Указатель структуры содержащей реальный размер строки

;---------------------------------------------------------------------------------------------
;Обработка пустого набора записей
If DllStructGetData($LENGHT,1)=-1 then return $SQL_NO_DATA_FOUND
;---------------------------------------------------------------------------------------------
;Обработка возможной ошибки
If $result[0]<>$SQL_SUCCESS then
MsgBox (262192,"Произошла ошибка", "Произошла ошибка: Выборка данных.")
EndIf
;---------------------------------------------------------------------------------------------
;Обновление данных структур
  DllStructSetData($LENGHT,1,0)
  DllStructSetData($SZ_BUFFER,1,"")
;------------------------------------------------
  $DATA=$DATA & $result[4]
Next
;---------------------------------------------------------------------------------------------
$D=$D & $DATA & "^"
Wend
  return $D
EndFunc

;[Подсчет столбцов в наборе записей]
;---------------------------------------------------------------------------------------------
Func ColCount($StmtHnd)
$COUNT  = DllStructCreate("udword")
$result=DllCall($MANAGER, _
      "short" ,"SQLNumResultCols", _
      "long"  ,$StmtHnd, _      ;Операторный дескриптор
      "long"   ,DllStructGetPtr($COUNT))
  ;------------------------------------------------------------------------------------------
  ;Обработка возможной ошибки
  If $result[0]<>$SQL_SUCCESS then
  MsgBox (262192,"Произошла ошибка", "Произошла ошибка: Счетчик столбцов.")
  return -1
  EndIf
  ;------------------------------------------------------------------------------------------
$CCOUNT=DllStructGetData($COUNT,1)
MsgBox (262192,"[Работала API SQLNumResultCols]", _
            "[Подсчет количества столбцов]" & @CR & _
            "[Найдено столбцов]: " & $CCOUNT)
$COUNT=0
return $CCOUNT
EndFunc
;---------------------------------------------------------------------------------------------

AccessSample()  ;Вызов примера
;poltergeyst 2006