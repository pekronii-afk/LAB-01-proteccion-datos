# Pregunta 1

¿Cuáles son los principales riesgos?
- Si alguien saca la tabla de usuarios tiene todas las contraseñas
- Con el RFC pueden hacer fraudes o hacerse pasar por alguien
- Como no se valida el servidor, alguien puede meterse en medio de la conexión y leer o cambiar los datos
- Con las claves en los archivos SQL cualquiera que vea el código puede descifrar todo
- Si se roban un respaldo tienen toda la información sin tener que entrar a la base

## Pregunta 2

¿Qué mecanismo utilizarías para cada elemento?

| Elemento | Mecanismo |
|---|---|
| Nombre | Permisos y enmascaramiento si hace falta |
| Correo | Permisos y enmascaramiento |
| Contraseña | Hash con sal |
| RFC | Cifrado |
| Información financiera | Cifrado y acceso restringido |
| Claves criptográficas | Guardarlas fuera del código en un gestor de secretos |
| Conexiones | TLS con verify-full |
| Respaldos | Respaldos cifrados |

## Pregunta 3

¿Cuál de los problemas consideras más crítico y por qué?
Las contraseñas en texto claro, porque con una sola fuga ya pueden entrar como cualquier usuario y como la gente repite contraseñas el problema se va a otras cuentas fuera de la empresa

## Pregunta 4

¿Tener correctamente configurados los usuarios y permisos elimina estos riesgos?
No, los permisos nada más controlan quién entra a la base. Si se roban un respaldo, leen la red o encuentran la clave en el código, los permisos no sirven de nada
