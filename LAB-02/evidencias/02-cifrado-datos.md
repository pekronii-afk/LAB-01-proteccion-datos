# 02 Cifrado de datos

## Objetivo

Cifrar el RFC con pgp_sym_encrypt() y después recuperarlo con pgp_sym_decrypt()

## Comando

Script `sql/02-cifrado-datos.sql`

```sql
INSERT INTO clientes_protegidos (
    nombre,
    rfc_cifrado
)
VALUES (
    'Ana López',
    pgp_sym_encrypt('LOPA900101ABC', 'CLAVE-DE-PRUEBA')
);

SELECT *
FROM clientes_protegidos;

SELECT
    id,
    nombre,
    pgp_sym_decrypt(
        rfc_cifrado,
        'CLAVE-DE-PRUEBA'
    ) AS rfc
FROM clientes_protegidos;
```

La clave CLAVE-DE-PRUEBA es nada más de prueba

## Resultado obtenido

RFC cifrado

```
(pega aquí el resultado de SELECT * FROM clientes_protegidos)
```

RFC descifrado con la clave correcta

```
 id |  nombre   |      rfc
----+-----------+---------------
  1 | Ana López | LOPA900101ABC
```

Con la clave equivocada

```
ERROR:  Wrong key or corrupt data
```

## Análisis

**¿Qué diferencia existe entre crypt() y pgp_sym_encrypt()?**
crypt() saca un hash que no se puede regresar y se usa para contraseñas, pgp_sym_encrypt() cifra el dato con una clave y después lo puedes descifrar

**¿Cuál de los dos mecanismos permite recuperar el dato original?**
pgp_sym_encrypt(), usando pgp_sym_decrypt() con la clave

**¿Qué ocurre si se utiliza una clave incorrecta?**
Sale error y no te muestra el RFC

**¿Qué problema de seguridad representa colocar la clave directamente en una consulta?**
Que cualquiera que vea el script ve la clave y puede descifrar todo, además se puede quedar en el historial o en los logs

## Conclusión

El cifrado sirve para datos que sí ocupas recuperar como el RFC, pero de nada sirve si la clave está a la vista
