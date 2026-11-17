Hice dos intentos que fallaron y en los dos salió `Authentication failed`

| Intento | Mensaje | Usuario | Error | result | App |
|---|---|---|---|---|---|
| Contraseña mal | Failed to authenticate | app_ventas | storedKey mismatch | 18 | mongosh |
| Usuario que no existe | Failed to authenticate | usuario_inexistente | UserNotFound | 11 | mongosh |
| Entró bien | Successfully authenticated | app_ventas | | 0 | app-ventas-web |

¿Qué campo distingue un acceso fallido de uno exitoso?
El mensaje y el `result`, que es 0 cuando entra bien

¿Qué diferencia hay entre el error de contraseña incorrecta y el de usuario inexistente? ¿Por qué el cliente recibe el mismo mensaje en ambos casos?
Con la contraseña mal sale `storedKey mismatch` y con el usuario que no existe sale `UserNotFound`. Al que se conecta le sale lo mismo para que no sepa si el usuario existe o no

¿Por qué el nombre de la aplicación del intento fallido es mongosh y no app-ventas-web?
Porque en esos intentos no se puso el nombre de la app, entonces mongosh pone el suyo
