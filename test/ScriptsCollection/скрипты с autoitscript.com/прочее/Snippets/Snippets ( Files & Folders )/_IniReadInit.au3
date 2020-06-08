; Читает INI и в случае отсутствия значений по умолчанию записывает его.
; Это отличается от стандартное поведения, когда параметры могут отсутствовать.

;===============================================================================
; Description:     Reads values from INI or creates INI with initial values.
;                  Intended to ensure all available INI settings are exposed
;                  and editable.
;                  Parameters are identical to IniRead()
; Parameter(s):    $filename  = filename of INI
;                  $section  = section name of INI
;                  $key      = key name in section
;                  $default  = default value (written to INI if not exists)
; Requirement(s):  None
; Return Value(s): Returns value from INI (or default if not defined)
; Note(s):         Chr(127) used to detect non-existing value since won't normally exist in a text file
;===============================================================================
Func _IniReadInit($filename, $section, $key, $default)
  Local $value = IniRead($filename, $section, $key, Chr(127))
    If $value = Chr(127) Then
      IniWrite($filename, $section, $key, $default)
      $value = $default
    EndIf
    Return $value
EndFunc