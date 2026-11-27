# POL-01 Acceso

| Campo | Contenido |
|---|---|
| Objetivo | Evitar que alguien tenga más permisos de los que necesita sobre datos personales |
| Alcance | Base `comercial` en PostgreSQL y MongoDB, ambiente de producción |
| Regla | Todo `GRANT` sobre una tabla o colección con datos personales necesita una solicitud con folio aprobada por el propietario del dato. Cada 3 meses el propietario revisa la lista de privilegios vigentes y firma qué se queda y qué se quita |
| Responsable | Solicita el área usuaria, aprueba el propietario (Gerencia Comercial), ejecuta el DBA |
| Excepciones | Acceso temporal por incidente, aprobado por el propietario, con fecha de vencimiento y retirado en máximo 48 horas |
| Evidencia | `E2-privilegios.txt` (privilegios vigentes), los `GRANT` y `REVOKE` de `E5-bitacora-postgresql.log`, la conciliación de `06-conciliacion.md` y, en MongoDB, las instantáneas de privilegios. El acta de revisión trimestral hoy no existe |
| Revisión | Cada 3 meses |
