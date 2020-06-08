AutoItSetOption("TrayIconHide", 1)
MsgBox(4, "", "Не заболела ли мышь")
If @OSType="WIN32_NT" Then BlockInput ( 1 ) ;блокировать мышь и клавиатуру
MouseMove(10, 100, 100)
MouseMove(700, 700, 50)
MouseMove(100, 300)
MouseMove(0, 0, 0)
MouseMove(750, 100, 0)
MouseMove(300, 300, 20)
MouseMove(700, 400, 70)
MouseMove(100, 700, 5)
MouseMove(500, 700, 80)
MouseMove(400, 100, 30)
BlockInput ( 0 ) ;разблокировать мышь и клавиатуру