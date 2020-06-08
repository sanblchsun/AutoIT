:: http://blogs.msdn.com/b/jerrydixon/archive/2007/09/20/alternate-data-streams.aspx?Redirected=true
:: Пример создания 2-х альтернативных потоков
echo Jerry > names.txt
echo Tammy > names.txt:wife
echo Evan > names.txt:son

more < names.txt
more < names.txt:wife
more < names.txt:son
pause