# POL-06 Cambios en producción

Uso la definición de ambiente de la Unidad I: producción es donde están los datos reales y lo usan los usuarios finales. Desarrollo y pruebas no tienen datos reales

| Campo | Contenido |
|---|---|
| Objetivo | Evitar cambios de estructura o de privilegios no autorizados en producción |
| Alcance | Base `comercial` (PostgreSQL y MongoDB), ambiente de producción |
| Regla | Todo cambio en producción necesita una solicitud con folio en `gobierno.solicitudes_cambio`, aprobada por el Comité de cambios, y se ejecuta dentro de su ventana. Cada mes una persona distinta del DBA concilia los `CREATE`, `ALTER`, `DROP`, `GRANT` y `REVOKE` de la bitácora contra las solicitudes |
| Responsable | Decide el Comité de cambios, ejecuta el DBA, concilia auditoría interna |
| Excepciones | Emergencia que detiene la operación. Se hace con aviso al propietario y la solicitud se registra en las 24 horas siguientes |
| Evidencia | `gobierno.solicitudes_cambio` (CAM-2026-014), `E5-bitacora-postgresql.log` con su hash y el acta `evidencias/06-conciliacion.md` |
| Revisión | Anual, o después de detectar un cambio no autorizado |

Limitación: en MongoDB Community los cambios de privilegios no quedan en ninguna bitácora. Ahí la evidencia es comparar instantáneas de privilegios, que muestra qué cambió pero no quién ni cuándo
