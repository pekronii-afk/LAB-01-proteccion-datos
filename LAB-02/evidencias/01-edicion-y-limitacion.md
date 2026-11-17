Corrí `db.version()`, `buildInfo` y `serverCmdLineOpts()`. Salió la versión 7.0, `modules` salió vacío y la autorización está activada

¿Qué edición de MongoDB estás usando? ¿Qué evidencia lo demuestra?
La Community, porque `modules` sale vacío y en la Enterprise diría "enterprise"

¿A dónde escribe tu servidor su bitácora? ¿Cómo lo sabes?
A la salida del contenedor, porque en `serverCmdLineOpts()` no sale nada de `systemLog`. Se puede ver con `docker logs` o con `getLog`

Según REF-U3-04, ¿qué cuatro categorías de eventos registraría la auditoría nativa?
- Cambios en la estructura (DDL)
- Cosas de réplicas y clústeres
- Inicios de sesión y permisos
- Lecturas y cambios de datos (CRUD)

¿Qué tendría que evaluar una organización antes de licenciar Enterprise o migrar a Atlas solo para obtener auditoría?
Cuánto cuesta, si de verdad lo necesita, cuánto trabajo es cambiarse y si está bien tener los datos en la nube de otra empresa
