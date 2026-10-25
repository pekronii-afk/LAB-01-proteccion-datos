# Actividad 1 Inventario y finalidad de los datos

| Campo | ¿Es dato personal? | Finalidad | ¿Es necesario? | Nivel de acceso | Retención |
|---|---|---|---|---|---|
| id | No por sí solo, pero apunta a una persona | Identificar el registro dentro de la base | Sí | Todas las áreas que usan el registro | Mientras exista el registro |
| nombre | Sí | Atender al cliente y facturar | Sí | Atención al cliente y facturación | Mientras sea cliente y lo que pida la ley para las facturas |
| correo | Sí | Contactar al cliente | Sí | Atención al cliente | Mientras sea cliente |
| telefono | Sí | Contactar al cliente | Sí, pero puede ser opcional | Atención al cliente | Mientras sea cliente |
| rfc | Sí | Facturación | Solo para facturar | Facturación | Lo que diga el área jurídica o fiscal |
| edad | Sí | Estadísticas | No para la operación, solo en rangos para analítica | Analítica en rangos | Revisarla, no hace falta guardarla siempre |
| ciudad | Sí, junto con otros datos identifica | Estadísticas | Sí, agrupada | Analítica agregada y atención | Mientras sea cliente |
| codigo_postal | Sí, junto con otros datos identifica | Datos fiscales y estadísticas por región | Sí para facturar, para analítica solo la región | Facturación y analítica por región | Mientras sea cliente |
| fecha_alta | Sí, porque es de una persona | Saber desde cuándo es cliente y calcular la retención | Sí | DBA y dirección | Mientras exista el registro |

Justificación

- id, nombre, correo y fecha_alta se necesitan para que el sistema funcione y para atender al cliente
- El teléfono sirve para soporte pero no todos los clientes lo tienen que dar
- El RFC solo lo ocupa facturación, las demás áreas no tienen por qué verlo
- La edad no se ocupa para atender ni para facturar, solo para estadísticas y ahí basta con el rango
- La ciudad y el código postal solos no dicen quién es la persona, pero junto con la edad sí, por eso a analítica se le dan agrupados
- El tiempo de retención del RFC y los datos fiscales no lo decide el DBA, lo tiene que definir el área jurídica o fiscal
