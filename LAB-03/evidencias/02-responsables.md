# Propietarios, custodios y usuarios

En la Unidad II la matriz solo cubría `clientes`. Aquí la amplío a los objetos de auditoría y a MongoDB

| Conjunto de datos | Propietario | Custodio | Usuarios autorizados | Quién aprueba accesos | Quién aprueba correcciones |
|---|---|---|---|---|---|
| `comercial.public.clientes` (PostgreSQL) | Gerencia Comercial | DBA | `app_ventas` (lee, inserta y actualiza), `soporte_ana` (solo lee), según `E2-privilegios.txt` | Gerencia Comercial | Gerencia Comercial |
| `auditoria.cambios_clientes` (PostgreSQL) | Auditoría interna | DBA | Auditoría interna en modo lectura. La aplicación no tiene permisos directos, solo escribe el disparador | Auditoría interna | Nadie, los registros no se corrigen. Si hay un error se agrega una nota |
| Bitácora de PostgreSQL y vista `dba.bitacora` | Auditoría interna | DBA | Auditoría interna y el DBA para diagnóstico | Auditoría interna | Nadie, se conserva como está. Solo se tapan secretos en la copia exportada |
| `comercial.clientes` (MongoDB) | Gerencia Comercial | DBA | `app_ventas@comercial` y soporte | Gerencia Comercial | Gerencia Comercial |
| `comercial.system.profile` (MongoDB) | Auditoría interna | DBA | Auditoría interna y el DBA | Auditoría interna | Nadie, es registro técnico |
| `gobierno.solicitudes_cambio` (PostgreSQL) | Comité de cambios | DBA | Comité de cambios y quien concilia | Comité de cambios | Comité de cambios |

1. ¿Por qué el propietario de `auditoria.cambios_clientes` no debería ser quien opera `clientes`?

Porque esa tabla sirve para revisar lo que hacen los que operan `clientes`. Si el mismo que hace los cambios es dueño de la auditoría, podría decidir qué se guarda o borrar lo que no le conviene. Es la misma idea de no revisarte a ti mismo

2. ¿Quién debe poder leer las bitácoras y `dba.bitacora`?

Solo auditoría interna y el DBA, nunca la aplicación ni soporte. En el LAB-01 vimos que la bitácora puede guardar contraseñas (por ejemplo un `CREATE ROLE ... PASSWORD`) y sentencias con datos personales. Por eso la copia que se comparte (E5) va con `<REDACTED>` y con hash

3. ¿Qué pasa con la responsabilidad de un dato sin responsable asignado?

Nadie la tiene. Nadie aprueba accesos, nadie decide si se corrige o se borra, y cuando pasa algo como el cambio del RFC de María García nadie puede contestar quién lo autorizó. En la práctica el DBA termina decidiendo cosas que no le tocan
