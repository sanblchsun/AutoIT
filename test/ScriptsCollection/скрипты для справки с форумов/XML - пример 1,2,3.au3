
; Примеры работы с XML-файлом stylers.xml взятым из дистрибутива Notepad++. В файле содержатся цветовые темы синтаксиса языков программирования

#include <Array.au3>
#include <_XMLDomWrapper.au3>

$GroupXML=_XMLFileOpen(@ScriptDir&'\stylers.xml')

; пример 1, получить дочерние элементы указанного пути
$aChilds = _XMLGetChildText('NotepadPlus/LexerStyles')
_ArrayDisplay($aChilds, 'Дочерние пути')


; пример 2, получить параметры дочерних элементов указанного пути
$aRoot = 'NotepadPlus/LexerStyles'
$aChilds = _XMLGetChildText($aRoot)

Dim $aName[1], $aValue[1]

For $i = 1 To UBound($aChilds)-1
    ; $aAttribs = _XMLGetChildNodes($aRoot&'/'&$aChilds[$i])
    $aAttribs = _XMLGetAllAttribIndex($aRoot&'/'&$aChilds[$i], $aName, $aValue, "", $i-1)
    _ArrayDisplay($aAttribs, 'Дочерние параметры')
Next


; пример 3, получить параметры дочерних элементов указанного пути
$aRoot = 'NotepadPlus/LexerStyles'
$aChilds = _XMLGetChildText('NotepadPlus/LexerStyles')

Dim $aName[1], $aValue[1]

For $i = 1 To UBound($aChilds)-1
    $aAttribs = _XMLGetAllAttribIndex($aRoot&'/'&$aChilds[$i]&'/WordsStyle', $aName, $aValue, "", $i-1)
    _ArrayDisplay($aAttribs, 'Дочерние параметры')
Next

