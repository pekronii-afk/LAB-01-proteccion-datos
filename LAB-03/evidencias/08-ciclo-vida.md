# Actividad 8 Derecho de cancelación y ciclo de vida

Antes de hacer el DELETE se revisó en dónde más puede estar el dato

```
clientes
   │
   ├── respaldos
   ├── réplicas
   ├── reportes
   ├── exportaciones
   └── sistemas externos
```

- Otras tablas relacionadas: sí, por ejemplo clientes_soporte que se hizo en este laboratorio
- Respaldos: sí, los respaldos viejos tienen al cliente
- Réplicas: si hay réplicas el dato también está ahí
- Registros de auditoría: pueden tener el nombre o el correo en lo que se registró
- Copias para analítica: la vista no guarda datos, pero si se exportaron estadísticas o tablas sí
- Archivos exportados: los CSV o Excel que alguien haya sacado
- Sistemas externos: el sistema de facturación o el de correos

¿Por qué eliminar un registro de una tabla no necesariamente significa que toda la información relacionada con esa persona haya desaparecido de la organización?
Porque el dato está copiado en otros lados como respaldos, réplicas, reportes, archivos exportados y otros sistemas. Si nada más se borra de la tabla clientes, lo demás sigue ahí, por eso antes hay que saber en dónde está cada copia y qué se hace con cada una
