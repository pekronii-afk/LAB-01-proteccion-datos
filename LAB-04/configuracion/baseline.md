# Línea base PostgreSQL 16

## Red

- Escuchar solo en localhost o en la IP que se ocupe
- Puerto 5432 documentado
- Firewall abierto solo para la red que lo ocupa
- Nada de 0.0.0.0/0 en pg_hba.conf

## Autenticación

- scram-sha-256, no md5 ni trust
- Contraseñas largas y fuera del código
- postgres solo para administrar

## Autorización

- Un rol por función
- Cada rol con lo mínimo
- La app sin SUPERUSER, CREATEROLE ni CREATEDB

## Configuración

- log_connections y log_disconnections en on
- Solo las extensiones que se usan
- Timeouts para conexiones inactivas

## Sistema operativo

- Los archivos son de la cuenta del servicio de PostgreSQL
- Otros usuarios no pueden leer la configuración ni la carpeta data

## Cifrado

- TLS 1.2 o más si hay conexiones remotas
- Contraseñas con scram-sha-256
- RFC y respaldos cifrados

## Mantenimiento

- Instalar las actualizaciones de PostgreSQL 16
- Revisar pg_hba.conf y roles cada cierto tiempo
- Anotar cada cambio
