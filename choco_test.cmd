
PAUSE

FOR /F "tokens=3 delims= " %%G in ('reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage') DO (
IF [%%G] EQU [0409] (
  ECHO English install language detected
) ELSE (
  ECHO Some other language detected
)


PAUSE