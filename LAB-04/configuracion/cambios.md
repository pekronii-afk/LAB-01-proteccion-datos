# Cambios realizados

## Regla permisiva

```
host    all    all    0.0.0.0/0    scram-sha-256
```

Deja entrar a todas las bases, con todos los usuarios y desde cualquier IPv4. Aunque pida contraseña cualquiera puede intentar entrar. Para restringirla hay que saber qué red, base y usuario se ocupan de verdad

```
Regla actual:
host    all    all    0.0.0.0/0    scram-sha-256

Problema:
Permite conexiones desde cualquier lado

Origen que realmente necesita acceso:
10.10.10.0/24

Base de datos:
basedatos_app

Usuario:
app_user

Regla propuesta:
host    basedatos_app    app_user    10.10.10.0/24    scram-sha-256
```

## Antes y después

| Control | Antes | Después | Justificación |
|---|---|---|---|
| listen_addresses | '*' | 'localhost' | Solo me conecto desde la compu |
| pg_hba.conf | all/all desde 127.0.0.1/32 y ::1/128 | Solo bases y usuarios que se usan | Entre más específica mejor |
| Método de autenticación | scram-sha-256 | scram-sha-256 | Ya estaba bien |
| Usuarios administrativos | postgres para todo | postgres solo para administrar | Menos riesgo |
| Cuentas de aplicación | No había | App y consulta separadas | Que la app no tenga permisos de admin |
| Puerto | 5432 | 5432 | Cambiarlo no protege |
| TLS | off | off en local | En local no sale a la red |
| Permisos SO | Sin revisar | Revisados | Que otros usuarios no lean los archivos |
| Extensiones | plpgsql y pgcrypto | plpgsql y pgcrypto | Las dos se usan |
| Conexiones | max_connections 100, timeouts en 0 | Documentado | Que no se queden conexiones abiertas |
