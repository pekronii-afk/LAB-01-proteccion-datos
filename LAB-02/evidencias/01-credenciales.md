# Actividad 1 Protección de credenciales

¿Qué ocurriría si una persona obtiene acceso de lectura a esta tabla?
Vería las contraseñas tal cual y podría entrar como cualquier usuario, y como mucha gente usa la misma contraseña en todos lados también podría entrar a otras cuentas

## Preguntas 7.3

¿Son iguales? Si no son iguales, ¿por qué?
No, salen diferentes aunque sea la misma contraseña porque gen_salt() le pone una sal random diferente cada vez

¿Qué función cumple gen_salt()?
Crea la sal random, con 'bf' se usa bcrypt

¿Qué función cumple crypt()?
Saca el hash de la contraseña con la sal, y si le pasas el hash que ya está guardado sirve para comprobar si la contraseña está bien

¿Esto es cifrado reversible?
No, del hash no se puede sacar la contraseña

## Preguntas 7.5

¿Qué resultado obtuviste con la contraseña correcta?
true

¿Qué resultado obtuviste con la contraseña incorrecta?
false

¿Por qué no es necesario recuperar la contraseña original?
Porque nada más se le saca el hash a lo que escribe el usuario y se compara con el que está guardado, si son iguales la contraseña está bien

¿Por qué un hash no debe confundirse con cifrado?
Porque el cifrado se puede regresar con la clave y el hash no, es de un solo sentido
