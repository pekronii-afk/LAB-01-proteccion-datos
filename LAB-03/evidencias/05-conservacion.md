# Conservación de bitácoras


| Registro | Ubicación actual | Riesgo de pérdida observado | Sensibilidad | Periodo propuesto | Justificación | Dónde se conserva | Quién puede leerlo | Acción al vencer |
|---|---|---|---|---|---|---|---|---|
| Accesos de PostgreSQL | Archivos `log/` dentro del volumen del contenedor | Cada reinicio abre un archivo nuevo (E5 junta 4 archivos) y si se borra el volumen se pierde todo | Media (usuarios, IP) | 1 año | Alcanza para investigar accesos raros en revisiones anuales | Copia exportada con hash fuera del servidor | Auditoría interna, DBA | Borrar la copia y dejar acta |
| Cambios de privilegios y estructura | Misma bitácora (`GRANT`, `ALTER`) | Igual que arriba, y lo que pasó con `log_statement = none` no existe | Alta | Mientras exista la base + plazo a confirmar con el área jurídica | Hace falta para conciliar contra POL-06 y saber quién tenía acceso en una fecha | Copia con hash y separada de las consultas comunes | Auditoría interna | Revisar con jurídico antes de borrar |
| Modificaciones de datos (`mod`) | Misma bitácora | Puede traer datos personales en el texto de la sentencia | Alta | 1 año | Hace falta para reconstruir incidentes como el del RFC | Copia redactada con hash | Auditoría interna | Borrar la copia y dejar acta |
| `auditoria.cambios_clientes` | Tabla dentro de la misma base | Si alguien deshabilita el disparador ya no se llena, y vive en el mismo servidor que audita | Alta (valores antes y después) | Plazo a confirmar con el área jurídica (por ser datos personales y fiscales) | Choca con eliminar datos personales: no se puede borrar al cliente y dejar su RFC en la auditoría para siempre | La tabla, más un respaldo aparte | Auditoría interna | Anonimizar los valores personales y dejar solo los metadatos |
| Bitácora de `mongod` | Memoria (`getLog`, solo los últimos 1024 eventos) | Se pierde al reiniciar o cuando se llena | Media | 1 año en archivo | Es lo único que dice quién entró a MongoDB | Archivo exportado con hash (`E6-mongodb/`) | Auditoría interna, DBA | Borrar el archivo y dejar acta |
| `system.profile` | Colección circular de 1 MB | Se sobrescribe sola y el nivel vuelve a 0 al reiniciar | Alta (guarda los comandos con datos) | 6 meses en archivo | Sirve para investigar, pero guarda los datos completos | Exportación JSON con hash | Auditoría interna | Borrar la exportación |
| Instantáneas de privilegios (MongoDB) | Colección `auditoria.instantaneas_privilegios`, se toman a mano | Si nadie las toma no existen | Media | Mientras exista la base | Es el único control para cambios de privilegios en Community | La colección y una copia exportada | Auditoría interna | Conservar la última y revisar las demás |

1. ¿Por qué la bitácora de privilegios merece más conservación que las consultas rutinarias?

Porque un permiso dado de más puede usarse meses después, y para investigarlo hay que saber desde cuándo lo tenía y quién se lo dio. Las consultas rutinarias pierden valor rápido y además traen datos personales, entonces conviene guardarlas menos tiempo

2. ¿Qué control de integridad aplicarás a las bitácoras exportadas?

Un SHA-256 de cada archivo, guardado aparte del archivo. Por ejemplo `E5-bitacora-postgresql.sha256` y `E6-mongodb/hashes.sha256`. Si alguien cambia una sola línea, el hash ya no coincide. También se exportan con las contraseñas tapadas

3. ¿Qué diferencia hay entre conservar una bitácora y respaldar una base de datos?

El respaldo es para volver a dejar los datos como estaban. La bitácora es para saber qué pasó, quién lo hizo y cuándo. Un respaldo no te dice quién cambió el RFC, y una bitácora no sirve para restaurar la tabla
