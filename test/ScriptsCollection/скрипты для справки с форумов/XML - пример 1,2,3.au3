
; ������� ������ � XML-������ stylers.xml ������ �� ������������ Notepad++. � ����� ���������� �������� ���� ���������� ������ ����������������

#include <Array.au3>
#include <_XMLDomWrapper.au3>

$GroupXML=_XMLFileOpen(@ScriptDir&'\stylers.xml')

; ������ 1, �������� �������� �������� ���������� ����
$aChilds = _XMLGetChildText('NotepadPlus/LexerStyles')
_ArrayDisplay($aChilds, '�������� ����')


; ������ 2, �������� ��������� �������� ��������� ���������� ����
$aRoot = 'NotepadPlus/LexerStyles'
$aChilds = _XMLGetChildText($aRoot)

Dim $aName[1], $aValue[1]

For $i = 1 To UBound($aChilds)-1
    ; $aAttribs = _XMLGetChildNodes($aRoot&'/'&$aChilds[$i])
    $aAttribs = _XMLGetAllAttribIndex($aRoot&'/'&$aChilds[$i], $aName, $aValue, "", $i-1)
    _ArrayDisplay($aAttribs, '�������� ���������')
Next


; ������ 3, �������� ��������� �������� ��������� ���������� ����
$aRoot = 'NotepadPlus/LexerStyles'
$aChilds = _XMLGetChildText('NotepadPlus/LexerStyles')

Dim $aName[1], $aValue[1]

For $i = 1 To UBound($aChilds)-1
    $aAttribs = _XMLGetAllAttribIndex($aRoot&'/'&$aChilds[$i]&'/WordsStyle', $aName, $aValue, "", $i-1)
    _ArrayDisplay($aAttribs, '�������� ���������')
Next

