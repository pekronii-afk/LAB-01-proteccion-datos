# Informe LAB-02 Trazabilidad en MongoDB Community

20321619_joel_cuadras

## 1. Despliegue, edición y limitación

Usé MongoDB 7 Community en Docker con la autorización activada. Comprobé que es Community porque `modules` sale vacío. Esta versión no tiene auditoría, eso solo viene en Enterprise y Atlas

## 2. Perfilador

Lo activé en la base `comercial`. En nivel 2 guardó todo, hasta las búsquedas, con usuario, IP, app y hora. Luego lo puse en nivel 1 para que solo guarde cambios. El perfilador es para ver qué tan rápido va el servidor, no para auditar, porque lo hace más lento, solo guarda 1 MB y no guarda el valor de antes

## 3. Bitácora de mongod

Sale en el contenedor y la leí con `getLog`. Ahí salieron los inicios de sesión buenos y malos y el cambio del perfilador. Ese cambio no dice quién lo hizo, pero buscando la misma conexión salió que fue `admin`

## 4. Privilegios

Cuando le di `dbAdmin` a la app no quedó nada ni en el perfilador ni en la bitácora. Con las fotos de permisos se ve que cambió, pero no quién lo hizo ni cuándo. Eso no es auditoría, solo ayuda un poco

## 5. Conservación

Al reiniciar se apagó el perfilador y se borró lo de `getLog`, y el perfilador además borra lo viejo cuando se llena. Por eso exporté todo a archivos y les saqué el hash

## 6. Comparación

PostgreSQL con bitácora y disparador fue el que más guardó, hasta el valor de antes. MongoDB Community guarda los inicios de sesión y las operaciones, pero no los cambios de permisos ni el valor de antes. Enterprise y Atlas guardarían más, pero eso solo lo vi en la documentación

## 7. Recomendación

Si una empresa necesita saber quién cambia los permisos en MongoDB, le diría que use Enterprise o Atlas, porque ya vi que Community no lo guarda. Mientras, que tome fotos de permisos seguido, guarde la bitácora fuera del servidor y que haya pocos administradores. Si vale la pena pagar Enterprise depende de qué tan importantes sean sus datos

## Preguntas de reflexión

1. ¿Por qué el perfilador no debe presentarse como un mecanismo de auditoría de seguridad?
Porque es para ver el rendimiento, se puede apagar, se borra solo y no guarda los cambios de permisos

2. ¿Por qué el perfilador sí aporta trazabilidad aunque no sea auditoría?
Porque dice qué se hizo, quién, desde dónde y a qué hora

3. ¿Qué riesgo introduce el nivel 2 al registrar filtros de consultas que pueden contener datos personales?
Que el perfilador termina guardando datos personales y también hay que cuidarlo

4. ¿Qué diferencia hay entre detectar un cambio y atribuirlo a alguien?
Detectar es saber que algo cambió y atribuir es saber quién lo hizo

5. ¿Por qué reconocer una limitación técnica es parte del trabajo profesional del DBA?
Porque si dices que todo se guarda y no es cierto, la empresa se confía y toma malas decisiones
