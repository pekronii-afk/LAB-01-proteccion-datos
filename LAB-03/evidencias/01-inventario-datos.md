# Actividad 1 Inventario y finalidad de los datos

| Campo | ¿Es dato personal? | Finalidad | ¿Es necesario? | Nivel de acceso | Retención |
|---|---|---|---|---|---|
| id | No solo, pero lleva a la persona | Identificar el registro | Sí | Todas las áreas | Mientras exista el registro |
| nombre | Sí | Atender y facturar | Sí | Atención y facturación | Mientras sea cliente |
| correo | Sí | Contactar al cliente | Sí | Atención | Mientras sea cliente |
| telefono | Sí | Contactar al cliente | Puede ser opcional | Atención | Mientras sea cliente |
| rfc | Sí | Facturar | Solo para facturar | Facturación | Lo que diga el área fiscal |
| edad | Sí | Estadísticas | Solo en rangos | Analítica | Revisar si se ocupa |
| ciudad | Sí, junto con otros datos | Estadísticas | Sí, agrupada | Analítica y atención | Mientras sea cliente |
| codigo_postal | Sí, junto con otros datos | Facturar y estadísticas | Sí | Facturación y analítica por región | Mientras sea cliente |
| fecha_alta | Sí | Saber desde cuándo es cliente | Sí | DBA y dirección | Mientras exista el registro |

Justificación

- Nombre, correo y teléfono los ocupa atención para contactar al cliente
- El RFC solo lo ocupa facturación
- La edad solo sirve para estadísticas y con el rango basta
- Ciudad y código postal solos no dicen quién es, pero con la edad sí, por eso a analítica se le dan agrupados
- El tiempo que se guarda el RFC lo decide el área fiscal, no el DBA
