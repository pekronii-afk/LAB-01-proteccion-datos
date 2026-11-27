# POL-05 Uso de datos sensibles

| Campo | Contenido |
|---|---|
| Objetivo | Que el RFC, el teléfono y los demás datos personales solo se usen para su finalidad y que quede rastro de quién los lee o los cambia |
| Alcance | Columnas marcadas como dato personal en `03-diccionario.md` y sus copias en auditoría y bitácoras |
| Regla | Las lecturas y cambios de `rfc` y `telefono` se auditan con pgaudit y con el disparador. Las copias de bitácora que salen del servidor van con las contraseñas tapadas y con hash. Solo auditoría interna puede leer la auditoría y las bitácoras |
| Responsable | Decide el propietario (Gerencia Comercial), ejecuta el DBA, revisa auditoría interna |
| Excepciones | Petición de una autoridad, autorizada por jurídico. La entrega queda registrada |
| Evidencia | Líneas `AUDIT` de `E5-bitacora-postgresql.log` (por ejemplo la 326, lectura del RFC del cliente 3), `E3-disparadores.txt`, `E4-muestra-auditoria.txt` y `E5-bitacora-postgresql.sha256` |
| Revisión | Anual |

