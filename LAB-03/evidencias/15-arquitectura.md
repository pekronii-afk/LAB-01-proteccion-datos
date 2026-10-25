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
  Datos necesarios   Datos        Quién hizo
  para operación     agregados    qué
```

| Control | Cómo se aplica |
|---|---|
| Acceso | Un rol por área con permiso solo a sus vistas |
| Minimización | Vistas con las columnas que ocupa cada área |
| Información sensible | RFC cifrado y solo para facturación |
| Retención | Revisar fecha_alta y borrar lo vencido |
| Trazabilidad | Auditoría de quién consulta o cambia |
| Eliminación | Borrar también en respaldos y copias |
| Solicitudes | El área de privacidad autoriza y el DBA hace el cambio |
