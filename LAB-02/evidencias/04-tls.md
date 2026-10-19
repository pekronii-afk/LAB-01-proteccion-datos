# Preguntas TLS

¿La conexión actual utiliza TLS?
No, en pg_stat_ssl la columna ssl salió en false y version y cipher salieron vacías

¿Qué versión de TLS se está utilizando?
Ninguna

¿Qué algoritmo de cifrado aparece?
Ninguno, porque la conexión no usa TLS

¿Qué diferencia existe entre una conexión protegida con TLS y una conexión sin TLS?
Sin TLS lo que mandas viaja tal cual por la red y alguien que esté viendo el tráfico podría leer las consultas, los resultados y hasta contraseñas. Con TLS todo va cifrado y se puede comprobar que te estás conectando al servidor correcto
