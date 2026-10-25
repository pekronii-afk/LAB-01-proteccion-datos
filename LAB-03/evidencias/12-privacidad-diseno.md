# Actividad 12 Privacidad por diseño

¿Qué problemas identificas?
Guarda datos que no se ocupan como salario, estado civil y ocupación, no tiene llave primaria y todo es TEXT

¿Qué principio de privacidad se está ignorando?
La minimización

¿Qué preguntas realizarías antes de aprobar el diseño?
¿Para qué es cada campo?, ¿quién lo ocupa?, ¿cuánto tiempo se guarda? y ¿quién lo puede ver?

¿Qué datos eliminarías?
Salario, estado civil, ocupación y edad, porque se puede sacar de la fecha de nacimiento

¿Qué datos requerirían una justificación adicional?
Fecha de nacimiento, dirección y RFC

¿Cómo aplicarías privacidad por defecto?
Pedir solo lo obligatorio, que ningún rol tenga acceso hasta que se le dé y que las áreas vean los datos por vistas

## Actividad 13 Controles técnicos y administrativos

| Medida | Técnico | Administrativo |
|---|---|---|
| Crear roles de PostgreSQL | Sí | |
| Política de retención | | Sí |
| Cifrado de datos | Sí | |
| Procedimiento para solicitudes ARCO | | Sí |
| Vista con información limitada | Sí | |
| Clasificación de información | Sí | Sí |
| Registro de auditoría | Sí | |
| Política de control de acceso | Sí | Sí |

La clasificación y la política de control de acceso son las dos porque se deciden en un documento y luego se aplican en la base con esquemas, roles y GRANT
