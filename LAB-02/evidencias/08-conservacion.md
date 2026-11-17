Después de reiniciar, el perfilador regresó a 0 aunque lo había dejado en 1. Lo que ya estaba guardado siguió ahí, pero la bitácora de `getLog` quedó con menos eventos porque se borró

No cambié el archivo de configuración, nada más lo documenté

Exporté el perfilador a `system-profile.json` y la bitácora a `bitacora-mongod.log`, y saqué el hash de los dos en `hashes.sha256`

Menciona tres formas en que la evidencia del perfilador o de la bitácora puede perderse sin que nadie la borre deliberadamente
- El perfilador solo guarda 1 MB y cuando se llena borra lo más viejo
- Al reiniciar se borra lo de `getLog` y el perfilador se apaga
- Si se borra el contenedor se va todo

¿Por qué el tamaño de 1 MB de system.profile es un problema de conservación y no solo de espacio?
Porque se llena rápido y lo viejo se borra solo sin que nadie se dé cuenta

¿Por qué getLog sirve para interpretar pero no para conservar?
Porque solo guarda los últimos 1024 eventos y se borra al reiniciar
