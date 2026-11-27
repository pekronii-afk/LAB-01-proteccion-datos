# POL-04 Restauración

| Campo | Contenido |
|---|---|
| Objetivo | Asegurar que los respaldos de POL-02 sí sirven y saber quién decide restaurar |
| Alcance | Base `comercial` (PostgreSQL y MongoDB) |
| Regla | Una restauración en producción solo se hace con la autorización por escrito del propietario del dato. Cada 3 meses se prueba restaurar un respaldo en un ambiente de pruebas y se anota si funcionó y cuánto tardó. El procedimiento técnico se definirá en la Unidad V |
| Responsable | Autoriza el propietario del dato, ejecuta el DBA, revisa auditoría interna la prueba trimestral |
| Excepciones | Caída total de producción: el DBA puede restaurar con aviso inmediato al propietario y la autorización se firma después |
| Evidencia | Registro de pruebas de restauración. Hoy no existe |
| Revisión | Cada 6 meses |
