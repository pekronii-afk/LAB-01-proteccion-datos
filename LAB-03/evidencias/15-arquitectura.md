# Actividad 15 Propuesta de arquitectura

```
                 BASE DE DATOS
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
     Operación      Analítica       Auditoría
        │              │              │
        ▼              ▼              ▼
  Datos necesarios   Datos        Registro de
  para operación     agregados    quién hizo qué
```

| Control | Cómo se aplica |
|---|---|
| Acceso | Un rol por área (soporte, facturación, analista) y cada uno solo con permiso a sus vistas |
| Minimización | Vistas con solo las columnas que ocupa cada área, por ejemplo clientes_soporte y v_analitica_clientes |
| Protección de información sensible | El RFC cifrado y en un esquema aparte, solo facturación lo ve |
| Retención | Revisar fecha_alta y borrar o anonimizar lo que ya pasó del plazo |
| Trazabilidad | Registro de auditoría con quién consultó o cambió datos |
| Eliminación | Borrar en la tabla y también en respaldos, réplicas y exportaciones según el mapa del ciclo de vida |
| Atención de solicitudes | Consultas listas para ARCO y un procedimiento que autorice el área de privacidad antes de que el DBA haga el cambio |

La idea es que operación trabaje con los datos completos que ocupa, analítica solo con datos agrupados y auditoría guarde lo que pasa, así cada quien ve solo lo de su finalidad
