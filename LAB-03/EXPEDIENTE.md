# Expediente de auditoría interna, base `comercial`

Organización: Comercializadora Norte S.A. de C.V. (ficticia)
Elaboró: Cuadras Renteria Joel, 20321619, grupo 4-1
Fecha: 2026-11-26
Gestores: PostgreSQL 16.16 y MongoDB 7 Community, en contenedores de Docker

## 1. Alcance

Revisé la base `comercial` en PostgreSQL (`public.clientes`, `auditoria.cambios_clientes`, `gobierno.solicitudes_cambio` y la bitácora del servidor) y en MongoDB (`comercial.clientes` y `comercial.system.profile`). El periodo va del 2026-11-17 al 2026-11-27 (UTC), que es lo que cubren las bitácoras que conservo. Todo es un ambiente de laboratorio con datos ficticios

Queda fuera: respaldos y restauración (Unidad V), la auditoría nativa de MongoDB Enterprise (no la tengo) y todo lo que pasó antes de que se activara el registro

## 2. Configuración de auditoría (E1, E3, E6)

| Mecanismo | Gestor | Configuración vigente | Evidencia |
|---|---|---|---|
| Bitácora del servidor | PostgreSQL | `logging_collector = on`, `log_connections = on`, `log_disconnections = on`, `log_statement = mod`, `log_line_prefix = %m [%p] user=%u db=%d app=%a client=%h` | `evidencias/E1-configuracion-registro.txt` |
| Tabla de auditoría con disparador | PostgreSQL | `trg_auditoria_clientes` sobre `clientes`, habilitado (`tgenabled = O`) | `evidencias/E3-disparadores.txt` |
| pgaudit | PostgreSQL | `pgaudit.log = role, ddl` y `pgaudit.role = auditor_datos` (vigila `rfc` y `telefono`) | `E5-bitacora-postgresql.log`, líneas 280 a 286 |
| Perfilador | MongoDB | Se usó nivel 2 y luego nivel 1 con filtro `insert, remove, update`. No es persistente, vuelve a 0 al reiniciar | `E6-mongodb/bitacora-mongod.log`, líneas 245, 383, 439, 1689 y 1869 |
| Bitácora de `mongod` | MongoDB | `getLog` en memoria, últimos 1024 eventos, exportada a archivo | `E6-mongodb/bitacora-mongod.log` |

## 3. Bitácora interpretada

Todas las líneas son de `evidencias/E5-bitacora-postgresql.log` y las horas están en UTC

| # | Línea (resumida, sin secretos) | Tipo | Quién · cuándo · desde dónde | Prueba | No prueba |
|---|---|---|---|---|---|
| 1 | 42: `GRANT UPDATE ON clientes TO app_ventas` | Cambio de privilegios | `postgres` · 2026-11-18 06:30:06 · socket local (psql) | Que la cuenta `postgres` le dio UPDATE a la aplicación | Quién estaba detrás de la cuenta `postgres` ni si alguien lo autorizó (no hay folio) |
| 2 | 326: `AUDIT: OBJECT,...,READ,SELECT,...,"SELECT nombre, rfc FROM clientes WHERE id = 3"` | Lectura de dato sensible | `app_ventas` · 2026-11-18 06:35:00 · 127.0.0.1, app `app-ventas-web` | Que la cuenta de la aplicación leyó el RFC del cliente 3 (María García) | Qué persona usaba la aplicación, el valor que se leyó (`<not logged>`) ni para qué. El nombre de la app lo pone el propio cliente |
| 3 | 340 y 341: `UPDATE clientes SET rfc = ... WHERE id = 1` | Modificación de datos | `app_ventas` · 2026-11-18 06:35:00 · 127.0.0.1 | Que se cambió el RFC del cliente 1. Con el evento 1 de `E4-muestra-auditoria.txt` también se tiene el valor de antes y después | El motivo del cambio ni si el propietario lo pidió |
| 4 | 945: `ERROR: column "edad" of relation "clientes" does not exist` | Error | `postgres` · 2026-11-27 03:44:41 · socket local | Que hubo un intento de INSERT que falló y no cambió nada | Que alguien quisiera hacer daño. Fue el script de la guía, que no coincide con la tabla |
| 5 | 1088: `ALTER TABLE clientes ADD COLUMN canal_alta VARCHAR(20)` | Cambio de estructura | `postgres` · 2026-11-27 03:46:37 · socket local | Que el cambio se hizo y, junto con `gobierno.solicitudes_cambio`, que fue dentro de la ventana de CAM-2026-014 | Que la aprobación del comité sea real. El registro lo escribe el mismo DBA |

Cronología del incidente del RFC de María García (id = 3):

| # | Hora (UTC) | Usuario | Cliente | Tipo | Qué ocurrió | Fuente |
|---|---|---|---|---|---|---|
| — | Sin registro | — | — | Datos | Primer cambio del RFC: no hay evidencia, el registro estaba apagado | — |
| 1 | 2026-11-18 06:30:04 | — | — | Configuración | `log_statement` pasa de `none` a `ddl`. Desde aquí hay registro | E5, línea 25 |
| 2 | 2026-11-18 06:30:06 | — | — | Configuración | `log_statement` pasa a `mod` | E5, línea 49 |
| 3 | 2026-11-18 06:35:00 | app_ventas | 127.0.0.1 | Lectura | La aplicación lee el nombre y el RFC del cliente 3. Solo lo detecta pgaudit, ni `mod` ni el disparador registran lecturas | E5, línea 326 |
| 4 | 2026-11-27 03:46:37 | — | — | Revisión | `auditoria.cambios_clientes` no tiene ningún evento del cliente 3 | `E4-muestra-auditoria.txt` |

Conclusión: sobre el cambio original del RFC de María García no se puede saber quién lo hizo ni cuándo. Lo único registrado después es una lectura de su RFC por parte de la aplicación

## 4. Elementos de gobierno

- Propietario del dato de clientes: Gerencia Comercial. Custodio: DBA. Usuarios: `app_ventas` y `soporte_ana` (`evidencias/02-responsables.md`, `E2-privilegios.txt`)
- Catálogo: CAT-01 a CAT-05, de los dos motores (`evidencias/04-catalogo.md`)
- Diccionario: comentarios en la tabla y en sus columnas, más `diccionario-clientes.csv` y su versión completa en `evidencias/03-diccionario.md`. Para MongoDB hoy no existe

## 5. Conservación

El detalle de los siete tipos de registro está en `evidencias/05-conservacion.md`. Resumen:

| Registro | Periodo propuesto | Justificación | Dónde se conserva | Al vencer |
|---|---|---|---|---|
| Accesos de PostgreSQL | 1 año | Investigar accesos en revisiones anuales | Copia con hash fuera del servidor | Borrar con acta |
| Privilegios y estructura | Mientras exista la base + plazo a confirmar con el área jurídica | Hace falta para conciliar | Copia con hash | Revisar con jurídico |
| Modificaciones (`mod`) | 1 año | Reconstruir incidentes | Copia redactada | Borrar con acta |
| `auditoria.cambios_clientes` | Plazo a confirmar con el área jurídica | Choca con el borrado de datos personales | Tabla + respaldo | Anonimizar |
| Bitácora de `mongod` | 1 año en archivo | Única fuente de accesos en MongoDB | Archivo con hash | Borrar con acta |
| `system.profile` | 6 meses en archivo | Guarda datos completos | Exportación con hash | Borrar |
| Instantáneas de privilegios | Mientras exista la base | Único control de privilegios en Community | Colección + copia | Conservar la última |

## 6. Políticas (POL-01 a POL-06)

| Política | Regla en corto | Evidencia |
|---|---|---|
| POL-01 Acceso | `GRANT` con folio del propietario y revisión cada 3 meses | `E2-privilegios.txt`, `06-conciliacion.md`. El acta trimestral hoy no existe |
| POL-02 Respaldo | Respaldo diario fuera del servidor con hash | Hoy no existe |
| POL-03 Retención | Periodos de `05-conservacion.md`, sin borrar si hay investigación abierta | `05-conservacion.md`. El acta de borrado hoy no existe |
| POL-04 Restauración | Restaurar solo con autorización y probar cada 3 meses | Hoy no existe |
| POL-05 Datos sensibles | Lecturas y cambios de `rfc` y `telefono` auditados, copias redactadas con hash | E3, E4, E5 (línea 326) y su `.sha256` |
| POL-06 Cambios en producción | Folio aprobado, ventana y conciliación mensual por alguien distinto del DBA | `gobierno.solicitudes_cambio`, `06-conciliacion.md` |

Los archivos están en `politicas/`

## 7. Conciliación de cambios

Detalle en `evidencias/06-conciliacion.md`. De todos los cambios de estructura y privilegios de la bitácora, solo `ADD COLUMN canal_alta` (línea 1088) tiene folio (CAM-2026-014) y se hizo dentro de la ventana. Sin folio quedan: `GRANT UPDATE` a `app_ventas` (línea 42), `ADD COLUMN segmento` (línea 43), `GRANT SELECT` a `soporte_ana` (línea 350) y los cambios de preparación del curso. Lo que pasó antes de la línea 25 no se puede conciliar

## 8. Hallazgos

| ID | Hallazgo | Fuente | Severidad | Impacto | Recomendación | Decisión requerida de |
|---|---|---|---|---|---|---|
| H-01 | Correo duplicado entre los clientes 1 y 7 | `01-calidad.md` (C1) | Media | Dos registros de la misma persona, notificaciones dobles | Confirmar y fusionar, agregar índice único por correo | Gerencia Comercial |
| H-02 | RFC incompleto (7) y vacío (8) | `01-calidad.md` (C2, C3) | Media | Facturas que no se pueden emitir | Pedir el dato y agregar `CHECK` de formato | Gerencia Comercial |
| H-03 | Correo inválido y teléfono de 3 dígitos (8) | `01-calidad.md` (C4) | Baja | No se puede contactar al cliente | Validar desde la captura | Gerencia Comercial |
| H-04 | `GRANT UPDATE` a `app_ventas` sin folio | E5, línea 42 | Alta | La aplicación puede cambiar cualquier columna, RFC incluido | Revisar si lo necesita y regularizar con folio | Gerencia Comercial y Comité de cambios |
| H-05 | `GRANT SELECT` a `soporte_ana` sin folio | E5, línea 350 | Media | Soporte puede leer todos los datos personales | Limitar a las columnas que necesita | Gerencia Comercial |
| H-06 | Columna `segmento` agregada sin folio y sin comentario | E5, línea 43; `03-diccionario.md` | Media | Dato sin finalidad ni responsable | Documentarla o quitarla con folio | Comité de cambios |
| H-07 | El periodo con `log_statement = none` no tiene registro | E5, línea 25 | Alta | No se puede saber quién cambió el RFC de María García | Dejar el registro siempre activo y vigilar que no se apague | Auditoría interna |
| H-08 | La creación del disparador y del rol `auditor_datos` no quedó en la bitácora (bloques `DO`) | `06-conciliacion.md`, nota 2 | Media | Un cambio a un control de auditoría puede pasar sin rastro | Agregar `function` a `pgaudit.log` para que se registre lo que corre dentro de un `DO` | Auditoría interna |
| H-09 | Lectura del RFC del cliente 3 por `app_ventas` | E5, línea 326 | Media | Solo se ve con pgaudit. Sin él, las lecturas no dejan rastro | Mantener pgaudit y revisar las lecturas de `rfc` | Auditoría interna |
| H-10 | 580 de 1148 líneas de la bitácora son del `pg_isready` del contenedor | E5 | Baja | Ruido que hace más difícil revisar | Filtrar o bajar la frecuencia del chequeo | DBA |
| H-11 | Las bitácoras viven dentro del contenedor; `getLog` y `system.profile` son limitados | `05-conservacion.md` | Media | Se pueden perder antes de exportarlas | Exportar seguido con hash fuera del servidor | Auditoría interna |

No corregí ninguno de estos hallazgos, solo los registré

## 9. Limitaciones y riesgos aceptados

| Limitación | Verificado o documentado | Control compensatorio | Quién acepta el riesgo |
|---|---|---|---|
| MongoDB Community no registra cambios de privilegios | Verificado en el LAB-02 | Instantáneas de privilegios | Auditoría interna |
| MongoDB no guarda el valor anterior del dato | Verificado en el LAB-02 | Ninguno | Gerencia Comercial |
| Auditoría nativa de MongoDB Enterprise/Atlas | Documentado, no practicado | — | Dirección (si se compra la licencia) |
| La desactivación del disparador de la guía no está en mi entorno | Verificado (no aparece en E5) | `E3-disparadores.txt` muestra el estado actual | Auditoría interna |
| `<not logged>`: pgaudit no guarda los parámetros ni el valor leído | Verificado (E5, línea 326) | El disparador guarda los cambios, pero no las lecturas | Auditoría interna |
| El usuario de la bitácora es la cuenta, no la persona (todas las apps usan `app_ventas`) | Verificado | Ninguno en la base, tendría que venir de la aplicación | Gerencia Comercial |
| La tabla no tiene `edad` ni `codigo_postal`, así que no se pudo revisar la edad | Verificado (E5, línea 945) | Revisión de teléfono en su lugar | — |

## 10. Índice de evidencias con hash

| Archivo | Qué contiene |
|---|---|
| `evidencias/E1-configuracion-registro.txt` | Configuración de registro |
| `evidencias/E2-privilegios.txt` | Privilegios vigentes |
| `evidencias/E3-disparadores.txt` | Disparador de auditoría |
| `evidencias/E4-muestra-auditoria.txt` | Últimos eventos de la auditoría (solo metadatos) |
| `evidencias/E5-bitacora-postgresql.log` | Bitácora completa (4 archivos) con contraseñas tapadas |
| `evidencias/E5-bitacora-postgresql.sha256` | Hash de E5 |
| `evidencias/diccionario-clientes.csv` | Diccionario exportado |
| `evidencias/E6-mongodb/` | Perfilador, bitácora de `mongod`, sus hashes y la comparación del LAB-02 |
