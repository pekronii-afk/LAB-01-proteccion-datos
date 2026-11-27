# Calidad de datos

Las consultas están en `sql/01-verificaciones-calidad.sql`. La tabla `clientes` de este laboratorio no tiene `edad` ni `codigo_postal`, así que el INSERT de la guía marcaba error (se ve en `E5-bitacora-postgresql.log`, línea 945). Lo corrí sin esas columnas y en lugar de revisar la edad revisé que el teléfono tuviera 10 dígitos

Después de insertar los registros 7 y 8 había 7 clientes en total

| # | Hallazgo | Registros | Regla de calidad | ¿Quién decide la corrección? | Acción propuesta |
|---|---|---|---|---|---|
| C1 | Correo duplicado (`ana.lopez@example.test` con distinta mayúscula). También el nombre se repite si se quitan acentos | 1 y 7 | Un correo por cliente, sin distinguir mayúsculas | Gerencia Comercial (propietario) | Confirmar si es la misma persona y, si lo es, fusionar los registros |
| C2 | RFC incompleto (`LOAA850315AB`, 12 caracteres) | 7 | RFC con formato válido de 12 o 13 caracteres | Gerencia Comercial | Pedir el RFC correcto al cliente o al área que lo capturó |
| C3 | RFC vacío | 8 | El RFC es obligatorio si se va a facturar | Gerencia Comercial | Pedir el dato o marcar al cliente como "sin facturación" |
| C4 | Correo sin formato (`sin-correo`) y teléfono de 3 dígitos (`667`) | 8 | Correo con `@` y dominio, teléfono de 10 dígitos | Gerencia Comercial | Contactar al cliente y validar los datos desde la captura |

Los registros de prueba no se borraron porque son parte de los hallazgos

1. ¿Por qué el DBA no debe corregir por su cuenta el RFC del registro 7?

Porque el DBA es el custodio, no el dueño del dato. No sabe cuál es el RFC correcto y si lo inventa o lo corrige sin autorización está cambiando un dato fiscal sin que nadie lo apruebe. Lo que le toca es detectar el problema, registrarlo y avisar al propietario

2. ¿Qué restricción habría evitado cada hallazgo y quién debe aprobarla?

- C1: un índice único sobre lower(correo)
- C2 y C4: un CHECK con la expresión regular del RFC, otro para el correo y otro para que el teléfono tenga 10 dígitos
- C3: NOT NULL en rfc, aunque solo si el negocio dice que siempre se factura

Las tiene que aprobar la Gerencia Comercial por POL-06, porque cambian la estructura en producción y pueden rechazar altas que hoy sí entran. El DBA solo las propone y las ejecuta con folio

3. ¿Qué mecanismo del LAB-01 deja evidencia si el DBA corrige un dato?

El disparador `trg_auditoria_clientes`, que guarda en `auditoria.cambios_clientes` quién hizo el cambio y el valor de antes y después. Por ejemplo, los INSERT de los registros 7 y 8 quedaron como eventos 3 y 4 (`E4-muestra-auditoria.txt`). Además, con `log_statement = 'mod'` la sentencia queda en la bitácora
