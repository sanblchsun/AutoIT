$oMyError = ObjEvent("AutoIt.Error","MyErrFunc")
#cs
вставляем после этих коментов код, содержащий типа $Obj1.Load('...'), который вызывает критическую ошибку
теперь он будет выдавать информации об ошибке и не вылетать.
#ce



;This is COM error handler
Func MyErrFunc()
  $HexNumber=hex($oMyError.number,8)
  Msgbox(0,"COM Error Test","We intercepted a COM Error !"       & @CRLF  & @CRLF & _
             "err.description is: "    & @TAB & $oMyError.description    & @CRLF & _
             "err.windescription:"     & @TAB & $oMyError.windescription & @CRLF & _
             "err.number is: "         & @TAB & $HexNumber              & @CRLF & _
             "err.lastdllerror is: "   & @TAB & $oMyError.lastdllerror   & @CRLF & _
             "err.scriptline is: "     & @TAB & $oMyError.scriptline     & @CRLF & _
             "err.source is: "         & @TAB & $oMyError.source         & @CRLF & _
             "err.helpfile is: "       & @TAB & $oMyError.helpfile       & @CRLF & _
             "err.helpcontext is: "    & @TAB & $oMyError.helpcontext _
            )
  SetError(1)  ; to check for after this function returns
Endfunc
