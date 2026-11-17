Guardé una foto de los permisos, puse el nivel 2 y le di el rol `dbAdmin` a `app_ventas`

Busqué el cambio en el perfilador y en la bitácora y salió 0 en los dos, o sea no quedó nada

Con la segunda foto se ve que `app_ventas` antes solo tenía `readWrite` y ahora también tiene `dbAdmin`

| Pregunta | ¿La instantánea responde? |
|---|---|
| ¿Cambiaron los privilegios de app_ventas? | Sí |
| ¿Qué rol se agregó? | Sí, dbAdmin |
| ¿Quién lo agregó? | No |
| ¿Cuándo exactamente? | No, solo que fue entre las dos fotos |

Al final le quité el rol y regresé el filtro

¿Por qué un cambio de privilegios es uno de los eventos auditables más importantes?
Porque si alguien se da más permisos puede ver o cambiar lo que quiera

¿Con qué frecuencia tomarías instantáneas? ¿Qué factores influyen?
Una vez al día y antes y después de un mantenimiento. Depende de qué tan seguido se cambian los permisos y qué tan importantes son los datos

¿Quién debería poder escribir en auditoria.instantaneas_privilegios?
Solo una cuenta que sea nada más para eso, no el DBA ni la app

Redacta en tres líneas cómo comunicarías esta limitación a Dirección
MongoDB Community no guarda quién cambia los permisos
Con las fotos de permisos vemos qué cambió, pero no quién ni a qué hora
Para saberlo habría que pagar Enterprise o Atlas
