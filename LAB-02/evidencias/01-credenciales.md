# 01 Credenciales

## Objetivo

Ver por qué no se guardan las contraseñas tal cual y guardarlas con hash

## Comando

`sql/01-credenciales.sql`

## Resultado obtenido

- En usuarios_insegura se ve Password123 tal cual
- Hashes de crypt: (pega aquí los 2)
- Con Password123 salió true y con OtraPassword salió false

## Análisis

¿Qué ocurriría si una persona obtiene acceso de lectura a esta tabla?
Vería las contraseñas y podría entrar como cualquier usuario

¿Son iguales? Si no son iguales, ¿por qué?
No, porque gen_salt() pone una sal diferente cada vez

¿Qué función cumple gen_salt()?
Crea la sal random, con 'bf' usa bcrypt

¿Qué función cumple crypt()?
Saca el hash de la contraseña con la sal y sirve para comprobarla

¿Esto es cifrado reversible?
No, del hash no se saca la contraseña

¿Qué resultado obtuviste con la contraseña correcta?
true

¿Qué resultado obtuviste con la contraseña incorrecta?
false

¿Por qué no es necesario recuperar la contraseña original?
Porque se le saca el hash a lo que escribe el usuario y se compara con el guardado

¿Por qué un hash no debe confundirse con cifrado?
Porque el cifrado se regresa con la clave y el hash no

## Conclusión

Las contraseñas se guardan con hash, nunca tal cual
