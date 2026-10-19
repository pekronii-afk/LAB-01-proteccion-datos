# Tabla de comparación

| Situación | Mecanismo apropiado | ¿Qué protege? |
|---|---|---|
| Contraseña de usuario | Hash con sal | Que no se sepa la contraseña aunque vean la tabla |
| RFC almacenado en una tabla | Cifrado | El dato guardado |
| Consulta enviada desde un cliente al servidor | TLS | Los datos mientras viajan por la red |
| Respaldo de una base de datos | Cifrar el respaldo | Los datos que están en el archivo del respaldo |
| Clave criptográfica | Gestión de claves | La clave que sirve para descifrar todo |
