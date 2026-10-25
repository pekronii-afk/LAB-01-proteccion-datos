# Actividad 11 Matriz de gobierno de datos

| Dato | Finalidad | Responsable | Usuarios autorizados | Protección | Retención | Acción al finalizar |
|---|---|---|---|---|---|---|
| nombre | Atender y facturar | Atención al cliente | Atención y facturación | Permisos | Mientras sea cliente | Eliminar |
| correo | Contacto | Atención al cliente | Atención | Permisos y enmascaramiento | Mientras sea cliente | Eliminar |
| telefono | Contacto | Atención al cliente | Atención | Permisos y enmascaramiento | Mientras sea cliente | Eliminar |
| rfc | Facturar | Facturación | Facturación | Cifrado | Lo que diga la ley | Eliminar |
| edad | Estadísticas | Analítica | Analítica en rangos | Vista | Mientras sea cliente | Anonimizar |
| ciudad | Estadísticas | Analítica | Analítica | Vista | Mientras sea cliente | Anonimizar |
| codigo_postal | Facturar y estadísticas | Facturación | Facturación y analítica | Permisos | Mientras sea cliente | Anonimizar |

El DBA no aparece porque administra la base pero no usa los datos
