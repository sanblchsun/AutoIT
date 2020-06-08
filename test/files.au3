;---------------------------------------------------------------------------------------------
; ������ ������ � ����� Access 4.0 ����� ������� ODBC API � ����� AutoIt3.
; ������� ������ ������ � ����� ������, � ����� ��������� ������.
;---------------------------------------------------------------------------------------------
; Language: AutoIt3
; ODBC 3.51 � ����
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

;[�������� ������� ��������������� ������ � ��]
;----------------------------------------------------------------------------------
Func AccessSample()

$INSTALLER = DllOpen("odbccp32.dll")    ;��������� ���������� ����������� ODBC
$MANAGER = DllOpen("odbc32.dll")    ;��������� ���������� ��������� ��������� ODBC

Dim $InitData[2]
$dir=@ScriptDir

;[�������� ����� ���� ������ � �������� �������]
;----------------------------------------------------------------------------------
$InitData[0]    ="Microsoft Access Driver (*.mdb)"    ;��������� �� �������
$InitData[1]    ='CREATE_DB="' & $dir & '\access.mdb"'     ;��������� �� ����������� ����

$result = DllCall($INSTALLER, _
 "short","SQLConfigDataSource", _
 "hwnd",0, _
 "long",$ODBC_ADD_SYS_DSN, _
 "str",    $InitData[0], _
 "str",    $InitData[1])

Select
 Case $result[0]<>1
MsgBox (262192,"��������� ������", "��������� ������:�������� ����� ����. �������� ���� ��� ����������.")
 Case $result[0]=1
MsgBox (262192,"[�������� API SQLConfigDataSource]", _
          "[�������� ����� ���� Access]"    & @CR & _
          "[���������]"    & @CR & $result[0]    & @CR & _
          "[�������]"    & @CR & $InitData[0]    & @CR & _
          "[������ �������������]"  & @CR & $InitData[0])
EndSelect

;[������ ����������� � ���� ������]
;----------------------------------------------------------------------------------
;/��������� ����������� ���������/

$HANDLE_BUFFER  = DllStructCreate("udword")
$result=DllCall($MANAGER, _
      "short","SQLAllocEnv", _
      "long",DllStructGetPtr($HANDLE_BUFFER))
      ;-----------------------------------------
      If $result[0]<>$SQL_SUCCESS then
        MsgBox (262192,"��������� ������", "��������� ������: ���������� ���������.")
        return -1
      EndIf
$HANDLE_ENV=DllStructGetData($HANDLE_BUFFER,1)
$HANDLE_BUFFER=0
;---------------------------------------------------------------------------------------------
;/��������� ����������� ����������/

$HANDLE_BUFFER  = DllStructCreate("udword")
$result=DllCall($MANAGER, _
      "short","SQLAllocConnect", _
      "long",$HANDLE_ENV, _
      "long",DllStructGetPtr($HANDLE_BUFFER))
      ;-----------------------------------------
      If $result[0]<>$SQL_SUCCESS then
        MsgBox (262192,"��������� ������", "��������� ������: ���������� ����������.")
        return -1
      EndIf
$HANDLE_CONN=DllStructGetData($HANDLE_BUFFER,1)
$HANDLE_BUFFER=0
;����� ����������� �������� ���� ����� �� ��� �����������
;---------------------------------------------------------------------------------------------
;/������ ����������� � ��������/

$CONNECTION_STRING=  "Driver={Microsoft Access Driver (*.mdb)};" & _  ;������ ��������
    "DBQ=" & $dir & "\access.mdb;" & _    ;���� � ����� ����(���� ���� ����� ���������� ����� ������� ����������)
    "DefaultDir=C:\TestAccess;" & _    ;������� �� ���������
    "ExtendedAnsiSQL=0;" & _        ;������������ ����������� ���������� SQL
    "FIL=MS Access;" & _        ;��� ����� ���������
    "ImplicitCommitSync=Yes;" & _    ;�������� �������� ���������� ���������� ���������� ����������
    "MaxBufferSize=4096;" & _        ;������ ������(kB) ������� 256
    "MaxScanRows=5;" & _        ;����� ������������
    "PageTimeout=5;"    & _        ;����� �������� ������ � ������ �� �� ������ � ����(1/10 ���)
    "ReadOnly=0;" & _            ;����� ������
    "SafeTransactions=0;" & _        ;���������� ����������
    "Threads=3;" & _            ;�������
    "UserCommitSync=Yes"        ;�������� �������� ���������� ���������� ������� ����������
;---------------------------------------------------------------------------------------------
$CONNECTION_STRING_LEN  =StringLen($CONNECTION_STRING)
$SZ_BUFFER_SIZE = 1024    ;������ ������ ������ ����������� ������� ���������� �������(���������� ������ 1024)
$SZ_BUFFER = DllStructCreate("char[" & $SZ_BUFFER_SIZE & "]")
$LENGHT = DllStructCreate("udword")
;---------------------------------------------------------------------------------------------
;/���������� � ����� ������/

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
        MsgBox (262192,"��������� ������", "��������� ������: ����������.")
        return -1
    Case $result[0]=$SQL_SUCCESS
      $Str1=StringReplace($CONNECTION_STRING,";",";" & @CR)
      $Str2=StringReplace($result[5],";",";" & @CR)
        MsgBox (262192,"[�������� API SQLDriverConnectW]", _
          "[������ ����������� � ��������]" & @CR & _
          "[���������]" & @CR & $result[0] & @CR & _
          "[������ �������������]" & @CR & $Str1  & @CR & _
          "[������ ����������� ��������������� ���������]" & @CR & $Str2 & @CR & _
          "[���������� ���������]" & @CR & $HANDLE_ENV  & @CR & _
          "[���������� ����������]"  & @CR & $HANDLE_CONN)
    EndSelect
    ;-----------------------------------------------------------------------------------------
    $CONNECTION_STRING=$result[5]
    $SZ_BUFFER=0
    $LENGHT=0

;[������� SQLGetInfo ��������� �������� ������������� ���������� ODBC ������������ �����]
;[��������� � �������� � ������������ ��������� ��.������� ODBC]
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
      MsgBox (262192,"��������� ������", "��������� ������: ��������� ����������.")
    Case $result[0]=$SQL_SUCCESS
    ;----------------------------------------------------------------------------------------
      $DATA=DllStructGetData($SZ_BUFFER,1)
    ;-----------------------------------------------------------------------------------------
      MsgBox (262192,"[�������� API SQLGetInfo]", _
          "[��������� ����������]"   & @CR & _
          "[���������]"    & @CR & $result[0] & @CR & _
          "[��������� �������]"  & @CR & $result[2] & @CR & _
          "[������������ ������]"  & @CR & $DATA)
    EndSelect
;---------------------------------------------------------------------------------------------
$HANDLE_STMT=GenerateStmt(0,0,1,$HANDLE_CONN,0)    ;��������� ������������ �����������
    If $HANDLE_STMT=-1 then return 0

;[�������� ������,���������� � ������ ������]
;---------------------------------------------------------------------------------------------
;/�������� �������/

$SQL_COMMAND="CREATE TABLE TESTTABLE(col1 varchar,col2 varchar)"
StaticSQLStatement($SQL_COMMAND,$HANDLE_STMT)
$HANDLE_STMT=GenerateStmt(1,$SQL_RESET_PARAMS,1,$HANDLE_CONN,$HANDLE_STMT)     ;����������� ������������ �����������
If $HANDLE_STMT=-1 then return 0
;---------------------------------------------------------------------------------------------
;/���������� ������/

$SQL_COMMAND="INSERT INTO TESTTABLE VALUES('This Is Access 4.0',' database')"
StaticSQLStatement($SQL_COMMAND,$HANDLE_STMT)
$HANDLE_STMT=GenerateStmt(1,$SQL_RESET_PARAMS,1,$HANDLE_CONN,$HANDLE_STMT)     ;����������� ������������ �����������
If $HANDLE_STMT=-1 then return 0
;---------------------------------------------------------------------------------------------
;/������ ������/

$SQL_COMMAND="SELECT * FROM TESTTABLE"
StaticSQLStatement($SQL_COMMAND,$HANDLE_STMT)
$ColumnsCount=ColCount($HANDLE_STMT)
$DATA=QuerySQLStatement($ColumnsCount,$HANDLE_STMT)
$DATA=StringReplace($DATA,"^",";" & @CR)
MsgBox (262192,"[������� ������� ������]","[������������ ������]" & @CR & $DATA)
$HANDLE_STMT=GenerateStmt(1,$SQL_RESET_PARAMS,1,$HANDLE_CONN,$HANDLE_STMT)     ;����������� ������������ �����������


;[������������ ��������]
;---------------------------------------------------------------------------------------------
;/������������ ������������ �����������/

$HANDLE_STMT=GenerateStmt(1,$SQL_DROP,0,0,$HANDLE_STMT)
;------------------------------------------------------------------------
;/���������� ������ �����������/

$result=DllCall($MANAGER,"short","SQLDisconnect", _
             "long",$HANDLE_CONN)
;------------------------------------------------------------------------
;/������������ ����������� ����������/

$result=DllCall($MANAGER,"short","SQLFreeConnect", _
       "long",$HANDLE_CONN)
;------------------------------------------------------------------------
;/������������ ����������� ���������/

$result=DllCall($MANAGER,"short","SQLFreeEnv", _
       "long",$HANDLE_ENV)
;---------------------------------------------------------------------------------------------
;������� Dll
DllClose($MANAGER)
DllClose($INSTALLER)

MsgBox (262192,"[���������]", _
      "[���������������� ������ ��������]")
EndFunc

;[���������,����������,������������ ������������ �����������]
;---------------------------------------------------------------------------------------------
Func GenerateStmt($Free, _      ;����������� ����������� ����������
                $Method, _    ;��������� �� ������ ������������ ������������ �����������
                $Generate, _    ;������������ ����������� ����������
                $ConnHnd, _    ;���������� ����������
                $StmtHnd)    ;����������� ���������� ����������� ���������.������������ � ���������� ������ �� ������ ������������� �����������.

;���������� ��������� ��������� ����� ������� �������
;---------------------------------------------------------------------------------------------
If $Free=True then
;������������ ������������ �����������
$result=DllCall($MANAGER, _
    "short","SQLFreeStmt", _
    "long",$StmtHnd, _
    "long",$SQL_DROP)
EndIf
;---------------------------------------------------------------------------------------------
If $Generate=True then
;��������� ������������ �����������
$HANDLE_BUFFER  = DllStructCreate("udword")
$result=DllCall($MANAGER, _
      "short","SQLAllocStmt", _
      "long",$ConnHnd, _
      "long",DllStructGetPtr($HANDLE_BUFFER))
      ;-----------------------------------------
      If $result[0]<>$SQL_SUCCESS then
      MsgBox (16,"��������� ������", "��������� ������: ��������� ������������ �����������.")
        return -1
      EndIf
      ;-----------------------------------------
$HANDLE_STMT=DllStructGetData($HANDLE_BUFFER,1)
$HANDLE_BUFFER=0
return $HANDLE_STMT
EndIf
EndFunc

;[���������� ������������ �������]
;---------------------------------------------------------------------------------------------
Func StaticSQLStatement($SQL_Command, _  ;������
      $StmtHnd)  ;����������� ����������.������������ � ���������� ������ �� ������ ������������� �����������

$SQL_COMMAND_LEN=StringLen($SQL_Command)
$result=DllCall($MANAGER,"short","SQLExecDirectW", _
    "long"  ,$StmtHnd, _
    "wstr"  ,$SQL_COMMAND, _
    "long"  ,$SQL_COMMAND_LEN)

    ;-----------------------------------------------------------------------------------------
    Select
    Case $result[0]<>$SQL_SUCCESS
      MsgBox (262192,"��������� ������", "��������� ������: ���������� ������������ �������.")
    Case $result[0]=$SQL_SUCCESS
      MsgBox (262192,"[�������� API SQLExecDirectW]", _
            "[���������� ������������ �������]" & @CR & _
            "[���������]"  & @CR & $result[0] & @CR & _
            "[������ SQL]"  & @CR & $result[2])
    EndSelect
EndFunc


;[��������� ������ ������ �������]
;---------------------------------------------------------------------------------------------
Func QuerySQLStatement($ColCount,$StmtHnd)

$SZ_BUFFER_SIZE  = 255
$SZ_BUFFER = DllStructCreate("char[" & $SZ_BUFFER_SIZE & "]")
$LENGHT = DllStructCreate("long")
$D = ""

While 1
;---------------------------------------------------------------------------------------------
;������� � ��������� ������
$result=DllCall($MANAGER,"short","SQLFetchScroll", _
    "long",  $StmtHnd, _
    "short", $SQL_FETCH_NEXT, _
    "int",     0)

If $result[0]=$SQL_NO_DATA_FOUND then ExitLoop
;---------------------------------------------------------------------------------------------
;��������� �������� ������ �������
$DATA=""
For $i=1 to $ColCount
  $result=DllCall($MANAGER, _
      "short" ,"SQLGetData", _
      "long" ,$StmtHnd, _            ;����������� ����������
      "long" ,$i, _                ;����� �������
      "long" ,$SQL_C_CHAR, _            ;��� ���������� ������
      "str" ,DllStructGetPtr($SZ_BUFFER), _    ;��������� ������ ������
      "long" ,$SZ_BUFFER_SIZE, _        ;�������������� ������ ������
      "long" ,DllStructGetPtr($LENGHT))        ;��������� ��������� ���������� �������� ������ ������

;---------------------------------------------------------------------------------------------
;��������� ������� ������ �������
If DllStructGetData($LENGHT,1)=-1 then return $SQL_NO_DATA_FOUND
;---------------------------------------------------------------------------------------------
;��������� ��������� ������
If $result[0]<>$SQL_SUCCESS then
MsgBox (262192,"��������� ������", "��������� ������: ������� ������.")
EndIf
;---------------------------------------------------------------------------------------------
;���������� ������ ��������
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

;[������� �������� � ������ �������]
;---------------------------------------------------------------------------------------------
Func ColCount($StmtHnd)
$COUNT  = DllStructCreate("udword")
$result=DllCall($MANAGER, _
      "short" ,"SQLNumResultCols", _
      "long"  ,$StmtHnd, _      ;����������� ����������
      "long"   ,DllStructGetPtr($COUNT))
  ;------------------------------------------------------------------------------------------
  ;��������� ��������� ������
  If $result[0]<>$SQL_SUCCESS then
  MsgBox (262192,"��������� ������", "��������� ������: ������� ��������.")
  return -1
  EndIf
  ;------------------------------------------------------------------------------------------
$CCOUNT=DllStructGetData($COUNT,1)
MsgBox (262192,"[�������� API SQLNumResultCols]", _
            "[������� ���������� ��������]" & @CR & _
            "[������� ��������]: " & $CCOUNT)
$COUNT=0
return $CCOUNT
EndFunc
;---------------------------------------------------------------------------------------------

AccessSample()  ;����� �������
;poltergeyst 2006