﻿
RegExp
Утилита для теста регулярных выражений, но не исключает и обработку данных. Имеет несколько библиотек с готовыми регулярными выражениями, для решения некоторых задач парсинга. Утилита представляет собой только оболочку, синтаксический анализ (парсинг) выполняет встроенный в AutoIt3 движок PCRE. Ограничение добавления патернов в библиотеку 99. Для большего количества делаем очередной файл-библиотеку.

 Возможности:

Подсветка синтаксиса рег. выр.
Тест диапазонов
Расширяемые библиотеки
История тестируемых рег. выр.
Расширяемое меню вставки элементов рег. выр. 
Отчёт времени выполнения рег. выр.
Копирование готового кода AutoIt3 с рег. выр.
Настройка цветовой схемы
Справка, вызываемая по клавише F1

Некоторые возможности RegExp может выполнить утилита TextReplace, например в плане пакетной обработки файлов используя регулярные выражения.

Если у вас не отображаются стрелки при использовании групп, то измените в ini-файле размер шрифта на не дробное число 8 или 9 или 10, так как 8.5 приводит к такому вот эффекту. По умолчанию -1 означает системный размер шрифа, который имеет размер 8.5
 
Обновления

1.0.2
Обновлены библиотеки и справка
Шаблон повтора {0,4} раскрашивается полностью

1.0
Добавлено: Раскрывающийся список для вставки элементов регулярного выражения
Изменение: Вместо кнопки "Открыть" раскрывающаяся кнопка выбора библиотеки
Запоминает последнюю открытую библиотеку
Исправлено: Ctrl+A для RichEdit
Исправлено: Очень длинные рег.выр. обрезаются в раскрывающемся списке истории, чтобы левая часть меню не западала за край экрана
Компиляция на AutoIt3 версии 3.3.8.1
Несколько других незначительных улучшений
Исправлена проблема Ctrl+A

0.9.1
Добавлено подсвечивание метасимволов регулярного выражения

Удалена подложка для Drag & Drop, вместо неё задействованы сами элементы
Добавлено возможность установить размер шрифта, рекомендуется 10
Исправлено сброс обрамления при использовании "Вычислить" (ошибка появилась при выпадающем списке)
Добавлена установка цвета в RegExp.ini, удалите ini чтобы обновить
При тесте символов по кнопке T символ NULL теперь тоже подсвечивается при захвате
Добавлено сохранение размера и позиции окна
Добавлены стили уменьшающие мерцание при изменении размеров окна

0.8
При Copy символы " или ' дублируются
Добавлено кэширование регулярного выражения в историю комбобокса при каждом нажатии "Start"
Добавлена кнопка запуска charmap.exe
Поля для вставки текста позволяют вмещать файлы без ограничения в 30 000 символов
Добавлена кнопка "Т" для теста метасимволов захвата или символьных классов

0.7
Добавлено время выполнения операции, со сравнением с предыдущей операцией
Добавлена разметка при выводе групп
Добавлен Library_New - несколько регулярных выражений найденных в интернете
Для полей регулярного выражения и замены добавлен стиль по умолчанию, без него при вставке с буфера текст обрезался, когда превышал длину поля
Добавлена установка фокуса в поле результата после выполнения, чтобы использовать Ctrl+A и Ctrl+C для копирования
Исправил, теперь выделение символа ошибки работает для всех режимов
Исправлен вывод результата при использовании параметре 4 - массив массивов.
Инвертировал галочку отображения номеров групп и теперь она сохраняется в ini

0.6
Добавлен RegExp.ini, содержащий формат строки, где можно поменять $test или апострофы заменить кавычками или добавить пробелы
При ошибке регулярного выражения символ ошибки выделен
Если параметр 0 для StringRegExp, то обрезается, так как по умолчанию.
Горячая клавиша F1 открывает справку
Добавлена горячая клавиша Ctrl+A - "Выделить всё" для 4-х полей
Задействована кнопка "Развернуть на весь экран"
Обновлены 2 регулярных выражения
Добавлен чекбокс "Вычислить" для теста регулярных выражений содержащих макро, например @CRLF
Поправки в справке

0.5
Добавил иконки кнопкам
Добавил при неверном регулярном выражении, возвращение позиции ошибки и символ в этой позиции.
Добавил Library_Text.ini и обучающий Library_Example.ini.
Шаблон почты обновил упрощённым вариантом. Заглавные буквы не убрал, чтоб срабатывал и на неправильно набранные, это ведь поиск а не проверка валидности

0.4
Добавил галочку запрета обновления тестового шаблона
Установлен ограничение на минимальный размера окна.
Открытие справки из окна утилиты
Добавлен Library_AU3.ini
Улучшен диалог "О программе"
 
0.3
Первая скомпилированная версия

Попробуйте стили в RegExp.ini:

RedColor=c53800
TextColor=000000
BkColor=d0c8ac
GuiBkColor=aba48c

или

RedColor=FF8080
TextColor=999999
BkColor=3F3F3F
GuiBkColor=777777

RegExp.dll - нужна только для нескомпилированного скрипта, для отображения иконок.


ссылки по теме:
Web RegExp
http://gskinner.com/RegExr/

Библиотека RegExp
http://regexlib.com/DisplayPatterns.aspx

Библиотека от создателей RegexBuddy
http://www.regular-expressions.info/tutorial.html