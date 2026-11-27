# POL-03 Retención

| Campo | Contenido |
|---|---|
| Objetivo | No guardar datos personales ni registros más tiempo del necesario, pero tampoco borrarlos antes de que se puedan investigar |
| Alcance | Datos de clientes, `auditoria.cambios_clientes`, bitácoras de PostgreSQL y MongoDB, `system.profile` e instantáneas de privilegios |
| Regla | Cada registro se conserva el periodo que marca `evidencias/05-conservacion.md`. Nada de auditoría se borra mientras haya una investigación abierta (POL-05). Al vencer se borra o se anonimiza y queda un acta |
| Responsable | Decide el propietario de cada registro (ver `02-responsables.md`), ejecuta el DBA, revisa jurídico los plazos marcados "a confirmar" |
| Excepciones | Investigación abierta o petición de jurídico. En ese caso el registro se congela hasta que se cierre |
| Evidencia | Tabla de `05-conservacion.md` y acta de borrado o anonimización. El acta hoy no existe |
| Revisión | Anual, o cuando jurídico confirme los plazos pendientes |
