

#include <Crypt.au3>
; Способ создания пароля
; $password='Новый пароль'
; $bEncrypted = Binary(_Crypt_EncryptData($password, $password, $CALG_RC4))
; MsgBox(0, 'Шифрованый пароль', $bEncrypted)
; ClipPut($bEncrypted)

; для программы
$bEncrypted = '0xB6A6144E1441' ; пароль Привет
Do
	$pass=InputBox('Вход', 'Введите пароль', '', '*', 100, 130)
	If @error=1 Then Exit
Until $pass == BinaryToString(_Crypt_DecryptData($bEncrypted, $pass, $CALG_RC4))
MsgBox(0, 'Вход', 'Пароль верный - '&$pass)