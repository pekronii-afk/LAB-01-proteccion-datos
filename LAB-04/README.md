# LAB-04 Hardening y configuración segura de PostgreSQL

20321619_joel_cuadras

## Objetivo

Revisar qué tiene expuesto PostgreSQL y dejar solo lo necesario

## Entorno

PostgreSQL 16 en mi compu, porque el servidor de la escuela no dejaba conectarse

## Superficie de ataque inicial

| Elemento | Estado actual | ¿Es necesario? | Riesgo |
|---|---|---|---|
| Puerto PostgreSQL | 5432 | Sí | Bajo |
| Interfaces de escucha | '*' | No | Acepta conexiones por cualquier red |
| Conexiones remotas | No hay | No | Ninguno |
| Usuarios administrativos | postgres | Sí | Se usaba para todo |
| SSL/TLS | off | No en local | Sin cifrar si se abre a la red |
| Métodos de autenticación | scram-sha-256 | Sí | Bajo |

¿Por qué conocer la superficie de ataque debe preceder al hardening?
Porque no puedes proteger algo que no sabes que está expuesto

## Hallazgos

Archivos de configuración

- postgresql.conf: parámetros como el puerto y listen_addresses
- pg_hba.conf: quién se puede conectar
- pg_ident.conf: relaciona usuarios del sistema con los de PostgreSQL
- log_connections y log_disconnections estaban en off

¿Por qué es importante conocer la ubicación física de estos archivos?
Para revisar sus permisos, porque si alguien los cambia se brinca la seguridad

listen_addresses

```
Configuración encontrada:
'*'

Interfaces necesarias:
localhost

Interfaces innecesarias:
Las demás
```

La arquitectura con red privada expone menos porque desde internet no se llega al servidor

pg_hba.conf

Solo hay reglas para 127.0.0.1/32 y ::1/128 con scram-sha-256, no hay 0.0.0.0/0 ni ::/0. La regla permisiva está en `configuracion/cambios.md`

Autenticación

password_encryption está en scram-sha-256

- Autenticación es quién eres y autorización es qué puedes hacer
- scram-sha-256 protege la contraseña porque no viaja ni se guarda tal cual
- No es cifrado reversible porque no se puede sacar la contraseña
- Aunque la contraseña sea fuerte, si la cuenta tiene permisos de más y alguien la consigue puede hacer de todo

Roles

| Rol | LOGIN | SUPERUSER | CREATEROLE | CREATEDB | Función |
|---|---|---|---|---|---|
| postgres | Sí | Sí | Sí | Sí | Administrador |
| analista | No | No | No | No | Rol del lab 3 |
| pg_* | No | No | No | No | Roles que trae PostgreSQL |

¿Por qué no debería utilizarse una cuenta SUPERUSER como cuenta normal de una aplicación?
Porque si alguien se mete por la app puede hacer de todo

Separación de cuentas

| Cuenta | Propósito | LOGIN | Privilegios |
|---|---|---|---|
| DBA | Administración | Sí | Administrativos |
| APP | Aplicación | Sí | Mínimos |
| CONSULTA | Consulta | Sí | Solo lectura |

¿Qué riesgo existe si la aplicación se conecta utilizando una cuenta administrativa?
Que si atacan la app tienen permisos de administrador en toda la base

Extensiones

plpgsql viene por defecto y pgcrypto se instaló para el lab 2, las dos se usan

Conexiones

- max_connections: 100
- superuser_reserved_connections: 3
- statement_timeout: 0, sin límite
- idle_in_transaction_session_timeout: 0, sin límite

¿Por qué mantener conexiones indefinidamente abiertas puede representar un problema de disponibilidad o consumo de recursos?
Porque gastan memoria y si se llenan ya nadie se puede conectar, como pasó en el servidor de la escuela

Permisos del sistema operativo

Se revisaron los permisos de postgresql.conf, pg_hba.conf y la carpeta data, solo los debe poder leer la cuenta del servicio

¿Por qué no es suficiente proteger PostgreSQL mediante GRANT y REVOKE si cualquier usuario del sistema operativo puede leer archivos sensibles?
Porque leyendo los archivos directo no pasas por los GRANT

Exposición de red

```
Dirección de escucha:
127.0.0.1

Puerto:
5432

¿Está expuesto fuera de la interfaz necesaria?
No
```

Firewall

| Origen | Destino | Puerto | Acción |
|---|---|---|---|
| 10.10.10.0/24 | PostgreSQL | 5432 | Permitir |
| Cualquier otro origen | PostgreSQL | 5432 | Denegar |

¿Por qué pg_hba.conf y el firewall no son controles equivalentes?
El firewall bloquea antes de llegar a PostgreSQL y pg_hba.conf decide quién se autentica ya adentro

TLS

```
¿La conexión actual utiliza TLS?
No

Versión:
Ninguna

Cipher:
Ninguno
```

En local no pasa nada, pero si se abre a la red debe usar TLS

## Cambios realizados

- listen_addresses de '*' a 'localhost'
- pg_hba.conf revisado
- Cuentas DBA, APP y CONSULTA separadas
- Permisos de archivos revisados

Detalle en `configuracion/cambios.md` y `configuracion/baseline.md`

## Justificación de los cambios

El cambio más importante fue listen_addresses porque ya no acepta conexiones desde la red

## Verificación

Con `sql/04-verificacion.sql` se vio que listen_addresses quedó en localhost

## Checklist de hardening

| # | Control | Verificado | Evidencia |
|---|---|---|---|
| 1 | Puerto documentado | Sí | SHOW port |
| 2 | Interfaces de escucha justificadas | Sí | SHOW listen_addresses |
| 3 | pg_hba.conf revisado | Sí | pg_hba_file_rules |
| 4 | Redes autorizadas restringidas | Sí | Solo localhost |
| 5 | Autenticación segura | Sí | scram-sha-256 |
| 6 | Superusuarios identificados | Sí | pg_roles |
| 7 | Cuentas de aplicación separadas | Sí | Tabla de cuentas |
| 8 | Privilegios mínimos | Sí | Tabla de roles |
| 9 | Extensiones revisadas | Sí | pg_extension |
| 10 | TLS verificado | Sí | pg_stat_ssl |
| 11 | Configuración protegida | Sí | Permisos de archivos |
| 12 | Directorio de datos protegido | Sí | Permisos de data |
| 13 | Firewall documentado | Sí | Tabla de firewall |
| 14 | Actualizaciones documentadas | Sí | baseline.md |
| 15 | Configuración registrada | Sí | cambios.md |

## Caso integral

| # | Problema | Riesgo | Control propuesto |
|---|---|---|---|
| 1 | Acepta conexiones de cualquier IPv4 | Cualquiera intenta entrar | Solo la red de la app |
| 2 | La app usa usuario administrativo | Si atacan la app tienen todo | Cuenta con permisos mínimos |
| 3 | Escucha en todas las interfaces | Expuesto de más | Solo la IP necesaria |
| 4 | Firewall abierto a todos en 5432 | Fuerza bruta | Solo la red de la app |
| 5 | pg_hba.conf all/all desde 0.0.0.0/0 | Todos a todo | Reglas específicas |
| 6 | Solo confían en contraseñas | Una filtrada y entran | Varias capas |
| 7 | No saben qué conexiones se ocupan | No se puede restringir | Revisar conexiones |
| 8 | No hay TLS | Datos sin cifrar | Activar TLS |
| 9 | No hay cuentas separadas | No se sabe quién hizo qué | Cuentas por función |
| 10 | No hay logs de conexiones | No se nota un ataque | Activar logs |

¿Es suficiente tener contraseñas fuertes?
No, la contraseña solo es la autenticación. Si la red está abierta, la app es administradora y no hay TLS, con una contraseña filtrada o una inyección SQL tienen todo

## Conclusiones

El hardening es quitar lo que no se ocupa y controlar lo que se queda, y todo se tiene que documentar
