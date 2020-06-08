#include <Console.au3>

Dim $Color

For $i = 1 to 255
    Cout($i & ' ', $Color & $i)
    Sleep(10)
Next

Sleep(2000)