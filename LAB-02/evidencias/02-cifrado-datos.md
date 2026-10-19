# 02 Cifrado de datos

## Objetivo

Cifrar el RFC y recuperarlo con la clave

## Comando

`sql/02-cifrado-datos.sql`

## Resultado obtenido

- RFC cifrado: (pega aquí lo que salió)
- Con CLAVE-DE-PRUEBA salió LOPA900101ABC
- Con CLAVE-EQUIVOCADA salió `ERROR: Wrong key or corrupt data`

## Análisis

¿Qué diferencia existe entre crypt() y pgp_sym_encrypt()?
crypt() saca un hash que no se regresa, pgp_sym_encrypt() cifra con una clave y sí se puede descifrar

¿Cuál de los dos mecanismos permite recuperar el dato original?
pgp_sym_encrypt(), con pgp_sym_decrypt() y la clave

¿Qué ocurre si se utiliza una clave incorrecta?
Sale error y no muestra el RFC

¿Qué problema de seguridad representa colocar la clave directamente en una consulta?
Que cualquiera que vea el script tiene la clave, y además se queda en el historial y en los logs

## Conclusión

El cifrado sirve para datos que sí se ocupan recuperar, pero la clave no debe estar a la vista
