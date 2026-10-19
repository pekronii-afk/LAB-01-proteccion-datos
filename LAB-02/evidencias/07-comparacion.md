# 07 Comparación

## Objetivo

Ver qué mecanismo va con cada situación

## Resultado obtenido

| Situación | Mecanismo apropiado | ¿Qué protege? |
|---|---|---|
| Contraseña de usuario | Hash con sal (bcrypt o Argon2id) | Que no se sepa la contraseña aunque vean la tabla |
| RFC almacenado en una tabla | Cifrado | El dato guardado |
| Consulta enviada desde un cliente al servidor | TLS | Los datos mientras viajan por la red |
| Respaldo de una base de datos | Cifrar el respaldo | Los datos que están en el archivo del respaldo |
| Clave criptográfica | Gestión de claves | La clave que sirve para descifrar todo |

## Análisis

Las contraseñas van con hash porque no ocupas recuperarlas, nada más comprobarlas. El RFC y los respaldos van cifrados porque esos sí los ocupas recuperar. TLS es para la conexión, no para lo que está guardado

## Conclusión

Cada cosa lleva su propio mecanismo, no hay uno que sirva para todo
