

#include <Crypt.au3>
; ������ �������� ������
; $password='����� ������'
; $bEncrypted = Binary(_Crypt_EncryptData($password, $password, $CALG_RC4))
; MsgBox(0, '���������� ������', $bEncrypted)
; ClipPut($bEncrypted)

; ��� ���������
$bEncrypted = '0xB6A6144E1441' ; ������ ������
Do
	$pass=InputBox('����', '������� ������', '', '*', 100, 130)
	If @error=1 Then Exit
Until $pass == BinaryToString(_Crypt_DecryptData($bEncrypted, $pass, $CALG_RC4))
MsgBox(0, '����', '������ ������ - '&$pass)