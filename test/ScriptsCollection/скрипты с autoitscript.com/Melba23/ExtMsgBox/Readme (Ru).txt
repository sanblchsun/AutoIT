﻿; #FUNCTION# =========================================================================================================
; Имя функции ...: _ExtMsgBox
; Версия AutoIt ..: v3.2.12.1 и выше
; Описание ........: Создает пользовательсое диалоговое окно (MsgBox) в центре родительского окна, в центре экрана или в указанных координатах.
; Синтаксис.......: _ExtMsgBox ($vIcon, $vButton, $sTitle, $sText, [$iTimeout, [$hWin, [$iVPos]]])
; Параметры:
;                   $vIcon		-> Используемая иконка: 0 - без иконки, 8 - UAC или следующие константы $MB_ICON... :
;                                  16 - Стоп, 32 - Вопрос, 48 - Восклицательный знак, 64 - Информация
;                                  Любое другое число возвращает -1, ошибка 1
;                                  Если указано имя exe-файла, то его иконка будет отображаться
;                                  Если указано имя иконки, то эта иконка будет отображаться
;                   $vButton	-> Текст кнопок, разделённый символом "|". Пробел " " - без кнопок
;                                  Амперсанд (&) перед текстом кнопки указывает на кнопку по умолчанию (вызываемая по Enter).
;                                  Два фокусирующих амперсанда (&) возвращает -1, ошибка 2. Только одна кнопка может быть по умолчанию
;                                  Нажатие Enter или Space (пробел) активируют кнопу по умолчанию.
;                                  Можно использовать числовые константы кнопок $MB_... : 0 = "OK", 1 = "&OK|Отмена",
;                                  2 = "&Прервать|Повтор|Пропустить", 3 = "&Да|Нет|Отмена", 4 = "&Да|Нет", 5 = "&Повтор|Отмена",
;                                  6 = "&Отмена|Повторить|Продолжить".  Другие значения возвращают -1, ошибка  3
;                                  По умолчанию максимальная ширина 370 дает 1-4 кнопки шириной 80 или 5 кнопок шириной 60 или 6 кнопок шириной 50
;                                  Минимальная ширина кнопки 50, поэтому установка 7 кнопок возвращает -1, ошибка 4
;                   $sTitle		-> Заголовок окна
;                   $sText		-> Текст окна. Длинные строки переносятся. размер окна подгоняется по заполнению
;                                  Установки максимальной ширины может увеличиться до абсолютного значения, если потребуется
;                   $iTimeout	-> Время ожидания (в секундах), по истечении которого EMB (ExtMsgBox) закроется. 0 = без таймаута (по умолчанию)
;                                 Если нет ни одной из кнопок и не установлен тайм-аут, то время ожидания автоматически устанавливается равным 5
;                   $hWin		-> Дескриптор родительского окна, относительно которого центрируется EMB
;                                 Если окно скрыто или не указан дескриптор, то EMB в центре экрана (по умолчанию)
;                                  Если параметр не является дескриптором окна, то значение интерпретируется как координата левого края EMB
;                   $iVPos      -> Координата верхнего края EMB, только если параметр $hWin интерпретируется iкак координата левого края.  (по умолчанию = 0)
; Возвращаемое значение: Успешно:	Возвращает индекс нажатой кнопки, отсчёт слева, начиная с 1.
;                           Возвращает 0 если закрыто кнопкой "CloseGUI" (то есть нажатием [X] в окне или нажатием клавиши Esc (Escape) на клавиатуре)
;                           Возвращает 9 если выход по таймауту
;                           Если "Не показывать снова" чекбокс отмечен, то возвращается отрицательное значение
;                  Неудачно:	Возвращает -1 и устанавливает @error:
;                               1 - Неверно указана иконка
;                               2 - Попытка установить несколько кнопок по умолчанию
;                               3 - Button constant error
;                               4 - Количество кнопок превышено (более 6-ти), чтобы уместить в GUI
;                               5 - Ошибка StringSize
;                               6 - Ошибка создания GUI
; Автор ...........: Melba23, на основе некоторых оригинальных кодах сделанных photonbuddy & YellowLab
; Примечания ..: Положение EMB автоматически корректируется, чтобы появится полностью видимым на экране
; Пример.........: Есть
;=====================================================================================================================

; #FUNCTION# =========================================================================================================
; Имя функции ...: _ExtMsgBoxSet
; Версия AutoIt ..: v3.2.12.1 и выше
; Описание ........: Устанавливает стили GUI, выравнивание, цвет и шрифт для последующих вызовов функциии _ExtMsgBox
; Синтаксис.......: _ExtMsgBoxSet($iStyle, $iJust, [$iBkCol, [$iCol, [$sFont_Size, [$iFont_Name]]]])
; Параметры:
;                  $iStyle      -> 0 (по умолчанию) - Кнопка на панели задач, стиль "поверх всех окон" (TOPMOST), использование выбранного шрифта для кнопок.
;                                  Это может быть комбинацией следующих изменений:
;                                    1 = Кнопка не появляется на панели задач
;                                    2 = Не устанавливаеть стиль "поверх всех окон" (TOPMOST
;                                    4 = Кнопки используют шрифт по умолчанию
;                   >>>>>>>>>>     Если этот параметр является ключевым словом 'Default', то это сбрасывает ВСЕ параметры в значения по умолчанию <<<<
;                  $iJust       -> 0 = Выравнивание по левому краю (по умолчанию), 1 = по центру , 2 = по правому краю
;                                  + 4 = Единственную кнопку делает в центре.  Примечание: несколько кнопок всегда выравниваются по центру
;                                  (Также могут использоваться $SS_LEFT, $SS_CENTER, $SS_RIGHT)
;                   $iBkCol		-> Цвет фона окна. По умолчанию = системный цвет
;                   $iCol		-> Цвет текста окна. По умолчанию = системный цвет
;                                  Опустив параметры цвета или используя -1, оставляет цвет без изменений
;                                  Установка параметра цвета в ключевое слово Default сбрасывает в системные установки цвета
;                   $iFont_Size -> Размер шрифта в points. По умолчанию = системный размер шрифта
;                   $sFont_Name -> Название шрифта. По умолчанию = системный шрифт
;                                  Опустив параметры шрифта и размер шрифта или используя размер шрифта -1 или название шрифта "", оставляет без изменений
;                                  Установка параметра шрифта в ключевое слово Default сбрасывает в системные установки шрифт и размер
; Возвращаемое значение: Успешно: - Возвращает 1
;                  Неудачно - Возвращает 0 и устанавливает @error равным 1, а в @extended устанавливает порядковый номер параметра вызвавшего сбой
; Remarks .......;
; Author ........: Melba23
; Example........; Есть
;=====================================================================================================================