El perfilador estaba apagado (`was: 0`). La app cambió el RFC del cliente 3 y salió que sí se modificó

Al buscar en el perfilador salió 0 y al buscar el RFC nuevo en la bitácora también salió 0. Lo único que salió de `app-ventas-web` fue que se conectó y que inició sesión

¿Puedes demostrar qué cambió? ¿Y quién se conectó a esa hora?
No se puede saber qué cambió porque no quedó nada de la operación. Solo se sabe que `app_ventas` se conectó desde 127.0.0.1 con la app `app-ventas-web` a esa hora

¿Por qué mongosh abre varias conexiones (conn8, conn9, …) para una sola instrucción? ¿Cuál es la que se autentica?
Porque una conexión es para revisar el servidor y otra para hacer la instrucción. La que inicia sesión es la que sale con `Successfully authenticated`
