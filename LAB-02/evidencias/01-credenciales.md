# 01 Credenciales

## Objetivo

Ver por qué no se deben guardar las contraseñas tal cual y guardarlas mejor con un hash

## Comando

Script `sql/01-credenciales.sql`

```sql
SELECT *
FROM usuarios_insegura;

SELECT crypt(
    'Password123',
    gen_salt('bf')
);

SELECT
    usuario,
    password_hash = crypt('Password123', password_hash)
        AS contraseña_correcta
FROM usuarios_segura
WHERE usuario = 'juan';
```

## Resultado obtenido

Tabla insegura

```
 id | usuario |  password
----+---------+-------------
  1 | juan    | Password123
```

Hash sacado 2 veces con la misma contraseña

```
(pega aquí los 2 resultados de crypt)
```

Tabla segura

```
(pega aquí el resultado de SELECT * FROM usuarios_segura)
```

Verificación

- Con `Password123` salió `true`
- Con `OtraPassword` salió `false`

## Análisis

**¿Qué ocurriría si una persona obtiene acceso de lectura a esta tabla?**
Vería las contraseñas tal cual y podría entrar con la cuenta de quien sea, y como mucha gente usa la misma contraseña en todos lados también podría meterse a otras cuentas

**¿Son iguales?**
No, salen diferentes aunque sea la misma contraseña

**Si no son iguales, ¿por qué?**
Porque gen_salt() le pone una sal random diferente cada vez

**¿Qué función cumple gen_salt()?**
Crea la sal random, con 'bf' se usa bcrypt

**¿Qué función cumple crypt()?**
Saca el hash de la contraseña con la sal, y si le pasas el hash que ya tienes guardado sirve para comprobar si la contraseña está bien

**¿Esto es cifrado reversible?**
No, del hash no se puede sacar la contraseña

**¿Qué resultado obtuviste con la contraseña correcta?**
true

**¿Qué resultado obtuviste con la contraseña incorrecta?**
false

**¿Por qué no es necesario recuperar la contraseña original?**
Porque nada más le sacas el hash a lo que escribe el usuario y lo comparas con el que tienes guardado, si son iguales la contraseña está bien

**¿Por qué un hash no debe confundirse con cifrado?**
Porque el cifrado se puede regresar con la clave y el hash no, es de un solo sentido

## Conclusión

Las contraseñas nunca se guardan tal cual, se guarda el hash y así aunque alguien vea la tabla no sabe cuál es la contraseña
