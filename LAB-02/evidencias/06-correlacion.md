En la bitácora salió que el perfilador cambió de nivel 0 a 1, pero no dice quién fue, solo el número de conexión. Busqué esa misma conexión y salió que el que inició sesión fue `admin`

¿Qué usuario cambió la configuración del perfilador? ¿Qué dos eventos lo demuestran?
`admin`. Lo demuestran el cambio del perfilador y el inicio de sesión, porque tienen el mismo número de conexión

¿Qué condición debe cumplirse para que esta correlación sea válida?
Que el servidor no se haya reiniciado en medio, porque al reiniciar los números de conexión empiezan otra vez y podría ser otra persona

¿Por qué es relevante que quede registrado un cambio de configuración del propio mecanismo de registro?
Porque alguien podría apagar el perfilador para hacer algo sin que se note, y así por lo menos queda que lo apagó
