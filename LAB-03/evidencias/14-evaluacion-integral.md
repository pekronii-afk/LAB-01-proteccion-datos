# Actividad 14 Escenario integral

| # | Problema | Principio afectado | Riesgo | Control propuesto |
|---|---|---|---|---|
| 1 | Analítica consulta directo la tabla clientes | Mínimo privilegio | Ven datos que no ocupan | Darles una vista |
| 2 | Analítica ve nombre, correo y RFC | Minimización | Exposición de datos | Vista sin esos datos |
| 3 | Solo hacen estadísticas pero tienen datos de cada persona | Finalidad | Usar datos para otra cosa | Darles datos agrupados |
| 4 | Datos guardados desde hace 12 años | Retención | Más datos si hay fuga | Borrar o anonimizar lo viejo |
| 5 | No hay política de retención | Gobierno de datos | Nadie sabe cuándo borrar | Hacer una política |
| 6 | Desarrolladores reciben copias completas | Minimización | Datos reales en equipos sin protección | Datos de prueba |
| 7 | Copias de desarrollo con datos reales | Ciclo de vida | Fuga desde desarrollo | Anonimizar las copias |
| 8 | Marketing usa los correos | Finalidad | Usarlos sin permiso | Pedir consentimiento |
| 9 | No se sabe para qué es cada dato | Gobierno de datos | No se puede justificar | Catálogo de datos |
| 10 | No se sabe quién consulta | Trazabilidad | No saber quién filtró algo | Auditoría |
| 11 | RFC sin proteger | Confidencialidad | Robo de identidad | Cifrar el RFC |
