# Actividad 2 Cifrado de información sensible

¿Qué diferencia existe entre crypt() y pgp_sym_encrypt()?
crypt() saca un hash que no se puede regresar y se usa para contraseñas, pgp_sym_encrypt() cifra el dato con una clave y después se puede descifrar

¿Cuál de los dos mecanismos permite recuperar el dato original?
pgp_sym_encrypt(), usando pgp_sym_decrypt() con la clave

¿Qué ocurre si se utiliza una clave incorrecta?
Sale el error Wrong key or corrupt data y no muestra el RFC

¿Qué problema de seguridad representa colocar la clave directamente en una consulta?
Que cualquiera que vea el script ve la clave y puede descifrar todo, además se puede quedar en el historial o en los logs
