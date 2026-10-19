# 03 Gestión de claves

## Objetivo

Ver el problema de escribir la clave dentro de un script

## Procedimiento

Se hizo el archivo `sql/ejemplo-mala-practica.sql` con esto

```sql
SELECT pgp_sym_decrypt(
    rfc_cifrado,
    'CLAVE-DE-PRUEBA'
)
FROM clientes_protegidos;
```

Después de revisarlo se borró porque no va en la entrega

Antes de subir todo se buscaron secretos con

```bash
grep -RniE 'password|passwd|secret|token|api_key|clave' sql/
```

## Resultado obtenido

```
sql/02-cifrado-datos.sql:13:    pgp_sym_encrypt('LOPA900101ABC', 'CLAVE-DE-PRUEBA')
sql/02-cifrado-datos.sql:24:        'CLAVE-DE-PRUEBA'
sql/02-cifrado-datos.sql:33:        'CLAVE-EQUIVOCADA'
sql/01-credenciales.sql:10:    password VARCHAR(100) NOT NULL
sql/01-credenciales.sql:13:INSERT INTO usuarios_insegura (usuario, password)
sql/01-credenciales.sql:14:VALUES ('juan', 'Password123');
sql/01-credenciales.sql:20:    'Password123',
sql/01-credenciales.sql:25:    'Password123',
sql/01-credenciales.sql:32:    password_hash TEXT NOT NULL
sql/01-credenciales.sql:35:INSERT INTO usuarios_segura (usuario, password_hash)
sql/01-credenciales.sql:38:    crypt('Password123', gen_salt('bf'))
sql/01-credenciales.sql:46:    password_hash = crypt('Password123', password_hash)
sql/01-credenciales.sql:53:    password_hash = crypt('OtraPassword', password_hash)
```

Todo lo que salió son datos de prueba del laboratorio, no hay contraseñas ni claves reales

## Análisis

**¿Qué ocurriría si esta clave fuera una clave utilizada realmente por una organización y el archivo se publicara en un repositorio Git?**
Cualquiera que vea el repositorio podría descifrar todos los RFC, y aunque después borres el archivo la clave se queda en el historial de commits, entonces habría que cambiar la clave y volver a cifrar todo

## Conclusión

Las claves no se escriben en el código ni se suben al repositorio, se tienen que guardar en otro lado
