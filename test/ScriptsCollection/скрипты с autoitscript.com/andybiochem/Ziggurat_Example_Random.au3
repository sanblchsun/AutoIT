#include <Array.au3>
#include "Ziggurat.au3"

Global $Array[1001]

For $i = 1 To 1000
    $Array[$i] = _Random_Gaussian_Zig(0, 1)
Next

_ArrayDisplay($Array,"1000 Gaussian Distribution numbers")
 
