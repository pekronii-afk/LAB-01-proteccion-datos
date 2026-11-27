# Diccionario operativo

| Columna | Tipo | Nulos | Descripción | Clasificación | Finalidad |
|---|---|---|---|---|---|
| id | bigint | No | Identificador interno del cliente | Interno | Relacionar registros |
| nombre | varchar(120) | No | Nombre completo | Confidencial, dato personal identificador | Identificar al cliente |
| correo | varchar(120) | No | Correo de contacto | Confidencial, dato personal | Notificaciones al cliente |
| rfc | varchar(13) | Sí | RFC del cliente, sus cambios se auditan | Confidencial, dato personal fiscal | Facturación |
| telefono | varchar(15) | Sí | Teléfono de contacto | Confidencial, dato personal | Contacto con el cliente |
| ciudad | varchar(60) | Sí | Ciudad del cliente | Interno | Logística y reportes por zona |
| segmento | varchar(20) | Sí | Sin comentario | Sin clasificar | No documentada (ver hallazgo H-06) |
| canal_alta | varchar(20) | Sí | Canal por el que se registró el cliente (CAM-2026-014) | Interno | Saber por dónde llegan los clientes |

Para `comercial.clientes` de MongoDB no existe `COMMENT`, así que su diccionario tendría que ir en un documento aparte. Hoy no existe
