# Actividad 8 Derecho de cancelación y ciclo de vida

```
clientes
   │
   ├── respaldos
   ├── réplicas
   ├── reportes
   ├── exportaciones
   └── sistemas externos
```

- Otras tablas: sí, como clientes_soporte
- Respaldos: sí
- Réplicas: si hay, también
- Auditoría: puede tener el nombre o correo
- Copias de analítica: si se exportaron datos sí
- Archivos exportados: CSV o Excel que alguien haya sacado
- Sistemas externos: facturación o correos

¿Por qué eliminar un registro de una tabla no necesariamente significa que toda la información relacionada con esa persona haya desaparecido de la organización?
Porque el dato está copiado en respaldos, réplicas, reportes y otros sistemas, si solo se borra de la tabla lo demás sigue ahí
