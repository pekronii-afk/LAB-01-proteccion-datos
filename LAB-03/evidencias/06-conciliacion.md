# Registro de cambios y conciliación

El registro de cambios está en `sql/04-registro-cambios.sql`. Lo que comparé fue la bitácora completa (`E5-bitacora-postgresql.log`, juntando los 4 archivos de log) contra `gobierno.solicitudes_cambio`, donde solo existe CAM-2026-014. Las horas están en UTC

| Momento (bitácora) | Usuario | Sentencia | Folio que lo autoriza | ¿Autorizado? | Hallazgo |
|---|---|---|---|---|---|
| 2026-11-27 03:46:37.489 (línea 1088) | postgres | `ALTER TABLE clientes ADD COLUMN canal_alta VARCHAR(20)` | CAM-2026-014 | Sí, dentro de la ventana (`dentro_de_ventana = t`) | No |
| 2026-11-18 06:30:06.167 (línea 42) | postgres | `GRANT UPDATE ON clientes TO app_ventas` | Ninguno | No | Sí, H-04 |
| 2026-11-18 06:30:06.166 (línea 41) | postgres | `REVOKE UPDATE ON clientes FROM soporte_ana` | Ninguno | No | Por revisar, quita un permiso y podría ser preparación |
| 2026-11-18 06:30:06.168 (línea 43) | postgres | `ALTER TABLE clientes ADD COLUMN segmento VARCHAR(20)` | Ninguno | No | Sí, H-06 |
| 2026-11-18 06:35:00.602 (línea 350) | postgres | `GRANT SELECT ON clientes TO soporte_ana` | Ninguno | No | Sí, H-05 |
| 2026-11-18 06:34:05.820 (línea 280) | postgres | `GRANT SELECT (rfc, telefono), UPDATE (rfc, telefono) ON clientes TO auditor_datos` | Ninguno | No | Por revisar, es la configuración de pgaudit |
| `DISABLE TRIGGER trg_auditoria_clientes` | — | No aparece en mi bitácora | — | — | Ver nota 2 |

Notas que hay que declarar:

1. Hueco de evidencia. La creación de la vista `dba.bitacora` no aparece porque `log_statement` estaba en `none`. La bitácora no registra sentencias hasta la línea 25 (2026-11-18 06:30:04), cuando cambió a `ddl`, y hasta la línea 49 no pasó a `mod`. Lo que se hizo antes no se puede conciliar
2. En este entorno no está la desactivación del disparador de la guía (líneas 163 y 169) porque no corrí esa parte del LAB-01 aquí. Encontré otro hueco parecido: la creación del disparador y la del rol `auditor_datos` tampoco aparecen, porque se hicieron dentro de bloques `DO` y con `log_statement = 'mod'` esos bloques no se registran. `E3-disparadores.txt` muestra el disparador habilitado (`O`), pero la bitácora no dice cuándo se creó ni quién lo creó
3. Contraseña expuesta. En la guía es la línea 37 (`CREATE ROLE rol_temporal ... PASSWORD`). En mi bitácora no aparece, pero la exportación E5 reemplaza cualquier `PASSWORD '...'` por `<REDACTED>` y revisé que no quedara `_Practica_2026` en el archivo
4. La creación de `gobierno.solicitudes_cambio` (líneas 1047 a 1083) tampoco tiene folio, porque el registro todavía no existía. Es preparación del laboratorio

1. ¿Qué cambios no tienen folio y son preparación o hallazgos?

Ninguno tiene folio menos `canal_alta`. Los de las líneas 41, 43 y 47 (`log_statement`) y la creación del esquema `auditoria` los hizo el script de preparación del curso. Aun así, en una base real serían hallazgos, porque nadie los aprobó. Los `GRANT` a `app_ventas` (línea 42) y a `soporte_ana` (línea 350) los marco como hallazgo porque dan acceso a datos personales

2. ¿Qué tan grave es desactivar el disparador y qué distingue la línea 163 de la 169?

Es grave (Alta), porque mientras está apagado los cambios en `clientes` no dejan valor anterior y nadie se da cuenta. Según la guía, la 163 es cuando se desactiva y la 169 cuando se vuelve a activar. Lo que pasa entre esas dos líneas no está auditado. En mi entorno no pasó, pero el riesgo está en que la creación del disparador tampoco queda registrada (nota 2)

3. ¿Qué limitación tiene la conciliación si `log_statement` estuvo en `none`?

Solo puede revisar lo que pasó después de activarlo. Antes de eso no hay líneas que comparar, entonces un cambio sin folio de esa época no se puede detectar. La conciliación puede encontrar diferencias, pero no puede probar que no pasó nada

4. ¿Quién debe hacer la conciliación?

Otra persona, no el DBA que hizo los cambios. Si la hace el mismo DBA se estaría revisando a sí mismo. Lo puede hacer auditoría interna o alguien del Comité de cambios, como dice POL-06
