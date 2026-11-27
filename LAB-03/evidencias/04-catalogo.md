# Catálogo mínimo

| ID | Conjunto de datos | Motor | Ubicación | Propietario | Custodio | Clasificación | Contiene datos personales | Finalidad | Conservación | Diccionario |
|---|---|---|---|---|---|---|---|---|---|---|
| CAT-01 | Clientes | PostgreSQL 16 | u3-postgres / comercial / public.clientes | Gerencia Comercial | DBA | Confidencial | Sí | Venta y facturación | Mientras sea cliente, después se aplica POL-03 | `COMMENT` + `diccionario-clientes.csv` |
| CAT-02 | Auditoría de cambios de clientes | PostgreSQL 16 | u3-postgres / comercial / auditoria.cambios_clientes | Auditoría interna | DBA | Confidencial | Sí | Saber quién cambió qué y su valor anterior | Ver `05-conservacion.md` | `COMMENT` de la tabla |
| CAT-03 | Solicitudes de cambio | PostgreSQL 16 | u3-postgres / comercial / gobierno.solicitudes_cambio | Comité de cambios | DBA | Interno | No | Autorizar y conciliar cambios (POL-06) | Igual que la bitácora de privilegios | `COMMENT` de la tabla |
| CAT-04 | Clientes | MongoDB 7 Community | u3-mongo / comercial / clientes | Gerencia Comercial | DBA | Confidencial | Sí | Venta | Mientras sea cliente | Hoy no existe, MongoDB no tiene `COMMENT` |
| CAT-05 | Perfilador | MongoDB 7 Community | u3-mongo / comercial / system.profile | Auditoría interna | DBA | Confidencial | Sí | Rastrear operaciones | 1 MB circular, se exporta a archivo | No aplica, estructura fija de MongoDB |

El `propietario_tecnico` que da `pg_class` es `postgres`, pero eso solo dice qué rol creó la tabla. El dueño del dato es la Gerencia Comercial

1. ¿Por qué CAT-02 y CAT-05 contienen datos personales si son de auditoría?

Porque guardan lo que se hizo con los datos. `cambios_clientes` guarda el valor de antes y después en JSON, con RFC y teléfono incluidos, y `system.profile` guarda el comando completo, por ejemplo el `$set` con el teléfono nuevo (`E6-mongodb/system-profile.json`). Necesitan el mismo cuidado que la tabla original

2. ¿Qué pasa si CAT-01 y CAT-04 tienen propietarios distintos y el RFC difiere entre motores?

No habría forma de saber cuál es el correcto, porque cada dueño diría que el suyo. Habría que definir cuál es la fuente oficial del RFC, y para eso sirve que el catálogo diga quién es el propietario de cada copia

3. ¿Qué información del catálogo cambia más seguido y quién la actualiza?

Las filas y el tamaño, que cambian todos los días y los saca el DBA del motor. También los usuarios autorizados, que cambian con cada `GRANT` o `REVOKE`. Al DBA le toca actualizarlo, pero el propietario es quien aprueba esos cambios
