Puse el nivel 2. El primer resultado salió `was: 0` porque muestra el nivel que había antes, y al revisarlo otra vez ya salió `was: 2`

| # | op | Usuario | Cliente | Aplicación | Momento | Qué hizo | Documentos afectados |
|---|---|---|---|---|---|---|---|
| 1 | query | app_ventas@comercial | 127.0.0.1 | app-ventas-web | El `ts` que salió | Buscó los clientes de Culiacán | Revisó 5 y regresó 3 |
| 2 | update | app_ventas@comercial | 127.0.0.1 | app-ventas-web | Unos milisegundos después | Cambió el RFC del cliente 3 | 1 modificado |
| 3 | remove | app_ventas@comercial | 127.0.0.1 | app-ventas-web | Unos milisegundos después | Borró el cliente 2 | 1 borrado |

¿Puedes saber cuál era el RFC antes del cambio con la información de system.profile?
No, solo sale el RFC nuevo

¿Puedes saber qué datos tenía el documento eliminado?
No, solo sale que se borró el cliente 2

A diferencia de log_statement = 'mod' en PostgreSQL, el nivel 2 sí registró la consulta. ¿Qué ventaja y qué riesgo tiene eso?
La ventaja es que se sabe quién vio los datos. El riesgo es que guarda todo, se llena rápido, hace más lento el servidor y puede guardar datos personales

¿Por qué el campo user incluye @comercial?
Porque el usuario se creó en la base `comercial` y así se sabe de qué base es
